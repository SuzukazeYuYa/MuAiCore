local MultiGuide = {}
--[[
===========================
    多重指路数据模块
===========================
]]
local playerData = {}
--- 支持指导逻辑的副本，无法设置 
local mapsIds = { 1363 }
---@param M MuAiGuide
MultiGuide.init = function(M)
    M.MultiGuide = {
        enable = false,
        maps = mapsIds,
        players = {},
    }

    M.MultiGuide.RefreshDic = function()
        M.MultiGuide.players = {}
        if M.Party and (M.GetPartyCnt() == 4 or M.GetPartyCnt() == 8) then
            for job, member in pairs(M.Party) do
                for id, player in pairs(playerData) do
                    if id == member.id then
                        M.MultiGuide.players[job] = player
                        break
                    end
                end
            end
        end
    end

    --- Multiplayer初始化玩家列表定义
    M.MultiGuide.initList = function()
        if M.Party ~= nil and (M.GetPartyCnt() == 4 or M.GetPartyCnt() == 8) and M.SelfPos ~= nil then
            local player = M.GetPlayer()
            playerData = {
                [player.id] = { obj = M.Party[M.SelfPos], color = M.Config.Main.GuideColor}
            }
        else
            playerData = {}
        end
        M.MultiGuide.RefreshDic()
    end

    M.MultiGuide.isPlayerInGuide = function(id)
        return playerData[id] ~= nil
    end

    --- Multiplayer添加制定职能玩家到列表
    --- @param playerJob string 玩家职能
    M.MultiGuide.addPlayer = function(playerJob)
        local colorCfg = M.Config.Main.MultiColor[playerJob]
        local player = M.Party[playerJob]
        playerData[player.id] = { obj = M.Party[playerJob], color = colorCfg }
        M.Info(string.format('已经将[%s]加入到指导列表。', player.name))
        M.MultiGuide.RefreshDic()
    end

    --- Multiplayer移除玩家
    --- @param playerJob string 玩家职能
    M.MultiGuide.removePlayer = function(playerJob)
        local player = M.Party[playerJob]
        playerData[player.id] = nil
        M.Info(string.format('已经将[%s]从指导列表中移除。', player.name))
        M.MultiGuide.RefreshDic()
    end

    --- 判断当前玩家是否在可指导地图
    M.MultiGuide.onMap = function()
        return table.contains(mapsIds, Player.localmapid)
    end

    M.MultiGuide.onMapChange = function()
        M.MultiGuide.enable = false
        M.MultiGuide.initList()
    end
    M.MultiGuide.resetAllColor = function()
        M.Config.Main.MultiColor = {
            ['MT'] = { r = 1.0, g = 0.0, b = 0.0, a = 0.5 },
            ['ST'] = { r = 1.0, g = 0.5, b = 0.0, a = 0.5 },
            ['H1'] = { r = 1.0, g = 1.0, b = 0.0, a = 0.5 },
            ['H2'] = { r = 0.0, g = 1.0, b = 0.0, a = 0.5 },
            ['D1'] = { r = 0.0, g = 1.0, b = 1.0, a = 0.5 },
            ['D2'] = { r = 0.0, g = 0.0, b = 1.0, a = 0.5 },
            ['D3'] = { r = 0.2, g = 0.0, b = 0.5, a = 0.5 },
            ['D4'] = { r = 1.0, g = 0.3, b = 0.7, a = 0.5 }
        }
    end
end
return MultiGuide