Config = {}

Config.Framework = 'QBCore'  -- Framework to use (QBCore or OX)
Config.Dispatch = 'ps-dispatch' -- Dispatch that you use (ps-dispatch or cd_dispatch)

Config.HackItem = { "fleecacard", "fleecaphone" } -- Item required to do the robbery (Change Label to something fitting if you change this)
Config.HackType = 'greek' -- can be alphabet, numeric, alphanumeric, greek, braille, runes
Config.HackTime = 25 --how long to do minigame
Config.HackingTime = 15 --how long for hacking progressbars

Config.MoneyType = false -- true = cash / false = blackmoney/dirtymoney
Config.PaymentMin = '2500' -- Min amount they can get
Config.PaymentMax = '3750' -- Max amount they can get

Config.Cops = 0 -- Amount of cops needed to do the robbery
Config.CoolDown = 8 -- How long Cooldown is before robbery can be done again (minutes)