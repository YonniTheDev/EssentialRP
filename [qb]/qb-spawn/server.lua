local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-spawn:server:getOwnedHouses', function(_, cb, cid)
    if cid ~= nil then
        -- local houses = exports.oxmysql:executeSync('SELECT * FROM player_houses WHERE citizenid = ?', {cid}) -- OLD
        local houses = MySQL.query.await('SELECT * FROM player_houses WHERE citizenid = ?', {cid}) -- NEW
        if houses[1] ~= nil then
            cb(houses)
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end)

QBCore.Commands.Add("addloc", "Add location for spawn (God Only)", {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-spawn:client:OpenUIForSelectCoord', src)
end, "god")