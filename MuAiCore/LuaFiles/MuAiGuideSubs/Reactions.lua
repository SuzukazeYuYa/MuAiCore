local Module = {}
-- 时间轴公共能力，由 MuAiCore 的 Update/DrawUIs 管理；不注册独立事件。

function Module.init(M)
local R = {version = "20261115.1", API = {}, Data = {}, Settings = {}, Roster = {}}
local root = M.Config.MainPath .. "\\Reactions\\"
local function report(message, data, key)
    M.Diagnostic('ERROR', 'Reactions', message, data, key)
end
local function read(path)
    local chunk, err = loadfile(path)
    if not chunk then return nil, err end
    local ok, value = pcall(chunk)
    if not ok then return nil, value end
    return value
end
local function mergeDefaults(value, defaults)
    for key, default in pairs(defaults) do
        if value[key] == nil then
            if type(default) == 'table' then value[key] = {}; mergeDefaults(value[key], default)
            else value[key] = default end
        elseif type(default) == 'table' and type(value[key]) == 'table' then
            mergeDefaults(value[key], default)
        end
    end
end
local defaults = read(MuAiGuideRoot .. 'MuAiGuideSubs\\ReactionsDefaults.lua')
assert(type(defaults) == 'table', 'ReactionsDefaults 加载失败')
local function loadSettings()
    local saved, err
    if FileExists(root .. 'Settings.lua') then
        saved, err = read(root .. 'Settings.lua')
        if type(saved) ~= 'table' or type(saved.Settings) ~= 'table'
                or saved.Data ~= nil and type(saved.Data) ~= 'table'
                or saved.RosterProfiles ~= nil and type(saved.RosterProfiles) ~= 'table' then
            report('设置读取失败，保留当前状态并等待文件恢复', {error=err, path=root..'Settings.lua'}, 'settings_read')
            return false
        end
    else saved = {Settings={}, Data={}, RosterProfiles={rosters={}}} end
    mergeDefaults(saved.Settings, defaults)
    for key, value in pairs(defaults) do
        if type(saved.Settings[key]) ~= type(value) then
            report('设置类型无效，等待修复', {key=key}, 'settings_type')
            return false
        end
    end
    R.Settings, R.Data, R.RosterProfiles = saved.Settings, saved.Data or {}, saved.RosterProfiles or {rosters={}}
    R.Data.timedWorldTextDraws, R.Data.Toggle = {}, {}
    return true
end
R.configReady = loadSettings()
if not R.configReady then
    mergeDefaults(R.Settings, defaults)
    R.Data.timedWorldTextDraws, R.Data.Toggle = {}, {}
    R.RosterProfiles = {rosters={}}
end
R.COLOR_WHITE = 4294967295

function R.log(message, level)
    level=level or 1
    local timer=TensorReactions_CurrentTimer
    if level==2 and (R.Settings.DebugLevel or 1)<2 then return end
    if level==4 then
        if R.Data.lastStr==message and R.Data.lastStrTimer and Now()-R.Data.lastStrTimer<2500 then return end
        R.Data.lastStr,R.Data.lastStrTimer=message,Now()
    end
    if level==5 then
        if timer==nil then return end
        local line=string.format("[MuAiCore.Reactions]: [%.3f] %s\n",timer,tostring(message))
        d(line);TensorCore.timelineLogToFile(line);return
    end
    local suffix=timer and timer>0 and string.format(" - %.2f",timer) or ""
    d("[MuAiCore.Reactions] " .. tostring(message)..suffix)
end

local jobCodes = {[1]="gld",[2]="pgl",[3]="mrd",[4]="lnc",[5]="arc",[6]="cnj",[7]="thm",[19]="pld",[20]="mnk",[21]="war",[22]="drg",[23]="brd",[24]="whm",[25]="blm",[26]="acn",[27]="smn",[28]="sch",[29]="rog",[30]="nin",[31]="mch",[32]="drk",[33]="ast",[34]="sam",[35]="rdm",[36]="blu",[37]="gnb",[38]="dnc",[39]="rpr",[40]="sge",[41]="vpr",[42]="pct",[43]="bst"}
R.jobs = jobCodes
local names = {[1]="Gladiator",[2]="Pugilist",[3]="Marauder",[4]="Lancer",[5]="Archer",[6]="Conjurer",[7]="Thaumaturge",[19]="Paladin",[20]="Monk",[21]="Warrior",[22]="Dragoon",[23]="Bard",[24]="WhiteMage",[25]="BlackMage",[26]="Arcanist",[27]="Summoner",[28]="Scholar",[29]="Rogue",[30]="Ninja",[31]="Machinist",[32]="DarkKnight",[33]="Astrologian",[34]="Samurai",[35]="RedMage",[36]="BlueMage",[37]="Gunbreaker",[38]="Dancer",[39]="Reaper",[40]="Sage",[41]="Viper",[42]="Pictomancer",[43]="Beastmaster"}
local byName = {}
for id, code in pairs(jobCodes) do byName[code], byName[names[id]], byName[names[id]:lower()] = id, id, id end
local function group(ids)
    local result = {}; for _, id in ipairs(ids) do result[id] = true end; return result
end
R.tankJobs = group({1,3,19,21,32,37})
R.healJobs = group({6,24,28,33,40})
R.meleeJobs = group({2,4,20,22,29,30,34,39,41,43})
R.cdpsJobs = group({7,25,26,27,35,36,42})
R.rdpsJobs = group({5,23,31,38})
R.dpsJobs, R.supportJobs, R.rangedJobs = {}, {}, {}
for id in pairs(jobCodes) do
    if R.tankJobs[id] or R.healJobs[id] then R.supportJobs[id] = true
    elseif R.meleeJobs[id] or R.cdpsJobs[id] or R.rdpsJobs[id] then R.dpsJobs[id] = true end
    if R.cdpsJobs[id] or R.rdpsJobs[id] then R.rangedJobs[id] = true end
end
local function job(value)
    if value == nil then local p = TensorCore.mGetPlayer(); return p and p.job end
    if type(value) == "table" then return tonumber(value.job) end
    if type(value) == "string" then return byName[value] or byName[value:lower()] or tonumber(value) end
    if type(value) == "number" then
        if value <= 100 then return value end
        local e = TensorCore.mGetEntity(value); return e and e.job
    end
end
for name, set in pairs({isTank=R.tankJobs,isDPS=R.dpsJobs,isHealer=R.healJobs,isSupport=R.supportJobs,isMelee=R.meleeJobs,isCaster=R.cdpsJobs,isRanged=R.rdpsJobs,isRangedDPS=R.rangedJobs}) do
    local members = set; R[name] = function(value) return members[job(value)] == true end
end
function R.getJobAttackRange(value)
    local id = job(value); return (R.rangedJobs[id] or R.healJobs[id]) and 25 or 3
end
function R.cTimeSince(time, duration) return time ~= nil and Now() - time >= duration end
function R.Shotcall(text, tts, seconds, important, volume)
    local s, t = R.Settings, Now()
    if not s.Shotcaller or text == nil then return end
    if R.Data.lastShotcall == text and R.Data.lastShotcallTimer and t - R.Data.lastShotcallTimer < 2500 then return end
    R.Data.lastShotcall, R.Data.lastShotcallTimer = text, t
    local color = important and s.ShotcallerImportantColor or s.ShotcallerColor
    local duration = type(seconds)=="number" and seconds>=0 and seconds<=100 and seconds*1000 or 5000
    TensorCore.addAlertText(duration, tostring(text), s.ShotcallerTextScale, color, s.ShotcallerTTS and tts or false, volume or s.ShotcallerVolume*100)
end

-- 按需获取当前队伍，使用实体原值；同距时按实体 ID 排序。
local function entity(value)
    return type(value)=="table" and value or value and TensorCore.mGetEntity(value)
end
function R.API.getAgnosticPartyList(kind)
    kind = kind or "Party"
    local roles = {Tank=R.tankJobs,Tanks=R.tankJobs,Healer=R.healJobs,Healers=R.healJobs,DPS=R.dpsJobs,Support=R.supportJobs,Melee=R.meleeJobs,Ranged=R.rangedJobs,["Melee DPS"]=R.meleeJobs,["Ranged DPS"]=R.rangedJobs,["Ranged Physical DPS"]=R.rdpsJobs,["Ranged Caster DPS"]=R.cdpsJobs}
    local set = roles[kind]
    if kind ~= "Party" and not set then error("[MuAiCore.Reactions] 未知队伍分组: " .. tostring(kind)) end
    local result = {}
    for _, value in ipairs(R.partyInfo()) do
        local e = TensorCore.mGetEntity(value.id)
        if not e and value.id==R.playerID() then e=TensorCore.mGetPlayer() end
        if e and e.id and e.job and type(e.name)=="string" and e.name~="" and (not set or set[e.job]) then result[e.id] = e end
    end
    return result
end
function R.partyInfo()
    if Duty:GetActiveDutyInfo()==nil and not InInstance() then return {} end
    local members,guids,identities={},{},{}
    local function add(e)
        if type(e)=="number" then e=TensorCore.mGetEntity(e) end
        if not e or not e.id or not e.job or type(e.name)~="string" or e.name=="" or e.chartype~=4 or members[e.id] then return end
        local identity=e.name.."|"..tostring(e.homeworld)
        if e.guid and guids[e.guid] or identities[identity] then return end
        members[e.id]=e;identities[identity]=true;if e.guid then guids[e.guid]=true end
    end
    for _,e in pairs(TensorCore.getEntityGroupList("Party",{noAliveCheck=true}) or {}) do add(e) end
    local fallback=EntityList and EntityList.myparty
    if not fallback or next(fallback)==nil then fallback=EntityList and EntityList.crossworldparty end
    for _,e in pairs(fallback or {}) do add(e) end
    add(TensorCore.mGetPlayer())
    local result={};for _,e in pairs(members) do result[#result+1]=e end
    return result
end
function R.playerID() local p=TensorCore.mGetPlayer(); return p and p.id end
local function compareDistance(a,b)
    return a.distance==b.distance and a.id<b.id or a.distance<b.distance
end
local function distances(pos, party)
    if not pos or pos.x==nil or pos.z==nil then return nil end
    local result = {}
    for _, value in pairs(party or TensorCore.getEntityGroupList("Party") or {}) do
        local e = entity(value)
        if e and e.pos then result[#result+1]={id=e.id, distance=TensorCore.getDistance2d(e.pos,pos)} end
    end
    table.sort(result,compareDistance)
    return result
end
local function nearest(pos, count, party, farthest, exclude)
    local rows = distances(pos,party) or {}; local length, result = 0, {}
    -- 排序结束后原地收紧为 ID 列表，保持原排序、排除和数量边界。
    for _, row in ipairs(rows) do
        if row.id~=exclude then length=length+1; rows[length]=row.id end
    end
    local first=farthest and math.max(1,length-math.max(0,count)+1) or 1
    local last=farthest and length or math.min(length,count)
    for i=first,last do result[#result+1]=rows[i] end
    return result
end
function R.API.getNearestNumToPos(pos,count,party) return nearest(pos,count,party) end
function R.API.IsInRange(action, target)
    if action==nil then action=(R.isTank() or R.isMelee()) and 3554 or (R.isRangedDPS() or R.isHealer()) and 25859 or nil end
    if action==nil then return false end
    if type(action)=="number" then action=ActionList:Get(1,action) end
    if not action then return false end
    local p=TensorCore.mGetPlayer(); local e=entity(target or p and p.targetid)
    if not e then return false end
    if action.IsInRange then return action:IsInRange(e.id)==true end
    return p and p.pos and e.pos and action.range and TensorCore.getDistance2d(p.pos,e.pos)<=action.range+(e.hitradius or 0) or false
end
local function normalize(h) return (h+math.pi)%(2*math.pi)-math.pi end
function R.API.isInsideCone(pos,origin,heading,angle,range)
    if range and TensorCore.getDistance2d(origin,pos)>range then return false end
    return math.abs(normalize(TensorCore.restoreHeading(TensorCore.getHeadingToTarget(origin,pos))-TensorCore.restoreHeading(heading)))<=angle/2
end
function R.API.findSegmentCircleIntersections(cx,cz,r,x1,z1,x2,z2)
    local dx,dz=x2-x1,z2-z1; local a=dx*dx+dz*dz
    if a==0 then return end
    local b=2*(dx*(x1-cx)+dz*(z1-cz)); local c=(x1-cx)^2+(z1-cz)^2-r*r
    local discriminant=b*b-4*a*c; if discriminant<0 then return end
    local first=(-b-math.sqrt(discriminant))/(2*a); local second=(-b+math.sqrt(discriminant))/(2*a)
    local ax,az,bx,bz
    if first>=0 and first<=1 then ax,az=x1+first*dx,z1+first*dz end
    if discriminant>0 and second>=0 and second<=1 then bx,bz=x1+second*dx,z1+second*dz end
    if not ax then return bx,bz end
    return ax,az,bx,bz
end
-- 文本和 ACR 延时任务只在存在待处理条目时工作；实体文本逐帧跟随。
local sequence=0
local function textId() sequence=sequence+1; return "MuAiText-"..tostring(Now()).."-"..sequence end
function R.resetTransient(clearMarkers)
    R.Data.timedWorldTextDraws,R.Data.Toggle={},{}
    R.Roster._key,R.Roster._record,R.Roster._bySlot,R.Roster._next=nil,nil,nil,nil
    if clearMarkers and R.Data.autoMarkersSet then R.Data.clearMarkers=true
    else R.Data.autoMarkersSet,R.Data.clearMarkers,R.wasInCombat=nil,nil,nil end
    R.ownerMapID=nil
end
function R.noteMap()
    local p=TensorCore.mGetPlayer()
    if not p then return end
    if R.ownerMapID and R.ownerMapID~=p.localmapid then R.resetTransient(false) end
    R.ownerMapID=p.localmapid
end
function R.addTimedWorldText(timeout,text,pos,color,bg,scale,delay)
    if not timeout or text==nil or not pos or not pos.x then return nil,nil end
    R.noteMap()
    local entry={uuid=textId(),start=Now()+(delay or 0),timer=timeout,str=text,pos=pos,color=color or R.COLOR_WHITE,bg=bg,sizeMultiplier=scale}
    R.Data.timedWorldTextDraws[sequence]=entry;return entry.uuid,entry
end
function R.addTimedWorldTextOnEnt(timeout,text,id,color,bg,scale,height,delay)
    local e=entity(id); if not e or not e.pos then return nil,nil end
    local uuid,entry=R.addTimedWorldText(timeout,text,{x=e.pos.x,y=e.pos.y+(height or .1),z=e.pos.z},color,bg,scale,delay)
    if entry then entry.entID,entry.heightAddition=id,height or .1 end
    return uuid,entry
end
function R.removeTimedWorldText(id)
    for key,entry in pairs(R.Data.timedWorldTextDraws) do
        if entry.uuid==id then R.Data.timedWorldTextDraws[key]=nil;return true end
    end
    return false
end
local function drawText(entry,text)
    local p=TensorCore.mGetPlayer(); if not p or not p.camera then return end
    if entry.entID then
        local e=entity(entry.entID);if not e or not e.pos then return end
        entry.pos={x=e.pos.x,y=e.pos.y+(entry.heightAddition or 0),z=e.pos.z}
    end
    local x,y=RenderManager:WorldToScreen(entry.pos,true);if not x or not y then return end
    local distance=TensorCore.getDistance3d(p.camera,entry.pos);if distance>=200 then return end
    local scale=(entry.sizeMultiplier or 1)*math.min(1,25/math.max(distance,.001))
    local ui=GUI.GetUIScale and GUI:GetUIScale() or 1
    if type(ui)~="number" or ui<=0 then ui=1 end
    local flags=GUI.WindowFlags_NoInputs+GUI.WindowFlags_NoSavedSettings+GUI.WindowFlags_NoBringToFrontOnFocus+GUI.WindowFlags_NoTitleBar+GUI.WindowFlags_AlwaysAutoResize+GUI.WindowFlags_NoScrollbar+GUI.WindowFlags_NoCollapse+GUI.WindowFlags_NoFocusOnAppearing
    GUI:PushStyleColor(GUI.Col_WindowBg,0,0,0,entry.bg and .6 or 0)
    local visible=GUI:Begin("MuAiWorld##"..entry.uuid,true,flags)
    if visible then
        GUI:SetWindowFontScale(scale)
        local width,height=GUI:CalcTextSize(text)
        local cx,cy=GUI:GetCursorPos()
        GUI:SetWindowPos(x/ui-cx-width/2,y/ui-cy-height/2,GUI.SetCond_Always)
        local color=entry.color or R.COLOR_WHITE
        local red,green,blue,alpha
        if type(color)=="table" then red,green,blue,alpha=color.r or 1,color.g or 1,color.b or 1,color.a or 1
        else red,green,blue,alpha=GUI:ColorConvertU32ToFloat4(color) end
        GUI:TextColored(red,green,blue,alpha,text)
    end
    GUI:End();GUI:PopStyleColor()
end
function R.draw()
    if next(R.Data.timedWorldTextDraws)==nil then return end
    R.noteMap()
    local t=Now()
    for key,entry in pairs(R.Data.timedWorldTextDraws) do
        if t>=entry.start+entry.timer then R.Data.timedWorldTextDraws[key]=nil
        elseif t>=entry.start then drawText(entry,entry.str) end
    end
end
function R.tick()
    if #R.Data.Toggle>0 or R.Data.autoMarkersSet or R.Data.clearMarkers then R.noteMap() end
    if #R.Data.Toggle>0 then
        local pending={};local t=Now()
        for _,entry in ipairs(R.Data.Toggle) do
            if t>=entry.TimerStart+entry.Timer then R.Toggle(entry.Type,entry.Boolean) else pending[#pending+1]=entry end
        end
        R.Data.Toggle=pending
    end
    if R.Data.clearMarkers then
        local marked=false
        for _,e in ipairs(R.partyInfo()) do
            if e.marker and e.marker>0 then ActionList:Get(12,e.marker):Cast(e.id);marked=true end
        end
        if not marked then R.Data.clearMarkers=nil;R.Data.autoMarkersSet=nil end
    end
    if R.Data.autoMarkersSet then
        local p=TensorCore.mGetPlayer()
        local inCombat=p and p.incombat==true
        if R.wasInCombat and not inCombat then R.Data.clearMarkers=true end
        R.wasInCombat=inCombat
    else R.wasInCombat=nil end
end


local function missingToggle()
    report('职业适配尚不可用，本次开关未执行', {path=root..'Toggles.lua'}, 'toggle_unavailable')
    return false
end
R.Toggle = missingToggle
local function loadToggles()
    local installer, err = read(root .. 'Toggles.lua')
    if type(installer) ~= 'function' then
        report('职业适配读取失败；其他公共能力继续可用', {error=err, path=root..'Toggles.lua'}, 'toggle_read')
        return false
    end
    local ok, result = pcall(installer, R)
    if not ok or type(R.Toggle) ~= 'function' or R.Toggle == missingToggle then
        R.Toggle = missingToggle
        report('职业适配初始化失败，等待文件恢复', {error=result}, 'toggle_init')
        return false
    end
    return true
end
R.togglesReady = loadToggles()
local roster = read(MuAiGuideRoot .. 'MuAiGuideSubs\\ReactionsRoster.lua')
assert(type(roster) == 'function', 'ReactionsRoster 加载失败')
roster(R)
R.ready = R.configReady

local retryAt = 0
function R.update()
    if (not R.configReady or not R.togglesReady) and Now() >= retryAt then
        retryAt = Now() + 5000
        if not R.configReady then R.configReady = loadSettings(); R.ready = R.configReady end
        if not R.togglesReady then R.togglesReady = loadToggles() end
    end
    if R.ready then
        M.DiagnosticCall('Reactions', '更新时间轴公共任务', R.tick)
    end
end
local draw = R.draw
R.draw = function()
    if R.ready then M.DiagnosticCall('Reactions', '绘制时间轴世界文字', draw) end
end

-- 新 MuAiGuide 成功激活后再接管状态；失败候选不会修改旧 owner。
function R.adopt(previous)
    if type(previous) ~= 'table' or not previous.ready then return end
    R.Settings, R.Data, R.RosterProfiles = previous.Settings, previous.Data, previous.RosterProfiles
    R.ownerMapID, R.wasInCombat = previous.ownerMapID, previous.wasInCombat
    for key in pairs(R.Data.timedWorldTextDraws) do
        if type(key) == 'number' then sequence = math.max(sequence, key) end
    end
    R.configReady, R.ready = true, true
    R.Roster._key, R.Roster._record, R.Roster._bySlot, R.Roster._next = nil, nil, nil, nil
    -- 旧闭包可能仍由宿主持有；只留空队列，不能继续处理已转交的动作。
    previous.Data = {timedWorldTextDraws={}, Toggle={}}
    previous.ownerMapID, previous.wasInCombat, previous.ready = nil, nil, false
end
M.Reactions = R
return R
end
return Module
