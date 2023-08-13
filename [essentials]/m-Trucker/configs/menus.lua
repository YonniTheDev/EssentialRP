local QBCore = exports[Config.CoreName]:GetCoreObject()

AddEventHandler('m-TruckerJob:client:OpenGeneralMenu', function()
    exports[Config.Menu]:openMenu({
        {header = Language["QBMenu"]["Information"],isMenuHeader = true},
        {header = Language["QBMenu"]["StartJob"],txt = "",params = {event = "m-TruckerJob:client:EscolherViagem",}},
    })
end)

AddEventHandler('m-TruckerJob:client:General', function()
    local job = QBCore.Functions.GetPlayerData().job.grade.level
    if job == 0 or job == 1 or job == 2 then
        exports[Config.Menu]:openMenu({
            {header = Language["QBMenu"]["Company"], isMenuHeader = true},
            {header = Language["QBMenu"]["MenuEmployee"], txt = Language["QBMenu"]["DescMenuEmplyee"], params = {event = "m-TruckerJob:client:OpenEmployedMenu"}},
        })
    elseif job == 3 then
        exports[Config.Menu]:openMenu({
            {header = Language["QBMenu"]["Company"], isMenuHeader = true},
            {header = Language["QBMenu"]["MenuEmployee"], txt = Language["QBMenu"]["DescMenuEmplyee"], params = {event = "m-TruckerJob:client:OpenEmployedMenu"}},
            {header = Language["QBMenu"]["BossMenu"], txt = Language["QBMenu"]["DescBossMenu"], params = {event = "m-TruckerJob:client:OpenBossMenu"}},
        })
    end
end)

AddEventHandler('m-TruckerJob:client:OpenEmployedMenu', function()
    exports[Config.Menu]:openMenu({
        {header = Language["QBMenu"]["Company"], isMenuHeader = true},
        {header = Language["QBMenu"]["CheckLevel"], txt = "", params = {isServer = true, event = "m-TruckerJob:Server:VerificarNivel"}},
        {header = Language["QBMenu"]["BuyTruck"], txt = "", params = {event = "m-TruckerJob:Client:BuyVehicles"}},
       --[[  {header = Language["QBMenu"]["PreviewTruck"], txt = "", params = {event = "m-TruckerJob:Client:PreviewTrucks"}}, ]]
    })
end)


AddEventHandler('m-TruckerJob:client:EscolherViagem', function()
    local charinfo = QBCore.Functions.GetPlayerData().metadata["truckerxp"]
    if charinfo >= Config.XP_Need_Big_Delivery then
        exports[Config.Menu]:openMenu({
            {header = Language["QBMenu"]["Locations"],isMenuHeader = true},
            {header = Language["QBMenu"]["SmallDelivery"],txt = Language["QBMenu"]["Experience"]..charinfo.."<br>"..Language["QBMenu"]["Need"]..Config.XP_Need_Small_Delivery.."XP<br><br>"..Language["QBMenu"]["Rewards"].."<br>"..Language["QBMenu"]["GainExperience"].." +"..Config.XP_Small_Delivery.."<br>"..Language["QBMenu"]["Money"]..Config.Payment.Player.SmallDelivery,params = {event = "m-TruckerJob:client:SmallTrip",}},
            {header = Language["QBMenu"]["MediumDelivery"],txt = Language["QBMenu"]["Experience"]..charinfo.."<br>"..Language["QBMenu"]["Need"]..Config.XP_Need_Medium_Delivery.."XP<br><br>"..Language["QBMenu"]["Rewards"].."<br>"..Language["QBMenu"]["GainExperience"].." +"..Config.XP_Medium_Delivery.."<br>"..Language["QBMenu"]["Money"]..Config.Payment.Player.MediumDelivery,params = {event = "m-TruckerJob:client:MediumTrip",}},
            {header = Language["QBMenu"]["BigDelivery"],txt = Language["QBMenu"]["Experience"]..charinfo.."<br>"..Language["QBMenu"]["Need"]..Config.XP_Need_Big_Delivery.."XP<br><br>"..Language["QBMenu"]["Rewards"].."<br>"..Language["QBMenu"]["GainExperience"].." +"..Config.XP_Big_Delivery.."<br>"..Language["QBMenu"]["Money"]..Config.Payment.Player.BigDelivery,params = {event = "m-TruckerJob:client:LargeTrip",}},
        })
    elseif charinfo >= Config.XP_Need_Medium_Delivery then
        exports[Config.Menu]:openMenu({
            {header = Language["QBMenu"]["Locations"],isMenuHeader = true},
            {header = Language["QBMenu"]["SmallDelivery"],txt = Language["QBMenu"]["Experience"]..charinfo.."<br>"..Language["QBMenu"]["Need"]..Config.XP_Need_Small_Delivery.."XP<br><br>"..Language["QBMenu"]["Rewards"].."<br>"..Language["QBMenu"]["GainExperience"].." +"..Config.XP_Small_Delivery.."<br>"..Language["QBMenu"]["Money"]..Config.Payment.Player.SmallDelivery,params = {event = "m-TruckerJob:client:SmallTrip",}},
            {header = Language["QBMenu"]["MediumDelivery"],txt = Language["QBMenu"]["Experience"]..charinfo.."<br>"..Language["QBMenu"]["Need"]..Config.XP_Need_Medium_Delivery.."XP<br><br>"..Language["QBMenu"]["Rewards"].."<br>"..Language["QBMenu"]["GainExperience"].." +"..Config.XP_Medium_Delivery.."<br>"..Language["QBMenu"]["Money"]..Config.Payment.Player.MediumDelivery,params = {event = "m-TruckerJob:client:MediumTrip",}},
        })
    elseif charinfo >= Config.XP_Need_Small_Delivery then
        exports[Config.Menu]:openMenu({
            {header = Language["QBMenu"]["Locations"],isMenuHeader = true},
            {header = Language["QBMenu"]["SmallDelivery"],txt = Language["QBMenu"]["Experience"]..charinfo.."<br>"..Language["QBMenu"]["Need"]..Config.XP_Need_Small_Delivery.."XP<br><br>"..Language["QBMenu"]["Rewards"].."<br>"..Language["QBMenu"]["GainExperience"].." +"..Config.XP_Small_Delivery.."<br>"..Language["QBMenu"]["Money"]..Config.Payment.Player.SmallDelivery,params = {event = "m-TruckerJob:client:SmallTrip",}},
        })
    end
end)

