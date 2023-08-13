fx_version 'cerulean'
author '! marcinhu.#6158'
Description 'TruckerJob V2'
game 'gta5'


shared_scripts { 
    'configs/**.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/**.lua',
}

server_script { 
    '@oxmysql/lib/MySQL.lua',
    'server/**.lua'
} 

escrow_ignore {
    "client/c_targets",
    "configs/**.lua",
    "Images/**",
    "fxmanifest.lua",
}

lua54 'yes'
dependency '/assetpacks'