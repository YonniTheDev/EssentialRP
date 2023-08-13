--  ██████  ██    ██ ████████ ███████ ██ ██████  ███████     ██    ██ ███████ ██   ██ ██  ██████ ██      ███████ ███████ 
-- ██    ██ ██    ██    ██    ██      ██ ██   ██ ██          ██    ██ ██      ██   ██ ██ ██      ██      ██      ██      
-- ██    ██ ██    ██    ██    ███████ ██ ██   ██ █████       ██    ██ █████   ███████ ██ ██      ██      █████   ███████ 
-- ██    ██ ██    ██    ██         ██ ██ ██   ██ ██           ██  ██  ██      ██   ██ ██ ██      ██      ██           ██ 
--  ██████   ██████     ██    ███████ ██ ██████  ███████       ████   ███████ ██   ██ ██  ██████ ███████ ███████ ███████

CreateCallback("snipe-menu:server:getOutsideVehicles", function(source, cb)
    local returnData = {}
    if Config.Core == "QBCore" then
        local result = MySQL.query.await('SELECT * FROM player_vehicles WHERE state = ?', { 0 }) 
        -- local result = MySQL.query.await('SELECT * FROM player_vehicles WHERE in_garage = ?', { 0 })  -- uncomment this line if you use cd_garage (QBCore) and comment the line above
        if result ~= nil then
            for k, v in pairs(result) do
                returnData[#returnData + 1] = {
                    id = v.vehicle,
                    name = v.plate,
                }
            end
            cb(returnData)
        else
            cb(nil)
        end
    elseif Config.Core == "ESX" then
        local result = MySQL.query.await('SELECT * FROM owned_vehicles WHERE stored = ?', { 0 }) 
        -- local result = MySQL.query.await('SELECT * FROM owned_vehicles WHERE in_garage = ?', { 0 }) -- uncomment this line if you use cd_garage (ESX) and comment the line above
        if result ~= nil then
            for k, v in pairs(result) do
                returnData[#returnData + 1] = {
                    id = v.vehicle,
                    name = v.plate,
                }
            end
            cb(returnData)
        else
            cb(nil)
        end
    end
end)

RegisterServerEvent("snipe-menu:server:changeVehicleState", function(plate)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        if Config.Core == "QBCore" then
            MySQL.query.await('UPDATE player_vehicles SET state = ? WHERE plate = ?', { 1, plate }) 
            -- MySQL.query.await('UPDATE player_vehicles SET in_garage = ? WHERE plate = ?', { 1, plate }) -- uncomment this line if you use cd_garage (QBCore) and comment the line above
            SendLogs(src, "triggered", Config.Locales["changed_vehicle_state"]..plate)
        elseif Config.Core == "ESX" then
            MySQL.query.await('UPDATE owned_vehicles SET stored = ? WHERE plate = ?', { 1, plate }) 
            -- MySQL.query.await('UPDATE owned_vehicles SET in_garage = ? WHERE plate = ?', { 1, plate }) -- uncomment this line if you use cd_garage (ESX) and comment the line above
            SendLogs(src, "triggered", Config.Locales["changed_vehicle_state"]..plate)
        end
    else
        SendLogs(src, "exploit", Config.Locales["changed_vehicle_state_exploit"])
    end
end)

-- ██       ██████   ██████   ██████  ██    ██ ████████ 
-- ██      ██    ██ ██       ██    ██ ██    ██    ██    
-- ██      ██    ██ ██   ███ ██    ██ ██    ██    ██    
-- ██      ██    ██ ██    ██ ██    ██ ██    ██    ██    
-- ███████  ██████   ██████   ██████   ██████     ██

RegisterServerEvent("snipe-menu:server:forceLogout", function(id)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        if Config.Core == "QBCore" then
            QBCore.Player.Logout(id)
            TriggerClientEvent('qb-multicharacter:client:chooseChar', id)
            SendLogs(src, "triggered", Config.Locales["forced_logout_player"]..GetPlayerName(id))
        elseif Config.Core == "ESX" then
            TriggerEvent("esx:playerLogout") -- only works if you use multicharacter (ESX)
            SendLogs(src, "triggered", Config.Locales["forced_logout_player"]..GetPlayerName(id))
        end
    else
        SendLogs(src, "exploit", Config.Locales["forced_logout_player_exploit"])
    end
end)

--  ██████  ██ ██    ██ ███████      ██████  ██    ██ ████████ ███████ ██ ████████ ███████ 
-- ██       ██ ██    ██ ██          ██    ██ ██    ██    ██    ██      ██    ██    ██      
-- ██   ███ ██ ██    ██ █████       ██    ██ ██    ██    ██    █████   ██    ██    ███████ 
-- ██    ██ ██  ██  ██  ██          ██    ██ ██    ██    ██    ██      ██    ██         ██ 
--  ██████  ██   ████   ███████      ██████   ██████     ██    ██      ██    ██    ███████

RegisterServerEvent("snipe-menu:server:giveOutfits", function(id)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        if Config.Skin == "qb-clothing" then
            TriggerClientEvent("qb-clothing:client:openOutfitMenu", id)
        elseif Config.Skin == "fivem-appearance" then
            if Config.Core == "QBCore" then
                TriggerClientEvent("qb-clothing:client:openOutfitMenu", id)
            else
                TriggerClientEvent("fivem-appearance:pickNewOutfit", id, {id = 1, number = 2})
            end
        elseif Config.Skin == "esx_skin" then
            -- ESX Skin does not have outfits options
        elseif Config.Skin == "other" then
            -- Put the event to open the outfit menu here
        end
        TriggerClientEvent("snipe-menu:client:closeMenu", id)
        SendLogs(src, "triggered", Config.Locales["clothing_outfit_option"]..GetPlayerName(id))
    else
        SendLogs(src, "exploit", Config.Locales["clothing_outfit_option_exploit"])
    end
end)

-- ██████  ███████ ██    ██     ███    ███  ██████  ██████  ███████ 
-- ██   ██ ██      ██    ██     ████  ████ ██    ██ ██   ██ ██      
-- ██   ██ █████   ██    ██     ██ ████ ██ ██    ██ ██   ██ █████   
-- ██   ██ ██       ██  ██      ██  ██  ██ ██    ██ ██   ██ ██      
-- ██████  ███████   ████       ██      ██  ██████  ██████  ███████

local function isDevMode(source)
    if source == nil then 
        print("snipe-menu: isDevMode() source is nil")
        return false 
    end
    return devMode[source]
end

exports('isDevMode', isDevMode)


RegisterServerEvent("snipe-menu:server:sendDmToPlayer", function(playerId, reason)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        SendLogs(src, "triggered", Config.Locales["send_dm_used"]..GetPlayerName(playerId).." reason: "..reason)
        TriggerClientEvent('chat:addMessage', tonumber(playerId), {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[DM]", reason}
        })
    end
end)


-- This is used to fetch the necessary licenses that show on the player list. You can add more info here if you want.

function GetPlayerAllLicenses(id)
    local returnData = {}
    local licenses = GetPlayerIdentifiers(id)
    for k, v in pairs(licenses) do
        if string.match(v, "license:") then
            returnData[#returnData + 1] = v
        elseif string.match(v, "steam:") then
            returnData[#returnData + 1] = v
        elseif string.match(v, "discord:") then
            returnData[#returnData + 1] = v
        elseif string.match(v, "fivem:") then
            returnData[#returnData + 1] = v
        end
    end
    return returnData
end

function GetPlayerInfo(id)
    local returnData = {}
    if Config.Core == "QBCore" then
        local otherPlayer = QBCore.Functions.GetPlayer(id)
        returnData.citizenId = otherPlayer.PlayerData.citizenid
        returnData.name = otherPlayer.PlayerData.charinfo.firstname.." "..otherPlayer.PlayerData.charinfo.lastname
        returnData.job = otherPlayer.PlayerData.job.label.." ("..otherPlayer.PlayerData.job.grade.name..")"
        returnData.gang = otherPlayer.PlayerData.gang.label.." ("..otherPlayer.PlayerData.gang.grade.name..")"
        returnData.cashBalance = otherPlayer.PlayerData.money["cash"]
        returnData.bankBalance = otherPlayer.PlayerData.money["bank"]
        returnData.radio = Player(otherPlayer.PlayerData.source).state.radioChannel
        -- if you use a custom phone script, make sure to change the line below to the correct phone number
        returnData.phone = otherPlayer.PlayerData.charinfo.phone or "Not Available"
    elseif Config.Core == "ESX" then
        local otherPlayer = ESX.GetPlayerFromId(id)
        returnData.citizenId = otherPlayer.identifier
        returnData.name = otherPlayer.name
        returnData.job = otherPlayer.job.label.." ("..otherPlayer.job.grade_label..")"
        returnData.gang = otherPlayer.job.label.." ("..otherPlayer.job.grade_label..")" -- gang is job in ESX. If you have gangs, you can change this.
        returnData.cashBalance = otherPlayer.getMoney()
        returnData.bankBalance = otherPlayer.getAccount("bank").money
        returnData.radio = Player(otherPlayer.source).state.radioChannel
        -- if you use a custom phone script, make sure to change the line below to the correct phone number
        returnData.phone = otherPlayer.get('phoneNumber') or "Not Available"
    end
    return returnData
end