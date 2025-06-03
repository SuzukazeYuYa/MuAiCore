local DrawMainUI = function(M)
    if M.AddLabel == nil then
        M.AddLabel = function(label, normal, space)
            GUI:AlignFirstTextHeightToWidgets()
            if normal then
                GUI:Text(label)
            else
                GUI:BulletText(label)
            end
            if space ~= nil then
                GUI:SameLine(space, 0)
            else
                GUI:SameLine(0, 0)
            end
        end
    end
    GUI:SetNextWindowSize(200, 0, GUI.SetCond_Appearing)
    M.UI.visible, M.UI.open = GUI:Begin("MuAiGuide Setting", M.UI.open)
    if M.UI.visible then
        if GUI:CollapsingHeader("基础设置") then
            GUI:Text(" ")
            GUI:SameLine()
            M.Config.Main.AutoUpdate = GUI:Checkbox("开启自动更新", M.Config.Main.AutoUpdate)
            GUI:SameLine(0, 45)
            GUI:TextColored(0, 255, 0, 1, "※需要网络状态良好！")
            GUI:Text(" ")
            GUI:SameLine()
            M.Config.Main.AnyOneReactionOn = GUI:Checkbox("是否启用了Anyone", M.Config.Main.AnyOneReactionOn)
            GUI:SameLine(0, 19)
            GUI:TextColored(0, 255, 0, 1, "※如果不用A轴请取消勾选")
            GUI:Text(" ")
            GUI:SameLine()
            local colorChange1, colorChange2
            M.Config.Main.GuideColor.r, M.Config.Main.GuideColor.g, M.Config.Main.GuideColor.b, M.Config.Main.GuideColor.a, colorChange1 = GUI:ColorEdit4("指路工具颜色",
                    M.Config.Main.GuideColor.r,
                    M.Config.Main.GuideColor.g,
                    M.Config.Main.GuideColor.b,
                    M.Config.Main.GuideColor.a,
                    GUI.ColorEditMode_NoInputs)

            GUI:SameLine(0, 50)
            M.Config.Main.GuidePairColor.r, M.Config.Main.GuidePairColor.g, M.Config.Main.GuidePairColor.b, M.Config.Main.GuidePairColor.a, colorChange2 = GUI:ColorEdit4("分摊连线颜色",
                    M.Config.Main.GuidePairColor.r,
                    M.Config.Main.GuidePairColor.g,
                    M.Config.Main.GuidePairColor.b,
                    M.Config.Main.GuidePairColor.a,
                    GUI.ColorEditMode_NoInputs)
            GUI:Text(" ")
            GUI:SameLine()
            M.Config.Main.LogToEchoMsg = GUI:Checkbox("聊天栏提示信息", M.Config.Main.LogToEchoMsg)
            GUI:SameLine(0, 36)
            M.Config.Main.TTS = GUI:Checkbox("开启TTS播报", M.Config.Main.TTS)
            GUI:Text(" ")
            GUI:SameLine()
            GUI:AlignFirstTextHeightToWidgets()
            GUI:BulletText("快捷键设置：")
            GUI:SameLine(0, 50)
            GUI:PushItemWidth(60)
            local curKeyIndex = M.Config.Main.KeyBindFirst - 15
            local newIndex, keyBind1Change = GUI:Combo("##KEYBNIN1", curKeyIndex, M.Config.Key1, 4)
            if keyBind1Change then
                M.Config.Main.KeyBindFirst = newIndex + 15
            end
            GUI:PopItemWidth()
            GUI:SameLine()
            GUI:Text("+")
            GUI:SameLine()
            GUI:PushItemWidth(40)
            local curKeyIndex2
            if M.Config.Main.KeyBindSecond <= 90 then
                curKeyIndex2 = M.Config.Main.KeyBindSecond - 64
            else
                curKeyIndex2 = M.Config.Main.KeyBindSecond - 165
            end
            local newIndex2, keyBind1Change2 = GUI:Combo("##KEYBNIN2", curKeyIndex2, M.Config.Key2, 27)
            if keyBind1Change2 then
                if newIndex2 <= 26 then
                    M.Config.Main.KeyBindSecond = newIndex2 + 64
                else
                    M.Config.Main.KeyBindSecond = newIndex2 + 165
                end

            end
            GUI:PopItemWidth()
        end

        GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing | GUI.SetCond_Once)
        if GUI:CollapsingHeader("职能设置", GUI.TreeNodeFlags_SDefaultOpen) then
            GUI:Dummy(1, 1)
            if M.SelfPos then
                GUI:BulletText("当前职能:")
                GUI:SetWindowFontSize(2.5)
                GUI:Dummy(10, 0)
                GUI:SameLine()

                if table.size(M.Party) == 4 then
                    if M.SelfPos == "MT" then
                        GUI:TextColored(0, 0, 1, 1, M.SelfPos)
                    elseif M.SelfPos == "H1" then
                        GUI:TextColored(0, 1, 0, 1, M.SelfPos)
                    else
                        GUI:TextColored(1, 0, 0, 1, M.SelfPos)
                    end
                else
                    if M.SelfPos == "MT" or M.SelfPos == "ST" then
                        GUI:TextColored(0, 0.3, 1, 1, M.SelfPos)
                    elseif M.SelfPos == "H1" or M.SelfPos == "H2" then
                        GUI:TextColored(0, 1, 0, 1, M.SelfPos)
                    else
                        GUI:TextColored(1, 0, 0, 1, M.SelfPos)
                    end
                end

                if M.DebugMode then
                    GUI:SameLine()
                    GUI:TextColored(255, 0, 0, 1, "[DEBUG]")
                end
                GUI:SetWindowFontSize(1)
                GUI:TextColored(0, 255, 0, 1, "   ※拖动角色名进行职能修改")
            else
                GUI:TextColored(255, 0, 0, 1, "当前没有加入队伍")
            end
            GUI:Dummy(1, 1)
            GUI:Separator()
            GUI:Text("  | 职能 |职业|             角色名            |")

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
                GUI:ListBoxHeader("##Jobs", 304, 200)
                partyMembers = {
                    { info = M.Party.MT, label = "MT" },
                    { info = M.Party.H1, label = "H1" },
                    { info = M.Party.D1, label = "D1" },
                    { info = M.Party.D2, label = "D2" },
                }
            else
                GUI:ListBoxHeader("##Jobs", 304, 262)
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
                GUI:Dummy(5, 0)
                GUI:SameLine()
                GUI:AlignFirstTextHeightToWidgets()
                GUI:SetWindowFontSize(1.5)
                if table.size(M.Party) == 4 then
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
                GUI:SetWindowFontSize(1.3)
                GUI:SameLine()
                GUI:Dummy(0, 0)
                GUI:SameLine()
                if ptMember.info ~= nil and ptMember.info.job ~= nil and ptMember.info.name ~= nil then
                    local path = GetLuaModsPath() .. "\\MuAiCore\\Image\\JobIcon\\" .. tostring(ptMember.info.job) .. ".png"
                    GUI:Image(path, 25, 25)
                    GUI:SameLine(0, 25)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:Selectable(ptMember.info.name, IsSelected(), GUI.SelectableFlags_DontClosePopups, 0, 0)
                else
                    local path = GetLuaModsPath() .. "\\MuAiCore\\Image\\JobIcon\\00.png"
                    if i <= 2 then
                        path = GetLuaModsPath() .. "\\MuAiCore\\Image\\JobIcon\\TankRole.png"
                    elseif i <= 4 then
                        path = GetLuaModsPath() .. "\\MuAiCore\\Image\\JobIcon\\HealerRole.png"
                    else
                        path = GetLuaModsPath() .. "\\MuAiCore\\Image\\JobIcon\\DPSRole.png"
                    end
                    GUI:Image(path, 25, 25)
                    GUI:SameLine(0, 25)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:Selectable("未知玩家" .. i, IsSelected())
                end
                if GUI:IsItemHovered(GUI.HoveredFlags_AllowWhenBlockedByPopup + GUI.HoveredFlags_AllowWhenBlockedByActiveItem + GUI.HoveredFlags_AllowWhenOverlapped) then
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
                            if M.Party ~= nil and M.Party[M.Party.mousePosition] ~= nil then
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
                end

                if M.Party.mousePosition ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then
                    M.Party.mousePosition = nil
                end
                if M.Party.selected ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then
                    M.Party.selected = nil
                end
                if i < 8 then
                    GUI:Separator()
                end
            end
            GUI:ListBoxFooter()
            if M.Party.mousePosition ~= nil and
                    not GUI:IsItemHovered(GUI.HoveredFlags_AllowWhenBlockedByPopup + GUI.HoveredFlags_AllowWhenBlockedByActiveItem + GUI.HoveredFlags_AllowWhenOverlapped)
            then
                M.Party.mousePosition = nil
            end
            GUI:Text(" ")
            GUI:SameLine()
            GUI:SetWindowFontSize(1)
            GUI:Button("重新加载小队列表", 305, 30)
            if GUI:IsItemClicked(0) then
                M.LoadParty()
            end
        end
        GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
        if GUI:CollapsingHeader("副本设置", GUI.TreeNodeFlags_SDefaultOpen) then
            GUI:Text(" ")
            GUI:SameLine()
            GUI:Button("绝伊甸指路设置", 150, 30)
            if GUI:IsItemClicked(0) then
                M.ConfigFruInit = false
                M.FruConfigUI.open = not M.FruConfigUI.open
                M.FruMitigationUI.open = false
            end
            GUI:SameLine()
            GUI:Button("绝伊甸减伤设置", 150, 30)
            if GUI:IsItemClicked(0) then
                if MuAiGuide.IsHealer(Player.job) then
                    M.Info("不支持治疗职业<se.1>")
                else
                    M.FruMitigationUI.open = not M.FruMitigationUI.open
                    M.FruConfigUI.open = false
                end
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
                local debugJob, debugJobChange = GUI:Combo("作为第一视角", index, M.JobPosName, 10)
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
            M.DevelopMode = GUI:Checkbox("UI开发模式", M.DevelopMode)
            GUI:SameLine(0, 81)
            GUI:Button("重载MuAiGuide", 120, 20)
            if GUI:IsItemClicked(0) then
                M.UI.open = false
                M.FruConfigUI.open = false
                ReloadMuAiGuide()
            end
        end
        if GUI:CollapsingHeader("Hack") then
            M.AddLabel("移动速度作弊： ")
            GUI:PushItemWidth(50)
            local hackSpeed, hackSpeedChange = GUI:InputText("##hackSpeed", tostring(M.Config.Main.SpeedHack), GUI.InputTextFlags_CharsNoBlank)
            if hackSpeedChange then
                M.Config.Main.SpeedHack = tonumber(hackSpeed)
            end
            GUI:PopItemWidth()
            GUI:SameLine()
            GUI:Button("应用移动", 75, 20)
            if GUI:IsItemClicked(0) then
                local curSp = tonumber(M.Config.Main.SpeedHack)
                if curSp ~= gDevHackRunningSpeed then
                    gDevHackRunningSpeed = curSp
                    Player:SetSpeed(1, gDevHackRunningSpeed, gDevHackBackwardsSpeed, gDevHackStrafeSpeed, gDevHackWalkingSpeed)
                    M.Info("移动速度修改为：" .. gDevHackRunningSpeed)
                end
            end
            GUI:SameLine()
            if (GUI:Button("还原移动", 75, 20)) then
                Player:ResetSpeed(1) -- walking
                gDevHackRunningSpeed = 6.0
                gDevHackWalkingSpeed = 2.4000000953674
                gDevHackBackwardsSpeed = 2.4000000953674
                gDevHackStrafeSpeed = 2.4000000953674
                gDevHackWalkRatio = gDevHackRunningSpeed / gDevHackWalkingSpeed
            end
            M.AddLabel("最大视距作弊： ")
            GUI:PushItemWidth(50)
            local hackZoom, hackZoomChange = GUI:InputText("##hackZoom", tostring(M.Config.Main.HackZoom), GUI.InputTextFlags_CharsNoBlank)
            if hackZoomChange then
                M.Config.Main.HackZoom = tonumber(hackZoom)
            end
            GUI:PopItemWidth()
            GUI:SameLine()
            GUI:Button("应用视距", 75, 20)
            if GUI:IsItemClicked(0) then
                local curZM = tonumber(M.Config.Main.HackZoom)
                if curZM ~= gDevHackMaxZoom then
                    gDevHackMaxZoom = curZM
                    Hacks:SetCamMaxZoom(gDevHackMinZoom,gDevHackMaxZoom)
                end
            end
            GUI:SameLine()
            if (GUI:Button("还原视距", 75, 20)) then
                Hacks:ResetCamMaxZoom()
                gDevHackMaxZoom = 20.0
                gDevHackMinZoom = 1.5
            end

            M.AddLabel("地面坐骑速度： ")
            GUI:PushItemWidth(50)
            local hackMtSpeed, hackMtSpeedChange = GUI:InputText("##hackMountSpeed", tostring(M.Config.Main.MountSpeedHack), GUI.InputTextFlags_CharsNoBlank)
            if hackMtSpeedChange then
                M.Config.Main.MountSpeedHack = tonumber(hackMtSpeed)
            end
            GUI:PopItemWidth()
            GUI:SameLine()
            GUI:Button("应用坐骑", 75, 20)
            if GUI:IsItemClicked(0) then
                local curSp = tonumber(M.Config.Main.MountSpeedHack)
                if curSp ~= gDevHackMountRunningSpeed then
                    gDevHackMountRunningSpeed = curSp
                    Player:SetSpeed(2,gDevHackMountRunningSpeed,gDevHackMountBackwardsSpeed,gDevHackMountStrafeSpeed,gDevHackMountWalkingSpeed)
                    M.Info("地面坐骑速度修改为：" .. gDevHackMountRunningSpeed)
                end
            end
            GUI:SameLine()
            if (GUI:Button("还原坐骑", 75, 20)) then
                gDevHackMountRunningSpeed = 9.0
                Player:SetSpeed(2,gDevHackMountRunningSpeed,gDevHackMountBackwardsSpeed,gDevHackMountStrafeSpeed,gDevHackMountWalkingSpeed)
            end
        end
        if GUI:CollapsingHeader("支持一下") then
            local path = GetLuaModsPath() .. "\\MuAiCore\\Image\\QRCode.png"
            GUI:Text("        ")
            GUI:SameLine()
            GUI:Image(path, 200, 200)
            GUI:TextColored(0, 1, 0, 1, "   如果您觉得我做的很好，可以支持一下。")
            GUI:TextColored(1, 1, 0, 1, "   但是这并不能让您获得更多权益，只代表你对本")
            GUI:TextColored(1, 1, 0, 1, "   人的支持，根本没任何回报，请慎重。")
            GUI:TextColored(1, 0, 0, 1, "   ※郑重声明：本工具没有任何用户分级政策。")
            GUI:TextColored(1, 0, 0, 1, "   ※码是DC群友的热情难拒，才加上的。")
            GUI:TextColored(1, 0, 0, 1, "   ※请勿用付费说事，全凭自愿打赏。")
        end
        GUI:Separator()
        GUI:BulletText("BUG反馈")
        GUI:Dummy(10, 1)
        GUI:SameLine()
        GUI:Text("添加QQ2437365584，备注BUG反馈")
        GUI:Dummy(10, 1)
        GUI:BulletText("说明书、下载地址、更新日志：")
        GUI:Button("https://github.com/SuzukazeYuYa/MuAiCore", 330, 20)
        if GUI:IsItemClicked(0) then
            io.popen("start https://github.com/SuzukazeYuYa/MuAiCore")
        end
        
        GUI:Button("恢复默认设置", 150, 20)
        if GUI:IsItemClicked(0) then
            M.Config.Main = M.CreateDefMainCfg()
            MuAiGuide.Info("已恢复默认设置。")
        end
        GUI:SameLine()
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text("  ver." .. M.VERSION .. " ")
        GUI:SameLine(0, 0)
        GUI:Button("检查更新", 100, 20)
        if GUI:IsItemClicked(0) then
            MuAiGuide.UI.open = false
            MuAiGuide.FruConfigUI.open = false
            MuAiGuide.Info("更新过程中会短暂卡屏，请耐心等待。")
            MuAiGuide.ForceUpdate()
        end
       
        M.SaveConfig(M.Config.MainPath, M.Config.MainFile, "Main")
    end
    local winPosx, winPosy = GUI:GetWindowPos();
    M.FruConfigUI.x = winPosx + 350
    M.FruConfigUI.y = winPosy
    GUI:SetWindowSize(350, 0)
    GUI:End()
end
return DrawMainUI
