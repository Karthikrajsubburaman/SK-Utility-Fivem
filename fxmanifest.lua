fx_version 'cerulean'
game 'gta5'
description 'SK utils'
author "sk"
version '1.0.0'
lua54 'yes'

shared_scripts { '@ox_lib/init.lua','shared/Config.lua',  }

server_scripts {
   '@oxmysql/lib/MySQL.lua',
   'server/*.lua',
}

client_scripts {
   'client/*.lua',
}
