local titles = {
    "绝命战士",
    "希瓦·米特隆",
    "暗之巫女",
    "希瓦·米特隆&暗之巫女",
    "潘多拉希瓦·米特隆",
}
local function AddCheckBox(index, M)
    local key = M.FruMitigation.AoeNames[index].key
    local skillName = M.FruMitigation.JobMap[Player.job]
    if (M.Config.FruMitigation[key].Target == nil or skillName[1] == nil) and
            (M.Config.FruMitigation[key].Field == nil or skillName[2] == nil)
    then
        return
    end
    GUI:Columns(3, "TableExample", false)
    GUI:Dummy(15, 10)
    GUI:SameLine(0, 0)
    GUI:AlignFirstTextHeightToWidgets()
    GUI:BulletText(M.FruMitigation.AoeNames[index].name)
    GUI:NextColumn()
    if M.Config.FruMitigation[key].Target ~= nil and skillName[1] ~= nil then
        GUI:Dummy(25, 10)
        GUI:SameLine(0, 0)
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text(skillName[1])
        GUI:SameLine(0, 10)
        M.Config.FruMitigation[key].Target = GUI:Checkbox("##Target" .. key, M.Config.FruMitigation[key].Target)
    end
    GUI:NextColumn()
    if M.Config.FruMitigation[key].Field ~= nil and skillName[2] ~= nil then
        GUI:Dummy(15, 10)
        GUI:SameLine(0, 0)
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text(skillName[2])
        GUI:SameLine(0, 10)
        M.Config.FruMitigation[key].Field = GUI:Checkbox("##Field" .. key, M.Config.FruMitigation[key].Field)
    end
    GUI:Columns(1)
end
local DrawUI = function(M)
    if M.FruMitigationUI.open then
        if not M.UI.open or M.IsHealer(Player.job) then
            M.FruMitigationUI.open = false
            M.FruMitigationUI.NewMode = false
            return
        end
        GUI:SetNextWindowSize(300, 0, GUI.SetCond_Appearing)
        GUI:SetNextWindowPos(M.FruConfigUI.x, M.FruConfigUI.y, GUI.SetCond_Appearing)
        M.FruMitigationUI.visible, M.FruMitigationUI.open = GUI:Begin("Fru Mitigation Setting", M.FruMitigationUI.open)
        if M.FruMitigationUI.visible then
            GUI:TextColored(1, 0, 0, 1, "※请勿盲目勾选，需要根据技能CD情况合理设置。")
            GUI:TextColored(1, 0, 0, 1, "※如果你使用A轴且需要本工具，那么不要继承A轴的减伤!")
            GUI:TextColored(1, 0, 0, 1, "※需要对应的时间轴，请确认好继承自己职业的时间轴。")
            local jobName = M.GetJobNameById(Player.job)
            GUI:TextColored(1, 1, 0, 1, " 当前职业：" .. jobName)
            if M.IsTank(Player.job) then
                --     19, 21, 32, 37,
                --     "骑士", "战士", "黑骑", "绝枪",
                if Player.job == 32 then
                    GUI:TextColored(1, 1, 0, 1, " 请继承时间轴：\n   1.Jackpot\\fru-Tank-Self-Drk\n   2.Jackpot\\fru-Tank-Team")
                elseif Player.job == 19 then
                    GUI:TextColored(1, 1, 0, 1, " 请继承时间轴：\n   1.Jackpot\\fru-Tank-Self-Pld\n   2.Jackpot\\fru-Tank-Team")
                else
                    GUI:TextColored(1, 1, 0, 1, " 请继承时间轴：\n   暂不支持，有能力请自行开发")
                end
            end
            if M.IsMelee(Player.job) then
                GUI:TextColored(1, 1, 0, 1, " 请继承时间轴：MuAi\\MuAiMitigationMeleeFru")
            end
            if M.IsRange(Player.job) then
                GUI:TextColored(1, 1, 0, 1, " 请继承时间轴：MuAi\\MuAiMitigationRangeFru")
            end
            if M.IsMagic(Player.job) then
                GUI:TextColored(1, 1, 0, 1, " 请继承时间轴：MuAi\\MuAiMitigationMagicFru")
            end
            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing | GUI.SetCond_Once)
            if GUI:CollapsingHeader("团队减伤") then
                local lastP = 0
                for i = 1, #M.FruMitigation.AoeNames do
                    local curP = M.FruMitigation.AoeNames[i].p
                    if lastP ~= curP then
                        GUI:Separator()
                        GUI:BulletText("P" .. M.FruMitigation.AoeNames[i].p .. ". " .. titles[curP])
                        GUI:Separator()
                        lastP = curP
                    end
                    AddCheckBox(i, M)
                end
                if M.IsMelee(Player.job) then
                    GUI:Separator()
                    GUI:BulletText("自动极限技")
                    GUI:Dummy(20, 10)
                    GUI:SameLine()
                    
                    M.AddLabel("自动P3极限技", true, 120)
                    M.Config.FruMitigation.AutoLB1 = GUI:Checkbox("##AutoLB1",  M.Config.FruMitigation.AutoLB1)
                    GUI:SameLine(0, 50)
                    M.AddLabel("自动P5极限技", true,273)
                    M.Config.FruMitigation.AutoLB2 = GUI:Checkbox("##AutoLB2",  M.Config.FruMitigation.AutoLB2)
                end
                GUI:Separator()
                GUI:TextColored(1, 0, 0, 1, "※请谨慎使用，慎防挂友认亲！")
                GUI:TextColored(1, 0, 0, 1, "※默语默认打钩，此状态下发送到默语，可以复制出去做宏。")
                GUI:TextColored(1, 0, 0, 1, "※默语取消打钩，则直接发送到小队频道！（慎用）")
                local mark
                if M.FruMitigationUI.SendParty then
                    mark = "/e"
                else
                    mark = "/p"
                end
                GUI:Button("发送团队减伤", 270, 20)

                if GUI:IsItemClicked(0) then
                    local skillName = M.FruMitigation.JobMap[Player.job]
                    local lastPSend = 1
                    local pMark = "P1: "
                    local targetInfo = ""
                    local fieldInfo = ""
                    local msgSkill1 = {}
                    local msgSkill2 = {}
                    for i = 1, #M.FruMitigation.AoeNames do
                        local curInfo = M.FruMitigation.AoeNames[i]
                        local key = M.FruMitigation.AoeNames[i].key
                        if lastPSend ~= curInfo.p then
                            if #targetInfo ~= 0 then
                                table.insert(msgSkill1, pMark .. targetInfo)
                            end
                            if #fieldInfo ~= 0 then
                                table.insert(msgSkill2, pMark .. fieldInfo)
                            end
                            pMark = "P" .. curInfo .p .. ": "
                            lastPSend = curInfo.p
                            targetInfo = ""
                            fieldInfo = ""
                        end
                        if M.Config.FruMitigation[key].Target and skillName[1] then
                            if #targetInfo == 0 then
                                targetInfo = curInfo.macroInfo .. "  "
                            else
                                targetInfo = targetInfo .. curInfo.macroInfo .. "  "
                            end
                        end
                        if M.Config.FruMitigation[key].Field and skillName[2] then
                            if #fieldInfo == 0 then
                                fieldInfo = curInfo.macroInfo .. "  "
                            else
                                fieldInfo = fieldInfo .. curInfo.macroInfo .. " "
                            end
                        end
                    end
                    if #targetInfo ~= 0 then
                        table.insert(msgSkill1, pMark .. targetInfo)
                    end
                    if #fieldInfo ~= 0 then
                        table.insert(msgSkill2, pMark .. fieldInfo)
                    end
                    if #msgSkill1 > 0 then
                        SendTextCommand(mark .. " " .. skillName[1])
                        for i = 1, #msgSkill1 do
                            SendTextCommand(mark .. " " .. msgSkill1[i])
                        end
                    end
                    if #msgSkill2 > 0 then
                        SendTextCommand(mark .. " " .. skillName[2])
                        for i = 1, #msgSkill2 do
                            SendTextCommand(mark .. " " .. msgSkill2[i])
                        end
                    end
                end
                GUI:SameLine()
                M.FruMitigationUI.SendParty = GUI:Checkbox("默语", M.FruMitigationUI.SendParty)
            end
            if M.IsTank(Player.job) then
                if GUI:CollapsingHeader("坦克死刑") then
                    local table2 = { "自己减伤", "自己无敌" }
                    local table3 = { "自己无敌", "搭档无敌" }
                    local table4 = { "自己减伤", "自己无敌", "搭档减伤", "搭档无敌" }
                    local table5 = { "自己减伤", "自己无敌", "搭档无敌" }
                    local table6 = { "自己减伤", "搭档减伤", "不单吃" }
                    GUI:BulletText("P1." .. titles[1])
                    GUI:Separator()
                    GUI:Columns(2, "##Tank1", false)
                    GUI:Dummy(10, 10)
                    GUI:SameLine(0, 0)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:BulletText("第一次死刑:")
                    GUI:NextColumn()
                    GUI:PushItemWidth(100)
                    local P1_Death1, P1_Death1Change = GUI:Combo("##P1_Death1", M.Config.FruMitigation.Tank.P1_Death1, table4, 4)
                    if P1_Death1Change then
                        M.Config.FruMitigation.Tank.P1_Death1 = P1_Death1
                    end
                    GUI:Columns(1)
                    GUI:Columns(2, "##Tank2", false)
                    GUI:Dummy(10, 10)
                    GUI:SameLine(0, 0)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:BulletText("第二次死刑:")
                    GUI:NextColumn()
                    GUI:PushItemWidth(100)
                    local P1_Death2, P1_Death2Change = GUI:Combo("##P1_Death2", M.Config.FruMitigation.Tank.P1_Death2, table4, 4)
                    if P1_Death2Change then
                        M.Config.FruMitigation.Tank.P1_Death2 = P1_Death2
                    end
                    GUI:Columns(1)
                    GUI:Separator()
                    GUI:BulletText("P2." .. titles[2])
                    GUI:Separator()
                    GUI:Columns(2, "##Tank3", false)
                    GUI:Dummy(10, 10)
                    GUI:SameLine(0, 0)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:BulletText("开场死刑:")
                    GUI:NextColumn()
                    GUI:PushItemWidth(100)
                    local P2_Open, P2_OpenChange = GUI:Combo("##P2_Open", M.Config.FruMitigation.Tank.P2_Open, table3, 4)
                    if P2_OpenChange then
                        M.Config.FruMitigation.Tank.P2_Open = P2_Open
                    end
                    GUI:Columns(1)
                    GUI:Separator()
                    GUI:BulletText("P3." .. titles[3])
                    GUI:Separator()
                    GUI:Columns(2, "##Tank4", false)
                    GUI:Dummy(10, 10)
                    GUI:SameLine(0, 0)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:BulletText("黑色光环:")
                    GUI:NextColumn()
                    GUI:PushItemWidth(100)
                    local P3_BlackRing, P3_BlackRingChange = GUI:Combo("##P3_BlackRing", M.Config.FruMitigation.Tank.P3_BlackRing, table4, 4)
                    if P3_BlackRingChange then
                        M.Config.FruMitigation.Tank.P3_BlackRing = P3_BlackRing
                    end
                    GUI:Columns(1)
                    GUI:Columns(2, "##Tank5", false)
                    GUI:Dummy(10, 10)
                    GUI:SameLine(0, 0)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:BulletText("暗夜舞蹈:")
                    GUI:NextColumn()
                    GUI:PushItemWidth(100)
                    local P3_DarkestDance, P3_DarkestDanceChange = GUI:Combo("##P3_DarkestDance", M.Config.FruMitigation.Tank.P3_DarkestDance, table4, 4)
                    if P3_DarkestDanceChange then
                        M.Config.FruMitigation.Tank.P3_DarkestDance = P3_DarkestDance
                    end
                    GUI:Columns(1)
                    GUI:Separator()
                    GUI:BulletText("P4." .. titles[4])
                    GUI:Separator()
                    GUI:Columns(2, "##Tank6", false)
                    GUI:Dummy(10, 10)
                    GUI:SameLine(0, 0)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:BulletText("暗夜舞蹈:")
                    GUI:NextColumn()
                    GUI:PushItemWidth(100)
                    local P4_DarkestDance, P4_DarkestDanceChange = GUI:Combo("##P4_DarkestDance", M.Config.FruMitigation.Tank.P4_DarkestDance, table5, 4)
                    if P4_DarkestDanceChange then
                        M.Config.FruMitigation.Tank.P4_DarkestDance = P4_DarkestDance
                    end
                    GUI:Columns(1)
                    GUI:Columns(2, "##Tank7", false)
                    GUI:Dummy(10, 10)
                    GUI:SameLine(0, 0)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:BulletText("死亡轮回1:")
                    GUI:NextColumn()
                    GUI:PushItemWidth(100)
                    local P4_AkhMorn1, P4_AkhMorn1DanceChange = GUI:Combo("##P4_AkhMorn1", M.Config.FruMitigation.Tank.P4_AkhMorn1, table6, 4)
                    if P4_AkhMorn1DanceChange then
                        M.Config.FruMitigation.Tank.P4_AkhMorn1 = P4_AkhMorn1
                    end
                    GUI:Columns(1)
                    GUI:Columns(2, "##Tank8", false)
                    GUI:Dummy(10, 10)
                    GUI:SameLine(0, 0)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:BulletText("死亡轮回2:")
                    GUI:NextColumn()
                    GUI:PushItemWidth(100)
                    local P4_AkhMorn2, P4_AkhMorn2DanceChange = GUI:Combo("##P4_AkhMorn2", M.Config.FruMitigation.Tank.P4_AkhMorn2, table6, 4)
                    if P4_AkhMorn2DanceChange then
                        M.Config.FruMitigation.Tank.P4_AkhMorn2 = P4_AkhMorn2
                    end
                    GUI:Columns(1)
                    GUI:Separator()
                    GUI:BulletText("P5." .. titles[5])
                    GUI:Separator()
                    GUI:Columns(2, "##Tank9", false)
                    GUI:Dummy(10, 10)
                    GUI:SameLine(0, 0)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:BulletText("第一波死刑:")
                    GUI:NextColumn()
                    GUI:PushItemWidth(100)
                    local P5_Death1, P5_Death1RingChange = GUI:Combo("##P5_Death1", M.Config.FruMitigation.Tank.P5_Death1, table2, 4)
                    if P5_Death1RingChange then
                        M.Config.FruMitigation.Tank.P5_Death1 = P5_Death1
                    end
                    GUI:Columns(1)
                    GUI:Columns(2, "##Tank10", false)
                    GUI:Dummy(10, 10)
                    GUI:SameLine(0, 0)
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:BulletText("第二波死刑:")
                    GUI:NextColumn()
                    GUI:PushItemWidth(100)
                    local P5_Death2, P5_Death2Change = GUI:Combo("##P5_Death2", M.Config.FruMitigation.Tank.P5_Death2, table2, 4)
                    if P5_Death2Change then
                        M.Config.FruMitigation.Tank.P5_Death2 = P5_Death2
                    end
                    GUI:Columns(1)
                end
            end
            if GUI:CollapsingHeader("开发人员") then
                GUI:BulletText("构思&方案：")
                GUI:SameLine()
                GUI:Text("Jackpot、CatZ")
                GUI:BulletText("UI：")
                GUI:SameLine()
                GUI:Text("MuAi")
                GUI:BulletText("坦克减伤：")
                GUI:SameLine()
                GUI:Text("Jackpot")
                GUI:BulletText("DPS减伤：")
                GUI:SameLine()
                GUI:Text("MuAi")
            end
            GUI:Separator()
            GUI:BulletText("使用默认配置：")
            GUI:Dummy(10, 20)
            GUI:SameLine()
            GUI:Button("清空选择", 90, 20)
            if GUI:IsItemClicked(0) then
                M.Config.FruMitigation = M.FruMitigation.LoadDefault()
            end
            if M.IsTank(Player.job) then
                GUI:SameLine(0, 10)
                GUI:Button("读取MT默认", 90, 20)
                if GUI:IsItemClicked(0) then
                    M.FruMitigation.LoadDefaultByName("tank_mt_default.lua")
                end
                GUI:SameLine(0, 10)
                GUI:Button("读取ST默认", 90, 20)
                if GUI:IsItemClicked(0) then
                    M.FruMitigation.LoadDefaultByName("tank_st_default.lua")
                end
            elseif M.IsMelee(Player.job) then
                GUI:SameLine(0, 10)
                GUI:Button("读取D1默认", 90, 20)
                if GUI:IsItemClicked(0) then
                    M.FruMitigation.LoadDefaultByName("melee_d1_default.lua")
                    if Player.job == 20 then
                 
                        M.FruMitigation.LoadDefaultByNameEx("melee_monkEx.lua", false)
                    elseif Player.job == 39 then
                        M.FruMitigation.LoadDefaultByNameEx("melee_reaperEx.lua", false)
                    end
                end
                GUI:SameLine(0, 10)
                GUI:Button("读取D2默认", 90, 20)
                if GUI:IsItemClicked(0) then
                    M.FruMitigation.LoadDefaultByName("melee_d2_default.lua")
                    if Player.job == 20 then
                        M.FruMitigation.LoadDefaultByNameEx("melee_monkEx.lua", false)
                    elseif Player.job == 39 then
                        M.FruMitigation.LoadDefaultByNameEx("melee_reaperEx.lua", false)
                    end
                end
            elseif M.IsRange(Player.job) then
                GUI:SameLine(0, 10)
                GUI:Button("读取默认", 90, 20)
                if GUI:IsItemClicked(0) then
                    if Player.job == 31 then
                        M.FruMitigation.LoadDefaultByName("rdps_default_mch.lua")
                    elseif Player.job == 23 then
                        M.FruMitigation.LoadDefaultByName("rdps_default_brd.lua")
                    else
                        M.FruMitigation.LoadDefaultByName("rdps_default_dnc.lua")
                    end
                end
            elseif M.IsMagic(Player.job) then
                GUI:SameLine(0, 10)
                GUI:Button("读取D2默认", 90, 20)
                if GUI:IsItemClicked(0) then
                    M.FruMitigation.LoadDefaultByName("magic_d2_default.lua")
                    if Player.job == 35 then
                        M.FruMitigation.LoadDefaultByNameEx("magic_redmEx.lua", false)
                    elseif Player.job == 42 then
                        M.FruMitigation.LoadDefaultByNameEx("magic_pcmEx.lua", false)
                    end
                end
                GUI:SameLine(0, 10)
                GUI:Button("读取D4默认", 90, 20)
                if GUI:IsItemClicked(0) then
                    M.FruMitigation.LoadDefaultByName("magic_d2_default.lua")
                end
            end

            GUI:BulletText("配置文件工具：")
            if M.FruMitigationUI.NewMode then
                GUI:Dummy(10, 20)
                GUI:SameLine()
                M.AddLabel("新配置名：", true)
                GUI:PushItemWidth(200)
                local havaSame = false
                local NewFileName, NewFileNameChanged = GUI:InputText("##NewFileName", M.FruMitigationUI.NewFileName, GUI.InputTextFlags_CharsNoBlank)
                if NewFileNameChanged then
                    if M.ContainsIgnoreCase(M.Config.FruMitigationCustomList, NewFileName)
                            or string.lower(NewFileName) == "frumitigation"
                            or NewFileName == "" or #NewFileName == 0
                    then
                        GUI:TextColored(1, 0, 0, 1, "已存在该名称文件或者名称不合法,无法创建!")
                        havaSame = true
                    else
                        M.FruMitigationUI.NewFileName = NewFileName
                    end
                end
                GUI:PopItemWidth()
                GUI:Dummy(10, 20)
                GUI:SameLine()
                GUI:Button("确认", 100, 20)
                if GUI:IsItemClicked(0) then
                    if not havaSame and M.FruMitigationUI.NewFileName ~= nil and #M.FruMitigationUI.NewFileName > 0 then
                        local path = M.Config.FruMitigationPath .. "\\" .. M.GetJobNameById(Player.job)
                        M.SaveFileConfig(path, M.FruMitigationUI.NewFileName, M.Config.FruMitigation)
                        M.FruMitigationUI.NewMode = false
                        if M.FruMitigationUI.NewFileName ~= M.Config.FruMitigationCustomList[M.Config.FruMitigationCustomListIndex] then
                            table.insert(M.Config.FruMitigationCustomList, M.FruMitigationUI.NewFileName)
                        end
                    else
                        M.Info("已存在该名称文件或者名称不合法,无法创建!")
                    end
                end
                GUI:SameLine()
                GUI:Button("取消", 100, 20)
                if GUI:IsItemClicked(0) then
                    M.FruMitigationUI.NewFileName = M.Config.FruMitigationCustomList[M.Config.FruMitigationCustomListIndex]
                    M.FruMitigationUI.NewMode = false
                end
            else
                GUI:Dummy(10, 20)
                GUI:SameLine()
                GUI:PushItemWidth(300)
                local configIndex, configIndexChange = GUI:Combo("##configIndex", M.Config.FruMitigationCustomListIndex, M.Config.FruMitigationCustomList, 4)
                if configIndexChange then
                    M.Config.FruMitigationCustomListIndex = configIndex
                    M.FruMitigationUI.NewFileName = M.Config.FruMitigationCustomList[M.Config.FruMitigationCustomListIndex]
                end
                GUI:PopItemWidth()
                GUI:Dummy(10, 20)
                GUI:SameLine()
                if M.Config.FruMitigationCustomListIndex == 1 then
                    GUI:Button("新建配置", 90, 20)
                    if GUI:IsItemClicked(0) then
                        M.FruMitigationUI.NewFileName = ""
                        M.FruMitigationUI.NewMode = true
                    end
                else
                    GUI:Button("加载此配置", 90, 20)
                    if GUI:IsItemClicked(0) then
                        local path = M.Config.FruMitigationPath .. "\\" .. M.GetJobNameById(Player.job)
                        local fileName = M.Config.FruMitigationCustomList[M.Config.FruMitigationCustomListIndex]
                        local curConfig = M.FruMitigation.LoadDefault()
                        M.Config.FruMitigation = M.LoadFileConfig(path, fileName, curConfig)
                    end
                    GUI:SameLine()
                    GUI:Button("新建配置", 90, 20)
                    if GUI:IsItemClicked(0) then
                        M.FruMitigationUI.NewFileName = ""
                        M.FruMitigationUI.NewMode = true
                    end
                    GUI:SameLine()
                    GUI:Button("保存到此配置", 100, 20)
                    if GUI:IsItemClicked(0) then
                        local path = M.Config.FruMitigationPath .. "\\" .. M.GetJobNameById(Player.job)
                        M.SaveFileConfig(path, M.FruMitigationUI.NewFileName, M.Config.FruMitigation)
                    end
                end
            end

            M.SaveConfig(M.Config.FruMitigationPath .. "\\" .. M.GetJobNameById(Player.job), M.Config.FruMitigationFile, "FruMitigation")
        end
        GUI:SetWindowSize(410, 0)
        GUI:End()
    end
end
return DrawUI
