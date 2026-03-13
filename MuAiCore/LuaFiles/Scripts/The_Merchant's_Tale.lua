local G = {}
G.MapId = 1317
G.NameCN = '异闻商客奇谭'
G.CurBoss = nil

local _gridCenters = {}
local _boss1Center = { x = 375, y = -29.5, z = 530 }
local _boss2Center = { x = 170, y = -16, z = -815 }
local _boss3Center = { x = -760, y = -54, z = -805 }
local _skillIdCircle = { 46658, 46660, 46687, 46689, 47562, 47564, 47566, 47568 }
local _skillIdRing = { 46659, 46661, 46668, 46690, 47563, 47565, 47567, 47569 }
local _order = { "MT", "H1", "D1", "D2" }
local _order2 = { "H1", "MT", "D1", "D2" }
local _lastRightMarkTime = 0

local _redDrawer = Argus2.ShapeDrawer:new(
		(GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),
		1
)

local _yellowDrawer = Argus2.ShapeDrawer:new(
		(GUI:ColorConvertFloat4ToU32(1, 1, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 1, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 1, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),
		1
)

local _blueDrawer = Argus2.ShapeDrawer:new(
		(GUI:ColorConvertFloat4ToU32(0, 0, 1, 0.3)),
		(GUI:ColorConvertFloat4ToU32(0, 0, 1, 0.3)),
		(GUI:ColorConvertFloat4ToU32(0, 0, 1, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),
		1
)

local _greenDrawer = Argus2.ShapeDrawer:new(
		(GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),
		1
)

local _purpleDrawer = Argus2.ShapeDrawer:new(
		(GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),
		1
)

local _cyanDrawer = Argus2.ShapeDrawer:new(
		(GUI:ColorConvertFloat4ToU32(0, 1, 1, 0.3)),
		(GUI:ColorConvertFloat4ToU32(0, 1, 1, 0.3)),
		(GUI:ColorConvertFloat4ToU32(0, 1, 1, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),
		1
)

local initGlobalData = function()
	MuAiGuide.Merchant = {
		State = {
			Start = 0,
			Boss1_Start = 1000,
			Boss1_P1_ForceMove = 1101,
			Boss1_P1_End = 1199,
			Boss1_P2_GroudWater = 1201,
			Boss1_P2_GroudWaterEnd = 1202,
			Boss1_P2_Treasure = 1203,

			Boss1_P2_End = 1299,
			-- 老2
			Boss2_Start = 2000,
			Boss2_P1_Start = 2100,
			Boss2_P1_GetBuff = 2101,
			Boss2_P1_GetLine = 2102,
			Boss2_P1_LineEnd = 2103,
			Boss2_P2_Start = 2200,
			Boss2_P2_Put = 2202,
			Boss2_P3_Start = 2300,
			Boss2_P3_GetBuff1 = 2301,
			Boss2_P3_GetBlade = 2302,
			Boss2_P3_GetLine = 2303,
			Boss2_P3_LineEnd = 2304,
			Boss2_P3_4Blade1 = 2305,
			Boss2_P3_4Blade2 = 2306,
			Boss2_P3_4Blade3 = 2307,
			Boss2_P3_4AddMark = 2308,
			Boss2_P3_4Blade4 = 2309,
			Boss2_P3_4BladeEnd = 2310,
			Boss2_P3_End = 2399,
			Boss2_P4_Start = 2400,
			Boss2_P4_GetStone = 2401,
			Boss2_P4_Linked = 2402,
			Boss2_P4_GetBuff = 2403,
			Boss2_P4_Blade1 = 2404,
			Boss2_P4_Blade2 = 2405,
			Boss2_P4_Blade3 = 2406,
			Boss2_P4_Blade4 = 2407,
			Boss2_P4_BladeEnd = 2408,
			-- 老3
			Boss3_Start = 3000,
			Boss3_P1_Start = 3100,
			Boss3_P1_FireDance = 3102,
			Boss3_P1_End = 3199,
			Boss3_P2_Start = 3200,
			Boss3_P2_GetBuff = 3201,
			Boss3_P2_Turn1 = 3202,
			Boss3_P2_Turn2 = 3203,
			Boss3_P2_Turn3 = 3204,
			Boss3_P2_Turn4 = 3205,
			Boss3_P2_StartCarry = 3206,
			Boss3_P2_GetKeyBlanket = 3207,
			Boss3_P2_CarryEnd = 3208,
			Boss3_P2_End = 3299,
			Boss3_P3_Start = 3300,
			Boss3_P3_GetFirstFire = 3301,
			Boss3_P3_FirstPillar = 3302,
			Boss3_P3_GetPillar = 3303,
			Boss3_P3_GetBuff = 3304,
			Boss3_P3_End = 3399,

			Boss3_P4_Start = 3400,
			Boss3_P4_Tower1 = 3401,
			Boss3_P4_Tower2 = 3402,
			Boss3_P4_FireStone = 3403,
			Boss3_P4_End = 3499,
		},
		CurrentState = 0,
		Timer = 0,
		mark20InState = false,
		mark20Timer = 0,
		mark22 = false,
		Timer46574 = 0,
		Timer47031 = 0,
		spell45845 = {
			Timer = 0,
			Ids = {},
			SafePoint = {},
			DangerPoints = nil,
			LockingFace = false,
			GuidePos1 = nil,
			GuidePos2 = nil,
			BuffType = nil,
			offsetH = nil,
		},
		aoeGroudWater = {
			Timer = 0,
			aoe = {},
			GuidePos1 = nil,
			GuidePos2 = nil,
			WaitTime = 0,
			DrawPos = nil,
		},
		spell45849 = {
			InState = false,
			Timer = 0,
			Ids = {},
			FirstBallIds = {},
			FirstBallFinish = false,
			AllBalls = {},
			P1TargetPos = nil,
			P1GuidePos1 = nil,
			P1GuidePos2 = nil,
			P1OffsetH = nil,
			P1BuffType = nil,
			P1LockingFace = nil
		},
		spell46715 = false,
		spellRingCircle = false,
		spellRingData = {
			spellId = 0,
			spellType = 0,
			spellMark1 = nil,
			spellMark2 = nil,
			spellMarkAim = nil,
		},
		spell45866 = {
			InState = false,
			Timer = 0,
			AoeInfo1 = {},
			AoeInfo2 = {},
		},
		B2P1SmallBlade = nil,
		B2P3Blade = nil,
		fireDance = {
			inState = false,
			state = 0,
			spellId = 0,
			aoeHeading = 0,
			tethers = {},
			routeInfo = {}
		},
		B3P1Sub = {
			Timer = 0,
			entities = {},
			ids = {},
			marks = {},
			AOEs = {},
			spellId = 0
		},
		B3P2FireDance = {
			marks = {},
			auras = {},
			aoeInfo = nil,
			curDir = nil,
			near = nil,
			far = nil,
			mid = nil,
			Timer = 0,
		},
		B3P2Phantom = {
			aoeInfo = nil,
			entity = nil,
			redOrb = {},
			blanketIds = {},
			blankets = {},
			blueOrbOldPos = nil,
			blueOrbNewPos = nil,
			blanketWithBlueOrb = nil,
			GuidePos = nil,
		},
		B3P3FireType = nil,
		B3P3Fire = {},
		B3P3FireLinkType = {},
		B3P3Pillar = {},
		B3P3FireGuidePos = nil,
		B3P3FireGuidePos2 = nil,
		B3P4Tower1 = {},
		B3P4Tower2 = {},
		B3P4BladeAoes = {},
		B3P4FineStoneIndex = 1,
		B3P4FineStoneIdsOld = {},
		B3P4FineStoneIds = {},
		B3P4FineStoneEnts = {},
		B3P4FineStoneDirAoe = nil,
		B3P4FineStoneMarks = {},
		B3P4linkDirInfo = nil,
		B3P4linkGuidePos = {},
		B3P4linkGuideTable = {}
	}
end

local getCfg = function()
	return MuAiGuide.Config.Main
end

local getCurBoss = function()
	if G.CurBoss == nil then
		return nil
	end
	return TensorCore.mGetEntity(G.CurBoss.id)
end

local changeState = function(state)
	MuAiGuide.Merchant.CurrentState = state
	MuAiGuide.Debug("阶段切换：" .. tostring(state))
end
local getTurnLineFrom = function(entity, buffType)
	local entityID = entity.id
	local tethers = Argus.getTethersOnEnt(entityID)
	if tethers ~= nil and table.size(tethers) > 0 then
		for _, tether in pairs(Argus.getTethersOnEnt(entityID)) do
			if tether.type == 115 then
				for _, pTether in pairs(Argus.getTethersOnEnt(tether.partnerid)) do
					if pTether.partnerid ~= entityID then
						return TensorCore.mGetEntity(pTether.partnerid)
					end
				end
			end
		end
	else
		for _, ent in pairs(TensorCore.entityList("contentid=14326")) do
			local model = Argus.getEntityModel(ent.id)
			if model == 19228 then
				if buffType == 4775 then
					if ent.pos.z > _boss2Center.z + 18 or ent.pos.z < _boss2Center.z - 18 then
						if ent.pos.x - 2 < entity.pos.x and entity.pos.x < ent.pos.x + 2 and MuAiGuide.HasLine(ent.id, 115) then
							return ent
						end
					end
				else
					if ent.pos.x > _boss2Center.x + 18 or ent.pos.x < _boss2Center.x - 18 then
						if ent.pos.z - 2 < entity.pos.z and entity.pos.z < ent.pos.z + 2 and MuAiGuide.HasLine(ent.id, 115) then
							return ent
						end
					end
				end
			end
		end
	end
	return nil
end

local boss1SubDraw = function(entityID, spellID)
	if not getCfg().MerchantDraw then
		return
	end
	local drawerTime = 1800
	local curEnt = TensorCore.mGetEntity(entityID)
	if spellID == 45843 then
		_redDrawer:addTimedCone(drawerTime, curEnt.pos.x, curEnt.pos.y, curEnt.pos.z, 45, math.pi / 3, curEnt.pos.h)
	elseif spellID == 45841 or spellID == 45839 or spellID == 45840 then
		_redDrawer:addTimedRect(drawerTime, curEnt.pos.x, curEnt.pos.y, curEnt.pos.z, 42, 8, curEnt.pos.h)
	elseif spellID == 45842 then
		_redDrawer:addTimedCone(drawerTime, curEnt.pos.x, curEnt.pos.y, curEnt.pos.z, 20, math.pi, curEnt.pos.h)
	end
end

local OnUpdateSpell45866 = function()
	local mmd = MuAiGuide.Merchant
	if not getCfg().MerchantDraw and not mmd.spell45866.InState then
		return
	end
	if TimeSince(mmd.spell45866.Timer) < 6500 then
		for _, aoe in pairs(mmd.spell45866.AoeInfo1) do
			_purpleDrawer:addCone(_boss1Center.x, _boss1Center.y, _boss1Center.z, 30, math.pi / 2, aoe.heading)
		end
	elseif TimeSince(mmd.spell45866.Timer) < 10000 then
		for _, aoe in pairs(mmd.spell45866.AoeInfo1) do
			_purpleDrawer:addCone(_boss1Center.x, _boss1Center.y, _boss1Center.z, 30, math.pi / 2, aoe.heading + math.pi / 2)
		end
	else
		mmd.spell45866 = {
			InState = false,
			Timer = 0,
			AoeInfo1 = {},
			AoeInfo2 = {},
		}
	end
end

--- 沉没的宝藏
local OnUpdateSpell45849 = function()
	local mmd = MuAiGuide.Merchant
	if not mmd.spell45849.InState then
		return
	end
	if TimeSince(mmd.spell45849.Timer) < 7500 then
		for _, ent in pairs(TensorCore.entityList("contentid=2015004")) do
			if not table.contains(mmd.spell45849.Ids, ent.id) then
				table.insert(mmd.spell45849.Ids, ent.id)
				table.insert(mmd.spell45849.AllBalls, { entity = ent, type = 1 })
			end
		end
		for _, ent in pairs(TensorCore.entityList("contentid=2015005")) do
			if not table.contains(mmd.spell45849.Ids, ent.id) then
				table.insert(mmd.spell45849.Ids, ent.id)
				table.insert(mmd.spell45849.AllBalls, { entity = ent, type = 2 })
			end
		end
	elseif TimeSince(mmd.spell45849.Timer) < 20000 then
		if getCfg().MerchantDraw and mmd.spell45849.FirstBallFinish then
			for _, exEnt in pairs(mmd.spell45849.AllBalls) do
				if exEnt.type == 2 then
					_redDrawer:addDonut(exEnt.entity.pos.x, exEnt.entity.pos.y, exEnt.entity.pos.z, 4, 20)
				else
					if table.contains(mmd.spell45849.FirstBallIds, exEnt.entity.id) then
						_yellowDrawer:addCircle(exEnt.entity.pos.x, exEnt.entity.pos.y, exEnt.entity.pos.z, 18)
					end
				end
			end
		end
	elseif TimeSince(mmd.spell45849.Timer) < 27000 then
		if getCfg().MerchantDraw then
			for _, exEnt in pairs(mmd.spell45849.AllBalls) do
				if exEnt.type == 1 and not table.contains(mmd.spell45849.FirstBallIds, exEnt.entity.id) then
					_redDrawer:addCircle(exEnt.entity.pos.x, exEnt.entity.pos.y, exEnt.entity.pos.z, 18)
				end
			end
		end
	end
end

local OnUpdateMark20 = function()
	if not MuAiGuide.Merchant.mark20InState then
		return
	end
	if TimeSince(MuAiGuide.Merchant.mark20Timer) < 7700 then
		for _, ent in pairs(MuAiGuide.Party) do
			if ent.id ~= Player.id then
				local dis = 100000000
				local curPoint
				for _, row in pairs(_gridCenters) do
					for _, point in pairs(row) do
						local curEnt = TensorCore.mGetEntity(ent.id)
						local curDis = TensorCore.getDistance2d(curEnt.pos, { x = point.x, y = _boss1Center.y, z = point.z })
						if curDis < dis then
							dis = curDis
							curPoint = point
						end
					end
				end
				if curPoint ~= nil then
					_yellowDrawer:addCross(curPoint.x, _boss1Center.y, curPoint.z, 40, 8, math.pi)
				end
			end
		end
	else
		MuAiGuide.Merchant.mark20InState = false
		MuAiGuide.Merchant.mark20Timer = 0
	end
end

local OnUpDateMoveChecker = function()
	if not getCfg().MerchantDraw then
		return
	end
	local player = MuAiGuide.GetPlayer()
	local heading
	if TensorCore.hasBuff(player.id, 2161) then
		-- 前
		heading = player.pos.h
	elseif TensorCore.hasBuff(player.id, 2162) then
		heading = player.pos.h + math.pi
		-- 后
	elseif TensorCore.hasBuff(player.id, 2163) then
		-- 左
		heading = player.pos.h + math.pi / 2
	elseif TensorCore.hasBuff(player.id, 2164) then
		-- 右
		heading = player.pos.h - math.pi / 2
	else
		return
	end
	local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(1, 1, 0, 0.7), 0)
	drawer:addArrow(player.pos.x, player.pos.y, player.pos.z, heading, 18, 0.05, 0.3, 0.15, true)
end

local OnUpdateSpellRingCircle = function()
	if not getCfg().MerchantDraw or not MuAiGuide.Merchant.spellRingCircle then
		return
	end
	local mmd = MuAiGuide.Merchant
	if mmd.spellRingData.spellMark1 == nil
			or mmd.spellRingData.spellMark2 == nil
			or mmd.spellRingData.spellMarkAim == nil
			or mmd.spellRingData.spellId == 0
	then
		return
	end

	--[[if mmd.spellRingData.spellType == 0 then
		local _curBoss = getCurBoss()
		if _curBoss ~= nil then
			if _curBoss.lastAction == 34 then
				-- 分摊
				mmd.spellRingData.spellType = 1
			elseif _curBoss.lastAction == 35 then
				-- 小钢铁
				mmd.spellRingData.spellType = 2
			end
		end
	end]]
	if getCfg().MerchantGuide then
		local player = MuAiGuide.GetPlayer()
		local guidePos
		if player.id == mmd.spellRingData.spellMarkAim.id then
			guidePos = { x = 170, z = -823.5 }
		elseif player.id == mmd.spellRingData.spellMark1.id then
			if table.contains(_skillIdCircle, mmd.spellRingData.spellId) then
				guidePos = { x = 170, z = -806.5 }
			else
				guidePos = { x = 170, z = -815 }
			end
		elseif player.id == mmd.spellRingData.spellMark2.id then
			if table.contains(_skillIdCircle, mmd.spellRingData.spellId) then
				guidePos = { x = 170, z = -815 }
			else
				guidePos = { x = 170, z = -806.5 }
			end
		end
		if guidePos ~= nil then
			MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
		end
	end
	local aimEnt = TensorCore.mGetEntity(mmd.spellRingData.spellMarkAim.id)
	if TimeSince(MuAiGuide.Merchant.Timer) < 5000 then
		local drawPosYellow = TensorCore.mGetEntity(mmd.spellRingData.spellMark2.id)
		local drawPosRed = TensorCore.mGetEntity(mmd.spellRingData.spellMark1.id)
		if table.contains(_skillIdCircle, mmd.spellRingData.spellId) then
			_yellowDrawer:addDonut(drawPosYellow.pos.x, drawPosYellow.pos.y, drawPosYellow.pos.z, 8, 60)
			_redDrawer:addCircle(drawPosRed.pos.x, drawPosRed.pos.y, drawPosRed.pos.z, 8)
		else
			_redDrawer:addDonut(drawPosRed.pos.x, drawPosRed.pos.y, drawPosRed.pos.z, 8, 40)
			_yellowDrawer:addCircle(drawPosYellow.pos.x, drawPosYellow.pos.y, drawPosYellow.pos.z, 8)
		end
		_purpleDrawer:addCircle(aimEnt.pos.x, aimEnt.pos.y, aimEnt.pos.z, 5)
	elseif TimeSince(MuAiGuide.Merchant.Timer) < 7000 then
		local drawPosRed = TensorCore.mGetEntity(mmd.spellRingData.spellMark2.id)
		if table.contains(_skillIdCircle, mmd.spellRingData.spellId) then
			_redDrawer:addDonut(drawPosRed.pos.x, drawPosRed.pos.y, drawPosRed.pos.z, 8, 60)
		else
			_redDrawer:addCircle(drawPosRed.pos.x, drawPosRed.pos.y, drawPosRed.pos.z, 8)
		end
		if TimeSince(MuAiGuide.Merchant.Timer) < 5500 then
			_purpleDrawer:addCircle(aimEnt.pos.x, aimEnt.pos.y, aimEnt.pos.z, 5)
		end
	else
		mmd.Timer = 0
		mmd.spellRingCircle = false
		mmd.spellRingData = {
			spellId = 0,
			spellType = 0,
			spellMark1 = nil,
			spellMark2 = nil,
			spellMarkAim = nil,
		}
	end
end

local onJumpDraw = function()
	local mmdd = MuAiGuide.Merchant.fireDance
	local curBoss = getCurBoss()
	if curBoss == nil then
		return
	end
	local curRouteInfo = mmdd.routeInfo[mmdd.state]
	if TensorCore.getDistance2d(curBoss.pos, curRouteInfo.endEnt.pos) < 0.5 then
		mmdd.state = mmdd.state + 1
	else
		local drawPos = curRouteInfo.drawPoint
		local wide = TensorCore.getDistance2d(curRouteInfo.startEnt.pos, curRouteInfo.endEnt.pos)
		if getCfg().MerchantDraw then
			_redDrawer:addRect(drawPos.x, drawPos.y, drawPos.z, 43, wide, curRouteInfo.drawHeading)
			if mmdd.state < 3 then
				local curRouteInfo2 = mmdd.routeInfo[mmdd.state + 1]
				local drawPos2 = curRouteInfo2.drawPoint
				local wide2 = TensorCore.getDistance2d(curRouteInfo2.startEnt.pos, curRouteInfo2.endEnt.pos)
				_yellowDrawer:addRect(drawPos2.x, drawPos2.y, drawPos2.z, 43, wide2, curRouteInfo2.drawHeading)
			end
			for i = mmdd.state, #mmdd.routeInfo do
				local info = mmdd.routeInfo[i]
				local heading = TensorCore.getHeadingToTarget(info.startEnt.pos, info.endEnt.pos)
				local distance = TensorCore.getDistance2d(info.startEnt.pos, info.endEnt.pos)
				local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0, 1, 0, 1), 0)
				local guidePos = info.startEnt.pos
				drawer:addArrow(guidePos.x, guidePos.y, guidePos.z, heading, distance - 1, 0.2, 1, 0.5, true)
			end
		end
	end
end

---@param tbl table 表格
---@param strX string 提取X方位
---@param StrZ string 提取Z方位
local getGuidePosFromBlade4 = function(tbl, strX, StrZ)
	local dirXEnt, dirZEnt
	for _, data in pairs(tbl) do
		if data.dirType == strX then
			dirXEnt = data.entity
		end
		if data.dirType == StrZ then
			dirZEnt = data.entity
		end
		if dirXEnt ~= nil and dirZEnt ~= nil then
			break
		end
	end
	return { x = dirXEnt.pos.x, z = dirZEnt.pos.z }
end

local drawGuide4Blade = function(bladeTbl)
	local guidePos
	local player = MuAiGuide.GetPlayer()
	if TensorCore.hasBuff(player.id, 4781) then
		-- 右上不能被攻击
		guidePos = getGuidePosFromBlade4(bladeTbl, "down", "left")
	elseif TensorCore.hasBuff(player.id, 4782) then
		-- 左上不能被攻击
		guidePos = getGuidePosFromBlade4(bladeTbl, "down", "right")
	elseif TensorCore.hasBuff(player.id, 4777) then
		-- 右下不能被攻击
		guidePos = getGuidePosFromBlade4(bladeTbl, "up", "left")
	elseif TensorCore.hasBuff(player.id, 4778) then
		-- 左下不能被攻击
		guidePos = getGuidePosFromBlade4(bladeTbl, "up", "right")
	end
	if guidePos ~= nil then
		MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
	end
end

local getBladeTable = function(tbl, idTable, model)
	model = model or 19227
	for _, ent in pairs(TensorCore.entityList("contentid=14326")) do
		local modelId = Argus.getEntityModel(ent.id)
		if modelId == model and not table.contains(idTable, ent.id) then
			table.insert(idTable, ent.id)
			local type
			if ent.pos.z < _boss2Center.z - 18 then
				type = "up"
			elseif ent.pos.x > _boss2Center.x + 18 then
				type = "right"
			elseif ent.pos.z > _boss2Center.z + 18 then
				type = "down"
			elseif ent.pos.x < _boss2Center.x - 18 then
				type = "left"
			end
			table.insert(tbl, { entity = ent, dirType = type })
		end
	end
end

local guide4Blade = function(wave)
	local mmd = MuAiGuide.Merchant
	local index = "Big" .. tostring(wave)
	if mmd.B2P3Blade.BigIds == nil then
		mmd.B2P3Blade.BigIds = {}
	end
	if mmd.B2P3Blade[index] == nil then
		mmd.B2P3Blade[index] = {}
	end
	local limit = wave * 4
	if table.size(mmd.B2P3Blade.BigIds) < limit then
		getBladeTable(mmd.B2P3Blade[index], mmd.B2P3Blade.BigIds)
	elseif table.size(mmd.B2P3Blade.BigIds) == limit then
		drawGuide4Blade(mmd.B2P3Blade[index])
	end
end

local calcB2P4Blade = function(index)
	local targetBlade
	local mmd = MuAiGuide.Merchant
	for _, blade in pairs(mmd.P4Blade[index]) do
		if mmd.P4SelfSafeDir == blade.dirType then
			targetBlade = blade
			break
		end
	end
	local stone1 = MuAiGuide.Merchant.P4Stone[1]
	local stone2 = MuAiGuide.Merchant.P4Stone[2]
	local targetStone
	if targetBlade.dirType == "up" or targetBlade.dirType == "down" then
		if targetBlade.entity.pos.x > _boss2Center.x and stone1.pos.x > _boss2Center.x
				or targetBlade.entity.pos.x < _boss2Center.x and stone1.pos.x < _boss2Center.x
		then
			targetStone = stone1
		else
			targetStone = stone2
		end
	else
		if targetBlade.entity.pos.z > _boss2Center.z and stone1.pos.z > _boss2Center.z
				or targetBlade.entity.pos.z < _boss2Center.z and stone1.pos.z < _boss2Center.z
		then
			targetStone = stone1
		else
			targetStone = stone2
		end
	end
	local targetBlade2
	for _, blade in pairs(mmd.P4Blade[index]) do
		if targetBlade.entity.id ~= blade.entity.id then
			if targetBlade.dirType == "up" or targetBlade.dirType == "down" then
				if (blade.entity.pos.x > _boss2Center.x + 18 or blade.entity.pos.x < _boss2Center.x - 18)
						and (blade.entity.pos.z > _boss2Center.z and targetStone.pos.z > _boss2Center.z
						or blade.entity.pos.z < _boss2Center.z and targetStone.pos.z < _boss2Center.z)
				then
					targetBlade2 = blade
					break
				end
			else
				if (blade.entity.pos.z > _boss2Center.z + 18 or blade.entity.pos.z < _boss2Center.z - 18)
						and (blade.entity.pos.x > _boss2Center.x and targetStone.pos.x > _boss2Center.x
						or blade.entity.pos.x < _boss2Center.x and targetStone.pos.x < _boss2Center.x)
				then
					targetBlade2 = blade
					break
				end
			end
		end
	end
	local dir
	if targetBlade2.entity.pos.z < _boss2Center.z - 18 then
		dir = 0
	elseif targetBlade2.entity.pos.x > _boss2Center.x + 18 then
		dir = 3 * math.pi / 2
	elseif targetBlade2.entity.pos.x < _boss2Center.x - 18 then
		dir = math.pi / 2
	else
		dir = math.pi
	end

	local guidePos = TensorCore.getPosInDirection(targetStone.pos, dir, 4)
	mmd.P4BladeGuidePos[index] = guidePos
end

local drawerB2P4Blade = function(index)
	local mmd = MuAiGuide.Merchant
	local limit = index * 4
	if table.size(mmd.P4BladeIds) < limit then
		getBladeTable(mmd.P4Blade[index], mmd.P4BladeIds, 19518)
	elseif table.size(mmd.P4BladeIds) == limit then
		if mmd.P4BladeGuidePos[index] == nil then
			calcB2P4Blade(index)
		else
			local guidePos = mmd.P4BladeGuidePos[index]
			MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
		end
	end
end

local boss3FireDance2 = function(nextState, curWave)
	local mmd = MuAiGuide.Merchant
	local hasChange = false
	if mmd.B3P2FireDance.Timer == 0 or TimeSince(mmd.B3P2FireDance.Timer) > 2100 then
		for _, ent in pairs(MuAiGuide.Party) do
			if TensorCore.hasBuff(ent.id, 2941) then
				changeState(nextState)
				mmd.B3P2FireDance.curDir = mmd.B3P2FireDance.curDir + math.pi
				mmd.B3P2FireDance.Timer = Now()
				hasChange = true
				break
			end
		end
	end
	if not hasChange then
		local curAura = mmd.B3P2FireDance.auras[curWave]
		local curMark = mmd.B3P2FireDance.marks[curWave]
		if curAura == nil or curMark == nil then
			return
		end
		local curPlayers = {}
		for _, ent in pairs(MuAiGuide.Party) do
			table.insert(curPlayers, TensorCore.mGetEntity(ent.id))
		end
		local boss = getCurBoss()
		if boss == nil then
			return
		end
		if getCfg().MerchantDraw then
			table.sort(curPlayers, function(a, b)
				local disA = TensorCore.getDistance2d(a.pos, boss.pos)
				local disB = TensorCore.getDistance2d(b.pos, boss.pos)
				return disA < disB
			end)
			local nearest = curPlayers[1]
			local farest = curPlayers[4]
			if curAura == 2751 then
				_greenDrawer:addCircle(farest.pos.x, farest.pos.y, farest.pos.z, 3.5)
				_purpleDrawer:addCircle(nearest.pos.x, nearest.pos.y, nearest.pos.z, 3.5)
			elseif curAura == 2752 then
				_greenDrawer:addCircle(nearest.pos.x, nearest.pos.y, nearest.pos.z, 3.5)
				_purpleDrawer:addCircle(farest.pos.x, farest.pos.y, farest.pos.z, 3.5)
			end
			local heading
			if curMark == 645 or curMark == 625 then
				heading = mmd.B3P2FireDance.curDir + math.pi / 2
			else
				heading = mmd.B3P2FireDance.curDir - math.pi / 2
			end
			_redDrawer:addRect(_boss3Center.x, _boss3Center.y, _boss3Center.z, 20, 40, heading)
		end
		if getCfg().MerchantGuide then
			local heading
			if curMark == 645 or curMark == 625 then
				heading = mmd.B3P2FireDance.curDir - math.pi / 2
			else
				heading = mmd.B3P2FireDance.curDir + math.pi / 2
			end
			local selfIdx = MuAiGuide.IndexOf(_order, MuAiGuide.SelfPos)
			local basePos
			if selfIdx == curWave then
				if curAura == 2752 then
					basePos = mmd.B3P2FireDance.far
				else
					basePos = mmd.B3P2FireDance.near
				end
			else
				basePos = mmd.B3P2FireDance.mid
			end
			local offset
			if curWave == 1 and MuAiGuide.IsSameDirection(mmd.B3P2FireDance.aoeInfo.heading, math.pi / 2) then
				offset = 2.5
			else
				offset = 0.5
			end
			if curWave == 1 and MuAiGuide.IsSameDirection(mmd.B3P2FireDance.aoeInfo.heading, math.pi * 3 / 2) then
				basePos = { x = basePos.x + 0.5, y = basePos.y, z = basePos.z }
			end
			local guidePos = TensorCore.getPosInDirection(basePos, heading, offset)
			MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
		end
	end
end

local OnUpdateSpell46715 = function()
	if getCfg().MerchantDraw and MuAiGuide.Merchant.spell46715 then
		if TimeSince(MuAiGuide.Merchant.Timer) < 5000 then
			local curBoss = getCurBoss()
			if curBoss == nil then
				return
			end
			_redDrawer:addRect(curBoss.pos.x, curBoss.pos.y, curBoss.pos.z, 40, 60, curBoss.pos.h)
		else
			MuAiGuide.Merchant.spell46715 = false
			MuAiGuide.Merchant.Timer = 0
		end
	end
end

local getNextTower = function(fromDir, towerList)
	local curDir = MuAiGuide.SetHeading2Pi(fromDir)
	local startDir = 0
	if math.abs(curDir) < 0.01 then
		startDir = math.pi * 15 / 8
	else
		local maxDir = 0
		for i = 1, 8 do
			local tempDir = (2 * i - 1) * math.pi / 8
			if startDir == 0 or tempDir < curDir and tempDir > maxDir then
				startDir = tempDir
			end
		end
	end
	for i = 0, 15 do
		local pointDir = MuAiGuide.SetHeading2Pi(startDir - i * math.pi / 8)
		for _, tower in pairs(towerList) do
			if tower.job == nil then
				local heading = TensorCore.getHeadingToTarget(_boss3Center, { x = tower.x, y = tower.y, z = tower.z, })
				local towerDir = MuAiGuide.SetHeading2Pi(heading)
				if MuAiGuide.IsSameDirection(towerDir, pointDir) then
					return tower
				end
			end
		end
	end
end

local guideToTower = function(curTowers, wave)
	local player = MuAiGuide.GetPlayer()
	local mmd = MuAiGuide.Merchant
	if mmd.B3P4linkDirInfo == nil or table.size(mmd.B3P4linkDirInfo) == 0 then
		mmd.B3P4linkDirInfo = {}
		for job, ent in pairs(MuAiGuide.Party) do
			local tethers = Argus.getTethersOnEnt(ent.id)
			local position, dir, pPos
			for _, tether in pairs(tethers) do
				if tether.type == 17 then
					local partner = TensorCore.mGetEntity(tether.partnerid)
					pPos = partner.pos
					local aoe = mmd.B3P4BladeAoes[tether.partnerid]
					local offsetX = partner.pos.x - _boss3Center.x
					local offsetZ = partner.pos.z - _boss3Center.z
					if offsetZ < -18 then
						position = "up"
					elseif offsetX > 18 then
						position = "right"
					elseif offsetZ > 18 then
						position = "down"
					elseif offsetX < -18 then
						position = "left"
					end
					if MuAiGuide.IsSameDirection(aoe.heading, 0) then
						dir = "down"
					elseif MuAiGuide.IsSameDirection(aoe.heading, math.pi / 2) then
						dir = "right"
					elseif MuAiGuide.IsSameDirection(aoe.heading, math.pi) then
						dir = "up"
					elseif MuAiGuide.IsSameDirection(aoe.heading, math.pi * 3 / 2) then
						dir = "left"
					end
				end
			end
			local buff = TensorCore.getBuff(ent.id, 2939)
			if buff ~= nil then
				mmd.B3P4linkDirInfo[job] = {
					LinkedPos = position,
					LinkedDir = dir,
					IsFirst = buff.duration < 7,
					PartnerPos = pPos
				}
			end
		end
	end
	local linkDirInfo = mmd.B3P4linkDirInfo
	if mmd.B3P4linkGuideTable[wave] == nil then
		local guideTable = {}
		for job, info in pairs(linkDirInfo) do
			local bindTower
			if wave == 1 then
				bindTower = info.IsFirst
			else
				bindTower = not info.IsFirst
			end
			if bindTower then
				local aimTower
				if info.LinkedPos == "up" then
					if info.LinkedDir == "left" then
						for _, tw in pairs(curTowers) do
							if tw.x < _boss3Center.x and (aimTower == nil or tw.z < aimTower.z) then
								aimTower = tw
							end
						end
					else
						for _, tw in pairs(curTowers) do
							if tw.x > _boss3Center.x and (aimTower == nil or tw.z < aimTower.z) then
								aimTower = tw
							end
						end
					end
				elseif info.LinkedPos == "down" then
					if info.LinkedDir == "left" then
						for _, tw in pairs(curTowers) do
							if tw.x < _boss3Center.x and (aimTower == nil or tw.z > aimTower.z) then
								aimTower = tw
							end
						end
					else
						for _, tw in pairs(curTowers) do
							if tw.x > _boss3Center.x and (aimTower == nil or tw.z > aimTower.z) then
								aimTower = tw
							end
						end
					end
				elseif info.LinkedPos == "left" then
					if info.LinkedDir == "up" then
						for _, tw in pairs(curTowers) do
							if tw.z < _boss3Center.z and (aimTower == nil or tw.x < aimTower.x) then
								aimTower = tw
							end
						end
					else
						for _, tw in pairs(curTowers) do
							if tw.z > _boss3Center.z and (aimTower == nil or tw.x < aimTower.x) then
								aimTower = tw
							end
						end
					end
				elseif info.LinkedPos == "right" then
					if info.LinkedDir == "up" then
						for _, tw in pairs(curTowers) do
							if tw.z < _boss3Center.z and (aimTower == nil or tw.x > aimTower.x) then
								aimTower = tw
							end
						end
					else
						for _, tw in pairs(curTowers) do
							if tw.z > _boss3Center.z and (aimTower == nil or tw.x > aimTower.x) then
								aimTower = tw
							end
						end
					end
				end
				aimTower.job = job
				guideTable[job] = aimTower
			end
		end
		mmd.B3P4linkGuideTable[wave] = guideTable
	end
	if mmd.B3P4linkGuidePos[wave] == nil then
		mmd.B3P4linkGuidePos[wave] = {}
		local guideData = mmd.B3P4linkGuideTable[wave][MuAiGuide.SelfPos]
		if guideData == nil then
			local dir
			if wave == 1 then
				dir = TensorCore.getHeadingToTarget(_boss3Center, linkDirInfo[MuAiGuide.SelfPos].PartnerPos)
			else
				dir = TensorCore.getHeadingToTarget(_boss3Center, player.pos)
			end
			guideData = getNextTower(dir, curTowers)
			if guideData ~= nil then
				mmd.B3P4linkGuidePos[wave][1] = { x = guideData.x, z = guideData.z }
				mmd.B3P4linkGuidePos[wave][2] = { x = guideData.x, z = guideData.z }
			end
		else
			local towerPos = { x = guideData.x, y = guideData.y, z = guideData.z }
			local dir = TensorCore.getHeadingToTarget(_boss3Center, towerPos)
			local dis = TensorCore.getDistance2d(_boss3Center, towerPos)
			local guidePos = TensorCore.getPosInDirection(_boss3Center, dir, dis + 1)
			mmd.B3P4linkGuidePos[wave][1] = { x = guidePos.x, z = guidePos.z }
			mmd.B3P4linkGuidePos[wave][2] = { x = guideData.x, z = guideData.z }
		end
	end
	if mmd.Timer46574 == 0 then
		local guidePos = mmd.B3P4linkGuidePos[wave][1]
		MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
	elseif (TimeSince(mmd.Timer46574) < 1000) then
		local guidePos = mmd.B3P4linkGuidePos[wave][2]
		MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
	else
		mmd.Timer46574 = 0
		if mmd.CurrentState < mmd.State.Boss3_P4_Tower1 then
			changeState(mmd.State.Boss3_P4_Tower1)
		elseif mmd.CurrentState < mmd.State.Boss3_P4_Tower2 then
			changeState(mmd.State.Boss3_P4_Tower2)
		end
	end
end

local calcCurHeading = function(curMark, curDir)
	if curMark == 645 or curMark == 625 then
		return curDir + math.pi / 2
	else
		return curDir - math.pi / 2
	end
end

local drawStoneDir = function(curWave)
	local mmd = MuAiGuide.Merchant
	if mmd.B3P4FineStoneEnts[curWave] == nil then
		return
	end
	for _, ent in pairs(mmd.B3P4FineStoneEnts[curWave]) do
		_redDrawer:addCross(ent.pos.x, ent.pos.y, ent.pos.z, 40, 10, 0)
	end
	local curMark = mmd.B3P4FineStoneMarks[curWave]
	local heading = calcCurHeading(curMark, mmd.B3P4FineStoneDirAoe.heading + math.pi * (curWave - 1))
	_redDrawer:addRect(_boss3Center.x, _boss3Center.y, _boss3Center.z, 20, 40, heading)
end

local getP1Higher = function()
	local player = MuAiGuide.GetPlayer()
	local cuBuff = TensorCore.hasBuff(player.id, 4726)
	local partner
	for Job, ent in pairs(MuAiGuide.Party) do
		if ent.id ~= player.id then
			if cuBuff then
				if TensorCore.hasBuff(ent.id, 4726) then
					partner = Job
					break
				end
			else
				if not TensorCore.hasBuff(ent.id, 4726) then
					partner = Job
					break
				end
			end
		end
	end
	local selfIndex = MuAiGuide.IndexOf(_order, MuAiGuide.SelfPos)
	local otherIndex = MuAiGuide.IndexOf(_order, partner)
	return selfIndex < otherIndex
end

local changeStateByForceMoveEnd = function(state)
	local hasBuff = false
	for _, ent in pairs(MuAiGuide.Party) do
		if TensorCore.hasBuff(ent.id, 1257) then
			hasBuff = true
			break
		end
		for i = 2161, 2164 do
			if TensorCore.hasBuff(ent.id, i) then
				hasBuff = true
				break
			end
		end
		if hasBuff then
			break
		end
	end
	if not hasBuff then
		changeState(state)
		return true
	end
	return false
end

local Boss_14291_Update = function()
	local curBoss = getCurBoss()
	if curBoss ~= nil and not curBoss.alive then
		changeState(MuAiGuide.Merchant.State.Boss2_Start)
		return
	end
	local mmd = MuAiGuide.Merchant
	OnUpdateSpell45866()
	OnUpdateSpell45849()
	OnUpdateMark20()
	if mmd == nil or mmd.CurrentState == nil then
		return
	end
	local player = MuAiGuide.GetPlayer()
	if mmd.State.Boss1_P1_ForceMove <= mmd.CurrentState
			and mmd.CurrentState < mmd.State.Boss1_P1_End then
		if getCfg().MerchantAimTool then
			OnUpDateMoveChecker()
		end
		if changeStateByForceMoveEnd(mmd.State.Boss1_P1_End) then
			return
		end
		--- 强制移动1 空中漫游
		if TimeSince(mmd.spell45845.Timer) > 4100 then
			if mmd.spell45845.DangerPoints == nil then
				mmd.spell45845.DangerPoints = {}
				table.insert(mmd.spell45845.DangerPoints, _boss1Center)
			else
				for _, ent in pairs(TensorCore.entityList("contentid=14291")) do
					if TensorCore.getDistance2d(_boss1Center, ent.pos) > 14
							and not table.contains(mmd.spell45845.Ids, ent.id)
					then
						table.insert(mmd.spell45845.Ids, ent.id)
						table.insert(mmd.spell45845.DangerPoints, ent.pos)
					end
				end
			end
		end
		if mmd.spell45845.BuffType == nil then
			if TensorCore.hasBuff(player.id, 2161) then
				-- 前
				mmd.spell45845.offsetH = 0
				mmd.spell45845.BuffType = 2161
			elseif TensorCore.hasBuff(player.id, 2162) then
				-- 后
				mmd.spell45845.offsetH = math.pi
				mmd.spell45845.BuffType = 2162
			elseif TensorCore.hasBuff(player.id, 2163) then
				-- 左 
				mmd.spell45845.offsetH = -math.pi / 2
				mmd.spell45845.BuffType = 2163
			elseif TensorCore.hasBuff(player.id, 2164) then
				-- 右
				mmd.spell45845.offsetH = math.pi / 2
				mmd.spell45845.BuffType = 2164
			end
		end
		if mmd.spell45845.DangerPoints ~= nil then
			if getCfg().MerchantDraw then
				for _, pos in pairs(mmd.spell45845.DangerPoints) do
					_redDrawer:addCircle(pos.x, pos.y, pos.z, 12)
				end
			end
			if not getCfg().MerchantGuide then
				return
			end

			if table.size(mmd.spell45845.DangerPoints) == 7 then
				if mmd.spell45845.GuidePos1 == nil then
					if table.size(mmd.spell45845.SafePoint) < 2 then
						for i = 1, 4 do
							local curHeading = MuAiGuide.SetHeading2Pi(curBoss.pos.h - (2 * i - 1) * math.pi / 4)
							local curPoint = TensorCore.getPosInDirection(_boss1Center, curHeading, 22.624)
							local inDanger = false
							for _, point in pairs(mmd.spell45845.DangerPoints) do
								if TensorCore.getDistance2d(point, curPoint) < 12 then
									inDanger = true
									break
								end
							end
							if not inDanger then
								table.insert(mmd.spell45845.SafePoint, {
									x = curPoint.x,
									y = curPoint.y,
									z = curPoint.z,
									h = curHeading,
								})
								if table.size(mmd.spell45845.SafePoint) == 2 then
									break
								end
							end
						end
					else
						local isHigher = getP1Higher()
						if isHigher then
							mmd.spell45845.GuidePos2 = mmd.spell45845.SafePoint[1]
						else
							mmd.spell45845.GuidePos2 = mmd.spell45845.SafePoint[2]
						end
						mmd.spell45845.GuidePos1 = TensorCore.getPosInDirection(_boss1Center, mmd.spell45845.GuidePos2.h, 3)
					end
				else
					local curBuff = TensorCore.getBuff(player.id, mmd.spell45845.BuffType)
					local guidePos
					if getCfg().MerchantLockFace then
						if curBuff ~= nil then
							guidePos = mmd.spell45845.GuidePos1
							if curBuff.duration < 2 and not mmd.spell45845.LockingFace then
								local distanceTo1 = TensorCore.getDistance2d(player.pos, mmd.spell45845.GuidePos1)
								if distanceTo1 < 1 then
									local curHeading = TensorCore.getHeadingToTarget(player.pos, mmd.spell45845.GuidePos2)
											+ mmd.spell45845.offsetH
									TensorCore.API.TensorACR.setLockFaceHeading(curHeading)
									TensorCore.API.TensorACR.toggleLockFace(true)
									mmd.spell45845.LockingFace = true
								end
							end
						else
							if mmd.spell45845.LockingFace then
								local moveBuff = TensorCore.getBuff(player.id, 1257)
								if moveBuff ~= nil and moveBuff.duration < 2 then
									TensorCore.API.TensorACR.toggleLockFace(false)
									mmd.spell45845.LockingFace = false
								end
							end
							guidePos = mmd.spell45845.GuidePos2
						end
					else
						guidePos = mmd.spell45845.GuidePos2
					end
					if guidePos ~= nil then
						MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
					end
				end
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss1_P2_GroudWater then
		if table.size(mmd.aoeGroudWater.aoe) < 2 then
			return
		end
		if TimeSince(mmd.aoeGroudWater.Timer) > 15000 then
			changeState(mmd.State.Boss1_P2_GroudWaterEnd)
			return
		end
		local aoe = mmd.aoeGroudWater.aoe
		local timer = TimeSince(mmd.aoeGroudWater.Timer)
		if getCfg().MerchantDraw then
			if mmd.aoeGroudWater.DrawPos == nil then
				mmd.aoeGroudWater.DrawPos = {}
				for i = 1, 5 do
					mmd.aoeGroudWater.DrawPos[i] = {}
					for _, curAoe in pairs(aoe) do
						local curPos = { x = curAoe.x, y = curAoe.y, z = curAoe.z }
						local heading = TensorCore.getHeadingToTarget(curPos, _boss1Center)
						local distance = (i - 1) * 8 + 4
						curPos = TensorCore.getPosInDirection(curPos, heading, distance)
						curPos.h = heading + math.pi / 2
						table.insert(mmd.aoeGroudWater.DrawPos[i], curPos)
					end
				end
			else
				local pos
				if timer < 5000 then
					pos = mmd.aoeGroudWater.DrawPos[1]
				elseif timer < 7000 then
					pos = mmd.aoeGroudWater.DrawPos[2]
				elseif timer < 9000 then
					pos = mmd.aoeGroudWater.DrawPos[3]
				elseif timer < 11000 then
					pos = mmd.aoeGroudWater.DrawPos[4]
				elseif timer < 13000 then
					pos = mmd.aoeGroudWater.DrawPos[5]
				end
				if pos ~= nil then
					for _, curPos in pairs(pos) do
						_redDrawer:addCenteredRect(curPos.x, curPos.y, curPos.z, 40, 8, curPos.h)
					end
				end
			end
		end
		if getCfg().MerchantGuide then
			if mmd.aoeGroudWater.GuidePos1 == nil then
				local mid = {
					x = (aoe[1].x + aoe[2].x) / 2,
					y = (aoe[1].y + aoe[2].y) / 2,
					z = (aoe[1].z + aoe[2].z) / 2,
				}
				local posDis = {
					16.26345596729059,
					4.949747468305833,
					6.363961030678928,
					17.67766952966369,
				}
				local dir = TensorCore.getHeadingToTarget(_boss1Center, mid)
				local selfOrder = MuAiGuide.IndexOf(_order2, MuAiGuide.SelfPos)
				local deltaDis = 1.414213562373095
				if selfOrder >= 3 then
					dir = dir + math.pi
					deltaDis = -1.414213562373095
				end
				mmd.aoeGroudWater.GuidePos1 = TensorCore.getPosInDirection(_boss1Center, dir, posDis[selfOrder])
				mmd.aoeGroudWater.GuidePos2 = TensorCore.getPosInDirection(_boss1Center, dir, posDis[selfOrder] + deltaDis)
				mmd.aoeGroudWater.WaitTime = 5000 + (selfOrder - 1) * 2000
			else
				local guidePos
				if timer < mmd.aoeGroudWater.WaitTime then
					guidePos = mmd.aoeGroudWater.GuidePos1
				else
					guidePos = mmd.aoeGroudWater.GuidePos2
				end
				MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss1_P2_Treasure then
		if getCfg().MerchantAimTool then
			OnUpDateMoveChecker()
		end
		if not getCfg().MerchantGuide and
				not mmd.spell45849.FirstBallFinish
				or changeStateByForceMoveEnd(mmd.State.Boss1_P2_End)
		then
			return
		end
		if mmd.spell45849.P1GuidePos1 == nil then
			local dangerBall = TensorCore.mGetEntity(mmd.spell45849.FirstBallIds[1])
			local dir = TensorCore.getHeadingToTarget(_boss1Center, dangerBall.pos) + math.pi
			local NewDir
			local isHigher = getP1Higher()
			if isHigher then
				NewDir = dir + math.pi / 4
			else
				NewDir = dir - math.pi / 4
			end
			local targetMid = TensorCore.getPosInDirection(_boss1Center, NewDir, 8 * 1.5 * math.sqrt(2))
			local startDir = TensorCore.getHeadingToTarget(targetMid, _boss1Center)
			mmd.spell45849.P1GuidePos1 = TensorCore.getPosInDirection(targetMid, startDir, 18)
		end
		if mmd.spell45849.P1GuidePos2 == nil then
			if table.size(mmd.spell45866.AoeInfo1) >= 2 then
				local dangerBall = TensorCore.mGetEntity(mmd.spell45849.FirstBallIds[1])
				local dir = TensorCore.getHeadingToTarget(_boss1Center, dangerBall.pos) + math.pi
				local NewDir, startDir
				local isSame = false
				for _, aoe in pairs(mmd.spell45866.AoeInfo1) do
					if MuAiGuide.IsSameDirection(aoe.heading, dir) then
						isSame = true
						break
					end
				end
				local isHigher = getP1Higher()
				local delta = 0.06
				if isSame then
					if isHigher then
						NewDir = dir + math.pi / 4 + delta
						startDir = dir + math.pi / 4 + math.pi
					else
						NewDir = dir - math.pi / 4 - delta
						startDir = dir - math.pi / 4 + math.pi
					end
				else
					if isHigher then
						NewDir = dir + math.pi / 4 - delta
						startDir = dir + math.pi / 4 + math.pi
					else
						NewDir = dir - math.pi / 4 + delta
						startDir = dir - math.pi / 4 + math.pi
					end
				end
				local targetMid = TensorCore.getPosInDirection(_boss1Center, NewDir, 8 * 1.5 * math.sqrt(2))
				mmd.spell45849.P1GuidePos2 = TensorCore.getPosInDirection(targetMid, startDir, 18)
				mmd.spell45849.P1TargetPos = targetMid
			end
		end
		if mmd.spell45849.P1BuffType == nil then
			if TensorCore.hasBuff(player.id, 2161) then
				-- 前
				mmd.spell45849.P1OffsetH = 0
				mmd.spell45849.P1BuffType = 2161
			elseif TensorCore.hasBuff(player.id, 2162) then
				-- 后
				mmd.spell45849.P1OffsetH = math.pi
				mmd.spell45849.P1BuffType = 2162
			elseif TensorCore.hasBuff(player.id, 2163) then
				-- 左 
				mmd.spell45849.P1OffsetH = -math.pi / 2
				mmd.spell45849.P1BuffType = 2163
			elseif TensorCore.hasBuff(player.id, 2164) then
				-- 右
				mmd.spell45849.P1OffsetH = math.pi / 2
				mmd.spell45849.P1BuffType = 2164
			end
		end
		if mmd.spell45849.P1GuidePos2 == nil then
			if mmd.spell45849.P1GuidePos1 ~= nil then
				MuAiGuide.FrameDirect(mmd.spell45849.P1GuidePos1.x, mmd.spell45849.P1GuidePos1.z)
			end
			return
		end
		local guidePos
		if getCfg().MerchantLockFace then
			local curBuff = TensorCore.getBuff(player.id, mmd.spell45849.P1BuffType)
			if curBuff ~= nil then
				if curBuff.duration < 1.3 and not mmd.spell45849.P1LockingFace then
					local distanceTo1 = TensorCore.getDistance2d(player.pos, mmd.spell45849.P1GuidePos2)
					if distanceTo1 < 1 then
						-- 严格在指路范围内
						local curHeading = TensorCore.getHeadingToTarget(player.pos, mmd.spell45849.P1TargetPos)
								+ mmd.spell45849.P1OffsetH
						TensorCore.API.TensorACR.setLockFaceHeading(curHeading)
						TensorCore.API.TensorACR.toggleLockFace(true)
						mmd.spell45849.P1LockingFace = true
					end
				end
				guidePos = mmd.spell45849.P1GuidePos2
			else
				if mmd.spell45849.P1LockingFace then
					local moveBuff = TensorCore.getBuff(player.id, 1257)
					if moveBuff ~= nil and moveBuff.duration < 2 then
						TensorCore.API.TensorACR.toggleLockFace(false)
						mmd.spell45849.P1LockingFace = false
					end
				end
				guidePos = mmd.spell45849.P1TargetPos
			end
		else
			guidePos = mmd.spell45849.P1TargetPos
		end
		if guidePos ~= nil then
			MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
		end
	end
end

local Boss_14323_Update = function()
	local curBoss = getCurBoss()
	if curBoss ~= nil and not curBoss.alive then
		changeState(MuAiGuide.Merchant.State.Boss3_Start)
		return
	end
	OnUpdateSpell46715()
	OnUpdateSpellRingCircle()
	local player = MuAiGuide.GetPlayer()
	local M = MuAiGuide
	local mmd = M.Merchant
	if mmd == nil or mmd.CurrentState == nil then
		return
	end
	if mmd.CurrentState == mmd.State.Boss2_P1_Start then
		if TensorCore.hasBuff(player.id, 4785)
				or TensorCore.hasBuff(player.id, 4786)
				or TensorCore.hasBuff(player.id, 4783)
				or TensorCore.hasBuff(player.id, 4779)
		then
			changeState(mmd.State.Boss2_P1_GetBuff)
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P1_GetBuff then
		for _, ent in pairs(M.Party) do
			local tethers = Argus.getTethersOnEnt(ent.id)
			for _, tether in pairs(tethers) do
				if tether.type >= 101 and tether.type <= 104 then
					changeState(mmd.State.Boss2_P1_GetLine)
					return
				end
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P1_GetLine then
		for _, ent in pairs(M.Party) do
			if TensorCore.hasBuff(ent.id, 2518)
					or TensorCore.hasBuff(ent.id, 4787)
			then
				changeState(mmd.State.Boss2_P1_LineEnd)
				break
			end
		end
		if M.HasLine(player.id, 115) then
			if mmd.B2P1SmallBlade == nil then
				mmd.B2P1SmallBlade = getTurnLineFrom(player)
			end
			if mmd.B2P1SmallBlade ~= nil then
				local linkFrom = mmd.B2P1SmallBlade.pos
				local guidePos
				-- 看看身上是什么buff
				if TensorCore.hasBuff(player.id, 4785) then
					-- 左
					if linkFrom.z < _boss2Center.z - 19 then
						-- 上
						if player.pos.x - linkFrom.x < 3 then
							guidePos = { x = linkFrom.x + 3, z = player.pos.z }
						end
					elseif linkFrom.x > _boss2Center.x + 19 then
						-- 右
						-- 无解
					elseif linkFrom.z > _boss2Center.z + 19 then
						-- 下
						if player.pos.x - linkFrom.x < 3 then
							guidePos = { x = linkFrom.x + 3, z = player.pos.z }
						end
					elseif linkFrom.x < _boss2Center.x - 19 then
						-- 左 
						guidePos = { x = player.pos.x, z = linkFrom.z }
					end
				elseif TensorCore.hasBuff(player.id, 4786) then
					-- 右
					if linkFrom.z < _boss2Center.z - 10 then
						-- 上
						if linkFrom.x - player.pos.x < 3 then
							guidePos = { x = linkFrom.x - 3, z = player.pos.z }
						end
					elseif linkFrom.x > _boss2Center.x + 10 then
						-- 右
						guidePos = { x = player.pos.x, z = linkFrom.z }
					elseif linkFrom.z > _boss2Center.z + 10 then
						-- 下
						if linkFrom.x - player.pos.x < 3 then
							guidePos = { x = linkFrom.x - 3, z = player.pos.z }
						end
					elseif linkFrom.x < _boss2Center.x - 10 then
						-- 左 
						-- 无解
					end
				elseif TensorCore.hasBuff(player.id, 4783) then
					-- 下
					if linkFrom.z < _boss2Center.z - 10 then
						-- 上
						-- 无解
					elseif linkFrom.x > _boss2Center.x + 10 then
						-- 右
						if linkFrom.z - player.pos.z < 3 then
							guidePos = { x = player.pos.x, z = linkFrom.z - 3 }
						end
					elseif linkFrom.z > _boss2Center.z + 10 then
						-- 下
						guidePos = { x = linkFrom.x, z = player.pos.z }
					elseif linkFrom.x < _boss2Center.x - 10 then
						-- 左 
						if linkFrom.z - player.pos.z < 3 then
							guidePos = { x = player.pos.x, z = linkFrom.z - 3 }
						end
					end
				elseif TensorCore.hasBuff(player.id, 4779) then
					-- 上
					if linkFrom.z < _boss2Center.z - 10 then
						-- 上
						guidePos = { x = linkFrom.x, z = player.pos.z }
					elseif linkFrom.x > _boss2Center.x + 10 then
						-- 右
						if player.pos.z - linkFrom.z < 3 then
							guidePos = { x = player.pos.x, z = linkFrom.z + 3 }
						end
					elseif linkFrom.z > _boss2Center.z + 10 then
						-- 下
					elseif linkFrom.x < _boss2Center.x - 10 then
						-- 左 
						if player.pos.z - linkFrom.z < 3 then
							guidePos = { x = player.pos.x, z = linkFrom.z + 3 }
						end
					end
				end
				if guidePos ~= nil then
					M.FrameDirect(guidePos.x, guidePos.z)
				end
			end
		else
			local targetLinkType
			if TensorCore.hasBuff(player.id, 4785) then
				-- 左
				targetLinkType = 103
			elseif TensorCore.hasBuff(player.id, 4786) then
				-- 右
				targetLinkType = 102
			elseif TensorCore.hasBuff(player.id, 4783) then
				-- 下
				targetLinkType = 104
			elseif TensorCore.hasBuff(player.id, 4779) then
				-- 上
				targetLinkType = 101
			end
			if targetLinkType ~= nil then
				if not M.HasLine(player.id, targetLinkType) then
					for _, ent in pairs(M.Party) do
						if M.HasLine(ent.id, targetLinkType) then
							local curEnt = TensorCore.mGetEntity(ent.id)
							M.FrameTakeLine(_boss2Center, curEnt.pos, player.pos)
							break
						end
					end
				end
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P2_Start then
		for _, ent in pairs(M.Party) do
			if TensorCore.hasBuff(ent.id, 2940)
			then
				changeState(mmd.State.Boss2_P2_Put)
				break
			end
		end
		if getCfg().MerchantGuide then
			local guidePos
			if M.SelfPos == "MT" then
				guidePos = { x = _boss2Center.x + 15, z = _boss2Center.z - 15 }
			elseif M.SelfPos == "H1" then
				guidePos = { x = _boss2Center.x - 15, z = _boss2Center.z - 15 }
			elseif M.SelfPos == "D1" then
				guidePos = { x = _boss2Center.x - 15, z = _boss2Center.z + 15 }
			elseif M.SelfPos == "D2" then
				guidePos = { x = _boss2Center.x + 15, z = _boss2Center.z + 15 }
			end
			M.FrameDirect(guidePos.x, guidePos.z)
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P3_Start then
		for _, ent in pairs(M.Party) do
			if TensorCore.hasBuff(ent.id, 4784)
					or TensorCore.hasBuff(ent.id, 4775)
			then
				changeState(mmd.State.Boss2_P3_GetBuff1)
				break
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P3_GetBuff1 then
		if mmd.B2P3Blade == nil then
			mmd.B2P3Blade = {}
			mmd.B2P3Blade.SmallId = {}
			mmd.B2P3Blade.Small = {}
		end
		if table.size(mmd.B2P3Blade.SmallId) < 4 then
			for _, ent in pairs(TensorCore.entityList("contentid=14326")) do
				local modelId = Argus.getEntityModel(ent.id)
				if modelId == 19227 and not table.contains(mmd.B2P3Blade.SmallId, ent.id) then
					table.insert(mmd.B2P3Blade.SmallId, ent.id)
					table.insert(mmd.B2P3Blade.Small, ent)
				end
			end
		elseif table.size(mmd.B2P3Blade.SmallId) == 4 then
			changeState(mmd.State.Boss2_P3_GetBlade)
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P3_GetBlade then
		for _, ent in pairs(M.Party) do
			if M.HasLine(ent.id, 115) then
				changeState(mmd.State.Boss2_P3_GetLine)
				return
			end
		end
		for _, ent in pairs(M.Party) do
			local buffType
			if TensorCore.hasBuff(ent.id, 4784) then
				buffType = 4784
			elseif TensorCore.hasBuff(ent.id, 4775) then
				buffType = 4775
			end
			local linkFrom = getTurnLineFrom(ent, buffType)
			if linkFrom ~= nil then
				changeState(mmd.State.Boss2_P3_GetLine)
				return
			end
		end
		if getCfg().MerchantGuide then
			if TensorCore.hasBuff(player.id, 4784) then
				local guidePos1 = { x = _boss2Center.x, z = _boss2Center.z - 5 }
				local guidePos2 = { x = _boss2Center.x, z = _boss2Center.z + 5 }
				local dis1 = TensorCore.getDistance2d(player.pos, guidePos1)
				local dis2 = TensorCore.getDistance2d(player.pos, guidePos2)
				if dis1 < dis2 then
					mmd.P3GetLineGuidePos0 = guidePos1
				else
					mmd.P3GetLineGuidePos0 = guidePos2
				end
			elseif TensorCore.hasBuff(player.id, 4775) then
				local guidePos1 = { x = _boss2Center.x - 5, z = _boss2Center.z }
				local guidePos2 = { x = _boss2Center.x + 5, z = _boss2Center.z }
				local dis1 = TensorCore.getDistance2d(player.pos, guidePos1)
				local dis2 = TensorCore.getDistance2d(player.pos, guidePos2)
				if dis1 < dis2 then
					mmd.P3GetLineGuidePos0 = guidePos1
				else
					mmd.P3GetLineGuidePos0 = guidePos2
				end
			end
			if mmd.P3GetLineGuidePos0 ~= nil then
				local guidePos = mmd.P3GetLineGuidePos0
				M.FrameDirect(guidePos.x, guidePos.z)
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P3_GetLine then
		if mmd.P3GetLineGuidePos == nil or MuAiGuide.ScriptDevelopMode then
			local buffType
			if TensorCore.hasBuff(player.id, 4784) then
				buffType = 4784
			elseif TensorCore.hasBuff(player.id, 4775) then
				buffType = 4775
			end
			local linkFrom = getTurnLineFrom(player, buffType)
			if linkFrom ~= nil then
				if TensorCore.hasBuff(player.id, 4784) then
					--可以打左右
					if linkFrom.pos.x > _boss2Center.x + 18 then
						--如果连线来源在右边
						mmd.P3GetLineGuidePos = { x = _boss2Center.x - 19, z = linkFrom.pos.z }
					elseif linkFrom.pos.x < _boss2Center.x - 18 then
						--如果连线来源在左边
						mmd.P3GetLineGuidePos = { x = _boss2Center.x + 19, z = linkFrom.pos.z }
					else
						local partnerFrom
						for _, ent in pairs(M.Party) do
							if ent.id ~= player.id and TensorCore.hasBuff(ent.id, 4784) then
								local curEnt = TensorCore.mGetEntity(ent.id)
								partnerFrom = getTurnLineFrom(curEnt, 4784)
							end
						end
						if partnerFrom ~= nil then
							if partnerFrom.pos.x > _boss2Center.x + 18 then
								-- 如果队友连线在右边
								mmd.P3GetLineGuidePos = { x = _boss2Center.x + 19, z = _boss2Center.z - 5 }
							elseif partnerFrom.pos.x < _boss2Center.x - 18 then
								mmd.P3GetLineGuidePos = { x = _boss2Center.x - 19, z = _boss2Center.z + 5 }
							else
								if partnerFrom.pos.z > linkFrom.pos.z then
									mmd.P3GetLineGuidePos = { x = _boss2Center.x + 19, z = _boss2Center.z - 5 }
								else
									mmd.P3GetLineGuidePos = { x = _boss2Center.x - 19, z = _boss2Center.z + 5 }
								end
							end
						end
					end
				elseif TensorCore.hasBuff(player.id, 4775) then
					--可以打上下
					--_redDrawer:addCircle(linkFrom.pos.x , linkFrom.pos.y, linkFrom.pos.z, 3, true)
					if linkFrom.pos.z < _boss2Center.z - 18 then
						--如果我的连线在上
						mmd.P3GetLineGuidePos = { x = linkFrom.pos.x, z = _boss2Center.z + 19 }
					elseif linkFrom.pos.z > _boss2Center.z + 18 then
						--如果我的连线在下
						mmd.P3GetLineGuidePos = { x = linkFrom.pos.x, z = _boss2Center.z - 19 }
					else
						local partnerFrom
						for _, ent in pairs(M.Party) do
							if ent.id ~= player.id and TensorCore.hasBuff(ent.id, 4775) then
								local curEnt = TensorCore.mGetEntity(ent.id)
								partnerFrom = getTurnLineFrom(curEnt, 4775)
							end
						end
						if partnerFrom ~= nil then
							if partnerFrom.pos.z < _boss2Center.z - 18 then
								--如果同组的线在上
								mmd.P3GetLineGuidePos = { x = _boss2Center.x - 5, z = _boss2Center.z - 19 }
							elseif partnerFrom.pos.z > _boss2Center.z + 18 then
								--如果同组的线在下
								mmd.P3GetLineGuidePos = { x = _boss2Center.x + 5, z = _boss2Center.z + 19 }
							else
								--都不是，看相对位置
								if partnerFrom.pos.x > linkFrom.pos.x then
									mmd.P3GetLineGuidePos = { x = _boss2Center.x - 5, z = _boss2Center.z - 19 }
								else
									mmd.P3GetLineGuidePos = { x = _boss2Center.x + 5, z = _boss2Center.z + 19 }
								end
							end
						end
					end
				end
			end
		end
		if getCfg().MerchantGuide and mmd.P3GetLineGuidePos then
			local guidePos = mmd.P3GetLineGuidePos
			M.FrameDirect(guidePos.x, guidePos.z)
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P3_4Blade1 then
		if MuAiGuide.Merchant.spell46715 then
			return
		end
		guide4Blade(1)
	elseif mmd.CurrentState == mmd.State.Boss2_P3_4Blade2 then
		guide4Blade(2)
	elseif mmd.CurrentState == mmd.State.Boss2_P3_4Blade3 then
		guide4Blade(3)
	elseif mmd.CurrentState == mmd.State.Boss2_P3_4AddMark
			or mmd.CurrentState == mmd.State.Boss2_P3_4Blade4 then
		if mmd.B2P3Blade["Big4"] == nil then
			mmd.B2P3Blade["Big4"] = {}
		end
		if table.size(mmd.B2P3Blade.BigIds) < 16 then
			getBladeTable(mmd.B2P3Blade["Big4"], mmd.B2P3Blade.BigIds)
		elseif table.size(mmd.B2P3Blade.BigIds) == 16 then
			if TensorCore.hasBuff(player.id, 4781) then
				-- 右上不能被攻击
				if M.HasLine(player.id, 103) then
					mmd.B2P3SafePos = "down"
				elseif M.HasLine(player.id, 104) then
					mmd.B2P3SafePos = "left"
				end
			elseif TensorCore.hasBuff(player.id, 4782) then
				-- 左上不能被攻击
				if M.HasLine(player.id, 102) then
					mmd.B2P3SafePos = "down"
				elseif M.HasLine(player.id, 104) then
					mmd.B2P3SafePos = "right"
				end
			elseif TensorCore.hasBuff(player.id, 4777) then
				-- 右下不能被攻击
				if M.HasLine(player.id, 103) then
					mmd.B2P3SafePos = "up"
				elseif M.HasLine(player.id, 101) then
					mmd.B2P3SafePos = "left"
				end
			elseif TensorCore.hasBuff(player.id, 4778) then
				-- 左下不能被攻击
				if M.HasLine(player.id, 102) then
					mmd.B2P3SafePos = "up"
				elseif M.HasLine(player.id, 101) then
					mmd.B2P3SafePos = "right"
				end
			end
			if mmd.B2P3SafePos ~= nil then
				local takeBlade
				for _, blade in pairs(mmd.B2P3Blade["Big4"]) do
					if blade.dirType == mmd.B2P3SafePos then
						takeBlade = blade.entity
						break
					end
				end
				if takeBlade ~= nil then
					local guidePos
					if mmd.B2P3SafePos == "up" then
						if takeBlade.pos.x > _boss2Center.x then
							guidePos = { x = takeBlade.pos.x, z = takeBlade.pos.z + 38 }
						else
							guidePos = { x = takeBlade.pos.x, z = takeBlade.pos.z + 2 }
						end
					elseif mmd.B2P3SafePos == "down" then
						if takeBlade.pos.x > _boss2Center.x then
							guidePos = { x = takeBlade.pos.x, z = takeBlade.pos.z - 2 }
						else
							guidePos = { x = takeBlade.pos.x, z = takeBlade.pos.z - 38 }
						end
					elseif mmd.B2P3SafePos == "left" then
						if takeBlade.pos.z > _boss2Center.z then
							guidePos = { x = takeBlade.pos.x + 2, z = takeBlade.pos.z }
						else
							guidePos = { x = takeBlade.pos.x + 38, z = takeBlade.pos.z }
						end
					elseif mmd.B2P3SafePos == "right" then
						if takeBlade.pos.z > _boss2Center.z then
							guidePos = { x = takeBlade.pos.x - 38, z = takeBlade.pos.z }
						else
							guidePos = { x = takeBlade.pos.x - 2, z = takeBlade.pos.z }
						end
					end
					if guidePos ~= nil then
						M.FrameDirect(guidePos.x, guidePos.z)
					end
				end
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P3_4BladeEnd then
		local guidePos
		if mmd.B2P3SafePos ~= nil then
			if mmd.B2P3SafePos == "up" then
				guidePos = { x = _boss2Center.x, z = _boss2Center.z + 3 }
			elseif mmd.B2P3SafePos == "down" then
				guidePos = { x = _boss2Center.x, z = _boss2Center.z - 3 }
			elseif mmd.B2P3SafePos == "left" then
				guidePos = { x = _boss2Center.x + 3, z = _boss2Center.z }
			elseif mmd.B2P3SafePos == "right" then
				guidePos = { x = _boss2Center.x - 3, z = _boss2Center.z }
			end
		end
		if guidePos ~= nil then
			M.FrameDirect(guidePos.x, guidePos.z)
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P4_Start then
		if mmd.P4Stone == nil then
			mmd.P4Stone = {}
			mmd.P4StoneIds = {}
		end
		if table.size(mmd.P4StoneIds) < 2 then
			for _, ent in pairs(TensorCore.entityList("contentid=14324")) do
				if Argus.isEntityVisible(ent) and not table.contains(mmd.P4StoneIds, ent.id) then
					table.insert(mmd.P4StoneIds, ent.id)
					table.insert(mmd.P4Stone, ent)
				end
			end
		else
			if table.size(mmd.P4StoneIds) == 2 then
				changeState(mmd.State.Boss2_P4_GetStone)
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P4_GetStone then
		if mmd.P4_GetStoneGuidePos == nil then
			local stone1 = MuAiGuide.Merchant.P4Stone[1]
			local stone2 = MuAiGuide.Merchant.P4Stone[2]
			local heading = TensorCore.getHeadingToTarget(stone1.pos, stone2.pos)
			local guideHeading = heading + math.pi / 2
			local guidePos1 = TensorCore.getPosInDirection(_boss2Center, guideHeading, 27)
			local guidePos2 = TensorCore.getPosInDirection(_boss2Center, guideHeading + math.pi, 28)
			if guidePos1.z > guidePos2.z then
				guidePos1, guidePos2 = guidePos2, guidePos1
			end
			local tethers = Argus.getTethersOnEnt(player.id)
			if tethers ~= nil and table.size(tethers) ~= 0 then
				local partner
				for _, tether in pairs(tethers) do
					if tether.type == 163 then
						partner = TensorCore.mGetEntity(tether.partnerid)
						break
					end
				end
				local otherJob
				for job, ent in pairs(M.Party) do
					if partner.id == ent.id then
						otherJob = job
					end
				end
				local selfJobIdx = M.IndexOf(_order, M.SelfPos)
				local otherJobIdx = M.IndexOf(_order, otherJob)
				if selfJobIdx < otherJobIdx then
					mmd.P4_GetStoneGuidePos = guidePos1
				else
					mmd.P4_GetStoneGuidePos = guidePos2
				end
				mmd.Timer = Now()
			end
		else
			if mmd.Timer > 0 and TimeSince(mmd.Timer) < 5500 then
				local guidePos = mmd.P4_GetStoneGuidePos
				M.FrameDirect(guidePos.x, guidePos.z)
			else
				changeState(mmd.State.Boss2_P4_Linked)
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P4_Linked then
		if mmd.P4Blade == nil then
			mmd.P4Blade = {
				[1] = {},
				[2] = {},
				[3] = {},
				[4] = {},
			}
			mmd.P4BladeIds = {}
		end
		if mmd.P4SelfSafeDir == nil then
			if TensorCore.hasBuff(player.id, 4785) then
				-- 左
				mmd.P4SelfSafeDir = "left"
			elseif TensorCore.hasBuff(player.id, 4786) then
				-- 右
				mmd.P4SelfSafeDir = "right"
			elseif TensorCore.hasBuff(player.id, 4783) then
				-- 下
				mmd.P4SelfSafeDir = "down"
			elseif TensorCore.hasBuff(player.id, 4779) then
				-- 上
				mmd.P4SelfSafeDir = "up"
			end
		else
			changeState(mmd.State.Boss2_P4_GetBuff)
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P4_GetBuff then
		if mmd.P4BladeGuidePos == nil then
			mmd.P4BladeGuidePos = {}
		end
		drawerB2P4Blade(1)
	elseif mmd.CurrentState == mmd.State.Boss2_P4_Blade1 then
		drawerB2P4Blade(2)
	elseif mmd.CurrentState == mmd.State.Boss2_P4_Blade2 then
		drawerB2P4Blade(3)
	elseif mmd.CurrentState == mmd.State.Boss2_P4_Blade3 then
		drawerB2P4Blade(4)
	end
end

local Boss_14274_Update = function()
	local curBoss = getCurBoss()
	if curBoss ~= nil and not curBoss.alive then
		changeState(MuAiGuide.Merchant.State.Boss3_P4_End)
		return
	end
	local mmd = MuAiGuide.Merchant
	if mmd == nil or mmd.CurrentState == nil then
		return
	end
	if mmd.CurrentState == mmd.State.Boss3_P1_Start then
		local mmdd = MuAiGuide.Merchant.fireDance
		if curBoss == nil then
			return
		end
		if mmdd.state == 0 then
			if table.size(mmdd.routeInfo) < 3 then
				if table.size(mmdd.tethers) < 3 then
					local tethers = Argus.getCurrentTethers()
					if tethers ~= nil and table.size(tethers) > 0 then
						for entId, allTe in pairs(tethers) do
							if mmdd.tethers[entId] == nil then
								mmdd.tethers[entId] = allTe
							end
						end
					end
				elseif table.size(mmdd.tethers) == 3 then
					local routeInfoData = {}
					local cIndex = 1
					for id, tethers in pairs(mmdd.tethers) do
						for _, tether in pairs(tethers) do
							local from = TensorCore.mGetEntity(id)
							local target = TensorCore.mGetEntity(tether.targetid)
							local mid = {
								x = (from.pos.x + target.pos.x) / 2,
								y = (from.pos.y + target.pos.y) / 2,
								z = (from.pos.z + target.pos.z) / 2
							}
							local heading = TensorCore.getHeadingToTarget(from.pos, target.pos) + mmdd.aoeHeading
							local curRoute = {
								startEnt = from,
								endEnt = target,
								drawPoint = mid,
								drawHeading = heading,
								index = cIndex
							}
							cIndex = cIndex + 1
							table.insert(routeInfoData, curRoute)
							break
						end
					end
					local boss = getCurBoss()
					local first, second, third
					for _, info in pairs(routeInfoData) do
						if TensorCore.getDistance2d(info.startEnt.pos, boss.pos) < 0.5 then
							first = info
							break
						end
						if TensorCore.getDistance2d(info.endEnt.pos, boss.pos) < 0.5 then
							first = info
							info.startEnt, info.endEnt = info.endEnt, info.startEnt
							break
						end
					end

					for _, info in pairs(routeInfoData) do
						if info.index ~= first.index then
							if TensorCore.getDistance2d(info.startEnt.pos, first.endEnt.pos) < 0.5 then
								second = info
								break
							end
							if TensorCore.getDistance2d(info.endEnt.pos, first.endEnt.pos) < 0.5 then
								second = info
								info.startEnt, info.endEnt = info.endEnt, info.startEnt
								break
							end
						end
					end

					for _, info in pairs(routeInfoData) do
						if info.index ~= first.index and info.index ~= second.index then
							if TensorCore.getDistance2d(info.startEnt.pos, second.endEnt.pos) < 0.5 then
								third = info
								break
							end
							if TensorCore.getDistance2d(info.endEnt.pos, second.endEnt.pos) < 0.5 then
								third = info
								info.startEnt, info.endEnt = info.endEnt, info.startEnt
								break
							end
						end
					end
					table.insert(mmdd.routeInfo, first)
					table.insert(mmdd.routeInfo, second)
					table.insert(mmdd.routeInfo, third)
					mmdd.state = 1
				end
			end
		elseif mmdd.state <= 3 then
			onJumpDraw()
		elseif mmdd.state == 4 then
			if (MuAiGuide.Merchant.Timer ~= 0 and TimeSince(MuAiGuide.Merchant.Timer) > 4500) then
				MuAiGuide.Merchant.Timer = 0
				MuAiGuide.Merchant.fireDance = {
					inState = false,
					state = 0,
					spellId = 0,
					aoeHeading = 0,
					tethers = {},
					routeInfo = {}
				}
				changeState(MuAiGuide.Merchant.State.Boss3_P1_FireDance)
			end
			-- 到地方了 开始画月环
			if MuAiGuide.Merchant.Timer == 0 or TimeSince(MuAiGuide.Merchant.Timer) < 2000 then
				local point = mmdd.routeInfo[3].endEnt.pos
				_redDrawer:addDonut(point.x, point.y, point.z, 8, 45)
			end
			if (MuAiGuide.Merchant.Timer == 0 or TimeSince(MuAiGuide.Merchant.Timer) < 3500) then
				if mmdd.spellId == 45434 or mmdd.spellId == 45435 or mmdd.spellId == 45444 then
					for _, ent in pairs(MuAiGuide.Party) do
						local curMember = TensorCore.mGetEntity(ent.id)
						_redDrawer:addCircle(curMember.pos.x, curMember.pos.y, curMember.pos.z, 4)
					end
				else
					local allInRange = true
					local player = MuAiGuide.GetPlayer()
					for _, ent in pairs(MuAiGuide.Party) do
						local curEnt = TensorCore.mGetEntity(ent.id)
						if ent.id ~= player.id and TensorCore.getDistance2d(curEnt.pos, player.pos) > 4 then
							allInRange = false
							break
						end
					end
					local drawer
					if allInRange then
						drawer = _greenDrawer
					else
						drawer = _yellowDrawer
					end
					if getCfg().MerchantDraw then
						drawer:addCircle(player.pos.x, player.pos.y, player.pos.z, 4)
					end
				end
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss3_P1_FireDance then
		if table.size(mmd.B3P1Sub.ids) < 4 then
			for _, ent in pairs(TensorCore.entityList("contentid=14275")) do
				if Argus.isEntityVisible(ent) and not table.contains(mmd.B3P1Sub.ids, ent.id) then
					table.insert(mmd.B3P1Sub.ids, ent.id)
					table.insert(mmd.B3P1Sub.entities, ent)
				end
			end
		end
		if mmd.B3P1Sub.Timer > 0 and TimeSince(mmd.B3P1Sub.Timer) > 5000 then
			for _, ent in pairs(MuAiGuide.Party) do
				if TensorCore.getBuff(ent.id, 2937) then
					changeState(mmd.State.Boss3_P1_End)
					return
				end
			end
		end
		if table.size(mmd.B3P1Sub.ids) == 4
				and table.size(mmd.B3P1Sub.AOEs) == 4
				and table.size(mmd.B3P1Sub.marks) == 4
		then
			for _, ent in pairs(mmd.B3P1Sub.entities) do
				local mark = mmd.B3P1Sub.marks[ent.id]
				local heading = mmd.B3P1Sub.AOEs[ent.id].heading
				if mark == 646 or mark == 628 then
					heading = heading - math.pi / 2
				elseif mark == 647 or mark == 629 then
					heading = heading + math.pi / 2
				end
				if getCfg().MerchantDraw then
					_redDrawer:addRect(ent.pos.x, ent.pos.y, ent.pos.z, 40, 60, heading)
				end
			end
		end
		if mmd.B3P1Sub.spellId ~= 0 and getCfg().MerchantDraw then
			local player = MuAiGuide.GetPlayer()
			if 45538 <= mmd.B3P1Sub.spellId and mmd.B3P1Sub.spellId <= 45540 then
				-- 对火花
				for _, ent in pairs(MuAiGuide.Party) do
					if MuAiGuide.IsDps(player.job) and not MuAiGuide.IsDps(ent.job)
							or not MuAiGuide.IsDps(player.job) and MuAiGuide.IsDps(ent.job)
					then
						local curMember = TensorCore.mGetEntity(ent.id)
						_greenDrawer:addCircle(curMember.pos.x, curMember.pos.y, curMember.pos.z, 6)
					end
				end
			elseif (mmd.B3P1Sub.spellId == 45536 or mmd.B3P1Sub.spellId == 45537) then
				--散火花 
				for _, ent in pairs(MuAiGuide.Party) do
					local curMember = TensorCore.mGetEntity(ent.id)
					_purpleDrawer:addCircle(curMember.pos.x, curMember.pos.y, curMember.pos.z, 6)
				end
			end
		end
	elseif mmd.State.Boss3_P2_Start <= mmd.CurrentState and mmd.CurrentState <= mmd.State.Boss3_P2_Turn4 then
		if table.size(mmd.B3P2FireDance.auras) < 4 then
			if mmd.Timer ~= 0 then
				local timeSince = TimeSince(mmd.Timer)
				if timeSince > 100 and timeSince < 500 then
					local _, a2, _ = Argus.getEntityAuras(getCurBoss())
					if a2 ~= nil and a2 ~= 0 then
						table.insert(mmd.B3P2FireDance.auras, a2)
						d("记录光环：" .. a2)
						mmd.Timer = 0
					end
				end
			end
		end
		if mmd.CurrentState == mmd.State.Boss3_P2_Start then
			if table.size(mmd.B3P2FireDance.auras) > 0
					and table.size(mmd.B3P2FireDance.marks) > 0
					and MuAiGuide.Merchant.B3P2FireDance.aoeInfo ~= nil
			then
				mmd.B3P2FireDance.curDir = mmd.B3P2FireDance.aoeInfo.heading
				mmd.B3P2FireDance.near = _boss3Center
				mmd.B3P2FireDance.far = { x = _boss3Center.x + 10, y = _boss3Center.y, z = _boss3Center.z }
				mmd.B3P2FireDance.mid = { x = _boss3Center.x + 5, y = _boss3Center.y, z = _boss3Center.z }
				changeState(mmd.State.Boss3_P2_GetBuff)
			end
		elseif mmd.CurrentState == mmd.State.Boss3_P2_GetBuff then
			boss3FireDance2(mmd.State.Boss3_P2_Turn1, 1)
		elseif mmd.CurrentState == mmd.State.Boss3_P2_Turn1 then
			boss3FireDance2(mmd.State.Boss3_P2_Turn2, 2)
		elseif mmd.CurrentState == mmd.State.Boss3_P2_Turn2 then
			boss3FireDance2(mmd.State.Boss3_P2_Turn3, 3)
		elseif mmd.CurrentState == mmd.State.Boss3_P2_Turn3 then
			boss3FireDance2(mmd.State.Boss3_P2_Turn4, 4)
		end
	elseif mmd.CurrentState < mmd.State.Boss3_P2_End then
		local player = MuAiGuide.GetPlayer()
		for _, ent in pairs(MuAiGuide.Party) do
			if TensorCore.hasBuff(ent.id, 2941)
			then
				changeState(mmd.State.Boss3_P2_End)
				return
			end
		end
		if mmd.B3P2Phantom.aoeInfo ~= nil then
			_redDrawer:addRect(_boss3Center.x, _boss3Center.y, _boss3Center.z, 28.5, 56.6, mmd.B3P2Phantom.aoeInfo.heading)
		end
		if mmd.B3P2Phantom.blueOrbOldPos == nil then
			for _, ent in pairs(TensorCore.entityList("contentid=14278")) do
				if Argus.isEntityVisible(ent) then
					mmd.B3P2Phantom.blueOrbOldPos = ent.pos
					break
				end
			end
		end
		if mmd.CurrentState == mmd.State.Boss3_P2_StartCarry then
			if mmd.B3P2Phantom.blanketWithBlueOrb == nil then
				for _, ent in pairs(TensorCore.entityList("contentid=14276")) do
					if Argus.isEntityVisible(ent)
							and not table.contains(mmd.B3P2Phantom.blanketIds, ent.id) then
						table.insert(mmd.B3P2Phantom.blanketIds, ent.id)
						table.insert(mmd.B3P2Phantom.blankets, ent)
					end
					if table.size(mmd.B3P2Phantom.blanketIds) == 3 then
						for _, blanket in pairs(mmd.B3P2Phantom.blankets) do
							if TensorCore.getDistance2d(blanket.pos, mmd.B3P2Phantom.blueOrbOldPos) < 0.5 then
								mmd.B3P2Phantom.blanketWithBlueOrb = blanket
								break
							end
						end
					end
				end
			else
				changeState(mmd.State.Boss3_P2_GetKeyBlanket)
			end
		elseif mmd.CurrentState == mmd.State.Boss3_P2_CarryEnd then
			if mmd.B3P2Phantom.blueOrbNewPos == nil then
				local curEnt = TensorCore.mGetEntity(mmd.B3P2Phantom.blanketWithBlueOrb.id)
				mmd.B3P2Phantom.blueOrbNewPos = curEnt.pos
			end
			if mmd.B3P2Phantom.blueOrbNewPos ~= nil and getCfg().MerchantGuide then
				if mmd.B3P2Phantom.GuidePos == nil then
					local _curBlankets = {}
					for _, ent in pairs(mmd.B3P2Phantom.blankets) do
						table.insert(_curBlankets, TensorCore.mGetEntity(ent.id))
					end
					local dis12 = TensorCore.getDistance2d(_curBlankets[1].pos, _curBlankets[2].pos)
					local dis23 = TensorCore.getDistance2d(_curBlankets[2].pos, _curBlankets[3].pos)
					local dis13 = TensorCore.getDistance2d(_curBlankets[1].pos, _curBlankets[3].pos)
					local topPos, MidPos
					if math.abs(dis12 - dis23) < 0.1 then
						topPos = _curBlankets[2].pos
						MidPos = {
							x = (_curBlankets[1].pos.x + _curBlankets[3].pos.x) / 2,
							y = _boss3Center.y,
							z = (_curBlankets[1].pos.z + _curBlankets[3].pos.z) / 2,
						}
					elseif math.abs(dis12 - dis13) < 0.1 then
						topPos = _curBlankets[1].pos
						MidPos = {
							x = (_curBlankets[2].pos.x + _curBlankets[3].pos.x) / 2,
							y = _boss3Center.y,
							z = (_curBlankets[2].pos.z + _curBlankets[3].pos.z) / 2,
						}
					elseif math.abs(dis13 - dis23) < 0.1 then
						topPos = _curBlankets[3].pos
						MidPos = {
							x = (_curBlankets[1].pos.x + _curBlankets[2].pos.x) / 2,
							y = _boss3Center.y,
							z = (_curBlankets[1].pos.z + _curBlankets[2].pos.z) / 2,
						}
					end
					local dir = TensorCore.getHeadingToTarget(topPos, MidPos)
					local safePoints = {
						TensorCore.getPosInDirection(topPos, dir - math.pi / 4, 22.5),
						TensorCore.getPosInDirection(topPos, dir, 28.5),
						TensorCore.getPosInDirection(topPos, dir + math.pi / 4, 22.5),
					}
					local safeIce = {}
					for i = 1, 3 do
						local pos = safePoints[i]
						local xRangeMax = mmd.B3P2Phantom.blueOrbNewPos.x + 5
						local xRangeMin = mmd.B3P2Phantom.blueOrbNewPos.x - 5
						local zRangeMax = mmd.B3P2Phantom.blueOrbNewPos.z + 5
						local zRangeMin = mmd.B3P2Phantom.blueOrbNewPos.z - 5
						if xRangeMin < pos.x and pos.x < xRangeMax
								or zRangeMin < pos.z and pos.z < zRangeMax
						then
							pos.iceCross = true
							table.insert(safeIce, pos)
						else
							pos.iceCross = false
						end
					end
					if not TensorCore.hasBuff(player.id, 4617) then
						for _, p in pairs(safePoints) do
							if p.iceCross == false then
								mmd.B3P2Phantom.GuidePos = p
								break
							end
						end
					else
						local cnt = 0
						local otherJob
						for job, ent in pairs(MuAiGuide.Party) do
							if TensorCore.hasBuff(ent.id, 4617) then
								cnt = cnt + 1
								if ent.id ~= player.id then
									otherJob = job
								end
							end
						end
						if cnt == 2 then
							local selfIdx = MuAiGuide.IndexOf(_order, MuAiGuide.SelfPos)
							local otherIdx = MuAiGuide.IndexOf(_order, otherJob)
							if selfIdx < otherIdx then
								mmd.B3P2Phantom.GuidePos = safeIce[1]
							else
								mmd.B3P2Phantom.GuidePos = safeIce[2]
							end
						elseif cnt == 3 then
							if TensorCore.hasBuff(player.id, 4615) then
								mmd.B3P2Phantom.GuidePos = safeIce[2]
							else
								mmd.B3P2Phantom.GuidePos = safeIce[1]
							end
						end
					end
				else
					local guidePos = mmd.B3P2Phantom.GuidePos
					MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
				end
			end
		end
		if mmd.B3P2Phantom.blueOrbNewPos ~= nil then
			local pos = mmd.B3P2Phantom.blueOrbNewPos
			_cyanDrawer:addCross(pos.x, pos.y, pos.z, 40, 10, 0)
			_redDrawer:addCenteredRect(pos.x, pos.y, pos.z, 10, 10, 0)
		end
		for _, ent in pairs(TensorCore.entityList("contentid=14277")) do
			if Argus.isEntityVisible(ent) then
				_redDrawer:addCross(ent.pos.x, ent.pos.y, ent.pos.z, 40, 10, 0)
			end
		end
		for _, ent in pairs(MuAiGuide.Party) do
			local disBuff = TensorCore.getBuff(ent.id, 4615)
			if disBuff ~= nil and disBuff.duration < 6 then
				local curEnt = TensorCore.mGetEntity(ent.id)
				_blueDrawer:addCircle(curEnt.pos.x, curEnt.pos.y, curEnt.pos.z, 13)
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss3_P3_GetFirstFire then
		if mmd.B3P3FireGuidePos == nil then
			local upCnt = 0
			local downCnt = 0
			for _, fireAoe in pairs(mmd.B3P3Fire) do
				if fireAoe.z < _boss3Center.z - 11 then
					upCnt = upCnt + 1
				elseif fireAoe.z > _boss3Center.z + 11 then
					downCnt = downCnt + 1
				end
			end
			if upCnt > downCnt then
				mmd.B3P3FireType = "up"
				mmd.B3P3FireGuidePos = { x = _boss3Center.x - 19, z = _boss3Center.z - 19 }
			else
				mmd.B3P3FireType = "down"
				mmd.B3P3FireGuidePos = { x = _boss3Center.x + 19, z = _boss3Center.z + 19 }
			end
		else
			local guidePos = mmd.B3P3FireGuidePos
			MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
		end
	elseif mmd.CurrentState == mmd.State.Boss3_P3_GetPillar then
		if TensorCore.hasBuff(MuAiGuide.GetPlayer().id, 769) then
			changeState(mmd.State.Boss3_P3_GetBuff)
		end
	elseif mmd.CurrentState == mmd.State.Boss3_P3_GetBuff then
		for _, ent in pairs(MuAiGuide.Party) do
			if TensorCore.hasBuff(ent.id, 2937) then
				changeState(mmd.State.Boss3_P3_End)
				return
			end
		end
		if mmd.B3P3FireGuidePos2 == nil then
			local firstFire, LastFire
			if mmd.B3P3FireType == "up" then
				if mmd.B3P3Pillar[1].z > mmd.B3P3Pillar[2].z then
					firstFire = mmd.B3P3Pillar[1]
				else
					firstFire = mmd.B3P3Pillar[2]
				end
				if mmd.B3P3Pillar[7].z > mmd.B3P3Pillar[8].z then
					LastFire = mmd.B3P3Pillar[7]
				else
					LastFire = mmd.B3P3Pillar[8]
				end
				if mmd.B3P3FireLinkType.buff == 4845 then
					if mmd.B3P3FireLinkType.isHigh then
						mmd.B3P3FireGuidePos2 = {
							x = _boss3Center.x - 19,
							z = _boss3Center.z + 19
						}
					else
						mmd.B3P3FireGuidePos2 = {
							x = _boss3Center.x + 19,
							z = LastFire.z + 10.5
						}
					end
				else
					if mmd.B3P3FireLinkType.isHigh then
						mmd.B3P3FireGuidePos2 = {
							x = _boss3Center.x - 19,
							z = firstFire.z + 10.5
						}
					else
						mmd.B3P3FireGuidePos2 = {
							x = _boss3Center.x + 19,
							z = _boss3Center.z + 19
						}
					end
				end
			else
				if mmd.B3P3Pillar[1].z < mmd.B3P3Pillar[2].z then
					firstFire = mmd.B3P3Pillar[1]
				else
					firstFire = mmd.B3P3Pillar[2]
				end
				if mmd.B3P3Pillar[7].z < mmd.B3P3Pillar[8].z then
					LastFire = mmd.B3P3Pillar[7]
				else
					LastFire = mmd.B3P3Pillar[8]
				end
				if mmd.B3P3FireLinkType.buff == 4845 then
					if mmd.B3P3FireLinkType.isHigh then
						mmd.B3P3FireGuidePos2 = {
							x = _boss3Center.x + 19,
							z = _boss3Center.z - 19
						}
					else
						mmd.B3P3FireGuidePos2 = {
							x = _boss3Center.x - 19,
							z = LastFire.z - 10.5
						}
					end
				else
					if mmd.B3P3FireLinkType.isHigh then
						mmd.B3P3FireGuidePos2 = {
							x = _boss3Center.x + 19,
							z = firstFire.z - 10.5
						}
					else
						mmd.B3P3FireGuidePos2 = {
							x = _boss3Center.x - 19,
							z = _boss3Center.z - 19
						}
					end
				end
			end
		else
			local guidePos = mmd.B3P3FireGuidePos2
			MuAiGuide.FrameDirect(guidePos.x, guidePos.z)
		end
	elseif mmd.CurrentState < mmd.State.Boss3_P4_Tower2 then
		if mmd.CurrentState == mmd.State.Boss3_P4_Start then
			if table.size(mmd.B3P4Tower1) == 4 then
				guideToTower(mmd.B3P4Tower1, 1)
			end
		elseif mmd.CurrentState == mmd.State.Boss3_P4_Tower1 then
			if table.size(mmd.B3P4Tower2) == 4 then
				guideToTower(mmd.B3P4Tower2, 2)
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss3_P4_Tower2 then
		for _, ent in pairs(MuAiGuide.Party) do
			if TensorCore.hasBuff(ent.id, 2937) then
				changeState(mmd.State.Boss3_P4_FireStone)
				return
			end
		end
		for _, ent in pairs(TensorCore.entityList("contentid=14277")) do
			if Argus.isEntityVisible(ent) then
				if not table.contains(mmd.B3P4FineStoneIdsOld, ent.id) then
					table.insert(mmd.B3P4FineStoneIdsOld, ent.id)
				end
				_redDrawer:addCross(ent.pos.x, ent.pos.y, ent.pos.z, 40, 10, 0)
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss3_P4_FireStone then
		if not getCfg().MerchantDraw
				or (mmd.Timer47031 == 0 or TimeSince(mmd.Timer47031) < 2000) then
			return
		end
		if table.size(mmd.B3P4FineStoneIds) < 8 then
			for _, ent in pairs(TensorCore.entityList("contentid=14277")) do
				if Argus.isEntityVisible(ent)
						and not table.contains(mmd.B3P4FineStoneIds, ent.id) then
					if mmd.B3P4FineStoneEnts[mmd.B3P4FineStoneIndex] == nil then
						mmd.B3P4FineStoneEnts[mmd.B3P4FineStoneIndex] = {}
					end
					table.insert(mmd.B3P4FineStoneIds, ent.id)
					table.insert(mmd.B3P4FineStoneEnts[mmd.B3P4FineStoneIndex], ent)
					if table.size(mmd.B3P4FineStoneIds) % 2 == 0 then
						mmd.B3P4FineStoneIndex = mmd.B3P4FineStoneIndex + 1
					end
				end
			end
		end
		if (mmd.Timer47031) == 0 then
			return
		end
		if TimeSince(mmd.Timer47031) < 20000 then
			if mmd.B3P4FineStoneEnts[1] ~= nil
					and table.size(mmd.B3P4FineStoneEnts[1]) >= 2
					and table.size(mmd.B3P4FineStoneMarks) > 0
					and mmd.B3P4FineStoneDirAoe ~= nil
			then
				drawStoneDir(1)
			end
		elseif TimeSince(mmd.Timer47031) < 23000 then
			drawStoneDir(2)
		elseif TimeSince(mmd.Timer47031) < 26000 then
			drawStoneDir(3)
		elseif TimeSince(mmd.Timer47031) < 29000 then
			drawStoneDir(4)
		else
			changeState(mmd.State.Boss3_P4_End)
		end
	end
end
local initGroud = function()
	_gridCenters = {}
	for row = 1, 5 do
		_gridCenters[row] = {}
		for col = 1, 5 do
			local x = 375 - 40 / 2 + (40 / 5) / 2 + (col - 1) * (40 / 5)
			local z = 530 - 40 / 2 + (40 / 5) / 2 + (row - 1) * (40 / 5)
			_gridCenters[row][col] = { x = x, y = _boss1Center.y, z = z }
		end
	end
end

local Boss14291Init = function()
	initGroud()
	changeState(MuAiGuide.Merchant.State.Boss1_Start)
end

local Boss14323Init = function()
	changeState(MuAiGuide.Merchant.State.Boss2_Start)
end

local Boss14274Init = function()
	changeState(MuAiGuide.Merchant.State.Boss3_Start)
end

local OnBossChange = function(newBoss)
	if not MuAiGuide.ScriptDevelopMode then
		initGlobalData()
	end
	if newBoss.contentid == 14291 then
		MuAiGuide.GlobalGuideY = _boss1Center.y
		Boss14291Init()
	elseif newBoss.contentid == 14323 then
		MuAiGuide.GlobalGuideY = _boss2Center.y
		Boss14323Init()
	elseif newBoss.contentid == 14274 then
		MuAiGuide.GlobalGuideY = _boss3Center.y
		Boss14274Init()
	end
	if G.CurBoss ~= nil then
		MuAiGuide.Info(G.CurBoss.name .. "初始化完成！")
	end
end

local SetBoss = function()
	local curTarget = TensorCore.mGetTarget()
	if curTarget == nil or not curTarget.attackable then
		if (G.CurBoss == nil or not G.CurBoss.alive) and Player.alive then
			local searchBoss
			for _, ent in pairs(TensorCore.entityList("contentid=14323")) do
				if Argus.isEntityVisible(ent) and (not ent.incombat or ent.charType == 5) and ent.alive then
					searchBoss = ent
					break
				end
			end
			for _, ent in pairs(TensorCore.entityList("contentid=14274")) do
				if Argus.isEntityVisible(ent) and (not ent.incombat or ent.charType == 5) and ent.alive then
					searchBoss = ent
					break
				end
			end
			for _, ent in pairs(TensorCore.entityList("contentid=14291")) do
				if Argus.isEntityVisible(ent) and (not ent.incombat or ent.charType == 5) and ent.alive then
					searchBoss = ent
					break
				end
			end
			if searchBoss ~= nil then
				G.CurBoss = TensorCore.mGetEntity(searchBoss.id)
				OnBossChange(searchBoss)
				MuAiGuide.Debug("当前目标不正确，已自动搜索BOSS" .. searchBoss.name)
			end
		end
	else
		if G.CurBoss == nil then
			G.CurBoss = TensorCore.mGetEntity(curTarget.id)
			if not curTarget.incombat or curTarget.hp.percent >= 99.9 then
				OnBossChange(curTarget)
			end
		elseif curTarget.contentid ~= G.CurBoss.contentid then
			G.CurBoss = TensorCore.mGetEntity(curTarget.id)
			OnBossChange(curTarget)
		elseif G.CurBoss.incombat and not curTarget.incombat then
			G.CurBoss = TensorCore.mGetEntity(curTarget.id)
			OnBossChange(curTarget)
		end
	end
end

----------------------------- MuAiCore Call -----------------------------
G.OnEntityChannel = function(entityID, spellID, _)
	if not getCfg().Merchant then
		return
	end
	local mmd = MuAiGuide.Merchant
	if spellID == 45434 or spellID == 45435 or spellID == 45444    --火粉分散
			or spellID == 45436 or spellID == 45437 or spellID == 45445 --集火分摊
	then
		if mmd.CurrentState < mmd.State.Boss3_P1_Start then
			changeState(mmd.State.Boss3_P1_Start)
			mmd.fireDance.spellId = spellID
			mmd.fireDance.inState = true
		end
	elseif spellID == 45448 then
		-- 火环
		if mmd.fireDance.inState then
			mmd.Timer = Now()
		end
	elseif spellID == 45467 or spellID == 45468 then
		-- 四连炎舞·追火	
		if mmd.CurrentState < mmd.State.Boss3_P2_Start then
			changeState(mmd.State.Boss3_P2_Start)
		end
	elseif 45481 <= spellID and spellID <= 45482 or spellID == 45492 then
		-- 怒炎
		if mmd.CurrentState < mmd.State.Boss3_P3_End then
			changeState(mmd.State.Boss3_P3_Start)
		end
	elseif spellID == 45506 then
		-- 解开包裹
		if mmd.CurrentState < mmd.State.Boss3_P2_CarryEnd then
			changeState(mmd.State.Boss3_P2_CarryEnd)
		end
	elseif spellID == 45519 then
		if mmd.CurrentState < mmd.State.Boss3_P1_End then
			changeState(mmd.State.Boss3_P1_End)
		end
	elseif spellID == 45551 then
		--- 火灵的诅咒
	elseif 45538 <= spellID and spellID <= 45540 -- 对火花
			or (spellID == 45536 or spellID == 45537) --散火花
	then
		if mmd.CurrentState <= mmd.State.Boss3_P2_Start then
			mmd.B3P1Sub.spellId = spellID
			mmd.B3P1Sub.Timer = Now()
		end
	elseif 45839 <= spellID and spellID <= 45843 then
		boss1SubDraw(entityID, spellID)
	elseif spellID == 45845 or spellID == 45809 or spellID == 45776 then
		-- 空中漫游
		mmd.spell45845.Timer = Now()
		if mmd.CurrentState < mmd.State.Boss1_P1_ForceMove then
			changeState(mmd.State.Boss1_P1_ForceMove)
		end
	elseif spellID == 45773 then
		--小夜曲
	elseif spellID == 45849 then
		-- 沉没宝藏
		if mmd.CurrentState > mmd.State.Boss1_P2_End then
			mmd.spell45849 = {
				InState = false,
				Timer = 0,
				Ids = {},
				FirstBallIds = {},
				FirstBallFinish = false,
				AllBalls = {},
				P1TargetPos = nil,
				P1GuidePos1 = nil,
				P1GuidePos2 = nil,
				P1OffsetH = nil,
				P1BuffType = nil,
				P1LockingFace = nil
			}
		end
		mmd.spell45849.Timer = Now()
		mmd.spell45849.InState = true
	elseif spellID == 46693 then
		-- 四方凶兆
		if mmd.CurrentState == mmd.State.Boss2_Start then
			changeState(mmd.State.Boss2_P1_Start)
		elseif mmd.CurrentState >= mmd.State.Boss2_P2_Put
				and mmd.CurrentState < mmd.State.Boss2_P3_Start then
			changeState(mmd.State.Boss2_P3_Start)
		elseif mmd.CurrentState >= mmd.State.Boss2_P3_LineEnd
				and mmd.CurrentState < mmd.State.Boss2_P4_Start
		then
			changeState(mmd.State.Boss2_P3_4Blade1)
		end
	elseif spellID == 46698 then
		-- 缚链凶兆击
	elseif spellID == 46700 then
		-- 变转光波
	elseif spellID == 46704 then
		-- 转轮残响
		MuAiGuide.DirectTo(_boss2Center.x, _boss2Center.z, 3600)
	elseif spellID == 46707 then
		-- 八叶残响
	elseif spellID == 46711 then
		-- 八叶回响
	elseif spellID == 46713 then
		-- 时差剑波
	elseif spellID == 46715 or spellID == 46716 or spellID == 46642 or spellID == 46679 or spellID == 46680 then
		-- 咬击古狼闪
		mmd.Timer = Now()
		mmd.spell46715 = true
	elseif spellID == 46720 then
		-- 剑气释放
		if mmd.CurrentState > mmd.State.Boss2_P3_Start then
			changeState(mmd.State.Boss2_P4_Start)
		end
	elseif spellID == 46721 then
		-- 光波钢剑舞
	elseif spellID == 46733 then
		-- 四联幻影光波
	elseif spellID == 46752 then
		-- 灼热回响
	elseif spellID == 46754 then
		if mmd.CurrentState < mmd.State.Boss3_P2_End then
			changeState(mmd.State.Boss3_P2_StartCarry)
		end
	elseif table.contains(_skillIdCircle, spellID) or table.contains(_skillIdRing, spellID) then
		--天界交叉斩·圆          --天界交叉斩·环
		mmd.Timer = Now()
		mmd.spellRingCircle = true
		mmd.spellRingData.spellId = spellID
	elseif spellID == 47031 or spellID == 47032 then
		mmd.Timer47031 = Now()
	elseif spellID == 47041 then
		-- 幻影生成
		changeState(mmd.State.Boss3_P4_Start)
	elseif spellID == 47763 then
		-- 冥界灵击波
	end
end

G.OnMarkerAdd = function(entityID, markerID)
	if not getCfg().Merchant then
		return
	end
	local mmd = MuAiGuide.Merchant
	if markerID == 20 then
		mmd.mark20Timer = Now()
		mmd.mark20InState = true
	elseif markerID == 22 then
		mmd.Timer = Now()
		mmd.mark22 = true
	elseif markerID == 136 or markerID == 137 then
		if _lastRightMarkTime == 0 or TimeSince(_lastRightMarkTime) > 700 then
			_lastRightMarkTime = Now()
			if mmd.CurrentState == mmd.State.Boss2_P1_GetLine then
				changeState(mmd.State.Boss2_P1_LineEnd)
			elseif mmd.CurrentState == mmd.State.Boss2_P3_GetLine then
				changeState(mmd.State.Boss2_P3_LineEnd)
			elseif mmd.CurrentState == mmd.State.Boss2_P3_4Blade1 then
				changeState(mmd.State.Boss2_P3_4Blade2)
			elseif mmd.CurrentState == mmd.State.Boss2_P3_4Blade2 then
				changeState(mmd.State.Boss2_P3_4Blade3)
			elseif mmd.CurrentState == mmd.State.Boss2_P3_4Blade3 then
				changeState(mmd.State.Boss2_P3_4AddMark)
			elseif mmd.CurrentState == mmd.State.Boss2_P3_4AddMark then
				changeState(mmd.State.Boss2_P3_4Blade4)
			elseif mmd.CurrentState == mmd.State.Boss2_P3_4Blade4 then
				changeState(mmd.State.Boss2_P3_4BladeEnd)
			elseif mmd.CurrentState == mmd.State.Boss2_P3_4BladeEnd then
				changeState(mmd.State.Boss2_P3_End)
			elseif mmd.CurrentState == mmd.State.Boss2_P4_GetBuff then
				changeState(mmd.State.Boss2_P4_Blade1)
			elseif mmd.CurrentState == mmd.State.Boss2_P4_Blade1 then
				changeState(mmd.State.Boss2_P4_Blade2)
			elseif mmd.CurrentState == mmd.State.Boss2_P4_Blade2 then
				changeState(mmd.State.Boss2_P4_Blade3)
			elseif mmd.CurrentState == mmd.State.Boss2_P4_Blade3 then
				changeState(mmd.State.Boss2_P4_Blade4)
			elseif mmd.CurrentState == mmd.State.Boss2_P4_Blade4 then
				changeState(mmd.State.Boss2_P4_BladeEnd)
			end
		end
	elseif markerID == 161 then
		-- 对火花
	elseif markerID == 332 then
		mmd.spellRingData.spellMark1 = TensorCore.mGetEntity(entityID)
	elseif markerID == 333 then
		mmd.spellRingData.spellMark2 = TensorCore.mGetEntity(entityID)
	elseif markerID == 499 then
		mmd.Timer = Now()
		mmd.mark499 = true
		if mmd.CurrentState <= mmd.State.Boss2_P2_Start then
			changeState(mmd.State.Boss2_P2_Start)
		end
	elseif markerID == 631 then
		-- 飞毯标记

	elseif markerID == 644 or markerID == 624 then
		-- 黄
		if mmd.CurrentState <= mmd.State.Boss3_P2_Turn4 then
			table.insert(mmd.B3P2FireDance.marks, markerID)
			mmd.Timer = Now()
		elseif mmd.CurrentState > mmd.State.Boss3_P4_Start then
			table.insert(mmd.B3P4FineStoneMarks, markerID)
		end
	elseif markerID == 645 or markerID == 625 then
		-- 蓝
		if mmd.CurrentState <= mmd.State.Boss3_P2_Turn4 then
			table.insert(mmd.B3P2FireDance.marks, markerID)
			mmd.Timer = Now()
		elseif mmd.CurrentState > mmd.State.Boss3_P4_Start then
			table.insert(mmd.B3P4FineStoneMarks, markerID)
		end
	elseif markerID == 646 or markerID == 647 or markerID == 628 or markerID == 629 then
		if mmd.CurrentState < mmd.State.Boss3_P2_Start then
			mmd.B3P1Sub.marks[entityID] = markerID
		end
	elseif markerID == 652 then
		mmd.spellRingData.spellMarkAim = TensorCore.mGetEntity(entityID)
	end
end

--- @param aoeInfo GroundAOE|DirectionalAOE
G.OnAOECreate = function(aoeInfo)
	if not getCfg().Merchant or aoeInfo.aoeID == nil then
		return
	end
	local mmd = MuAiGuide.Merchant
	if aoeInfo.aoeID == 45434 or aoeInfo.aoeID == 45435 or aoeInfo.aoeID == 45436
			or aoeInfo.aoeID == 45437 or aoeInfo.aoeID == 45444 or aoeInfo.aoeID == 45445
	then
		if mmd.CurrentState < mmd.State.Boss3_P2_Start then
			-- P1
			mmd.fireDance.aoeHeading = aoeInfo.heading
		end
	elseif aoeInfo.aoeID == 45439 or aoeInfo.aoeID == 45438 or aoeInfo.aoeID == 45584
			or 45449 <= aoeInfo.aoeID and aoeInfo.aoeID <= 45452
	then
		--幻影炎舞 
		if mmd.CurrentState < mmd.State.Boss3_P3_Start then
			mmd.B3P2Phantom.aoeInfo = aoeInfo
		elseif mmd.CurrentState >= mmd.State.Boss3_P4_Start then
			mmd.B3P4BladeAoes[aoeInfo.entityID] = aoeInfo
		end
	elseif aoeInfo.aoeID == 45467 or aoeInfo.aoeID == 45468 then
		-- 四连炎舞
		if mmd.CurrentState < mmd.State.Boss3_P3_Start then
			mmd.B3P2FireDance.aoeInfo = aoeInfo
		end
	elseif aoeInfo.aoeID == 45478 or aoeInfo.aoeID == 45479 then
		if mmd.CurrentState < mmd.State.Boss3_P2_Start then
			mmd.B3P1Sub.AOEs[aoeInfo.entityID] = aoeInfo
		end
	elseif 45483 < aoeInfo.aoeID and aoeInfo.aoeID == 45488 then
		if getCfg().MerchantDraw then
			_redDrawer:addTimedCircle(5700, aoeInfo.x, aoeInfo.y, aoeInfo.z, aoeInfo.aoeLength)
		end
		if table.size(mmd.B3P3Fire) < 4 then
			table.insert(mmd.B3P3Fire, aoeInfo)
			if table.size(mmd.B3P3Fire) == 4 then
				changeState(mmd.State.Boss3_P3_GetFirstFire)
			end
		end
	elseif aoeInfo.aoeID == 45527 or aoeInfo.aoeID == 45526
			or aoeInfo.aoeID == 40750 or aoeInfo.aoeID == 40751
			or 40735 <= aoeInfo.aoeID and aoeInfo.aoeID <= 40737
	then
		table.insert(mmd.B3P3Pillar, aoeInfo)
		if mmd.CurrentState < mmd.State.Boss3_P3_FirstPillar then
			local player = MuAiGuide.GetPlayer()
			local otherJob
			local selfBuff
			for Job, ent in pairs(MuAiGuide.Party) do
				if ent.id ~= player.id then
					if TensorCore.hasBuff(player.id, 4844)
							and TensorCore.hasBuff(ent.id, 4844)
					then
						selfBuff = 4844
						otherJob = Job
						break
					elseif TensorCore.hasBuff(player.id, 4845)
							and TensorCore.hasBuff(ent.id, 4845)
					then
						selfBuff = 4845
						otherJob = Job
						break
					end
				end
			end
			local selfIndex = MuAiGuide.IndexOf(_order, MuAiGuide.SelfPos)
			local otherIndex = MuAiGuide.IndexOf(_order, otherJob)
			mmd.B3P3FireLinkType.isHigh = selfIndex < otherIndex
			mmd.B3P3FireLinkType.buff = selfBuff
			changeState(mmd.State.Boss3_P3_FirstPillar)
		end
		if table.size(mmd.B3P3Pillar) >= 8 then
			changeState(mmd.State.Boss3_P3_GetPillar)
		end
	elseif aoeInfo.aoeID == 45532 then
		--塔
		if table.size(mmd.B3P4Tower1) < 4 then
			table.insert(mmd.B3P4Tower1, aoeInfo)
		else
			table.insert(mmd.B3P4Tower2, aoeInfo)
		end
	elseif 45788 <= aoeInfo.aoeID and aoeInfo.aoeID < 45790
			or 45823 <= aoeInfo.aoeID and aoeInfo.aoeID < 45825
			or 45862 <= aoeInfo.aoeID and aoeInfo.aoeID < 45864
	then
		if mmd.aoeGroudWater.Timer == 0 then
			mmd.aoeGroudWater.Timer = Now()
		end
		if mmd.CurrentState < mmd.State.Boss1_P2_GroudWater then
			changeState(mmd.State.Boss1_P2_GroudWater)
		end
		table.insert(mmd.aoeGroudWater.aoe, aoeInfo)
	elseif aoeInfo.aoeID == 45865 or aoeInfo.aoeID == 45866 then
		if mmd.spell45866.Timer == 0 then
			mmd.spell45866.InState = true
			mmd.spell45866.Timer = Now()
		end
		if table.size(mmd.spell45866.AoeInfo1) < 2 then
			table.insert(mmd.spell45866.AoeInfo1, aoeInfo)
		elseif table.size(mmd.spell45866.AoeInfo1) == 2 then
			table.insert(mmd.spell45866.AoeInfo2, aoeInfo)
		end
	elseif aoeInfo.aoeID == 46573 or aoeInfo.aoeID == 46574 then
		mmd.Timer46574 = Now()
	elseif aoeInfo.aoeID == 46705 and mmd.CurrentState > mmd.State.Boss2_P4_Start then
		if getCfg().MerchantDraw then
			_redDrawer:addTimedCross(5000, aoeInfo.x, aoeInfo.y, aoeInfo.z, 60, 8, 0)
			_redDrawer:addTimedCross(5000, aoeInfo.x, aoeInfo.y, aoeInfo.z, 60, 8, math.pi / 4)
		end
	elseif aoeInfo.aoeID == 46707 or aoeInfo.aoeID == 46708 then
		if getCfg().MerchantDraw then
			_redDrawer:addTimedCross(3000, aoeInfo.x, aoeInfo.y, aoeInfo.z, 60, 8, aoeInfo.heading)
		end
	elseif aoeInfo.aoeID == 47031 or aoeInfo.aoeID == 47032 then
		mmd.B3P4FineStoneDirAoe = aoeInfo
	end
end

G.OnEventObjectScriptFunc = function(entityID, _, _, _)
	local mmd = MuAiGuide.Merchant
	if not getCfg().Merchant then
		return
	end
	local curEnt = TensorCore.mGetEntity(entityID)
	if curEnt.contentid == 2015004 then
		local maxSize = 1
		if table.size(mmd.spell45849.AllBalls) == 6 then
			maxSize = 1
		elseif table.size(mmd.spell45849.AllBalls) == 6 then
			maxSize = 2
		end
		if table.size(mmd.spell45849.FirstBallIds) < maxSize then
			table.insert(mmd.spell45849.FirstBallIds, entityID)
			if table.size(mmd.spell45849.FirstBallIds) == maxSize then
				mmd.spell45849.FirstBallFinish = true
			end
		end
		if mmd.CurrentState < mmd.State.Boss1_P2_Treasure then
			changeState(mmd.State.Boss1_P2_Treasure)
		end
	end
end
--- 每帧执行
G.Update = function()
	if not getCfg().Merchant then
		return
	end
	if MuAiGuide.Merchant == nil then
		initGlobalData()
	end
	SetBoss()
	if G.CurBoss == nil or MuAiGuide.Merchant == nil then
		return
	end
	if G.CurBoss.contentid == 14291 then
		Boss_14291_Update()
	elseif G.CurBoss.contentid == 14323 then
		Boss_14323_Update()
	elseif G.CurBoss.contentid == 14274 then
		Boss_14274_Update()
	end
end

--- 进入副本
G.OnEnter = function()
	G.CurBoss = nil
end

G.OnLeave = function()
	-- TODO Nothing
end
--- 脱离战斗
G.OnWipe = function()
	if not getCfg().Merchant then
		return
	end
	G.CurBoss = nil
	initGlobalData()
	MuAiGuide.Debug("团灭了！")
end

return G