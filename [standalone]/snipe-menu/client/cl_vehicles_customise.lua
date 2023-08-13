function BennyOpen()
    if Config.Core == "QBCore" then
        TriggerServerEvent("snipe-menu:server:toggleBennys")
    elseif Config.Core == "ESX" then
        exports["esx_lscustom"]:GetAction({value = 'main'})
    end
end

function SpawnCar(carName, maxMods, seatVehicle)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local forwardCoords = GetEntityForwardVector(PlayerPedId()) * 5.0
    if IsModelInCdimage(carName) then
        if not HasModelLoaded(carName) then 
            RequestModel(carName)
            while not HasModelLoaded(carName) do
                Wait(0)
            end
        end
        local vehicle = CreateVehicle(carName, playerCoords.x + forwardCoords.x, playerCoords.y + forwardCoords.y, playerCoords.z + forwardCoords.z, playerCoords.w, true, false)
        SetEntityHeading(vehicle, GetEntityHeading(PlayerPedId()))
        NetworkFadeInEntity(vehicle, true, true)
        SetVehicleOnGroundProperly(vehicle)
        SetEntityAsMissionEntity(vehicle, true, true)
        local netid = NetworkGetNetworkIdFromEntity(vehicle)
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetNetworkIdCanMigrate(netid, true)
        GiveKeys(GetVehicleNumberPlateText(vehicle))
        TriggerServerEvent("snipe-menu:server:sendLogs", "triggered", "Spawned a " .. carName)
        if maxMods then
            Wait(100)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, 11, 3, false)--engine
            SetVehicleMod(vehicle, 12, 2, false)--brakes
            SetVehicleMod(vehicle, 13, 2, false)--transmission
            SetVehicleMod(vehicle, 15, 2, false)--suspension
            SetVehicleMod(vehicle, 16, 4, false)--armor
            ToggleVehicleMod(vehicle,  18, true)--turbo
            SetVehicleFixed(vehicle)
        end
        if seatVehicle then
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
            SendNUIMessage({
                action = "forceClose"
            })
        end
    else
        print("Invalid model name")
    end
end