-- ============================================================================
-- NPC风格动作 - 服务端入口
-- 作者: Arthur_Wallison
-- ============================================================================

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        print('^2[Arthur NPC Style Animations]^7 v1.0.0 loaded')
        print('^2[Arthur NPC Style Animations]^7 Author: Arthur_Wallison')
        print('^2[Arthur NPC Style Animations]^7 Player animations will be force-overridden with NPC style')
    end
end)
