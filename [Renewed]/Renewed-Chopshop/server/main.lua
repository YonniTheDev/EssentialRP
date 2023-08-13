local QBCore = exports['qb-core']:GetCoreObject()
local ChoppedParts = {}
JobActives = {}

local function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)

    return plate
end

---- ** Sersidded event to tell when the group are in the area of the car ** ----
RegisterNetEvent('renewed-chopshop:server:InCarZone', function()
    local src = source
    local group = exports['qb-phone']:GetGroupByMembers(src)

    if group and JobActives[group] then

        JobActives[group].Stages[1].isDone = true
        exports['qb-phone']:setJobStatus(group, "Chop Shop", JobActives[group].Stages)

        local temp = {
            title = "Chop Shop",
            text = "Find the Vehicle",
            icon = "fas fa-search-location",
            color = "#6699cc",
            timeout = 900000, -- 15 minutes
        }

        ChangePhoneNotis(group, temp)

        local Players = exports['qb-phone']:getGroupMembers(group)
        for k = 1, #Players do
            TriggerClientEvent('renewed-chopshop:client:DeletePolyZone', Players[k])
        end
    end
end)

---- ** Spawns the vehicle and syncs it to all clients while giving the group stages to handle.** ----
RegisterNetEvent('renewed-chopshop:server:ChopCarSpawn', function(group)
    local coords = JobActives[group].location
    local car = CreateVehicleServerSetter(joaat(JobActives[group].model), 'automobile', coords.x, coords.y, coords.z, coords.w)
    print(coords.x, coords.y, coords.z)
    while not DoesEntityExist(car) do
        Wait(10)
    end

    if DoesEntityExist(car) then
        SetVehicleDoorsLocked(car, 2)
        SetVehicleColours(car, 12, 12)

        if Config.RenewedFuel then
            exports['Renewed-Fuel']:SetFuel(car, 100.0)
        end

        exports['qb-phone']:setJobStatus(group, "Chop Shop", JobActives[group].Stages)
        local plate = GeneratePlate()
        SetVehicleNumberPlateText(car, plate)
        JobActives[group].netId = NetworkGetNetworkIdFromEntity(car)
        print('plate', plate)
        local Blip = {
            coords = JobActives[group].location,
            radius = 300.0,
            alpha = 100
        }

        exports['qb-phone']:CreateBlipForGroup(group, "Car Location", Blip)

        local MailData = {
            sender = "Eddie the Car Guy",
            subject = "Car Information",
            message = "Here's a bit more information on the car you are looking for! <br> Vehicle: " .. JobActives[group].model .. "</br> <br> Plate: " .. plate .. " </br>",
        }

        local Players = exports['qb-phone']:getGroupMembers(group)
        for k = 1, #Players do
            TriggerClientEvent('renewed-chopshop:client:EmailHandler', Players[k], MailData)
            TriggerClientEvent('renewed-chopshop:client:FindCar', Players[k], JobActives[group].netId, JobActives[group].Doors, JobActives[group].Secured, JobActives[group].location )
        end

        Wait(500)
        local temp = {
            title = "Chop Shop",
            text = "Head to the Location",
            icon = "fas fa-search-location",
            color = "#6699cc",
            timeout = 900000, -- 15 minutes
        }

        ChangePhoneNotis(group, temp)
    end
end)

---- ** Tells the server side when the group has finished the job ** ----
RegisterNetEvent('renewed-chopshop:server:CarDisassembled', function()
    local src = source
    local group = exports['qb-phone']:GetGroupByMembers(src)
    if group and JobActives[group] then
        if exports['qb-phone']:isGroupLeader(src, group) then
            JobActives[group].Stages[5] = true

            local temp = {
                title = "Chop Shop",
                text = "Chopping Successfull",
                icon = "fas fa-search-location",
                color = "#6699cc",
                timeout = 5000, -- 15 minutes
            }

            ChangePhoneNotis(group, temp)

            local Players = exports['qb-phone']:getGroupMembers(group)
            for k = 1, #Players do
                TriggerClientEvent('renewed-chopshop:client:ClientReset', Players[k])
            end

            exports['qb-phone']:resetJobStatus(group)

            JobActives[group] = nil
        end
    end
end)

---- ** Tell the server when a group has requested a job ** ----
RegisterNetEvent("renewed-chopshop:server:Startjob", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname

    local group = exports['qb-phone']:GetGroupByMembers(src) or exports['qb-phone']:CreateGroup(src, name)
    if group then
        if JobActives[group] then return TriggerClientEvent('QBCore:Notify', src, "I already gave your group a route", "error") end
        if exports["qb-phone"]:getJobStatus(group) == "WAITING" then
            if exports['qb-phone']:isGroupLeader(src, group) then
                local car = AvailableCars()
                if car then
                    JobActives[group] = {
                        location = car,
                        model = GetRandomCar(),
                        Secured = false,
                        Dissasembly = nil,
                        Doors = {
                            ["boot"] =          { busy = false, stolen = false },
                            ["overheat"] =      { busy = false, stolen = false },
                            ["door_dside_f"] =  { busy = false, stolen = false },
                            ["door_dside_r"] =  { busy = false, stolen = false },
                            ["door_pside_f"] =  { busy = false, stolen = false },
                            ["door_pside_r"] =  { busy = false, stolen = false },
                            ["wheel_lf"] =      { busy = false, stolen = false },
                            ["wheel_lr"] =      { busy = false, stolen = false },
                            ["wheel_rf"] =      { busy = false, stolen = false },
                            ["wheel_rr"] =      { busy = false, stolen = false },
                        },

                        Stages = {
                            [1] = {name = "Head to the area located on your GPS", isDone = false , id = 1},
                            [2] = {name = "Find the vehicle I emailed you!", isDone = false , id = 2},
                            [3] = {name = "Head to the scrapping location marked on your GPS!", isDone = false , id = 3},
                            [4] = {name = "Dissasemble the vehicle for parts!", isDone = false , id = 4},
                            [5] = {name = "Break down the rest of the car to get rid of the evidence!", isDone = false , id = 4},
                            [6] = {name = "Get out of there before you get seen!", isDone = false , id = 5},
                        }
                    }

                    TriggerEvent('renewed-chopshop:server:ChopCarSpawn', group)
                else
                    TriggerClientEvent('QBCore:Notify', src, "I do not have a job for you currently...", "error")
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Your group is already doing a job!", "error")
        end
    end
end)

---- ** Tells the server side when the group has found the car ** ----
RegisterNetEvent('renewed-chopshop:server:CarFound', function()
    local src = source
    local group = exports['qb-phone']:GetGroupByMembers(src)
    if group and JobActives[group] and not JobActives[group].Dissasembly then
        JobActives[group].Stages[2].isDone = true
        exports['qb-phone']:setJobStatus(group, "Chop Shop", JobActives[group].Stages)

        local temp = {
            title = "Chop Shop",
            text = "Head to the chopping Location",
            icon = "fas fa-search-location",
            color = "#6699cc",
            timeout = 900000, -- 15 minutes
        }
        ChangePhoneNotis(group, temp)

        exports['qb-phone']:RemoveBlipForGroup(group, "Car Location")

        local i = math.random(1, #Config.Disassembly)

        JobActives[group].Dissasembly = Config.Disassembly[i].coords

        local Blip = {
            coords = JobActives[group].Dissasembly,
            label = "Dissasembly Lot",
            sprite = 326,
            route = true,
            routeColor = 26
        }

        exports['qb-phone']:CreateBlipForGroup(group, "Dissasembly Lot", Blip)
        local Players = exports['qb-phone']:getGroupMembers(group)
        for k = 1, #Players do
            TriggerClientEvent('renewed-chopshop:client:GeneratePolyZone', Players[k], i)
        end
        if not Config.RenewedFuel then
            TriggerClientEvent('renewed-chopshop:client:CarFound', src)
        end
    end
end)

---- ** Tells the server when the group has arrived on location to update their apps ** ----
RegisterNetEvent('renewed-chopshop:server:ArrivedAtLocation', function()
    local src = source
    local group = exports['qb-phone']:GetGroupByMembers(src)
    if group and JobActives[group] then
        JobActives[group].Stages[3].isDone = true
        exports['qb-phone']:setJobStatus(group, "Chop Shop", JobActives[group].Stages)
        exports['qb-phone']:RemoveBlipForGroup(group, "Dissasembly Lot")
        local temp = {
            title = "Chop Shop",
            text = "Start Chopping",
            icon = "fas fa-search-location",
            color = "#6699cc",
            timeout = 900000, -- 15 minutes
        }

        ChangePhoneNotis(group, temp)
    end
end)

---- ** Event that gives the items when a part has been chopped ** ----
RegisterNetEvent('renewed-chopshop:server:StoleItem', function(part)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local group = exports['qb-phone']:GetGroupByMembers(src)
    if group then
        if JobActives[group].Doors[part].busy and not JobActives[group].Doors[part].stolen then
            local item = nil
            if not JobActives[group].Stages[4].isDone then JobActives[group].Stages[4].isDone = true exports['qb-phone']:setJobStatus(group, "Chop Shop", JobActives[group].Stages) end
            JobActives[group].Doors[part].stole = true
            if part == "door_dside_f" or part == "door_dside_r" or part == "door_pside_f" or part == "door_pside_r" then
                item = "carpart_door"
            elseif part == "boot" then
                item = "carpart_trunk"
            elseif part == "overheat" then
                item = "carpart_hood"
            elseif part == "wheel_lf" or part == "wheel_lr" or part == "wheel_rf" or part == "wheel_rr" then
                item = "carpart_wheel"
            end

            Player.Functions.AddItem(item, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
        end
    end
end)

---- ** Tells the server that the group has now successfully secured the vehicle and it can sync it for all users ** ----
RegisterNetEvent('renewed-chopshop:server:SecuredCar', function()
    local src = source
    local group = exports['qb-phone']:GetGroupByMembers(src)
    if group then
        if JobActives[group].Secured then
            GroupSync(group, nil, JobActives[group].Secured, pos)
        end
    end
end)

---- ** Callbacks to tell when a user wants to do xyz event ** ----
QBCore.Functions.CreateCallback("renewed-chopshop:server:CanStealPart", function(source, cb, part)
    local src = source
    local group = exports['qb-phone']:GetGroupByMembers(src)
    if group then
        if JobActives[group] and not JobActives[group].Doors[part].busy then
            JobActives[group].Doors[part].busy = true
            GroupSync(group, part, false)
            cb(JobActives[group].Doors[part].busy)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback("renewed-chopshop:server:CanSecureCar", function(source, cb)
    local src = source
    local group = exports['qb-phone']:GetGroupByMembers(src)
    if group then
        if JobActives[group] then
            if not JobActives[group].Secured then
                local car = NetworkGetEntityFromNetworkId(JobActives[group].netId)
                FreezeEntityPosition(car, true)
                JobActives[group].Secured = true
                cb(true)
            else
                TriggerClientEvent('QBCore:Notify', src, "Someone has already secured the vehicle!", "error")
                cb(false)
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You are not in a group!", "error")
        cb(false)
    end
end)

RegisterNetEvent('renewed-chopshop:server:ChopParts', function(k)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(Config.Parts[k].item, 1) then
        ChoppedParts[src] = k
        TriggerClientEvent('renewed-chopshop:client:ChopParts', src, k)
    end
end)

RegisterNetEvent('renewed-chopshop:server:GetParts', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if ChoppedParts[src] then
        for k, v in pairs(Config.Parts[ChoppedParts[src]].reward) do
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], "add")
            Player.Functions.AddItem(k, math.random(v.min, v.max))
        end
        ChoppedParts[src] = nil
    end
end)

QBCore.Functions.CreateCallback("renewed-chopshop:server:HasGroupAndStarted", function(source, cb)
    local group = exports['qb-phone']:GetGroupByMembers(source)
    if group and exports["qb-phone"]:getJobStatus(group) ~= "WAITING" then
        cb(true)
    else
        cb(false)
    end
end)

local function WaitReset(group)
    SetTimeout((math.random(10, 30) * 1000), function()
        exports['qb-phone']:resetJobStatus(group)
        JobActives[group] = nil
        if exports['qb-phone']:isGroupTemp(group) then
            exports['qb-phone']:DestroyGroup(group)
        end
    end)
end

RegisterNetEvent('Renewed-Chopshop:server:ScrapVehicle', function()
    local src = source
    local group = exports['qb-phone']:GetGroupByMembers(src)
    if group and JobActives[group] then
        if exports['qb-phone']:isGroupLeader(src, group) then
            local Player = QBCore.Functions.GetPlayer(src)
            JobActives[group].Stages[5].isDone = true

            local temp = {
                title = "Chop Shop",
                text = "Chopping Successfull",
                icon = "fas fa-search-location",
                color = "#6699cc",
                timeout = 5000, -- 5 seconds
            }

            ChangePhoneNotis(group, temp)

            local Players = exports['qb-phone']:getGroupMembers(group)
            for k = 1, #Players do
                TriggerClientEvent('renewed-chopshop:client:ClientReset', Players[k])
            end

            local car = NetworkGetEntityFromNetworkId(JobActives[group].netId)
            if DoesEntityExist(car) then
                DeleteEntity(car)

                exports['qb-phone']:setJobStatus(group, "Chop Shop", JobActives[group].Stages)

                
                local payout = math.random(Config.CashReward.min, Config.CashReward.max)
                Player.Functions.AddMoney('cash', payout, 'chopshop-reward')


                for k, v in pairs(Config.CarReward) do
                    Player.Functions.AddItem(k, math.random(v.min, v.max))
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], "add")
                end

              
        

                WaitReset(group)
            end
        end
    end
end)

AddEventHandler('qb-phone:server:GroupDeleted', function(group, players)
    if not JobActives[group] then return end
    JobActives[group] = nil
    for i=1, #players do
        TriggerClientEvent("renewed-chopshop:client:ClientReset", players[i])
    end
end)
