-- 测试内容
local MuAiCore = {}
local AddonName = "MuAiCore"
local core = MuAiCore
local autoPopMap = { 1238, 1122, 1325, 1327 }
local mainDrawer, fruConfigDrawer, fruMitigationDrawer
local lastMap, lastJob, updateTime
local updateNeedReLoad = false
local lastVersion
local downloadPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\"

ReloadMuAiGuide = function()
    MuAiGuide = nil
    core.InitMuAiGuide()
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
    if checkUpdate and MuAiGuide.Config.Main.AutoUpdate then
        core.ForceUpdate()
    end
    if FolderExists(downloadPath) then
        FolderDelete(downloadPath)
    end
    MuAiGuide.checkVersion = function(auto)
        MuAiGuide.LatestVersion = nil
        local url = string.format("https://gist.githubusercontent.com/SuzukazeYuYa/3967e5bc841aa3b28cea219d7da6c74c/raw/MuAiCoreVerson.txt?nocache=%d", Now())
        local cmd = string.format('powershell -Command "(Invoke-WebRequest -Uri \'%s\' -UseBasicParsing).Content"', url)
        local result = io.popen(cmd):read("*a"):gsub("%s+$", "")
        if not auto then
            local verNumber = tonumber(result)
            if verNumber == MuAiGuide.VERSION then
                MuAiGuide.Info("版本检查完毕：没有发现新的版本<se.3>！")
            else
                MuAiGuide.Info("版本检查完毕：发现新的版本：ver." .. result .. "<se.1>!")
            end
        end
        MuAiGuide.LatestVersion = result
    end
    MuAiGuide.checkVersion(true)
end

core.DrawMainUI = function()
    if mainDrawer == nil or MuAiGuide.DevelopMode then
        mainDrawer = FileLoad(MuAiGuideRoot .. "MainUI.lua")
    end
    mainDrawer(MuAiGuide)
end

core.DrawFriConfigUI = function()
    if fruConfigDrawer == nil or MuAiGuide.DevelopMode then
        fruConfigDrawer = FileLoad(MuAiGuideRoot .. "FruConfigUI.lua")
    end
    fruConfigDrawer(MuAiGuide)
end

core.DrawFruMitigationUI = function()
    if fruMitigationDrawer == nil or MuAiGuide.DevelopMode then
        fruMitigationDrawer = FileLoad(MuAiGuideRoot .. "FruMitigationUI.lua")
    end
    fruMitigationDrawer(MuAiGuide)
end

core.Initialize = function()
    core.InitMuAiGuide(true)
    lastVersion = MuAiGuide.VERSION
    local Icon = GetLuaModsPath() .. "MuAiCore\\Image\\MainIcon.png"
    local tooltip = "暮霭指路核心功能"
    ml_gui.ui_mgr:AddMember({ id = "MuAiCore", name = "MuAiGuide", onClick = function()
        MuAiGuide.UI.open = not MuAiGuide.UI.open
    end, tooltip = tooltip, texture = Icon }, "FFXIVMINION##MENU_HEADER")
end

local isDrawBlackListOn = function()
    return MuAiGuide.Config.Main.DrawBlackListEnable
            and MuAiGuide.Config.Main.DrawBlackList
            and table.size(MuAiGuide.Config.Main.DrawBlackList) > 0
end

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

local onMapChange = function()
    MuAiGuide.Party = nil
    MuAiGuide.SelfPos = nil
    if table.contains(autoPopMap, Player.localmapid) then
        if MuAiGuide.UI.open == false then
            MuAiGuide.UI.open = true
        end
        MuAiGuide.LoadParty()
    else
        MuAiGuide.UI.open = false
    end
    lastMap = Player.localmapid
    if isDrawBlackListOn()
            and not table.contains(MuAiGuide.Config.Main.DrawBlackList, Player.localmapid)
            and MoogleTelegraphs.Settings.DrawEnemyAoE == false
    then
        MoogleTelegraphs.Settings.DrawEnemyAoE = true
        MuAiGuide.Info("当前已由MuAiGuide管理莫古力敌人范围开关，检测MoogleTelegraphs的[敌人范围]被关闭，已将其恢复到开启状态。")
    end
end

core.Update = function()
    if MuAiGuide == nil then
        core.InitMuAiGuide()
    end
    if MuAiGuide and MuAiGuide.Config and GUI:IsKeyDown(MuAiGuide.Config.Main.KeyBindFirst) and GUI:IsKeyPressed(MuAiGuide.Config.Main.KeyBindSecond) then
        MuAiGuide.UI.open = not MuAiGuide.UI.open
    end
    disableDrawCheck()
    if lastMap ~= Player.localmapid then
        onMapChange()
    end
    if lastJob ~= Player.job and MuAiGuide and MuAiGuide.Config and MuAiGuide.FruMitigation then
        MuAiGuide.FruMitigation.ChangeJob()
        lastJob = Player.job
    end
    if updateNeedReLoad and updateTime then
        if TimeSince(updateTime) > 2000 then
            updateNeedReLoad = false
            if MuAiGuide.UI.open then
                MuAiGuide.UI.open = false
                MuAiGuide.FruConfigUI.open = false
                MuAiGuide.FruMitigationUI.open = false
                mainDrawer = FileLoad(MuAiGuideRoot .. "MainUI.lua")
                fruConfigDrawer = FileLoad(MuAiGuideRoot .. "FruConfigUI.lua")
                fruMitigationDrawer = FileLoad(MuAiGuideRoot .. "FruMitigationUI.lua")

            end
            core.InitMuAiGuide()
            if lastVersion ~= MuAiGuide.VERSION then
                lastVersion = MuAiGuide.VERSION
                MuAiGuide.Info("MuAiCore已更新，当前版本：ver." .. MuAiGuide.VERSION)
            end
        end
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
    end
end

core.ForceUpdate = function()
    local gitZipUrl = "https://codeload.github.com/SuzukazeYuYa/MuAiCore/zip/refs/heads/main"
    local tempPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\"
    local replacePath = GetStartupPath() .. "\\LuaMods"
    --local replacePath = "D:\\LuaMods"
    local zipFilePath = tempPath .. "repository.zip"
    local extractPath = tempPath .. "Extracted"
    -- 擦屁股代码
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
        d("下载失败，无法找到 Zip 文件。")
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