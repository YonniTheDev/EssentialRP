Config = {}
Config.LoopSpeed = 2700 -- How fast the loop to check weapons runs. Lower numbers are lest optimized.

Config.Placement = {
    ["Back"] = {
        bone = 24816,
        x = 0.275, -- up and down
        y = -0.165, -- in and out
        z = 0.02, -- left and right
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 0.0
    },
    ["Front"] = {
        bone = 10706,
        x = 0.0, -- up and down
        y = 0.19, -- in and out
        z = -0.25, -- left and right
        x_rotation = 0.0, -- flips the gun how you would want
        y_rotation = 75.0, -- tilts sideways
        z_rotation = 180.0 -- tilts into ped
    }
}
Config.PlacementSecond = {
    ["Back"] = {
        bone = 24816,
        x = 0.235, -- up and down
        y = -0.165, -- in and out
        z = -0.08, -- left and right
        x_rotation = 180.0, -- flips the gun how you would want
        y_rotation = 0.0, -- tilts sideways
        z_rotation = 0.0 -- tilts into ped
    },
    ["Front"] = {
        bone = 24816,
        x = 0.275, -- up and down
        y = -0.165, -- in and out
        z = 0.02, -- left and right
        x_rotation = 0.0, -- flips the gun how you would want
        y_rotation = 0.0, -- tilts sideways
        z_rotation = 0.0 -- tilts into ped
    }
}
Config.PlacementThird = {
    ["Back"] = {
        bone = 10706,
        x = 0.0, -- up and down
        y = 0.19, -- in and out
        z = -0.25, -- left and right
        x_rotation = 0.0, -- flips the gun how you would want
        y_rotation = 75.0, -- tilts sideways
        z_rotation = 180.0 -- tilts into ped
    },
    ["Front"] = {
        bone = 24816,
        x = 0.235, -- up and down
        y = -0.165, -- in and out
        z = -0.08, -- left and right
        x_rotation = 180.0, -- flips the gun how you would want
        y_rotation = 0.0, -- tilts sideways
        z_rotation = 0.0 -- tilts into ped
    }
}

Config.WeaponsOnBack = {
    -- assault rifles:
    ["weapon_carbinerifle"] = { model = "w_ar_carbinerifle", hash = -2084633992},
    ["weapon_compactrifle"] = { model = "w_ar_assaultrifle_smg", hash = 1649403952},
    ["weapon_carbinerifle_mk2"] = { model = "w_ar_carbineriflemk2", hash = GetHashKey("WEAPON_CARBINERIFLE_MK2")},
    ["weapon_assaultrifle"] = { model = "w_ar_assaultrifle", hash = -1074790547},
    ["weapon_specialcarbine"] = { model = "w_ar_specialcarbine", hash = -1063057011},
    ["weapon_bullpuprifle"] = { model = "w_ar_bullpuprifle", hash = 2132975508},
    ["weapon_advancedrifle"] = { model = "w_ar_advancedrifle", hash = -1357824103},
    -- sub machine guns:
--  ["weapon_microsmg"] = { model = "w_sb_microsmg", hash = 324215364},
    ["weapon_assaultsmg"] = { model = "w_sb_assaultsmg", hash = -270015777},
    ["weapon_smg"] = { model = "w_sb_smg", hash = 736523883},
    ["weapon_smgmk2"] = { model = "w_sb_smgmk2", hash = GetHashKey("WEAPON_SMG_MK2")},
    ["weapon_gusenberg"] = { model = "w_sb_gusenberg", hash = 1627465347},
    -- sniper rifles:
    ["weapon_sniperrifle"] = { model = "w_sr_sniperrifle", hash = 100416529},
    -- shotguns:
    ["weapon_sawnoffshotgun"] = { model = "w_sg_sawnoff", hash = 2017895192},
    ["weapon_assaultshotgun"] = { model = "w_sg_assaultshotgun", hash = -494615257},
    ["weapon_bullpupshotgun"] = { model = "w_sg_bullpupshotgun", hash = -1654528753},
    ["weapon_pumpshotgun"] = { model = "w_sg_pumpshotgun", hash = 487013001},
    ["weapon_musket"] = { model = "w_ar_musket", hash = -1466123874},
    ["weapon_heavyshotgun"] = { model = "w_sg_heavyshotgun", hash = GetHashKey("WEAPON_HEAVYSHOTGUN")},
    -- mele weapons
    ["weapon_machete"] = { model = "w_me_machette_lr", hash = -581044007, isdifferent = true},
    ["weapon_bat"] = { model = "w_me_bat", hash = GetHashKey("WEAPON_BAT"), isdifferent = true},
    ["markedbills"] = { model = "prop_money_bag_01", hash = 289396019, isdifferent = true},
    ["meth_baggy"] = { model = "bkr_prop_coke_cutblock_01", hash = -303457828},

    -- Addon weapons
    ["weapon_remington"] = { model = "w_sg_remington", hash = GetHashKey("weapon_remington")},
    ["weapon_katana"] = { model = "w_me_katana", hash = GetHashKey("weapon_katana"), isdifferent = true},
    ["weapon_mp5"] = { model = "w_sb_mp5", hash = GetHashKey("weapon_mp5")},
    ["weapon_huntingrifle"] = { model = "w_sr_huntingrifle", hash = GetHashKey("weapon_huntingrifle")},
}