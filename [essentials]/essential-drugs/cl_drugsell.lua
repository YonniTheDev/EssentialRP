local QBCore = exports[Config.Core]:GetCoreObject()

-- \ Locals and tables
local SoldPeds = {}
local SellZone = {}
local CurrentZone = nil
local AllowedTarget = (not Config.ShouldToggleSelling)
local InitiateSellProgress = false

-- \ Create Zones for the drug sales
for k, v in pairs(Config.Zones) do
    SellZone[k] = PolyZone:Create(v.points, {
        name= k,
        minZ = v.minZ,
        maxZ = v.maxZ,
        debugPoly = Config.Debug,
    })
end

-- \ Send police alert on drug sale
local function PoliceAlert()
    TriggerEvent('ps-dispatch:client:drugsale')
	if Config.Debug then print('Police Notify Function triggered') end
end

-- \ Play five animation for both player and ped
local function PlayGiveAnim(tped)	
	local pid = PlayerPedId()	
	FreezeEntityPosition(pid, true)		
	QBCore.Functions.RequestAnimDict('mp_common')
	TaskPlayAnim(pid, "mp_common", "givetake2_a", 8.0, -8, 2000, 0, 1, 0,0,0)    
	TaskPlayAnim(tped, "mp_common", "givetake2_a", 8.0, -8, 2000, 0, 1, 0,0,0)
	FreezeEntityPosition(pid, false)	
end

-- \ Add Old Ped to table
local function AddSoldPed(entity)
    SoldPeds[entity] = true
end

--\ Check if ped is in table
local function HasSoldPed(entity)
    return SoldPeds[entity] ~= nil
end

local function TimeoutMenu(ped)
	SetTimeout(Config.SellTimeout*1000, function()
		if InitiateSellProgress then
			TriggerEvent("essential-drugs:notify", "You wasted time so the person left")
			TriggerEvent("qb-menu:client:closeMenu")
			SetPedAsNoLongerNeeded(ped)
		end
	end)
end

local function HasItem(item, amount)
	if Config.Inventory == 'ox' then
		local count = exports.ox_inventory:Search('count', item)
		return count >= amount
	elseif Config.Inventory == 'qb' then
		return exports["qb-inventory"]:HasItem(item, amount)
	else
		return QBCore.Functions.HasItem(item, amount)
	end
end

local function InitiateSell(ped, randamt)
	local AlreadySold = false
	for k, v in pairs(Config.ZoneDrugs) do
		if k == CurrentZone.name then			
			Wait(200) -- Dont Change this
			local tries = 0
			for a, b in pairs(Config.ZoneDrugs[k]) do
				local randdrug = Config.ZoneDrugs[k][math.random(1, #Config.ZoneDrugs[k])]
				local price = randdrug.price
				if not AlreadySold then
					if HasItem(randdrug.item, randamt) then					
						AlreadySold = true
						InitiateSellProgress = true
						local SaleMenu = {
							{
								header = tostring(randamt).."x of "..QBCore.Shared.Items[tostring(randdrug.item)]['label'].." for "..QBCore.Shared.Round(randamt * price, 0).."$",
								isMenuHeader = true
							},
							{
								header = "Accept Offer",
								params = {
									event = 'essential-drugs:salesinitiate',
									args = {
										type = 'buy',
										item = randdrug.item,
										price = price,
										amt = randamt,
										tped = ped
									}
								}
							},
							{
								header = "Decline Offer",							
								params = {
									event = 'essential-drugs:salesinitiate',
									args = {
										type = 'close',
										tped = ped
									}
								}
							}
						}
						exports[Config.Menu]:openMenu(SaleMenu)
						TimeoutMenu(ped)	
					else
						tries += 1
						if tries == #Config.ZoneDrugs[k] then SetPedAsNoLongerNeeded(ped) TriggerEvent('QBCore:Notify', 'Person wanted more stuff but you dont have!') end
						if Config.Debug then print('You dont have ['..b.item..'] to sell') end
					end
				end
			end
		end
	end	
end

-- \ Interact with the ped
local function InteractPed(ped)
	local Playerjob = QBCore.Functions.GetPlayerData().job
	SetEntityAsMissionEntity(ped)
	TaskTurnPedToFaceEntity(ped, PlayerPedId(), Config.SellTimeout*1000)
	Wait(500)	
	if Playerjob.name == 'police' then
		TriggerEvent('QBCore:Notify', 'Locals hate cops!')
		SetPedAsNoLongerNeeded(ped)
		if Config.Debug then print('Police Not allowed') end
		return
	end
	local percent = math.random(1, 100)
	local randomamt = math.random(Config.RandomMinSell, Config.RandomMaxSell)
	if percent < Config.ChanceSell then
		InitiateSell(ped, randomamt)
	else
		local copPercent = math.random(1, 100)
		if copPercent < Config.CopCallChance then
			if Config.Debug then print('Police has been notified') end
			QBCore.Functions.Notify('Not Interested!', 'error')
			TaskUseMobilePhoneTimed(ped, 8000)
			PoliceAlert()
			SetPedAsNoLongerNeeded(ped)
		else
			QBCore.Functions.Notify('Not Interested!', 'error')
		end
	end	
end

-- \ Initialize the drug sales
local function InitiateSales(entity)
	QBCore.Functions.TriggerCallback('essential-drugs:server:GetCops', function(result)
		if result < Config.MinimumCops then
			TriggerEvent('essential-drugs:notify', 'Buyer is not interested to buy now!')			
			if Config.Debug then print('Not Enough Cops') end
		else
			local CurrentPedID = PedToNet(entity)			
			local isSoldtoPed = HasSoldPed(CurrentPedID)
			if isSoldtoPed then TriggerEvent('essential-drugs:notify', 'You already spoke with this local') return false end
			AddSoldPed(CurrentPedID)
			InteractPed(entity)
			if Config.Debug then print('Drug Sales Initiated now proceding to interact') end
		end
	end)	
end

-- \ Blacklist Ped Models
function isPedBlacklisted(ped)
	local model = GetEntityModel(ped)
	for i = 1, #Config.BlacklistPeds do
		if model == GetHashKey(Config.BlacklistPeds[i]) then
			return true
		end
	end
	return false
end

-- \ Sell Drugs to peds inside the sellzone
local function CreateTarget()
	exports[Config.Target]:AddGlobalPed({
		options = {
			{                			
				icon = 'fas fa-comments',
				label = 'Speak To Ped...',
				action = function(entity)
					InitiateSales(entity)
				end,
				canInteract = function(entity)
					if CurrentZone then
						if not IsPedDeadOrDying(entity) and not IsPedInAnyVehicle(entity) and CurrentZone.inside and (GetPedType(entity)~=28) and (not IsPedAPlayer(entity)) and (not isPedBlacklisted(entity)) and not IsPedInAnyVehicle(PlayerPedId()) then
							return true
						end         						
					end					 
					return false
				end,        
			}
		},
		distance = 2.5,
	})
end
exports('CreateTarget', CreateTarget)

-- \ Remove Sell Drugs to peds inside the sellzone
local function RemoveTarget()
	exports[Config.Target]:RemoveGlobalPed({"Talk"})
end
exports('RemoveTarget', RemoveTarget)

-- \ This will toggle allowing/disallowing target even if inside zone
local function AllowedTarget(value)
	AllowedTarget = value
end
exports('AllowedTarget', AllowedTarget)

-- \ Notify event for client/server
RegisterNetEvent('essential-drugs:notify', function(msg)
	if Config.Debug then print('Notify:'..msg) end
	TriggerEvent('QBCore:Notify', msg, "primary", 5000)
end)

-- \ event handler to server (execute server side)
RegisterNetEvent('essential-drugs:salesinitiate', function(cad)
	if cad.type == 'close' then
		InitiateSellProgress = false
		TriggerEvent("essential-drugs:notify", "You rejected the offer")
		TriggerEvent("qb-menu:client:closeMenu")
		SetPedAsNoLongerNeeded(cad.tped)
	else
		InitiateSellProgress = false
		PlayGiveAnim(cad.tped)
		TriggerServerEvent("essential-drugs:initiatedrug", cad)
		SetPedAsNoLongerNeeded(cad.tped)
	end
end)

-- \ Toggle selling (radialmenu)
RegisterNetEvent('essential-drugs:toggleselling', function()
	if Config.ShouldToggleSelling then
		AllowedTarget = not AllowedTarget
		if AllowedTarget then
			CreateTarget()
			TriggerEvent("essential-drugs:notify", "Enabled Selling")
		else
			RemoveTarget()
			TriggerEvent("essential-drugs:notify", "Disabled Selling")
		end
	else
		TriggerEvent("essential-drugs:notify", "Option disabled")
	end
end)

-- \ Check if inside sellzone
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local coord = GetEntityCoords(Ped)
		if Ped and coord and SellZone and next(SellZone) ~= nil then
			for k, v in pairs(SellZone) do
				if SellZone[k] then
					if SellZone[k]:isPointInside(coord) then						
						SellZone[k].inside = true
                        CurrentZone = SellZone[k]	
						if not SellZone[k].target then
							SellZone[k].target = true
							if not Config.ShouldToggleSelling then CreateTarget() end
							if Config.Debug then print("Target Added ["..CurrentZone.name.."]") end
						end
						if Config.Debug then print(json.encode(CurrentZone)) end
					else										
						SellZone[k].inside = false
						if SellZone[k].target then
							SellZone[k].target = false
							if not Config.ShouldToggleSelling then RemoveTarget() end
							if Config.Debug then print("Target Removed ["..CurrentZone.name.."]") end
						end
					end
				end
			end
		end
		Wait(1000)
	end
end)