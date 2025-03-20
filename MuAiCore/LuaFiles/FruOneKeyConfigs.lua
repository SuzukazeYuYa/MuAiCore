local loadConfigs = function(M)
    --- 快速莫古力&mmw攻略
    M.FastMgl = function()
        local configTbl1 = {
            --- 标点
            PosInfo = { "C", "3", "B", "2", "A", "1", "D", "4" },
            --- 基础8方位置
            JobPos = { "H2", "D2", "ST", "D4", "MT", "D3", "H1", "D1" },

            ----------------------------- P1 -----------------------------
            ProteanType = 1,
            --- 雾龙8方站位 C逆
            FruUtopainSkyPosInfo = { "H2", "D2", "D4", "ST", "MT", "D3", "H1", "D1" },
            --- 抓人分组上
            CatchTwoUp = { "MT", "ST", "H1", "H2" },
            --- 抓人分组下
            CatchTwoDown = { "D1", "D2", "D3", "D4" },
            --- 抓人补位
            CatchTwoDownFall = { "MT", "D1" },
            --- 雷火线优先级
            FruLightFirePriority = { "H1", "H2", "MT", "ST", "D1", "D2", "D3", "D4" },
            --- 雷火线标记
            FruLightFireMark = false,
            --- 雷火线处理方向：1：上下，2：左右
            FruLightFireDir = 1,
            --- 雷火线处理方式：1：上下互换，2：闲人固定
            FruLightFireType = 1,
            --- 闲人顺序，从上到下从左到右
            FruLightFireRestPos = { "2", "1", "3", "4" },
            --- 踩塔方式 1 小学塔，2固定+补位，3,日基塔固定3人补位3人
            TakeTowerType = 2,
            --- 填充塔优先级
            FallTowerOrder = { "H1", "H2", "D1", "D2", "D3", "D4" },
            --- 固定塔
            FixTowerUp = { "H1", "D1" },
            FixTowerMid = { "H2", "D2" },
            FixTowerDown = { "D4", "D3" },
            --- 日基踩塔
            JapanTowerFix = { "H1", "H2", "D4" },
            JapanTowerFall = { "D1", "D2", "D3" },

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
            MirrorPosMelee1 = { "D1", "MT", "ST", "D2" },
            MirrorPosMelee2 = { "MT", "D1", "D2", "ST" },
            MirrorPosRange = { "H1", "D3", "D4", "H2" },
            --- 蓝镜子居中情况下 1. 远左近右， 2.近左远右
            MirrorSameDistanceType = 1,
            --- 光爆处理方式 1、田园郡 2、灰9
            FruLightRampantType = 1,
            --- 田园郡式光爆优先级
            FruLightRampantOrder = { "MT", "ST", "H1", "H2", "D1", "D2", "D3", "D4" },
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
            ApocalypseType = 1,
            --- 暗夜舞蹈谁引导 1 MT 2 ST
            P3DarkestDanceTaker = 1,
            ----------------------------- P4 -----------------------------
            --- 光暗龙诗优先级
            DarkLitOrder = { "MT", "ST", "H1", "H2", "D1", "D2", "D3", "D4" },
            --- 光暗龙诗 翻花绳4边形时候 谁换，1左换，2右换
            DarkLitChangeType = 1,
            CrystallizeTimeMark = false,
            --- 暗夜舞蹈谁引导 1 MT 2 ST
            P4DarkestDanceTaker = 1,
            --- 时间结晶优先级
            CrystallizeTimePriority = { "H1", "H2", "MT", "ST","D1", "D2", "D3", "D4" },
            --- Buff 处理方式， 1，基本，2，日基
            CrystallizeTimeBuffType = 1,
            --- 时间结晶处理方式：1:固定吃，2:标点，3:自动摇号
            CrystallizeTimeType = 3,
            CrystallizeTimeActType = 1,
            --- 时间结晶击退处理方式：1 Y字， 2：角落
            CrystallizeTimeKnockBack = 2,
            CrystallizeTimeKnockCType = 2,
            -- 固定吃, 顺序
            CrystallizeTimeByBuff = {
                2462, -- 冰
                2461, -- 水
                2454, -- 摊
                2460, -- 暗
            },

            CrystallizeMark = {
                ["D"] = 4,
                ["B"] = 1,
                ["3"] = 2,
                ["4"] = 3
            },

            ----------------------------- P4 -----------------------------
            --- 踩塔类型： 1.固定踩塔 ，2.顺序踩塔
            DarkLightWingsTakeTowerType = 2,
            --- 固定塔站位
            DarkLightWings = {
                Down = { "D1", "D2" },
                Left = { "H1", "H2" },
                Right = { "D3", "D4" },
            },
            --- 顺序塔站位
            DarkLightWings2 = {
                Down = { "H1", "H2" },
                Left = { "D3", "D4" },
                Right = { "D1", "D2" },
            },
            drawWinPolarizingOrder = {
                {"MT", "ST"},
                {"D1", "D2"},
                {"D3", "D4"},
                {"H1", "H2"},
            },
            --- 绘图开关
            drawAknMorn = M.Config.FruCfg.drawAknMorn,
            drawShit = M.Config.FruCfg.drawShit,
            drawWinLight = M.Config.FruCfg.drawWinLight,
            drawWinPolarizing = M.Config.FruCfg.drawWinPolarizing,
        }
        M.Config.FruCfg = configTbl1
        M.Info("已切换为莫古力&MMW攻略默认配置。")
    end
    --- 快速日基
    M.FastJapanConfig = function()
        local configTbl2 = {
            --- 标点
            PosInfo = { "C", "2", "B", "1", "A", "4", "D", "3" },
            --- 基础8方位置
            JobPos = { "ST", "D2", "H2", "D4", "MT", "D3", "H1", "D1" },

            ----------------------------- P1 -----------------------------
            ProteanType = 2,
            --- 雾龙8方站位 C逆
            FruUtopainSkyPosInfo = { "D4", "D2", "H2", "ST", "MT", "D3", "H1", "D1" },
            --- 抓人分组上
            CatchTwoUp = { "H1", "H2", "ST", "MT" },
            --- 抓人分组下
            CatchTwoDown = { "D1", "D2", "D3", "D4" },
            --- 抓人补位
            CatchTwoDownFall = { "MT", "D1" },
            --- 雷火线优先级
            FruLightFirePriority = { "H1", "H2", "MT", "ST", "D1", "D2", "D3", "D4" },
            --- 雷火线标记
            FruLightFireMark = false,
            --- 雷火线处理方向：1：上下，2：左右
            FruLightFireDir = 2,
            --- 雷火线处理方式：1：上下互换，2：闲人固定
            FruLightFireType = 1,
            --- 闲人顺序，从上到下从左到右
            FruLightFireRestPos = { "1", "2", "3", "4" },
            --- 踩塔方式 1 小学塔，2固定+补位，3,日基塔固定3人补位3人
            TakeTowerType = 3,
            --- 填充塔优先级
            FallTowerOrder = { "H1", "H2", "D1", "D2", "D3", "D4" },
            --- 固定塔
            FixTowerUp = { "H1", "D1" },
            FixTowerMid = { "H2", "D2" },
            FixTowerDown = { "D4", "D3" },
            --- 日基踩塔
            JapanTowerFix = { "H1", "H2", "D4" },
            JapanTowerFall = { "D1", "D2", "D3" },

            ----------------------------- P2 -----------------------------
            --- DD 换位方式 1： 同组互换，2：全员顺时针
            DDChangeType = 2,
            --- DD 分组方式 1: A1D4/2B3C / 2: 2A1D,B4C3
            DDGroupType = 2,
            --- DD 逆时针跑圈方式 1：全体逆，2:仅45度逆
            DDRunType = 2,
            --- 滑冰提示TTS
            SkatingHit = 2,
            --- 镜子
            MirrorPosMelee1 = { "MT", "D1", "D2", "ST" },
            MirrorPosMelee2 = { "MT", "D1", "D2", "ST" },
            MirrorPosRange = { "H2", "D4", "D3", "H1" },
            --- 蓝镜子居中情况下 1. 远左近右， 2.近左远右
            MirrorSameDistanceType = 2,
            --- 光爆处理方式 1、田园郡 2、灰9
            FruLightRampantType = 1,
            --- 田园郡式光爆优先级
            FruLightRampantOrder = { "H1", "H2", "MT", "ST", "D1", "D2", "D3", "D4" },
            --- 放圈方案 1 莫古力 2 日基
            FruLightRampantDropType = 2,

            ----------------------------- P3 -----------------------------
            --- P3 1运处理方案 1 灰9式，2遗迹王国式
            UltimateRelativityType = 2,
            --- 分组方案 1: 预站位， 2: 科技  3：日基 4：双分组
            ApocalypseGroupType = 3,
            --- 换位后是否调整位置 1 不调，2调整
            ApocalypseChangePos = 1,
            --- P3地火解法 1：车头法 2：人群法 3：起点法 4：双分组
            ApocalypseType = 1,
            --- 暗夜舞蹈谁引导 1 MT 2 ST
            P3DarkestDanceTaker = 1,
            ----------------------------- P4 -----------------------------
            --- 光暗龙诗优先级
            DarkLitOrder = { "H1", "H2", "MT", "ST", "D1", "D2", "D3", "D4" },
            --- 光暗龙诗 翻花绳4边形时候 谁换，1左换，2右换
            DarkLitChangeType = 2,
            CrystallizeTimeMark = false,     
            --- 暗夜舞蹈谁引导 1 MT 2 ST
            P4DarkestDanceTaker = 1,
            --- 时间结晶优先级
            CrystallizeTimePriority = { "H1", "MT", "ST", "D1", "D2", "D3", "D4", "H2" },       
            --- Buff 处理方式， 1，基本，2，日基
            CrystallizeTimeBuffType = 2,
            --- 时间结晶处理方式：1:固定吃，2:标点，3:自动摇号
            CrystallizeTimeType = 3,
            CrystallizeTimeActType = 1,
            --- 时间结晶击退处理方式：1 Y字， 2：角落
            CrystallizeTimeKnockBack = 1,
            CrystallizeTimeKnockCType = 1,
            -- 固定吃, 顺序
            CrystallizeTimeByBuff = {
                2462, -- 冰
                2461, -- 水
                2454, -- 摊
                2460, -- 暗
            },

            CrystallizeMark = {
                ["D"] = 4,
                ["B"] = 1,
                ["3"] = 2,
                ["4"] = 3
            },

            ----------------------------- P5 -----------------------------
            --- 踩塔类型： 1.固定踩塔 ，2.顺序踩塔
            DarkLightWingsTakeTowerType = 2,
            --- 固定塔站位
            DarkLightWings = {
                Down = { "D1", "D2" },
                Left = { "H1", "H2" },
                Right = { "D3", "D4" },
            },
            --- 顺序塔站位
            DarkLightWings2 = {
                Down = { "H1", "H2" },
                Left = { "D3", "D4" },
                Right = { "D1", "D2" },
            },
            drawWinPolarizingOrder = {
                {"MT", "ST"},
                {"D1", "D2"},
                {"D3", "D4"},
                {"H1", "H2"},
            },
            --- 绘图开关
            drawAknMorn = M.Config.FruCfg.drawAknMorn,
            drawShit = M.Config.FruCfg.drawShit,
            drawWinLight = M.Config.FruCfg.drawWinLight,
            drawWinPolarizing = M.Config.FruCfg.drawWinPolarizing,
        }
        M.Config.FruCfg = configTbl2
        M.Info("已切换为日基攻略默认配置。")
    end

    --- 快速莫灵喵
    M.FastMLM = function()
        local configTbl1 = {
            --- 标点
            PosInfo = { "C", "3", "B", "2", "A", "1", "D", "4" },
            --- 基础8方位置
            JobPos = { "H2", "D2", "ST", "D4", "MT", "D3", "H1", "D1" },

            ----------------------------- P1 -----------------------------
            ProteanType = 1,
            --- 雾龙8方站位 C逆
            FruUtopainSkyPosInfo = { "H2", "D2", "D4", "ST", "MT", "D3", "H1", "D1" },
            --- 抓人分组上
            CatchTwoUp = { "MT", "ST", "D3", "D4" },
            --- 抓人分组下
            CatchTwoDown = { "D1", "D2", "H1", "H2"  },
            --- 抓人补位
            CatchTwoDownFall = { "MT", "D1" },
            --- 雷火线优先级
            FruLightFirePriority = { "MT", "ST", "H1", "H2", "D1", "D2", "D3", "D4" },
            --- 雷火线标记
            FruLightFireMark = false,
            --- 雷火线处理方向：1：上下，2：左右
            FruLightFireDir = 1,
            --- 雷火线处理方式：1：上下互换，2：闲人固定
            FruLightFireType = 1,
            --- 闲人顺序，从上到下从左到右
            FruLightFireRestPos = { "2", "1", "3", "4" },
            --- 踩塔方式 1 小学塔，2固定+补位，3,日基塔固定3人补位3人
            TakeTowerType = 1,
            --- 填充塔优先级
            FallTowerOrder = { "H1", "H2", "D1", "D2", "D3", "D4" },
            --- 固定塔
            FixTowerUp = { "H1", "D1" },
            FixTowerMid = { "H2", "D2" },
            FixTowerDown = { "D4", "D3" },
            --- 日基踩塔
            JapanTowerFix = { "H1", "H2", "D4" },
            JapanTowerFall = { "D1", "D2", "D3" },

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
            MirrorPosMelee1 = { "ST", "D2", "D1", "MT" },
            MirrorPosMelee2 = { "MT", "D1", "D2", "ST" },
            MirrorPosRange = { "H1", "D3", "D4", "H2" },
            --- 蓝镜子居中情况下 1. 远左近右， 2.近左远右
            MirrorSameDistanceType = 1,
            --- 光爆处理方式 1、田园郡 2、灰9
            FruLightRampantType = 1,
            --- 田园郡式光爆优先级
            FruLightRampantOrder = { "MT", "ST", "H1", "H2", "D1", "D2", "D3", "D4" },
            --- 放圈方案 1 莫古力 2 日基
            FruLightRampantDropType = 1,

            ----------------------------- P3 -----------------------------
            --- P3 1运处理方案 1 灰9式，2遗迹王国式
            UltimateRelativityType = 1,
            --- 分组方案 1: 预站位， 2: 科技  3：日基 4：双分组
            ApocalypseGroupType = 2,
            --- 换位后是否调整位置 1 不调，2调整
            ApocalypseChangePos = 1,
            --- P3地火解法 1：车头法 2：人群法 3：起点法 4：双分组
            ApocalypseType = 2,
            --- 暗夜舞蹈谁引导 1 MT 2 ST
            P3DarkestDanceTaker = 1,
            ----------------------------- P4 -----------------------------
            
            --- 光暗龙诗优先级
            DarkLitOrder = { "MT", "ST", "H1", "H2", "D1", "D2", "D3", "D4" },
            --- 光暗龙诗 翻花绳4边形时候 谁换，1左换，2右换
            DarkLitChangeType = 1,
            CrystallizeTimeMark = false,
            --- 暗夜舞蹈谁引导 1 MT 2 ST
            P4DarkestDanceTaker = 1,
            --- 时间结晶优先级
            CrystallizeTimePriority = { "MT", "ST", "H1", "H2", "D1", "D2", "D3", "D4" },
            --- Buff 处理方式， 1，基本，2，日基
            CrystallizeTimeBuffType = 1,
            --- 时间结晶处理方式：1:固定吃，2:标点，3:自动摇号
            CrystallizeTimeType = 2,

            CrystallizeTimeActType = 2,
            --- 时间结晶击退处理方式：1 Y字， 2：角落
            CrystallizeTimeKnockBack = 2,
            
            CrystallizeTimeKnockCType = 1,
            -- 固定吃, 顺序
            CrystallizeTimeByBuff = {
                2462, -- 冰
                2461, -- 水
                2454, -- 摊
                2460, -- 暗
            },

            CrystallizeMark = {
                ["D"] = 1,
                ["B"] = 2,
                ["3"] = 3,
                ["4"] = 4
            },

            ----------------------------- P4 -----------------------------
            --- 踩塔类型： 1.固定踩塔 ，2.顺序踩塔
            DarkLightWingsTakeTowerType = 1,
            --- 固定塔站位
            DarkLightWings = {
                Down = { "D1", "D2" },
                Left = { "H1", "H2" },
                Right = { "D3", "D4" },
            },
            --- 顺序塔站位
            DarkLightWings2 = {
                Down = { "H1", "H2" },
                Left = { "D3", "D4" },
                Right = { "D1", "D2" },
            },
            drawWinPolarizingOrder = {
                {"MT", "ST"},
                {"D1", "D2"},
                {"D3", "D4"},
                {"H1", "H2"},
            },
            --- 绘图开关
            drawAknMorn = M.Config.FruCfg.drawAknMorn,
            drawShit = M.Config.FruCfg.drawShit,
            drawWinLight = M.Config.FruCfg.drawWinLight,
            drawWinPolarizing = M.Config.FruCfg.drawWinPolarizing,
        }
        M.Config.FruCfg = configTbl1
        M.Info("已切换到莫灵喵默认设置，请根据组内情况调整可选配置。")
    end
    
    M.Debug("默认配置文件读取完成。")
end
return loadConfigs