local G = {}
G.MapId = 1317
G.CurBoss = nil
local _lastBoss
local _gridCenters = {}
local _boss1Center = { x = 375, y = -29.5, z = 530 }
local _boss2Center = { x = 170, y = -16, z = -815 }
local _skillIdCircle = { 46658, 46660, 46687, 46689, 47562, 47564, 47566, 47568 }
local _skillIdRing = { 46659, 46661, 46668, 46690, 47563, 47565, 47567, 47569 }
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

local _order = { "MT", "ST", "D1", "D2" }
local lastRightMarkTime = 0

local getTurnLineFrom = function(entityID)
	for _, tether in pairs(Argus.getTethersOnEnt(entityID)) do
		if tether.type == 115 then
			for _, pTether in pairs(Argus.getTethersOnEnt(tether.partnerid)) do
				if pTether.partnerid ~= entityID then
					return TensorCore.mGetEntity(pTether.partnerid)
				end
			end
		end
	end
	return nil
end

local boss1SubDraw = function(entityID, spellID)
	if not MuAiGuide.Config.Main.MerchantDraw then
		return
	end
	local drawerTime = 2200
	local curEnt = TensorCore.mGetEntity(entityID)
	if spellID == 45843 then
		_redDrawer:addTimedCone(drawerTime, curEnt.pos.x, curEnt.pos.y, curEnt.pos.z, 45, math.pi / 3, curEnt.pos.h)
	elseif spellID == 45841 or spellID == 45839 or spellID == 45840 then
		_redDrawer:addTimedRect(drawerTime, curEnt.pos.x, curEnt.pos.y, curEnt.pos.z, 42, 8, curEnt.pos.h)
	elseif spellID == 45842 then
		_redDrawer:addTimedCone(drawerTime, curEnt.pos.x, curEnt.pos.y, curEnt.pos.z, 20, math.pi, curEnt.pos.h)
	end
end

--- 空中漫游画图
local OnUpdateSpell45845 = function()
	if not MuAiGuide.Merchant.spell45845 then
		return
	end
	if TimeSince(MuAiGuide.Merchant.Timer) < 17000 then
		if MuAiGuide.Config.Main.MerchantDraw then
			_redDrawer:addCircle(_boss1Center.x, _boss1Center.y, _boss1Center.z, 12)
			for _, ent in pairs(TensorCore.entityList("contentid=14291")) do
				if TensorCore.getDistance2d(_boss1Center, ent.pos) > 10 then
					_redDrawer:addCircle(ent.pos.x, ent.pos.y, ent.pos.z, 12)
				end
			end
		end
	else
		MuAiGuide.Merchant.Timer = 0
		MuAiGuide.Merchant.spell45845 = false
	end
end

--- 沉没的宝藏
local OnUpdateSpell45849 = function()
	if not MuAiGuide.Merchant.spell45849 then
		return
	end
	if MuAiGuide.Merchant.SecondBall == nil then
		for _, ent in pairs(TensorCore.entityList("contentid=2015004")) do
			if ent.action ~= 0 then
				MuAiGuide.Merchant.BallChanged = true
				break
			end
		end
		if MuAiGuide.Merchant.BallChanged then
			MuAiGuide.Merchant.FirstBall = {}
			MuAiGuide.Merchant.SecondBall = {}
			for _, ent in pairs(TensorCore.entityList("contentid=2015004")) do
				if ent.action ~= 0 then
					table.insert(MuAiGuide.Merchant.SecondBall, ent)
				else
					table.insert(MuAiGuide.Merchant.FirstBall, ent)
				end
			end
			MuAiGuide.Merchant.Rings = {}
			for _, ent in pairs(TensorCore.entityList("contentid=2015005")) do
				table.insert(MuAiGuide.Merchant.Rings, ent)
				_redDrawer:addDonut(ent.pos.x, ent.pos.y, ent.pos.z, 4, 20)
			end
		end
	else
		if TimeSince(MuAiGuide.Merchant.Timer) < 20000 then
			for _, ent in pairs(MuAiGuide.Merchant.Rings) do
				_redDrawer:addDonut(ent.pos.x, ent.pos.y, ent.pos.z, 4, 20)
			end
			for _, ent in pairs(MuAiGuide.Merchant.FirstBall) do
				_redDrawer:addCircle(ent.pos.x, ent.pos.y, ent.pos.z, 18)
			end
		elseif TimeSince(MuAiGuide.Merchant.Timer) < 27000 then
			for _, ent in pairs(MuAiGuide.Merchant.SecondBall) do
				_redDrawer:addCircle(ent.pos.x, ent.pos.y, ent.pos.z, 18)
			end
		else
			MuAiGuide.Merchant.Timer = 0
			MuAiGuide.Merchant.spell45849 = false
			MuAiGuide.Merchant.BallFinish = false
		end
	end
end

local OnUpdateMark20 = function()
	if not MuAiGuide.Merchant.mark20 then
		return
	end
	if TimeSince(MuAiGuide.Merchant.Timer) < 8000 then
		local players = MuAiGuide.GetPartyPlayers()
		for _, ent in pairs(players) do
			if ent.id ~= Player.id then
				local dis = 100000000
				local curPoint = nil
				for _, row in pairs(_gridCenters) do
					for _, point in pairs(row) do
						local curDis = TensorCore.getDistance2d(ent.pos, { x = point.x, y = _boss1Center.y, z = point.z })
						if curDis < dis then
							dis = curDis
							curPoint = point
						end
					end
				end
				if curPoint ~= nil then
					_redDrawer:addCross(curPoint.x, _boss1Center.y, curPoint.z, 40, 8, math.pi)
				end
			end
		end
	else
		MuAiGuide.Merchant.mark20 = false
		d("mark20 被设置FALSE")
	end
end

local OnUpdateSpellRingCircle = function()
	if not MuAiGuide.Config.Main.MerchantDraw or  not MuAiGuide.Merchant.spellRingCircle then
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
	if mmd.spellRingData.spellType == 0 then
		local _curBoss = TensorCore.mGetEntity(G.CurBoss.id)
		if _curBoss.lastAction == 34 then
			-- 分摊
			mmd.spellRingData.spellType = 1
		elseif _curBoss.lastAction == 35 then
			-- 小钢铁
			mmd.spellRingData.spellType = 2
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
	elseif TimeSince(MuAiGuide.Merchant.Timer) < 6500 then
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

local changeState = function(state)
	MuAiGuide.Merchant.CurrentState = state
	MuAiGuide.Debug("阶段切换：" .. tostring(state))

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
	if mmd.P3Blade.BigIds == nil then
		mmd.P3Blade.BigIds = {}
	end
	if mmd.P3Blade[index] == nil then
		mmd.P3Blade[index] = {}
	end
	local limit = wave * 4
	if table.size(mmd.P3Blade.BigIds) < limit then
		getBladeTable(mmd.P3Blade[index], mmd.P3Blade.BigIds)
	elseif table.size(mmd.P3Blade.BigIds) == limit then
		drawGuide4Blade(mmd.P3Blade[index])
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

local OnUpdateSpell46715 = function()
	if MuAiGuide.Config.Main.MerchantDraw and MuAiGuide.Merchant.spell46715 then
		if TimeSince(MuAiGuide.Merchant.Timer) < 5000 then
			local curBoss = TensorCore.mGetEntity(G.CurBoss.id)
			_redDrawer:addRect(curBoss.pos.x, curBoss.pos.y, curBoss.pos.z, 40, 60, curBoss.pos.h)
		else
			MuAiGuide.Merchant.spell46715 = false
			MuAiGuide.Merchant.Timer = 0
		end
	end
end

local Boss_14291_Update = function()
	if G.CurBoss == nil or G.CurBoss.contentid ~= 14291 or MuAiGuide.Merchant == nil then
		return
	end
	OnUpdateSpell45845()
	OnUpdateSpell45849()
	OnUpdateMark20()
end

local Boss_14323_Update = function()
	if G.CurBoss == nil or G.CurBoss.contentid ~= 14323 or MuAiGuide.Merchant == nil then
		return
	end
	OnUpdateSpell46715()
	OnUpdateSpellRingCircle()
	local player = MuAiGuide.GetPlayer()
	local M = MuAiGuide
	local mmd = M.Merchant
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
			if M.HasLine(ent.id, 115) then
				changeState(mmd.State.Boss2_P1_GetLine)
				break
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
			local linkFromEnt = getTurnLineFrom(player.id)
			if linkFromEnt ~= nil then
				local linkFrom = linkFromEnt.pos
				local guidePos = nil
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
					local boss = TensorCore.mGetEntity(G.CurBoss.id)
					for i, ent in pairs(M.Party) do
						if M.HasLine(ent.id, targetLinkType) then
							M.FrameTakeLine(boss.pos, ent.pos, player.pos)
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
		if MuAiGuide.Config.Main.MerchantGuide then
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
		if mmd.P3Blade == nil then
			mmd.P3Blade = {}
			mmd.P3Blade.SamllId = {}
			mmd.P3Blade.Small = {}
		end
		if table.size(mmd.P3Blade.SamllId) < 4 then
			for _, ent in pairs(TensorCore.entityList("contentid=14326")) do
				local modelId = Argus.getEntityModel(ent.id)
				if modelId == 19227 and not table.contains(mmd.P3Blade.SamllId, ent.id) then
					table.insert(mmd.P3Blade.SamllId, ent.id)
					table.insert(mmd.P3Blade.Small, ent)
				end
			end
		elseif table.size(mmd.P3Blade.SamllId) == 4 then
			changeState(mmd.State.Boss2_P3_GetBlade)
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P3_GetBlade then
		for _, ent in pairs(M.Party) do
			if M.HasLine(ent.id, 115) then
				changeState(mmd.State.Boss2_P3_GetLine)
				break
			end
		end
		if MuAiGuide.Config.Main.MerchantGuide then
			local guidePos
			if TensorCore.hasBuff(player.id, 4784) then
				guidePos = { x = _boss2Center.x + 10, z = _boss2Center.z - 5 }
			elseif TensorCore.hasBuff(player.id, 4775) then
				guidePos = { x = _boss2Center.x - 5, z = _boss2Center.z - 10 }
			end
			if guidePos ~= nil then
				M.FrameDirect(guidePos.x, guidePos.z)
			end
		end
	elseif mmd.CurrentState == mmd.State.Boss2_P3_GetLine then
		if M.HasLine(player.id, 115) then
			local linkFrom = getTurnLineFrom(player.id)
			if mmd.P3GetLineGuidePos == nil then
				if TensorCore.hasBuff(player.id, 4784) then
					--可以打左右
					local partnerFrom = nil
					for _, ent in pairs(M.Party) do
						if ent.id ~= player.id and TensorCore.hasBuff(ent.id, 4784) then
							partnerFrom = getTurnLineFrom(ent.id)
						end
					end
					if partnerFrom ~= nil then
						if partnerFrom.pos.z < _boss2Center.z - 18 and linkFrom.pos.z > _boss2Center.z + 18
								or partnerFrom.pos.z > _boss2Center.z + 18 and linkFrom.pos.z < _boss2Center.x - 18
						then
							if partnerFrom.pos.z > linkFrom.pos.z then
								mmd.P3GetLineGuidePos = { x = _boss2Center.x - 19, z = _boss2Center.z + 5 }
							else
								mmd.P3GetLineGuidePos = { x = _boss2Center.x + 19, z = _boss2Center.z - 5 }
							end
						else
							if linkFrom.pos.x > _boss2Center.x + 18 then
								--如果连线来源在右边
								mmd.P3GetLineGuidePos = { x = _boss2Center.x - 19, z = linkFrom.pos.z }
							elseif linkFrom.pos.x < _boss2Center.x - 18 then
								--如果连线来源在左边
								mmd.P3GetLineGuidePos = { x = _boss2Center.x + 19, z = linkFrom.pos.z }
							elseif partnerFrom.pos.x > _boss2Center.x + 18 then
								mmd.P3GetLineGuidePos = { x = _boss2Center.x + 19, z = _boss2Center.z - 5 }
							elseif partnerFrom.pos.x < _boss2Center.x - 18 then
								mmd.P3GetLineGuidePos = { x = _boss2Center.x - 19, z = _boss2Center.z + 5 }
							end
						end
					end
				elseif TensorCore.hasBuff(player.id, 4775) then
					--可以打上下
					local partnerFrom
					for _, ent in pairs(M.Party) do
						if ent.id ~= player.id and TensorCore.hasBuff(ent.id, 4775) then
							partnerFrom = getTurnLineFrom(ent.id)
						end
					end

					if partnerFrom ~= nil then
						if partnerFrom.pos.x < _boss2Center.x - 18 and linkFrom.pos.x > _boss2Center.x + 18
								or partnerFrom.pos.x > _boss2Center.x + 18 and linkFrom.pos.x < _boss2Center.x - 18
						then
							if partnerFrom.pos.x > linkFrom.pos.x then
								mmd.P3GetLineGuidePos = { x = _boss2Center.x - 5, z = _boss2Center.z - 19 }
							else
								mmd.P3GetLineGuidePos = { x = _boss2Center.x + 5, z = _boss2Center.z + 19 }
							end
						else

							if linkFrom.pos.z < _boss2Center.z - 18 then
								mmd.P3GetLineGuidePos = { x = linkFrom.pos.x, z = _boss2Center.z + 19 }
							elseif linkFrom.pos.z > _boss2Center.z + 18 then
								mmd.P3GetLineGuidePos = { x = linkFrom.pos.x, z = _boss2Center.z - 19 }
							elseif partnerFrom.pos.z < _boss2Center.z - 18 then
								mmd.P3GetLineGuidePos = { x = _boss2Center.x + 5, z = _boss2Center.z + 19 }
							elseif partnerFrom.pos.z > _boss2Center.z + 18 then
								mmd.P3GetLineGuidePos = { x = _boss2Center.x - 5, z = _boss2Center.z - 19 }
							end
						end
					end
				end
			end
		end
		if mmd.P3GetLineGuidePos then
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
		if mmd.P3Blade["Big4"] == nil then
			mmd.P3Blade["Big4"] = {}
		end
		if table.size(mmd.P3Blade.BigIds) < 16 then
			getBladeTable(mmd.P3Blade["Big4"], mmd.P3Blade.BigIds)
		elseif table.size(mmd.P3Blade.BigIds) == 16 then
			if TensorCore.hasBuff(player.id, 4781) then
				-- 右上不能被攻击
				if M.HasLine(player, 103) then
					mmd.B2P3SafePos = "down"
				elseif M.HasLine(player, 104) then
					mmd.B2P3SafePos = "left"
				end
			elseif TensorCore.hasBuff(player.id, 4782) then
				-- 左上不能被攻击
				if M.HasLine(player, 102) then
					mmd.B2P3SafePos = "down"
				elseif M.HasLine(player, 104) then
					mmd.B2P3SafePos = "right"
				end
			elseif TensorCore.hasBuff(player.id, 4777) then
				-- 右下不能被攻击
				if M.HasLine(player, 103) then
					mmd.B2P3SafePos = "up"
				elseif M.HasLine(player, 101) then
					mmd.B2P3SafePos = "left"
				end
			elseif TensorCore.hasBuff(player.id, 4778) then
				-- 左下不能被攻击
				if M.HasLine(player, 102) then
					mmd.B2P3SafePos = "up"
				elseif M.HasLine(player, 101) then
					mmd.B2P3SafePos = "right"
				end
			end
			if mmd.B2P3SafePos ~= nil then
				local takeBlade
				for _, blade in pairs(mmd.P3Blade["Big4"]) do
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
			local guidePos1 = TensorCore.getPosInDirection(_boss2Center, guideHeading, 28)
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

local initGlobalData = function()
	MuAiGuide.Merchant = {
		State = {
			Start = 0,
			Boss1_Start = 1000,
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
		},
		CurrentState = 0,
		Timer = 0,
		spell45845 = false,
		spell45849 = false,
		spell46715 = false,
		spellRingCircle = false,
		spellRingData = {
			spellId = 0,
			spellType = 0,
			spellMark1 = nil,
			spellMark2 = nil,
			spellMarkAim = nil,
		},
		mark20 = false,
		mark22 = false,
		P3Blade = nil
	}
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

local OnBossChange = function(newBoss)
	initGlobalData()
	if newBoss.contentid == 14291 then
		MuAiGuide.GlobalGuideY = _boss1Center.y
		Boss14291Init()
	elseif newBoss.contentid == 14323 then
		MuAiGuide.GlobalGuideY = _boss2Center.y
		Boss14323Init()
	end
	if G.CurBoss ~= nil then
		MuAiGuide.Info(G.CurBoss.name .. "初始化完成！")
	end
end

local SetBoss = function()
	local curTarget = TensorCore.mGetTarget()
	if curTarget == nil or not curTarget.attackable then
		return
	end
	if G.CurBoss == nil then
		G.CurBoss = TensorCore.mGetEntity(curTarget.id)
		if not curTarget.incombat or curTarget.hp.percent >= 99.9 then
			OnBossChange(curTarget)
		end
	elseif curTarget.contentid ~= G.CurBoss.contentid then
		G.CurBoss = TensorCore.mGetEntity(curTarget.id)
		OnBossChange(curTarget)
	else
		G.CurBoss = TensorCore.mGetEntity(curTarget.id)
	end

end

----------------------------- MuAiCore Call -----------------------------
G.OnEntityChannel = function(entityID, spellID, channelDuration)
	if Player.localmapid ~= G.MapId or not MuAiGuide.Config.Main.Merchant then
		return
	end
	if spellID == 45773 then
		--小夜曲
	elseif spellID == 45845 then
		-- 空中漫游
		MuAiGuide.Merchant.Timer = Now()
		MuAiGuide.Merchant.spell45845 = true
	elseif spellID == 45849 then
		-- 沉没宝藏
		MuAiGuide.Merchant.Timer = Now()
		MuAiGuide.Merchant.spell45849 = true
	elseif 45839 <= spellID and spellID <= 45843 then
		boss1SubDraw(entityID, spellID)
	elseif spellID == 46700 then
		-- 变转光波	
		-- 变转光波
	elseif spellID == 46704 then
		-- 转轮残响
		MuAiGuide.DirectTo(_boss2Center.x, _boss2Center.z, 3600)
	elseif spellID == 46707 then

	elseif spellID == 46711 then
		-- 八叶回响
	elseif spellID == 46713 then
		-- 时差剑波
	elseif spellID == 46720 then
		-- 剑气释放
		if MuAiGuide.Merchant.CurrentState > MuAiGuide.Merchant.State.Boss2_P3_Start then
			changeState(MuAiGuide.Merchant.State.Boss2_P4_Start)
		end
	elseif spellID == 46693 then
		-- 四方凶兆
		if MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_Start then
			changeState(MuAiGuide.Merchant.State.Boss2_P1_Start)
		elseif MuAiGuide.Merchant.CurrentState >= MuAiGuide.Merchant.State.Boss2_P2_Put
				and MuAiGuide.Merchant.CurrentState < MuAiGuide.Merchant.State.Boss2_P3_Start then
			changeState(MuAiGuide.Merchant.State.Boss2_P3_Start)
		elseif MuAiGuide.Merchant.CurrentState >= MuAiGuide.Merchant.State.Boss2_P3_LineEnd
				and MuAiGuide.Merchant.CurrentState < MuAiGuide.Merchant.State.Boss2_P4_Start
		then
			changeState(MuAiGuide.Merchant.State.Boss2_P3_4Blade1)
		end
	elseif spellID == 46698 then
		-- 缚链凶兆击

	elseif spellID == 46733 then
		-- 四联幻影光波
	elseif spellID == 46721 then
		-- 光波钢剑舞
	elseif spellID == 46715 then
		-- 防击古狼闪
		MuAiGuide.Merchant.Timer = Now()
		MuAiGuide.Merchant.spell46715 = true
	elseif spellID == 46752 then
		-- 灼热回响
	elseif spellID == 47763 then
		-- 冥界灵击波
	elseif table.contains(_skillIdCircle, spellID) or table.contains(_skillIdRing, spellID) then
		--天界交叉斩·圆          --天界交叉斩·环
		MuAiGuide.Merchant.Timer = Now()
		MuAiGuide.Merchant.spellRingCircle = true
		MuAiGuide.Merchant.spellRingData.spellId = spellID
	end
end

G.OnMarkerAdd = function(entityID, markerID)
	if Player.localmapid ~= G.MapId then
		return
	end
	if markerID == 20 then
		MuAiGuide.Merchant.Timer = Now()
		MuAiGuide.Merchant.mark20 = true
	elseif markerID == 22 then
		MuAiGuide.Merchant.Timer = Now()
		MuAiGuide.Merchant.mark22 = true
	elseif markerID == 499 then
		MuAiGuide.Merchant.Timer = Now()
		MuAiGuide.Merchant.mark499 = true
		if MuAiGuide.Merchant.CurrentState <= MuAiGuide.Merchant.State.Boss2_P2_Start then
			changeState(MuAiGuide.Merchant.State.Boss2_P2_Start)
		end
	elseif markerID == 332 then
		MuAiGuide.Merchant.spellRingData.spellMark1 = TensorCore.mGetEntity(entityID)
	elseif markerID == 333 then
		MuAiGuide.Merchant.spellRingData.spellMark2 = TensorCore.mGetEntity(entityID)
	elseif markerID == 652 then
		MuAiGuide.Merchant.spellRingData.spellMarkAim = TensorCore.mGetEntity(entityID)
	elseif markerID == 136 or markerID == 137 then
		if lastRightMarkTime == 0 or TimeSince(lastRightMarkTime) > 700 then
			lastRightMarkTime = Now()
			if MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P1_GetLine then
				changeState(MuAiGuide.Merchant.State.Boss2_P1_LineEnd)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P3_GetLine then
				changeState(MuAiGuide.Merchant.State.Boss2_P3_LineEnd)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P3_4Blade1 then
				changeState(MuAiGuide.Merchant.State.Boss2_P3_4Blade2)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P3_4Blade2 then
				changeState(MuAiGuide.Merchant.State.Boss2_P3_4Blade3)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P3_4Blade3 then
				changeState(MuAiGuide.Merchant.State.Boss2_P3_4AddMark)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P3_4AddMark then
				changeState(MuAiGuide.Merchant.State.Boss2_P3_4Blade4)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P3_4Blade4 then
				changeState(MuAiGuide.Merchant.State.Boss2_P3_4BladeEnd)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P3_4BladeEnd then
				changeState(MuAiGuide.Merchant.State.Boss2_P3_End)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P4_GetBuff then
				changeState(MuAiGuide.Merchant.State.Boss2_P4_Blade1)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P4_Blade1 then
				changeState(MuAiGuide.Merchant.State.Boss2_P4_Blade2)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P4_Blade2 then
				changeState(MuAiGuide.Merchant.State.Boss2_P4_Blade3)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P4_Blade3 then
				changeState(MuAiGuide.Merchant.State.Boss2_P4_Blade4)
			elseif MuAiGuide.Merchant.CurrentState == MuAiGuide.Merchant.State.Boss2_P4_Blade4 then
				changeState(MuAiGuide.Merchant.State.Boss2_P4_BladeEnd)
			end
		end
	end
end

G.OnAOECreate = function(aoeInfo)
	if not MuAiGuide.Config.Main.MerchantDraw then
		return
	end
	if aoeInfo.aoeID == 45866 then
		--激涌的洋流
	elseif aoeInfo.aoeID == 46708 then
		_redDrawer:addTimedCross(3000, aoeInfo.x, aoeInfo.y, aoeInfo.z, 60, 8, aoeInfo.heading)
	elseif aoeInfo.aoeID == 46705 and MuAiGuide.Merchant.CurrentState > MuAiGuide.Merchant.State.Boss2_P4_Start then
		_redDrawer:addTimedCross(5000, aoeInfo.x, aoeInfo.y, aoeInfo.z, 60, 8, 0)
		_redDrawer:addTimedCross(5000, aoeInfo.x, aoeInfo.y, aoeInfo.z, 60, 8, math.pi / 4)
	end
end

--- 每帧执行
G.Update = function()
	if not MuAiGuide.Config.Main.Merchant then
		return
	end
	if MuAiGuide.Merchant == nil then
		initGlobalData()
	end
	SetBoss()
	Boss_14291_Update()
	Boss_14323_Update()
end

--- 进入副本
G.OnEnter = function()
	G.CurBoss = nil
	_lastBoss = nil
	MuAiGuide.Debug("进入副本：异闻商客奇谭")
end

--- 脱离战斗
G.OnWipe = function()
	G.CurBoss = nil
	initGlobalData()
end

return G