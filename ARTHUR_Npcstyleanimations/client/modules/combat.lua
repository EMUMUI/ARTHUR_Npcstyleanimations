-- ============================================================================
-- 战斗模块 - 战斗行为覆盖
-- ============================================================================
CombatModule = {}

-- ============================================================================
-- 执行区
-- ============================================================================

--- 应用NPC风格战斗行为
function CombatModule.Apply()
    local ped = PlayerPedId()
    if not IsPedHuman(ped) then return end

    SetPedCombatAttributes(ped, 1, true)
    SetPedCombatAbility(ped, 100)
    SetPedCombatMovement(ped, 2)
    SetPedCombatRange(ped, 2)
    SetPedCombatAttributes(ped, 5, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedCombatAttributes(ped, 0, false)

    if NPCConfig.Debug then
        print('[NPC Style] Combat attributes applied')
    end
end
