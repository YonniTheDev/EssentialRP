Config = {}

Config.setupMenu = 'qb-menu' -- qb-menu / nh-context

Config.vehicleList = {
    { name = "Futo", model = "Futo", price = 250 },
    { name = "Bison", model = "Bison", price = 300 },
    { name = "Sanchez", model = "Sanchez", price = 350 },
}


-- Blips 
Config.Locations = {
    ["rentalstations"] = {
        [1] = {label = "Rental Station", coords =  vector4(-1993.7271728516, -331.87377929688, 48.106292724609, 60.919219970703)},
        -- [2] = {label = "Rental Stations", coords = vector4(462.75, -1676.62, 29.29, 5.02)},
        -- [3] = {label = "Rental Stations", coords = vector4(-1442.49, -673.65, 26.53, 288.07)},
    },
}

Config.vehicleSpawn = {
    --- Cresten Rentals
	[1] = { 
		workSpawn = {
			coords = vector3(-2002.8131103516, -328.23254394531, 47.58419418335),
			heading = 344.69,
		},
	},
--     --- Davis 
--     [2] = { 
-- 		workSpawn = {
-- 			coords = vector3(460.1, -1699.62, 29.3),
-- 			heading = 323.94,
-- 		},
-- 	},
--  --- Marathon Avenue
--     [3] = { 
-- 		workSpawn = {
-- 			coords = vector3(-1444.12, -680.25, 26.39),
-- 			heading = 122.5,
-- 		},
-- 	},
}


-- Addding Exports to your QB-Target Can be found at client.lua
