local DancingMadUI = {}
local wide = 350
local newCfgMode = false
local newFileName = ""

DancingMadUI.draw = function()
    local M = MuAiGuide
    if not M.DancingMadUI.open then
        newCfgMode = false
        return
    end
    GUI:SetNextWindowPos(M.MainUI.uiPos.x, M.MainUI.uiPos.y)
    GUI:SetNextWindowSize(wide, 0, GUI.SetCond_Appearing)
    M.DancingMadUI.visible, M.DancingMadUI.open = GUI:Begin('Dmu Setting', M.DancingMadUI.open)
    if M.DancingMadUI.visible then
        if GUI:CollapsingHeader('全局设置') then
            GUI:AlignFirstTextHeightToWidgets()
            GUI:BulletText('配置文件工具')
            GUI:SameLine(0, 60)
            GUI:Button('打开存档位置', 150, 22)
            if GUI:IsItemClicked(0) then
                local cmd = string.format('explorer "%s"', M.Config.DmuGuidePath)
                local handle = io.popen(cmd)
                if handle then
                    handle:close()
                end
            end
            if newCfgMode then
                GUI:Dummy(20, 0)
                GUI:SameLine(0, 0)
                M.UITool.AddLabel("新配置名：", false)
                GUI:PushItemWidth(200)
                local havaSame = false
                local NewFileName, NewFileNameChanged = GUI:InputText("##NewFileName", newFileName, GUI.InputTextFlags_CharsNoBlank)
                if NewFileNameChanged then
                    local fileName = NewFileName
                    if M.ContainsIgnoreCase(M.Config.DmuCustomList, fileName)
                            or string.lower(fileName) == "guideconfig"
                            or NewFileName == "" or #NewFileName == 0
                    then
                        GUI:TextColored(1, 0, 0, 1, "已存在该名称文件或者名称不合法,无法创建!")
                        havaSame = true
                    else
                        newFileName = NewFileName
                    end
                end
                GUI:PopItemWidth()
                GUI:Dummy(20, 0)
                GUI:SameLine(0, 0)
                GUI:Button("确认", 100, 20)
                if GUI:IsItemClicked(0) then
                    if not havaSame and newFileName ~= nil and #newFileName > 0 then
                        M.SaveFileConfig(M.Config.DmuGuidePath, newFileName, M.Config.DmuCfg)
                        newCfgMode = false
                        if newFileName ~= M.Config.DmuCustomList[M.Config.DmuCustomListIndex] then
                            table.insert(M.Config.DmuCustomList, newFileName)
                        end
                    else
                        M.ShowMsgUI(3, { "已存在该名称文件或者名称不合法,无法创建!" })
                    end
                end
                GUI:SameLine()
                GUI:Button("取消", 100, 20)
                if GUI:IsItemClicked(0) then
                    newFileName = M.Config.DmuCustomList[M.Config.DmuCustomListIndex]
                    newCfgMode = false
                end
            else
                GUI:Dummy(20, 0)
                GUI:SameLine(0, 0)
                GUI:PushItemWidth(300)
                local configIndex, configIndexChange = GUI:Combo("##configIndex", M.Config.DmuCustomListIndex, M.Config.DmuCustomList, 30)
                if configIndexChange then
                    M.Config.DmuCustomListIndex = configIndex
                    newFileName = M.Config.DmuCustomList[M.Config.DmuCustomListIndex]
                end
                GUI:PopItemWidth()
                if M.Config.DmuCustomListIndex == 1 then
                    GUI:Dummy(20, 0)
                    GUI:SameLine(0, 0)
                    GUI:Button("新建配置", 90, 20)
                    if GUI:IsItemClicked(0) then
                        newFileName = ""
                        newCfgMode = true
                    end
                else
                    GUI:Dummy(20, 0)
                    GUI:SameLine(0, 0)
                    GUI:Button("加载此配置", 90, 20)
                    if GUI:IsItemClicked(0) then
                        local fileName = M.Config.DmuCustomList[M.Config.DmuCustomListIndex]
                        local defCfg = M.CreateDmuDefaultCfg()
                        M.Config.DmuCfg = M.LoadFileConfig(M.Config.DmuGuidePath, fileName, defCfg)
                    end
                    GUI:SameLine()
                    GUI:Button("新建配置", 90, 20)
                    if GUI:IsItemClicked(0) then
                        newFileName = ""
                        newCfgMode = true
                    end
                    GUI:SameLine()
                    GUI:Button("保存到此配置", 100, 20)
                    if GUI:IsItemClicked(0) then
                        M.SaveFileConfig(M.Config.DmuGuidePath, newFileName, M.Config.DmuCfg)
                    end
                end
            end
            GUI:Separator()
            GUI:Columns(3, 'switch', false)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:BulletText('总开关')
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
                GUI:SetTooltip('勾选后屏蔽特效, 并且采用A+画紫色危险区\n未勾选使用ImGui画图显示黄色危险区')
            end
        end
        if M.Config.DmuCfg.P1.enable and GUI:CollapsingHeader('P1 凯夫卡·众神之像') then
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('一神')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 职能固定  ')
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
            GUI:TextColored(1, 0, 0, 1, ' 攻略: M S分组AC固定分摊, 近左远右放分散  ')
            GUI:Dummy(0, 0)
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('唰啦啦传送')
            GUI:Dummy(0, 0)
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 回转寿司, 相同buff优先正点放  ')
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.P1.transUnOpt = GUI:Checkbox('开启近战负优化[寿司优化]##P1transUnOpt', M.Config.DmuCfg.P1.transUnOpt)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('启动后混乱在外, 睡眠在内 \n纯粹是特么的负优化！')
            end
            GUI:Dummy(0, 0)
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('最后雷火')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 固定式')
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.P1.autoLookAt = GUI:Checkbox('自动调整面向##P1autoLookAt', M.Config.DmuCfg.P1.autoLookAt)
            if M.Config.DmuCfg.P1.autoLookAt then
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
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 混合优化, 闲人固定')
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P2.towerGuide = GUI:Checkbox('开启踩塔指挥模式##P2towerGuide', M.Config.DmuCfg.P2.towerGuide)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('踩塔组从左到右分别标记攻击1234, \n闲人左边锁链12, 右边禁止12')
            end
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
            GUI:BulletText('一运')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 逃课, 夜音式')
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

            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 击退站位方案:   ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            M.Config.DmuCfg.P3.kickType = GUI:Combo('##P3kickType', M.Config.DmuCfg.P3.kickType, { 'THHT', 'HTH', '8人一起' }, 3)
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
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P3.autoTargetEx = GUI:Checkbox('击退前自动切换到EX防止出现锁面向问题##autoTargetEx', M.Config.DmuCfg.P3.autoTargetEx)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('BUFF剩余5秒锁定, BUFF消失停止, 检查\n到目标不对会一直tab小艾，谨慎使用!')
            end
            GUI:BulletText('二运')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 盗火, 按标记顺序')
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
            if GUI:IsItemHovered() then
                GUI:SetTooltip('标记全队：如果有人噶了导致没有BUFF会不标记')
            end
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
            GUI:AlignFirstTextHeightToWidgets()
            GUI:BulletText('放圈踩塔')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 盗火orCCHH, 其他请选择关闭')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 方案设置:  ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            local takeTowerTypeChanged
            M.Config.DmuCfg.P3.takeTowerType, takeTowerTypeChanged = GUI:Combo('##takeTowerType', M.Config.DmuCfg.P3.takeTowerType, { '关闭放圈', 'NOCCHH', '盗火', }, 3)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('修改这里选项为CCHH或者盗火下面两个选项\n会自动修改, 如果你打的是标准的CCHH或者\n盗火, 请勿手动修改下方的两个设置')
            end
            if takeTowerTypeChanged then
                d('takeTowerTypeChanged')
                d(M.Config.DmuCfg.P3.takeTowerType)
                if M.Config.DmuCfg.P3.takeTowerType == 2 then
                    M.Config.DmuCfg.P3.towerGround = 2
                    M.Config.DmuCfg.P3.towerHeading = 1
                else
                    if M.Config.DmuCfg.P3.takeTowerType == 3 then
                        M.Config.DmuCfg.P3.towerGround = 1
                        M.Config.DmuCfg.P3.towerHeading = 2
                    end
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
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 盗火, MWW, 不同的地方做了选项')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 雷/水BUFF分散: ')
            GUI:SameLine(0, 17)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P4.disType = GUI:Combo('##P4disType', M.Config.DmuCfg.P4.disType, { 'D左TH右', 'TH左D右' }, 2)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 石化眼站位:  ')
            GUI:SameLine(0, 30)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P4.eyeType = GUI:Combo('##P4eyeType', M.Config.DmuCfg.P4.eyeType, { '盗火固定式', '常规-眼进人群出', 'MMW人群不动眼动', '瞎站(关闭)' }, 4)
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
        if M.Config.DmuCfg.P5.enable and GUI:CollapsingHeader('P5 魔法少女?凯夫卡') then
            GUI:Dummy(0, 0)
            GUI:SameLine()
            GUI:BulletText('疯狂交响曲')
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P5.isLeaning = GUI:Checkbox('斜米站位##p5isLeaning', M.Config.DmuCfg.P5.isLeaning)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('不勾选就是常规八方')
            end
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 站位顺序:  ')
            GUI:SameLine()
            GUI:PushItemWidth(175)
            local p5JobOrder, p5JobOrderChanged = GUI:InputText('##P5MaddeningOrchestraOrder',
                    M.StringJoin(M.Config.DmuCfg.P5.jobOrder, ','), GUI.InputTextFlags_CharsNoBlank)
            if p5JobOrderChanged then
                M.Config.DmuCfg.P5.jobOrder = M.StringSplit(p5JobOrder, ',')
            end
            if GUI:IsItemHovered() then
                GUI:SetTooltip('顺序：C（下）开始逆时针一周')
            end
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine()
            GUI:BulletText('混沌末世（地火）')
            GUI:Dummy(0, 0)
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 预警次数:  ')
            GUI:SameLine()
            local groundCntChanged, groundCntValue
            GUI:PushItemWidth(100)
            groundCntValue, groundCntChanged = GUI:InputInt('##P5groundCnt', M.Config.DmuCfg.P5.groundCnt, 1, 1)
            GUI:PopItemWidth()
            if groundCntChanged then
                if groundCntValue < 2 then
                    M.Config.DmuCfg.P5.groundCnt = 2
                elseif groundCntValue > 7 then
                    M.Config.DmuCfg.P5.groundCnt = 7
                else
                    M.Config.DmuCfg.P5.groundCnt = groundCntValue
                end
            end
            GUI:Dummy(0, 0)
            GUI:Dummy(0, 0)
            GUI:SameLine()
            GUI:BulletText('遗弃末世（软狂暴）')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 跑位方案:  ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            M.Config.DmuCfg.P5.forsakenType = GUI:Combo('##P4ForsakenType', M.Config.DmuCfg.P5.forsakenType,
                    { '斜点全顺', '其他（关闭）' }, 2)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 跑位起点:  ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            if M.Config.DmuCfg.P5.forsakenType then
                M.Config.DmuCfg.P5.forsakenTypeStart = GUI:Combo('##P5forsakenTypeStart', M.Config.DmuCfg.P5.forsakenTypeStart, { '左下:4', '右下:3', '右上:2', '左上:1' }, 4)
            end
            GUI:PopItemWidth()
        end
    end
    M.SaveConfig(M.Config.DmuGuidePath, M.Config.DmuGuideFile, 'DmuCfg')
    GUI:SetWindowSize(wide, 0)
    GUI:End()
end

return DancingMadUI