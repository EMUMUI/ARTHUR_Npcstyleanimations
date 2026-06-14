-- ============================================================================
-- 武器模块 - 武器动画覆盖
-- ============================================================================
WeaponsModule = {}

-- ============================================================================
-- 内部状态
-- ============================================================================
local WEAPON_OVERRIDE_SET = NPCConfig.WeaponOverrideSet

-- ============================================================================
-- 执行区
-- ============================================================================

--- 应用NPC风格武器动画
function WeaponsModule.Apply()
    local ped = PlayerPedId()
    if not IsPedHuman(ped) then return end

    SetWeaponAnimationOverride(ped, WEAPON_OVERRIDE_SET)

    if NPCConfig.Debug then
        print('[NPC Style] Weapon override applied: ' .. WEAPON_OVERRIDE_SET)
    end
end
