local MuAiCore = {}
local AddonName = "MuAiCore"
local core = MuAiCore
local autoPopMap = { 1238, 1122 }
local lastMap

core.Info = {
    Creator = "MuAi",
    Version = "0.0.0",
    StartDate = "20/03/2025",
    LastUpdate = "20/03/2025",
    ChangeLog = { }
}
core.Data = {}
local LuaPath = GetStartupPath() .. "\\LuaMods\\"
core.Override = {}
core.InitMuAiGuide = function()
    MuAiGuideRoot = GetStartupPath() .. "\\LuaMods\\MuAiCore\\LuaFiles\\"
    MuAiGuide = FileLoad(MuAiGuideRoot .. "MuAiGuide.lua")
    local configsLoader = FileLoad(MuAiGuideRoot .. "FruOneKeyConfigs.lua")
    configsLoader(MuAiGuide)
    MuAiGuide.ForceUpdate()
end
core.InitMuAiGuide()

local mainDrawer, fruConfigDrawer = nil, nil
core.DrawMainUI = function()
    if mainDrawer == nil or MuAiGuide.DevelopMode then
        local path = MuAiGuideRoot .. "MainUI.lua"
        mainDrawer = FileLoad(path)
    end
    mainDrawer(MuAiGuide)
end

core.DrawFriConfigUI = function()
    if fruConfigDrawer == nil or MuAiGuide.DevelopMode then
        local path = MuAiGuideRoot .. "FruConfigUI.lua"
        fruConfigDrawer = FileLoad(path)
    end
    fruConfigDrawer(MuAiGuide)
end

core.Initialize = function()
    local Icon = GetStartupPath() .. "\\LuaMods\\MuAiCore\\Image\\MainIcon.png"
    local tooltip = "暮霭指路核心功能"
    ml_gui.ui_mgr:AddMember({ id = "MuAiCore", name = "MuAiGuide", onClick = function()
        --- MuAiGuide.UI.open = not MuAiGuide.UI.open
        core.ForceUpdate()
    end, tooltip = tooltip, texture = Icon }, "FFXIVMINION##MENU_HEADER")
end

core.Update = function()
    if MuAiGuide == nil then
        core.InitMuAiGuide()
    end
    if GUI:IsKeyPressed(88) and GUI:IsKeyDown(17) then
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
        end
        lastMap = Player.localmapid
    end
end

core.Draw = function()
    if MuAiGuide and MuAiGuide.UI.open then
        core.DrawMainUI()
    end
    if MuAiGuide and MuAiGuide.FruConfigUI.open then
        core.DrawFriConfigUI()
    end
end

function core.Updater(k, v)
    if core.Data.UpdateTick == nil then
        if k == "reactions" and v == "check" then
            io.popen([[start /b powershell -Command "-Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11; $json = (Invoke-WebRequest -Uri https://api.github.com/repos/QwertOfficial/Healer-reactions/releases -UseBasicParsing | ConvertFrom-Json); Set-Content -Path ']] .. LuaPath .. [[\QwertCore\Data\RVersion.txt' -Value $json[0].tag_name; stop-process -Id $PID"]]):close()
            core.Data.UpdateTick = true
            core.Data.LastCheckVerR = Now()
            core.Data.CheckVerR = true
        end
        if k == "reactions" and v == "update" then
            io.popen([[start /b powershell -Command "Compress-Archive -Path ']] .. LuaPath .. [[TensorReactions\GeneralReactions', ']] .. LuaPath .. [[TensorReactions\TimelineReactions' -DestinationPath ]] .. LuaPath .. [[\TensorReactions\GeneralReactions\Qwert\TensorReactions_$((Get-Date).ToString('MM_dd_HHmm')).zip -Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11; $tag = (Invoke-WebRequest -Uri https://api.github.com/repos/QwertOfficial/Healer-reactions/releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name; Invoke-WebRequest https://github.com/QwertOfficial/Healer-reactions/releases/download/$tag/TensorReactions.zip -Out ']] .. LuaPath .. [[\TensorReactions\TensorReactions.zip'; Expand-Archive ']] .. LuaPath .. [[\TensorReactions\TensorReactions.zip' -DestinationPath ]] .. LuaPath .. [[ -Force; Remove-Item ']] .. LuaPath .. [[\TensorReactions\TensorReactions.zip' -Force; stop-process -Id $PID"]]):close()
            io.popen([[start /b powershell -Command "Set-Content -Path ']] .. LuaPath .. [[\QwertCore\Data\RStatus.txt' -Value 'Done'; stop-process -Id $PID"]]):close()
            core.Data.UpdateTick = true
            core.Data.UpdateVerR = true
        end
        if k == "core" and v == "check" then
            io.popen([[start /b powershell -Command "-Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11; $json = (Invoke-WebRequest -Uri https://api.github.com/repos/QwertOfficial/QwertCore/releases -UseBasicParsing | ConvertFrom-Json); Set-Content -Path ']] .. LuaPath .. [[\QwertCore\Data\CVersion.txt' -Value $json[0].tag_name; stop-process -Id $PID"]]):close()
            core.Data.UpdateTick = true
            core.Data.LastCheckVerC = Now()
            core.Data.CheckVerC = true
        end
        if k == "core" and v == "update" then
            io.popen([[start /b powershell -Command "-Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11; $tag = (Invoke-WebRequest -Uri https://api.github.com/repos/QwertOfficial/QwertCore/releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name; Invoke-WebRequest https://github.com/QwertOfficial/QwertCore/releases/download/$tag/QwertCore.zip -Out ']] .. LuaPath .. [[\QwertCore\QwertCore.zip'; Expand-Archive ']] .. LuaPath .. [[\QwertCore\QwertCore.zip' -DestinationPath ]] .. LuaPath .. [[ -Force; Remove-Item ']] .. LuaPath .. [[\QwertCore\QwertCore.zip' -Force; stop-process -Id $PID"]]):close()
            io.popen([[start /b powershell -Command "Set-Content -Path ']] .. LuaPath .. [[\QwertCore\Data\CStatus.txt' -Value 'Done'; stop-process -Id $PID"]]):close()
            core.Data.UpdateTick = true
            core.Data.UpdateVerC = true
        end
    end
end

local gitZipUrl = "https://codeload.github.com/SuzukazeYuYa/MuAiCore/zip/refs/heads/main"
local tempPath = GetStartupPath() .. "\\LuaMods\\MuAiCore\\Temp\\Download"
local localPath = GetStartupPath() .. "\\LuaMods\\MuAiCore"
local zipFilePath = tempPath .. "\\repository.zip"
local extractPath = tempPath .. "\\Extracted"

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
    d("正在下载文件...")
    runCommand('powershell -Command "Invoke-WebRequest -Uri \'' .. url .. '\' -OutFile \'' .. destination .. '\'"')
end

-- 解压文件
local function extractZip(zipPath, destination)
    d("正在解压文件...")
    runCommand('powershell -Command "Expand-Archive -Path \'' .. zipPath .. '\' -DestinationPath \'' .. destination .. '\'"')
end

-- 对比文件内容
local function areFilesDifferent(file1, file2)
    local cmd = 'fc /b "' .. file1 .. '" "' .. file2 .. '"'
    local result = runCommand(cmd)
    return not result:find("没有差异", 1, true) -- Windows "fc /b" 的输出包含“没有差异”表示文件相同
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

-- 主流程 
function core.ForceUpdate()
    -- 清理并创建临时目录
    deletePath(tempPath)
    createDirectory(tempPath)

    d("[MuAiCore]开下下载文件。")
    downloadFile(gitZipUrl, zipFilePath)

    d("[MuAiCore]开始解压文件。")
    deletePath(extractPath)
    extractZip(zipFilePath, extractPath)

    -- 获取解压后的文件路径
    local extractedFilesPath = getFileList(extractPath)[1]
    if not extractedFilesPath then
        d("[MuAiCore]解压后的文件目录不存在，任务终止。")
        return
    end

    -- 遍历解压目录文件，与目标路径对比
    MuAiGuide.Info("正在进行文件比对。")
    for _, file in ipairs(getFileList(extractedFilesPath)) do
        local relativePath = file:sub(#extractedFilesPath + 2) -- 获取相对路径
        local targetFilePath = localPath .. "\\" .. relativePath
        if not io.open(targetFilePath) or areFilesDifferent(file, targetFilePath) then
            d("[MuAiCore]复制文件: " .. relativePath)
            copyFile(file, targetFilePath)
        end
    end

    -- 清理临时目录
    deletePath(tempPath)
    MuAiGuide.Info("更新完成，请进行Reload操作<se.1>。")
    --core.InitMuAiGuide()
end

RegisterEventHandler("Module.Initalize", core.Initialize, AddonName)
RegisterEventHandler("Gameloop.Update", core.Update, AddonName)
RegisterEventHandler("Gameloop.Draw", core.Draw, AddonName)
d("[MuAiGuide] Loaded!")