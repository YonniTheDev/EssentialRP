vehicles = {}
categories = {}

CreateThread(function()
    if Config.Core == "ESX" then
        vehicles = MySQL.query.await('SELECT * FROM vehicles')
        categories = MySQL.query.await('SELECT * FROM vehicle_categories')
    end
end)


--  ██████ ██   ██  █████  ███    ██  ██████  ███████     ██████  ██       █████  ████████ ███████ 
-- ██      ██   ██ ██   ██ ████   ██ ██       ██          ██   ██ ██      ██   ██    ██    ██      
-- ██      ███████ ███████ ██ ██  ██ ██   ███ █████       ██████  ██      ███████    ██    █████   
-- ██      ██   ██ ██   ██ ██  ██ ██ ██    ██ ██          ██      ██      ██   ██    ██    ██      
--  ██████ ██   ██ ██   ██ ██   ████  ██████  ███████     ██      ███████ ██   ██    ██    ███████
RegisterServerEvent("snipe-menu:server:changePlate", function(oldplate, newPlate)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        if Config.Core == "QBCore" then
            local IsVehicleOwned = MySQL.Sync.fetchAll('SELECT plate FROM player_vehicles WHERE plate = ?', {oldplate})

            if IsVehicleOwned[1] == nil then 
                TriggerClientEvent('QBCore:Notify', src, 'This vehicle is not owned by anyone', 'error')
                return 
            end
            local platecheck = MySQL.Sync.fetchAll('SELECT plate FROM player_vehicles WHERE plate = ?', {newPlate})

            if platecheck[1] ~= nil then 
                TriggerClientEvent("QBCore:Notify", src, "Vehicle Plate already exists!", "error") 
                return 
            end

            MySQL.Async.execute('UPDATE player_vehicles SET plate = ? WHERE plate = ?', {newPlate, oldplate})
            
            MySQL.Async.execute('UPDATE trunkitems SET plate = ? WHERE plate = ?', {newPlate, oldplate})

            MySQL.Async.execute('UPDATE gloveboxitems SET plate = ? WHERE plate = ?', {newPlate, oldplate})
            SendLogs(src, "triggered", Config.Locales["plate_change_used"]..oldplate.." to "..newPlate)
            TriggerClientEvent('snipe-menu:client:changePlate', src, newPlate)
        elseif Config.Core == "ESX" then
            local IsVehicleOwned = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE plate = ?', {oldplate})

            if IsVehicleOwned[1] == nil then 
                ShowNotification(src, 'This vehicle is not owned by anyone', "error")
                return 
            end
            local platecheck = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE plate = ?', {newPlate})

            if platecheck[1] ~= nil then 
                ShowNotification(src, "Vehicle Plate already exists!", "error")
                return 
            end

            MySQL.Async.execute('UPDATE owned_vehicles SET plate = ? WHERE plate = ?', {newPlate, oldplate})
            
            SendLogs(src, "triggered", Config.Locales["plate_change_used"]..oldplate.." to "..newPlate)
            TriggerClientEvent('snipe-menu:client:changePlate', src, newPlate)
        end
    else
        SendLogs(src, "exploit", Config.Locales["change_plate_exploit_event"])
    end
end)

--  ██████  ██ ██    ██ ███████  ██████  █████  ██████  
-- ██       ██ ██    ██ ██      ██      ██   ██ ██   ██ 
-- ██   ███ ██ ██    ██ █████   ██      ███████ ██████  
-- ██    ██ ██  ██  ██  ██      ██      ██   ██ ██   ██ 
--  ██████  ██   ████   ███████  ██████ ██   ██ ██   ██

RegisterServerEvent("snipe-menu:server:givecar", function(playerid, carname, properties, type)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        if Config.Core == "QBCore" then
            SendLogs(src, "triggered", Config.Locales["give_car_used"]..GetPlayerName(playerid).." "..carname)
            local otherPlayer = QBCore.Functions.GetPlayer(playerid)
            local cid = otherPlayer.PlayerData.citizenid
            local garageName = "pillboxgarage"
            if type == "boat" then
                garageName = "lsymc"
            elseif type == "air" then
                garageName = "intairport"
            end
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                otherPlayer.PlayerData.license,
                cid,
                carname,
                GetHashKey(carname),
                json.encode(properties.props),
                properties.props.plate,
                garageName,
                1
            })
        elseif Config.Core == "ESX" then
            local xPlayer = ESX.GetPlayerFromId(source)
            local garageType = "car"
            MySQL.insert('INSERT INTO owned_vehicles (owner, vehicle, plate, stored, type) VALUES (?, ?, ?, ?, ?)', {
                xPlayer.identifier,
                json.encode(properties.props),
                properties.props.plate,
                true,
                garageType
            })
        end
    else
        SendLogs(src, "exploit", Config.Locales["give_car_exploit_event"])
    end
end)


--  █████  ██████  ███    ███ ██ ███    ██  ██████  █████  ██████  
-- ██   ██ ██   ██ ████  ████ ██ ████   ██ ██      ██   ██ ██   ██ 
-- ███████ ██   ██ ██ ████ ██ ██ ██ ██  ██ ██      ███████ ██████  
-- ██   ██ ██   ██ ██  ██  ██ ██ ██  ██ ██ ██      ██   ██ ██   ██ 
-- ██   ██ ██████  ██      ██ ██ ██   ████  ██████ ██   ██ ██   ██
RegisterServerEvent("snipe-menu:server:addAdminCar", function(carname, properties, type)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        if Config.Core == "QBCore" then
            local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', { properties.plate })
            if result[1] == nil then
                SendLogs(src, "triggered", Config.Locales["admin_car_used"].." "..carname)
                local otherPlayer = QBCore.Functions.GetPlayer(src)
                local cid = otherPlayer.PlayerData.citizenid
                local garageName = "pillboxgarage"
                if type == "boat" then
                    garageName = "lsymc"
                elseif type == "air" then
                    garageName = "intairport"
                end
                MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                    otherPlayer.PlayerData.license,
                    cid,
                    carname,
                    GetHashKey(carname),
                    json.encode(properties),
                    properties.plate,
                    garageName,
                    1
                })
                ShowNotification(src, Config.Locales["you_own_the_car"])
            else
                ShowNotification(src, Config.Locales["car_already_owned"])
            end
        elseif Config.Core == "ESX" then
            local xPlayer = ESX.GetPlayerFromId(src)
            local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE plate = @plate', {
                ['@plate'] = properties.plate
            })
            if result[1] == nil then
                SendLogs(src, "triggered", Config.Locales["admin_car_used"].." "..carname)
                MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
                    ['@owner'] = xPlayer.identifier,
                    ['@plate'] = properties.plate,
                    ['@vehicle'] = json.encode(properties),
                })
                ShowNotification(src, Config.Locales["you_own_the_car"])
            else
                ShowNotification(src, Config.Locales["car_already_owned"])
            end
        end
    else
        SendLogs(src, "exploit", Config.Locales["admin_car_exploit"])
    end
end)

CreateCallback("snipe-menu:server:getAllVehicles", function(source, cb)
    for i = 1, #vehicles do
		local vehicle = vehicles[i]
		for j = 1, #categories do
			local category = categories[j]
			if category.name == vehicle.category then
				vehicle.categoryLabel = category.label
				break
			end
		end
	end
    cb(vehicles)
end)
