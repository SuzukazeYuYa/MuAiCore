local DrawFruConfigUI = function(M)
    if M.FruConfigUI.AddLabel == nil then
        M.FruConfigUI.AddLabel = function(label, normal, space)
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
    if M.FruConfigUI.open then
        if not M.UI.open then
            M.FruConfigUI.open = false
            M.FruConfigUI.NewMode = false
            return
        end
        GUI:SetNextWindowSize(200, 0, GUI.SetCond_Appearing)
        GUI:SetNextWindowPos(M.FruConfigUI.x, M.FruConfigUI.y, GUI.SetCond_Appearing)
        M.FruConfigUI.visible, M.FruConfigUI.open = GUI:Begin("MuAiGuide Fru Setting", M.FruConfigUI.open)
        if M.FruConfigUI.visible then
            GUI:SetNextWindowPos(M.FruConfigUI.x, M.FruConfigUI.y, GUI.SetCond_Appearing)
            GUI:TextColored(255, 0, 0, 1, "※所有非优先级八方均按照C开始逆时针一周填写")
            if GUI:CollapsingHeader("全局设置") then
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("1.一键默认") then
                    GUI:TextColored(255, 255, 0, 1, "※以下均为默认设置，有多种打法的部分仍需要设置！")
                    GUI:Button("国野主流", 130, 20)
                    if GUI:IsItemClicked(0) then
                        M.Config.FruCfg = M.CreateFruDefaultCfg()
                        M.Info("已切换为国服野队主流配置，但是细节仍需检查<se.3>。")
                    end
                    GUI:SameLine(0, 30)
                    GUI:Button("日基", 130, 20)
                    if GUI:IsItemClicked(0) then
                        M.FastJapanConfig()
                    end
                    GUI:Button("莫古力/MMW", 130, 20)
                    if GUI:IsItemClicked(0) then
                        M.FastMgl()
                    end
                    GUI:SameLine(0, 30)
                    GUI:Button("莫灵喵", 130, 20)
                    if GUI:IsItemClicked(0) then
                        M.FastMLM()
                    end
                    GUI:TextColored(255, 255, 0, 1, "※一键配置说明※")
                    GUI:TextColored(255, 255, 0, 1, "1.国服野队为当前主流，细节自行查看和修改。")
                    GUI:TextColored(255, 255, 0, 1, "2.基本上mmw仅需改动P2光爆和P3地火，默认为六芒星、")
                    GUI:TextColored(255, 255, 0, 1, "车头法原版。其他均已自动调好，不需要修改设置。")
                    GUI:TextColored(255, 255, 0, 1, "3.MLM攻略目前在适配中，大体上已经完成，如果有问题")
                    GUI:TextColored(255, 255, 0, 1, "请反馈时候帮忙提供一个卫月回放！")
                    GUI:TextColored(255, 255, 0, 1, "4.各类繁杂的设置仅供缝合攻略使用，能不动尽量别动。")
                    GUI:TreePop()
                end
                GUI:Separator()
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("2.配置文件工具") then
                    if M.FruConfigUI.NewMode then
                        M.FruConfigUI.AddLabel("新配置名：", false)
                        GUI:PushItemWidth(200)
                        local havaSame = false
                        local NewFileName, NewFileNameChanged = GUI:InputText("##NewFileName", M.NewFileName, GUI.InputTextFlags_CharsNoBlank)
                        if NewFileNameChanged then
                            local fileName = NewFileName
                            if M.ContainsIgnoreCase(M.ConfigTable, fileName)
                                    or string.lower(fileName) == "muaiguideconfig"
                                    or M.NewFileName ~= ""
                            then
                                GUI:TextColored(1, 0, 0, 1, "已存在该名称文件或者名称不合法,无法创建!")
                                havaSame = true
                            else
                                M.NewFileName = NewFileName
                            end
                        end
                        GUI:PopItemWidth()
                        GUI:Button("确认", 100, 20)
                        if GUI:IsItemClicked(0) then
                            if not havaSame and M.NewFileName ~= nil and #M.NewFileName > 0 then
                                M.SaveFileConfig(M.NewFileName, M.Config.FruCfg)
                                M.FruConfigUI.NewMode = false
                                if M.NewFileName ~= M.ConfigTable[M.ConfigTableIndex] then
                                    table.insert(M.ConfigTable, M.NewFileName)
                                end
                            else
                                M.Info("已存在该名称文件或者名称不合法,无法创建!")
                            end
                        end
                        GUI:SameLine()
                        GUI:Button("取消", 100, 20)
                        if GUI:IsItemClicked(0) then
                            M.NewFileName = M.ConfigTable[M.ConfigTableIndex]
                            M.FruConfigUI.NewMode = false
                        end
                    else
                        GUI:PushItemWidth(300)
                        local configIndex, configIndexChange = GUI:Combo("##configIndex", M.ConfigTableIndex, M.ConfigTable, 4)
                        if configIndexChange then
                            M.ConfigTableIndex = configIndex
                            M.NewFileName = M.ConfigTable[M.ConfigTableIndex]
                        end
                        GUI:PopItemWidth()
                        if M.ConfigTableIndex == 1 then
                            GUI:Button("新建配置", 90, 20)
                            if GUI:IsItemClicked(0) then
                                M.NewFileName = ""
                                M.FruConfigUI.NewMode = true
                            end
                        else
                            GUI:Button("加载此配置", 90, 20)
                            if GUI:IsItemClicked(0) then
                                local fileName = M.ConfigTable[M.ConfigTableIndex]
                                M.Config.FruCfg = M.LoadFileConfig(fileName)
                            end
                            GUI:SameLine()
                            GUI:Button("新建配置", 90, 20)
                            if GUI:IsItemClicked(0) then
                                M.NewFileName = ""
                                M.FruConfigUI.NewMode = true
                            end
                            GUI:SameLine()
                            GUI:Button("保存到此配置", 100, 20)
                            if GUI:IsItemClicked(0) then
                                M.SaveFileConfig(M.NewFileName, M.Config.FruCfg)
                            end
                        end
                    end
                    GUI:TreePop()
                end
                GUI:Separator()
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("3.基础设置") then
                    M.FruConfigUI.AddLabel("基础八方：", false, 115)
                    GUI:PushItemWidth(180)
                    local gJobPos, gJobPosChanged = GUI:InputText("##JobPos", M.StringJoin(M.Config.FruCfg.JobPos, ","), GUI.InputTextFlags_CharsNoBlank)
                    if gJobPosChanged then
                        M.Config.FruCfg.JobPos = M.StringSplit(gJobPos, ",")
                    end
                    GUI:PopItemWidth()
                    M.FruConfigUI.AddLabel("场地标点：", false)
                    GUI:PushItemWidth(115)
                    local markPos, markPosChanged = GUI:InputText("##PosInfo", M.StringJoin(M.Config.FruCfg.PosInfo, ","), GUI.InputTextFlags_CharsNoBlank)
                    if markPosChanged then
                        M.Config.FruCfg.PosInfo = M.StringSplit(markPos, ",")
                    end
                    GUI:PopItemWidth()
                    GUI:SameLine()
                    GUI:TextColored(255, 255, 0, 1, "※影响UI显示")
                    GUI:TreePop()
                end
            end
            if GUI:CollapsingHeader("P1.绝命战士") then
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("1.八方分散&雾龙") then
                    M.FruConfigUI.AddLabel("分散方式：", false, 118)
                    GUI:PushItemWidth(80)
                    local ProteanType, ProteanTypeCg = GUI:Combo("##ProteanType", M.Config.FruCfg.ProteanType, { "TH逆,D顺", "全顺时针" }, 4)
                    if ProteanTypeCg then
                        M.Config.FruCfg.ProteanType = ProteanType
                    end
                    GUI:PopItemWidth()
                    M.FruConfigUI.AddLabel("雾龙站位：", false)
                    GUI:PushItemWidth(180)
                    local utopainSkyPosInput, utopainSkyPosInputChanged = GUI:InputText("##FruUtopainSkyPosInfo", M.StringJoin(M.Config.FruCfg.FruUtopainSkyPosInfo, ","), GUI.InputTextFlags_CharsNoBlank)
                    if utopainSkyPosInputChanged then
                        M.Config.FruCfg.FruUtopainSkyPosInfo = M.StringSplit(utopainSkyPosInput ",")
                    end
                    GUI:PopItemWidth()
                    GUI:TreePop()
                end
                GUI:Separator()
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("2.双分组") then
                    GUI:TextColored(255, 255, 0, 1, "※含优先级设置，如高换反着写即可")
                    M.FruConfigUI.AddLabel("上方分组：", false, 127)
                    GUI:PushItemWidth(90)
                    local inputGroupUp, inputGroupUpChanged = GUI:InputText("##CatchTwoUp", M.StringJoin(M.Config.FruCfg.CatchTwoUp, ","), GUI.InputTextFlags_CharsNoBlank)
                    if inputGroupUpChanged then
                        M.Config.FruCfg.CatchTwoUp = M.StringSplit(inputGroupUp, ",")
                    end
                    M.FruConfigUI.AddLabel("下方分组：", false, 127)
                    GUI:PushItemWidth(90)
                    local inputGroupDown, inputGroupDownChanged = GUI:InputText("##CatchTwoDown", M.StringJoin(M.Config.FruCfg.CatchTwoDown, ","), GUI.InputTextFlags_CharsNoBlank)
                    if inputGroupDownChanged then
                        M.Config.FruCfg.CatchTwoDown = M.StringSplit(inputGroupDown, ",")
                    end
                    M.FruConfigUI.AddLabel("需要换位时：", false)
                    GUI:PushItemWidth(50)
                    local inputGroupFall, inputGroupFallDownChanged = GUI:InputText("##CatchTwoDownFall", M.StringJoin(M.Config.FruCfg.CatchTwoDownFall, ","), GUI.InputTextFlags_CharsNoBlank)
                    if inputGroupFallDownChanged then
                        M.Config.FruCfg.CatchTwoDownFall = M.StringSplit(inputGroupFall, ",")
                    end
                    GUI:SameLine()
                    GUI:Text("补位")
                    GUI:PopItemWidth()
                    GUI:TreePop()
                end
                GUI:Separator()
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("3.雷火线") then
                    M.FruConfigUI.AddLabel("优先级：", false, 113)
                    GUI:PushItemWidth(185)
                    local FruLightFirePriority, FruLightFirePriorityChanged = GUI:InputText("##FruLightFirePriority", M.StringJoin(M.Config.FruCfg.FruLightFirePriority, ","), GUI.InputTextFlags_CharsNoBlank)
                    if FruLightFirePriorityChanged then
                        M.Config.FruCfg.FruLightFirePriority = M.StringSplit(FruLightFirePriority, ",")
                    end
                    M.FruConfigUI.AddLabel("处理方式：", false)
                    GUI:PushItemWidth(50)
                    local FruLightFireDir, FruLightFireDirIdxChanged = GUI:Combo("##FruLightFireDir", M.Config.FruCfg.FruLightFireDir, { "上下", "左右" }, 4)
                    if FruLightFireDirIdxChanged then
                        M.Config.FruCfg.FruLightFireDir = FruLightFireDir
                    end
                    GUI:SameLine(0, 2)
                    if M.Config.FruCfg.FruLightFireDir == 1 then
                        M.FruConfigUI.AddLabel("方向分组", true, 218)
                        GUI:PushItemWidth(80)
                        local FruLightFireType, FruLightFireTypeIdxChanged = GUI:Combo("##FruLightFireType", M.Config.FruCfg.FruLightFireType, { "内外互换", "闲人固定" }, 4)
                        if FruLightFireTypeIdxChanged then
                            M.Config.FruCfg.FruLightFireType = FruLightFireType
                        end
                    else
                        M.Config.FruCfg.FruLightFireType = 1
                        GUI:TextColored(0, 255, 0, 1, "   ※仅支持内外互换")
                    end

                    if M.Config.FruCfg.FruLightFireType == 1 then
                        M.FruConfigUI.AddLabel("闲人站位：", false, 113)
                        GUI:PushItemWidth(70)
                        local restPos, restPosChanged = GUI:InputText("##FruLightFireRestPos", M.StringJoin(M.Config.FruCfg.FruLightFireRestPos, ","), GUI.InputTextFlags_CharsNoBlank)
                        GUI:PopItemWidth()
                        if restPosChanged then
                            M.Config.FruCfg.FruLightFireRestPos = M.StringSplit(restPos, ",")
                        end
                        if FruLightFireDir == 1 then
                            GUI:TextColored(0, 255, 0, 1, "   ※左上、右上、左下、右下分别对应几号闲人")
                        else
                            GUI:TextColored(0, 255, 0, 1, "   ※左上、左下、右上、右下分别对应几号闲人")
                        end
                    end
                    GUI:TreePop()
                end
                GUI:Separator()
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("4.踩塔") then
                    M.FruConfigUI.AddLabel("基本方案：", false, 130)
                    GUI:PushItemWidth(90)
                    local TakeTowerType, TakeTowerTypeIdxChanged = GUI:Combo("##TakeTowerType", M.Config.FruCfg.TakeTowerType, { "填充数数", "固定和补位", "日野主流" }, 4)
                    if TakeTowerTypeIdxChanged then
                        M.Config.FruCfg.TakeTowerType = TakeTowerType
                    end
                    GUI:PopItemWidth()

                    if M.Config.FruCfg.TakeTowerType == 1 then
                        M.FruConfigUI.AddLabel("填充优先级：", false)
                        GUI:PushItemWidth(140)
                        local fallInput, fallInputChanged = GUI:InputText("##FallTowerOrder", M.StringJoin(M.Config.FruCfg.FallTowerOrder, ","), GUI.InputTextFlags_CharsNoBlank)
                        if fallInputChanged then
                            M.Config.FruCfg.FallTowerOrder = M.StringSplit(fallInput, ",")
                        end
                        GUI:PopItemWidth()
                    elseif M.Config.FruCfg.TakeTowerType == 2 then
                        GUI:BulletText("成员设置：")
                        GUI:SameLine()
                        GUI:TextColored(0, 255, 0, 1, "※第一个是固定，第二个是补位")
                        GUI:PushItemWidth(45)
                        GUI:Dummy(10, 0)
                        GUI:SameLine()
                        local inputFixUp, inputFixUpChanged = GUI:InputText(":上塔 ", M.StringJoin(M.Config.FruCfg.FixTowerUp, ","), GUI.InputTextFlags_CharsNoBlank)
                        if inputFixUpChanged then
                            M.Config.FruCfg.FixTowerUp = M.StringSplit(inputFixUp, ",")
                        end
                        GUI:SameLine()
                        local inputFixMid, inputFixMidChanged = GUI:InputText(":中塔 ", M.StringJoin(M.Config.FruCfg.FixTowerMid, ","), GUI.InputTextFlags_CharsNoBlank)
                        if inputFixMidChanged then
                            M.Config.FruCfg.FixTowerMid = M.StringSplit(inputFixMid, ",")
                        end
                        GUI:SameLine()
                        local inputFixDown, inputFixDownChanged = GUI:InputText(":下塔 ", M.StringJoin(M.Config.FruCfg.FixTowerDown, ","), GUI.InputTextFlags_CharsNoBlank)
                        if inputFixDownChanged then
                            M.Config.FruCfg.FixTowerDown = M.StringSplit(inputFixDown, ",")
                        end
                        GUI:PopItemWidth()
                    elseif M.Config.FruCfg.TakeTowerType == 3 then
                        GUI:BulletText("成员设置：")
                        GUI:SameLine()
                        GUI:TextColored(0, 255, 0, 1, "※对应位置以及优先级")
                        GUI:Dummy(10, 0)
                        GUI:SameLine()
                        GUI:PushItemWidth(65)
                        local inputFixJp, inputFixJpChanged = GUI:InputText("固定  ", M.StringJoin(M.Config.FruCfg.JapanTowerFix, ","), GUI.InputTextFlags_CharsNoBlank)
                        if inputFixJpChanged then
                            M.Config.FruCfg.JapanTowerFix = M.StringSplit(inputFixJp, ",")
                        end
                        GUI:SameLine()
                        local inputFallJp, inputFallJpChanged = GUI:InputText("补位 ", M.StringJoin(M.Config.FruCfg.JapanTowerFall, ","), GUI.InputTextFlags_CharsNoBlank)
                        if inputFallJpChanged then
                            M.Config.FruCfg.JapanTowerFall = M.StringSplit(inputFallJp, ",")
                        end
                        GUI:PopItemWidth()
                    end
                    GUI:TreePop()
                end
            end
            if GUI:CollapsingHeader("P2.希瓦·米特隆") then
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("1.钻石星辰") then
                    GUI:PushItemWidth(90)
                    M.FruConfigUI.AddLabel("点名和冰花重叠时：", false)
                    local DDChangeType, DDChangeTypeChange = GUI:Combo("##DDChangeType", M.Config.FruCfg.DDChangeType, { "同组互换", "全体顺时针" }, 4)
                    if DDChangeTypeChange then
                        M.Config.FruCfg.DDChangeType = DDChangeType
                    end
                    GUI:SameLine()
                    GUI:Text("处理")
                    M.FruConfigUI.AddLabel("左右分组方案：", false, 165)
                    local fCfg = M.Config.FruCfg.PosInfo
                    local dGroup1Str = fCfg[5] .. fCfg[6] .. fCfg[7] .. fCfg[8] .. "/" .. fCfg[4] .. fCfg[3] .. fCfg[2] .. fCfg[1]
                    local dGroup2Str = fCfg[4] .. fCfg[5] .. fCfg[6] .. fCfg[7] .. "/" .. fCfg[3] .. fCfg[2] .. fCfg[1] .. fCfg[8]
                    local DDGroupType, DDGroupTypeIdxChange = GUI:Combo("##DDGroupType", M.Config.FruCfg.DDGroupType, { dGroup1Str, dGroup2Str }, 4)
                    if DDGroupTypeIdxChange then
                        M.Config.FruCfg.DDGroupType = DDGroupType
                    end
                    M.FruConfigUI.AddLabel("逆时针跑圈方式：", false, 165)
                    GUI:PushItemWidth(120)
                    local DDRunType, DDRunTypeChange = GUI:Combo("##DDRunType", M.Config.FruCfg.DDRunType, { "全体成员都逆", "仅分身在45度逆" }, 4)
                    if DDRunTypeChange then
                        M.Config.FruCfg.DDRunType = DDRunType
                    end
                    GUI:PopItemWidth()
                    M.FruConfigUI.AddLabel("滑冰倒计时提示：", false, 165)
                    GUI:PushItemWidth(50)
                    local SkatingHit, SkatingHitChange = GUI:Combo("##SkatingHit", M.Config.FruCfg.SkatingHit, { "TTS", "噪音", "关闭" }, 4)
                    if SkatingHitChange then
                        M.Config.FruCfg.SkatingHit = SkatingHit
                    end

                    GUI:PopItemWidth()
                    GUI:TreePop()
                end
                GUI:Separator()
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("2.镜中奇遇") then
                    GUI:PushItemWidth(90)
                    M.FruConfigUI.AddLabel("白镜子与两个红镜子等距时：", false)
                    local MirrorSameDistanceType, MirrorSameDistanceTypeChange = GUI:Combo("##MirrorSameDistanceType", M.Config.FruCfg.MirrorSameDistanceType, { "远左近右", "顺时针" }, 4)
                    if MirrorSameDistanceTypeChange then
                        M.Config.FruCfg.MirrorSameDistanceType = MirrorSameDistanceType
                    end
                    GUI:PopItemWidth()
                    M.FruConfigUI.AddLabel("远程站位：", false)
                    local inputRange, inputRangeChanged = GUI:InputText("##MirrorPosRange", M.StringJoin(M.Config.FruCfg.MirrorPosRange, ","), GUI.InputTextFlags_CharsNoBlank)
                    if inputRangeChanged then
                        M.Config.FruCfg.MirrorPosRange = M.StringSplit(inputRange, ",")
                    end
                    GUI:SameLine()
                    GUI:TextColored(255, 0, 0, 1, "※面向红镜子")
                    GUI:BulletText("近战站位：")
                    M.FruConfigUI.AddLabel("    第一波：", true, 115)
                    local inputMelee1, inputMelee1Changed = GUI:InputText("##MirrorPosMelee1", M.StringJoin(M.Config.FruCfg.MirrorPosMelee1, ","), GUI.InputTextFlags_CharsNoBlank)
                    if inputMelee1Changed then
                        M.Config.FruCfg.MirrorPosMelee1 = M.StringSplit(inputMelee1, ",")
                    end
                    GUI:SameLine()
                    GUI:TextColored(0, 255, 255, 1, "※背对蓝镜子")
                    M.FruConfigUI.AddLabel("    第二波：", true, 115)
                    local inputMelee2, inputMelee2Changed = GUI:InputText("##MirrorPosMelee2", M.StringJoin(M.Config.FruCfg.MirrorPosMelee2, ","), GUI.InputTextFlags_CharsNoBlank)
                    if inputMelee2Changed then
                        M.Config.FruCfg.MirrorPosMelee2 = M.StringSplit(inputMelee2, ",")
                    end
                    GUI:SameLine()
                    GUI:TextColored(255, 0, 0, 1, "※面向红镜子")
                    GUI:PopItemWidth()
                    GUI:TreePop()
                end
                GUI:Separator()
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("3.光之暴走") then
                    M.FruConfigUI.AddLabel("基本方案：", false)
                    GUI:PushItemWidth(80)
                    local FruLightRampantTypeIdx, FruLightRampantTypeIdxChange = GUI:Combo("##FruLightRampantType", M.Config.FruCfg.FruLightRampantType, { "正六芒星", "新灰九式" }, 4)
                    if FruLightRampantTypeIdxChange then
                        M.Config.FruCfg.FruLightRampantType = FruLightRampantTypeIdx
                    end
                    GUI:PopItemWidth()
                    if M.Config.FruCfg.FruLightRampantType == 1 then
                        M.FruConfigUI.AddLabel("优先级：", false, 112)
                        GUI:PushItemWidth(180)
                        local lrPos, lrPosChanged = GUI:InputText("##FruLightRampantOrder", M.StringJoin(M.Config.FruCfg.FruLightRampantOrder, ","), GUI.InputTextFlags_CharsNoBlank)
                        if lrPosChanged then
                            M.Config.FruCfg.FruLightRampantOrder = M.StringSplit(lrPos, ",")
                        end
                        M.FruConfigUI.AddLabel("放圈方式：", false)
                        GUI:PushItemWidth(80)
                        local FruLightRampantDropType, FruLightRampantDropTypeChange = GUI:Combo("##FruLightRampantDropType", M.Config.FruCfg.FruLightRampantDropType, { "莫古力", "田园郡" }, 4)
                        if FruLightRampantDropTypeChange then
                            M.Config.FruCfg.FruLightRampantDropType = FruLightRampantDropType
                        end
                        GUI:PopItemWidth()
                    end
                    GUI:TreePop()
                end
            end
            if GUI:CollapsingHeader("P3.暗之巫女") then
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("1.时间压缩·绝") then
                    M.FruConfigUI.AddLabel("处理方案：", false)
                    GUI:PushItemWidth(80)
                    local UltimateRelativityType, UltimateRelativityTypeChange = GUI:Combo("##UltimateRelativityType", M.Config.FruCfg.UltimateRelativityType, { "灰九式", "日野摇号" }, 4)
                    if UltimateRelativityTypeChange then
                        M.Config.FruCfg.UltimateRelativityType = UltimateRelativityType
                    end
                    if M.Config.FruCfg.UltimateRelativityType == 1 then
                        GUI:TextColored(0, 255, 255, 1, "   ※看小队列表获取优先级")
                    elseif M.Config.FruCfg.UltimateRelativityType == 2 then
                        GUI:TextColored(0, 255, 255, 1, "   ※日基自动摇号，根据摇到的号确定优先级")
                    end
                    GUI:PopItemWidth()
                    GUI:TreePop()
                end
                GUI:Separator()
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("2.启示录") then
                    GUI:PushItemWidth(80)
                    M.FruConfigUI.AddLabel("处理方案：", false)
                    local ApocalypseGroupType, ApocalypseGroupTypeCg = GUI:Combo("##ApocalypseGroupType", M.Config.FruCfg.ApocalypseGroupType, { "预站位", "莫莫科技", "日野主流", "双分组" }, 4)
                    if ApocalypseGroupTypeCg then
                        M.Config.FruCfg.ApocalypseGroupType = ApocalypseGroupType
                    end
                    GUI:PopItemWidth()
                    if M.Config.FruCfg.ApocalypseGroupType == 1 then
                        GUI:TextColored(0, 255, 255, 1, "   ※左右预站位，低优先级交换，包含车头法等")
                    elseif M.Config.FruCfg.ApocalypseGroupType == 3 then
                        GUI:TextColored(0, 255, 255, 1, "   ※上下预站位，高优先级交换")
                    elseif M.Config.FruCfg.ApocalypseGroupType == 2 then
                        GUI:TextColored(0, 255, 255, 1, "   ※莫灵喵标记攻击左非攻击右")
                    else
                        GUI:TextColored(0, 255, 255, 1, "   ※双分组固定站位")
                    end
                    if M.Config.FruCfg.ApocalypseGroupType <= 2 then
                        if M.Config.FruCfg.ApocalypseGroupType == 1 then
                            M.FruConfigUI.AddLabel("换位后：", false, 113)
                            GUI:PushItemWidth(100)
                            local ApocalypseChangePos, ApocalypseChangePosCg = GUI:Combo("##ApocalypseChangePos", M.Config.FruCfg.ApocalypseChangePos, { "不调整站位", "调整站位" }, 4)
                            if ApocalypseChangePosCg then
                                M.Config.FruCfg.ApocalypseChangePos = ApocalypseChangePos
                            end
                            GUI:PopItemWidth()
                            if M.Config.FruCfg.ApocalypseChangePos == 2 then
                                GUI:TextColored(0, 255, 255, 1, "   ※根据第1次分摊时相对位置处理分散")
                            end
                        end
                        GUI:PushItemWidth(80)
                        M.FruConfigUI.AddLabel("分散方案：", false, 113)
                        local ApocalypseType, ApocalypseTypeCg = GUI:Combo("##ApocalypseType", M.Config.FruCfg.ApocalypseType, { "车头基准", "人群基准", "起点基准" }, 4)
                        if ApocalypseTypeCg then
                            M.Config.FruCfg.ApocalypseType = ApocalypseType
                        end
                        GUI:PopItemWidth()
                        if M.Config.FruCfg.ApocalypseType == 1 then
                            GUI:TextColored(0, 255, 255, 1, "   ※车头固定，其他人去车头顺/逆下一个点")
                        elseif M.Config.FruCfg.ApocalypseType == 2 then
                            GUI:TextColored(0, 255, 255, 1, "   ※人群固定，车头去人群顺/逆上一个点")
                        elseif M.Config.FruCfg.ApocalypseType == 3 then
                            GUI:TextColored(0, 255, 255, 1, "   ※地火起点固定，人群去自己起点最近的一个点")
                        end
                    elseif M.Config.FruCfg.ApocalypseGroupType == 3 then
                        if M.Config.FruCfg.ApocalypseType > 2 then
                            M.Config.FruCfg.ApocalypseType = 1
                        end
                        GUI:PushItemWidth(80)
                        M.FruConfigUI.AddLabel("分散方案：", false, 113)
                        local ApocalypseType, ApocalypseTypeCg = GUI:Combo("##ApocalypseType", M.Config.FruCfg.ApocalypseType, { "地火基准", "安置基准" }, 4)
                        if ApocalypseTypeCg then
                            M.Config.FruCfg.ApocalypseType = ApocalypseType
                        end
                        GUI:PopItemWidth()
                    end

                    GUI:PushItemWidth(40)
                    M.FruConfigUI.AddLabel("暗夜舞蹈引导：", false)
                    local P3DarkestDanceTaker, P3DarkestDanceTakerChange = GUI:Combo("##P3DarkestDanceTaker", M.Config.FruCfg.P3DarkestDanceTaker, { "MT", "ST" }, 4)
                    if P3DarkestDanceTakerChange then
                        M.Config.FruCfg.P3DarkestDanceTaker = P3DarkestDanceTaker
                    end
                    GUI:SameLine()
                    GUI:TextColored(255, 0, 0, 1, "※T玩家必填，其他人随意！")
                    GUI:PopItemWidth()
                    GUI:TreePop()
                end
            end
            if GUI:CollapsingHeader("P4.光之巫女&暗之巫女") then
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("1.光暗龙诗：") then
                    M.FruConfigUI.AddLabel("优先级：", false)
                    GUI:PushItemWidth(180)
                    local DarkLitOrder, DarkLitOrderChanged = GUI:InputText("##DarkLitOrder", M.StringJoin(M.Config.FruCfg.DarkLitOrder, ","), GUI.InputTextFlags_CharsNoBlank)
                    if DarkLitOrderChanged then
                        M.Config.FruCfg.DarkLitOrder = M.StringSplit(DarkLitOrder, ",")
                    end
                    GUI:PopItemWidth()
                    M.FruConfigUI.AddLabel("翻花绳四边形时换位人：", false, 204)
                    GUI:PushItemWidth(80)
                    local DarkLitChangeType, DarkLitChangeTypeCg = GUI:Combo("##DarkLitChangeType", M.Config.FruCfg.DarkLitChangeType, { "左边两人", "右边两人" }, 4)
                    if DarkLitChangeTypeCg then
                        M.Config.FruCfg.DarkLitChangeType = DarkLitChangeType
                    end
                    GUI:PopItemWidth()
                    GUI:PushItemWidth(40)
                    M.FruConfigUI.AddLabel("暗夜舞蹈引导：", false)
                    local P4DarkestDanceTaker, P4DarkestDanceTakerChange = GUI:Combo("##P4DarkestDanceTaker", M.Config.FruCfg.P4DarkestDanceTaker, { "MT", "ST" }, 4)
                    if P4DarkestDanceTakerChange then
                        M.Config.FruCfg.P4DarkestDanceTaker = P4DarkestDanceTaker
                    end
                    GUI:SameLine()
                    GUI:TextColored(255, 0, 0, 1, "※T玩家必填，其他人随意！")
                    GUI:PopItemWidth()
                    GUI:TreePop()
                end
                GUI:Separator()
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("2.时间结晶：") then
                    M.FruConfigUI.AddLabel("优先级：", false)
                    GUI:PushItemWidth(180)
                    local inputP42ProPriority, inputP42ProPriorityChange = GUI:InputText("##CrystallizeTimePriority", M.StringJoin(M.Config.FruCfg.CrystallizeTimePriority, ","), GUI.InputTextFlags_CharsNoBlank)
                    if inputP42ProPriorityChange then
                        M.Config.FruCfg.CrystallizeTimePriority = M.StringSplit(inputP42ProPriority, ",")
                    end
                    GUI:PopItemWidth()
                    M.FruConfigUI.AddLabel("红冰不分摊人：", false, 162)
                    GUI:PushItemWidth(100)
                    local CrystallizeTimeBuffType, CrystallizeTimeBuffTypeCg = GUI:Combo("##CrystallizeTimeBuffType", M.Config.FruCfg.CrystallizeTimeBuffType, { "往下躲大圈", "赤暴走开冲" }, 4)
                    if CrystallizeTimeBuffTypeCg then
                        M.Config.FruCfg.CrystallizeTimeBuffType = CrystallizeTimeBuffType
                    end
                    GUI:PopItemWidth()
                    GUI:PushItemWidth(110)
                    if M.Config.FruCfg.CrystallizeTimeBuffType == 2 then
                        GUI:TextColored(0, 1, 1, 1, "  ※赤暴走含自动疾跑")
                    end
                    M.FruConfigUI.AddLabel("贡品拾取方式：", false, 162)
                    local CrystallizeTimeType, CrystallizeTimeTypeCG = GUI:Combo("##CrystallizeTimeType", M.Config.FruCfg.CrystallizeTimeType, { "BUFF固定", "科技标点", "自动手摇结果" }, 4)
                    if CrystallizeTimeTypeCG then
                        M.Config.FruCfg.CrystallizeTimeType = CrystallizeTimeType
                    end
                    if M.Config.FruCfg.CrystallizeTimeType == 2 then
                        GUI:TextColored(255, 0, 0, 1, "※目前科技种类繁杂，为做到兼容适配，你要问下")
                        GUI:TextColored(255, 0, 0, 1, "开那个人锁链和禁止代表的意义。当然也可以选择")
                        GUI:TextColored(255, 0, 0, 1, "【无视禁止和锁链】，并确认好【优先级】！")
                        M.FruConfigUI.AddLabel("科技类型：", false, 162)
                        GUI:PushItemWidth(140)
                        local CrystallizeTimeActType, CrystallizeTimeActTypeCG = GUI:Combo("##CrystallizeTimeActType", M.Config.FruCfg.CrystallizeTimeActType, { "红冰锁链|红风禁止", "红冰禁止|红风锁链", "无视锁链和禁止" }, 4)
                        if CrystallizeTimeActTypeCG then
                            M.Config.FruCfg.CrystallizeTimeActType = CrystallizeTimeActType
                        end
                        GUI:PopItemWidth()
                    end
                    GUI:PopItemWidth()
                    GUI:Text("--------------------------------------")
                    GUI:BulletText("贡品拾取位置：")
                    local leftStr = M.Config.FruCfg.PosInfo[7]
                    local rightStr = M.Config.FruCfg.PosInfo[3]
                    local rightDownStr = M.Config.FruCfg.PosInfo[2]
                    local leftDownStr = M.Config.FruCfg.PosInfo[8]
                    if M.Config.FruCfg.CrystallizeTimeType == 1 then
                        GUI:Dummy(10, 0)
                        GUI:SameLine()
                        local labels = { leftStr, rightStr, rightDownStr, leftDownStr }
                        GUI:PushItemWidth(50)
                        local buffIds = { 2460, 2454, 2462, 2461 }
                        local buffNames = { "暗焰", "分摊", "冰封", "狂水" }
                        local indexChange = { 1, 2, 4, 3 }
                        for i = 1, 4 do
                            local index = indexChange[i]
                            local buffId = tonumber(M.Config.FruCfg.CrystallizeTimeByBuff[index])
                            local buffIndex = M.IndexOf(buffIds, buffId)
                            M.FruConfigUI.AddLabel("[" .. labels[index] .. "]", true)
                            local newIndex, changed = GUI:Combo("##POS" .. index, buffIndex, buffNames, 4)
                            if changed then
                                local newBuff = buffIds[newIndex]
                                local oldIndex
                                for j = 1, 4 do
                                    if newBuff == tonumber(M.Config.FruCfg.CrystallizeTimeByBuff[j]) then
                                        oldIndex = j
                                        break
                                    end
                                end
                                M.Config.FruCfg.CrystallizeTimeByBuff[index] = M.Config.FruCfg.CrystallizeTimeByBuff[oldIndex]
                                M.Config.FruCfg.CrystallizeTimeByBuff[oldIndex] = buffId
                            end
                            if i == 1 then
                                GUI:SameLine(0, 100)
                            elseif i == 2 then
                                GUI:Dummy(35, 0)
                                GUI:SameLine()
                            elseif i == 3 then
                                GUI:SameLine(0, 50)
                            end
                        end

                        GUI:PopItemWidth()
                    else
                        GUI:SameLine()
                        GUI:TextColored(0, 255, 0, 1, "※攻击1到4标记位置")
                        GUI:PushItemWidth(20)
                        M.FruConfigUI.MarkInputRight = true
                        GUI:Dummy(10, 0)
                        GUI:SameLine()
                        M.FruConfigUI.AddLabel("[" .. leftStr .. "]", true)
                        local inputStrD, DChanged = GUI:InputText("##CrystallizeMarkD", M.Config.FruCfg.CrystallizeMark["D"], GUI.InputTextFlags_CharsNoBlank)
                        if DChanged then
                            if tonumber(inputStrD) == nil or tonumber(inputStrD) > 4 then
                                M.FruConfigUI.MarkInputRight = false
                            else
                                M.Config.FruCfg.CrystallizeMark["D"] = inputStrD
                            end
                        end
                        GUI:SameLine(0, 160)
                        M.FruConfigUI.AddLabel("[" .. rightStr .. "]", true)
                        local inputStrB, BChanged = GUI:InputText("##CrystallizeMarkB", M.Config.FruCfg.CrystallizeMark["B"], GUI.InputTextFlags_CharsNoBlank)
                        if BChanged then
                            if tonumber(inputStrB) == nil or tonumber(inputStrB) > 4 then
                                M.FruConfigUI.MarkInputRight = false
                            else
                                M.Config.FruCfg.CrystallizeMark["B"] = inputStrB
                            end
                        end
                        GUI:Dummy(45, 0)
                        GUI:SameLine()
                        M.FruConfigUI.AddLabel("[" .. leftDownStr .. "]", true)
                        local inputStr4, _4Changed = GUI:InputText("##CrystallizeMark4", M.Config.FruCfg.CrystallizeMark["4"], GUI.InputTextFlags_CharsNoBlank)
                        if _4Changed then
                            if tonumber(inputStr4) == nil or tonumber(inputStr4) > 4 then
                                M.FruConfigUI.MarkInputRight = false
                            else
                                M.Config.FruCfg.CrystallizeMark["4"] = inputStr4
                            end
                        end
                        GUI:SameLine(0, 90)
                        M.FruConfigUI.AddLabel("[" .. rightDownStr .. "]", true)
                        local inputStr3, _3Changed = GUI:InputText("##CrystallizeMark3", M.Config.FruCfg.CrystallizeMark["3"], GUI.InputTextFlags_CharsNoBlank)
                        if _3Changed then
                            if tonumber(inputStr3) == nil or tonumber(inputStr3) > 4 then
                                M.FruConfigUI.MarkInputRight = false
                            else
                                M.Config.FruCfg.CrystallizeMark["3"] = inputStr3
                            end
                        end
                        if not M.FruConfigUI.MarkInputRight then
                            GUI:TextColored(255, 0, 0, 1, "错误，请检查填写的内容!")
                        end
                        GUI:PopItemWidth()
                    end
                    GUI:Text("--------------------------------------")

                    GUI:PushItemWidth(80)
                    M.FruConfigUI.AddLabel("击退方案：", false, 140)
                    local CrystallizeTimeKnockBack, CrystallizeTimeKnockBackCg = GUI:Combo("##CrystallizeTimeKnockBack", M.Config.FruCfg.CrystallizeTimeKnockBack, { "Y字击退", "角落击退" }, 4)
                    if CrystallizeTimeKnockBackCg then
                        M.Config.FruCfg.CrystallizeTimeKnockBack = CrystallizeTimeKnockBack
                    end
                    GUI:PopItemWidth()
                    if M.Config.FruCfg.CrystallizeTimeKnockBack == 1 then
                        GUI:TextColored(0, 255, 255, 1, "   ※Y字击退自动开启防击退")
                    elseif M.Config.FruCfg.CrystallizeTimeKnockBack then
                        GUI:PushItemWidth(80)
                        M.FruConfigUI.AddLabel("回返位置：", false, 140)
                        local CrystallizeTimeKnockCType, CrystallizeTimeKnockCTypeCg = GUI:Combo("##CrystallizeTimeKnockCType", M.Config.FruCfg.CrystallizeTimeKnockCType, { "外标点", "内标点" }, 4)
                        if CrystallizeTimeKnockCTypeCg then
                            M.Config.FruCfg.CrystallizeTimeKnockCType = CrystallizeTimeKnockCType
                        end
                        GUI:PopItemWidth()
                    end
                    GUI:TreePop()
                end
            end
            if GUI:CollapsingHeader("P5.潘多拉·米特隆") then
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("1.踩塔：") then
                    GUI:TextColored(255, 0, 0, 1, "※仅支持MT1塔对面站位方案")
                    M.FruConfigUI.AddLabel("基本方案：")
                    GUI:PushItemWidth(80)
                    local DarkLightWingsTakeTowerType, DarkLightWingsTakeTowerTypeCg = GUI:Combo("##DarkLightWingsTakeTowerType", M.Config.FruCfg.DarkLightWingsTakeTowerType, { "固定踩塔", "顺序踩塔" }, 4)
                    if DarkLightWingsTakeTowerTypeCg then
                        M.Config.FruCfg.DarkLightWingsTakeTowerType = DarkLightWingsTakeTowerType
                    end
                    GUI:PopItemWidth()
                    GUI:BulletText("位置分配： ")
                    GUI:PushItemWidth(45)
                    if M.Config.FruCfg.DarkLightWingsTakeTowerType == 1 then
                        local inputDown, inputDownChanged = GUI:InputText("去下，", M.StringJoin(M.Config.FruCfg.DarkLightWings.Down, ","), GUI.InputTextFlags_CharsNoBlank)
                        if inputDownChanged then
                            M.Config.FruCfg.DarkLightWings.Down = M.StringSplit(inputDown, ",")
                        end
                        GUI:SameLine()
                        local inputLeft, inputLeftChanged = GUI:InputText("去左上，", M.StringJoin(M.Config.FruCfg.DarkLightWings.Left, ","), GUI.InputTextFlags_CharsNoBlank)
                        if inputLeftChanged then
                            M.Config.FruCfg.DarkLightWings.Left = M.StringSplit(inputLeft, ",")
                        end
                        GUI:SameLine()
                        local inputRight, inputRightChanged = GUI:InputText("去右上", M.StringJoin(M.Config.FruCfg.DarkLightWings.Right, ","), GUI.InputTextFlags_CharsNoBlank)
                        if inputRightChanged then
                            M.Config.FruCfg.DarkLightWings.Right = M.StringSplit(inputRight, ",")
                        end
                    else
                        local inputDown, inputDownChanged = GUI:InputText("去下，", M.StringJoin(M.Config.FruCfg.DarkLightWings2.Down, ","), GUI.InputTextFlags_CharsNoBlank)
                        if inputDownChanged then
                            M.Config.FruCfg.DarkLightWings2.Down = M.StringSplit(inputDown, ",")
                        end
                        GUI:SameLine()
                        local inputLeft, inputLeftChanged = GUI:InputText("安全区，", M.StringJoin(M.Config.FruCfg.DarkLightWings2.Left, ","), GUI.InputTextFlags_CharsNoBlank)
                        if inputLeftChanged then
                            M.Config.FruCfg.DarkLightWings2.Left = M.StringSplit(inputLeft, ",")
                        end
                        GUI:SameLine()
                        local inputRight, inputRightChanged = GUI:InputText("危险区", M.StringJoin(M.Config.FruCfg.DarkLightWings2.Right, ","), GUI.InputTextFlags_CharsNoBlank)
                        if inputRightChanged then
                            M.Config.FruCfg.DarkLightWings2.Right = M.StringSplit(inputRight, ",")
                        end
                    end
                    GUI:PopItemWidth()
                    GUI:TreePop()
                end
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("2.挡枪：") then
                    M.FruConfigUI.AddLabel("第1挡：", true)
                    GUI:PushItemWidth(50)
                    local drawWinPolarizing1, drawWinPolarizing1Changed = GUI:InputText("##drawWinPolarizing1", M.StringJoin( M.Config.FruCfg.drawWinPolarizingOrder[1], ","), GUI.InputTextFlags_CharsNoBlank)
                    if drawWinPolarizing1Changed then
                        M.Config.FruCfg.drawWinPolarizingOrder[1] = M.StringSplit(drawWinPolarizing1, ",")
                    end
                    GUI:PopItemWidth()
                    GUI:SameLine(0, 50)
                    M.FruConfigUI.AddLabel("第2挡：", true)
                    GUI:PushItemWidth(50)
                    local drawWinPolarizing2, drawWinPolarizing2Changed = GUI:InputText("##drawWinPolarizing2", M.StringJoin( M.Config.FruCfg.drawWinPolarizingOrder[2], ","), GUI.InputTextFlags_CharsNoBlank)
                    if drawWinPolarizing2Changed then
                        M.Config.FruCfg.drawWinPolarizingOrder[2] = M.StringSplit(drawWinPolarizing2, ",")
                    end
                    GUI:PopItemWidth()
                    M.FruConfigUI.AddLabel("第3挡：", true)
                    GUI:PushItemWidth(50)
                    local drawWinPolarizing3, drawWinPolarizing3Changed = GUI:InputText("##drawWinPolarizing3", M.StringJoin( M.Config.FruCfg.drawWinPolarizingOrder[3], ","), GUI.InputTextFlags_CharsNoBlank)
                    if drawWinPolarizing3Changed then
                        M.Config.FruCfg.drawWinPolarizingOrder[3] = M.StringSplit(drawWinPolarizing3, ",")
                    end
                    GUI:SameLine(0, 50)
                    GUI:PopItemWidth()
                    M.FruConfigUI.AddLabel("第4挡：", true)
                    GUI:PushItemWidth(50)
                    local drawWinPolarizing4, drawWinPolarizing4Changed = GUI:InputText("##drawWinPolarizing4", M.StringJoin( M.Config.FruCfg.drawWinPolarizingOrder[4], ","), GUI.InputTextFlags_CharsNoBlank)
                    if drawWinPolarizing4Changed then
                        M.Config.FruCfg.drawWinPolarizingOrder[4] = M.StringSplit(drawWinPolarizing4, ",")
                    end
                    GUI:PopItemWidth()
                    
                    GUI:TreePop()
                end
                GUI:Separator()
                GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing)
                if GUI:TreeNode("绘图设置：") then
                    GUI:TextColored(0, 1, 1, 1, "※补充一些绘制")
                    M.Config.FruCfg.drawShit = GUI:Checkbox("地火", M.Config.FruCfg.drawShit)
                    GUI:SameLine(0, 120)
                    M.Config.FruCfg.drawAknMorn = GUI:Checkbox("分摊", M.Config.FruCfg.drawAknMorn)
                    --GUI:SameLine(0,0)
                    --GUI:TextColored(1, 0, 0, 1, " ※仅支持44或17")
                    M.Config.FruCfg.drawWinLight = GUI:Checkbox("左右刀&远近", M.Config.FruCfg.drawWinLight)
                    GUI:SameLine(0, 75)
                    M.Config.FruCfg.drawWinPolarizing = GUI:Checkbox("挡枪", M.Config.FruCfg.drawWinPolarizing)
                    GUI:TreePop()
                end
            end
            if GUI:CollapsingHeader("特别鸣谢") then
                GUI:TextColored(0, 255, 255, 1, "※顺序不代表排名")
                GUI:Dummy(20, 3)
                GUI:SameLine()
                GUI:Text("megaminx、ppu、Shippo、kaze")
                GUI:Dummy(20, 3)
                GUI:SameLine()
                GUI:Text("Master Lee、String、SEA_Ai、倦、andraword")
                GUI:Dummy(20, 3)
                GUI:SameLine()
                GUI:Text("各大挂群群友、DC群友")
            end
        end
        M.SaveConfig()
        GUI:SetWindowSize(350, 0)
        GUI:End()
    end
end
return DrawFruConfigUI
