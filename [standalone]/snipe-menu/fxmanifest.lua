fx_version 'cerulean'
game 'gta5'

description 'Admin Menu Script'
version '2.7.0'
author 'Snipe'

lua54 'yes'
ui_page 'html/index.html'

shared_scripts { 
	'config/*.lua',
    -- '@es_extended/imports.lua' -- comment or delete this line if you use QBCore
}

files {
	'html/**/*',
}

client_scripts{
    'client/cl_utils.lua',
    'client/cl_main.lua',
    'client/cl_customise.lua',
    'client/cl_customise_1.lua',
    'client/cl_playerlistmenu.lua',
    'client/cl_vehicles.lua',
    'client/cl_noclip.lua',
    'client/cl_items.lua',
    'client/cl_jobstash.lua',
    'client/cl_keybinds.lua',
    'client/cl_settings.lua',
    'client/cl_deleteentity.lua',
    'client/cl_adminmanagement.lua',
    'client/cl_blips.lua',
    'client/cl_weathermanagement.lua',
    'client/cl_favouritelocations.lua',
    'client/cl_spectate.lua',
    'client/cl_reports.lua',
    'client/cl_names.lua',
    'client/cl_adminchat.lua',
    'client/cl_vehdebug.lua',
    'client/cl_openstashes.lua',
    'client/cl_inventory.lua',
    'client/pedlist.lua',
    'client/cl_vehicles_customise.lua',
    'client/cl_troll.lua',
    'client/cl_troll_customise.lua',
    'client/cl_resources.lua',
    'client/cl_noclip2.lua'
} 

server_scripts{
    'server/sv_utils.lua',
    '@oxmysql/lib/MySQL.lua',
    'server/sv_customise.lua',
    'server/sv_webhooks.lua',
    'server/sv_main.lua',
    'server/sv_jobstash.lua',
    'server/sv_blips.lua',
    'server/sv_spectate.lua',
    'server/sv_reports.lua',
    'server/sv_adminchat.lua',
    'server/sv_customise_new.lua',
    'server/sv_vehicles.lua',
    'server/sv_inventory.lua',
    'server/sv_troll.lua',
    'server/sv_customise_2.lua',
    'server/sv_resources.lua',
} 

escrow_ignore {
    'config/config.lua',
    'config/locales.lua',
    'config/permissions.lua',
    'config/config_new.lua',
    'client/cl_customise.lua',
    'client/cl_keybinds.lua',
    'client/cl_noclip.lua',
    'server/sv_customise.lua',
    'server/sv_webhooks.lua',
    'server/sv_customise_new.lua',
    'client/cl_vehdebug.lua',
    'client/cl_customise_1.lua',
    'client/pedlist.lua',
    'server/sv_utils.lua',
    'client/cl_utils.lua',
    'server/sv_vehicles.lua',
    'client/cl_inventory.lua',
    'server/sv_inventory.lua',
    'client/cl_vehicles_customise.lua',
    'client/cl_troll_customise.lua',
    'server/sv_customise_2.lua',
    'client/cl_names.lua',
}

dependency '/assetpacks'