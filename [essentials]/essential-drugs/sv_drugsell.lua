local QBCore = exports[Config.Core]:GetCoreObject()

QBCore.Functions.CreateCallback('essential-drugs:server:GetCops', function(source, cb)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if (v.PlayerData.job.name == "police" or v.PlayerData.job.name == "bcso") and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

function GetDeliveryCops()
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
                amount = amount + 1
            end
        end
	end
    return amount
end

RegisterNetEvent('essential-drugs:initiatedrug', function(cad)	
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then
		local price = cad.price * cad.amt
		if Config.GiveBonusOnPolice then
			local copsamount = GetDeliveryCops()
			if copsamount > 0 and copsamount < 3 then
				price = price * 1.2
			elseif copsamount >= 3 and copsamount <= 6 then
				price = price * 1.5
			elseif copsamount >= 7 and copsamount <= 10 then
				price = price * 2.0            
			end
		end
		price = math.floor(price)
		if Config.Inventory == 'ox' then
			local item = exports.ox_inventory:GetItem(src, tostring(cad.item), nil, true)
			if item and item >= cad.amt then
				exports.ox_inventory:RemoveItem(src, tostring(cad.item), cad.amt)
				Player.Functions.AddMoney("cash", price)
				TriggerClientEvent('essential-drugs:notify', src, 'You recieved $'..price)
				if Config.Debug then print('You got '..cad.amt..' '..cad.item..' for $'..price) end
			else
				TriggerClientEvent('essential-drugs:notify', src, 'You could not sell your '..cad.item..'!')
			end
		else
			if Player.Functions.GetItemByName(tostring(cad.item)) then
				if Player.Functions.RemoveItem(tostring(cad.item), cad.amt) then
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[tostring(cad.item)], "remove", cad.amt)
					Player.Functions.AddMoney("cash", price)
					TriggerClientEvent('essential-drugs:notify', src, 'You recieved $'..price)
					if Config.Debug then print('You got '..cad.amt..' '..cad.item..' for $'..price) end
				else
					TriggerClientEvent('essential-drugs:notify', src, 'You could not sell your '..cad.item..'!')
				end
			else
				TriggerClientEvent('essential-drugs:notify', src, 'You do not have any '..cad.item..' to sell!')
			end			
		end
	end
end)

if Config.ShouldToggleSelling then
	QBCore.Commands.Add("toggleselling", "Toggle selling in a zone", {}, false, function(source, _)
		TriggerClientEvent("essential-drugs:toggleselling", source)
	end)
end
