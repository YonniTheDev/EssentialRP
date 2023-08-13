-- If Config.Reputation = true the player must reach this level to unlock T2 houses
Config.T2_RequiredLvl = 5

-- If Config.Reputation = false set the chance of the player receiving a T2 house
Config.T2_HouseChance = 40

-- Set the T2 circle / ps-circle minigame difficulty - https://github.com/Nathan-FiveM/qb-lock
Config.T2_Difficulty = {
    ["circles"] = { 4, 5 }, -- [1] = min, [2] = max
    ["speed"] = { 7, 8 } -- [1] = min, [2] = max
}

-- T2 house locations
Config.T2_Houses = {
    [1] = {
        ["interior"] = 1, -- Set the interior ID for this house, T2 interior list: interiors/tier2.lua
        ["location"] = vector3(-1151.85, -913.13, 6.63), -- Set the entry door location for this house
        ["heading"] = 46.44, -- Set the entry door heading for this house
        ["unlocked"] = false, -- Do not change
        ["authorised"] = false, -- Do not change
        ["poly"] = false, -- Do not change
    },
    [2] = {
        ["interior"] = 1, -- Set the interior ID for this house, T2 interior list: interiors/tier2.lua
        ["location"] = vector3(-1090.68, -926.24, 3.14), -- Set the entry door location for this house
        ["heading"] = 46.44, -- Set the entry door heading for this house
        ["unlocked"] = false, -- Do not change
        ["authorised"] = false, -- Do not change
        ["poly"] = false, -- Do not change
    },
    [3] = {
        ["interior"] = 1, -- Set the interior ID for this house, T2 interior list: interiors/tier2.lua
        ["location"] = vector3(-1022.63, -896.76, 5.41), -- Set the entry door location for this house
        ["heading"] = 209.32, -- Set the entry door heading for this house
        ["unlocked"] = false, -- Do not change
        ["authorised"] = false, -- Do not change
        ["poly"] = false, -- Do not change
    },
    [4] = {
        ["interior"] = 1, -- Set the interior ID for this house, T2 interior list: interiors/tier2.lua
        ["location"] = vector3(-1065.83, -1545.74, 4.9), -- Set the entry door location for this house
        ["heading"] = 223.53, -- Set the entry door heading for this house
        ["unlocked"] = false, -- Do not change
        ["authorised"] = false, -- Do not change
        ["poly"] = false, -- Do not change
    },
    [5] = {
        ["interior"] = 1, -- Set the interior ID for this house, T2 interior list: interiors/tier2.lua
        ["location"] = vector3(-1256.32, -1330.97, 4.08), -- Set the entry door location for this house
        ["heading"] = 116.34, -- Set the entry door heading for this house
        ["unlocked"] = false, -- Do not change
        ["authorised"] = false, -- Do not change
        ["poly"] = false, -- Do not change
    },
    [6] = {
        ["interior"] = 1, -- Set the interior ID for this house, T2 interior list: interiors/tier2.lua
        ["location"] = vector3(1046.34, -497.92, 64.08), -- Set the entry door location for this house
        ["heading"] = 171.55, -- Set the entry door heading for this house
        ["unlocked"] = false, -- Do not change
        ["authorised"] = false, -- Do not change
        ["poly"] = false, -- Do not change
    },
    [7] = {
        ["interior"] = 1, -- Set the interior ID for this house, T2 interior list: interiors/tier2.lua
        ["location"] = vector3(993.74, -620.82, 59.04), -- Set the entry door location for this house
        ["heading"] = 129.79, -- Set the entry door heading for this house
        ["unlocked"] = false, -- Do not change
        ["authorised"] = false, -- Do not change
        ["poly"] = false, -- Do not change
    },
    [8] = {
        ["interior"] = 1, -- Set the interior ID for this house, T2 interior list: interiors/tier2.lua
        ["location"] = vector3(999.53, -593.94, 59.64), -- Set the entry door location for this house
        ["heading"] = 81.33, -- Set the entry door heading for this house
        ["unlocked"] = false, -- Do not change
        ["authorised"] = false, -- Do not change
        ["poly"] = false, -- Do not change
    },
    [9] = {
        ["interior"] = 1, -- Set the interior ID for this house, T2 interior list: interiors/tier2.lua
        ["location"] = vector3(996.95, -729.65, 57.82), -- Set the entry door location for this house
        ["heading"] = 146.47, -- Set the entry door heading for this house
        ["unlocked"] = false, -- Do not change
        ["authorised"] = false, -- Do not change
        ["poly"] = false, -- Do not change
    },
    [10] = {
        ["interior"] = 1, -- Set the interior ID for this house, T2 interior list: interiors/tier2.lua
        ["location"] = vector3(1223.06, -696.95, 60.8), -- Set the entry door location for this house
        ["heading"] = 287.51, -- Set the entry door heading for this house
        ["unlocked"] = false, -- Do not change
        ["authorised"] = false, -- Do not change
        ["poly"] = false, -- Do not change
    },
}

-- Set the item used to break in to T2 houses
Config.T2_RequiredBreakIn = "advancedlockpick"

-- Set the item used to crack in to T2 safes
Config.T2_RequiredSafeCracker = "advancedlockpick"

-- Set the reward items for T2 search locations
Config.T2_RewardItems = {
    ["common"] = { ["chance"] = 100, ["exp"] = { 85, 125 },
        [1] = {
            ["item"] = "twerks_candy",
            ["amount"] = { 1, 2 },
        },
        [2] = {
            ["item"] = "lighter",
            ["amount"] = { 1, 2 },
        },
        [3] = {
            ["item"] = "copper",
            ["amount"] = { 1, 2 },
        },
        [4] = {
            ["item"] = "bandage",
            ["amount"] = { 1, 2 },
        },
    },
    ["uncommon"] = { ["chance"] = 55, ["exp"] = { 125, 165 },
        [1] = {
            ["item"] = "joint",
            ["amount"] = { 1, 3 },
        },
        [2] = {
            ["item"] = "rolling_paper",
            ["amount"] = { 1, 3 },
        },
        [3] = {
            ["item"] = "firstaid",
            ["amount"] = { 1, 3 },
        },
    },
    ["rare"] = { ["chance"] = 35, ["exp"] = { 165, 205 },
        [1] = {
            ["item"] = "cokebaggy",
            ["amount"] = { 1, 4 },
        },
        [2] = {
            ["item"] = "xtcbaggy",
            ["amount"] = { 1, 4 },
        },
        [3] = {
            ["item"] = "crack_baggy",
            ["amount"] = { 1, 4 },
        },
    },
    ["noway"] = { ["chance"] = 15, ["exp"] = { 205, 245 },
        [1] = {
            ["item"] = "goldchain",
            ["amount"] = { 1, 5 },
        },
        [2] = {
            ["item"] = "10kgoldchain",
            ["amount"] = { 1, 5 },
        },
        [3] = {
            ["item"] = "fitbit",
            ["amount"] = { 1, 5 },
        },
        [4] = {
            ["item"] = "trojan_usb",
            ["amount"] = { 1, 5 },
        },
        [5] = {
            ["item"] = "goldbar",
            ["amount"] = { 1, 1 },
        }
    },
}

-- Set the reward items for T2 safes
Config.T2_SafeRewardItems = {
    ["common"] = { ["chance"] = 100, ["exp"] = { 100, 150 },
        [1] = {
            ["item"] = "pistol_ammo",
            ["amount"] = { 1, 3 },
        },
        [2] = {
            ["item"] = "smg_ammo",
            ["amount"] = { 1, 2 },
        },
    },
    ["uncommon"] = { ["chance"] = 35, ["exp"] = { 200, 250 },
        [1] = {
            ["item"] = "pistol_suppressor",
            ["amount"] = { 1, 1 },
        },
        [2] = {
            ["item"] = "weapon_knuckle",
            ["amount"] = { 1, 1 },
        },
        [3] = {
            ["item"] = "pistol_extendedclip",
            ["amount"] = { 1, 1 },
        }
    },
    ["rare"] = { ["chance"] = 30, ["exp"] = { 300, 350 },
        [1] = {
            ["item"] = "weapon_pistol",
            ["amount"] = { 1, 1 },
        },
    },
    ["noway"] = { ["chance"] = 10, ["exp"] = { 350, 400 },
        [1] = {
            ["item"] = "weapon_pistol_mk2",
            ["amount"] = { 1, 1 },
        },
        [2] = {
            ["item"] = "weapon_combatpistol",
            ["amount"] = { 1, 1 },
        },
    },
}

-- Set the amount of cash rewarded for T2 cash piles
Config.T2_RewardCashAmount = { 500, 750 } -- [1] = min, [2] = max
