local on = true
local WhitelistedWeapons = {
    `weapon_assaultrifle`,
    `weapon_carbinerifle`,
    `weapon_pumpshotgun`,
    `weapon_sawnoffshotgun`,
    `weapon_compactrifle`,
    `weapon_microsmg`,
    `weapon_autoshotgun`,
    `weapon_pistol`,
    `weapon_pistol_mk2`,
    `weapon_combatpistol`,
    `weapon_appistol`,
    `weapon_pistol50`,
    `weapon_heavypistol`,
    `weapon_vintagepistol`,
	`weapon_smg_mk2`,
    `weapon_assaultsmg`,
    `weapon_combatpdw`,
    `weapon_gusenberg`,
    `weapon_machinepistol`,
    `weapon_minismg`,
	`weapon_assaultrifle_mk2`,
    `weapon_carbinerifle_mk2`,
    `weapon_advancedrifle`,
    `weapon_specialcarbine`,
    `weapon_bullpuprifle`,
    `weapon_specialcarbine_mk2`,
    `weapon_bullpuprifle_mk2`,
    `weapon_militaryrifle`,
    `weapon_ceramicpistol`,
    `weapon_revolver`,
    `weapon_stungun`,
    `weapon_m6ic`,
    `weapon_glock17`,
    `weapon_ak47`,
    `weapon_m4`,
	`weapon_m9`,
    `weapon_m1911`,
    `weapon_uzi`,
    `weapon_mac10`,
    `weapon_ar15`,
    `weapon_mk14`,
    `weapon_mp9`,
    `weapon_m110`,
    `weapon_hk416`,
    `weapon_ak74`,
    `weapon_aks74`,
    `weapon_glock18c`,
    `weapon_glock22`,
    `weapon_mp5`,
}
CreateThread(function()
	while true do
		if on then
			if IsAimCamActive() then
				for k,v in pairs(WhitelistedWeapons) do
					if GetSelectedPedWeapon(PlayerPedId()) == v then
						drawCrosshair()
					end
				end
			else
				Wait(300)
			end
		else
			Wait(3000)
		end
		Wait(5)
	end
end)
RegisterNetEvent('cl:update_c')
AddEventHandler('cl:update_c', function(bool)
	on = bool
end)
RegisterCommand('togglecrosshair', function()
	if on then
		on = false
	elseif not on then 
		on = true
	end
end)
function drawCrosshair()
	local sprite = DrawRect(0.5, 0.5, 0.001, 0.009, 255, 255, 255, 255)
    local sprite = DrawRect(0.5, 0.5, 0.005, 0.001, 255, 255, 255, 255)
end
