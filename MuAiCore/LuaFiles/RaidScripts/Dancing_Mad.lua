local DM = {}
DM.MapId = 1363
DM.NameCN = '妖星乱舞绝境战'
DM.Version = '0.0.1'
DM.ScriptName = 'Dancing_Mad';
DM.SubScripts = nil
local MG
--- 初始化，将拆分的脚本合并加载
DM.Init = function(M)
    DM.SubScripts = {}
    MG = M
    local folderPath = MuAiGuideRoot .. "RaidScripts\\Dancing_Mad_Subs"
    local list = FolderList(folderPath)
    for _, fileName in pairs(list) do
        M.Debug(" 加载副本[" .. DM.ScriptName .. "]的子脚本：" .. fileName)
        local filePath = folderPath .. "\\" .. fileName
        local script = FileLoad(filePath)
        if type(script) ~= "table" then
            M.Debug(fileName .. "加载失败！")
        else
            table.insert(DM.SubScripts, script)
        end
    end
end

local doSubEvents = function(eventName, ...)
    if not MG.Config.DmuCfg.state.global.enable or MG.DancingMad == nil then
        return
    end

    for _, script in pairs(DM.SubScripts or {}) do
        if MG.Config.DmuCfg.state[script.StateName] and script[eventName] then
            local ok, err = pcall(script[eventName], ...)
            if not ok then
                MG.Debug(script.StateName .. '执行' .. eventName .. '失败！')
                MG.Debug('错误信息:' .. tostring(err))
                MG.Debug('调用堆栈:' .. debug.traceback())
            end
        end
    end
end

local dataInit = function()
    -- 副本数据初始化
    MG.DancingMad = {

    }
    MG.Info(DM.NameCN .. '数据初始化完毕！')
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
    MG.Develop.Reg("DancingMad")
end

return DM