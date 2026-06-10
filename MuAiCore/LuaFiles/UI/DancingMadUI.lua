local DancingMadUI = {}
local wide = 350

DancingMadUI.draw = function()
    local M = MuAiGuide
    if not M.DancingMadUI.open then
        return
    end
    GUI:SetNextWindowPos(M.MainUI.uiPos.x, M.MainUI.uiPos.y)
    GUI:SetNextWindowSize(wide, 0, GUI.SetCond_Appearing)
    M.DancingMadUI.visible, M.DancingMadUI.open = GUI:Begin("Dmu Setting", M.DancingMadUI.open)
    if M.DancingMadUI.visible then
        if GUI:CollapsingHeader("全局开关") then
            GUI:Columns(3, 'switch', false)
            GUI:Dummy(15, 10)
            GUI:SameLine()
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('总开关')
            GUI:NextColumn()
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('是否画图')
            GUI:NextColumn()
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('是否指路')
            GUI:NextColumn()
            GUI:Separator()
            for i = 1, 5 do
                local key = 'P' .. i
                local curConfig = M.Config.DmuCfg[key]
                GUI:Dummy(15, 10)
                GUI:SameLine(0, 0)
                GUI:AlignFirstTextHeightToWidgets()
                GUI:Text(key)
                GUI:SameLine()
                curConfig.enable = GUI:Checkbox('##' .. key .. 'enable', curConfig.enable)
                GUI:NextColumn()
                GUI:Dummy(10, 0)
                GUI:SameLine()
                curConfig.draw = GUI:Checkbox('##' .. key .. 'draw', curConfig.draw)
                GUI:NextColumn()
                GUI:Dummy(10, 0)
                GUI:SameLine()
                curConfig.guide = GUI:Checkbox('##' .. key .. 'guide', curConfig.guide)
                GUI:NextColumn()
                GUI:Separator()
            end
            GUI:Columns(1)
        end
        if M.Config.DmuCfg.P1.enable and GUI:CollapsingHeader("P1") then
            GUI:BulletText('真假冰和雷')
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.P1.effect = GUI:Checkbox('屏蔽真假AOE特效##effectBind', M.Config.DmuCfg.P1.effect)
            if GUI:IsItemHovered() then
                GUI:SetTooltip("勾选后屏蔽特效采用A+画紫色危险区, 未勾选使用ImGui画图显示黄色危险区")
            end
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('一神')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:Text(' 打法: 职能固定  ')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 激光站位顺序  ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(175)
            local dmOrder, dmOrderChanged = GUI:InputText('##DrawBlackList',
                    M.StringJoin(M.Config.DmuCfg.P1.BeamOrder, ','), GUI.InputTextFlags_CharsNoBlank)
            if dmOrderChanged then
                if dmOrderChanged then
                    M.Config.DmuCfg.P1.BeamOrder = M.StringSplit(dmOrder, ",")
                end
            end
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('二神')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:Text(' 打法: M S分组AC固定分摊, 近左远右放分散  ')
            GUI:Dummy(0, 0)
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('唰啦啦传送')
            GUI:Dummy(0, 0)
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:Text(' 打法: 回转寿司, 相同buff优先正点放  ')
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('最后雷火')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:Text(' 打法: 固定式')
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.P1.autoLookAt = GUI:Checkbox('自动面对和背对石像##autoLookAt', M.Config.DmuCfg.P1.autoLookAt)
        end
        if M.Config.DmuCfg.P1.enable and GUI:CollapsingHeader("P2") then
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('8次踩塔')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:Text('打法: 混合优化, 闲人固定')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('固定方式: ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(100)
            M.Config.DmuCfg.P2.fixType = GUI:Combo("##T8fixType", M.Config.DmuCfg.P2.fixType, { "职能固定", "扇左钢右" }, 4)
            GUI:PopItemWidth()
        end
    end
    M.SaveConfig(M.Config.DmuGuidePath, M.Config.DmuGuideFile, "DmuCfg")
    GUI:SetWindowSize(wide, 0)
    GUI:End()
end

return DancingMadUI