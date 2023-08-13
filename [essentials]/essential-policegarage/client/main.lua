local QBCore = exports['qb-core']:GetCoreObject() 
local PlayerData = {}
local pedspawned = false


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(Player)
    PlayerData =  QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
     PlayerJob = job
end)



RegisterCommand('clear', function(source, args)
    TriggerEvent('chat:clear')
end, false)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k, v in pairs(Config.Pedlocation) do
			local pos = GetEntityCoords(PlayerPedId())	
			local dist = #(v.Cords - pos)
			
			if dist < 40 and pedspawned == false then
				TriggerEvent('spawn:ped',v.Cords,v.h)
				pedspawned = true
			end
			if dist >= 35 then
				pedspawned = false
				DeletePed(npc)
			end
		end
	end
end)

RegisterNetEvent('spawn:ped')
AddEventHandler('spawn:ped',function(coords,heading)
	local hash = GetHashKey('ig_trafficwarden')
	if not HasModelLoaded(hash) then
		RequestModel(hash)
		Wait(10)
	end
	while not HasModelLoaded(hash) do 
		Wait(10)
	end

    pedspawned = true
	npc = CreatePed(5, hash, coords, heading, false, false)
	FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
	loadAnimDict("amb@world_human_cop_idles@male@idle_b") 
	while not TaskPlayAnim(npc, "amb@world_human_cop_idles@male@idle_b", "idle_e", 8.0, 1.0, -1, 17, 0, 0, 0, 0) do
	Wait(1000)
	end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent('essential:garage')
AddEventHandler('essential:garage', function(pd)
    local vehicle = pd.vehicle
    local coords = { ['x'] = 435.51, ['y'] = -975.91, ['z'] = 25.7, ['h'] = 89.04}
    
    

    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "police" then
            if vehicle == 'code311cvpi' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)            
            elseif  vehicle == 'code314tahoe' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)

            elseif vehicle ==  'code316fpiu' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            elseif vehicle == '2016taurusrb' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            elseif vehicle == 'code318charger' then 
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            elseif vehicle == 'code320tahoe' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            elseif vehicle == 'code320tahoek9' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            elseif vehicle == 'code321durango' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            elseif vehicle == 'code321tahoe' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            elseif vehicle == 'code3bike1' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            elseif vehicle == 'code3bike2' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            end
        else 
            QBCore.Functions.Notify('You are not a cop.', 'error')
            
        end
    end)    
end)

RegisterNetEvent('essential:storecar')
AddEventHandler('essential:storecar', function()
    local Player = QBCore.Functions.GetPlayerData()

    QBCore.Functions.Notify('Vehicle Stored!')
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    NetworkFadeOutEntity(car, true,false)
    Citizen.Wait(2000)
    QBCore.Functions.DeleteVehicle(car)
end)



RegisterNetEvent('garage:menu', function()
    exports['qb-menu']:openMenu( {
        {
            id = 1,
            header = "2011 CVPI",
            txt = "Police CVPI",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = 'code311cvpi',
                    
                }
            }
        },
        {
            id = 2,
            header = "2014 Tahoe",
            txt = "Police Tahoe",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = 'code314tahoe',
                    
                }
            }
        },
        {
            id = 3,
            header = "2016 Explorer",
            txt = "Police Explorer",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = 'code316fpiu',
                    
                }
            }
        },
        {
            id = 4,
            header = "2016 Taurus",
            txt = "Police Taurus",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = '2016taurusrb',
                    
                }
            }
        },
       
        {
            id = 5,
            header = "2018 Charger",
            txt = "Police Charger",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = 'code318charger',
                    
                }
            }
        },
        {
            id = 6,
            header = "2020 Tahoe",
            txt = "Police Tahoe",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = 'code320tahoe',
                    
                }
            }
        },
        {
            id = 7,
            header = "2020 K9 Tahoe",
            txt = "K9 Tahoe",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = 'code320tahoek9',
                    
                }
            }
        },
        {
            id = 8,
            header = "2021 Durango",
            txt = "Police Durango",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = 'code321durango',
                    
                }
            }
        },
        {
            id = 9,
            header = "2021 Tahoe",
            txt = "Police Command Tahoe",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = 'code321tahoe',
                    
                }
            }
        },
        {
            id = 10,
            header = "Kawasaki Bike",
            txt = "Police Bike 1",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = 'code3bike1',
                    
                }
            }
        },
        {
            id = 11,
            header = "BMW Bike",
            txt = "Police Bike 2",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = 'code3bike2',
                    
                }
            }
        },
        {
            id = 12,
            header = "Police F-150",
            txt = "Police Ford F-150",
            params = {
                event = "essential:garage",
                args = {
                    vehicle = 'Code3F150',
                    
                }
            }
        },
        {
            id = 12,
            header = "Store Vehicle",
            txt = "Store Vehicle Inside Garage",
            params = {
                event = "essential:storecar",
                args = {
                    
                }
            }
        },
        
        
    })
end)

--- EMS Garage

RegisterNetEvent('ambulance:garage')
AddEventHandler('ambulance:garage', function(pd)
    local vehicle = pd.vehicle
    local coords = { ['x'] = 317.57, ['y'] = -578.52, ['z'] = 28.8, ['h'] = 250.01}
    

    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "ambulance" then
            if vehicle == 'ambulance' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)            
            elseif  vehicle == 'dodgeEMS' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            elseif  vehicle == 'emsnspeedo' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            elseif  vehicle == 'emsv' then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                    exports['cdn-fuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            end
        else 
            QBCore.Functions.Notify('You are not an EMS', 'error')
            
        end
    end)    
end)

RegisterNetEvent('essential:storecar')
AddEventHandler('essential:storecar', function()
    local Player = QBCore.Functions.GetPlayerData()

    QBCore.Functions.Notify('Vehicle Stored!')
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    NetworkFadeOutEntity(car, true,false)
    Citizen.Wait(2000)
    QBCore.Functions.DeleteVehicle(car)
end)



RegisterNetEvent('garage:ambulance', function()
    exports['qb-menu']:openMenu( {
        {
            id = 1,
            header = "Ambulance Garage",
            txt = ""
        },
        {
            id = 2,
            header = "Ambulance",
            txt = "EMS Ambulance",
            params = {
                event = "ambulance:garage",
                args = {
                    vehicle = 'ambulance',
                    
                }
            }
        },
        {
            id = 3,
            header = "Ambulance",
            txt = "EMS Chager",
            params = {
                event = "ambulance:garage",
                args = {
                    vehicle = 'dodgeEMS',
                    
                }
            }
        },
        {
            id = 4,
            header = "Speedo",
            txt = "EMS Speedo Ambulance",
            params = {
                event = "ambulance:garage",
                args = {
                    vehicle = 'emsnspeedo',
                    
                }
            }
        },
        {
            id = 5,
            header = "Coroner Vapid",
            txt = "EMS Vapid Ambulance",
            params = {
                event = "ambulance:garage",
                args = {
                    vehicle = 'emsv',
                    
                }
            }
        },
        {
            id = 9,
            header = "Store Vehicle",
            txt = "Store Vehicle Inside Garage",
            params = {
                event = "essential:storecar",
                args = {
                    
                }
            }
        },
        
    })
end)


