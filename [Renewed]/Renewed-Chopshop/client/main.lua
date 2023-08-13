local QBCore = exports['qb-core']:GetCoreObject()
local NetID = nil
local PZone = nil
local inZone = false
local Doors = {}
local Secured = false
local Notif = false
local inProgress = false

local CurrentPD = 0

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentPD = amount
end)

---- ** Test command to chop, MAKE SURE to be in a group before you start ** ----
RegisterCommand('chop', function()
    TriggerEvent('renewed-chopshop:client:StartJob')
end, false)

RegisterNetEvent('renewed-chopshop:client:EmailHandler', function(data)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = data.sender,
        subject = data.subject,
        message = data.message
    })
end)


---- ** Event to listen to lockpicks and if the user have NetID defined to then check for dist checks, x100 more effcient than a loop ** ----
RegisterNetEvent('lockpicks:UseLockpick', function()
    if NetID and DoesEntityExist(NetworkGetEntityFromNetworkId(NetID)) and not PZone then
        local carSpawned = NetworkGetEntityFromNetworkId(NetID)
        local dist = #(GetEntityCoords(carSpawned) - GetEntityCoords(PlayerPedId()))
        if dist <= 5 then
            TriggerServerEvent('renewed-chopshop:server:CarFound')
        end
    end
end)

---- ** Event to generate the scrapyard Zone ** ----
RegisterNetEvent('renewed-chopshop:client:GeneratePolyZone', function(data)
    if lib then
        PZone = lib.zones.sphere({
            coords = Config.Disassembly[data].coords,
            radius = Config.Disassembly[data].radius,
            debug = true,
            onEnter = function(self)
                --exports['qb-dispatch']:Chopping()
                inZone = true
                if not Notif then
                    Notif = true
                    TriggerServerEvent('renewed-chopshop:server:ArrivedAtLocation')
                end
            end,
            onExit = function(self)
                inZone = false
            end
        })
    else
        PZone = CircleZone:Create(Config.Disassembly[data].coords, Config.Disassembly[data].radius, {
            name = "NewChopShopWhoDis",
            debugPoly = false,
        })
        PZone:onPlayerInOut(function(isPointInside)
            if isPointInside then
                --exports['qb-dispatch']:Chopping()
                inZone = true
                if not Notif then
                    Notif = true
                    TriggerServerEvent('renewed-chopshop:server:ArrivedAtLocation')
                end
            else
                inZone = false
            end
        end)

    end
end)

---- ** Job Sync Events ** ----
RegisterNetEvent("renewed-chopshop:client:CarFound", function()
    local realCar = NetworkGetEntityFromNetworkId(NetID)
    print('setting fuel')
    exports['cdn-fuel']:SetFuel(realCar, 100.0)
end)

RegisterNetEvent('renewed-chopshop:client:FindCar', function(car, GroupDoors, Secure, Coords)
    NetID = car

    local realCar = NetworkGetEntityFromNetworkId(NetID)
    SetVehicleEngineOn(realCar, false, false, true)
    Doors = GroupDoors
    Secured = Secure

    if lib then
        PZone = lib.zones.sphere({
            coords = vector3(Coords.x, Coords.y, Coords.z),
            radius = 300,
            debug = true,
            onEnter = function(self)
                TriggerServerEvent('renewed-chopshop:server:InCarZone')
            end
        })
    else
        PZone = CircleZone:Create(vector3(Coords.x, Coords.y, Coords.z), 300, {
            name = "NewCarSpawnWhoDis",
            debugPoly = false,
        })

        PZone:onPlayerInOut(function(isPointInside)
            if isPointInside then
                TriggerServerEvent('renewed-chopshop:server:InCarZone')
            end
        end)
    end
end)
local function removePolyZones()
    if PZone then
        if lib then
            PZone:remove()
        else
            PZone:destroy()
        end
        PZone = nil
    end
end
RegisterNetEvent('renewed-chopshop:client:DeletePolyZone', removePolyZones)

RegisterNetEvent('renewed-chopshop:client:setState', function(location, state)
    Config.Spawns[location].isBusy = state
end)

RegisterNetEvent('renewed-chopshop:client:syncParts', function(part, busy)
    Doors[part].busy = busy
end)

RegisterNetEvent('renewed-chopshop:client:syncSecure', function(secure)
    Secured = secure
end)

RegisterNetEvent('renewed-chopshop:client:ClientReset', function()
    removePolyZones()
    NetID = nil
    inZone = false
    Doors = {}
    Secured = false
    Notif = false
end)

---- ** All the chopping vehicle Events ** ----
RegisterNetEvent('renewed-chopshop:client:SecureCar', function()
    if inProgress then return QBCore.Functions.Notify('You are already doing something', 'error', 7500) end
    QBCore.Functions.TriggerCallback('renewed-chopshop:server:CanSecureCar', function(canSecure)
        if canSecure then
            if Config.oSkullaEmotes then
                exports.scully_emotemenu:PlayByCommand("mechanic4")
            else
                TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
            end
            inProgress = true
            QBCore.Functions.Progressbar('chop_place', 'Securing Car in Place', 5000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Play When Done
                if Config.oSkullaEmotes then exports.scully_emotemenu:CancelAnimation() else ClearPedTasks(PlayerPedId()) end
                TriggerServerEvent('renewed-chopshop:server:SecuredCar')
                inProgress = false
            end, function() -- Play When Cancel
                inProgress = false
            end)
        end
    end)
end)

RegisterNetEvent('renewed-chopshop:client:ChopDoor', function(data)
    if data and data.args then data = data.args end
    if GetVehicleDoorLockStatus(NetworkGetEntityFromNetworkId(NetID)) ~= 2 then
        if inProgress then return QBCore.Functions.Notify('You are already doing something', 'error', 7500) end
        QBCore.Functions.TriggerCallback("renewed-chopshop:server:CanStealPart", function(canSteal)
            local vehicle = NetworkGetEntityFromNetworkId(NetID)
            local ped = PlayerPedId()
            TaskOpenVehicleDoor(ped, vehicle, 3000, data.seat, 10)
            local checks = 0
            inProgress = true
            while GetVehicleDoorAngleRatio(vehicle, data.door) < 0.75 do
                Wait(100)
                checks = checks + 1
                if checks > 15 then
                    SetVehicleDoorOpen(vehicle, data.door, false, true) -- Incase the door gets stuck, like my stepsister in the washing machine
                end
            end
            if Config.oSkullaEmotes then
                exports.scully_emotemenu:PlayByCommand("weld")
            else
                TriggerEvent('animations:client:EmoteCommandStart', {"weld"})
            end
            QBCore.Functions.Progressbar('weld_Car', 'Breaking off Door', 5000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Play When Done
                inProgress = false
                SetVehicleDoorBroken(vehicle, data.door, true)
                TriggerServerEvent('renewed-chopshop:server:StoleItem', data.bone)
                if Config.oSkullaEmotes then exports.scully_emotemenu:CancelAnimation() else ClearPedTasks(PlayerPedId()) end
            end, function() -- Play When Cancel
                inProgress = false
            end)
        end, data.bone)
    else
        QBCore.Functions.Notify('Vehicle is Locked!', 'error', 7500)
    end
end)

RegisterNetEvent('renewed-chopshop:client:ChopEngine', function(data)
    if data and data.args then data = data.args end
    if inProgress then return QBCore.Functions.Notify('You are already doing something', 'error', 7500) end
    if GetVehicleDoorLockStatus(NetworkGetEntityFromNetworkId(NetID)) ~= 2 then
        QBCore.Functions.TriggerCallback("renewed-chopshop:server:CanStealPart", function(canSteal)
            local vehicle = NetworkGetEntityFromNetworkId(NetID)
            SetVehicleDoorOpen(vehicle, data.door, false, true)
            if Config.oSkullaEmotes then
                exports.scully_emotemenu:PlayByCommand("pull")
            else
                TriggerEvent('animations:client:EmoteCommandStart', {"pull"})
            end
            inProgress = true
            QBCore.Functions.Progressbar('weld_Car', 'Pulling off car Part', 5000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Play When Done
                if Config.oSkullaEmotes then exports.scully_emotemenu:CancelAnimation() else ClearPedTasks(PlayerPedId()) end
                inProgress = false
                SetVehicleDoorBroken(NetworkGetEntityFromNetworkId(NetID), data.door, true)
                TriggerServerEvent('renewed-chopshop:server:StoleItem', data.bone)
            end, function() -- Play When Cancel
                inProgress = false
            end)
        end, data.bone)
    else
        QBCore.Functions.Notify('Vehicle is Locked!', 'error', 7500)
    end
end)

RegisterNetEvent('renewed-chopshop:client:ChopWheel', function(data)
    if data and data.args then data = data.args end
    if inProgress then return QBCore.Functions.Notify('You are already doing something', 'error', 7500) end
    QBCore.Functions.TriggerCallback("renewed-chopshop:server:CanStealPart", function(canSteal)
        local vehicle = NetworkGetEntityFromNetworkId(NetID)
        if Config.oSkullaEmotes then
            exports.scully_emotemenu:PlayByCommand("mechanic4")
        else
            TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
        end
        inProgress = true
        QBCore.Functions.Progressbar('weld_Car', 'Slashing tyre', 5000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Play When Done
            if Config.oSkullaEmotes then exports.scully_emotemenu:CancelAnimation() else ClearPedTasks(PlayerPedId()) end
            inProgress = false
            SetVehicleTyreBurst(vehicle, data.tyre, true, 1000.0)
            TriggerServerEvent('renewed-chopshop:server:StoleItem', data.bone)
        end, function() -- Play When Cancel
            inProgress = false
        end)
    end, data.bone)
end)

RegisterNetEvent('renewed-chopshop:client:ScrapCar', function()
    if inProgress then return QBCore.Functions.Notify('You are already doing something', 'error', 7500) end
    inProgress = true
    if Config.oSkullaEmotes then
        exports.scully_emotemenu:PlayByCommand("weld")
    else
        TriggerEvent('animations:client:EmoteCommandStart', {"weld"})
    end
    QBCore.Functions.Progressbar('ScrappINgCarLulW', 'Scrapping Vehicle...', 5000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Play When Done
        if Config.oSkullaEmotes then exports.scully_emotemenu:CancelAnimation() else ClearPedTasks(PlayerPedId()) end
        inProgress = false
        TriggerServerEvent('Renewed-Chopshop:server:ScrapVehicle')
    end, function() -- Play When Cancel
        inProgress = false
    end)
end)

local function CloseToDoor(Entity, Ped, Bone, DoorIndex)
    if GetIsDoorValid(Entity, DoorIndex) then
        local pos = GetWorldPositionOfEntityBone(Entity, GetEntityBoneIndexByName(Entity, Bone))
        return #(GetEntityCoords(Ped) - pos) <= 2.0
    else
        return false
    end
end

---- ** All the QB -target Shit ---- **

local function ScrapCar()
    local DidShit = 0
    for _, v in pairs(Doors) do
        if v.busy then
            DidShit = DidShit + 1
        end
    end

    return DidShit >= 8 and true or false
end

local function requestModel(model)
	if not tonumber(model) then model = joaat(model) end
	if HasModelLoaded(model) then return model end

	if not IsModelValid(model) then
		return error(("Attempted to load invalid model (%s)"):format(model))
	end

    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(150)
    end
    return model
end

local eddiePed
local oxtemp = 0
CreateThread(function()
    local eCoords = Config.PedStart.coords
    requestModel(Config.PedStart.ped)
    Wait(50)
    eddiePed = CreatePed(0, joaat(Config.PedStart.ped), eCoords.x, eCoords.y, eCoords.z-1, eCoords.w, false, false)
    TaskStartScenarioInPlace(eddiePed, Config.PedStart.scenario, 0, true)
    FreezeEntityPosition(eddiePed, true)
    SetEntityInvincible(eddiePed, true)
    SetBlockingOfNonTemporaryEvents(eddiePed, true)
    if lib then
        ---- ** Spawn Ped ** ----
        exports.ox_target:addLocalEntity(eddiePed, {{
            name = 'renewed_chopshop_eddie',
            event = 'renewed-chopshop:client:StartJob',      
            icon = 'fa-solid fa-user-secret',
            label = 'Talk to Eddie',
            canInteract = function(entity, distance)
                return distance < 2.5 and true or false
            end
        }})
        exports.ox_target:addGlobalVehicle({
            {
                name = 'renewed_chopshop_chop_secure',
                event = 'renewed-chopshop:client:SecureCar',
                icon = 'fa-solid fa-user-secret',
                label = 'Secure Car',
                canInteract = function(entity, distance)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or Secured then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    return true
                end
            },
            {
                name = 'renewed_chopshop_chop_scrap',
                event = 'renewed-chopshop:client:ScrapCar',
                icon = 'fa-solid fa-user-secret',
                label = 'Scrap Car',
                canInteract = function(entity, distance)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or not Secured or not ScrapCar() then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    return true
                end
            },
            {
                name = 'renewed_chopshop_chop_boot',
                event = 'renewed-chopshop:client:ChopEngine',
                args = {door = 5,bone = "boot",seat = 5},
                icon = 'fa-solid fa-circle',
                bones = "boot",
                label = 'Chop Boot',
                canInteract = function(entity, distance, coords, name, bone)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or not Secured or Doors["boot"].busy then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    if IsVehicleDoorDamaged(entity, 5) == 1 then return false end
                    return true
                end
            },
            {
                name = 'renewed_chopshop_chop_engine',
                event = 'renewed-chopshop:client:ChopEngine',
                args = {door = 4,bone = "overheat",seat = 4},
                icon = 'fa-solid fa-circle',
                bones = "overheat",
                label = 'Chop Boot',
                canInteract = function(entity, distance, coords, name, bone)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or not Secured or Doors["overheat"].busy then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    if IsVehicleDoorDamaged(entity, 4) == 1 then return false end
                    return true
                end
            },
            {
                name = 'renewed_chopshop_chop_lfwheel',
                event = 'renewed-chopshop:client:ChopWheel',
                args = {tyre = 0,bone = "wheel_lf"},
                icon = 'fa-solid fa-circle',
                bones = "wheel_lf",
                label = 'Slash Tires',
                canInteract = function(entity, distance, coords, name, bone)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or not Secured or Doors["wheel_lf"].busy then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    if IsVehicleTyreBurst(entity, 0, true) then return false end
                    return true
                end
            },
            {
                name = 'renewed_chopshop_chop_lrwheel',
                event = 'renewed-chopshop:client:ChopWheel',
                args = {tyre = 4,bone = "wheel_lr"},
                icon = 'fa-solid fa-circle',
                bones = "wheel_lr",
                label = 'Slash Tires',
                canInteract = function(entity, distance, coords, name, bone)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or not Secured or Doors["wheel_lr"].busy then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    if IsVehicleTyreBurst(entity, 4, true) then return false end
                    return true
                end
            },
            {
                name = 'renewed_chopshop_chop_rfwheel',
                event = 'renewed-chopshop:client:ChopWheel',
                args = {tyre = 1,bone = "wheel_rf"},
                icon = 'fa-solid fa-circle',
                bones = "wheel_rf",
                label = 'Slash Tires',
                canInteract = function(entity, distance, coords, name, bone)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or not Secured or Doors["wheel_rf"].busy then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    if IsVehicleTyreBurst(entity, 1, true) then return false end
                    return true
                end
            },
            {
                name = 'renewed_chopshop_chop_rrwheel',
                event = 'renewed-chopshop:client:ChopWheel',
                args = {tyre = 5,bone = "wheel_rr"},
                icon = 'fa-solid fa-circle',
                bones = "wheel_rr",
                label = 'Slash Tires',
                canInteract = function(entity, distance, coords, name, bone)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or not Secured or Doors["wheel_rr"].busy then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    if IsVehicleTyreBurst(entity, 5, true) then return false end
                    return true
                end
            },
            {
                name = 'renewed_chopshop_chop_lfdoor',
                event = 'renewed-chopshop:client:ChopDoor',
                args = {door = 0,bone = "door_dside_f",seat = 0},
                icon = 'fa-solid fa-circle',
                bones = "door_dside_f",
                label = 'Chop Driver Door',
                canInteract = function(entity, distance, coords, name, bone)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or not Secured or Doors["door_dside_f"].busy then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    if IsVehicleDoorDamaged(entity, 0) == 1 then return false end
                    return true
                end
            },
            {
                name = 'renewed_chopshop_chop_rfdoor',
                event = 'renewed-chopshop:client:ChopDoor',
                args = {door = 1,bone = "door_pside_f",seat = -1},
                icon = 'fa-solid fa-circle',
                bones = "door_pside_f",
                label = 'Chop Passenger Door',
                canInteract = function(entity, distance, coords, name, bone)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or not Secured or Doors["door_pside_f"].busy then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    if IsVehicleDoorDamaged(entity, 1) == 1 then return false end
                    return true
                end
            },
            {
                name = 'renewed_chopshop_chop_lrdoor',
                event = 'renewed-chopshop:client:ChopDoor',
                args = {door = 2,bone = "door_dside_r",seat = 2},
                icon = 'fa-solid fa-circle',
                bones = "door_dside_r",
                label = 'Chop Driver Rear',
                canInteract = function(entity, distance, coords, name, bone)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or not Secured or Doors["door_dside_r"].busy then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    if IsVehicleDoorDamaged(entity, 2) == 1 then return false end
                    return true
                end
            },
            {
                name = 'renewed_chopshop_chop_rrdoor',
                event = 'renewed-chopshop:client:ChopDoor',
                args = {door = 3,bone = "door_pside_r",seat = 1},
                icon = 'fa-solid fa-circle',
                bones = "door_pside_r",
                label = 'Chop Driver Rear',
                canInteract = function(entity, distance, coords, name, bone)
                    if distance > 1.5 then return false end
                    if entity ~= NetworkGetEntityFromNetworkId(NetID) then return false end
                    if not inZone or not Secured or Doors["door_pside_r"].busy then return false end
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                    if IsVehicleDoorDamaged(entity, 3) == 1 then return false end
                    return true
                end
            }
        })
        oxtemp = exports.ox_target:addSphereZone({
            coords = vec3(Config.PartsDisassembly.x, Config.PartsDisassembly.y, Config.PartsDisassembly.z),
            radius = 0.5,
            debug = false,
            options = {
                {
                    name = 'renewed_chopshop_part_shop',
                    event = 'renewed-chopshop:client:ChopPartsMenu',
                    icon = 'Chop Parts',
                    label = 'Open Parts Menu',
                    canInteract = function(entity, distance, coords, name)
                        if distance > 1 then return false end
                        if not exports['Renewed-Weaponscarry']:isCarryingObject() then return false end
                        return true
                    end
                }
            }
        })
    else
        exports['qb-target']:AddGlobalVehicle({

            -- Secure the Vehicle --
            options = {
                {
                    icon ="fa-solid fa-car",
                    label = 'Secure Car',
                    action = function()
                        TriggerEvent('renewed-chopshop:client:SecureCar')
                    end,
                    canInteract = function(entity)
                        if inZone and not Secured and entity == NetworkGetEntityFromNetworkId(NetID) and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                            return true
                        end
                    end,
                },
                {
                    icon = "fa-solid fa-car",
                    label = 'Scrap Car',
                    action = function()
                        TriggerEvent('renewed-chopshop:client:ScrapCar')
                    end,
                    canInteract = function(entity)
                        if inZone and Secured and entity == NetworkGetEntityFromNetworkId(NetID) and ScrapCar() and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                            return true
                        end
                    end,
                },
                -- All the Vehicle Doors --
                {
                    icon = "fa-solid fa-car",
                    label = 'Chop Driver Door',
                    action = function()
                        TriggerEvent('renewed-chopshop:client:ChopDoor', {door = 0,bone = "door_dside_f",seat = 0})
                    end,
                    canInteract = function(entity)
                        if inZone and Secured and entity == NetworkGetEntityFromNetworkId(NetID) and not Doors["door_dside_f"].busy and CloseToDoor(entity, PlayerPedId(), "door_dside_f", 0) and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                            if IsVehicleDoorDamaged(entity, 0) == 1 then return false end
                            return true
                        end
                    end,
                },
                {
                    icon = "fa-solid fa-car",
                    label = 'Chop Passenger Door',
                    action = function()
                        TriggerEvent('renewed-chopshop:client:ChopDoor', {door = 1,bone = "door_pside_f",seat = 1})
                    end,
                    canInteract = function(entity)
                        if inZone and Secured and entity == NetworkGetEntityFromNetworkId(NetID) and not Doors["door_pside_f"].busy and CloseToDoor(entity, PlayerPedId(), "door_pside_f", 1) and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                            if IsVehicleDoorDamaged(entity, 1) == 1 then return false end
                            return true
                        end
                    end,
                },
                {
                    icon = "fa-solid fa-car",
                    label = 'Chop Driver Rear',
                    action = function()
                        TriggerEvent('renewed-chopshop:client:ChopDoor', {door = 2,bone = "door_dside_r",seat = 2})
                    end,
                    canInteract = function(entity)
                        if inZone and Secured and entity == NetworkGetEntityFromNetworkId(NetID) and not Doors["door_dside_r"].busy and CloseToDoor(entity, PlayerPedId(), "door_dside_r", 2) and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                            if IsVehicleDoorDamaged(entity, 2) == 1 then return false end
                            return true
                        end
                    end,
                },
                {
                    icon = "fa-solid fa-car",
                    label = 'Chop Passenger Rear',
                    action = function()
                        TriggerEvent('renewed-chopshop:client:ChopDoor', {door = 3,bone = "door_pside_r",seat = 3})
                    end,
                    canInteract = function(entity)
                        if inZone and Secured and entity == NetworkGetEntityFromNetworkId(NetID) and not Doors["door_pside_r"].busy and CloseToDoor(entity, PlayerPedId(), "door_pside_r", 3) and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                            if IsVehicleDoorDamaged(entity, 3) == 1 then return false end
                            return true
                        end
                    end,
                },
            },
            distance = 2.5,
          })
        ---- ** Spawn Ped ** ----
        exports['qb-target']:AddTargetEntity(eddiePed, {
            options = {
                {
                    event = "renewed-chopshop:client:StartJob",
                    icon = 'fa-solid fa-user-secret',
                    label = 'Talk to Eddie',
                },
            },
            distance = 2.5,
        })
        ---- ** ENGINE AND BOOTS ** ----
        exports['qb-target']:AddTargetBone("boot", {
            options = {
                {
                icon = "fa-solid fa-car",
                label = 'Chop Boot',

                action = function()
                    TriggerEvent('renewed-chopshop:client:ChopEngine', {door = 5,bone = "boot",seat = 5})
                end,

                canInteract = function(entity)
                    if inZone and Secured and not Doors["boot"].busy and entity == NetworkGetEntityFromNetworkId(NetID) and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                        if IsVehicleDoorDamaged(entity, 5) == 1 then return false end
                        return true
                    end
                end,

                }
            },
            distance = 1.5,
        })
        exports['qb-target']:AddTargetBone("overheat", {
            options = {
                {
                icon = "fa-solid fa-car",
                label = 'Chop Engine',

                action = function()
                    TriggerEvent('renewed-chopshop:client:ChopEngine', {door = 4,bone = "overheat",seat = 4})
                end,

                canInteract = function(entity)
                    if inZone and Secured and not Doors["overheat"].busy and entity == NetworkGetEntityFromNetworkId(NetID) and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                        if IsVehicleDoorDamaged(entity, 4) == 1 then return false end
                        return true
                    end
                end,

                }
            },
            distance = 1.5,
        })
        ---- ** WHEELS FOR THE CARS ** ----
        exports['qb-target']:AddTargetBone("wheel_lf", {
            options = {
                {
                icon = "fa-solid fa-car",
                label = 'Slash Tires',

                action = function()
                    TriggerEvent('renewed-chopshop:client:ChopWheel', {tyre = 0,bone = "wheel_lf"})
                end,

                canInteract = function(entity)
                    if inZone and Secured and not Doors["wheel_lf"].busy and entity == NetworkGetEntityFromNetworkId(NetID) and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                        if IsVehicleTyreBurst(entity, 0, true) then return false end
                        return true
                    end
                end,

                }
            },
            distance = 2.0,
        })
        exports['qb-target']:AddTargetBone("wheel_lr", {
            options = {
                {
                icon = "fa-solid fa-car",
                label = 'Slash Tires',

                action = function()
                    TriggerEvent('renewed-chopshop:client:ChopWheel', {tyre = 4,bone = "wheel_lr"})
                end,

                canInteract = function(entity)
                    if inZone and Secured and not Doors["wheel_lr"].busy and entity == NetworkGetEntityFromNetworkId(NetID) and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                        if IsVehicleTyreBurst(entity, 4, true) then return false end
                        return true
                    end
                end,

                }
            },
            distance = 2.0,
        })
        exports['qb-target']:AddTargetBone("wheel_rf", {
            options = {
                {
                icon = "fa-solid fa-car",
                label = 'Slash Tires',

                action = function()
                    TriggerEvent('renewed-chopshop:client:ChopWheel', {tyre = 1,bone = "wheel_rf"})
                end,

                canInteract = function(entity)
                    if inZone and Secured and not Doors["wheel_rf"].busy and entity == NetworkGetEntityFromNetworkId(NetID) and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                        if IsVehicleTyreBurst(entity, 1, true) then return false end
                        return true
                    end
                end,

                }
            },
            distance = 2.0,
        })
        exports['qb-target']:AddTargetBone("wheel_rr", {
            options = {
                {
                icon = "fa-solid fa-car",
                label = 'Slash Tires',

                action = function()
                    TriggerEvent('renewed-chopshop:client:ChopWheel', {tyre = 5,bone = "wheel_rr"})
                end,

                canInteract = function(entity)
                    if inZone and Secured and not Doors["wheel_rr"].busy and entity == NetworkGetEntityFromNetworkId(NetID) and not exports['Renewed-Weaponscarry']:isCarryingObject() then
                        if IsVehicleTyreBurst(entity, 5, true) then return false end
                        return true
                    end
                end,

                }
            },
            distance = 2.0,
        })
        exports['qb-target']:AddCircleZone("ChopShopPartsLOL", Config.PartsDisassembly, 0.5, {
                name = "ChopShopPartsLOL",
                debugPoly = false,
                useZ = true
        }, {
            options = {
            {
                type = "client",
                event = "renewed-chopshop:client:ChopPartsMenu",
                icon = "fa-solid fa-screwdriver-wrench",  
                label = 'Chop Parts',
                canInteract = function()
                    if exports['Renewed-Weaponscarry']:isCarryingObject() then
                        return true
                    end
                end,
            }
            },
            distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
        })
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if lib then
            exports.ox_target:removeGlobalVehicle({"renewed_chopshop_chop_secure", "renewed_chopshop_chop_scrap", "renewed_chopshop_chop_boot", "renewed_chopshop_chop_engine", "renewed_chopshop_chop_lfwheel","renewed_chopshop_chop_lrwheel", "renewed_chopshop_chop_rfwheel", "renewed_chopshop_chop_rrwheel", "renewed_chopshop_chop_lfdoor", "renewed_chopshop_chop_rfdoor", "renewed_chopshop_chop_lrdoor", "renewed_chopshop_chop_rrdoor"})
            exports.ox_target:removeLocalEntity(eddiePed, {'renewed_chopshop_eddie'})
            exports.ox_target:removeZone(oxtemp)
        else
            exports['qb-target']:RemoveGlobalVehicle({'Secure Car', 'Scrap Car', 'Chop Driver Door', 'Chop Passenger Door', 'Chop Driver Rear', 'Chop Passenger Rear'})
            exports['qb-target']:RemoveTargetEntity(eddiePed, "Talk to Eddie")
            exports['qb-target']:RemoveTargetBone({"boot", "overheat", "wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"}, {"Slash Tires", "Chop Engine", "Chop Boot"})
        end
    end
end)

RegisterNetEvent('renewed-chopshop:client:ChopParts', function(k)
    local model = joaat(Config.Parts[k].prop)
    local coords = Config.Parts[k].coords
    local object = CreateObject(model, coords.x, coords.y, coords.z, true, false, false)
    SetEntityHeading(object, 350)
    FreezeEntityPosition(object, true)
    PlaceObjectOnGroundProperly(object)
    Wait(1000)
    if Config.oSkullaEmotes then
        exports.scully_emotemenu:PlayByCommand("weld")
    else
        TriggerEvent('animations:client:EmoteCommandStart', {"weld"})
    end
    QBCore.Functions.Progressbar('KEKW', 'Breaking down the Part', math.random(7500, 12500), false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Play When Done
        DeleteObject(object)
        TriggerServerEvent('renewed-chopshop:server:GetParts')
    end, function() -- Play When Cancel
        DeleteObject(object)
    end)
end)

local chopMenu = {
    [1] = {
        event = "renewed-chopshop:client:ChopPartsMenu",
        menu = function()
            local menu = {}
            for k, v in pairs(Config.Parts) do
                local item = QBCore.Shared.Items[v.item]
                menu[#menu + 1] = {
                    header = item.label,
                    txt = "Break down " .. item.label.." For materials",
                    icon = "fa-solid fa-car",
                    params = {
                        isServer = true,
                        event = "renewed-chopshop:server:ChopParts",
                        args = k
                    }
                }
            end
            exports["qb-menu"]:openMenu(menu)
        end,
        lib = function()
            local menu = {}
            for k, v in pairs(Config.Parts) do
                local item = exports.ox_inventory:Items(v.item)
                menu[#menu + 1] = {
                    title = item.label,
                    metadata = {"Break down " .. item.label.." For materials"},
                    serverEvent = 'renewed-chopshop:server:ChopParts',
                    args = k,
                    icon = "fa-solid fa-car"
                }
            end
            lib.registerContext({
                id = 'renewed_chopshop_part_menu',
                title = "Part Menu",
                position = 'top-right',
                options = menu
            })
            lib.showContext("renewed_chopshop_part_menu")
        end
    },
    [2] = {
        event = "renewed-chopshop:client:StartJob",
        menu = function()
            local openMainMenu = {
                {
                    header = "Jeff The Car Plug",
                    isMenuHeader = true,
                    icon = "fa-solid fa-user-secret",
                },
            }
            QBCore.Functions.TriggerCallback('renewed-chopshop:server:HasGroupAndStarted', function(result)
                if result then
                    openMainMenu[#openMainMenu+1] = {
                        header = "Reset Job",
                        txt = "Reset your current Job",
                        icon = "fa-solid fa-car",
                        params = {
                            isServer = true,
                            event = "renewed-chopshop:server:ResetJob",
                        }
                    }
                else
                    if CurrentPD >= 0 then
                        openMainMenu[#openMainMenu+1] = {
                            header = "Request a Job",
                            txt = "Are you up for the challenge?",
                            icon = "fa-solid fa-car",
                            params = {
                                isServer = true,
                                event = "renewed-chopshop:server:Startjob",
                            }
                        }
                    else
                        openMainMenu[#openMainMenu+1] = {
                            header = "Request a Job",
                            txt = "Are you up for the challenge?",
                            icon = "fa-solid fa-car",
                            disabled = true
                        }
                    end
                    openMainMenu[#openMainMenu+1] = {
                        header = "No thanks",
                        icon = "fa-solid fa-circle-xmark",
                        params = {
                            event = "qb-menu:closeMenu",
                        }
                    }
                end
                exports["qb-menu"]:openMenu(openMainMenu)
            end)
        end,
        lib = function()
            local menu = {}
            QBCore.Functions.TriggerCallback('renewed-chopshop:server:HasGroupAndStarted', function(result)
                if result then
                    menu[#menu + 1] = {
                        title = "Reset Job",
                        metadata = {"Reset your current Job"},
                        serverEvent = 'renewed-chopshop:server:ResetJob',
                        icon = 'fa-solid fa-car'
                    }
                else
                    if CurrentPD >= 0 then
                        menu[#menu + 1] = {
                            title = "Request a Job",     
                            metadata = {"Are you up for the challenge?"},
                            serverEvent = 'renewed-chopshop:server:Startjob',
                            icon = 'fa-solid fa-car'
                        }
                    else
                        menu[#menu + 1] = {
                            title = "Request a Job",
                            metadata = {"Are you up for the challenge?"},
                            icon = 'fa-solid fa-car',
                            disabled = true
                        }
                    end
                end
                lib.registerContext({
                    id = 'renewed_chopshop_start_job',
                    title = "Jeff The Car Plug",
                    position = 'top-right',
                    options = menu
                })
                lib.showContext("renewed_chopshop_start_job")
            end)
        end
    }
}

for k=1, #chopMenu do
    RegisterNetEvent(chopMenu[k].event, lib and chopMenu[k].lib or chopMenu[k].menu)
end