local DM = {}
DM.MapId = 001
DM.NameCN = '妖星乱舞绝境战'
DM.Version = '0.0.1'
DM.ScriptName = 'Dancing_Mad';
DM.SubScripts = nil
--- 初始化，将拆分的脚本合并加载
DM.Init = function()
    DM.SubScripts = {}
    local folderPath = MuAiGuideRoot .. "RaidScripts\\Dancing_Mad_Subs"
    local list = FolderList(folderPath)
    for _, fileName in pairs(list) do
        MuAiGuide.Debug(" 加载副本[" .. DM.ScriptName .. "]的子脚本：" .. fileName)
        local filePath = folderPath .. "\\" .. fileName
        local script = FileLoad(filePath)
        if type(script) ~= "table" then
            MuAiGuide.Debug(fileName .. "加载失败！")
        else
            table.insert(DM.SubScripts, script)
        end
    end
end

local doSubEvents = function(eventName, ...)
    if not MuAiGuide.Config.DcmCfg.state.global.enable or MuAiGuide.DancingMad == nil then
        return
    end

    for _, script in pairs(DM.SubScripts or {}) do
        local cfgName = script.StateName
        if not cfgName then
            goto continue
        end
        if MuAiGuide.Config.DcmCfg.state[cfgName] and script[eventName] then
            local ok, err = pcall(script[eventName], ...)
            if not ok then
                MuAiGuide.Debug(cfgName .. '执行' .. eventName .. '失败！')
                MuAiGuide.Debug('错误信息:' .. tostring(err))
                MuAiGuide.Debug('调用堆栈:' .. debug.traceback())
            end
        end
        :: continue ::
    end
end

local dataInit = function()
    -- 副本数据初始化
    MuAiGuide.DancingMad = {

    }
    MuAiGuide.Info(DM.NameCN .. '数据初始化完毕！')
end

-------------------------- Argus Events --------------------------
DM.OnEntityChannel = function(entityID, spellID, _)
    if spellID == 12345 then -- 初步设定开场读条，可能增加其他条件
        dataInit()
    end
    doSubEvents('OnEntityChannel', entityID, spellID)
end

DM.OnMarkerAdd = function(entityID, markerID)
    doSubEvents('OnMarkerAdd', entityID, markerID)
end

DM.OnAOECreate = function(aoeInfo)
    doSubEvents('OnAOECreate', aoeInfo)
end

DM.OnEventObjectScriptFunc = function(entityID)
    doSubEvents('OnEventObjectScriptFunc', entityID)
end

DM.OnAddEntityVFX = function(vfxID)
    doSubEvents('OnAddEntityVFX', vfxID)
end

DM.Update = function()
    doSubEvents('Update')
end

DM.OnEnter = function()
    MuAiGuide.Develop.Reg("DancingMad")
end

DM.Init()
return DM