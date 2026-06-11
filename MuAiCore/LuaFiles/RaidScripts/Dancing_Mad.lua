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
        if MG.Config.DmuCfg[script.StateName].enable
                and script[eventName]
                and DM.OverState(script.StateName .. 'Start', true)
                and DM.BeLowState(script.StateName .. 'End', true)
        then
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
    MG.DancingMad = {
        P1 = {
            Death = {
                Timer = 0,
                InState = false,
                MT = nil,
                ST = nil,
            },
            Death2 = {
                Timer = 0,
                OnDraw = false,
            },
            Fire1 = {
                BossMark = 0,
                PlayerMark = 0,
                GatherPlayers = {},
                Time = 0 --火判定时间
            },
            Beam = {
                Order = nil,
                --被激光射了的人
                Shoot = nil,
                -- 没被射
                UnShoot = nil,
                TowerPos = nil,
                Time = 0,
            },
            Tower = {
                Aoe = {},
                GuideData = nil
            },
            Turn1 = {
                BuffJobs = nil,
                SelfGroupTurner = nil,
                SelfGroupTurnerObj = nil,
                NextState = 'P1DeathBfLine2',
                thGroupGuidePos = { x = 91, y = 0, z = 100 },
                dpsGroupGuidePos = { x = 109, y = 0, z = 100 },
                offSetTh = { x = 1, y = 0, z = 0 },
                offSetDps = { x = -1, y = 0, z = 0 }
            },
            -- 放黑泥1
            Line2 = {
                dangerDir = nil,
                GatherPlayers = nil,
                DisPlayers = nil,
                Guide0 = nil,
                Guide1 = nil,
                Guide2 = nil,
                Timer = 0,
            },
            -- 放黑泥2
            Line3 = {
                GatherPlayers = nil,
                DisPlayers = nil,
                Guide1 = nil,
                Guide2 = nil,
                Timer = 0,
                Shits = nil,
                UpShit = nil,
                DownShit = nil,
            },
            Turn2 = {
                BuffJobs = nil,
                SelfGroupTurner = nil,
                SelfGroupTurnerObj = nil,
                NextState = 'P1Turn2End',
                thGroupGuidePos = nil,
                dpsGroupGuidePos = nil,
                offSetTh = { x = 0, y = 0, z = 1 },
                offSetDps = { x = 0, y = 0, z = -1 }
            },
            Shit = {
                StateTimer = 0,
                Guide1 = nil,
                Guide2 = nil,
                Boomed = {},
                first = true
            },
            TeleTrouncing = {
                BuffInfo = nil,
                Guide1 = nil,
                Guide2 = nil,
                Timer = 0,
                Reference = nil
            },
            Turn3 = {
                BuffJobs = nil,
                SelfGroupTurner = nil,
                SelfGroupTurnerObj = nil,
                NextState = 'SleepOrConfused',
                thGroupGuidePos = { x = 94, y = 0, z = 94 },
                dpsGroupGuidePos = { x = 106, y = 0, z = 106 },
                offSetTh = { x = 1, y = 0, z = 1 },
                offSetDps = { x = -1, y = 0, z = -1 }
            },
            -- 放完箭头之击退之后的指路
            LastLink = {
                GuideData = {
                    MT = { x = 100, z = 92 },
                    ST = { x = 108, z = 100 },
                    H1 = { x = 84, z = 100 },
                    H2 = { x = 100, z = 116 },
                    D1 = { x = 92, z = 100 },
                    D2 = { x = 100, z = 108 },
                    D3 = { x = 100, z = 84 },
                    D4 = { x = 116, z = 100 },
                },
                SleepGroup = nil,
                Timer = 0,
            },

            AutoLookAt = {
                enable = false,
                boss = nil,
                Timer = 0,
            },
            FireThunder = {
                BossMark = 0,
                PlayerMark = 0,
                GatherPlayers = {},
                Thunders = {},
                Time = 0, --火判定时间
                BaseGuideData = {
                    H1 = { x = 100, y = 0, z = 85.86 },
                    D1 = { x = 107.07, y = 0, z = 92.93 },
                    D4 = { x = 114.14, y = 0, z = 100 },
                    MT = { x = 92.93, y = 0, z = 92.93 },
                    D2 = { x = 107.07, y = 0, z = 107.07 },
                    H2 = { x = 85.86, y = 0, z = 100 },
                    ST = { x = 92.93, y = 0, z = 107.07 },
                    D3 = { x = 100, y = 0, z = 114.14 }
                },
                GuideData = nil,
                MoveTable = nil,
                DrawCalled = false,
            },
        },
        P2 = {
            Towers = {
                spawn = {},
                temp = {},
                guideDir = {
                    { finish = false, skill = 0, guideData = nil },
                    { finish = false, skill = 0, guideData = nil },
                    { finish = false, skill = 0, guideData = nil },
                    { finish = false, skill = 0, guideData = nil, backData = nil },
                },
                markCnt = 0,
                Timer = 0,
                curMarks = {},
                wave = 0,
                groupA = {},
                groupB = {},
                doing = {},
                standBy = {},
                GuideData = {},
                markCache = {},
                groupOrders = {},
                kickBoss = {},
                kickPreSkill = 0,
                kickTimer = 0,
                kickDrawing = false,
            },
            Trine = {
                wave = 1,
                TimerStart = 0,
                Timer = 0,
                DrawPos = {},
            },
            FarNearDeath = {
                Timer = 0,
                OnDraw = false,
            }
        }
    }

    MG.Info(DM.NameCN .. '数据初始化完毕！')
end

-- 阶段名称定义，注意每个阶段都必须有Start和End否则会出错
DM.StateNames = {
    --- P1 ---
    'P1Start',
    'P1TrueFalse1',
    'P1LineKickBacked',
    'P1TrueFalse2',
    'P1TrueFalse1End',
    'P1BeamEnd',
    'P1TowerBoom',
    'P1BuffTurn1',
    'P1DeathBfLine2',
    'P1Line2Start',
    'P1Line2_1', --1线消失
    'P1Line2_2', --2线消失
    'P1DeathBfLine3',
    'P1Line3_1',
    'P1Line3_2',
    'P1Turn2End',
    'P1ShitBoom',
    'P1TeleTrouncing',
    'P1TeleTrouncingGetBuff',
    'P1ArrowPut',
    'P1SleepOrConfused',
    'P1Teleport',
    'P1FireThunder',
    'P1End',
    --- P2 ---
    'P2Start', -- 8轮踩塔开始
    'P2T8Start',
    'P2T8InitMark',
    'P2T8End',
    'P2T8LastKick',
    'P2TrineStart',
    'P2End',
}
-- 
--- 初始化
DM.Init = function(M)
    DM.State = {}
    -- 绑定阶段序号
    for i = 1, #DM.StateNames do
        DM.State[DM.StateNames[i]] = i
    end
    DM.SubScripts = {}
    MG = M
    -- 一次性创建所有颜色
    DM.redDrawer = MG.CreateDrawer(1, 0, 0, nil, 2)
    DM.yellowDrawer = MG.CreateDrawer(1, 1, 0, nil, 2)
    DM.blueDrawer = MG.CreateDrawer(0, 0, 1, nil, 2)
    DM.greenDrawer = MG.CreateDrawer(0, 1, 0, nil, 2)
    DM.purpleDrawer = MG.CreateDrawer(1, 0, 1, nil, 2)
    DM.cyanDrawer = MG.CreateDrawer(0, 1, 1, nil, 2)
    local folderPath = MuAiGuideRoot .. "RaidScripts\\Dancing_Mad_Subs"
    local list = FolderList(folderPath)
    for _, fileName in pairs(list) do
        M.Debug("       加载副本[" .. DM.ScriptName .. "]的子脚本：" .. fileName)
        local filePath = folderPath .. "\\" .. fileName
        local script = FileLoad(filePath)
        if type(script) ~= "table" then
            M.Debug('       加载失败，获取到内容如下：')
            M.Debug('-------------------------------')
            d(script)
            M.Debug('-------------------------------')
        else
            script.Init(DM, M)
            table.insert(DM.SubScripts, script)
        end
    end
end

DM.Center = { x = 100, y = 0, z = 100 }
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
    if state == nil then
        MG.Debug("[错误]切换状态失败，状态不存在：" .. stateName)
        return false
    end
    if MG.DancingMad.CurrentState == state then
        return true
    end
    return false
end

DM.OverState = function(stateName, include)
    local state = DM.State[stateName]
    if state == nil then
        -- 输出错误日志
        d("[MuAiGuide][错误]状态不存在：" .. stateName)
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
        -- 恶狠狠毁荡
        dataInit()
        DM.ChangeState('P1Start')
    elseif spellID == 49740 then
        -- 终末双腕
        if DM.BeLowState('P2Start') then
            DM.ChangeState('P2Start')
        end
    end

    doSubEvents('OnEntityChannel', entityID, spellID)
end

DM.OnEntityCast = function(entityID, spellID, castPos)
    doSubEvents('OnEntityCast', entityID, spellID, castPos)
end

DM.OnMarkerAdd = function(entityID, markerID)
    doSubEvents('OnMarkerAdd', entityID, markerID)
end

DM.OnAOECreate = function(aoeInfo)
    doSubEvents('OnAOECreate', aoeInfo)
end

DM.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    doSubEvents('OnEventObjectScriptFunc', entityID, a1, a2, a3)
end

DM.OnAddEntityVFX = function(vfxID)
    doSubEvents('OnAddEntityVFX', vfxID)
end

DM.OnMapEffect = function(a1, a2, a3)
    doSubEvents('OnMapEffect', a1, a2, a3)
end

DM.OnTetherChange = function(sourceEntityID, oldTetherID, oldTetherFlags, oldTargetID, newTetherID, newTetherFlags, newTargetID)
    doSubEvents('OnTetherChange', sourceEntityID, oldTetherID, oldTetherFlags, oldTargetID, newTetherID, newTetherFlags, newTargetID)
end

-------------------------- MuAiGuide Events --------------------------
DM.Update = function()
    doSubEvents('Update')
end

DM.OnEnter = function()
    MG.DancingMad = {}
    MG.DancingMad.CurrentState = 0
    MG.Develop.Reg("DancingMad")
end

return DM