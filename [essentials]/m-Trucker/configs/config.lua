Config = {}


Config.CoreName = 'qb-core' -- Your qb-core folder name
Config.QBTarget = "qb-target" -- Your qb-target folder name
Config.Menu = "essential-menu" -- Your qb-menu folder name
Config.Input = "qb-input" -- Your qb-input folder name
--[[ Config.JobName = "unemployed" -- Name of job ]]
Config.DeliveryText = "~g~[E]~w~ - Deliver" -- The text on qbdrawtext to deliver
Config.BossMenu = "qb-bossmenu:client:OpenMenu" -- If you use qb-management or qb-bossmenu dont change this, is the same trigger.
Config.Management = "qb-management" -- Your qb-management
Config.PaymentType = "cash" -- "cash" or "bank"

------------------
-- General Menu / Boss Menu
------------------
Config["GeneralTruckMenu"] = { -- Start a trip
    vector3(1209.72, -3121.44, 4.54)
}

Config["BoosMenuEmployee"] = { -- General Menu
    vector3(1209.31, -3115.07, 5.54)
}

------------------
-- Deliveries
------------------
Config["SmallTrip"] = { -- Small deliverie 1.0/2.0 kmh
    vector3(558.01, -1917.24, 24.25),
    vector3(374.79, -1816.48, 28.62),
    vector3(186.11, -1555.64, 28.7),
    vector3(68.23, -1428.61, 28.79),
    -- You can add more locations
}

Config["MediumTrip"] = { -- Medium deliverie 3.0/4.0 kmh
    vector3(616.83, 267.24, 102.57),
    vector3(115.81, 317.07, 111.62),
    vector3(-182.61, 314.66, 97.28),
    vector3(-710.08, -935.0, 18.5),
    -- You can add more locations
}

Config["LargeTrip"] = { -- Big deliverie +5.0 kmh
    vector3(-1879.48, 189.66, 83.48),
    vector3(-1808.4, 793.77, 137.99),
    vector3(-1498.55, 1505.98, 115.02),
    vector3(-406.24, 1183.44, 325.02),
    -- You can add more locations
}

------------------
-- Level System
------------------
Config.XP_Need_Small_Delivery = 0 -- Required amount of XP to be able to make a small delivery.
Config.XP_Need_Medium_Delivery = 250 -- Required amount of XP to be able to make a medium delivery.
Config.XP_Need_Big_Delivery = 500 -- Required amount of XP to be able to make a big delivery.
-------------------------------------------------------------------------------------------------------------
Config.XP_Small_Delivery = 5 -- Amount earned xp for a small delivery.
Config.XP_Medium_Delivery = 10 -- Amount earned xp for a medium delivery.
Config.XP_Big_Delivery = 15 -- Amount earned xp for a big delivery.
-------------------------------------------------------------------------------------------------------------
Config.Payment = {
    Type = "bank", -- "bank" or "cash"
    Player = {
        SmallDelivery = 250, -- Money the player receives after completing a Small Delivery
        MediumDelivery = 350, -- Money the player receives after completing a Medium Delivery
        BigDelivery = 450, -- Money the player receives after completing a Big Delivery
    },
    Company = {
        SmallDelivery = 250, -- Money the company receives after completing a Small Delivery
        MediumDelivery = 350, -- Money the company receives after completing a Medium Delivery
        BigDelivery = 450, --  Money the company receives after completing a Big Delivery
    }
}

---------------
-- Blips
---------------
Config.Blip = { Name = "Truck Driver", Sprite = 479, Colour = 2, Scale = 0.8 }

Config.SmallDelivery = { Name = "Small Delivery", Sprite = 436, Colour = 3, RouteColour = 3, Scale = 0.8 }

Config.MediumDelivery = { Name = "Medium Delivery", Sprite = 436, Colour = 3, RouteColour = 3 }

Config.BigDelivery = { Name = "Big Delivery", Sprite = 436, Colour = 3, RouteColour = 3 }

---------------
-- Peds
---------------
Config.PedLocation = vector3(1240.11, -3152.35, 4.53) -- Level 1 Ped
Config.PedLocation2 = vector3(1239.84, -3145.7, 4.53) -- Level 2 Ped
Config.PedLocation3 = vector3(1240.22, -3138.98, 4.53) -- Level 3 Ped
Config.PedListTrucker = {                                              
    {
        model = "mp_m_waremech_01",                            
        coords = Config.PedLocation,               
        heading = 309.14,
        gender = "male",
        scenario = "CODE_HUMAN_POLICE_INVESTIGATE"
    },
    {
        model = "mp_m_waremech_01",                            
        coords = Config.PedLocation2,               
        heading = 309.14,
        gender = "male",
        scenario = "CODE_HUMAN_POLICE_INVESTIGATE"
    },
    {
        model = "mp_m_waremech_01",                            
        coords = Config.PedLocation3,               
        heading = 309.14,
        gender = "male",
        scenario = "CODE_HUMAN_POLICE_INVESTIGATE"
    },
    {
        model = "mp_m_waremech_01",                            
        coords = vector3(1209.72, -3121.44, 4.54),               
        heading = 181.52,
        gender = "male",
        scenario = "CODE_HUMAN_MEDIC_KNEEL"
    },
}

-------------
-- Vehicleshop
-------------
Config.FuelSystem = "cdn-fuel" -- Your fuel system
Config.VehicleKeys = "vehiclekeys:client:SetOwner" -- Your trigger vehicle keys
Config.SpawnVehicle = vector4(1204.35, -3099.53, 5.86, 2.27) -- Location to spawn the vehicle
Config.PreviewVehicle = vector4(1204.35, -3099.53, 5.86, 2.27) -- Location to preview the truck
Config.SpawnTrailer = vector3(1275.12, -3159.81, 5.9) -- Location to spawn trailer
Config.HeadingTrailer = 90.47 -- Heading of the trailer
Config.Plate = "TRUCK"..tostring(math.random(111, 999)) -- Plate of truck
Config.Trailer = "trailers" -- Trailer 

-- You can add more vehicles, change the price
Config.Vehicles = {
    [1] = {
        ['vehiclename'] = "Hauler", --Name
        ['vehicle'] = "hauler", --Model
        ['price'] = 5000, --Price
    }, 
    [2] = {
        ['vehiclename'] = "Phantom", --Name
        ['vehicle'] = "phantom", --Model
        ['price'] = 18000, --Price
    },  
}


