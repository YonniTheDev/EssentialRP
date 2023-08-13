local QBCore = exports['qb-core']:GetCoreObject()
local attached_weapons = {}
local hotbar = {}
local sling = "Back"
local playerLoaded = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  Wait(2000)
  playerLoaded = true
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
    Wait(2000)
    playerLoaded = true
  end
end)

local number = 0
function NewItems(slot)
  if Config.WeaponsOnBack[slot].isdifferent then
    return true
  else
    return false
  end
end
function GetClosedInfo()
  local info = {
    style = sling,
    
  }
  return info
end

Citizen.CreateThread(function()
  while true do
    if playerLoaded then
        local me = PlayerPedId()
        local items = QBCore.Functions.GetPlayerData().items
        if items ~= nil then 
          hotbar = items
          for slot, item in pairs(hotbar) do
            if item ~= nil and item.type == "weapon" and Config.WeaponsOnBack[item.name] ~= nil then
              local wep_model = Config.WeaponsOnBack[item.name].model
              local wep_hash = Config.WeaponsOnBack[item.name].hash
              
              if not attached_weapons[wep_model] and GetSelectedPedWeapon(me) ~= wep_hash then
                for k, v in pairs(attached_weapons) do
                  if v.slot == number and not v.slot == 0 then
                    number = number + 1
                  end
                end
                number = number + 1
                if number < 0 then
                  number = 0
                end
                if number > 3 then
                  number = 3
                end
                if number == 1 then
                  if NewItems(item.name) then
                    AttachWeapon(wep_model, wep_hash, Config.Placement[sling].bone, 0.105, Config.Placement[sling].y, Config.Placement[sling].z, Config.Placement[sling].x_rotation, 90.0, Config.Placement[sling].z_rotation,number)
                  else
                    AttachWeapon(wep_model, wep_hash, Config.Placement[sling].bone, Config.Placement[sling].x, Config.Placement[sling].y, Config.Placement[sling].z, Config.Placement[sling].x_rotation, Config.Placement[sling].y_rotation, Config.Placement[sling].z_rotation,number)
                  end
                elseif number == 2 then
                  if NewItems(item.name) then
                    AttachWeapon(wep_model, wep_hash, Config.PlacementSecond[sling].bone, 0.105, Config.PlacementSecond[sling].y, Config.PlacementSecond[sling].z, Config.PlacementSecond[sling].x_rotation, 90.0, Config.PlacementSecond[sling].z_rotation,number)
                  else
                    AttachWeapon(wep_model, wep_hash, Config.PlacementSecond[sling].bone, Config.PlacementSecond[sling].x, Config.PlacementSecond[sling].y, Config.PlacementSecond[sling].z, Config.PlacementSecond[sling].x_rotation, Config.PlacementSecond[sling].y_rotation, Config.PlacementSecond[sling].z_rotation,number)
                  end
                else
                  if NewItems(item.name) then
                    print(item.name)
                    AttachWeapon(wep_model, wep_hash, Config.PlacementThird[sling].bone, 0.2, 0.15, -0.15, Config.PlacementThird[sling].x_rotation, Config.PlacementThird[sling].y_rotation, Config.PlacementThird[sling].z_rotation,number)
                  else
                    AttachWeapon(wep_model, wep_hash, Config.PlacementThird[sling].bone, Config.PlacementThird[sling].x, Config.PlacementThird[sling].y, Config.PlacementThird[sling].z, Config.PlacementThird[sling].x_rotation, Config.PlacementThird[sling].y_rotation, Config.PlacementThird[sling].z_rotation,number)
                  end
                end
              end
            end
          end
          for k, v in pairs(attached_weapons) do
            if GetSelectedPedWeapon(me) == v.hash or not inHotbar(v.hash) then -- equipped or not in weapon wheel
              number = v.slot - 1
              DeleteObject(v.handle)
              attached_weapons[k] = nil
              if number < 0 then
                number = 0
              end
              if number > 3 then
                number = 3
              end
              if not inHotbar(v.hash) then
                for k, v in pairs(GetGamePool('CObject')) do
                  if IsEntityAttachedToEntity(PlayerPedId(), v) then
                    SetEntityAsMissionEntity(v, true, true)
                    DeleteObject(v)
                    DeleteEntity(v)
                  end
                end
                number = 0
                for slot, item in pairs(hotbar) do
                  if item ~= nil and item.type == "weapon" and Config.WeaponsOnBack[item.name] ~= nil then
                    number = number + 1
                    local wep_model = Config.WeaponsOnBack[item.name].model
                    local wep_hash = Config.WeaponsOnBack[item.name].hash
                    if number == 1 then
                      if NewItems(item.name) then
                        AttachWeapon(wep_model, wep_hash, Config.Placement[sling].bone, 0.105, Config.Placement[sling].y, Config.Placement[sling].z, Config.Placement[sling].x_rotation, 90.0, Config.Placement[sling].z_rotation,number)
                      else
                        AttachWeapon(wep_model, wep_hash, Config.Placement[sling].bone, Config.Placement[sling].x, Config.Placement[sling].y, Config.Placement[sling].z, Config.Placement[sling].x_rotation, Config.Placement[sling].y_rotation, Config.Placement[sling].z_rotation,number)
                      end
                    elseif number == 2 then
                      if NewItems(item.name) then
                        AttachWeapon(wep_model, wep_hash, Config.PlacementSecond[sling].bone, 0.105, Config.PlacementSecond[sling].y, Config.PlacementSecond[sling].z, Config.PlacementSecond[sling].x_rotation, 90.0, Config.PlacementSecond[sling].z_rotation,number)
                      else
                        AttachWeapon(wep_model, wep_hash, Config.PlacementSecond[sling].bone, Config.PlacementSecond[sling].x, Config.PlacementSecond[sling].y, Config.PlacementSecond[sling].z, Config.PlacementSecond[sling].x_rotation, Config.PlacementSecond[sling].y_rotation, Config.PlacementSecond[sling].z_rotation,number)
                      end
                    else
                      if NewItems(item.name) then
                        AttachWeapon(wep_model, wep_hash, Config.PlacementThird[sling].bone, 0.2, 0.15, -0.15, Config.PlacementThird[sling].x_rotation, Config.PlacementThird[sling].y_rotation, Config.PlacementThird[sling].z_rotation,number)
                      else
                        AttachWeapon(wep_model, wep_hash, Config.PlacementThird[sling].bone, Config.PlacementThird[sling].x, Config.PlacementThird[sling].y, Config.PlacementThird[sling].z, Config.PlacementThird[sling].x_rotation, Config.PlacementThird[sling].y_rotation, Config.PlacementThird[sling].z_rotation,number)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    Wait(Config.LoopSpeed)
  end
end)

RegisterCommand('weaponprint',function()
  -- TriggerServerEvent('essential:paintball:RemovePlayer',playerTeam)
  print(GetSelectedPedWeapon(PlayerPedId()))
end)

function inHotbar(hash)
  for slot, item in pairs(hotbar) do
    if item ~= nil and item.type == "weapon" and Config.WeaponsOnBack[item.name] ~= nil then
      if hash == GetHashKey(item.name) then
        return true
      end
    end
  end
  return false
end

function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR,num)
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumber)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Wait(100)
	end

  attached_weapons[attachModel] = {
    hash = modelHash,
    handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false),
    slot = num
  }

	AttachEntityToEntity(attached_weapons[attachModel].handle, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end

RegisterNetEvent('essential:sling:togglePos')
AddEventHandler('essential:sling:togglePos', function()
    if sling == "Back" then 
      sling = "Front"
    else
      sling = "Back"
    end
end)

RegisterNetEvent('essential:ReloadGuns:sling', function()
  for k, v in pairs(GetGamePool('CObject')) do
    if IsEntityAttachedToEntity(PlayerPedId(), v) then
      SetEntityAsMissionEntity(v, true, true)
      DeleteObject(v)
      DeleteEntity(v)
    end
  end
  number = 0
  local me = PlayerPedId()
  local items = QBCore.Functions.GetPlayerData().items
  if items ~= nil then 
      hotbar = items
      for slot, item in pairs(hotbar) do
          if item ~= nil and item.type == "weapon" and Config.WeaponsOnBack[item.name] ~= nil then
              local wep_model = Config.WeaponsOnBack[item.name].model
              local wep_hash = Config.WeaponsOnBack[item.name].hash
              if attached_weapons[wep_model] and GetSelectedPedWeapon(me) ~= wep_hash then
                  for k, v in pairs(attached_weapons) do
                      if v.slot == number and not v.slot == 0 then
                          number = number + 1
                      end
                  end
                  number = number + 1
                  if number < 0 then
                      number = 0
                  end
                  if number > 3 then
                      number = 3
                  end
                  if number == 1 then
                    if NewItems(item.name) then
                      AttachWeapon(wep_model, wep_hash, Config.Placement[sling].bone, 0.105, Config.Placement[sling].y, Config.Placement[sling].z, Config.Placement[sling].x_rotation, 90.0, Config.Placement[sling].z_rotation,number)
                    else
                      AttachWeapon(wep_model, wep_hash, Config.Placement[sling].bone, Config.Placement[sling].x, Config.Placement[sling].y, Config.Placement[sling].z, Config.Placement[sling].x_rotation, Config.Placement[sling].y_rotation, Config.Placement[sling].z_rotation,number)
                    end
                  elseif number == 2 then
                    if NewItems(item.name) then
                      AttachWeapon(wep_model, wep_hash, Config.PlacementSecond[sling].bone, 0.105, Config.PlacementSecond[sling].y, Config.PlacementSecond[sling].z, Config.PlacementSecond[sling].x_rotation, 90.0, Config.PlacementSecond[sling].z_rotation,number)
                    else
                      AttachWeapon(wep_model, wep_hash, Config.PlacementSecond[sling].bone, Config.PlacementSecond[sling].x, Config.PlacementSecond[sling].y, Config.PlacementSecond[sling].z, Config.PlacementSecond[sling].x_rotation, Config.PlacementSecond[sling].y_rotation, Config.PlacementSecond[sling].z_rotation,number)
                    end
                  else
                    if NewItems(item.name) then
                      AttachWeapon(wep_model, wep_hash, Config.PlacementThird[sling].bone, 0.2, 0.15, -0.15, Config.PlacementThird[sling].x_rotation, Config.PlacementThird[sling].y_rotation, Config.PlacementThird[sling].z_rotation,number)
                    else
                      AttachWeapon(wep_model, wep_hash, Config.PlacementThird[sling].bone, Config.PlacementThird[sling].x, Config.PlacementThird[sling].y, Config.PlacementThird[sling].z, Config.PlacementThird[sling].x_rotation, Config.PlacementThird[sling].y_rotation, Config.PlacementThird[sling].z_rotation,number)
                    end
                  end
              end
          end
      end
  end
end)