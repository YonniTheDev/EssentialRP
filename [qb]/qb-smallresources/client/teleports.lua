local title = Lang:t('teleport.teleport_default')
local ran = false
local teleportPoly = {}

local function teleportMenu(zones,currentZone)
    local menu = {}
    for k,v in pairs(Config.Teleports[zones]) do
        if k ~= currentZone then
            if not v.label then
                title = Lang:t('teleport.teleport_default')
            else
                title = v.label
            end
            menu[#menu+1] = {
                header = title,
                params = {
                    event = "teleports:chooseloc",
                    args = {
                        car = Config.Teleports[zones][currentZone]["AllowVehicle"],
                        coords = v['poly'].coords,
                        heading = v['poly'].heading
                    }
                }
            }
        end
    end
    exports['qb-menu']:showHeader(menu)
end

CreateThread(function()
    for i = 1,#Config.Teleports,1 do
        for u = 1,#Config.Teleports[i] do
            local portal = Config.Teleports[i][u]['poly']
            teleportPoly[#teleportPoly+1] = BoxZone:Create(vector3(portal.coords.x, portal.coords.y, portal.coords.z), portal.length, portal.width, {
                heading = portal.heading,
                name = i,
                debugPoly = false,
                minZ = portal.coords.z - 5,
                maxZ = portal.coords.z + 5,
                data = {pad = u}
            })
            local teleportCombo = ComboZone:Create(teleportPoly, {name = "teleportPoly"})
            teleportCombo:onPlayerInOut(function(isPointInside, _, zone)
                if isPointInside then
                    if not ran then
                        ran = true
                        teleportMenu(tonumber(zone.name),zone.data.pad)
                    end
                else
                    ran = false
                end
            end)
        end
    end
end)

RegisterNetEvent("teleports:chooseloc", function(data)
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(500)
    if data.car then
        SetPedCoordsKeepVehicle(ped, data.coords.x, data.coords.y, data.coords.z)
    else
        SetEntityCoords(ped, data.coords.x, data.coords.y, data.coords.z)
    end
    SetEntityHeading(ped, data.heading)
    Wait(500)
    DoScreenFadeIn(500)
end)

RegisterNetEvent("GunBenchEnter", function()
    local ped = PlayerPedId()
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(ped, 730.44, 2531.84, 73.23, 0, 0, 0, false)  
    SetEntityHeading(ped, 271.14)
    FreezeEntityPosition(ped, true)
    Wait(3000)
    DoScreenFadeIn(2000)
    FreezeEntityPosition(ped, false)
end)

RegisterNetEvent("GunBenchExit", function()
    local ped = PlayerPedId()
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(ped, 172.99, -1007.59, -99.0, 0, 0, 0, false)     
    SetEntityHeading(ped, 357.72)
    Wait(1000)
    DoScreenFadeIn(1000)
end)
