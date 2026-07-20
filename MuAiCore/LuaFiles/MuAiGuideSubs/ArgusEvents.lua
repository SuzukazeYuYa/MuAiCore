local ArgusEvents = {}
--[[
===========================
    Argus事件模块
===========================
]]

-- 注册状态放在全局桥中：Lua 热重载只替换当前 handler，不向 Argus 重复注册回调。
local bridge = rawget(_G, 'MuAiCoreArgusEventBridge')
if type(bridge) ~= 'table' then
    bridge = { registered = {} }
    rawset(_G, 'MuAiCoreArgusEventBridge', bridge)
elseif type(bridge.registered) ~= 'table' then
    bridge.registered = {}
end

local function callRaidScript(M, eventName, ...)
    local script = M.CurRaidScript
    local callback = script ~= nil and script[eventName] or nil
    if type(callback) == 'function' then
        return callback(...)
    end
end

local function createDispatcher(eventName)
    return function(...)
        local guide = rawget(_G, 'MuAiGuide')
        local handlers = type(guide) == 'table' and guide.ArgusEventHandlers or nil
        local handler = type(handlers) == 'table' and handlers[eventName] or nil
        if type(handler) == 'function' then
            return handler(...)
        end
    end
end

---@param M MuAiGuide
ArgusEvents.init = function(M)
    local handlers = {}
    M.ArgusEventHandlers = handlers

    --- 开始读条事件
    handlers.OnEntityChannel = function(entityID, spellID, targetID, channelTimeMax)
        callRaidScript(M, 'OnEntityChannel', entityID, spellID, targetID, channelTimeMax)
        if M.Develop.ShowSkillId or M.Develop.PrintChannelInfo then
            local entity = TensorCore.mGetEntity(entityID)
            if entity == nil or entity.charType == 4 or entity.charType == 2 then
                return
            end
            if M.Develop.ShowSkillId then
                AnyoneCore.addTimedWorldTextOnEnt(
                        M.Develop.ShowTime * 1000,
                        'Spell:' .. tostring(spellID),
                        entityID,
                        GUI:ColorConvertFloat4ToU32(1, 1, 1, 1),
                        true,
                        1,
                        4
                )
            end
            if M.Develop.PrintChannelInfo then
                M.InfoNoLog('[' .. M.InfoTime()
                        .. ']开始读条，实体名称：' .. entity.name .. ', 技能ID：' .. spellID .. '，判定时间：' .. channelTimeMax)
            end
        end
    end

    --- 读条结束事件
    handlers.OnEntityCast = function(entityID, spellID, castPos)
        callRaidScript(M, 'OnEntityCast', entityID, spellID, castPos)
        if M.Develop.PrintCastInfo then
            local entity = TensorCore.mGetEntity(entityID)
            if entity == nil or entity.charType == 4 or entity.charType == 2 then
                return
            end
            M.InfoNoLog('[' .. M.InfoTime()
                    .. ']OnEntityCast，实体名称：' .. entity.name .. ',SpellID：' .. spellID)
        end
    end

    --- 添加标记事件
    handlers.OnMarkerAdd = function(entityID, markerID)
        callRaidScript(M, 'OnMarkerAdd', entityID, markerID)
        local entity = TensorCore.mGetEntity(entityID)
        if entity == nil then
            return
        end
        if M.Develop.ShowMarkId then
            AnyoneCore.addTimedWorldTextOnEnt(
                    M.Develop.ShowTime * 1000,
                    'Mark:' .. tostring(markerID),
                    entityID,
                    GUI:ColorConvertFloat4ToU32(1, 1, 1, 1),
                    true,
                    1,
                    2
            )
        end
        if M.Develop.PrintMarkId then
            M.InfoNoLog('[' .. M.InfoTime()
                    .. ']添加标记，实体名称：' .. entity.name .. ', 标记ID：' .. markerID .. '。')
        end
    end

    --- 注册 AOE 生成事件
    ---@param aoeInfo DirectionalAOE
    handlers.OnAOECreate = function(aoeInfo)
        callRaidScript(M, 'OnAOECreate', aoeInfo)
        if M.Develop.CacheAoeInfo then
            if M.Develop.AoeInfo[aoeInfo.aoeID] == nil then
                M.Develop.AoeInfo[aoeInfo.aoeID] = {}
            end
            table.insert(M.Develop.AoeInfo[aoeInfo.aoeID], aoeInfo)
        end
        if M.Develop.PrintAoeInfo then
            if aoeInfo.entityID then
                local entity = TensorCore.mGetEntity(aoeInfo.entityID)
                if entity ~= nil and entity.type == 1 then
                    return
                end
            end
            M.InfoNoLog('[' .. M.InfoTime()
                    .. ']AOE生成，名称：' .. tostring(aoeInfo.aoeName)
                    .. ', ID：' .. tostring(aoeInfo.aoeID)
                    .. '，类型：' .. tostring(aoeInfo.aoeCastType)
                    .. '，朝向：' .. tostring(aoeInfo.heading)
            )
        end
    end

    --- 注册场景物件脚本事件
    handlers.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
        callRaidScript(M, 'OnEventObjectScriptFunc', entityID, a1, a2, a3)
        if M.Develop.EventObjectScript then
            M.Info('[' .. M.InfoTime() .. ']OnEventObjectScriptFunc: |'
                    .. tostring(entityID) .. '| ' .. tostring(a1) .. '|' .. tostring(a2) .. '|' .. tostring(a3) .. '|。')
        end
    end

    --- 注册地图效果事件
    handlers.OnMapEffect = function(a1, a2, a3)
        callRaidScript(M, 'OnMapEffect', a1, a2, a3)
        if M.Develop.PrintMapEffect then
            M.Info('[' .. M.InfoTime() .. ']OnMapEffect: |'
                    .. tostring(a1) .. '|' .. tostring(a2) .. '|' .. tostring(a3) .. '|。')
        end
    end

    --- 注册实体 VFX 事件
    handlers.OnAddEntityVFX = function(vfxID, vfxName, primaryEntityID, secondaryEntityID, time, a5, a6)
        callRaidScript(M, 'OnAddEntityVFX', vfxID, vfxName, primaryEntityID, secondaryEntityID, time, a5, a6)
        if M.Develop.PrintVFXInfo then
            local entity = TensorCore.mGetEntity(primaryEntityID)
            if entity == nil then
                return
            end
            if M.Develop.VFXFilter then
                if vfxID > M.Develop.VFXFilterMax or vfxID < M.Develop.VFXFilterMin then
                    return
                end
                if entity.type == 1 and M.Develop.VFXFilterNoPlayer then
                    return
                end
            end
            M.Info('[' .. M.InfoTime() .. ']' .. tostring(entity.name)
                    .. 'AddVFX，vfxID：' .. tostring(vfxID)
                    .. '，vfxName：' .. tostring(vfxName)
                    .. '，Other：|' .. tostring(primaryEntityID)
                    .. '|' .. tostring(secondaryEntityID)
                    .. '|' .. tostring(time)
                    .. '|' .. tostring(a5)
                    .. '|' .. tostring(a6) .. '|'
            )
        end
    end

    --- 注册连线变化事件
    handlers.OnTetherChange = function(sourceEntityID, oldTetherID, oldTetherFlags, oldTargetID,
            newTetherID, newTetherFlags, newTargetID)
        return callRaidScript(M, 'OnTetherChange', sourceEntityID, oldTetherID, oldTetherFlags, oldTargetID,
                newTetherID, newTetherFlags, newTargetID)
    end

    --- 注册实体生成事件
    handlers.OnEntityAdd = function(entityID, entityName)
        return callRaidScript(M, 'OnEntityAdd', entityID, entityName)
    end

    local registerComplete = false
    -- Argus 可能晚于本模块就绪；允许后续重试，bridge.registered 保证每类事件只注册一次。
    local function registerArgus()
        if Argus == nil then
            return false
        end
        local registrations = {
            { 'OnEntityChannel', Argus.registerOnEntityChannel },
            { 'OnEntityCast', Argus.registerOnEntityCast },
            { 'OnMarkerAdd', Argus.registerOnMarkerAdd },
            { 'OnAOECreate', Argus.registerOnAOECreateFunc },
            { 'OnEventObjectScriptFunc', Argus.registerOnEventObjectScriptFunc },
            { 'OnMapEffect', Argus.registerOnMapEffect },
            { 'OnAddEntityVFX', Argus.registerOnAddEntityVFXFunc },
            { 'OnTetherChange', Argus.registerOnTetherChange },
            { 'OnEntityAdd', Argus.registerOnEntityAddFunc },
        }

        local allRegistered = true
        for _, registration in ipairs(registrations) do
            local eventName = registration[1]
            local registerFunction = registration[2]
            if not bridge.registered[eventName] then
                if type(registerFunction) ~= 'function' then
                    allRegistered = false
                else
                    local ok, err = pcall(registerFunction, createDispatcher(eventName))
                    if ok then
                        bridge.registered[eventName] = true
                    else
                        allRegistered = false
                        M.LogOnce('ArgusEvents', 'register_' .. eventName,
                                'Argus事件注册失败', { event = eventName, err = tostring(err) }, true)
                    end
                end
            end
        end
        return allRegistered
    end

    M.CheckArgusRegister = function()
        if registerComplete then
            return
        end
        if registerArgus() then
            registerComplete = true
            M.Debug('ArgusEvents:所有Argus事件函数注册完成')
        end
    end
end

return ArgusEvents
