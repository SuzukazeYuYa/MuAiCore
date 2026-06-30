local DmuDpsUI = {}
local wide = 350
local key2 = {
    'Flaflare1',
    'LightOfJudgment1',
    'LightOfJudgment2',
    'Flaflare2',
    'TwinArms',
    'Forsaken1',
    'LightOfJudgment3',
    'TwinArms2',
    'Bowbow',
    'BlazeTsunami1',
    'BlazeTsunami2',
    'VacuumWave',
    'ThunderIII_T_2',
    'ThunderIII_T_3',
    'Shockwave1',
    'ThunderIII_T_4',
    'Shockwave2',
    'Shockwave3',
    'Blaze',
    'GrandCross1',
    'GrandCross2',
    'GrandCross3',
    'UltimaUpsideDown1',
    'UltimaUpsideDown2',
    'ConsecutiveUltima1',
    'MaddeningOrchestra1',
    'ConsecutiveUltima2',
    'MaddeningOrchestra2',
    'Forsaken1_P5',
    'Forsaken2_P5',
}
local jobMap = {
    --- Melee
    [34] = { "牵制" },
    [20] = { "牵制", "真言" },
    [22] = { "牵制" },
    [30] = { "牵制" },
    [39] = { "牵制" },
    [41] = { "牵制" },
    --- Range
    [31] = { "扳手", "策动", },
    [23] = { "大地神", "行吟", },
    [38] = { nil, "桑巴" },
    --- Magic
    [27] = { "混乱" },
    [42] = { "混乱", "画盾" },
    [25] = { "混乱", },
    [35] = { "混乱", "抗死" },
}

local singleLine = false
local newFileName = ""
local fileListIndex = 1
local getFilePath = function()
    return MuAiGuide.Config.DmuMitig .. '\\' .. Player.job
end

DmuDpsUI.draw = function()
    local M = MuAiGuide
    if not M.DmuDpsUI.open then
        return
    end
    if not M.IsDps(Player.job) then
        M.DmuDpsUI.open = false
        return
    end
    local jobValue = jobMap[Player.job]
    local fileList = M.Config.DmuMitigJobConfigs
    GUI:SetNextWindowPos(M.MainUI.uiPos.x, M.MainUI.uiPos.y)
    GUI:SetNextWindowSize(wide, 0, GUI.SetCond_Appearing)
    if jobValue[1] == nil or jobValue[2] == nil then
        singleLine = true
        wide = 340
    else
        singleLine = false
        wide = 360
    end
    M.DmuDpsUI.visible, M.DmuDpsUI.open = GUI:Begin("Dmu Mitigation Setting", M.DmuDpsUI.open)
    if M.DmuDpsUI.visible then
        GUI:TextColored(1, 1, 0, 1, '本插件暂时仅提供UI控制，本人未制作相关减伤轴,')
        GUI:TextColored(1, 1, 0, 1, '有需要可以自行制作, 或使用其他人做好的时间轴, ')
        GUI:TextColored(1, 1, 0, 1, '本插件将尽可能的提供技术支持!')
        ------------------------------------------------
        GUI:AlignFirstTextHeightToWidgets()
        GUI:BulletText('配置文件工具')
        GUI:SameLine(0, 60)
        GUI:Button('打开存档位置', 150, 22)
        if GUI:IsItemClicked(0) then
            if (not FolderExists(getFilePath())) then
                FolderCreate(getFilePath())
            end
            local cmd = string.format('explorer "%s"', getFilePath())
            d(cmd)
            local handle = io.popen(cmd)
            if handle then
                handle:close()
            end
        end
        if M.Config.DmuMitigNewMode then
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.UITool.AddLabel("新配置名：", false)
            GUI:PushItemWidth(200)
            local havaSame = false
            local NewFileName, NewFileNameChanged = GUI:InputText("##NewFileName", newFileName, GUI.InputTextFlags_CharsNoBlank)
            if NewFileNameChanged then
                local fileName = NewFileName
                if M.ContainsIgnoreCase(fileList, fileName)
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
                    M.SaveFileConfig(getFilePath(), newFileName, M.Config.DmuDpsCfg)
                    M.Config.DmuMitigNewMode = false
                    if newFileName ~= fileList[fileListIndex] then
                        table.insert(fileList, newFileName)
                    end
                else
                    M.ShowMsgUI(3, { "已存在该名称文件或者名称不合法,无法创建!" })
                end
            end
            GUI:SameLine()
            GUI:Button("取消", 100, 20)
            if GUI:IsItemClicked(0) then
                newFileName = fileList[fileListIndex]
                M.Config.DmuMitigNewMode = false
            end
        else
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(300)
            local configIndex, configIndexChange = GUI:Combo("##configIndex", fileListIndex, fileList, 30)
            if configIndexChange then
                fileListIndex = configIndex
                newFileName = fileList[fileListIndex]
            end
            GUI:PopItemWidth()
            if fileListIndex == 1 then
                GUI:Dummy(20, 0)
                GUI:SameLine(0, 0)
                GUI:Button("新建配置", 90, 20)
                if GUI:IsItemClicked(0) then
                    newFileName = ""
                    M.Config.DmuMitigNewMode = true
                end
            else
                GUI:Dummy(20, 0)
                GUI:SameLine(0, 0)
                GUI:Button("加载此配置", 90, 20)
                if GUI:IsItemClicked(0) then
                    local fileName = fileList[fileListIndex]
                    local defCfg = M.CreateDmuMigCfg()
                    M.Config.DmuDpsCfg = M.LoadFileConfig(getFilePath(), fileName, defCfg)
                end
                GUI:SameLine()
                GUI:Button("新建配置", 90, 20)
                if GUI:IsItemClicked(0) then
                    newFileName = ""
                    M.Config.DmuMitigNewMode = true
                end
                GUI:SameLine()
                GUI:Button("保存到此配置", 100, 20)
                if GUI:IsItemClicked(0) then
                    M.SaveFileConfig(getFilePath(), newFileName, M.Config.DmuDpsCfg)
                end
            end
        end

        --GUI:Separator()
        ------------------------------------------------
        local curP = 0

        if singleLine then
            GUI:Columns(3, 'TeamValue', true)
            GUI:SetColumnWidth(0, 68)
            GUI:SetColumnWidth(1, 100)
            GUI:SetColumnWidth(2, 80)
        else
            GUI:Columns(4, 'TeamValue', true)
            GUI:SetColumnWidth(0, 68)
            GUI:SetColumnWidth(1, 100)
            GUI:SetColumnWidth(2, 80)
            GUI:SetColumnWidth(3, 80)
        end
        for i = 1, #key2 do
            local curConfig = M.Config.DmuDpsCfg[key2[i]]
            if curP ~= curConfig.p then
                GUI:Columns(1)
                GUI:Separator()
                GUI:BulletText('P' .. curConfig.p)
                GUI:Separator()
                if singleLine then
                    GUI:Columns(3)
                    GUI:SetColumnWidth(0, 68)
                    GUI:SetColumnWidth(1, 100)
                    GUI:SetColumnWidth(2, 80)
                else
                    GUI:Columns(4)
                    GUI:SetColumnWidth(0, 68)
                    GUI:SetColumnWidth(1, 100)
                    GUI:SetColumnWidth(2, 80)
                    GUI:SetColumnWidth(3, 80)
                end
                curP = curConfig.p
            end
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('  ' .. curConfig.time)
            GUI:NextColumn()
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(curConfig.nameCn)
            GUI:NextColumn()
            if jobValue[1] ~= nil then
                curConfig.Target = GUI:Checkbox(jobValue[1] .. "##" .. key2[i], curConfig.Target)
                GUI:NextColumn()
            end
            if jobValue[2] ~= nil then
                curConfig.Field = GUI:Checkbox(jobValue[2] .. "##" .. key2[i], curConfig.Field)
                GUI:NextColumn()
            end
        end
    end
    GUI:SetWindowSize(wide, 0)
    if M.SaveConfigJob(getFilePath(), 'Config.lua', M.Config.DmuDpsCfg, M.Config.DmuDpsCfgPrevious) then
        M.Config.DmuDpsCfgPrevious = table.deepcopy(M.Config.DmuDpsCfg)
    end
    GUI:End()
end
return DmuDpsUI