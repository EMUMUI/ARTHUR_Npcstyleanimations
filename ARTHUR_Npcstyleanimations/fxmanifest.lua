fx_version 'cerulean'
game 'gta5'

author 'Arthur_Wallison'
description 'NPC Style Animations - Force override player animations with NPC-style movements, combat, and weapon handling'
version '1.0.0'

shared_scripts {
    'client/config.lua',
}

client_scripts {
    'client/modules/weapons.lua',
    'client/modules/combat.lua',
    'client/modules/debug.lua',
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

files {
    'data/meta/*.meta',
}

data_file 'WEAPON_ANIMATIONS_FILE' 'data/meta/*.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' 'data/pedpersonality.ymt'

lua54 'yes'
