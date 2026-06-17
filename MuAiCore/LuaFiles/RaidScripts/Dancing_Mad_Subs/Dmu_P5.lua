local Dmu_P5 = {}
Dmu_P5.StateName = "P5"
---@type DancingMad
local DM
---@type MuAiGuide
local MG

local Cfg = function()
    return MG.Config.DmuCfg.P5
end

local Data = function()
    if MG.DancingMad == nil then
        return nil
    end
    return MG.DancingMad.P5
end

Dmu_P5.Init = function()
end

Dmu_P5.OnEntityCast = function()
end
Dmu_P5.OnEntityChannel = function()
end
Dmu_P5.OnMapEffect = function()
end
Dmu_P5.Update = function()
end
return Dmu_P5