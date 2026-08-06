local G = {}
G.MapId = 1252
G.NameCN = '新月岛·南岛'

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

local function getNow()
    if type(Now) == 'function' then
        return Now()
    end
    return math.floor(os.clock() * 1000)
end

local function validXYZ(pos)
    return Common.validXZ(pos) and Common.finite(pos.y)
end

local function copyPosition(pos, fallbackY)
    return Common.copyPosition(pos, false, fallbackY or 0)
end

local function copyReliablePosition(pos)
    return Common.copyPosition(pos, false)
end

local function entityPosition(entityID)
    if type(entityID) ~= 'number'
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    return entity ~= nil and copyPosition(entity.pos) or nil
end

local function reliableEntityPosition(entityID)
    if type(entityID) ~= 'number'
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    return entity ~= nil and copyReliablePosition(entity.pos) or nil
end

local function eventPosition(entityID, castPos)
    return copyPosition(castPos) or entityPosition(entityID)
end

local function eventHeading(castPos)
    if type(castPos) == 'table' then
        if type(castPos.h) == 'number' then
            return castPos.h
        end
        if type(castPos.heading) == 'number' then
            return castPos.heading
        end
    end
    return nil
end

local greenGuideColor = { r = 0, g = 1, b = 0, a = 0.5 }
local greenDrawer
local function getGreenDrawer(guide)
    if greenDrawer == nil
            and type(guide) == 'table'
            and type(guide.CreateDrawer) == 'function'
    then
        greenDrawer = guide.CreateDrawer(0, 1, 0, 0.28, 2, 0)
    end
    return greenDrawer
end

local SouthContext = {
    Common = Common,
    GetNow = getNow,
    ValidXYZ = validXYZ,
    CopyPosition = copyPosition,
    CopyReliablePosition = copyReliablePosition,
    EntityPosition = entityPosition,
    ReliableEntityPosition = reliableEntityPosition,
    EventPosition = eventPosition,
    EventHeading = eventHeading,
    GetGreenDrawer = getGreenDrawer,
    GreenGuideColor = greenGuideColor,
}

local function loadSouthModule(name)
    local globalName = 'MuAiOccultCrescentSouth' .. name
    local module = nil
    if type(FileLoad) == 'function' and type(MuAiGuideRoot) == 'string' then
        rawset(_G, globalName, nil)
        FileLoad(MuAiGuideRoot
                .. 'RaidScripts\\Occult_Crescent_South_Subs\\'
                .. name .. '.lua')
        module = rawget(_G, globalName)
    else
        local folder = currentFolder()
        if folder ~= nil and type(loadfile) == 'function' then
            local separator = folder:find('\\', 1, true) and '\\' or '/'
            local loader = loadfile(folder .. 'Occult_Crescent_South_Subs'
                    .. separator .. name .. '.lua')
            module = type(loader) == 'function' and loader() or nil
        end
    end
    assert(type(module) == 'table' and type(module.Create) == 'function',
            'failed to load South Island module: ' .. tostring(name))
    local feature = module.Create(SouthContext)
    assert(type(feature) == 'table',
            'failed to create South Island module: ' .. tostring(name))
    return feature
end

local CrescentBerserker = loadSouthModule('CrescentBerserker')
local OccultKnight = loadSouthModule('OccultKnight')
local Hinkypunk = loadSouthModule('Hinkypunk')
local Nymian = loadSouthModule('NymianPetalodus')
local TradeTortoise = loadSouthModule('TradeTortoise')
local Mindflayer = loadSouthModule('MysteriousMindflayer')
local BlackChocobo = loadSouthModule('BlackChocobo')
local CloisterDemon = loadSouthModule('CloisterDemon')
local GildedHeadstone = loadSouthModule('GildedHeadstone')
local LionRampant = loadSouthModule('LionRampant')
local CrystalDragon = loadSouthModule('CrystalDragon')
local DeathClaw = loadSouthModule('DeathClaw')
local IslandWatcher = loadSouthModule('IslandWatcher')
local Nammu = loadSouthModule('Nammu')
local OccultMoogleRanges = loadSouthModule('HigherBird')
local OccultReferenceDrawings = loadSouthModule('OccultReferenceDrawings')
local ForkedTowerBlood = loadSouthModule('ForkedTowerBlood')
local STATE_MODULES = {
    { 'NymianPetalodus', 'SetNymianPetalodusEnabled', Nymian },
    { 'TradeTortoise', 'SetTradeTortoiseEnabled', TradeTortoise },
    { 'MysteriousMindflayer', 'SetMysteriousMindflayerEnabled', Mindflayer },
    { 'BlackChocobo', 'SetBlackChocoboEnabled', BlackChocobo },
    { 'CloisterDemon', 'SetCloisterDemonEnabled', CloisterDemon },
    { 'GildedHeadstone', nil, GildedHeadstone },
    { 'LionRampant', 'SetLionRampantEnabled', LionRampant },
    { 'DeathClaw', 'SetDeathClawEnabled', DeathClaw },
    { 'IslandWatcher', 'SetIslandWatcherEnabled', IslandWatcher },
    { 'ForkedTowerBlood', 'SetForkedTowerBloodEnabled', ForkedTowerBlood },
}

local function initializeStateModules(guide)
    for _, spec in ipairs(STATE_MODULES) do
        local key, api = spec[1], spec[3]
        local state = type(guide[key]) == 'table' and guide[key] or api.NewState()
        guide[key] = api.EnsureState(state)
    end
end

local function clearStateModules()
    for _, spec in ipairs(STATE_MODULES) do
        local api = spec[3]
        local state = api.GetRuntimeState()
        if state ~= nil then
            api.ClearState(state)
        end
    end
end

local function makeDisableSetter(guide, key, clearState)
    return function(enabled)
        if enabled ~= true then
            clearState(guide[key])
        end
    end
end

local function installStateModuleSetters(guide)
    for _, spec in ipairs(STATE_MODULES) do
        local key, setter, api = spec[1], spec[2], spec[3]
        if setter ~= nil then
            guide[setter] = makeDisableSetter(guide, key, api.ClearState)
        end
    end
end

local function enabledModuleState(api, guide)
    local cfg = api.GetConfig(guide)
    local state = api.GetRuntimeState()
    if state ~= nil and type(cfg) == 'table' and cfg.Enable == true then
        return state, cfg
    end
end

G.Init = function(M)
    M.CrescentBerserker = CrescentBerserker.EnsureState(
            type(M.CrescentBerserker) == 'table' and M.CrescentBerserker or CrescentBerserker.NewState())
    M.OccultKnight = OccultKnight.EnsureState(
            type(M.OccultKnight) == 'table' and M.OccultKnight or OccultKnight.NewState())
    M.Hinkypunk = Hinkypunk.EnsureState(
            type(M.Hinkypunk) == 'table' and M.Hinkypunk or Hinkypunk.NewState())
    initializeStateModules(M)
    ForkedTowerBlood.GetConfig(M)
    M.CrystalDragon = CrystalDragon.EnsureState(
            type(M.CrystalDragon) == 'table'
                    and M.CrystalDragon or CrystalDragon.NewState())
    IslandWatcher.GetConfig(M)
    M.Nammu = Nammu.EnsureState(
            type(M.Nammu) == 'table' and M.Nammu or Nammu.NewState())
    Nammu.GetConfig(M)
    M.OccultMoogleRanges = OccultMoogleRanges.EnsureState(
            type(M.OccultMoogleRanges) == 'table'
                    and M.OccultMoogleRanges or OccultMoogleRanges.NewState())
    OccultMoogleRanges.GetHigherBirdConfig(M)
    M.OccultReferenceDrawings = OccultReferenceDrawings.EnsureState(
            type(M.OccultReferenceDrawings) == 'table'
                    and M.OccultReferenceDrawings
                    or OccultReferenceDrawings.NewState())
    OccultReferenceDrawings.GetConfig(M)
    M.SetCrescentBerserkerMoogleDonutsEnabled = function(enabled)
        return CrescentBerserker.ApplyMoogleDonuts(M.CrescentBerserker, enabled == true)
    end
    M.SetOccultKnightEnabled = function(enabled)
        if enabled ~= true then
            OccultKnight.ClearState(M.OccultKnight)
        end
    end
    M.SetHinkypunkEnabled = function(enabled)
        if enabled ~= true then
            Hinkypunk.ClearState(M.Hinkypunk)
        end
    end
    installStateModuleSetters(M)
    M.SetGildedHeadstoneEnabled = function(enabled)
        if enabled ~= true then
            GildedHeadstone.ClearState(M.GildedHeadstone)
            return
        end
        GildedHeadstone.ApplyMoogleDonuts(M.GildedHeadstone, true)
    end
    M.SetGildedHeadstoneMoogleDonutsEnabled = function(enabled)
        local gildedCfg = GildedHeadstone.GetConfig(M)
        return GildedHeadstone.ApplyMoogleDonuts(
                M.GildedHeadstone,
                type(gildedCfg) == 'table'
                        and gildedCfg.Enable == true)
    end
    M.SetGildedHeadstoneAutoFaceEnabled = function(enabled)
        if enabled ~= true then
            GildedHeadstone.ReleaseAutoFace(M.GildedHeadstone)
        end
    end
    M.SetCrystalDragonEnabled = function(enabled)
        return CrystalDragon.ApplyMoogleDonuts(
                M.CrystalDragon,
                enabled == true)
    end
    M.SetIslandWatcherAutoFaceEnabled = function(enabled)
        if enabled ~= true then
            IslandWatcher.ReleaseAutoFace(M.IslandWatcher)
        end
    end
    M.SetHigherBirdEnabled = function(enabled)
        if enabled ~= true then
            OccultMoogleRanges.ClearState(M.OccultMoogleRanges)
        end
    end
    M.SetHigherBirdAutoFaceEnabled = function(enabled)
        if enabled ~= true then
            OccultMoogleRanges.ReleaseAutoFace(M.OccultMoogleRanges)
        end
    end
    M.SetNammuEnabled = function(enabled)
        if enabled ~= true then
            Nammu.ClearState(M.Nammu)
        end
        return Nammu.ApplyBlacklist(M.Nammu, enabled == true)
    end
    M.SetOccultReferenceDrawingsEnabled = function(enabled)
        if enabled ~= true then
            OccultReferenceDrawings.ClearDraws(M.OccultReferenceDrawings)
        end
        return OccultReferenceDrawings.ApplyBlacklist(
                M.OccultReferenceDrawings,
                enabled == true)
    end

    local cfg = CrescentBerserker.GetConfig(M)
    CrescentBerserker.ApplyMoogleDonuts(M.CrescentBerserker,
            type(cfg) == 'table' and cfg.Enable == true)
    local gildedCfg = GildedHeadstone.GetConfig(M)
    GildedHeadstone.ApplyMoogleDonuts(
            M.GildedHeadstone,
            type(gildedCfg) == 'table'
                    and gildedCfg.Enable == true)
    local crystalDragonCfg = CrystalDragon.GetConfig(M)
    CrystalDragon.ApplyMoogleDonuts(
            M.CrystalDragon,
            type(crystalDragonCfg) == 'table'
                    and crystalDragonCfg.Enable == true)
    local nammuCfg = Nammu.GetConfig(M)
    Nammu.ApplyBlacklist(
            M.Nammu,
            type(nammuCfg) == 'table' and nammuCfg.Enable == true)
    OccultMoogleRanges.Apply(M.OccultMoogleRanges, true)
    local referenceCfg = OccultReferenceDrawings.GetConfig(M)
    OccultReferenceDrawings.ApplyBlacklist(
            M.OccultReferenceDrawings,
            type(referenceCfg) == 'table' and referenceCfg.Enable == true)
    local ftbCfg = ForkedTowerBlood.GetConfig(M)
    ForkedTowerBlood.ApplyBlacklist(
            M.ForkedTowerBlood,
            type(ftbCfg) == 'table' and ftbCfg.Enable == true)
end

G.OnEnter = function()
    local state = CrescentBerserker.GetRuntimeState()
    if state ~= nil then
        CrescentBerserker.ClearState(state)
        local cfg = CrescentBerserker.GetConfig()
        CrescentBerserker.ApplyMoogleDonuts(state,
                type(cfg) == 'table' and cfg.Enable == true)
    end
    local knightState = OccultKnight.GetRuntimeState()
    if knightState ~= nil then
        OccultKnight.ClearState(knightState)
    end
    local hinkyState = Hinkypunk.GetRuntimeState()
    if hinkyState ~= nil then
        Hinkypunk.ClearState(hinkyState)
    end
    clearStateModules()
    local ftbState = ForkedTowerBlood.GetRuntimeState()
    if ftbState ~= nil then
        local ftbCfg = ForkedTowerBlood.GetConfig()
        ForkedTowerBlood.ApplyBlacklist(
                ftbState,
                type(ftbCfg) == 'table' and ftbCfg.Enable == true)
    end
    local gildedState = GildedHeadstone.GetRuntimeState()
    if gildedState ~= nil then
        local gildedCfg = GildedHeadstone.GetConfig()
        GildedHeadstone.ApplyMoogleDonuts(
                gildedState,
                type(gildedCfg) == 'table'
                        and gildedCfg.Enable == true)
    end
    local crystalDragonState = CrystalDragon.GetRuntimeState()
    if crystalDragonState ~= nil then
        local crystalDragonCfg = CrystalDragon.GetConfig()
        CrystalDragon.ApplyMoogleDonuts(
                crystalDragonState,
                type(crystalDragonCfg) == 'table'
                        and crystalDragonCfg.Enable == true)
    end
    local nammuState = Nammu.GetRuntimeState()
    if nammuState ~= nil then
        Nammu.ClearState(nammuState)
        local nammuCfg = Nammu.GetConfig()
        Nammu.ApplyBlacklist(
                nammuState,
                type(nammuCfg) == 'table' and nammuCfg.Enable == true)
    end
    local occultMoogleRangeState = OccultMoogleRanges.GetRuntimeState()
    if occultMoogleRangeState ~= nil then
        OccultMoogleRanges.ClearState(occultMoogleRangeState)
        OccultMoogleRanges.Apply(occultMoogleRangeState, true)
    end
    local referenceState = OccultReferenceDrawings.GetRuntimeState()
    if referenceState ~= nil then
        OccultReferenceDrawings.ClearDraws(referenceState)
        local referenceCfg = OccultReferenceDrawings.GetConfig()
        OccultReferenceDrawings.ApplyBlacklist(
                referenceState,
                type(referenceCfg) == 'table'
                        and referenceCfg.Enable == true)
    end
end

G.OnLeave = function()
    local state = CrescentBerserker.GetRuntimeState()
    if state ~= nil then
        CrescentBerserker.ClearState(state)
        CrescentBerserker.ApplyMoogleDonuts(state, false)
    end
    local knightState = OccultKnight.GetRuntimeState()
    if knightState ~= nil then
        OccultKnight.ClearState(knightState)
    end
    local hinkyState = Hinkypunk.GetRuntimeState()
    if hinkyState ~= nil then
        Hinkypunk.ClearState(hinkyState)
    end
    clearStateModules()
    local ftbState = ForkedTowerBlood.GetRuntimeState()
    if ftbState ~= nil then
        ForkedTowerBlood.ApplyBlacklist(ftbState, false)
    end
    local crystalDragonState = CrystalDragon.GetRuntimeState()
    if crystalDragonState ~= nil then
        CrystalDragon.ApplyMoogleDonuts(crystalDragonState, false)
    end
    local nammuState = Nammu.GetRuntimeState()
    if nammuState ~= nil then
        Nammu.ClearState(nammuState)
        Nammu.ApplyBlacklist(nammuState, false)
    end
    local occultMoogleRangeState = OccultMoogleRanges.GetRuntimeState()
    if occultMoogleRangeState ~= nil then
        OccultMoogleRanges.ClearState(occultMoogleRangeState)
        OccultMoogleRanges.Apply(occultMoogleRangeState, false)
    end
    local referenceState = OccultReferenceDrawings.GetRuntimeState()
    if referenceState ~= nil then
        OccultReferenceDrawings.ClearDraws(referenceState)
        OccultReferenceDrawings.ApplyBlacklist(referenceState, false)
    end
end

G.OnWipe = G.OnLeave

G.OnEntityChannel = function(entityID, spellID, targetID, channelTimeMax)
    local guide = rawget(_G, 'MuAiGuide')
    local now = getNow()
    local higherBirdCfg = OccultMoogleRanges.GetHigherBirdConfig(guide)
    local occultMoogleRangeState = OccultMoogleRanges.GetRuntimeState()
    if occultMoogleRangeState ~= nil
            and type(higherBirdCfg) == 'table'
            and higherBirdCfg.Enable == true
    then
        OccultMoogleRanges.RecordThreefoldChannel(
                occultMoogleRangeState,
                entityID,
                spellID,
                channelTimeMax,
                now)
        OccultMoogleRanges.RecordPetrifyingGaze(
                occultMoogleRangeState,
                entityID,
                spellID,
                channelTimeMax,
                now)
    end
    local cfg = Hinkypunk.GetConfig()
    local state = Hinkypunk.GetRuntimeState()
    if state ~= nil and type(cfg) == 'table' and cfg.Enable then
        Hinkypunk.HandleEntityChannel(
                state,
                entityID,
                spellID,
                targetID,
                channelTimeMax,
                now)
    end
    local nymianState = enabledModuleState(Nymian, guide)
    if nymianState ~= nil then
        Nymian.HandleEntityChannel(nymianState, entityID, spellID, now)
    end
    local tradeState = enabledModuleState(TradeTortoise, guide)
    if tradeState ~= nil then
        TradeTortoise.HandleEntityChannel(
                tradeState,
                entityID,
                spellID,
                targetID,
                channelTimeMax,
                now,
                guide)
    end
    local mindflayerState = enabledModuleState(Mindflayer, guide)
    if mindflayerState ~= nil then
        Mindflayer.HandleEntityChannel(
                mindflayerState,
                entityID,
                spellID,
                targetID,
                channelTimeMax,
                now,
                guide)
    end
    local cloisterState = enabledModuleState(CloisterDemon, guide)
    if cloisterState ~= nil then
        CloisterDemon.HandleEntityChannel(
                cloisterState,
                entityID,
                spellID,
                channelTimeMax,
                now,
                guide)
    end
    local gildedState = enabledModuleState(GildedHeadstone, guide)
    if gildedState ~= nil then
        GildedHeadstone.HandleEntityChannel(
                gildedState,
                entityID,
                spellID,
                channelTimeMax,
                now,
                guide)
    end
    local deathClawState = enabledModuleState(DeathClaw, guide)
    if deathClawState ~= nil then
        DeathClaw.HandleEntityChannel(
                deathClawState,
                entityID,
                spellID,
                channelTimeMax,
                now,
                guide)
    end
    local islandWatcherState = enabledModuleState(IslandWatcher, guide)
    if islandWatcherState ~= nil then
        IslandWatcher.HandleEntityChannel(
                islandWatcherState,
                entityID,
                spellID,
                channelTimeMax,
                now,
                guide)
    end
    local ftbState = enabledModuleState(ForkedTowerBlood, guide)
    if ftbState ~= nil then
        ForkedTowerBlood.HandleEntityChannel(
                ftbState, guide, entityID, spellID, now)
    end
end

G.OnAuraChange = function(
        entityID,
        oldActiveAura1,
        oldActiveAura2,
        oldPersistentAura,
        newActiveAura1,
        newActiveAura2,
        newPersistentAura)
    local cfg = LionRampant.GetConfig()
    local state = LionRampant.GetRuntimeState()
    if state ~= nil and type(cfg) == 'table' and cfg.Enable then
        return LionRampant.AddBrightPulse(
                state,
                entityID,
                oldActiveAura1,
                newActiveAura1,
                getNow(),
                rawget(_G, 'MuAiGuide'))
    end
    return false
end

G.OnAOECreate = function(aoeInfo)
    local now = getNow()
    local guide = rawget(_G, 'MuAiGuide')
    local referenceState = enabledModuleState(OccultReferenceDrawings, guide)
    if referenceState ~= nil then
        OccultReferenceDrawings.HandleAOECreate(
                referenceState,
                aoeInfo,
                now)
    end
    local deathClawState = enabledModuleState(DeathClaw, guide)
    if deathClawState ~= nil then
        DeathClaw.HandleAOECreate(deathClawState, aoeInfo, now)
    end
    local nammuState = enabledModuleState(Nammu, guide)
    if nammuState ~= nil then
        Nammu.HandleAOECreate(nammuState, aoeInfo, now)
    end
    local higherBirdCfg = OccultMoogleRanges.GetHigherBirdConfig(guide)
    local occultMoogleRangeState = OccultMoogleRanges.GetRuntimeState()
    if occultMoogleRangeState ~= nil
            and type(higherBirdCfg) == 'table'
            and higherBirdCfg.Enable == true
    then
        OccultMoogleRanges.HandleMissingAOE(
                occultMoogleRangeState,
                aoeInfo,
                now)
    end
    local cfg = CrescentBerserker.GetConfig()
    local state = CrescentBerserker.GetRuntimeState()
    if state ~= nil and type(cfg) == 'table' and cfg.Enable then
        CrescentBerserker.HandleAOECreate(state, aoeInfo, now)
    end
    local knightCfg = OccultKnight.GetConfig()
    local knightState = OccultKnight.GetRuntimeState()
    if knightState ~= nil and type(knightCfg) == 'table' and knightCfg.Enable then
        OccultKnight.HandleAOECreate(knightState, aoeInfo, now, rawget(_G, 'MuAiGuide'))
    end
    local hinkyCfg = Hinkypunk.GetConfig()
    local hinkyState = Hinkypunk.GetRuntimeState()
    if hinkyState ~= nil and type(hinkyCfg) == 'table' and hinkyCfg.Enable then
        Hinkypunk.HandleAOECreate(
                hinkyState,
                aoeInfo,
                now,
                rawget(_G, 'MuAiGuide'))
    end
    local nymianState = enabledModuleState(Nymian, guide)
    if nymianState ~= nil then
        Nymian.HandleAOECreate(nymianState, aoeInfo, now, guide)
    end
    local tradeState = enabledModuleState(TradeTortoise, guide)
    if tradeState ~= nil then
        TradeTortoise.HandleAOECreate(tradeState, aoeInfo, now, guide)
    end
    local mindflayerState = enabledModuleState(Mindflayer, guide)
    if mindflayerState ~= nil then
        Mindflayer.HandleAOECreate(mindflayerState, aoeInfo, now, guide)
    end
    local blackChocoboState = enabledModuleState(BlackChocobo, guide)
    if blackChocoboState ~= nil then
        BlackChocobo.HandleAOECreate(
                blackChocoboState,
                aoeInfo,
                now,
                guide)
    end
    local gildedState = enabledModuleState(GildedHeadstone, guide)
    if gildedState ~= nil then
        GildedHeadstone.HandleAOECreate(gildedState, aoeInfo, now, guide)
    end
    local ftbState = enabledModuleState(ForkedTowerBlood, guide)
    if ftbState ~= nil then
        ForkedTowerBlood.HandleAOECreate(ftbState, guide, aoeInfo, now)
    end
end

G.OnEntityCast = function(entityID, spellID, castPos)
    local now = getNow()
    local guide = rawget(_G, 'MuAiGuide')
    local referenceState = enabledModuleState(OccultReferenceDrawings, guide)
    if referenceState ~= nil then
        OccultReferenceDrawings.HandleEntityCast(
                referenceState,
                entityID,
                spellID)
    end
    local nammuState = enabledModuleState(Nammu, guide)
    if nammuState ~= nil then
        Nammu.HandleEntityCast(nammuState, entityID, spellID)
    end
    local cfg = CrescentBerserker.GetConfig()
    local state = CrescentBerserker.GetRuntimeState()
    if state ~= nil and type(cfg) == 'table' and cfg.Enable then
        CrescentBerserker.HandleEntityCast(state, entityID, spellID, now)
    end
    local knightCfg = OccultKnight.GetConfig()
    local knightState = OccultKnight.GetRuntimeState()
    if knightState ~= nil and type(knightCfg) == 'table' and knightCfg.Enable then
        OccultKnight.HandleEntityCast(
                knightState,
                entityID,
                spellID,
                castPos,
                now,
                guide)
    end
    local hinkyCfg = Hinkypunk.GetConfig()
    local hinkyState = Hinkypunk.GetRuntimeState()
    if hinkyState ~= nil and type(hinkyCfg) == 'table' and hinkyCfg.Enable then
        Hinkypunk.HandleEntityCast(
                hinkyState,
                entityID,
                spellID,
                castPos,
                now,
                guide)
    end
    local nymianState = enabledModuleState(Nymian, guide)
    if nymianState ~= nil then
        Nymian.HandleEntityCast(
                nymianState,
                entityID,
                spellID,
                castPos,
                now,
                guide)
    end
    local tradeState = enabledModuleState(TradeTortoise, guide)
    if tradeState ~= nil then
        TradeTortoise.HandleEntityCast(tradeState, entityID, spellID, now)
    end
    local mindflayerState = enabledModuleState(Mindflayer, guide)
    if mindflayerState ~= nil then
        Mindflayer.HandleEntityCast(
                mindflayerState,
                entityID,
                spellID,
                castPos,
                now,
                guide)
    end
    local blackChocoboState = enabledModuleState(BlackChocobo, guide)
    if blackChocoboState ~= nil then
        BlackChocobo.HandleEntityCast(
                blackChocoboState,
                entityID,
                spellID,
                castPos,
                now,
                guide)
    end
    local cloisterState = enabledModuleState(CloisterDemon, guide)
    if cloisterState ~= nil then
        CloisterDemon.HandleEntityCast(
                cloisterState,
                entityID,
                spellID,
                now,
                guide)
    end
    local gildedState = enabledModuleState(GildedHeadstone, guide)
    if gildedState ~= nil then
        GildedHeadstone.HandleEntityCast(
                gildedState,
                entityID,
                spellID,
                now,
                guide)
    end
    local lionState = enabledModuleState(LionRampant, guide)
    if lionState ~= nil then
        LionRampant.ResolveBrightPulse(
                lionState,
                entityID,
                spellID,
                castPos,
                now)
    end
    local deathClawState = enabledModuleState(DeathClaw, guide)
    if deathClawState ~= nil then
        DeathClaw.HandleEntityCast(
                deathClawState,
                entityID,
                spellID,
                castPos,
                now,
                guide)
    end
    local islandWatcherState = enabledModuleState(IslandWatcher, guide)
    if islandWatcherState ~= nil then
        IslandWatcher.HandleEntityCast(
                islandWatcherState,
                entityID,
                spellID,
                now,
                guide)
    end
    local ftbState = enabledModuleState(ForkedTowerBlood, guide)
    if ftbState ~= nil then
        ForkedTowerBlood.HandleEntityCast(
                ftbState, guide, entityID, spellID, now)
    end
end

G.OnTetherChange = function(
        sourceEntityID,
        oldTetherID,
        oldTetherFlags,
        oldTargetID,
        newTetherID,
        newTetherFlags,
        newTargetID)
    local now = getNow()
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = TradeTortoise.GetConfig()
    local state = TradeTortoise.GetRuntimeState()
    if state ~= nil and type(cfg) == 'table' and cfg.Enable then
        TradeTortoise.HandleTetherChange(
                state,
                sourceEntityID,
                newTetherID,
                newTargetID,
                now,
                guide)
    end
    local ftbState = enabledModuleState(ForkedTowerBlood, guide)
    if ftbState ~= nil then
        ForkedTowerBlood.HandleTetherChange(
                ftbState,
                guide,
                sourceEntityID,
                newTargetID,
                newTetherID,
                now)
    end
end

G.OnMarkerAdd = function(entityID, markerID)
    local now = getNow()
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = TradeTortoise.GetConfig()
    local state = TradeTortoise.GetRuntimeState()
    if state ~= nil and type(cfg) == 'table' and cfg.Enable then
        TradeTortoise.HandleMarkerAdd(
                state,
                entityID,
                markerID,
                now,
                guide)
    end
    local ftbState = enabledModuleState(ForkedTowerBlood, guide)
    if ftbState ~= nil then
        ForkedTowerBlood.HandleMarkerAdd(
                ftbState, guide, entityID, markerID, now)
    end
end

G.OnEntityAdd = function(entityID, entityName)
    local consumed = false
    local cfg = CloisterDemon.GetConfig()
    local state = CloisterDemon.GetRuntimeState()
    if state ~= nil and type(cfg) == 'table' and cfg.Enable then
        consumed = CloisterDemon.HandleEntityAdd(
                state,
                entityID,
                getNow(),
                rawget(_G, 'MuAiGuide')) or consumed
    end
    local lionCfg = LionRampant.GetConfig()
    local lionState = LionRampant.GetRuntimeState()
    if lionState ~= nil
            and type(lionCfg) == 'table'
            and lionCfg.Enable
    then
        consumed = LionRampant.HandleEntityAdd(
                lionState,
                entityID,
                getNow()) or consumed
    end
    return consumed
end

G.OnVisibilityChange = function(entityID, wasVisible, isVisible)
    local consumed = false
    local now = getNow()
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = DeathClaw.GetConfig()
    local state = DeathClaw.GetRuntimeState()
    if state ~= nil and type(cfg) == 'table' and cfg.Enable then
        consumed = DeathClaw.HandleVisibilityChange(
                state,
                entityID,
                wasVisible,
                isVisible,
                now,
                guide) or consumed
    end
    local ftbState = enabledModuleState(ForkedTowerBlood, guide)
    if ftbState ~= nil then
        consumed = ForkedTowerBlood.HandleVisibilityChange(
                ftbState, guide, entityID,
                wasVisible, isVisible, now) or consumed
    end
    return consumed
end

G.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    local consumed = false
    local cfg = CloisterDemon.GetConfig()
    local state = CloisterDemon.GetRuntimeState()
    if state ~= nil and type(cfg) == 'table' and cfg.Enable then
        consumed = CloisterDemon.HandleScriptFunc(
                state,
                entityID,
                a1,
                a2,
                a3,
                getNow()) or consumed
    end
    local deathClawCfg = DeathClaw.GetConfig()
    local deathClawState = DeathClaw.GetRuntimeState()
    if deathClawState ~= nil
            and type(deathClawCfg) == 'table'
            and deathClawCfg.Enable
    then
        consumed = DeathClaw.HandleScriptFunc(
                deathClawState,
                entityID,
                a1,
                a2,
                a3,
                getNow(),
                rawget(_G, 'MuAiGuide')) or consumed
    end
    local guide = rawget(_G, 'MuAiGuide')
    local ftbState = enabledModuleState(ForkedTowerBlood, guide)
    if ftbState ~= nil then
        consumed = ForkedTowerBlood.HandleScriptFunc(
                ftbState, entityID, a1, a2, a3, getNow()) or consumed
    end
    return consumed
end

G.Update = function()
    local guide = rawget(_G, 'MuAiGuide')
    local now = getNow()
    local ftbState = ForkedTowerBlood.GetRuntimeState()
    local ftbCfg = ForkedTowerBlood.GetConfig(guide)
    if ftbState ~= nil and type(ftbCfg) == 'table' then
        ForkedTowerBlood.ApplyBlacklist(
                ftbState, ftbCfg.Enable == true)
        if ftbCfg.Enable == true then
            ForkedTowerBlood.Tick(ftbState, guide, now)
        else
            ForkedTowerBlood.ClearState(ftbState)
        end
    end
    local referenceState = OccultReferenceDrawings.GetRuntimeState()
    local referenceCfg = OccultReferenceDrawings.GetConfig(guide)
    if referenceState ~= nil and type(referenceCfg) == 'table' then
        OccultReferenceDrawings.ApplyBlacklist(
                referenceState,
                referenceCfg.Enable == true)
        if referenceCfg.Enable == true then
            OccultReferenceDrawings.PruneState(referenceState, now)
        else
            OccultReferenceDrawings.ClearDraws(referenceState)
        end
    end
    local nammuState = Nammu.GetRuntimeState()
    local nammuCfg = Nammu.GetConfig(guide)
    if nammuState ~= nil and type(nammuCfg) == 'table' then
        Nammu.ApplyBlacklist(nammuState, nammuCfg.Enable == true)
        if nammuCfg.Enable == true then
            Nammu.PruneState(nammuState, now)
        else
            Nammu.ClearState(nammuState)
        end
    end
    local state = CrescentBerserker.GetRuntimeState()
    local cfg = CrescentBerserker.GetConfig(guide)
    if state ~= nil and type(cfg) == 'table' then
        CrescentBerserker.ApplyMoogleDonuts(state, cfg.Enable == true)
        if not cfg.Enable then
            if #state.items > 0 then
                CrescentBerserker.ClearState(state)
            end
        else
            CrescentBerserker.PruneExpired(state, now)
            if #state.items > 0 then
                local bossPresent = CrescentBerserker.HasLive()
                if bossPresent == true then
                    state.bossLastSeenAt = now
                elseif bossPresent == false
                        and state.bossLastSeenAt ~= nil
                        and now - state.bossLastSeenAt > CrescentBerserker.BossMissingClearMs
                then
                    CrescentBerserker.ClearState(state)
                end
                if #state.items > 0 then
                    local selected = CrescentBerserker.SelectNextItem(state.items)
                    if selected ~= nil then
                        CrescentBerserker.DrawSelected(guide, cfg, selected)
                    end
                end
            end
        end
    end

    local knightState = OccultKnight.GetRuntimeState()
    local knightCfg = OccultKnight.GetConfig(guide)
    if guide ~= nil and knightState ~= nil and type(knightCfg) == 'table' then
        OccultKnight.Update(guide, knightCfg, knightState)
    end

    local hinkyState = Hinkypunk.GetRuntimeState()
    local hinkyCfg = Hinkypunk.GetConfig(guide)
    if guide ~= nil and hinkyState ~= nil and type(hinkyCfg) == 'table' then
        Hinkypunk.Update(guide, hinkyCfg, hinkyState)
    end

    if guide ~= nil then
        for _, spec in ipairs(STATE_MODULES) do
            local api = spec[3]
            local moduleState = api.GetRuntimeState()
            local moduleCfg = api.GetConfig(guide)
            if moduleState ~= nil
                    and type(moduleCfg) == 'table'
                    and type(api.Update) == 'function'
            then
                api.Update(guide, moduleCfg, moduleState, now)
            end
        end
    end

    local crystalDragonState = CrystalDragon.GetRuntimeState()
    local crystalDragonCfg = CrystalDragon.GetConfig(guide)
    if crystalDragonState ~= nil and type(crystalDragonCfg) == 'table' then
        CrystalDragon.ApplyMoogleDonuts(
                crystalDragonState,
                crystalDragonCfg.Enable == true)
    end

    local occultMoogleRangeState = OccultMoogleRanges.GetRuntimeState()
    if occultMoogleRangeState ~= nil then
        OccultMoogleRanges.PruneTimedCircles(
                occultMoogleRangeState,
                now)
        local higherBirdCfg = OccultMoogleRanges.GetHigherBirdConfig(guide)
        if type(higherBirdCfg) == 'table' then
            OccultMoogleRanges.UpdatePetrifyingGaze(
                    guide,
                    higherBirdCfg,
                    occultMoogleRangeState,
                    now)
        end
        OccultMoogleRanges.Apply(occultMoogleRangeState, true)
    end
end

G.Test = {
    LandingRadiusByID = CrescentBerserker.LandingRadiusByID,
    RingRadiusByID = CrescentBerserker.RingRadiusByID,
    RingIDByRadius = CrescentBerserker.RingIDByRadius,
    NewState = CrescentBerserker.NewState,
    ClearMechanicState = CrescentBerserker.ClearState,
    PruneExpired = CrescentBerserker.PruneExpired,
    SelectNextItem = CrescentBerserker.SelectNextItem,
    HandleAOECreate = CrescentBerserker.HandleAOECreate,
    HandleEntityCast = CrescentBerserker.HandleEntityCast,
    NearestPreparationPoint = CrescentBerserker.NearestPreparationPoint,
    ApplyMoogleDonuts = CrescentBerserker.ApplyMoogleDonuts,
    KnightAID = OccultKnight.AID,
    KnightArenaCenter = OccultKnight.ArenaCenter,
    KnightArenaRadius = OccultKnight.ArenaRadius,
    NewKnightState = OccultKnight.NewState,
    ClearKnightState = OccultKnight.ClearState,
    PruneKnightState = OccultKnight.PruneState,
    HandleKnightAOECreate = OccultKnight.HandleAOECreate,
    HandleKnightEntityCast = OccultKnight.HandleEntityCast,
    GetSpinningPredictions = OccultKnight.GetSpinningPredictions,
    FindSpinningSafePoint = OccultKnight.FindSpinningSafePoint,
    FindNearestArenaPoint = OccultKnight.FindNearestArenaPoint,
    IsPointInCross = OccultKnight.IsPointInCross,
    IsPointInForwardRect = OccultKnight.IsPointInForwardRect,
    ProjectKnockback = OccultKnight.ProjectKnockback,
    FindKnockbackSolution = OccultKnight.FindKnockbackSolution,
    GetFlurryPredictions = OccultKnight.GetFlurryPredictions,
    HasKnightActivity = OccultKnight.HasActivity,
    HinkyAID = Hinkypunk.AID,
    HinkyArenaCenter = Hinkypunk.ArenaCenter,
    HinkyArenaRadius = Hinkypunk.ArenaRadius,
    HinkyKnockbackSafeRadius = Hinkypunk.KnockbackSafeRadius,
    HinkyCrossHeading = Hinkypunk.CrossHeading,
    NewHinkyState = Hinkypunk.NewState,
    ClearHinkyState = Hinkypunk.ClearState,
    PruneHinkyState = Hinkypunk.PruneState,
    HinkyCastDelay = Hinkypunk.CastDelay,
    HandleHinkyEntityChannel = Hinkypunk.HandleEntityChannel,
    HandleHinkyAOECreate = Hinkypunk.HandleAOECreate,
    HandleHinkyEntityCast = Hinkypunk.HandleEntityCast,
    GetNextHinkyBird = Hinkypunk.GetNextBird,
    FindHinkyDonutSafePoint = Hinkypunk.FindDonutSafePoint,
    FindNearestHinkyArenaPoint = Hinkypunk.FindNearestArenaPoint,
    IsPointInHinkyCross = Hinkypunk.IsPointInCross,
    ProjectHinkyKnockback = Hinkypunk.ProjectKnockback,
    FindHinkyKnockbackSolution = Hinkypunk.FindKnockbackSolution,
    DrawHinkypunk = Hinkypunk.Draw,
    HasHinkyActivity = Hinkypunk.HasActivity,
    Nymian = Nymian,
    TradeTortoise = TradeTortoise,
    Mindflayer = Mindflayer,
    BlackChocobo = BlackChocobo,
    CloisterDemon = CloisterDemon,
    GildedHeadstone = GildedHeadstone,
    LionRampant = LionRampant,
    CrystalDragon = CrystalDragon,
    DeathClaw = DeathClaw,
    IslandWatcher = IslandWatcher,
    Nammu = Nammu,
    OccultMoogleRanges = OccultMoogleRanges,
    OccultReferenceDrawings = OccultReferenceDrawings,
    ForkedTowerBlood = ForkedTowerBlood,
}

return G
