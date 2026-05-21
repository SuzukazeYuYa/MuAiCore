local Config = {}
--[[
===========================
    配置文件处理模块
===========================
]]
---@param M MuAiGuide
local LoadUIConfig = function(M)
    M.Config = {}
    M.Config.MainPath = GetLuaModsPath() .. "MuAiCore\\Configs"
    M.Config.MainFile = "MainConfig.lua"

    M.Config.FruGuidePath = M.Config.MainPath .. "\\FruGuide"
    M.Config.FruGuideFile = "GuideConfig.lua"
    M.Config.FruMitigationPath = M.Config.MainPath .. "\\FruMitigation"
    M.Config.FruMitigationFile = "FruMitigation.lua"

    M.Config.DcmGuidePath = M.Config.MainPath .. "\\DcmGuide"
    M.Config.DcmGuideFile = "GuideConfig.lua"
    M.Config.DcmMitig = M.Config.MainPath .. "\\DcmMitig"

    M.Config.Key1 = { "Shift", "Ctrl", "Alt" }
    M.Config.Key2 = {}
    for i = 65, 90 do
        table.insert(M.Config.Key2, string.char(i))
    end
    table.insert(M.Config.Key2, "~")

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
    M.Config.FruCustomList = M.LoadFileList(M.Config.FruGuidePath, { "GuideConfig.lua" })
    M.Config.FruCustomListIndex = 1
    --- 读取绝妖星存档
    local defDcmCfg = M.CreateDcmDefaultCfg()
    M.Config.DcmCfg = defDcmCfg  -- 这里只是让编辑可以默认识别，无实际作用
    M.Config.DcmCfg = M.LoadConfig(M.Config.DcmGuidePath, M.Config.DcmGuideFile, defDcmCfg)
    M.Config.DcmCfgPrevious = table.deepcopy(M.Config.DcmCfg)
    M.Config.DcmCustomList = M.LoadFileList(M.Config.DcmGuidePath, { "GuideConfig.lua" })
    M.Config.DcmCustomListIndex = 1
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
        M.Info("已恢复默认设置.")
    end
    M.CreateDefMainCfg = function()
        local mainCfg = {
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
            ApocalypseType = 2,
            --- 暗夜舞蹈谁引导 1 MT 2 ST
            P3DarkestDanceTaker = 1,
            ----------------------------- P4 -----------------------------
            --- 光暗龙诗优先级
            DarkLitOrder = { "MT", "ST", "H1", "H2", "D1", "D2", "D3", "D4" },
            --- 光暗龙诗 翻花绳4边形时候 谁换，1左换，2右换
            DarkLitChangeType = 1,
            --- 标记队友
            CrystallizeTimeMark = false,
            --- 暗夜舞蹈谁引导 1 MT 2 ST
            P4DarkestDanceTaker = 1,
            --- 时间结晶优先级
            CrystallizeTimePriority = { "H1", "H2", "MT", "ST", "D1", "D2", "D3", "D4" },
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
                ["D"] = 4,
                ["B"] = 1,
                ["3"] = 2,
                ["4"] = 3
            },

            ----------------------------- P5 -----------------------------
            --- 处理方式 1:MT 一塔对面，2 人群无脑去
            DarkLightWingsType = 2,
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
                { "MT", "ST" },
                { "D1", "D2" },
                { "D3", "D4" },
                { "H1", "H2" },
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
    M.CreateDcmDefaultCfg = function()
        return {
            state = {
                global = { enable = true, draw = true, guide = true },
                P1 = { enable = true, draw = true, guide = true },
                P2 = { enable = true, draw = true, guide = true },
                P3 = { enable = true, draw = true, guide = true },
                P4 = { enable = true, draw = true, guide = true },
                P5 = { enable = true, draw = true, guide = true },
                P6 = { enable = true, draw = true, guide = true },
            },
            --- 基础8方位置
            JobPos = { "H2", "D2", "ST", "D4", "MT", "D3", "H1", "D1" },
        }
    end

    --- 同步配置字段
    M.SyncNestedFields = function(saveData, defaultData)
        for key, value in pairs(defaultData) do
            if type(value) == "table" then
                if type(saveData[key]) == "table" then
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
    --- 读取存档名称
    M.LoadFileList = function(path, except)
        local files = { "None" }
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
        local saveFile = path .. "\\" .. fileName .. ".lua"

        if (not FolderExists(path)) then
            FolderCreate(path)
        end
        local config = FileLoad(saveFile)
        if config ~= nil then
            M.SyncNestedFields(config, defConfig)
            M.Info("加载配置[" .. fileName .. "]成功！")
            return config
        end
        M.Info("加载配置[" .. fileName .. "]失败！")
        return defConfig
    end
    --- 将表格序列化到文件
    M.SaveFileConfig = function(path, fileName, table)
        local saveFile = path .. "\\" .. fileName .. ".lua"
        if (not FolderExists(path)) then
            FolderCreate(path)
        end
        FileSave(saveFile, table)
        M.Info("已将当前设置保存到配置[" .. fileName .. "]。")
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
        local saveFile = path .. "\\" .. fileName
        local config = FileLoad(saveFile)
        if config ~= nil then
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
        local preConfig = M.Config[configName .. "Previous"]
        if curConfig == nil or preConfig == nil then
            return
        end
        if not table.deepcompare(curConfig, preConfig) then
            local saveFile = path .. "\\" .. fileName
            if (not FolderExists(path)) then
                FolderCreate(path)
            end
            FileSave(saveFile, curConfig)
            M.Config[configName .. "Previous"] = table.deepcopy(curConfig)
            --d("[MuAiCore]存档" .. fileName .. "已更新")
        end
    end
    LoadUIConfig(M)
end

return Config