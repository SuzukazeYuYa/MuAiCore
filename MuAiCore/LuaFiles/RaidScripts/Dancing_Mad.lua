local DM = {} ---@ class DancingMad
DM.MapId = 1363
DM.NameCN = '妖星乱舞绝境战'
DM.Version = '0.0.1'
DM.ScriptName = 'Dancing_Mad';
DM.SubScripts = nil
---@type MuAiGuide
local MG

-- 执行子脚本
local doSubEvents = function(eventName, ...)
    if not MG.Config.DmuCfg.Enable or MG.DancingMad == nil then
        return
    end

    for _, script in pairs(DM.SubScripts or {}) do
        if MG.Config.DmuCfg[script.StateName].enable and script[eventName] then
            local ok, err = pcall(script[eventName], ...)
            if not ok then
                MG.Debug(script.StateName .. '执行' .. eventName .. '失败！')
                d('----------------------------------------------------')
                MG.Debug('错误信息:' .. tostring(err))
                MG.Debug('调用堆栈:' .. debug.traceback())
                d('----------------------------------------------------')
            end
        end
    end
end

---数据初始化
local dataInit = function()
    --- @class DancingMadData
    MG.DancingMad = {
        P1 = {
            Fire1 = {
                BossMark = 0,
                PlayerMark = 0,
                GatherPlayers = {},
                Time = 0 --火判定时间
            },
            BeamShoot = {},
            TowerAoe = {},
            
        }
    }
    MG.DancingMad.CurrentState = DM.State.P1Start
    MG.Info(DM.NameCN .. '数据初始化完毕！')
end

--- 状态定义
DM.State = {
    P1Start = 1000,
    P1TrueFalse1 = 1001,
    P1LineKickBacked = 1002,
    P1TrueFalse2 = 1003,
    P1TrueFalse1End = 1004,
    P1BeamEnd = 1005,
    P1TowerBoom = 1006,
    P1BuffTrans1 = 1007,
    P1BuffTrans2 = 1008,
    P1BuffTrans3 = 1009,
    P1BuffTrans4 = 1010,
    P1Line2_1 = 1011,
    P1Line2_2 = 1012,
    P1Line3_1 = 1013,
    P1Line3_2 = 1014,
    
    P1End = 1099,
    
    
    P2Start = 2000,
}

--- 初始化，将拆分的脚本合并加载
DM.Init = function(M)
    DM.SubScripts = {}
    MG = M
    -- 一次性创建所有颜色
    DM.redDrawer = MG.CreateDrawer(1, 0, 0)
    DM.yellowDrawer = MG.CreateDrawer(1, 1, 0)
    DM.blueDrawer = MG.CreateDrawer(0, 0, 1)
    DM.greenDrawer = MG.CreateDrawer(0, 1, 0)
    DM.purpleDrawer = MG.CreateDrawer(1, 0, 1)
    DM.cyanDrawer = MG.CreateDrawer(0, 1, 1)
    local folderPath = MuAiGuideRoot .. "RaidScripts\\Dancing_Mad_Subs"
    local list = FolderList(folderPath)
    for _, fileName in pairs(list) do
        M.Debug("       加载副本[" .. DM.ScriptName .. "]的子脚本：" .. fileName)
        local filePath = folderPath .. "\\" .. fileName
        local script = FileLoad(filePath)
        if type(script) ~= "table" then
            M.Debug('       加载失败，获取到内容如下：')
            M.Debug('       -----------------------')
            d(script)
            M.Debug('       -----------------------')
        else
            script.Init(DM, M)
            table.insert(DM.SubScripts, script)
        end
    end
end

--- 切换状态
DM.ChangeState = function(stateName)
    local state = DM.State[stateName]
    if state == nil then
        -- 输出错误日志
        MG.Debug("[错误]切换状态失败，状态不存在：" .. stateName)
        MG.Debug("调用堆栈：" .. debug.traceback()) -- 打印完整调用栈
        -- 直接抛出 Lua 异常，强制中断，避免继续执行
        error("DM.ChangeState 禁止传入 nil 状态！")
        return
    end
    MG.DancingMad.CurrentState = state
    MG.Debug("DancingMad阶段切换：" .. stateName)
end

--- 是否在状态中
---@param stateName string
DM.InState = function(stateName)
    local state = DM.State[stateName]
    if MG.DancingMad.CurrentState == state then
        return true
    end
    return false
end

DM.OverState = function(stateName, include)
    local state = DM.State[stateName]
    if state == nil then
        -- 输出错误日志
        MG.Debug("[错误]状态不存在：" .. stateName)
    end
    if include then
        return MG.DancingMad.CurrentState >= state
    else
        return MG.DancingMad.CurrentState > state
    end
end

--- 是否在状态前
---@param stateName string
---@param include boolean 是否包含
DM.BeLowState = function(stateName, include)
    local state = DM.State[stateName]
    if state == nil then
        -- 输出错误日志
        MG.Debug("[错误]状态不存在：" .. stateName)
    end
    if include then
        return MG.DancingMad.CurrentState <= state
    else
        return MG.DancingMad.CurrentState < state
    end
end

-------------------------- Argus Events --------------------------
DM.OnEntityChannel = function(entityID, spellID, _)
    if spellID == 50179 and TensorReactions_CurrentCombatTimer < 30 then
        -- 初步设定开场读条，可能增加其他条件
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

-------------------------- MuAiGuide Events --------------------------
DM.Update = function()
    doSubEvents('Update')
end

DM.OnEnter = function()
    MG.Develop.Reg("DancingMad")
end

return DM