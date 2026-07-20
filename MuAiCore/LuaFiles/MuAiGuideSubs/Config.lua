local Config = {}
--[[
===========================
    配置文件处理模块
===========================
]]
local reservedFileNames = {
    CON = true,
    PRN = true,
    AUX = true,
    NUL = true,
}
for index = 1, 9 do
    reservedFileNames['COM' .. index] = true
    reservedFileNames['LPT' .. index] = true
end

Config.isValidConfigName = function(fileName)
    if type(fileName) ~= 'string' or fileName == '' or #fileName > 120 then
        return false
    end
    if fileName:find('..', 1, true)
            or fileName:find('[<>:"/\\|%?%*%c]')
            or fileName:find('%s')
            or fileName:sub(-1) == '.'
    then
        return false
    end
    local stem = string.upper(fileName:match('^[^%.]+') or fileName)
    return not reservedFileNames[stem]
end

---@param M MuAiGuide
local LoadUIConfig = function(M)
    M.Config = {}
    M.Config.MainPath = GetLuaModsPath() .. 'MuAiCore\\Configs'
    M.Config.MainFile = 'MainConfig.lua'

    M.Config.FruGuidePath = M.Config.MainPath .. '\\FruGuide'
    M.Config.FruGuideFile = 'GuideConfig.lua'
    M.Config.FruMitigationPath = M.Config.MainPath .. '\\FruMitigation'
    M.Config.FruMitigationFile = 'FruMitigation.lua'

    M.Config.DmuGuidePath = M.Config.MainPath .. '\\DmuGuide'
    M.Config.DmuGuideFile = 'GuideConfig.lua'
    M.Config.DmuMitig = M.Config.MainPath .. '\\DmuMitig'

    M.Config.DmuCatZMigPath = M.Config.MainPath .. '\\DmuMitig\\CatZ'
    M.Config.DmuCatZMigFile = 'Config.lua'

    M.Config.Key1 = { 'Shift', 'Ctrl', 'Alt' }
    M.Config.Key2 = {}
    for i = 65, 90 do
        table.insert(M.Config.Key2, string.char(i))
    end
    table.insert(M.Config.Key2, '~')

    -- 读取主存档
    local defMainCfg = M.CreateDefMainCfg()
    M.Config.Main = defMainCfg -- 这里只是让编辑器可以默认识别，无实际作用
    M.Config.Main = M.LoadConfig(M.Config.MainPath, M.Config.MainFile, defMainCfg)
    M.Config.MainPrevious = table.deepcopy(M.Config.Main)
    --- 读取绝伊甸存档
    local defFruCfg = M.CreateFruDefaultCfg()
    M.Config.FruCfg = defFruCfg  -- 这里只是让编辑可以默认识别，无实际作用
    M.Config.FruCfg = M.LoadConfig(M.Config.FruGuidePath, M.Config.FruGuideFile, defFruCfg)
    M.Config.FruCfgPrevious = table.deepcopy(M.Config.FruCfg)
    M.Config.FruCustomList = M.LoadFileList(M.Config.FruGuidePath, { 'GuideConfig.lua' })
    M.Config.FruCustomListIndex = 1
    --- 读取绝妖星存档
    local defDmuCfg = M.CreateDmuDefaultCfg()
    M.Config.DmuCfg = defDmuCfg  -- 这里只是让编辑可以默认识别，无实际作用
    M.Config.DmuCfg = M.LoadConfig(M.Config.DmuGuidePath, M.Config.DmuGuideFile, defDmuCfg)
    M.Config.DmuCfgPrevious = table.deepcopy(M.Config.DmuCfg)
    M.Config.DmuCustomList = M.LoadFileList(M.Config.DmuGuidePath, { 'GuideConfig.lua' })
    M.Config.DmuCustomListIndex = 1

    --local defDmuCatZCfg = M.CreateDmuMigCfg()
    --M.Config.DmuCatZCfg = defDmuCatZCfg  -- 这里只是让编辑可以默认识别，无实际作用
    --M.Config.DmuCatZCfg = M.LoadConfig(M.Config.DmuCatZMigPath, M.Config.DmuCatZMigFile, defDmuCatZCfg)
    --M.Config.DmuCatZCfgPrevious = table.deepcopy(M.Config.DmuCatZCfg)

    M.Config.DmuMig = {}
end

---@param M MuAiGuide
Config.init = function(M)
    M.LoadDefWithOutRaidSetting = function()
        local oldConfig = M.Config.Main
        M.Config.Main = M.CreateDefMainCfg()
        M.Config.Main.DrawBlackList = oldConfig.DrawBlackList
        M.Config.Main.M11SExDraw = oldConfig.M11SExDraw
        M.Config.Main.M11SOrbitalOmenAllMelee = oldConfig.M11SOrbitalOmenAllMelee
        M.Config.Main.M11SKickType = oldConfig.M11SKickType
        M.Config.Main.M11SGatherType = oldConfig.M11SGatherType
        M.Config.Main.M12SP4UpTime = oldConfig.M12SP4UpTime
        M.Config.Main.M12SP4Type = oldConfig.M12SP4Type
        M.Config.Main.M12SP4SendMacro = oldConfig.M12SP4SendMacro
        M.Config.Main.M12SP2is13 = oldConfig.M12SP2is13
        M.Config.Main.M12SAutoFace1 = oldConfig.M12SAutoFace1
        M.Config.Main.M12SAutoFace2 = oldConfig.M12SAutoFace2
        M.Config.Main.M12SAutoFaceType = oldConfig.M12SAutoFaceType
        M.Config.Main.M12SExDraw = oldConfig.M12SExDraw
        M.Config.Main.Merchant = oldConfig.Merchant
        M.Config.Main.MerchantDraw = oldConfig.MerchantDraw
        M.Config.Main.MerchantGuide = oldConfig.MerchantGuide
        M.Config.Main.MerchantLockFace = oldConfig.MerchantLockFace
        M.Config.Main.MerchantAimTool = oldConfig.MerchantAimTool
        M.InfoNoLog('已恢复默认设置.')
    end
    M.CreateDefMainCfg = function()
        local mainCfg = {
            JobOrder = {
                19, 21, 32, 37,
                24, 33, 40, 28,
                34, 20, 22, 30, 39, 41,
                31, 23, 38,
                27, 42, 25, 35
            },
            --- 指路工具颜色
            GuideColor = { r = 0, g = 1, b = 1, a = 0.5 },
            --- 多人指路工具颜色
            MultiColor = {
                ['MT'] = { r = 1.0, g = 0.0, b = 0.0, a = 0.5 },
                ['ST'] = { r = 1.0, g = 0.5, b = 0.0, a = 0.5 },
                ['H1'] = { r = 1.0, g = 1.0, b = 0.0, a = 0.5 },
                ['H2'] = { r = 0.0, g = 1.0, b = 0.0, a = 0.5 },
                ['D1'] = { r = 0.0, g = 1.0, b = 1.0, a = 0.5 },
                ['D2'] = { r = 0.0, g = 0.0, b = 1.0, a = 0.5 },
                ['D3'] = { r = 0.2, g = 0.0, b = 0.5, a = 0.5 },
                ['D4'] = { r = 1.0, g = 0.3, b = 0.7, a = 0.5 }
            },
            --- 指路工具颜色（分摊）
            GuidePairColor = { r = 0, g = 0, b = 1, a = 0.5 },
            ShowTargetPos = true,
            ShowTargetPosTank = false,
            --- 目标脚下点颜色
            TargetPosColor = { r = 1, g = 1, b = 0, a = 1 },
            TargetPosSize = 4,
            --- 是否启用了Anyone
            AnyOneReactionOn = true,
            --- 是否输出提示信息到消息栏
            LogToEchoMsg = true,
            --- 开启TTS
            TTS = false,
            --- 是否自动更新
            AutoUpdate = false,
            KeyBindFirst = 17,
            KeyBindSecond = 70,
            SpeedHack = 6,
            HackZoom = 100,
            MountSpeedHack = 9,
            DrawBlackListEnable = false,
            DrawBlackList = {},
            AttackRangeHelper = false,
            AttackRangeReplace = false,
            OutRangeColor = { r = 1, g = 1, b = 0, a = 1 },
            InRangeColor = { r = 1, g = 1, b = 1, a = 1 },
            LineSize = 3,
            AtkRangeData = {
                [1321] = { [14300] = 4, [14301] = 10, [14302] = 3, [14303] = 3, [14304] = 4, },
                [1323] = { [14369] = 4, [14370] = 4, [14373] = 4 },
                [1325] = { [14305] = { range = 5, buff = 3808, onBuffRange = 10 } },
                [1327] = { [14378] = 13.8, [14379] = { range = 5, buff = 3808, onBuffRange = 9 } },
                -- [341] = { [541] = 1.5 },
            },
            -- 更新源，1 github 2腾讯云
            DownLoadSource = 1,
            -- 开启日志系统
            LogEnable = true,
            --------- M11S -----------
            M11SExDraw = false,
            M11SOrbitalOmenAllMelee = false,
            -- 击飞方式 1 直 2斜
            M11SKickType = 1,
            -- 22 分摊 1 X 2 十字
            M11SGatherType = 1,
            --------- M12S -----------
            M12SP4UpTime = false,
            -- 4运打法，1 盗火改，2NOCCHH
            M12SP4Type = 1,
            M12SP4SendMacro = false,
            M12SP2is13 = false,
            M12SAutoFace1 = true,
            M12SAutoFace2 = true,
            -- 传统-传统uptime
            M12SAutoFaceType = 1,
            -- 添加一些关键性绘图
            M12SExDraw = false,
            --------- 商客奇谈 ---------
            Merchant = true,
            MerchantDraw = true,
            MerchantGuide = true,
            MerchantLockFace = true,
            MerchantAimTool = true
        }
        return mainCfg
    end
    --- 创建绝伊甸默认配置
    --- @return table 伊甸默认配置
    M.CreateFruDefaultCfg = function()
        return {
            --- 标点
            PosInfo = { 'C', '3', 'B', '2', 'A', '1', 'D', '4' },
            --- 基础8方位置
            JobPos = { 'H2', 'D2', 'ST', 'D4', 'MT', 'D3', 'H1', 'D1' },
            ----------------------------- P1 -----------------------------
            ProteanType = 1,
            --- 雾龙8方站位 C逆
            FruUtopainSkyPosInfo = { 'H2', 'D2', 'D4', 'ST', 'MT', 'D3', 'H1', 'D1' },
            --- 抓人分组上
            CatchTwoUp = { 'MT', 'ST', 'H1', 'H2' },
            --- 抓人分组下
            CatchTwoDown = { 'D1', 'D2', 'D3', 'D4' },
            --- 抓人补位
            CatchTwoDownFall = { 'MT', 'D1' },
            --- 雷火线优先级
            FruLightFirePriority = { 'H1', 'H2', 'MT', 'ST', 'D1', 'D2', 'D3', 'D4' },
            --- 雷火线标记
            FruLightFireMark = false,
            --- 雷火线处理方向：1：上下，2：左右
            FruLightFireDir = 1,
            --- 雷火线处理方式：1：上下互换，2：闲人固定
            FruLightFireType = 1,
            --- 闲人顺序，从上到下从左到右
            FruLightFireRestPos = { '2', '1', '3', '4' },
            --- 踩塔方式 1 小学塔，2固定+补位，3,日基塔固定3人补位3人
            TakeTowerType = 2,
            --- 填充塔优先级
            FallTowerOrder = { 'H1', 'H2', 'D1', 'D2', 'D3', 'D4' },
            --- 固定塔
            FixTowerUp = { 'H1', 'D1' },
            FixTowerMid = { 'H2', 'D2' },
            FixTowerDown = { 'D4', 'D3' },
            --- 日基踩塔
            JapanTowerFix = { 'H1', 'H2', 'D4' },
            JapanTowerFall = { 'D1', 'D2', 'D3' },

            ----------------------------- P2 -----------------------------
            --- DD 换位方式 1： 同组互换，2：全员顺时针
            DDChangeType = 1,
            --- DD 分组方式 1: A1D4/2B3C / 2: 2A1D/B4C3
            DDGroupType = 1,
            --- DD 逆时针跑圈方式 1：全体逆，2:仅45度逆
            DDRunType = 1,
            --- 滑冰提示TTS
            SkatingHit = 2,
            --- 镜子
            MirrorPosMelee1 = { 'D1', 'MT', 'ST', 'D2' },
            MirrorPosMelee2 = { 'MT', 'D1', 'D2', 'ST' },
            MirrorPosRange = { 'H1', 'D3', 'D4', 'H2' },
            --- 蓝镜子居中情况下 1. 远左近右， 2.近左远右
            MirrorSameDistanceType = 1,
            --- 光爆处理方式 1、田园郡 2、灰9
            FruLightRampantType = 1,
            --- 田园郡式光爆优先级
            FruLightRampantOrder = { 'MT', 'ST', 'H1', 'H2', 'D1', 'D2', 'D3', 'D4' },
            --- 放圈方案 1 莫古力 2 日基
            FruLightRampantDropType = 1,

            ----------------------------- P3 -----------------------------
            --- P3 1运处理方案 1 灰9式，2遗迹王国式
            UltimateRelativityType = 1,
            --- 分组方案 1: 预站位， 2: 科技  3：日基 4：双分组
            ApocalypseGroupType = 1,
            --- 换位后是否调整位置 1 不调，2调整
            ApocalypseChangePos = 1,
            --- P3地火解法 1：车头法 2：人群法 3：起点法 4：双分组
            ApocalypseType = 2,
            --- 暗夜舞蹈谁引导 1 MT 2 ST
            P3DarkestDanceTaker = 1,
            ----------------------------- P4 -----------------------------
            --- 光暗龙诗优先级
            DarkLitOrder = { 'MT', 'ST', 'H1', 'H2', 'D1', 'D2', 'D3', 'D4' },
            --- 光暗龙诗 翻花绳4边形时候 谁换，1左换，2右换
            DarkLitChangeType = 1,
            --- 标记队友
            CrystallizeTimeMark = false,
            --- 暗夜舞蹈谁引导 1 MT 2 ST
            P4DarkestDanceTaker = 1,
            --- 时间结晶优先级
            CrystallizeTimePriority = { 'H1', 'H2', 'MT', 'ST', 'D1', 'D2', 'D3', 'D4' },
            --- Buff 处理方式， 1，基本，2，日基
            CrystallizeTimeBuffType = 1,
            --- 时间结晶处理方式：1:固定吃，2:标点，3:自动摇号
            CrystallizeTimeType = 3,
            --- 时间结晶击退处理方式：1 Y字， 2：角落
            CrystallizeTimeKnockBack = 1,
            --- 标点类型
            CrystallizeTimeKnockCType = 2,
            -- 固定吃, 顺序
            CrystallizeTimeByBuff = {
                2462, -- 冰
                2461, -- 水
                2454, -- 摊
                2460, -- 暗
            },

            CrystallizeMark = {
                ['D'] = 4,
                ['B'] = 1,
                ['3'] = 2,
                ['4'] = 3
            },

            ----------------------------- P5 -----------------------------
            --- 处理方式 1:MT 一塔对面，2 人群无脑去
            DarkLightWingsType = 2,
            --- 踩塔类型： 1.固定踩塔 ，2.顺序踩塔
            DarkLightWingsTakeTowerType = 1,
            --- 固定塔站位
            DarkLightWings = {
                Down = { 'D1', 'D2' },
                Left = { 'H1', 'H2' },
                Right = { 'D3', 'D4' },
            },
            --- 顺序塔站位
            DarkLightWings2 = {
                Down = { 'H1', 'H2' },
                Left = { 'D3', 'D4' },
                Right = { 'D1', 'D2' },
            },
            drawWinPolarizingOrder = {
                { 'MT', 'ST' },
                { 'D1', 'D2' },
                { 'D3', 'D4' },
                { 'H1', 'H2' },
            },
            --- 绘图开关
            drawAknMorn = true,
            drawShit = true,
            drawWinLight = true,
            drawWinPolarizing = true,
        }

    end

    --- 创建绝卡夫卡默认配置
    --- @return table
    M.CreateDmuDefaultCfg = function()
        return {
            Enable = true,
            BindEffect = true,
            P1 = {
                enable = true, draw = true, guide = true,
                autoLookAt = true,
                transUnOpt = false,
                hardLock = false,
                -- 1 MS 2 A:T远 C:奶近
                Line2Type = 1,
                BeamOrder = { 'H2', 'H1', 'ST', 'MT', 'D1', 'D2', 'D3', 'D4', },
            },
            P2 = {
                enable = true, draw = true, guide = true,
                -- 1职能固定，2扇左钢右 3职固Uptime
                fixType = 1,
                -- 踩塔开启指挥模式
                --towerGuide = false,
                -- 踩塔结束之后去哪 1 -> A, 2 -> 两塔中间
                endTower = 1,
                -- 1.只画一次，2.绘制预览
                trineDrawType = 1,
            },
            P3 = {
                enable = true, draw = true, guide = true,
                fireBuffOrder = { 'MT', 'ST', 'H1', 'H2', 'D1', 'D2', 'D3', 'D4', },
                -- 开场拉ex的T是谁 1 ST  2 MT
                ExDeathTank = 1,
                -- 是否自动面向
                LockFace = true,
                HardLockFace = false,
                -- 1 d3; 2 d4
                superJump = 1,
                -- 1: THHT 2: HTH, 3 8人一起 
                kickType = 1,
                -- 击退前自动选中小艾
                autoTargetEx = false,
                slapHappyDraw = true,
                slapHappyDir = true,
                -- 标记类型，1 关闭； 2  随机标记自己；  3 标记全队,  4, 精确标记自己
                markType = 1,
                takeLineAttack12 = false,
                takeLineStop22 = false,
                markOrderSelf = { 'MT', 'ST', 'D1', 'D2', 'D3', 'D4', 'H1', 'H2' },
                markOrder = { 'MT', 'ST', 'D1', 'D2', 'D3', 'D4', 'H1', 'H2' },
                delayMark = true,
                -- 踩塔基础类型
                --- 1:其他 2:CCHH, 3:盗火，
                takeTowerType = 1,
                --- 踩塔12点, 1 脚跟，2脚尖
                towerHeading = 1,
                --- 踩塔分组是面基是场基
                towerGround = 1,
            },
            P4 = {
                enable = true, draw = true, guide = true,
                -- 分散的人 1 D左TH右，2 TH左边D右边
                disType = 1,
                -- 石化眼方案 1.盗火站位，2.盗火常规，3.MMW
                eyeType = 1,
                autoLook = true,
                harkLock = false,
                sendMacro = false,
            },
            P5 = { enable = true, draw = true, guide = true,
                   groundFireGuide = true,
                   isLeaning = false,
                   jobOrder = { 'H2', 'D2', 'D4', 'ST', 'MT', 'D3', 'H1', 'D1' },
                -- 画地火的数量
                   groundCnt = 3,
                --是否显示黑洞范围
                   showBlackHole = true,
                -- 软狂暴跑路类型
                -- 1、全顺，2关闭
                   forsakenType = 1,
                -- 起点 1左下，2右下，3右上，4左上
                   forsakenTypeStart = 1,
            }
        }
    end

    --- 创建默认减伤配置
    M.CreateDmuMigCfg = function()
        return {
            -- T减 --
            -- P1
            RevoltingRuinIII_1 = { p = 1, value = 1, nameCn = '恶狠狠毁荡' },
            LightingJudgment_1 = { p = 1, value = 1, nameCn = '超驱动' },
            RevoltingRuinIII_2 = { p = 1, value = 1, nameCn = '恶狠狠毁荡' },
            LightingJudgment_2 = { p = 1, value = 1, nameCn = '超驱动' },
            -- P2
            UltimateEmbrace_1 = { p = 2, value = 1, nameCn = '终末双腕' },
            WingOfDestruction = { p = 2, value = 1, nameCn = '破坏之翼' },
            UltimateEmbrace_2 = { p = 2, value = 1, nameCn = '终末双碗' },
            -- P3
            ThunderIII_1 = { p = 3, value = 1, nameCn = '暴雷1' },
            ThunderIII_2 = { p = 3, value = 1, nameCn = '暴雷2' },
            ThunderIII_3 = { p = 3, value = 1, nameCn = '暴雷3' },
            ThunderIII_4 = { p = 3, value = 1, nameCn = '暴雷4' },
            ThunderIII_5 = { p = 3, value = 1, nameCn = '暴雷5' },
            -- P5
            ChaoticFlare_1 = { p = 5, value = 1, nameCn = '混沌核爆1' },
            ChaoticFlare_2 = { p = 5, value = 1, nameCn = '混沌核爆2' },
            -- 团减--
            Flaflare1 = { p = 1, Target = false, Field = false, nameCn = '呼啦啦爆炎1', time = 45.9 },
            LightOfJudgment1 = { p = 1, Target = false, Field = false, nameCn = '制裁之光1', time = 62.6 },
            LightOfJudgment2 = { p = 1, Target = false, Field = false, nameCn = '制裁之光2', time = 132.3 },
            Flaflare2 = { p = 1, team = true, Target = false, Field = false, nameCn = '呼啦啦爆炎2', time = 187.1 },
            TwinArms = { p = 2, team = true, Target = false, Field = false, nameCn = '终末双腕1', time = 220.1 },
            Forsaken1 = { p = 2, team = true, Target = false, Field = false, nameCn = '遗弃末世1', time = 235.3 },
            LightOfJudgment3 = { p = 2, team = true, Target = false, Field = false, nameCn = '制裁之光', time = 341.7 },
            TwinArms2 = { p = 2, team = true, Target = false, Field = false, nameCn = '终末双腕2', time = 377.3 },
            Bowbow = { p = 3, team = true, Target = false, Field = false, nameCn = '深层痛楚', time = 450 },
            BlazeTsunami1 = { p = 3, team = true, Target = false, Field = false, nameCn = '烈焰/海啸1', time = 470.2 },
            BlazeTsunami2 = { p = 3, team = true, Target = false, Field = false, nameCn = '烈焰/海啸2', time = 497.2 },
            VacuumWave = { p = 3, team = true, Target = false, Field = false, nameCn = '真空波', time = 514.4 },
            ThunderIII_T_2 = { p = 3, team = true, Target = false, Field = false, nameCn = '暴雷2', time = 540 },
            ThunderIII_T_3 = { p = 3, team = true, Target = false, Field = false, nameCn = '暴雷3', time = 557.2 },
            Shockwave1 = { p = 3, team = true, Target = false, Field = false, nameCn = '冲击波1', time = 578 },
            ThunderIII_T_4 = { p = 3, team = true, Target = false, Field = false, nameCn = '暴雷5', time = 640 },
            Shockwave2 = { p = 3, team = true, Target = false, Field = false, nameCn = '冲击波2', time = 608.4 },
            Shockwave3 = { p = 3, team = true, Target = false, Field = false, nameCn = '冲击波3', time = 676.3 },
            Blaze = { p = 3, team = true, Target = false, Field = false, nameCn = '轰击', time = 710.7 },
            GrandCross1 = { p = 4, team = true, Target = false, Field = false, nameCn = '大十字1', time = 826 },
            GrandCross2 = { p = 4, team = true, Target = false, Field = false, nameCn = '大十字2', time = 841.1 },
            GrandCross3 = { p = 4, team = true, Target = false, Field = false, nameCn = '大十字3', time = 856 },
            UltimaUpsideDown1 = { p = 4, team = true, Target = false, Field = false, nameCn = '扑腾腾究极1', time = 895.5 },
            UltimaUpsideDown2 = { p = 4, team = true, Target = false, Field = false, nameCn = '扑腾腾究极2', time = 934.7 },
            ConsecutiveUltima1 = { p = 5, team = true, Target = false, Field = false, nameCn = '连续究极1', time = 975.9 },
            MaddeningOrchestra1 = { p = 5, team = true, Target = false, Field = false, nameCn = '癫狂交响曲1', time = 1003.4 },
            ConsecutiveUltima2 = { p = 5, team = true, Target = false, Field = false, nameCn = '连续究极2', time = 1057.7 },
            MaddeningOrchestra2 = { p = 5, team = true, Target = false, Field = false, nameCn = '癫狂交响曲2', time = 1098.6 },
            Forsaken1_P5 = { p = 5, team = true, Target = false, Field = false, nameCn = '遗弃末世1234', time = 1138.4 },
            Forsaken2_P5 = { p = 5, team = true, Target = false, Field = false, nameCn = '遗弃末世5678', time = 1154.7 },
        }
    end

    M.DumCfgJobChange = function()
        if Player == nil or Player.job == nil then
            return
        end
        local filePath = M.Config.DmuMitig .. '\\' .. Player.job
        M.Config.DmuMitigJobConfigs = M.LoadFileList(filePath, { 'Config.lua' })
        M.Config.DmuMitigNewMode = false
        local defCfg = M.CreateDmuMigCfg()
        local curCfg = M.LoadConfig(filePath, 'Config.lua', defCfg)
        if M.IsTank(Player.job) then
            M.Config.DmuCatZCfg = curCfg
            M.Config.DmuCatZCfgPrevious = table.deepcopy(curCfg)
        else
            M.Config.DmuDpsCfg = curCfg
            M.Config.DmuDpsCfgPrevious = table.deepcopy(curCfg)
        end
    end
    --- 同步配置字段
    M.SyncNestedFields = function(saveData, defaultData)
        for key, value in pairs(defaultData) do
            if type(value) == 'table' then
                if type(saveData[key]) == 'table' then
                    M.SyncNestedFields(saveData[key], value)
                else
                    saveData[key] = value
                end
            else
                if saveData[key] == nil then
                    saveData[key] = value
                end
            end
        end
    end

    M.IsValidConfigName = Config.isValidConfigName

    --- 读取存档名称
    M.LoadFileList = function(path, except)
        local files = { 'None' }
        if (not FolderExists(path)) then
            FolderCreate(path)
        end
        local items = FolderList(path)
        if except ~= nil then
            for i = 1, #items do
                if not table.contains(except, items[i]) then
                    table.insert(files, M.RemoveExtension(items[i]))
                end
            end
        else
            for i = 1, #items do
                table.insert(files, M.RemoveExtension(items[i]))
            end
        end

        return files
    end
    --- 读取序列化的表格文件
    M.LoadFileConfig = function(path, fileName, defConfig)
        if not M.IsValidConfigName(fileName) then
            M.ShowMsgUI(3, { '配置名不合法，已拒绝加载。' })
            return defConfig
        end
        local saveFile = path .. '\\' .. fileName .. '.lua'

        if (not FolderExists(path)) then
            FolderCreate(path)
        end
        local config = FileLoad(saveFile)
        if type(config) == 'table' then
            M.SyncNestedFields(config, defConfig)
            M.ShowMsgUI(3, { ('加载配置[' .. fileName .. ']成功！') })
            return config
        end
        M.ShowMsgUI(3, { ('加载配置[' .. fileName .. ']失败！') })
        return defConfig
    end

    --- 将表格序列化到文件
    M.SaveFileConfig = function(path, fileName, table)
        if not M.IsValidConfigName(fileName) then
            M.ShowMsgUI(3, { '配置名不合法，已拒绝保存。' })
            return false
        end
        local saveFile = path .. '\\' .. fileName .. '.lua'
        if (not FolderExists(path)) then
            FolderCreate(path)
        end
        if FileSave(saveFile, table) then
            M.ShowMsgUI(3, { ('已将当前设置保存到配置[' .. fileName .. ']！') })
            return true
        end
        M.ShowMsgUI(3, { ('保存配置[' .. fileName .. ']失败，请检查目录权限！') })
        return false
    end

    --- 读取设置信息
    --- @param path string 路径(最后不带\\)
    --- @param fileName string 文件名
    --- @param defaultCfg table 默认配置
    --- @return table 读取到或者生成的存档
    M.LoadConfig = function(path, fileName, defaultCfg)
        if (not FolderExists(path)) then
            FolderCreate(path)
        end
        local saveFile = path .. '\\' .. fileName
        local config = FileLoad(saveFile)
        if type(config) == 'table' then
            M.SyncNestedFields(config, defaultCfg)
            return config
        end
        return defaultCfg;
    end

    --- 保存设置
    --- @param path string 路径(最后不带\\)
    --- @param fileName string 文件名
    --- @param configName string 配置ID
    M.SaveConfig = function(path, fileName, configName)
        local curConfig = M.Config[configName]
        local preConfig = M.Config[configName .. 'Previous']
        if curConfig == nil or preConfig == nil then
            return
        end
        if not table.deepcompare(curConfig, preConfig) then
            local saveFile = path .. '\\' .. fileName
            if (not FolderExists(path)) then
                FolderCreate(path)
            end
            if FileSave(saveFile, curConfig) then
                M.Config[configName .. 'Previous'] = table.deepcopy(curConfig)
                return true
            end
            M.LogError('Config', '保存配置失败', { file = saveFile, config = configName }, true)
            return false
        end
        return true
    end

    M.SaveConfigJob = function(path, fileName, curConfig, preConfig)
        if curConfig == nil or preConfig == nil then
            return false
        end
        if not table.deepcompare(curConfig, preConfig) then
            local saveFile = path .. '\\' .. fileName
            if (not FolderExists(path)) then
                FolderCreate(path)
            end
            if FileSave(saveFile, curConfig) then
                return true
            end
            M.LogError('Config', '保存职业配置失败', { file = saveFile }, true)
            return false
        end
        return false
    end

    LoadUIConfig(M)
end

return Config
