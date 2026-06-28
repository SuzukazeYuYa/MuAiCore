local CatZDmuTankUI = {}

local dropDrownList = { "自己减伤", "自己无敌", "搭档减伤", "搭档无敌", "分摊" }
local dropDrownListP3 = { "自己减伤", "自己无敌", "搭档减伤", "搭档无敌", "分摊", "换T先吃", "换T后吃" }
local wide = 350
local keys = {
    -- P1,
    'RevoltingRuinIII_1',
    'LightingJudgment_1',
    'RevoltingRuinIII_2',
    'LightingJudgment_2',
    -- P2,
    'UltimateEmbrace_1',
    'WingOfDestruction',
    'UltimateEmbrace_2',
    -- P3,
    'ThunderIII_1',
    'ThunderIII_2',
    'ThunderIII_3',
    'ThunderIII_4',
    'ThunderIII_5',
    --'ThunderIII_6',
    --'ThunderIII_7',
    --'ThunderIII_8',
    --'ThunderIII_9',
    --'ThunderIII_10',
    -- P4
    -- P5
    'ChaoticFlare_1',
    'ChaoticFlare_2',
}

local key2 = {
    'Flaflare1',
    'Hyperdrive1',
    'LightOfJudgment',
    'Flaflare2',
    'TwinArms',
    'Forsaken1',
    'LightOfJudgment2',
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
    --- TANK
    [19] = { "雪仇", "幕帘" },
    [21] = { "雪仇", "摆脱" },
    [32] = { "雪仇", "步道" },
    [37] = { "雪仇", "光心" },
}

local newFileName = ""
local fileListIndex = 1
local getFilePath = function()
    return MuAiGuide.Config.DmuMitig .. '\\' .. Player.job
end

CatZDmuTankUI.draw = function()
    local M = MuAiGuide
    if not M.CatZDmuTankUI.open then
        return
    end
    if not M.IsTank(Player.job) then
        M.CatZDmuTankUI.open = false
        newCfgMode = false
        return
    end
    local fileList = M.Config.DmuMitigJobConfigs
    local newCfgMode = M.Config.DmuMitigNewMode
    GUI:SetNextWindowPos(M.MainUI.uiPos.x, M.MainUI.uiPos.y)
    GUI:SetNextWindowSize(wide, 0, GUI.SetCond_Appearing)
    M.CatZDmuTankUI.visible, M.CatZDmuTankUI.open = GUI:Begin("CatZ Dmu Mitigation Setting", M.CatZDmuTankUI.open)
    if M.CatZDmuTankUI.visible then
        GUI:TextColored(1, 1, 0, 1, '本插件仅为CatZ的时间轴提供减伤控制UI,')
        GUI:TextColored(1, 1, 0, 1, '如果需要对应的时间轴自行寻找CatZ的开源')
        GUI:TextColored(1, 1, 0, 1, '链接, 本插件不提供该时间轴文件.')
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
                    M.SaveFileConfig(getFilePath(), newFileName, M.Config.DmuCatZCfg)
                    newCfgMode = false
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
                newCfgMode = false
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
                    newCfgMode = true
                end
            else
                GUI:Dummy(20, 0)
                GUI:SameLine(0, 0)
                GUI:Button("加载此配置", 90, 20)
                if GUI:IsItemClicked(0) then
                    local fileName = fileList[fileListIndex]
                    local defCfg = M.CreateDmuMigCfg()
                    d(fileName)
                    M.Config.DmuCatZCfg = M.LoadFileConfig(getFilePath(), fileName, defCfg)
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
                    M.SaveFileConfig(getFilePath(), newFileName, M.Config.DmuCatZCfg)
                end
            end
        end

        GUI:Separator()
        ------------------------------------------------
        if GUI:CollapsingHeader('死刑') then
            local curP = 0
            GUI:Columns(2, 'CNName and Value', false)
            local p3Pull = false
            for i = 1, #keys do
                local curConfig = M.Config.DmuCatZCfg[keys[i]]
                if curP ~= curConfig.p then
                    GUI:Columns(1)
                    GUI:Separator()
                    GUI:BulletText('P' .. curConfig.p)
                    GUI:Separator()
                    GUI:Columns(2)
                    curP = curConfig.p
                end
                local itemList
                if curP == 3 then
                    itemList = dropDrownListP3
                    if not p3Pull then
                        p3Pull = true
                        GUI:AlignFirstTextHeightToWidgets()
                        GUI:Text('  谁拉艾克斯迪斯')
                        GUI:NextColumn()
                        M.Config.DmuCfg.P3.ExDeathTank = GUI:Combo('##ExDeathTank', M.Config.DmuCfg.P3.ExDeathTank, { 'ST', 'MT' }, 2)
                        GUI:NextColumn()
                    end
                else
                    itemList = dropDrownList
                end
                GUI:AlignFirstTextHeightToWidgets()
                GUI:Text('  ' .. curConfig.nameCn)
                GUI:NextColumn()
                curConfig.value = GUI:Combo("##" .. keys[i], curConfig.value, itemList, #itemList)
                GUI:NextColumn()
            end
        end
        GUI:Columns(1)
        if GUI:CollapsingHeader('团减') then
            local curP = 0
            GUI:Columns(3, 'TeamValue', false)
            for i = 1, #key2 do
                local curConfig = M.Config.DmuCatZCfg[key2[i]]
                if curP ~= curConfig.p then
                    GUI:Columns(1)
                    GUI:Separator()
                    GUI:BulletText('P' .. curConfig.p)
                    GUI:Separator()
                    GUI:Columns(3)
                    curP = curConfig.p
                end
                GUI:AlignFirstTextHeightToWidgets()
                GUI:Text('  ' .. curConfig.nameCn)
                GUI:NextColumn()
                local jobValue = jobMap[Player.job]
                if jobValue[1] ~= nil then
                    curConfig.Target = GUI:Checkbox(jobValue[1] .. "##" .. key2[i], curConfig.Target)
                else
                    GUI:Dummy()
                end
                GUI:NextColumn()
                if jobValue[2] ~= nil then
                    curConfig.Field = GUI:Checkbox(jobValue[2] .. "##" .. key2[i], curConfig.Field)
                else
                    GUI:Dummy()
                end
                GUI:NextColumn()
            end
        end
    end
    if M.SaveConfigJob(getFilePath(), 'Config.lua', M.Config.DmuCatZCfg, M.Config.DmuCatZCfgPrevious) then
        M.Config.DmuCatZCfgPrevious = table.deepcopy(M.Config.DmuCatZCfg)
    end
    GUI:SetWindowSize(wide, 0)
    GUI:End()
end
return CatZDmuTankUI