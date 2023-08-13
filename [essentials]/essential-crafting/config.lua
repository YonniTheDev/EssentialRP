Config = {}

Config.useTargetModels = true -- If true, all prop models below can be targeted to access the crafting menu and negates making box zones for them // Currently only setup for base crafting
Config.Models = {
    base = {`gr_prop_gr_bench_04b`},
}

Config.benchReps = {
    rep = {"base", "electronic"},
    attachmentRep = {"attachment"},
    weaponreputation = {"weapon"},
    ammoreputation = {"ammo"}
}

Config.craftingBenches = {
    {id = "pbbase", coords = vector3(170.37, -1004.33, -99.0), heading = 90.54, objExists = true, prop = 'gr_prop_gr_bench_01b', benchType = 'weapon'},
    {id = "pbbase2", coords = vector3(1539.4061279297, 1699.6688232422, 109.74491119385), heading = 80.76, objExists = false, prop = 'gr_prop_gr_bench_04b', benchType = 'base'},
    -- {id = "gsbase", coords = vector3(2135.7, 4771.66, 39.98), heading = 5.35, objExists = true, prop = 'prop_toolchest_05', benchType = 'base'},
    -- {id = "lmelec", coords = vector3(1272.18, -1710.86, 54.77), heading = 26, objExists = true, prop = 'electronicbench', benchType = 'ammo'},
    {id = "ssattach", coords = vector3(1216.6668701172, 1892.3439941406, 77.988441467285), heading = 40.00, objExists = false, prop = 'gr_prop_gr_bench_02a', benchType = 'attachment'},
    {id = "gsammo", coords = vector3(-564.81201171875, -1621.8746337891, 27.010774612427), heading = 263.00, objExists = false, prop = 'gr_prop_gr_speeddrill_01b', benchType = 'ammo'},
}

--[[
Make sure to change the image path to your inventory image file. Default is qb-inventory, you can change it to lj-inventory by doing this example below:
    https://cfx-nui-lj-inventory/html/images/radio.png
]]

-- Recipes that come with every workbench
Config.defaultRecipes = {
    -- Base Items -- 
    lockpick = {
        item = "lockpick",
        label = "Lockpick",
        image = "https://cfx-nui-qb-inventory/html/images/lockpick.png",
        benchType = "base",
        threshold = 0,
        points = 1,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 20, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "plastic", label = "Plastic", amount = 32, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "aluminum", label = "Aluminum", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
        }
    },
    unmarkedsimcard = {
        item = "unmarkedsimcard",
        label = "Unmarked Fleeca Card",
        image = "https://cfx-nui-qb-inventory/html/images/simcard.png",
        benchType = "base",
        threshold = 0,
        points = 1,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "plastic", label = "Plastic", amount = 40, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "aluminum", label = "Aluminum", amount = 20, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
            {item = "copper", label = "Copper", amount = 20, image = "https://cfx-nui-qb-inventory/html/images/copper.png"},
        }
    },
    repairkit = {
        item = "repairkit",
        label = "Repair Kit",
        image = "https://cfx-nui-qb-inventory/html/images/repairkit.png",
        benchType = "base",
        threshold = 0,
        points = 2,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 50, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 50, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "plastic", label = "Plastic", amount = 60, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    electronickit = {
        item = "electronickit",
        label = "Electronic Kit",
        image = "https://cfx-nui-qb-inventory/html/images/electronickit.png",
        benchType = "base",
        threshold = 0,
        points = 2,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 60, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 70, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "plastic", label = "Plastic", amount = 75, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    radio = {
        item = "radio",
        label = "Radio",
        image = "https://cfx-nui-qb-inventory/html/images/radio.png",
        benchType = "base",
        threshold = 0,
        points = 2,
        components = {
            {item = "electronickit", label = "Electronic Kit", amount = 1, image = "https://cfx-nui-qb-inventory/html/images/electronickit.png"},
            {item = "plastic", label = "Plastic", amount = 30, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "steel", label = "Steel", amount = 15, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
        }
    },
    phone = {
        item = "phone",
        label = "Phone",
        image = "https://cfx-nui-qb-inventory/html/images/phone.png",
        benchType = "base",
        threshold = 0,
        points = 2,
        components = {
            {item = "electronickit", label = "Electronic Kit", amount = 1, image = "https://cfx-nui-qb-inventory/html/images/electronickit.png"},
            {item = "plastic", label = "Plastic", amount = 20, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "steel", label = "Steel", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
        }
    },
    ironoxide = {
        item = "ironoxide",
        label = "Iron Oxide",
        image = "https://cfx-nui-qb-inventory/html/images/ironoxide.png",
        benchType = "base",
        threshold = 300,
        points = 5,
        components = {
            {item = "iron", label = "Iron", amount = 60, image = "https://cfx-nui-qb-inventory/html/images/iron.png"},
            {item = "glass", label = "Glass", amount = 60, image = "https://cfx-nui-qb-inventory/html/images/glass.png"},
            {item = "copper", label = "Copper", amount = 30, image = "https://cfx-nui-qb-inventory/html/images/Copper.png"},
        }
    },
    aluminumoxide = {
        item = "aluminumoxide",
        label = "Aluminum Oxide",
        image = "https://cfx-nui-qb-inventory/html/images/aluminumoxide.png",
        benchType = "base",
        threshold = 315,
        points = 5,
        components = {
            {item = "aluminum", label = "Aluminum", amount = 60, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
            {item = "glass", label = "Glass", amount = 30, image = "https://cfx-nui-qb-inventory/html/images/glass.png"},
        }
    },
    safecracker = {
        item = "safecracker",
        label = "Safecracker",
        image = "https://cfx-nui-qb-inventory/html/images/safecracker.png",
        benchType = "base",
        threshold = 400,
        points = 9,
        components = {
            {item = "lockpick", label = "Lockpick", amount = 2, image = "https://cfx-nui-qb-inventory/html/images/lockpick.png"},
            {item = "advancedlockpick", label = "Advanced Lockpick", amount = 1, image = "https://cfx-nui-qb-inventory/html/images/advancedlockpick.png"},
        }
    },
    armor = {
        item = "armor",
        label = "Body Armor",
        image = "https://cfx-nui-qb-inventory/html/images/armor.png",
        benchType = "base",
        threshold = 600,
        points = 9,
        components = {
            {item = "metalscrap", label = "Metalscrap", amount = 30, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 65, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "plastic", label = "Plastic", amount = 55, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "Iron", label = "Iron", amount = 30, image = "https://cfx-nui-qb-inventory/html/images/iron.png"},
        }
    },
    drill = {
        item = "drill",
        label = "Drill",
        image = "https://cfx-nui-qb-inventory/html/images/drill.png",
        benchType = "base",
        threshold = 1000,
        points = 9,
        components = {
            {item = "lockpick", label = "Lockpick", amount = 2, image = "https://cfx-nui-qb-inventory/html/images/lockpick.png"},
            {item = "steel", label = "Steel", amount = 45, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "plastic", label = "Plastic", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "Iron", label = "Iron", amount = 25, image = "https://cfx-nui-qb-inventory/html/images/iron.png"},
        }
    },

    -- Ammo Bench -- 
    pistol_ammo = {
        item = "pistol_ammo",
        label = "Pistol Ammo",
        image = "https://cfx-nui-qb-inventory/html/images/pistol_ammo.png",
        benchType = "ammo",
        threshold = 0,
        points = 1,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 50, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 60, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "copper", label = "Copper", amount = 20, image = "https://cfx-nui-qb-inventory/html/images/copper.png"},
        }
    },
    smg_ammo = {
        item = "smg_ammo",
        label = "SMG Ammo",
        image = "https://cfx-nui-qb-inventory/html/images/smg_ammo.png",
        benchType = "ammo",
        threshold = 400,
        points = 1,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 200, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 125, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "copper", label = "Copper", amount = 90, image = "https://cfx-nui-qb-inventory/html/images/copper.png"},
        }
    },
    -- Weapon Items -- 
    weapon_fnx45 = {
        item = "weapon_fnx45",
        label = "FNX-45",
        image = "https://cfx-nui-qb-inventory/html/images/weapon_combat-pistol.png",
        benchType = "weapon",
        threshold = 0,
        points = 1,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 120, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 225, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 100, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},

        }
    },
    weapon_m1911 = {
        item = "weapon_m1911",
        label = "M1911",
        image = "https://cfx-nui-qb-inventory/html/images/weapon_pistol.png",
        benchType = "weapon",
        threshold = 110,
        points = 2,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 280, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 500, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 180, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},

        }
    },
    weapon_browning = {
        item = "weapon_browning",
        label = "Browning",
        image = "https://cfx-nui-qb-inventory/html/images/browning.png",
        benchType = "weapon",
        threshold = 300,
        points = 2,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 175, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 275, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 180, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},
            {item = "iron", label = "Iron", amount = 125, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},
        }
    },
    weapon_vintagepistol = {
        item = "weapon_vintagepistol",
        label = "Vintage",
        image = "https://cfx-nui-qb-inventory/html/images/weapon_vintagepistol.png",
        benchType = "weapon",
        threshold = 450,
        points = 3,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 180, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 300, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 175, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},
            {item = "iron", label = "Iron", amount = 125, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},
        }
    },
    weapon_dp9 = {
        item = "weapon_dp9",
        label = "Diamondback",
        image = "https://cfx-nui-qb-inventory/html/images/weapon_snspistol.png",
        benchType = "weapon",
        threshold = 600,
        points = 4,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 280, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 220, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 180, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},
        }
    },
    weapon_heavypistol = {
        item = "weapon_heavypistol",
        label = "Heavy Pistol",
        image = "https://cfx-nui-qb-inventory/html/images/weapon_heavypistol.png",
        benchType = "weapon",
        threshold = 1000,
        points = 3,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 280, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 500, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 180, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},
        }
    },
    weapon_pistol50 = {
        item = "weapon_pistol50",
        label = "Deagle",
        image = "https://cfx-nui-qb-inventory/html/images/weapon_pistol50.png",
        benchType = "weapon",
        threshold = 1500,
        points = 5,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 350, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 500, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 200, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},
            {item = "iron", label = "Iron", amount = 175, image = "https://cfx-nui-qb-inventory/html/images/Iron.png"},

        }
    },
    -- Attachment Items --
    pistol_extendedclip = {
        item = "pistol_extendedclip",
        label = "Pistol Extended Mag",
        image = "https://cfx-nui-qb-inventory/html/images/pistol_extendedclip.png",
        benchType = "attachment",
        threshold = 0,
        points = 1,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 140, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 250, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 60, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    pistol_suppressor = {
        item = "pistol_suppressor",
        label = "Pistol Suppressor",
        image = "https://cfx-nui-qb-inventory/html/images/pistol_suppressor.png",
        benchType = "attachment",
        threshold = 10,
        points = 2,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 165, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 285, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 75, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    smg_extendedclip = {
        item = "smg_extendedclip",
        label = "SMG Extended Mag",
        image = "https://cfx-nui-qb-inventory/html/images/smg_extendedclip.png",
        benchType = "attachment",
        threshold = 25,
        points = 3,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 190, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 305, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 85, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    microsmg_extendedclip = {
        item = "microsmg_extendedclip",
        label = "Micro Extended Mag",
        image = "https://cfx-nui-qb-inventory/html/images/microsmg_extendedclip.png",
        benchType = "attachment",
        threshold = 50,
        points = 4,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 205, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 340, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 110, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    smg_drum = {
        item = "smg_drum",
        label = "SMG Drum Mag",
        image = "https://cfx-nui-qb-inventory/html/images/smg_drum.png",
        benchType = "attachment",
        threshold = 75,
        points = 5,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 230, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 365, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 130, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    smg_scope = {
        item = "smg_scope",
        label = "SMG Scope",
        image = "https://cfx-nui-qb-inventory/html/images/smg_scope.png",
        benchType = "attachment",
        threshold = 100,
        points = 6,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 255, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 390, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 145, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    assaultrifle_extendedclip = {
        item = "assaultrifle_extendedclip",
        label = "AR Extended Mag",
        image = "https://cfx-nui-qb-inventory/html/images/assaultrifle_extendedclip.png",
        benchType = "attachment",
        threshold = 150,
        points = 7,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 270, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 435, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 155, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "smg_extendedclip", label = "SMG Extended Mag", amount = 1, image = "https://cfx-nui-qb-inventory/html/images/smg_extendedclip.png"},
        }
    },
    assaultrifle_drum = {
        item = "assaultrifle_drum",
        label = "AR Drum Mag",
        image = "https://cfx-nui-qb-inventory/html/images/assaultrifle_extendedclip.png",
        benchType = "attachment",
        threshold = 200,
        points = 8,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 300, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 469, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 170, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "smg_extendedclip", label = "SMG Extended Mag", amount = 2, image = "https://cfx-nui-qb-inventory/html/images/smg_extendedclip.png"},
        }
    },
}

--Recipes that are unlocked with blueprints
Config.blueprintRecipes = {
    -- Base Items --
    advancedlockpick = {
        item = "advancedlockpick",
        label = "Advanced Lockpick",
        image = "https://cfx-nui-qb-inventory/html/images/advancedlockpick.png",
        benchType = "base",
        points = 10,
        components = {
            {item = "aluminum", label = "Aluminum", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
            {item = "rubber", label = "Rubber", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},
            {item = "plastic", label = "Plastic", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        },
        blueprintImage = "https://cfx-nui-qb-inventory/html/images/blueprint.png"
    },
    handcuffs = {
        item = "handcuffs",
        label = "Handcuffs",
        image = "https://cfx-nui-qb-inventory/html/images/handcuffs.png",
        benchType = "base",
        points = 6,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 36, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 24, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "aluminum", label = "Aluminum", amount = 28, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
        },
        blueprintImage = "https://cfx-nui-qb-inventory/html/images/blueprint.png"
    },
    armor = {
        item = "armor",
        label = "Armor",
        image = "https://cfx-nui-qb-inventory/html/images/armor.png",
        benchType = "base",
        points = 11,
        components = {
            {item = "iron", label = "Iron", amount = 33, image = "https://cfx-nui-qb-inventory/html/images/iron.png"},
            {item = "steel", label = "Steel", amount = 44, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "plastic", label = "Plastic", amount = 55, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "aluminum", label = "Aluminum", amount = 22, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
        },
        blueprintImage = "https://cfx-nui-qb-inventory/html/images/blueprint.png"
    },
    drill = {
        item = "drill",
        label = "Drill",
        image = "https://cfx-nui-qb-inventory/html/images/drill.png",
        benchType = "base",
        points = 12,
        components = {
            {item = "iron", label = "Iron", amount = 50, image = "https://cfx-nui-qb-inventory/html/images/iron.png"},
            {item = "steel", label = "Steel", amount = 50, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "screwdriverset", label = "Screwdriver Set", amount = 3, image = "https://cfx-nui-qb-inventory/html/images/screwdriverset.png"},
            {item = "advancedlockpick", label = "Advanced Lockpick", amount = 2, image = "https://cfx-nui-qb-inventory/html/images/advancedlockpick.png"},
        },
        blueprintImage = "https://cfx-nui-qb-inventory/html/images/blueprint.png"
    },
    -- Electronic Items --
    gatecrack = {
        item = "gatecrack",
        label = "Gatecrack",
        image = "https://cfx-nui-qb-inventory/html/images/gatecrack.png",
        benchType = "electronic",
        points = 5,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "plastic", label = "Plastic", amount = 50, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "aluminum", label = "Aluminum", amount = 30, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
            {item = "iron", label = "Iron", amount = 17, image = "https://cfx-nui-qb-inventory/html/images/iron.png"},
            {item = "electronickit", label = "Electronic Kit", amount = 2, image = "https://cfx-nui-qb-inventory/html/images/electronickit.png"},
        },
        blueprintImage = "https://cfx-nui-qb-inventory/html/images/blueprint.png"
    },
}
