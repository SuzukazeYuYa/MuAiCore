local function MitigationDef(M)
    M.FruMitigation = {}
    M.FruMitigation.AoeNames = {
        --- P1
        { key = "SinsMite", p = 1, name = "罪雷/罪焰", macroInfo = "开场" },
        { key = "BurnishedGlory1", p = 1, name = "光焰圆光1", macroInfo = "光焰圆光1" },
        { key = "BurnishedGlory2", p = 1, name = "光焰圆光2", macroInfo = "光焰圆光2" },
        --- P2
        { key = "DiamondDust", p = 2, name = "钻石星尘", macroInfo = "DD AOE" },
        { key = "SinBound", p = 2, name = "罪神圣", macroInfo = "DD跑圈" },
        { key = "HallowedRay", p = 2, name = "神圣射线", macroInfo = "激光" },
        { key = "LightRampant", p = 2, name = "光之失控", macroInfo = "光暴" },
        { key = "HouseOfLight", p = 2, name = "光之海啸", macroInfo = "最后踩塔" },
        { key = "AbsoluteZero", p = 2, name = "绝对零度", macroInfo = "狂暴读条" },
        --- P3
        { key = "Relativity", p = 3, name = "时间压缩", macroInfo = "1运AOE" },
        { key = "ShockwavePulsar", p = 3, name = "罪熔毁", macroInfo = "1运中间" },
        { key = "ShellCrusher", p = 3, name = "破盾一击", macroInfo = "1运后AOE" },
        { key = "DarkWater", p = 3, name = "黑暗狂水", macroInfo = "击退分摊" },
        { key = "MemorySEnd", p = 3, name = "记忆终结", macroInfo = "狂暴读条" },
        --- P4
        { key = "DarkLitDragonSong", p = 4, name = "光暗龙诗", macroInfo = "1运AOE" },
        { key = "MornAfah1", p = 4, name = "无尽顿悟1", macroInfo = "无尽顿悟1" },
        { key = "CrystallizeTime", p = 4, name = "时间结晶", macroInfo = "二运AOE" },
        { key = "HallowedWings", p = 4, name = "神圣之翼", macroInfo = "击退" },
        { key = "MornAfah2", p = 4, name = "无尽顿悟2", macroInfo = "无尽顿悟2" },
        --- P5
        { key = "FulgentBlade1", p = 5, name = "光尘之剑1", macroInfo = "1地火" },
        { key = "AkhMorn1", p = 5, name = "死亡轮回1", macroInfo = "1分摊" },
        { key = "Polarizing1", p = 5, name = "星灵之剑1", macroInfo = "1挡枪" },
        { key = "FulgentBlade2", p = 5, name = "光尘之剑2", macroInfo = "2地火" },
        { key = "AkhMorn2", p = 5, name = "死亡轮回2", macroInfo = "2分摊" },
        { key = "Polarizing2", p = 5, name = "星灵之剑2", macroInfo = "2挡枪" },
        { key = "FulgentBlade3", p = 5, name = "光尘之剑3", macroInfo = "3地火" },
        { key = "AkhMorn3", p = 5, name = "死亡轮回3", macroInfo = "3分摊" },
    }
    M.FruMitigation.JobMap = {
        --- TANK
        [19] = { "雪仇", "幕帘" },
        [21] = { "雪仇", "摆脱" },
        [32] = { "雪仇", "步道" },
        [37] = { "雪仇", "光心" },
        --- Melee
        [34] = { "牵制" },
        [20] = { "牵制", "真言" },
        [22] = { "牵制" },
        [30] = { "牵制" },
        [39] = { "牵制", "神秘纹" },
        [41] = { "牵制" },
        --- Range
        [31] = { "扳手", "策动", },
        [23] = { "大地神", "行吟", },
        [38] = { nil, "桑巴" },
        --- Magic
        [27] = { "混乱" },
        [42] = { "混乱", "画盾" },
        [25] = { "混乱", },
        [35] = { "混乱", "抗死" },
    }
    local createTankDef = function()
        local table = {
            P1_Death1 = 1,
            P1_Death2 = 1,
            P2_Open = 1,
            P3_BlackRing = 1,
            P3_DarkestDance = 1,
            P4_DarkestDance = 1,
            P4_AkhMorn1 = 1,
            P4_AkhMorn2 = 1,
            P5_Death1 = 1,
            P5_Death2 = 1,
        }
        return table
    end

    M.FruMitigation.LoadDefault = function()
        local ConfigValue = {
            --- P1
            SinsMite = { p = 1, Target = true, Field = true },
            BurnishedGlory1 = { p = 1, Target = true, Field = false },
            BurnishedGlory2 = { p = 1, Target = false, Field = false },
            --- P2
            DiamondDust = { p = 2, Target = true, Field = false },
            SinBound = { p = 2, Target = nil, Field = false },
            HallowedRay = { p = 2, Target = false, Field = false },
            LightRampant = { p = 2, Target = true, Field = true },
            HouseOfLight = { p = 2, Target = false, Field = true },
            AbsoluteZero = { p = 2, Target = true, Field = false },
            --- P3
            Relativity = { p = 3, Target = true, Field = false },
            ShockwavePulsar = { p = 3, Target = nil, Field = true },
            ShellCrusher = { p = 3, Target = false, Field = false },
            DarkWater = { p = 3, Target = true, Field = false },
            MemorySEnd = { p = 3, Target = false, Field = false },
            --- P4
            DarkLitDragonSong = { p = 4, Target = true, Field = false },
            MornAfah1 = { p = 4, Target = false, Field = true },
            CrystallizeTime = { p = 4, Target = true, Field = false },
            HallowedWings = { p = 4, Target = nil, Field = false },
            MornAfah2 = { p = 4, Target = true, Field = false },
            --- P5
            FulgentBlade1 = { p = 5, Target = true, Field = false },
            AkhMorn1 = { p = 5, Target = false, Field = false },
            Polarizing1 = { p = 5, Target = true, Field = true },
            FulgentBlade2 = { p = 5, Target = false, Field = false },
            AkhMorn2 = { p = 5, Target = true, Field = false },
            Polarizing2 = { p = 5, Target = false, Field = true },
            FulgentBlade3 = { p = 5, Target = true, Field = false },
            AkhMorn3 = { p = 5, Target = false, Field = false },
        }
        if M.IsTank(Player.job) then
            ConfigValue.Tank = createTankDef()
        end
        return ConfigValue
    end

    M.FruMitigation.ChangeJob = function()
        local defConfig = M.FruMitigation.LoadDefault()
        M.Config.FruMitigation = M.LoadConfig(M.Config.FruMitigationPath .. "\\" .. M.GetJobNameById(Player.job), M.Config.FruMitigationFile, defConfig)
        M.Config.FruMitigationPrevious = table.deepcopy(M.Config.FruMitigation)
        M.Config.FruMitigationCustomList = M.LoadFileList(M.Config.FruMitigationPath .. "\\" .. M.GetJobNameById(Player.job), { M.Config.FruMitigationFile })
        M.Config.FruMitigationCustomListIndex = 1

    end
end
return MitigationDef
