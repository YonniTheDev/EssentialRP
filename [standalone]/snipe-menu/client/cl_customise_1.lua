RegisterNetEvent("snipe-menu:client:toggleDuty", function()
    if hasAdminPerms then     
        if Config.Core == "QBCore" then   
            local PlayerData = QBCore.Functions.GetPlayerData()
            if PlayerData.job.name == "police" then
                TriggerEvent("qb-policejob:ToggleDuty") -- this event is present in qb-policejob/client/job.lua (added this event because it manages some local variables in qb-policejob)
            elseif PlayerData.job.name == "ambulance" then
                TriggerEvent("EMSToggle:Duty") -- this event is present in qb-ambulancejob/client/job.lua (added this event because it manages some local variables in qb-ambulancejob)
            else
                TriggerServerEvent("QBCore:ToggleDuty") -- this event is present in qb-core/server/main.lua
            end
            TriggerServerEvent("snipe-menu:server:sendLogs", "triggered", Config.Locales["toggle_duty_used"])
        elseif Config.Core == "ESX" then
            -- Add a toggle duty event here if you have one
            TriggerServerEvent("snipe-menu:server:sendLogs", "triggered", Config.Locales["toggle_duty_used"])
        end
    else
        TriggerServerEvent("snipe-menu:server:sendLogs", "exploit", Config.Locales["toggle_duty_exploit"])
    end
end)

-- if you have custom clothing script, make sure to add the events to load the players old clothes back when you click revert
RegisterNetEvent("snipe-menu:client:revertClothing", function()
    if Config.Core == "QBCore" then
        if Config.Skin == "qb-clothing" then
            TriggerServerEvent("qb-clothing:server:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES
            TriggerServerEvent("qb-clothes:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES
        elseif Config.Skin == "fivem-appearance" then
            TriggerEvent("fivem-appearance:client:reloadSkin")
        elseif Config.Other == "other" then
            -- add your custom clothing script event here
        end
    elseif Config.Core == "ESX" then
        if Config.Skin == "fivem-appearance" then
            ESX.TriggerServerCallback('fivem-appearance:getPlayerSkin', function(appearance)
                exports['fivem-appearance']:setPlayerAppearance(appearance)
            end)
        elseif Config.Skin == "esx_skin" then
            local p = promise.new()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                p:resolve(skin)
            end)
            local skin = Citizen.Await(p)
            TriggerEvent('skinchanger:loadSkin', skin)
        elseif Config.Other == "other" then
            -- add your custom clothing script event here
        end
    end
    
end)

RegisterNetEvent("snipe-menu:client:refuelVehicle", function()
    if hasAdminPerms then 
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle ~= 0 then
            exports["LegacyFuel"]:SetFuel(vehicle, 100.0)
            -- change it to your fuel script if you have one
        end
    end
end)

function clearArea(radius, type)
    local playerCoords = GetEntityCoords(PlayerPedId())
    if type == "vehicle" then
        local vehicleList = GetGamePool('CVehicle')
        for k, v in pairs(vehicleList) do
            if DoesEntityExist(v) then
                local coords = GetEntityCoords(v)
                local dist = #(coords - playerCoords)
                if dist <= radius then
                    DeleteEntity(v)
                end
            end
        end
    elseif type == "ped" then
        local pedList = GetGamePool('CPed')
        for k, v in pairs(pedList) do
            if DoesEntityExist(v) then
                local coords = GetEntityCoords(v)
                local dist = #(coords - playerCoords)
                if dist <= radius then
                    DeleteEntity(v)
                end
            end
        end
    elseif type == "object" then
        local objectList = GetGamePool('CObject')
        
        
    
        for k, v in pairs(objectList) do
            if DoesEntityExist(v) then
                local coords = GetEntityCoords(v)
                local dist = #(coords - playerCoords)
                if dist <= radius then
                    DeleteEntity(v)
                end
            end
        end
    end
end


CreateThread(function()
    local idle = 500
    while true do
        Wait(idle)
        if next(adminTagEnabledList) then
            for k, v in pairs(GetActivePlayers()) do
                if NetworkIsPlayerActive(v) and adminTagEnabledList[GetPlayerServerId(v)] then
                    local ped = GetPlayerPed(v)
                    local coords = GetEntityCoords(ped)
                    local distance = #(coords - GetEntityCoords(PlayerPedId()))
                    if distance < 20.0 then
                        idle = 0
                        DrawText3Ds(coords.x, coords.y, coords.z + 0.9, Config.Locales.AdminTag)
                    else
                        idle = 500
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("snipe-menu:client:reviveall", function(id)
    local p = promise.new()
    TriggerCallback("snipe-adminmenu:server:isAdmin", function(isAdmin)
        p:resolve(isAdmin)
    end, id)
    local isAdmin = Citizen.Await(p)
    if isAdmin then
        if Config.Core == "QBCore" then
            TriggerEvent("hospital:client:Revive")
        elseif Config.Core == "ESX" then
            TriggerEvent("esx_ambulancejob:revive")
        end
    end
end)