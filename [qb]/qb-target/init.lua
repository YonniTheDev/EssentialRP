function Load(name)
	local resourceName = GetCurrentResourceName()
	local chunk = LoadResourceFile(resourceName, ('data/%s.lua'):format(name))
	if chunk then
		local err
		chunk, err = load(chunk, ('@@%s/data/%s.lua'):format(resourceName, name), 't')
		if err then
			error(('\n^1 %s'):format(err), 0)
		end
		return chunk()
	end
end

-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------

Config = {}

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 7.0

-- Enable debug options
Config.Debug = false

-- Supported values: true, false
Config.Standalone = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Whether to have the target as a toggle or not
Config.Toggle = false

-- Draw a Sprite on the center of a PolyZone to hint where it's located
Config.DrawSprite = false

-- The default distance to draw the Sprite
Config.DrawDistance = 2.5

-- The color of the sprite in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.DrawColor = {255, 255, 255, 255}

-- The color of the sprite in rgb when the PolyZone is targeted, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.SuccessDrawColor = {218, 112, 214}

-- The color of the outline in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.OutlineColor = {255, 255, 255, 255}

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = true

-- Disable the target eye whilst being in a vehicle
Config.DisableInVehicle = true

-- Key to open the target eye, here you can find all the names: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenKey = 'LMENU' -- Left Alt

-- Control for key press detection on the context menu, it's the Right Mouse Button by default, controls are found here https://docs.fivem.net/docs/game-references/controls/
Config.MenuControlKey = 237

-------------------------------------------------------------------------------
-- Target Configs
-------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {

}

Config.BoxZones = {

	["Police Armory"] = {
        name = "PoliceArmory",
        coords = vector3(479.83, -996.66, 30.69),
        length = 1,
        width = 1,
        heading = 0,
        debugPoly = false,
        minZ=26.89,
        maxZ=30.89,
        options = {
            {
                event = "qb-police:client:openArmoury",
                icon = "fa-solid fa-shield-halved",
                label = "Open PD Armory",
                job = "police",
            },
        },
        distance = 3.5
    },
    ["Police Fingerprint"] = {
        name = "Police Fingerprint",
        coords = vector3(473.17, -1006.71, 26.27),
        length = 1,
        width = 1,
        heading = 0,
        debugPoly = false,
        minZ=22.47,
        maxZ=26.47,
        options = {
            {
                event = "qb-police:client:scanFingerPrint",
                icon = "fa-solid fa-shield-halved",
                label = "Scan Fingerprint",
                job = "police",
            },
        },
        distance = 3.5
    },
	["Start Chop Job"] = {
        name = "ChopShop",
        coords = vector3(-559.95, -1805.36, 22.61),
        length = 2,
        width = 2,
        heading = 335,
        debugPoly = false,
        minZ=20.01,
        maxZ=24.01,
        options = {
            {
                event = "renewed-chopshop:server:Startjob",
                icon = "fas fa-car",
                label = "Locate A Vehicle",
                job = "all",
            },
        },
        distance = 2.5
    },
	["Police Duty"] = {
        name = "PoliceDuty",
        coords = vector3(442.09, -982.03, 30.69),
        length = 1,
        width = 1,
        heading = 0,
        debugPoly = false,
        minZ=27.09,
        maxZ=31.09,
        options = {
            {
                event = "qb-policejob:ToggleDuty",
                icon = "fa-solid fa-shield-halved",
                label = "Clock On",
                job = "police",
            },
        },
        distance = 3.5
    },
    ["PD Garage"] = {
        name = "PD Garage",
        coords = vector3(441.39, -974.64, 25.7),
        length = 1,
        width = 1,
        heading = 0,
        debugPoly = false,
        minZ=22.5,
        maxZ=26.5,
        options = {
            {
                event = "garage:menu",
                icon = "fa-solid fa-warehouse",
                label = "Open Vehicle Garage",
                job = "police",
            },
        },
        distance = 3.5
    },
    ["PD Evidence"] = {
        name = "PD Evidence",
        coords = vector3(472.63, -990.89, 26.27),
        length = 2,
        width = 1,
        heading = 0,
        debugPoly = false,
        minZ=23.07,
        maxZ=27.07,
        options = {
            {
                event = "police:client:EvidenceStashDrawer",
                icon = "fa-solid fa-folder",
                label = "Open Evidence Locker",
                job = "police",
            },
        },
        distance = 4.5
    },
    ["EMS Evidence"] = {
        name = "EMS Evidence",
        coords = vector3(310.39379882813, -603.03033447266, 43.284038543701),
        length = 2,
        width = 1,
        heading = 0,
        debugPoly = false,
        minZ=40.68,
        maxZ=44.68,
        options = {
            {
                event = "qb-ambulancejob:armory",
                icon = "fa-solid fa-folder",
                label = "Open EMS Armory",
                job = "ambulance",
            },
        },
        distance = 4.5
    },
    --[[ ["Store Safe Innocence"] = {
        name = "Store Safe Innocence",
        coords = vector3(28.19, -1338.43, 29.5),
        length = 1,
        width = 1,
        heading = 0,
        debugPoly = false,
        minZ=25.5,
        maxZ=29.5,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Grove Safe"] = {
        name = "Grove Safe",
        coords = vector3(-43.98, -1748.01, 29.42),
        length = 1,
        width = 1,
        heading = 320,
        debugPoly = false,
        minZ=25.62,
        maxZ=29.62,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Vespucci Popular Safe"] = {
        name = "Vespucci Popular Safe",
        coords = vector3(1126.69, -979.44, 45.39),
        length = 1,
        width = 1,
        heading = 10,
        debugPoly = false,
        minZ=41.99,
        maxZ=45.99,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Mirror Safe"] = {
        name = "Mirror Safe",
        coords = vector3(1158.71, -314.15, 69.21),
        length = 1,
        width = 1,
        heading = 10,
        debugPoly = false,
        minZ=65.21,
        maxZ=69.21,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Big Bank Store Safe"] = {
        name = "Big Bank Store Safe",
        coords = vector3(378.32, 334.1, 103.57),
        length = 1,
        width = 1,
        heading = 345,
        debugPoly = false,
        minZ=99.57,
        maxZ=103.57,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Little Seoul Safe"] = {
        name = "Little Seoul Safe",
        coords = vector3(-710.49, -904.2, 19.22),
        length = 1,
        width = 1,
        heading = 0,
        debugPoly = false,
        minZ=15.22,
        maxZ=19.22,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Burgershot store safe"] = {
        name = "Burgershot store safe",
        coords = vector3(-1221.42, -916.43, 11.33),
        length = 1,
        width = 1,
        heading = 305,
        debugPoly = false,
        minZ=7.93,
        maxZ=11.93,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Cougar Store Safe"] = {
        name = "Cougar Store Safe",
        coords = vector3(-1478.43, -375.94, 39.14),
        length = 1,
        width = 1,
        heading = 315,
        debugPoly = false,
        minZ=35.74,
        maxZ=39.74,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["North Rockford Store"] = {
        name = "North Rockford Store",
        coords = vector3(-1829.76, 798.25, 138.17),
        length = 1,
        width = 1,
        heading = 315,
        debugPoly = false,
        minZ=134.17,
        maxZ=138.17,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Great Ocean Safe #1"] = {
        name = "Great Ocean Safe #1",
        coords = vector3(-2959.69, 386.39, 14.04),
        length = 1,
        width = 1,
        heading = 355,
        debugPoly = false,
        minZ=10.64,
        maxZ=14.64,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Great Ocean Safe #2"] = {
        name = "Great Ocean Safe #2",
        coords = vector3(-3048.52, 585.35, 7.91),
        length = 1,
        width = 1,
        heading = 20,
        debugPoly = false,
        minZ=3.91,
        maxZ=7.91,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Great Ocean Safe #3"] = {
        name = "Great Ocean Safe #3",
        coords = vector3(-3250.76, 1004.47, 12.83),
        length = 1,
        width = 1,
        heading = 355,
        debugPoly = false,
       minZ=8.83,
       maxZ=12.83,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Harmoney Left Side Safe #1"] = {
        name = "Harmoney Left Side Safe #1",
        coords = vector3(546.55, 2662.02, 42.16),
        length = 1,
        width = 1,
        heading = 5,
        debugPoly = false,
        minZ=38.16,
        maxZ=42.16,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Harmony #2 Right side Safe"] = {
        name = "Harmony #2 Right side Safe",
        coords = vector3(1169.98, 2717.84, 37.16),
        length = 1,
        width = 1,
        heading = 0,
        debugPoly = false,
        minZ=33.76,
        maxZ=37.76,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Sandy Safe #1 "] = {
        name = "Sandy Safe #1 ",
        coords = vector3(1958.89, 3749.52, 32.34),
        length = 1,
        width = 1,
        heading = 300,
        debugPoly = false,
        minZ=28.34,
        maxZ=32.34,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["LS Freeway by Hardware Safe "] = {
        name = "LS Freeway by Hardware Safe ",
        coords = vector3(2672.1, 3286.95, 55.24),
        length = 1,
        width = 1,
        heading = 330,
        debugPoly = false,
        minZ=51.24,
        maxZ=55.24,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Grapeseed Safe"] = {
        name = "Grapeseed Safe",
        coords = vector3(1708.36, 4921.08, 42.06),
        length = 1,
        width = 1,
        heading = 325,
        debugPoly = false,
        minZ=38.06,
        maxZ=42.06,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Above Grapeseed Safe"] = {
        name = "Above Grapeseed Safe",
        coords = vector3(1735.12, 6421.39, 35.04),
        length = 1,
        width = 1,
        heading = 335,
        debugPoly = false,
        minZ=31.04,
        maxZ=35.04,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["Palomino Safe"] = {
        name = "Palomino Safe",
        coords = vector3(1735.12, 6421.39, 35.04),
        length = 1,
        width = 1,
        heading = 0,
        debugPoly = false,
        minZ=104.62,
        maxZ=108.62,
        options = {
            {
                type = "client",
                event = "essential-storerobbery:client:checkmoney",
                icon = "fas fa-lock",
                label = "Break Open Safe",
            },
            {
                type = "client",
                event = "essential-storerobbery:client:collectsafe",
                icon = "fas fa-lock",
                label = "Grab Goods",
            },
        },
        distance = 4.5
    },
    ["legion bank cart #2"] = {
        name = "legion bank cart #2",
        coords = vector3(151.28, -1046.71, 29.35),
        length = 1,
        width = 1,
        heading = 0,
        debugPoly = false,
        minZ=25.55,
        maxZ=29.55,
        options = {
            {
                type = "client",
                event = "qb-bankrobbery:grabcash",
                icon = "fas fa-lock",
                label = "Grab Loot",
            },
        },
        distance = 2.5
    }, ]]
    ["GunBenchExit"] = {
        name = "GunBenchExit",
        coords = vector3(730.24, 2531.9, 73.23),
        length = 1,
        width = 1,
        heading=0,
        -- debugPoly=false,
        minZ=70.21,
        maxZ=74.21,
        options = {
          {
            type = "client",
            event = "GunBenchExit",
            icon = "fa-solid fa-user-secret",
            label = "Call Room Service",
          },
        },
        distance = 2.2
      },
      ["GunBenchEnter"] = {
        name = "GunBenchEnter",
        coords = vector3(179.01, -999.67, -99.0),
        length = 0.4,
        width = 1,
        heading=0,
        -- debugPoly=false,
        minZ=-102.4,
        maxZ=-98.4,
        options = {
          {
            type = "client",
            event = "GunBenchEnter",
            icon = "fa-solid fa-user-secret",  
            label = "Call Elevator",
          },
        },
        distance = 2.2
      },
    
	
	
	

}

Config.PolyZones = {

}

Config.TargetBones = {
    ["main"] = {
        bones = {
            "door_dside_f",
            "door_dside_r",
            "door_pside_r",
            "door_pside_f",
            
        },
        options = {
            {
                type = "client",
                event = "police:client:PutPlayerInVehicle",
                icon = "fas fa-user-plus",
                label = "Place In Vehicle",
            },
            {
                type = "client",
                event = "police:client:SetPlayerOutVehicle",
                icon = "fas fa-user-minus",
                label = "Take Out Vehicle",
            },
            {
                type = "client",
                event = "qb-policejob:copimpound",  
                icon = "fas fa-car",
                label = "Impound Vehicle",
                job = 'police'
            },
            {
                type = "client",
                event = "qb-policejob:towimpound",
                icon = "fas fa-car",
                label = "Impound",
                job = 'tow'
            },
            {
                type = "client",
                event = "qb-targer:client:flipvehicle",
                icon = "fas fa-car",
                label = "Flip Vehicle",
            },
        },
        distance = 2.5
    },
	--[[ ["trunk"] = {
        bones = {
            "boot"
        },
		options = {
            {
                type = "client",
                event = ":OpenTrunk",
                icon = "fas fa-chevron-circle-left",
                label = "Open Trunk",
            },
		},
		distance = 2.5
	}, ]]

        
		
		

}

Config.TargetModels = {

    ["VehicleRental"] = {
        models = {
            `a_m_y_business_03`,
        },
        options = {
            {
                type = "client",
                event = "qb-rental:openMenu",
                icon = "fas fa-car",
                label = "Rent Vehicle",
            },
        },
        distance = 4.0
    },

	

	

}

Config.GlobalPedOptions = {
		options = {
			{
				type = 'client',
				event = 'qb-methcar:cook',
				icon = 'fas fa-blender',
				label = 'Lets cook!',
				canInteract = function(entity)
					if GetVehicleEngineHealth(entity) <= 0 then return false end
						local model = GetEntityModel(entity)
						local modelName = GetDisplayNameFromVehicleModel(model)
						if modelName == 'JOURNEY' then
						return true
					end
					return false
				end
			},
		},
		distance = 2.0,
	

}

Config.GlobalVehicleOptions = {

--[[     options = {
        {
            type = "client",
            event = "vehiclekeys:client:GiveKeys",
            icon = "fas fa-key",
            label = "Give Keys",
        },
        {
            type = "client",
            event = "police:client:PutPlayerInVehicle",
            icon = "fas fa-chevron-circle-left",
            label = "Place In Vehicle",
        },
        {
            type = "client",
            event = "police:client:SetPlayerOutVehicle",
            icon = "fas fa-chevron-circle-right",
            label = "Take Out Of Vehicle",
        },
        {
            type = "client",
            event = "angelicxs-flipcar:flipcar",
            icon = "fas fa-arrow-up",
            label = "Flip Vehicle",
        },
    },
    distance = 3.0 ]]
}



Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {
    
    options = {
        {
            type = "client",
            event = "qb-phone:client:GiveContactDetails",
            icon = "fas fa-address-book",
            label = "Give Contact Details",
        },
       --[[  {
            event = "police:client:RobPlayer",
            icon = "fas fa-user-secret",
            label = "Rob Player",
        }, ]]
        {
            type = "client",
            event = "police:client:CuffPlayer",
            icon = "fas fa-hands",
            label = "Cuff / Uncuff",
            job = "police",
            item = 'handcuffs',
        },

}

}

Config.Peds = {

	{ ------------Tuner Shop-------------
        model = 'mp_m_waremech_01',
        coords = vector4(129.98, -3032.27, 7.04, 245.31),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
		minusOne = true,
    },
	{ ------------armory pd-------------
        model = 's_m_m_security_01',
        coords = vector4(480.32, -996.68, 30.69, 90.21),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
		minusOne = true,
    },
	{ -----------Rentals-------------
        model = 'cs_barry',
        coords = vector4(-1993.3103027344, -332.19323730469, 48.106353759766, 54.288589477539),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
		minusOne = true,
        scenario = 'WORLD_HUMAN_CLIPBOARD',
    },
    { -----------PD Garage-------------
        model = 's_m_m_security_01',
        coords = vector4(441.4, -974.7, 25.7, 186.77),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
		minusOne = true,
        scenario = 'WORLD_HUMAN_CLIPBOARD',
    },
    { -----------PD Garage-------------
        model = 's_f_y_cop_01',
        coords = vector4(472.51, -991.22, 26.27, 270.19),
        gender = 'male',
        freeze = true,
        invincible = true,
        blockevents = true,
		minusOne = true,
        scenario = 'WORLD_HUMAN_CLIPBOARD',
    },




	
	
	



}

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
local function JobCheck() return true end
local function GangCheck() return true end
local function ItemCheck() return true end
local function CitizenCheck() return true end

CreateThread(function()
	local state = GetResourceState('qb-core')
	if state ~= 'missing' then
		local timeout = 0
		while state ~= 'started' and timeout <= 100 do
			timeout += 1
			state = GetResourceState('qb-core')
			Wait(0)
		end
		Config.Standalone = false
	end
	if Config.Standalone then
		local firstSpawn = false
		local event = AddEventHandler('playerSpawned', function()
			SpawnPeds()
			firstSpawn = true
		end)
		-- Remove event after it has been triggered
		while true do
			if firstSpawn then
				RemoveEventHandler(event)
				break
			end
			Wait(1000)
		end
	else
		local QBCore = exports['qb-core']:GetCoreObject()
		local PlayerData = QBCore.Functions.GetPlayerData()

		ItemCheck = QBCore.Functions.HasItem

		JobCheck = function(job)
			if type(job) == 'table' then
				job = job[PlayerData.job.name]
				if job and PlayerData.job.grade.level >= job then
					return true
				end
			elseif job == 'all' or job == PlayerData.job.name then
				return true
			end
			return false
		end

		GangCheck = function(gang)
			if type(gang) == 'table' then
				gang = gang[PlayerData.gang.name]
				if gang and PlayerData.gang.grade.level >= gang then
					return true
				end
			elseif gang == 'all' or gang == PlayerData.gang.name then
				return true
			end
			return false
		end

		CitizenCheck = function(citizenid)
			return citizenid == PlayerData.citizenid or citizenid[PlayerData.citizenid]
		end

		RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
			PlayerData = QBCore.Functions.GetPlayerData()
			SpawnPeds()
		end)

		RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
			PlayerData = {}
			DeletePeds()
		end)

		RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
			PlayerData.job = JobInfo
		end)

		RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
			PlayerData.gang = GangInfo
		end)

		RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
			PlayerData = val
		end)
	end
end)

local function flipVehicle(vehicle)
	local rot = GetEntityRotation(vehicle)
	SetEntityRotation(vehicle, rot.x, rot.y+ 180, rot.z)
end
  
RegisterNetEvent('qb-targer:client:flipvehicle', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    if DoesEntityExist(vehicle) then
        exports['progressbar']:Progress({
            name = "flipping_vehicle",
            duration = 5000,
            label = "Fliping Vehicle...",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "random@mugging4",
                anim = "struggle_loop_b_thief",
                flags = 49,
            }
        }, function(status)
            -- SetVehicleOnGroundProperly(vehicle)
			flipVehicle(vehicle)
			SetVehicleOnGroundProperly(vehicle)
        end)
    else
        exports['ps-ui']:Notify('No vehicle nearby', 'error', 2500) 
    end
end)

function CheckOptions(data, entity, distance)
	if distance and data.distance and distance > data.distance then return false end
	if data.job and not JobCheck(data.job) then return false end
	if data.gang and not GangCheck(data.gang) then return false end
	if data.item and not ItemCheck(data.item) then return false end
	if data.citizenid and not CitizenCheck(data.citizenid) then return false end
	if data.canInteract and not data.canInteract(entity, distance, data) then return false end
	return true
end