local MuAiCore = {}
local AddonName = "MuAiCore"
local core = MuAiCore
local autoPopMap = { 1238, 1122 }
local mainDrawer, fruConfigDrawer, fruMitigationDrawer
local lastMap, lastJob, updateTime
local updateNeedReLoad = false
local lastVersion

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

core.Update = function()
    if MuAiGuide == nil then
        core.InitMuAiGuide()
    end
    if MuAiGuide and MuAiGuide.Config and GUI:IsKeyDown(MuAiGuide.Config.Main.KeyBindFirst) and GUI:IsKeyPressed(MuAiGuide.Config.Main.KeyBindSecond) then
        MuAiGuide.UI.open = not MuAiGuide.UI.open
    end
    if lastMap ~= Player.localmapid then
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
    end
    if lastJob ~= Player.job then
        if MuAiGuide and MuAiGuide.FruMitigation then
            MuAiGuide.FruMitigation.ChangeJob()
        end
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
                        -- 比较文件大小和内容
                        local srcFileSize = FileSize(srcFile)
                        local destFileSize = FileSize(destFile)
                        if srcFileSize ~= destFileSize then
                            runCommand("copy /Y " .. srcFile .. " " .. destFile)
                            d("[MuAiCore]更新：" .. destFile)
                        end
                    else
                        runCommand("copy /Y " .. srcFile .. " " .. destFile)
                        d("[MuAiCore]新增：" .. destFile)
                    end
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