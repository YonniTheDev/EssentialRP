local QBCore = exports['qb-core']:GetCoreObject()
local craftingBenches = {}

local function validateDB()
    MySQL.ready(function()
        MySQL.Sync.execute([=[
            CREATE TABLE IF NOT EXISTS `crafting_benches` (
            `id` INT NOT NULL AUTO_INCREMENT,
            `benchId` VARCHAR(50) NOT NULL,
            `blueprints` LONGTEXT NULL,
            PRIMARY KEY (`id`),
            KEY (`benchId`));
        ]=])
    end)
end

validateDB()

local function fetchCraftingBenches()
    MySQL.query('SELECT * FROM crafting_benches', function(results)
        if #results > 0 then
            for k, v in pairs(results) do 
                craftingBenches[v.benchId] = {blueprints = json.decode(v.blueprints)}
            end
        end
    end)
end

local function getClosestBench(src)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local currentBench = nil
    local dist = nil
    local minDist = 3

    for index, bench in ipairs(Config.craftingBenches) do
        if currentBench then
            if #(playerCoords - bench.coords) < dist then
                currentBench = index
                dist = #(playerCoords - bench.coords)
            end
        elseif #(playerCoords - bench.coords) < minDist then
            currentBench = index
            dist = #(playerCoords - bench.coords)
        end
    end

    if currentBench then
        local benchID = Config.craftingBenches[currentBench].id
        -- TriggerEvent("essential-crafting_sv:getCraftingBenchBlueprints", benchID)
        return benchID, Config.craftingBenches[currentBench].benchType
    end
end

local function blueprintUsed(src, craftItem)
    local closestBench = getClosestBench(src)
    if closestBench then
        
        if Config.blueprintRecipes[craftItem] then
            local bench = craftingBenches[closestBench]
            if bench then
                for _, blueprint in ipairs(bench.blueprints) do
                    if craftItem == blueprint then
                        TriggerClientEvent('QBCore:Notify', src, 'This crafting bench already has this blueprint', 'error')
                        return false
                    end
                end
                
                if (#bench.blueprints < 5) then
                    bench.blueprints[#bench.blueprints + 1] = craftItem
                    MySQL.update('UPDATE crafting_benches SET blueprints = ? WHERE benchId = ?', {json.encode(bench.blueprints), closestBench})
                    TriggerClientEvent('QBCore:Notify', src, 'Successfully added blueprint to work bench', 'success')
                else
                    TriggerClientEvent('QBCore:Notify', src, "This crafting bench can't hold anymore blueprints", 'error')
                    return false
                end
            else
                for _, v in ipairs(Config.craftingBenches) do
                    if v.id == closestBench then
                        craftingBenches[closestBench] = {blueprints = {craftItem}}
                        MySQL.insert('INSERT INTO crafting_benches (`benchId`, `blueprints`) VALUES (?, ?)', {closestBench, json.encode({craftItem})})
                        TriggerClientEvent('QBCore:Notify', src, 'Successfully added blueprint to work bench', 'success')
                        break
                    end
                end
            end
            return true
        end

        return false
    end
end

-- Blueprint Items --

QBCore.Functions.CreateUseableItem("blueprint_advancedlockpick", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("blueprint_advancedlockpick") then
        local craftItem = "advancedlockpick"
        local addedBlueprint = blueprintUsed(source, craftItem)
        if addedBlueprint then
            Player.Functions.RemoveItem("blueprint_advancedlockpick", 1)
        end
    end
end)

RegisterNetEvent("essential-crafting_sv:getWorkBenchData", function()
    local src = source
    local function getClosestBenchData() return getClosestBench(src) end
    local closestBench = {getClosestBenchData()}
    if closestBench then
        TriggerClientEvent("essential-crafting_cl:openCraftingBench", src, craftingBenches[closestBench], closestBench)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Unable to find crafting bench', 'error')
    end
end)

RegisterNetEvent("essential-crafting_sv:getCraftingBenchBlueprints", function(benchId)
    local src = source
    if craftingBenches[benchId] then
        TriggerClientEvent("essential-crafting_cl:loadCraftingBlueprints", src, craftingBenches[benchId].blueprints)
    end
end)

-- QBCore.Functions.CreateCallback('essential-crafting_sv:discardBlueprint', function(source, cb, benchId, blueprintToRemove)
--     local src = source
--     if craftingBenches[benchId] then
--         local blueprintFound = false
--         for index, blueprint in ipairs(craftingBenches[benchId].blueprints) do
--             if blueprint == blueprintToRemove then
--                 blueprintFound = true
--                 TriggerClientEvent('QBCore:Notify', src, 'Successfully removed blueprint to work bench', 'success')

--                 table.remove(craftingBenches[benchId].blueprints, index)

--                 MySQL.update('UPDATE crafting_benches SET blueprints = ? WHERE benchId = ?', {json.encode(craftingBenches[benchId].blueprints), benchId})                
--                 cb(true)

--                 break
--             end
--         end

--         if not blueprintFound then
--             TriggerClientEvent('QBCore:Notify', src, 'Failed to find blueprint at work bench', 'error')
--             cb(false)
--         end
--     else
--        cb(false)

RegisterNetEvent("essential-crafting_sv:attemptCraft", function(benchId, itemToCraft, amount, isBlueprintRecipe)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local rep = Player.PlayerData.metadata.craftingrep
    local attachmentRep = Player.PlayerData.metadata.attachmentcraftingrep
    local weaponreputation = Player.PlayerData.metadata.weaponmakingrep
    local ammoreputation = Player.PlayerData.metadata.ammomakingrep
    
    local benchType = false
    local points = 0
    
    local hasRecipe = false
    local components = nil
    local itemName = nil

    if isBlueprintRecipe then
        if craftingBenches[benchId] then
            for _, blueprint in ipairs(craftingBenches[benchId].blueprints) do
                if blueprint == itemToCraft then
                    local craftData = Config.blueprintRecipes[itemToCraft]
                    hasRecipe = true
                    points = craftData.points
                    benchType = craftData.benchType
                    components = craftData.components
                    itemName = craftData.label
                    break
                end
            end
        end
    else
        local craftData = Config.defaultRecipes[itemToCraft]
        hasRecipe = true
        points = craftData.points
        benchType = craftData.benchType

        for k, attachThres in pairs(Config.benchReps.attachmentRep) do 
            if benchType == attachThres then
                if attachmentRep < craftData.threshold then
                    return
                end
            end
        end
        for k, baseThres in pairs(Config.benchReps.rep) do
            if benchType == baseThres then
                if rep < craftData.threshold then
                    return
                end
            end
        end
        for k, weaponThres in pairs(Config.benchReps.weaponreputation) do
            if benchType == weaponThres then
                if rep < craftData.threshold then
                    return
                end
            end
        end
        for k, ammoThres in pairs(Config.benchReps.ammoreputation) do
            if benchType == ammoThres then
                if rep < craftData.threshold then
                    return
                end
            end
        end

        components = craftData.components
        itemName = craftData.label
    end

    if hasRecipe and components then
        if amount ~= "max" then
            amount = tonumber(amount)
            local playerComponents = {}
            for _, component in ipairs(components) do
                local amountNeeded = amount * component.amount
                if Player.Functions.GetItemByName(component.item) then
                    if Player.Functions.GetItemByName(component.item).amount < amountNeeded then
                        TriggerClientEvent('QBCore:Notify', src, 'Missing ' ..component.label .. ' to craft ' ..amount.. ' ' ..itemName..'(s)', 'error')
                        return
                    else
                        playerComponents[#playerComponents + 1] = {item = component.item, takeAmount = amountNeeded}
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any '..component.label, 'error')
                    return
                end
            end

            if Player.Functions.AddItem(itemToCraft, amount) then

                for _, v in ipairs(playerComponents) do
                    Player.Functions.RemoveItem(v.item, v.takeAmount)
                end

                for k, ammoRep in pairs(Config.benchReps.ammoreputation) do  
                    if benchType == ammoRep then 
                        Player.Functions.SetMetaData("ammomakingrep", ammoreputation + (points * amount))
                        TriggerClientEvent("essential-crafting_cl:increasedRep", src, rep, ammoreputation + (points * amount), benchType)
                    end
                end

                for k, weaponRep in pairs(Config.benchReps.weaponreputation) do  
                    if benchType == weaponRep then 
                        Player.Functions.SetMetaData("weaponmakingrep", weaponreputation + (points * amount))
                        TriggerClientEvent("essential-crafting_cl:increasedRep", src, rep, weaponreputation + (points * amount), benchType)
                    end
                end

                for k, attachRep in pairs(Config.benchReps.attachmentRep) do  
                    if benchType == attachRep then 
                        Player.Functions.SetMetaData("attachmentcraftingrep", attachmentRep + (points * amount))
                        TriggerClientEvent("essential-crafting_cl:increasedRep", src, rep, attachmentRep + (points * amount), benchType)
                    end
                end
                for k, baseRep in pairs(Config.benchReps.rep) do
                    if benchType == baseRep then 
                        Player.Functions.SetMetaData("craftingrep", rep + (points * amount))
                        TriggerClientEvent("essential-crafting_cl:increasedRep", src, rep + (points * amount), attachmentRep, benchType)
                    end
                end

                TriggerClientEvent('QBCore:Notify', src, 'Successfully crafted ' ..amount.. ' ' ..itemName..'(s)', 'success')

            end
        else
            local playerComponents = {}
            local maxCraft = nil
            
            for _, component in ipairs(components) do
                local minAmountNeeded = component.amount
                if Player.Functions.GetItemByName(component.item) then
                    local playerAmt = Player.Functions.GetItemByName(component.item).amount
                    if playerAmt < minAmountNeeded then
                        TriggerClientEvent('QBCore:Notify', src, 'Missing ' ..component.label .. ' to craft ' ..itemName, 'error')
                        return
                    else
                        if not maxCraft then
                            maxCraft = math.floor(playerAmt/minAmountNeeded)
                        elseif math.floor(playerAmt/minAmountNeeded) < maxCraft then
                            maxCraft = math.floor(playerAmt/minAmountNeeded)
                        end

                        playerComponents[#playerComponents + 1] = {item = component.item, requiredPerCraft = component.amount}
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any '..component.label, 'error')
                    return
                end
            end

            if Player.Functions.AddItem(itemToCraft, maxCraft) then

                for _, v in ipairs(playerComponents) do
                    Player.Functions.RemoveItem(v.item, v.requiredPerCraft * maxCraft)
                end
                for k, ammoRep in pairs(Config.benchReps.ammoreputation) do  
                    if benchType == weaponRep then 
                        Player.Functions.SetMetaData("ammomakingrep", ammoreputation + (points * maxCraft))
                        TriggerClientEvent("essential-crafting_cl:increasedRep", src, rep, ammoreputation + (points * maxCraft), benchType)
                    end
                end
                for k, weaponRep in pairs(Config.benchReps.weaponreputation) do  
                    if benchType == weaponRep then 
                        Player.Functions.SetMetaData("weaponmakingrep", weaponreputation + (points * maxCraft))
                        TriggerClientEvent("essential-crafting_cl:increasedRep", src, rep, weaponreputation + (points * maxCraft), benchType)
                    end
                end
                for k, attachRep in pairs(Config.benchReps.attachmentRep) do  
                    if benchType == attachRep then 
                        Player.Functions.SetMetaData("attachmentcraftingrep", attachmentRep + (points * maxCraft))
                        TriggerClientEvent("essential-crafting_cl:increasedRep", src, rep, attachmentRep + (points * maxCraft), benchType)
                    end
                end
                for k, baseRep in pairs(Config.benchReps.rep) do
                    if benchType == baseRep then 
                        Player.Functions.SetMetaData("craftingrep", rep + (points * maxCraft))
                        TriggerClientEvent("essential-crafting_cl:increasedRep", src, rep + (points * maxCraft), attachmentRep, benchType)
                    end
                end

                TriggerClientEvent('QBCore:Notify', src, 'Successfully crafted ' ..maxCraft.. ' ' ..itemName..'(s)', 'success')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'Unable to find blueprint recipe', 'error')
    end
end)

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        SetTimeout(2000, function()
            fetchCraftingBenches()
        end)
    end
end)
