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
local pp_1 = GUI:ColorConvertFloat4ToU32(1, 0, 1, 1)
local w_1 = GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)

---@param M MuAiGuide
Drawers.init = function(M)
    local ZeroYMap = { 1238, 1122, 1325, 1327, 1363 }
    M.NotDelayGuides = {}
    M.NotDelayGuidesMulti = {}
    local frameDirectCenterDrawer = TensorCore.getCachedDrawer(pp_1, pp_1, pp_1, nil, 1)
    local frameDirectStyles = setmetatable({}, { __mode = 'k' })
    -- 连续拉线只复用样式，位置仍在每次调用中重新提交。
    local singleTakeLineDrawer
    local multiTakeLineDrawers = {}
    local defaultTakeLineColor = { r = 1, g = 0, b = 0 }
    local targetPosDrawer, targetPosR, targetPosG, targetPosB, targetPosA
    -- 圆点只需要可攻击标志和位置，可直接按当前目标 ID 读取。旧宿主沿用 TensorCore。
    local directTarget = EntityList and type(EntityList.Get) == 'function'
    local function getDotTarget(id)
        if directTarget then return EntityList:Get(id) end
        return TensorCore.mGetEntity(id)
    end

    local optionalNumber = function(value, defaultValue, caller, name)
        if value == nil then
            return defaultValue
        end
        if type(value) ~= "number" then
            M.LogOnce('Drawers', caller .. '_invalid_' .. name,
                    '绘图参数类型错误，已使用默认值', { caller = caller, parameter = name, valueType = type(value) })
            return defaultValue
        end
        return value
    end

    local validDirectTarget = function(x, z, time, caller)
        if type(x) == "number" and type(z) == "number" and type(time) == "number" then
            return true
        end
        M.LogOnce('Drawers', caller .. '_invalid_target',
                '指路跳过：坐标或持续时间不是数字',
                { caller = caller, xType = type(x), zType = type(z), timeType = type(time) })
        return false
    end

    local validEntity = function(entity)
        local entityType = type(entity)
        return (entityType == "table" or entityType == "userdata")
                and entity.id ~= nil
                and entity.pos ~= nil
    end
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
                nil,
                true,
                true,
                0,
                false
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
        if not validDirectTarget(x, z, time, 'direct_to') then
            return false
        end
        local color = M.Config.Main.GuideColor
        size = optionalNumber(size, 0.5, 'direct_to', 'size')
        delay = optionalNumber(delay, 0, 'direct_to', 'delay')
        if delay < 1 then
            M.CancelDir()
        end
        local curPlayer = M.GetPlayer()
        curPlayer = curPlayer or Player
        if not validEntity(curPlayer) then
            M.LogOnce('Drawers', 'direct_to_missing_player', '指路跳过：未找到当前玩家实体')
            return false
        end
        commonDirect(x, z, curPlayer, color, time, size, M.NotDelayGuides, delay)
        return true
    end

    --- 绘制多人指路工具
    --- @param data table 多人目标坐标数据
    --- @param time number 指路时间（毫秒）
    --- @param size? number 圈大小（默认0.5）
    --- @param delay? number 延迟执行（毫秒）
    M.MultiDirectTo = function(data, time, size, delay)
        if type(data) ~= "table" or type(time) ~= "number" then
            M.LogOnce('Drawers', 'multi_direct_invalid_input',
                    '多人指路跳过：目标数据或持续时间无效',
                    { dataType = type(data), timeType = type(time) })
            return false
        end
        size = optionalNumber(size, 0.5, 'multi_direct', 'size')
        delay = optionalNumber(delay, 0, 'multi_direct', 'delay')
        if M.MultiGuide.players == nil or table.size(M.MultiGuide.players) == 0 then
            local player = M.GetPlayer() or Player
            if not validEntity(player) then
                M.LogOnce('Drawers', 'multi_direct_missing_player', '多人指路跳过：未找到当前玩家实体')
                return false
            end
            M.MultiGuide.players = {
                [M.SelfPos] = {
                    obj = player,
                    color = M.Config.Main.GuideColor
                }
            }
        end
        local hasDrawn = false
        for job, multiData in pairs(M.MultiGuide.players) do
            local pos = data[job]
            if type(pos) == "table" and validDirectTarget(pos.x, pos.z, time, 'multi_direct_' .. tostring(job)) then
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
                if type(curPlayer) == "number" then
                    curPlayer = TensorCore.mGetEntity(curPlayer)
                end
                local color = multiData.color
                if validEntity(curPlayer) and type(color) == "table" then
                    commonDirect(pos.x, pos.z, curPlayer, color, time, size, M.NotDelayGuidesMulti[job], delay)
                    hasDrawn = true
                else
                    M.LogOnce('Drawers', 'multi_direct_missing_entity_' .. tostring(job),
                            '多人指路跳过：队员实体或颜色不可用', { job = job })
                end
            end
        end
        return hasDrawn
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
                nil,
                true,
                true,
                0,
                false
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
                nil,
                true,
                true,
                0,
                false
        )
        local newDraw2 = Argus2.ShapeDrawer:new(
                (GUI:ColorConvertFloat4ToU32(1, 0, 1, 1)),
                (GUI:ColorConvertFloat4ToU32(1, 0, 1, 1)),
                (GUI:ColorConvertFloat4ToU32(1, 0, 1, 1)),
                nil,
                1
        )

        local id3 = newDraw2:addTimedCircleOnEnt(time, id, 0.03, 0, true, true)
        table.insert(drawIds, id1)
        table.insert(drawIds, id2)
        table.insert(drawIds, id3)
        return drawIds
    end

    local commonFrameDirect = function(x, z, playerPos, color, size, mapId)
        local drawY
        if mapId == nil then mapId = Player.localmapid end
        if table.contains(ZeroYMap, mapId) then
            drawY = 0
        else
            drawY = M.GlobalGuideY or playerPos.y
        end
        size = size or 0.5
        -- 普通颜色表的样式可复用；位置和几何仍每次更新，元表保持原读取行为。
        local cacheable = type(color) == 'table' and getmetatable(color) == nil
        local newDraw, newDraw2
        if cacheable then
            local style = cacheable and frameDirectStyles[color] or nil
            local main = M.Config.Main
            if style == nil or style.r ~= color.r or style.g ~= color.g or style.b ~= color.b or style.a ~= color.a
                    or style.kind ~= main.DrawerType or style.mix ~= main.DrawerMix or style.factory ~= TensorCore.getCachedDrawer then
                local drawer1Color = GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)
                local drawer2Color = GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)
                style = { r = color.r, g = color.g, b = color.b, a = color.a, kind = main.DrawerType, mix = main.DrawerMix,
                    factory = TensorCore.getCachedDrawer,
                    first = TensorCore.getCachedDrawer(drawer1Color, drawer1Color, drawer1Color, w_1, 2),
                    second = TensorCore.getCachedDrawer(drawer2Color, drawer2Color, drawer2Color, drawer2Color, 2) }
                if cacheable then frameDirectStyles[color] = style end
            end
            newDraw, newDraw2 = style.first, style.second
        else
            local drawer1Color = GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a)
            local drawer2Color = GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)
            newDraw = TensorCore.getCachedDrawer(drawer1Color, drawer1Color, drawer1Color, w_1, 2)
            newDraw2 = TensorCore.getCachedDrawer(drawer2Color, drawer2Color, drawer2Color, drawer2Color, 2)
        end
        -- 直接传入坐标，避免为距离、朝向分别创建位置表或整理原生批次数组。
        local px, pz = playerPos.x, playerPos.z
        local distance = TensorCore.getDistance2d2(px, 0, pz, x, 0, z)
        local heading = TensorCore.getHeadingToTarget2(px, 0, pz, x, 0, z)
        newDraw:addCircle(x, drawY, z, size, true)
        newDraw2:addRect(px, drawY, pz, distance, 0.05, heading, true)
        frameDirectCenterDrawer:addCircle(x, drawY, z, 0.03, true)
    end

    local getLiveEntityPos = function(entityId, caller, positions)
        if entityId == nil then
            M.LogOnce('Drawers', caller .. '_missing_id', '绘图跳过：实体ID不存在')
            return nil
        end
        if positions and positions[entityId] then return positions[entityId] end
        local entity = TensorCore.mGetEntity(entityId)
        local position = entity and entity.pos
        if position == nil then
            M.LogOnce('Drawers', caller .. '_missing_entity_' .. tostring(entityId),
                    '绘图跳过：当前帧实体不可用', { id = entityId })
            return nil
        end
        if positions then positions[entityId] = position end
        return position
    end

    local getMultiGuideEntityId = function(multiData, caller)
        if type(multiData) ~= 'table' then
            M.LogOnce('Drawers', caller .. '_invalid_data', '多人指路跳过：玩家数据不是表', {
                dataType = type(multiData),
            })
            return nil
        end
        local entity = multiData.obj
        if type(entity) == 'number' then
            return entity
        end
        local entityType = type(entity)
        if (entityType == 'table' or entityType == 'userdata') and entity.id ~= nil then
            return entity.id
        end
        M.LogOnce('Drawers', caller .. '_invalid_entity', '多人指路跳过：玩家实体引用无效', {
            entityType = entityType,
        })
        return nil
    end

    --- 帧指路OnFrame用
    --- @param x number 指路位置x
    --- @param z number 指路位置z
    --- @param size number 圆圈大小
    M.FrameDirect = function(x, z, size, color)
        if not validDirectTarget(x, z, 0, 'frame_direct') then
            return false
        end
        local curPlayer = M.GetPlayer() or Player
        if curPlayer == nil then
            M.LogOnce('Drawers', 'frame_direct_missing_player', '帧指路跳过：未找到当前玩家')
            return false
        end
        local playerPos = getLiveEntityPos(curPlayer.id, 'frame_direct')
        if playerPos == nil then
            return false
        end
        local curColor = color or M.Config.Main.GuideColor
        commonFrameDirect(x, z, playerPos, curColor, size, curPlayer.localmapid)
        return true
    end

    --- 帧指路OnFrame用
    --- @param data table 数据表 key job, value 位置
    --- @param size number 圆圈大小
    M.FrameMultiD = function(data, size)
        if type(data) ~= 'table' then
            M.LogOnce('Drawers', 'frame_multi_invalid_input',
                    '多人帧指路跳过：职能坐标数据不是表', { dataType = type(data) })
            return false
        end
        local hasDrawn = false
        local selfDrawn = false
        local positions = {}
        local curPlayer = M.GetPlayer() or Player
        local curPlayerId = curPlayer ~= nil and curPlayer.id or nil
        local multiPlayers = M.MultiGuide.players or {}
        for job, multiData in pairs(multiPlayers) do
            local caller = 'frame_multi_' .. tostring(job)
            local entityId = getMultiGuideEntityId(multiData, caller)
            local isCurrentPlayer = curPlayerId ~= nil and entityId == curPlayerId
            local pos = isCurrentPlayer and data[M.SelfPos] or data[job]
            if pos ~= nil and not (job == M.SelfPos and curPlayerId ~= nil and not isCurrentPlayer) then
                local validPos = validDirectTarget(type(pos) == 'table' and pos.x or nil,
                        type(pos) == 'table' and pos.z or nil, 0, caller)
                local playerPos = validPos and entityId ~= nil and getLiveEntityPos(entityId, caller, positions) or nil
                if playerPos ~= nil then
                    commonFrameDirect(pos.x, pos.z, playerPos, multiData.color, size,
                            curPlayer ~= nil and curPlayer.localmapid or nil)
                    hasDrawn = true
                    selfDrawn = selfDrawn or isCurrentPlayer
                end
            end
        end
        if not selfDrawn and data[M.SelfPos] ~= nil then
            local pos = data[M.SelfPos]
            local fallbackDrawn = M.FrameDirect(type(pos) == 'table' and pos.x or nil,
                    type(pos) == 'table' and pos.z or nil, size)
            if fallbackDrawn then
                local fallbackReason = multiPlayers[M.SelfPos] == nil and 'missing' or 'stale'
                M.LogOnce('Drawers', 'frame_multi_self_fallback_' .. fallbackReason,
                        '多人指路名单未包含有效的本人映射，已使用本人指路', {
                            reason = fallbackReason,
                            selfPos = M.SelfPos,
                        }, true)
            end
            hasDrawn = fallbackDrawn or hasDrawn
        end
        return hasDrawn
    end

    --- 计算点 P 到线段 AB 的最近投影点
    ---@param A table 线段起点坐标 {x, z} 人
    ---@param B table 线段终点坐标 {x, z} 物体
    ---@param P table 待测点坐标 {x, z}  接线人坐标
    ---@return boolean isOnSegment 投影垂足是否落在线段 AB 上
    ---@return number x 线段上距离 P 最近的点坐标
    ---@return number z
    ---@return boolean 如果在延长线上，近端是否为A
    local getLinePos = function(A, B, P)
        -- 向量 AB、向量 AP
        local ABx, ABz = B.x - A.x, B.z - A.z
        local APx, APz = P.x - A.x, P.z - A.z

        -- 线段 AB 长度平方，避免开方提升计算效率
        local abLenSq = ABx * ABx + ABz * ABz
        -- 起止点重合，直接返回 A 点
        if abLenSq == 0 then
            return false, A.x, A.z
        end

        -- 投影系数 t：0 对应 A 点，1 对应 B 点
        local t = (APx * ABx + APz * ABz) / abLenSq
        -- 判断垂足是否在线段区间内
        local isOnSegment = t >= 0 and t <= 1

        if t < 0 then
            -- 投影在 A 侧延长线，取端点 A
            return isOnSegment, A.x, A.z, true
        elseif t > 1 then
            -- 投影在 B 侧延长线，取端点 B
            return isOnSegment, B.x, B.z, false
        else
            -- 投影在线段内部，计算垂足坐标
            return isOnSegment, A.x + ABx * t, A.z + ABz * t
        end
    end

    --- 帧指路接线
    --- @param pos1 table 线第1端位置(物)
    --- @param pos2 table 线第2端位置(人)
    --- @param playerPos table 玩家位置
    --- @param size number 线粗(可缺省)
    M.FrameTakeLine = function(pos1, pos2, playerPos, size)
        size = size or 5
        if singleTakeLineDrawer == nil then
            singleTakeLineDrawer = Argus2.ShapeDrawer:new(
                (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0)),
                (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0)),
                (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0)),
                (GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)),
                3
            )
        end
        local drawer = singleTakeLineDrawer
        drawer:addLine(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, size, 0)
        local isInLine, x, z = getLinePos(pos2, pos1, playerPos)
        if isInLine then
            M.FrameDirect(x, z)
        else
            local heading = TensorCore.getHeadingToTarget2(pos2.x, 0, pos2.z, pos1.x, 0, pos1.z)
            local gx, _, gz = TensorCore.getPosInDirection(pos2, heading, 1, true)
            M.FrameDirect(gx, gz)
        end
    end
    local takeLineGuide = function(data, playerPos)
        local a, b = data.posPlayer, data.posObj
        local isInLine, x, z, isClosePlayer = getLinePos(a, b, playerPos)
        local disPlayer = data.disPlayer or 2
        local disObj = data.disObj or 2
        if isInLine then
            -- nearestPos 进行修正
            if TensorCore.getDistance2d2(x, 0, z, b.x, 0, b.z) < disObj then
                --可能处在危险区
                local dir = TensorCore.getHeadingToTarget2(b.x, 0, b.z, a.x, 0, a.z)
                local gx, _, gz = TensorCore.getPosInDirection(b, dir, disObj, true)
                return gx, gz
            end
            return x, z
        else
            local length = TensorCore.getDistance2d2(a.x, 0, a.z, b.x, 0, b.z)
            local distance = isClosePlayer and disPlayer or disObj
            if length < distance then return (a.x + b.x) / 2, (a.z + b.z) / 2 end
            local start, target = isClosePlayer and a or b, isClosePlayer and b or a
            local heading = TensorCore.getHeadingToTarget2(start.x, 0, start.z, target.x, 0, target.z)
            local gx, _, gz = TensorCore.getPosInDirection(start, heading, distance, true)
            return gx, gz
        end
    end

    local drawTakeLineItem = function(job, i, data, playerPos, guideColor, size)
        local color = data.color or defaultTakeLineColor
        local playerDrawers = multiTakeLineDrawers[job]
        if playerDrawers == nil then playerDrawers = {}; multiTakeLineDrawers[job] = playerDrawers end
        local cached = playerDrawers[i]
        if cached == nil or cached.r ~= color.r or cached.g ~= color.g or cached.b ~= color.b then
            cached = { r = color.r, g = color.g, b = color.b, drawer = Argus2.ShapeDrawer:new(
                (GUI:ColorConvertFloat4ToU32(0, 0, 0, 0)),
                (GUI:ColorConvertFloat4ToU32(0, 0, 0, 0)),
                (GUI:ColorConvertFloat4ToU32(0, 0, 0, 0)),
                (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 1)), 3) }
            playerDrawers[i] = cached
        end
        local drawer = cached.drawer
        drawer:addLine(data.posPlayer.x, data.posPlayer.y, data.posPlayer.z, data.posObj.x, data.posObj.y, data.posObj.z, 4, 0)
        local x, z = takeLineGuide(data, playerPos)
        commonFrameDirect(x, z, playerPos, guideColor, size)
    end

    --- 多重指路拉线；本次调用复用成功解析的位置，数值接口直接返回引导点。
    M.MultiTakeLine = function(guideData, size)
        local positions = {}
        for job, multiData in pairs(M.MultiGuide.players) do
            local curJobData = guideData[job]
            local caller = 'multi_take_line_' .. tostring(job)
            local entityId = getMultiGuideEntityId(multiData, caller)
            local playerPos = entityId ~= nil and getLiveEntityPos(entityId, caller, positions) or nil
            if playerPos ~= nil and curJobData ~= nil and table.size(curJobData) > 0 then
                for i = 1, #curJobData do
                    drawTakeLineItem(job, i, curJobData[i], playerPos, multiData.color, size)
                end
            end
        end
    end
    M.DrawTargetPos = function()
        if not M.Config.Main.ShowTargetPos then
            return
        end
        local player = TensorCore.mGetPlayer()
        local targetId = player and player.targetid
        if not targetId or targetId == 0 then return end
        if not M.Config.Main.ShowTargetPosTank and M.IsTank(player.job) then return end
        local target = getDotTarget(targetId)
        if target == nil or not target.attackable then
            return
        end
        local pos = target.pos
        if not pos then return end
        local x, y, z = pos.x, pos.y, pos.z
        if not x or not y or not z then return end
        local color = M.Config.Main.TargetPosColor
        -- 只复用样式；改色立即重建，当前位置和尺寸仍逐帧提交。
        if targetPosDrawer == nil or targetPosR ~= color.r or targetPosG ~= color.g
                or targetPosB ~= color.b or targetPosA ~= color.a then
            targetPosDrawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, color.a), 1)
            targetPosR, targetPosG, targetPosB, targetPosA = color.r, color.g, color.b, color.a
        end
        targetPosDrawer:addCircle(x, y, z, 0.01 * M.Config.Main.TargetPosSize, true)
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
                M.InfoNoLog("附近没有任何玩家！")
            end
        else
            M.InfoNoLog("附近没有任何玩家！")
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

    M.drawerY = 0.05
    --- 通用创建 Drawer 函数
    ---@return ShapeDrawer
    M.CreateDrawer = function(r, g, b, a, lineSize, gradient)
        local color = GUI:ColorConvertFloat4ToU32(r, g, b, a or 0.3)
        -- 缺省值，如果未指定则设置为3
        gradient = gradient or 3
        local lineColor = GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)
        if lineSize == nil then
            lineSize = 1
        elseif lineSize == 0 then
            lineColor = GUI:ColorConvertFloat4ToU32(1, 1, 1, 0)
            lineSize = 1
        end
        local drawer = Argus2.ShapeDrawer:new(color, color, color, lineColor, lineSize)
        if gradient > 0 then
            drawer:setRenderFlags(M.Config.Main.DrawerType)
            drawer:setGradient(gradient, 0.15, 2)
        end
        return drawer
    end

    -- 每个持续绘图调用点独占一个缓存，不与定时图形或其他调用点共享。
    -- 样式变化时只替换对应的 drawer；模块重新初始化时清空自己的缓存。
    M.GetFrameDrawer = function(cache, key, r, g, b, a, lineSize, gradient)
        local flags = M.Config.Main.DrawerType
        local cached = cache[key]
        if cached == nil or cached.r ~= r or cached.g ~= g or cached.b ~= b
                or cached.a ~= a or cached.lineSize ~= lineSize
                or cached.gradient ~= gradient or cached.flags ~= flags then
            cached = { r = r, g = g, b = b, a = a, lineSize = lineSize,
                       gradient = gradient, flags = flags,
                       drawer = M.CreateDrawer(r, g, b, a, lineSize, gradient) }
            cache[key] = cached
        end
        return cached.drawer
    end
    
    -- 更改全局参数
    M.ChangeDrawer = function(changeType, changeValue)
        
    end
    
    M.loadMix = function()
        
    end
    
    --- 绘制一个圆（已废弃仿报错用）
    M.DrawCircleUI = function()
    end

    --- 绘制一个地面圆（已废弃仿报错用）
    M.DrawCircleFloor = function()
    end
end

return Drawers
