Config = {}

-- Blip Creation

Config.UseBlip = false

Config.BlipLocation = {
    {title="Shady Dealer", colour=37, id=47, x = -462.73, y = -66.37, z = 44.90},
} 

-- Ped Spawns

Config.Peds = {
    {
        type = 'donglenpc',
        position = vector4(-300.32, -1401.04, 31.3, 3.79)
    },
}

-- Menu Contents

Config.RobberyList = {
    [1] = {
        bank = true,
        Header = "Fleeca Banks",
        icon = "fa-solid fa-user-secret",
        minCops = 4,
    },
    [2] = {
        bank = true,
        Header = "Paleto Bank",
        icon = "fa-solid fa-user-secret",
        minCops = 6,
    },
    [3] = {
        bank = true,
        Header = "Pacific Bank",
        icon = "fa-solid fa-user-secret",
        minCops = 8,
    },
    [4] = {
        bank = true,
        Header = "Vangelico",
        icon = "fa-solid fa-user-secret",
        minCops = 5,
    },
}

Config.Shop = {
    [1] = {
        item = "electronickit",
        price = 5450,
        type = "crypto",
        icon = "fa-solid fa-bolt",     
    },
    [2] = {
        item = "gatecrack",
        price = 5450,
        type = "cash",
        icon = "fa-solid fa-vault",   
    },
    -- [3] = {
    --     item = "thermite",
    --     price = 5450,
    --     type = "cash",
    --     icon = "fa-solid fa-laptop-code",
    -- },
    [3] = {
        item = "trojan_usb",
        price = 5450,
        type = "cash",
        icon = "fa-brands fa-usb",   
    },
    -- [4] = {
    --     item = "drill",
    --     price = 5450,
    --     type = "cash",
    --     icon = "fa-solid fa-laptop-code",
    -- },
    [4] = {
        item = "advancedlockpick",
        price = 3500,
        type = "cash",
        icon = "fa-solid fa-lock",
    }
}
