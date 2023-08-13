QBCore, ESX = nil, nil

-- ███████ ██████   █████  ███    ███ ███████ ██     ██  ██████  ██████  ██   ██ 
-- ██      ██   ██ ██   ██ ████  ████ ██      ██     ██ ██    ██ ██   ██ ██  ██  
-- █████   ██████  ███████ ██ ████ ██ █████   ██  █  ██ ██    ██ ██████  █████   
-- ██      ██   ██ ██   ██ ██  ██  ██ ██      ██ ███ ██ ██    ██ ██   ██ ██  ██  
-- ██      ██   ██ ██   ██ ██      ██ ███████  ███ ███   ██████  ██   ██ ██   ██

if Config.Core == "QBCore" then
    QBCore = exports[Config.CoreFolderName]:GetCoreObject()
    Citizen.CreateThread(function()
        while QBCore == nil do
            TriggerEvent(Config.Core..':GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end)
elseif Config.Core == "ESX" then
    ESX = exports[Config.CoreFolderName]:getSharedObject()
end

-- ███████ ██    ██ ███████ ███    ██ ████████ ███████ 
-- ██      ██    ██ ██      ████   ██    ██    ██      
-- █████   ██    ██ █████   ██ ██  ██    ██    ███████ 
-- ██       ██  ██  ██      ██  ██ ██    ██         ██ 
-- ███████   ████   ███████ ██   ████    ██    ███████


RegisterNetEvent("snipe-menu:client:FixVehicle", function()
    if hasAdminPerms then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle then
            SetVehicleFixed(vehicle)
            SetVehicleDirtLevel(vehicle, 0.0)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true)
            -- if you have any other events that fix vehicles/status add them below this line.
        else
            ShowNotification("You are not in a vehicle", "error")
        end
    else
        TriggerServerEvent("snipe-menu:server:sendLogs", "exploit", Config.Locales["fix_vehicle_exploit_event"])
    end
end)

RegisterNetEvent("snipe-menu:client:teleportMarker", function()
    if hasAdminPerms then
        local WaypointHandle = GetFirstBlipInfoId(8)

        if DoesBlipExist(WaypointHandle) then
            local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

            for height = 1, 1000 do
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                if foundGround then
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    break
                end

                Citizen.Wait(5)
            end
        end
    else
        TriggerServerEvent("snipe-menu:server:sendLogs", "exploit", Config.Locales["teleport_exploit_event"])
    end
end)

RegisterNetEvent("snipe-menu:client:removeStress", function()
    if hasAdminPerms then
        TriggerServerEvent("hud:server:RelieveStress", 100) -- this is qbcore event to remove stress (that particular event is in qb-hud/server.lua)
    else
        TriggerServerEvent("snipe-menu:server:sendLogs", "exploit", Config.Locales["stress_exploit_event"])
    end
end)

RegisterNetEvent("snipe-menu:client:teleporttoplayer", function(coords)
    if hasAdminPerms then
        SetPedCoordsKeepVehicle(PlayerPedId(), coords.x, coords.y, coords.z)
    else
        TriggerServerEvent("snipe-menu:server:sendLogs", "exploit", Config.Locales["teleport_exploit_event"])
    end
end)

RegisterNetEvent("snipe-menu:client:bringPlayer", function(coords)
    SetPedCoordsKeepVehicle(PlayerPedId(), coords.x, coords.y, coords.z)
end)



RegisterNetEvent("snipe-menu:client:openinventory", function(otherPlayer)
    if hasAdminPerms then
        if Config.Core == "QBCore" and Config.Inventory ~= "ox" then
            TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", otherPlayer)
        elseif Config.Core == "ESX" and Config.Inventory == "qs" then
            TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", otherPlayer)
        elseif Config.Inventory == "ox" then
            exports.ox_inventory:SetAdmin()
            exports.ox_inventory:openInventory('player', otherPlayer)
        else
            print("Snipe-Menu: Invalid Inventory Type, please change it to either 'qb' or 'qs' or 'ox' in config.lua")
        end
    end
end)

RegisterNetEvent("snipe-menu:client:changePlate", function(newPlate)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    SetVehicleNumberPlateText(vehicle, newPlate)
    GiveKeys(newPlate)
end)

RegisterNetEvent("snipe-menu:client:toggleDev", function()
    if hasAdminPerms then
        TriggerEvent("qb-admin:client:ToggleDevmode") -- used to toggle the dev mode ui on hud if you use ps-hud
    end
end)


RegisterNetEvent("snipe-menu:client:setWeather", function(weatherName)
    if hasAdminPerms then
        if Config.Core == "QBCore" then
            TriggerServerEvent("qb-weathersync:server:setWeather", weatherName) -- used to change the weather if you use qb-weathersync (edit if you use another weather script)
        elseif Config.Core == "ESX" then -- this is configured for easytime
            local values = {
                instantweather = true,
                weather = weatherName,
                dynamic = exports["cd_easytime"]:GetWeather().dynamic,
                instanttime = true,
                hours = exports["cd_easytime"]:GetWeather().hours,
                mins = exports["cd_easytime"]:GetWeather().mins,
                freeze = exports["cd_easytime"]:GetWeather().freeze,
                tsunami = exports["cd_easytime"]:GetWeather().tsunami,
                blackout = exports["cd_easytime"]:GetWeather().blackout
            }
            TriggerServerEvent('cd_easytime:ForceUpdate', values)
        end
    end
end)

RegisterNetEvent("snipe-menu:client:setTime", function(hours, mins)
    if hasAdminPerms then
        if Config.Core == "QBCore" then
            TriggerServerEvent("qb-weathersync:server:setTime", hours, mins) -- used to change the time if you use qb-weathersync (edit if you use another weather script)
        elseif Config.Core == "ESX" then -- this is configured for easytime
            local values = {
                instantweather = false,
                weather = exports["cd_easytime"]:GetWeather().weather,
                dynamic = exports["cd_easytime"]:GetWeather().dynamic,
                instanttime = true,
                hours = hours,
                mins = mins,
                freeze = exports["cd_easytime"]:GetWeather().freeze,
                tsunami = exports["cd_easytime"]:GetWeather().tsunami,
                blackout = exports["cd_easytime"]:GetWeather().blackout
            }
            TriggerServerEvent('cd_easytime:ForceUpdate', values)
        end
    end
end)

RegisterNetEvent("snipe-menu:client:reviveInRadius", function(coords)
    if #(GetEntityCoords(PlayerPedId()) - coords) < Config.ReviveRadiusDistance then
        if Config.Core == "QBCore" then
            TriggerEvent("hospital:client:Revive")
        elseif Config.Core == "ESX" then
            TriggerEvent("esx_ambulancejob:revive")
        end
    end
end)


function SetTargetExports(entity, job, size, slots, stashName, isJob, isGang)
    if isJob then
        if Config.Target ~= "ox_target" then
            exports[Config.Target]:AddTargetEntity({entity}, {
                options = {
                    {
                        event = "snipe-menu:client:openJobStash",
                        icon = "fas fa-box-open",
                        label = "Open",
                        job = job,
                        size = size,
                        slots = slots,
                        jobStashName = stashName,
                    },
                },
                distance = 1.5
            })
        elseif Config.Target == "ox_target" then
            local options = {
                {
                    event = "snipe-menu:client:openJobStash",
                    icon = "fas fa-box-open",
                    label = "Open",
                    groups = job,
                    size = size,
                    slots = slots,
                    jobStashName = stashName,
                },
            }
            exports.ox_target:addLocalEntity(entity, options)
        end
    elseif isGang then
        if Config.Target ~= "ox_target" then
            exports[Config.Target]:AddTargetEntity({entity}, {
                options = {
                    {
                        event = "snipe-menu:client:openJobStash",
                        icon = "fas fa-box-open",
                        label = "Open",
                        gang = job,
                        size = size,
                        slots = slots,
                        jobStashName = stashName,
                    },
                },
                distance = 1.5
            })
        elseif Config.Target == "ox_target" then
            local options = {
                {
                    event = "snipe-menu:client:openJobStash",
                    icon = "fas fa-box-open",
                    label = "Open",
                    groups = job,
                    size = size,
                    slots = slots,
                    jobStashName = stashName,
                },
            }
            exports.ox_target:addLocalEntity(entity, options)
        end
    end
end

-- ███    ██  ██████  ████████ ██ ███████ ██    ██ 
-- ████   ██ ██    ██    ██    ██ ██       ██  ██  
-- ██ ██  ██ ██    ██    ██    ██ █████     ████   
-- ██  ██ ██ ██    ██    ██    ██ ██         ██    
-- ██   ████  ██████     ██    ██ ██         ██

function ShowNotification(msg, type)
    if Config.Core == "QBCore" then
        QBCore.Functions.Notify(msg, type)
    elseif Config.Core == "ESX" then
        ESX.ShowNotification(msg)
    end
end

function GiveKeys(plate)
    TriggerEvent("vehiclekeys:client:SetOwner", plate) -- change it to your own logic
end

local function isAdmin()
    return hasAdminPerms
end

exports('isAdmin', isAdmin)