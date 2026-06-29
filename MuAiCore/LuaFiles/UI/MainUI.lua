local MainUI = {}
local WIN_WIDE = 355
--[[
===========================
    主UI VIEW
===========================
]]

--- 判断当前成员是否被选中
local IsSelected = function(member)
    if member.label == MuAiGuide.MainUI.selected then
        return true
    end
    return false
end

---@param M MuAiGuide
local drawJobTab = function(M)
    if M.SelfPos then
        GUI:BulletText('当前职能:')
        GUI:SetWindowFontSize(2.5)
        GUI:Dummy(10, 0)
        GUI:SameLine()
        if table.size(M.Party) == 4 then
            if M.SelfPos == 'MT' then
                GUI:TextColored(0, 0, 1, 1, M.SelfPos)
            elseif M.SelfPos == 'H1' then
                GUI:TextColored(0, 1, 0, 1, M.SelfPos)
            else
                GUI:TextColored(1, 0, 0, 1, M.SelfPos)
            end
        else
            if M.SelfPos == 'MT' or M.SelfPos == 'ST' then
                GUI:TextColored(0, 0.3, 1, 1, M.SelfPos)
            elseif M.SelfPos == 'H1' or M.SelfPos == 'H2' then
                GUI:TextColored(0, 1, 0, 1, M.SelfPos)
            else
                GUI:TextColored(1, 0, 0, 1, M.SelfPos)
            end
        end

        if M.Develop.JobView then
            GUI:SameLine()
            GUI:TextColored(1, 0, 0, 1, '[DEBUG]')
        end
        GUI:SetWindowFontSize(1)
        GUI:Dummy(10, 0)
        GUI:SameLine()
        if M.MultiGuide.onMap() then
            local multiEnable, multiChanged = GUI:Checkbox('指导模式', M.MultiGuide.enable)
            M.MultiGuide.enable = multiEnable
            if multiChanged then
                if not multiEnable then
                    M.MultiGuide.initList()
                end
            end
            if GUI:IsItemHovered() then
                GUI:SetTooltip("可以显示其他队友当前应该去哪")
            end
            if M.MultiGuide.enable then
                GUI:SameLine()
                if M.MultiGuide.Count() > 1 then
                    GUI:Button('清空指导', 100, 20)
                    if GUI:IsItemClicked(0) then
                        M.MultiGuide.initList()
                        M.ShowMsgUI(3, { '已清空指导列表' })
                    end
                else
                    GUI:Button('全选指导', 100, 20)
                    if GUI:IsItemClicked(0) then
                        M.MultiGuide.initList()
                        for job, _ in pairs(M.Party) do
                            if job ~= M.SelfPos then
                                M.MultiGuide.addPlayer(job)
                            end
                        end
                    end
                end
                GUI:SameLine()
                GUI:Button('还原颜色', 100, 20)
                if GUI:IsItemClicked(0) then
                    M.MultiGuide.resetAllColor()
                    M.ShowMsgUI(3, { '已还原默认指路颜色' })
                end
            end
        end
        GUI:AlignFirstTextHeightToWidgets()
        GUI:TextColored(0, 1, 0, 1, '   ※拖动角色名修改职能')
    else
        GUI:AlignFirstTextHeightToWidgets()
        GUI:TextColored(1, 0, 0, 1, '  当前没有加入队伍')
    end
    GUI:SameLine(195, 0)
    GUI:Button('默认顺序设置', 135, 22)
    if GUI:IsItemClicked(0) then
        M.DefaultJobsUI.open = not M.DefaultJobsUI.open
    end
    GUI:Dummy(1, 1)
    GUI:Separator()
    GUI:Dummy(1, 1)
    if M.MultiGuide.enable then
        GUI:Text('  |职能|职业|指导|颜色|       小队成员      |')
    else
        GUI:Text('  | 职能 | 职业 |          小队成员         |')
    end
    GUI:Dummy(6, 0)
    GUI:SameLine()
    GUI:PushItemWidth(303)
    if M.GetPartyCnt() == 0 then
        if M.Party == nil then
            M.Party = {}
        end
        M.Party.MT = nil
        M.Party.ST = nil
        M.Party.H1 = nil
        M.Party.H2 = nil
        M.Party.D1 = nil
        M.Party.D2 = nil
        M.Party.D3 = nil
        M.Party.D4 = nil
    end
    local partyMembers, listHeight
    if M.GetPartyCnt() == 4 then
        listHeight = 130
        partyMembers = {
            { info = M.Party.MT, label = 'MT' },
            { info = M.Party.H1, label = 'H1' },
            { info = M.Party.D1, label = 'D1' },
            { info = M.Party.D2, label = 'D2' },
        }
    else
        listHeight = 280
        partyMembers = {
            { info = M.Party.MT, label = 'MT' },
            { info = M.Party.ST, label = 'ST' },
            { info = M.Party.H1, label = 'H1' },
            { info = M.Party.H2, label = 'H2' },
            { info = M.Party.D1, label = 'D1' },
            { info = M.Party.D2, label = 'D2' },
            { info = M.Party.D3, label = 'D3' },
            { info = M.Party.D4, label = 'D4' }
        }
    end
    GUI:ListBoxHeader('##Jobs', 310, listHeight)
    for i, member in ipairs(partyMembers) do
        local ptMember = partyMembers[i]
        if ptMember.label == M.SelfPos then
            GUI:Dummy(0, 5)
            local selectPath = GetLuaModsPath() .. 'MuAiCore\\Image\\mark.png'
            GUI:SameLine(297)
            GUI:Image(selectPath, 15, 25)
            GUI:SameLine(-1)
            GUI:Image(selectPath, 15, 25, 1, 0, 0, 1)
            if M.MultiGuide.enable then
                GUI:SameLine(12)
            else
                GUI:SameLine(20)
            end
        else
            if M.MultiGuide.enable then
                GUI:Dummy(0, 5)
            else
                GUI:Dummy(8, 5)
            end
            GUI:SameLine()
        end
        GUI:AlignFirstTextHeightToWidgets()
        GUI:SetWindowFontSize(1.3)
        if M.GetPartyCnt() == 4 then
            if i == 1 then
                GUI:TextColored(0, 0.3, 1, 1, ptMember.label)
            elseif i == 2 then
                GUI:TextColored(0, 1, 0, 1, ptMember.label)
            else
                GUI:TextColored(1, 0, 0, 1, ptMember.label)
            end
        else
            if i == 1 or i == 2 then
                GUI:TextColored(0, 0.3, 1, 1, ptMember.label)
            elseif i == 3 or i == 4 then
                GUI:TextColored(0, 1, 0, 1, ptMember.label)
            else
                GUI:TextColored(1, 0, 0, 1, ptMember.label)
            end
        end
        GUI:SetWindowFontSize(1)
        if M.MultiGuide.enable then
            GUI:SameLine(46)
        else
            GUI:SameLine(70)
        end
        if ptMember.info ~= nil and ptMember.info.job ~= nil and ptMember.info.name ~= nil then
            local path = GetLuaModsPath() .. 'MuAiCore\\Image\\JobIcon\\' .. tostring(ptMember.info.job) .. '.png'
            GUI:Image(path, 25, 25)
            if M.MultiGuide.enable then
                local checkText = '##multiGuide_' .. ptMember.label
                local curIsOpen
                if ptMember.label == M.SelfPos then
                    curIsOpen = false
                else
                    curIsOpen = M.MultiGuide.isPlayerInGuide(ptMember.info.id)
                end
                GUI:SameLine(90)
                local curUIColor = nil
                local style = GUI.GetStyle()
                for _, color in pairs(style.colors) do
                    if color[5] == 'FrameBg' then
                        curUIColor = color
                        break
                    end
                end
                local tJobSelect, tJobChanged
                if curUIColor then
                    GUI:PushStyleColor(GUI.Col_FrameBg, curUIColor[1] / 2 * 3, curUIColor[2] / 2 * 3, curUIColor[3] / 2 * 3, curUIColor[4])
                    tJobSelect, tJobChanged = GUI:Checkbox(checkText, curIsOpen)
                    GUI:PopStyleColor()
                else
                    tJobSelect, tJobChanged = GUI:Checkbox(checkText, curIsOpen)
                end

                if tJobChanged then
                    if ptMember.label == M.SelfPos then
                        M.ShowMsgUI(3, { '无法修改自己是否在指导列表！' })
                    else
                        if tJobSelect then
                            M.MultiGuide.addPlayer(ptMember.label)
                        else
                            M.MultiGuide.removePlayer(ptMember.label)
                        end
                    end
                end

                GUI:SameLine(122)
                local curColor, colorChange, cR, cG, cB, cA
                if ptMember.label == M.SelfPos then
                    curColor = M.Config.Main.GuideColor
                    cR, cG, cB, cA, colorChange = GUI:ColorEdit4('##guideToolColor_' .. ptMember.label, curColor.r, curColor.g, curColor.b, curColor.a,
                            GUI.ColorEditMode_NoInputs | GUI.ColorEditMode_NoTooltip)
                    if GUI:IsItemHovered() then
                        GUI:SetTooltip("你无法修改自己的指路颜色，请到基本设置修改！")
                    end
                else
                    curColor = M.Config.Main.MultiColor[ptMember.label]

                    cR, cG, cB, cA, colorChange = GUI:ColorEdit4('##guideToolColor_' .. ptMember.label, curColor.r, curColor.g, curColor.b, curColor.a,
                            GUI.ColorEditMode_NoInputs)
                end

                if colorChange then
                    M.Config.Main.MultiColor[ptMember.label] = { r = cR, g = cG, b = cB, a = cA }
                end
            end
            GUI:SameLine(0, 25)
            local text = ptMember.info.name
            if ptMember.label == M.SelfPos and M.IsVideo() then
                text = M.GetJobFullNameById(M.Party[M.SelfPos].job)
            end
            local itemW = GUI:GetContentRegionAvailWidth()
            local textW = GUI:CalcTextSize(text)
            local offsetX = (itemW - textW) * 0.5
            GUI:Selectable(
                    string.rep(" ", offsetX / GUI:CalcTextSize(" ")) .. text,
                    IsSelected(member),
                    GUI.SelectableFlags_DontClosePopups,
                    0,
                    24
            )
        else
            local path = GetLuaModsPath() .. 'MuAiCore\\Image\\JobIcon\\00.png'
            if i <= 2 then
                path = GetLuaModsPath() .. 'MuAiCore\\Image\\JobIcon\\TankRole.png'
            elseif i <= 4 then
                path = GetLuaModsPath() .. 'MuAiCore\\Image\\JobIcon\\HealerRole.png'
            else
                path = GetLuaModsPath() .. 'MuAiCore\\Image\\JobIcon\\DPSRole.png'
            end
            GUI:Image(path, 25, 25)
            GUI:SameLine(0, 25)
            GUI:Selectable('        未知玩家' .. i, IsSelected(member), GUI.SelectableFlags_DontClosePopups, 0, 24)
        end
        if M.GetPartyCnt() > 0 and GUI:IsItemHovered(GUI.HoveredFlags_AllowWhenBlockedByPopup + GUI.HoveredFlags_AllowWhenBlockedByActiveItem + GUI.HoveredFlags_AllowWhenOverlapped) then
            if GUI:IsMouseDown(0) then
                if M.MainUI.mousePosition == nil then
                    if M.MainUI.mousePosition ~= ptMember.label then
                        M.MainUI.mousePosition = ptMember.label
                    end
                    if M.MainUI.selected ~= ptMember.label then
                        M.MainUI.selected = ptMember.label
                    end
                elseif M.MainUI.mousePosition ~= ptMember.label then
                    M.Debug('站位交换：' .. M.MainUI.mousePosition .. '<==>' .. ptMember.label)
                    local temp = M.Party[M.MainUI.mousePosition]
                    M.Party[M.MainUI.mousePosition] = M.Party[ptMember.label]
                    M.Party[ptMember.label] = temp
                    if M.Party ~= nil and M.Party[M.MainUI.mousePosition] ~= nil then
                        -- 职能调整
                        if M.Party[M.MainUI.mousePosition].id == M.GetPlayer().id then
                            M.SelfPos = M.MainUI.mousePosition;
                        elseif M.Party[ptMember.label].id == M.GetPlayer().id then
                            M.SelfPos = ptMember.label;
                        end
                        M.MainUI.mousePosition = ptMember.label
                        if M.MainUI.selected ~= ptMember.label then
                            M.MainUI.selected = ptMember.label
                        end
                    end
                    M.MultiGuide.RefreshDic()
                end
            end
        end
        if M.MainUI.mousePosition ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then
            M.MainUI.mousePosition = nil
        end
        if M.MainUI.selected ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then
            M.MainUI.selected = nil
        end

        local size
        if M.Party ~= nil and (M.GetPartyCnt() == 4 or M.GetPartyCnt() == 8) then
            size = M.GetPartyCnt()
        else
            size = 8
        end
        if i < size then
            GUI:Separator()
        end
    end
    GUI:ListBoxFooter()
    if M.MainUI.mousePosition ~= nil and
            not GUI:IsItemHovered(GUI.HoveredFlags_AllowWhenBlockedByPopup + GUI.HoveredFlags_AllowWhenBlockedByActiveItem + GUI.HoveredFlags_AllowWhenOverlapped)
    then
        M.MainUI.mousePosition = nil
    end
    GUI:Dummy(6, 0)
    GUI:SameLine()
    GUI:Button('重新加载小队列表', 310, 30)
    if GUI:IsItemClicked(0) then
        M.LoadParty()
    end
end
---@param M MuAiGuide
local drawBaseSettingTab = function(M)
    GUI:Columns(2, 'BindKey', false)
    GUI:Dummy(6, 0)
    GUI:SameLine()
    GUI:AlignFirstTextHeightToWidgets()
    GUI:Text('更新下载源：  ')
    GUI:NextColumn()
    GUI:PushItemWidth(123)
    M.Config.Main.DownLoadSource = GUI:Combo('##DownLoadSource', M.Config.Main.DownLoadSource, { 'GitHub', '腾讯云' }, 2)
    GUI:PopItemWidth()
    GUI:NextColumn()
    GUI:Dummy(6, 0)
    GUI:SameLine()
    GUI:AlignFirstTextHeightToWidgets()
    GUI:Text('UI开启快捷键：  ')
    GUI:NextColumn()
    GUI:PushItemWidth(60)
    local curKeyIndex = M.Config.Main.KeyBindFirst - 15
    local newIndex, keyBind1Change = GUI:Combo('##KEYBNIN1', curKeyIndex, M.Config.Key1, 4)
    if keyBind1Change then
        M.Config.Main.KeyBindFirst = newIndex + 15
    end
    GUI:PopItemWidth()
    GUI:SameLine()
    GUI:Text('+')
    GUI:SameLine()
    GUI:PushItemWidth(40)
    local curKeyIndex2
    if M.Config.Main.KeyBindSecond <= 90 then
        curKeyIndex2 = M.Config.Main.KeyBindSecond - 64
    else
        curKeyIndex2 = M.Config.Main.KeyBindSecond - 165
    end
    local newIndex2, keyBind1Change2 = GUI:Combo('##KEYBNIN2', curKeyIndex2, M.Config.Key2, 27)
    if keyBind1Change2 then
        if newIndex2 <= 26 then
            M.Config.Main.KeyBindSecond = newIndex2 + 64
        else
            M.Config.Main.KeyBindSecond = newIndex2 + 165
        end
    end
    GUI:PopItemWidth()
    GUI:Dummy(0, 0)
    GUI:NextColumn()
    GUI:Columns(2, 'AutoUpdate', false)
    GUI:Dummy(6, 0)
    GUI:SameLine()
    M.Config.Main.LogToEchoMsg = GUI:Checkbox('聊天栏提示信息', M.Config.Main.LogToEchoMsg)
    GUI:NextColumn()
    M.Config.Main.TTS = GUI:Checkbox('开启TTS播报', M.Config.Main.TTS)
    GUI:Separator()
    GUI:Dummy(0, 0)
    GUI:NextColumn()
    GUI:Dummy(6, 0)
    GUI:SameLine()
    local colorChange1, colorChange2, colorChange3
    M.Config.Main.GuideColor.r, M.Config.Main.GuideColor.g, M.Config.Main.GuideColor.b, M.Config.Main.GuideColor.a, colorChange1 = GUI:ColorEdit4('指路工具颜色',
            M.Config.Main.GuideColor.r,
            M.Config.Main.GuideColor.g,
            M.Config.Main.GuideColor.b,
            M.Config.Main.GuideColor.a,
            GUI.ColorEditMode_NoInputs)

    GUI:NextColumn()
    GUI:Button('指路工具预览', 140, 20)
    if GUI:IsItemClicked(0) then
        M.DrawGuidePreView()
    end
    GUI:NextColumn()
    GUI:Dummy(6, 0)
    GUI:SameLine()
    M.Config.Main.GuidePairColor.r, M.Config.Main.GuidePairColor.g, M.Config.Main.GuidePairColor.b, M.Config.Main.GuidePairColor.a, colorChange2 = GUI:ColorEdit4('分摊连线颜色',
            M.Config.Main.GuidePairColor.r,
            M.Config.Main.GuidePairColor.g,
            M.Config.Main.GuidePairColor.b,
            M.Config.Main.GuidePairColor.a,
            GUI.ColorEditMode_NoInputs)
    GUI:NextColumn()
    GUI:Button('分摊连线预览', 140, 20)
    if GUI:IsItemClicked(0) then
        M.DrawGuidePreViewGather()
    end
    GUI:Separator()
    GUI:NextColumn()
    GUI:Dummy(0, 0)
    GUI:Dummy(6, 0)
    GUI:SameLine()
    M.Config.Main.ShowTargetPos = GUI:Checkbox('显示目标位置', M.Config.Main.ShowTargetPos)
    if M.Config.Main.ShowTargetPos then
        GUI:NextColumn()
        M.Config.Main.ShowTargetPosTank = GUI:Checkbox('包含坦克职业', M.Config.Main.ShowTargetPosTank)
        GUI:NextColumn()
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Config.Main.TargetPosColor.r, M.Config.Main.TargetPosColor.g, M.Config.Main.TargetPosColor.b, M.Config.Main.TargetPosColor.a, colorChange3 = GUI:ColorEdit4('目标位置颜色',
                M.Config.Main.TargetPosColor.r,
                M.Config.Main.TargetPosColor.g,
                M.Config.Main.TargetPosColor.b,
                M.Config.Main.TargetPosColor.a,
                GUI.ColorEditMode_NoInputs)
        GUI:NextColumn()
        local targetPointSize
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text('大小:')
        GUI:SameLine()
        GUI:PushItemWidth(85)
        M.Config.Main.TargetPosSize, targetPointSize = GUI:SliderFloat('##TargetPointSize', M.Config.Main.TargetPosSize, 1, 30)
        GUI:PopItemWidth()
    end
    GUI:Columns(1)
    GUI:Dummy(15, 0)
    GUI:SameLine(0, 0)
    M.Config.Main.LogEnable = GUI:Checkbox('输出调试日志##LogEnable', M.Config.Main.LogEnable)
    if GUI:IsItemHovered() then
        GUI:SetTooltip('日志会写入MuAiCore\\Log，并脱敏队员名称')
    end
    GUI:Separator()
    GUI:Dummy(0, 0)
    GUI:Dummy(6, 0)
    GUI:SameLine()
    M.Config.Main.DrawBlackListEnable = GUI:Checkbox('开启绘制黑名单', M.Config.Main.DrawBlackListEnable)
    if GUI:IsItemHovered() then
        GUI:SetTooltip('在指定地图自动关闭Argus自动绘图')
    end
    if M.Config.Main.DrawBlackListEnable then
        GUI:Dummy(6, 0)
        GUI:SameLine()
        GUI:Text('黑名单地图ID:')
        GUI:Dummy(6, 0)
        GUI:SameLine()
        GUI:PushItemWidth(315)
        GUI:SameLine()
        local drBlackListInput, blackChanged = GUI:InputText('##DrawBlackList', M.StringJoin(M.Config.Main.DrawBlackList, ','), GUI.InputTextFlags_CharsNoBlank)
        if blackChanged then
            if drBlackListInput ~= nil and drBlackListInput ~= '' then
                local blackList = M.StringSplit(drBlackListInput, ',')
                M.Config.Main.DrawBlackList = {}
                for _, mapId in pairs(blackList) do
                    table.insert(M.Config.Main.DrawBlackList, tonumber(mapId))
                end
            end
        end
        GUI:PopItemWidth()
        GUI:Dummy(6, 0)
        GUI:SameLine()
        GUI:Button('快速添加', 150, 25)
        if GUI:IsItemClicked(0) then
            local mapId = tostring(Player.localmapid)
            M.ShowMsgUI(1, { '是确认将当前地图ID[' .. mapId .. ']添加到黑名单' }
            , function()
                        if not table.contains(M.Config.Main.DrawBlackList, Player.localmapid) then
                            table.insert(M.Config.Main.DrawBlackList, Player.localmapid)
                            M.ShowMsgUI(3, { '添加成功！' })
                        else
                            M.ShowMsgUI(3, { '当前地图ID' .. mapId .. '已经在黑名单中，无法重复添加！' })
                        end
                    end
            )
        end
        if GUI:IsItemHovered() then
            GUI:SetTooltip('将当前地图ID添加到黑名单')
        end
        GUI:SameLine(190)
        GUI:Button('快速移除', 150, 25)
        if GUI:IsItemClicked(0) then
            local mapId = tostring(Player.localmapid)
            M.ShowMsgUI(1, { '是确认将当前地图ID[' .. mapId .. ']从黑名单移除？' }, function()
                if table.contains(M.Config.Main.DrawBlackList, Player.localmapid) then
                    for i = #M.Config.Main.DrawBlackList, 1, -1 do
                        if M.Config.Main.DrawBlackList[i] == Player.localmapid then
                            table.remove(M.Config.Main.DrawBlackList, i)
                            M.ShowMsgUI(3, { '移除成功！' })
                            break
                        end
                    end
                else
                    M.ShowMsgUI(3, { '当前地图ID' .. mapId .. '不在黑名单中，无法移除！' })
                end
            end)
        end
        if GUI:IsItemHovered() then
            GUI:SetTooltip('将当前地图ID从黑名单移除')
        end
    end
    GUI:Separator()
    GUI:Dummy(0, 0)
    GUI:Dummy(6, 0)
    GUI:SameLine()
    GUI:AlignFirstTextHeightToWidgets()
    GUI:Button('恢复本页默认设置', 310, 35)
    if GUI:IsItemClicked(0) then
        M.ShowMsgUI(1, { "恢复默认操作不可逆，确定吗？", }, M.LoadDefWithOutRaidSetting)
    end
end
---@param M MuAiGuide
local drawRaidSettingTab = function(M)
    GUI:TextColored(1, 1, 0, 1, ' 使用说明:')
    GUI:TextColored(1, 1, 0, 1, '  1.光暗未来绝境战, 时间轴: MuAi\\MuaiGuideFru')
    GUI:TextColored(1, 1, 0, 1, '  2.欧米茄绝境检定战, 时间轴: MuAi\\MuAiGuideTop')
    GUI:TextColored(1, 1, 0, 1, '  3.M11S|M12S, [全局]: MuAi\\MuAiGeneral')
    GUI:TextColored(1, 1, 0, 1, '  4.除上述外, 其他副本无继承, 启用即可!')
    if GUI:CollapsingHeader('绝本') then
        GUI:BulletText('欧米茄绝境检定战')
        GUI:Text('   仅默认设置, 国服野队一套打法')
        GUI:Dummy(0, 7)
        GUI:BulletText('光暗未来绝境战')
        GUI:Dummy(15, 0)
        GUI:SameLine()
        GUI:Button('指路设置', 150, 25)
        if GUI:IsItemClicked(0) then
            M.ConfigFruInit = false
            M.FruConfigUI.open = not M.FruConfigUI.open
            M.FruMitigationUI.open = false
            M.DancingMadUI.open = false
            M.DmuDpsUI.open = false
            M.CatZDmuTankUI.open = false
        end
        GUI:SameLine()
        GUI:Button('减伤设置', 150, 25)
        if GUI:IsItemClicked(0) then
            if M.IsHealer(Player.job) then
                M.InfoNoLog('不支持治疗职业<se.1>')
            else
                M.FruMitigationUI.open = not M.FruMitigationUI.open
                M.FruConfigUI.open = false
            end
            M.DancingMadUI.open = false
            M.DmuDpsUI.open = false
            M.CatZDmuTankUI.open = false
        end
        GUI:Dummy(0, 7)
        local DmuCfgChanged
        M.Config.DmuCfg.Enable, DmuCfgChanged = GUI:Checkbox('妖星乱舞绝境战##DmuEnable', M.Config.DmuCfg.Enable)
        if GUI:IsItemHovered() then
            GUI:SetTooltip('是否开启妖星乱舞绝境战相关功能')
        end
        if M.Config.DmuCfg.Enable then
            GUI:Dummy(15, 0)
            GUI:SameLine()
            GUI:Button('设置绘制指路', 150, 25)
            if GUI:IsItemClicked(0) then
                M.DancingMadUI.open = not M.DancingMadUI.open
                M.CatZDmuTankUI.open = false
                M.DmuDpsUI.open = false
                M.FruConfigUI.open = false
                M.FruMitigationUI.open = false
            end
            
            if M.IsTank(Player.job) then
                GUI:SameLine(0, 8)
                GUI:Button('CatZTankUI', 150, 25)
                if M.DmuDpsUI.open then
                    M.DmuDpsUI.open = false
                end
                if GUI:IsItemClicked(0) then
                    M.CatZDmuTankUI.open = not M.CatZDmuTankUI.open
                    M.DancingMadUI.open = false
                    M.FruConfigUI.open = false
                    M.FruMitigationUI.open = false
                end
            elseif M.IsDps(Player.job) then
                GUI:SameLine(0, 8)
                GUI:Button('DPS减伤UI', 150, 25)
                if M.CatZDmuTankUI.open then
                    M.CatZDmuTankUI.open = false
                end
                if GUI:IsItemClicked(0) then
                    M.DmuDpsUI.open = not M.DmuDpsUI.open
                    M.DancingMadUI.open = false
                    M.FruConfigUI.open = false
                    M.FruMitigationUI.open = false
                end
            end
        end
        if DmuCfgChanged then
            M.SaveConfig(M.Config.DmuGuidePath, M.Config.DmuGuideFile, 'DmuCfg')
        end
    end

    if GUI:CollapsingHeader('零式') then
        GUI:Dummy(6, 0)
        GUI:SameLine()
        if GUI:CollapsingHeader('阿卡狄亚零式-重量级3') then
            GUI:Dummy(6, 0)
            GUI:SameLine()
            M.Config.Main.M11SExDraw = GUI:Checkbox('开启绘图', M.Config.Main.M11SExDraw)
            if M.Config.Main.M11SExDraw then
                GUI:TextColored(1, 0, 1, 1, '   请注意: 绘图包含全部机制, 为防止花眼')
                GUI:TextColored(1, 0, 1, 1, '   建议使用时请注意关闭其他绘图, 并将地')
                GUI:TextColored(1, 0, 1, 1, '   图ID 1325 添加到屏蔽黑名单！')
            end
            GUI:Dummy(6, 0)
            GUI:SameLine()
            M.Config.Main.M11SOrbitalOmenAllMelee = GUI:Checkbox('星轨链远程职业也场中处理', M.Config.Main.M11SOrbitalOmenAllMelee)
            GUI:Dummy(6, 0)
            GUI:SameLine()
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('王者陨石闲人踩塔方式: ')
            GUI:SameLine(0, 15)
            GUI:PushItemWidth(65)
            local m11sKickType, m11sKickTypeChange = GUI:Combo('##m11sKickType', M.Config.Main.M11SKickType, { '直飞', '斜飞' }, 4)
            if m11sKickTypeChange then
                M.Config.Main.M11SKickType = m11sKickType
            end
            GUI:PopItemWidth()
            GUI:Dummy(6, 0)
            GUI:SameLine()
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('陨石狂奔22分摊方式: ')
            GUI:SameLine(0, 31)
            GUI:PushItemWidth(65)
            local m11sGatherType, m11sGatherTypeChange = GUI:Combo('##m11sGatherType', M.Config.Main.M11SGatherType, { 'X字', '十字' }, 4)
            if m11sGatherTypeChange then
                M.Config.Main.M11SGatherType = m11sGatherType
            end
            GUI:PopItemWidth()
        end
        GUI:Dummy(6, 0)
        GUI:SameLine()
        if GUI:CollapsingHeader('阿卡狄亚零式-重量级4') then
            GUI:Dummy(6, 0)
            GUI:SameLine()
            M.Config.Main.M12SAutoFace1 = GUI:Checkbox('门神1运自动面向, 面向方式:', M.Config.Main.M12SAutoFace1)
            GUI:SameLine(0, 15)
            if M.Config.Main.M12SAutoFace1 then
                GUI:PushItemWidth(80)
                local faceType, faceTypeChange = GUI:Combo('##FaceType', M.Config.Main.M12SAutoFaceType, { '传统', 'UpTime', '一字', 'MMW' }, 4)
                if faceTypeChange then
                    M.Config.Main.M12SAutoFaceType = faceType
                end
                GUI:PopItemWidth()
            end
            GUI:Dummy(6, 0)
            GUI:SameLine()
            M.Config.Main.M12SAutoFace2 = GUI:Checkbox('本体2运自动面向正上', M.Config.Main.M12SAutoFace2)

            GUI:Dummy(6, 0)
            GUI:SameLine()
            M.Config.Main.M12SP2is13 = GUI:Checkbox('本体3运1|3分组撞球（仅奶妈有用）', M.Config.Main.M12SP2is13)
            GUI:Dummy(6, 0)
            GUI:SameLine()
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('本体4运打法：')
            GUI:SameLine(0, 45)
            GUI:PushItemWidth(80)
            local newType, m12sP4TypeChanged = GUI:Combo('##M12SP4Type', M.Config.Main.M12SP4Type, { '盗火改', 'NOCCHH' }, 4)
            if m12sP4TypeChanged then
                M.Config.Main.M12SP4Type = newType
            end
            GUI:PopItemWidth()
            GUI:Dummy(6, 0)
            GUI:SameLine()
            M.Config.Main.M12SP4UpTime = GUI:Checkbox('近战优化', M.Config.Main.M12SP4UpTime)
            GUI:SameLine()
            GUI:Dummy(6, 0)
            GUI:SameLine(0, 36)
            M.Config.Main.M12SP4SendMacro = GUI:Checkbox('发宏', M.Config.Main.M12SP4SendMacro)
            if M.Config.Main.M12SP4SendMacro then
                GUI:TextColored(1, 0, 0, 1, '   注意：宏的很快, 有被看出开了的风险！')
            end
            GUI:Dummy(6, 0)
            GUI:SameLine()
            M.Config.Main.M12SExDraw = GUI:Checkbox('追加绘图', M.Config.Main.M12SExDraw)
            if M.Config.Main.M12SExDraw then
                GUI:TextColored(1, 0, 1, 1, '  添加一些额外的绘图, 包括:')
                GUI:TextColored(1, 0, 1, 1, '    1.门神, 致命灾变')
                GUI:TextColored(1, 0, 1, 1, '    2.本体, 1运, 火暗点名')
                GUI:TextColored(1, 0, 1, 1, '    3.本体, 4运, 踩塔激光, 击退')
                GUI:TextColored(1, 0, 1, 1, '    4.本体, 4运, 远近')
            end
        end
    end
    if GUI:CollapsingHeader('其他') then
        GUI:Dummy(6, 0)
        GUI:SameLine()
        if GUI:CollapsingHeader('异闻商客奇谭') then
            GUI:Dummy(6, 5)
            GUI:SameLine()
            M.Config.Main.Merchant = GUI:Checkbox('全局开关##Merchant', M.Config.Main.Merchant)
            GUI:TextColored(0, 1, 0, 1, '  攻略：MMW全2，如攻略不同建议关闭指路')
            GUI:Separator()
            if M.Config.Main.Merchant then
                GUI:Dummy(6, 5)
                GUI:SameLine()
                M.Config.Main.MerchantDraw = GUI:Checkbox('开启绘图##Merchant', M.Config.Main.MerchantDraw)
                if M.Config.Main.MerchantDraw then
                    GUI:TextColored(1, 0, 1, 1, '  防止花眼请关闭其他绘图, 并将1317加入到')
                    GUI:TextColored(1, 0, 1, 1, '  黑名单, 并停用Anyone全局')
                    GUI:SameLine()
                    GUI:TextColored(1, 1, 0, 1, '[AMT]')
                    GUI:SameLine()
                    GUI:TextColored(1, 0, 1, 1, '开头全部')
                    GUI:TextColored(1, 0, 1, 1, '  ArgusDraws+用户请一定关闭加亮！')
                end
                GUI:Separator()
                GUI:Dummy(6, 5)
                GUI:SameLine()
                M.Config.Main.MerchantGuide = GUI:Checkbox('开启指路##Merchant', M.Config.Main.MerchantGuide)
                if M.Config.Main.MerchantGuide then
                    GUI:TextColored(1, 0, 1, 1, '  注意：唯一解机制的指路无法关闭！')
                end
                GUI:Separator()
                GUI:Dummy(6, 5)
                GUI:SameLine()
                M.Config.Main.MerchantAimTool = GUI:Checkbox('老1强制移动目标箭头##Merchant', M.Config.Main.MerchantAimTool)
                GUI:Separator()
                GUI:Dummy(6, 5)
                GUI:SameLine()
                M.Config.Main.MerchantLockFace = GUI:Checkbox('老1强制移动自动面向##Merchant', M.Config.Main.MerchantLockFace)
                if M.Config.Main.MerchantGuide then
                    GUI:TextColored(1, 0, 1, 1, '  需要严格站在指路位置圈内！')
                end
            end
        end
    end
end
---@param M MuAiGuide
local drawToolsTab = function(M)
    GUI:BulletText('Mini内置Hack功能')
    GUI:Dummy(0, 3)
    GUI:Text('   移动速度作弊： ')
    GUI:SameLine()
    GUI:PushItemWidth(35)
    local hackSpeed, hackSpeedChange = GUI:InputText('##hackSpeed', tostring(M.Config.Main.SpeedHack), GUI.InputTextFlags_CharsNoBlank)
    if hackSpeedChange then
        M.Config.Main.SpeedHack = tonumber(hackSpeed)
    end
    GUI:PopItemWidth()
    GUI:SameLine()
    GUI:Button('应用移动', 75, 20)
    if GUI:IsItemClicked(0) then
        local curSp = tonumber(M.Config.Main.SpeedHack)
        if curSp ~= gDevHackRunningSpeed then
            gDevHackRunningSpeed = curSp
            Player:SetSpeed(1, gDevHackRunningSpeed, gDevHackBackwardsSpeed, gDevHackStrafeSpeed, gDevHackWalkingSpeed)
            M.InfoNoLog('移动速度修改为：' .. gDevHackRunningSpeed)
        end
    end
    GUI:SameLine()
    if (GUI:Button('还原移动', 75, 20)) then
        Player:ResetSpeed(1) -- walking
        gDevHackRunningSpeed = 6.0
        gDevHackWalkingSpeed = 2.4000000953674
        gDevHackBackwardsSpeed = 2.4000000953674
        gDevHackStrafeSpeed = 2.4000000953674
        gDevHackWalkRatio = gDevHackRunningSpeed / gDevHackWalkingSpeed
    end
    GUI:Text('   最大视距作弊： ')
    GUI:SameLine()
    GUI:PushItemWidth(35)
    local hackZoom, hackZoomChange = GUI:InputText('##hackZoom', tostring(M.Config.Main.HackZoom), GUI.InputTextFlags_CharsNoBlank)
    if hackZoomChange then
        M.Config.Main.HackZoom = tonumber(hackZoom)
    end
    GUI:PopItemWidth()
    GUI:SameLine()
    GUI:Button('应用视距', 75, 20)
    if GUI:IsItemClicked(0) then
        local curZM = tonumber(M.Config.Main.HackZoom)
        if curZM ~= gDevHackMaxZoom then
            gDevHackMaxZoom = curZM
            Hacks:SetCamMaxZoom(gDevHackMinZoom, gDevHackMaxZoom)
        end
    end
    GUI:SameLine()
    if (GUI:Button('还原视距', 75, 20)) then
        Hacks:ResetCamMaxZoom()
        gDevHackMaxZoom = 20.0
        gDevHackMinZoom = 1.5
    end

    GUI:Text('   地面坐骑速度： ')
    GUI:SameLine()
    GUI:PushItemWidth(35)
    local hackMtSpeed, hackMtSpeedChange = GUI:InputText('##hackMountSpeed', tostring(M.Config.Main.MountSpeedHack), GUI.InputTextFlags_CharsNoBlank)
    if hackMtSpeedChange then
        M.Config.Main.MountSpeedHack = tonumber(hackMtSpeed)
    end
    GUI:PopItemWidth()
    GUI:SameLine()
    GUI:Button('应用坐骑', 75, 20)
    if GUI:IsItemClicked(0) then
        local curSp = tonumber(M.Config.Main.MountSpeedHack)
        if curSp ~= gDevHackMountRunningSpeed then
            gDevHackMountRunningSpeed = curSp
            Player:SetSpeed(2, gDevHackMountRunningSpeed, gDevHackMountBackwardsSpeed, gDevHackMountStrafeSpeed, gDevHackMountWalkingSpeed)
            M.InfoNoLog('地面坐骑速度修改为：' .. gDevHackMountRunningSpeed)
        end
    end
    GUI:SameLine()
    if (GUI:Button('还原坐骑', 75, 20)) then
        gDevHackMountRunningSpeed = 9.0
        Player:SetSpeed(2, gDevHackMountRunningSpeed, gDevHackMountBackwardsSpeed, gDevHackMountStrafeSpeed, gDevHackMountWalkingSpeed)
    end

    GUI:Separator()
    GUI:Dummy(0, 2)
    GUI:BulletText('目标圈HACK辅助功能')
    GUI:Dummy(8, 0)
    GUI:SameLine()
    M.Config.Main.AttackRangeHelper = GUI:Checkbox('绘制原始攻击范围', M.Config.Main.AttackRangeHelper)
    GUI:SameLine(0, 25)
    local AttackRangeReplace = GUI:Checkbox('接管攻击距离显示', M.Config.Main.AttackRangeReplace)
    if AttackRangeReplace ~= M.Config.Main.AttackRangeReplace then
        M.Config.Main.AttackRangeReplace = AttackRangeReplace
        MoogleTelegraphs.Settings.DrawAttackRange = not M.Config.Main.AttackRangeReplace
        if AttackRangeReplace == true then
            M.InfoNoLog('已接管攻击范围显示，[MoogleTelegraphs]的攻击范围显示已关闭。')
        else
            M.InfoNoLog('已取消攻击范围显示接管，[MoogleTelegraphs]的攻击范围显示已开启。')
        end
    end
    if M.Config.Main.AttackRangeHelper then
        GUI:Dummy(8, 0)
        GUI:SameLine()
        local OutRangeColorChange, InRangeColorChange
        M.Config.Main.OutRangeColor.r, M.Config.Main.OutRangeColor.g, M.Config.Main.OutRangeColor.b, M.Config.Main.OutRangeColor.a, OutRangeColorChange = GUI:ColorEdit4('范围外颜色',
                M.Config.Main.OutRangeColor.r,
                M.Config.Main.OutRangeColor.g,
                M.Config.Main.OutRangeColor.b,
                M.Config.Main.OutRangeColor.a,
                GUI.ColorEditMode_NoInputs)

        GUI:SameLine(0, 69)
        M.Config.Main.InRangeColor.r, M.Config.Main.InRangeColor.g, M.Config.Main.InRangeColor.b, M.Config.Main.InRangeColor.a, InRangeColorChange = GUI:ColorEdit4('范围内颜色',
                M.Config.Main.InRangeColor.r,
                M.Config.Main.InRangeColor.g,
                M.Config.Main.InRangeColor.b,
                M.Config.Main.InRangeColor.a,
                GUI.ColorEditMode_NoInputs)
        local LineSizeChange
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text('  边缘线宽度 ')
        GUI:SameLine()
        GUI:PushItemWidth(80)
        M.Config.Main.LineSize, LineSizeChange = GUI:SliderFloat('##LineSize', M.Config.Main.LineSize, 1, 10)
        GUI:PopItemWidth()
    end
end
---@param M MuAiGuide
local drawDeveloperTab = function(M)
    GUI:Dummy(6, 0)
    GUI:SameLine()
    GUI:TextColored(1, 0, 0, 1, '※本页内容为开发工具，请勿乱动！')
    GUI:Separator()
    GUI:Dummy(0, 0)
    GUI:BulletText('指路视角')
    if not M.Develop.JobView then
        GUI:PushItemWidth(40)
        GUI:Dummy(6, 0)
        GUI:SameLine()
        local index = M.IndexOf(M.JobPosName, M.Develop.ViewedJob)
        local debugJob, debugJobChange = GUI:Combo('作为第一视角', index, M.JobPosName, 10)
        if debugJobChange then
            M.Develop.ViewedJob = M.JobPosName[debugJob]
        end
        GUI:PopItemWidth()
        GUI:SameLine(0, 50)
        GUI:Button('开始', 120, 20)
        if GUI:IsItemClicked(0) then
            if M.SelfPos then
                if not table.contains(M.JobPosName, M.Develop.ViewedJob) then
                    M.ShowMsgUI(3, { '填写有误！请重新填写' })
                else
                    M.Develop.JobView = true
                    M.GetSelfPos()
                    M.InfoNoLog('进入视角调试模式, 当前视角：' .. M.SelfPos)
                end
            else
                M.ShowMsgUI(3, { '当前没有加入小队！' })
            end
        end
    else
        GUI:Dummy(6, 0)
        GUI:SameLine()
        GUI:Button('取消视角', 280, 20)
        if GUI:IsItemClicked(0) then
            M.Develop.JobView = false
            M.GetSelfPos()
            M.InfoNoLog('退出视角调试, 视角还原到：' .. M.SelfPos)
        end
    end
    GUI:Separator()
    GUI:Dummy(0, 0)
    GUI:BulletText('调试')
    GUI:Dummy(6, 0)
    GUI:SameLine()
    GUI:Button('刷新UI', 120, 20)
    if GUI:IsItemClicked(0) then
        M.LoadUI(true)
    end
    GUI:SameLine(205, 0)
    M.Develop.UIRefresh = GUI:Checkbox('持续刷新', M.Develop.UIRefresh)
    GUI:Dummy(6, 0)
    GUI:Dummy(6, 0)
    GUI:SameLine()
    GUI:Button('重载副本脚本', 120, 20)
    if GUI:IsItemClicked(0) then
        M.LoadRaidScripts(true)
    end
    GUI:SameLine(205, 0)
    GUI:Button('重载MuAiGuide', 120, 20)
    if GUI:IsItemClicked(0) then
        M.CloseAllUI()
        MuAiGuide = FileLoad(MuAiGuideRoot .. "MuAiGuide.lua")
    end
    GUI:Dummy(6, 0)
    GUI:Dummy(6, 0)
    GUI:SameLine()
    GUI:Button('显示日志弹窗', 120, 20)
    if GUI:IsItemClicked(0) then
        if M.LogInfo ~= nil and table.size(M.LogInfo) > 0 then
            M.ShowMsgUI(2, M.LogInfo)
        end
    end
    GUI:Separator()
    GUI:Dummy(0, 0)
    if GUI:CollapsingHeader('工具') then
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Develop.ShowTetherInfo = GUI:Checkbox('显示所有实体连线信息', M.Develop.ShowTetherInfo)
        GUI:Dummy(6, 5)
        GUI:BulletText('Events')
        GUI:Dummy(6, 0)
        GUI:SameLine()
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text('公共显示时间(s) ')
        GUI:SameLine()
        GUI:PushItemWidth(180)
        GUI:SliderInt('##ShowAddMarkTime', M.Develop.ShowTime, 1, 100)
        GUI:PopItemWidth()
        GUI:Dummy(3, 0)
        GUI:SameLine()
        GUI:Text('1.OnMarkerAdd')
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Develop.ShowMarkId = GUI:Checkbox('实体上显示MarkId', M.Develop.ShowMarkId)
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Develop.PrintMarkId = GUI:Checkbox('当实体AddMark时将信息输出到聊天栏', M.Develop.PrintMarkId)
        GUI:Dummy(3, 0)
        GUI:SameLine()
        GUI:Text('2.OnEntityChannel')
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Develop.ShowSkillId = GUI:Checkbox('实体上显示读条ID', M.Develop.ShowSkillId)
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Develop.PrintChannelInfo = GUI:Checkbox('当实体读条时将信息输出到聊天栏', M.Develop.PrintChannelInfo)
        GUI:Dummy(3, 0)
        GUI:SameLine()
        GUI:Text('3.OnEntityCast')
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Develop.PrintCastInfo = GUI:Checkbox('当实体技能判定时将信息输出到聊天栏', M.Develop.PrintCastInfo)
        GUI:Dummy(3, 0)
        GUI:SameLine()
        GUI:Text('4.OnAOECreate')
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Develop.CacheAoeInfo = GUI:Checkbox('缓存AOE信息', M.Develop.CacheAoeInfo)
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Develop.PrintAoeInfo = GUI:Checkbox('当AOE生成时将信息输出到聊天栏', M.Develop.PrintAoeInfo)
        GUI:Dummy(3, 0)
        GUI:SameLine()
        GUI:Text('5.OnMapEffect')
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Develop.PrintMapEffect = GUI:Checkbox('将OnMapEffect信息输出到聊天栏', M.Develop.PrintMapEffect)
        GUI:Dummy(3, 0)
        GUI:SameLine()
        GUI:Text('6.ObjectScript')
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Develop.EventObjectScript = GUI:Checkbox('将OEventObjectScript输出到聊天栏', M.Develop.EventObjectScript)
        GUI:Dummy(3, 0)
        GUI:SameLine()
        GUI:Text('7.OnAddEntityVFX')
        GUI:Dummy(6, 0)
        GUI:SameLine()
        M.Develop.PrintVFXInfo = GUI:Checkbox('将entityVFX信息输出到聊天栏', M.Develop.PrintVFXInfo)
        if M.Develop.PrintVFXInfo then
            GUI:Dummy(6, 0)
            GUI:SameLine()
            M.Develop.VFXFilter = GUI:Checkbox('过滤VFX', M.Develop.VFXFilter)
            if M.Develop.VFXFilter then
                GUI:AlignFirstTextHeightToWidgets()
                GUI:Text('  VFX ID最大值:')
                GUI:SameLine()
                GUI:PushItemWidth(120)
                local vfxFilterValue1, vfxFilterChange1 = GUI:InputInt("##VFXIdMax", M.Develop.VFXFilterMax)
                GUI:PopItemWidth()
                if vfxFilterChange1 then
                    M.Develop.VFXFilterMax = vfxFilterValue1
                end
                GUI:AlignFirstTextHeightToWidgets()
                GUI:Text('  VFX ID最小值:')
                GUI:SameLine()
                GUI:PushItemWidth(120)
                local vfxFilterValue2, vfxFilterChange2 = GUI:InputInt("##VFXIdMin", M.Develop.VFXFilterMin)
                GUI:PopItemWidth()
                if vfxFilterChange2 then
                    M.Develop.VFXFilterMin = vfxFilterValue2
                end
                GUI:Dummy(6, 0)
                GUI:SameLine()
                M.Develop.VFXFilterNoPlayer = GUI:Checkbox('不显示玩家角色VFX', M.Develop.VFXFilterNoPlayer)
            end
        end
    end
end
---@param M MuAiGuide
local drawSupportTab = function(M)
    GUI:TextColored(0, 1, 0, 1, '如果您觉得本插件很棒, 可以点击下方按钮进行打赏.')
    GUI:ImageButton(
            'wechatPay',
            GetLuaModsPath() .. 'MuAiCore\\Image\\WeChatPay.png',
            155, 155
    )
    if GUI:IsItemClicked(0) then
        M.ShowQRCodeUI(1)
        M.SponsorUI.open = false
    end
    GUI:SameLine(185)
    GUI:ImageButton(
            'alipay',
            GetLuaModsPath() .. 'MuAiCore\\Image\\AliPay.png',
            155, 155
    )
    if GUI:IsItemClicked(0) then
        M.ShowQRCodeUI(2)
        M.SponsorUI.open = false
    end
    GUI:Button('赞助者&鸣谢名单', 340, 30)
    if GUI:IsItemClicked(0) then
        M.QRCodeUI.open = false
        M.SponsorUI.open = not M.SponsorUI.open
    end
end
---@param M MuAiGuide
local drawCommon = function(M)
    GUI:Separator()
    GUI:Dummy(10, 2)
    GUI:AlignFirstTextHeightToWidgets()
    GUI:BulletText('BUG反馈,QQ群1106367633')
    GUI:SameLine(200)
    GUI:Button('点此加入', 145, 20)
    if GUI:IsItemClicked(0) then
        io.popen('start https://qm.qq.com/q/BGzv02jsiI')
        M.InfoNoLog('加群答案为：MuAiCore(注意大小写)<se.1>')
    end

    GUI:SameLine()
    GUI:Dummy(10, 1)
    GUI:AlignFirstTextHeightToWidgets()
    GUI:BulletText('GitHub主页（说明书）')
    GUI:SameLine(200)
    GUI:Button('点击打开', 145, 20)
    if GUI:IsItemClicked(0) then
        io.popen('start https://github.com/SuzukazeYuYa/MuAiCore')
    end
    GUI:AlignFirstTextHeightToWidgets()
    GUI:BulletText('更新日志：')
    GUI:SameLine(200)
    GUI:Button('点击查看', 145, 20)
    if GUI:IsItemClicked(0) then
        io.popen('start https://github.com/SuzukazeYuYa/MuAiCore/commits/main/')
    end
    GUI:Dummy(10, 2)
    GUI:Separator()
    GUI:Dummy(10, 2)
    GUI:BulletText('版本信息')
    if M.LatestVer == nil then
        GUI:TextColored(1, 1, 0, 1, '   获取在线版本信息失败！请检查网络状态，')
        GUI:TextColored(1, 1, 0, 1, '   或点击上方链接查看版本状态！')
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text('                      ver.' .. M.VERSION .. ' ')
        GUI:SameLine(0, 0)
        GUI:Button('尝试检查版本', 120, 20)
        if GUI:IsItemClicked(0) then
            M.CheckVersion()
        end
    else
        if M.LatestVer > M.VERSION then
            GUI:TextColored(0, 1, 0, 1, '  有新的版本: ver.' .. M.LatestVer)
            GUI:SameLine(0, 20)
            GUI:TextColored(1, 0, 0, 1, ' 当前版本: ver.' .. M.VERSION .. ' ')
            GUI:Button('点击此处进行更新', 335, 20)
            if GUI:IsItemClicked(0) then
                if M.LogInfo ~= nil then
                    M.ShowMsgUI(2, M.LogInfo)
                else
                    M.ForceUpdate()
                end
            end
            GUI:TextColored(1, 1, 0, 1, '提示：如无法正常更新，请点击上方链接手动覆盖！')
        else
            GUI:AlignFirstTextHeightToWidgets()
            GUI:TextColored(0, 1, 0, 1, '   当前已是最新版本: ver.' .. M.VERSION .. '   ')
            GUI:SameLine(0, 0)
            GUI:Button('检查更新', 100, 20)
            if GUI:IsItemClicked(0) then
                M.CheckVersion()
            end
        end
    end
end

MainUI.draw = function()
    local M = MuAiGuide
    if M.MainUI.tabs == nil then
        M.MainUI.tabs = GUI_CreateTabs('职能,基本,副本,辅助,开发,赞助')
    end
    GUI:SetNextWindowSize(WIN_WIDE, 0, GUI.SetCond_Appearing)
    M.MainUI.visible, M.MainUI.open = GUI:Begin('MuAiCore Setting', M.MainUI.open)
    local winPosX, winPosY = GUI:GetWindowPos()
    M.MainUI.uiPos.x = winPosX + WIN_WIDE
    M.MainUI.uiPos.y = winPosY
    if M.MainUI.visible and not GUI:IsWindowCollapsed() then
        GUI:Separator()
        GUI:Dummy(2, 2)
        GUI:SameLine()
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text('|')
        GUI:SameLine()
        local tabindex, _ = GUI_DrawTabs(M.MainUI.tabs)
        GUI:Dummy(0, 3)
        if tabindex == 1 then
            drawJobTab(M)
        elseif tabindex == 2 then
            drawBaseSettingTab(M)
        elseif tabindex == 3 then
            drawRaidSettingTab(M)
        elseif tabindex == 4 then
            drawToolsTab(M)
        elseif tabindex == 5 then
            drawDeveloperTab(M)
        elseif tabindex == 6 then
            drawSupportTab(M)
        end
        if tabindex ~= 1 then
            M.DefaultJobsUI.open = false
        end
        if tabindex ~= 6 then
            M.QRCodeUI.open = false
            M.SponsorUI.open = false
        end
        if tabindex ~= 3 then
            M.FruConfigUI.open = false
            M.FruMitigationUI.open = false
            M.DancingMadUI.open = false
            M.CatZDmuTankUI.open = false
            M.DmuDpsUI.open = false
        end
        drawCommon(M)
    end
    M.SaveConfig(M.Config.MainPath, M.Config.MainFile, 'Main')
    GUI:SetWindowSize(355, 0)
    GUI:End()
end
return MainUI
