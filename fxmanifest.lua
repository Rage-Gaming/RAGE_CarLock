fx_version 'cerulean'

game 'gta5'

author 'RAGE'

name 'RAGE_CarLock'

description 'CarLock system for ESX'

lua54 'yes'

version '1.0.0'

shared_script {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}


server_script {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'ox_lib'
}