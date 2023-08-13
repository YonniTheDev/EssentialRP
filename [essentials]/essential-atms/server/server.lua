local QBCore = exports['qb-core']:GetCoreObject()

local MoneyType = Config.MoneyType
local HackItem = Config.HackItem
local CoolDown = false


--------------------------------------------------------------------------------------- # Events # ---------------------------------------------------------------------------------------
RegisterServerEvent('essential-atms:server:timer', function()
    CoolDown = true
    local timer = Config.CoolDown * (60 * 1000)
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            CoolDown = false
        end
    end
end)

RegisterNetEvent('essential-atms:server:removeitem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(HackItem, 1)
end)

-- RegisterNetEvent('essential-atms:server:giveitemback', function()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     Player.Functions.AddItem(HackItem, 1)
-- end)

RegisterNetEvent("essential-atms:server:success",function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    Player.Functions.AddMoney('cash', math.random(Config.PaymentMin, Config.PaymentMax))
end)

RegisterServerEvent('essential-atms:server:success2', function()
    local src = source
	local Player =  QBCore.Functions.GetPlayer(source)
    local bags = 10,15
	local info = {
		worth = math.random(Config.PaymentMin, Config.PaymentMax)
	}
	Player.Functions.AddItem('bands', bags, false, info)
    Player.Functions.RemoveItem(HackItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bands'], "add")
end)
--------------------------------------------------------------------------------------- # Start / Stop Resoure # ----------------------------------------------------------------------------
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PerformHttpRequest('https://raw.githubusercontent.com/DevSerrulata/essential-atms/master/version.txt', function(errorCode, result, headers)
            local version = LoadResourceFile(GetCurrentResourceName(), '1.0.2')
            if result ~= version then
                print("-----------------------------------------------------")
                print("essential-atms is outdated, please update it!")
                print("-----------------------------------------------------")
            else
                print("essential-atms is up to date!")
            end
        end)
    end
end)


--------------------------------------------------------------------------------------- # Callbacks # ---------------------------------------------------------------------------------------
QBCore.Functions.CreateCallback("essential-atms:server:Cooldown",function(source, cb)
    if CoolDown then
        cb(true)
    else
        cb(false)
    end
end)