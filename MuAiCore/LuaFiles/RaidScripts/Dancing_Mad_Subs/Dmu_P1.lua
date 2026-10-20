local Dmu_P1 = {}
Dmu_P1.StateName = "P1"

---@type DancingMad
local DM

---@type MuAiGuide
local MG

local Cfg = function()
    return MG.Config.DmuCfg.P1
end

local Data = function()
    if MG.DancingMad == nil then
        return nil
    end
    return MG.DancingMad.P1
end
local mtGroup = { 'MT', 'H1', 'D1', 'D3' }
local thGroup = { 'MT', 'ST', 'H1', 'H2' }
local dpsGroup = { 'D1', 'D2', 'D3', 'D4' }
local trGroup = { 'MT', 'ST', 'D3', 'D4' }
-- 八人 C-A：第二轮面向 Boss 整体转半圈，不继承旧分组方案的散点。
local caRockPositions = {
    MT = { x = 90, z = 103 }, ST = { x = 110, z = 103 },
    H1 = { x = 88, z = 114 }, H2 = { x = 112, z = 114 },
    D1 = { x = 90, z = 103 }, D2 = { x = 110, z = 103 },
    D3 = { x = 88, z = 114 }, D4 = { x = 112, z = 114 },
}
local ArrowBuffs = {
    [4876] = 'up',
    [4877] = 'down',
    [4878] = 'right',
    [4879] = 'left',
    [5079] = 'up',
    [5080] = 'down',
    [5081] = 'right',
    [5082] = 'left',
}

local TeleTrouncingPos = {
    ['up_up'] = { { x = 112, z = 100 }, { x = 112, z = 106 } },
    ['left_left'] = { { x = 100, z = 88 }, { x = 106, z = 88 } },
    ['down_down'] = { { x = 88, z = 100 }, { x = 88, z = 94 } },
    ['right_right'] = { { x = 100, z = 112 }, { x = 94, z = 112 } },
    ['right_up'] = { up = { x = 112, z = 112 }, right = { x = 106, z = 112 } },
    ['up_left'] = { left = { x = 112, z = 88 }, up = { x = 112, z = 94 } },
    ['left_down'] = { down = { x = 88, z = 88 }, left = { x = 94, z = 88 } },
    ['down_right'] = { right = { x = 88, z = 112 }, down = { x = 88, z = 106 } },
}

local TeleTrouncingPos2 = {
    ['up_up'] = { { x = 112, z = 99 }, { x = 112, z = 106 } },
    ['left_left'] = { { x = 99, z = 88 }, { x = 106, z = 88 } },
    ['down_down'] = { { x = 88, z = 99 }, { x = 88, z = 94 } },
    ['right_right'] = { { x = 99, z = 112 }, { x = 94, z = 112 } },
    ['right_up'] = { up = { x = 112, z = 112 }, right = { x = 106, z = 112 } },
    ['up_left'] = { left = { x = 112, z = 88 }, up = { x = 112, z = 94 } },
    ['left_down'] = { down = { x = 88, z = 88 }, left = { x = 94, z = 88 } },
    ['down_right'] = { right = { x = 88, z = 112 }, down = { x = 88, z = 106 } },
}

local dis24 = {
    MT = { x = 94, y = 0, z = 100.5 },
    ST = { x = 99.5, y = 0, z = 106 },
    H1 = { x = 84, y = 0, z = 100.5 },
    H2 = { x = 99.5, y = 0, z = 116 },
    D1 = { x = 106, y = 0, z = 99.5 },
    D2 = { x = 100.5, y = 0, z = 94 },
    D3 = { x = 116, y = 0, z = 99.5 },
    D4 = { x = 100.5, y = 0, z = 84 },
}

local dis13 = {
    MT = { x = 99.5, y = 0, z = 94 },
    ST = { x = 94, y = 0, z = 99.5 },
    H1 = { x = 99.5, y = 0, z = 84 },
    H2 = { x = 84, y = 0, z = 99.5 },
    D1 = { x = 100.5, y = 0, z = 106 },
    D2 = { x = 106, y = 0, z = 100.5 },
    D3 = { x = 100.5, y = 0, z = 116 },
    D4 = { x = 116, y = 0, z = 100.5 },
}

-- 在击退线仍完整时保存分组，线消失后不能把击退组重新判成闲人。
local cacheFire1KnockbackGroup = function(dataTable)
    if dataTable.knockbackTh ~= nil or dataTable.linkGuideFinish then
        return
    end
    local counts, seen = { 0, 0 }, {}
    for index, group in ipairs({ thGroup, dpsGroup }) do
        for _, job in ipairs(group) do
            local member = MG.Party[job]
            if member == nil or member.id == nil or member.id == 0 or seen[member.id] then
                return
            end
            seen[member.id] = true
            if MG.HasLine(member.id, 45) then
                counts[index] = counts[index] + 1
            end
        end
    end
    if counts[1] == 4 and counts[2] == 0 then
        dataTable.knockbackTh = true
    elseif counts[1] == 0 and counts[2] == 4 then
        dataTable.knockbackTh = false
    end
end

local setFire1IdleNorth = function(dataTable)
    local guide = dataTable.GuideData
    if guide.MT == nil then
        return
    end
    -- 以场地北为上。必要时整体转半圈，保留近战内侧、远程外侧的散开关系。
    if (guide.MT.z < 100) == dataTable.knockbackTh then
        local rotated = {}
        for job, pos in pairs(guide) do
            rotated[job] = { x = 200 - pos.x, y = pos.y, z = 200 - pos.z }
        end
        dataTable.GuideData = rotated
    end
end

--- 绘制击退
local drawBuffKick = function()
    if not Cfg().draw then
        return
    end
    local buffPlayer = {}
    local buffPlayerId = {}
    local needDo = false
    for _, member in pairs(MG.Party) do
        local buff = TensorCore.getBuff(member.id, 5078)
        if buff and buff.duration < 4 then
            local curMember = TensorCore.mGetEntity(member.id)
            table.insert(buffPlayer, curMember)
            table.insert(buffPlayerId, curMember.id)
            needDo = true
        end
    end
    if needDo then
        local player = TensorCore.mGetPlayer()
        for _, curMember in pairs(buffPlayer) do
            DM.cyanDrawer:addCircle(curMember.pos.x, MG.drawerY, curMember.pos.z, 6)
            if not table.contains(buffPlayerId, player.id) then
                local distance = TensorCore.getDistance2d(curMember.pos, player.pos)
                if distance < 6 then
                    local kickDis = 15
                    local heading = TensorCore.getHeadingToTarget(curMember.pos, player.pos)
                    DM.greenDrawer:addArrow(player.pos.x, MG.drawerY, player.pos.z, heading, kickDis - 0.4, 0.2, 0.4, 0.2, true)
                end
            end
        end
    end
end

--- 检查扇形死刑
local CheckConeDeath = function()
    if Data().Death.InState and Data().Death.Timer > 0 then
        if TimeSince(Data().Death.Timer) < 9000 then
            if TimeSince(Data().Death.Timer) < 6000 then
                if Cfg().draw then
                    if Data().Death.MT == nil then
                        Data().Death.MT = TensorCore.getEntityByGroup("Main Tank", "Nearest")
                    else
                        local curMt = TensorCore.mGetEntity(Data().Death.MT.id)
                        local curBoss = MG.GetCurRaidBoss()
                        if curMt ~= nil and curMt.pos ~= nil and curBoss ~= nil then
                            local dir = TensorCore.getHeadingToTarget(curBoss.pos, curMt.pos)
                            DM.redDrawer:addCone(curBoss.pos.x, MG.drawerY, curBoss.pos.z, 30, math.pi * 2 / 3, dir)
                        end
                    end
                end
            else
                if Cfg().draw then
                    if Data().Death.ST == nil then
                        local curMt = TensorCore.getEntityByGroup("Main Tank", "Nearest")
                        if curMt ~= nil then
                            for job, member in pairs(MG.Party) do
                                if (job == 'MT' or job == 'ST') and member.id ~= curMt.id then
                                    Data().Death.ST = member
                                    break
                                end
                            end
                        end
                    else
                        local cur = TensorCore.mGetEntity(Data().Death.ST.id)
                        local curBoss = MG.GetCurRaidBoss()
                        if cur ~= nil and cur.pos ~= nil and curBoss ~= nil then
                            local dir = TensorCore.getHeadingToTarget(curBoss.pos, cur.pos)
                            DM.redDrawer:addCone(curBoss.pos.x, MG.drawerY, curBoss.pos.z, 30, math.pi * 2 / 3, dir)
                        end
                    end
                end
            end
        else
            Data().Death.InState = false
            Data().Death.MT = nil
            Data().Death.ST = nil
            Data().Death.Timer = 0
            if DM.InState('P1Line2_2') then
                DM.ChangeState('P1DeathBfLine3')
            end
        end
    end
end

--- 缓存自动背对 data by string
local autoLookAtCache = function(entityID, a1, a2, a3)
    if not Cfg().autoLookAt then
        return
    end
    local obj = TensorCore.mGetEntity(entityID)
    local enabled = (a1 == 64 and a2 == 128) or (a2 == 64 and a3 == 128)
    local cid = obj.contentid or obj.contentID
    if cid ~= 2015166 and cid ~= 2015167 or not enabled then
        return
    end
    Data().AutoLookAt.boss = obj
    Data().AutoLookAt.Timer = Now()
end

--- 画半场刀 data by string
local halfGroupAOE = function(entityID, a1, a2, a3)
    if not ((a1 == 64 and a2 == 128) or (a2 == 64 and a3 == 128)) then
        return
    end
    local obj = TensorCore.mGetEntity(entityID)
    local x, heading
    if obj.contentid == 2015164 then
        x = 90
        heading = -math.pi / 2
        Data().Half.offSetX = 0.5
        Data().Half.Timer = Now()
    elseif obj.contentid == 2015165 then
        x = 110
        heading = math.pi / 2
        Data().Half.offSetX = -0.5
        Data().Half.Timer = Now()
    else
        return
    end
    if Cfg().draw then
        DM.purpleDrawer:addTimedCenteredRect(5150, x, MG.drawerY, 100, 20, 42, heading)
    end
end

--- 紫圈爆炸
local shitBoom = function(entityID, a1, a2, a3)
    if not (a1 == 4 and a2 == 8 and a3 == 0) then
        return
    end
    local boomObj
    if Cfg().blackMudType == 2 then
        -- 结算时物体可能已从实体表消失，按本轮已确认的 runtime ID 识别。
        for _, ent in ipairs(Data().Line3.Shits or {}) do
            if ent.id == entityID then boomObj = ent; break end
        end
    else
        boomObj = TensorCore.mGetEntity(entityID)
        if boomObj ~= nil and boomObj.contentid ~= 2015266 then return end
    end
    if boomObj == nil then return end
    if Cfg().blackMudType == 2 then
        for _, previous in ipairs(Data().Shit.Boomed) do
            if previous.id == boomObj.id then return end
        end
    end
    table.insert(Data().Shit.Boomed, boomObj)
end

--- 自动背对 执行/取消
local autoLookAtUpdate = function()
    if not Cfg().autoLookAt or Data().AutoLookAt.Timer == 0 then
        return
    end
    if TimeSince(Data().AutoLookAt.Timer) < 11000 then
        if TimeSince(Data().AutoLookAt.Timer) > 8000
                and not Data().AutoLookAt.enable
        then
            local player = TensorCore.mGetPlayer()
            local boss = Data().AutoLookAt.boss
            local heading = TensorCore.getHeadingToTarget(player.pos, boss.pos)
            if boss.contentid == 2015166 then
                heading = heading + math.pi;
            end
            Data().AutoLookAt.enable = true
            TensorCore.API.TensorACR.setLockFaceHeading(heading)
            if Cfg().hardLock then
                TensorCore.API.TensorACR.setHardLockFace(true)
            end
            TensorCore.API.TensorACR.toggleLockFace(true)
            MG.Info('P1锁定面向开始，面向：' .. string.format("%.2f", heading))
        end
    else
        Data().AutoLookAt.Timer = 0
        Data().AutoLookAt.enable = false
        if Cfg().hardLock then
            TensorCore.API.TensorACR.setHardLockFace(false)
        end
        TensorCore.API.TensorACR.toggleLockFace(false)
        MG.Info('P1锁定面向结束。')
    end
end

-- 2、3次被连线画图和指路
local guideAndDrawL2L3 = function(lineData, north)
    if Cfg().draw then
        for _, id in pairs(lineData.DisPlayers) do
            local player = TensorCore.mGetEntity(id)
            MG.CreateDrawer(1, 0.5, 0, 0.3, 2):addCircle(player.pos.x, MG.drawerY, player.pos.z, 5)
        end
    end
    if Cfg().guide then
        if lineData.Guide2 == nil then
            lineData.Guide2 = {}
            if Cfg().blackMudType == 2 then
                for job, member in pairs(MG.Party) do
                    if table.contains(lineData.DisPlayers, member.id) then
                        local pos = caRockPositions[job]
                        -- 第二轮从 A 面向 Boss，左右与第一轮一起旋转半圈。
                        lineData.Guide2[job] = { x = north and 200 - pos.x or pos.x, y = 0,
                            z = north and 200 - pos.z or pos.z }
                    else
                        lineData.Guide2[job] = { x = 100, y = 0, z = 100 }
                    end
                end
            elseif Cfg().Line2Type == 1 then
                for job, member in pairs(MG.Party) do
                    if table.contains(lineData.DisPlayers, member.id) then
                        if job == 'MT' or job == 'D1' then
                            lineData.Guide2[job] = { x = 108, y = 0, z = 95 }
                        elseif job == 'ST' or job == 'D2' then
                            lineData.Guide2[job] = { x = 92, y = 0, z = 105 }
                        elseif job == 'H1' or job == 'D3' then
                            lineData.Guide2[job] = { x = 88, y = 0, z = 94 }
                        elseif job == 'H2' or job == 'D4' then
                            lineData.Guide2[job] = { x = 112, y = 0, z = 106 }
                        end
                    else
                        lineData.Guide2[job] = { x = 100, y = 0, z = 100 }
                    end
                end
            else
                for job, member in pairs(MG.Party) do
                    if table.contains(lineData.DisPlayers, member.id) then
                        if job == 'MT' or job == 'D3' then
                            lineData.Guide2[job] = { x = 109, y = 0, z = 97 }
                        elseif job == 'ST' or job == 'D4' then
                            lineData.Guide2[job] = { x = 91, y = 0, z = 97 }
                        elseif job == 'H1' or job == 'D1' then
                            lineData.Guide2[job] = { x = 91, y = 0, z = 103 }
                        elseif job == 'H2' or job == 'D2' then
                            lineData.Guide2[job] = { x = 109, y = 0, z = 103 }
                        end
                    else
                        lineData.Guide2[job] = { x = 100, y = 0, z = 100 }
                    end
                end
            end
        else
            MG.FrameMultiD(lineData.Guide2)
        end
    end
end

--- buff传递
local turnBuff = function(dataTable, stateChangeFunc, guideOverride)
    if stateChangeFunc() then
        DM.ChangeState(dataTable.NextState)
    else
        if dataTable.BuffJobs == nil then
            local buffJob = {}
            for job, member in pairs(MG.Party) do
                if TensorCore.hasBuff(member.id, 5078) then
                    table.insert(buffJob, job)
                end
            end
            if table.size(buffJob) >= 2 then
                dataTable.BuffJobs = buffJob
                if table.contains(buffJob, MG.SelfPos) then
                    dataTable.SelfGroupTurner = MG.SelfPos
                else
                    for _, job in pairs(buffJob) do
                        if (table.contains(thGroup, job) and table.contains(thGroup, MG.SelfPos))
                                or (not table.contains(thGroup, job) and not table.contains(thGroup, MG.SelfPos))
                        then
                            dataTable.SelfGroupTurner = job
                            break
                        end
                    end
                end
            end
        else
            if Cfg().guide then
                if guideOverride ~= nil then
                    guideOverride(dataTable)
                    return
                end
                local guideData = {}
                local dpsJob, thJob
                -- 填入
                for _, job in pairs(dataTable.BuffJobs) do
                    if table.contains(thGroup, job) then
                        thJob = job
                        guideData[job] = dataTable.thGroupGuidePos
                    else
                        dpsJob = job
                        guideData[job] = dataTable.dpsGroupGuidePos
                    end
                end

                local dpsObj = TensorCore.mGetEntity(MG.Party[dpsJob].id)
                local thObj = TensorCore.mGetEntity(MG.Party[thJob].id)
                local disDps = TensorCore.getDistance2d(dpsObj.pos, guideData[dpsJob])
                local disTh = TensorCore.getDistance2d(thObj.pos, guideData[thJob])
                for job, _ in pairs(MG.Party) do
                    if table.contains(thGroup, job) then
                        if job ~= thJob then
                            if disTh < 2 then
                                guideData[job] = MG.VectorXZAdd(thObj.pos, dataTable.offSetTh)
                            else
                                guideData[job] = MG.VectorXZAdd(guideData[thJob], dataTable.offSetTh)
                            end
                        end
                    else
                        if job ~= dpsJob then
                            if disDps < 2 then
                                guideData[job] = MG.VectorXZAdd(dpsObj.pos, dataTable.offSetDps)
                            else
                                guideData[job] = MG.VectorXZAdd(guideData[dpsJob], dataTable.offSetDps)
                            end
                        end
                    end
                end
                MG.FrameMultiD(guideData)
            end
        end
    end
end

-- 两边各四层黑泥必须有共同覆盖区。只使用已采集的真实八个物体，缺失时等待。
local getCaPuddles = function()
    local cached = Data().Shit.caPuddles
    if cached ~= nil and cached.centers ~= nil and cached.innerEdges ~= nil then return cached end
    local shits = Data().Line3.Shits
    if shits == nil or #shits ~= 8 then return nil end
    local groups, seen = { north = {}, south = {} }, {}
    for _, ent in ipairs(shits) do
        local pos = ent.pos
        if ent.id == nil or seen[ent.id] or pos == nil
                or type(pos.x) ~= 'number' or type(pos.z) ~= 'number'
                or pos.x ~= pos.x or pos.z ~= pos.z
                or pos.x < 80 or pos.x > 120 or pos.z <= 80 or pos.z >= 120
                or pos.z == 100 then
            return nil
        end
        seen[ent.id] = true
        table.insert(pos.z < 100 and groups.north or groups.south, pos)
    end
    local result = { centers = {}, innerEdges = {} }
    for side, positions in pairs(groups) do
        if #positions ~= 4 then return nil end
        local center = { x = 0, y = 0, z = 0 }
        local innerEdge = positions[1].z
        for _, pos in ipairs(positions) do
            center.x, center.z = center.x + pos.x / 4, center.z + pos.z / 4
            innerEdge = side == 'north' and math.max(innerEdge, pos.z) or math.min(innerEdge, pos.z)
        end
        -- 目标在四层共同覆盖区的内侧，放击退的人也跟入同一目标。
        local target = { x = center.x, y = 0, z = center.z + (side == 'north' and 2 or -2) }
        for _, pos in ipairs(positions) do
            local dx, dz = target.x - pos.x, target.z - pos.z
            if dx * dx + dz * dz >= 16 then return nil end
        end
        result[side] = target
        result.centers[side], result.innerEdges[side] = center, innerEdge
    end
    Data().Shit.caPuddles = result
    return result
end

-- 在击退前按真实传毒源与 6 米范围锁定四人组；不能在击退后按职业或当前位置重新分组。
local captureCaTrapGroups = function(dataTable)
    if dataTable.BuffJobs == nil or #dataTable.BuffJobs ~= 2 then return nil end
    local groups, entities, seen = {}, {}, {}
    for job, member in pairs(MG.Party) do
        local ent = TensorCore.mGetEntity(member.id)
        if ent == nil or ent.pos == nil or type(ent.pos.x) ~= 'number' or type(ent.pos.z) ~= 'number'
                or ent.pos.x ~= ent.pos.x or ent.pos.z ~= ent.pos.z or seen[member.id] then return nil end
        entities[job], seen[member.id] = ent, true
    end
    for _, owner in ipairs(dataTable.BuffJobs) do
        local ent = entities[owner]
        if ent == nil or math.abs(ent.pos.z - 100) < 0.5 then return nil end
        local side = ent.pos.z < 100 and 'north' or 'south'
        if groups[side] ~= nil then return nil end
        groups[side] = { owner = owner, members = {}, source = { x = ent.pos.x, y = 0, z = ent.pos.z } }
    end
    if groups.north == nil or groups.south == nil then return nil end
    for job, ent in pairs(entities) do
        local north = TensorCore.getDistance2d(ent.pos, groups.north.source) < 6
        local south = TensorCore.getDistance2d(ent.pos, groups.south.source) < 6
        if north == south then return nil end
        table.insert((north and groups.north or groups.south).members, job)
    end
    if #groups.north.members ~= 4 or #groups.south.members ~= 4 then return nil end
    return groups
end

local guideCaSoak = function()
    local turn = Data().Turn2
    local groups, puddles = turn.caGroups, getCaPuddles()
    if groups == nil or puddles == nil then
        MG.LogOnce('P1Ca', 'soak_groups_incomplete', '击退前四人组未确认，暂不生成踩泥指路')
        return
    end
    local guide = {}
    for side, group in pairs(groups) do
        if not group.landed then
            local landed = 0
            for _, job in ipairs(group.members) do
                if job ~= group.owner then
                    local live = TensorCore.mGetEntity(MG.Party[job].id)
                    if live ~= nil and live.pos ~= nil
                            and ((side == 'north' and live.pos.z > 100) or (side == 'south' and live.pos.z < 100)) then
                        landed = landed + 1
                    end
                end
            end
            -- 原击退源不参与此判断；只观察本组三名受击退者是否已过中线。
            group.landed = landed == 3
        end
        if group.landed then
            local target = side == 'north' and puddles.south or puddles.north
            for _, job in ipairs(group.members) do
                -- 三名受击退者去对面，免疫击退的原源留在原侧，接对面来的三人。
                guide[job] = job == group.owner and puddles[side] or target
            end
        else
            -- 47783 结算和实际击退之间有延迟。源原地等候，受击退者不画返回起点的箭头。
            guide[group.owner] = group.source
        end
    end
    if next(guide) ~= nil then MG.FrameMultiD(guide) end
end

local guideCaTrap = function(dataTable)
    -- 默认预站位 TN 北、DPS 南；已形成的实际四人组优先，接击退者朝场中跨场进泥。
    if Data().Half.offSetX ~= nil then
        local guide = {}
        for job in pairs(MG.Party) do
            guide[job] = { x = 100 + Data().Half.offSetX * 2, y = 0, z = 100 }
        end
        MG.FrameMultiD(guide)
        return
    end
    local puddles = getCaPuddles()
    if puddles == nil then
        MG.LogOnce('P1Ca', 'puddles_incomplete', '八人C-A黑泥位置不完整，暂不指路')
        return
    end
    local groups = captureCaTrapGroups(dataTable)
    local owners = {}
    if groups ~= nil then
        owners.north, owners.south = groups.north.owner, groups.south.owner
    else
        for _, job in ipairs(dataTable.BuffJobs) do
            local side = table.contains(thGroup, job) and 'north' or 'south'
            if owners[side] ~= nil then
                MG.LogOnce('P1Ca', 'trap_owners_invalid', '八人C-A击退源分组不完整，暂不指路')
                return
            end
            owners[side] = job
        end
    end
    if #dataTable.BuffJobs ~= 2 or owners.north == nil or owners.south == nil then
        MG.LogOnce('P1Ca', 'trap_owners_invalid', '八人C-A击退源分组不完整，暂不指路')
        return
    end
    local guide = {}
    for side, owner in pairs(owners) do
        local targetSide = side == 'north' and 'south' or 'north'
        local target = puddles[targetSide]
        local source = { x = puddles.centers[side].x, y = 0,
            z = puddles.innerEdges[side] + (side == 'north' and 5.5 or -5.5) }
        -- 放泥移到 12 米后，从共同覆盖区反推 1 米站位加 14 米击退；
        -- 仅在比避开本侧黑泥所需位置更靠场中时采用，最后统一检查两组安全距离。
        local tx, tz = target.x - source.x, target.z - source.z
        local targetDistance = math.sqrt(tx * tx + tz * tz)
        if targetDistance > 15 then
            source = { x = target.x - tx / targetDistance * 15, y = 0,
                z = target.z - tz / targetDistance * 15 }
        end
        local live = TensorCore.mGetEntity(MG.Party[owner].id)
        if live == nil or live.pos == nil then
            MG.LogOnce('P1Ca', 'missing_trap_owner_' .. owner, '八人C-A击退源实体不可用，暂不指路')
            return
        end
        local anchor = source
        if TensorCore.getDistance2d(live.pos, source) < 1 then anchor = live.pos end
        local dx, dz = target.x - anchor.x, target.z - anchor.z
        local distance = math.sqrt(dx * dx + dz * dz)
        if distance < 1 then return end
        dx, dz = dx / distance, dz / distance
        local receiver = { x = anchor.x + dx, y = 0, z = anchor.z + dz }
        -- 接击退者离源 1 米，再沿该方向被推 14 米，必须直接进入对面四层共同覆盖区。
        local landing = { x = receiver.x + dx * 14, z = receiver.z + dz * 14 }
        for _, ent in ipairs(Data().Line3.Shits) do
            if TensorCore.getDistance2d(source, ent.pos) <= 5
                    or TensorCore.getDistance2d(anchor, ent.pos) <= 5
                    or TensorCore.getDistance2d(receiver, ent.pos) <= 5
                    or ((ent.pos.z < 100) == (targetSide == 'north')
                        and TensorCore.getDistance2d(landing, ent.pos) >= 4) then
                MG.LogOnce('P1Ca', 'trap_landing_invalid', '八人C-A击退落点不能覆盖四层黑泥，暂不指路')
                return
            end
        end
        for job in pairs(MG.Party) do
            local inGroup = groups ~= nil and table.contains(groups[side].members, job)
                    or groups == nil and ((side == 'north') == table.contains(thGroup, job))
            if inGroup then guide[job] = job == owner and source or receiver end
        end
    end
    for job, pos in pairs(guide) do
        local inNorth = groups ~= nil and table.contains(groups.north.members, job)
                or groups == nil and table.contains(thGroup, job)
        local otherOwner = inNorth and owners.south or owners.north
        if TensorCore.getDistance2d(pos, guide[otherOwner]) <= 6 then
            MG.LogOnce('P1Ca', 'trap_groups_overlap', '八人C-A两组传毒范围重叠，暂不指路')
            return
        end
    end
    MG.FrameMultiD(guide)
end

-- 计算出移动表
local getThunderMoveTable = function(curThunders)
    local moveTable = {}
    local thunderType = DM.CalcThunderType(curThunders)
    if thunderType == DM.ThunderType.Right13 then
        moveTable.H1 = math.pi / 4
        moveTable.MT = math.pi / 4
        moveTable.H2 = math.pi / 4
        moveTable.D4 = math.pi / 4
        moveTable.D2 = math.pi / 4
        moveTable.D3 = math.pi / 4
        moveTable.D1 = math.pi * 5 / 4
        moveTable.ST = math.pi * 5 / 4
    elseif thunderType == DM.ThunderType.Right24 then
        moveTable.H1 = math.pi * 5 / 4
        moveTable.MT = math.pi * 5 / 4
        moveTable.H2 = math.pi * 5 / 4
        moveTable.D4 = math.pi * 5 / 4
        moveTable.D2 = math.pi * 5 / 4
        moveTable.D3 = math.pi * 5 / 4
        moveTable.D1 = math.pi / 4
        moveTable.ST = math.pi / 4
    elseif thunderType == DM.ThunderType.Left13 then
        moveTable.H1 = math.pi * 7 / 4
        moveTable.D1 = math.pi * 7 / 4
        moveTable.D4 = math.pi * 7 / 4
        moveTable.H2 = math.pi * 7 / 4
        moveTable.ST = math.pi * 7 / 4
        moveTable.D3 = math.pi * 7 / 4
        moveTable.MT = math.pi * 3 / 4
        moveTable.D2 = math.pi * 3 / 4
    elseif thunderType == DM.ThunderType.Left24 then
        moveTable.H1 = math.pi * 3 / 4
        moveTable.D1 = math.pi * 3 / 4
        moveTable.D4 = math.pi * 3 / 4
        moveTable.H2 = math.pi * 3 / 4
        moveTable.ST = math.pi * 3 / 4
        moveTable.D3 = math.pi * 3 / 4
        moveTable.MT = math.pi * 7 / 4
        moveTable.D2 = math.pi * 7 / 4
    end
    return moveTable
end

--- 真假火画图
local drawFire = function(dataTable)
    if not Cfg().draw then
        return
    end
    if dataTable.PlayerMark == 127
            or table.size(dataTable.GatherPlayers) >= 2 then
        local radius = 5
        local drawTime = 6000
        if dataTable.BossMark == 673 then
            --火是假的
            if dataTable.PlayerMark == 127 then
                MG.CreateDrawer(0, 1, 0, 0.3, 2, -1):addTimedCircleOnEnt(drawTime, TensorCore.mGetPlayer().id, radius)
            else
                for _, member in pairs(MG.Party) do
                    MG.CreateDrawer(1, 0, 0, 0.3, 2, -1):addTimedCircleOnEnt(drawTime, member.id, radius)
                end
            end
        else
            --真的
            if dataTable.PlayerMark == 127 then
                for _, member in pairs(MG.Party) do
                    MG.CreateDrawer(1, 0, 0, 0.3, 2, -1):addTimedCircleOnEnt(drawTime, member.id, radius)
                end
            else
                for _, id in pairs(dataTable.GatherPlayers) do
                    MG.CreateDrawer(0, 1, 0, 0.3, 2, -1):addTimedCircleOnEnt(drawTime, id, radius)
                end
            end
        end
    end
end

local checkHalf = function()
    if Data().Half.Timer > 0 then
        if TimeSince(Data().Half.Timer) > 5150 then
            Data().Half.Timer = 0
            Data().Half.offSetX = nil
        end
    end
    if Data().Half.offSetX ~= nil and DM.BeLowState('P1DeathBfLine3') then
        local guideData = {}
        MG.OnCurrentPartyDo(function(job, member)
            if Data().Half.offSetX > 0 and member.pos.x < 100 then
                guideData[job] = { x = 101, y = 0, z = member.pos.z }
            elseif Data().Half.offSetX < 0 and member.pos.x > 100 then
                guideData[job] = { x = 99, y = 0, z = member.pos.z }
            end
        end)
        MG.FrameMultiD(guideData)
    end
end

--------------------------------------------- event function ---------------------------------------------
--- 初始化
--- @param dm DancingMad
--- @param m MuAiGuide
Dmu_P1.Init = function(dm, m)
    DM = dm
    MG = m
end

Dmu_P1.OnEntityChannel = function(entityID, spellID, _)
    if spellID == 50179 then
        -- 恶狠狠毁荡
        Data().Death.Timer = Now()
        Data().Death.InState = true
        MG.CurRaidBoss = TensorCore.mGetEntity(entityID)
    elseif spellID == 47764 then
        if DM.BeLowState('P1TrueFalse1', true) then
            DM.ChangeState('P1TrueFalse1')
        end
    elseif spellID == 48370 then
        -- 众神之像
        if DM.InState('P1DeathBfLine2') then
            -- 死刑后，开始处理线
            DM.ChangeState('P1Line2Start')
        end
        -- 回转寿司后的众神之象 = 神像连线那次; 记时, 之后延迟到连环环陷阱(击退)判定后才画站位
        if Data().Link ~= nil and Data().Link.sushiSeenTime ~= nil
                and TimeSince(Data().Link.sushiSeenTime) < 10000 then
            Data().Link.gsTime = Now()
        end
    elseif spellID == 50722 then
        -- 制裁之光，接3连死刑

    elseif spellID == 47782 then
        -- 连环环陷阱
    end
end

Dmu_P1.OnEntityCast = function(entityID, spellID, castPos)
    if spellID == 47783 and Cfg().blackMudType == 2
            and (DM.InState('P1Line3_2') or DM.InState('P1Turn2End')) then
        if Data().Turn2.caKnockbackAt == nil then
            Data().Turn2.caGroups = captureCaTrapGroups(Data().Turn2)
            Data().Turn2.caKnockbackAt = Now()
            DM.ChangeState('P1Turn2End')
        end
    elseif spellID == 50722 then
        local mt = TensorCore.getEntityByGroup("Main Tank", "Nearest")
        if mt ~= nil then
            MG.CreateDrawer(1, 0.5, 0, nil, 2, -1):addTimedCircleOnEnt(9000, mt.id, 5)
        else
            MG.LogOnce('P1Death', 'missing_main_tank_cast', '死刑绘制跳过：未找到主坦实体', {
                entityID = entityID,
                spellID = spellID,
            }, true)
        end
    elseif spellID == 47801 or spellID == 47802 then
        -- 唰啦啦传送
        if DM.BeLowState('P1TeleTrouncing') then
            DM.ChangeState('P1TeleTrouncing')
        end
    end
end

Dmu_P1.OnMarkerAdd = function(entityID, markerID)
    local DataTable
    if DM.BeLowState('P1TrueFalse1', true) then
        if DM.BeLowState('P1TrueFalse1') then
            DM.ChangeState('P1TrueFalse1')
        end
        DataTable = Data().Fire1
    elseif DM.OverState('P1SleepOrConfused') then
        DataTable = Data().FireThunder
    end
    if DataTable ~= nil then
        if markerID == 127 or markerID == 128 then
            DataTable.PlayerMark = markerID
            if markerID == 128 then
                table.insert(DataTable.GatherPlayers, entityID)
            end
        elseif markerID == 673 or markerID == 674 then
            DataTable.BossMark = markerID
        end
    end
end

---@param aoeInfo DirectionalAOE
Dmu_P1.OnAOECreate = function(aoeInfo)
    if DM.BeLowState('P1TrueFalse2', true) and (aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768) then
        if Data().Fire1.iceDir == nil then
            Data().Fire1.iceDir = MG.SetHeading2Pi(aoeInfo.heading)
        end
    end

    if (aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777)
            and DM.InState('P1FireThunder')
    then
        if Data().FireThunder.MoveTable == nil then
            local moveTable = getThunderMoveTable(aoeInfo)
            if moveTable ~= nil and table.size(moveTable) > 0 then
                Data().FireThunder.MoveTable = moveTable
            end
        end
    end

    if (aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768)
            and DM.InState('P1Line2Start')
            and Data().Line2.dangerDir == nil
    then
        -- 采集冰方向
        Data().Line2.dangerDir = aoeInfo.heading
    end

    -- 激光-采集刷的塔信息
    if aoeInfo.aoeID == 47786 and DM.BeLowState('P2Start') then
        table.insert(Data().Tower.Aoe, aoeInfo)
        if table.size(Data().Tower.Aoe) == 4 then
            table.sort(Data().Tower.Aoe, function(t1, t2)
                return t1.x < t2.x
            end)
        end
    end
end

Dmu_P1.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    autoLookAtCache(entityID, a1, a2, a3)
    halfGroupAOE(entityID, a1, a2, a3)
    shitBoom(entityID, a1, a2, a3)
end

Dmu_P1.OnAddEntityVFX = function(vfxID)

end

Dmu_P1.OnTetherChange = function(sourceEntityID, oldTetherID, oldTetherFlags, oldTargetID, newTetherID, newTetherFlags, newTargetID)
    if oldTetherID ~= 0 and newTetherID == 0 then
        if DM.BeLowState('P1TrueFalse1End', true) then
            Data().Fire1.linkGuideFinish = true
        end
        local fromObj = TensorCore.mGetEntity(sourceEntityID)
        if fromObj.contentid == 7132 then
            -- 线消失
            if DM.InState('P1Line2Start') then
                local oldTarget = TensorCore.mGetEntity(oldTargetID)
                if oldTarget ~= nil and oldTarget.charType == 4 then
                    DM.ChangeState('P1Line2_1')
                    Data().Line2.Timer = Now()
                end
            elseif DM.InState('P1Line2_1')
                    and Data().Line2.Timer > 0
                    and TimeSince(Data().Line2.Timer) > 3000 then
                local oldTarget = TensorCore.mGetEntity(oldTargetID)
                if oldTarget ~= nil and oldTarget.charType == 4 then
                    DM.ChangeState('P1Line2_2')
                end
            elseif DM.InState('P1DeathBfLine3') then
                local oldTarget = TensorCore.mGetEntity(oldTargetID)
                if oldTarget ~= nil and oldTarget.charType == 4 then
                    DM.ChangeState('P1Line3_1')
                    Data().Line3.Timer = Now()
                end
            elseif DM.InState('P1Line3_1')
                    and Data().Line3.Timer > 0
                    and TimeSince(Data().Line3.Timer) > 3000 then
                local oldTarget = TensorCore.mGetEntity(oldTargetID)
                if oldTarget ~= nil and oldTarget.charType == 4 then
                    DM.ChangeState('P1Line3_2')
                end
            end
        end
    end
end

Dmu_P1.Update = function()
    autoLookAtUpdate()
    CheckConeDeath()
    drawBuffKick()
    checkHalf()
    if Cfg().draw
            and (DM.OverState('P1Line3_1', true) and DM.BeLowState('P1ShitBoom'))
            and Data().Line3.Shits ~= nil and table.size(Data().Line3.Shits) >= 0
    then
        local out = 5.05
        local inner
        if ArgusDrawsPlus ~= nil and ArgusDrawsPlus.getEnabled() then
            inner = out - 0.15
        else
            inner = out - 0.08
        end
        local drawer = MG.CreateDrawer(1, 0, 0, 1, 0, 0)
        drawer:setRenderFlags(256)
        for _, ent in pairs(Data().Line3.Shits) do
            drawer:addDonut(ent.pos.x, MG.drawerY, ent.pos.z, inner, out)
        end
    end
    -- 一神击退范围画图
    if DM.BeLowState('P1TrueFalse2', true) then
        if Cfg().draw then
            local kickDis = 10
            local player = TensorCore.mGetPlayer()
            local hasLine, tether = MG.HasLine(player.id, 45)
            if hasLine and tether ~= nil then
                local from = TensorCore.mGetEntity(tether.partnerid)
                if from ~= nil then
                    local heading = TensorCore.getHeadingToTarget(from.pos, player.pos)
                    DM.greenDrawer:addArrow(player.pos.x, MG.drawerY, player.pos.z,
                            heading, kickDis - 0.4, 0.2, 0.4, 0.2, true)
                end
            end
        end
    end
    -- 真假火开始
    if Cfg().guide and Cfg().Fire1Type == 2
            and (DM.InState('P1TrueFalse1') or DM.InState('P1TrueFalse2')) then
        cacheFire1KnockbackGroup(Data().Fire1)
    end
    if DM.InState('P1TrueFalse1') then
        -- 真假火画图
        if Data().Fire1.BossMark ~= 0 and Data().Fire1.PlayerMark ~= 0 then
            drawFire(Data().Fire1)
            DM.ChangeState('P1TrueFalse2')
        end
    end
    -- 真假火判定 转阶段
    if DM.InState('P1TrueFalse2') then
        if MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P1TrueFalse1End')
            Data().Fire1.Time = Now()
        end
        if Cfg().guide and Data().Fire1.iceDir ~= nil
                and (Cfg().Fire1Type ~= 2 or (Data().Fire1.knockbackTh ~= nil
                    and (Data().Fire1.BossMark == 673 or Data().Fire1.BossMark == 674)
                    and (Data().Fire1.PlayerMark == 127
                        or (Data().Fire1.PlayerMark == 128 and table.size(Data().Fire1.GatherPlayers) >= 2)))) then
            local dataTable = Data().Fire1
            if dataTable.GuideData == nil then
                dataTable.GuideData = {}
                if dataTable.PlayerMark == 127 or table.size(dataTable.GatherPlayers) >= 2 then
                    if dataTable.BossMark == 673 then
                        --火是假的
                        if dataTable.PlayerMark == 127 then
                            --点名分散，实际是分摊
                            if (0 < dataTable.iceDir and dataTable.iceDir < math.pi / 2)
                                    or (math.pi < dataTable.iceDir and dataTable.iceDir < math.pi * 3 / 2)
                            then
                                -- 如果危险区在13象限
                                for job, _ in pairs(MG.Party) do
                                    if table.contains(thGroup, job) then
                                        dataTable.GuideData[job] = { x = 96, y = 0, z = 104 }
                                    else
                                        dataTable.GuideData[job] = { x = 104, y = 0, z = 96 }
                                    end
                                end
                            else
                                for job, _ in pairs(MG.Party) do
                                    if table.contains(thGroup, job) then
                                        dataTable.GuideData[job] = { x = 96, y = 0, z = 96 }
                                    else
                                        dataTable.GuideData[job] = { x = 104, y = 0, z = 104 }
                                    end
                                end
                            end
                        else
                            if (0 < dataTable.iceDir and dataTable.iceDir < math.pi / 2)
                                    or (math.pi < dataTable.iceDir and dataTable.iceDir < math.pi * 3 / 2)
                            then
                                -- 如果危险区在13象限
                                dataTable.GuideData = dis24
                            else
                                dataTable.GuideData = dis13
                            end
                        end
                    else
                        --真的
                        if dataTable.PlayerMark == 127 then
                            --点名分散
                            if (0 < dataTable.iceDir and dataTable.iceDir < math.pi / 2)
                                    or (math.pi < dataTable.iceDir and dataTable.iceDir < math.pi * 3 / 2)
                            then
                                -- 如果危险区在13象限
                                dataTable.GuideData = dis24
                            else
                                dataTable.GuideData = dis13
                            end
                        else
                            --点名分摊
                            if (0 < dataTable.iceDir and dataTable.iceDir < math.pi / 2)
                                    or (math.pi < dataTable.iceDir and dataTable.iceDir < math.pi * 3 / 2)
                            then
                                -- 如果危险区在13象限
                                for job, _ in pairs(MG.Party) do
                                    if table.contains(thGroup, job) then
                                        dataTable.GuideData[job] = { x = 96, y = 0, z = 104 }
                                    else
                                        dataTable.GuideData[job] = { x = 104, y = 0, z = 96 }
                                    end
                                end
                            else
                                for job, _ in pairs(MG.Party) do
                                    if table.contains(thGroup, job) then
                                        dataTable.GuideData[job] = { x = 96, y = 0, z = 96 }
                                    else
                                        dataTable.GuideData[job] = { x = 104, y = 0, z = 104 }
                                    end
                                end
                            end
                        end
                    end
                end
                if Cfg().Fire1Type == 2 then
                    setFire1IdleNorth(dataTable)
                end
            else
                if Data().Fire1.linkGuideFinish then
                    MG.FrameMultiD(dataTable.GuideData)
                else
                    if Data().Fire1.GuideDataLink == nil then
                        Data().Fire1.GuideDataLink = {}
                        for job, ent in pairs(MG.Party) do
                            local hasLine = MG.HasLine(ent.id, 45)
                            if Cfg().Fire1Type == 2 then
                                hasLine = table.contains(thGroup, job) == dataTable.knockbackTh
                            end
                            if hasLine then
                                local goLeft = table.contains(thGroup, job)
                                if Cfg().Fire1Type == 2 then
                                    goLeft = dataTable.GuideData[job].x < 100
                                end
                                if goLeft then
                                    Data().Fire1.GuideDataLink[job] = { x = 98, y = 0, z = 88 }
                                else
                                    Data().Fire1.GuideDataLink[job] = { x = 102, y = 0, z = 88 }
                                end
                            else
                                Data().Fire1.GuideDataLink[job] = dataTable.GuideData[job]
                            end
                        end
                    else
                        MG.FrameMultiD(dataTable.GuideDataLink)
                    end
                end
            end
        end
    end
    -- 真假火结束，准备激光
    if DM.OverState('P1TrueFalse1End', true) and DM.BeLowState('P1BeamEnd') then
        if Cfg().draw then
            -- 画激光
            local point = { x = 100, y = 0, z = 70 }
            for _, member in pairs(MuAiGuide.Party) do
                local curMember = TensorCore.mGetEntity(member.id)
                if curMember ~= nil then
                    local dir = TensorCore.getHeadingToTarget(point, curMember.pos)
                    MG.CreateDrawer(0, 1, 1, 0.3, 2, 1)
                      :addRect(point.x, MG.drawerY, point.z, 60, 6, dir, false)
                end
            end
        end
        if Cfg().guide then
            --这里可能涉及计算
            if Data().Beam.Order == nil then
                Data().Beam.Order = Cfg().BeamOrder
            end
            local curParty = {}
            for job, member in pairs(MG.Party) do
                curParty[job] = TensorCore.mGetEntity(member.id)
            end

            -- 一字横排法
            local beamWay = {
                [Data().Beam.Order[1]] = { x = 80.5, z = 100 },
                [Data().Beam.Order[8]] = { x = 119.5, z = 100 },
            }
            for i = 2, 7 do
                local curJob = Data().Beam.Order[i]
                local leftPlayer = curParty[Data().Beam.Order[i - 1]]
                local rightPlayer = curParty[Data().Beam.Order[i + 1]]
                beamWay[curJob] = { x = (leftPlayer.pos.x + rightPlayer.pos.x) / 2, z = 100 }
            end
            MG.FrameMultiD(beamWay)
        end

        if TimeSince(Data().Fire1.Time) > 1500 and MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P1BeamEnd')
            Data().Beam.Time = Now()
        end
    end
    -- 激光射完了
    if DM.InState('P1BeamEnd') then
        -- 计算被射了的人
        if Data().Beam.Order ~= nil and Data().Beam.Shoot == nil then
            local shoot = {}
            for _, job in pairs(Data().Beam.Order) do
                local member = MG.Party[job]
                if TensorCore.hasBuff(member.id, 2941) then
                    table.insert(shoot, job)
                end
            end
            if table.size(shoot) == 4 then
                Data().Beam.Shoot = shoot
            elseif table.size(shoot) > 4 then
                MG.LogOnce('P1Beam', 'invalid_shoot_count', '激光命中人数异常，等待本轮数据稳定', {
                    count = table.size(shoot),
                }, true)
            end
        end
        --计算没被射的人
        if Data().Beam.Order ~= nil
                and Data().Beam.Shoot ~= nil
                and Data().Beam.UnShoot == nil
        then
            local unshoot = {}
            for _, job in pairs(Data().Beam.Order) do
                if not table.contains(Data().Beam.Shoot, job) then
                    table.insert(unshoot, job)
                end
            end
            Data().Beam.UnShoot = unshoot
        end

        -- 激光判定小于4秒，指路踩塔
        if TimeSince(Data().Beam.Time) < 4000 then
            if table.size(Data().Beam.Shoot) == 4
                    and table.size(Data().Beam.UnShoot) == 4
                    and table.size(Data().Tower.Aoe) == 4
            then
                if Cfg().guide then
                    -- 计算踩塔指路位置
                    if Data().Tower.GuideData == nil then
                        local guideData = {}
                        for _, job in pairs(Data().Beam.Order) do
                            local curIdx
                            if table.contains(Data().Beam.Shoot, job) then
                                curIdx = MG.IndexOf(Data().Beam.Shoot, job)
                                local tower = Data().Tower.Aoe[curIdx]
                                guideData[job] = { x = tower.x, z = tower.z + 5 }
                            else
                                curIdx = MG.IndexOf(Data().Beam.UnShoot, job)
                                local tower = Data().Tower.Aoe[curIdx]
                                guideData[job] = { x = tower.x, z = tower.z }
                            end
                        end
                        Data().Tower.GuideData = guideData
                    else
                        MG.FrameMultiD(Data().Tower.GuideData)
                    end
                end
            end
        else
            -- 超过4秒进入传毒阶段
            DM.ChangeState('P1BuffTurn1')
        end
    end
    -- 第一次传毒
    if DM.InState('P1BuffTurn1') then
        turnBuff(Data().Turn1, function()
            return MG.IsAnyMemberHasBuff(5078, 50)
        end)
    end
    -- 第一次放圈前
    if DM.InState('P1Line2Start') then
        -- 可能线还没出现，所以要找一帧确认4个人都有的情况
        if Data().Line2.GatherPlayers == nil or table.size(Data().Line2.GatherPlayers) < 4 then
            Data().Line2.GatherPlayers = {}
            for _, member in pairs(MG.Party) do
                local tethers = Argus.getTethersOnEnt(member)
                if tethers ~= nil and table.size(tethers) > 0 then
                    for _, tether in pairs(tethers) do
                        if tether.type == 45 then
                            local linkFrom = TensorCore.mGetEntity(tether.partnerid)
                            if linkFrom.pos.x < 110 then
                                table.insert(Data().Line2.GatherPlayers, member.id)
                                break
                            end
                        end
                    end
                end
            end
        else
            if Cfg().draw then
                for _, id in pairs(Data().Line2.GatherPlayers) do
                    local player = TensorCore.mGetEntity(id)
                    MG.CreateDrawer(0.2, 0, 0.6, 0.3, 2):addCircle(player.pos.x, MG.drawerY, player.pos.z, 5)
                end
            end
        end
        if Cfg().guide then
            if Data().Line2.Guide1 == nil then
                local groupBy
                if Cfg().Line2Type == 1 then
                    groupBy = mtGroup
                else
                    groupBy = trGroup
                end
                if Data().Line2.dangerDir ~= nil then
                    Data().Line2.Guide1 = {}
                    local dir = MG.SetHeading2Pi(Data().Line2.dangerDir)
                    if (math.pi / 2 < dir and dir < math.pi) or (math.pi * 3 / 2 < dir and dir < 2 * math.pi) then
                        for job, _ in pairs(MG.Party) do
                            if Cfg().blackMudType ~= 2 and table.contains(groupBy, job) then
                                Data().Line2.Guide1[job] = { x = 99.5, y = 0, z = 81 }
                            else
                                Data().Line2.Guide1[job] = { x = 100.5, y = 0, z = Cfg().blackMudType == 2 and 112 or 119 }
                            end
                        end
                    else
                        for job, _ in pairs(MG.Party) do
                            if Cfg().blackMudType ~= 2 and table.contains(groupBy, job) then
                                Data().Line2.Guide1[job] = { x = 100.5, y = 0, z = 81 }
                            else
                                Data().Line2.Guide1[job] = { x = 99.5, y = 0, z = Cfg().blackMudType == 2 and 112 or 119 }
                            end
                        end
                    end
                else
                    if Data().Line2.Guide0 == nil then
                        Data().Line2.Guide0 = {}
                        for job, _ in pairs(MG.Party) do
                            if Cfg().blackMudType ~= 2 and table.contains(groupBy, job) then
                                Data().Line2.Guide0[job] = { x = 100, y = 0, z = 81 }
                            else
                                Data().Line2.Guide0[job] = { x = 100, y = 0, z = Cfg().blackMudType == 2 and 112 or 119 }
                            end
                        end
                    else
                        MG.FrameMultiD(Data().Line2.Guide0)
                    end
                end
            else
                MG.FrameMultiD(Data().Line2.Guide1)
            end
        end
    end
    -- 对一次放圈后分撒
    if DM.InState('P1Line2_1') then
        if Data().Line2.DisPlayers == nil then
            Data().Line2.DisPlayers = {}
            for _, member in pairs(MG.Party) do
                if not table.contains(Data().Line2.GatherPlayers, member.id) then
                    table.insert(Data().Line2.DisPlayers, member.id)
                end
            end
        else
            guideAndDrawL2L3(Data().Line2, false)
        end
    end
    if Cfg().blackMudType == 2 and Cfg().guide and DM.InState('P1Line2_2') then
        local guide = {}
        for job in pairs(MG.Party) do
            guide[job] = { x = 100 + (Data().Half.offSetX or 0) * 2, y = 0,
                -- Boss 在北侧打扇形死刑，非坦克留在南侧背后。
                z = (job == 'MT' or job == 'ST') and 92 or 104 }
        end
        MG.FrameMultiD(guide)
    end
    -- 第二次扇形死刑后
    if DM.InState('P1DeathBfLine3') then
        local groupBy
        if Cfg().Line2Type == 1 then
            groupBy = mtGroup
        else
            groupBy = trGroup
        end
        if Data().Line3.Guide1 == nil
                or Data().Line3.GatherPlayers == nil
                or table.size(Data().Line3.GatherPlayers) < 4 then
            Data().Line3.Guide1 = {}
            Data().Line3.DisPlayers = {}
            Data().Line3.GatherPlayers = {}
            --找到前次黑泥，
            local upZ = 0
            local downZ = 1000
            if Cfg().blackMudType ~= 2 then
                for _, ent in pairs(TensorCore.entityList("contentid=2015266")) do
                    if ent.pos.z > 100 then
                        if ent.pos.z < downZ then
                            downZ = ent.pos.z
                        end
                    else
                        if ent.pos.z > upZ then
                            upZ = ent.pos.z
                        end
                    end
                end
            end
            for job, member in pairs(MG.Party) do
                if Cfg().blackMudType == 2 then
                    -- 第一轮 C、第二轮 A，均离场中 12 米。
                    Data().Line3.Guide1[job] = { x = 100, y = 0, z = 88 }
                elseif table.contains(groupBy, job) then
                    Data().Line3.Guide1[job] = { x = 100, y = 0, z = upZ + 6 }
                else
                    Data().Line3.Guide1[job] = { x = 100, y = 0, z = downZ - 6 }
                end
                local tethers = Argus.getTethersOnEnt(member)
                if tethers ~= nil and table.size(tethers) > 0 then
                    for _, tether in pairs(tethers) do
                        if tether.type == 45 then
                            local linkFrom = TensorCore.mGetEntity(tether.partnerid)
                            if linkFrom.pos.x > 110 then
                                table.insert(Data().Line3.DisPlayers, member.id)
                            else
                                table.insert(Data().Line3.GatherPlayers, member.id)
                            end
                        end
                    end
                end
            end
        else
            MG.FrameMultiD(Data().Line3.Guide1)
            if Cfg().draw then
                for _, id in pairs(Data().Line3.GatherPlayers) do
                    local player = TensorCore.mGetEntity(id)
                    MG.CreateDrawer(0.2, 0, 0.6, 0.3, 2):addCircle(player.pos.x, MG.drawerY, player.pos.z, 5)
                end
            end
        end
    end
    -- 第二次放圈后分散
    if DM.InState('P1Line3_1') then
        guideAndDrawL2L3(Data().Line3, true)
        if Data().Line3.Shits == nil or table.size(Data().Line3.Shits) < 8 then
            Data().Line3.Shits = {}
            for _, ent in pairs(TensorCore.entityList("contentid=2015266")) do
                table.insert(Data().Line3.Shits, ent)
                if ent.pos.z > 100 then
                    if Data().Line3.DownShit == nil or ent.pos.z < Data().Line3.DownShit.pos.z then
                        Data().Line3.DownShit = ent
                    end
                else
                    if Data().Line3.UpShit == nil or ent.pos.z > Data().Line3.UpShit.pos.z then
                        Data().Line3.UpShit = ent
                    end
                end
            end
        end
    end

    -- 第二次传毒
    if DM.InState('P1Line3_2') then
        if Cfg().blackMudType == 2 then
            turnBuff(Data().Turn2, function()
                return Data().Turn2.caKnockbackAt ~= nil
            end, guideCaTrap)
        else
            if Data().Half.offSetX == nil then
                Data().Turn2.thGroupGuidePos = {
                    x = 100,
                    y = Data().Line3.UpShit.pos.y,
                    z = Data().Line3.UpShit.pos.z + 5.5
                }
                Data().Turn2.dpsGroupGuidePos = {
                    x = 100,
                    y = Data().Line3.DownShit.pos.y,
                    z = Data().Line3.DownShit.pos.z - 5.5
                }
            else
                Data().Turn2.thGroupGuidePos = {
                    x = 100 + Data().Half.offSetX,
                    y = Data().Line3.UpShit.pos.y,
                    z = Data().Line3.UpShit.pos.z + 5.5
                }
                Data().Turn2.dpsGroupGuidePos = {
                    x = 100 + Data().Half.offSetX,
                    y = Data().Line3.DownShit.pos.y,
                    z = Data().Line3.DownShit.pos.z - 5.5
                }
            end
            turnBuff(Data().Turn2, function()
                return MG.IsAnyMemberHasBuff(5078, 40)
            end)
        end
    end

    if DM.InState('P1Turn2End') then
        if Cfg().blackMudType == 2 then
            if #Data().Shit.Boomed >= 8 then
                DM.ChangeState('P1ShitBoom')
            elseif Cfg().guide then
                guideCaSoak()
            end
        else
            if table.size(Data().Shit.Boomed) >= 8 then
                DM.ChangeState('P1ShitBoom')
            end
            if Data().Shit.StateTimer == 0 then
                Data().Shit.StateTimer = Now()
            end
            if TimeSince(Data().Shit.StateTimer) > 1200 then
                local player = MG.GetPlayer()
                if Data().Shit.Guide1 == nil
                        or Data().Shit.Guide2 == nil
                then
                    if player.pos.z > 100 then
                        Data().Shit.Guide1 = Data().Line3.DownShit.pos
                        Data().Shit.Guide2 = MG.VectorXZAdd(Data().Line3.DownShit.pos, { x = 0, y = 0, z = 6 })
                    else
                        Data().Shit.Guide1 = Data().Line3.UpShit.pos
                        Data().Shit.Guide2 = MG.VectorXZAdd(Data().Line3.UpShit.pos, { x = 0, y = 0, z = -6 })
                    end
                else
                    if Data().Shit.first then
                        for _, shit in pairs(Data().Shit.Boomed) do
                            if TensorCore.getDistance2d(shit.pos, player.pos) < 6 then
                                Data().Shit.first = false
                            end
                        end
                        MG.FrameDirect(Data().Shit.Guide1.x, Data().Shit.Guide1.z)
                    else
                        MG.FrameDirect(Data().Shit.Guide2.x, Data().Shit.Guide2.z)
                    end
                end
            end
        end
    end
    -- 八层黑泥结算后本段指路结束，不在等待传送的状态中持续回中。
    --箭头
    if DM.InState('P1TeleTrouncing') then
        for buffId, buffType in pairs(ArrowBuffs) do
            if TensorCore.hasBuff(TensorCore.mGetPlayer().id, buffId) then
                DM.ChangeState('P1TeleTrouncingGetBuff')
                Data().TeleTrouncing.Timer = Now()
                break
            end
        end
    end

    if DM.InState('P1TeleTrouncingGetBuff')
            and Data().TeleTrouncing.Timer ~= 0
            and TimeSince(Data().TeleTrouncing.Timer) > 500
    then
        if Data().TeleTrouncing.BuffInfo == nil or table.size(Data().TeleTrouncing.BuffInfo) < 8 then
            Data().TeleTrouncing.BuffInfo = {}
            Data().TeleTrouncing.Guide1 = {}
            Data().TeleTrouncing.Guide2 = {}
            local buffInfo = Data().TeleTrouncing.BuffInfo
            for job, member in pairs(MG.Party) do
                buffInfo[job] = {}
                local key1, key2
                local curPlayer = TensorCore.mGetEntity(member.id)
                local buffs = curPlayer.buffs
                for _, buff in pairs(buffs) do
                    local buffType = ArrowBuffs[buff.id]
                    if ArrowBuffs[buff.id] ~= nil then
                        if buff.duration > 7 then
                            buffInfo[job].long = buff.id
                            buffInfo[job].longKey = buffType
                        else
                            buffInfo[job].short = buff.id
                            buffInfo[job].shortKey = buffType
                        end
                    end
                end
                if buffInfo[job].short ~= nil and buffInfo[job].long ~= nil then
                    key1 = buffInfo[job].shortKey .. '_' .. buffInfo[job].longKey
                    key2 = buffInfo[job].longKey .. '_' .. buffInfo[job].shortKey
                    if Cfg().transUnOpt then
                        if TeleTrouncingPos2[key1] ~= nil then
                            buffInfo[job].posInfo = TeleTrouncingPos2[key1]
                        elseif TeleTrouncingPos2[key2] ~= nil then
                            buffInfo[job].posInfo = TeleTrouncingPos2[key2]
                        end
                    else
                        if TeleTrouncingPos[key1] ~= nil then
                            buffInfo[job].posInfo = TeleTrouncingPos[key1]
                        elseif TeleTrouncingPos[key2] ~= nil then
                            buffInfo[job].posInfo = TeleTrouncingPos[key2]
                        end
                    end
                    if buffInfo[job].longKey == buffInfo[job].shortKey then
                        Data().TeleTrouncing.Guide1[job] = buffInfo[job].posInfo[1]
                        Data().TeleTrouncing.Guide2[job] = buffInfo[job].posInfo[2]
                    else
                        if Data().TeleTrouncing.Reference == nil then
                            Data().TeleTrouncing.Reference = {
                                id = member.id,
                                short = buffInfo[job].short,
                                long = buffInfo[job].long
                            }
                        end
                        Data().TeleTrouncing.Guide1[job] = buffInfo[job].posInfo[buffInfo[job].shortKey]
                        Data().TeleTrouncing.Guide2[job] = buffInfo[job].posInfo[buffInfo[job].longKey]
                    end
                end
            end
        else
            local ref = Data().TeleTrouncing.Reference
            local curShortBuff = TensorCore.getBuff(ref.id, ref.short)
            local curLongBuff = TensorCore.getBuff(ref.id, ref.long)
            if curLongBuff ~= nil and curLongBuff.duration > 0 then
                if Cfg().guide then
                    if curShortBuff ~= nil and curShortBuff.duration > 0 then
                        MG.FrameMultiD(Data().TeleTrouncing.Guide1)
                    else
                        MG.FrameMultiD(Data().TeleTrouncing.Guide2)
                    end
                end
            else
                if Data().TeleTrouncing.Timer ~= 0 and TimeSince(Data().TeleTrouncing.Timer) > 10000 then
                    DM.ChangeState('P1ArrowPut')
                end
            end
        end
    end
    -- 放完箭头去击退位置
    if DM.InState('P1ArrowPut') then
        turnBuff(Data().Turn3, function()
            for _, member in pairs(MG.Party) do
                if TensorCore.hasBuff(member.id, 5078) then
                    return false
                end
            end
            return true
        end)
    end
    -- 睡眠点名
    if DM.InState('P1SleepOrConfused') then
        if MG.IsAnyMemberHasBuff(4894) then
            DM.ChangeState('P1Teleport')
            Data().LastLink.Timer = Now()
        end
        if Data().LastLink.SleepGroup == nil or table.size(Data().LastLink.SleepGroup) < 4 then
            Data().LastLink.SleepGroup = {}
            for job, member in pairs(MG.Party) do
                local tethers = Argus.getTethersOnEnt(member)
                if tethers ~= nil and table.size(tethers) > 0 then
                    for _, tether in pairs(tethers) do
                        if tether.type == 45 then
                            local linkFrom = TensorCore.mGetEntity(tether.partnerid)
                            if linkFrom.pos.x > 100 then
                                table.insert(Data().LastLink.SleepGroup, job)
                                break
                            end
                        end
                    end
                end
            end
        else
            if Cfg().draw then
                for _, job in pairs(Data().LastLink.SleepGroup) do
                    local player = TensorCore.mGetEntity(MG.Party[job].id)
                    MG.CreateDrawer(0.2, 0, 0.6, 0.3, 2)
                      :addCircle(player.pos.x, MG.drawerY, player.pos.z, 5)
                end
            end
        end
        if Cfg().guide then
            if Cfg().transUnOpt then
                if table.size(Data().LastLink.SleepGroup) >= 4 then
                    if not Data().LastLink.exchanged then
                        Data().LastLink.GuideData2 = {}
                        for _, job in pairs(Data().LastLink.SleepGroup) do
                            -- 如果睡眠点了远程组，和同组互换位置
                            if table.contains({ 'H1', 'H2', 'D3', 'D4' }, job) then
                                local partner = MG.CalcPartner(job)
                                Data().LastLink.GuideData[job], Data().LastLink.GuideData[partner] = Data().LastLink.GuideData[partner], Data().LastLink.GuideData[job]
                            end
                        end
                        Data().LastLink.exchanged = true
                    else
                        MG.FrameMultiD(Data().LastLink.GuideData)
                    end
                end
            else
                MG.FrameMultiD(Data().LastLink.GuideData)
            end
        end
    end
    -- 开始传送
    if DM.InState('P1Teleport')
            and Data().LastLink.Timer ~= 0
            and TimeSince(Data().LastLink.Timer) > 4000 then
        local anyoneNoBuff = true
        for _, player in pairs(MG.Party) do
            if TensorCore.hasBuff(player.id, 4894)
                    or TensorCore.hasBuff(player.id, 1283)
            then
                anyoneNoBuff = false
                break
            end
        end
        if anyoneNoBuff then
            DM.ChangeState('P1FireThunder')
        end
    end
    if DM.InState('P1FireThunder') then
        if MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P1End')
        end
        if Data().FireThunder.PlayerMark ~= nil
                and Data().FireThunder.BossMark ~= nil
                and Data().FireThunder.MoveTable ~= nil
        then
            if not Data().FireThunder.DrawCalled then
                Data().FireThunder.DrawCalled = true
                drawFire(Data().FireThunder)
            end
            if Cfg().guide then
                if Data().FireThunder.GuideData == nil
                        or table.size(Data().FireThunder.GuideData) < 8
                then
                    Data().FireThunder.GuideData = {}
                    local moveTable = Data().FireThunder.MoveTable
                    local movePos = {}
                    for job, pos in pairs(Data().FireThunder.BaseGuideData) do
                        movePos[job] = TensorCore.getPosInDirection(pos, moveTable[job], 0.5)
                    end
                    if Data().FireThunder.BossMark == 673 then
                        --火假
                        if Data().FireThunder.PlayerMark == 127 then
                            for job, _ in pairs(MG.Party) do
                                if table.contains(thGroup, job) then
                                    Data().FireThunder.GuideData[job] = movePos.MT
                                else
                                    Data().FireThunder.GuideData[job] = movePos.D2
                                end
                            end
                        else
                            Data().FireThunder.GuideData = movePos
                        end
                    else
                        --真的
                        if Data().FireThunder.PlayerMark == 127 then
                            Data().FireThunder.GuideData = movePos
                        else
                            for job, _ in pairs(MG.Party) do
                                if table.contains(thGroup, job) then
                                    Data().FireThunder.GuideData[job] = movePos.MT
                                else
                                    Data().FireThunder.GuideData[job] = movePos.D2
                                end
                            end
                        end
                    end
                else
                    MG.FrameMultiD(Data().FireThunder.GuideData)
                end
            end
        end
    end
end
return Dmu_P1
