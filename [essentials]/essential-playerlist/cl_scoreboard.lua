local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('qb-scoreboard:AddPlayer')
    TriggerServerEvent('qb-scoreboard:server:totalPlayers')
end)

local QB = QB or {}
QB.Scoreboard = {}
QB._Scoreboard = {}

QB.Scoreboard.Menu = {}

QB._Scoreboard.Players = {}
QB._Scoreboard.Recent = {}
QB._Scoreboard.SelectedPlayer = nil
QB._Scoreboard.MenuOpen = false
QB._Scoreboard.Menus = {}

local function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function QB.Scoreboard.AddPlayer(self, data)
    QB._Scoreboard.Players[data.src] = data
end

function QB.Scoreboard.RemovePlayer(self, data)
    QB._Scoreboard.Players[data.src] = nil
    QB._Scoreboard.Recent[data.src] = data
end

function QB.Scoreboard.RemoveRecent(self, src)
    QB._Scoreboard.Recent[src] = nil
end

function QB.Scoreboard.AddAllPlayers(self, data)
    QB._Scoreboard.Players[data.src] = data
end

local playerOnline

RegisterNetEvent("qb-scoreboard:playerscount")
AddEventHandler("qb-scoreboard:playerscount", function(a)
    playerOnline = a
end)

function QB.Scoreboard.Menu.Open(self)
    QB._Scoreboard.SelectedPlayer = nil
    WarMenu.OpenMenu("scoreboard")
    shouldDraw = true
    CreateThread(function()
        while shouldDraw do
            local nearbyPlayers = GetNeareastPlayers()
            for k, v in pairs(nearbyPlayers) do
                local ped = v.ped
                if DoesEntityExist(ped) and IsEntityVisible(ped) then
                    local x, y, z = table.unpack(GetEntityCoords(v.ped))
                    Draw3DText(x, y, z + 1.1, v.playerId)
                end
            end
            for k,v in pairs(QB._Scoreboard.Menus) do
                if WarMenu.IsMenuOpened(k) then
                    v()
                    WarMenu.Display()
                else
                    if timed > 0 then
                        timed = timed - 1
                    end
                end
            end
            Wait(2)
        end
    end)
end

function QB.Scoreboard.Menu.Close(self)
    for k,v in pairs(QB._Scoreboard.Menus) do
    WarMenu.CloseMenu(k) shouldDraw =false end
end

CreateThread(function()
    local function DrawMain()
        if WarMenu.Button("Total:", tostring(playerOnline), {r = 135, g = 206, b = 250, a = 150}) then end

        for k,v in spairs(QB._Scoreboard.Players, function(t, a, b) return t[a].src < t[b].src end) do
            local playerId = GetPlayerFromServerId(v.src)

            if NetworkIsPlayerActive(playerId) or GetPlayerPed(playerId) == PlayerPedId() then
                if WarMenu.MenuButton("[" .. v.src .. "] " .. v.citizenid .. " ", "options") then QB._Scoreboard.SelectedPlayer = v end
            else
                if WarMenu.MenuButton("[" .. v.src .. "] - instanced?", "options", {r = 255, g = 0, b = 0, a = 255}) then QB._Scoreboard.SelectedPlayer = v end
            end
        end



        if WarMenu.MenuButton("Recent D/C's", "recent") then
        end
    end

    local function DrawRecent()
        for k,v in spairs(QB._Scoreboard.Recent, function(t, a, b) return t[a].src < t[b].src end) do
            if WarMenu.MenuButton("[" .. v.src .. "] " .. v.name, "options") then QB._Scoreboard.SelectedPlayer = v end
        end
    end

    local function DrawOptions()
        if WarMenu.Button("Citizen ID:", QB._Scoreboard.SelectedPlayer.citizenid) then end
        if WarMenu.Button("Server ID:", QB._Scoreboard.SelectedPlayer.src) then end
    end

    QB._Scoreboard.Menus = {
        ["scoreboard"] = DrawMain,
        ["recent"] = DrawRecent,
        ["options"] = DrawOptions
    }

    local function Init()
        WarMenu.CreateMenu("scoreboard", "Player List")
        WarMenu.SetSubTitle("scoreboard", "Players")

        WarMenu.SetMenuWidth("scoreboard", 0.5)
        WarMenu.SetMenuX("scoreboard", 0.71)
        WarMenu.SetMenuY("scoreboard", 0.017)
        WarMenu.SetMenuMaxOptionCountOnScreen("scoreboard", 30)
        WarMenu.SetTitleColor("scoreboard", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("scoreboard", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("scoreboard", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("scoreboard", 255, 255, 255, 255)

        WarMenu.CreateSubMenu("recent", "scoreboard", "Recent D/C's")
        WarMenu.SetMenuWidth("recent", 0.5)
        WarMenu.SetTitleColor("recent", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("recent", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("recent", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("recent", 255, 255, 255, 255)

        WarMenu.CreateSubMenu("options", "scoreboard", "User Info")
        WarMenu.SetMenuWidth("options", 0.5)
        WarMenu.SetTitleColor("options", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("options", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("options", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("options", 255, 255, 255, 255)
    end

    Init()
    timed = 0
end)


CreateThread(function()
    RegisterKeyMapping("+scoreboard", "Scoreboard", "keyboard", "U") --Removed Bind System and added standalone version
    RegisterCommand('+scoreboard', OpenScoreboard, false)
    RegisterCommand('-scoreboard', CloseScoreboard, false)
    TriggerEvent("chat:removeSuggestion", "/+scoreboard")
    TriggerEvent("chat:removeSuggestion", "/-scoreboard")
end)

local function IsAnyMenuOpen()
    for k,v in pairs(QB._Scoreboard.Menus) do
        if WarMenu.IsMenuOpened(k) then return true end
    end
    return false
end

function OpenScoreboard()
    if not IsAnyMenuOpen() then
        QB.Scoreboard.Menu:Open()
        TriggerEvent('animations:client:EmoteCommandStart', {"think"})
    end
end

function CloseScoreboard()
    if IsAnyMenuOpen() then
        QB.Scoreboard.Menu:Close()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end
end

RegisterNetEvent("qb-scoreboard:RemovePlayer")
AddEventHandler("qb-scoreboard:RemovePlayer", function(data)
    QB.Scoreboard:RemovePlayer(data)
end)

RegisterNetEvent("qb-scoreboard:AddPlayer")
AddEventHandler("qb-scoreboard:AddPlayer", function(data)
    QB.Scoreboard:AddPlayer(data)
end)

RegisterNetEvent("qb-scoreboard:RemoveRecent")
AddEventHandler("qb-scoreboard:RemoveRecent", function(src)
    QB.Scoreboard:RemoveRecent(src)
end)

RegisterNetEvent("qb-scoreboard:AddAllPlayers")
AddEventHandler("qb-scoreboard:AddAllPlayers", function(data)
    QB.Scoreboard:AddAllPlayers(data)
end)

function Draw3DText(x, y, z, text)
    -- Check if coords are visible and get 2D screen coords
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        -- Calculate text scale to use
        local dist = #(GetGameplayCamCoords() - vector3(x, y, z))
        local scale = 1.5 * (1.0 / dist) * (1.0 / GetGameplayCamFov()) * 100

        -- Draw text on screen
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function GetNeareastPlayers()
	local playerPed = PlayerPedId()
	local playerlist = GetActivePlayers()
   --local players, _ = hc.Game.GetPlayersInArea(GetEntityCoords(playerPed), Config.DrawDistance)

    local players_clean = {}
    local found_players = false

    for i = 1, #playerlist, 1 do
        found_players = true
        table.insert(players_clean, { playerName = GetPlayerName(playerlist[i]), playerId = GetPlayerServerId(playerlist[i]), ped = GetPlayerPed(playerlist[i]) })
    end
    return players_clean
end