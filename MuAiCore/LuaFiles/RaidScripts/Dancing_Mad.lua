local DM = {} ---@ class DancingMad
DM.MapId = 1363
DM.NameCN = '妖星乱舞绝境战'
DM.Version = '0.0.1'
DM.ScriptName = 'Dancing_Mad';
DM.SubScripts = nil
---@type MuAiGuide
local MG

--- 执行子脚本
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
                d('----------------------------------------------------')
                local traceback = debug ~= nil and debug.traceback ~= nil and debug.traceback() or 'debug.traceback unavailable'
                MG.LogError('Error',
                        script.StateName .. '执行' .. eventName .. '失败',
                        { err = tostring(err), traceback = traceback },
                        true)
                MG.Debug('错误信息:' .. tostring(err))
                MG.Debug('调用堆栈:' .. traceback)
                d('----------------------------------------------------')
                
            end
        end
    end
end

local printCurrentState = function()
    MG.Debug('当前副本阶段：' .. DM.StateNames[MG.DancingMad.CurrentState])
end

---数据初始化
local dataInit = function()
    MG.DancingMad = {
        -- 公共变量
        Init = true,
        Casting = {},
        CastingCache = {},
        IceThunderTimer = 0,
        IceType = nil,
        ThunderType = nil,
        -- 阶段变量
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
                Time = 0, --火判定时间
                GuideData = nil,
                GuideDataLink = nil,
                linkGuideFinish = false,
                iceDir = nil
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
                NextState = 'P1SleepOrConfused',
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
                exchanged = false,
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
                GuideDataCache = {},
                markCache = {},
                groupOrdersLast = {},
                groupOrders = {},
                kickBoss = {},
                kickPreSkill = 0,
                kickTimer = 0,
                kickDrawing = false,
                fixFlg = false,
                marked = {}
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
        },
        P3 = {
            Chaos = nil,
            ExDeath = nil,
            Kefka = nil,
            Elements = {
                Fire = nil,
                Water = nil,
                Wind = nil,
                Guide1 = nil,
                Guide2 = nil,
                exGuidePos = nil,
                chaosGuidePos = nil,
                bigCircleTimer = 0,
                exCasting = false,
                exPull = nil,
                chaosPull = nil,
                gather = nil,
                FireBuff = nil, --点名火buff的职能
                LongBuff = 0,
                ShortBuff = 0,
                BuffEndTimer = {
                    [1600] = 0,
                    [1601] = 0,
                },
                BuffStart = {
                    [1600] = false,
                    [1601] = false,
                },
                Buff1End = false,
                Buff2End = false,
            },
            Implosion = {
                skillId = 0,
                OnDraw = false,
                Timer = 0,
            },
            WacuumWave = {
                Timer = 0,
                Start = false,
                BeforeKick = nil,
                AfterKick = nil,
            },
            UmbraSmash = {
                Timer = 0,
                Start = false,
                LeadEnd = false,
                drawPos = nil,
                LeadPlayer = nil
            },
            LockFace = {
                buffType = 0,
                enable = false,
                onDoing = false
            },
            UltimaBlaster = {
                Lines = {},
                Markers = {},
                fromPos = {},
                GuideData = nil,
                DrawData = nil,
                StartTimer = 0,
                guideMarked = false
            },
            ThunderIII = {
                Start = false,
                Timer = 0,
            },
            Mark = {
                Finish = false,
                -- 自身标记类型=buffid
                SelfType = 0,
                BuffTypeMap = nil,
                JobDelay = nil,
                JobDelayTimer = 0,
                AnyHasMark = false,
                MarkCnt = {
                    [3004] = 0,
                    [3005] = 0,
                    [3006] = 0,
                },
            },
            BlackHolds = {
                temp = {},
                wave = 0,
                tempCnt = 0,
                Object = {},
                JumpTimer = 0,
                MarkedPlayers = {},
                MarkCheckTimer = 0,
                MarkCheckCnt = 0,
                allMarkFind = false,
                CastedEnt = {},
                tetherInfo = {},
                sourceObject = {},
                guideData = {}
            },
            SlapHappy = {
                OnDraw = false,
                CasterId = 0,
                Timer = 0,
                SkillId = 0,
            },
            LookUponMe = {
                OnDraw = false,
                Timer = 0,
                CasterId = 0,
            },
            DamningEdict = {
                OnDraw = false,
                Timer = 0,
            },
            TakeTower = {
                aoeCache = {},
                castCache = {},
                stampCnt = 0,
                isDps = nil,
                firstEntity = nil,
                secondEntity = nil,
                boomPos = nil,
                isDps = nil,
                Put1Pos = nil,
                Put2Pos = nil,
                Guide1 = nil,
                Guide2 = nil,
                Timer = 0,
                TimerTower1 = 0,
                TimerTower2 = 0,
            }
        },
        P4 = {
            Chaos = {
                CurrentIsReal = false,
                Timer = 0,
                -- 水 火 buffId
                CastType = 0,
                Timer = 0,
            },
            ExDeath = {
                CurrentIsReal = false,
                Timer = 0,
                FirstJudge = false,
                DeathBeamObj = nil,
                AliveBeamObj = nil,
                DothBeamObj = nil,
                deathDir = nil,
                deathDrawPos = nil,
                aliveDir = nil,
                aliveDrawPos = nil,
                GuideData = nil,
                JudgeTimer = 0,
                DrawTimer = 0
            },
            ThunderWater = {
                Guide1 = nil,
                Guide2 = nil,
                Guide2Offset = nil,
                IceType = nil,
                ToEye2Timer = 0,
            },
            WaterFire1 = {
                Guide1 = {},
                Guide2 = {},
                AoeTimer = 0,
                Type = false,
            },
            WaterFire2 = {
                Guide1 = {},
                Guide2 = {},
                AoeTimer = 0,
                Type = false,
                IceType = nil,
                ThunderType = nil
            },
            Eye1 = {
                GuidePos = nil,
                thunder = nil,
                type = false,
                Owner = nil,
                LostTimer = 0,
                Locked = false,
                wasDraw = false,
            },
            Eye2 = {
                GuidePos = nil,
                thunder = nil,
                type = false,
                Owner = nil,
                LostTimer = 0,
                Locked = false,
                wasDraw = false,
            },
            MoveOrStopHit = nil,
            StateVfx = {},
            Buff = {},
            CheckFinish = {}

        },
        P5 = {
            Kefka = nil,
            UltimaRepeater = {},
            Blood = {
                Cross12 = nil,
                Cross23 = nil,
                Cross34 = nil,
                Cross14 = nil,
                Aoe = {},
                AoeOut = {},
                GuideData = {},
                drawData = {
                    first = nil,
                    second = nil,
                },
            },
            MaddeningOrchestra = {
                FirstHitTimer = 0,
                FirstHits = {},
                Guide1 = nil,
                Guide2 = nil,
                Guide3 = nil,
                GuideOut = nil,
                RedBuff = nil,
                BlueBuff = nil,
            },
            Celestriad = {
                AllTowers = nil,
                TowerFire = nil,
                TowerIce = nil,
                TowerThunder = nil,
                BuffPlayerStart = nil,
                groupBuffPos = {},
                groupNoBuff = nil,
                wave = 0,
                CastingTowers = {},
                Guiding = {},
                GuideData = {},
                GuideDataOut = {},
                GuideDataIn = {},
                castingCache = {},
                CatastrophicChoiceId = 0,
            },
            GroundFire = {
                Info = {},
                OverTime = {},
                OnCreate = {},
                AoePos = {},
                OnCast = {}
            },
            Forsaken = {
                wave = 1,
                Guide = {}
            }
        },
    }
    ---判定P4指定BUFF是否为真BUFF
    ---@return boolean | nil 真假|为空表示Buff不存在 
    MG.DancingMad.IsRealBuff = function(buffId, job)
        if MG.DancingMad == nil then
            return nil
        end
        job = job or MG.SelfPos
        local buffList = MG.DancingMad.P4.Buff[MG.SelfPos]
        if buffList == nil or buffList[buffId] == nil then
            return nil
        end
        return buffList[buffId]
    end
    MG.LogSystemInit()
    MG.Info(DM.NameCN .. '数据初始化完毕！')
end

local developForceChange = function(stateName)
    if MG.DancingMad == nil or not MG.DancingMad.Init then
        dataInit()
    end
    DM.ChangeState(stateName)
end

--- 屏蔽特效开关缓存
local effectSwitch

--- 关闭的特效的技能ID
local closeList = {
    [47764] = { old0 = nil, old1 = nil },
    [47768] = { old0 = nil, old1 = nil },
    [47771] = { old0 = nil, old1 = nil },
    [47774] = { old0 = nil, old1 = nil },
    [47775] = { old0 = nil, old1 = nil },
    [47776] = { old0 = nil, old1 = nil },
    [47777] = { old0 = nil, old1 = nil },
}

local defineColors = function()
    -- 一次性创建所有颜色
    ---@type ShapeDrawer
    DM.redDrawer = MG.CreateDrawer(1, 0, 0, nil, 2)
    ---@type ShapeDrawer
    DM.orangeDrawer = MG.CreateDrawer(1, 0.5, 0, nil, 2)
    ---@type ShapeDrawer
    DM.yellowDrawer = MG.CreateDrawer(1, 1, 0, nil, 2)
    ---@type ShapeDrawer
    DM.blueDrawer = MG.CreateDrawer(0, 0, 1, nil, 2)
    ---@type ShapeDrawer
    DM.greenDrawer = MG.CreateDrawer(0, 1, 0, nil, 2)
    ---@type ShapeDrawer
    DM.purpleDrawer = MG.CreateDrawer(1, 0, 1, nil, 2)
    ---@type ShapeDrawer
    DM.cyanDrawer = MG.CreateDrawer(0, 1, 1, nil, 2)
    ---@type ShapeDrawer
    DM.litBlue = MG.CreateDrawer(0, 0.3, 0.5, 0.3, 2)
end

--- 屏蔽特效
local applyEffectBinder = function()
    if effectSwitch ~= MG.Config.DmuCfg.BindEffect then
        if MG.Config.DmuCfg.BindEffect then
            if closeList[47764].old0 == nil then
                for skillId, _ in pairs(closeList) do
                    closeList[skillId].old0 = Argus.getActionAOEType(skillId, 0)
                    closeList[skillId].old1 = Argus.getActionAOEType(skillId, 1)
                    Argus.setActionAOEType(skillId, 0, 0)
                    Argus.setActionAOEType(skillId, 1, 0)
                end
            end
            MG.Debug('屏蔽特效已执行！')
        else
            for skillId, _ in pairs(closeList) do
                if closeList[skillId].old0 ~= nil then
                    Argus.setActionAOEType(skillId, 0, closeList[skillId].old0)
                end
                if closeList[skillId].old1 ~= nil then
                    Argus.setActionAOEType(skillId, 1, closeList[skillId].old1)
                end
            end
            MG.Debug('屏蔽特效已取消！')
        end
        effectSwitch = MG.Config.DmuCfg.BindEffect
    end
end
--------------------------------------------- public ---------------------------------------------

-- 阶段名称定义，注意每个阶段都必须有Start和End否则会出错
DM.StateNames = {
    'NotStart',
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
    --- P3 ---
    'P3Start',
    'P3ElementsStart',
    'P3ElementsBuff1',
    'P3ElementsBuff2',
    'P3UltimaBlaster',
    'P3BlackHolePre',
    'P3BlackHoleStart',
    'P3BlackHoleAppear1',
    'P3BlackHole1_1',
    'P3BlackHole1_2',
    'P3BlackHoleAppear2',
    'P3BlackHole2_1',
    'P3BlackHole2_2',
    'P3BlackHole2_3',
    'P3BlackHoleAppear3',
    'P3BlackHole3_1',
    'P3BlackHole3_2',
    'P3BlackHole3_3',
    'P3BlackHoleAppear4',
    'P3BlackHole4_1',
    'P3BlackHole4_2',
    'P3AoePut1',
    'P3AoePut2',
    'P3Tower1',
    'P3Tower2',
    'P3End',
    --- P4 ---
    'P4Start',
    'P4ExDeathBuff1',
    'P4ChaosBuff1',
    'P4ExDeathBuff2',
    'P4ChaosBuff2',
    'P4ExDeathBuff3',
    'P4ExDeath3Judge',
    'P4ThunderWater1',
    'P4Eye1',
    'P4WaterFire1',
    'P4WaterFire1Put',
    'P4ThunderWater2',
    'P4Eye2',
    'P4WaterFire2',
    'P4WaterFire2Put',
    'P4End',
    -- p5 --
    'P5Start',
    'P5BloodStart',
    'P5Blood1End',
    'P5Blood2End',
    'P5Blood3End',
    'P5MaddeningOrchestra',
    'P5MaddeningOrchestra1End',
    'P5MaddeningOrchestra2End',
    'P5UltimaRepeater2',
    'P5CelestriadPre',
    'P5Celestriad',
    'P5CelestriadGetData',
    'P5CelestriadEnd',
    'P5UltimaRepeater3',
    'P5GroundFire',
    'P5MaddeningOrchestra2',
    'P5MaddeningOrchestra2_1End',
    'P5MaddeningOrchestra2_2End',
    'P5UltimaRepeater4',
    'P5Forsaken',
    'P5BeforeEnd',
    'P5End',
}

---@class ThunderType 雷类型
DM.ThunderType = {
    Left13 = 1,
    Left24 = 2,
    Right13 = 3,
    Right24 = 4
}

---@class IceType 冰类型
DM.IceType = {
    danger13 = 1,
    danger24 = 2,
}
--- 初始化
DM.Init = function(M)
    DM.State = {}
    -- 绑定阶段序号
    for i = 1, #DM.StateNames do
        DM.State[DM.StateNames[i]] = i
    end
    DM.SubScripts = {}
    MG = M
    defineColors()
    local folderPath = MuAiGuideRoot .. 'RaidScripts\\Dancing_Mad_Subs'
    local list = FolderList(folderPath)
    for _, fileName in pairs(list) do
        M.Debug('       加载副本[' .. DM.ScriptName .. ']的子脚本：' .. fileName)
        local filePath = folderPath .. '\\' .. fileName
        local script = FileLoad(filePath)
        if type(script) ~= 'table' then
            M.Debug('       加载失败，获取到内容如下：')
            M.Debug('-------------------------------')
            d(script)
            M.Debug('-------------------------------')
        else
            if script.Init ~= nil then
                script.Init(DM, M)
                table.insert(DM.SubScripts, script)
            end
        end
    end
end

--- 中心点
DM.Center = { x = 100, y = 0, z = 100 }

DM.ChangeState = function(stateName)
    local state = DM.State[stateName]
    if state == nil then
        -- 输出错误日志
        local traceback = debug ~= nil and debug.traceback ~= nil and debug.traceback() or 'debug.traceback unavailable'
        MG.LogError('Error', '切换状态失败，状态不存在：' .. tostring(stateName), {
            traceback = traceback,
        }, true)
        -- 直接抛出 Lua 异常，强制中断，避免继续执行
        error('ChangeState 禁止传入 nil 状态！')
        return
    end
    local oldState = MG.DancingMad.CurrentState
    local oldStateName = DM.StateNames[oldState] or tostring(oldState)
    MG.DancingMad.CurrentState = state
    MG.Info(DM.NameCN .. '阶段切换：' .. oldStateName .. ' -> ' .. stateName, false, true)
end

--- 切到下一个状态
DM.GoNextSate = function()
    MG.DancingMad.CurrentState = MG.DancingMad.CurrentState + 1
    local log = DM.NameCN .. '阶段切换：' .. DM.StateNames[MG.DancingMad.CurrentState]
    MG.Info(log, false, true)
end

--- 是否在状态中
---@param stateName string
DM.InState = function(stateName)
    local state = DM.State[stateName]
    if state == nil then
        MG.Debug('[错误]判断当前状态失败：' .. stateName .. '不存在')
        return false
    end
    if MG.DancingMad.CurrentState == state then
        return true
    end
    return false
end

--- 当前阶段是否已经在某个阶段之后
DM.OverState = function(stateName, include)
    local state = DM.State[stateName]
    if state == nil then
        -- 输出错误日志
        MG.Debug('[错误]状态不存在：' .. stateName)
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
        MG.Debug('[错误]状态不存在：' .. stateName)
    end
    if include then
        return MG.DancingMad.CurrentState <= state
    else
        return MG.DancingMad.CurrentState < state
    end
end

--- 计算劈啪啪暴雷类型
---@param thundersAoe GroundAOE
---@return ThunderType
DM.CalcThunderType = function(thundersAoe)
    local h2pi = MG.SetHeading2Pi(thundersAoe.heading)
    if MG.IsSameDirection(h2pi, math.pi * 7 / 4) then
        if thundersAoe.x > 100 and thundersAoe.x < 107 then
            return DM.ThunderType.Right13
        elseif thundersAoe.x > 107 and thundersAoe.x < 114 then
            return DM.ThunderType.Right24
        end
    elseif MG.IsSameDirection(h2pi, math.pi / 4) then
        if thundersAoe.x > 93 and thundersAoe.x < 100 then
            return DM.ThunderType.Left13
        elseif thundersAoe.x > 86 and thundersAoe.x < 93 then
            return DM.ThunderType.Left24
        end
    end
end

---计算冰AOE类型
---@return IceType
DM.CalcIceType = function(iceAoe)
    local h2pi = MG.SetHeading2Pi(iceAoe.heading)
    if MG.IsSameDirection(h2pi, math.pi / 4)
            or MG.IsSameDirection(h2pi, math.pi * 5 / 4) then
        return DM.IceType.danger24
    elseif MG.IsSameDirection(h2pi, math.pi * 3 / 4)
            or MG.IsSameDirection(h2pi, math.pi * 7 / 4) then
        return DM.IceType.danger13
    end
end

---计算安全点
---@param thunderType 雷类型
---@param iceType 冰类型
DM.CalcMixPoint = function(thunder, ice)
    local near, far, center, same
    if thunder == DM.ThunderType.Left13 and ice == DM.IceType.danger13 then
        -- Left13 + danger13
        near = { x = 104, y = 0, z = 101.6568 }
        far = { x = 98.3432, y = 0, z = 96 }
        center = { x = 101, y = 0, z = 100.4 }
        same = true
    elseif thunder == DM.ThunderType.Left13 and ice == DM.IceType.danger24 then
        -- Left13 + danger24
        near = { x = 104, y = 0, z = 96 }
        far = { x = 90, y = 0, z = 110 }
        center = { x = 101, y = 0, z = 99 }
        same = false
    elseif thunder == DM.ThunderType.Left24 and ice == DM.IceType.danger13 then
        -- Left24 + danger13
        near = { x = 101.6568, y = 0, z = 104 }
        far = { x = 96, y = 0, z = 98.3432 }
        center = { x = 101, y = 0, z = 100.4 }
        same = true
    elseif thunder == DM.ThunderType.Left24 and ice == DM.IceType.danger24 then
        -- Left24 + danger24
        near = { x = 96, y = 0, z = 104 }
        far = { x = 110, y = 0, z = 90 }
        center = { x = 99, y = 0, z = 101 }
        same = false
    elseif thunder == DM.ThunderType.Right13 and ice == DM.IceType.danger13 then
        -- Right13 + danger13
        near = { x = 96, y = 0, z = 96 }
        far = { x = 110, y = 0, z = 110 }
        center = { x = 99, y = 0, z = 99 }
        same = false
    elseif thunder == DM.ThunderType.Right13 and ice == DM.IceType.danger24 then
        -- Right13 + danger24
        near = { x = 96, y = 0, z = 101.6568 }
        far = { x = 101.6568, y = 0, z = 96 }
        center = { x = 99, y = 0, z = 100.4 }
        same = true
    elseif thunder == DM.ThunderType.Right24 and ice == DM.IceType.danger13 then
        -- Right24 + danger13
        near = { x = 104, y = 0, z = 104 }
        far = { x = 90, y = 0, z = 90 }
        center = { x = 101, y = 0, z = 101 }
        same = false
    elseif thunder == DM.ThunderType.Right24 and ice == DM.IceType.danger24 then
        -- Right24 + danger24
        near = { x = 98.3432, y = 0, z = 104 }
        far = { x = 104, y = 0, z = 98.3432 }
        center = { x = 99.6, y = 0, z = 101 }
        same = true
    end
    return near, far, center, same
end

-- 公共画图aoeId
DM.commonDrawIds = { 47774, 47775, 47777, 47768 }

-- 公共指路排除的阶段
DM.notGuideState = { 'P1BuffTurn1', 'P4WaterFire2Put' }

---@param aoeInfo DirectionalAOE
DM.commonStartDraw = function(aoeInfo)
    if MG == nil or MG.DancingMad == nil or MG.DancingMad.Casting == nil then
        return
    end
    if table.contains(DM.commonDrawIds, (aoeInfo.aoeID)) then
        MG.DancingMad.Casting[aoeInfo.entityID] = aoeInfo
    end
end

DM.commonStartGuide = function(aoeInfo)
    if MG == nil or MG.DancingMad == nil then
        return
    end
    if table.contains(DM.commonDrawIds, (aoeInfo.aoeID)) and
            (MG.DancingMad.IceThunderTimer == 0 or TimeSince(MG.DancingMad.IceThunderTimer) < 1000)
    then
        MG.Debug('缓存冰雷AOE')
        MG.DancingMad.CastingCache[aoeInfo.entityID] = aoeInfo
        -- 1秒内的冰雷，抓取他们的类型
        if MG.DancingMad.IceThunderTimer == 0 then
            MG.DancingMad.IceThunderTimer = Now()
        end
        if aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768 then
            -- 冰
            if MG.DancingMad.IceType == nil then
                MG.DancingMad.IceType = DM.CalcIceType(aoeInfo)
            end
        elseif aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777 then
            -- 雷
            if MG.DancingMad.ThunderType == nil then
                MG.DancingMad.ThunderType = DM.CalcThunderType(aoeInfo)
            end
        end
    end
end

DM.CommonDraw = function()
    if MG == nil or MG.DancingMad == nil or MG.DancingMad.Casting == nil or table.size(MG.DancingMad.Casting) == 0 then
        return
    end
    if (DM.OverState('P1Start', true) and DM.BeLowState('P1End') and MG.Config.DmuCfg.P1.draw)
            or (DM.OverState('P4Start', true) and DM.BeLowState('P4End') and MG.Config.DmuCfg.P4.draw) then
        for id, aoeInfo in pairs(MG.DancingMad.Casting) do
            if aoeInfo.aoeCastType == 13 then
                if MG.Config.DmuCfg.BindEffect then
                    DM.purpleDrawer:addCone(aoeInfo.x, 0, aoeInfo.z, 20, math.pi / 2, aoeInfo.heading)
                else
                    DM.yellowDrawer:addCone(aoeInfo.x, 0, aoeInfo.z, 20, math.pi / 2, aoeInfo.heading, true)
                end
            elseif aoeInfo.aoeCastType == 12 then
                if MG.Config.DmuCfg.BindEffect then
                    DM.purpleDrawer:addRect(aoeInfo.x, 0, aoeInfo.z, 40, 10, aoeInfo.heading)
                else
                    DM.yellowDrawer:addRect(aoeInfo.x, 0, aoeInfo.z, 40, 10, aoeInfo.heading, true)
                end
            end
        end
    end
end

DM.CommonGuide = function()
    if MG == nil or MG.DancingMad == nil
            or MG.DancingMad.CastingCache == nil or table.size(MG.DancingMad.CastingCache) == 0
            or table.contains(DM.notGuideState, DM.StateNames[MG.DancingMad.CurrentState])
    then
        return
    end

    if ((DM.OverState('P1Start', true) and DM.BeLowState('P1End') and MG.Config.DmuCfg.P1.guide)
            or (DM.OverState('P4Start', true) and DM.BeLowState('P4End') and MG.Config.DmuCfg.P4.guide))
            and MG.DancingMad.IceType ~= nil and MG.DancingMad.ThunderType ~= nil then
        local far, near = DM.CalcMixPoint(MG.DancingMad.ThunderType, MG.DancingMad.IceType)
        local player = MG.GetPlayer()
        local guidePos
        if MG.IsTank(player.job) or MG.IsMelee(player.job) then
            guidePos = near
        else
            local disF = TensorCore.getDistance2d(far, player.pos)
            local disN = TensorCore.getDistance2d(near, player.pos)
            if disN > disF then
                guidePos = far
            else
                guidePos = near
            end
        end
        MG.FrameDirect(guidePos.x, guidePos.z)
    end
end

DM.CommonEndDraw = function(entityID)
    if MG == nil or MG.DancingMad == nil
            or MG.DancingMad.Casting == nil or table.size(MG.DancingMad.Casting) == 0 then
        return
    end
    ---@type DirectionalAOE
    local aoe = MG.DancingMad.Casting[entityID]
    if aoe ~= nil and TimeSince(aoe.startTime) > aoe.duration * 1000 - 200 then
        MG.DancingMad.Casting[entityID] = nil
    end
end

DM.CommonEndGuide = function(entityID)
    if MG == nil or MG.DancingMad == nil
            or MG.DancingMad.CastingCache == nil or table.size(MG.DancingMad.CastingCache) == 0 then
        return
    end
    local aoe = MG.DancingMad.CastingCache[entityID]
    if aoe ~= nil and TimeSince(aoe.startTime) > aoe.duration * 1000 - 200 then
        MG.DancingMad.CastingCache[entityID] = nil
    end
    if table.size(MG.DancingMad.CastingCache) == 0 then
        MG.DancingMad.IceType = nil
        MG.DancingMad.ThunderType = nil
        MG.DancingMad.IceThunderTimer = 0
        MG.Debug('清空冰雷AOE缓存')
    end
end

DM.ClearMarks = function()
    for i = 1, 8 do
        SendTextCommand("/mk clear <" .. i .. ">")
    end
    MG.Debug('执行清除标记。')
end

-------------------------- Argus Events --------------------------
DM.OnEntityChannel = function(entityID, spellID, targetID, channelTimeMax)
    if not MG.Config.DmuCfg.Enable or MG.DancingMad == nil then
        return
    end
    if spellID == 50179 and TensorReactions_CurrentCombatTimer < 30 then
        -- 恶狠狠毁荡
        dataInit()
        DM.ChangeState('P1Start')
    elseif spellID == 49740 then
        -- 终末双腕
        if DM.BeLowState('P2Start') then
            DM.ChangeState('P2Start')
        end
    elseif spellID == 49890 or spellID == 49891 then
        --决战
        if DM.BeLowState('P3Start') then
            DM.ChangeState('P3Start')
        end
    elseif spellID == 49884 then
        if DM.BeLowState('P4Start') then
            DM.ChangeState('P4Start')
        end
    elseif spellID == 47936 then
        if DM.BeLowState('P5Start') then
            DM.ChangeState('P5Start')
        end
    end
    doSubEvents('OnEntityChannel', entityID, spellID, targetID, channelTimeMax)
end

DM.OnEntityCast = function(entityID, spellID, castPos)
    doSubEvents('OnEntityCast', entityID, spellID, castPos)
    DM.CommonEndDraw(entityID)
    DM.CommonEndGuide(entityID)
end

DM.OnMarkerAdd = function(entityID, markerID)
    doSubEvents('OnMarkerAdd', entityID, markerID)
end

DM.OnAOECreate = function(aoeInfo)
    doSubEvents('OnAOECreate', aoeInfo)
    DM.commonStartDraw(aoeInfo)
    DM.commonStartGuide(aoeInfo)
end

DM.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    doSubEvents('OnEventObjectScriptFunc', entityID, a1, a2, a3)
end

DM.OnAddEntityVFX = function(vfxID, vfxName, primaryEntityID, secondaryEntityID, time, a5, a6)
    doSubEvents('OnAddEntityVFX', vfxID, vfxName, primaryEntityID, secondaryEntityID, time, a5, a6)
end

DM.OnMapEffect = function(a1, a2, a3)
    doSubEvents('OnMapEffect', a1, a2, a3)
end

DM.OnTetherChange = function(sourceEntityID, oldTetherID, oldTetherFlags, oldTargetID, newTetherID, newTetherFlags, newTargetID)
    doSubEvents('OnTetherChange', sourceEntityID, oldTetherID, oldTetherFlags, oldTargetID, newTetherID, newTetherFlags, newTargetID)
end

DM.OnEntityAdd = function(entityID, entityName)
    doSubEvents('OnEntityAdd', entityID, entityName)
end

-------------------------- MuAiGuide Events --------------------------
DM.Update = function()
    applyEffectBinder()
    doSubEvents('Update')
    DM.CommonDraw()
    DM.CommonGuide()
end

DM.OnEnter = function()
    MG.DancingMad = { CurrentState = 1 }
    MG.Develop.Reg('DancingMad')
    MG.Develop.LogState = function()
        printCurrentState()
    end
    MG.Develop.ForceChange = function(stateName)
        developForceChange(stateName)
    end
    MG.Log('State', '副本开始：' .. DM.NameCN)
end

DM.OnWipe = function()
    MG.DancingMad = { CurrentState = 1 }
    MG.Log('State', '灭团重置：' .. DM.NameCN)
end

return DM