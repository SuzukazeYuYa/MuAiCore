local DevelopModel = {}
--[[
===========================
    开发工具数据模块
===========================
]]
---@param M MuAiGuide
DevelopModel.init = function(M)
    M.Develop = {
        JobView = false,
        ViewedJob = "MT",
        UIRefresh = false,
        ScRefresh = false,
        State = nil,
        DateTable = nil,
        DateCatch = false,
        ShowMarkId = false,
        ShowTime = 10,
        PrintMarkId = false,
        ShowSkillId = false,
        PrintChannelInfo = false,
        CacheAoeInfo = false,
        PrintAoeInfo = false,
        AoeInfo = {},
        PrintMapEffect = false,
        ShowTetherInfo = false,
        PrintVFXInfo = false,
        VFXFilter = false,
        VFXFilterNoPlayer = false,
        VFXFilterMax = 65535,
        VFXFilterMin = 0,
        TempList = {}
    }
    --- @ 注册开发模数据表格名称
    M.Develop.Reg = function(key)
        M.Develop.DateTable = key
    end
end
return DevelopModel