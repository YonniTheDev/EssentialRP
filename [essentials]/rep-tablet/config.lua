Config = {}
-- Config thêm job và event chỉ đường vào đây, vpn = true sẽ yêu cầu VPN để hiển thị
Config.JobCenter = {
    ['towing'] = {
        vpn = false,
        label = "Towing (Job)",
        event = "rep-tablet:jobcenter:tow",
        mem = 1, -- Số lượng người tối đa trong 1 nhóm
        count = 0, -- Don't touch
        salary = 'high',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fa-solid fa-truck-ramp-box"

    },
    ['taxi'] = {
        vpn = false,
        label = "Taxi (Job)",
        event = "rep-tablet:jobcenter:taxi",
        mem = 1,
        count = 0,
        salary = 'low',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fa-solid fa-taxi"
    },
    ['houserobbery'] = {
        vpn = true,
        label = "House Robbery (Crime)",
        event = "burglary:client:Waypoint",
        mem = 4,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fa-solid fa-mask"
    },
    ['oxyrun'] = {
        vpn = true,
        label = "Oxy Run (Crime)",
        event = "rep-oxyrun:client:chiduong",
        mem = 1,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fa-solid fa-pills"
    },
    ['theftcar'] = {
        vpn = true,
        label = "Car Chopping (Crime)",
        event = "rep-chopshop:client:chiduong",
        mem = 4,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fas fa-car-crash"  
    },
    ['postop'] = {
        vpn = false,
        label = "Road Runner (Job)",
        event = "rep-tablet:jobcenter:postop",
        mem = 4,
        count = 0,
        salary = 'high',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fa-solid fa-truck-fast"
    },
    ['sani'] = {
        vpn = false,
        label = "Sanitation (Job)",
        event = "rep-tablet:jobcenter:sanitation",
        mem = 4,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fas fa-trash"
    },
    ['trucking'] = {
        vpn = false,
        label = "Trucking (Job)",
        event = "m-Trucker:client:Waypoint",
        mem = 1,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fa-solid fa-truck-arrow-right"     
    },
    --[[ ['taco'] = {
        vpn = true,
        label = "Taco Shop",
        event = "rep-weed:client:chiduong",
        mem = 1,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fas fa-cannabis"
    }, ]]
}

-- Họ sẽ được random khi trong người có VPN
Config.FirstName = {
    'Trump',
    'Musk',
    'Adams',
    'Harrison',
    'Taft',
    'Long',
    'Lodge',
    'Kennedy',
    'Bayh',
    'Indiana',
    'Brown',
    'Miller',
    'Davis',
    'Garcia',
}
-- Tên sẽ được random khi trong người có VPN
Config.LastName = {
    'James',
    'Robert',
    'John',
    'Michael',
    'Cheng',
    'BahnMy',
    'Cris',
    'Hwan',
    'William'
}