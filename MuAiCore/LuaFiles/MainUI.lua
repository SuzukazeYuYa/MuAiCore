local DrawMainUI = function(M)
    if M.ConfigUI == nil then
        M.ConfigUI = {}
        M.ConfigUI.GuideColorChange = false
        M.ConfigUI.GuideColorPChange = false
        M.ConfigUI.DebugPos = M.Config.DebugPos
        M.ConfigUI.DebugPosChange = false
        M.ConfigUI.DebugMode = false
    end
    GUI:SetNextWindowSize(200, 0, GUI.SetCond_Appearing)
    M.UI.visible, M.UI.open = GUI:Begin("MuAiGuide Setting", M.UI.open)
    if M.UI.visible then
        if GUI:CollapsingHeader("基础设置") then
            GUI:Text(" ")
            GUI:SameLine()
            M.Config.AnyOneReactionOn = GUI:Checkbox("是否启用了Anyone", M.Config.AnyOneReactionOn)
            GUI:SameLine()
            GUI:TextColored(0, 255, 0, 1, "※如果不用A轴请取消勾选")
            GUI:Text(" ")
            GUI:SameLine()
            M.Config.GuideColor.r, M.Config.GuideColor.g, M.Config.GuideColor.b, M.Config.GuideColor.a, M.ConfigUI.GuideColorChange = GUI:ColorEdit4("指路工具颜色",
                    M.Config.GuideColor.r,
                    M.Config.GuideColor.g,
                    M.Config.GuideColor.b,
                    M.Config.GuideColor.a,
                    GUI.ColorEditMode_NoInputs)

            GUI:SameLine(0, 50)
            M.Config.GuidePairColor.r, M.Config.GuidePairColor.g, M.Config.GuidePairColor.b, M.Config.GuidePairColor.a, M.ConfigUI.GuideColorPChange = GUI:ColorEdit4("分摊连线颜色",
                    M.Config.GuidePairColor.r,
                    M.Config.GuidePairColor.g,
                    M.Config.GuidePairColor.b,
                    M.Config.GuidePairColor.a,
                    GUI.ColorEditMode_NoInputs)
            if M.ConfigUI.GuideColorChange or M.ConfigUI.GuideColorPChange then
                M.SaveConfig()
            end
            GUI:Text(" ")
            GUI:SameLine()
            M.Config.LogToEchoMsg = GUI:Checkbox("聊天栏提示信息", M.Config.LogToEchoMsg)
            GUI:SameLine(0, 36)
            M.Config.TTS = GUI:Checkbox("开启TTS播报", M.Config.TTS)
            GUI:Dummy(1, 1)
            GUI:Text(" ")
            GUI:SameLine()
            GUI:Button("恢复默认设置")
            if GUI:IsItemClicked(0) then
                M.LoadDefaultMain()
            end
        end

        GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing | GUI.SetCond_Once)
        if GUI:CollapsingHeader("职能设置", GUI.TreeNodeFlags_SDefaultOpen) then
            GUI:Dummy(1, 1)
            if M.SelfPos then
                GUI:BulletText("当前职能:")
                GUI:SameLine()
                if M.DebugMode then
                    GUI:TextColored(255, 0, 0, 1, M.SelfPos .. "[调试]")
                else
                    GUI:TextColored(255, 0, 0, 1, M.SelfPos)
                end
                GUI:SameLine()
                GUI:TextColored(0, 255, 0, 1, " ※拖动角色名进行职能修改")
            else
                GUI:TextColored(255, 0, 0, 1, "当前没有加入队伍")
            end
            GUI:Dummy(1, 1)
            GUI:Text("    <职能>    <职业>     <角色名>")
            if M.Party == nil or table.size(M.Party) == 0 then
                M.Party = {}
                M.Party.MT = nil
                M.Party.ST = nil
                M.Party.H1 = nil
                M.Party.H2 = nil
                M.Party.D1 = nil
                M.Party.D2 = nil
                M.Party.D3 = nil
                M.Party.D4 = nil
            end
            GUI:Text(" ")
            GUI:SameLine()
            GUI:PushItemWidth(303)

            local partyMembers
            if table.size(M.Party) == 4 then
                GUI:ListBoxHeader("##Jobs", 304, 100)
                partyMembers = {
                    { info = M.Party.MT, label = "MT" },
                    { info = M.Party.H1, label = "H1" },
                    { info = M.Party.D1, label = "D1" },
                    { info = M.Party.D2, label = "D2" },
                }
            else
                GUI:ListBoxHeader("##Jobs", 304, 200)
                partyMembers = {
                    { info = M.Party.MT, label = "MT" },
                    { info = M.Party.ST, label = "ST" },
                    { info = M.Party.H1, label = "H1" },
                    { info = M.Party.H2, label = "H2" },
                    { info = M.Party.D1, label = "D1" },
                    { info = M.Party.D2, label = "D2" },
                    { info = M.Party.D3, label = "D3" },
                    { info = M.Party.D4, label = "D4" }
                }
            end
            for i, member in ipairs(partyMembers) do
                local IsSelected = function()
                    if member.label == M.Party.selected then
                        return true
                    end
                    return false
                end
                local ptMember = partyMembers[i]
                if table.size(M.Party) == 4 then
                    if i == 1 then
                        GUI:ColorButton("#jobPos", 0, 0, 255, 255, GUI.ColorEditMode_NoTooltip, 20, 20)
                    elseif i == 2 then
                        GUI:ColorButton("#jobPos", 0, 255, 0, 255, GUI.ColorEditMode_NoTooltip, 20, 20)
                    else
                        GUI:ColorButton("#jobPos", 255, 0, 0, 255, GUI.ColorEditMode_NoTooltip, 20, 20)
                    end
                    GUI:SameLine()
                    if i == 1 then
                        GUI:TextColored(0, 100, 255, 1, "[" .. ptMember.label .. "]")
                    elseif i == 2 then
                        GUI:TextColored(0, 255, 0, 1, "[" .. ptMember.label .. "]")
                    else
                        GUI:TextColored(255, 0, 0, 1, "[" .. ptMember.label .. "]")
                    end
                else
                    if i == 1 or i == 2 then
                        GUI:ColorButton("#jobPos", 0, 0, 255, 255, GUI.ColorEditMode_NoTooltip, 20, 20)
                    elseif i == 3 or i == 4 then
                        GUI:ColorButton("#jobPos", 0, 255, 0, 255, GUI.ColorEditMode_NoTooltip, 20, 20)
                    else
                        GUI:ColorButton("#jobPos", 255, 0, 0, 255, GUI.ColorEditMode_NoTooltip, 20, 20)
                    end
                    GUI:SameLine()
                    if i == 1 or i == 2 then
                        GUI:TextColored(0, 100, 255, 1, "[" .. ptMember.label .. "]")
                    elseif i == 3 or i == 4 then
                        GUI:TextColored(0, 255, 0, 1, "[" .. ptMember.label .. "]")
                    else
                        GUI:TextColored(255, 0, 0, 1, "[" .. ptMember.label .. "]")
                    end
                end

                GUI:SameLine()
                if ptMember.info ~= nil and ptMember.info.job ~= nil and ptMember.info.name ~= nil then
                    GUI:Selectable("   " .. M.GetJobNameById(ptMember.info.job) .. "      " .. ptMember.info.name, IsSelected())
                else
                    GUI:Selectable("   " .. "未知" .. "      " .. "未知玩家" .. i, IsSelected())
                end
                if
                GUI:IsItemHovered(
                        GUI.HoveredFlags_AllowWhenBlockedByPopup + GUI.HoveredFlags_AllowWhenBlockedByActiveItem +
                                GUI.HoveredFlags_AllowWhenOverlapped
                )
                then
                    if GUI:IsMouseDown(0) then
                        if M.Party.mousePosition == nil then
                            if M.Party.mousePosition ~= ptMember.label then
                                M.Party.mousePosition = ptMember.label
                            end
                            if M.Party.selected ~= ptMember.label then
                                M.Party.selected = ptMember.label
                            end
                        elseif M.Party.mousePosition ~= ptMember.label then
                            d("[M]站位交换：" .. M.Party.mousePosition .. "<==>" .. ptMember.label)
                            local temp = M.Party[M.Party.mousePosition]
                            M.Party[M.Party.mousePosition] = M.Party[ptMember.label]
                            M.Party[ptMember.label] = temp

                            -- 职能调整
                            if M.Party[M.Party.mousePosition].id == M.GetPlayer().id then
                                M.SelfPos = M.Party.mousePosition;
                            elseif M.Party[ptMember.label].id == M.GetPlayer().id then
                                M.SelfPos = ptMember.label;
                            end

                            M.Party.mousePosition = ptMember.label
                            if M.Party.selected ~= ptMember.label then
                                M.Party.selected = ptMember.label
                            end
                        end
                    end
                end

                if M.Party.mousePosition ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then
                    M.Party.mousePosition = nil
                end
                if M.Party.selected ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then
                    M.Party.selected = nil
                end
            end
            GUI:ListBoxFooter()
            if
            M.Party.mousePosition ~= nil and
                    not GUI:IsItemHovered(
                            GUI.HoveredFlags_AllowWhenBlockedByPopup + GUI.HoveredFlags_AllowWhenBlockedByActiveItem +
                                    GUI.HoveredFlags_AllowWhenOverlapped
                    )
            then
                M.Party.mousePosition = nil
            end
            GUI:Text(" ")
            GUI:SameLine()
            GUI:Button("重新加载小队列表", 305, 30)
            if GUI:IsItemClicked(0) then
                M.LoadParty()
            end
        end
        GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
        if GUI:CollapsingHeader("副本设置", GUI.TreeNodeFlags_SDefaultOpen) then
            GUI:Text(" ")
            GUI:SameLine()
            GUI:Button("绝伊甸设置", 150, 30)
            if GUI:IsItemClicked(0) then
                M.ConfigFruInit = false
                M.FruConfigUI.open = not M.FruConfigUI.open
            end
            GUI:SameLine()
            GUI:Button("预留位置", 150, 30)
            if GUI:IsItemClicked(0) then
                M.Info("敬请期待..")
            end
        end
        if GUI:CollapsingHeader("调试工具") then
            GUI:Text(" ")
            GUI:SameLine()
            GUI:TextColored(255, 0, 0, 1, "※不知道干嘛的千万别动！")
            if not M.DebugMode then
                GUI:PushItemWidth(40)
                GUI:Text(" ")
                GUI:SameLine()
                local index = M.IndexOf(M.JobPosName, M.DebugPos)
                local debugJob, debugJobChange = GUI:Combo("作为第一视角", index, M.JobPosName, 4)
                if debugJobChange then
                    M.DebugPos = M.JobPosName[debugJob]
                end
                GUI:PopItemWidth()
                GUI:SameLine(0, 50)
                GUI:Button("开始调试", 120, 20)
                if GUI:IsItemClicked(0) then
                    d(M.IndexOf(M.JobPosName, M.DebugPos))
                    if not table.contains(M.JobPosName, M.DebugPos) then
                        M.Info("填写有误!")
                        M.Debug("填写有误!")
                    else
                        M.DebugMode = true
                        M.GetSelfPos()
                        M.Info("进入视角调试模式，当前视角：" .. M.SelfPos)
                    end
                end
            else
                GUI:Text(" ")
                GUI:SameLine()
                GUI:Button("取消调试视角", 280, 20)
                if GUI:IsItemClicked(0) then
                    M.DebugMode = false
                    M.GetSelfPos()
                    M.Info("退出视角调试，视角还原到：" .. M.SelfPos)
                end
            end
            GUI:Text(" ")
            GUI:SameLine()
            MuAiGuide.DevelopMode = GUI:Checkbox("UI开发模式", MuAiGuide.DevelopMode)
            GUI:SameLine(0, 80)
            GUI:Button("重载MuAiGuide", 120, 20)
            if GUI:IsItemClicked(0) then
                MuAiGuide.UI.open = false
                MuAiGuide.FruConfigUI.open = false
                MuAiGuide = nil
            end
        end
        if GUI:CollapsingHeader("支持一下") then
            local path = MuAiGuideRoot .. "qrcode.png"
            GUI:Text("        ")
            GUI:SameLine()
            GUI:Image(path, 200, 200)
            GUI:TextColored(0, 1, 0, 1, "   如果您觉得我做的很好，可以支持一下。")
            GUI:TextColored(1, 1, 0, 1, "   但是这并不能让您获得更多权益，只代表你对本人")
            GUI:TextColored(1, 1, 0, 1, "   的支持，也许根本没任何回报。")
            GUI:TextColored(1, 0, 0, 1, "   ※郑重声明：本工具没有任何用户分级政策。")
            GUI:TextColored(1, 0, 0, 1, "   ※码是DC群友的热情难拒，我才加上的。")
            GUI:TextColored(1, 0, 0, 1, "   ※请勿用付费说事，全凭自愿打赏。")
        end
        GUI:Separator()
        GUI:BulletText("BUG反馈")
        GUI:Dummy(10, 1)
        GUI:SameLine()
        GUI:Text("添加QQ2437365584，备注BUG反馈")
        GUI:Dummy(10, 1)
        GUI:BulletText("说明书、下载地址、更新日志：")
        GUI:Button("https://github.com/SuzukazeYuYa/MuAiGuide", 330, 20)
        if GUI:IsItemClicked(0) then
            io.popen("start https://github.com/SuzukazeYuYa/MuAiGuide")
        end
        GUI:Text("                                        ver.173")
    end
    M.SaveConfig()
    local winPosx, winPosy = GUI:GetWindowPos();
    M.FruConfigUI.x = winPosx + 350
    M.FruConfigUI.y = winPosy
    GUI:SetWindowSize(350, 0)
    GUI:End()
end
return DrawMainUI
