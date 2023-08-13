Config = {}

Config.DefaultKey = 'N'
Config.framework = 'qbcore' -- qbcore / esx
Config.Notification = "%s mode applied" -- %s is the vehiclemode

Config.AuthorizedJobs = {
    "police",
}

Config.VehicleModes = { 
    "C",
    "B",
    "A",
    "S"
}

Config.VehicleModifications = { -- define each mode their own modifications
["C"] = {
    ["Turbo"] = false,
    ["XenonHeadlights"] = false,
    ["Engine"] = 4,
    ["Brakes"] = 3,
    ["Transmission"] = 3,
    ["XenonHeadlightsColor"] = 0,
},
["B"] = {
    ["Turbo"] = false,
    ["XenonHeadlights"] = false,
    ["Engine"] = 4,
    ["Brakes"] = 3,
    ["Transmission"] = 3,
    ["XenonHeadlightsColor"] = 0,
},
["A"] = {
    ["Turbo"] = true,
    ["XenonHeadlights"] = true,
    ["Engine"] = 4,
    ["Brakes"] = 3,
    ["Transmission"] = 3,
    ["XenonHeadlightsColor"] = 8,--Red
},
["S"] = {
    ["Turbo"] = true,
    ["XenonHeadlights"] = true,
    ["Engine"] = 4,
    ["Brakes"] = 3,
    ["Transmission"] = 3,
    ["XenonHeadlightsColor"] = 1, --Royal Blue
}
}

 Config.VehiclesConfig = {
    ["Code311cvpi"] = {
        ["C"] = {
            ["fInitialDragCoeff"] = 4.5000,
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.70000,
            ["fInitialDriveMaxFlatVel"] = 200.000000,
            ["fSteeringLock"] = 40.0,
            ["fInitialDriveForce"] = 0.500000
        },
        ["B"] = {
            ["fInitialDragCoeff"] = 3.5000,
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.75000,
            ["fInitialDriveMaxFlatVel"] = 320.000000,
            ["fSteeringLock"] = 40.0,
            ["fInitialDriveForce"] = 0.6960000
        },
        ["A"] = {
            ["fInitialDragCoeff"] = 3.000,
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.800000,
            ["fInitialDriveMaxFlatVel"] = 300.0000,
            ["fSteeringLock"] = 40.0,
            ["fInitialDriveForce"] = 0.74000
        },
        ["S"] = {
            ["fInitialDragCoeff"] = 3.000,
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.7500000,
            ["fInitialDriveMaxFlatVel"] = 309.000000,
            ["fSteeringLock"] = 40.0,
            ["fInitialDriveForce"] = 0.875000
        }
    },
    ["Code318Charger"] = {
        ["C"] = {
            ["fInitialDragCoeff"] = 4.5000,
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.4000000,
            ["fInitialDriveMaxFlatVel"] = 120.000000,
            ["fSteeringLock"] = 40.0,
            ["fInitialDriveForce"] = 0.430000
        },
        ["B"] = {
            ["fInitialDragCoeff"] = 3.5000,
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.5500000,
            ["fInitialDriveMaxFlatVel"] = 280.000000,
            ["fSteeringLock"] = 40.0,
            ["fInitialDriveForce"] = 0.680000
        },
        ["A"] = {
            ["fInitialDragCoeff"] = 3.000,
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.6500000,
            ["fInitialDriveMaxFlatVel"] = 300.0000,
            ["fSteeringLock"] = 40.0,
            ["fInitialDriveForce"] = 0.745000
        },
        ["S"] = {
            ["fInitialDragCoeff"] = 2.885,
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.7500000,
            ["fInitialDriveMaxFlatVel"] = 360.000000,
            ["fSteeringLock"] = 40.0,
            ["fInitialDriveForce"] = 0.835000
        }
    },

   
    
--[[     ["police"] = {  -- this is an example of how to add more cars.
        ["C"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 145.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.285
        },
        ["B"] = {
            ["fDriveInertia"] = 1.100000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 150.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.29
        },
        ["A"] = {
            ["fDriveInertia"] = 1.15,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 165.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.30
        },
        ["S"] = {
            ["fDriveInertia"] = 1.17,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 179.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.45
        }
    }, ]]
    ["police2"] = {
        ["C"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 145.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.285
        },
        ["B"] = {
            ["fDriveInertia"] = 1.100000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 150.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.29
        },
        ["A"] = {
            ["fDriveInertia"] = 1.15,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 165.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.30
        },
        ["S"] = {
            ["fDriveInertia"] = 1.17,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 179.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.45
        }
    },
    ["police3"] = {
        ["C"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 145.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.285
        },
        ["B"] = {
            ["fDriveInertia"] = 1.100000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 150.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.29
        },
        ["A"] = {
            ["fDriveInertia"] = 1.15,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 165.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.30
        },
        ["S"] = {
            ["fDriveInertia"] = 1.17,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 179.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.45
        }
    },
    ["police4"] = {
        ["C"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 145.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.285
        },
        ["B"] = {
            ["fDriveInertia"] = 1.100000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 150.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.29
        },
        ["A"] = {
            ["fDriveInertia"] = 1.15,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 165.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.30
        },
        ["S"] = {
            ["fDriveInertia"] = 1.17,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 179.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.45
        }
    },
    ["fbi"] = {
        ["C"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 145.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.285
        },
        ["B"] = {
            ["fDriveInertia"] = 1.100000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 150.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.29
        },
        ["A"] = {
            ["fDriveInertia"] = 1.15,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 165.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.30
        },
        ["S"] = {
            ["fDriveInertia"] = 1.17,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 179.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.45
        }
    },
    ["fbi2"] = {
        ["C"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 145.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.285
        },
        ["B"] = {
            ["fDriveInertia"] = 1.100000,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 150.000000,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.29
        },
        ["A"] = {
            ["fDriveInertia"] = 1.15,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 165.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.30
        },
        ["S"] = {
            ["fDriveInertia"] = 1.17,
            ["fBrakeForce"] = 0.900,
            ["fInitialDriveMaxFlatVel"] = 179.0,
            ["fSteeringLock"] = 40.00,
            ["fInitialDriveForce"] = 0.45
        }
    }
}