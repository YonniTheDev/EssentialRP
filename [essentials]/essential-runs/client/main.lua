local QBCore = exports['qb-core']:GetCoreObject()

zoneEntered = false
deliveries = 0
gettingBox = false
amountOfBox = 0
gettingVehicle = false
Delivered = false
holdingBox = false
OxyItem = false
doingOxy = false
atOxy = false
currentCars = 0
currentBoxes = 0
local Boss = nil
local Routes = 1
local car = 0
local spawnedPeds = {}
local oxyVeh
local oxyPed
local CurrentCops = 0
local routesFull = false

-- Cop Minimum Amount

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

-- Ped Creation
function SetupOxyBoss()
	BossHash = Config.BossPed[math.random(#Config.BossPed)]
	loc = Config.BossLocation[math.random(#Config.BossLocation)]
	QBCore.Functions.LoadModel(BossHash)
    local Boss = CreatePed(0, BossHash, loc.x, loc.y, loc.z-1.0, loc.w, false, false)
    SetPedFleeAttributes(Boss, 0, 0)
    SetPedDiesWhenInjured(Boss, false)
    TaskStartScenarioInPlace(Boss, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    SetPedKeepTask(Boss, true)
    SetBlockingOfNonTemporaryEvents(Boss, true)
    SetEntityInvincible(Boss, true)
    FreezeEntityPosition(Boss, true)
end

CreateThread(function()
    SetupOxyBoss()
end)

CreateThread(function()
    while true do
        if LocalPlayer.state['isLoggedIn'] then
            local player = PlayerPedId()
			if Config.Core == 'new' then
				OxyItem = exports[Config.Inventory]:HasItem(Config.Item, 1)
				elseif Config.Core == 'old' then
				OxyItem = QBCore.Functions.HasItem(Config.Item, 1)
			end
            if OxyItem then
                if not holdingBox then
					if Config.ForceAnimation then
                    holdingBox = true
                    LoadAnim('anim@heists@box_carry@')
                    TaskPlayAnim(player, 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                    CarryAnimation()
                    QBCore.Functions.LoadModel(`hei_prop_heist_box`)
                    OxyBox = CreateObject(`hei_prop_heist_box`, 0, 0, 0, true, true, true)
                    AttachEntityToEntity(OxyBox, player, GetPedBoneIndex(player, 0xEB95), 0.075, -0.10, 0.255, -130.0, 105.0, 0.0, true, true, false, false, 0, true)
                    DisableControls()
					end
                end
            elseif holdingBox then
				if Config.ForceAnimation then
                ClearPedTasks(player)
                DeleteEntity(OxyBox)
				hasItem = false
                holdingBox = false
				end
            end
        end
        Wait(1000)
    end
end)

function DisableControls()
    CreateThread(function ()
        while holdingBox do
            DisableControlAction(0, 21, true) -- Sprinting
            DisableControlAction(0, 22, true) -- Jumping
            DisableControlAction(0, 23, true) -- Vehicle Entering
            DisableControlAction(0, 36, true) -- Ctrl
			DisableControlAction(0, 24, true) -- disable attack
			DisableControlAction(0, 25, true) -- disable aim
			DisableControlAction(0, 47, true) -- disable weapon
			DisableControlAction(0, 58, true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 142, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
            Wait(1)
        end
    end)
end

function CarryAnimation()
    CreateThread( function ()
        while holdingBox do
            if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
                TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
            end
            Wait(1000)
        end
    end)
end

-- Target Exports
CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.BossPed, {
        options = {
            {
				type = "client",
				event = "essential-runs:client:start",
				icon = "fas fa-circle",
				label = Lang:t("target.oxyboss"),
            },
        },
        distance = 3.0
    })

end)

-- Blip Creation
CreateThread(function()
    if Config.Blip.Enable then
        local blip = AddBlipForCoord(Config.Blip.Location)
        SetBlipSprite(blip, Config.Blip.Sprite)
        SetBlipDisplay(blip, Config.Blip.Display)
        SetBlipScale(blip, Config.Blip.Scale)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, Config.Blip.Colour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Blip.Name)
        EndTextCommandSetBlipName(blip)
    end
end)

-- Police Alert
function policeAlert()
	exports['ps-dispatch']:DrugSale()
end

-- Start!
RegisterNetEvent('essential-runs:client:start', function ()
    QBCore.Functions.TriggerCallback("essential-runs:server:getCops", function(enoughCops)
        if enoughCops >= Config.MinimumPolice then
            QBCore.Functions.TriggerCallback("essential-runs:server:coolc",function(isCooldown)
				if isCooldown then
					QBCore.Functions.Notify(Lang:t("error.someone_recently_did_this"), 'error')
				else
					if Config.EnableAnimation then
						TriggerEvent('animations:client:EmoteCommandStart', {Config.Animation})
					end
				QBCore.Functions.Progressbar("search_register", Lang:t("progress.talking_to_boss"), 5000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
				}, {}, {}, function() -- Done
					if Config.EnableAnimation then
						TriggerEvent('animations:client:EmoteCommandStart', {"c"})
					end

		            if not routesFull then
						TriggerServerEvent('essential-runs:server:startr')
					end
				end, function() -- Cancel
					if Config.EnableAnimation then
						TriggerEvent('animations:client:EmoteCommandStart', {"c"})
					end
					QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
				end)
            end
		end)
        else
            QBCore.Functions.Notify(Lang:t("error.cannot_do_this_right_now"), 'error')
        end
    end)
end)

-- Car Events
function WaitTaskToEnd(ped, task)
	while GetScriptTaskStatus(ped, task) == 0 do
		Wait(250)
	end
	while GetScriptTaskStatus(ped, task) == 1 do
		Wait(250)
	end
end

RegisterNetEvent("essential-runs:createOxyVehicle")
AddEventHandler("essential-runs:createOxyVehicle", function(route)
	local loc = Config.Routes[route].locations
	local oxyVehicleModel = GetHashKey(Config.Cars[math.random(1,#Config.Cars)])
	local heading = Config.Routes[route].info.startHeading

	if IsModelValid(oxyVehicleModel) then
		if IsThisModelACar(oxyVehicleModel) then
			RequestModel(oxyVehicleModel)
			while not HasModelLoaded(oxyVehicleModel) do
				Wait(1)
			end

			if not DoesEntityExist(oxyVeh) then
				oxyVeh = CreateVehicle(oxyVehicleModel, loc[1].pos.x,loc[1].pos.y,loc[1].pos.z, heading, true, false)
				SetEntityAsMissionEntity(oxyVeh, true, true)
				SetVehicleEngineOn(oxyVeh, true, true, false)
				SetModelAsNoLongerNeeded(oxyVehicleModel)
				SetHornEnabled(oxyVeh, true)
				StartVehicleHorn(oxyVeh, 1000, GetHashKey("NORMAL"), false)
			end
		end
	end
	local model = GetHashKey(Config.DriverPed)

	if DoesEntityExist(oxyVeh) then
		if IsModelValid(model) then
			RequestModel(model)
			while not HasModelLoaded(model) do
				Wait(1)
			end

			oxyPed = CreatePedInsideVehicle(oxyVeh, 26, model, -1, true, false)
			SetAmbientVoiceName(oxyPed, "A_M_M_EASTSA_02_LATINO_FULL_01")
			SetBlockingOfNonTemporaryEvents(oxyPed, true)
			SetEntityAsMissionEntity(oxyPed, true, true)

			SetModelAsNoLongerNeeded(model)

		end
	end
	while not DoesEntityExist(oxyVeh) do
		Wait(1)
	end
	while not DoesEntityExist(oxyPed) do
		Wait(1)
	end
	RollDownWindows(oxyVeh)
	Wait(50)
	TaskVehicleDriveToCoordLongrange(oxyPed, oxyVeh, loc[2].pos.x,loc[2].pos.y,loc[2].pos.z, 7.5, Config.DriveStyle, 4.0)
	SetPedKeepTask(oxyPed, true)
	WaitTaskToEnd(oxyPed, 567490903)
	exports['qb-target']:AddTargetEntity(oxyVeh, {
		options = {
			{
				type = "client",
				event = "essential-runs:client:deliverPackage",
				icon = "fas fa-hand-holding",
				label = Lang:t("target.handoff_package"),
			},
		},
		distance = 3.0
	})
end)

AddEventHandler("essential-runs:deleteOxyVehicle", function(ped, veh, route)
	SetPedKeepTask(ped, false)
	loc = Config.Routes[route].locations
	TaskVehicleDriveToCoordLongrange(oxyPed, oxyVeh, loc[3].pos.x,loc[3].pos.y,loc[3].pos.z, 7.5, Config.DriveStyle, 4.0)
	Wait(Config.MinTimeBetweenCars*800)
	DeleteEntity(oxyPed)
	DeleteEntity(oxyVeh)
end)

-- Hand in Packages
RegisterNetEvent("essential-runs:client:deliverPackage")
AddEventHandler("essential-runs:client:deliverPackage", function()
	if holdingBox then
		exports['qb-target']:RemoveTargetEntity(oxyVeh, Lang:t("target.handoff_package"))
		if not Config.ForceAnimation then
		holdingBox = false
		end
		TriggerEvent("essential-runs:deleteOxyVehicle",oxyPed,oxyVeh, Routes)
		if currentCars <= deliveries then
			currentCars = currentCars + 1
			TriggerEvent('QBCore:Notify', 'Good Job, (' .. currentCars .. '/' .. deliveries .. ')')
			if math.random(1,100) <= Config.CallCopsChance then
				policeAlert()
			end
		end

		if not Config.ForceAnimation then
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		end
		TriggerServerEvent("essential-runs:server:deliver")
		Delivered = true
		Wait(1000)
		Delivered = false
		if currentCars == deliveries then
			TriggerEvent("essential-runs:client:endOxy")
			return
		end
		Wait(Config.MinTimeBetweenCars*1200, Config.MaxTimeBetweenCars*1200)
		TriggerEvent("essential-runs:createOxyVehicle",Routes)
	else
		QBCore.Functions.Notify(Lang:t("error.no_package"), 'error')
	end
end)

RegisterNetEvent("essential-runs:client:hasPackage")
AddEventHandler("essential-runs:client:hasPackage", function()
	local ped = PlayerPedId()

	if not Config.ForceAnimation then
	QBCore.Functions.TriggerCallback('essential-runs:server:hasPackage', function(hasItems)
		if hasItems then
			TriggerEvent('animations:client:EmoteCommandStart', {"box"})
			holdingBox = true
		elseif holdingBox and not hasItems then
			Wait(250)
			TriggerEvent('animations:client:EmoteCommandStart', {"c"})
			holdingBox = false
		   end
		end)
	end
end)

Citizen.CreateThread(function()
    while true do
		Wait(0)
		if gettingVehicle then
			if IsPedInAnyVehicle(PlayerPedId(), false) then
				if Config.ForceAnimation then
				onRun = true
				end
				gettingVehicle = false
				QBCore.Functions.Notify(Lang:t("success.suppliers_position"), 'success')
				loc = Config.PickUpLocations[math.random(#Config.PickUpLocations)]
				oxyBlip = AddBlipForCoord(loc.x, loc.y, loc.z)
				SetBlipSprite(oxyblip, 1)
				SetBlipColour(oxyBlip, Config.OxySupplierColour)
				SetBlipRoute(oxyBlip, Config.OxySupplierRoute)
				SpawnSupplier()
			end
		end
	end
end)

function SpawnSupplier()
    local SupplierHash = Config.SupplierPeds[math.random(#Config.SupplierPeds)]
    QBCore.Functions.LoadModel(SupplierHash)
    Supplier = CreatePed(0, SupplierHash, loc.x, loc.y, loc.z-1.0, loc.w, false, true)
	pedprop = CreateObject(`prop_cs_cardbox_01`, 0, 0, 0, false, true, true)
    FreezeEntityPosition(Supplier, true)
    SetEntityInvincible(Supplier, true)
	SetPedKeepTask(Supplier, true)
    SetBlockingOfNonTemporaryEvents(Supplier, true)
	AttachEntityToEntity(pedprop, Supplier, GetPedBoneIndex(Supplier, 0xEB95), 0.075, -0.10, 0.255, -130.0, 105.0, 0.0, true, true, false, false, 0, true)
    LoadAnim('anim@heists@box_carry@')
    TaskPlayAnim(Supplier, 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
end 

CreateThread(function()
	if Config.ForceAnimation then
	exports['qb-target']:AddTargetModel(Config.SupplierPeds, {
		options = {
			{
				type = "client",
				event = "essential-runs:client:getBox",
				icon = "fas fa-box",
				label = Lang:t("target.oxysupplier"),
				canInteract = function()
					if not holdingBox then return true else return false end 
				end
			},
		},
		distance = 2.0
	})
else 
	exports['qb-target']:AddTargetModel(Config.SupplierPeds, {
		options = {
			{
				type = "client",
				event = "essential-runs:client:getBox",
				icon = "fas fa-box",
				label = Lang:t("target.oxysupplier"),
			},
		},
		distance = 2.0
	})
end
end)

RegisterNetEvent('essential-runs:client:SetOccupied', function(route)
	Config.Routes[route].info.occupied = true
end)

RegisterNetEvent('essential-runs:client:sendToOxy', function()

	deliveries = math.random(Config.MinDeliveries, Config.MaxDeliveries)
	Routes = math.random(1, #Config.Routes)
	local totalCount = #Config.Routes + 1

	local trueCount = 1
	for _,v1 in pairs(Config.Routes) do
		if Config.Routes[_].info.occupied == true then
			trueCount = trueCount + 1
		end
	end


	if trueCount == totalCount then
		QBCore.Functions.Notify(Lang:t("error.occupied_routes"), 'error')
		routesFull = true
	else
		if Config.Routes[Routes].info.occupied == true then
			repeat
				Routes = math.random(1, #Config.Routes)
			until(Config.Routes[Routes].info.occupied == false)
		end

		TriggerServerEvent('essential-runs:server:SetOccupied', Routes)
		Config.Routes[Routes].info.occupied = true

		exports['qb-target']:RemoveTargetModel(Config.BossPed, {
			Lang:t("target.oxyboss"),
		})

		TriggerServerEvent('essential-runs:server:TakeMoney', src)
		local carRoute = Config.Routes[Routes]

		gettingBox = true
		gettingVehicle = true
		TriggerEvent('essential-runs:client:email')
		routesFull = false
	end
end)



RegisterNetEvent('essential-runs:client:getBox', function()
	if not holdingBox then
	if gettingBox then
		amountOfBox = deliveries
		QBCore.Functions.TriggerCallback('essential-runs:server:canCarry', function(canCarry)
			if canCarry then
				if currentBoxes < amountOfBox then
					currentBoxes = currentBoxes + 1
					TriggerEvent('QBCore:Notify', '('.. currentBoxes .. '/' .. amountOfBox .. ')')
					if currentBoxes == amountOfBox then
						RemoveBlip(oxyBlip)
						QBCore.Functions.Notify(Lang:t("success.location_marked"), 'success')
						DeleteEntity(pedprop)
						ClearPedTasks(Supplier)
                        Wait(500)
                        SetPedAsNoLongerNeeded(Supplier)
						TriggerEvent("essential-runs:client:startOxy")
						gettingBox = false
					    end
					end
				end
			end)
		end
	else
		QBCore.Functions.Notify(Lang:t("error.does_not_speak"), 'error')
	end
end)


RegisterNetEvent('essential-runs:client:startOxy', function()
	local carRoute = Config.Routes[Routes]
	local carRoute = carRoute
	position = carRoute.locations[2].pos

	doingOxy = true
	oxyBlip = AddBlipForCoord(position)
	SetBlipSprite(oxyblip, 1)
	SetBlipColour(oxyBlip, Config.OxyRouteColour)
	SetBlipRoute(oxyBlip, Config.OxyRouteGPS)
end)

RegisterNetEvent('essential-runs:client:sendCar', function()
	if doingOxy and atOxy then
		TriggerServerEvent("essential-runs:server:sendCar", Routes)
	end
end)

RegisterNetEvent('essential-runs:client:endOxy', function()
	Config.Routes[Routes].info.occupied = false

	exports['qb-target']:AddTargetModel(Config.BossPed, {
        options = {
            {
				type = "client",
				event = "essential-runs:client:start",
				icon = "fas fa-circle",
				label = Lang:t("target.oxyboss"),
            },
        },
        distance = 3.0
    })

	currentCars = 0
	doingOxy = false
	atOxy = false
	Routes = 0
	currentBoxes = 0
	Delivered = false
	zoneEntered = false
	amountOfBox = 0
	deliveries = 0

	if Config.SendEmail then
	TriggerEvent('essential-runs:client:endemail')
	end

	RemoveBlip(oxyBlip)
end)

AddEventHandler('onClientResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
	  return
	end

	RemoveBlip(oxyBlip)
	for route = 1, #Config.Routes do
		local curr = Config.Routes[route]
		local curr = curr
		local position = curr.locations[2].pos

		DropZone = BoxZone:Create(vector3(position.x, position.y, position.z), 20.0, 20.0, {
			name="AtOxy",
			heading=335.31,
			minZ=position.z-10,
			maxZ=position.z+5,
			debugPoly = Config.OxyRunDebug
        })
		DropZone:onPlayerInOut(function(isPointInside)
			if isPointInside then
				atOxy = true
				if doingOxy and atOxy and not zoneEntered then
					TriggerEvent("essential-runs:client:sendCar")
					QBCore.Functions.Notify(Lang:t("success.you_have_arrived"), 'success')
					zoneEntered = true
				end
			end
		end)
	end
end)

-- E-Mail Creation
RegisterNetEvent('essential-runs:client:email', function() 
	if Config.SendEmail then
		QBCore.Functions.Notify(Lang:t("success.send_email_right_now"), 'success')
	RunStart()
	else
		QBCore.Functions.Notify(Lang:t("success.start_run"), 'success')
	end
end)

function RunStart()
	Citizen.Wait(2000)
	TriggerServerEvent('qb-phone:server:sendNewMail', {
	sender = Lang:t('mailstart.sender'),
	subject = Lang:t('mailstart.subject'),
	message = Lang:t('mailstart.message'),
	})
	Citizen.Wait(3000)
end

RegisterNetEvent('essential-runs:client:endemail', function() 
	if Config.SendEmail then
	RunEnd()
	end
end)

function RunEnd()
    Citizen.Wait(2000)
	TriggerServerEvent('qb-phone:server:sendNewMail', {
    sender = Lang:t('mailfinish.sender'),
	subject = Lang:t('mailfinish.subject'),
	message = Lang:t('mailfinish.message'),
	})
	Citizen.Wait(3000)
end

-- Load Anim Dict
function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end
