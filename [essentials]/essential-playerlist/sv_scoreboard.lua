local QBCore = exports['qb-core']:GetCoreObject()

local QB = QB or {}
QB.Scoreboard = {}
QB._Scoreboard = {}
QB._Scoreboard.PlayersS = {}
QB._Scoreboard.RecentS = {}

RegisterServerEvent('qb-scoreboard:AddPlayer')
AddEventHandler("qb-scoreboard:AddPlayer", function()
    local src = source
    local ply = GetPlayerName(src)
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local data = { src = src, citizenid = cid, name = ply }
    QB._Scoreboard.PlayersS[#QB._Scoreboard.PlayersS+1] = data
    TriggerClientEvent("qb-scoreboard:AddPlayer", -1, data )
    QB.Scoreboard.AddAllPlayers()
end)


function QB.Scoreboard.AddAllPlayers(self)
    --local players = GetActivePlayers()
    for _, _PlayerId in pairs(QBCore.Functions.GetPlayers()) do
        local ply = GetPlayerName(_PlayerId)
        local pData = QBCore.Functions.GetPlayer(tonumber(_PlayerId))
        local cid = pData.PlayerData.citizenid
        local data = { src = tonumber(_PlayerId), citizenid = cid, name = ply }

        TriggerClientEvent("qb-scoreboard:AddAllPlayers", source, data)
    end
end

AddEventHandler('playerDropped', function()
    local src = source
    for _, v in pairs(QB._Scoreboard.PlayersS) do
        if v.src == src then
            local data = { src = v.src, citizenid = v.citizenid, name = v.name }

            TriggerClientEvent("qb-scoreboard:RemovePlayer", -1, data)
            TriggerEvent('qb-scoreboard:server:totalPlayers')
            Wait(600000)
            TriggerClientEvent("qb-scoreboard:RemoveRecent", -1, v.src)
        end
    end
end)

RegisterNetEvent('qb-scoreboard:server:totalPlayers')
AddEventHandler('qb-scoreboard:server:totalPlayers', function()
    local totalPlayers = 0
    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v then
            totalPlayers += 1
        end
    end
    TriggerClientEvent('qb-scoreboard:playerscount', -1, totalPlayers)
end)