fx_version 'cerulean'
game 'gta5'

name ''
author ''
description ''
-- repository 'https://github.com/Serrulata-Studios/serrulata-atmrobbery'

version '1.0.1'

shared_script 'config.lua'

server_script 'server/*.lua'

client_scripts {
    'client/*.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
}

dependencies {
    'ps-ui'
}

lua54 'yes'