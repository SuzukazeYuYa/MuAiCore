local NetWork = {}
--[[
===========================
    HTTP处理模块
===========================
]]
local updateTime
local updateNeedReLoad = false

-- 赞助列表来自远端，但格式只是受限的 Lua table；这里严格解析数据，禁止直接执行响应内容。
local function skipWhitespace(text, index)
    while index <= #text and text:sub(index, index):match("%s") do
        index = index + 1
    end
    return index
end

local function parseIdentifier(text, index)
    index = skipWhitespace(text, index)
    local startIndex, endIndex = text:find("[%a_][%w_]*", index)
    if startIndex ~= index then
        return nil, index
    end
    return text:sub(startIndex, endIndex), endIndex + 1
end

local function parseQuotedString(text, index)
    index = skipWhitespace(text, index)
    local quote = text:sub(index, index)
    if quote ~= "'" and quote ~= '"' then
        return nil, index, 'expected quoted string'
    end

    local result = {}
    index = index + 1
    while index <= #text do
        local char = text:sub(index, index)
        if char == quote then
            return table.concat(result), index + 1
        end
        if char == "\\" then
            local escaped = text:sub(index + 1, index + 1)
            local replacements = {
                n = "\n",
                r = "\r",
                t = "\t",
                ["\\"] = "\\",
                ["'"] = "'",
                ['"'] = '"',
            }
            if replacements[escaped] == nil then
                return nil, index, 'unsupported escape sequence'
            end
            result[#result + 1] = replacements[escaped]
            index = index + 2
        else
            if char:match("%c") then
                return nil, index, 'control character in string'
            end
            result[#result + 1] = char
            index = index + 1
        end
    end
    return nil, index, 'unterminated string'
end

local function expectChar(text, index, expected)
    index = skipWhitespace(text, index)
    if text:sub(index, index) ~= expected then
        return nil, 'expected ' .. expected
    end
    return index + 1
end

local function parseSponsorsList(text)
    if type(text) ~= 'string' or #text == 0 or #text > 65536 then
        return nil, 'invalid response size'
    end

    local index = skipWhitespace(text, 1)
    local keyword
    keyword, index = parseIdentifier(text, index)
    if keyword ~= 'return' then
        return nil, 'expected return'
    end

    local err
    index, err = expectChar(text, index, '{')
    if index == nil then
        return nil, err
    end

    local result = {}
    while true do
        index = skipWhitespace(text, index)
        if text:sub(index, index) == '}' then
            index = index + 1
            break
        end

        index, err = expectChar(text, index, '{')
        if index == nil then
            return nil, err
        end

        local idKey
        idKey, index = parseIdentifier(text, index)
        if idKey ~= 'id' then
            return nil, 'expected id field'
        end
        index, err = expectChar(text, index, '=')
        if index == nil then
            return nil, err
        end
        local id
        id, index, err = parseQuotedString(text, index)
        if id == nil then
            return nil, err
        end

        index, err = expectChar(text, index, ',')
        if index == nil then
            return nil, err
        end
        local iconKey
        iconKey, index = parseIdentifier(text, index)
        if iconKey ~= 'icon' then
            return nil, 'expected icon field'
        end
        index, err = expectChar(text, index, '=')
        if index == nil then
            return nil, err
        end
        local icon
        icon, index, err = parseQuotedString(text, index)
        if icon == nil then
            return nil, err
        end

        index = skipWhitespace(text, index)
        if text:sub(index, index) == ',' then
            index = index + 1
        end
        index, err = expectChar(text, index, '}')
        if index == nil then
            return nil, err
        end

        if id == '' or #id > 96 or id:find('%c')
                or icon == '' or #icon > 64
                or not icon:match('^[%w_%-]+$')
        then
            return nil, 'invalid sponsor fields'
        end
        result[#result + 1] = { id = id, icon = icon }
        if #result > 100 then
            return nil, 'too many sponsors'
        end

        index = skipWhitespace(text, index)
        if text:sub(index, index) == ',' then
            index = index + 1
        end
    end

    index = skipWhitespace(text, index)
    if index <= #text then
        return nil, 'unexpected trailing content'
    end
    if #result == 0 then
        return nil, 'empty sponsor list'
    end
    return result
end

local function powerShellLiteral(value)
    return "'" .. tostring(value):gsub("'", "''") .. "'"
end

local function startDetachedCommand(command)
    if type(command) ~= 'string' or command == '' then
        return false, 'invalid command'
    end
    if type(io) ~= 'table' or type(io.popen) ~= 'function' then
        return false, 'io.popen is unavailable'
    end

    local openOk, handle = pcall(io.popen, command)
    if not openOk then
        return false, tostring(handle)
    end
    if handle == nil then
        return false, 'failed to start command'
    end

    local closeOk, closeResult, closeReason, closeCode = pcall(function()
        return handle:close()
    end)
    if not closeOk then
        return false, tostring(closeResult)
    end
    if closeResult == nil then
        return false, tostring(closeReason or closeCode or 'command failed')
    end
    return true
end

---@param M MuAiGuide
NetWork.init = function(M)
    M.FinalSponsorList = nil
    M.LocalSponsorList = {
        { id = 'W', icon = 'W' },
        { id = 'Master Lee', icon = 'MasterLee' },
        { id = 'Jackpot', icon = 'Jackpot' },
        { id = '芝麻酷豆', icon = 'SesameCoolBean' },
        { id = '一箱老雪', icon = 'Snowbeer' },
        { id = '楪祈', icon = 'Inori' },
    }

    M.ThxList = {
        { id = 'kaze', icon = 'kaze' },
        { id = 'megaminx', icon = 'megaminx' },
        { id = 'ppu', icon = 'ppu' },
        { id = 'Shippo', icon = 'Shippo' },
        { id = 'String', icon = 'String' },
        { id = 'catZ', icon = 'catZ' },
        { id = 'Master Lee', icon = 'MasterLee' },
        { id = 'Jackpot', icon = 'Jackpot' },
        { id = 'Rikuduo', icon = 'Rikuduo' },
        { id = '倦', icon = 'juan' },
        { id = '蛙', icon = 'fog' },
        { id = 'SEA_AI', icon = 'SEA_AI' },
    }
    M.ShuffleListInPlace(M.LocalSponsorList)
    M.ShuffleListInPlace(M.ThxList)
    M.ParseSponsorsList = parseSponsorsList
    ---使用系统CMD请求网络数据
    ---@param url string 地址
    ---@return string 获取的值
    M.WebRequest = function(url)
        if type(url) ~= 'string'
                or not url:match('^https://[%w%._~:/%-%?=]+$')
        then
            return nil
        end
        local urlStr = url .. '?t=' .. os.time()
        local handle = io.popen('curl --fail --silent --show-error --connect-timeout 3 --max-time 5 "' .. urlStr .. '"')
        if handle == nil then
            return nil
        end
        local result = handle:read("*all")
        handle:close()
        if type(result) ~= 'string' or result == '' then
            return nil
        end
        return result
    end

    ---使用系统CMD检查版本
    ---@param isAuto boolean 是否为自动检查
    M.CheckVersion = function(isAuto)
        M.LatestVer = nil
        M.LogInfo = nil
        --local resp = M.WebRequest('https://gist.githubusercontent.com/SuzukazeYuYa/cb01eb35b958b57d7d962235262ea05d/raw/MuAiCoreChangeLog.txt')
        -- 改用腾讯云存储
        local resp = M.WebRequest('https://muai-guide-main-1435131442.cos.ap-shanghai.myqcloud.com/versionLog.txt')
        if resp ~= nil and resp ~= '' then
            local logsData = M.StringSplit(resp, "|")
            if logsData ~= nil and table.size(logsData) >= 0 then
                M.LatestVer = tonumber(logsData[1])
                local infoTable = { "版本检查完毕：",
                                    "Tab|当前版本：" .. M.VERSION,
                                    "Tab|最新版本：" .. tostring(M.LatestVer)
                }
                table.insert(infoTable, "")
                table.insert(infoTable, tostring(M.LatestVer) .. "版本更新内容：")
                for i = 2, #logsData do
                    table.insert(infoTable, ("Tab|" .. logsData[i]))
                end
                table.insert(infoTable, "")
                table.insert(infoTable, "是否立刻进行更新？")
                table.insert(infoTable, "如进行更新，过程中会短暂卡屏，请耐心等待。")
                M.LogInfo = infoTable
            end
        end
        if not isAuto then
            if M.LatestVer ~= nil then
                if M.LatestVer == M.VERSION then
                    M.ShowMsgUI(1,
                            { "版本检查完毕：没有发现新的版本！" },
                            nil,
                            function()
                                M.CloseAllUI()
                                M.ForceUpdate()
                            end,
                            '确认', '强制更新')
                else
                    M.ShowMsgUI(2, M.LogInfo)
                end
            else
                M.ShowMsgUI(3, { "版本检查失败，请检查网络或重新启动游戏后再次尝试。" })
            end
        end
    end

    M.GetSponsorsList = function()
        --local resp = M.WebRequest('https://gist.github.com/SuzukazeYuYa/e598918cc010089df3387e8246b9c0dd/raw/SponsorsList.txt')
        -- 改用腾讯云存储
        local resp = M.WebRequest('https://muai-guide-main-1435131442.cos.ap-shanghai.myqcloud.com/sponsorsList.txt')
        local parseError
        if resp ~= nil then
            M.FinalSponsorList, parseError = parseSponsorsList(resp)
        end
        if M.FinalSponsorList == nil then
            M.FinalSponsorList = M.LocalSponsorList
            if parseError ~= nil then
                M.LogError('Network', '远端赞助名单解析失败，已使用本地名单', { err = parseError }, true)
            end
        end
        M.ShuffleListInPlace(M.FinalSponsorList)
        --local iconUrl = "https://raw.githubusercontent.com/SuzukazeYuYa/MuAiCore/main/MuAiCore/Image/HeadIcons/"
        local iconUrl = "https://muai-guide-main-1435131442.cos.ap-shanghai.myqcloud.com/HeadIcons/"
        local scheduledDownloads = 0
        for _, spName in pairs(M.FinalSponsorList) do
            local iconPath = GetLuaModsPath() .. 'MuAiCore/Image/HeadIcons/' .. spName.icon .. '.png'
            iconPath = string.gsub(iconPath, "\\", "/")
            if not FileExists(iconPath) and scheduledDownloads < 4 then
                local url = iconUrl .. spName.icon .. '.png'
                local arguments = "@('--fail','--silent','--show-error','--location',"
                        .. "'--remove-on-error','--connect-timeout','2','--max-time','5','--output',"
                        .. powerShellLiteral(iconPath) .. ',' .. powerShellLiteral(url) .. ')'
                local cmd = 'powershell.exe -NoProfile -NonInteractive -Command "Start-Process '
                        .. "-WindowStyle Hidden -FilePath 'curl.exe' -ArgumentList " .. arguments .. '"'
                local started, startError = startDetachedCommand(cmd)
                if not started then
                    M.LogOnce('Network', 'sponsor-icon-download-unavailable',
                            '赞助头像下载未启动，已跳过缺失头像',
                            { icon = spName.icon, err = startError }, true)
                    break
                end
                scheduledDownloads = scheduledDownloads + 1
            end
        end
    end

    --- 检查更新是否需要重新加载
    M.CheckNeedReload = function()
        if not updateNeedReLoad
                or updateTime == nil or updateTime == 0
                or TimeSince(updateTime) < 3000
        then
            return
        end
        M.CloseAllUI()
        Reload()
    end

    ---强制更新所有脚本
    M.ForceUpdate = function()
        local gitZipUrl
        if M.Config.Main.DownLoadSource == 1 then
            gitZipUrl = "https://codeload.github.com/SuzukazeYuYa/MuAiCore/zip/refs/heads/main"
        elseif M.Config.Main.DownLoadSource == 2 then
            gitZipUrl = "https://muai-guide-main-1435131442.cos.ap-shanghai.myqcloud.com/MuAiCore-main.zip"
        end
        if gitZipUrl == nil then
            return
        end

        local systemTemp = os.getenv('TEMP') or os.getenv('TMP')
        if systemTemp == nil or systemTemp == '' then
            M.ShowMsgUI(3, { '更新失败：无法获取系统临时目录。' })
            return
        end

        local tempPath = systemTemp .. "\\MuAiCoreUpdater\\" .. tostring(os.time())
        local replacePath = GetStartupPath() .. "\\LuaMods"
        local zipFilePath = tempPath .. "\\repository.zip"
        local extractPath = tempPath .. "\\Extracted"
        local exPath = extractPath .. "\\MuAiCore-main"
        local installerPath = MuAiGuideRoot .. "MuAiGuideSubs\\InstallUpdate.ps1"
        local successToken = '__MUAI_COMMAND_OK__'

        -- Lua 5.1 的 io.popen 不能稳定提供退出码，用成功标记区分命令输出与执行结果。
        local function runCommand(cmd)
            local handle = io.popen(cmd .. ' 2>&1 && echo ' .. successToken)
            if handle == nil then
                return false, 'failed to start command'
            end
            local result = handle:read("*a")
            handle:close()
            local success = result:find(successToken, 1, true) ~= nil
            result = result:gsub(successToken, '')
            return success, result
        end

        local function downloadFile(url, destination)
            d("[MuAiCore]正在下载文件...")
            d('当前源' .. gitZipUrl)
            local cmd = 'curl.exe --fail --silent --show-error --location --connect-timeout 5 --max-time 90 --output "'
                    .. destination .. '" "' .. url .. '"'
            local ok, output = runCommand(cmd)
            if ok then
                d("[MuAiCore]文件下载完成: " .. destination)
            end
            return ok, output
        end

        local function fileSize(path)
            local file = io.open(path, 'rb')
            if file == nil then
                return nil
            end
            local size = file:seek('end')
            file:close()
            return size
        end

        local function failUpdate(message, detail)
            d('[MuAiCore]' .. message)
            if detail ~= nil and detail ~= '' then
                d(detail)
            end
            M.LogError('Update', message, { detail = detail }, true)
            FolderDelete(tempPath)
            M.ShowMsgUI(3, { message })
        end

        updateTime = nil
        updateNeedReLoad = false
        -- 每次更新使用独立临时目录，失败路径统一清理，不在 LuaMods 内留下半成品。
        FolderDelete(tempPath)
        FolderCreate(tempPath)

        -- 下载完成后先校验文件存在及合理大小，再进入解压阶段。
        local downloadOk, downloadOutput = downloadFile(gitZipUrl, zipFilePath)
        local zipSize = fileSize(zipFilePath)
        if not downloadOk or zipSize == nil or zipSize < 1024 or zipSize > 209715200 then
            failUpdate('更新失败：下载文件无效。', downloadOutput)
            return
        end

        -- Expand-Archive 同时承担 ZIP 完整性检查，解压失败不会触碰当前安装。
        FolderCreate(extractPath)
        local expandCommand = 'powershell.exe -NoProfile -NonInteractive -Command "try { Expand-Archive -LiteralPath '
                .. powerShellLiteral(zipFilePath) .. ' -DestinationPath ' .. powerShellLiteral(extractPath)
                .. ' -Force -ErrorAction Stop; exit 0 } catch { Write-Error $_; exit 1 }"'
        local expandOk, expandOutput = runCommand(expandCommand)
        if not expandOk then
            failUpdate('更新失败：ZIP 解压或完整性检查失败。', expandOutput)
            return
        end

        -- 只接受完整的 MuAiCore 发布目录，避免错误压缩包覆盖现有 runtime。
        if not FileExists(exPath .. "\\MuAiCore\\MuAiCore.lua")
                or not FileExists(exPath .. "\\MuAiCore\\module.def")
                or not FolderExists(exPath .. "\\TensorReactions")
                or not FileExists(installerPath)
        then
            failUpdate('更新失败：压缩包目录结构不完整。')
            return
        end

        d("[MuAiCore]解压和结构校验完成，开始替换更新文件...")
        -- 文件替换、备份和失败回滚由事务安装脚本一次完成。
        local installCommand = 'powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "'
                .. installerPath .. '" -SourceRoot "' .. exPath .. '" -TargetRoot "'
                .. replacePath .. '" -WorkRoot "' .. tempPath .. '"'
        local installOk, installOutput = runCommand(installCommand)
        if not installOk then
            failUpdate('更新失败：已回滚到更新前文件。', installOutput)
            return
        end

        -- 安装成功后再删除工作目录，并延迟到下一帧触发 Reload。
        FolderDelete(tempPath)
        d('[MuAiCore]更新文件替换完成。')
        updateTime = Now()
        updateNeedReLoad = true
    end
end

return NetWork
