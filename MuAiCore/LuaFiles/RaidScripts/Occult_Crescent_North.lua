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
local TwoHeadedAevis = loadNorthModule('TwoHeadedAevis')
local SwordDancer = loadNorthModule('SwordDancer')
local Necrophobia = loadNorthModule('Necrophobia')
local Index = loadNorthModule('Index')
local SacredTreeGiant = loadNorthModule('SacredTreeGiant')
local OccultGrimoire = loadNorthModule('OccultGrimoire')
local CalofisteriDoppelganger = loadNorthModule('CalofisteriDoppelganger')
local AlabasterBlade = loadNorthModule('AlabasterBlade')
local MagiNecromancer = loadNorthModule('MagiNecromancer')
local LeaderChimera = loadNorthModule('LeaderChimera')
local MagiHydra = loadNorthModule('MagiHydra')
local Iambe = loadNorthModule('Iambe')
local GaleGriffin = loadNorthModule('GaleGriffin')
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
    TwoHeadedAevis,
    SwordDancer,
    Necrophobia,
    Index,
    SacredTreeGiant,
    OccultGrimoire,
    CalofisteriDoppelganger,
    AlabasterBlade,
    MagiNecromancer,
    LeaderChimera,
    MagiHydra,
    Iambe,
    GaleGriffin,
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
    TwoHeadedAevis.OnEntityChannel(entityID, spellID, now)
    SwordDancer.OnEntityChannel(entityID, spellID, now)
    OccultGrimoire.OnEntityChannel(
            entityID, spellID, channelTimeMax, now)
    CalofisteriDoppelganger.OnEntityChannel(entityID, spellID, now)
    MagiNecromancer.OnEntityChannel(entityID, spellID, now)
    LeaderChimera.OnEntityChannel(
            entityID, spellID, channelTimeMax, now)
    MagiHydra.OnEntityChannel(
            entityID, spellID, channelTimeMax, now)
    Iambe.OnEntityChannel(
            entityID, spellID, targetID, channelTimeMax, now)
    GaleGriffin.OnEntityChannel(
            entityID, spellID, channelTimeMax, now)
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
    TwoHeadedAevis.OnEntityCast(entityID, spellID)
    SwordDancer.OnEntityCast(entityID, spellID, castPos, now)
    SacredTreeGiant.OnEntityCast(entityID, spellID, now)
    OccultGrimoire.OnEntityCast(entityID, spellID, now)
    CalofisteriDoppelganger.OnEntityCast(entityID, spellID, now)
    AlabasterBlade.OnEntityCast(entityID, spellID, now)
    MagiNecromancer.OnEntityCast(entityID, spellID, now)
    LeaderChimera.OnEntityCast(entityID, spellID, now)
    MagiHydra.OnEntityCast(entityID, spellID, now)
    Iambe.OnEntityCast(entityID, spellID)
    GaleGriffin.OnEntityCast(entityID, spellID, now)
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
    local aevis = TwoHeadedAevis.OnVisibilityChange(entityID, isVisible)
    local revealed = MagiNecromancer.OnVisibilityChange(
            entityID, wasVisible, isVisible, now)
    local flash = MagiHydra.OnVisibilityChange(
            entityID, wasVisible, isVisible, now)
    local gemstone = GemstoneBeast.OnVisibilityChange(
            entityID, wasVisible, isVisible, now)
    return aevis or revealed or flash or gemstone
end

G.OnAnimationChange = function(
        entityID, index, oldAnimationID, newAnimationID)
    if not Context.currentMapIsNorth() then
        return false
    end
    return SwordDancer.OnAnimationChange(
            entityID,
            index,
            oldAnimationID,
            newAnimationID,
            Context.nowMs())
end

G.OnEntityAdd = function(entityID, entityName, contentID)
    if not Context.currentMapIsNorth() then
        return false
    end
    local now = Context.nowMs()
    local aevis = TwoHeadedAevis.OnEntityAdd(entityID, contentID, now)
    local index = Index.OnEntityAdd(entityID, contentID, now)
    local necromancer = MagiNecromancer.OnEntityAdd(
            entityID, contentID, now)
    local chimera = LeaderChimera.OnEntityAdd(
            entityID, contentID, now)
    local littleMage = LittleMage.OnEntityAdd(entityID, now)
    local iambe = Iambe.OnEntityAdd(entityID, contentID, now)
    local gale = GaleGriffin.OnEntityAdd(entityID, contentID, now)
    local sword = SwordDancer.OnEntityAdd(
            entityID, entityName, contentID, now)
    return aevis or index or necromancer or chimera
            or littleMage or iambe or gale or sword
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
        SwordDancer.OnAddGroundEffect({ ... }, now)
        Index.OnAddGroundEffect({ ... }, now)
        Pallmagia.OnAddGroundEffect(...)
    end
end

G.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    if Context.currentMapIsNorth() then
        local now = Context.nowMs()
        SwordDancer.OnEventObjectScriptFunc(
                entityID, a1, a2, a3, now)
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
    Necrophobia.OnAOECreate(aoeInfo, now)
    OccultGrimoire.OnAOECreate(aoeInfo, now)
    CalofisteriDoppelganger.OnAOECreate(aoeInfo, now)
    AlabasterBlade.OnAOECreate(aoeInfo, now)
    MagiNecromancer.OnAOECreate(aoeInfo, now)
    LeaderChimera.OnAOECreate(aoeInfo, now)
    MagiHydra.OnAOECreate(aoeInfo, now)
    Iambe.OnAOECreate(aoeInfo, now)
    GaleGriffin.OnAOECreate(aoeInfo, now)
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
    TwoHeadedAevis.Update(guide, now)
    SwordDancer.Update(guide, now)
    Necrophobia.Update(guide, now)
    Index.Update(guide, now)
    SacredTreeGiant.Update(guide, now)
    OccultGrimoire.Update(guide, now)
    CalofisteriDoppelganger.Update(guide, now)
    AlabasterBlade.Update(guide, now)
    MagiNecromancer.Update(guide, now)
    LeaderChimera.Update(guide, now)
    MagiHydra.Update(guide, now)
    Iambe.Update(guide, now)
    GaleGriffin.Update(guide, now)
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
    TwoHeadedAevis = TwoHeadedAevis.Test,
    SwordDancer = SwordDancer.Test,
    Necrophobia = Necrophobia.Test,
    Index = Index.Test,
    SacredTreeGiant = SacredTreeGiant.Test,
    OccultGrimoire = OccultGrimoire.Test,
    CalofisteriDoppelganger = CalofisteriDoppelganger.Test,
    AlabasterBlade = AlabasterBlade.Test,
    MagiNecromancer = MagiNecromancer.Test,
    LeaderChimera = LeaderChimera.Test,
    MagiHydra = MagiHydra.Test,
    Iambe = Iambe.Test,
    GaleGriffin = GaleGriffin.Test,
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
