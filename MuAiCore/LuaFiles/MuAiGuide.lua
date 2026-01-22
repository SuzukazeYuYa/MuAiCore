local M = {}
M.VERSION = 226
--- 是否开启测试模式
M.DebugMode = false
--- 测试模式玩家职能
M.DebugPos = "MT"
--- 是否开了UI开发模式
M.DevelopMode = false
------------------------------- UI -------------------------------
--- UI定义
M.UI = {}
--- 绝伊甸UI用字段
M.FruConfigUI = {
    NewMode = false,
    NewFileName = ""
}
--- 减伤轴UI
M.FruMitigationUI = {
    NewMode = false,
    SendParty = true,
    NewFileName = ""
}
------------------------------- 工具方法 -------------------------------
--- 输出消息到聊天栏
--- @param msg string
M.Info = function(msg, ttsOn)
    if not M.Config.Main.LogToEchoMsg then
        return
    end
    local info = "/e [信息]" .. msg
    SendTextCommand(info)
    if ttsOn and M.Config.Main.TTS == true then
        TensorCore.addAlertText(0, msg, 1, 2, true)
    end
end

--- 输出信息到控制台
--- @param msg string
M.Debug = function(msg)
    local info = "[MuAiGuide]" .. msg
    d(info)
end

--- 计算索引位置
--- @param orderTable table 基于哪个优先级序列的表
--- @param value any 元素成员
--- @return number index 索引
M.IndexOf = function(orderTable, value)
    for i = 1, #orderTable, 1 do
        if value == orderTable[i] then
            return i
        end
    end
    return 0
end

--- 字符串分割
--- @param str string 待分割的字符串
--- @param mark string 分隔符（默认为","）
--- @return table 分割后的列表
M.StringSplit = function(str, mark)
    mark = mark or ","
    local input = string.gsub(str, "，", ",")
    local t = {}
    if input == "" then
        return t
    end
    local pattern = "([^" .. mark .. "]+)"
    for match in string.gmatch(input, pattern) do
        table.insert(t, match)
    end
    return t
end

--- 列表进行拼接
--- @param tbl table 表
--- @param mark string 分隔符
--- @return table result 拼合后的字符串
M.StringJoin = function(tbl, mark)
    local result = ""
    if tbl == nil or table.size(tbl) == 0 then
        return result
    end
    for i, v in ipairs(tbl) do
        if i > 1 then
            result = result .. mark
        end
        result = result .. tostring(v)
    end
    return result
end

--- 将表B合并到表A中
M.Append = function(tblA, tblB)
    local tbl = {}
    for _, v in ipairs(tblA) do
        table.insert(tbl, v)
    end
    for _, v in ipairs(tblB) do
        table.insert(tbl, v)
    end
    return tbl
end

--- 计算2个弧度之间的夹角（0~π）
M.GetAngleRadian = function(r1, r2)
    local diff = math.abs(r2 - r1)
    if diff > math.pi then
        diff = 2 * math.pi - diff
    end
    return diff
end

--- 判断2个数是否相等
--- @return boolean is same
M.IsSame = function(n1, n2)
    if n1 == nil or n2 == nil then
        return n1 == nil and n2 == nil
    end
    if n1 == n2 then
        return true
    end
    local diff = math.abs(n1 - n2)
    if diff < 0.05 then
        return true
    end
    return false
end

--- 将给定弧度调整到0~2π
M.SetHeading2Pi = function(heading)
    if M.IsSame(heading, 0) or M.IsSame(heading, 2 * math.pi) then
        return 0
    end
    if heading > math.pi * 2 then
        local result = heading - math.pi * 2
        if M.IsSame(endH, 0) then
            return 0
        end
        return result
    end
    if heading < 0 then
        return heading + math.pi * 2
    end
    return heading
end

M.IsSameDirection = function(angle1, angle2, tolerance)
    tolerance = tolerance or 0.05
    angle1 = angle1 % (2 * math.pi)
    if angle1 < 0 then angle1 = angle1 + 2 * math.pi end
    angle2 = angle2 % (2 * math.pi)
    if angle2 < 0 then angle2 = angle2 + 2 * math.pi end
    local diff = math.abs(angle1 - angle2)
    if diff > math.pi then
        diff = 2 * math.pi - diff
    end
    return diff <= tolerance
end


--- 判断点A到B的顺逆
--- @return boolean true 顺时针，false 逆时针
M.GetClock = function(posA, posB)
    local OA = { x = posA.x - 100, z = posA.z - 100 }
    local OB = { x = posB.x - 100, z = posB.z - 100 }
    local crossProduct = OA.x * OB.z - OA.z * OB.x
    -- 非标准坐标系，叉乘结果要反着来
    if crossProduct > 0 then
        return true
    elseif crossProduct < 0 then
        return false
    end
end

--- 移除文件扩展名
M.RemoveExtension = function(filename)
    local dotIndex = filename:match(".*()%.")
    if dotIndex then
        return filename:sub(1, dotIndex - 1)
    else
        return filename
    end
end

--- 不区分大小写方式判断表格存在元素
M.ContainsIgnoreCase = function(tbl, target)
    if type(tbl) ~= "table" or type(target) ~= "string" then
        return false
    end
    for _, value in ipairs(tbl) do
        if type(value) == "string" and string.lower(value) == string.lower(target) then
            return true
        end
    end
    return false
end

--- 创建默认配置
M.CreateDefMainCfg = function()
    local mainCfg = {
        --- 指路工具颜色
        GuideColor = { r = 0, g = 1, b = 1, a = 0.5 },
        --- 指路工具颜色（分摊）
        GuidePairColor = { r = 0, g = 0, b = 1, a = 0.5 },
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
    }
    return mainCfg
end

--- 创建绝伊甸默认配置
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
    if (not FolderExists(savePath)) then
        FolderCreate(savePath)
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
--- 初始化设置信息
M.InitConfig = function()
    M.Config = {}
    M.Config.MainPath = GetLuaModsPath() .. "MuAiCore\\Configs"
    M.Config.MainFile = "MainConfig.lua"
    M.Config.FruGuidePath = M.Config.MainPath .. "\\FruGuide"
    M.Config.FruGuideFile = "GuideConfig.lua"
    M.Config.FruMitigationPath = M.Config.MainPath .. "\\FruMitigation"
    M.Config.FruMitigationFile = "FruMitigation.lua"
    M.Config.Key1 = { "Shift", "Ctrl", "Alt" }
    M.Config.Key2 = {}
    for i = 65, 90 do
        table.insert(M.Config.Key2, string.char(i))
    end
    table.insert(M.Config.Key2, "~")
    --- 旧存档修正
    if FolderExists(M.Config.FruGuidePath) and FileExists(M.Config.FruGuidePath .. "\\MuAiGuideConfig.lua") then
        local mainSave, fruSave
        local config = FileLoad(M.Config.FruGuidePath .. "\\MuAiGuideConfig.lua")
        fruSave = table.deepcopy(config.FruCfg)
        config.FruCfg = nil
        mainSave = table.deepcopy(config)
        FileDelete(M.Config.FruGuidePath .. "\\MuAiGuideConfig.lua")
        M.Config.Main = mainSave
        M.Config.MainPrevious = mainSave
        M.Config.FruCfg = fruSave
        M.Config.FruCfgPrevious = fruSave
        FileSave(M.Config.MainPath .. "\\" .. M.Config.MainFile, mainSave)
        FileSave(M.Config.FruGuidePath .. "\\" .. M.Config.FruGuideFile, fruSave)
    else
        --- 读取主存档
        local defMainCfg = M.CreateDefMainCfg()
        M.Config.Main = M.LoadConfig(M.Config.MainPath, M.Config.MainFile, defMainCfg)
        M.Config.MainPrevious = table.deepcopy(M.Config.Main)
        --- 读取绝伊甸存档
        local defFruCfg = M.CreateFruDefaultCfg()
        M.Config.FruCfg = M.LoadConfig(M.Config.FruGuidePath, M.Config.FruGuideFile, defFruCfg)
        M.Config.FruCfgPrevious = table.deepcopy(M.Config.FruCfg)
    end
    M.Config.FruCustomList = M.LoadFileList(M.Config.FruGuidePath, { "GuideConfig.lua" })
    M.Config.FruCustomListIndex = 1
end

------------------------------- 游戏逻辑 -------------------------------
local SupportMap = { 1238, 1122, 1327}
local TankJobs = { 19, 21, 32, 37 }
local HealerJobs = { 24, 28, 33, 40 }
local MeleeJob = { 20, 22, 30, 34, 39, 41 }
local RangeJob = { 31, 23, 38 }
local MagicJob = { 25, 27, 35, 42 }
local JobIds = {
    19, 21, 32, 37,
    24, 33, 40, 28,
    34, 20, 22, 30, 39, 41,
    31, 23, 38,
    27, 42, 25, 35
}

local JobName = {
    "骑士", "战士", "黑骑", "绝枪",
    "白魔", "占星", "贤者", "学者",
    "武士", "武僧", "龙骑", "忍者", "钐镰", "蝰蛇",
    "机工", "诗人", "舞者",
    "召唤", "绘灵", "黑魔", "赤魔"
}

M.JobPosName = { "MT", "ST", "H1", "H2", "D1", "D2", "D3", "D4" }

--- 标记
M.HeadMark = {
    Attack1 = 1, Attack2 = 2, Attack3 = 3, Attack4 = 4, Attack5 = 5,
    Attack6 = 15, Attack7 = 16, Attack8 = 17,
    Bind1 = 6, Bind2 = 7, Bind3 = 8,
    Stop1 = 9, Stop2 = 10,
    Square = 11, Circle = 12, Cross = 13, Triangle = 14,
}

M.GetHeadMarkCN = function(mark)
    local markType
    if mark < 5 or mark >= 15 and mark <= 17 then
        if mark <= 5 then
            markType = "攻击" .. mark
        else
            markType = "攻击" .. (mark - 9)
        end
    elseif mark < 9 then
        markType = "锁链" .. (mark - 5)
    elseif mark < 11 then
        markType = "禁止" .. (mark - 8)
    elseif mark == 11 then
        markType = "方块"
    elseif mark == 12 then
        markType = "圆圈"
    elseif mark == 13 then
        markType = "十字"
    elseif mark == 14 then
        markType = "三角"
    end
    return markType
end

--- 当前职业ID是否是坦克
M.IsTank = function(job)
    return table.contains(TankJobs, job)
end
--- 当前职业ID是否是治疗
M.IsHealer = function(job)
    return table.contains(HealerJobs, job)
end
--- 当前职业ID是否是近战
M.IsMelee = function(job)
    return table.contains(MeleeJob, job)
end
--- 当前职业ID是否是远敏
M.IsRange = function(job)
    return table.contains(RangeJob, job)
end
--- 当前职业ID是否是法师职业
M.IsMagic = function(job)
    return table.contains(MagicJob, job)
end
--- 当前职业ID是否是DPS职业
M.IsDps = function(job)
    return table.contains(MeleeJob, job)
            or table.contains(RangeJob, job)
            or table.contains(MagicJob, job)
end

--- 当前物体是否是玩家
M.IsPlayer = function(entity)
    if not entity
            or not entity.job
            or entity.type ~= 1
            or not table.contains(JobIds, entity.job)
    then
        return false
    end
    return true
end

--- 获取职业名称
--- @param job number 职业ID
M.GetJobNameById = function(job)
    for i = 1, #JobIds, 1 do
        if JobIds[i] == job then
            return JobName[i]
        end
    end
end

--- 读取小队列表
M.GetPartyPlayers = function()
    local curPt = TensorCore.getEntityGroupList("Party")
    local members = {}
    local checker = {}
    -- 回放模式或者其他情况
    if #curPt == 1 then
        table.insert(members, curPt[1])
        table.insert(checker, curPt[1].id)
        curPt = TensorCore.entityList("Party")
    end
    for _, ent in pairs(curPt) do
        if M.IsPlayer(ent)
                and ent.type == 1
                and not table.contains(checker, ent.id)
                and ent.name ~= nil and ent.name ~= ""
        then
            table.insert(members, ent)
        end
    end
    return members
end

--- 读取小队信息（初始化模块）
M.LoadParty = function()
    M.Party = {}
    local members = M.GetPartyPlayers()
    table.sort(members, function(p1, p2) return M.IndexOf(JobIds, p1.job) < M.IndexOf(JobIds, p2.job) end)
    if table.size(members) == 4 then
        for i = 1, 4 do
            if M.IsTank(members[i].job) then
                if M.Party.MT == nil then
                    M.Party.MT = members[i]
                end
            elseif M.IsHealer(members[i].job) then
                if M.Party.H1 == nil then
                    M.Party.H1 = members[i]
                end
            else
                if M.Party.D1 == nil then
                    M.Party.D1 = members[i]
                elseif M.Party.H2 == nil then
                    M.Party.D2 = members[i]
                end
            end
        end
        M.GetSelfPos()
        return
    end
    if members == nil or table.size(members) < 8 then
        M.Info("当前没有组队。")
        return
    end

    local memberHasSet = {}
    for i = 1, 8, 1 do
        if M.IsTank(members[i].job) then
            if M.Party.MT == nil then
                M.Party.MT = members[i]
                table.insert(memberHasSet, members[i])
            elseif M.Party.ST == nil then
                M.Party.ST = members[i]
                table.insert(memberHasSet, members[i])
            end
        elseif M.IsHealer(members[i].job) then
            if M.Party.H1 == nil then
                M.Party.H1 = members[i]
                table.insert(memberHasSet, members[i])
            elseif M.Party.H2 == nil then
                M.Party.H2 = members[i]
                table.insert(memberHasSet, members[i])
            end
        elseif M.IsMelee(members[i].job) then
            if M.Party.D1 == nil then
                M.Party.D1 = members[i]
                table.insert(memberHasSet, members[i])
            elseif M.Party.D2 == nil then
                M.Party.D2 = members[i]
                table.insert(memberHasSet, members[i])
            end
        elseif M.IsRange(members[i].job) then
            if M.Party.D3 == nil then
                M.Party.D3 = members[i]
                table.insert(memberHasSet, members[i])
            end
        elseif M.IsMagic(members[i].job) then
            if M.Party.D4 == nil then
                M.Party.D4 = members[i]
                table.insert(memberHasSet, members[i])
            end
        end
    end

    if #memberHasSet < 8 then
        for i = 1, #members, 1 do
            if not table.contains(memberHasSet, members[i]) then
                if M.Party.MT == nil then
                    M.Party.MT = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.ST == nil then
                    M.Party.ST = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.H1 == nil then
                    M.Party.H1 = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.H2 == nil then
                    M.Party.H2 = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.D1 == nil then
                    M.Party.D1 = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.D2 == nil then
                    M.Party.D2 = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.D3 == nil then
                    M.Party.D3 = members[i]
                    table.insert(memberHasSet, members[i])
                elseif M.Party.D4 == nil then
                    M.Party.D4 = members[i]
                    table.insert(memberHasSet, members[i])
                end
            end
        end
    end

    M.GetSelfPos()
end

--- 计算自己当前的职能
M.GetSelfPos = function()
    -- 设置自己的职能
    if not M.Party then
        return
    end
    for jobPos, ent in pairs(M.Party) do
        if ent.id == M.GetPlayer().id then
            M.SelfPos = jobPos
            break
        end
    end
end

--- 获取当前玩家表
--- @return table | nil player
M.GetPlayer = function()
    if M.Party == nil then
        return nil
    end
    if M.DebugMode then
        local testPlayer = M.Party[M.DebugPos]
        if testPlayer == nil then
            return TensorCore.mGetPlayer()
        end
        return TensorCore.mGetEntity(testPlayer.id)
    end
    return TensorCore.mGetPlayer()
end

--- 通过ID来获取其他玩家
--- @return table | nil player
M.GetOtherPlayer = function(id)
    for _, member in pairs(M.Party) do
        if member.id == id then
            return member
        end
    end
    return nil
end

--- 判断当前物体是否是自己
--- @param entity table 查找到的entity
--- @return boolean result 是否是自己
M.IsMe = function(entity)
    if not entity then
        return false
    end
    return M.GetPlayer().id == entity.id
end

--- 判断当前物体是否是自己
--- @param curJosPos string 当前职能
--- @return boolean result 是否是自己
M.IsMeByPos = function(curJosPos)
    if not table.contains(M.JobPosName, curJosPos) or not M.Party then
        return false
    end
    local curPlayer = M.Party[curJosPos]
    if not curPlayer then
        return false
    end
    return M.GetPlayer().id == curPlayer.id
end

--- 计算目标点在中心点的相对方位 6点钟（C）逆时针 1~8
--- @param center table 中心点的坐标 {x=number, z=number}
--- @param target table 物品点的坐标 {x=number, z=number}
--- @return number 方位 ID（1~8）
M.GetDirectionIndex = function(center, target)
    local heading = TensorCore.getHeadingToTarget(center, target);
    local index = 0
    -- 请求弧度最接近的值
    for i = 1, 8 do
        local curRad = (i - 1) / 4 * math.pi
        if M.IsSame(heading, curRad) then
            index = i
            break
        end
    end
    return index
end

--- 根据给定的站位表和heading输出8方位置
--- @param tblStand table 站位表（C逆）
--- @param heading number 方向
--- @return string 方位名称
M.GetGamePointByHeading = function(tblStand, heading)
    for i = 1, 8 do
        local infoDir = (i - 1) * math.pi / 4
        if M.IsSame(infoDir, heading) then
            return tblStand[i]
        end
    end
    return nil
end

--- 从 startPos点出发，沿着 startPos => endPos 方向，获取距离为 distance 的点坐标
--- @param startPos table 起点坐标
--- @param endPos table 终点坐标
--- @param distance number 距离，正值为朝向终点方向，负值为反向
--- @return table targetPos 返回目标点的坐标，包含 x 和 z 分量
M.GetPointAtDistance = function(startPos, endPos, distance)
    local heading = TensorCore.getHeadingToTarget(startPos, endPos)
    return TensorCore.getPosInDirection(startPos, heading, distance)
end

--- 计算基础搭档
M.GetBasePartner = function(config)
    if config ~= nil then
        local jobPos = config.JobPos
        for i = 1, 8 do
            local curJob = jobPos[i]
            if curJob == M.SelfPos then
                local pIndex
                if i % 2 == 0 then
                    pIndex = i - 1
                else
                    pIndex = i + 1
                end
                return jobPos[pIndex]
            end
        end
    else
        local partner
        if M.SelfPos == "MT" then
            partner = "D3"
        elseif M.SelfPos == "ST" then
            partner = "D4"
        elseif M.SelfPos == "H1" then
            partner = "D1"
        elseif M.SelfPos == "H2" then
            partner = "D2"
        elseif M.SelfPos == "D1" then
            partner = "H1"
        elseif M.SelfPos == "D2" then
            partner = "H2"
        elseif M.SelfPos == "D3" then
            partner = "MT"
        elseif M.SelfPos == "D4" then
            partner = "ST"
        end
        return partner
    end
end

--- 计算同为远程/近战搭档
M.GetRMPartner = function()
    local partner
    if M.SelfPos == "MT" then
        partner = "D1"
    elseif M.SelfPos == "ST" then
        partner = "D2"
    elseif M.SelfPos == "H1" then
        partner = "D3"
    elseif M.SelfPos == "H2" then
        partner = "D4"
    elseif M.SelfPos == "D1" then
        partner = "MT"
    elseif M.SelfPos == "D2" then
        partner = "ST"
    elseif M.SelfPos == "D3" then
        partner = "H1"
    elseif M.SelfPos == "D4" then
        partner = "H2"
    end
    return partner
end

--- 暂不支持
M.MarkParty = function(marker, id)
end

------------------------------- 绘图工具 -------------------------------
M.NotDelayGuides = {}

--- 取消已注册的所有指路
M.CancelDir = function()
    if table.size(M.NotDelayGuides) > 0 then
        for i, uuid in pairs(M.NotDelayGuides) do
            Argus.deleteTimedShape(uuid)
        end
        M.NotDelayGuides = {}
    end
end

--- 绘制一个指路工具
--- @param x number 当前x坐标
--- @param z number 当前z坐标
--- @param time number 指路时间（毫秒）
--- @param size? number 圈大小（默认0.5）
--- @param delay? number 延迟执行（毫秒）
M.DirectTo = function(x, z, time, size, delay)
    local color = M.Config.Main.GuideColor
    size = size or 0.5
    delay = delay or 0
    if delay < 1 then
        M.CancelDir()
    end
    local curPlayer = M.GetPlayer()
    curPlayer = curPlayer or Player
    local drawY
    if table.contains(SupportMap, Player.localmapid) then
        drawY = 0
    else
        drawY = curPlayer.pos.y
    end
    local newDraw = Argus2.ShapeDrawer:new(
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),
            2
    )
    local guide1 = newDraw:addTimedCircle(time, x, drawY, z, size, delay, true)
    local guide2 = Argus2.addTimedRectFilled(
            time,
            x,
            drawY,
            z,
            0.3,
            0.05,
            math.pi,
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
            nil,
            delay,
            nil,
            curPlayer.id,
            false,
            nil,
            0.01,
            nil,
            nil,
            true
    )

    local newDraw2 = Argus2.ShapeDrawer:new(
            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
            nil,
            1
    )

    local guide3 = newDraw2:addTimedCircle(time, x, drawY, z, 0.03, delay, true)
    if delay < 1 then
        table.insert(M.NotDelayGuides, guide1)
        table.insert(M.NotDelayGuides, guide2)
        table.insert(M.NotDelayGuides, guide3)
    end
end

--- 绘制一个连到其他玩家的连线（矩形）
M.LinkToPlayer = function(id, time, size, r, g, b, a)
    size = size or 0.05
    r = r or 0
    g = g or 0
    b = b or 0
    a = a or 0.55
    if r == 0 and g == 0 and b == 0 then
        b = 255
    end
    local curPlayer = M.GetPlayer()
    local drawY
    if table.contains(SupportMap, Player.localmapid) then
        drawY = 0
    else
        drawY = curPlayer.pos.y
    end
    Argus2.addTimedRectFilled(
            time,
            100,
            drawY,
            100,
            0.3,
            size,
            math.pi,
            (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),
            (GUI:ColorConvertFloat4ToU32(r / 255, g / 255, b / 255, a)),
            nil,
            0,
            id,
            curPlayer.id,
            false,
            nil,
            0.01,
            nil,
            nil,
            true
    )
end

--- 指路到某移动物体
--- @param id number 目标的Id
--- @return table uuidList
M.DirectToEnt = function(id, time, size)
    local drawIds = {}
    size = size or 0.2
    local color = M.Config.Main.GuidePairColor
    local newDraw = Argus2.ShapeDrawer:new(
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),
            2
    )
    local curPlayer = M.GetPlayer()
    local drawY
    if table.contains(SupportMap, Player.localmapid) then
        drawY = 0
    else
        drawY = curPlayer.pos.y
    end
    local id1 = newDraw:addTimedCircleOnEnt(time, id, size, 0, true)
    local id2 = Argus2.addTimedRectFilled(
            time,
            0,
            drawY,
            0,
            0.3,
            0.05,
            math.pi,
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
            nil,
            0,
            id,
            curPlayer.id,
            false,
            nil,
            0.01,
            nil,
            nil,
            true
    )
    local newDraw2 = Argus2.ShapeDrawer:new(
            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
            nil,
            1
    )

    local id3 = newDraw2:addTimedCircleOnEnt(time, id, 0.03, 0, true)
    table.insert(drawIds, id1)
    table.insert(drawIds, id2)
    table.insert(drawIds, id3)
    return drawIds
end

--- 帧指路OnFrame用
--- @param x number 指路位置x
--- @param z number 指路位置z
--- @param size number 圆圈大小
M.FrameDirect = function(x, z, size)
    size = size or 0.5
    local playerPos = TensorCore.mGetEntity((M.GetPlayer() or Player).id).pos
    local drawY
    if table.contains(SupportMap, Player.localmapid) then
        drawY = 0
    else
        drawY = playerPos.y
    end
    local color = M.Config.Main.GuideColor
    local newDraw = Argus2.ShapeDrawer:new(
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)),
            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),
            2
    )
    newDraw:addCircle(x, drawY, z, size, true)
    local newDraw2 = Argus2.ShapeDrawer:new(
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
            2
    )
    local distance = TensorCore.getDistance2d(playerPos, { x = x, y = 0, z = z })
    local heading = TensorCore.getHeadingToTarget(playerPos, { x = x, y = 0, z = z })
    newDraw2:addRect(playerPos.x, drawY, playerPos.z, distance, 0.05, heading, true)
    local newDraw3 = Argus2.ShapeDrawer:new(
            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
            nil,
            1
    )
    newDraw3:addCircle(x, drawY, z, 0.03, true)
end

--- 绘制一个圆（已废弃仿报错用）
M.DrawCircleUI = function(x, z, time, size, r, g, b, a, delay)
end

--- 绘制一个地面圆（已废弃仿报错用）
M.DrawCircleFloor = function(x, z, time, size, r, g, b, a, delay)
end

M.Debug("初始化成功!")
return M
