fx_version 'cerulean'
game 'gta5'

author 'SKryptz'
description 'An advanced burglary script for fivem | QBCore'
version '2.2.76'

dependencies {
    '/onesync',
    'qb-target'
}

client_scripts { 
    'client/*.lua' 
}

server_scripts { 
    'server/*.lua',
    '@oxmysql/lib/MySQL.lua',
}

shared_scripts {
    'config.lua',
    'props/*.lua',
    'houses/*.lua',
    'interiors/*.lua',
}

escrow_ignore {
    'config.lua',
    'props/*.lua',
    'houses/*.lua',
    'interiors/*.lua',
    'server/sv_carry',
    'server/sv_public',
    'client/cl_public'
}

lua54 'yes'
dependency '/assetpacks'