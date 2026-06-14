DebugModule = {}

local lastWeapon = nil
local lastCoverState = nil
local weaponNames = {
    [GetHashKey('WEAPON_PISTOL')] = 'PISTOL',
    [GetHashKey('WEAPON_PISTOL50')] = 'PISTOL50',
    [GetHashKey('WEAPON_COMBATPISTOL')] = 'COMBATPISTOL',
    [GetHashKey('WEAPON_HEAVYPISTOL')] = 'HEAVYPISTOL',
    [GetHashKey('WEAPON_APPISTOL')] = 'APPISTOL',
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = 'VINTAGEPISTOL',
    [GetHashKey('WEAPON_SNSPISTOL')] = 'SNSPISTOL',
    [GetHashKey('WEAPON_SNSPISTOL_MK2')] = 'SNSPISTOL_MK2',
    [GetHashKey('WEAPON_PISTOL_MK2')] = 'PISTOL_MK2',
    [GetHashKey('WEAPON_STUNGUN')] = 'STUNGUN',
    [GetHashKey('WEAPON_REVOLVER')] = 'REVOLVER',
    [GetHashKey('WEAPON_REVOLVER_MK2')] = 'REVOLVER_MK2',
    [GetHashKey('WEAPON_DOUBLEACTION')] = 'DOUBLEACTION',
    [GetHashKey('WEAPON_NAVYREVOLVER')] = 'NAVYREVOLVER',
    [GetHashKey('WEAPON_CERAMICPISTOL')] = 'CERAMICPISTOL',
    [GetHashKey('WEAPON_FLAREGUN')] = 'FLAREGUN',
    [GetHashKey('WEAPON_MARKSMANPISTOL')] = 'MARKSMANPISTOL',
    [GetHashKey('WEAPON_SMG')] = 'SMG',
    [GetHashKey('WEAPON_SMG_MK2')] = 'SMG_MK2',
    [GetHashKey('WEAPON_MICROSMG')] = 'MICROSMG',
    [GetHashKey('WEAPON_MACHINEPISTOL')] = 'MACHINEPISTOL',
    [GetHashKey('WEAPON_ASSAULTSMG')] = 'ASSAULTSMG',
    [GetHashKey('WEAPON_COMBATPDW')] = 'COMBATPDW',
    [GetHashKey('WEAPON_MINISMG')] = 'MINISMG',
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = 'ASSAULTRIFLE',
    [GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = 'ASSAULTRIFLE_MK2',
    [GetHashKey('WEAPON_CARBINERIFLE')] = 'CARBINERIFLE',
    [GetHashKey('WEAPON_CARBINERIFLE_MK2')] = 'CARBINERIFLE_MK2',
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = 'ADVANCEDRIFLE',
    [GetHashKey('WEAPON_SPECIALCARBINE')] = 'SPECIALCARBINE',
    [GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = 'SPECIALCARBINE_MK2',
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = 'BULLPUPRIFLE',
    [GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = 'BULLPUPRIFLE_MK2',
    [GetHashKey('WEAPON_COMPACTRIFLE')] = 'COMPACTRIFLE',
    [GetHashKey('WEAPON_MILITARYRIFLE')] = 'MILITARYRIFLE',
    [GetHashKey('WEAPON_HEAVYRIFLE')] = 'HEAVYRIFLE',
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = 'PUMPSHOTGUN',
    [GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = 'PUMPSHOTGUN_MK2',
    [GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = 'SAWNOFFSHOTGUN',
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = 'ASSAULTSHOTGUN',
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = 'BULLPUPSHOTGUN',
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = 'HEAVYSHOTGUN',
    [GetHashKey('WEAPON_DBSHOTGUN')] = 'DBSHOTGUN',
    [GetHashKey('WEAPON_AUTOSHOTGUN')] = 'AUTOSHOTGUN',
    [GetHashKey('WEAPON_SNIPERRIFLE')] = 'SNIPERRIFLE',
    [GetHashKey('WEAPON_HEAVYSNIPER')] = 'HEAVYSNIPER',
    [GetHashKey('WEAPON_HEAVYSNIPER_MK2')] = 'HEAVYSNIPER_MK2',
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = 'MARKSMANRIFLE',
    [GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] = 'MARKSMANRIFLE_MK2',
    [GetHashKey('WEAPON_PRECISIONRIFLE')] = 'PRECISIONRIFLE',
    [GetHashKey('WEAPON_MINIGUN')] = 'MINIGUN',
    [GetHashKey('WEAPON_RPG')] = 'RPG',
    [GetHashKey('WEAPON_GRENADELAUNCHER')] = 'GRENADELAUNCHER',
    [GetHashKey('WEAPON_STICKYBOMB')] = 'STICKYBOMB',
    [GetHashKey('WEAPON_GRENADE')] = 'GRENADE',
    [GetHashKey('WEAPON_MOLOTOV')] = 'MOLOTOV',
    [GetHashKey('WEAPON_BZGAS')] = 'BZGAS',
    [GetHashKey('WEAPON_SMOKEGRENADE')] = 'SMOKEGRENADE',
    [GetHashKey('WEAPON_FLARE')] = 'FLARE',
    [GetHashKey('WEAPON_PETROLCAN')] = 'PETROLCAN',
    [GetHashKey('WEAPON_HAZARDCAN')] = 'HAZARDCAN',
    [GetHashKey('WEAPON_FIREEXTINGUISHER')] = 'FIREEXTINGUISHER',
    [GetHashKey('GADGET_NIGHTVISION')] = 'NIGHTVISION',
    [GetHashKey('GADGET_PARACHUTE')] = 'PARACHUTE',
}

local function GetWeaponName(hash)
    return weaponNames[hash] or ('0x%08X'):format(hash)
end

function DebugModule.Start()
    if not NPCConfig.Debug then return end

    print('[NPC Debug] ====== Debug monitor started ======')
    print('[NPC Debug] Override set: ' .. NPCConfig.WeaponOverrideSet)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            local ped = PlayerPedId()
            if not IsPedHuman(ped) then
                lastWeapon = nil
                lastCoverState = nil
                goto continue
            end

            local weaponHash = GetSelectedPedWeapon(ped)
            if weaponHash ~= lastWeapon then
                local name = GetWeaponName(weaponHash)
                print(('[NPC Debug] Weapon changed: %s (0x%08X)'):format(name, weaponHash))
                print('[NPC Debug]   -> Override set: ' .. NPCConfig.WeaponOverrideSet)
                lastWeapon = weaponHash
            end

            local inCover = IsPedInCover(ped, false)
            local goingInto = IsPedGoingIntoCover(ped)
            if inCover ~= lastCoverState then
                if inCover then
                    local name = GetWeaponName(weaponHash)
                    print('[NPC Debug] ENTERED COVER - Weapon: ' .. name)
                    print('[NPC Debug]   -> IsPedGoingIntoCover: ' .. tostring(goingInto))
                    print('[NPC Debug]   -> IsPedArmed: ' .. tostring(IsPedArmed(ped, 7)))
                    print('[NPC Debug]   -> IsPedShooting: ' .. tostring(IsPedShooting(ped)))
                    print('[NPC Debug]   -> IsPedDucking: ' .. tostring(IsPedDucking(ped)))
                    print('[NPC Debug]   -> IsPedInAnyVehicle: ' .. tostring(IsPedInAnyVehicle(ped, false)))
                else
                    print('[NPC Debug] EXITED COVER')
                end
                lastCoverState = inCover
            end

            ::continue::
        end
    end)
end
