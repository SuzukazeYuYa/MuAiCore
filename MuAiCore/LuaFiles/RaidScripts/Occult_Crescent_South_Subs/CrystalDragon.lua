local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table')
    local Common = assert(Context.Common)
    local getNow = assert(Context.GetNow)
    local validXZ = Common.validXZ
    local validXYZ = assert(Context.ValidXYZ)
    local copyPosition = assert(Context.CopyPosition)
    local copyReliablePosition = assert(Context.CopyReliablePosition)
    local entityPosition = assert(Context.EntityPosition)
    local reliableEntityPosition = assert(Context.ReliableEntityPosition)
    local eventPosition = assert(Context.EventPosition)
    local eventHeading = assert(Context.EventHeading)
    local distanceSquared = Common.distanceSquared
    local normalized = Common.normalized
    local greenGuideColor = Context.GreenGuideColor

local CRYSTAL_DRAGON_NAME_ID = 13696
local CRYSTAL_DRAGON_ARENA_CENTER = { x = -414, z = 75 }
local CRYSTAL_DRAGON_ARENA_RADIUS = 24.5
local CRYSTAL_DRAGON_MOOGLE_SOURCE = 'MuAiCore - 水晶龙'

local crystalDragonAID = {
    PrismaticWingIn = 42767,
    MadeMagicIn = 42769,
    ChaosSmall1 = 41759,
    ChaosMedium1 = 41760,
    ChaosLarge1 = 41761,
    ChaosSmall2 = 42729,
    ChaosMedium2 = 42730,
    ChaosLarge2 = 42731,
    ChaosSmall3 = 42733,
    ChaosMedium3 = 42734,
    ChaosLarge3 = 42735,
}

local crystalDragonMoogleDonuts = {
    [42767] = { name = '水晶之翼', radius = 5 },
    [42769] = { name = '释放魔力', radius = 5 },
    [41759] = { name = '水晶乱流', radius = 7 },
    [41760] = { name = '水晶乱流', radius = 13 },
    [41761] = { name = '水晶乱流', radius = 19 },
    [42729] = { name = '水晶乱流', radius = 7 },
    [42730] = { name = '水晶乱流', radius = 13 },
    [42731] = { name = '水晶乱流', radius = 19 },
    [42733] = { name = '水晶乱流', radius = 7 },
    [42734] = { name = '水晶乱流', radius = 13 },
    [42735] = { name = '水晶乱流', radius = 19 },
}

local function newCrystalDragonState()
    return {
        moogle = {
            registered = false,
            owned = {},
            previous = {},
            previousKnown = {},
        },
    }
end

local function ensureCrystalDragonState(state)
    state.moogle = type(state.moogle) == 'table' and state.moogle or {}
    state.moogle.registered = state.moogle.registered == true
    state.moogle.owned = type(state.moogle.owned) == 'table'
            and state.moogle.owned or {}
    state.moogle.previous = type(state.moogle.previous) == 'table'
            and state.moogle.previous or {}
    state.moogle.previousKnown = type(state.moogle.previousKnown) == 'table'
            and state.moogle.previousKnown or {}
    return state
end

local crystalDragonFeature = Common.newFeature({
    key = 'CrystalDragon',
    newState = newCrystalDragonState,
    ensureState = ensureCrystalDragonState,
})
local getCrystalDragonConfig = crystalDragonFeature.GetConfig
local getCrystalDragonRuntimeState = crystalDragonFeature.GetRuntimeState

local crystalDragonDonutRegistry = Common.newMoogleDonutRegistry({
    entries = crystalDragonMoogleDonuts,
    source = CRYSTAL_DRAGON_MOOGLE_SOURCE,
    ensureState = ensureCrystalDragonState,
    getBucket = function(state)
        return state.moogle
    end,
})
local applyCrystalDragonDonuts = crystalDragonDonutRegistry.Apply

return {
    AID = crystalDragonAID,
    NameID = CRYSTAL_DRAGON_NAME_ID,
    ArenaCenter = CRYSTAL_DRAGON_ARENA_CENTER,
    ArenaRadius = CRYSTAL_DRAGON_ARENA_RADIUS,
    MoogleSource = CRYSTAL_DRAGON_MOOGLE_SOURCE,
    MoogleDonuts = crystalDragonMoogleDonuts,
    NewState = newCrystalDragonState,
    EnsureState = ensureCrystalDragonState,
    GetConfig = getCrystalDragonConfig,
    GetRuntimeState = getCrystalDragonRuntimeState,
    ApplyMoogleDonuts = applyCrystalDragonDonuts,
}
end

rawset(_G, 'MuAiOccultCrescentSouthCrystalDragon', Module)
return Module
