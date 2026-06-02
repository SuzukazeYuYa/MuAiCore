local DM = {} ---@ class DancingMad
DM.MapId = 1363
DM.NameCN = '妖星乱舞绝境战'
DM.Version = '0.0.1'
DM.ScriptName = 'Dancing_Mad';
DM.SubScripts = nil
---@type MuAiGuide
local MG
-- 通用创建 Drawer 函数
local function CreateDrawer(r, g, b, a)
    local color = GUI:ColorConvertFloat4ToU32(r, g, b, a or 0.3)
    return Argus2.ShapeDrawer:new(color, color, color, GUI:ColorConvertFloat4ToU32(1, 1, 1, 1), 1)
end
-- 一次性创建所有颜色
DM.redDrawer = CreateDrawer(1, 0, 0)
DM.yellowDrawer = CreateDrawer(1, 1, 0)
DM.blueDrawer = CreateDrawer(0, 0, 1)
DM.greenDrawer = CreateDrawer(0, 1, 0)
DM.purpleDrawer = CreateDrawer(1, 0, 1)
DM.cyanDrawer = CreateDrawer(0, 1, 1)
DM.State = {
    P1Start = 1000,
    P1TrueFalse1 = 1001,
    
    LineKickBacked = 1002,
    P1TrueFalse2 = 1002,
    P1TrueFalse1End = 1003,
    P1TrueBeamEnd = 1003,

    P1End = 1099,
}

--- 初始化，将拆分的脚本合并加载
DM.Init = function(M)
    DM.SubScripts = {}
    MG = M
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

DM.ChangeState = function(state)
    if state == nil then
        -- 输出错误日志
        MG.Debug("[错误] DM.ChangeState 传入了 nil 状态！！！")
        MG.Debug("调用堆栈：" .. debug.traceback()) -- 打印完整调用栈
        -- 直接抛出 Lua 异常，强制中断，避免继续执行
        error("DM.ChangeState 禁止传入 nil 状态！")
        return
    end
    MG.DancingMad.CurrentState = state
    MG.Debug("阶段切换：" .. tostring(state))
end
local doSubEvents = function(eventName, ...)
    if not MG.Config.DmuCfg.state.global.enable or MG.DancingMad == nil then
        return
    end

    for _, script in pairs(DM.SubScripts or {}) do
        if MG.Config.DmuCfg.state[script.StateName].enable and script[eventName] then
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
    --- @class DancingMadData
    MG.DancingMad = {
        P1_1Fire = { ---@class P11Fire 第1次玄乎乎魔法数据
            BossMark = 0,
            PlayerMark = 0,
            GatherPlayers = {},
            Timer = 0
        },
    }
    MG.DancingMad.CurrentState = DM.State.P1Start
    MG.Info(DM.NameCN .. '数据初始化完毕！')
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