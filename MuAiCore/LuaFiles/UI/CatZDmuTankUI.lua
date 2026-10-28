local CatZDmuTankUI = {}

local dropDrownList = { "自己减伤", "自己无敌", "搭档减伤", "搭档无敌", "分摊" }
local dropDrownListP3 = { "自己减伤", "自己无敌", "搭档减伤", "搭档无敌", "分摊", "换T先吃", "换T后吃" }
local wide = 380
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
    'LightOfJudgment1',
    'StatueDebuff2',
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
    'Shockwave2',
    'ThunderIII_T_4',
    'Shockwave3',
    'Blaze',
    'GrandCross1',
    'GrandCross2',
    'GrandCross3',
    'UltimaUpsideDown1',
    'UltimaUpsideDown2',
    'ConsecutiveUltima1',
    'Flood_P5',
    'MaddeningOrchestra1',
    'ConsecutiveUltima2',
    'MaddeningOrchestra2',
    'Forsaken1_P5',
    'Forsaken2_P5',
}

local jobMap = {
    --- TANK
    [19] = { "雪仇", "圣光幕帘" },
    [21] = { "雪仇", "摆脱" },
    [32] = { "雪仇", "暗黑布道" },
    [37] = { "雪仇", "光之心" },
}

-- Config.lua predates these two team-mitigation rows. Keep the migration local
-- to this UI and fill only fields that are absent from the active config.
local teamMitigationDefaults = {
    StatueDebuff2 = {
        p = 1,
        team = true,
        Target = false,
        Field = false,
        nameCn = '传毒/踩泥',
        time = 118.1,
    },
    Flood_P5 = {
        p = 5,
        team = true,
        Target = false,
        Field = false,
        nameCn = '洪水/地水',
        time = 990.3,
    },
}

local ensureTeamMitigationConfig = function(M, config)
    if config == nil then
        config = M.CreateDmuMigCfg()
    end
    assert(type(config) == 'table', 'Dmu mitigation config must be a table')
    for key, defaultConfig in pairs(teamMitigationDefaults) do
        local currentConfig = config[key]
        if currentConfig == nil then
            currentConfig = {}
            config[key] = currentConfig
        else
            assert(type(currentConfig) == 'table', 'Dmu mitigation entry must be a table: ' .. key)
        end
        if currentConfig.p == nil then
            currentConfig.p = defaultConfig.p
        end
        if currentConfig.team == nil then
            currentConfig.team = defaultConfig.team
        end
        if currentConfig.Target == nil then
            currentConfig.Target = defaultConfig.Target
        end
        if currentConfig.Field == nil then
            currentConfig.Field = defaultConfig.Field
        end
        if currentConfig.nameCn == nil then
            currentConfig.nameCn = defaultConfig.nameCn
        end
        if currentConfig.time == nil then
            currentConfig.time = defaultConfig.time
        end
    end
    if Player.job == 19 then
        for _, key in ipairs(key2) do
            local row = config[key]
            assert(type(row) == 'table', 'Dmu mitigation entry must be a table: ' .. key)
            if row.Passage == nil then row.Passage = false end
        end
    end
    return config
end

-- Only PLD presets carry role/boss assignments. Legacy and other-job presets
-- keep their existing load behavior; metadata never replaces mitigation rows.
local normalizePaladinRole = function(role)
    if role == 'mt' then return 'mt' end
    if role == 'ot' or role == 'st' then return 'ot' end
end

local capturePaladinAssignment = function(M)
    if Player.job ~= 19 then return end
    if type(gACRSelectedProfiles) ~= 'table' or gACRSelectedProfiles[19] ~= 'RikuPLD3' then return end
    local role = normalizePaladinRole(ACR_RikuPLD3_TankStance)
    local boss = M.Config.DmuCfg.P3.ExDeathTank
    if role and (boss == 1 or boss == 2) then
        M.Config.DmuCatZCfg.PaladinAssignment = { role = role, ExDeathTank = boss }
    end
end

local loadPaladinAssignment = function(M)
    if Player.job ~= 19 then return end
    local assignment = M.Config.DmuCatZCfg.PaladinAssignment
    if type(assignment) ~= 'table' then return end
    local role = normalizePaladinRole(assignment.role)
    if assignment.ExDeathTank == 1 or assignment.ExDeathTank == 2 then
        M.Config.DmuCfg.P3.ExDeathTank = assignment.ExDeathTank
    end
    if type(gACRSelectedProfiles) == 'table' and gACRSelectedProfiles[19] == 'RikuPLD3'
            and role then
        ACR_RikuPLD3_TankStance = role
    end
end

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
        return
    end
    M.Config.DmuCatZCfg = ensureTeamMitigationConfig(M, M.Config.DmuCatZCfg)
    local isPaladin = Player.job == 19
    local windowWidth = isPaladin and 480 or wide
    local revealTeam = isPaladin and M.CatZDmuTankUI.revealTeam == true
    local fileList = M.Config.DmuMitigJobConfigs
    GUI:SetNextWindowPos(M.MainUI.uiPos.x, M.MainUI.uiPos.y)
    GUI:SetNextWindowSize(windowWidth, 0, GUI.SetCond_Appearing)
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
                        or not M.IsValidConfigName(NewFileName)
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
                if not havaSame and M.IsValidConfigName(newFileName) then
                    capturePaladinAssignment(M)
                    if M.SaveFileConfig(getFilePath(), newFileName, M.Config.DmuCatZCfg) then
                        M.Config.DmuMitigNewMode = false
                        if newFileName ~= fileList[fileListIndex] then
                            table.insert(fileList, newFileName)
                        end
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
                    d(fileName)
                    M.Config.DmuCatZCfg = M.LoadFileConfig(getFilePath(), fileName, defCfg)
                    M.Config.DmuCatZCfg = ensureTeamMitigationConfig(M, M.Config.DmuCatZCfg)
                    loadPaladinAssignment(M)
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
                    capturePaladinAssignment(M)
                    M.SaveFileConfig(getFilePath(), newFileName, M.Config.DmuCatZCfg)
                end
            end
        end
        ------------------------------------------------
        if isPaladin and normalizePaladinRole(ACR_RikuPLD3_TankStance) == 'ot' then
            GUI:TextColored(1, 0.8, 0, 1, '枪刃搭档需另排 P1 无敌, P3 仍为 1/4.')
        end
        if revealTeam then GUI:SetNextTreeNodeOpened(false, GUI.SetCond_Always) end
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
        if revealTeam then
            GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Always)
            M.CatZDmuTankUI.revealTeam = nil
        end
        if GUI:CollapsingHeader('团减') then
            local curP = 0
            if isPaladin then
                GUI:Text('羽翼: ACR 自动覆盖最多队友, 单跳后取消.')
            end
            local columnCount = isPaladin and 5 or 4
            GUI:Columns(columnCount, 'TeamValue', false)
            GUI:SetColumnWidth(0, 68)
            GUI:SetColumnWidth(1, 100)
            GUI:SetColumnWidth(2, 80)
            GUI:SetColumnWidth(3, 100)
            if isPaladin then GUI:SetColumnWidth(4, 100) end
            for i = 1, #key2 do
                local curConfig = M.Config.DmuCatZCfg[key2[i]]
                if curP ~= curConfig.p then
                    GUI:Columns(1)
                    GUI:Separator()
                    GUI:BulletText('P' .. curConfig.p)
                    GUI:Separator()
                    curP = curConfig.p
                    GUI:Columns(columnCount)
                    GUI:SetColumnWidth(0, 68)
                    GUI:SetColumnWidth(1, 100)
                    GUI:SetColumnWidth(2, 80)
                    GUI:SetColumnWidth(3, 100)
                    if isPaladin then GUI:SetColumnWidth(4, 100) end
                end
                GUI:AlignFirstTextHeightToWidgets()
                -- GUI:Text('  [' .. curConfig.time .. ']')
                GUI:Text('  ' .. curConfig.time)
                GUI:NextColumn()
                GUI:AlignFirstTextHeightToWidgets()
                GUI:Text(curConfig.nameCn)
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
                if isPaladin then
                    curConfig.Passage = GUI:Checkbox('圣光羽翼##' .. key2[i], curConfig.Passage)
                    GUI:NextColumn()
                end
            end
        end
    end
    capturePaladinAssignment(M)
    if M.SaveConfigJob(getFilePath(), 'Config.lua', M.Config.DmuCatZCfg, M.Config.DmuCatZCfgPrevious) then
        M.Config.DmuCatZCfgPrevious = table.deepcopy(M.Config.DmuCatZCfg)
    end
    -- Preset loading and the P3 selector edit the shared guide config, which is
    -- stored separately. Keep failed saves dirty for the normal retry path.
    if M.Config.DmuCfg.P3.ExDeathTank ~= M.Config.DmuCfgPrevious.P3.ExDeathTank then
        M.SaveConfig(M.Config.DmuGuidePath, M.Config.DmuGuideFile, 'DmuCfg')
    end
    GUI:SetWindowSize(windowWidth, 0)
    GUI:End()
end
return CatZDmuTankUI
