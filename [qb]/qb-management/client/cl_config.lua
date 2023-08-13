-- Zones for Menues
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    ['police'] = {
        vector3(461.45, -986.2, 30.73),
    },
    ['ambulance'] = {
        vector3(335.46, -594.52, 43.28),
    },
    ['realestate'] = {
        vector3(-716.11, 261.21, 84.14),
    },
    ['taxi'] = {
        vector3(907.24, -150.19, 74.17),
    },
    ['cardealer'] = {
        vector3(-27.47, -1107.13, 27.27),
    },
    ['mechanic'] = {
        vector3(-339.53, -156.44, 44.59),
    },
    ['gasmonkey'] = {
        vector3(-1427.09, -458.48, 35.91),
    },

    
}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(461.45, -986.2, 30.73), length = 0.35, width = 0.45, heading = 351.0, minZ = 30.58, maxZ = 30.68 } ,
    },
    ['ambulance'] = {
        { coords = vector3(335.46, -594.52, 43.28), length = 1.2, width = 0.6, heading = 341.0, minZ = 43.13, maxZ = 43.73 },
    },
    ['realestate'] = {
        { coords = vector3(-716.11, 261.21, 84.14), length = 0.6, width = 1.0, heading = 25.0, minZ = 83.943, maxZ = 84.74 },
    },
    ['taxi'] = {
        { coords = vector3(907.24, -150.19, 74.17), length = 1.0, width = 3.4, heading = 327.0, minZ = 73.17, maxZ = 74.57 },
    },
    ['cardealer'] = {
        { coords = vector3(-27.47, -1107.13, 27.27), length = 2.4, width = 1.05, heading = 340.0, minZ = 27.07, maxZ = 27.67 },
    },
    ['mechanic'] = {
        { coords = vector3(-339.53, -156.44, 44.59), length = 1.15, width = 2.6, heading = 353.0, minZ = 43.59, maxZ = 44.99 },
    },
    ['gasmonkey'] = {
        { coords = vector3(-1427.09, -458.48, 35.91), length = 1, width = 1, heading = 300.0, minZ = 32.11, maxZ = 36.11 },
    },
}

Config.GangMenus = {
    ['zt'] = {
        vector3(-1568.74, -233.61, 49.44),
    },
    ['ns'] = {
        vector3(-161.51, -1625.23, 33.66),
    },
    ['lostmc'] = {
        vector3(103.28, 3604.67, 40.49),
    },
    ['ballas'] = {
        vector3(0.41, -1810.63, 29.15),
    },
    ['vagos'] = {
        vector3(328.04, -2000.87, 24.21),
    },
    ['aztecas'] = {
        vector3(484.73, -1534.99, 29.29),
    },
    ['families'] = {
        vector3(-164.34, -1617.67, 33.65),
    },
    ['marabunta'] = {
        vector3(1249.26, -1581.83, 58.35),
    },
    ['altruists'] = {
        vector3(-1108.76, 4939.55, 223.13),
    },
    ['triads'] = {
        vector3(-645.9, -1242.79, 11.55),
    },
}

Config.GangMenuZones = {
    
    ['zt'] = {
        { coords = vector3(-1568.74, -233.61, 49.44), length = 1, width = 1, heading = 330, minZ = 45.84, maxZ = 49.84, },
    },
    ['ns'] = {
        { coords = vector3(-161.51, -1625.23, 33.66), length = 1, width = 1, heading = 325, minZ = 29.86, maxZ = 33.86, },
    },
    ['ballas'] = {
        { coords = vector3(0.41, -1810.63, 29.15), length = 1, width = 1, heading = 320, minZ = 25.35, maxZ = 29.35, },
    },
    
}
