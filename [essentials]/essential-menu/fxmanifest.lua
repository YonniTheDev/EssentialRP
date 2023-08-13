fx_version "cerulean"
games { 'gta5' }

name "essential-menu"
description "qbcore menu"
author "Yonni"

ui_page "./ui/index.html"

files {
    "./ui/index.html",
    "./ui/main.css",
    "./ui/main.js",
}

client_script "client.lua"
