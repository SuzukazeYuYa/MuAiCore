local AsyncHttp = {}

local function psLiteral(value)
    return "'" .. value:gsub("'", "''") .. "'"
end

-- -EncodedCommand avoids cmd.exe expansion of %, &, quotes and non-ASCII
-- paths. PowerShell expects UTF-16LE; the host supplies UTF-8 Lua strings.
local function encodeCommand(value)
    local bytes, index = {}, 1
    local function appendUnit(unit)
        bytes[#bytes + 1] = unit % 256
        bytes[#bytes + 1] = math.floor(unit / 256)
    end
    while index <= #value do
        local point, width = value:byte(index), 1
        if point >= 240 then point, width = point - 240, 4
        elseif point >= 224 then point, width = point - 224, 3
        elseif point >= 192 then point, width = point - 192, 2
        elseif point >= 128 then error('invalid UTF-8 command') end
        for offset = 1, width - 1 do
            local continuation = value:byte(index + offset)
            assert(continuation and continuation >= 128 and continuation < 192, 'invalid UTF-8 command')
            point = point * 64 + continuation - 128
        end
        if point >= 65536 then
            point = point - 65536
            appendUnit(55296 + math.floor(point / 1024))
            appendUnit(56320 + point % 1024)
        else
            appendUnit(point)
        end
        index = index + width
    end
    local alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    local result = {}
    local function digit(n) return alphabet:sub(n + 1, n + 1) end
    for i = 1, #bytes, 3 do
        local packed = bytes[i] * 65536 + (bytes[i + 1] or 0) * 256 + (bytes[i + 2] or 0)
        result[#result + 1] = digit(math.floor(packed / 262144))
                .. digit(math.floor(packed / 4096) % 64)
                .. (bytes[i + 1] and digit(math.floor(packed / 64) % 64) or '=')
                .. (bytes[i + 2] and digit(packed % 64) or '=')
    end
    return table.concat(result)
end

local function readLimited(path, limit)
    local file, err = io.open(path, 'rb')
    if file == nil then return nil, err end
    local content = file:read(limit + 1)
    file:close()
    if content == nil or #content == 0 then return nil, 'empty response' end
    if #content > limit then return nil, 'response exceeds size limit' end
    return content
end

-- Only the launcher is waited on. curl runs in a hidden worker; no network read
-- or subprocess wait is performed by the game update while it is in flight.
AsyncHttp.init = function(M)
    local pending = {}
    local sequence = 0
    local lastPollAt
    local pollInterval, timeout = 250, 15000
    local worker = MuAiGuideRoot .. 'MuAiGuideSubs\\HttpRequest.ps1'

    local function cleanup(request)
        if request.base == nil then return end
        for _, suffix in ipairs({ '.body', '.done', '.done.tmp', '.pending' }) do
            local path = request.base .. suffix
            if FileExists(path) and FileDelete(path) ~= true then
                M.LogOnce('HTTP', 'cleanup_' .. request.key,
                        '后台请求临时文件清理失败，稍后由过期清理回收', { file = path })
            end
        end
    end

    local function start(request)
        local root = GetStartupPath() .. '\\MuAiCoreHttp'
        if not FolderExists(root) and FolderCreate(root) ~= true then
            return false, 'cannot create HTTP work directory'
        end
        repeat
            sequence = sequence + 1
            request.base = root .. '\\request_' .. tostring(os.time()) .. '_'
                    .. tostring(math.floor(Now())) .. '_' .. tostring(sequence)
        until not FileExists(request.base .. '.pending')
                and not FileExists(request.base .. '.done')
                and not FileExists(request.base .. '.body')
        if FileWrite(request.base .. '.pending', '', false) ~= true then
            return false, 'cannot reserve HTTP response file'
        end
        local workerCommand = '& ' .. psLiteral(worker) .. ' -Uri ' .. psLiteral(request.requestUrl)
                .. ' -OutputBase ' .. psLiteral(request.base)
        -- Start-Process breaks the inherited pipe chain; cmd start does not
        -- reliably detach a child from Lua's CRT popen handle on Windows.
        local command = 'powershell.exe -NoProfile -NonInteractive -WindowStyle Hidden -Command "'
                .. "$ErrorActionPreference='Stop'; Start-Process -WindowStyle Hidden -FilePath powershell.exe"
                .. " -ArgumentList '-NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -EncodedCommand "
                .. encodeCommand(workerCommand) .. "'; Write-Output '__MUAI_HTTP_STARTED__'\""
        local handle = io.popen(command)
        if handle == nil then return false, 'cannot start HTTP worker' end
        -- Read the launch acknowledgement only. The detached child can inherit
        -- another copy of the CRT pipe handle; waiting for EOF waits for curl.
        local output = handle:read('*l')
        handle:close()
        if type(output) ~= 'string' or not output:find('__MUAI_HTTP_STARTED__', 1, true) then
            return false, 'HTTP worker launcher failed'
        end
        request.startedAt = Now()
        return true
    end

    M.WebRequestAsync = function(key, url, callback)
        if type(key) ~= 'string' or type(callback) ~= 'function'
                or type(url) ~= 'string' or not url:match('^https://[%w%._~:/%-%?=]+$') then
            return false, 'invalid HTTP request'
        end
        local current = pending[key]
        if current ~= nil then
            if current.url ~= url then return false, 'request key already uses another URL' end
            -- The same resource needs only one worker. Its latest owner receives
            -- the result (e.g. switching away from a branch and back again).
            current.callback = callback
            return true
        end
        local separator = url:find('?', 1, true) and '&' or '?'
        pending[key] = { key = key, url = url, callback = callback,
                requestUrl = url .. separator .. 't=' .. tostring(os.time()) }
        return true
    end

    M.PollWebRequests = function()
        if next(pending) == nil then return end
        if lastPollAt ~= nil and TimeSince(lastPollAt) < pollInterval then return end
        lastPollAt = Now()
        local finished = {}
        for key, request in pairs(pending) do
            -- Isolate host/filesystem failures to this read-only request.
            local ok, complete, body, err = pcall(function()
                if request.startedAt == nil then
                    local started, launchError = start(request)
                    return not started, nil, launchError
                end
                if FileExists(request.base .. '.done') then
                    local status, statusError = readLimited(request.base .. '.done', 1024)
                    if status ~= 'OK' then return true, nil, statusError or status end
                    local response, readError = readLimited(request.base .. '.body', 65536)
                    return true, response, readError
                end
                if TimeSince(request.startedAt) >= timeout then
                    return true, nil, 'HTTP worker timed out'
                end
                return false
            end)
            if not ok then complete, body, err = true, nil, tostring(complete) end
            if complete then
                pending[key] = nil
                finished[#finished + 1] = { request = request, body = body, err = err }
            end
        end
        for _, result in ipairs(finished) do
            local ok, err = pcall(cleanup, result.request)
            if not ok then
                M.LogOnce('HTTP', 'cleanup_' .. result.request.key,
                        '后台请求临时文件清理异常', { error = tostring(err) })
            end
            -- Callback errors are recorded without losing other completed requests.
            M.DiagnosticCall('HTTP', '处理后台请求结果', function()
                result.request.callback(result.body, result.err)
            end, { request = result.request.key })
        end
    end
end

return AsyncHttp
