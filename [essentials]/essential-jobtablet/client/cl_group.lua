local inJob = false
local requestCoolDown = false
local isGroupLeader = false
local vpn = false
local groupID = 0
local JobCenter = {}
local request = false

local function loadConfig()
    SendNUIMessage({
        action = "loadConfig",
        config = Config.JobCenter,
    })
end

exports("IsGroupLeader", function()
    return isGroupLeader
end)

exports("GetGroupID", function()
    return groupID
end)

local function ReQuest(title, text, icon, color, timeout, accept, deny)
    request = promise.new()
    SendNUIMessage({
        action = "ReQuest",
        TabletNotify = {
            title = title or "Rep Scripts",
            text = text or "MSG",
            icon = icon or "fas fa-home",
            color = color or "#FFBF00",
            timeout = timeout or 7500, -- Nếu là "NONE" thì sẽ không tự tắt
            accept = accept or "fas fa-check-circle",
            deny = deny or "fas fa-times-circle",
        },
    })
    local result = Citizen.Await(request)
    return result
end

RegisterNUICallback('openMap', function()
    ExecuteCommand('e tablet2')
    exports['ps-ui']:ShowImage("https://images-ext-2.discordapp.net/external/Fav1ERUT4HznSnjZopp2QH3DHYw2Yh1rLmzyaCgAJUI/https/saeshq2018.weebly.com/uploads/1/1/8/7/118771343/5470709-orig_orig.png?width=690&height=702")
end)

RegisterNUICallback('AcceptNotification', function()
    request:resolve(true)
    request = nil
end)

RegisterNUICallback('DenyNotification', function()
    request:resolve(false)
    request = nil
end)

exports("ReQuest", ReQuest)

-- Khi bật App sẽ gửi về để xem có job hay không, nếu có job thì kiểm tra
RegisterNUICallback('GetData', function(data, cb)
    local job = LocalPlayer.state.nghe
    if job then
        Core.Functions.TriggerCallback('essential-jobtablet:callback:getGroupsApp', function (bool, data)
            if bool then
                SendNUIMessage({
                    action = "addGroupStage",  -- Khi set State thì status về true, còn refresh App thì status của job về false. Nếu Stage == {} thì đưa về giao diện các thành viên trong nhóm
                    status =  data,   -- cấu trúc của stage https://cdn.discordapp.com/attachments/1036820124784668692/1052217816528461894/image.png
                })
            else
                SendNUIMessage({
                    action = "refreshApp",  --https://cdn.discordapp.com/attachments/1036820124784668692/1052217278701244527/image.png Cấu trúc data gửi lên
                    data = data, -- nhớ làm lại bảng for để check xem cái nào cùng job thì add và xem cái status nào bận, cái nào không bận // Thông tin các nhóm
                    job = LocalPlayer.state.nghe -- Nghề, lọc ra các nhóm trong bảng data có cùng nghề
                })
            end
        end)
    else --- jobcenter thì sẽ hiện danh sách các nghề
        SendNUIMessage({
            action = "jobcenter",
            data = JobCenter,
        })
    end
end)

-- Tạo blip đến chỗ làm việc
RegisterNUICallback('CreateBlip', function(data)
    TriggerEvent(data.event)
end)

RegisterNUICallback('readyToJob', function()
    if groupID == 0 then return end
    local success = ReQuest("Job Offer", 'Would you like to begin this job?', 'fas fa-users', '#FFBF00', "NONE", 'bx bxs-check-square', 'bx bxs-x-square')
    if success == nil then return end
    if success then
        TriggerEvent('essential-jobtablet:client:readyforjob')
    else
        SendNUIMessage({
            action = "reLoop", -- Khi set State thì status về true, còn refresh App thì status của job về fail 
        })
    end
end)

-- Tạo nhóm
RegisterNUICallback('CreateJobGroup', function(data, cb) --employment
    local result = vpn
    TriggerServerEvent('essential-jobtablet:server:createJobGroup', result, LocalPlayer.state.nghe)
    isGroupLeader = true
    cb("ok")
end)

--Xin vào nhóm
RegisterNUICallback('RequestToJoin', function (data, cb)
    if not requestCoolDown then
        requestCoolDown = true
        TriggerServerEvent('essential-jobtablet:server:requestJoinGroup', data)
        Wait(5000)
        requestCoolDown = false
    else
        Core.Functions.Notify("You need to wait before requesting again", "error")
    end
end)

RegisterNUICallback('checkOut', function (data, cb)
    if groupID ~= 0 or inJob then
        TriggerServerEvent('essential-jobtablet:server:LeaveGroup', groupID)
        if inJob then
            SendNUIMessage({
            action = "closeAllNotification",
        })
        end
    end
    LocalPlayer.state:set('nghe', nil, false)
    TriggerEvent('essential-jobtablet:client:checkout')
    SendNUIMessage({
        action = "jobcenter",
        data = JobCenter,
    })
end)

-- Out khỏi nhóm
RegisterNUICallback('LeaveGroup', function(data, cb) --data của nhóm ấn vào
    if not data then return end
    local success = ReQuest("Job Center", 'Are you sure you want to leave the group?', 'fas fa-users', '#FFBF00', "NONE", 'bx bxs-check-square', 'bx bxs-x-square')
    if success then
        isGroupLeader = false
        TriggerServerEvent('essential-jobtablet:server:LeaveGroup', groupID)
        cb("ok")
    end
end)

RegisterNUICallback('DisbandGroup', function(data, cb) --data của nhóm ấn vào
    if not data then return end
    local success = ReQuest("Job Center", 'Are you sure you want to disband the group?', 'fas fa-users', '#FFBF00', "NONE", 'bx bxs-check-square', 'bx bxs-x-square')
    if success then
        isGroupLeader = false
        TriggerServerEvent('essential-jobtablet:server:DisbandGroup', groupID)
        cb("ok")
    end
end)
-- Event

-- Làm mới nhóm, ai đang trong stage sẽ không sửa lại
RegisterNetEvent('essential-jobtablet:client:RefreshGroupsApp', function(Groups, bool)
    local job = LocalPlayer.state.nghe
    if bool then inJob = false end
    if inJob or not job then return end
    SendNUIMessage({
        action = "refreshApp",
        data = Groups,
        job = LocalPlayer.state.nghe
    })
end)

-- Khi mà sign in thì sẽ hiện các ra các nhóm của nghề đó
RegisterNetEvent('essential-jobtablet:client:signIn', function(bool)
    LocalPlayer.state:set('nghe', bool, false)
    Core.Functions.TriggerCallback('essential-jobtablet:callback:getGroupsApp', function (bool, data)
        if bool then
        else
            SendNUIMessage({
                action = "refreshApp",  --https://cdn.discordapp.com/attachments/1036820124784668692/1052217278701244527/image.png Cấu trúc data gửi lên
                data = data, -- nhớ làm lại bảng for để check xem cái nào cùng job thì add và xem cái status nào bận, cái nào không bận
                job = LocalPlayer.state.nghe
            })
        end
    end)
end)

-- Khi mà sign off thì sẽ chuyển lại giao diện jobcenter
RegisterNetEvent('essential-jobtablet:client:signOff', function()
    if groupID ~= 0 or inJob then
        TriggerServerEvent('essential-jobtablet:server:LeaveGroup', groupID)
        if inJob then
            SendNUIMessage({
            action = "closeAllNotification",
        })
        end
    end
    LocalPlayer.state:set('nghe', nil, false)
    SendNUIMessage({
        action = "jobcenter",
        data = JobCenter,
    })
end)

-- Add nhiệm vụ 
RegisterNetEvent('essential-jobtablet:client:AddGroupStage', function(data)
    inJob = true
    SendNUIMessage({
        action = "addGroupStage",
        status =  data
    })
end)

--Set Id cho group
RegisterNetEvent('essential-jobtablet:client:UpdateGroupId', function(id)
    groupID = id
    if id == 0 then
        isGroupLeader = false
    end
end)

--Xin vào nhóm// Request to join a group
RegisterNetEvent('essential-jobtablet:client:requestJoinGroup', function(target)
    local success = ReQuest("Job Center", target..' want to join your group', 'fas fa-users', '#FFBF00', "NONE", 'bx bxs-check-square', 'bx bxs-x-square')
    if success then
        TriggerServerEvent('essential-jobtablet:client:requestJoin', target, true)
    else
        TriggerServerEvent('essential-jobtablet:client:requestJoin', target, false)
    end
end)

RegisterNetEvent('essential-jobtablet:client:notReady', function ()
    SendNUIMessage({
        action = "cancelReady",
    })
end)

--Update Group Job
RegisterNetEvent('essential-jobtablet:client:updateGroupJob', function (data)
    Config.JobCenter = data
    loadConfig()
    JobCenter = {}
    for k, v in pairs(Config.JobCenter) do
        if vpn then
            JobCenter[#JobCenter+1] = v
        else
            if v.vpn == false then
                JobCenter[#JobCenter+1] = v
            end
        end
    end
end)

--Vào nhóm
RegisterNetEvent('essential-jobtablet:client:Join', function(id)
    groupID = id
    TriggerServerEvent('essential-jobtablet:server:Join', id, vpn)
end)

-- ReQuest
RegisterNetEvent("essential-jobtablet:client:request", function(title, text, icon, color, timeout, accept, deny)
    ReQuest(title, text, icon, color, timeout, accept, deny)
end)

RegisterNetEvent('essential-jobtablet:jobcenter:tow', function()
    SetNewWaypoint(1243.5552978516, -3256.4140625)
end)

RegisterNetEvent('essential-jobtablet:jobcenter:taxi', function()
    SetNewWaypoint(909.51, -177.36)
end)

RegisterNetEvent('essential-jobtablet:jobcenter:postop', function()
    SetNewWaypoint(-432.51, -2787.98)
end)

RegisterNetEvent('essential-jobtablet:jobcenter:gasdelivery', function()
    SetNewWaypoint(1721.9868164063, -1557.7171630859)
end)

RegisterNetEvent('essential-jobtablet:jobcenter:sanitation', function()    
    SetNewWaypoint(-350.12, -1569.96)
end)

RegisterNetEvent('rep-oxyrun:client:chiduong', function()    
    SetNewWaypoint(-1566.41, -442.41) 
end)

RegisterNetEvent('rep-chopshop:client:chiduong', function()  
    SetNewWaypoint(-1377.75, -753.16)
end)

RegisterNetEvent("burglary:client:Waypoint", function()  
    SetNewWaypoint(245.4, 370.23)
end)

RegisterNetEvent("m-Trucker:client:Waypoint", function()  
    SetNewWaypoint(1204.5278320313, -3103.162109375) 
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = nil
end)

local function CheckVPN()
    for _, itemData in pairs(PlayerData.items) do
        if itemData.name == 'vpn' then
            return true
        end
    end
    return false
end

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
    Wait(100)
    local result = CheckVPN()
    if vpn ~= result then
        vpn = result
        JobCenter = {}
        for k, v in pairs(Config.JobCenter) do
            if vpn then
                JobCenter[#JobCenter+1] = v
            else
                if v.vpn == false then
                    JobCenter[#JobCenter+1] = v
                end
            end
        end
        TriggerServerEvent('essential-jobtablet:server:updateVPN', result)
    end
end)

-- Handles state if resource is restarted live.
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        PlayerData = Core.Functions.GetPlayerData()
        vpn = CheckVPN()
        JobCenter = {}
        for k, v in pairs(Config.JobCenter) do
            if vpn then
                JobCenter[#JobCenter+1] = v
            else
                if v.vpn == false then
                    JobCenter[#JobCenter+1] = v
                end
            end
        end
        LocalPlayer.state.nghe = nil
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Core.Functions.TriggerCallback('essential-jobtablet:callback:getGroupsJob', function (data)
        Config.JobCenter = data
    end)
    vpn = CheckVPN()
    loadConfig()
    JobCenter = {}
    for k, v in pairs(Config.JobCenter) do
        if vpn then
            JobCenter[#JobCenter+1] = v
        else
            if v.vpn == false then
                JobCenter[#JobCenter+1] = v
            end
        end
    end
    PlayerData = Core.Functions.GetPlayerData()
end)
