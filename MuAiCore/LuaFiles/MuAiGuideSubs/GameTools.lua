local GameTools = {}
---@param M MuAiGuide
GameTools.init = function(M)
    local TankJobs = { 19, 21, 32, 37 }
    local HealerJobs = { 24, 28, 33, 40 }
    local MeleeJob = { 20, 22, 30, 34, 39, 41 }
    local RangeJob = { 31, 23, 38 }
    local MagicJob = { 25, 27, 35, 42 }
    M.JobIds = {
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
    
    local fullJobName = {
        "骑士", "战士", "暗黑骑士", "绝枪战士",
        "白魔法师", "占星术士", "贤者", "学者",
        "武士", "武僧", "龙骑士", "忍者", "钐镰客", "蝰蛇剑士",
        "机工士", "诗人", "舞者",
        "召唤师", "绘灵法师", "黑魔法师", "赤魔法师"
    }

    M.JobPosName = { "MT", "ST", "H1", "H2", "D1", "D2", "D3", "D4" }

    ---@class MuAiGuide.HeadMark 标记枚举
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
                or not table.contains(M.JobIds, entity.job)
        then
            return false
        end
        return true
    end

    --- 获取职业名称
    --- @param job number 职业ID
    M.GetJobNameById = function(job, jobName)
        jobName = jobName or JobName
        for i = 1, #M.JobIds, 1 do
            if M.JobIds[i] == job then
                return jobName[i]
            end
        end
    end
    
    
    M.GetJobFullNameById = function(job)
        return M.GetJobNameById(job, fullJobName)
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
        elseif #curPt == 3 or #curPt == 7 then
            local hasSelf = false
            for _, ent in pairs(curPt) do
                if ent.id == Player.id then
                    hasSelf = true
                    break
                end
            end
            if not hasSelf then
                table.insert(curPt, Player)
            end
        end
        for _, ent in pairs(curPt) do
            if M.IsPlayer(ent)
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
        local jobOrder = M.Config.Main.JobOrder
        local members = M.GetPartyPlayers()
        table.sort(members, function(p1, p2)
            return M.IndexOf(jobOrder, p1.job) < M.IndexOf(jobOrder, p2.job)
        end)
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
                    if M.IsMelee(members[i].job) or M.IsMagic(members[i].job) then
                        -- 近法优先分配近战
                        if M.Party.D1 == nil then
                            M.Party.D1 = members[i]
                        elseif M.Party.D2 == nil then
                            M.Party.D2 = members[i]
                        end
                    elseif M.IsRange(members[i].job) then
                        --远敏优先分配远程
                        if M.Party.D2 == nil then
                            M.Party.D2 = members[i]
                        elseif M.Party.D1 == nil then
                            M.Party.D1 = members[i]
                        end
                    end
                end
            end
            M.GetSelfPos()
            return
        end
        if members == nil or (table.size(members) < 8 and table.size(members) ~= 4) then
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

    --- 计算当前小队成员数量（可靠）
    M.GetPartyCnt = function()
        if M.Party == nil then
            return 0
        end
        local count = 0
        for _, key in ipairs(M.JobPosName) do
            if M.Party[key] ~= nil then
                count = count + 1
            end
        end
        return count
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
            return TensorCore.mGetPlayer()
        end
        if M.Develop.JobView then
            local testPlayer = M.Party[M.Develop.ViewedJob]
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

    ---查询给定实体或者实体id对应的实体是否有执行类型的线
    ---@param  entityID number|table
    ---@return boolean 是否存在
    ---@return TetherInfo 存在情况下，返回线对象
    M.HasLine = function(entityID, lineType)
        local tethers = Argus.getTethersOnEnt(entityID)
        if tethers == nil or table.size(tethers) == 0 then
            return false
        end
        for _, tether in pairs(tethers) do
            if tether.type == lineType then
                return true, tether
            end
        end
        return false
    end

    --- 标记给定实体
    ---@param marker MuAiGuide.HeadMark 标记类型（枚举）
    ---@param entityId number 标记对象
    M.MarkParty = function(marker, entityId)
        ActionList:Get(12, marker):Cast(entityId)
    end

    --- 判断是否有成员有指定buff
    ---@param buffId number buffId
    ---@param time number buffTime
    ---@return boolean 是否有成员有指定buff
    M.IsAnyMemberHasBuff = function(buffId, time)
        for _, player in pairs(M.Party) do
            local debuff = TensorCore.getBuff(player.id, buffId)
            if debuff ~= nil then
                if time == nil then
                    return true
                else
                    return debuff.duration > time
                end
            end
        end
        return false
    end

    --- 当前队伍遍历执行
    --- @param action function(job,curMember)
    M.OnCurrentPartyDo = function(action)
        for job, oldMember in pairs(M.Party) do
            local curMember = TensorCore.mGetEntity(oldMember.id)
            if curMember ~= nil then
                local breakFlag = action(job, curMember)
                if breakFlag then
                    break
                end
            end
        end
    end
    --- 获取刷新所有数据后的小队列表
    --- @param divTable table 可空，非空时表示拆分依据
    M.getCurParty = function(divTable)
        if divTable == nil then
            local member = {}
            for job, oldMember in pairs(M.Party) do
                member[job] = TensorCore.mGetEntity(oldMember.id)
            end
            return member
        end
        local include = {}
        local out = {}
        for job, oldMember in pairs(M.Party) do
            local member = TensorCore.mGetEntity(oldMember.id)
            if table.contains(divTable, job) then
                include[job] = member
            else
                out[job] = member
            end
        end
        return include, out
    end


end
return GameTools