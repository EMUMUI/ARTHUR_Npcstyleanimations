local resourceName = GetCurrentResourceName()

local function ApplyAll()
    local ped = PlayerPedId()
    if not IsPedHuman(ped) then return end

    WeaponsModule.Apply()
    CombatModule.Apply()

    if NPCConfig.Debug then
        print('[NPC Style] All overrides applied')
    end
end

AddEventHandler('onClientResourceStart', function(resource)
    if resource ~= resourceName then return end
    ApplyAll()
end)

AddEventHandler('playerSpawned', function()
    ApplyAll()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(NPCConfig.MaintainInterval)
        ApplyAll()
    end
end)

DebugModule.Start()
