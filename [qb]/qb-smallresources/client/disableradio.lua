local QBCore = exports['qb-core']:GetCoreObject()
local playerData = QBCore.Functions.GetPlayerData()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            SetUserRadioControlEnabled(false)
            if GetPlayerRadioStationName() ~= nil then
                SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId()),"OFF")
            end
        end
    end
end)

-- car hood fix

local vehicleHoodFp = false

CreateThread(function()
    while true do
        Wait(2500)
        local profileSetting = GetProfileSetting(243)

        if profileSetting == 1 then
            if not vehicleHoodFp then
                QBCore.Functions.Notify('Disable first person on the hood setting.', 'error')
                vehicleHoodFp = true
                FreezeEntityPosition(PlayerPedId(), vehicleHoodFp)
                SetPlayerCanDoDriveBy(PlayerId(), false)
                DisablePlayerFiring(PlayerId(), true)
                DisableControlAction(0, 25, true)
            end
        elseif vehicleHoodFp then
            vehicleHoodFp = false
            FreezeEntityPosition(PlayerPedId(), vehicleHoodFp)
            QBCore.Functions.Notify('Woo! Thanks for changing that setting.', 'success')
            SetPlayerCanDoDriveBy(PlayerId(), true)
            DisablePlayerFiring(PlayerId(), false)
            EnableControlAction(0, 25, true)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)  -- This allows other scripts to run and the game to continue processing

        local ped = PlayerPedId()
        local isInVehicle = IsPedInAnyVehicle(ped, false)

        if isInVehicle then
            local viewMode = GetFollowVehicleCamViewMode()
            if viewMode == 1 or viewMode == 2 then
                SetFollowVehicleCamViewMode(4)
            end
        else
            local viewMode = GetFollowPedCamViewMode()
            if viewMode == 2 then
                SetFollowPedCamViewMode(4)
            end
        end

        if not isInVehicle then
            ClampGameplayCamPitch(-80.0, 80.0)
        end

        SetPlayerForcedZoom(PlayerId(), not isInVehicle)
    end
end)

-- Zoomed Aim

-- local CanUseVehicleWeapon = false
-- local LastAiming = 0
-- local LastMeleeAttack = 0
-- local LastJump = 0
-- local ActionMode = 0
-- local WasAimingThirdPerson = 0
-- local WasAiming = false

-- --[[ Threads ]]--
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		local ped = PlayerPedId()
-- 		local player = PlayerId()
-- 		local weapon = GetSelectedPedWeapon(ped)
-- 		local isShooting = IsPedShooting(ped)
-- 		local coords = GetEntityCoords(ped)
		
-- 		for k, otherPlayer in ipairs(GetActivePlayers()) do
-- 			-- Enable PVP.
-- 			SetCanAttackFriendly(GetPlayerPed(otherPlayer), true, true)
-- 			NetworkSetFriendlyFireOption(true)
-- 		end

-- 		-- Wanted level.
-- 		if GetPlayerWantedLevel(player) ~= 0 then
-- 			SetPlayerWantedLevel(player, 0, false)
-- 			SetPlayerWantedLevelNow(player, false)
-- 			SetMaxWantedLevel(0)
-- 		end

-- 		-- Disable pistol whipping.
-- 		if IsPedArmed(ped, 4) then
-- 			DisableControlAction(0, 140, true)
-- 			DisableControlAction(0, 141, true)
-- 			DisableControlAction(0, 142, true)
-- 			DisableControlAction(0, 257, true)
-- 			DisableControlAction(0, 263, true)
-- 			DisableControlAction(0, 264, true)
-- 		end

-- 		-- Disable reticle.
-- 		if not IsPlayerFreeAiming() and not ScopedWeapons[weapon] then
-- 			HideHudComponentThisFrame(14)
-- 		end

-- 		-- Dispatch stuff.
-- 		EnableDispatchService(1, false)
-- 		EnableDispatchService(2, false)
-- 		EnableDispatchService(3, false)
-- 		EnableDispatchService(4, false)
-- 		EnableDispatchService(5, false)
-- 		EnableDispatchService(6, false)
-- 		EnableDispatchService(7, false)
-- 		EnableDispatchService(8, false)
-- 		EnableDispatchService(9, false)
-- 		EnableDispatchService(10, false)
-- 		EnableDispatchService(11, false)
-- 		EnableDispatchService(12, false)
-- 		EnableDispatchService(13, false)
-- 		EnableDispatchService(14, false)
-- 		EnableDispatchService(15, false)

-- 		-- Disable ambient/ghost sirens.
-- 		DistantCopCarSirens(false)

-- 		-- Disable crits.
-- 		SetPedSuffersCriticalHits(ped, false)
		
-- 		-- Melee cooldown.
-- 		if IsPedArmed(ped, 1) or weapon == GetHashKey("WEAPON_UNARMED") then
-- 			local canAttack = IsControlPressed(0, 25) or IsPedRunning(ped) or IsPedSprinting(ped)
-- 			for k, v in ipairs(Config.CombatControls) do
-- 				if not canAttack then
-- 					DisableControlAction(0, v)
-- 				elseif IsControlJustPressed(0, v) or IsControlJustReleased(0, v) then
-- 					LastMeleeAttack = GetGameTimer()
-- 					break
-- 				end
-- 			end
-- 		end

-- 		local lastMelee = GetGameTimer() - LastMeleeAttack
-- 		if lastMelee < Config.MeleeCooldown then
-- 			DisablePlayerFiring(ped, true)
-- 			for k, v in ipairs(Config.CombatControls) do
-- 				if IsDisabledControlJustPressed(0, v) then
-- 					LastMeleeAttack = LastMeleeAttack + 30
-- 				end
-- 				DisableControlAction(0, v, true)
-- 			end
-- 		end
-- 		if lastMelee < -100 then
-- 			print("Maybe, don't click so fast. :)")
-- 		end

-- 		-- No blind firing.
-- 		if IsPedInCover(ped, false) and not IsPedAimingFromCover(ped) then
-- 			DisableControlAction(0, 24)
-- 		end

-- 		-- No rolling while aiming.
-- 		local isRolling = false
-- 		if (IsAimCamActive() or isShooting or (not IsPedWeaponReadyToShoot(ped))) and IsControlJustPressed(0, 22) then
-- 			isRolling = true
-- 		end

-- 		-- Jumping.
-- 		if IsPedJumping(ped) or isRolling then
-- 			LastJump = GetGameTimer()
-- 		elseif GetGameTimer() - LastJump < 3000 then
-- 			SetPedMoveRateOverride(ped, 0.5 + math.min((GetGameTimer() - LastJump) / 3000 * 0.5, 0.5))
-- 			DisableControlAction(0, 22)
-- 		end

-- 		-- Disable action mode.
-- 		if IsPedUsingActionMode(ped) then
-- 			if GetGameTimer() - ActionMode > 1000 then
-- 				ActionMode = GetGameTimer()
-- 				SetPedUsingActionMode(ped, false, -1, 0)
-- 			end
-- 		end

-- 		-- Emergency vehicles.
-- 		ClearAreaOfCops(coords.x, coords.y, coords.z, 500.0)

-- 		-- Zoom.
-- 		local isInVehicle= IsPedInAnyVehicle(ped, false)
-- 		if isInVehicle then
-- 			local viewMode = GetFollowVehicleCamViewMode()
-- 			if viewMode == 1 or viewMode == 2 then
-- 				SetFollowVehicleCamViewMode(4)
-- 			end
-- 		else
-- 			local viewMode = GetFollowPedCamViewMode()
-- 			if viewMode == 2 then
-- 				SetFollowPedCamViewMode(4)
-- 			end
-- 		end
-- 		if not isInVehicle then
-- 			ClampGameplayCamPitch(-80.0, 80.0)
-- 		end
-- 		SetPlayerForcedZoom(PlayerId(), not isInVehicle)

-- 		-- Shooting on motorcycles.
-- 		if isShooting and isInVehicle and GetVehicleClass(GetVehiclePedIsIn(ped) or 0) == 8 and GetRandomFloatInRange(0.0, 1.0) < 0.1 then
-- 			SetPedToRagdoll(ped, 1000, 1000, 0)
-- 		end

-- 		-- Stamina.
-- 		RestorePlayerStamina(player, 100.0)
		
-- 		-- Targetting.
-- 		SetPlayerTargetingMode(3)

-- 		-- Crosshair.
-- 		local isAiming = IsAimCamActive() and IsPedArmed(ped, 4) and GetFollowPedCamViewMode() ~= 4
-- 		if WasAiming ~= isAiming then
-- 			ToggleCrosshair(isAiming)
-- 			WasAiming = isAiming
-- 		end
-- 	end
-- end)

-- -- Zoom.
-- local isInVehicle= IsPedInAnyVehicle(ped, false)
-- if isInVehicle then
--     local viewMode = GetFollowVehicleCamViewMode()
--     if viewMode == 1 or viewMode == 2 then
--         SetFollowVehicleCamViewMode(4)
--     end
-- else
--     local viewMode = GetFollowPedCamViewMode()
--     if viewMode == 2 then
--         SetFollowPedCamViewMode(4)
--     end
-- end
-- if not isInVehicle then
--     ClampGameplayCamPitch(-80.0, 80.0)
-- end
-- SetPlayerForcedZoom(PlayerId(), not isInVehicle)