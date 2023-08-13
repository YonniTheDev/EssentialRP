RegisterNuiCallback('close', function(data, cb)
    NUI:Close()
    cb('ok')
end)

RegisterNuiCallback('ApplyJob', function(data, cb)
    TriggerServerEvent('essential-cityhall:server:ApplyJob', data.id)
    cb('ok')
end)

RegisterNuiCallback('BuyIdentity', function(data, cb)
    TriggerServerEvent('essential-cityhall:server:BuyIdentity', data.id)
    cb('ok')
end)