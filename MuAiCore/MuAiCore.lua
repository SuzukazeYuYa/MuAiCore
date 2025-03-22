local MuAiCore = {}
local AddonName = "MuAiCore"
local core = MuAiCore
local autoPopMap = { 1238, 1122 }
local mainDrawer, fruConfigDrawer, fruMitigationDrawer
local lastMap, lastJob, updateTime
local updateNeedReLoad = false

core.InitMuAiGuide = function(checkUpdate)
    MuAiGuideRoot = GetLuaModsPath() .. "MuAiCore\\LuaFiles\\"
    MuAiGuide = FileLoad(MuAiGuideRoot .. "MuAiGuide.lua")
    local configDef = FileLoad(MuAiGuideRoot .. "FruOneKeyConfigs.lua")
    configDef(MuAiGuide)
    local mitigationDef = FileLoad(MuAiGuideRoot .. "FruMitigation.lua")
    mitigationDef(MuAiGuide)
    MuAiGuide.InitConfig()
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
    if GUI:IsKeyPressed(70) and GUI:IsKeyDown(17) then
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
    local localPath = GetLuaModsPath()
    local zipFilePath = tempPath .. "repository.zip"
    local extractPath = tempPath .. "Extracted"

    -- 执行系统命令的函数
    local function runCommand(cmd)
        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()
        return result
    end

    -- 创建目录
    local function createDirectory(path)
        runCommand('mkdir "' .. path .. '"')
    end

    -- 删除目录或文件
    local function deletePath(path)
        runCommand('rmdir /s /q "' .. path .. '"')
    end

    -- 下载文件
    local function downloadFile(url, destination)
        d("[MuAiCore]正在下载文件...")
        local cmd = 'curl -L -o "' .. destination .. '" "' .. url .. '"'
        local result = runCommand(cmd)

        -- 检查下载是否成功
        if not io.open(destination, "rb") then
            error("下载失败: " .. url)
        end
        d("[MuAiCore]文件下载完成: " .. destination)
    end

    -- 解压文件
    local function extractZip(zipPath, destination)
        d("[MuAiCore]正在解压文件...")
        runCommand('powershell -Command "Expand-Archive -Path \'' .. zipPath .. '\' -DestinationPath \'' .. destination .. '\'"')
    end

    -- 遍历目录并返回文件列表
    local function getFileList(path)
        local cmd = 'dir /b /s "' .. path .. '"'
        local output = runCommand(cmd)
        local files = {}
        for line in output:gmatch("[^\r\n]+") do
            table.insert(files, line)
        end
        return files
    end

    -- 复制文件
    local function copyFile(source, destination)
        local destinationDir = destination:match("^(.*)\\")
        runCommand('mkdir "' .. destinationDir .. '" 2>nul')
        runCommand('copy /y "' .. source .. '" "' .. destination .. '"')
    end

    local function getFirstLevelFolder(path)
        local cmd = 'dir /b /ad "' .. path .. '"'
        local output = runCommand(cmd)
        return output:match("[^\r\n]+") -- 获取第一行，即顶层文件夹名
    end

    local function getFileMD5(filePath)
        local cmd = 'certutil -hashfile "' .. filePath .. '" MD5'
        local output = runCommand(cmd)
        return output:match("([a-fA-F0-9]+)") -- 提取 MD5 值
    end

    -- 对比文件内容（MD5 对比）
    local function areFilesDifferent(file1, file2)
        local md5File1 = getFileMD5(file1)
        local md5File2 = getFileMD5(file2)
        if not md5File1 or not md5File2 then
            return true
        end
        return md5File1 ~= md5File2
    end

    updateTime = nil
    updateNeedReLoad = false
    -- 清理并创建临时目录
    deletePath(tempPath)
    createDirectory(tempPath)

    -- 下载 Zip 文件
    downloadFile(gitZipUrl, zipFilePath)

    -- 检查下载是否成功
    if not io.open(zipFilePath) then
        d("下载失败，无法找到 Zip 文件。")
        return
    end

    -- 解压 Zip 文件
    deletePath(extractPath)
    extractZip(zipFilePath, extractPath)

    -- 获取解压后的第一级文件夹
    local firstLevelFolder = getFirstLevelFolder(extractPath)
    if not firstLevelFolder then
        d("[MuAiCore]解压失败，未找到任何文件。")
        return
    end
    local extractedFilesPath = extractPath .. "\\" .. firstLevelFolder

    -- 获取解压后的文件列表
    local extractedFiles = getFileList(extractedFilesPath)
    if #extractedFiles == 0 then
        d("[MuAiCore]解压失败，未找到任何文件。")
        return
    end

    -- 遍历解压目录文件，与目标路径对比
    d("[MuAiCore]正在对比并复制文件...")
    for _, file in ipairs(extractedFiles) do
        local relativePath = file:sub(#extractedFilesPath + 2) -- 移除解压目录的顶层文件夹
        local targetFilePath = localPath .. relativePath
        -- 仅对解压后的文件进行对比和复制
        if not io.open(targetFilePath) or areFilesDifferent(file, targetFilePath) then
            d("[MuAiCore]更新文件: " .. targetFilePath)
            copyFile(file, targetFilePath)
        end
    end

    -- 清理临时目录
    deletePath(tempPath)
    --MuAiGuide.Info("已同步最新文件，请进行Reload操作<se.1>。")
    updateTime = Now()
    updateNeedReLoad = true
end

RegisterEventHandler("Module.Initalize", core.Initialize, AddonName)
RegisterEventHandler("Gameloop.Update", core.Update, AddonName)
RegisterEventHandler("Gameloop.Draw", core.Draw, AddonName)
d("[MuAiCore]加载成功!")