-- MuAiCore 队伍排序：保留已保存的身份与职能位置，缺员替补仅重排空缺位置。
return function(R)
    local slots={"T1","T2","H1","H2","M1","M2","R1","R2"}
    local wants={T1="tank",T2="tank",H1="healer",H2="healer",M1="melee",M2="melee",R1="physical",R2="caster"}
    local dpsSlot={M1=true,M2=true,R1=true,R2=true}
    local orders={conga=slots,supports={"T1","T2","H1","H2"},dps={"M1","M2","R1","R2"},g1={"T1","H1","M1","R1"},g2={"T2","H2","M2","R2"}}
    local ranks={}; for rank,id in ipairs({19,1,21,3,32,37,24,6,28,33,40,20,2,22,4,30,29,34,39,41,43,23,5,31,38,25,7,27,26,35,42,36}) do ranks[id]=rank end
    local function class(id)
        if R.tankJobs[id] then return "tank" end
        if R.healJobs[id] then return "healer" end
        if R.meleeJobs[id] then return "melee" end
        if R.cdpsJobs[id] then return "caster" end
        return "physical"
    end
    local function sortedMembers(party)
        local result={};for _,e in ipairs(party) do result[#result+1]=e end
        table.sort(result,function(a,b)
            local x,y=ranks[a.job] or 999,ranks[b.job] or 999
            return x==y and a.guid<b.guid or x<y
        end)
        return result
    end
    local function fill(members,party)
        local used={};for _,slot in pairs(members) do used[slot]=true end
        for pass=1,3 do
            for _,slot in ipairs(slots) do
                if not used[slot] then
                    for _,e in ipairs(party) do
                        if not members[e.guid] and (pass==3 or pass==2 and dpsSlot[slot] and R.isDPS(e.job) or pass==1 and class(e.job)==wants[slot]) then
                            members[e.guid]=slot;used[slot]=true;break
                        end
                    end
                end
            end
        end
    end
    local function resolve()
        local function invalidate()
            R.Roster._key,R.Roster._record,R.Roster._bySlot=nil,nil,{}
            return nil,R.Roster._bySlot
        end
        if R.Settings.Roster.enabled==false then return invalidate() end
        local t=Now()
        if R.Roster._next and t<R.Roster._next then return R.Roster._record,R.Roster._bySlot or {} end
        R.Roster._next=t+500
        local party=R.partyInfo();if #party~=8 then return invalidate() end
        local byGuid,key={},{}
        for _,e in ipairs(party) do
            if type(e.guid)~="string" or e.guid=="" then return invalidate() end
            byGuid[e.guid]=e;key[#key+1]=e.guid..":"..e.job
        end
        table.sort(key);key=table.concat(key,"|")
        if R.Roster._key==key then return R.Roster._record,R.Roster._bySlot end
        local record,bestMissing,bestUsed
        for _,candidate in ipairs(R.RosterProfiles.rosters or {}) do
            local size,missing=0,0
            for guid in pairs(candidate.members or {}) do size=size+1;if not byGuid[guid] then missing=missing+1 end end
            if size==8 and missing<=(R.Settings.Roster.nearMatchTolerance or 1) and (not bestMissing or missing<bestMissing or missing==bestMissing and (candidate.lastUsed or 0)>(bestUsed or 0)) then
                record,bestMissing,bestUsed=candidate,missing,candidate.lastUsed
            end
            if record and bestMissing==0 then break end
        end
        local members={};local used={}
        if record then
            for guid,slot in pairs(record.members or {}) do
                local e=byGuid[guid]
                if e and wants[slot] and not used[slot] and (class(e.job)==wants[slot] or dpsSlot[slot] and R.isDPS(e.job)) then members[guid]=slot;used[slot]=true end
            end
        end
        fill(members,sortedMembers(party))
        local bySlot={};for guid,slot in pairs(members) do bySlot[slot]=byGuid[guid] end
        local resolved={members=members,confirmed=record and record.confirmed or false,jobs={},names={}}
        for _,e in ipairs(party) do resolved.jobs[e.guid],resolved.names[e.guid]=e.job,e.name end
        R.Roster._key,R.Roster._record,R.Roster._bySlot=key,resolved,bySlot
        return resolved,bySlot
    end
    function R.Roster.current() return (resolve()) end
    function R.Roster.order(order)
        local _,bySlot=resolve();local result={}
        local list=type(order)=="table" and order or orders[order]
        if not list then list={};for slot in tostring(order):gmatch("[THMR][12]") do list[#list+1]=slot end end
        for _,slot in ipairs(list) do if bySlot[slot] then result[#result+1]=bySlot[slot] end end
        return result
    end
    function R.Roster.prio(order)
        local result={byId={},byRank={},bySlot={}}
        local _,bySlot=resolve()
        for rank,e in ipairs(R.Roster.order(order)) do result.byId[e.id]=rank;result.byRank[rank]=e.id end
        for slot,e in pairs(bySlot) do result.bySlot[slot]=result.byId[e.id] end
        return result
    end
end
