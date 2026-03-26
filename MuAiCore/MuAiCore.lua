local MuAiCore = {}
local AddonName = "MuAiCore"
local core = MuAiCore
local autoPopMap = { 1238, 1122, 1325, 1327, 1317 }
local mainDrawer, fruConfigDrawer, fruMitigationDrawer, messageBoxDrawer
local lastMap, lastJob, updateTime
local updateNeedReLoad = false
local downloadPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\"
local raidScript = {}
local currentScript
local register = {}
local registerOK = false
local infoTime = function()
    return string.format("%.3f", TensorReactions_CurrentCombatTimer)
end

--- 开始读条事件
local OnEntityChannel = function(entityID, spellID, targetID, channelTimeMax)
    if currentScript ~= nil and currentScript.OnEntityChannel ~= nil then
        currentScript.OnEntityChannel(entityID, spellID, targetID, channelTimeMax)
    end
    if MuAiGuide then
        local ent = TensorCore.mGetEntity(entityID)
        if ent == nil or ent.type == 1 then
            return
        end
        if MuAiGuide.Develop.ShowSkillId then
            AnyoneCore.addTimedWorldTextOnEnt(
                    MuAiGuide.Develop.ShowTime * 1000,
                    'Spell:' .. tostring(spellID),
                    entityID,
                    GUI:ColorConvertFloat4ToU32(1, 1, 1, 1),
                    true,
                    3,
                    4
            )
        end
        if MuAiGuide.Develop.PrintChannelInfo then
            MuAiGuide.Info('[' .. infoTime()
                    .. ']开始读条，实体名称：' .. ent.name .. ', 技能ID：' .. spellID .. "，判定时间：" .. channelTimeMax)
        end
    end
end

--- 添加标记时间事件
local OnMarkerAdd = function(entityID, markerID)
    if currentScript ~= nil and currentScript.OnMarkerAdd ~= nil then
        currentScript.OnMarkerAdd(entityID, markerID)
    end
    if MuAiGuide then
        local ent = TensorCore.mGetEntity(entityID)
        if ent == nil then
            return
        end
        if MuAiGuide.Develop.ShowMarkId then
            AnyoneCore.addTimedWorldTextOnEnt(
                    MuAiGuide.Develop.ShowTime * 1000,
                    'Mark:' .. tostring(markerID),
                    entityID,
                    GUI:ColorConvertFloat4ToU32(1, 1, 1, 1),
                    true,
                    3,
                    2
            )
        end
        if MuAiGuide.Develop.PrintMarkId then
            MuAiGuide.Info('[' .. infoTime()
                    .. ']添加标记，实体名称：' .. ent.name .. ', 标记ID：' .. markerID .. "。")
        end
    end
end

--- 注册AOE生成
local OnAOECreate = function(aoeInfo)
    if currentScript ~= nil and currentScript.OnAOECreate ~= nil then
        currentScript.OnAOECreate(aoeInfo)
    end
    if MuAiGuide then
        if MuAiGuide.Develop.CacheAoeInfo then
            if MuAiGuide.Develop.AoeInfo[aoeInfo.aoeID] == nil then
                MuAiGuide.Develop.AoeInfo[aoeInfo.aoeID] = {}
            end
            table.insert(MuAiGuide.Develop.AoeInfo[aoeInfo.aoeID], aoeInfo)
        end
        if MuAiGuide.Develop.PrintAoeInfo then
            MuAiGuide.Info('[' .. infoTime()
                    .. ']AOE生成，名称：' .. aoeInfo.aoeName
                    .. ', ID：' .. aoeInfo.aoeID
                    .. "，类型：" .. aoeInfo.aoeCastType
                    .. "，朝向：" .. aoeInfo.heading
            )
        end
    end
end

--- 注册OnEventObjectScriptFunc
local OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    if currentScript ~= nil and currentScript.OnEventObjectScriptFunc ~= nil then
        currentScript.OnEventObjectScriptFunc(entityID, a1, a2, a3)
    end
end

local OnMapEffect = function(a1, a2, a3)
    if currentScript ~= nil and currentScript.OnMapEffect ~= nil then
        currentScript.OnMapEffect(a1, a2, a3)
    end
    if MuAiGuide and MuAiGuide.Develop.PrintAoeInfo then
        MuAiGuide.Info('[' .. infoTime()
                .. ']OnMapEffect: |' .. a1 .. '|' .. a2 .. '|' .. a3 .. '|。')
    end
end

local OnAddEntityVFX = function(vfxID, vfxName, primaryEntityID, secondaryEntityID, time, a5, a6)
    if currentScript ~= nil and currentScript.OnAddEntityVFX ~= nil then
        currentScript.OnAddEntityVFX(vfxID, vfxName, primaryEntityID, secondaryEntityID, time, a5, a6)
    end
    if MuAiGuide and MuAiGuide.Develop.PrintVFXInfo then
        local ent = TensorCore.mGetEntity(primaryEntityID)
        if MuAiGuide.Develop.VFXFilter then
            if vfxID > MuAiGuide.Develop.VFXFilterMax or vfxID < MuAiGuide.Develop.VFXFilterMin then
                return
            end
            if ent.type == 1 and MuAiGuide.Develop.VFXFilterNoPlayer then
                return
            end
        end
        MuAiGuide.Info('[' .. infoTime()
                .. ']' .. ent.name .. 'AddVFX，vfxID：' .. vfxID .. '，vfxName：' .. vfxName
                .. '，Other：|' .. primaryEntityID
                .. '|' .. secondaryEntityID
                .. '|' .. time
                .. '|' .. a5
                .. '|' .. a6 .. '|'
        )
    end
end

--- 安全注册阿古斯（防止加载失败导致报错）
local registerArgus = function()
    if Argus == nil then
        register = nil
        return
    else
        register = {}
    end
    if Argus.registerOnEntityChannel ~= nil and not register["OnEntityChannel"] then
        Argus.registerOnEntityChannel(OnEntityChannel)
        register["OnEntityChannel"] = true
    else
        register["OnEntityChannel"] = false
    end
    if Argus.registerOnMarkerAdd ~= nil and not register["OnMarkerAdd"] then
        Argus.registerOnMarkerAdd(OnMarkerAdd)
        register["OnMarkerAdd"] = true
    else
        register["OnMarkerAdd"] = false
    end
    if Argus.registerOnAOECreateFunc ~= nil and not register["OnAOECreate"] then
        Argus.registerOnAOECreateFunc(OnAOECreate)
        register["OnAOECreate"] = true
    else
        register["OnAOECreate"] = false
    end
    if Argus.registerOnEventObjectScriptFunc ~= nil and not register["OnEventObjectScriptFunc"] then
        Argus.registerOnEventObjectScriptFunc(OnEventObjectScriptFunc)
        register["OnEventObjectScriptFunc"] = true
    else
        register["OnEventObjectScriptFunc"] = false
    end
    if Argus.registerOnMapEffect ~= nil and not register["OnMapEffect"] then
        Argus.registerOnMapEffect(OnMapEffect)
        register["OnMapEffect"] = true
    else
        register["OnMapEffect"] = false
    end
    if Argus.registerOnAddEntityVFXFunc ~= nil and not register["OnAddEntityVFX"] then
        Argus.registerOnAddEntityVFXFunc(OnAddEntityVFX)
        register["OnAddEntityVFX"] = true
    else
        register["OnAddEntityVFX"] = false
    end
end

local checkArgusRegister = function()
    if registerOK then
        return
    end
    if register == nil then
        registerArgus()
        return
    end
    local hasNotRegister = false
    for _, state in pairs(register) do
        if not state then
            hasNotRegister = true
            break
        end
    end
    if hasNotRegister then
        registerArgus()
    else
        registerOK = true
        MuAiGuide.Debug("所有事件函数注册完成")
    end
end

--- 读取副本脚本
local LoadScripts = function()
    raidScript = {}
    local folderPath = MuAiGuideRoot .. "Scripts"
    local list = FolderList(folderPath)
    for _, fileName in pairs(list) do
        MuAiGuide.Debug("已加载副本脚本：" .. fileName)
        local filePath = folderPath .. "\\" .. fileName
        local script = FileLoad(filePath)
        if script ~= nil then
            raidScript[script.MapId] = script
        end
    end
    if currentScript ~= nil and raidScript[Player.localmapid] ~= nil then
        currentScript = raidScript[Player.localmapid]
    end
end

local isDrawBlackListOn = function()
    return MuAiGuide.Config.Main.DrawBlackListEnable
            and MuAiGuide.Config.Main.DrawBlackList
            and table.size(MuAiGuide.Config.Main.DrawBlackList) > 0
end

--- 绘图黑名单控制
local disableDrawCheck = function()
    if isDrawBlackListOn() then
        if lastMap ~= Player.localmapid then
            if table.contains(MuAiGuide.Config.Main.DrawBlackList, Player.localmapid) then
                MuAiGuide.Info("进入绘制黑名单区域，MoogleTelegraphs的[敌人范围]已关闭。")
                MoogleTelegraphs.Settings.DrawEnemyAoE = false
            elseif table.contains(MuAiGuide.Config.Main.DrawBlackList, lastMap) then
                MuAiGuide.Info("离开绘制黑名单区域，MoogleTelegraphs的[敌人范围]已开启。")
                MoogleTelegraphs.Settings.DrawEnemyAoE = true
            end
        end
    end
end

local attackRangeHackHelper = function()
    if Player == nil or Player.hitradius == nil or (not MuAiGuide.Config.Main.AttackRangeHelper) then
        return
    end
    local addRange = Player.hitradius - 0.5
    if math.abs(addRange) <= 0.001 then
        return
    end
    local curTarget = TensorCore.mGetTarget()
    if curTarget == nil or not curTarget.attackable then
        return
    end
    local curDistance = TensorCore.getDistance2d(Player.pos, curTarget.pos)
    local deltaDistance = curDistance - curTarget.hitradius + addRange
    local alpha, color, radius, maxRange
    if (not MuAiGuide.IsTank(Player.job)) and (not MuAiGuide.IsMelee(Player.job)) then
        maxRange = 25.5
    else
        maxRange = 3.5
    end
    radius = curTarget.hitradius - addRange + maxRange
    local minRange = maxRange - 1.5
    if deltaDistance >= maxRange then
        alpha = MuAiGuide.Config.Main.OutRangeColor.a
        color = MuAiGuide.Config.Main.OutRangeColor
    elseif deltaDistance >= minRange then
        local sub = deltaDistance - minRange
        if sub < 1 then
            alpha = MuAiGuide.Config.Main.InRangeColor.a * sub
        else
            alpha = MuAiGuide.Config.Main.InRangeColor.a
        end
        color = MuAiGuide.Config.Main.InRangeColor
    else
        return
    end
    local drawer = Argus2.ShapeDrawer:new(
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, alpha)),
            MuAiGuide.Config.Main.LineSize
    )
    drawer:addCircle(curTarget.pos.x, curTarget.pos.y, curTarget.pos.z, radius)
end

local attackRangeReMake = function()
    if not MuAiGuide.Config.Main.AttackRangeReplace
            or MoogleTelegraphs == nil or MoogleTelegraphs.Settings == nil
            or Player == nil
    then
        return
    end
    local curTarget = TensorCore.mGetTarget()
    if curTarget == nil or not curTarget.attackable or curTarget.type == 1 then
        return
    end
    MoogleTelegraphs.Settings.DrawAttackRange = false
    local curDistance = TensorCore.getDistance2d(Player.pos, curTarget.pos)
    local hitRange = curTarget.hitRadius
    local deltaDistance = curDistance - hitRange
    local alpha, color
    local radius
    local maxRange
    if (not MuAiGuide.IsTank(Player.job)) and (not MuAiGuide.IsMelee(Player.job)) then
        maxRange = 25.5
    else
        maxRange = 3.5
    end
    radius = hitRange + maxRange
    local minRange = maxRange - 1.5
    local inSideColor = MoogleTelegraphs.Settings.outlineRGB.rangeInside
    local outSideColor = MoogleTelegraphs.Settings.outlineRGB.rangeOutside
    if MoogleTelegraphs.Settings.AlwaysShowAttackRange then
        if deltaDistance >= maxRange then
            alpha = outSideColor.a
            color = outSideColor
        else
            alpha = inSideColor.a
            color = inSideColor
        end
    else
        if deltaDistance >= maxRange then
            alpha = outSideColor.a
            color = outSideColor
        elseif deltaDistance >= minRange then
            local sub = deltaDistance - minRange
            if sub < 1 then
                alpha = inSideColor.a * sub
            else
                alpha = inSideColor.a
            end
            color = inSideColor
        else
            return
        end
    end
    local drawer = Argus2.ShapeDrawer:new(
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, alpha)),
            MoogleTelegraphs.Settings.outlineThickness.range
    )
    drawer:addCircle(curTarget.pos.x, curTarget.pos.y, curTarget.pos.z, radius)
end

local onMapChange = function()
    MuAiGuide.Party = nil
    MuAiGuide.SelfPos = nil
    if table.contains(autoPopMap, Player.localmapid) then
        if MuAiGuide.UI.open == false then
            MuAiGuide.UI.open = true
        end
        MuAiGuide.LoadParty()
        if MuAiGuide.UI.tabs ~= nil then
            for i = 1, 6 do
                MuAiGuide.UI.tabs.tabs[i].isselected = i == 1
            end
        end
    else
        MuAiGuide.UI.open = false
    end

    if raidScript ~= nil and raidScript[Player.localmapid] ~= nil then
        -- 进入副本
        currentScript = raidScript[Player.localmapid]
        currentScript.OnEnter()
        MuAiGuide.Debug("进入副本：" .. currentScript.NameCN)
    elseif currentScript ~= nil then
        MuAiGuide.Debug("离开副本：" .. currentScript.NameCN)
        currentScript = nil
        MuAiGuide.CurRaidBoss = nil
    end

    if MoogleTelegraphs == nil or MoogleTelegraphs.Settings == nil then
        return
    end
    disableDrawCheck()
    if isDrawBlackListOn()
            and not table.contains(MuAiGuide.Config.Main.DrawBlackList, Player.localmapid)
            and MoogleTelegraphs and MoogleTelegraphs.Settings and MoogleTelegraphs.Settings.DrawEnemyAoE == false
    then
        MoogleTelegraphs.Settings.DrawEnemyAoE = true
        MuAiGuide.Info("当前已由MuAiGuide管理莫古力敌人范围开关，检测MoogleTelegraphs的[敌人范围]被关闭，已将其恢复到开启状态。")
    end
end

local checkNeedReload = function()
    if not updateNeedReLoad
            or updateTime == nil or updateTime == 0
            or TimeSince(updateTime) < 3000
    then
        return
    end
    if MuAiGuide.UI.open then
        MuAiGuide.UI.open = false
        MuAiGuide.FruConfigUI.open = false
        MuAiGuide.FruMitigationUI.open = false
    end
    if MuAiGuide.LatestVer ~= nil then
        MuAiGuide.VERSION = MuAiGuide.LatestVer
        MuAiGuide.Info("MuAiCore已更新，当前版本：ver." .. MuAiGuide.LatestVer)
    end
    Reload()
end

local onRaidUpdate = function()
    if raidScript and raidScript[Player.localmapid] then
        raidScript[Player.localmapid].Update()
        if currentScript == nil then
            currentScript = raidScript[Player.localmapid]
        end
    end
end

local onPlayerChangeJob = function()
    if MuAiGuide and MuAiGuide.Config and MuAiGuide.FruMitigation then
        MuAiGuide.FruMitigation.ChangeJob()
    end
end

local checkHotKeyPress = function()
    if MuAiGuide and MuAiGuide.Config
            and GUI:IsKeyDown(MuAiGuide.Config.Main.KeyBindFirst)
            and GUI:IsKeyPressed(MuAiGuide.Config.Main.KeyBindSecond)
    then
        MuAiGuide.UI.open = not MuAiGuide.UI.open
    end
end
local checkMuAiGuide = function()
    if MuAiGuide == nil then
        core.InitMuAiGuide()
    end
end

ReloadMuAiGuide = function()
    MuAiGuide = nil
    core.InitMuAiGuide()
end

ReloadMuAiScripts = function()
    LoadScripts()
end

RefreshMuAiUI = function()
    mainDrawer = FileLoad(MuAiGuideRoot .. "MainUI.lua")
    fruConfigDrawer = FileLoad(MuAiGuideRoot .. "FruConfigUI.lua")
    fruMitigationDrawer = FileLoad(MuAiGuideRoot .. "FruMitigationUI.lua")
    messageBoxDrawer = FileLoad(MuAiGuideRoot .. "MessageBoxUI.lua")
end

core.InitMuAiGuide = function(checkUpdate)
    MuAiGuideRoot = GetLuaModsPath() .. "MuAiCore\\LuaFiles\\"
    MuAiGuide = FileLoad(MuAiGuideRoot .. "MuAiGuide.lua")
    local configDef = FileLoad(MuAiGuideRoot .. "FruOneKeyConfigs.lua")
    configDef(MuAiGuide)
    local mitigationDef = FileLoad(MuAiGuideRoot .. "FruMitigation.lua")
    mitigationDef(MuAiGuide)
    MuAiGuide.InitConfig()
    MuAiGuide.FruMitigation.ChangeJob()
    MuAiGuide.ForceUpdate = function()
        core.ForceUpdate()
    end
    if FolderExists(downloadPath) then
        FolderDelete(downloadPath)
    end
    LoadScripts()
    registerArgus()
    if checkUpdate then
        MuAiGuide.checkVersion(true)
        if MuAiGuide.LatestVer ~= nil and MuAiGuide.Config.Main.AutoUpdate then
            if MuAiGuide.LatestVer > MuAiGuide.VERSION then
                core.ForceUpdate()
            end
        end
    end
end

core.DrawMainUI = function()
    if mainDrawer == nil or MuAiGuide.Develop.UIRefresh then
        mainDrawer = FileLoad(MuAiGuideRoot .. "MainUI.lua")
    end
    mainDrawer(MuAiGuide)
end

core.DrawFriConfigUI = function()
    if fruConfigDrawer == nil or MuAiGuide.Develop.UIRefresh then
        fruConfigDrawer = FileLoad(MuAiGuideRoot .. "FruConfigUI.lua")
    end
    fruConfigDrawer(MuAiGuide)
end

core.DrawFruMitigationUI = function()
    if fruMitigationDrawer == nil or MuAiGuide.Develop.UIRefresh then
        fruMitigationDrawer = FileLoad(MuAiGuideRoot .. "FruMitigationUI.lua")
    end
    fruMitigationDrawer(MuAiGuide)
end

core.DrawMessageBoxUI = function()
    if messageBoxDrawer == nil or MuAiGuide.Develop.UIRefresh then
        messageBoxDrawer = FileLoad(MuAiGuideRoot .. "MessageBoxUI.lua")
    end
    messageBoxDrawer(MuAiGuide)
end

core.Initialize = function()
    core.InitMuAiGuide(true)
    local Icon = GetLuaModsPath() .. "MuAiCore\\Image\\MainIcon.png"
    local tooltip = "暮霭指路核心功能"
    ml_gui.ui_mgr:AddMember({ id = "MuAiCore",
                              name = "MuAiGuide",
                              onClick = function()
                                  MuAiGuide.UI.open = not MuAiGuide.UI.open
                              end,
                              tooltip = tooltip, texture = Icon },
            "FFXIVMINION##MENU_HEADER"
    )
end
core.Update = function()
    checkMuAiGuide()
    checkArgusRegister()
    checkHotKeyPress()
    if Player.localmapid ~= 0 and lastMap ~= Player.localmapid then
        onMapChange()
        lastMap = Player.localmapid
    end
    if lastJob ~= Player.job then
        onPlayerChangeJob()
        lastJob = Player.job
    end
    onRaidUpdate()
    checkNeedReload()
    attackRangeHackHelper()
    attackRangeReMake()
    if MuAiGuide then
        MuAiGuide.DrawTargetPos()
        MuAiGuide.DrawAllLink()
    end
end

core.Draw = function()
    if MuAiGuide then
        if MuAiGuide.UI.open then
            core.DrawMainUI()
        end
        if MuAiGuide.FruConfigUI.open then
            core.DrawFriConfigUI()
        end
        if MuAiGuide.FruMitigationUI.open and not MuAiGuide.IsHealer(Player.job) then
            core.DrawFruMitigationUI()
        end
        if MuAiGuide.MsgUI.open then
            core.DrawMessageBoxUI()
        end
    end
end

core.ForceUpdate = function()
    local gitZipUrl = "https://codeload.github.com/SuzukazeYuYa/MuAiCore/zip/refs/heads/main"
    local tempPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\"
    local replacePath = GetStartupPath() .. "\\LuaMods"
    local zipFilePath = tempPath .. "repository.zip"
    local extractPath = tempPath .. "Extracted"
    if FileExists(replacePath .. "\\TensorReactions\\TimelineReactions\\Jackpot") then
        FileDelete(replacePath .. "\\TensorReactions\\TimelineReactions\\Jackpot")
    end
    if FileExists(replacePath .. "\\MuAiCore\\LuaFiles\\MitigationDefault") then
        FileDelete(replacePath .. "\\MuAiCore\\LuaFiles\\MitigationDefault")
    end
    -- 执行系统命令的函数
    local function runCommand(cmd)
        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()
        return result
    end

    -- 下载文件
    local function downloadFile(url, destination)
        d("[MuAiCore]正在下载文件...")
        local cmd = 'curl -L -o "' .. destination .. '" "' .. url .. '"'
        runCommand(cmd)
        d("[MuAiCore]文件下载完成: " .. destination)
    end
    updateTime = nil
    updateNeedReLoad = false
    -- 清理并创建临时目录
    FolderDelete(tempPath)
    FolderCreate(tempPath)

    -- 下载 Zip 文件
    downloadFile(gitZipUrl, zipFilePath)

    -- 检查下载是否成功
    if not io.open(zipFilePath) then
        d("[MuAiCore]下载失败，无法找到 Zip 文件。")
        return
    end

    -- 解压 Zip 文件
    runCommand('powershell -Command "Expand-Archive -Path \'' .. zipFilePath .. '\' -DestinationPath \'' .. extractPath .. '\'"')
    d("[MuAiCore]解压完成，开始替换更新文件...")
    local exPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\Extracted\\MuAiCore-main"
    local excludeFiles = {
        ".gitignore",
        "README.md"
    }
    -- 检查文件名是否需要排除
    function isExcluded(fileName)
        for _, excluded in ipairs(excludeFiles) do
            if fileName == excluded then
                return true
            end
        end
        return false
    end

    function copyFiles(srcFolder, destFolder)
        -- 列出源文件夹中的所有文件和子文件夹
        local filesInSrc = FolderList(srcFolder, [[.*]], true)
        -- 遍历文件列表
        for _, fileName in ipairs(filesInSrc) do
            -- 如果当前文件需要排除，则跳过
            if not isExcluded(fileName) then
                -- 获取源文件的完整路径
                local srcFile = srcFolder .. "\\" .. fileName
                local destFile = destFolder .. "\\" .. fileName
                -- 如果是文件夹
                if FolderExists(srcFile) then
                    -- 如果目标文件夹不存在，创建它
                    if not FolderExists(destFile) then
                        FolderCreate(destFile)
                    end
                    -- 递归复制该子文件夹中的内容
                    copyFiles(srcFile, destFile)  -- 递归调用
                    -- 如果是文件
                elseif FileExists(srcFile) then
                    -- 确保目标文件夹存在
                    local destFolderPath = string.match(destFile, "^(.*[\\/])")  -- 获取文件夹路径
                    if not FolderExists(destFolderPath) then
                        FolderCreate(destFolderPath)
                    end
                    -- 如果目标文件存在，比较文件内容
                    if FileExists(destFile) then
                        d("[MuAiCore]更新：" .. destFile)
                    else
                        d("[MuAiCore]新增：" .. destFile)
                    end
                    runCommand("copy /Y " .. srcFile .. " " .. destFile)
                end
            end
        end
    end
    copyFiles(exPath, replacePath)
    -- 清理临时目录
    updateTime = Now()
    updateNeedReLoad = true
end

RegisterEventHandler("Module.Initalize", core.Initialize, AddonName)
RegisterEventHandler("Gameloop.Update", core.Update, AddonName)
RegisterEventHandler("Gameloop.Draw", core.Draw, AddonName)
d("[MuAiCore]加载成功!")