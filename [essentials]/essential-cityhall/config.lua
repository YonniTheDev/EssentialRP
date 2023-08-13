QBCore = exports['qb-core']:GetCoreObject()

Config = {}

-- Ped spawner
Config.ped = {
    enabled = true,
    model = "cs_fbisuit_01",
    coords = vector4(-551.95013427734, -192.18478393555, 37.227001190186, 205.00018310547),
    scenario = WORLD_HUMAN_CLIPBOARD,
    label = "Open cityhall"
}

Config.blip = {
    enabled = true,
    Name = "Cityhall",
    SpriteId = 438,
    Color = 0,
    Scale = 0.8,
    ShortRange = true,
    Alpha = 255,
    Coords = vector3(-551.95013427734, -192.18478393555, 38.227001190186)
}

-- Jobs for hire
Config.jobs = {
    -- {
    --     job = "trucker",
    --     label = "Trucker",
    --     salary = 50
    -- },
    {
        job = "taxi",
        label = "Taxi",
        salary = 50
    },
    -- {
    --     job = "tow",
    --     label = "Tow Truck",
    --     salary = 50
    -- },
    {
        job = "reporter",
        label = "News Reporter",
        salary = 50
    },
}

-- Items for purchase
Config.items = {{
    item = "id_card",
    meta = 'id',
    label = "ID Card",
    price = 100
}, {
    item = "driver_license",
    label = "Driver License",
    meta = 'driver',
    price = 100
}, {
    item = "weaponlicense",
    label = "Weapon License",
    meta = 'weapon',
    price = 100
}}

-- Items shown in the information tab
Config.licenseItems = {{
    item = 'id_card',
    label = 'ID Card'
}, {
    item = 'driver_license',
    label = 'Driver License'
}, {
    item = 'weaponlicense',
    label = 'Weapon License'
}}
