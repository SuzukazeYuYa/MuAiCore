local Drawers = {}
--[[
===========================
    绘图工具数据模块
===========================
]]
-- 画图基础颜色定义
local r_03 = GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.3)
local g_03 = GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.3)
local b_03 = GUI:ColorConvertFloat4ToU32(0, 0, 1, 0.3)
local yl_03 = GUI:ColorConvertFloat4ToU32(1, 1, 0, 0.3)
local cy_03 = GUI:ColorConvertFloat4ToU32(0, 1, 1, 0.3)
local pp_03 = GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.3)
local w_1 = GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)




---@param M MuAiGuide
Drawers.init = function(M)
    local ZeroYMap = { 1238, 1122, 1325, 1327, 1363 }
    M.NotDelayGuides = {}
    M.NotDelayGuidesMulti = {}
    -- 画图工具定义
    --M.RedDrawer = Argus2.ShapeDrawer:new(r_03, r_03, r_03, w_1, 1)
    --M.GreenDrawer = Argus2.ShapeDrawer:new(g_03, g_03, g_03, w_1, 1)
    --M.BlueDrawer = Argus2.ShapeDrawer:new(b_03, b_03, b_03, w_1, 1)
    --M.YellowDrawer = Argus2.ShapeDrawer:new(yl_03, yl_03, yl_03, w_1, 1)
    --M.CyanDrawer = Argus2.ShapeDrawer:new(cy_03, cy_03, cy_03, w_1, 1)
    --- 取消已注册的所有指路
    M.CancelDir = function()
        if table.size(M.NotDelayGuides) > 0 then
            for _, uuid in pairs(M.NotDelayGuides) do
                Argus.deleteTimedShape(uuid)
            end
            M.NotDelayGuides = {}
        end
    end

    local commonDirect = function(x, z, player, color, time, size, cacheTable, delay)
        local y
        if table.contains(ZeroYMap, Player.localmapid) then
            y = 0
        else
            if M.GlobalGuideY ~= nil then
                y = M.GlobalGuideY
            else
                y = player.pos.y
            end
        end
        local curU32Color = GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)
        local newDraw = Argus2.ShapeDrawer:new(curU32Color, curU32Color, curU32Color, w_1, 2)
        local guide1 = newDraw:addTimedCircle(time, x, y, z, size, delay, true, true)
        local guide2 = Argus2.addTimedRectFilled(
                time, x, y, z, 0.3, 0.05,
                math.pi,
                (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
                (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)),
                nil,
                delay,
                nil,
                player.id,
                false,
                nil,
                0.01,
                nil,
                nil,
                true,
                true
        )

        local colorU32PP = GUI:ColorConvertFloat4ToU32(1, 0, 1, 1)
        local newDraw2 = Argus2.ShapeDrawer:new(colorU32PP, colorU32PP, colorU32PP, nil, 1)
        local guide3 = newDraw2:addTimedCircle(time, x, y, z, 0.03, delay, true, true)
        if delay < 1 then
            table.insert(cacheTable, guide1)
            table.insert(cacheTable, guide2)
            table.insert(cacheTable, guide3)
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
        commonDirect(x, z, curPlayer, color, time, size, M.NotDelayGuides, delay)
    end

    --- 绘制多人指路工具
    --- @param data table 多人目标坐标数据
    --- @param time number 指路时间（毫秒）
    --- @param size? number 圈大小（默认0.5）
    --- @param delay? number 延迟执行（毫秒）
    M.MultiDirectTo = function(data, time, size, delay)
        if M.MultiGuide.players == nil or table.size(M.MultiGuide.players) == 0 then
            M.MultiGuide.players = {
                [M.SelfPos] = {
                    obj = M.GetPlayer(),
                    color = M.Config.Main.GuideColor
                }
            }
        end
        for job, multiData in pairs(M.MultiGuide.players) do
            local pos = data[job]
            if pos ~= nil then
                if M.NotDelayGuidesMulti[job] == nil then
                    M.NotDelayGuidesMulti[job] = {}
                end
                if delay < 1 then
                    if table.size(M.NotDelayGuidesMulti[job]) > 0 then
                        for _, uuid in pairs(M.NotDelayGuidesMulti[job]) do
                            Argus.deleteTimedShape(uuid)
                        end
                        M.NotDelayGuidesMulti[job] = {}
                    end
                end
                local curPlayer = multiData.obj
                local color = multiData.color
                commonDirect(pos.x, pos. z, curPlayer.id, color, time, size, M.NotDelayGuidesMulti[job], delay)
            end
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
        if table.contains(ZeroYMap, Player.localmapid) then
            drawY = 0
        else
            if M.GlobalGuideY ~= nil then
                drawY = M.GlobalGuideY
            else
                drawY = curPlayer.pos.y
            end
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
                true,
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
        if table.contains(ZeroYMap, Player.localmapid) then
            drawY = 0
        else
            if M.GlobalGuideY ~= nil then
                drawY = M.GlobalGuideY
            else
                drawY = curPlayer.pos.y
            end
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
                true,
                true
        )
        local newDraw2 = Argus2.ShapeDrawer:new(
                (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
                (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
                (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 1)),
                nil,
                1
        )

        local id3 = newDraw2:addTimedCircleOnEnt(time, id, 0.03, 0, true, true)
        table.insert(drawIds, id1)
        table.insert(drawIds, id2)
        table.insert(drawIds, id3)
        return drawIds
    end

    local commonFrameDirect = function(x, z, playerPos, color, size)
        local drawY
        if table.contains(ZeroYMap, Player.localmapid) then
            drawY = 0
        else
            drawY = M.GlobalGuideY or playerPos.y
        end
        size = size or 0.5
        local drawer1Color = GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)
        local drawer2Color = GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)
        local drawer3Color = GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)
        local newDraw = Argus2.ShapeDrawer:new(drawer1Color, drawer1Color, drawer1Color, w_1, 2)
        local newDraw2 = Argus2.ShapeDrawer:new(drawer2Color, drawer2Color, drawer2Color, drawer2Color, 2)
        local newDraw3 = Argus2.ShapeDrawer:new(drawer3Color, drawer3Color, drawer3Color, nil, 1)
        local distance = TensorCore.getDistance2d(playerPos, { x = x, y = 0, z = z })
        local heading = TensorCore.getHeadingToTarget(playerPos, { x = x, y = 0, z = z })
        newDraw:addCircle(x, drawY, z, size, true)
        newDraw2:addRect(playerPos.x, drawY, playerPos.z, distance, 0.05, heading, true)
        newDraw3:addCircle(x, drawY, z, 0.03, true)
    end

    --- 帧指路OnFrame用
    --- @param x number 指路位置x
    --- @param z number 指路位置z
    --- @param size number 圆圈大小
    M.FrameDirect = function(x, z, size)
        local curPlayer = M.GetPlayer() or Player
        local playerPos = TensorCore.mGetEntity(curPlayer.id).pos
        local color = M.Config.Main.GuideColor
        commonFrameDirect(x, z, playerPos, color, size)
    end

    --- 帧指路OnFrame用
    --- @param data table 数据表 key job, value 位置
    --- @param size number 圆圈大小
    M.FrameMultiD = function(data, size)
        for job, multiData in pairs(M.MultiGuide.players) do
            local pos = data[job]
            if pos ~= nil then
                local playerPos = TensorCore.mGetEntity(multiData.obj.id).pos
                local color = multiData.color
                commonFrameDirect(pos.x, pos.z, playerPos, color, size)
            end
        end
    end

    local getLinePos = function(A, B, P)
        local ABx, ABz = B.x - A.x, B.z - A.z
        local APx, APz = P.x - A.x, P.z - A.z
        local abLenSq = ABx * ABx + ABz * ABz
        if abLenSq == 0 then
            return false, { x = A.x, z = A.z }
        end
        local t = (APx * ABx + APz * ABz) / abLenSq
        local isOnSegment = t >= 0 and t <= 1
        local point = {}
        if t < 0 then
            point = { x = A.x, z = A.z }
        elseif t > 1 then
            point = { x = B.x, z = B.z }
        else
            point = { x = A.x + ABx * t, z = A.z + ABz * t }
        end
        return isOnSegment, point
    end

    --- 帧指路接线
    --- @param pos1 table 线第1端位置(物)
    --- @param pos2 table 线第2端位置(人)
    --- @param playerPos table 玩家位置
    --- @param size number 线粗(可缺省)
    M.FrameTakeLine = function(pos1, pos2, playerPos, size)
        size = size or 5
        local drawer = Argus2.ShapeDrawer:new(
                (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0)),
                (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0)),
                (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0)),
                (GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)),
                3
        )
        drawer:addLine(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, size, 0)
        local isInLine, nearestPos = getLinePos(pos2, pos1, playerPos)
        if isInLine then
            M.FrameDirect(nearestPos.x, nearestPos.z)
        else
            local heading = TensorCore.getHeadingToTarget(pos2, pos1)
            local guidePos = TensorCore.getPosInDirection(pos2, heading, 1)
            M.FrameDirect(guidePos.x, guidePos.z)
        end
    end

    M.DrawTargetPos = function()
        local target = TensorCore.mGetTarget()
        if not M.Config.Main.ShowTargetPos
                or target == nil
                or not target.attackable
                or (M.IsTank(TensorCore.mGetPlayer().job) and not M.Config.Main.ShowTargetPosTank)
        then
            return
        end
        local color = M.Config.Main.TargetPosColor
        local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a), 1)
        drawer:addCircle(target.pos.x, target.pos.y, target.pos.z, 0.01 * M.Config.Main.TargetPosSize, true)
    end

    M.DrawGuidePreView = function()
        local testPos = TensorCore.getPosInDirection(Player.pos, Player.pos.h, 2)
        M.DirectTo(testPos.x, testPos.z, 5000)
    end

    M.DrawGuidePreViewGather = function()
        local entities = TensorCore.entityList("All")
        if entities ~= nil then
            local target
            local dis = 100000
            for _, ent in pairs(entities) do
                if Argus.isEntityVisible(ent) and ent.name ~= nil and ent.job ~= 0 and ent.charType == 4 then
                    local distance = TensorCore.getDistance2d(Player.pos, ent.pos)
                    if target == nil or distance < dis then
                        dis = distance
                        target = ent
                    end
                end
            end
            if target ~= nil then
                M.DirectToEnt(target.id, 5000)
            else
                M.Info("附近没有任何玩家！")
            end
        else
            M.Info("附近没有任何玩家！")
        end
    end

    local fromIndex = {}
    M.DrawAllLink = function()
        if not MuAiGuide.Develop.ShowTetherInfo then
            return
        end
        local allTethers = Argus.getCurrentTethers()
        if allTethers == nil or table.size(allTethers) == 0 then
            return
        end
        local colors = {
            { r = 1, g = 0, b = 0 },
            { r = 0, g = 1, b = 0 },
            { r = 0, g = 0, b = 1 },
            { r = 0, g = 1, b = 1 },
            { r = 1, g = 0, b = 1 },
            { r = 1, g = 1, b = 0 },
        }
        local colorIdx = 1
        for fromId, tethers in pairs(allTethers) do
            if fromIndex[fromId] == nil then
                fromIndex[fromId] = {}
            end
            for _, tether in pairs(tethers) do
                local fromEnt = TensorCore.mGetEntity(fromId)
                local entEnt = TensorCore.mGetEntity(tether.targetid)
                if fromEnt == nil or entEnt == nil then
                    return
                end
                if fromIndex[fromId][tether.targetid] == nil then
                    if colorIdx > 6 then
                        colorIdx = 1
                    end
                    fromIndex[fromId][tether.targetid] = colorIdx
                end
                local curFromIdx = fromIndex[fromId][tether.targetid]
                local curColor = colors[curFromIdx]
                local curColorValue = GUI:ColorConvertFloat4ToU32(curColor.r, curColor.g, curColor.b, 1)
                local drawer = TensorCore.getStaticDrawer(curColorValue, 1)
                local formPos = { x = fromEnt.pos.x, y = fromEnt.pos.y + 0.2 * (curFromIdx - 1), z = fromEnt.pos.z }
                local endPos = { x = entEnt.pos.x, y = entEnt.pos.y + 0.2 * (curFromIdx - 1), z = entEnt.pos.z }
                local distance = TensorCore.getDistance2d(formPos, endPos)
                local heading = TensorCore.getHeadingToTarget(formPos, endPos)
                drawer:addArrow(formPos.x, formPos.y, formPos.z, heading, distance - 0.5, 0.1, 0.5, 0.25, true)
                AnyoneCore.renderWorldText(tostring(tether.type), formPos, curColorValue, true, 1)
                colorIdx = colorIdx + 1
            end
        end
    end
    
    --- 通用创建 Drawer 函数
    ---@return ShapeDrawer
    M.CreateDrawer = function(r, g, b, a)
        local color = GUI:ColorConvertFloat4ToU32(r, g, b, a or 0.3)
        return Argus2.ShapeDrawer:new(color, color, color,
                GUI:ColorConvertFloat4ToU32(1, 1, 1, 1), 1)
    end
    
    --- 绘制一个圆（已废弃仿报错用）
    M.DrawCircleUI = function()
    end

    --- 绘制一个地面圆（已废弃仿报错用）
    M.DrawCircleFloor = function()
    end
end

return Drawers