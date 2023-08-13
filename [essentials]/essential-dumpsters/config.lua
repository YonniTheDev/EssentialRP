Config = {}

Config.Props = {
    `prop_dumpster_4b`,
    `prop_dumpster_4a`,
    `prop_dumpster_3a`,
    `prop_dumpster_02b`,
    `prop_dumpster_02a`,
    `prop_dumpster_01a`,
    `prop_snow_dumpster_01`
}


-- ## Reset Configs
Config.ResetOnReboot = false
Config.ResetTime = 1 -- If Config.ResetOnReboot = false. In minutes

-- ## Minigame Configs
Config.Minigame = 'qb-lock' -- Available options: false, 'ps-ui', 'memorygame', 'ps-ui'

-- ## Time Configs
Config.ProgressTime = 3 -- In secondes

-- ## Police Configs
Config.Illegal = false -- True will send an alert using the % on Config.AlertChance
Config.AlertChance = 10
Config.Dispatch = 'ps-dispatch' -- Available options: 'ps-dispatch' or 'qb-core'

-- ## Hurting Configs
Config.Hurting = false -- True will give a chance to the player to be hurt
Config.HurtChance = 40 -- If Config.Hurting = true. In percentage
Config.CanBleed = false -- Can the player bleed? / Requires qb-ambulancejob
Config.BleedChance = 30 -- If Config.CanBleed = true. In percentage
Config.HurtDamage = {
    min = 5,
    max = 15,
}

-- ## Loot table
Config.CanLootMultiple = true -- Can the player loot multiple items?
Config.MaxLootItem = 2 -- If Config.CanLootMultiple = true. Max items the player can loot
Config.Loottable = {
    [1] = {item = 'pistol_ammo',         chances = 2,    min = 1,    max = 3},
    [2] = {item = 'joint',          chances = 40,   min = 1,    max = 3},
    [3] = {item = 'packagedweed',     chances = 25,   min = 1,    max = 3},
    [4] = {item = 'steel',              chances = 27,   min = 3,    max = 5},
    [5] = {item = 'advancedlockpick',   chances = 1,    min = 1,    max = 3},
    [6] = {item = 'weedplant_seedf',   chances = 40,    min = 2,    max = 4},
}
