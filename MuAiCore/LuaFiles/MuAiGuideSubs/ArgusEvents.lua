local ArgusEvents = {}
--[[
===========================
    Argus事件模块
===========================
]]
local register = {
    OnEntityChannel = false,
    OnMarkerAdd = false,
    OnAOECreate = false,
    OnEventObjectScriptFunc = false,
    OnMapEffect = false,
    OnAddEntityVFX = false,
}
local registerOK = false
local infoTime = function()
    return string.format("%.3f", TensorReactions_CurrentCombatTimer)
end

---@param M MuAiGuide
ArgusEvents.init = function(M)
    --- 开始读条事件
    local OnEntityChannel = function(entityID, spellID, targetID, channelTimeMax)
       if M.CurRaidScript ~= nil and M.CurRaidScript.OnEntityChannel ~= nil then
            M.CurRaidScript.OnEntityChannel(entityID, spellID, targetID, channelTimeMax)
        end

        local ent = TensorCore.mGetEntity(entityID)
        if ent == nil or ent.type == 1 then
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
            M.Info('[' .. infoTime()
                    .. ']开始读条，实体名称：' .. ent.name .. ', 技能ID：' .. spellID .. "，判定时间：" .. channelTimeMax)
        end
    end

    --- 添加标记时间事件
    local OnMarkerAdd = function(entityID, markerID)
        if M.CurRaidScript ~= nil and M.CurRaidScript.OnMarkerAdd ~= nil then
            M.CurRaidScript.OnMarkerAdd(entityID, markerID)
        end

        local ent = TensorCore.mGetEntity(entityID)
        if ent == nil then
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
            M.Info('[' .. infoTime()
                    .. ']添加标记，实体名称：' .. ent.name .. ', 标记ID：' .. markerID .. "。")
        end

    end

    --- 注册AOE生成
    ---@param aoeInfo DirectionalAOE
    local OnAOECreate = function(aoeInfo)
        if M.CurRaidScript ~= nil and M.CurRaidScript.OnAOECreate ~= nil then
            M.CurRaidScript.OnAOECreate(aoeInfo)
        end

        if M.Develop.CacheAoeInfo then
            if M.Develop.AoeInfo[aoeInfo.aoeID] == nil then
                M.Develop.AoeInfo[aoeInfo.aoeID] = {}
            end
            table.insert(M.Develop.AoeInfo[aoeInfo.aoeID], aoeInfo)
        end
        if M.Develop.PrintAoeInfo then
            if aoeInfo.entityID then
                local ent = TensorCore.mGetEntity(aoeInfo.entityID)
                if ent.type == 1 then
                    return
                end 
            end
            M.Info('[' .. infoTime()
                    .. ']AOE生成，名称：' .. aoeInfo.aoeName
                    .. ', ID：' .. aoeInfo.aoeID
                    .. "，类型：" .. aoeInfo.aoeCastType
                    .. "，朝向：" .. aoeInfo.heading
            )
        end

    end

    --- 注册OnEventObjectScriptFunc
    local OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
        if M.CurRaidScript ~= nil and M.CurRaidScript.OnEventObjectScriptFunc ~= nil then
            M.CurRaidScript.OnEventObjectScriptFunc(entityID, a1, a2, a3)
        end
    end

    local OnMapEffect = function(a1, a2, a3)
        if M.CurRaidScript ~= nil and M.CurRaidScript.OnMapEffect ~= nil then
            M.CurRaidScript.OnMapEffect(a1, a2, a3)
        end
        if M.Develop.PrintAoeInfo then
            M.Info('[' .. infoTime()
                    .. ']OnMapEffect: |' .. a1 .. '|' .. a2 .. '|' .. a3 .. '|。')
        end
    end

    local OnAddEntityVFX = function(vfxID, vfxName, primaryEntityID, secondaryEntityID, time, a5, a6)
        if M.CurRaidScript ~= nil and M.CurRaidScript.OnAddEntityVFX ~= nil then
            M.CurRaidScript.OnAddEntityVFX(vfxID, vfxName, primaryEntityID, secondaryEntityID, time, a5, a6)
        end
        if M.Develop.PrintVFXInfo then
            local ent = TensorCore.mGetEntity(primaryEntityID)
            if M.Develop.VFXFilter then
                if vfxID > M.Develop.VFXFilterMax or vfxID < M.Develop.VFXFilterMin then
                    return
                end
                if ent.type == 1 and M.Develop.VFXFilterNoPlayer then
                    return
                end
            end
            M.Info('[' .. infoTime()
                    .. ']' .. ent.name .. 'AddVFX，vfxID：' .. vfxID .. '，vfxName：' .. vfxName
                    .. '，Other：|' .. primaryEntityID
                    .. '|' .. secondaryEntityID
                    .. '|' .. time
                    .. '|' .. a5
                    .. '|' .. a6 .. '|'
            )
        end
    end

    --- 安全注册阿古斯（防止加载失败导致报错）
    local registerArgus = function()
        if Argus == nil then
            return
        end
        if Argus.registerOnEntityChannel ~= nil and not register["OnEntityChannel"] then
            Argus.registerOnEntityChannel(OnEntityChannel)
            register["OnEntityChannel"] = true
        end
        if Argus.registerOnMarkerAdd ~= nil and not register["OnMarkerAdd"] then
            Argus.registerOnMarkerAdd(OnMarkerAdd)
            register["OnMarkerAdd"] = true
        end
        if Argus.registerOnAOECreateFunc ~= nil and not register["OnAOECreate"] then
            Argus.registerOnAOECreateFunc(OnAOECreate)
            register["OnAOECreate"] = true
        end
        if Argus.registerOnEventObjectScriptFunc ~= nil and not register["OnEventObjectScriptFunc"] then
            Argus.registerOnEventObjectScriptFunc(OnEventObjectScriptFunc)
            register["OnEventObjectScriptFunc"] = true
        end
        if Argus.registerOnMapEffect ~= nil and not register["OnMapEffect"] then
            Argus.registerOnMapEffect(OnMapEffect)
            register["OnMapEffect"] = true
        end
        if Argus.registerOnAddEntityVFXFunc ~= nil and not register["OnAddEntityVFX"] then
            Argus.registerOnAddEntityVFXFunc(OnAddEntityVFX)
            register["OnAddEntityVFX"] = true
        end
    end

    M.CheckArgusRegister = function()
        if registerOK then
            return
        end
        if register == nil then
            registerArgus()
            return
        end
        local hasNotRegister = false
        for _, state in pairs(register) do
            if not state then
                hasNotRegister = true
                break
            end
        end
        if hasNotRegister then
            registerArgus()
        else
            registerOK = true
            M.Debug("ArgusEvents:所有Argus事件函数注册完成")
        end
    end
end
return ArgusEvents