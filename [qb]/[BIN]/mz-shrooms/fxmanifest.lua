
fx_version 'adamant'

game 'gta5'

description 'A resource for the picking and packaging of mushrooms built for qb-core - for use with mz-skills'
version '1.1.0'
author 'Mr_Zain#4139'

shared_scripts {
    'config.lua',
}

client_scripts{
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua',
}

server_scripts{
    'server/main.lua',
}
