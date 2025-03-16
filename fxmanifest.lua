fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Multi Colored Backpack script for Ox Inventory'
version '1.0.0'
author 'MrHooliNoodle'

client_scripts {
    'client/**.lua'
}

server_scripts {
  'server/**.lua'
}

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua'
}

dependencies {
  'ox_inventory'
}
