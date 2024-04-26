fx_version 'cerulean'
game 'gta5'

description 'Delivery Job by HorizonScripts!'
version '1.0.0'
author 'HorizonScripts'
lua54 'yes'

client_scripts {
	'client/cl_*.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
server_scripts  {
    'server/sv_*.lua'
}

files {
    'locales/*.json'
  }

dependencies {
    'hs-deliveryjob',
    'ox_lib',
    'ox_target',
    'es_extended'
}
