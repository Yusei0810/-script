fx_version 'cerulean'
game 'gta5'

author 'VGRPDEV'
description 'スピード違反検知script'
version '1.1.0'

server_scripts {
    '@qb-core/shared/locale.lua',
    'locales/ja.lua', -- 日本語のロケール
    'server.lua'
}

client_scripts {
    '@qb-core/shared/locale.lua',
    'locales/ja.lua', -- 日本語のロケール
    'client.lua'
}

shared_script '@qb-core/import.lua'
