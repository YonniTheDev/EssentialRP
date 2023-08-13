local QBCore = exports[Config.CoreName]:GetCoreObject()


CreateThread(function()
    for k, v in pairs(Config["GeneralTruckMenu"]) do
        name = "Trucker1"..k
        exports[Config.QBTarget]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 1, {
            name= name,
            heading = 0,
            minZ = v.z-1,
            maxZ = v.z+1,
        }, {
            options = {
                { event = "m-TruckerJob:client:OpenGeneralMenu", icon = Language["QBTarget"]["IconInformation"], label = Language["QBTarget"]["Information"],
                    
                },
            },
            distance = 2.0,
        })
    end

    for k, v in pairs(Config["SmallTrip"]) do
        name = "Trucker2"..k
        exports[Config.QBTarget]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 5.2, {
            name= name,
            heading = 22,
            minZ = v.z-1,
            maxZ = v.z+1,
        }, {
            options = {
                { event = "m-TruckerJob:client:DeliverSmallTrip", icon = Language["QBTarget"]["IconDelivery"], label = Language["QBTarget"]["Delivery"],
                    
                },
            },
            distance = 2.0,
        })
    end

    for k, v in pairs(Config["MediumTrip"]) do
        name = "Trucker3"..k
        exports[Config.QBTarget]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 5.2, {
            name= name,
            heading = 22,
            minZ = v.z-1,
            maxZ = v.z+1,
        }, {
            options = {
                { event = "m-TruckerJob:client:DeliverMediumTrip", icon = Language["QBTarget"]["IconDelivery"], label = Language["QBTarget"]["Delivery"],
                    
                },
            },
            distance = 2.0,
        })
    end

    for k, v in pairs(Config["LargeTrip"]) do
        name = "Trucker4"..k
        exports[Config.QBTarget]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 5.2, {
            name= name,
            heading = 22,
            minZ = v.z-1,
            maxZ = v.z+1,
        }, {
            options = {
                { event = "m-TruckerJob:client:DeliverLargeTrip", icon = Language["QBTarget"]["IconDelivery"], label = Language["QBTarget"]["Delivery"], 
                    
                },
            },
            distance = 2.0,
        })
    end
    exports[Config.QBTarget]:AddBoxZone("Trucker1", Config.PedLocation, 1, 1.2, {
        name= "Trucker5",
        heading = 22,
        minZ = Config.PedLocation-1,
        maxZ = Config.PedLocation+1,
    }, {
        options = {
            { event = "m-TruckerJob:client:EraseCar1", icon = Language["QBTarget"]["IconVehicle"], label = Language["QBTarget"]["PayslipLv1"],
                item = "trucker_contractlvl1", 
            },
        },
        distance = 8.0,
    })
    exports[Config.QBTarget]:AddBoxZone("Trucker2", Config.PedLocation2, 1, 1.2, {
        name= "Trucker5",
        heading = 22,
        minZ = Config.PedLocation2-1,
        maxZ = Config.PedLocation2+1,
    }, {
        options = {
            { event = "m-TruckerJob:client:EraseCar2", icon = Language["QBTarget"]["IconVehicle"], label = Language["QBTarget"]["PayslipLv2"],
                item = "trucker_contractlvl2", 
            },
        },
        distance = 8.0,
    })
    exports[Config.QBTarget]:AddBoxZone("Trucker3", Config.PedLocation3, 1, 1.2, {
        name= "Trucker5",
        heading = 22,
        minZ = Config.PedLocation3-1,
        maxZ = Config.PedLocation3+1,
    }, {
        options = {
            { event = "m-TruckerJob:client:EraseCar3", icon = Language["QBTarget"]["IconVehicle"], label = Language["QBTarget"]["PayslipLv3"],
                item = "trucker_contractlvl3", 
            },
        },
        distance = 8.0,
    })

    for k, v in pairs(Config["BoosMenuEmployee"]) do
        name = "GeneralMenu"..k
        exports[Config.QBTarget]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 1, {
            name= name,
            heading = 0,
            minZ = v.z-1,
            maxZ = v.z+1,
        }, {
            options = {
                { event = "m-TruckerJob:client:General", icon = "fa-solid fa-stairs", label = Language["QBTarget"]["GeneralMenu"],
                    
                },
            },
            distance = 2.0,
        })
    end
end)

CreateThread(function()
    for k, v in pairs(Config["GeneralTruckMenu"]) do
        local blip = AddBlipForCoord(vector3(v.x, v.y, v.z)) 
        SetBlipSprite(blip, Config.Blip.Sprite) 
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.Blip.Scale)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, Config.Blip.Colour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Blip.Name) 
        EndTextCommandSetBlipName(blip)
    end
end)