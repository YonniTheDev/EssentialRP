fx_version 'cerulean'
game 'gta5'

description 'Renewed chopshop, You are not allowed to distribute this script without permission from me.'
Author "FjamZoo#0001 & uShifty#1733"
version '2.0.0'

lua54 'yes'

shared_script {
    'config.lua'
}

client_scripts {
    --[[ '@ox_lib/init.lua', ]] -- Remove if not using ox_lib
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua' -- Globbing method for multiple files
}

server_scripts {
    'server/*.lua' -- Globbing method for multiple files
}

escrow_ignore {
    'config.lua',
    'server/main.lua',
    'client/main.lua'
}
dependency '/assetpacks'