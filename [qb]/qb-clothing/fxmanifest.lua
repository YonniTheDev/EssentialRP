fx_version 'cerulean'
game 'gta5'

description 'Clothing'

ui_page 'nui/index.html'

shared_scripts  {
	'shared/sh_*.lua'
}

server_scripts {
	'@ghmattimysql/lib/MySQL.lua',
	'server/sv_*.lua'
}

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/cl_*.lua'
}
files {
	'nui/index.html',
	'nui/css/*.css',
	'nui/js/**.js',
	'nui/img/*.png'
}

provide 'qb-clothing'

lua54 'yes'