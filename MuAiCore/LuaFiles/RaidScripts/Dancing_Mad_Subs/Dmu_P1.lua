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
            DM.cyanDrawer:addCircle(curMember.pos.x, curMember.pos.y, curMember.pos.z, 6)
            if not table.contains(buffPlayerId, player.id) then
                local distance = TensorCore.getDistance2d(curMember.pos, player.pos)
                if distance < 6 then
                    local kickDis = 15
                    local heading = TensorCore.getHeadingToTarget(curMember.pos, player.pos)
                    DM.greenDrawer:addArrow(player.pos.x, player.pos.y, player.pos.z, heading, kickDis - 0.4, 0.2, 0.4, 0.2, true)
                end
            end
        end
    end
end

--- 绘制死刑
local drawDeath = function()
    if Cfg().draw and Data().Death.OnDraw and Data().Death.Timer > 0 then
        if TimeSince(Data().Death.Timer) < 9000 then
            if TimeSince(Data().Death.Timer) < 6000 then
                if Data().Death.MT == nil then
                    Data().Death.MT = TensorCore.getEntityByGroup("Main Tank", "Nearest")
                else
                    local curMt = TensorCore.mGetEntity(Data().Death.MT.id)
                    local dir = TensorCore.getHeadingToTarget(MG.CurRaidBoss.pos, curMt.pos)
                    local curBoss = MG.GetCurRaidBoss()
                    DM.redDrawer:addCone(curBoss.pos.x, curBoss.pos.y, curBoss.pos.z, 30, math.pi * 2 / 3, dir)
                end
            else
                if Data().Death.ST == nil then
                    local curMt = TensorCore.getEntityByGroup("Main Tank", "Nearest")
                    for job, member in pairs(MG.Party) do
                        if (job == 'MT' or job == 'ST') and member.id ~= curMt then
                            Data().Death.ST = member
                            break
                        end
                    end
                else
                    local cur = TensorCore.mGetEntity(Data().Death.MT.id)
                    local dir = TensorCore.getHeadingToTarget(MG.CurRaidBoss.pos, cur.pos)
                    local curBoss = MG.GetCurRaidBoss()
                    DM.redDrawer:addCone(curBoss.pos.x, curBoss.pos.y, curBoss.pos.z, 30, math.pi * 2 / 3, dir)
                end
            end
        else
            Data().Death.OnDraw = false
            Data().Death.MT = nil
            Data().Death.ST = nil
            Data().Death.Timer = 0
        end
    end
end

-- ===== 回转寿司(唰啦啦传送 47802) 方向debuff指路: 时长短的先去①, 长的后去② =====
-- 方向debuff: 4876/5079=上 4877/5080=下 4878/5081=右 4879/5082=左
local SushiBuffDir = {
    [4876] = 'up', [4877] = 'down', [4878] = 'right', [4879] = 'left',
    [5079] = 'up', [5080] = 'down', [5081] = 'right', [5082] = 'left',
}
-- 每种方向组合的两步落点(16点格, 与回转寿司一致): { 箭1, 箭2 } 每箭 {dir,x,z}
local SushiPairs = {
    ['same:left']           = { { dir = 'left',  x = 100, z = 88 },  { dir = 'left',  x = 106, z = 88 } },
    ['different:left:up']   = { { dir = 'left',  x = 112, z = 88 },  { dir = 'up',    x = 112, z = 94 } },
    ['same:up']             = { { dir = 'up',    x = 112, z = 100 }, { dir = 'up',    x = 112, z = 106 } },
    ['different:up:right']  = { { dir = 'up',    x = 112, z = 112 }, { dir = 'right', x = 106, z = 112 } },
    ['same:right']          = { { dir = 'right', x = 100, z = 112 }, { dir = 'right', x = 94,  z = 112 } },
    ['different:right:down']= { { dir = 'right', x = 88,  z = 112 }, { dir = 'down',  x = 88,  z = 106 } },
    ['same:down']           = { { dir = 'down',  x = 88,  z = 100 }, { dir = 'down',  x = 88,  z = 94 } },
    ['different:down:left'] = { { dir = 'down',  x = 88,  z = 88 },  { dir = 'left',  x = 94,  z = 88 } },
}
local function sushiDiffKey(d1, d2)
    local has = { [d1] = true, [d2] = true }
    if has.up and has.left then
        return 'different:left:up'
    elseif has.up and has.right then
        return 'different:up:right'
    elseif has.right and has.down then
        return 'different:right:down'
    elseif has.down and has.left then
        return 'different:down:left'
    end
end
local function sushiArrowByDir(pair, dir)
    if pair[1].dir == dir then return pair[1] end
    if pair[2].dir == dir then return pair[2] end
end
-- 画靶心(粉内+绿外)+步骤数字, 同 huizhuan
local function sushiMark(p, text, drawTime)
    TensorCore.getStaticFlatDrawer(3539271935):addTimedCircle(drawTime, p.x, 0, p.z, 0.25, 0, true, true)
    TensorCore.getStaticFlatDrawer(1359019776):addTimedCircle(drawTime, p.x, 0, p.z, 0.75, 0, true, true)
    AnyoneCore.addTimedWorldText(drawTime, text, { x = p.x, y = 0, z = p.z }, AnyoneCore.COLOR_WHITE, true, 2)
end

--- 回转寿司指路 + 触发神像连线
--- 玩家2方向debuff: 短①长②(画一次); buff全清空=传送阵放完 → 开神像连线站位指路窗口
local drawSushi = function()
    local player = TensorCore.mGetPlayer()
    local matched = {}
    for _, buff in pairs(player.buffs or {}) do
        local dir = SushiBuffDir[buff.id]
        if dir ~= nil then
            table.insert(matched, { dir = dir, duration = buff.duration })
        end
    end
    local n = table.size(matched)
    if n >= 1 then
        -- 回转寿司进行中: 记下时刻(供识别其后的众神之象=神像连线那次)
        Data().Link = Data().Link or {}
        Data().Link.sushiSeenTime = Now()
        if Cfg().draw and n == 2 and (Data().Sushi == nil or not Data().Sushi.drawn) then
            local d1, d2 = matched[1], matched[2]
            local shortPos, longPos
            if d1.dir == d2.dir then
                local pair = SushiPairs['same:' .. d1.dir]
                if pair ~= nil then
                    shortPos, longPos = pair[1], pair[2]
                end
            else
                local pair = SushiPairs[sushiDiffKey(d1.dir, d2.dir)]
                if pair ~= nil then
                    local sb, lb = d1, d2
                    if d1.duration > d2.duration then
                        sb, lb = d2, d1
                    end
                    shortPos = sushiArrowByDir(pair, sb.dir)
                    longPos = sushiArrowByDir(pair, lb.dir)
                end
            end
            if shortPos ~= nil and longPos ~= nil then
                sushiMark(shortPos, '1', 7000)
                sushiMark(longPos, '2', 10000)
                Data().Sushi = { drawn = true }
            end
        end
    else
        Data().Sushi = nil
    end
end

-- ===== 神像连线(圣母/睡魔的神气) 固定站位指路 =====
-- 外环 D3上/D4右/H2下/H1左(距中心16); 内环 MT上/ST右/D2下/D1左(距中心9.8); 中心100,100
local LinkGuide = {
    D3 = { x = 100, z = 84 },  MT = { x = 100, z = 90.2 },
    D4 = { x = 116, z = 100 }, ST = { x = 109.8, z = 100 },
    H2 = { x = 100, z = 116 }, D2 = { x = 100, z = 109.8 },
    H1 = { x = 84, z = 100 },  D1 = { x = 90.2, z = 100 },
}

--- 神像连线固定站位指路: 神像连线那次众神之象后, 延迟到连环环陷阱(击退)判定之后才画, 持续到神气判定前
local drawLink = function()
    if Cfg().guide and Data().Link ~= nil and Data().Link.gsTime ~= nil then
        local dt = TimeSince(Data().Link.gsTime)
        if dt >= 7500 and dt < 16500 then
            MG.FrameMultiD(LinkGuide)
        end
    end
end

--- 初始化
--- @param dm DancingMad
--- @param m MuAiGuide
Dmu_P1.Init = function(dm, m)
    DM = dm
    MG = m
end

local closeList = {
    [47764] = { old0 = nil, old1 = nil },
    [47768] = { old0 = nil, old1 = nil },
    [47771] = { old0 = nil, old1 = nil },
    [47774] = { old0 = nil, old1 = nil },
    [47775] = { old0 = nil, old1 = nil },
    [47776] = { old0 = nil, old1 = nil },
    [47777] = { old0 = nil, old1 = nil },
}

local effectSwitch

local applyEffectBinder = function()
    if effectSwitch ~= Cfg().effect then
        if Cfg().effect then
            if closeList[47764].old0 == nil then
                for skillId, _ in pairs(closeList) do
                    closeList[skillId].old0 = Argus.getActionAOEType(skillId, 0)
                    closeList[skillId].old1 = Argus.getActionAOEType(skillId, 1)
                    Argus.setActionAOEType(skillId, 0, 0)
                    Argus.setActionAOEType(skillId, 1, 0)
                end
            end
            d('applyEffectBinder1')
        else
            for skillId, _ in pairs(closeList) do
                if closeList[skillId].old0 ~= nil then
                    Argus.setActionAOEType(skillId, 0, closeList[skillId].old0)
                end
                if closeList[skillId].old1 ~= nil then
                    Argus.setActionAOEType(skillId, 1, closeList[skillId].old1)
                end
            end
            d('applyEffectBinder2')
        end
        effectSwitch = Cfg().effect
    end
end

-- ===== 真假火雷(冰火雷最后一次: 火+雷同时出现) 职能固定式指路 =====
-- 标点(中心100,100,偏移12): A上 B右 C下 D左; 1左上 2右上 3右下 4左下
local FtWay = {
    ['1'] = { x = 88, z = 88 }, ['2'] = { x = 112, z = 88 },
    ['3'] = { x = 112, z = 112 }, ['4'] = { x = 88, z = 112 },
    ['A'] = { x = 100, z = 88 }, ['B'] = { x = 112, z = 100 },
    ['C'] = { x = 100, z = 112 }, ['D'] = { x = 88, z = 100 },
}
-- 分散: 职能→标点 (MT=1 D1=2 D2=3 ST=4 / H1=A D4=B D3=C H2=D)
local FtSpread = { MT = '1', D1 = '2', D2 = '3', ST = '4', H1 = 'A', D4 = 'B', D3 = 'C', H2 = 'D' }
local FtTh = { MT = true, ST = true, H1 = true, H2 = true }

-- 把落点沿法线推出真雷(47775/47777)危险带(半宽5)
local ftAvoidThunder = function(pos, thunders)
    local q = { x = pos.x, y = 0, z = pos.z }
    for _ = 1, 2 do
        for _, a in pairs(thunders) do
            local p2 = TensorCore.getPosInDirection({ x = a.x, y = 0, z = a.z }, a.heading, 1)
            local nx = -(p2.z - a.z)
            local nz = (p2.x - a.x)
            local dd = (q.x - a.x) * nx + (q.z - a.z) * nz
            if math.abs(dd) < 5.5 then
                local sign = 1
                if dd < 0 then sign = -1 end
                local push = (5.5 - math.abs(dd)) * sign + sign * 0.3
                q.x = q.x + nx * push
                q.z = q.z + nz * push
            end
        end
    end
    return q
end

Dmu_P1.OnEntityChannel = function(entityID, spellID, _)
    if spellID == 50179 then
        -- 恶狠狠毁荡
        Data().Death.Timer = Now()
        Data().Death.OnDraw = true
        MG.CurRaidBoss = TensorCore.mGetEntity(entityID)
    elseif spellID == 47764 then
        if DM.BeLowState('P1TrueFalse1', true) then
            DM.ChangeState('P1TrueFalse1')
        end

    elseif spellID == 48370 then
        -- 众神之象
        if DM.OverState('P1BeamEnd') and DM.BeLowState('P1Line2Start') then
            DM.ChangeState('P1Line2Start')
        end
        -- 回转寿司后的众神之象 = 神像连线那次; 记时, 之后延迟到连环环陷阱(击退)判定后才画站位
        if Data().Link ~= nil and Data().Link.sushiSeenTime ~= nil
                and TimeSince(Data().Link.sushiSeenTime) < 10000 then
            Data().Link.gsTime = Now()
        end
    elseif spellID == 47782 then
        -- 连环环陷阱

    end
end

Dmu_P1.OnMarkerAdd = function(entityID, markerID)
    -- 真假火雷识别: 采 火头标(127/128)/真假标(673/674), 各记时间戳(头标常比玄乎乎魔法读条早)
    if markerID == 127 or markerID == 128 or markerID == 673 or markerID == 674 then
        Data().Ft = Data().Ft or { pm = 0, pmTime = 0, bm = 0, thunders = {}, thTime = 0 }
        if markerID == 127 or markerID == 128 then
            Data().Ft.pm = markerID
            Data().Ft.pmTime = Now()
        else
            Data().Ft.bm = markerID
        end
    end
    if DM.BeLowState('P1TrueFalse1', true) then
        if DM.BeLowState('P1TrueFalse1') then
            DM.ChangeState('P1TrueFalse1')
        end
        if markerID == 127 or markerID == 128 then
            if Data().Fire1.PlayerMark == 0 then
                Data().Fire1.PlayerMark = markerID
            end
            if markerID == 128 then
                table.insert(Data().Fire1.GatherPlayers, entityID)
            end
        elseif markerID == 673 or markerID == 674 then
            Data().Fire1.BossMark = markerID
        end
    end
end

---@param aoeInfo DirectionalAOE
Dmu_P1.OnAOECreate = function(aoeInfo)
    -- 画制冰和雷
    if Cfg().draw then
        local drawTime = 5500
        if not Cfg().effect then
            -- 冰危险区
            if aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768 then
                DM.yellowDrawer:addTimedCone(drawTime, aoeInfo.x, aoeInfo.y, aoeInfo.z, 40, math.pi / 2, aoeInfo.heading, 0, true)
            end

            -- 画雷危险区
            if aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777 then
                local startPos = TensorCore.getPosInDirection({ x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z }, aoeInfo.heading + math.pi, 5)
                DM.yellowDrawer:addTimedRect(drawTime, startPos.x, startPos.y, startPos.z, 50, 10, aoeInfo.heading, 0, true)
            end
        else
            -- 冰危险区
            if aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768 then
                DM.purpleDrawer:addTimedCone(drawTime, aoeInfo.x, aoeInfo.y, aoeInfo.z, 40, math.pi / 2, aoeInfo.heading)
            end

            -- 画雷危险区
            if aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777 then
                local startPos = TensorCore.getPosInDirection({ x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z }, aoeInfo.heading + math.pi, 5)
                DM.purpleDrawer:addTimedRect(drawTime, startPos.x, startPos.y, startPos.z, 50, 10, aoeInfo.heading)
            end
        end
    end

    -- 真假火雷识别: 采真雷线(47775/47777)初始位置(与上方危险区同一判定), 隔轮(>9s)重置
    if aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777 then
        Data().Ft = Data().Ft or { pm = 0, pmTime = 0, bm = 0, thunders = {}, thTime = 0 }
        if TimeSince(Data().Ft.thTime) > 9000 then
            Data().Ft.thunders = {}
        end
        table.insert(Data().Ft.thunders, { x = aoeInfo.x, z = aoeInfo.z, heading = aoeInfo.heading })
        Data().Ft.thTime = Now()
    end

    -- 采集刷的塔信息
    if aoeInfo.aoeID == 47786 and DM.BeLowState('P2Start') then
        table.insert(Data().Tower.Aoe, aoeInfo)
        if table.size(Data().Tower.Aoe) == 4 then
            table.sort(Data().Tower.Aoe, function(t1, t2)
                return t1.x < t2.x
            end)
        end
    end
end

Dmu_P1.OnEventObjectScriptFunc = function(entityID)

end

Dmu_P1.OnAddEntityVFX = function(vfxID)

end

Dmu_P1.Update = function()
    applyEffectBinder()
    drawDeath()

    -- 真假火雷 职能固定式指路: 近期 火头标(127/128)+雷线 同时存在(=冰火雷最后一次火+雷)
    if Cfg().guide and Data().Ft ~= nil
            and Data().Ft.pm ~= 0 and TimeSince(Data().Ft.pmTime) < 9000
            and table.size(Data().Ft.thunders) > 0 and TimeSince(Data().Ft.thTime) < 9000 then
        -- 127分散/128分摊; 火假(673)翻转(假分散即分摊、假分摊即分散)
        local spread = (Data().Ft.pm == 127)
        if Data().Ft.bm == 673 then
            spread = not spread
        end
        local guideData = {}
        for job, member in pairs(MG.Party) do
            local slot
            if spread then
                slot = FtSpread[job]
            elseif FtTh[job] then
                slot = '1'
            else
                slot = '3'
            end
            if slot ~= nil and FtWay[slot] ~= nil then
                guideData[job] = ftAvoidThunder(FtWay[slot], Data().Ft.thunders)
            end
        end
        MG.FrameMultiD(guideData)
    end

    if DM.InState('P1TrueFalse1') then
        -- 真假火画图
        if Cfg().draw
                and Data().Fire1.BossMark ~= 0
                and Data().Fire1.PlayerMark ~= 0
        then
            if Data().Fire1.PlayerMark == 127
                    or table.size(Data().Fire1.GatherPlayers) >= 2 then
                local radius = 5
                local drawTime = 6000
                if Data().Fire1.BossMark == 673 then
                    --火是假的
                    if Data().Fire1.PlayerMark == 127 then
                        DM.greenDrawer:addTimedCircleOnEnt(drawTime, TensorCore.mGetPlayer().id, radius)
                    else
                        for _, member in pairs(MG.Party) do
                            DM.redDrawer:addTimedCircleOnEnt(drawTime, member.id, radius)
                        end
                    end
                else
                    --火是假的
                    if Data().Fire1.PlayerMark == 127 then
                        for _, member in pairs(MG.Party) do
                            DM.redDrawer:addTimedCircleOnEnt(drawTime, member.id, radius)
                        end
                    else
                        for _, id in pairs(Data().Fire1.GatherPlayers) do
                            DM.greenDrawer:addTimedCircleOnEnt(drawTime, id, radius)
                        end
                    end
                end
                DM.ChangeState('P1TrueFalse2')
            end
        end

    end

    -- 连线画图(击退提示箭头)
    if DM.BeLowState('P1TrueFalse2', true) then
        if Cfg().draw then
            local kickDis = 10
            local player = TensorCore.mGetPlayer()
            local hasLine, tether = MG.HasLine(player.id, 45)
            if hasLine and tether ~= nil then
                local from = TensorCore.mGetEntity(tether.partnerid)
                if from ~= nil then
                    local heading = TensorCore.getHeadingToTarget(from.pos, player.pos)
                    DM.greenDrawer:addArrow(player.pos.x, player.pos.y, player.pos.z,
                            heading, kickDis - 0.4, 0.2, 0.4, 0.2, true)
                end
            end
        end
    end

    -- 真假火判定 转阶段
    if DM.InState('P1TrueFalse2') then
        if MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P1TrueFalse1End')
            Data().Fire1.Time = Now()
        end
    end

    if DM.OverState('P1TrueFalse1End', true) and DM.BeLowState('P1BeamEnd') then
        if Cfg().draw then
            -- 画激光
            local point = { x = 100, y = 0, z = 70 }
            for _, member in pairs(MuAiGuide.Party) do
                local curMember = TensorCore.mGetEntity(member.id)
                if curMember ~= nil then
                    local dir = TensorCore.getHeadingToTarget(point, curMember.pos)
                    local color = GUI:ColorConvertFloat4ToU32(0, 1, 1, 0.2)
                    Argus2.ShapeDrawer:new(color, color, color, GUI:ColorConvertFloat4ToU32(0, 0, 1, 1), 0)
                          :addRect(point.x, point.y, point.z, 60, 6, dir, false)
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
                    ['H2'] = { x = 80.5, z = 100 },
                    ['D4'] = { x = 119.5, z = 100 },
                }

                for i = 2, 7 do
                    local curJob = Data().Beam.Order[i]
                    local leftPlayer = curParty[Data().Beam.Order[i - 1]]
                    local rightPlayer = curParty[Data().Beam.Order[i + 1]]
                    beamWay[curJob] = { x = (leftPlayer.pos.x + rightPlayer.pos.x) / 2, z = 100 }
                end
                MG.FrameMultiD(beamWay)
            end
        end
        if TimeSince(Data().Fire1.Time) > 1500 and MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P1BeamEnd')
            Data().Beam.Time = Now()
        end
    end

    -- 记录激光射了谁
    if DM.InState('P1BeamEnd') then
        -- 计算被射了的人
        if Data().Beam.Order ~= nil and Data().Beam.Shoot == nil then
            local shoot = {}
            for _, job in pairs(Data().Beam.Order) do
                local member = MG.Party[job]
                local debuff = TensorCore.getBuff(member.id, 2941)
                if debuff ~= nil then
                    table.insert(shoot, job)
                end
            end
            d(Data().Beam.Shoot)
            if table.size(shoot == 4) then
                Data().Beam.Shoot = shoot
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
            if table.size(Data().Beam.Shoot) >= 4
                    and table.size(Data().Tower.Aoe) >= 4
            then
                if Cfg().guide then
                    -- 计算踩塔指路位置
                    if Data().Tower.GuideData == nil then
                        Data().Tower.GuideData = {}
                        for _, job in pairs(Data().Beam.Order) do
                            if table.contains(Data().Beam.Shoot, job) then
                                local curIdx = MG.IndexOf(Data().Beam.Shoot, job)
                                local tower = Data().Tower.Aoe[curIdx]
                                Data().Tower.GuideData[job] = { x = tower.x, z = tower.z + 5 }
                            else
                                local curIdx = MG.IndexOf(Data().Beam.UnShoot, job)
                                local tower = Data().Tower.Aoe[curIdx]
                                Data().Tower.GuideData[job] = { x = tower.x, z = tower.z }
                            end
                        end
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

    -- 传毒开始
    if DM.InState('P1BuffTurn1') then
        -- 如果有任意一人毒buff超过50秒，判定为传毒完成
        if MG.IsAnyMemberHasBuff(5078, 50) then
            DM.ChangeState('P1Line2Start')
        else
            local thGroup = { 'MT', 'ST', 'H1', 'H2' }
            if Data().Turn1.BuffJobs == nil then
                local buffJob = {}
                for job, member in pairs(MG.Party) do
                    if TensorCore.hasBuff(member.id, 5078) then
                        table.insert(buffJob, job)
                    end
                end
                if table.size(buffJob) >= 2 then
                    Data().Turn1.BuffJobs = buffJob
                    if table.contains(buffJob, MG.SelfPos) then
                        Data().Turn1.SelfGroupTurner = MG.SelfPos
                    else
                        for _, job in pairs(buffJob) do
                            if (table.contains(thGroup, job) and table.contains(thGroup, MG.SelfPos))
                                    or (not table.contains(thGroup, job) and not table.contains(thGroup, MG.SelfPos))
                            then
                                Data().Turn1.SelfGroupTurner = job
                                break
                            end
                        end
                    end
                end
            else
                if Cfg().guide then
                    local guideData = {}
                    local dpsJob, thJob
                    -- 填入
                    for _, job in pairs(Data().Turn1.BuffJobs) do
                        if table.contains(thGroup, job) then
                            thJob = job
                            guideData[job] = { x = 91, y = 0, z = 100 }
                        else
                            dpsJob = job
                            guideData[job] = { x = 109, y = 0, z = 100 }
                        end
                    end
                    local dpsObj = TensorCore.mGetEntity(MG.Party[dpsJob].id)
                    local thObj = TensorCore.mGetEntity(MG.Party[thJob].id)
                    local disDps = TensorCore.getDistance2d(dpsObj.pos, guideData[dpsJob])
                    local disTh = TensorCore.getDistance2d(thObj.pos, guideData[thJob])
                    for job, member in pairs(MG.Party) do
                        if table.contains(thGroup, job) then
                            if job ~= thJob then
                                if disTh < 2 then
                                    guideData[job] = { x = thObj.pos.x + 1, y = thObj.pos.y, z = thObj.pos.z }
                                else
                                    guideData[job] = { x = 91.5, y = 0, z = 100 }
                                end
                            end
                        else
                            if job ~= dpsJob then
                                if disDps < 2 then
                                    guideData[job] = { x = dpsObj.pos.x - 1, y = dpsObj.pos.y, z = dpsObj.pos.z }
                                else
                                    guideData[job] = { x = 108.5, y = 0, z = 100 }
                                end
                            end
                        end
                    end
                    MG.FrameMultiD(guideData)
                end
            end
        end
    end

    if DM.InState('P1Line2_1') then
        if Cfg().draw then
            for _, member in pairs(MG.Party) do
                local hasLine, tether = MG.HasLine(member.id, 45)
                if hasLine then
                    local from = TensorCore.mGetEntity(tether.partnerid)
                    if from and from.pos.x < 100 then
                        local drawer = MG.CreateDrawer(0.5, 0.5, 0.5)
                    end
                end
            end
        end
    end

    drawBuffKick()
    drawSushi()
    drawLink()
end

return Dmu_P1