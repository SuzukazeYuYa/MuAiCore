local LogSystem = {}
--[[
===================================
    日志系统
    开发: String
    修改: MuAi
===================================
]]

local onceLogData = {}
local logCache = {}
local curFileName
local sessionActive = false

local logValue

local escapePattern = function(str)
    return tostring(str):gsub('(%W)', '%%%1')
end

local safeFileName = function(str)
    return tostring(str):gsub('[\\/:*?"<>|]', '_')
end

local createLogFileName = function()
    if MuAiGuide == nil then
        return false
    end
    if MuAiGuide.CurRaidScript == nil or MuAiGuide.CurRaidScript.NameCN == nil then
        if Player == nil or Player.localmapid == nil or Player.localmapid == 0 then
            MuAiGuide.Debug('创建新日志失败: 当前副本未找到且玩家地图为空！')
            return false
        end
        curFileName = safeFileName('Map_' .. tostring(Player.localmapid) .. '_' .. os.date('%Y%m%d_%H%M%S'))
    else
        curFileName = safeFileName(MuAiGuide.CurRaidScript.NameCN .. '_' .. os.date('%Y%m%d_%H%M%S'))
    end
    local path = GetLuaModsPath() .. 'MuAiCore\\Log'
    local baseName = curFileName
    local suffix = 2
    curFileName = baseName .. '.log'
    while FileExists(path .. '\\' .. curFileName) do
        curFileName = baseName .. '_' .. suffix .. '.log'
        suffix = suffix + 1
    end
    MuAiGuide.Debug('创建新日志: ' .. curFileName)
    return true
end

local logEnable = function(force)
    if force then
        return true
    end
    return MuAiGuide ~= nil
            and MuAiGuide.Config ~= nil
            and MuAiGuide.Config.Main ~= nil
            and MuAiGuide.Config.Main.LogEnable == true
end

local getDebugTime = function()
    if MuAiGuide ~= nil and MuAiGuide.InfoTime ~= nil then
        return MuAiGuide.InfoTime()
    end
    return tostring(TensorReactions_CurrentCombatTimer or 0)
end

local getRoleByEntityID = function(entityID)
    if MuAiGuide == nil or MuAiGuide.Party == nil then
        return nil
    end
    for job, member in pairs(MuAiGuide.Party) do
        if member ~= nil and member.id == entityID then
            return job
        end
    end
    return nil
end

local safeString = function(str)
    str = tostring(str):gsub('\r', '\\r'):gsub('\n', '\\n')
    if MuAiGuide ~= nil and MuAiGuide.Party ~= nil then
        for job, member in pairs(MuAiGuide.Party) do
            if member ~= nil and member.name ~= nil and member.name ~= '' then
                str = str:gsub(escapePattern(member.name), job)
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

local logTable = function(tbl, deep)
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
    local parts = {}
    local count = 0
    for key, value in pairs(tbl) do
        count = count + 1
        if count > 16 then
            table.insert(parts, '...')
            break
        end
        table.insert(parts, safeString(key) .. '=' .. logValue(value, deep + 1))
    end
    return '{' .. table.concat(parts, ',') .. '}'
end

logValue = function(value, deep)
    deep = deep or 0
    if value == nil then
        return 'nil'
    end
    if type(value) == 'table' then
        return logTable(value, deep)
    end
    if type(value) == 'string' then
        return safeString(value)
    end
    return tostring(value)
end

local saveLog = function()
    if #logCache == 0 then
        return true
    end
    if curFileName == nil and not createLogFileName() then
        return false
    end
    local path = GetLuaModsPath() .. 'MuAiCore\\Log'
    if not FolderExists(path) then
        FolderCreate(path)
    end

    local filePath = path .. '\\' .. curFileName
    local content = table.concat(logCache, "\n")
    if FileSave(filePath, content) then
        MuAiGuide.Debug('保存日志' .. curFileName .. '成功！')
        return true
    end
    MuAiGuide.Debug('保存日志' .. curFileName .. '失败！')
    return false
end

local clearLogData = function()
    onceLogData = {}
    logCache = {}
    curFileName = nil
end

---@param M MuAiGuide
LogSystem.init = function(M)
    --- 获取战斗时间（保留3位）
    M.InfoTime = function()
        return string.format('%.3f', TensorReactions_CurrentCombatTimer)
    end

    M.InfoNoLog = function(msg, ttsOn)
        if M.Config ~= nil and M.Config.Main ~= nil and not M.Config.Main.LogToEchoMsg then
            return
        end
        TensorCore.sendParsedChatMessage("/e {color:0,255,0}{resetcolor}" .. msg)
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
                TensorCore.sendParsedChatMessage("/e {color:0,255,0}{resetcolor}" .. '[' .. M.InfoTime() .. ']' .. msg)
            end
        else
            TensorCore.sendParsedChatMessage("/e {color:0,255,0}{resetcolor}" .. msg)
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
        if not logEnable(force) then
            return
        end
        local line = '[' .. getDebugTime() .. '][' .. eventName .. '] ' .. safeString(msg)
        if data ~= nil then
            line = line .. '|' .. logValue(data, 0)
        end
        table.insert(logCache, line)
        M.Debug('[' .. eventName .. '] ' .. safeString(msg))
    end

    M.LogError = function(eventName, msg, data, force)
        M.Log(eventName, '[问题]' .. msg, data, force)
    end

    M.LogOnce = function(eventName, key, msg, data, force)
        if not logEnable(force) then
            return
        end
        local cacheKey = eventName .. ':' .. tostring(key)
        if onceLogData[cacheKey] then
            return
        end
        onceLogData[cacheKey] = true
        M.Log(eventName, msg, data, force)
    end

    M.LogSystemEnter = function()
        if #logCache > 0 and not saveLog() then
            return false
        end
        clearLogData()
        sessionActive = false
        if logEnable() then
            return createLogFileName()
        end
        return true
    end

    M.LogSystemLeave = function()
        if #logCache > 0 and not saveLog() then
            return false
        end
        clearLogData()
        sessionActive = false
        return true
    end

    --- 日志系统-团灭
    M.LogSystemWipe = function()
        if #logCache > 0 and not saveLog() then
            return false
        end
        clearLogData()
        sessionActive = false
        if logEnable() then
            return createLogFileName()
        end
        return true
    end

    --- 日志系统初始化（需要在副本初始化时候调用）
    M.LogSystemInit = function()
        if not logEnable() then
            if #logCache > 0 and not saveLog() then
                return false
            end
            clearLogData()
            sessionActive = false
            return true
        end
        if sessionActive then
            if #logCache > 0 and not saveLog() then
                return false
            end
            clearLogData()
            if not createLogFileName() then
                return false
            end
        elseif curFileName == nil and not createLogFileName() then
            return false
        end
        sessionActive = true
        return true
    end
end

return LogSystem
