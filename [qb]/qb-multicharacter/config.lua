Config = {}
Config.StartingApartment = true -- Enable/disable starting apartments (make sure to set default spawn coords)
Config.Interior = vector3(-814.89, 181.95, 76.85) -- Interior to load where characters are previewed
Config.DefaultSpawn = vector3(-1035.71, -2731.87, 12.86) -- Default spawn coords if you have start apartments disabled
Config.PedCoords = vector4(902.81, 38.14, 111.33, 288.38) -- Create preview ped at these coordinates
Config.HiddenCoords = vector4(-356.28024291992, 164.62606811523, 86.390670776367, 267.31414794922) -- Hides your actual ped while you are in selection
Config.CamCoords = vector4(-347.18432617188, 162.61584472656, 87.037406921387, 180.61370849609) -- Camera coordinates for character preview screen
Config.EnableDeleteButton = true -- Define if the player can delete the character or not

Config.DefaultNumberOfCharacters = 4 -- min = 1 | max = 5
Config.PlayersNumberOfCharacters = { -- Define maximum amount of player characters by rockstar license (you can find this license in your server's database in the player table)
    { license = "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", numberOfChars = 2 },
}

Config.PedCords = {
    [1] = vector4(-344.56192016602, 159.81532287598, 86.390655517578, 30.996513366699),
    [2] = vector4(-349.56289672852, 159.71681213379, 86.390670776367, 323.03915405273),
    [3] = vector4(-345.46057128906, 156.1254119873, 87.201499938965, 8.9537677764893),
    [4] = vector4(-348.50128173828, 156.19038391113, 87.201507568359, 354.52853393555),
}

Config.TrainCoord = {
    Heading = 268.7,
    Start = vector3(-523.14, -665.62, 9.9),
    Stop = vector3(-498.32, -665.63, 9.9),
}

Config.Clothing = {
    ['qb-clothing'] = true,
    ['fivem-appearance'] = false,
    ['illenium-appearance'] = false,
}