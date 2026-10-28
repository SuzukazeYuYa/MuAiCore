local NetWork = {}
--[[
===========================
    HTTP处理模块
===========================
]]

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
    -- Sponsor icons are still fetched only when missing.
    local downloadSponsorIcons = function()
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

    M.GetSponsorsList = function()
        -- Startup/UI can use the bundled list before any remote request completes.
        M.FinalSponsorList = M.LocalSponsorList
        M.ShuffleListInPlace(M.FinalSponsorList)
        local function complete(resp, requestError)
            local sponsors, parseError
            if resp ~= nil then sponsors, parseError = parseSponsorsList(resp) end
            if sponsors ~= nil then
                M.FinalSponsorList = sponsors
                M.ShuffleListInPlace(M.FinalSponsorList)
            elseif requestError ~= nil or parseError ~= nil then
                M.LogError('Network', '远端赞助名单不可用，已使用本地名单',
                        { err = requestError or parseError }, true)
            end
            downloadSponsorIcons()
        end
        local accepted, err = M.WebRequestAsync('sponsors',
                'https://muai-guide-main-1435131442.cos.ap-shanghai.myqcloud.com/sponsorsList.txt', complete)
        if not accepted then complete(nil, err) end
    end

end

return NetWork
