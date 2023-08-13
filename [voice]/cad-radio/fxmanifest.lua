fx_version "cerulean"
game "gta5"
lua54 "yes"

author 'Cadburry'
description 'Radio System'

shared_scripts {
    "config.lua",
    'locales/en.lua' -- Change to the language you wantwwd
}
client_script "client.lua"
server_script "server.lua"

files {
    'nui/*',
}
ui_page 'nui/ui.html'
