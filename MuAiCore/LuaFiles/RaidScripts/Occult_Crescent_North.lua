local G = {}
G.MapId = 1346
G.NameCN = '新月岛·北岛'

local function currentFolder()
    local source = type(debug) == 'table'
            and type(debug.getinfo) == 'function'
            and debug.getinfo(1, 'S').source or nil
    local path = type(source) == 'string' and source:match('^@(.*)$') or nil
    return type(path) == 'string' and path:match('^(.*[/\\])') or nil
end

local function loadOccultCommon()
    if type(FileLoad) == 'function' and type(MuAiGuideRoot) == 'string' then
        rawset(_G, 'MuAiOccultCrescentCommon', nil)
        FileLoad(MuAiGuideRoot
                .. 'RaidScripts\\Occult_Crescent_Subs\\Common.lua')
        local module = rawget(_G, 'MuAiOccultCrescentCommon')
        if type(module) == 'table' then
            return module
        end
    end
    local folder = currentFolder()
    if folder == nil or type(loadfile) ~= 'function' then
        return nil
    end
    local separator = folder:find('\\', 1, true) and '\\' or '/'
    local loader = loadfile(folder .. 'Occult_Crescent_Subs'
            .. separator .. 'Common.lua')
    return type(loader) == 'function' and loader() or nil
end

local Common = assert(loadOccultCommon(),
        'failed to load Occult Crescent common module')
local MAP_ID = G.MapId

local Context = {
    Common = Common,
    MapID = MAP_ID,
}

Context.nowMs = function()
    return type(Now) == 'function' and Now() or 0
end

Context.finite = Common.finite

Context.currentMapIsNorth = function()
    return type(Player) == 'table' and Player.localmapid == MAP_ID
end

Context.reliablePosition = function(pos, requireHeading)
    local copy = Common.copyPosition(pos, true)
    if copy == nil or (requireHeading and not Common.finite(pos.h)) then
        return nil
    end
    if requireHeading then
        copy.h = pos.h
    end
    return copy
end

Context.resolveEntity = function(entityID)
    if type(entityID) ~= 'number'
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    return type(entity) == 'table' and entity or nil
end

Context.getPlayer = function(guide)
    local player = type(guide) == 'table'
            and type(guide.GetPlayer) == 'function'
            and guide.GetPlayer() or Player
    if type(player) ~= 'table'
            or Context.reliablePosition(player.pos, false) == nil
    then
        return nil
    end
    return player
end

local function loadNorthModule(name)
    local globalName = 'MuAiOccultCrescentNorth' .. name
    local module = nil
    if type(FileLoad) == 'function' and type(MuAiGuideRoot) == 'string' then
        rawset(_G, globalName, nil)
        FileLoad(MuAiGuideRoot
                .. 'RaidScripts\\Occult_Crescent_North_Subs\\'
                .. name .. '.lua')
        module = rawget(_G, globalName)
    else
        local folder = currentFolder()
        if folder ~= nil and type(loadfile) == 'function' then
            local separator = folder:find('\\', 1, true) and '\\' or '/'
            local loader = loadfile(folder .. 'Occult_Crescent_North_Subs'
                    .. separator .. name .. '.lua')
            module = type(loader) == 'function' and loader() or nil
        end
    end
    assert(type(module) == 'table' and type(module.Create) == 'function',
            'failed to load North Island module: ' .. tostring(name))
    local feature = module.Create(Context)
    assert(type(feature) == 'table',
            'failed to create North Island module: ' .. tostring(name))
    return feature
end

local NorthReferenceDrawings = loadNorthModule('NorthReferenceDrawings')
local AlabasterBlade = loadNorthModule('AlabasterBlade')
local MagiNecromancer = loadNorthModule('MagiNecromancer')
local LeaderChimera = loadNorthModule('LeaderChimera')
local MagiHydra = loadNorthModule('MagiHydra')
local Iambe = loadNorthModule('Iambe')
local KidnapDemon = loadNorthModule('KidnapDemon')
local ShapeshiftingMage = loadNorthModule('ShapeshiftingMage')
local KelpieCaptain = loadNorthModule('KelpieCaptain')
local GemstoneBeast = loadNorthModule('GemstoneBeast')
local Pallmagia = loadNorthModule('Pallmagia')
local LittleMage = loadNorthModule('LittleMage')
local EvilSeer = loadNorthModule('EvilSeer')
local Arachne = loadNorthModule('Arachne')
local WarlikeMinotaur = loadNorthModule('WarlikeMinotaur')
local FEATURES = {
    NorthReferenceDrawings,
    AlabasterBlade,
    MagiNecromancer,
    LeaderChimera,
    MagiHydra,
    Iambe,
    KidnapDemon,
    ShapeshiftingMage,
    KelpieCaptain,
    GemstoneBeast,
    Pallmagia,
    LittleMage,
    EvilSeer,
    Arachne,
    WarlikeMinotaur,
}

local function clearAll(releaseOwnership)
    for _, feature in ipairs(FEATURES) do
        if type(feature.Clear) == 'function' then
            feature.Clear(releaseOwnership)
        end
    end
end

G.Init = function(M)
    G.MuAiGuide = M
    rawset(_G, 'MuAiGuide', M)
    if type(M) ~= 'table' then
        return
    end
    for _, feature in ipairs(FEATURES) do
        feature.Init(M)
    end
end

G.OnEnter = function()
    clearAll(false)
end
G.OnLeave = function()
    clearAll(true)
end
G.OnWipe = function()
    clearAll(false)
end

G.OnEntityChannel = function(entityID, spellID, targetID, channelTimeMax)
    if not Context.currentMapIsNorth() then
        return
    end
    local now = Context.nowMs()
    NorthReferenceDrawings.OnEntityChannel(
            entityID, spellID, targetID, channelTimeMax, now)
    AlabasterBlade.OnEntityChannel(
            entityID, spellID, channelTimeMax, now)
    MagiNecromancer.OnEntityChannel(entityID, spellID, now)
    LeaderChimera.OnEntityChannel(
            entityID, spellID, channelTimeMax, now)
    MagiHydra.OnEntityChannel(
            entityID, spellID, channelTimeMax, now)
    Iambe.OnEntityChannel(
            entityID, spellID, targetID, channelTimeMax, now)
    ShapeshiftingMage.OnEntityChannel(
            entityID, spellID, channelTimeMax, now)
    GemstoneBeast.OnEntityChannel(entityID, spellID, now)
    Pallmagia.OnEntityChannel(
            entityID, spellID, targetID, channelTimeMax, now)
    LittleMage.OnEntityChannel(entityID, spellID, now)
    EvilSeer.OnEntityChannel(entityID, spellID, channelTimeMax, now)
    Arachne.OnEntityChannel(
            entityID, spellID, targetID, channelTimeMax, now)
    WarlikeMinotaur.OnEntityChannel(
            entityID, spellID, channelTimeMax, now)
end

G.OnTetherChange = function(
        sourceEntityID,
        oldTetherID,
        oldTetherFlags,
        oldTargetID,
        newTetherID,
        newTetherFlags,
        newTargetID)
    if not Context.currentMapIsNorth() then
        return
    end
    local now = Context.nowMs()
    LittleMage.OnTetherChange(
            sourceEntityID, newTetherID, newTargetID, now)
    Pallmagia.OnTetherChange(
            sourceEntityID, newTetherID, newTargetID, now)
end

G.OnEntityCast = function(entityID, spellID, castPos)
    if not Context.currentMapIsNorth() then
        return
    end
    local now = Context.nowMs()
    NorthReferenceDrawings.OnEntityCast(entityID, spellID, castPos, now)
    AlabasterBlade.OnEntityCast(entityID, spellID, now)
    MagiNecromancer.OnEntityCast(entityID, spellID, now)
    LeaderChimera.OnEntityCast(entityID, spellID, now)
    MagiHydra.OnEntityCast(entityID, spellID, now)
    Iambe.OnEntityCast(entityID, spellID, castPos, now)
    ShapeshiftingMage.OnEntityCast(entityID, spellID, now)
    KelpieCaptain.OnEntityCast(entityID, spellID, castPos, now)
    GemstoneBeast.OnEntityCast(entityID, spellID, now)
    Pallmagia.OnEntityCast(entityID, spellID, castPos, now)
    LittleMage.OnEntityCast(entityID, spellID, now)
    EvilSeer.OnEntityCast(entityID, spellID, now)
    Arachne.OnEntityCast(entityID, spellID, castPos, now)
    WarlikeMinotaur.OnEntityCast(entityID, spellID, now)
end

G.OnAuraChange = function(
        entityID,
        oldActiveAura1,
        oldActiveAura2,
        oldPersistentAura,
        newActiveAura1,
        newActiveAura2,
        newPersistentAura)
    if not Context.currentMapIsNorth() then
        return
    end
    local now = Context.nowMs()
    AlabasterBlade.OnAuraChange(
            entityID, oldActiveAura1, newActiveAura1, now)
    Arachne.OnAuraChange(
            entityID, oldActiveAura1, newActiveAura1, now)
end

G.OnVisibilityChange = function(entityID, wasVisible, isVisible)
    if not Context.currentMapIsNorth() then
        return false
    end
    local now = Context.nowMs()
    local chimera = LeaderChimera.OnVisibilityChange(
            entityID, wasVisible, isVisible, now)
    local revealed = MagiNecromancer.OnVisibilityChange(
            entityID, wasVisible, isVisible, now)
    local flash = MagiHydra.OnVisibilityChange(
            entityID, wasVisible, isVisible, now)
    local gemstone = GemstoneBeast.OnVisibilityChange(
            entityID, wasVisible, isVisible, now)
    return chimera or revealed or flash or gemstone
end

G.OnEntityAdd = function(entityID, entityName, contentID)
    if not Context.currentMapIsNorth() then
        return false
    end
    local now = Context.nowMs()
    local chimera = LeaderChimera.OnEntityAdd(entityID, contentID, now)
    local littleMage = LittleMage.OnEntityAdd(entityID, now)
    local iambe = Iambe.OnEntityAdd(entityID, contentID, now)
    return chimera or littleMage or iambe
end

G.OnMarkerAdd = function(entityID, markerID)
    if not Context.currentMapIsNorth() then
        return false
    end
    return KidnapDemon.OnMarkerAdd(
            entityID, markerID, Context.nowMs())
end

G.OnAddGroundEffect = function(...)
    if Context.currentMapIsNorth() then
        local now = Context.nowMs()
        ShapeshiftingMage.OnAddGroundEffect({ ... }, now)
        Pallmagia.OnAddGroundEffect(...)
    end
end

G.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    if Context.currentMapIsNorth() then
        local now = Context.nowMs()
        Pallmagia.OnEventObjectScriptFunc(
                entityID, a1, a2, a3, now)
        GemstoneBeast.OnEventObjectScriptFunc(
                entityID, a1, a2, a3, now)
    end
end

G.OnAOECreate = function(aoeInfo)
    if not Context.currentMapIsNorth() then
        return
    end
    local now = Context.nowMs()
    NorthReferenceDrawings.OnAOECreate(aoeInfo, now)
    LeaderChimera.OnAOECreate(aoeInfo, now)
    MagiHydra.OnAOECreate(aoeInfo, now)
    KidnapDemon.OnAOECreate(aoeInfo, now)
    ShapeshiftingMage.OnAOECreate(aoeInfo, now)
    KelpieCaptain.OnAOECreate(aoeInfo, now)
    Pallmagia.OnAOECreate(aoeInfo, now)
    WarlikeMinotaur.OnAOECreate(aoeInfo, now)
end

G.Update = function()
    local guide = rawget(_G, 'MuAiGuide')
    if type(guide) ~= 'table' then
        return
    end
    if not Context.currentMapIsNorth() then
        clearAll(true)
        return
    end
    local now = Context.nowMs()
    NorthReferenceDrawings.Update(guide, now)
    AlabasterBlade.Update(guide, now)
    MagiNecromancer.Update(guide, now)
    LeaderChimera.Update(guide, now)
    MagiHydra.Update(guide, now)
    Iambe.Update(guide, now)
    KidnapDemon.Update(guide, now)
    ShapeshiftingMage.Update(guide, now)
    KelpieCaptain.Update(guide, now)
    GemstoneBeast.Update(guide, now)
    local guided = Pallmagia.Update(guide, now)
    LittleMage.Update(guide, now, not guided)
    EvilSeer.Update(guide, now)
    Arachne.Update(guide, now)
    WarlikeMinotaur.Update(guide, now)
end

G.Test = {
    NorthReferenceDrawings = NorthReferenceDrawings.Test,
    AlabasterBlade = AlabasterBlade.Test,
    MagiNecromancer = MagiNecromancer.Test,
    LeaderChimera = LeaderChimera.Test,
    MagiHydra = MagiHydra.Test,
    Iambe = Iambe.Test,
    KidnapDemon = KidnapDemon.Test,
    ShapeshiftingMage = ShapeshiftingMage.Test,
    KelpieCaptain = KelpieCaptain.Test,
    GemstoneBeast = GemstoneBeast.Test,
    Pallmagia = Pallmagia.Test,
    LittleMage = LittleMage.Test,
    EvilSeer = EvilSeer.Test,
    Arachne = Arachne.Test,
    WarlikeMinotaur = WarlikeMinotaur.Test,
}

return G
