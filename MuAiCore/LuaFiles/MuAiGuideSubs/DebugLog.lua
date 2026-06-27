local DebugLog = {}

local debugFolderName = 'debuglogs'

---@param M MuAiGuide
DebugLog.init = function(M)
    local contextName
    local contextStartedAt
    local sessionStartedAt
    local sessionFilePath
    local buffer = {}
    local onceCache = {}

    local escapePattern = function(str)
        return tostring(str):gsub('(%W)', '%%%1')
    end

    local safeFileName = function(str)
        return tostring(str):gsub('[\\/:*?"<>|]', '_')
    end

    local getDebugPath = function()
        return GetLuaModsPath() .. 'MuAiCore\\' .. debugFolderName
    end

    local debugEnabled = function(force)
        return force == true
                or M.Config ~= nil
                and M.Config.Main ~= nil
                and M.Config.Main.DebugLog == true
    end

    local getDebugTime = function()
        if M.InfoTime ~= nil then
            return M.InfoTime()
        end
        return tostring(TensorReactions_CurrentCombatTimer or 0)
    end

    local getRoleByEntityID = function(entityID)
        if M.Party == nil then
            return nil
        end
        for job, member in pairs(M.Party) do
            if member ~= nil and member.id == entityID then
                return job
            end
        end
        return nil
    end

    local safeString = function(value)
        local str = tostring(value):gsub('\r', '\\r'):gsub('\n', '\\n')
        if M.Party ~= nil then
            for job, member in pairs(M.Party) do
                if member ~= nil and member.name ~= nil and member.name ~= '' then
                    str = str:gsub(escapePattern(member.name), job)
                end
            end
        end
        return str
    end

    local debugValue

    local debugPos = function(pos)
        if pos == nil then
            return 'nil'
        end
        return string.format('{x=%.3f,y=%.3f,z=%.3f}',
                tonumber(pos.x or 0) or 0,
                tonumber(pos.y or 0) or 0,
                tonumber(pos.z or 0) or 0)
    end

    local debugTable = function(tbl, deep)
        if tbl.x ~= nil and tbl.z ~= nil then
            return debugPos(tbl)
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
                info = info .. ',pos=' .. debugPos(tbl.pos)
            end
            return info .. '}'
        end
        if deep >= 2 then
            return '{...}'
        end
        local parts = {}
        local count = 0
        for key, value in pairs(tbl) do
            count = count + 1
            if count > 16 then
                table.insert(parts, '...')
                break
            end
            table.insert(parts, safeString(key) .. '=' .. debugValue(value, deep + 1))
        end
        return '{' .. table.concat(parts, ',') .. '}'
    end

    debugValue = function(value, deep)
        deep = deep or 0
        if value == nil then
            return 'nil'
        end
        if type(value) == 'table' then
            return debugTable(value, deep)
        end
        return safeString(value)
    end

    local resetSession = function()
        sessionStartedAt = nil
        sessionFilePath = nil
        contextStartedAt = contextName ~= nil and os.date('%Y%m%d_%H%M%S') or nil
        buffer = {}
        onceCache = {}
    end

    ---设置当前日志所属副本；切换副本前会先写出尚未落盘的内容。
    ---@param name string|nil
    M.SetDebugLogContext = function(name)
        if name == contextName then
            return
        end
        if #buffer > 0 and not M.FlushDebugLog(true) then
            return
        end
        contextName = name
        resetSession()
    end

    ---记录本次战斗的开始时间，用于生成一把一个的日志文件名。
    ---若上一把未正常触发灭团写盘，则在新一把开始前补写旧缓存。
    ---@return boolean success
    M.StartDebugLogSession = function()
        if contextName == nil then
            return false
        end
        if sessionStartedAt ~= nil then
            if #buffer > 0 then
                if not M.FlushDebugLog(true) then
                    return false
                end
            else
                resetSession()
            end
        end
        sessionStartedAt = os.date('%Y%m%d_%H%M%S')
        return true
    end

    ---@param eventName string
    ---@param msg any
    ---@param data any|nil
    ---@param force boolean|nil 即使全局开关关闭也记录，供错误处理使用
    M.DebugLog = function(eventName, msg, data, force)
        if contextName == nil or not debugEnabled(force) then
            return
        end
        local line = '[' .. getDebugTime() .. '][' .. safeString(eventName) .. '] ' .. safeString(msg)
        if data ~= nil then
            line = line .. ' | ' .. debugValue(data, 0)
        end
        table.insert(buffer, line)
    end

    M.DebugProblem = function(eventName, msg, data, force)
        M.DebugLog(eventName, '[问题]' .. tostring(msg), data, force)
    end

    M.DebugOnce = function(eventName, key, msg, data, force)
        if contextName == nil or not debugEnabled(force) then
            return
        end
        local cacheKey = tostring(eventName) .. ':' .. tostring(key)
        if onceCache[cacheKey] then
            return
        end
        onceCache[cacheKey] = true
        M.DebugLog(eventName, msg, data, force)
    end

    ---将当前战斗缓存集中写入文件。写入失败时保留缓存，供下次重试。
    ---@param reset boolean|nil 写入后是否开始新的战斗缓存
    ---@return boolean success
    M.FlushDebugLog = function(reset)
        if #buffer == 0 then
            if reset then
                resetSession()
            end
            return true
        end

        local path = getDebugPath()
        if not FolderExists(path) then
            FolderCreate(path)
        end
        if sessionFilePath == nil then
            local startedAt = sessionStartedAt or contextStartedAt or os.date('%Y%m%d_%H%M%S')
            local baseName = safeFileName((contextName or 'MuAiCore') .. '_' .. startedAt)
            sessionFilePath = path .. '\\' .. baseName .. '.log'
            local suffix = 2
            while FileExists(sessionFilePath) do
                sessionFilePath = path .. '\\' .. baseName .. '_' .. suffix .. '.log'
                suffix = suffix + 1
            end
        end
        local file = io.open(sessionFilePath, 'a')
        if file == nil then
            M.Debug('写入调试日志失败：' .. sessionFilePath)
            return false
        end
        local success, err = file:write(table.concat(buffer, '\n') .. '\n')
        file:close()
        if success == nil then
            M.Debug('写入调试日志失败：' .. tostring(err))
            return false
        end

        if reset then
            resetSession()
        else
            buffer = {}
        end
        return true
    end

    M.DebugCount = function(tbl)
        local count = 0
        for _, _ in pairs(tbl or {}) do
            count = count + 1
        end
        return count
    end

    M.DebugEntityID = function(entityID)
        return getRoleByEntityID(entityID) or tostring(entityID)
    end

    M.DebugEntityList = function(list)
        local result = {}
        for i = 1, #(list or {}) do
            table.insert(result, M.DebugEntityID(list[i]))
        end
        return table.concat(result, ',')
    end
end

return DebugLog
