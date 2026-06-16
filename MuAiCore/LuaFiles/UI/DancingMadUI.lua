local DancingMadUI = {}
local wide = 350

DancingMadUI.draw = function()
    local M = MuAiGuide
    if not M.DancingMadUI.open then
        return
    end
    GUI:SetNextWindowPos(M.MainUI.uiPos.x, M.MainUI.uiPos.y)
    GUI:SetNextWindowSize(wide, 0, GUI.SetCond_Appearing)
    M.DancingMadUI.visible, M.DancingMadUI.open = GUI:Begin('Dmu Setting', M.DancingMadUI.open)
    if M.DancingMadUI.visible then
        if GUI:CollapsingHeader('全局开关') then
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
                GUI:SameLine()
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
            GUI:BulletText('真假冰和雷')
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.BindEffect = GUI:Checkbox('屏蔽真假AOE特效##effectBind', M.Config.DmuCfg.BindEffect)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('勾选后屏蔽特效采用A+画紫色危险区\n未勾选使用ImGui画图显示黄色危险区\n如果你没有A+, 那仅仅是颜色的区别')
            end
        end
        if M.Config.DmuCfg.P1.enable and GUI:CollapsingHeader('P1 凯夫卡·众神之像') then
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('一神')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:TextColored(1,0,0,1, ' 攻略: 职能固定  ')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 激光站位顺序  ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(175)
            local dmOrder, dmOrderChanged = GUI:InputText('##BeamOrder',
                    M.StringJoin(M.Config.DmuCfg.P1.BeamOrder, ','), GUI.InputTextFlags_CharsNoBlank)
            if dmOrderChanged then
                M.Config.DmuCfg.P1.BeamOrder = M.StringSplit(dmOrder, ',')
            end
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('二神')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:TextColored(1,0,0,1, ' 攻略: M S分组AC固定分摊, 近左远右放分散  ')
            GUI:Dummy(0, 0)
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('唰啦啦传送')
            GUI:Dummy(0, 0)
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:TextColored(1,0,0,1, ' 攻略: 回转寿司, 相同buff优先正点放  ')
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.P1.transUnOpt = GUI:Checkbox('开启近战负优化##P1transUnOpt', M.Config.DmuCfg.P1.transUnOpt)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('启动后混乱在外, 睡眠在内 \n纯粹是特么的负优化！')
            end
            GUI:Dummy(0, 0)
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('最后雷火')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:TextColored(1,0,0,1, ' 攻略: 固定式')
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.P1.autoLookAt = GUI:Checkbox('自动调整面向##P1autoLookAt', M.Config.DmuCfg.P1.autoLookAt)
            if  M.Config.DmuCfg.P1.autoLookAt  then
                GUI:SameLine(0, 13)
                M.Config.DmuCfg.P1.hardLock = GUI:Checkbox('使用更严格的硬锁定##P1HardLockFace', M.Config.DmuCfg.P1.hardLock)
                if GUI:IsItemHovered() then
                    GUI:SetTooltip('开启后会完全禁止可能会改变面向的事, \n约等于停手, 请谨慎使用')
                end
            end
        end
        if M.Config.DmuCfg.P2.enable and GUI:CollapsingHeader('P2 凯夫卡·神') then
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('8次踩塔')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1,0,0,1, ' 攻略: 混合优化, 闲人固定')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 固定方式: ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P2.fixType = GUI:Combo('##T8fixType', M.Config.DmuCfg.P2.fixType, { '职能固定', '扇左钢右', '职能固定Uptime' }, 3)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 最后一脚: ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P2.endTower = GUI:Combo('##endTower', M.Config.DmuCfg.P2.endTower, { '去A点方向', '去两塔之间' }, 2)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('异三角')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 画图方案: ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(130)
            M.Config.DmuCfg.P2.trineDrawType = GUI:Combo('##trineDrawType', M.Config.DmuCfg.P2.trineDrawType, { '只画当前一次', '当前和下次预览' }, 2)
            GUI:PopItemWidth()
        end
        if M.Config.DmuCfg.P3.enable and GUI:CollapsingHeader('P3 艾克斯迪斯&卡奥斯') then
            GUI:Dummy(0, 0)
            GUI:SameLine()
            GUI:BulletText('一运')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1,0,0,1, ' 攻略: 逃课, 夜音式')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 谁拉艾克斯迪斯: ')
            GUI:SameLine()
            GUI:PushItemWidth(40)
            M.Config.DmuCfg.P3.ExDeathTank = GUI:Combo('##ExDeathTank', M.Config.DmuCfg.P3.ExDeathTank, { 'ST', 'MT' }, 2)
            GUI:PopItemWidth()

            GUI:Dummy(12, 0)
            GUI:SameLine(0, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 火BUFF左右优先级 ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(175)
            local p3fireBuffOrder, p3fireBuffOrderChanged = GUI:InputText('##fireBuffOrder',
                    M.StringJoin(M.Config.DmuCfg.P3.fireBuffOrder, ','), GUI.InputTextFlags_CharsNoBlank)
            GUI:PopItemWidth()
            if p3fireBuffOrderChanged then
                M.Config.DmuCfg.P3.fireBuffOrder = M.StringSplit(p3fireBuffOrder, ',')
            end

            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 谁引导超级跳:   ')
            GUI:SameLine()
            GUI:PushItemWidth(40)
            M.Config.DmuCfg.P3.superJump = GUI:Combo('##superJump', M.Config.DmuCfg.P3.superJump, { 'D3', 'D4' }, 2)
            GUI:PopItemWidth()
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P3.LockFace = GUI:Checkbox('自动调整面向##p3LockFace', M.Config.DmuCfg.P3.LockFace)
            if M.Config.DmuCfg.P3.LockFace then
                GUI:SameLine(0, 13)
                M.Config.DmuCfg.P3.HardLockFace = GUI:Checkbox('使用更严格的硬锁定##HardLockFace', M.Config.DmuCfg.P3.HardLockFace)
                if GUI:IsItemHovered() then
                    GUI:SetTooltip('开启后会完全禁止可能会改变面向的事, \n约等于停手, 请谨慎使用')
                end
            end
            GUI:Dummy(0, 0)
            GUI:SameLine()
            GUI:BulletText('二运')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1,0,0,1, ' 攻略: 盗火, 按标记顺序')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:Text(' 以巨大凯夫卡为12点顺时针找线')
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.P3.takeLineAttack12 = GUI:Checkbox('攻击1接两根##takeLineAttack12', M.Config.DmuCfg.P3.takeLineAttack12)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('在第1波中, 先由攻击2接第一根, 然后由攻击1同时接后面两根')
            end
            GUI:SameLine(0, 18)
            M.Config.DmuCfg.P3.takeLineStop22 = GUI:Checkbox('禁止2接两根##autoLookAt', M.Config.DmuCfg.P3.takeLineStop22)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('在第4波中, 先由禁止2接两根, 然后由禁止1接最后一根')
            end
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 标记类型:  ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            M.Config.DmuCfg.P3.markType = GUI:Combo('##P3markType', M.Config.DmuCfg.P3.markType, { '不标记', '标记自身', '标记全队' }, 3)
            GUI:PopItemWidth()
            if M.Config.DmuCfg.P3.markType == 2 then
                GUI:Dummy(10, 0)
                GUI:SameLine()
                M.Config.DmuCfg.P3.delayMark = GUI:Checkbox('延迟标记##p3delayMark', M.Config.DmuCfg.P3.delayMark)
                if GUI:IsItemHovered() then
                    GUI:SetTooltip('勾选后会自动检查队友标记情况, 有标记才会标记自己; 否则Buff出来就标.')
                end
            elseif M.Config.DmuCfg.P3.markType == 3 then
                GUI:Dummy(12, 0)
                GUI:SameLine(0, 0)
                GUI:AlignFirstTextHeightToWidgets()
                GUI:Text(' 标记优先级  ')
                GUI:SameLine(0, 0)
                GUI:PushItemWidth(175)
                local p3mkOrder, p3mkOrderChanged = GUI:InputText('##P3markOrder',
                        M.StringJoin(M.Config.DmuCfg.P3.markOrder, ','), GUI.InputTextFlags_CharsNoBlank)
                GUI:PopItemWidth()
                if p3mkOrderChanged then
                    M.Config.DmuCfg.P3.markOrder = M.StringSplit(p3mkOrder, ',')
                end
            end
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 踩塔12点:  ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            M.Config.DmuCfg.P3.towerHeading = GUI:Combo('##towerHeading', M.Config.DmuCfg.P3.towerHeading, { '脚跟方向', '脚尖方向' }, 2)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 踩塔左右:  ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            M.Config.DmuCfg.P3.towerGround = GUI:Combo('##P3towerGround', M.Config.DmuCfg.P3.towerGround, { '面基', '场基' }, 2)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('面基:以当前自身面向BOSS时的左右分组踩塔\n场基:以当前12点为基准进行左右分组踩塔')
            end
            GUI:PopItemWidth()
        end
        if M.Config.DmuCfg.P4.enable and GUI:CollapsingHeader('P4 凯夫卡&卡奥斯&新生艾克斯迪斯') then
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1,0,0,1, ' 攻略: 盗火, MWW, 不同的地方做了选项')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 雷/水BUFF分散: ')
            GUI:SameLine(0,17)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P4.disType = GUI:Combo('##P4disType', M.Config.DmuCfg.P4.disType, { 'D左TH右', 'TH左D右' }, 2)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 石化眼站位:  ')
            GUI:SameLine(0,30)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P4.eyeType = GUI:Combo('##P4eyeType', M.Config.DmuCfg.P4.eyeType, { '盗火固定式', '常规-眼进人群出', 'MMW人群不动眼动' }, 3)
            GUI:PopItemWidth()
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P4.autoLook = GUI:Checkbox('自动调整面向##p4LockFace', M.Config.DmuCfg.P4.autoLook)
            if M.Config.DmuCfg.P4.autoLook then
                GUI:SameLine(0, 13)
                M.Config.DmuCfg.P4.harkLock = GUI:Checkbox('使用更严格的硬锁定##P4HardLockFace', M.Config.DmuCfg.P4.harkLock)
                if GUI:IsItemHovered() then
                    GUI:SetTooltip('开启后会完全禁止可能会改变面向的事, \n约等于停手, 请谨慎使用')
                end
            end
        end
    end
    M.SaveConfig(M.Config.DmuGuidePath, M.Config.DmuGuideFile, 'DmuCfg')
    GUI:SetWindowSize(wide, 0)
    GUI:End()
end

return DancingMadUI