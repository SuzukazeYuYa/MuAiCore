local LogSystem = {}
--[[
===================================
    日志系统
    开发: String
    修改: MuAi
===================================
]]

local DIAGNOSTIC_MAX_BYTES = 1024 * 1024
local DIAGNOSTIC_MAX_FILES = 20
local DIAGNOSTIC_MAX_LINE_BYTES = 16 * 1024
local DIAGNOSTIC_THROTTLE_SECONDS = 10
local COMBAT_LOG_MAX_BYTES = 1024 * 1024
local COMBAT_LOG_MAX_FILES = 1000

local onceLogData = {}
local logCache = {}
local logCacheBytes = 0
local logCacheTruncated = false
local curFileName
local sessionActive = false
local activeGuide

local diagnosticState = {
    bytes = 0,
    disabled = false,
    fileName = nil,
    filePath = nil,
    part = 1,
    sessionName = nil,
    throttles = {},
}

local logValue

local consoleWrite = function(msg)
    if type(d) == 'function' then
        d('[MuAiCore]' .. tostring(msg))
    end
end

local escapePattern = function(str)
    return tostring(str):gsub('(%W)', '%%%1')
end

local safeFileName = function(str)
    return tostring(str):gsub('[\\/:*?"<>|]', '_')
end

local getLogPath = function()
    return GetLuaModsPath() .. 'MuAiCore\\Log'
end

local getDiagnosticPath = function()
    return getLogPath() .. '\\Diagnostics'
end

local ensureFolder = function(path)
    if FolderExists(path) then
        return true
    end
    return FolderCreate(path) == true
end

local listFiles = function(path, matcher)
    if not FolderExists(path) then
        return {}
    end
    local listed = FolderList(path)
    if type(listed) ~= 'table' then
        return {}
    end
    local files = {}
    for _, name in pairs(listed) do
        if type(name) == 'string' and matcher(name) then
            table.insert(files, name)
        end
    end
    table.sort(files, function(left, right)
        local leftTime = left:match('(%d%d%d%d%d%d%d%d_%d%d%d%d%d%d)') or left
        local rightTime = right:match('(%d%d%d%d%d%d%d%d_%d%d%d%d%d%d)') or right
        if leftTime == rightTime then
            return left < right
        end
        return leftTime < rightTime
    end)
    return files
end

local trimFilesForNew = function(path, matcher, maxFiles)
    local files = listFiles(path, matcher)
    while #files >= maxFiles do
        local oldest = table.remove(files, 1)
        if type(FileDelete) ~= 'function' or FileDelete(path .. '\\' .. oldest) ~= true then
            consoleWrite('[WARN][LogSystem] 删除过期日志失败：' .. tostring(oldest))
            return false
        end
    end
    return true
end

local getRoleByEntityID = function(entityID)
    if activeGuide == nil or activeGuide.Party == nil then
        return nil
    end
    for job, member in pairs(activeGuide.Party) do
        if member ~= nil and member.id == entityID then
            return job
        end
    end
    return nil
end

local safeString = function(str)
    str = tostring(str):gsub('\r', '\\r'):gsub('\n', '\\n')
    if activeGuide ~= nil and activeGuide.Party ~= nil then
        for job, member in pairs(activeGuide.Party) do
            if member ~= nil and member.name ~= nil and member.name ~= '' then
                str = str:gsub(escapePattern(member.name), tostring(job))
            end
        end
    end
    return str
end

local logPos = function(pos)
    if pos == nil then
        return 'nil'
    end
    return string.format('{x=%.3f,y=%.3f,z=%.3f}',
            tonumber(pos.x or 0) or 0,
            tonumber(pos.y or 0) or 0,
            tonumber(pos.z or 0) or 0)
end

local sortedKeys = function(tbl)
    local keys = {}
    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end
    table.sort(keys, function(left, right)
        return tostring(left) < tostring(right)
    end)
    return keys
end

local logTable = function(tbl, deep, seen)
    if seen[tbl] then
        return '{<cycle>}'
    end
    if tbl.x ~= nil and tbl.z ~= nil then
        return logPos(tbl)
    end
    if tbl.id ~= nil and (tbl.pos ~= nil or tbl.job ~= nil or tbl.contentid ~= nil or tbl.name ~= nil) then
        local role = getRoleByEntityID(tbl.id)
        local info = '{entity=' .. tostring(role or tbl.id)
        if tbl.job ~= nil then
            info = info .. ',job=' .. tostring(tbl.job)
        end
        if tbl.contentid ~= nil then
            info = info .. ',contentid=' .. tostring(tbl.contentid)
        end
        if tbl.pos ~= nil then
            info = info .. ',pos=' .. logPos(tbl.pos)
        end
        return info .. '}'
    end
    if deep >= 2 then
        return '{...}'
    end

    seen[tbl] = true
    local parts = {}
    local keys = sortedKeys(tbl)
    for i = 1, math.min(#keys, 16) do
        local key = keys[i]
        table.insert(parts, safeString(key) .. '=' .. logValue(tbl[key], deep + 1, seen))
    end
    if #keys > 16 then
        table.insert(parts, '...')
    end
    seen[tbl] = nil
    return '{' .. table.concat(parts, ',') .. '}'
end

logValue = function(value, deep, seen)
    deep = deep or 0
    seen = seen or {}
    if value == nil then
        return 'nil'
    end
    if type(value) == 'table' then
        return logTable(value, deep, seen)
    end
    if type(value) == 'string' then
        return safeString(value)
    end
    return safeString(value)
end

local getDebugTime = function()
    if activeGuide ~= nil and activeGuide.InfoTime ~= nil then
        return activeGuide.InfoTime()
    end
    return tostring(TensorReactions_CurrentCombatTimer or 0)
end

local logEnable = function(force)
    if force then
        return true
    end
    return activeGuide ~= nil
            and activeGuide.Config ~= nil
            and activeGuide.Config.Main ~= nil
            and activeGuide.Config.Main.LogEnable == true
end

local createDiagnosticSessionName = function()
    local path = getDiagnosticPath()
    local baseName = safeFileName('MuAiCore_' .. os.date('%Y%m%d_%H%M%S'))
    local candidate = baseName
    local suffix = 2
    local function sessionExists(sessionName)
        local escaped = escapePattern(sessionName)
        return #listFiles(path, function(name)
            return name == sessionName .. '.log'
                    or name:match('^' .. escaped .. '_part%d+%.log$') ~= nil
        end) > 0
    end
    while sessionExists(candidate) do
        candidate = baseName .. '_' .. suffix
        suffix = suffix + 1
    end
    return candidate
end

local formatDiagnosticLine = function(level, moduleName, msg, data)
    local line = '[' .. os.date('%Y-%m-%d %H:%M:%S') .. ']'
            .. '[' .. safeString(level) .. ']'
            .. '[' .. safeString(moduleName) .. '] '
            .. safeString(msg)
    if data ~= nil then
        line = line .. '|' .. logValue(data, 0, {})
    end
    if #line > DIAGNOSTIC_MAX_LINE_BYTES then
        line = line:sub(1, DIAGNOSTIC_MAX_LINE_BYTES - 18) .. '...[line-truncated]'
    end
    return line
end

local openDiagnosticFile = function()
    if diagnosticState.disabled then
        return false
    end
    local path = getDiagnosticPath()
    if not ensureFolder(path) then
        consoleWrite('[ERROR][LogSystem] 创建诊断日志目录失败：' .. path)
        diagnosticState.disabled = true
        return false
    end
    if not trimFilesForNew(path, function(name)
        return name:match('^MuAiCore_%d%d%d%d%d%d%d%d_%d%d%d%d%d%d.*%.log$') ~= nil
    end, DIAGNOSTIC_MAX_FILES) then
        diagnosticState.disabled = true
        return false
    end

    if diagnosticState.sessionName == nil then
        diagnosticState.sessionName = createDiagnosticSessionName()
    end
    local fileName = diagnosticState.sessionName
    if diagnosticState.part > 1 then
        fileName = fileName .. '_part' .. tostring(diagnosticState.part)
    end
    diagnosticState.fileName = fileName .. '.log'
    diagnosticState.filePath = path .. '\\' .. diagnosticState.fileName
    diagnosticState.bytes = 0

    if type(FileWrite) ~= 'function' then
        consoleWrite('[ERROR][LogSystem] 宿主未提供 FileWrite，诊断日志无法持久化')
        diagnosticState.disabled = true
        return false
    end
    local header = formatDiagnosticLine('INFO', 'Lifecycle', '诊断会话开始', {
        mapID = Player ~= nil and Player.localmapid or nil,
        version = activeGuide ~= nil and activeGuide.VERSION or nil,
    }) .. '\n'
    if FileWrite(diagnosticState.filePath, header, false) ~= true then
        consoleWrite('[ERROR][LogSystem] 创建诊断日志失败：' .. diagnosticState.filePath)
        diagnosticState.disabled = true
        return false
    end
    diagnosticState.bytes = #header
    return true
end

local writeDiagnosticLine = function(line)
    if diagnosticState.disabled then
        return false
    end
    if diagnosticState.filePath == nil and not openDiagnosticFile() then
        return false
    end
    local content = line .. '\n'
    if diagnosticState.bytes > 0
            and diagnosticState.bytes + #content > DIAGNOSTIC_MAX_BYTES
    then
        diagnosticState.part = diagnosticState.part + 1
        diagnosticState.filePath = nil
        if not openDiagnosticFile() then
            return false
        end
    end
    if FileWrite(diagnosticState.filePath, content, true) ~= true then
        consoleWrite('[ERROR][LogSystem] 追加诊断日志失败：' .. tostring(diagnosticState.filePath))
        diagnosticState.disabled = true
        return false
    end
    diagnosticState.bytes = diagnosticState.bytes + #content
    return true
end

local diagnosticKey = function(moduleName, key, msg)
    return safeString(moduleName) .. ':' .. safeString(key or msg)
end

local writeSuppressedSummary = function(cacheKey, state)
    if state == nil or state.suppressed == nil or state.suppressed <= 0 then
        return true
    end
    local written = writeDiagnosticLine(formatDiagnosticLine('INFO', state.moduleName,
            '重复诊断已节流', {
                key = cacheKey,
                repeats = state.suppressed,
                windowSeconds = DIAGNOSTIC_THROTTLE_SECONDS,
            }))
    state.suppressed = 0
    return written
end

local flushDiagnosticSuppressed = function()
    local keys = sortedKeys(diagnosticState.throttles)
    for i = 1, #keys do
        local key = keys[i]
        writeSuppressedSummary(key, diagnosticState.throttles[key])
    end
end

local writeDiagnostic = function(level, moduleName, msg, data, key)
    level = string.upper(tostring(level or 'INFO'))
    moduleName = tostring(moduleName or 'Core')
    msg = tostring(msg or '')
    local context = data ~= nil and logValue(data, 0, {}) or ''
    local signature = level .. '|' .. safeString(msg) .. '|' .. context
    local cacheKey = diagnosticKey(moduleName, key, msg)
    local now = os.time()
    local state = diagnosticState.throttles[cacheKey]

    if state ~= nil and state.signature == signature
            and now - state.lastWrittenAt < DIAGNOSTIC_THROTTLE_SECONDS
    then
        state.suppressed = state.suppressed + 1
        return false
    end
    if state ~= nil then
        writeSuppressedSummary(cacheKey, state)
    end
    local written = writeDiagnosticLine(formatDiagnosticLine(level, moduleName, msg, data))
    diagnosticState.throttles[cacheKey] = {
        lastWrittenAt = now,
        moduleName = moduleName,
        signature = signature,
        suppressed = 0,
    }
    return written
end

local createLogFileName = function()
    if activeGuide == nil then
        return false
    end
    if activeGuide.CurRaidScript == nil or activeGuide.CurRaidScript.NameCN == nil then
        if Player == nil or Player.localmapid == nil or Player.localmapid == 0 then
            activeGuide.Debug('创建新日志失败: 当前副本未找到且玩家地图为空！')
            return false
        end
        curFileName = safeFileName('Map_' .. tostring(Player.localmapid) .. '_' .. os.date('%Y%m%d_%H%M%S'))
    else
        curFileName = safeFileName(activeGuide.CurRaidScript.NameCN .. '_' .. os.date('%Y%m%d_%H%M%S'))
    end
    local path = getLogPath()
    if not ensureFolder(path) then
        activeGuide.Debug('创建战斗日志目录失败：' .. path)
        return false
    end
    if not trimFilesForNew(path, function(name)
        return name:match('%.log$') ~= nil
    end, COMBAT_LOG_MAX_FILES) then
        activeGuide.Debug('战斗日志保留策略执行失败，未创建新日志')
        return false
    end
    local baseName = curFileName
    local suffix = 2
    curFileName = baseName .. '.log'
    while FileExists(path .. '\\' .. curFileName) do
        curFileName = baseName .. '_' .. suffix .. '.log'
        suffix = suffix + 1
    end
    activeGuide.Debug('创建新日志: ' .. curFileName)
    return true
end

local clearLogData = function()
    onceLogData = {}
    logCache = {}
    logCacheBytes = 0
    logCacheTruncated = false
    curFileName = nil
end

local clearAndNew = function()
    clearLogData()
    return createLogFileName()
end

local appendCombatLog = function(eventName, msg, data, force)
    if not logEnable(force) then
        return false
    end
    local line = '[' .. getDebugTime() .. '][' .. eventName .. '] ' .. safeString(msg)
    if data ~= nil then
        line = line .. '|' .. logValue(data, 0, {})
    end
    if logCacheTruncated or logCacheBytes + #line + 1 > COMBAT_LOG_MAX_BYTES then
        logCacheTruncated = true
        return false
    end
    table.insert(logCache, line)
    logCacheBytes = logCacheBytes + #line + 1
    return true
end

local saveLog = function()
    if #logCache == 0 and not logCacheTruncated then
        return true
    end
    if curFileName == nil and not createLogFileName() then
        return false
    end
    local path = getLogPath()
    if not ensureFolder(path) then
        return false
    end

    local content = table.concat(logCache, '\n')
    if logCacheTruncated then
        local notice = '[' .. getDebugTime() .. '][LogSystem] [问题] 战斗日志达到大小上限，后续内容已停止缓存'
                .. '|{limitBytes=' .. tostring(COMBAT_LOG_MAX_BYTES) .. '}'
        if content ~= '' then
            content = content .. '\n'
        end
        content = content .. notice
    end
    local filePath = path .. '\\' .. curFileName
    if FileSave(filePath, content) then
        activeGuide.Debug('保存日志' .. curFileName .. '成功！')
        return true
    end
    activeGuide.Debug('保存日志' .. curFileName .. '失败！')
    return false
end

---@param M MuAiGuide
LogSystem.init = function(M)
    activeGuide = M
    local rawDebug = M.Debug

    --- 获取战斗时间（保留3位）
    M.InfoTime = function()
        return string.format('%.3f', tonumber(TensorReactions_CurrentCombatTimer) or 0)
    end

    M.Diagnostic = function(level, moduleName, msg, data, key)
        return writeDiagnostic(level, moduleName, msg, data, key)
    end

    M.DiagnosticFlush = function()
        flushDiagnosticSuppressed()
    end

    M.GetDiagnosticLogPath = function()
        return diagnosticState.filePath
    end

    M.DiagnosticCall = function(moduleName, operation, fn, context)
        if type(fn) ~= 'function' then
            error('DiagnosticCall requires a function')
        end
        local first, second, third, fourth
        local function onError(err)
            local stack = tostring(err)
            if debug ~= nil and type(debug.traceback) == 'function' then
                stack = debug.traceback(tostring(err), 2)
            end
            local details = {}
            if type(context) == 'table' then
                for key, value in pairs(context) do
                    details[key] = value
                end
            elseif context ~= nil then
                details.context = context
            end
            details.error = tostring(err)
            details.traceback = stack
            writeDiagnostic('ERROR', moduleName, operation .. '失败', details, operation)
            return stack
        end
        local ok, caught = xpcall(function()
            first, second, third, fourth = fn()
        end, onError)
        if not ok then
            return false, caught
        end
        return true, first, second, third, fourth
    end

    M.Debug = function(msg, moduleName, data)
        rawDebug(msg)
        writeDiagnostic('DEBUG', moduleName or 'Console', msg, data, msg)
    end

    openDiagnosticFile()

    M.InfoNoLog = function(msg, ttsOn)
        if M.Config ~= nil and M.Config.Main ~= nil and not M.Config.Main.LogToEchoMsg then
            return
        end
        TensorCore.sendParsedChatMessage('/e {color:0,255,0}{resetcolor}' .. msg)
        if ttsOn
                and M.Config ~= nil
                and M.Config.Main ~= nil
                and M.Config.Main.TTS == true
        then
            TensorCore.addAlertText(0, msg, 1, 2, true)
        end
    end

    --- 输出消息到聊天栏
    --- @param msg string
    M.Info = function(msg, ttsOn, arrOnly)
        if M.CurRaidScript ~= nil then
            M.Log('State', msg)
        end
        if not M.Config.Main.LogToEchoMsg then
            return
        end
        if arrOnly then
            if M.IsVideo() then
                TensorCore.sendParsedChatMessage('/e {color:0,255,0}{resetcolor}' .. '[' .. M.InfoTime() .. ']' .. msg)
            end
        else
            TensorCore.sendParsedChatMessage('/e {color:0,255,0}{resetcolor}' .. msg)
        end
        if ttsOn and M.Config.Main.TTS == true then
            TensorCore.addAlertText(0, msg, 1, 2, true)
        end
    end

    M.LogCount = function(tbl)
        local count = 0
        for _, _ in pairs(tbl or {}) do
            count = count + 1
        end
        return count
    end

    M.LogEntityID = function(entityID)
        return getRoleByEntityID(entityID) or tostring(entityID)
    end

    M.LogEntityList = function(list)
        local result = {}
        for i = 1, #(list or {}) do
            table.insert(result, M.LogEntityID(list[i]))
        end
        return table.concat(result, ',')
    end

    M.Log = function(eventName, msg, data, force)
        writeDiagnostic('INFO', eventName, msg, data, msg)
        if appendCombatLog(eventName, msg, data, force) then
            rawDebug('[' .. eventName .. '] ' .. safeString(msg))
        end
    end

    M.LogError = function(eventName, msg, data, force)
        writeDiagnostic('ERROR', eventName, msg, data, msg)
        if appendCombatLog(eventName, '[问题]' .. msg, data, force) then
            rawDebug('[' .. eventName .. '] [问题]' .. safeString(msg))
        end
    end

    M.LogOnce = function(eventName, key, msg, data, force)
        writeDiagnostic('WARN', eventName, msg, data, key)
        if not logEnable(force) then
            return
        end
        local cacheKey = eventName .. ':' .. tostring(key)
        if onceLogData[cacheKey] then
            return
        end
        onceLogData[cacheKey] = true
        if appendCombatLog(eventName, msg, data, force) then
            rawDebug('[' .. eventName .. '] ' .. safeString(msg))
        end
    end

    M.LogSystemEnter = function()
        if #logCache > 0 and not saveLog() then
            return false
        end
        sessionActive = false
        if logEnable() then
            return clearAndNew()
        end
        clearLogData()
        return true
    end

    M.LogSystemLeave = function()
        flushDiagnosticSuppressed()
        if (#logCache > 0 or logCacheTruncated) and not saveLog() then
            return false
        end
        clearLogData()
        sessionActive = false
        return true
    end

    --- 日志系统-团灭
    M.LogSystemWipe = function()
        flushDiagnosticSuppressed()
        if (#logCache > 0 or logCacheTruncated) and not saveLog() then
            return false
        end
        sessionActive = false
        if logEnable() then
            return clearAndNew()
        end
        clearLogData()
        return true
    end

    --- 日志系统初始化（需要在副本初始化时候调用）
    M.LogSystemInit = function()
        if not logEnable() then
            if (#logCache > 0 or logCacheTruncated) and not saveLog() then
                return false
            end
            clearLogData()
            sessionActive = false
            return true
        end
        -- 如果 wipe 触发失败数据没有清空，在下一次初始化时保存上一把并新建日志。
        if sessionActive then
            if (#logCache > 0 or logCacheTruncated) and not saveLog() then
                return false
            end
            if not clearAndNew() then
                return false
            end
        elseif curFileName == nil and not createLogFileName() then
            return false
        end
        sessionActive = true
        return true
    end

    M.DiagnosticConfig = {
        maxBytes = DIAGNOSTIC_MAX_BYTES,
        maxFiles = DIAGNOSTIC_MAX_FILES,
        maxLineBytes = DIAGNOSTIC_MAX_LINE_BYTES,
        throttleSeconds = DIAGNOSTIC_THROTTLE_SECONDS,
    }
end

return LogSystem
