
local time = 30 * 1000 -- 30 seconds for drunk effect
local PlayerPedId = PlayerPedId

local jailBoxCoords = vector3(-74.94596862793, -817.98797607422, 243.38595581055)  -- change it to your own jail box coords

local function LoadAnimSet(animSet)
    RequestAnimSet(animSet)
    while not HasAnimSetLoaded(animSet) do
        Wait(5)
    end
end

-- some of the effects are working while some are not. You might have to play with these. I have uncommented the one I tested and they work fine.
local VehicleEffects = {
    1 ,---brake
    3 ,---brake + reverse
    4 ,---turn left 90 + braking
    5 ,---turn right 90 + braking
    -- 6 ,---brake strong (handbrake?) until time ends
    7 ,---turn left + accelerate
    7 ,---turn right + accelerate
    -- 9 ,---weak acceleration
    -- 10, -- turn left + restore wheel pos to center in the end
    -- 11, -- turn right + restore wheel pos to center in the end
    13, -- turn left + go reverse
    14, -- turn left + go reverse
    19, -- strong brake + turn left/right
    20, -- weak brake + turn left then turn right
    21, -- weak brake + turn right then turn left
    22, -- brake + reverse
    -- 23, -- accelerate fast
    -- 24, -- brake
    25, -- brake turning left then when almost stopping it turns left more
    -- 26, -- brake turning right then when almost stopping it turns right more
    -- 27, -- brake until car stop or until time ends
    -- 28, -- brake + strong reverse acceleration
    -- 31, -- accelerate + handbrake
    -- 32-- accelerate very strong
}

-- ██████  ██████  ██    ██ ███    ██ ██   ██ 
-- ██   ██ ██   ██ ██    ██ ████   ██ ██  ██  
-- ██   ██ ██████  ██    ██ ██ ██  ██ █████   
-- ██   ██ ██   ██ ██    ██ ██  ██ ██ ██  ██  
-- ██████  ██   ██  ██████  ██   ████ ██   ██

function DrunkEffect()
    local isDrunk = true
    LoadAnimSet("move_m@drunk@verydrunk")
    SetPedMovementClipset(PlayerPedId(), "move_m@drunk@verydrunk")
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
    SetPedIsDrunk(PlayerPedId(), true)
    StartScreenEffect("SwitchSceneTrevor", 3.0, 0)
    local drunkTime = time
    CreateThread(function()
        while drunkTime > 0 and isDrunk do
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if vehicle ~= 0 then
                if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                    local vehicleTask = math.random(1, #VehicleEffects)
                    TaskVehicleTempAction(PlayerPedId(), vehicle, VehicleEffects[vehicleTask], 1000)
                end
            end
            drunkTime = drunkTime - 1000
            Wait(1000)
        end
        isDrunk = false
        StopGameplayCamShaking(true)
        ResetPedMovementClipset(PlayerPedId())
        StopScreenEffect("SwitchSceneTrevor")
        RemoveAnimSet("move_m@drunk@verydrunk")
    end)
end


function SetPlayerOnFire()
    StartEntityFire(PlayerPedId())
end

function SendToJailBox()
    SetEntityCoords(PlayerPedId(), jailBoxCoords.x, jailBoxCoords.y, jailBoxCoords.z, 0.0, 0.0, 0.0, false)
end

function SlapSky()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local maxZ = playerCoords.z + 100.0
    FreezeEntityPosition(PlayerPedId(), true)
    CreateThread(function()
        while maxZ > playerCoords.z do
            playerCoords = GetEntityCoords(PlayerPedId())
            SetEntityCoords(PlayerPedId(), playerCoords.x, playerCoords.y, playerCoords.z + 0.1, 0.0, 0.0, 0.0, false)
            Wait(100)
        end
        FreezeEntityPosition(PlayerPedId(), false)
    end)
end

-- if you want to use some other sound script, you can change the event name. the soundName is sent here and triggered on the player selected in UI.
function PlaySound(soundName)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.0, soundName, 0.5)
end

local function DamageVehicle(x, y, z)
    CreateThread(function()
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            for i = 1, 10, 1 do
                SetVehicleDamage(vehicle, x, y, z, 2000.0, 500.0, true)
                Wait(200)
            end
        end
    end)
end

function DamagePlayerVehicle()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        DamageVehicle(0.1, 0.1, 0)
        DamageVehicle(0.1, -0.1, 0)
        DamageVehicle(-0.1, 0.1, 0)
        DamageVehicle(-0.1, -0.1, 0)
        DamageVehicle(0.0, 0.0, 0.4)
        DamageVehicle(0.0, 0.0, -0.4)
    end
end