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
            GUI:TextColored(1, 0, 0, 1, '[开启]表示是否开启当前这一P，[画图]和[指路]控制当前P')
            GUI:TextColored(1, 0, 0, 1, '是否指路绘图')
            for i = 1, 6 do
                local key = 'P' .. i
                local curConfig = M.Config.DmuCfg[key]
                GUI:Columns(3, key .. 'switch', false)
                GUI:Dummy(15, 10)
                GUI:SameLine(0, 0)
                GUI:AlignFirstTextHeightToWidgets()
                GUI:Text(key)
                GUI:SameLine()
                curConfig.enable = GUI:Checkbox('##' .. key .. 'enable', curConfig.enable)
                GUI:NextColumn()
                GUI:AlignFirstTextHeightToWidgets()
                GUI:Text('画图')
                GUI:SameLine()
                curConfig.draw = GUI:Checkbox('##' .. key .. 'draw', curConfig.draw)
                GUI:NextColumn()
                GUI:AlignFirstTextHeightToWidgets()
                GUI:Text('指路')
                GUI:SameLine()
                curConfig.guide = GUI:Checkbox('##' .. key .. 'guide', curConfig.guide)
                GUI:Columns(1)
                GUI:Separator()
            end
        end
        if M.Config.DmuCfg.P1.enable and GUI:CollapsingHeader("P1") then
            GUI:Dummy(0, 0)
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.P1.effect = GUI:Checkbox('屏蔽真假AOE特效##effectBind', M.Config.DmuCfg.P1.effect)
            if GUI:IsItemHovered() then
                GUI:SetTooltip("勾选后屏蔽特效采用A+画紫色危险区，未勾选使用ImGui画图显示黄色危险区")
            end
            GUI:Dummy(0, 0)
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('1神激光站位顺序')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            local dmOrder, dmOrderChanged = GUI:InputText('##DrawBlackList',
                    M.StringJoin(M.Config.DmuCfg.P1.BeamOrder, ','), GUI.InputTextFlags_CharsNoBlank)
            if dmOrderChanged then
                if dmOrderChanged then
                    M.Config.DmuCfg.P1.BeamOrder = M.StringSplit(dmOrder, ",")
                end
            end
        end
        --if M.Config.DmuCfg.P2.enable and GUI:CollapsingHeader("P2") then
        --    M.Config.DmuCfg.P2.MarkMember = GUI:Checkbox('标记队友 分摊禁止,大圈锁链,扇形攻击', M.Config.DmuCfg.P2.MarkMember)
        --end
    end
    M.SaveConfig(M.Config.DmuGuidePath, M.Config.DmuGuideFile, "DmuCfg")
    GUI:SetWindowSize(wide, 0)
    GUI:End()
end
return DancingMadUI