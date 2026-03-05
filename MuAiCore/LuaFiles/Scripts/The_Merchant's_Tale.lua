local G = {}
G.MapId = 1317
local M
local _currentBoss
local _lastBoss
local _gridCenters = {}
local _boss1Center = { x = 375, y = -29.5, z = 530 }
-- 洋流 45865  左上 右下 => 右上 左下
-- 洋流 45862   =>  地火洋流
-- Mark 20 = 十字 

local _redDrawer = Argus2.ShapeDrawer:new(
		(GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.3)),
		(GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),
		1
)

local OnEntityChannelFishSubDraw = function(entityID, spellID)
	if not MuAiGuide.Config.Main.MerchantDraw or spellID < 45839 or spellID > 45843 then
		return
	end
	local drawerTime = 2200
	local curEnt = TensorCore.mGetEntity(entityID)
	if spellID == 45843 then
		_redDrawer:addTimedCone(drawerTime, curEnt.pos.x, curEnt.pos.y, curEnt.pos.z, 45, math. pi / 3, curEnt.pos.h)
	elseif spellID == 45841 or spellID == 45839 or spellID == 45840 then
		_redDrawer:addTimedRect(drawerTime, curEnt.pos.x, curEnt.pos.y, curEnt.pos.z, 42, 8, curEnt.pos.h)
	elseif spellID == 45842 then
		_redDrawer:addTimedCone(drawerTime, curEnt.pos.x, curEnt.pos.y, curEnt.pos.z, 20, math.pi, curEnt.pos.h)
	end
end

local OnEntityChannelStateChange = function(entityID, spellID)
	if spellID == 45845 then
		-- 空中漫游
		M.Merchant.Timer = Now()
		M.Merchant.spell45845 = true
	elseif spellID == 45849 then
		-- 沉没宝藏
		M.Merchant.Timer = Now()
		M.Merchant.spell45849 = true
	end
end

--- 空中漫游画图
local OnUpdateSpell45845 = function()
	if not M.Merchant.spell45845 then
		return
	end
	if TimeSince(M.Merchant.Timer) < 17000 then
		if MuAiGuide.Config.Main.MerchantDraw then
			_redDrawer:addCircle(_boss1Center.x, _boss1Center.y, _boss1Center.z, 12)
			for _, ent in pairs(TensorCore.entityList("contentid=14291")) do
				if TensorCore.getDistance2d(_boss1Center, ent.pos) > 10 then
					_redDrawer:addCircle(ent.pos.x, ent.pos.y, ent.pos.z, 12)
				end
			end
		end
	else
		d("spell45845 被设置FALSE")
		M.Merchant.spell45845 = false
	end
end

--- 沉没的宝藏
local OnUpdateSpell45849 = function()
	if not M.Merchant.spell45849 then
		return
	end
	if M.Merchant.SecondBall == nil then
		if M.Merchant.FirstBall == nil then
			for _, ent in pairs(TensorCore.entityList("contentid=2015004")) do
				if ent.action == 256 then
					M.Merchant.FirstBall = ent
					break
				end
			end
		else
			for _, ent in pairs(TensorCore.entityList("contentid=2015004")) do
				if M.Merchant.FirstBall.id ~= ent.id then
					M.Merchant.SecondBall = ent
					break
				end
			end
			M.Merchant.Rings = {}
			for _, ent in pairs(TensorCore.entityList("contentid=2015005")) do
				table.insert(M.Merchant.Rings, ent)
				_redDrawer:addDonut(ent.pos.x, ent.pos.y, ent.pos.z, 4, 20)
			end
		end
	else
		if TimeSince(M.Merchant.Timer) < 20000 then
			for _, ent in pairs(M.Merchant.Rings) do
				_redDrawer:addDonut(ent.pos.x, ent.pos.y, ent.pos.z, 4, 20)
			end
			local ball1 = M.Merchant.SecondBall
			_redDrawer:addCircle(ball1.pos.x, ball1.pos.y, ball1.pos.z, 18)
		elseif TimeSince(M.Merchant.Timer) < 27000 then
			local ball2 = M.Merchant.FirstBall
			_redDrawer:addCircle(ball2.pos.x, ball2.pos.y, ball2.pos.z, 18)
		else
			d(TimeSince(M.Merchant.Timer))
			d("spell45849 被设置FALSE")
			M.Merchant.spell45849 = false
		end
	end
end

local OnUpdateMark20 = function()
	if not M.Merchant.mark20 then
		return
	end
	if TimeSince(M.Merchant.Timer) < 8000 then
		local players = M.GetPartyPlayers()
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
		M.Merchant.mark20 = false
		d("mark20 被设置FALSE")
	end
end

local Boss14291Update = function()
	if _currentBoss == nil or _currentBoss.contentid ~= 14291 or M.Merchant == nil then
		return
	end
	OnUpdateSpell45845()
	OnUpdateSpell45849()
	OnUpdateMark20()
end

local Boss14291Init = function()
	M.Info(_currentBoss.name .. "初始化完成！")
end

local OnBossChange = function(newBoss)
	if newBoss.contentid == 14291 then
		Boss14291Init()
	end
end

local SetBoss = function()
	local curTarget = TensorCore.mGetTarget()
	if curTarget ~= nil and curTarget.attackable and (_currentBoss == nil or curTarget.contentid ~= _currentBoss.contentid) then
		_currentBoss = curTarget
		OnBossChange(curTarget)
	end
end

local initMuAiGuide = function()
	if M == nil then
		M = MuAiGuide
		M.Merchant = {
			Timer = 0,
			spell45845 = false,
			spell45849 = false,
			mark20 = false,
		}
	end
end
------------------------------ 事件方法 ----------------------------------

local OnEntityChannel = function(entityID, spellID, channelDuration)
	if not M.Config.Main.Merchant then
		return
	end
	OnEntityChannelStateChange(entityID, spellID)
	OnEntityChannelFishSubDraw(entityID, spellID)
end
local OnMarkerAdd = function(entityID, markerID)
	if markerID == 20 then
		M.Merchant.Timer = Now()
		M.Merchant.mark20 = true
	elseif markerID == 22 then
		M.Merchant.Timer = Now()
		M.Merchant.mark22 = true
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

----------------------------- MuAiCore Call -----------------------------
--- 初始化
G.Init = function()
	Argus.registerOnEntityChannel(OnEntityChannel)
	Argus.registerOnMarkerAdd(OnMarkerAdd)
	MuAiGuide.Debug("异闻商客奇谭初始化完成")
	initGroud()
end
--- 没帧执行
G.Update = function()
	initMuAiGuide()
	if not M.Config.Main.Merchant then
		return
	end
	SetBoss()
	Boss14291Update()
end
--- 进入副本
G.OnEnter = function()
	_currentBoss = nil
	_lastBoss = nil
	initMuAiGuide()
	M.Debug("进入副本：异闻商客奇谭")
end

--- 脱离战斗
G.OnLeaveBat = function()
	_currentBoss = nil
end

return G