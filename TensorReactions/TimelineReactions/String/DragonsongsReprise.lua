local tbl = 
{
	
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\ndata.string_dsr = nil\nself.used = true",
							endIfUsed = true,
							name = "Clear DSR state",
							uuid = "0d03b81b-1b3b-89ad-97d8-0e6ec924b876",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 9,
				name = "擦除：解除锁面并清理状态",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1,
				timerStartOffset = -1,
				uuid = "480a7f6a-4c9c-97b5-86d4-6102304cc4d2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\ndata.string_dsr = nil\nself.used = true",
							endIfUsed = true,
							name = "Clear DSR state",
							uuid = "c2a1f6a8-31c4-d519-ac1a-e25d2a6efd9f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 11,
				name = "换图：解除锁面并清理状态",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1,
				timerStartOffset = -1,
				uuid = "bfe16481-74c7-99a2-9809-fc59240e3085",
				version = 2,
			},
		},
	}, 
	[3] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"d8d72b8c-78bf-2f67-b54b-e5b25d3286b1",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "805a6ee8-f8aa-d7cf-81e8-db3653b2b3c9",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"2a124f37-8c28-9850-9ce3-ba37b38f353e",
									true,
								},
								
								{
									"58f34591-6daa-a85f-85e8-24336981a50a",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "bcdf2a09-230f-1501-9fd5-c5ffed934835",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"825d007e-41bf-849d-aa91-8836b1ce16d3",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "7dcb2f34-3f2b-5862-86a4-fe3287a1570b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "58f34591-6daa-a85f-85e8-24336981a50a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "d8d72b8c-78bf-2f67-b54b-e5b25d3286b1",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "2a124f37-8c28-9850-9ce3-ba37b38f353e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "825d007e-41bf-849d-aa91-8836b1ce16d3",
							version = 3,
						},
					},
				},
				enabled = false,
				mechanicTime = 10,
				name = "[P1] 近战个人减伤",
				timelineIndex = 3,
				timerOffset = -3,
				uuid = "31412f5a-4082-3599-8da9-20a0b20ecc2d",
				version = 2,
			},
		},
	},
	[4] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal centerX = tonumber(eventArgs.x)\nlocal centerZ = tonumber(eventArgs.z)\nlocal centerEntityID = tonumber(eventArgs.entityID)\nstate.p1MoonCenterX = nil\nstate.p1MoonCenterZ = nil\nstate.p1MoonCenterEntityID = nil\nif type(centerX) == \"number\" and type(centerZ) == \"number\"\n    and type(centerEntityID) == \"number\" then\n  state.p1MoonCenterX = centerX\n  state.p1MoonCenterZ = centerZ\n  state.p1MoonCenterEntityID = centerEntityID\nend\nself.used = true",
							conditions = 
							{
								
								{
									"aba94ba9-4aa8-026f-9127-1d83d7027b85",
									true,
								},
								
								{
									"6772b844-916d-9345-ad24-2f1f42b59cce",
									true,
								},
							},
							endIfUsed = true,
							name = "记录月环动态中心",
							uuid = "7f8b4cbb-f537-2a34-9577-ea2afe28298e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return eventArgs.aoeID == 25306",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25306,
							name = "Empty Dimension AOE",
							uuid = "aba94ba9-4aa8-026f-9127-1d83d7027b85",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return eventArgs.contentID == 3639",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3639,
							name = "Grinnaux AOE source",
							uuid = "6772b844-916d-9345-ad24-2f1f42b59cce",
							version = 3,
						},
					},
				},
				eventType = 18,
				mechanicTime = 23.2,
				name = "[P1] 月环指路状态",
				timeRange = true,
				timelineIndex = 4,
				timerStartOffset = -7,
				uuid = "14baccb0-b076-9690-aeb8-f6fd68b45996",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal centerX = state.p1MoonCenterX\nlocal centerZ = state.p1MoonCenterZ\nlocal source = TensorCore.mGetEntity(state.p1MoonCenterEntityID)\nif source and source.pos\n    and type(source.pos.x) == \"number\" and type(source.pos.z) == \"number\" then\n  centerX = source.pos.x\n  centerZ = source.pos.z\nend\nMuAiGuide.FrameDirect(centerX, centerZ + 4, 0.5)\nself.used = true",
							conditions = 
							{
								
								{
									"6f5ade97-5ae1-43cf-9b46-f62651503336",
									true,
								},
							},
							endIfUsed = true,
							name = "每帧绘制 MuAiCore 蓝色指路",
							uuid = "2cd86264-32ec-f037-8ca4-a87d5199cd95",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local state = data.string_dsr\nreturn state ~= nil\n  and type(state.p1MoonCenterX) == \"number\"\n  and type(state.p1MoonCenterZ) == \"number\"\n  and type(state.p1MoonCenterEntityID) == \"number\"\n  and type(MuAiGuide) == \"table\"\n  and type(MuAiGuide.FrameDirect) == \"function\"",
							name = "月环指路状态已就绪",
							uuid = "6f5ade97-5ae1-43cf-9b46-f62651503336",
							version = 3,
						},
					},
				},
				eventType = 12,
				mechanicTime = 23.2,
				name = "[P1] 月环动态指路",
				timeRange = true,
				timelineIndex = 4,
				timerStartOffset = -6,
				uuid = "f7319e30-45a6-afca-94e5-7bc9da3e7487",
				version = 2,
			},
		},
	},
	[7] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"c49e6488-6106-8965-bdc4-d2404d4628e9",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "1748a97f-c2fd-369b-8f68-4a0868c96c2b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"1a71b3de-87aa-996b-a9df-242a0ce9d8aa",
									true,
								},
								
								{
									"fa0a7c67-11c4-f454-8144-8902a9bf9d1d",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "4a2db106-1df0-f221-8d31-5b7d1463059d",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"b00a8440-641e-1a86-af99-4f61899bf996",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "e87e419c-2039-301b-8c9f-cf7e72ceb42e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "fa0a7c67-11c4-f454-8144-8902a9bf9d1d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "c49e6488-6106-8965-bdc4-d2404d4628e9",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "1a71b3de-87aa-996b-a9df-242a0ce9d8aa",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "b00a8440-641e-1a86-af99-4f61899bf996",
							version = 3,
						},
					},
				},
				mechanicTime = 28.2,
				name = "[P1] 近战个人减伤",
				timelineIndex = 7,
				timerOffset = -3,
				uuid = "d29c3b20-193e-ea08-aeb2-beb47854ecb2",
				version = 2,
			},
		},
	},
	[8] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3639,
							targetType = "ContentID",
							uuid = "408dc9e9-3260-efb7-abf4-93ae93f0fc7a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 36.5,
				name = "[P1] 自动目标：Grinnaux",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 8,
				timerEndOffset = 5,
				uuid = "d5057f47-2626-ed36-969c-575549faa037",
				version = 2,
			},
		},
	},
	[10] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3639, subgroup = \"Nearest\" })\nif player and boss then\n  local drawer = TensorCore.getMoogleDrawer()\n  drawer:addTimedArrowOnEnt(5100, boss.id, 20, 1, 2, 3, player.id)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"6eababc3-c39f-d4a8-a4ec-d9a2e7d76e0a",
									true,
								},
								
								{
									"6d6919b9-9162-aea3-99bc-172ee65117ca",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_CD",
							name = "Moogle 判定渐变箭头",
							uuid = "fc402780-8222-0b3b-9d7d-bc70260cd810",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 234,
							name = "Marker 234",
							uuid = "6eababc3-c39f-d4a8-a4ec-d9a2e7d76e0a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionLua = "local player = TensorCore.mGetPlayer()\nreturn player and eventArgs.entityID == player.id",
							conditionType = 10,
							dequeueIfLuaFalse = true,
							name = "Marker is on self",
							partyTargetType = "Event Entity",
							uuid = "6d6919b9-9162-aea3-99bc-172ee65117ca",
							version = 3,
						},
					},
				},
				eventType = 4,
				mechanicTime = 44.8,
				name = "[P1] 次元斩个人连线",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "3062e82a-a7c1-f464-b667-4f9ca0412b4f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local round = 1\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif playerID == nil or tonumber(eventArgs.entityID) ~= playerID then\n  return\nend\n\ndata.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal state = data.string_dsr\nif tonumber(state.p1SlashGuideRound) ~= round then\n  state.p1SlashGuideRound = round\n  state.p1SlashSelfMarked = false\n  state.p1SlashGuideMode = nil\n  state.p1SlashGuideTargetX = nil\n  state.p1SlashGuideTargetZ = nil\n  state.p1SlashGuideWaymarkID = nil\n  state.p1SlashGuideWaymarkXs = {}\n  state.p1SlashGuideWaymarkZs = {}\n  state.p1SlashGuideWaymarkIDs = {}\nend\n\nstate.p1SlashSelfMarked = true\nlocal playerPos = player.pos\nif type(playerPos) == \"table\"\n    and type(playerPos.x) == \"number\" and type(playerPos.z) == \"number\"\n    and type(Argus) == \"table\" and type(Argus.getWaymarkInfo) == \"function\" then\n  local markerIDs = { 5, 1, 2, 6 }\n  local xs = {}\n  local zs = {}\n  local ids = {}\n  local bestDistance\n  local bestX\n  local bestZ\n  local bestID\n  for slot = 1, 4 do\n    local markerID = markerIDs[slot]\n    local x, _, z, active = Argus.getWaymarkInfo(markerID)\n    if active == true and type(x) == \"number\" and type(z) == \"number\" then\n      xs[slot] = x\n      zs[slot] = z\n      ids[slot] = markerID\n      local dx = x - playerPos.x\n      local dz = z - playerPos.z\n      local distance = dx * dx + dz * dz\n      if bestDistance == nil or distance < bestDistance then\n        bestDistance = distance\n        bestX = x\n        bestZ = z\n        bestID = markerID\n      end\n    end\n  end\n  state.p1SlashGuideWaymarkXs = xs\n  state.p1SlashGuideWaymarkZs = zs\n  state.p1SlashGuideWaymarkIDs = ids\n  if bestID ~= nil then\n    state.p1SlashGuideMode = \"waymark\"\n    state.p1SlashGuideTargetX = bestX\n    state.p1SlashGuideTargetZ = bestZ\n    state.p1SlashGuideWaymarkID = bestID\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"a3c48622-954a-4fbe-a2c9-8fe7c8e84746",
									true,
								},
								
								{
									"2d780051-dd89-15a6-8ce1-8fa164ab6e27",
									true,
								},
							},
							endIfUsed = true,
							name = "记录本人第一轮标记与目标点",
							uuid = "2df351bb-43c2-603b-b1c7-91138773bd82",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 234,
							name = "Marker 234",
							uuid = "a3c48622-954a-4fbe-a2c9-8fe7c8e84746",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 10,
							dequeueIfLuaFalse = true,
							name = "Marker is on self",
							partyTargetType = "Event Entity",
							uuid = "2d780051-dd89-15a6-8ce1-8fa164ab6e27",
							version = 3,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 44.8,
				name = "[P1] 次元斩标记指路状态 1",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = -6,
				timerStartOffset = -8,
				uuid = "9224a6bc-1d9b-d641-af60-9fe06c0f0579",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local round = 1\ndata.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal state = data.string_dsr\nif tonumber(state.p1SlashGuideRound) ~= round then\n  state.p1SlashGuideRound = round\n  state.p1SlashSelfMarked = false\n  state.p1SlashGuideMode = nil\n  state.p1SlashGuideTargetX = nil\n  state.p1SlashGuideTargetZ = nil\n  state.p1SlashGuideWaymarkID = nil\n  state.p1SlashGuideWaymarkXs = {}\n  state.p1SlashGuideWaymarkZs = {}\n  state.p1SlashGuideWaymarkIDs = {}\nend\n\nlocal now = tonumber(TensorReactions_CurrentTimer)\nif state.p1SlashGuideMode == nil\n    and state.p1SlashSelfMarked ~= true\n    and now ~= nil and now >= 39.8 then\n  local boss = TensorCore.getEntityByGroup(\n    \"ContentID\", { contentid = 3639, subgroup = \"Nearest\" })\n  local bossPos = boss and boss.pos or nil\n  local bossX = type(bossPos) == \"table\" and tonumber(bossPos.x) or nil\n  local bossZ = type(bossPos) == \"table\" and tonumber(bossPos.z) or nil\n  if bossX ~= nil and bossZ ~= nil then\n    state.p1SlashGuideMode = round == 1 and \"boss_down\" or \"boss_up\"\n    state.p1SlashGuideBossEntityID = tonumber(boss.id)\n    state.p1SlashGuideBossX = bossX\n    state.p1SlashGuideBossZ = bossZ\n    state.p1SlashGuideTargetX = bossX\n    state.p1SlashGuideTargetZ = bossZ + (round == 1 and 4 or -4)\n  end\nend\n\nlocal targetX = state.p1SlashGuideTargetX\nlocal targetZ = state.p1SlashGuideTargetZ\nlocal mode = state.p1SlashGuideMode\nif mode == \"waymark\" then\n  local player = TensorCore.mGetPlayer()\n  local playerPos = player and player.pos or nil\n  local xs = state.p1SlashGuideWaymarkXs\n  local zs = state.p1SlashGuideWaymarkZs\n  local ids = state.p1SlashGuideWaymarkIDs\n  if type(playerPos) == \"table\"\n      and type(playerPos.x) == \"number\" and type(playerPos.z) == \"number\"\n      and type(xs) == \"table\" and type(zs) == \"table\" then\n    local bestDistance\n    local bestX\n    local bestZ\n    local bestID\n    for slot = 1, 4 do\n      local x = xs[slot]\n      local z = zs[slot]\n      if type(x) == \"number\" and type(z) == \"number\" then\n        local dx = x - playerPos.x\n        local dz = z - playerPos.z\n        local distance = dx * dx + dz * dz\n        if bestDistance == nil or distance < bestDistance then\n          bestDistance = distance\n          bestX = x\n          bestZ = z\n          bestID = type(ids) == \"table\" and ids[slot] or nil\n        end\n      end\n    end\n    if bestDistance ~= nil then\n      targetX = bestX\n      targetZ = bestZ\n      state.p1SlashGuideWaymarkID = bestID\n    end\n  end\nelseif mode == \"boss_down\" or mode == \"boss_up\" then\n  local bossX = state.p1SlashGuideBossX\n  local bossZ = state.p1SlashGuideBossZ\n  local bossID = tonumber(state.p1SlashGuideBossEntityID)\n  if bossID ~= nil then\n    local boss = TensorCore.mGetEntity(bossID)\n    local pos = boss and boss.pos or nil\n    if type(pos) == \"table\"\n        and type(pos.x) == \"number\" and type(pos.z) == \"number\" then\n      bossX = pos.x\n      bossZ = pos.z\n    end\n  end\n  if type(bossX) == \"number\" and type(bossZ) == \"number\" then\n    targetX = bossX\n    targetZ = bossZ + (mode == \"boss_down\" and 4 or -4)\n  end\nend\n\nif type(targetX) ~= \"number\" or type(targetZ) ~= \"number\" then\n  return\nend\nstate.p1SlashGuideTargetX = targetX\nstate.p1SlashGuideTargetZ = targetZ\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							conditions = 
							{
								
								{
									"8b30dd45-eed5-953c-8015-0f6bcb2c294e",
									true,
								},
							},
							endIfUsed = true,
							name = "本人标记或时间轴兜底动态指路",
							uuid = "171bfa4e-f4e3-e13e-a452-9776e9c3b9c2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return type(MuAiGuide) == \"table\"\n  and type(MuAiGuide.FrameDirect) == \"function\"",
							name = "MuAi 指路可用",
							uuid = "8b30dd45-eed5-953c-8015-0f6bcb2c294e",
							version = 3,
						},
					},
				},
				eventType = 12,
				mechanicTime = 44.8,
				name = "[P1] 次元斩标记动态指路 1",
				timeRange = true,
				timelineIndex = 10,
				timerStartOffset = -8,
				uuid = "e63801cb-3ffd-248a-9d98-9be8bc312e24",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local now = tonumber(TensorReactions_CurrentTimer)\nlocal entityID = tonumber(eventArgs.entityID)\nif type(now) == \"number\" and type(entityID) == \"number\" then\n  local entity = TensorCore.mGetEntity(entityID)\n  local pos = entity and entity.pos or nil\n  local timeout = (69.0 - now) * 1000\n  if type(pos) == \"table\"\n      and type(pos.x) == \"number\" and type(pos.y) == \"number\"\n      and type(pos.z) == \"number\" and timeout > 0 then\n    local drawer = TensorCore.getCachedDrawer(\n      1224720608, 1224720608, 1224720608, 2701099216, 2)\n    drawer:addTimedCircle(timeout, pos.x, pos.y, pos.z, 9, 0, false, false)\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"83759312-5030-14b0-a073-d67d0575bb1f",
									true,
								},
							},
							name = "一次性绘制淡紫危险范围",
							uuid = "7a715249-5f7c-b311-89a5-6bbecb4f4d5a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3293,
							name = "次元裂缝 ContentID 3293",
							uuid = "83759312-5030-14b0-a073-d67d0575bb1f",
							version = 3,
						},
					},
				},
				eventType = 5,
				loop = true,
				mechanicTime = 44.8,
				name = "[P1] 次元裂缝危险范围",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "e2185d02-c81f-efcb-bb4d-cd50fbdc3dad",
				version = 2,
			},
		},
	},
	[11] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"ac00488b-26c1-ed90-bc00-5fafc1cd623f",
									true,
								},
								
								{
									"b0d06522-7153-9919-80bf-e693b93f65b5",
									true,
								},
								
								{
									"cce559d9-22e9-af9c-807b-c954b7d424f5",
									true,
								},
								
								{
									"d90f183c-a9e5-21e6-85c2-d3066aca7ca5",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "19ad416c-7b3d-ffc2-af8c-2d48d9ed97a1",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "ac00488b-26c1-ed90-bc00-5fafc1cd623f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1934,
							category = "Self",
							uuid = "b0d06522-7153-9919-80bf-e693b93f65b5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1951,
							category = "Self",
							uuid = "cce559d9-22e9-af9c-807b-c954b7d424f5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1826,
							category = "Self",
							uuid = "d90f183c-a9e5-21e6-85c2-d3066aca7ca5",
							version = 3,
						},
					},
				},
				mechanicTime = 51.9,
				name = "[P1] 远敏团队减伤",
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 11,
				timerEndOffset = -9,
				timerStartOffset = -12,
				uuid = "cbdf0b50-d546-9593-a4eb-cee5349eb6a7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"68916933-9f7a-be21-b781-f01ce67def2e",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "16f52835-a3cd-bac4-b07e-fce7757587da",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"8bc2c658-10fa-15dc-912f-c96f193a1a2f",
									true,
								},
								
								{
									"1d08a486-82c0-6e06-8be4-f6a680337948",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "d4173e29-ff48-797c-b1a4-ac7c1ea2c523",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"d31ce4a0-ee08-4cae-a9ae-dccb6cef253e",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "8b43f056-540f-8fc4-8391-b3f8b60ae481",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "1d08a486-82c0-6e06-8be4-f6a680337948",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "68916933-9f7a-be21-b781-f01ce67def2e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "8bc2c658-10fa-15dc-912f-c96f193a1a2f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "d31ce4a0-ee08-4cae-a9ae-dccb6cef253e",
							version = 3,
						},
					},
				},
				mechanicTime = 51.9,
				name = "[P1] 近战个人减伤",
				timelineIndex = 11,
				timerOffset = -3,
				uuid = "2b5786e0-7ab2-a88d-b60a-0da6a8535a0b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local round = 2\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif playerID == nil or tonumber(eventArgs.entityID) ~= playerID then\n  return\nend\n\ndata.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal state = data.string_dsr\nif tonumber(state.p1SlashGuideRound) ~= round then\n  state.p1SlashGuideRound = round\n  state.p1SlashSelfMarked = false\n  state.p1SlashGuideMode = nil\n  state.p1SlashGuideTargetX = nil\n  state.p1SlashGuideTargetZ = nil\n  state.p1SlashGuideWaymarkID = nil\n  state.p1SlashGuideWaymarkXs = {}\n  state.p1SlashGuideWaymarkZs = {}\n  state.p1SlashGuideWaymarkIDs = {}\nend\n\nstate.p1SlashSelfMarked = true\nlocal playerPos = player.pos\nif type(playerPos) == \"table\"\n    and type(playerPos.x) == \"number\" and type(playerPos.z) == \"number\"\n    and type(Argus) == \"table\" and type(Argus.getWaymarkInfo) == \"function\" then\n  local markerIDs = { 8, 4, 3, 7 }\n  local xs = {}\n  local zs = {}\n  local ids = {}\n  local bestDistance\n  local bestX\n  local bestZ\n  local bestID\n  for slot = 1, 4 do\n    local markerID = markerIDs[slot]\n    local x, _, z, active = Argus.getWaymarkInfo(markerID)\n    if active == true and type(x) == \"number\" and type(z) == \"number\" then\n      xs[slot] = x\n      zs[slot] = z\n      ids[slot] = markerID\n      local dx = x - playerPos.x\n      local dz = z - playerPos.z\n      local distance = dx * dx + dz * dz\n      if bestDistance == nil or distance < bestDistance then\n        bestDistance = distance\n        bestX = x\n        bestZ = z\n        bestID = markerID\n      end\n    end\n  end\n  state.p1SlashGuideWaymarkXs = xs\n  state.p1SlashGuideWaymarkZs = zs\n  state.p1SlashGuideWaymarkIDs = ids\n  if bestID ~= nil then\n    state.p1SlashGuideMode = \"waymark\"\n    state.p1SlashGuideTargetX = bestX\n    state.p1SlashGuideTargetZ = bestZ\n    state.p1SlashGuideWaymarkID = bestID\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"ae6aa058-c304-cd68-95d8-f6f5575a5f69",
									true,
								},
								
								{
									"1dee4939-07af-b1a3-b5fa-1d3979b0d6cf",
									true,
								},
							},
							endIfUsed = true,
							name = "记录本人第二轮标记与目标点",
							uuid = "49e51c8b-0c25-c951-a04e-62ea3be1732d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 234,
							name = "Marker 234",
							uuid = "ae6aa058-c304-cd68-95d8-f6f5575a5f69",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 10,
							dequeueIfLuaFalse = true,
							name = "Marker is on self",
							partyTargetType = "Event Entity",
							uuid = "1dee4939-07af-b1a3-b5fa-1d3979b0d6cf",
							version = 3,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 51.9,
				name = "[P1] 次元斩标记指路状态 2",
				timeRange = true,
				timelineIndex = 11,
				timerEndOffset = -6,
				timerStartOffset = -8,
				uuid = "6daeec09-7d89-72e7-88f7-0c31f353a6d3",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local round = 2\ndata.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal state = data.string_dsr\nif tonumber(state.p1SlashGuideRound) ~= round then\n  state.p1SlashGuideRound = round\n  state.p1SlashSelfMarked = false\n  state.p1SlashGuideMode = nil\n  state.p1SlashGuideTargetX = nil\n  state.p1SlashGuideTargetZ = nil\n  state.p1SlashGuideWaymarkID = nil\n  state.p1SlashGuideWaymarkXs = {}\n  state.p1SlashGuideWaymarkZs = {}\n  state.p1SlashGuideWaymarkIDs = {}\nend\n\nlocal now = tonumber(TensorReactions_CurrentTimer)\nif state.p1SlashGuideMode == nil\n    and state.p1SlashSelfMarked ~= true\n    and now ~= nil and now >= 46.9 then\n  local boss = TensorCore.getEntityByGroup(\n    \"ContentID\", { contentid = 3639, subgroup = \"Nearest\" })\n  local bossPos = boss and boss.pos or nil\n  local bossX = type(bossPos) == \"table\" and tonumber(bossPos.x) or nil\n  local bossZ = type(bossPos) == \"table\" and tonumber(bossPos.z) or nil\n  if bossX ~= nil and bossZ ~= nil then\n    state.p1SlashGuideMode = round == 1 and \"boss_down\" or \"boss_up\"\n    state.p1SlashGuideBossEntityID = tonumber(boss.id)\n    state.p1SlashGuideBossX = bossX\n    state.p1SlashGuideBossZ = bossZ\n    state.p1SlashGuideTargetX = bossX\n    state.p1SlashGuideTargetZ = bossZ + (round == 1 and 4 or -4)\n  end\nend\n\nlocal targetX = state.p1SlashGuideTargetX\nlocal targetZ = state.p1SlashGuideTargetZ\nlocal mode = state.p1SlashGuideMode\nif mode == \"waymark\" then\n  local player = TensorCore.mGetPlayer()\n  local playerPos = player and player.pos or nil\n  local xs = state.p1SlashGuideWaymarkXs\n  local zs = state.p1SlashGuideWaymarkZs\n  local ids = state.p1SlashGuideWaymarkIDs\n  if type(playerPos) == \"table\"\n      and type(playerPos.x) == \"number\" and type(playerPos.z) == \"number\"\n      and type(xs) == \"table\" and type(zs) == \"table\" then\n    local bestDistance\n    local bestX\n    local bestZ\n    local bestID\n    for slot = 1, 4 do\n      local x = xs[slot]\n      local z = zs[slot]\n      if type(x) == \"number\" and type(z) == \"number\" then\n        local dx = x - playerPos.x\n        local dz = z - playerPos.z\n        local distance = dx * dx + dz * dz\n        if bestDistance == nil or distance < bestDistance then\n          bestDistance = distance\n          bestX = x\n          bestZ = z\n          bestID = type(ids) == \"table\" and ids[slot] or nil\n        end\n      end\n    end\n    if bestDistance ~= nil then\n      targetX = bestX\n      targetZ = bestZ\n      state.p1SlashGuideWaymarkID = bestID\n    end\n  end\nelseif mode == \"boss_down\" or mode == \"boss_up\" then\n  local bossX = state.p1SlashGuideBossX\n  local bossZ = state.p1SlashGuideBossZ\n  local bossID = tonumber(state.p1SlashGuideBossEntityID)\n  if bossID ~= nil then\n    local boss = TensorCore.mGetEntity(bossID)\n    local pos = boss and boss.pos or nil\n    if type(pos) == \"table\"\n        and type(pos.x) == \"number\" and type(pos.z) == \"number\" then\n      bossX = pos.x\n      bossZ = pos.z\n    end\n  end\n  if type(bossX) == \"number\" and type(bossZ) == \"number\" then\n    targetX = bossX\n    targetZ = bossZ + (mode == \"boss_down\" and 4 or -4)\n  end\nend\n\nif type(targetX) ~= \"number\" or type(targetZ) ~= \"number\" then\n  return\nend\nstate.p1SlashGuideTargetX = targetX\nstate.p1SlashGuideTargetZ = targetZ\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							conditions = 
							{
								
								{
									"c06e27d6-bf2c-821b-a869-e431462ad556",
									true,
								},
							},
							endIfUsed = true,
							name = "本人标记或时间轴兜底动态指路",
							uuid = "4a9cabfc-d66c-13f2-80c5-540e725720e7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return type(MuAiGuide) == \"table\"\n  and type(MuAiGuide.FrameDirect) == \"function\"",
							name = "MuAi 指路可用",
							uuid = "c06e27d6-bf2c-821b-a869-e431462ad556",
							version = 3,
						},
					},
				},
				eventType = 12,
				mechanicTime = 51.9,
				name = "[P1] 次元斩标记动态指路 2",
				timeRange = true,
				timelineIndex = 11,
				timerStartOffset = -8,
				uuid = "4184a4fd-03f6-4555-891b-d340e27fa2f9",
				version = 2,
			},
		},
	},
	[12] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nif player and eventArgs.entityID and eventArgs.channelTimeMax and eventArgs.channelTimeMax > 0 then\n  TensorCore.getStaticDrawer(520093951):addTimedArrowOnEnt(eventArgs.channelTimeMax * 1000, eventArgs.entityID, 20, 1, 2, 3, player.id)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"7750ab7b-77b2-5e07-af24-eab53325bb45",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw knockback direction",
							uuid = "77aeef5e-6dc8-0022-bb14-50aa17fc51bc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25308,
							name = "Faith Unmoving",
							uuid = "7750ab7b-77b2-5e07-af24-eab53325bb45",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 59.8,
				name = "[P1] 信仰不移击退方向",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 10,
				timerStartOffset = -1,
				uuid = "c52d7c64-e974-67fd-b9bc-2f9d0086dbe1",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal entityID = tonumber(eventArgs.entityID)\nlocal channelTime = tonumber(eventArgs.channelTimeMax)\nlocal timeout = channelTime and channelTime > 0 and channelTime * 1000 or 700\nif entityID == nil then\n  self.used = true\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nlocal entity = TensorCore.mGetEntity(entityID)\nlocal pos = entity and entity.pos or nil\nlocal draws = state.p1ShiningBladeDraws\nlocal matched\nif type(pos) == \"table\"\n    and type(pos.x) == \"number\" and type(pos.z) == \"number\"\n    and type(draws) == \"table\" then\n  local bestDistance\n  for index = 1, #draws do\n    local draw = draws[index]\n    if type(draw) == \"table\" and draw.claimed ~= true\n        and type(draw.x) == \"number\" and type(draw.z) == \"number\" then\n      local dx = draw.x - pos.x\n      local dz = draw.z - pos.z\n      local distance = dx * dx + dz * dz\n      if distance <= 1 and (bestDistance == nil or distance < bestDistance) then\n        bestDistance = distance\n        matched = draw\n      end\n    end\n  end\nend\n\nlocal updated = false\nif matched ~= nil and matched.uuid ~= nil then\n  updated = drawer:updateTimedCircleOnEnt(\n    matched.uuid,\n    timeout,\n    entityID,\n    9,\n    0,\n    false,\n    false\n  ) == true\n  matched.claimed = true\nend\nif updated ~= true then\n  drawer:addTimedCircleOnEnt(timeout, entityID, 9, 0, false, false)\nend\n\nstate.p1ShiningBladeObservedCount =\n  (tonumber(state.p1ShiningBladeObservedCount) or 0) + 1\nlocal now = tonumber(TensorReactions_CurrentTimer)\nif now ~= nil then\n  local actualEnd = now + timeout / 1000\n  local currentEnd = tonumber(state.p1ShiningBladeGuideEndsAt)\n  if currentEnd == nil or actualEnd > currentEnd then\n    state.p1ShiningBladeGuideEndsAt = actualEnd\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"060c70a7-548c-926a-8ad8-ed4c46282b77",
									true,
								},
								
								{
									"f758cbe4-0fb9-307e-ac8e-7ebb9d88e14b",
									true,
								},
							},
							endIfUsed = true,
							name = "按实际光球读条修正判定时间",
							uuid = "c91b538e-c080-b5a4-9074-f19f637039d4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 4385,
							name = "Holy Orb",
							uuid = "060c70a7-548c-926a-8ad8-ed4c46282b77",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25295,
							name = "Bright Flare",
							uuid = "f758cbe4-0fb9-307e-ac8e-7ebb9d88e14b",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 59.8,
				name = "[P1] 光球范围",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 13,
				timerStartOffset = -2,
				uuid = "528f33a2-3720-cf49-94e9-75c6c580f966",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7548,
							conditions = 
							{
								
								{
									"e0bf6ca0-036a-f33e-a747-ea6fe7acbae3",
									true,
								},
							},
							endIfUsed = true,
							uuid = "bb81874f-61c9-abef-a15d-0615e54b8545",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7559,
							conditions = 
							{
								
								{
									"e0bf6ca0-036a-f33e-a747-ea6fe7acbae3",
									true,
								},
							},
							endIfUsed = true,
							uuid = "b6f77d1a-255c-6c53-84a8-345d895d015e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25308,
							name = "Faith Unmoving",
							uuid = "e0bf6ca0-036a-f33e-a747-ea6fe7acbae3",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 59.8,
				name = "[P1] 自动防击退",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 3,
				timerStartOffset = -10,
				uuid = "2a63f7dd-7d7c-98e8-9feb-716a15af5122",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"ec30b706-0522-f3ea-ba62-d5f30e0769fc",
									true,
								},
								
								{
									"2f69cc33-6c2f-0abb-8419-b7f29f45eeaf",
									true,
								},
								
								{
									"cf3cd82b-669b-f0a3-87de-6afdbfe2c7ec",
									true,
								},
								
								{
									"6e8a5f8b-c67a-4cce-9d69-effe483d980c",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "6de390ba-64da-98ed-bb22-91e13aa9203a",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "ec30b706-0522-f3ea-ba62-d5f30e0769fc",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1934,
							category = "Self",
							uuid = "2f69cc33-6c2f-0abb-8419-b7f29f45eeaf",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1951,
							category = "Self",
							uuid = "cf3cd82b-669b-f0a3-87de-6afdbfe2c7ec",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1826,
							category = "Self",
							uuid = "6e8a5f8b-c67a-4cce-9d69-effe483d980c",
							version = 3,
						},
					},
				},
				enabled = false,
				mechanicTime = 59.8,
				name = "[P1] 远敏团队减伤",
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 12,
				timerStartOffset = -3,
				uuid = "f78cd4d4-76cc-761f-acf2-34f33f05cff8",
				version = 2,
			},
		},
	},
	[13] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetSubType = "Highest HP",
							targetType = "Enemy",
							uuid = "74285703-6aec-1d9f-87ec-8b85e9b98157",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 60.9,
				name = "[P1] 自动目标：Thordan 强制 Highest HP",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = 10,
				timerStartOffset = 7,
				uuid = "dcf8305e-d9b9-33fd-b75e-0c1b1d33325b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal source = eventArgs.entityID and TensorCore.mGetEntity(eventArgs.entityID) or nil\nlocal sourcePos = source and source.pos or nil\nlocal sx = sourcePos and tonumber(sourcePos.x) or nil\nlocal sy = sourcePos and tonumber(sourcePos.y) or tonumber(eventArgs.castPosY) or 0\nlocal sz = sourcePos and tonumber(sourcePos.z) or nil\nlocal tx = tonumber(eventArgs.castPosX)\nlocal tz = tonumber(eventArgs.castPosZ)\nlocal now = tonumber(TensorReactions_CurrentTimer)\nif sx == nil or sz == nil or tx == nil or tz == nil or now == nil then\n  self.used = true\n  return\nend\n\nlocal centerX = 100\nlocal centerZ = 100\nlocal sdx = sx - centerX\nlocal sdz = sz - centerZ\nlocal tdx = tx - centerX\nlocal tdz = tz - centerZ\nlocal sourceRadius = math.sqrt(sdx * sdx + sdz * sdz)\nlocal targetRadius = math.sqrt(tdx * tdx + tdz * tdz)\nif sourceRadius < 20 or sourceRadius > 24 or targetRadius < 20 or targetRadius > 24 then\n  self.used = true\n  return\nend\n\nlocal ax\nlocal az\nif math.abs(sdx) > math.abs(sdz) then\n  ax = sdx >= 0 and 1 or -1\n  az = 0\nelse\n  ax = 0\n  az = sdz >= 0 and 1 or -1\nend\nlocal bx\nlocal bz\nif math.abs(tdx) > math.abs(tdz) then\n  bx = tdx >= 0 and 1 or -1\n  bz = 0\nelse\n  bx = 0\n  bz = tdz >= 0 and 1 or -1\nend\nif math.abs(ax * bx + az * bz) > 0.01 then\n  self.used = true\n  return\nend\n\nlocal coefficients = {\n  { 22, 0 },\n  { 11, 11 },\n  { 0, 22 },\n  { 0, 7.5 },\n  { 0, -7.5 },\n  { 0, -22 },\n  { -11, -11 },\n  { -22, 0 },\n  { -7.5, 0 },\n  { 7.5, 0 },\n  { 22, 0 },\n}\nlocal timeouts = {\n  3075, 3372, 3696, 4169, 4651, 4776,\n  5184, 5624, 6310, 6622, 7006,\n}\nlocal drawer = TensorCore.getMoogleDrawer()\nlocal draws = {}\nfor index = 1, #coefficients do\n  local coefficient = coefficients[index]\n  local x = centerX + ax * coefficient[1] + bx * coefficient[2]\n  local z = centerZ + az * coefficient[1] + bz * coefficient[2]\n  local uuid = drawer:addTimedCircle(timeouts[index], x, sy, z, 9, 0, false, false)\n  draws[index] = {\n    x = x,\n    z = z,\n    uuid = uuid,\n    claimed = false,\n  }\nend\n\nstate.p1ShiningBladeDraws = draws\nstate.p1ShiningBladeGuideTargetX = centerX + (-ax + bx) * 11\nstate.p1ShiningBladeGuideTargetZ = centerZ + (-az + bz) * 11\nstate.p1ShiningBladeGuideStartedAt = now\nstate.p1ShiningBladeGuideEndsAt = now + 7.1\nstate.p1ShiningBladeObservedCount = 0\nself.used = true",
							conditions = 
							{
								
								{
									"8cc3df64-8349-f594-850d-b88d26e67c79",
									true,
								},
								
								{
									"dd29ae51-b130-5655-866b-0bd368ae5e07",
									true,
								},
								
								{
									"f83db873-39c9-1694-9edf-c28dc023aa82",
									true,
								},
							},
							endIfUsed = true,
							name = "预绘 11 个钢铁并记录安全点",
							uuid = "42563186-d07a-bb16-8989-221a9d095ae2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25294,
							name = "Shining Blade",
							uuid = "8cc3df64-8349-f594-850d-b88d26e67c79",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3634,
							name = "Ser Adelphel",
							uuid = "dd29ae51-b130-5655-866b-0bd368ae5e07",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local now = tonumber(TensorReactions_CurrentTimer)\nlocal state = data.string_dsr\nif now == nil or state == nil then\n  return now ~= nil\nend\nlocal startedAt = tonumber(state.p1ShiningBladeGuideStartedAt)\nlocal endsAt = tonumber(state.p1ShiningBladeGuideEndsAt)\nreturn startedAt == nil\n  or endsAt == nil\n  or now < startedAt\n  or now >= endsAt",
							dequeueIfLuaFalse = true,
							name = "First Shining Blade only",
							uuid = "f83db873-39c9-1694-9edf-c28dc023aa82",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 60.9,
				name = "[P1] 光芒剑钢铁预绘",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = 10,
				timerStartOffset = -5,
				uuid = "60dd3bb7-3ddd-902e-a1b6-9ec1e72d91e0",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nMuAiGuide.FrameDirect(\n  state.p1ShiningBladeGuideTargetX,\n  state.p1ShiningBladeGuideTargetZ,\n  0.5\n)\nself.used = true",
							conditions = 
							{
								
								{
									"8cada359-7e8e-82da-9ec9-88ae17ff9be8",
									true,
								},
							},
							endIfUsed = true,
							name = "持续指向同侧下半场安全花瓣",
							uuid = "9d36b418-9217-21d9-bbe7-4f3af0210911",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local state = data.string_dsr\nreturn state ~= nil\n  and type(state.p1ShiningBladeGuideTargetX) == \"number\"\n  and type(state.p1ShiningBladeGuideTargetZ) == \"number\"\n  and type(state.p1ShiningBladeGuideEndsAt) == \"number\"\n  and type(TensorReactions_CurrentTimer) == \"number\"\n  and TensorReactions_CurrentTimer < state.p1ShiningBladeGuideEndsAt\n  and type(MuAiGuide) == \"table\"\n  and type(MuAiGuide.FrameDirect) == \"function\"",
							name = "Shining Blade guide is active",
							uuid = "8cada359-7e8e-82da-9ec9-88ae17ff9be8",
							version = 3,
						},
					},
				},
				eventType = 12,
				mechanicTime = 60.9,
				name = "[P1] 光芒剑安全区动态指路",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = 10,
				timerStartOffset = -5,
				uuid = "e981f0b6-b05c-2d20-9bab-ae7bf77598df",
				version = 2,
			},
		},
	},
	[14] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7551,
							conditions = 
							{
								
								{
									"32e409cf-ef67-9f3b-87a1-07a04d2fb208",
									true,
								},
								
								{
									"ec61fc97-812f-c51b-a488-8ef4797e6f35",
									true,
								},
								
								{
									"bd00c921-a20b-a113-8390-733a92e97320",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							targetContentID = 3634,
							targetType = "ContentID",
							uuid = "66c42f74-f1d6-a980-88ef-23e93a2e5ae4",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7538,
							conditions = 
							{
								
								{
									"32e409cf-ef67-9f3b-87a1-07a04d2fb208",
									true,
								},
								
								{
									"390a5493-0265-6a15-a62c-3a7fea213e95",
									true,
								},
								
								{
									"2b963695-49ad-0a7b-bd6c-6b03073b84b6",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							targetContentID = 3634,
							targetType = "ContentID",
							uuid = "51eeeb15-8df0-9ad0-b3de-e154c3c54933",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25296,
							name = "至圣祥光",
							uuid = "32e409cf-ef67-9f3b-87a1-07a04d2fb208",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远程物理职业",
							uuid = "ec61fc97-812f-c51b-a488-8ef4797e6f35",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return ACR_RikuDNC3_Interrupt == true or ACR_TensorRequiem3_AutoInterrupt == true or ACR_TensorMagnum3_AutoInterrupt == true",
							name = "远程打断开关",
							uuid = "bd00c921-a20b-a113-8390-733a92e97320",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								19,
								21,
								32,
								37,
							},
							name = "坦克职业",
							uuid = "390a5493-0265-6a15-a62c-3a7fea213e95",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return ACR_RikuPLD3_AutoInterrupt == true or ACR_RikuWAR3_AutoInterrupt == true or ACR_RikuDRK3_AutoInterrupt == true or ACR_RikuGNB3_AutoInterrupt == true",
							name = "坦克打断开关",
							uuid = "2b963695-49ad-0a7b-bd6c-6b03073b84b6",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 69.1,
				name = "[P1] 第一次至圣祥光自动打断",
				timeRange = true,
				timelineIndex = 14,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "720f7f9b-4589-ba43-83c8-2ac824304104",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal st = type(party) == \"table\" and party.ST or nil\nlocal targetID = tonumber(st and st.id)\nif targetID == nil then\n  return\nend\n\nlocal drawer = state.p1ExecutionCircleDrawer\nif drawer == nil then\n  local red = GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.45)\n  drawer = TensorCore.getStaticDrawer(red, 2)\n  state.p1ExecutionCircleDrawer = drawer\nend\n\ndrawer:addTimedCircleOnEnt(3000, targetID, 5, 0, false, false)\nself.used = true",
							name = "在 ST 身上绘制 3000ms 固定红色处刑圆",
							uuid = "23f2561a-b9ab-47fb-aa70-3d1f552d161d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 69.1,
				name = "[P1] 处刑圆形死刑",
				timelineIndex = 14,
				timerOffset = -3,
				timerStartOffset = -3,
				uuid = "5f6ce496-4ebe-da35-a8e7-73fe3142ed48",
				version = 2,
			},
		},
	},
	[15] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nif player and eventArgs.entityID and eventArgs.channelTimeMax and eventArgs.channelTimeMax > 0 then\n  TensorCore.getStaticDrawer(520093951):addTimedArrowOnEnt(eventArgs.channelTimeMax * 1000, eventArgs.entityID, 20, 1, 2, 3, player.id)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"2785fba2-ecd7-5c78-a7e6-8105a1c0af3d",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw knockback direction",
							uuid = "ced537a5-e185-ee39-bfbd-150ed34ed53c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25308,
							name = "Faith Unmoving",
							uuid = "2785fba2-ecd7-5c78-a7e6-8105a1c0af3d",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 86.2,
				name = "[P1] 信仰不移击退方向（二）",
				timeRange = true,
				timelineIndex = 15,
				timerEndOffset = 10,
				timerStartOffset = -1,
				uuid = "8a08ea9b-a9db-d6a6-82fa-79e5f63b2108",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"38a6ba17-67cb-f3c7-85cf-221ece969bd6",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "03246609-a4a5-ac14-97b6-668177e6d760",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"f300330d-12c5-4274-b0ab-e4b870f7c4d3",
									true,
								},
								
								{
									"95ebea67-9dcc-5404-852a-2ab83faa6b59",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "21be3114-c673-c166-9529-93077fa7c3f8",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"d4bda5fa-b44d-9a60-af91-d098bddd9b74",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "e28062c5-230a-5a32-a66a-32c31f48c7aa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "95ebea67-9dcc-5404-852a-2ab83faa6b59",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "38a6ba17-67cb-f3c7-85cf-221ece969bd6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "f300330d-12c5-4274-b0ab-e4b870f7c4d3",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "d4bda5fa-b44d-9a60-af91-d098bddd9b74",
							version = 3,
						},
					},
				},
				mechanicTime = 86.2,
				name = "[P1] 近战个人减伤",
				timelineIndex = 15,
				timerOffset = -3,
				uuid = "9589927e-e4f4-ed2c-b7c8-8aa8af4a5473",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = player and tonumber(player.id) or nil\nlocal markerID = tonumber(eventArgs.markerID)\nif playerID == nil then\n  self.used = true\n  return\nend\n\nlocal targetX\nlocal targetZ\nif markerID == 281 then\n  local pos = player.pos\n  local playerX = type(pos) == \"table\" and tonumber(pos.x) or nil\n  if playerX ~= nil then\n    targetX = playerX < 100 and 96.5 or 103.5\n    targetZ = 100\n  end\nelseif markerID == 282 then\n  if TensorCore.isHealer(player) then\n    targetX = 98\n    targetZ = 97.5\n  elseif TensorCore.isDPS(player) then\n    targetX = 102\n    targetZ = 102.5\n  end\nelseif markerID == 283 then\n  if TensorCore.isTank(player) then\n    targetX = 102\n    targetZ = 97.5\n  elseif TensorCore.isDPS(player) then\n    targetX = 98\n    targetZ = 102.5\n  end\nelseif markerID == 284 then\n  if TensorCore.isTank(player) then\n    targetX = 100\n    targetZ = 96.5\n  elseif TensorCore.isHealer(player) then\n    targetX = 100\n    targetZ = 103.5\n  end\nend\n\nif targetX ~= nil and targetZ ~= nil then\n  state.p1HeavensflameMarkerID = markerID\n  state.p1HeavensflameGuideTargetX = targetX\n  state.p1HeavensflameGuideTargetZ = targetZ\nend\nself.used = true",
							conditions = 
							{
								
								{
									"995d1d5c-3c7f-0ad9-bae6-3afe62a146d8",
									true,
								},
								
								{
									"2bc864b8-87cc-c215-9f99-6eeef4c3e8b0",
									true,
								},
							},
							endIfUsed = true,
							name = "按标记与职能记录八方目标",
							uuid = "1b5a5b3c-48d3-a6aa-aa98-7861bf431336",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							markerIDList = 
							{
								281,
								282,
								283,
								284,
							},
							name = "PS 标记 281–284",
							uuid = "995d1d5c-3c7f-0ad9-bae6-3afe62a146d8",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 10,
							dequeueIfLuaFalse = true,
							name = "Marker is on self",
							partyTargetType = "Event Entity",
							uuid = "2bc864b8-87cc-c215-9f99-6eeef4c3e8b0",
							version = 3,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 86.2,
				name = "[P1] 天火标记动态指路状态",
				timeRange = true,
				timelineIndex = 15,
				timerStartOffset = -10,
				uuid = "7efce4b9-d810-ad7d-acfa-d995b6d16320",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal targetX = state.p1HeavensflameGuideTargetX\nlocal targetZ = state.p1HeavensflameGuideTargetZ\n\nif tonumber(state.p1HeavensflameMarkerID) == 281 then\n  local player = TensorCore.mGetPlayer()\n  local pos = player and player.pos or nil\n  local playerX = type(pos) == \"table\" and tonumber(pos.x) or nil\n  local playerZ = type(pos) == \"table\" and tonumber(pos.z) or nil\n  if playerX ~= nil and playerZ ~= nil then\n    local leftX = 96.5\n    local leftZ = 100\n    local rightX = 103.5\n    local rightZ = 100\n    local leftDX = leftX - playerX\n    local leftDZ = leftZ - playerZ\n    local rightDX = rightX - playerX\n    local rightDZ = rightZ - playerZ\n    local leftDistance = leftDX * leftDX + leftDZ * leftDZ\n    local rightDistance = rightDX * rightDX + rightDZ * rightDZ\n    if leftDistance <= rightDistance then\n      targetX = leftX\n      targetZ = leftZ\n    else\n      targetX = rightX\n      targetZ = rightZ\n    end\n    state.p1HeavensflameGuideTargetX = targetX\n    state.p1HeavensflameGuideTargetZ = targetZ\n  end\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							conditions = 
							{
								
								{
									"924d32d1-6e48-d80e-9325-7fce23c14e5a",
									true,
								},
							},
							endIfUsed = true,
							name = "红圈实时最近点，其余固定站位",
							uuid = "0a22558c-f209-4c8d-923e-4f6767ced619",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local state = data.string_dsr\nreturn state ~= nil\n  and type(state.p1HeavensflameGuideTargetX) == \"number\"\n  and type(state.p1HeavensflameGuideTargetZ) == \"number\"\n  and type(MuAiGuide) == \"table\"\n  and type(MuAiGuide.FrameDirect) == \"function\"",
							name = "天火目标点已就绪",
							uuid = "924d32d1-6e48-d80e-9325-7fce23c14e5a",
							version = 3,
						},
					},
				},
				eventType = 12,
				mechanicTime = 86.2,
				name = "[P1] 天火标记动态指路",
				timeRange = true,
				timelineIndex = 15,
				timerStartOffset = -10,
				uuid = "2cb9af4b-7c55-1697-800b-6d6bd4204e8c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local drawer = TensorCore.getMoogleDrawer()\nlocal party = TensorCore.getEntityGroupList(\"Party\", { noAliveCheck = true })\nif drawer and type(party) == \"table\" then\n  for _, member in pairs(party) do\n    if member and tonumber(member.id) ~= nil then\n      drawer:addTimedCircleOnEnt(2550, member.id, 10, 0, false, false)\n    end\n  end\nend\nself.used = true",
							endIfUsed = true,
							name = "绘制八人 10 米个人圆",
							uuid = "54f7b5a0-2816-7a4b-aba9-c100d6d8151b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 86.2,
				name = "[P1] 天火击退后个人圆",
				timelineIndex = 15,
				timerEndOffset = 2,
				timerStartOffset = -3,
				uuid = "8f6d0314-3851-6aff-aa70-5ff94f9d0064",
				version = 2,
			},
		},
	},
	[16] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"215c8a9b-4fd1-371f-81e8-51c378274bb3",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetSubType = "Highest HP",
							targetType = "Enemy",
							uuid = "639fce05-61a1-76e4-a0bb-8e03e849afe5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "215c8a9b-4fd1-371f-81e8-51c378274bb3",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 88.2,
				name = "[P1] 自动目标：Thordan Highest HP",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 16,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "8c4e5225-393f-4fee-8eed-119e84e0dbea",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7551,
							conditions = 
							{
								
								{
									"26bb6cd0-4cc9-f88f-b265-04798733843e",
									true,
								},
							},
							endIfUsed = true,
							targetContentID = 3634,
							targetType = "ContentID",
							uuid = "f84cc5de-5dd5-c888-bff2-2280ae4aeef1",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7538,
							conditions = 
							{
								
								{
									"26bb6cd0-4cc9-f88f-b265-04798733843e",
									true,
								},
							},
							endIfUsed = true,
							targetContentID = 3634,
							targetType = "ContentID",
							uuid = "fb9b03b3-c1a6-8198-b21f-bc7ed41c78b4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25296,
							name = "至圣祥光",
							uuid = "26bb6cd0-4cc9-f88f-b265-04798733843e",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 88.2,
				name = "[P1] 第二次至圣祥光自动打断",
				timeRange = true,
				timelineIndex = 16,
				timerEndOffset = 10,
				uuid = "5999cd0a-9d29-e4c2-925a-5b5b9a6dc036",
				version = 2,
			},
		},
	},
	[17] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							conditions = 
							{
								
								{
									"c9c6ee8d-fd87-48b1-92a7-4b3ebea2941f",
									true,
								},
								
								{
									"f2ac9ff8-8b4e-e28c-a1fe-47803aa7d1f3",
									true,
								},
							},
							endIfUsed = true,
							name = "牵制",
							targetContentID = 3634,
							targetType = "ContentID",
							uuid = "181e7c26-16a6-7a14-9e62-4fde16df2460",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Feint check",
							uuid = "f2ac9ff8-8b4e-e28c-a1fe-47803aa7d1f3",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
								22,
								30,
								34,
								39,
								41,
							},
							name = "牵制职业",
							uuid = "c9c6ee8d-fd87-48b1-92a7-4b3ebea2941f",
							version = 3,
						},
					},
				},
				mechanicTime = 102.2,
				name = "[P1] 牵制",
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 17,
				timerEndOffset = -3,
				timerStartOffset = -7,
				uuid = "0055b1c6-2dec-e9c0-9d3e-fe84a5104431",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7560,
							conditions = 
							{
								
								{
									"45ed1e7b-d553-4758-ac84-c88f956f58c7",
									true,
								},
								
								{
									"34502cb7-a8de-9eef-800e-78acc87e6990",
									true,
								},
							},
							endIfUsed = true,
							name = "昏乱",
							targetContentID = 3634,
							targetType = "ContentID",
							uuid = "7f26bc34-c6ef-9f5d-a005-00c265af8f2a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1203,
							name = "Addle check",
							uuid = "34502cb7-a8de-9eef-800e-78acc87e6990",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
								27,
								35,
								42,
							},
							name = "昏乱职业",
							uuid = "45ed1e7b-d553-4758-ac84-c88f956f58c7",
							version = 3,
						},
					},
				},
				mechanicTime = 102.2,
				name = "[P1] 昏乱",
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 17,
				timerEndOffset = -3,
				timerStartOffset = -7,
				uuid = "022c67eb-040b-0f1d-85a8-11b767b07eef",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2887,
							conditions = 
							{
								
								{
									"e09f5e35-a87d-9eee-85cf-acde4be6fd1f",
									true,
								},
								
								{
									"eb0bd766-504f-8197-946d-d5bbe01558cb",
									true,
								},
							},
							endIfUsed = true,
							name = "武装解除",
							targetType = "Current Target",
							uuid = "8bc22ae6-ed9c-d707-9545-5e801c1a4a1c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 860,
							name = "Dismantle check",
							uuid = "eb0bd766-504f-8197-946d-d5bbe01558cb",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								31,
							},
							name = "武装解除职业",
							uuid = "e09f5e35-a87d-9eee-85cf-acde4be6fd1f",
							version = 3,
						},
					},
				},
				mechanicTime = 102.2,
				name = "[P1] 武装解除",
				randomTimeout = 8,
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 17,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "6dbbe91a-a7df-5940-b4e3-175930350e2c",
				version = 2,
			},
		},
	},
	[18] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7551,
							conditions = 
							{
								
								{
									"c714691f-3ad7-92e9-a6ef-65b5c9198f17",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							targetContentID = 3634,
							targetType = "ContentID",
							uuid = "b672c15d-63d9-cbae-b89f-1f86d68893c0",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7538,
							conditions = 
							{
								
								{
									"c714691f-3ad7-92e9-a6ef-65b5c9198f17",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							targetContentID = 3634,
							targetType = "ContentID",
							uuid = "8e679947-46fd-69df-a807-179de87f07cf",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25296,
							name = "至圣祥光",
							uuid = "c714691f-3ad7-92e9-a6ef-65b5c9198f17",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 104.2,
				name = "[P1] 第三次至圣祥光自动打断",
				timeRange = true,
				timelineIndex = 18,
				timerEndOffset = 20,
				timerStartOffset = -10,
				uuid = "6dfc4a58-163f-add2-8728-e3a7dedbd44d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal aoeID = tonumber(eventArgs.aoeID)\nlocal centerX = tonumber(eventArgs.x)\nlocal centerZ = tonumber(eventArgs.z)\nlocal centerEntityID = tonumber(eventArgs.entityID)\nstate.p1LateDimensionCenterX = nil\nstate.p1LateDimensionCenterZ = nil\nstate.p1LateDimensionCenterEntityID = nil\nstate.p1LateDimensionAoeID = nil\nif (aoeID == 25306 or aoeID == 25307)\n    and type(centerX) == \"number\" and type(centerZ) == \"number\"\n    and type(centerEntityID) == \"number\" then\n  state.p1LateDimensionCenterX = centerX\n  state.p1LateDimensionCenterZ = centerZ\n  state.p1LateDimensionCenterEntityID = centerEntityID\n  state.p1LateDimensionAoeID = aoeID\nend\nself.used = true",
							conditions = 
							{
								
								{
									"c64105f5-7256-8b45-bab8-2ca7be04953f",
									true,
								},
							},
							endIfUsed = true,
							name = "记录钢铁月环动态中心",
							uuid = "38c072e0-b812-409c-8370-132b63d7f6f1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return eventArgs.contentID == 3639 and (eventArgs.aoeID == 25306 or eventArgs.aoeID == 25307)",
							dequeueIfLuaFalse = true,
							name = "格里诺钢铁/月环 AOE",
							uuid = "c64105f5-7256-8b45-bab8-2ca7be04953f",
							version = 3,
						},
					},
				},
				eventType = 18,
				mechanicTime = 104.2,
				name = "[P1] 钢铁月环最近安全点状态",
				timeRange = true,
				timelineIndex = 18,
				timerStartOffset = -6,
				uuid = "df5bb9f3-3c53-a5e5-a651-b34f04ca6b10",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal centerX = state.p1LateDimensionCenterX\nlocal centerZ = state.p1LateDimensionCenterZ\nlocal source = TensorCore.mGetEntity(state.p1LateDimensionCenterEntityID)\nif source and source.pos\n    and type(source.pos.x) == \"number\" and type(source.pos.z) == \"number\" then\n  centerX = source.pos.x\n  centerZ = source.pos.z\nend\n\nlocal player = TensorCore.mGetPlayer()\nlocal pos = player and player.pos or nil\nif pos and type(pos.x) == \"number\" and type(pos.z) == \"number\" then\n  local dx = pos.x - centerX\n  local dz = pos.z - centerZ\n  local distanceSquared = dx * dx + dz * dz\n  local targetX = pos.x\n  local targetZ = pos.z\n\n  if state.p1LateDimensionAoeID == 25307 and distanceSquared < 49 then\n    if distanceSquared < 0.000001 then\n      dx = 100 - centerX\n      dz = 100 - centerZ\n      distanceSquared = dx * dx + dz * dz\n      if distanceSquared < 0.000001 then\n        dx = 0\n        dz = 1\n        distanceSquared = 1\n      end\n    end\n    local scale = 7 / math.sqrt(distanceSquared)\n    targetX = centerX + dx * scale\n    targetZ = centerZ + dz * scale\n  elseif state.p1LateDimensionAoeID == 25306 and distanceSquared > 25 then\n    local scale = 5 / math.sqrt(distanceSquared)\n    targetX = centerX + dx * scale\n    targetZ = centerZ + dz * scale\n  end\n\n  MuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"fcad34b9-8724-28fb-b20f-d1c43d2f15c1",
									true,
								},
							},
							endIfUsed = true,
							name = "每帧指向最近安全点",
							uuid = "213103b5-be81-8854-bae3-36cf40e812cf",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local state = data.string_dsr\nreturn state ~= nil\n  and type(state.p1LateDimensionCenterX) == \"number\"\n  and type(state.p1LateDimensionCenterZ) == \"number\"\n  and type(state.p1LateDimensionCenterEntityID) == \"number\"\n  and (state.p1LateDimensionAoeID == 25306 or state.p1LateDimensionAoeID == 25307)\n  and type(MuAiGuide) == \"table\"\n  and type(MuAiGuide.FrameDirect) == \"function\"",
							name = "钢铁月环动态中心已就绪",
							uuid = "fcad34b9-8724-28fb-b20f-d1c43d2f15c1",
							version = 3,
						},
					},
				},
				eventType = 12,
				mechanicTime = 104.2,
				name = "[P1] 钢铁月环最近安全点动态指路",
				timeRange = true,
				timelineIndex = 18,
				timerStartOffset = -6,
				uuid = "5ea4c63d-601e-d27e-aff4-32aec74be43a",
				version = 2,
			},
		},
	},
	[21] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"2af32ddc-0a93-a312-a8ae-2fe095e52ed2",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3632,
							targetType = "ContentID",
							uuid = "f527085d-de4b-ce2f-8762-a2b11fa506c4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "2af32ddc-0a93-a312-a8ae-2fe095e52ed2",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 127.4,
				name = "[P1] 自动目标：Thordan P1-1",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 21,
				timerEndOffset = 10,
				timerStartOffset = -20,
				uuid = "1b4219f1-8a57-b376-853f-335af909c982",
				version = 2,
			},
		},
	},
	[24] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"804d4d44-cb55-fd59-a352-1643a30400c8",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3632,
							targetType = "ContentID",
							uuid = "88d86368-d9cf-a080-9dab-0d3f39d9b48f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "804d4d44-cb55-fd59-a352-1643a30400c8",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 200,
				name = "[P1] 自动目标：Thordan P1-2",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 24,
				timerEndOffset = 10,
				uuid = "82f0e001-9f0f-2c2d-b98b-c747e297d9ec",
				version = 2,
			},
		},
	},
	[28] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal ppos = player and player.pos or nil\nif type(party) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(ppos) ~= \"table\" then\n  return\nend\n\nlocal H1ID = tonumber(party.H1 and party.H1.id)\nlocal H2ID = tonumber(party.H2 and party.H2.id)\nlocal D3ID = tonumber(party.D3 and party.D3.id)\nlocal D4ID = tonumber(party.D4 and party.D4.id)\nlocal D1ID = tonumber(party.D1 and party.D1.id)\nlocal D2ID = tonumber(party.D2 and party.D2.id)\nlocal MTID = tonumber(party.MT and party.MT.id)\nlocal STID = tonumber(party.ST and party.ST.id)\nlocal knownRole = playerID == H1ID or playerID == H2ID\n  or playerID == D3ID or playerID == D4ID\n  or playerID == D1ID or playerID == D2ID\n  or playerID == MTID or playerID == STID\nif not knownRole or H1ID == nil or H2ID == nil or H1ID == H2ID then\n  return\nend\n\nlocal px = tonumber(ppos.x)\nlocal pz = tonumber(ppos.z)\nif px == nil or pz == nil then\n  return\nend\n\nlocal targetX = 89\nlocal targetZ = 100\nif playerID == H1ID or playerID == H2ID then\n  local frontDX = px - 90.55\n  local frontDZ = pz - 106.75\n  local backDX = px - 87.45\n  local backDZ = pz - 106.75\n  if frontDX * frontDX + frontDZ * frontDZ\n      <= backDX * backDX + backDZ * backDZ then\n    targetX = 90.55\n    targetZ = 106.75\n  else\n    targetX = 87.45\n    targetZ = 106.75\n  end\n\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							name = "H1H2 阶段动态指路",
							uuid = "f5214cc8-5e1b-3dfe-9d41-5c26ce37adfb",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 215.9,
				name = "[P1] 纯净心灵引导 H1H2",
				timeRange = true,
				timelineIndex = 28,
				timerStartOffset = -15.9,
				uuid = "f38e92db-2845-596b-b37e-b2baca559b4b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal firstID = type(party) == \"table\" and tonumber(party.H1 and party.H1.id) or nil\nlocal secondID = type(party) == \"table\" and tonumber(party.H2 and party.H2.id) or nil\nif firstID == nil or secondID == nil or firstID == secondID then\n  return\nend\n\nlocal charibert = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3642, subgroup = \"Nearest\" })\nlocal charibertID = tonumber(charibert and charibert.id)\nif charibertID == nil then\n  return\nend\nstate.p1PureCharibertID = charibertID\n\nlocal drawer = state.p1PureHealerDrawer\nif drawer == nil then\n  drawer = TensorCore.getStaticDrawer(\n    GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.4))\n  state.p1PureHealerDrawer = drawer\nend\n\ndrawer:addTimedConeOnEnt(\n  15900, charibertID, 18, math.rad(30), firstID, 0, false, false)\ndrawer:addTimedConeOnEnt(\n  15900, charibertID, 18, math.rad(30), secondID, 0, false, false)\nself.used = true",
							name = "绘制 H1H2 绿色跟随扇形",
							uuid = "48239892-f3ec-0b8c-b588-9a9464492b65",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 215.9,
				name = "[P1] 光翼闪扇形 H1H2（绿）",
				timelineIndex = 28,
				timerOffset = -15.89999961853,
				uuid = "2c42b43c-7405-d6aa-a577-eb4d64a13820",
				version = 2,
			},
		},
	},
	[29] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal ppos = player and player.pos or nil\nif type(party) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(ppos) ~= \"table\" then\n  return\nend\n\nlocal H1ID = tonumber(party.H1 and party.H1.id)\nlocal H2ID = tonumber(party.H2 and party.H2.id)\nlocal D3ID = tonumber(party.D3 and party.D3.id)\nlocal D4ID = tonumber(party.D4 and party.D4.id)\nlocal D1ID = tonumber(party.D1 and party.D1.id)\nlocal D2ID = tonumber(party.D2 and party.D2.id)\nlocal MTID = tonumber(party.MT and party.MT.id)\nlocal STID = tonumber(party.ST and party.ST.id)\nlocal knownRole = playerID == H1ID or playerID == H2ID\n  or playerID == D3ID or playerID == D4ID\n  or playerID == D1ID or playerID == D2ID\n  or playerID == MTID or playerID == STID\nif not knownRole or D3ID == nil or D4ID == nil or D3ID == D4ID then\n  return\nend\n\nlocal px = tonumber(ppos.x)\nlocal pz = tonumber(ppos.z)\nif px == nil or pz == nil then\n  return\nend\n\nlocal targetX = 89\nlocal targetZ = 100\nif playerID == D3ID or playerID == D4ID then\n  local frontDX = px - 90.55\n  local frontDZ = pz - 106.75\n  local backDX = px - 87.45\n  local backDZ = pz - 106.75\n  if frontDX * frontDX + frontDZ * frontDZ\n      <= backDX * backDX + backDZ * backDZ then\n    targetX = 90.55\n    targetZ = 106.75\n  else\n    targetX = 87.45\n    targetZ = 106.75\n  end\nelseif playerID == H1ID or playerID == H2ID then\n  targetX = 82\n  targetZ = 100\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							name = "D3D4 阶段动态指路",
							uuid = "a92b5979-793c-a890-87b2-b28af5d4c7a5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 220.9,
				name = "[P1] 纯净心灵引导 D3D4",
				timeRange = true,
				timelineIndex = 29,
				timerStartOffset = -5,
				uuid = "5c985d66-d3d9-630d-99a5-f515e243839d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal firstID = type(party) == \"table\" and tonumber(party.D3 and party.D3.id) or nil\nlocal secondID = type(party) == \"table\" and tonumber(party.D4 and party.D4.id) or nil\nif firstID == nil or secondID == nil or firstID == secondID then\n  return\nend\n\nlocal charibert = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3642, subgroup = \"Nearest\" })\nlocal charibertID = tonumber(charibert and charibert.id)\nif charibertID == nil then\n  return\nend\nstate.p1PureCharibertID = charibertID\n\nlocal drawer = state.p1PureRangedDrawer\nif drawer == nil then\n  drawer = TensorCore.getStaticDrawer(\n    GUI:ColorConvertFloat4ToU32(1, 0.6470588235, 0, 0.4))\n  state.p1PureRangedDrawer = drawer\nend\n\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), firstID, 0, false, false)\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), secondID, 0, false, false)\nself.used = true",
							name = "绘制 D3D4 橙色跟随扇形",
							uuid = "0411fc9f-b28e-e61a-8672-7f0c090ab0c6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 220.9,
				name = "[P1] 光翼闪扇形 D3D4（橙）",
				timelineIndex = 29,
				timerOffset = -5,
				uuid = "31d92e25-fdb3-54da-a59f-2b46f6cc7f4a",
				version = 2,
			},
		},
	},
	[31] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal ppos = player and player.pos or nil\nif type(party) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(ppos) ~= \"table\" then\n  return\nend\n\nlocal H1ID = tonumber(party.H1 and party.H1.id)\nlocal H2ID = tonumber(party.H2 and party.H2.id)\nlocal D3ID = tonumber(party.D3 and party.D3.id)\nlocal D4ID = tonumber(party.D4 and party.D4.id)\nlocal D1ID = tonumber(party.D1 and party.D1.id)\nlocal D2ID = tonumber(party.D2 and party.D2.id)\nlocal MTID = tonumber(party.MT and party.MT.id)\nlocal STID = tonumber(party.ST and party.ST.id)\nlocal knownRole = playerID == H1ID or playerID == H2ID\n  or playerID == D3ID or playerID == D4ID\n  or playerID == D1ID or playerID == D2ID\n  or playerID == MTID or playerID == STID\nif not knownRole or D1ID == nil or D2ID == nil or D1ID == D2ID then\n  return\nend\n\nlocal px = tonumber(ppos.x)\nlocal pz = tonumber(ppos.z)\nif px == nil or pz == nil then\n  return\nend\n\nlocal targetX = 89\nlocal targetZ = 100\nif playerID == D1ID or playerID == D2ID then\n  local frontDX = px - 90.55\n  local frontDZ = pz - 106.75\n  local backDX = px - 87.45\n  local backDZ = pz - 106.75\n  if frontDX * frontDX + frontDZ * frontDZ\n      <= backDX * backDX + backDZ * backDZ then\n    targetX = 90.55\n    targetZ = 106.75\n  else\n    targetX = 87.45\n    targetZ = 106.75\n  end\nelseif playerID == D3ID or playerID == D4ID then\n  targetX = 96\n  targetZ = 101.5\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							name = "D1D2 阶段动态指路",
							uuid = "0cba2db0-80c9-ba6d-a969-1be9fc3d3939",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 225.9,
				name = "[P1] 纯净心灵引导 D1D2",
				timeRange = true,
				timelineIndex = 31,
				timerStartOffset = -5,
				uuid = "8461edc5-15f0-9c96-84a0-b5446abc6f3a",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal firstID = type(party) == \"table\" and tonumber(party.D1 and party.D1.id) or nil\nlocal secondID = type(party) == \"table\" and tonumber(party.D2 and party.D2.id) or nil\nif firstID == nil or secondID == nil or firstID == secondID then\n  return\nend\n\nlocal charibert = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3642, subgroup = \"Nearest\" })\nlocal charibertID = tonumber(charibert and charibert.id)\nif charibertID == nil then\n  return\nend\nstate.p1PureCharibertID = charibertID\n\nlocal drawer = state.p1PureMeleeDrawer\nif drawer == nil then\n  drawer = TensorCore.getStaticDrawer(\n    GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.4))\n  state.p1PureMeleeDrawer = drawer\nend\n\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), firstID, 0, false, false)\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), secondID, 0, false, false)\nself.used = true",
							name = "绘制 D1D2 红色跟随扇形",
							uuid = "e1977767-71d0-8877-b94c-f5917a776eba",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 225.9,
				name = "[P1] 光翼闪扇形 D1D2（红）",
				timelineIndex = 31,
				timerOffset = -5,
				uuid = "be2b40a9-6c52-0cf8-aec5-c32b876b692c",
				version = 2,
			},
		},
	},
	[33] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal ppos = player and player.pos or nil\nif type(party) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(ppos) ~= \"table\" then\n  return\nend\n\nlocal H1ID = tonumber(party.H1 and party.H1.id)\nlocal H2ID = tonumber(party.H2 and party.H2.id)\nlocal D3ID = tonumber(party.D3 and party.D3.id)\nlocal D4ID = tonumber(party.D4 and party.D4.id)\nlocal D1ID = tonumber(party.D1 and party.D1.id)\nlocal D2ID = tonumber(party.D2 and party.D2.id)\nlocal MTID = tonumber(party.MT and party.MT.id)\nlocal STID = tonumber(party.ST and party.ST.id)\nlocal knownRole = playerID == H1ID or playerID == H2ID\n  or playerID == D3ID or playerID == D4ID\n  or playerID == D1ID or playerID == D2ID\n  or playerID == MTID or playerID == STID\nif not knownRole or MTID == nil or STID == nil or MTID == STID then\n  return\nend\n\nlocal px = tonumber(ppos.x)\nlocal pz = tonumber(ppos.z)\nif px == nil or pz == nil then\n  return\nend\n\nlocal targetX = 89\nlocal targetZ = 100\nif playerID == MTID or playerID == STID then\n  local frontDX = px - 90.55\n  local frontDZ = pz - 106.75\n  local backDX = px - 87.45\n  local backDZ = pz - 106.75\n  if frontDX * frontDX + frontDZ * frontDZ\n      <= backDX * backDX + backDZ * backDZ then\n    targetX = 90.55\n    targetZ = 106.75\n  else\n    targetX = 87.45\n    targetZ = 106.75\n  end\nelseif playerID == D1ID or playerID == D2ID then\n  targetX = 82\n  targetZ = 97\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							name = "MTST 阶段动态指路",
							uuid = "891e6cac-bc60-ac54-9aed-ffd6609ab519",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 230.9,
				name = "[P1] 纯净心灵引导 MTST",
				timeRange = true,
				timelineIndex = 33,
				timerStartOffset = -5,
				uuid = "819ee5ff-93e4-4485-a206-7b39a956b05e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal firstID = type(party) == \"table\" and tonumber(party.MT and party.MT.id) or nil\nlocal secondID = type(party) == \"table\" and tonumber(party.ST and party.ST.id) or nil\nif firstID == nil or secondID == nil or firstID == secondID then\n  return\nend\n\nlocal charibert = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3642, subgroup = \"Nearest\" })\nlocal charibertID = tonumber(charibert and charibert.id)\nif charibertID == nil then\n  return\nend\nstate.p1PureCharibertID = charibertID\n\nlocal drawer = state.p1PureTankDrawer\nif drawer == nil then\n  drawer = TensorCore.getStaticDrawer(\n    GUI:ColorConvertFloat4ToU32(0, 0, 1, 0.4))\n  state.p1PureTankDrawer = drawer\nend\n\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), firstID, 0, false, false)\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), secondID, 0, false, false)\nself.used = true",
							name = "绘制 MTST 蓝色跟随扇形",
							uuid = "dd4413c0-396d-f721-a615-81e5f3577f51",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 230.9,
				name = "[P1] 光翼闪扇形 MTST（蓝）",
				timelineIndex = 33,
				timerOffset = -5,
				uuid = "1221acb9-fdee-06e4-8438-25eca921bc06",
				version = 2,
			},
		},
	},
	[35] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"7ac67a90-6045-f67f-b567-b349928dcce6",
									true,
								},
								
								{
									"74f88d46-72b7-0bc7-abcf-a8278412dc8c",
									true,
								},
								
								{
									"e4aa1cc7-8c68-0cb1-a050-5fe6fb8934c8",
									true,
								},
								
								{
									"a0ef2338-bf39-0047-93fa-d8fc5e49fd7a",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "3de52baa-ba21-76cb-9fc2-bc912571f6cf",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "7ac67a90-6045-f67f-b567-b349928dcce6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1934,
							category = "Self",
							uuid = "74f88d46-72b7-0bc7-abcf-a8278412dc8c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1951,
							category = "Self",
							uuid = "e4aa1cc7-8c68-0cb1-a050-5fe6fb8934c8",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1826,
							category = "Self",
							uuid = "a0ef2338-bf39-0047-93fa-d8fc5e49fd7a",
							version = 3,
						},
					},
				},
				mechanicTime = 235.9,
				name = "[P2] 远敏团队减伤",
				timeRange = true,
				timelineIndex = 35,
				timerEndOffset = -7,
				timerStartOffset = -15,
				uuid = "1e9ffe7e-1435-03c9-92bf-a7aaeccfae5c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 157,
							conditions = 
							{
								
								{
									"db77ba6b-bd68-b8a4-8576-3d6e1b572e2c",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "魔罩",
							uuid = "b631bd59-67e3-e338-8f65-fcef691fa2b4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
							},
							name = "魔罩职业",
							uuid = "db77ba6b-bd68-b8a4-8576-3d6e1b572e2c",
							version = 3,
						},
					},
				},
				mechanicTime = 235.9,
				name = "[P2] 魔罩",
				timelineIndex = 35,
				timerOffset = -18,
				uuid = "b3e81b37-0029-ec19-a686-837a7bbc1b0c",
				version = 2,
			},
		},
	},
	[38] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\ndata.string_dsr = data.string_dsr or {}\ndata.string_dsr.eyePos = nil\ndata.string_dsr.cometCount = nil\ndata.string_dsr.cometsArmed = nil\ndata.string_dsr.drawnExaflares = nil\nself.used = true",
							endIfUsed = true,
							name = "Unlock face and reset phase state",
							uuid = "db8e5fd1-fdf5-615e-92e1-efc72dcc2ce4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 291.5,
				name = "[P2] 换相清理",
				timeRange = true,
				timelineIndex = 38,
				timerEndOffset = 0.5,
				timerStartOffset = -0.5,
				uuid = "6863a6e7-c2e6-5860-9620-1b9d752eba44",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"0588cf0e-cb5b-d1b9-97d1-e4d8cde39a2a",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3632,
							targetType = "ContentID",
							uuid = "41ee0fc7-534a-2088-bd8d-a7c55c9c6280",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "0588cf0e-cb5b-d1b9-97d1-e4d8cde39a2a",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 291.5,
				name = "[P2] 自动目标：Thordan P2-1",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 38,
				timerEndOffset = 5,
				uuid = "90eebade-cd92-5d5c-9240-0fb8923afb68",
				version = 2,
			},
		},
	},
	[41] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "b420f833-32f8-c6df-b4ad-2a8d29168e07",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 303.2,
				name = "[P2] 阿斯卡隆之威 第一轮1 范围",
				timelineIndex = 41,
				timerOffset = -1.5,
				uuid = "f7ad2e75-e28b-b5fc-b602-d570ce8974d3",
				version = 2,
			},
		},
	},
	[42] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "9519c7a5-db38-f5ff-a9dc-8f7cc5181774",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 304.8,
				name = "[P2] 阿斯卡隆之威 第一轮2 范围",
				timelineIndex = 42,
				timerOffset = -1.5,
				uuid = "1a54b1bd-04d6-96d1-b06e-71c7a4599ab5",
				version = 2,
			},
		},
	},
	[43] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							conditions = 
							{
								
								{
									"2be4bf85-7361-25be-ac5e-1cedd5dd553b",
									true,
								},
								
								{
									"91635356-bd1e-a98e-a4a3-015a4b0bbc83",
									true,
								},
							},
							endIfUsed = true,
							name = "牵制",
							targetType = "Current Target",
							uuid = "468f2371-6367-dc2b-876e-c2f968c25438",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Feint check",
							uuid = "91635356-bd1e-a98e-a4a3-015a4b0bbc83",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
								22,
								30,
								34,
								39,
								41,
							},
							name = "牵制职业",
							uuid = "2be4bf85-7361-25be-ac5e-1cedd5dd553b",
							version = 3,
						},
					},
				},
				mechanicTime = 306.4,
				name = "[P2] 牵制",
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 43,
				timerEndOffset = -3,
				timerStartOffset = -7,
				uuid = "9df4dffa-c322-9e70-9bee-bc4b655e783e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7560,
							conditions = 
							{
								
								{
									"a115f10d-bb1d-39f3-b444-6551b65ea8e6",
									true,
								},
								
								{
									"df2654d2-dbda-7ca8-b0c9-fbea505feba6",
									true,
								},
							},
							endIfUsed = true,
							name = "昏乱",
							targetType = "Current Target",
							uuid = "3f8ae507-0836-74b2-b87e-886513a96aec",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1203,
							name = "Addle check",
							uuid = "df2654d2-dbda-7ca8-b0c9-fbea505feba6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
								27,
								35,
								42,
							},
							name = "昏乱职业",
							uuid = "a115f10d-bb1d-39f3-b444-6551b65ea8e6",
							version = 3,
						},
					},
				},
				mechanicTime = 306.4,
				name = "[P2] 昏乱",
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 43,
				timerEndOffset = -3,
				timerStartOffset = -7,
				uuid = "5e15ced0-edc3-badb-a0f1-ee2f74b17b16",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2887,
							conditions = 
							{
								
								{
									"24c7e9f9-488e-d4ad-8e10-7a835e2fceed",
									true,
								},
								
								{
									"6609df35-b1a8-dcc0-a823-fa59948c821e",
									true,
								},
							},
							endIfUsed = true,
							name = "武装解除",
							targetType = "Current Target",
							uuid = "d8b771a4-c032-ad56-bff2-c7f5e1ec46b9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 860,
							name = "Dismantle check",
							uuid = "6609df35-b1a8-dcc0-a823-fa59948c821e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								31,
							},
							name = "武装解除职业",
							uuid = "24c7e9f9-488e-d4ad-8e10-7a835e2fceed",
							version = 3,
						},
					},
				},
				mechanicTime = 306.4,
				name = "[P2] 武装解除",
				randomTimeout = 8,
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 43,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "32fd07fd-4b71-a0ae-b1ac-33a4cf97f4fd",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "1c11b8e4-fe08-9909-983a-414ed61602b4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 306.4,
				name = "[P2] 阿斯卡隆之威 第一轮3 范围",
				timelineIndex = 43,
				timerOffset = -1.5,
				uuid = "2a99ee67-55c2-788b-b3a2-5d8a2beec017",
				version = 2,
			},
		},
	},
	[45] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local drawer = TensorCore.getMoogleDrawer()\nlocal id = eventArgs.entityID\nif id then\n  drawer:addTimedDonutOnEnt(2900, id, 6, 12, 4987)\n  drawer:addTimedDonutOnEnt(2900, id, 12, 18, 6862)\n  drawer:addTimedDonutOnEnt(2900, id, 18, 24, 8784)\n  drawer:addTimedDonutOnEnt(2900, id, 24, 30, 10685)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"4a87c27c-52d5-883f-ab7f-49a0bcf3bcc2",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw four impact rings",
							uuid = "6820ba3d-063a-4bf0-88a6-717ad1b56299",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25558,
							name = "Heavy Impact",
							uuid = "4a87c27c-52d5-883f-ab7f-49a0bcf3bcc2",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 317.5,
				name = "[P2] 圣杖重击四段环",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 14,
				timerStartOffset = -1,
				uuid = "38d981c6-15b2-a798-b60b-5a58ccbaacbc",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nif player and eventArgs.channelTimeMax and eventArgs.channelTimeMax > 0 then\n  TensorCore.getMoogleDrawer():addTimedCircleOnEnt(eventArgs.channelTimeMax * 1000, player.id, 5, 1000)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"ebfa569b-b51e-2c64-8e6b-89e19ee40e89",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw personal spread",
							uuid = "ed4555c2-6413-e9cf-9b20-cc32f020c496",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25548,
							name = "Heavensflame",
							uuid = "ebfa569b-b51e-2c64-8e6b-89e19ee40e89",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 317.5,
				name = "[P2] 苍穹之炎个人范围",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 12,
				timerStartOffset = -1,
				uuid = "514652ed-1311-5896-b6e0-66ba831dfbdb",
				version = 2,
			},
		},
	},
	[48] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal root = data.string_dsr\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nif guide and type(guide.LoadParty) == \"function\" then\n  local partyCount = type(guide.GetPartyCnt) == \"function\" and guide.GetPartyCnt() or 0\n  if type(guide.Party) ~= \"table\" or partyCount < 8 then\n    guide.LoadParty()\n  end\nend\nroot.p2Op1 = { ready = false, targets = {} }\nlocal state = root.p2Op1\n\nlocal function firstByContentID(contentID)\n  local entities = TensorCore.entityList(\"contentid=\" .. contentID)\n  if type(entities) == \"table\" then\n    for _, entity in pairs(entities) do\n      return entity\n    end\n  end\n  return nil\nend\n\nlocal first = firstByContentID(3638)\nlocal second = firstByContentID(3637)\nlocal third = firstByContentID(3636)\nlocal adds = { first, second, third }\nfor i = 1, 3 do\n  if not adds[i] or not adds[i].id or type(adds[i].pos) ~= \"table\" then\n    self.used = true\n    return\n  end\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nfor i = 1, 3 do\n  drawer:addTimedRectOnEnt(8000, adds[i].id, 52, 16)\nend\n\nlocal centerX, centerZ = 100, 100\nlocal mtCandidates = {\n  { x = 90.6661904883, z = 90.6661904883 },\n  { x = 86.8, z = 100.0 },\n  { x = 90.6661904883, z = 109.3338095117 },\n  { x = 100.0, z = 113.2 },\n}\nlocal stCandidates = {\n  { x = 100.0, z = 86.8 },\n  { x = 109.3338095117, z = 90.6661904883 },\n  { x = 113.2, z = 100.0 },\n  { x = 109.3338095117, z = 109.3338095117 },\n}\n\nlocal function clearance(point)\n  local nearest = math.huge\n  for i = 1, 3 do\n    local pos = adds[i].pos\n    local lx = tonumber(pos.x) - centerX\n    local lz = tonumber(pos.z) - centerZ\n    local length = math.sqrt(lx * lx + lz * lz)\n    if length <= 0.001 then\n      return 0\n    end\n    lx, lz = lx / length, lz / length\n    local px = point.x - centerX\n    local pz = point.z - centerZ\n    local distance = math.abs(px * lz - pz * lx)\n    if distance < nearest then\n      nearest = distance\n    end\n  end\n  return nearest\nend\n\nlocal function safest(candidates)\n  local best, bestClearance = nil, -1\n  for i = 1, #candidates do\n    local value = clearance(candidates[i])\n    if value > bestClearance then\n      best = candidates[i]\n      bestClearance = value\n    end\n  end\n  if bestClearance <= 8.05 then\n    return nil\n  end\n  return best\nend\n\nlocal mtSafe = safest(mtCandidates)\nlocal stSafe = safest(stCandidates)\nif not mtSafe or not stSafe then\n  self.used = true\n  return\nend\n\nlocal function addGroup(marker, tankRole, healerRole, leftRole, rightRole)\n  local dx = marker.x - centerX\n  local dz = marker.z - centerZ\n  local length = math.sqrt(dx * dx + dz * dz)\n  if length <= 0.001 then\n    return false\n  end\n  local ux, uz = dx / length, dz / length\n  local leftX, leftZ = -uz, ux\n\n  local tankX = centerX + ux * 20.0\n  local tankZ = centerZ + uz * 20.0\n  local dpsRadial = 19.7129399127\n  local dpsX = centerX + ux * dpsRadial\n  local dpsZ = centerZ + uz * dpsRadial\n  state.targets[tankRole] = { x = tankX, z = tankZ }\n  state.targets[healerRole] = { x = marker.x, z = marker.z }\n  state.targets[leftRole] = { x = dpsX + leftX * 6.2, z = dpsZ + leftZ * 6.2 }\n  state.targets[rightRole] = { x = dpsX - leftX * 6.2, z = dpsZ - leftZ * 6.2 }\n  return true\nend\n\nstate.ready = addGroup(mtSafe, \"MT\", \"H1\", \"D1\", \"D3\")\n  and addGroup(stSafe, \"ST\", \"H2\", \"D2\", \"D4\")\nself.used = true",
							endIfUsed = true,
							name = "预绘螺旋刺并计算固定世界坐标安全点",
							uuid = "f1762308-0b5a-8962-8ba9-f8f38dfe1f2c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 330.2,
				name = "[P2] 一运螺旋刺预绘与安全点",
				timelineIndex = 48,
				timerEndOffset = 2.2,
				timerOffset = -8,
				timerStartOffset = 1.5,
				uuid = "b98ed01e-b1da-708e-b6e1-bac447cd6762",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\" and data.string_dsr.p2Op1 or nil\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif not state or state.ready ~= true or type(state.targets) ~= \"table\"\n    or type(party) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal role = nil\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor i = 1, #roles do\n  local candidate = roles[i]\n  if tonumber(party[candidate] and party[candidate].id) == playerID then\n    role = candidate\n    break\n  end\nend\n\nlocal target = role and state.targets[role] or nil\nif target and type(target.x) == \"number\" and type(target.z) == \"number\" then\n  MuAiGuide.FrameDirect(target.x, target.z, 0.5)\nend\nself.used = true",
							name = "按 MuAi 职能动态指向固定世界坐标",
							uuid = "874c7139-0d1c-4483-bc7f-cbf9ce21e155",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 330.2,
				name = "[P2] 一运分组散开动态指路",
				timeRange = true,
				timelineIndex = 48,
				timerStartOffset = -8,
				uuid = "c444a982-387c-76c7-9dd0-69b45a87c416",
				version = 2,
			},
		},
	},
	[49] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"e842affb-5146-9647-b367-825669380630",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "心眼",
							uuid = "5c4eff81-173f-9c0d-a095-33122e622539",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"02d78092-4973-75b8-8715-b527501060a4",
									true,
								},
								
								{
									"4d90cf6d-b787-e80f-8bbf-d46f238eb345",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "金刚极意",
							uuid = "bdf7107c-af33-8527-81b2-59e7cfcf454d",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"8b760126-3863-4aac-b531-cf2513236b6b",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "神秘纹",
							uuid = "a5c9eaeb-5008-e590-8ba5-ec5dbc328055",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "4d90cf6d-b787-e80f-8bbf-d46f238eb345",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "e842affb-5146-9647-b367-825669380630",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "02d78092-4973-75b8-8715-b527501060a4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "8b760126-3863-4aac-b531-cf2513236b6b",
							version = 3,
						},
					},
				},
				mechanicTime = 330.4,
				name = "[P2] 近战个人减伤",
				timelineIndex = 49,
				timerOffset = -3,
				uuid = "292ee346-7fdb-577f-8849-34a35ee004fb",
				version = 2,
			},
		},
	},
	[50] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\" and data.string_dsr.p2Op15 or nil\nlocal entityID = tonumber(eventArgs.entityID)\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(state) ~= \"table\" or type(state.blueSeen) ~= \"table\"\n    or not state.blueRangeDrawer or not entityID or not playerID then\n  self.used = true\n  return\nend\n\nif state.blueSeen[entityID] then\n  self.used = true\n  return\nend\nstate.blueSeen[entityID] = true\nstate.blueCount = (tonumber(state.blueCount) or 0) + 1\nstate.blueIDs[state.blueCount] = entityID\n\nif entityID == playerID then\n  state.isBlue = true\nelse\n  state.blueRangeDrawer:addTimedCircleOnEnt(\n    9300, entityID, 24, 0, false, true\n  )\nend\nself.used = true",
							conditions = 
							{
								
								{
									"0c609a7c-a37e-c676-9bee-82024d93082c",
									true,
								},
							},
							endIfUsed = true,
							name = "逐标记记录并立即绘制蓝圈范围",
							uuid = "53216026-e5f7-308d-8669-634c4553fcd4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 330,
							name = "Marker 330",
							uuid = "0c609a7c-a37e-c676-9bee-82024d93082c",
							version = 3,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 335.3,
				name = "[P2] 1.5运蓝圈标记处理",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 11,
				timerStartOffset = -1,
				uuid = "e38609b3-2700-82a3-8746-93ea21a679dc",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal knight = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3640, subgroup = \"Nearest\" })\nif player and knight then\n  local drawer = TensorCore.getStaticDrawer(520093951)\n  drawer:addTimedArrowOnEnt(9000, player.id, 20, 1, 2, 3, knight.id)\n  drawer:addTimedCircleOnEnt(9000, knight.id, 2)\nend\nself.used = true",
							endIfUsed = true,
							name = "Draw alignment to knight",
							uuid = "6cd02b05-a23e-eae6-922e-e0d7e8ba2eb6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 335.3,
				name = "[P2] 战狂骑士对齐线",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 0.8,
				uuid = "50771676-d6d4-52d5-99da-528f20f23335",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"2603e111-81c0-42e2-90f9-05cc030fe2d5",
									true,
								},
								
								{
									"ca1e956a-addc-504b-a1ff-15a3547b866e",
									true,
								},
								
								{
									"f3e9efc3-6994-21bc-83a1-e5285a841922",
									true,
								},
								
								{
									"0f9cfd25-9eb7-5fa0-a2ab-408ffed520df",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "9d58b91d-8ae9-c87c-9a08-00c757eeb33e",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "2603e111-81c0-42e2-90f9-05cc030fe2d5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1934,
							category = "Self",
							uuid = "ca1e956a-addc-504b-a1ff-15a3547b866e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1951,
							category = "Self",
							uuid = "f3e9efc3-6994-21bc-83a1-e5285a841922",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1826,
							category = "Self",
							uuid = "0f9cfd25-9eb7-5fa0-a2ab-408ffed520df",
							version = 3,
						},
					},
				},
				enabled = false,
				mechanicTime = 335.3,
				name = "[P2] 远敏团队减伤",
				timelineIndex = 50,
				timerOffset = 1,
				uuid = "2b2bbfb2-dd92-7f3b-af45-fda18124f066",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal state = {\n  blueIDs = {},\n  blueSeen = {},\n  blueCount = 0,\n  isBlue = false,\n  blueRangeDrawer = TensorCore.getCachedDrawer(\n    1207942497, 1207942497, 1207942497, 4205190917, 3\n  ),\n  redArrowColor = 2349665791,\n  greenArrowColor = 2350907156,\n  arrowOutlineColor = 4294967295\n}\n\ndata.string_dsr.p2Op15 = state\nself.used = true",
							name = "初始化1.5运状态与绘图参数",
							uuid = "19068115-1baf-0b1c-ad28-8ec48fed67c4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 335.3,
				name = "[P2] 1.5运状态初始化",
				timelineIndex = 50,
				uuid = "10d29bd2-fbd3-8a53-bf79-76fa243641ba",
				version = 2,
			},
		},
	},
	[51] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- 25564末态半径9；需要八个圆心就绪。\nlocal aoes = Argus.getCurrentAOEs()\nlocal count = 0\nfor i = 1, #aoes do\n  if aoes[i].aoeID == 25564 then\n    count = count + 1\n  end\nend\nif count < 8 then\n  self.used = true\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nfor i = 1, #aoes do\n  local aoe = aoes[i]\n  if aoe.aoeID == 25564 then\n    drawer:addTimedCircle(7900, aoe.x, aoe.y, aoe.z, 9, 0, false, true)\n  end\nend\nself.used = true",
							name = "一次性绘制八个末态红圈",
							uuid = "c93c0762-6187-cfb6-a95c-1ea9304ec348",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 345.4,
				name = "[P2] 1.5运空间破碎末态",
				timelineIndex = 51,
				timerOffset = -7.9,
				uuid = "8fc931d9-757c-df2c-b30f-32feb74d00f2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\" and data.string_dsr.p2Op15 or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal thordanID = tonumber(state and state.thordanID)\nlocal pos = player and player.pos\nif type(state) ~= \"table\" or state.ready ~= true or not playerID or not thordanID\n    or not state.redArrowColor or not state.greenArrowColor or not state.arrowOutlineColor\n    or type(pos) ~= \"table\" or type(pos.x) ~= \"number\" or type(pos.z) ~= \"number\" then\n  return\nend\n\nlocal fillColor = state.isBlue == true and state.redArrowColor or state.greenArrowColor\nArgus2.addTimedArrowFilled(\n  7000,\n  pos.x, pos.y or 0, pos.z,\n  5, 1, 2, 3, 0,\n  fillColor, fillColor, nil,\n  0, playerID, thordanID,\n  state.arrowOutlineColor, 2,\n  0, 1, 0,\n  false, 0, false,\n  0, 0, 0, 0, 0.05\n)\nself.used = true",
							name = "半透明描边 OnEnt 箭头指向托尔丹",
							uuid = "3202f216-ed61-c996-a8ad-1263b809a930",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 345.4,
				name = "[P2] 1.5运人群托尔丹箭头",
				timelineIndex = 51,
				timerOffset = -7,
				timerStartOffset = -7,
				uuid = "7e42afa7-f948-31f7-a689-cdbae894d202",
				version = 2,
			},
		},
	},
	[52] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\" and data.string_dsr.p2Op15 or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(state) ~= \"table\" or state.ready ~= true or not playerID\n    or type(player.pos) ~= \"table\"\n    or type(MuAiGuide) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\"\n    or type(Argus) ~= \"table\"\n    or type(Argus.getCurrentAOEs) ~= \"function\" then\n  return\nend\n\nif not state.role then\n  local party = MuAiGuide.Party\n  if type(party) ~= \"table\" then\n    return\n  end\n  if tonumber(party.MT and party.MT.id) == playerID then state.role = \"MT\"\n  elseif tonumber(party.ST and party.ST.id) == playerID then state.role = \"ST\"\n  elseif tonumber(party.H1 and party.H1.id) == playerID then state.role = \"H1\"\n  elseif tonumber(party.H2 and party.H2.id) == playerID then state.role = \"H2\"\n  elseif tonumber(party.D1 and party.D1.id) == playerID then state.role = \"D1\"\n  elseif tonumber(party.D2 and party.D2.id) == playerID then state.role = \"D2\"\n  elseif tonumber(party.D3 and party.D3.id) == playerID then state.role = \"D3\"\n  elseif tonumber(party.D4 and party.D4.id) == playerID then state.role = \"D4\"\n  end\nend\nif not state.role then\n  return\nend\n\nif state.role == \"MT\" or state.role == \"ST\" then\n  self.used = true\n  return\nend\n\nlocal thordan = TensorCore.mGetEntity(tonumber(state.thordanID))\nlocal thordanPos = thordan and thordan.pos or nil\nif type(thordanPos) ~= \"table\"\n    or type(thordanPos.x) ~= \"number\"\n    or type(thordanPos.z) ~= \"number\"\n    or type(state.rx) ~= \"number\"\n    or type(state.rz) ~= \"number\" then\n  return\nend\n\nlocal crowdSlot = nil\nif state.isBlue ~= true then\n  if state.crowdSlotsReady ~= true then\n    local party = MuAiGuide.Party\n    if type(party) ~= \"table\" then\n      return\n    end\n\n    if type(state.crowdRoleIDs) ~= \"table\" then\n      state.crowdRoleIDs = {}\n    end\n    local ids = state.crowdRoleIDs\n    ids[1] = tonumber(party.H1 and party.H1.id)\n    ids[2] = tonumber(party.H2 and party.H2.id)\n    ids[3] = tonumber(party.D1 and party.D1.id)\n    ids[4] = tonumber(party.D2 and party.D2.id)\n    ids[5] = tonumber(party.D3 and party.D3.id)\n    ids[6] = tonumber(party.D4 and party.D4.id)\n\n    if type(state.crowdCandidates) ~= \"table\" then\n      state.crowdCandidates = {{}, {}, {}, {}, {}, {}}\n    end\n    local candidates = state.crowdCandidates\n\n    for i = 1, 6 do\n      local id = ids[i]\n      if not id then\n        return\n      end\n      for j = 1, i - 1 do\n        if ids[j] == id then\n          return\n        end\n      end\n\n      local entity = TensorCore.mGetEntity(id)\n      local pos = entity and entity.pos or nil\n      if type(pos) ~= \"table\"\n          or type(pos.x) ~= \"number\"\n          or type(pos.z) ~= \"number\" then\n        return\n      end\n\n      local dx = pos.x - thordanPos.x\n      local dz = pos.z - thordanPos.z\n      local candidate = candidates[i]\n      candidate.id = id\n      candidate.d2 = dx * dx + dz * dz\n      candidate.lateral = dx * state.rx + dz * state.rz\n    end\n\n    for i = 1, 4 do\n      local best = i\n      for j = i + 1, 6 do\n        if candidates[j].d2 < candidates[best].d2 then\n          best = j\n        end\n      end\n      if best ~= i then\n        candidates[i], candidates[best] = candidates[best], candidates[i]\n      end\n    end\n\n    if candidates[3].d2 > 100 or candidates[4].d2 < 144 then\n      return\n    end\n\n    if candidates[1].lateral > candidates[2].lateral then\n      candidates[1], candidates[2] = candidates[2], candidates[1]\n    end\n    if candidates[2].lateral > candidates[3].lateral then\n      candidates[2], candidates[3] = candidates[3], candidates[2]\n    end\n    if candidates[1].lateral > candidates[2].lateral then\n      candidates[1], candidates[2] = candidates[2], candidates[1]\n    end\n\n    if candidates[2].lateral - candidates[1].lateral < 0.25\n        or candidates[3].lateral - candidates[2].lateral < 0.25 then\n      return\n    end\n\n    state.crowdLeftID = candidates[1].id\n    state.crowdMiddleID = candidates[2].id\n    state.crowdRightID = candidates[3].id\n    state.crowdSlotsReady = true\n    return\n  end\n\n  if state.crowdLeftID == playerID then\n    crowdSlot = 1\n  elseif state.crowdMiddleID == playerID then\n    crowdSlot = 2\n  elseif state.crowdRightID == playerID then\n    crowdSlot = 3\n  else\n    return\n  end\nend\n\nif not state.towerTargetX then\n  if type(state.towerCandidates) ~= \"table\" then\n    state.towerCandidates = {{}, {}, {}, {}, {}, {}}\n  end\n  local towers = state.towerCandidates\n  local towerCount = 0\n  local aoes = Argus.getCurrentAOEs()\n  if type(aoes) ~= \"table\" then\n    return\n  end\n\n  for i = 1, #aoes do\n    local aoe = aoes[i]\n    if aoe.aoeID == 25567\n        and type(aoe.x) == \"number\"\n        and type(aoe.z) == \"number\"\n        and tonumber(aoe.entityID) then\n      local entityID = tonumber(aoe.entityID)\n      local duplicate = false\n      for j = 1, towerCount do\n        if towers[j].id == entityID then\n          duplicate = true\n          break\n        end\n      end\n      if not duplicate then\n        towerCount = towerCount + 1\n        if towerCount > 6 then\n          return\n        end\n        local tower = towers[towerCount]\n        tower.id = entityID\n        tower.x = aoe.x\n        tower.z = aoe.z\n      end\n    end\n  end\n  if towerCount ~= 6 then\n    return\n  end\n\n  if state.isBlue == true then\n    local best, bestD2 = nil, nil\n    for i = 1, 6 do\n      local tower = towers[i]\n      local dx = player.pos.x - tower.x\n      local dz = player.pos.z - tower.z\n      local d2 = dx * dx + dz * dz\n      if bestD2 == nil or d2 < bestD2 then\n        best = tower\n        bestD2 = d2\n      end\n    end\n    state.towerTargetX = best.x\n    state.towerTargetZ = best.z\n  else\n    for i = 1, 6 do\n      local tower = towers[i]\n      local dx = tower.x - thordanPos.x\n      local dz = tower.z - thordanPos.z\n      tower.d2 = dx * dx + dz * dz\n      tower.lateral = dx * state.rx + dz * state.rz\n    end\n\n    for i = 1, 4 do\n      local best = i\n      for j = i + 1, 6 do\n        if towers[j].d2 < towers[best].d2 then\n          best = j\n        end\n      end\n      if best ~= i then\n        towers[i], towers[best] = towers[best], towers[i]\n      end\n    end\n\n    if towers[4].d2 <= towers[3].d2 then\n      return\n    end\n\n    if towers[1].lateral > towers[2].lateral then\n      towers[1], towers[2] = towers[2], towers[1]\n    end\n    if towers[2].lateral > towers[3].lateral then\n      towers[2], towers[3] = towers[3], towers[2]\n    end\n    if towers[1].lateral > towers[2].lateral then\n      towers[1], towers[2] = towers[2], towers[1]\n    end\n\n    if towers[2].lateral - towers[1].lateral < 0.25\n        or towers[3].lateral - towers[2].lateral < 0.25 then\n      return\n    end\n\n    state.towerTargetX = towers[crowdSlot].x\n    state.towerTargetZ = towers[crowdSlot].z\n  end\nend\n\nif MuAiGuide.FrameDirect(\n    state.towerTargetX, state.towerTargetZ, 0.5\n) then\n  self.used = true\nend",
							name = "MuAi 指向本人分配塔",
							uuid = "8dafbbfd-be39-dbe1-8ab0-f9a93ec72d4f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 345.4,
				name = "[P2] 1.5运蓝圈与人群三塔动态指路",
				timeRange = true,
				timelineIndex = 52,
				timerEndOffset = 4.8,
				uuid = "6c0a6a01-0a63-5294-b9ca-60d30cbc6e96",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\" and data.string_dsr.p2Op15 or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(state) ~= \"table\" or state.ready ~= true or not playerID\n    or type(MuAiGuide) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\n\nif not state.role then\n  local party = MuAiGuide.Party\n  if type(party) ~= \"table\" then\n    return\n  end\n  if tonumber(party.MT and party.MT.id) == playerID then state.role = \"MT\"\n  elseif tonumber(party.ST and party.ST.id) == playerID then state.role = \"ST\"\n  elseif tonumber(party.H1 and party.H1.id) == playerID then state.role = \"H1\"\n  elseif tonumber(party.H2 and party.H2.id) == playerID then state.role = \"H2\"\n  elseif tonumber(party.D1 and party.D1.id) == playerID then state.role = \"D1\"\n  elseif tonumber(party.D2 and party.D2.id) == playerID then state.role = \"D2\"\n  elseif tonumber(party.D3 and party.D3.id) == playerID then state.role = \"D3\"\n  elseif tonumber(party.D4 and party.D4.id) == playerID then state.role = \"D4\"\n  end\nend\nif not state.role then\n  return\nend\n\nif state.isBlue == nil then\n  state.isBlue = false\n  for i = 1, tonumber(state.blueCount) or 0 do\n    if state.blueIDs[i] == playerID then\n      state.isBlue = true\n      break\n    end\n  end\nend\n\nif state.role == \"MT\" or state.role == \"ST\" then\n  self.used = true\n  return\nend\n\nlocal targetX = nil\nlocal targetZ = nil\nif state.isBlue == true then\n  local pos = player.pos\n  if type(pos) ~= \"table\"\n      or type(pos.x) ~= \"number\"\n      or type(pos.z) ~= \"number\"\n      or type(state.blueLeftX) ~= \"number\"\n      or type(state.blueLeftZ) ~= \"number\"\n      or type(state.blueRightX) ~= \"number\"\n      or type(state.blueRightZ) ~= \"number\"\n      or type(state.blueBackX) ~= \"number\"\n      or type(state.blueBackZ) ~= \"number\" then\n    return\n  end\n\n  if not state.blueTargetX then\n    local leftD2 =\n      (pos.x - state.blueLeftX) ^ 2 + (pos.z - state.blueLeftZ) ^ 2\n    local rightD2 =\n      (pos.x - state.blueRightX) ^ 2 + (pos.z - state.blueRightZ) ^ 2\n    local backD2 =\n      (pos.x - state.blueBackX) ^ 2 + (pos.z - state.blueBackZ) ^ 2\n\n    state.blueTargetX = state.blueLeftX\n    state.blueTargetZ = state.blueLeftZ\n    local bestD2 = leftD2\n    if rightD2 < bestD2 then\n      bestD2 = rightD2\n      state.blueTargetX = state.blueRightX\n      state.blueTargetZ = state.blueRightZ\n    end\n    if backD2 < bestD2 then\n      state.blueTargetX = state.blueBackX\n      state.blueTargetZ = state.blueBackZ\n    end\n  end\n\n  targetX = state.blueTargetX\n  targetZ = state.blueTargetZ\nelse\n  if type(state.groupX) ~= \"number\"\n      or type(state.groupZ) ~= \"number\" then\n    return\n  end\n  targetX = state.groupX\n  targetZ = state.groupZ\nend\n\nif MuAiGuide.FrameDirect(targetX, targetZ, 0.5) then\n  self.used = true\nend",
							name = "MuAi 指向蓝圈安全点或人群分摊点",
							uuid = "b4dd1a85-cd42-0474-b97d-8d3305a21b72",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 345.4,
				name = "[P2] 1.5运蓝圈安全点与人群分摊动态指路",
				timeRange = true,
				timelineIndex = 52,
				timerEndOffset = -0.01,
				timerStartOffset = -6.9,
				uuid = "37f682d5-e088-ed9d-9c69-e6108a520d14",
				version = 2,
			},
		},
	},
	[53] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\" and data.string_dsr.p2Op15 or nil\nif type(state) ~= \"table\" then\n  self.used = true\n  return\nend\n\nlocal thordans = TensorCore.entityList(\"contentid=3632\")\nlocal outer = nil\nlocal bestD2 = 0\nfor _, entity in pairs(thordans) do\n  if entity.pos then\n    local dx = entity.pos.x - 100\n    local dz = entity.pos.z - 100\n    local d2 = dx * dx + dz * dz\n    if d2 > bestD2 then\n      bestD2 = d2\n      outer = entity\n    end\n  end\nend\nif not outer or bestD2 < 225 then\n  self.used = true\n  return\nend\n\nlocal distance = math.sqrt(bestD2)\nlocal fx = (outer.pos.x - 100) / distance\nlocal fz = (outer.pos.z - 100) / distance\nlocal rx = fz\nlocal rz = -fx\n\nstate.thordanID = tonumber(outer.id)\nstate.fx = fx\nstate.fz = fz\nstate.rx = rx\nstate.rz = rz\nstate.groupX = 100 + fx * 20\nstate.groupZ = 100 + fz * 20\nstate.blueLeftX = 100 - rx * 20 - fx * 1.5\nstate.blueLeftZ = 100 - rz * 20 - fz * 1.5\nstate.blueRightX = 100 + rx * 20 - fx * 1.5\nstate.blueRightZ = 100 + rz * 20 - fz * 1.5\nstate.blueBackX = 100 - fx * 20\nstate.blueBackZ = 100 - fz * 20\nstate.mtLineX = 100 + rx * 8 - fx * 4.5\nstate.mtLineZ = 100 + rz * 8 - fz * 4.5\nstate.stLineX = 100 - rx * 8 - fx * 4.5\nstate.stLineZ = 100 - rz * 8 - fz * 4.5\nstate.mtFinalX = 100 - rx * 5.5 + fx * 19\nstate.mtFinalZ = 100 - rz * 5.5 + fz * 19\nstate.stFinalX = 100 + rx * 5.5 + fx * 19\nstate.stFinalZ = 100 + rz * 5.5 + fz * 19\nstate.ready = true\nself.used = true",
							name = "计算世界方位与托尔丹实体",
							uuid = "649e2ac9-bf5a-8b37-a4d8-a212eccec6be",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 346.5,
				name = "[P2] 1.5运方位与蓝圈范围",
				timelineIndex = 53,
				timerOffset = -8,
				uuid = "0bcc8cc5-3939-2112-a091-084fe00770fe",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\" and data.string_dsr.p2Op15 or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(state) ~= \"table\" or state.ready ~= true or not playerID\n    or type(MuAiGuide) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\n\nif not state.role then\n  local party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\n  if type(party) ~= \"table\" then\n    return\n  end\n  if tonumber(party.MT and party.MT.id) == playerID then state.role = \"MT\"\n  elseif tonumber(party.ST and party.ST.id) == playerID then state.role = \"ST\"\n  elseif tonumber(party.H1 and party.H1.id) == playerID then state.role = \"H1\"\n  elseif tonumber(party.H2 and party.H2.id) == playerID then state.role = \"H2\"\n  elseif tonumber(party.D1 and party.D1.id) == playerID then state.role = \"D1\"\n  elseif tonumber(party.D2 and party.D2.id) == playerID then state.role = \"D2\"\n  elseif tonumber(party.D3 and party.D3.id) == playerID then state.role = \"D3\"\n  elseif tonumber(party.D4 and party.D4.id) == playerID then state.role = \"D4\"\n  end\nend\nif not state.role then\n  return\nend\n\nif state.role == \"MT\" then\n  if MuAiGuide.FrameDirect(\n      state.mtLineX, state.mtLineZ, 0.5\n  ) then self.used = true end\nelseif state.role == \"ST\" then\n  if MuAiGuide.FrameDirect(\n      state.stLineX, state.stLineZ, 0.5\n  ) then self.used = true end\nelse\n  self.used = true\nend",
							name = "MuAi 指引 MT右 ST左接线",
							uuid = "7c67d361-71f3-74bb-a46a-182fae827747",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 346.5,
				name = "[P2] 1.5运T接线动态指路",
				timeRange = true,
				timelineIndex = 53,
				timerEndOffset = -3.6,
				timerStartOffset = -8,
				uuid = "8425d0d5-ea89-7316-b86b-34de0b298a74",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\" and data.string_dsr.p2Op15 or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(state) ~= \"table\" or state.ready ~= true or not playerID\n    or type(MuAiGuide) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\n\nif not state.role then\n  local party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\n  if type(party) ~= \"table\" then\n    return\n  end\n  if tonumber(party.MT and party.MT.id) == playerID then state.role = \"MT\"\n  elseif tonumber(party.ST and party.ST.id) == playerID then state.role = \"ST\"\n  elseif tonumber(party.H1 and party.H1.id) == playerID then state.role = \"H1\"\n  elseif tonumber(party.H2 and party.H2.id) == playerID then state.role = \"H2\"\n  elseif tonumber(party.D1 and party.D1.id) == playerID then state.role = \"D1\"\n  elseif tonumber(party.D2 and party.D2.id) == playerID then state.role = \"D2\"\n  elseif tonumber(party.D3 and party.D3.id) == playerID then state.role = \"D3\"\n  elseif tonumber(party.D4 and party.D4.id) == playerID then state.role = \"D4\"\n  end\nend\nif not state.role then\n  return\nend\n\nif state.role == \"MT\" then\n  if MuAiGuide.FrameDirect(\n      state.mtFinalX, state.mtFinalZ, 0.5\n  ) then self.used = true end\nelseif state.role == \"ST\" then\n  if MuAiGuide.FrameDirect(\n      state.stFinalX, state.stFinalZ, 0.5\n  ) then self.used = true end\nelse\n  self.used = true\nend",
							name = "MuAi 指引 T交叉后站位",
							uuid = "ae69899d-af5e-71fc-85fa-c66943e1d244",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 346.5,
				name = "[P2] 1.5运T交叉动态指路",
				timeRange = true,
				timelineIndex = 53,
				timerStartOffset = -3.6,
				uuid = "f77afcc0-2997-4224-9af3-ac69260cf24d",
				version = 2,
			},
		},
	},
	[56] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"c447f36b-384f-d024-82ad-4a39d5d212e3",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "心眼",
							uuid = "2d7f50f2-eede-38ce-8f12-81870b5c0f3c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "9ee2d6c1-7c3c-2fd0-a35f-f931e2fcb7ed",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "c447f36b-384f-d024-82ad-4a39d5d212e3",
							version = 3,
						},
					},
				},
				mechanicTime = 350.2,
				name = "[P2] 近战个人减伤",
				timelineIndex = 56,
				timerOffset = -3,
				uuid = "2dd99f96-cf9d-9bc1-afcf-3fd7b51bd8a3",
				version = 2,
			},
		},
	},
	[57] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"3323f1d1-1b99-693b-b89e-0a79d25464af",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3632,
							targetType = "ContentID",
							uuid = "d11ebb97-29a8-58da-bbe8-3d007fc1ae00",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "3323f1d1-1b99-693b-b89e-0a79d25464af",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 351.9,
				name = "[P2] 自动目标：Thordan P2-2",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 57,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "9d709063-9e32-25c0-b978-526fec074ba7",
				version = 2,
			},
		},
	},
	[58] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"db778d04-f6f6-22fd-88a2-0751cf9588a5",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "55e2d7fb-4d4e-4a5a-bc8b-bbcfa26134c5",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"6040279a-06e2-630e-8ead-f68b93a53aff",
									true,
								},
								
								{
									"59ac8739-358c-679c-b0b7-d4c1eefd8660",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "8367fcf1-8d40-100a-8761-98d558bc5940",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"0e0903fa-43f5-ee4a-aadb-57fdab71cc24",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "8e257d68-0765-4b42-bb7e-e596f8876311",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "59ac8739-358c-679c-b0b7-d4c1eefd8660",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "db778d04-f6f6-22fd-88a2-0751cf9588a5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "6040279a-06e2-630e-8ead-f68b93a53aff",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "0e0903fa-43f5-ee4a-aadb-57fdab71cc24",
							version = 3,
						},
					},
				},
				mechanicTime = 358,
				name = "[P2] 近战个人减伤",
				timelineIndex = 58,
				timerOffset = -3,
				uuid = "6f6d698c-c404-94cb-8887-8b4295f7149e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"1579c847-048e-d691-9d27-a7b63003b668",
									true,
								},
								
								{
									"b206f5b3-0087-c411-8a30-6b9ef9f1e281",
									true,
								},
								
								{
									"7929901b-4d56-d6f8-a1af-192ee3ab5cb6",
									true,
								},
							},
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "fc3a7f27-2b6e-600b-8b20-5c66c157f4a8",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "1579c847-048e-d691-9d27-a7b63003b668",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 6,
							buffIDList = 
							{
								1826,
								1951,
								1934,
							},
							category = "Self",
							name = "Missing Buffs",
							uuid = "b206f5b3-0087-c411-8a30-6b9ef9f1e281",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 4,
							inRangeValue = 20,
							minTargetPercent = true,
							partyTargetNumber = 100,
							partyTargetSubType = "Number",
							uuid = "7929901b-4d56-d6f8-a1af-192ee3ab5cb6",
							version = 3,
						},
					},
				},
				mechanicTime = 358,
				name = "[P2] 远敏团队减伤",
				timeRange = true,
				timelineIndex = 58,
				timerEndOffset = -1.5,
				timerStartOffset = -15,
				uuid = "5ac57838-83f8-c646-8f76-310ccde34b79",
				version = 2,
			},
		},
	},
	[60] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "91fffea2-91d4-c857-909e-0caaaad030c0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 371.3,
				name = "[P2] 阿斯卡隆之威 第二轮1 范围",
				timelineIndex = 60,
				timerOffset = -1.5,
				uuid = "38e38bbb-7aa5-5d60-aaee-13fbea0df440",
				version = 2,
			},
		},
	},
	[61] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "1b59043b-2cdb-0ee4-904c-2ea87e3f1531",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 372.9,
				name = "[P2] 阿斯卡隆之威 第二轮2 范围",
				timelineIndex = 61,
				timerOffset = -1.5,
				uuid = "778be7b6-2d84-ccf6-a63e-7fc4af47c1d8",
				version = 2,
			},
		},
	},
	[62] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "63bebf0c-c238-cec4-a5ac-e2152ba318e8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 374.6,
				name = "[P2] 阿斯卡隆之威 第二轮3 范围",
				timelineIndex = 62,
				timerOffset = -1.5,
				uuid = "9a8e680f-ba6e-8d8c-9b9a-961998946007",
				version = 2,
			},
		},
	},
	[64] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\ndata.string_dsr.p2SanctityMark1ID = tonumber(eventArgs.entityID)\nself.used = true",
							conditions = 
							{
								
								{
									"6f6932b6-9133-6c2f-b5fc-de0cba37e215",
									true,
								},
							},
							endIfUsed = true,
							name = "记录一剑点名",
							uuid = "9cfea81a-1b15-8f8a-a99e-2099e9bf09b9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 50,
							name = "Marker 50",
							uuid = "6f6932b6-9133-6c2f-b5fc-de0cba37e215",
							version = 3,
						},
					},
				},
				eventType = 4,
				mechanicTime = 385.6,
				name = "[P2] 二运一剑标记状态",
				timeRange = true,
				timelineIndex = 64,
				timerEndOffset = 7,
				timerStartOffset = 4,
				uuid = "28b13817-b1b5-cae5-9056-5163ca693faf",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal root = data.string_dsr\nroot.p2SanctityMark1ID = nil\nroot.p2SanctityMark2ID = nil\nroot.p2Sanctity = nil\nroot.p2SanctityOrbDraws = nil\nself.used = true",
							endIfUsed = true,
							name = "清理二运临时状态",
							uuid = "d2df7c8a-aa7f-47ed-812e-13f9542bfff1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 385.6,
				name = "[P2] 二运状态初始化",
				timelineIndex = 64,
				uuid = "c07e3252-b6d9-e430-a308-c9ef25b0390d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\ndata.string_dsr.p2SanctityMark2ID = tonumber(eventArgs.entityID)\nself.used = true",
							conditions = 
							{
								
								{
									"f5891163-bc1c-acde-9155-b7d23816992b",
									true,
								},
							},
							endIfUsed = true,
							name = "记录二剑点名",
							uuid = "87b3fcf4-df63-7494-b8a0-3f1c97df46d5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 51,
							name = "Two-sword marker",
							uuid = "f5891163-bc1c-acde-9155-b7d23816992b",
							version = 3,
						},
					},
				},
				eventType = 4,
				mechanicTime = 385.6,
				name = "[P2] 二运二剑标记状态",
				timeRange = true,
				timelineIndex = 64,
				timerEndOffset = 7,
				timerStartOffset = 4,
				uuid = "d6a7def8-b008-3f8d-8e94-631c1c196720",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal root = data.string_dsr\nlocal mark1ID = tonumber(root.p2SanctityMark1ID)\nlocal mark2ID = tonumber(root.p2SanctityMark2ID)\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif mark1ID == nil or mark2ID == nil or mark1ID == mark2ID\n    or type(party) ~= \"table\" or playerID == nil then\n  self.used = true\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nlocal roleCount = 0\nfor i = 1, #roles do\n  local role = roles[i]\n  local id = tonumber(party[role] and party[role].id)\n  if id ~= nil and roleByID[id] == nil then\n    roleByID[id] = role\n    roleCount = roleCount + 1\n  end\nend\nlocal selfRole = roleByID[playerID]\nlocal mark1Role = roleByID[mark1ID]\nlocal mark2Role = roleByID[mark2ID]\nif roleCount ~= 8 or selfRole == nil or mark1Role == nil or mark2Role == nil then\n  self.used = true\n  return\nend\n\nlocal function isMTGroup(role)\n  return role == \"MT\" or role == \"H1\" or role == \"D1\" or role == \"D3\"\nend\n\nlocal nearBlack = isMTGroup(selfRole)\nlocal swapRole\nif playerID == mark1ID then\n  nearBlack = false\nelseif playerID == mark2ID then\n  nearBlack = true\nelseif isMTGroup(mark1Role) == isMTGroup(mark2Role) then\n  if isMTGroup(mark1Role) then\n    swapRole = \"D2\"\n    if selfRole == \"D2\" then\n      nearBlack = true\n    end\n  else\n    swapRole = \"D1\"\n    if selfRole == \"D1\" then\n      nearBlack = false\n    end\n  end\nend\n\nlocal function headingDistance(a, b)\n  return math.abs(math.atan2(math.sin(a - b), math.cos(a - b)))\nend\n\nlocal function findChargeStart(filter)\n  local entities = TensorCore.entityList(filter)\n  for _, entity in pairs(entities or {}) do\n    local pos = entity and entity.pos\n    local x = tonumber(pos and pos.x)\n    local z = tonumber(pos and pos.z)\n    local heading = tonumber(pos and pos.h)\n    if x ~= nil and z ~= nil and heading ~= nil\n        and math.abs(z - 100) <= 1.5\n        and math.abs(math.abs(x - 100) - 5) <= 1.5 then\n      local south = headingDistance(heading, 0) <= 0.2\n      local north = headingDistance(heading, math.pi) <= 0.2\n        or headingDistance(heading, -math.pi) <= 0.2\n      if south or north then\n        return entity\n      end\n    end\n  end\n  return nil\nend\n\nlocal function findSeverKnight()\n  local entities = TensorCore.entityList(\"contentid=3633\")\n  for _, entity in pairs(entities or {}) do\n    local pos = entity and entity.pos\n    local x = tonumber(pos and pos.x)\n    local z = tonumber(pos and pos.z)\n    if x ~= nil and z ~= nil then\n      local dx = x - 100\n      local dz = z - 100\n      local distanceSquared = dx * dx + dz * dz\n      if distanceSquared >= 169 and distanceSquared <= 289 then\n        return entity\n      end\n    end\n  end\n  return nil\nend\n\nlocal black = findSeverKnight()\nlocal first = findChargeStart(\"contentid=3634\")\nlocal second = findChargeStart(\"contentid=3635\")\nif not black or not first or not second\n    or type(black.pos) ~= \"table\"\n    or type(first.pos) ~= \"table\"\n    or type(second.pos) ~= \"table\" then\n  self.used = true\n  return\nend\n\nlocal center = { x = 100, y = tonumber(first.pos.y) or 0, z = 100 }\nlocal function angleDistance(a, b)\n  return math.abs(math.atan2(math.sin(a - b), math.cos(a - b)))\nend\n\nlocal function buildCharge(entity)\n  local pos = entity.pos\n  local x = tonumber(pos.x)\n  local y = tonumber(pos.y) or center.y\n  local z = tonumber(pos.z)\n  local heading = tonumber(pos.h)\n  if x == nil or z == nil or heading == nil\n      or math.abs(z - center.z) > 1.5\n      or math.abs(math.abs(x - center.x) - 5) > 1.5 then\n    return nil\n  end\n\n  local south = angleDistance(heading, 0) <= 0.2\n  local north = angleDistance(heading, math.pi) <= 0.2\n    or angleDistance(heading, -math.pi) <= 0.2\n  if not south and not north then\n    return nil\n  end\n\n  local right = x > center.x\n  local clockwise = right == south\n  local turn = (clockwise and -1 or 1) * math.rad(112.5)\n  local p0 = { x = x, y = y, z = z }\n  local p1x, p1y, p1z = TensorCore.getPosInDirection(center, heading, 21, true)\n  local p2x, p2y, p2z = TensorCore.getPosInDirection(center, heading + turn, 21, true)\n  local p3x, p3y, p3z = TensorCore.getPosInDirection(center, heading + turn * 2, 21, true)\n  local points = {\n    p0,\n    { x = p1x, y = p1y, z = p1z },\n    { x = p2x, y = p2y, z = p2z },\n    { x = p3x, y = p3y, z = p3z },\n  }\n  return {\n    clockwise = clockwise,\n    points = points,\n  }\nend\n\nlocal charge1 = buildCharge(first)\nlocal charge2 = buildCharge(second)\nif charge1 == nil or charge2 == nil\n    or charge1.clockwise ~= charge2.clockwise then\n  self.used = true\n  return\nend\n\nlocal function lerp(a, b, t)\n  return {\n    x = a.x + (b.x - a.x) * t,\n    y = a.y + (b.y - a.y) * t,\n    z = a.z + (b.z - a.z) * t,\n  }\nend\n\nlocal function buildSpheres(points)\n  return {\n    points[1],\n    lerp(points[1], points[2], 0.5),\n    points[2],\n    lerp(points[2], points[3], 1 / 3),\n    lerp(points[2], points[3], 2 / 3),\n    points[3],\n    lerp(points[3], points[4], 1 / 3),\n    lerp(points[3], points[4], 2 / 3),\n    points[4],\n  }\nend\n\nlocal blackX = tonumber(black.pos.x)\nlocal blackZ = tonumber(black.pos.z)\nif blackX == nil or blackZ == nil then\n  self.used = true\n  return\nend\nlocal severDir = math.atan2(blackX - center.x, blackZ - center.z)\nlocal severDirEast = severDir\nif severDirEast < 0 then\n  severDirEast = severDirEast + math.pi\nend\nlocal severDiagonalSE = severDirEast < math.pi / 2\nlocal chargeEarly = severDiagonalSE == charge1.clockwise\nlocal chargeSign = charge1.clockwise and -1 or 1\nlocal firstOffset = math.rad(chargeEarly and 15 or 11.7)\nlocal secondOffset = math.rad(33.3)\n\nlocal function safePoint(offset)\n  local direction = severDir + chargeSign * offset\n  if not nearBlack then\n    direction = direction + math.pi\n  end\n  local x, y, z = TensorCore.getPosInDirection(center, direction, 20, true)\n  return { x = x, y = y, z = z }\nend\n\nroot.p2Sanctity = {\n  ready = true,\n  selfRole = selfRole,\n  mark1Role = mark1Role,\n  mark2Role = mark2Role,\n  swapRole = swapRole,\n  nearBlack = nearBlack,\n  clockwise = charge1.clockwise,\n  chargeEarly = chargeEarly,\n  firstTarget = safePoint(firstOffset),\n  secondTarget = safePoint(secondOffset),\n  sphereSets = {\n    buildSpheres(charge1.points),\n    buildSpheres(charge2.points),\n  },\n}\nself.used = true",
							endIfUsed = true,
							name = "按 MuAi 职能计算换位和两次安全点",
							uuid = "dd14fa07-afe5-dcd3-a1ab-f443ff27b64c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 385.6,
				name = "[P2] 二运职能换位与安全点计算",
				timelineIndex = 64,
				timerOffset = 6,
				uuid = "2a733a15-247c-fdbb-9d6f-ffc0f518e6b7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\"\n  and data.string_dsr.p2Sanctity or nil\nlocal target = state and state.ready == true and state.firstTarget or nil\nif type(target) == \"table\"\n    and type(target.x) == \"number\" and type(target.z) == \"number\"\n    and type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  MuAiGuide.FrameDirect(target.x, target.z, 0.5)\nend\nself.used = true",
							endIfUsed = true,
							name = "持续指向第一安全点",
							uuid = "af34ae0d-dd80-d5df-9f08-fe42470f50ed",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 385.6,
				name = "[P2] 二运第一安全点动态指路",
				timeRange = true,
				timelineIndex = 64,
				timerEndOffset = 16.10000038147,
				timerStartOffset = 6,
				uuid = "a2bb13ad-3eb3-868b-8c06-4adc84c5a98d",
				version = 2,
			},
		},
	},
	[65] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal center = { x = 100, y = 0, z = 100 }\nlocal heading = math.rad(180 - eventArgs.a1 * 45)\nlocal x, y, z = TensorCore.getPosInDirection(center, heading, 23, true)\ndata.string_dsr.eyePos = { x = x, y = y, z = z }\nself.used = true",
							conditions = 
							{
								
								{
									"04e42ecb-3e98-8c33-8a46-876000f563d1",
									true,
								},
								
								{
									"bda15ba4-fc06-66b3-94a8-08a11180eb04",
									true,
								},
								
								{
									"a15f4902-68fa-28b7-b438-914040a0119a",
									true,
								},
								
								{
									"3e7c1d2a-f126-d423-a405-20cd4fab40e8",
									true,
								},
							},
							endIfUsed = true,
							name = "Store eye position",
							uuid = "749c1a5b-febe-013f-aded-ee6fc3cae269",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return eventArgs.a1 >= 0 and eventArgs.a1 <= 7 and eventArgs.a2 == 1 and eventArgs.a3 == 2",
							dequeueIfLuaFalse = true,
							name = "Dragon eye a1 >= 0",
							uuid = "a15f4902-68fa-28b7-b438-914040a0119a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 2,
							dequeueIfLuaFalse = true,
							eventIntValue = 7,
							name = "Dragon eye a1 <= 7",
							uuid = "3e7c1d2a-f126-d423-a405-20cd4fab40e8",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventIntValue = 1,
							name = "Dragon eye a2 == 1",
							uuid = "04e42ecb-3e98-8c33-8a46-876000f563d1",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							eventIntValue = 2,
							name = "Dragon eye a3 == 2",
							uuid = "bda15ba4-fc06-66b3-94a8-08a11180eb04",
							version = 3,
						},
					},
				},
				eventType = 14,
				mechanicTime = 388.7,
				name = "[P2] 龙眼位置状态",
				timeRange = true,
				timelineIndex = 65,
				timerEndOffset = 12,
				timerStartOffset = -1,
				uuid = "4c51ebdd-03df-314e-b506-414447011ab2",
				version = 2,
			},
		},
	},
	[66] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nlocal thordan = TensorCore.mGetEntity(eventArgs.entityID)\n\nif not state or not state.eyePos or not player or not player.pos\n    or not thordan or not thordan.pos then\n  self.used = true\n  return\nend\n\nlocal heading = TensorCore.Avoidance.getHeadingBetweenPos(\n  player.pos,\n  state.eyePos,\n  thordan.pos\n) + math.pi\n\nTensorCore.API.TensorACR.setLockFaceHeading(heading)\nTensorCore.API.TensorACR.toggleLockFace(true)\nTensorCore.getStaticDrawer(520093951):addTimedArrow(\n  1800,\n  player.pos.x,\n  player.pos.y,\n  player.pos.z,\n  heading,\n  6,\n  1\n)\nself.used = true",
							conditions = 
							{
								
								{
									"9a0fa899-65c9-95d9-9eba-088018eb1ca2",
									true,
								},
								
								{
									"8b7c2cc3-2811-20a8-8a2e-4ded8a6a6095",
									true,
								},
							},
							endIfUsed = true,
							name = "Lock away from gaze",
							uuid = "a5b599ee-ba3b-2967-8f06-aa4c336c6254",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25552,
							name = "Gaze cast 25552",
							uuid = "9a0fa899-65c9-95d9-9eba-088018eb1ca2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3632,
							name = "Thordan C3632",
							uuid = "8b7c2cc3-2811-20a8-8a2e-4ded8a6a6095",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 398.2,
				name = "[P2] Dragon's Gaze 自动背对",
				timeRange = true,
				timelineIndex = 66,
				timerEndOffset = 1,
				timerStartOffset = -0.5,
				uuid = "bb98c662-5bc7-cfa9-b745-815303970e5d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\nself.used = true",
							conditions = 
							{
								
								{
									"d08257ed-2333-d492-a111-dc37a2503407",
									true,
								},
								
								{
									"14931158-1f33-f0fd-857c-50c4a71d3b97",
									true,
								},
							},
							endIfUsed = true,
							name = "Unlock facing",
							uuid = "c8a0e256-8ca4-d017-9f7d-4b9cc5c64852",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25553,
							name = "Gaze resolve 25553",
							uuid = "d08257ed-2333-d492-a111-dc37a2503407",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3632,
							name = "Thordan C3632",
							uuid = "14931158-1f33-f0fd-857c-50c4a71d3b97",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 398.2,
				name = "[P2] Dragon's Gaze 精确解锁",
				timeRange = true,
				timelineIndex = 66,
				timerEndOffset = 2.5,
				timerStartOffset = 0.5,
				uuid = "e6f2f630-e64b-5b82-8fca-d3ff73f55369",
				version = 2,
			},
		},
	},
	[68] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal root = data.string_dsr\nlocal entityID = tonumber(eventArgs.entityID)\nlocal channelTime = tonumber(eventArgs.channelTimeMax)\nlocal timeout = channelTime and channelTime > 0 and channelTime * 1000 or 700\nif entityID == nil then\n  self.used = true\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nlocal entity = TensorCore.mGetEntity(entityID)\nlocal pos = entity and entity.pos or nil\nlocal draws = root.p2SanctityOrbDraws\nlocal matched\nif type(pos) == \"table\"\n    and type(pos.x) == \"number\" and type(pos.z) == \"number\"\n    and type(draws) == \"table\" then\n  local bestDistance\n  for index = 1, #draws do\n    local draw = draws[index]\n    if type(draw) == \"table\" and draw.claimed ~= true\n        and type(draw.x) == \"number\" and type(draw.z) == \"number\" then\n      local dx = draw.x - pos.x\n      local dz = draw.z - pos.z\n      local distance = dx * dx + dz * dz\n      if distance <= 4 and (bestDistance == nil or distance < bestDistance) then\n        bestDistance = distance\n        matched = draw\n      end\n    end\n  end\nend\n\nlocal updated = false\nif matched ~= nil and matched.uuid ~= nil then\n  updated = drawer:updateTimedCircleOnEnt(\n    matched.uuid,\n    timeout,\n    entityID,\n    9,\n    0,\n    false,\n    false\n  ) == true\n  matched.claimed = true\nend\nif updated ~= true then\n  drawer:addTimedCircleOnEnt(timeout, entityID, 9, 0, false, false)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"5b653908-fecf-eb01-aaf2-974f7eaa95cc",
									true,
								},
								
								{
									"a5430ec3-4c45-1c1b-b9dc-79d1d30a562e",
									true,
								},
							},
							endIfUsed = true,
							name = "按实际白球读条修正判定时间",
							uuid = "aa6d4279-4d09-ebb9-a779-d69fee5a54e5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 4385,
							name = "Holy Orb",
							uuid = "5b653908-fecf-eb01-aaf2-974f7eaa95cc",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25295,
							name = "Bright Flare",
							uuid = "a5430ec3-4c45-1c1b-b9dc-79d1d30a562e",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 399.3,
				name = "[P2] 光球范围（二）",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 13,
				timerStartOffset = -2,
				uuid = "7f99da82-8d7b-144b-937b-9de00f035989",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"fa3e90b2-9f7b-e3ae-9a99-13fe0effdb91",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "2a476ca0-d48d-69fa-aa78-0ef5ef716be0",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"83558fc4-9eeb-f31b-946a-960207aa5fe2",
									true,
								},
								
								{
									"23498bf4-1aa8-5f8c-9743-0a654a8f7979",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "09a0618f-f548-2cec-873e-f94c7983d9d3",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"205004c3-808a-50be-bfbb-33c3c7b0bea0",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "2ffe6df7-fa78-64a5-98f9-b1ede9d1ecf7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "23498bf4-1aa8-5f8c-9743-0a654a8f7979",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "fa3e90b2-9f7b-e3ae-9a99-13fe0effdb91",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "83558fc4-9eeb-f31b-946a-960207aa5fe2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "205004c3-808a-50be-bfbb-33c3c7b0bea0",
							version = 3,
						},
					},
				},
				mechanicTime = 399.3,
				name = "[P2] 近战个人减伤",
				timelineIndex = 68,
				timerOffset = -3,
				uuid = "d9086d70-3ae6-60e0-a212-ecce35be8e6f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = data.string_dsr\nlocal state = type(root) == \"table\" and root.p2Sanctity or nil\nlocal sphereSets = state and state.ready == true and state.sphereSets or nil\nif type(sphereSets) ~= \"table\"\n    or type(sphereSets[1]) ~= \"table\"\n    or type(sphereSets[2]) ~= \"table\" then\n  self.used = true\n  return\nend\n\nlocal timeouts = {\n  5853, 6197, 6540, 7478, 7775, 8165, 8993, 9322, 9725,\n}\nlocal firstTarget = state.firstTarget\nlocal deferredSet\nlocal deferredIndex\nlocal deferredDistance\nif type(firstTarget) == \"table\"\n    and type(firstTarget.x) == \"number\"\n    and type(firstTarget.z) == \"number\" then\n  for sphereIndex = 1, #timeouts do\n    for setIndex = 1, 2 do\n      local point = sphereSets[setIndex][sphereIndex]\n      if type(point) == \"table\"\n          and type(point.x) == \"number\"\n          and type(point.z) == \"number\" then\n        local dx = point.x - firstTarget.x\n        local dz = point.z - firstTarget.z\n        local distance = dx * dx + dz * dz\n        if distance <= 81\n            and (deferredDistance == nil or distance < deferredDistance) then\n          deferredDistance = distance\n          deferredSet = setIndex\n          deferredIndex = sphereIndex\n        end\n      end\n    end\n  end\nend\n\nstate.deferredOrb = nil\nif deferredIndex ~= nil then\n  local point = sphereSets[deferredSet][deferredIndex]\n  local remaining = timeouts[deferredIndex] - 5900\n  if remaining > 0 then\n    state.deferredOrb = {\n      x = point.x,\n      y = tonumber(point.y) or 0,\n      z = point.z,\n      timeout = remaining,\n    }\n  else\n    deferredSet = nil\n    deferredIndex = nil\n  end\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nlocal draws = {}\nfor sphereIndex = 1, #timeouts do\n  for setIndex = 1, 2 do\n    local point = sphereSets[setIndex][sphereIndex]\n    if type(point) ~= \"table\"\n        or type(point.x) ~= \"number\"\n        or type(point.z) ~= \"number\" then\n      state.deferredOrb = nil\n      self.used = true\n      return\n    end\n    if setIndex ~= deferredSet or sphereIndex ~= deferredIndex then\n      local uuid = drawer:addTimedCircle(\n        timeouts[sphereIndex],\n        point.x,\n        tonumber(point.y) or 0,\n        point.z,\n        9,\n        0,\n        false,\n        false\n      )\n      draws[#draws + 1] = {\n        x = point.x,\n        z = point.z,\n        uuid = uuid,\n        claimed = false,\n      }\n    end\n  end\nend\nroot.p2SanctityOrbDraws = draws\nself.used = true",
							endIfUsed = true,
							name = "预绘两路十八个白球九米范围",
							uuid = "501ea4ce-ef79-2e95-a55c-7d00c26baf18",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 399.3,
				name = "[P2] 二运白球冲锋钢铁预绘",
				timelineIndex = 68,
				timerOffset = -3.5,
				uuid = "13abe376-5b9a-2f8b-9068-7ea02994a6d5",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\"\n  and data.string_dsr.p2Sanctity or nil\nlocal target = state and state.ready == true and state.secondTarget or nil\nif type(target) == \"table\"\n    and type(target.x) == \"number\" and type(target.z) == \"number\"\n    and type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  MuAiGuide.FrameDirect(target.x, target.z, 0.5)\nend\nself.used = true",
							endIfUsed = true,
							name = "第一批白球判定后指向第二安全点",
							uuid = "c4867bbe-d7b2-e812-9b62-7f423a03da9b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 399.3,
				name = "[P2] 二运第二安全点动态指路",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 6.4,
				timerStartOffset = 2.4,
				uuid = "df7caef7-9795-d7fa-99ef-d7b5539f9b32",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = data.string_dsr\nlocal state = type(root) == \"table\" and root.p2Sanctity or nil\nlocal orb = type(state) == \"table\" and state.deferredOrb or nil\nif type(orb) ~= \"table\"\n    or type(orb.x) ~= \"number\"\n    or type(orb.z) ~= \"number\" then\n  self.used = true\n  return\nend\n\nlocal timeout = tonumber(orb.timeout)\nif timeout ~= nil and timeout > 0 then\n  local drawer = TensorCore.getMoogleDrawer()\n  local uuid = drawer:addTimedCircle(\n    timeout,\n    orb.x,\n    tonumber(orb.y) or 0,\n    orb.z,\n    9,\n    0,\n    false,\n    false\n  )\n  root.p2SanctityOrbDraws = root.p2SanctityOrbDraws or {}\n  root.p2SanctityOrbDraws[#root.p2SanctityOrbDraws + 1] = {\n    x = orb.x,\n    z = orb.z,\n    uuid = uuid,\n    claimed = false,\n  }\nend\nstate.deferredOrb = nil\nself.used = true",
							endIfUsed = true,
							name = "补画第一安全点覆盖球",
							uuid = "73592294-f6aa-7682-832b-7aa1306d319a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 399.3,
				name = "[P2] 二运第一安全点覆盖球延后补画",
				timelineIndex = 68,
				timerOffset = 2.4,
				uuid = "b5aa2e70-080d-53e9-8c18-bd0326d9b6de",
				version = 2,
			},
		},
	},
	[70] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or {}\ndata.string_dsr = root\n\nroot.p2Sanctity25 = {\n  markerIDs = {},\n  markerIDSet = {},\n  markersReady = false,\n  ready = false,\n  firstReady = false,\n}\nroot.cometsArmed = false\n\nself.used = true",
							name = "初始化双陨石状态",
							uuid = "b03b4041-95a2-f3b6-b462-830418eb2519",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 417.2,
				name = "[P2] 彗星落点初始化",
				timelineIndex = 70,
				timerOffset = -9,
				uuid = "95effd9a-1be9-4c2d-9637-1363f1bc87ce",
				version = 2,
			},
			inheritedIndex = 1,
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p2Sanctity25 or nil\nlocal markerIDs = type(state) == \"table\" and state.markerIDs or nil\nlocal markerIDSet = type(state) == \"table\" and state.markerIDSet or nil\n\nif type(state) ~= \"table\"\n    or type(markerIDs) ~= \"table\"\n    or type(markerIDSet) ~= \"table\" then\n  self.used = true\n  return\nend\n\nif state.markersReady ~= true then\n  local id = tonumber(eventArgs.entityID)\n  if id and markerIDSet[id] ~= true and #markerIDs < 2 then\n    markerIDSet[id] = true\n    markerIDs[#markerIDs + 1] = id\n  end\n\n  if #markerIDs == 2 then\n    if markerIDs[1] > markerIDs[2] then\n      markerIDs[1], markerIDs[2] = markerIDs[2], markerIDs[1]\n    end\n\n    state.markersReady = true\n\n    local player = TensorCore.mGetPlayer()\n    root.cometsArmed = player ~= nil\n      and markerIDSet[tonumber(player.id)] == true\n  end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"db54ac88-ab51-3212-b33c-605c3b122811",
									true,
								},
							},
							endIfUsed = true,
							name = "捕获双陨石点名",
							uuid = "de981347-30aa-c6b0-bf88-fbf822e23152",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 285,
							name = "Marker 285",
							uuid = "db54ac88-ab51-3212-b33c-605c3b122811",
							version = 3,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 417.2,
				name = "[P2] 彗星落点状态",
				timeRange = true,
				timelineIndex = 70,
				timerEndOffset = -6.8000001907349,
				timerOffset = -7.4,
				timerStartOffset = -8,
				uuid = "0cd032c4-d693-3158-a8f5-1fe4d55e2c88",
				version = 2,
			},
		},
	},
	[71] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p2Sanctity25 or nil\nlocal markerIDs = type(state) == \"table\" and state.markerIDs or nil\nif type(state) ~= \"table\"\n    or state.markersReady ~= true\n    or type(markerIDs) ~= \"table\"\n    or #markerIDs ~= 2 then\n  return\nend\n\nlocal initialGroup = {\n  MT = 0, D1 = 0,\n  H2 = 1, D4 = 1,\n  ST = 2, D2 = 2,\n  H1 = 3, D3 = 3,\n}\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\n\nlocal function norm360(v)\n  v = v % 360\n  if v < 0 then v = v + 360 end\n  return v\nend\n\nlocal function angleDiff(v)\n  v = norm360(v + 180) - 180\n  return v\nend\n\nlocal function bearing(pos)\n  return norm360(math.deg(math.atan2(pos.x - 100, 100 - pos.z)))\nend\n\nlocal function posAt(deg, radius)\n  local rad = math.rad(deg)\n  return {\n    x = 100 + math.sin(rad) * radius,\n    y = 0,\n    z = 100 - math.cos(rad) * radius,\n  }\nend\n\nlocal function findSelfRole(player)\n  if state and state.ready == true and type(state.roleByID) == \"table\" then\n    return state.roleByID[tonumber(player.id)]\n  end\n  if type(MuAiGuide) ~= \"table\" or type(MuAiGuide.Party) ~= \"table\" then\n    return nil\n  end\n  for _, role in ipairs(roles) do\n    local ent = MuAiGuide.Party[role]\n    if ent and tonumber(ent.id) == tonumber(player.id) then\n      return role\n    end\n  end\n  return nil\nend\n\nif state and state.ready ~= true\n    and type(state.markerIDs) == \"table\" and #state.markerIDs >= 2\n    and type(MuAiGuide) == \"table\" and type(MuAiGuide.Party) == \"table\" then\n  local roleByID, idByRole = {}, {}\n  local valid = true\n\n  for _, role in ipairs(roles) do\n    local ent = MuAiGuide.Party[role]\n    local id = ent and tonumber(ent.id)\n    if not id or roleByID[id] then\n      valid = false\n      break\n    end\n    roleByID[id] = role\n    idByRole[role] = id\n  end\n\n  local meteorRoles = {}\n  if valid then\n    for i = 1, 2 do\n      local role = roleByID[state.markerIDs[i]]\n      if not role then\n        valid = false\n        break\n      end\n      meteorRoles[#meteorRoles + 1] = role\n    end\n  end\n\n  if valid then\n    local g1 = initialGroup[meteorRoles[1]]\n    local g2 = initialGroup[meteorRoles[2]]\n    if g1 > g2 then\n      g1, g2 = g2, g1\n      meteorRoles[1], meteorRoles[2] = meteorRoles[2], meteorRoles[1]\n    end\n\n    local swap = { [0] = 0, [1] = 1, [2] = 2, [3] = 3 }\n    local pair = tostring(g1) .. tostring(g2)\n    if pair == \"01\" then\n      swap[1], swap[2] = 2, 1\n    elseif pair == \"03\" then\n      swap[3], swap[2] = 2, 3\n    elseif pair == \"12\" then\n      swap[1], swap[0] = 0, 1\n    elseif pair == \"23\" then\n      swap[3], swap[0] = 0, 3\n    elseif pair ~= \"02\" and pair ~= \"13\" then\n      valid = false\n    end\n\n    if valid then\n      local isMeteorByRole = {}\n      isMeteorByRole[meteorRoles[1]] = true\n      isMeteorByRole[meteorRoles[2]] = true\n\n      local finalQuadrantByRole = {}\n      for _, role in ipairs(roles) do\n        finalQuadrantByRole[role] = swap[initialGroup[role]]\n      end\n\n      state.roles = roles\n      state.groupByRole = initialGroup\n      state.roleByID = roleByID\n      state.idByRole = idByRole\n      state.meteorRoles = meteorRoles\n      state.isMeteorByRole = isMeteorByRole\n      state.finalQuadrantByRole = finalQuadrantByRole\n      state.meteorGroupPair = pair\n      state.ready = true\n    end\n  end\nend\n\nif state and state.ready == true and state.firstReady ~= true\n    and type(Argus) == \"table\" and type(Argus.getCurrentAOEs) == \"function\" then\n  local outerByQ = { [0] = {}, [1] = {}, [2] = {}, [3] = {} }\n  local inner = {}\n  local seen, towerCount = {}, 0\n\n  for _, aoe in pairs(Argus.getCurrentAOEs()) do\n    if tonumber(aoe.aoeID) == 29564\n        and type(aoe.x) == \"number\" and type(aoe.z) == \"number\" then\n      local key = string.format(\"%.2f:%.2f\", aoe.x, aoe.z)\n      if not seen[key] then\n        seen[key] = true\n        towerCount = towerCount + 1\n        local pos = { x = aoe.x, y = tonumber(aoe.y or 0) or 0, z = aoe.z }\n        local dx, dz = pos.x - 100, pos.z - 100\n        local radius = math.sqrt(dx * dx + dz * dz)\n        local b = bearing(pos)\n        local tower = { pos = pos, bearing = b, key = key }\n\n        if radius > 10 then\n          local q = math.floor((b + 45) / 90) % 4\n          local diff = angleDiff(b - q * 90)\n          if math.abs(diff) < 10 then\n            tower.rank = 0\n          elseif diff < 0 then\n            tower.rank = 1\n          else\n            tower.rank = 2\n          end\n          outerByQ[q][#outerByQ[q] + 1] = tower\n        else\n          inner[#inner + 1] = tower\n        end\n      end\n    end\n  end\n\n  local layoutValid = towerCount == 8\n  for q = 0, 3 do\n    table.sort(outerByQ[q], function(a, b)\n      if a.rank ~= b.rank then return a.rank < b.rank end\n      return a.bearing < b.bearing\n    end)\n    if #outerByQ[q] < 1 or #outerByQ[q] > 2 then\n      layoutValid = false\n    end\n  end\n  table.sort(inner, function(a, b) return a.bearing < b.bearing end)\n\n  if layoutValid then\n    local membersByQ = { [0] = {}, [1] = {}, [2] = {}, [3] = {} }\n    for _, role in ipairs(state.roles or roles) do\n      local q = state.finalQuadrantByRole[role]\n      if q == nil then\n        layoutValid = false\n        break\n      end\n      membersByQ[q][#membersByQ[q] + 1] = role\n    end\n    for q = 0, 3 do\n      if #membersByQ[q] ~= 2 then layoutValid = false end\n    end\n\n    if layoutValid then\n      local firstByRole, firstBearingByRole = {}, {}\n      local usedOuterKeyByQ = {}\n      local meteorGroups = {}\n\n      local function meteorInGroup(q)\n        for _, role in ipairs(membersByQ[q]) do\n          if state.isMeteorByRole[role] then return role end\n        end\n        return nil\n      end\n\n      for q = 0, 3 do\n        local meteorRole = meteorInGroup(q)\n        if meteorRole then\n          meteorGroups[#meteorGroups + 1] = { q = q, role = meteorRole }\n        end\n      end\n      table.sort(meteorGroups, function(a, b) return a.q < b.q end)\n\n      if #meteorGroups == 2 then\n        local g1, g2 = meteorGroups[1], meteorGroups[2]\n        local best1, best2, bestDeviation, bestRank\n        for _, t1 in ipairs(outerByQ[g1.q]) do\n          for _, t2 in ipairs(outerByQ[g2.q]) do\n            local cw = norm360(t2.bearing - t1.bearing)\n            local deviation = math.abs(cw - 180)\n            local rank = t1.rank + t2.rank\n            if not bestDeviation\n                or deviation < bestDeviation\n                or (deviation == bestDeviation and rank < bestRank)\n                or (deviation == bestDeviation and rank == bestRank\n                    and (t1.bearing < best1.bearing\n                      or (t1.bearing == best1.bearing and t2.bearing < best2.bearing))) then\n              best1, best2 = t1, t2\n              bestDeviation, bestRank = deviation, rank\n            end\n          end\n        end\n\n        if best1 and best2 then\n          firstByRole[g1.role], firstBearingByRole[g1.role] = best1.pos, best1.bearing\n          firstByRole[g2.role], firstBearingByRole[g2.role] = best2.pos, best2.bearing\n          usedOuterKeyByQ[g1.q] = best1.key\n          usedOuterKeyByQ[g2.q] = best2.key\n        else\n          layoutValid = false\n        end\n      else\n        layoutValid = false\n      end\n\n      local pendingInner = {}\n      if layoutValid then\n        for q = 0, 3 do\n          local members = membersByQ[q]\n          local meteorRole = meteorInGroup(q)\n          local dpsRole\n          for _, role in ipairs(members) do\n            if string.sub(role, 1, 1) == \"D\" then dpsRole = role end\n          end\n          local highRole = meteorRole or dpsRole\n          local lowRole = members[1] == highRole and members[2] or members[1]\n\n          if not highRole or not lowRole then\n            layoutValid = false\n            break\n          end\n\n          if not firstByRole[highRole] then\n            local chosen = outerByQ[q][1]\n            firstByRole[highRole], firstBearingByRole[highRole] = chosen.pos, chosen.bearing\n            usedOuterKeyByQ[q] = chosen.key\n          end\n\n          local remainingOuter\n          for _, tower in ipairs(outerByQ[q]) do\n            if tower.key ~= usedOuterKeyByQ[q] then\n              remainingOuter = tower\n              break\n            end\n          end\n\n          if remainingOuter then\n            firstByRole[lowRole] = remainingOuter.pos\n            firstBearingByRole[lowRole] = remainingOuter.bearing\n          else\n            pendingInner[#pendingInner + 1] = { q = q, role = lowRole }\n          end\n        end\n      end\n\n      if layoutValid and #pendingInner == #inner then\n        local used, current = {}, {}\n        local best, bestLeftCount, bestRightCount, bestFillCost, bestCode\n\n        local function innerPreference(q, tower)\n          local left = norm360(q * 90 + 45)\n          local right = norm360(q * 90 - 45)\n          local dl = math.abs(angleDiff(tower.bearing - left))\n          local dr = math.abs(angleDiff(tower.bearing - right))\n          if dl < 10 then return 1, 0, 0 end\n          if dr < 10 then return 0, 1, 0 end\n          return 0, 0, math.min(dl, dr)\n        end\n\n        local function isBetter(leftCount, rightCount, fillCost, code)\n          if bestLeftCount == nil then return true end\n          if leftCount ~= bestLeftCount then return leftCount > bestLeftCount end\n          if rightCount ~= bestRightCount then return rightCount > bestRightCount end\n          if fillCost ~= bestFillCost then return fillCost < bestFillCost end\n          return code < bestCode\n        end\n\n        local function search(i, leftCount, rightCount, fillCost, code)\n          if i > #pendingInner then\n            if isBetter(leftCount, rightCount, fillCost, code) then\n              bestLeftCount, bestRightCount = leftCount, rightCount\n              bestFillCost, bestCode = fillCost, code\n              best = {}\n              for role, tower in pairs(current) do best[role] = tower end\n            end\n            return\n          end\n\n          local entry = pendingInner[i]\n          for index, tower in ipairs(inner) do\n            if not used[index] then\n              used[index] = true\n              current[entry.role] = tower\n              local addLeft, addRight, addFill = innerPreference(entry.q, tower)\n              search(\n                i + 1,\n                leftCount + addLeft,\n                rightCount + addRight,\n                fillCost + addFill,\n                code .. string.format(\"%02d\", index)\n              )\n              current[entry.role] = nil\n              used[index] = nil\n            end\n          end\n        end\n\n        search(1, 0, 0, 0, \"\")\n        if best then\n          for role, tower in pairs(best) do\n            firstByRole[role] = tower.pos\n            firstBearingByRole[role] = tower.bearing\n          end\n        else\n          layoutValid = false\n        end\n      elseif layoutValid then\n        layoutValid = false\n      end\n\n      if layoutValid then\n        for _, role in ipairs(state.roles or roles) do\n          if not firstByRole[role] then\n            layoutValid = false\n            break\n          end\n        end\n      end\n\n      if layoutValid then\n        local secondByRole, preKBByRole, secondBearingByRole = {}, {}, {}\n        for q = 0, 3 do\n          local members = membersByQ[q]\n          local meteorRole = meteorInGroup(q)\n          local oppositeQ = (q + 2) % 4\n          for _, role in ipairs(members) do\n            local b\n            if meteorRole then\n              b = state.isMeteorByRole[role] and (oppositeQ * 90) or (q * 90 + 45)\n            else\n              b = string.sub(role, 1, 1) == \"D\" and (q * 90) or (q * 90 + 45)\n            end\n            b = norm360(b)\n            secondBearingByRole[role] = b\n            secondByRole[role] = posAt(b, 18)\n            preKBByRole[role] = posAt(b, 2)\n          end\n        end\n\n        state.membersByFinalQuadrant = membersByQ\n        state.firstTowerByRole = firstByRole\n        state.firstTowerBearingByRole = firstBearingByRole\n        state.secondTowerByRole = secondByRole\n        state.secondTowerBearingByRole = secondBearingByRole\n        state.preKnockbackByRole = preKBByRole\n        state.firstReady = true\n      end\n    end\n  end\nend\n\nlocal player = TensorCore.mGetPlayer()\nif player and state and state.ready == true then\n  local role = findSelfRole(player)\n  local q = role and state.finalQuadrantByRole[role] or nil\n  if q ~= nil and type(MuAiGuide) == \"table\"\n      and type(MuAiGuide.FrameDirect) == \"function\" then\n    local target = posAt(q * 90, 12)\n    MuAiGuide.FrameDirect(target.x, target.z, 0.5)\n  end\nend\n\nself.used = true",
							endIfUsed = true,
							name = "动态指路",
							uuid = "91497969-a432-8ed1-ad53-0ac4d6bc1122",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 417.4,
				name = "[P2] 2.5运整组换位与冰圈预站位",
				timeRange = true,
				timelineIndex = 71,
				timerStartOffset = -8.2,
				uuid = "3764a3df-ad23-6015-a39d-aa624af8d9ed",
				version = 2,
			},
		},
	},
	[72] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal pos = player and player.pos or nil\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer and pos and type(pos.x) == \"number\" and type(pos.z) == \"number\" then\n  drawer:addTimedCircle(13100, pos.x, tonumber(pos.y or 0) or 0, pos.z, 6)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"0660dd8f-fa52-e4f8-af66-b279cea6cc9a",
									true,
								},
							},
							endIfUsed = true,
							name = "快照自己第 1 次彗星落点",
							uuid = "8647b69c-3256-1561-a4fd-f794c8dbe5f8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p2Sanctity25 or nil\nlocal markerIDs = type(state) == \"table\" and state.markerIDs or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = player and player.id or nil\nreturn type(state) == \"table\"\n  and state.markersReady == true\n  and type(markerIDs) == \"table\"\n  and #markerIDs == 2\n  and type(playerID) == \"number\"\n  and (markerIDs[1] == playerID or markerIDs[2] == playerID)",
							name = "自己是陨石点名",
							uuid = "0660dd8f-fa52-e4f8-af66-b279cea6cc9a",
							version = 3,
						},
					},
				},
				mechanicTime = 421.6,
				name = "[P2] 彗星落点 1",
				timelineIndex = 72,
				timerEndOffset = 10,
				uuid = "efacfe5a-d1c2-e231-b087-9ac94fe4f4a4",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\" and data.string_dsr.p2Sanctity25 or nil\nlocal player = TensorCore.mGetPlayer()\nif state and state.firstReady == true and player\n    and type(state.roleByID) == \"table\"\n    and type(state.firstTowerByRole) == \"table\"\n    and type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  local role = state.roleByID[tonumber(player.id)]\n  local target = role and state.firstTowerByRole[role] or nil\n  if target then\n    MuAiGuide.FrameDirect(target.x, target.z, 0.5)\n  end\nend\nself.used = true",
							endIfUsed = true,
							name = "动态指路",
							uuid = "d85063b2-c84a-4681-bf3c-7f3512bd1291",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 421.6,
				name = "[P2] 2.5运第一次踩塔动态指路",
				timeRange = true,
				timelineIndex = 72,
				timerStartOffset = -4.1999998092651,
				uuid = "7c0a184a-2d72-cea8-a026-ad17b6efa2bf",
				version = 2,
			},
		},
	},
	[73] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"4d67800a-1daf-984e-9e28-6e7b90812e73",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "心眼",
							uuid = "39ac3b1f-6564-1753-a0cf-1a802e622f2c",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"3a2dc96d-aa45-c647-be62-2d809c43fc81",
									true,
								},
								
								{
									"b74adf4f-09c8-75ef-a3b5-5d93dffdbb87",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "金刚极意",
							uuid = "083d69c9-278f-69b9-b66a-3d27916ecfd0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "b74adf4f-09c8-75ef-a3b5-5d93dffdbb87",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "4d67800a-1daf-984e-9e28-6e7b90812e73",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "3a2dc96d-aa45-c647-be62-2d809c43fc81",
							version = 3,
						},
					},
				},
				mechanicTime = 423,
				name = "[P2] 近战个人减伤",
				timelineIndex = 73,
				timerOffset = -3,
				uuid = "a16af54b-d047-f301-be2a-ee2a32a4ac06",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal pos = player and player.pos or nil\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer and pos and type(pos.x) == \"number\" and type(pos.z) == \"number\" then\n  drawer:addTimedCircle(11700, pos.x, tonumber(pos.y or 0) or 0, pos.z, 6)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"905e9cdf-05da-5bc6-9cad-850ecd60db9f",
									true,
								},
							},
							endIfUsed = true,
							name = "快照自己第 2 次彗星落点",
							uuid = "09c4dd1d-b8f1-46d7-9257-aabcfc381f12",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p2Sanctity25 or nil\nlocal markerIDs = type(state) == \"table\" and state.markerIDs or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = player and player.id or nil\nreturn type(state) == \"table\"\n  and state.markersReady == true\n  and type(markerIDs) == \"table\"\n  and #markerIDs == 2\n  and type(playerID) == \"number\"\n  and (markerIDs[1] == playerID or markerIDs[2] == playerID)",
							name = "自己是陨石点名",
							uuid = "905e9cdf-05da-5bc6-9cad-850ecd60db9f",
							version = 3,
						},
					},
				},
				mechanicTime = 423,
				name = "[P2] 彗星落点 2",
				timelineIndex = 73,
				uuid = "0c668eaf-f03a-90c0-947b-c4cfca2556e4",
				version = 2,
			},
		},
	},
	[74] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal pos = player and player.pos or nil\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer and pos and type(pos.x) == \"number\" and type(pos.z) == \"number\" then\n  drawer:addTimedCircle(10300, pos.x, tonumber(pos.y or 0) or 0, pos.z, 6)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"c11403e6-d23c-24fa-aab4-657fd9e06799",
									true,
								},
							},
							endIfUsed = true,
							name = "快照自己第 3 次彗星落点",
							uuid = "56760bb7-14d3-ce15-80cf-fc369e36b988",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p2Sanctity25 or nil\nlocal markerIDs = type(state) == \"table\" and state.markerIDs or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = player and player.id or nil\nreturn type(state) == \"table\"\n  and state.markersReady == true\n  and type(markerIDs) == \"table\"\n  and #markerIDs == 2\n  and type(playerID) == \"number\"\n  and (markerIDs[1] == playerID or markerIDs[2] == playerID)",
							name = "自己是陨石点名",
							uuid = "c11403e6-d23c-24fa-aab4-657fd9e06799",
							version = 3,
						},
					},
				},
				mechanicTime = 424.4,
				name = "[P2] 彗星落点 3",
				timelineIndex = 74,
				uuid = "367fdad8-6e52-b673-8c8c-88a4802b8b2b",
				version = 2,
			},
		},
	},
	[75] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal pos = player and player.pos or nil\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer and pos and type(pos.x) == \"number\" and type(pos.z) == \"number\" then\n  drawer:addTimedCircle(8900, pos.x, tonumber(pos.y or 0) or 0, pos.z, 6)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"cf725d47-2910-54d1-bea9-9bb7a5d379e9",
									true,
								},
							},
							endIfUsed = true,
							name = "快照自己第 4 次彗星落点",
							uuid = "4c7b7578-5ca3-db86-b8fc-8f74c8b7d057",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p2Sanctity25 or nil\nlocal markerIDs = type(state) == \"table\" and state.markerIDs or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = player and player.id or nil\nreturn type(state) == \"table\"\n  and state.markersReady == true\n  and type(markerIDs) == \"table\"\n  and #markerIDs == 2\n  and type(playerID) == \"number\"\n  and (markerIDs[1] == playerID or markerIDs[2] == playerID)",
							name = "自己是陨石点名",
							uuid = "cf725d47-2910-54d1-bea9-9bb7a5d379e9",
							version = 3,
						},
					},
				},
				mechanicTime = 425.8,
				name = "[P2] 彗星落点 4",
				timelineIndex = 75,
				uuid = "1181a254-c572-5919-b2ec-28b236fd6721",
				version = 2,
			},
		},
	},
	[76] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal pos = player and player.pos or nil\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer and pos and type(pos.x) == \"number\" and type(pos.z) == \"number\" then\n  drawer:addTimedCircle(7500, pos.x, tonumber(pos.y or 0) or 0, pos.z, 6)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"23d077e6-339b-f6da-927b-4a5044c9b3c5",
									true,
								},
							},
							endIfUsed = true,
							name = "快照自己第 5 次彗星落点",
							uuid = "aa89b703-9fef-0b77-bd01-1b648f8eb79a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p2Sanctity25 or nil\nlocal markerIDs = type(state) == \"table\" and state.markerIDs or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = player and player.id or nil\nreturn type(state) == \"table\"\n  and state.markersReady == true\n  and type(markerIDs) == \"table\"\n  and #markerIDs == 2\n  and type(playerID) == \"number\"\n  and (markerIDs[1] == playerID or markerIDs[2] == playerID)",
							name = "自己是陨石点名",
							uuid = "23d077e6-339b-f6da-927b-4a5044c9b3c5",
							version = 3,
						},
					},
				},
				mechanicTime = 427.2,
				name = "[P2] 彗星落点 5",
				timelineIndex = 76,
				uuid = "841572b0-5995-0aa5-94e7-27af1420db74",
				version = 2,
			},
		},
	},
	[77] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal pos = player and player.pos or nil\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer and pos and type(pos.x) == \"number\" and type(pos.z) == \"number\" then\n  drawer:addTimedCircle(6100, pos.x, tonumber(pos.y or 0) or 0, pos.z, 6)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"f4969c05-11d1-ba81-941a-bcc7b24fc49d",
									true,
								},
							},
							endIfUsed = true,
							name = "快照自己第 6 次彗星落点",
							uuid = "8589c1fe-db7e-11a3-ac23-c20d0b40fe97",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p2Sanctity25 or nil\nlocal markerIDs = type(state) == \"table\" and state.markerIDs or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = player and player.id or nil\nreturn type(state) == \"table\"\n  and state.markersReady == true\n  and type(markerIDs) == \"table\"\n  and #markerIDs == 2\n  and type(playerID) == \"number\"\n  and (markerIDs[1] == playerID or markerIDs[2] == playerID)",
							name = "自己是陨石点名",
							uuid = "f4969c05-11d1-ba81-941a-bcc7b24fc49d",
							version = 3,
						},
					},
				},
				mechanicTime = 428.6,
				name = "[P2] 彗星落点 6",
				timelineIndex = 77,
				uuid = "9fc8cc15-efc8-6c7d-9c44-bae2fc256485",
				version = 2,
			},
		},
	},
	[78] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal pos = player and player.pos or nil\nlocal drawer = TensorCore.getStaticDrawer(520093951)\nif drawer and pos and type(pos.x) == \"number\" and type(pos.z) == \"number\" then\n  drawer:addTimedCircle(4700, pos.x, tonumber(pos.y or 0) or 0, pos.z, 6)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"2b6ef453-322f-5439-ab02-180e7dee0526",
									true,
								},
							},
							endIfUsed = true,
							name = "快照自己第 7 次彗星落点",
							uuid = "30a0a5c5-4622-6f48-9da1-40388a4498c3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p2Sanctity25 or nil\nlocal markerIDs = type(state) == \"table\" and state.markerIDs or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = player and player.id or nil\nreturn type(state) == \"table\"\n  and state.markersReady == true\n  and type(markerIDs) == \"table\"\n  and #markerIDs == 2\n  and type(playerID) == \"number\"\n  and (markerIDs[1] == playerID or markerIDs[2] == playerID)",
							name = "自己是陨石点名",
							uuid = "2b6ef453-322f-5439-ab02-180e7dee0526",
							version = 3,
						},
					},
				},
				mechanicTime = 430,
				name = "[P2] 彗星落点 7",
				timelineIndex = 78,
				uuid = "931e2320-b677-b154-9267-912de39a5409",
				version = 2,
			},
		},
	},
	[79] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\" and data.string_dsr.p2Sanctity25 or nil\nlocal player = TensorCore.mGetPlayer()\n\nlocal function norm360(v)\n  v = v % 360\n  if v < 0 then v = v + 360 end\n  return v\nend\n\nlocal function bearing(pos)\n  return norm360(math.deg(math.atan2(pos.x - 100, 100 - pos.z)))\nend\n\nlocal function posAt(deg, radius)\n  local rad = math.rad(deg)\n  return {\n    x = 100 + math.sin(rad) * radius,\n    z = 100 - math.cos(rad) * radius,\n  }\nend\n\nif state and state.firstReady == true and player\n    and type(state.roleByID) == \"table\"\n    and type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  local role = state.roleByID[tonumber(player.id)]\n  local target\n\n  if role and state.isMeteorByRole[role] then\n    local otherRole\n    for _, meteorRole in ipairs(state.meteorRoles or {}) do\n      if meteorRole ~= role then otherRole = meteorRole end\n    end\n    local startBearing = state.firstTowerBearingByRole[role]\n    local endBearing = otherRole and state.firstTowerBearingByRole[otherRole] or nil\n    if type(startBearing) == \"number\" and type(endBearing) == \"number\" then\n      local total = norm360(endBearing - startBearing)\n      local progress = norm360(bearing(player.pos) - startBearing)\n      if progress > total then\n        if progress > total + 60 then\n          progress = 0\n        else\n          progress = total\n        end\n      end\n      local nextProgress = math.min(total, progress + 25)\n      target = posAt(startBearing + nextProgress, 20)\n    end\n  elseif role and type(state.secondTowerByRole) == \"table\" then\n    target = state.secondTowerByRole[role]\n  end\n\n  if target then\n    local targetX = target.x\n    local targetZ = target.z\n    if role and not state.isMeteorByRole[role] then\n      local dx = targetX - 100\n      local dz = targetZ - 100\n      local length = math.sqrt(dx * dx + dz * dz)\n      if length > 0.001 then\n        local scale = 20 / length\n        targetX = 100 + dx * scale\n        targetZ = 100 + dz * scale\n      end\n    end\n    MuAiGuide.FrameDirect(targetX, targetZ, 0.5)\n  end\nend\nself.used = true",
							endIfUsed = true,
							name = "动态指路",
							uuid = "4208868c-68cd-db1b-866f-c5002392f7d1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 431.4,
				name = "[P2] 2.5运陨石跑圈与闲人第二塔预站位",
				timeRange = true,
				timelineIndex = 79,
				timerEndOffset = 0.3,
				timerStartOffset = -9.7,
				uuid = "d5585051-b543-daa5-be9d-6efaaf391254",
				version = 2,
			},
		},
	},
	[80] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nif player and eventArgs.entityID and eventArgs.channelTimeMax and eventArgs.channelTimeMax > 0 then\n  TensorCore.getStaticDrawer(520093951):addTimedArrowOnEnt(eventArgs.channelTimeMax * 1000, eventArgs.entityID, 20, 1, 2, 3, player.id)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"1b085dde-9b2d-e45d-baeb-3773371cc0c1",
									true,
								},
								
								{
									"73c2458a-242c-0164-b32a-2ffcc58b1e7a",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw center knockback",
							uuid = "fb9624b8-8900-9065-b143-acbbcc12c576",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25308,
							name = "Faith Unmoving",
							uuid = "1b085dde-9b2d-e45d-baeb-3773371cc0c1",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local player = TensorCore.mGetPlayer()\nreturn player and TensorCore.getDistance2d(player.pos, { x = 100, y = 0, z = 100 }) <= 7",
							dequeueIfLuaFalse = true,
							name = "Player is in center",
							uuid = "73c2458a-242c-0164-b32a-2ffcc58b1e7a",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 431.8,
				name = "[P2] 中心击退方向",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 9,
				timerStartOffset = -1,
				uuid = "87927837-92fd-cfb5-8cfa-3f6300fd2b3d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7559,
							conditions = 
							{
								
								{
									"accd5623-c991-bff4-8ca2-0e57e518e8b4",
									true,
								},
								
								{
									"b0eac90a-f878-9573-83cb-04bc5270f35d",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							uuid = "cff32c0f-7e28-433e-8095-db24d7ddb671",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7548,
							conditions = 
							{
								
								{
									"accd5623-c991-bff4-8ca2-0e57e518e8b4",
									true,
								},
								
								{
									"b0eac90a-f878-9573-83cb-04bc5270f35d",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							uuid = "52f603d4-c4af-de7a-aa23-98cb647fc6c0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25308,
							name = "Faith Unmoving",
							uuid = "accd5623-c991-bff4-8ca2-0e57e518e8b4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local player = TensorCore.mGetPlayer()\nif not player then\n  return false\nend\nreturn TensorCore.getDistance2d(player.pos, { x = 100, y = 0, z = 100 }) >= 7",
							dequeueIfLuaFalse = true,
							name = "场中外 7m+",
							uuid = "b0eac90a-f878-9573-83cb-04bc5270f35d",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 431.8,
				name = "[P2] 外侧自动防击退",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 8,
				timerStartOffset = -8,
				uuid = "cf6183a5-6ec8-c9f1-9a10-b5c8cd3a8aaa",
				version = 2,
			},
		},
	},
	[81] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = type(data.string_dsr) == \"table\" and data.string_dsr.p2Sanctity25 or nil\nlocal player = TensorCore.mGetPlayer()\nif state and state.firstReady == true and player\n    and type(state.roleByID) == \"table\"\n    and type(state.secondTowerByRole) == \"table\"\n    and type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  local role = state.roleByID[tonumber(player.id)]\n  local target = role and state.secondTowerByRole[role] or nil\n  if target then\n    local dx = target.x - 100\n    local dz = target.z - 100\n    local length = math.sqrt(dx * dx + dz * dz)\n    if length > 0.001 then\n      local scale = 20 / length\n      MuAiGuide.FrameDirect(100 + dx * scale, 100 + dz * scale, 0.5)\n    end\n  end\nend\nself.used = true",
							endIfUsed = true,
							name = "动态指路",
							uuid = "bb4f212f-e7ea-a849-8f06-dbe70f3ce985",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 434.7,
				name = "[P2] 2.5运第二次踩塔动态指路",
				timeRange = true,
				timelineIndex = 81,
				timerStartOffset = -2.9,
				uuid = "53a21b06-edc2-e401-b1f7-3ca8e243d1e8",
				version = 2,
			},
		},
	},
	[82] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"9f97adbb-ed37-c882-806b-6f62555677ac",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3632,
							targetType = "ContentID",
							uuid = "58166c8e-55d9-a95b-8d28-a649c05cbb7e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "9f97adbb-ed37-c882-806b-6f62555677ac",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 439.2,
				name = "[P2] 自动目标：Thordan P2-3",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 82,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "c6d76fcd-0e7b-de09-a9ec-82993cb8f89b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if type(MuAiGuide) == \"table\" and type(MuAiGuide.FrameDirect) == \"function\" then\n  MuAiGuide.FrameDirect(100, 88, 0.5)\nend\nself.used = true",
							endIfUsed = true,
							name = "动态指路",
							uuid = "ad7a801e-2c84-d522-8290-1d657f1b2417",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 439.2,
				name = "[P2] 2.5运踩塔后回A动态指路",
				timeRange = true,
				timelineIndex = 82,
				timerStartOffset = -4.5,
				uuid = "8c1aca85-f34e-87c7-8ccf-038d4d1311cf",
				version = 2,
			},
		},
	},
	[84] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"47c27d5a-c33e-ad2e-a462-b22f3deb8e3f",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "3e8763a6-9c2e-0590-9687-b0a9a7bbb535",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"e88a3e7c-f41d-1984-ba29-aa6c2e477f61",
									true,
								},
								
								{
									"c0d53987-3c5c-e99b-a6f9-129044571f93",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "bdc37a1e-34f6-a621-9c25-9b50dafa45a8",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"117d718e-bb3d-4abe-aa59-293e21cc27f9",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "a2bdd5f3-2bd6-df16-b768-cb91819eab6c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "c0d53987-3c5c-e99b-a6f9-129044571f93",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "47c27d5a-c33e-ad2e-a462-b22f3deb8e3f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "e88a3e7c-f41d-1984-ba29-aa6c2e477f61",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "117d718e-bb3d-4abe-aa59-293e21cc27f9",
							version = 3,
						},
					},
				},
				mechanicTime = 452.7,
				name = "[P2] 近战个人减伤",
				timelineIndex = 84,
				timerOffset = -3,
				uuid = "83537cfc-49e0-8bef-bf94-00c7192f7c82",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							conditions = 
							{
								
								{
									"66b6fe09-6830-1530-bd6c-f99cc26fdf10",
									true,
								},
								
								{
									"566a8eec-df62-a094-b1ac-262fc901e4bf",
									true,
								},
							},
							endIfUsed = true,
							name = "牵制",
							targetType = "Current Target",
							uuid = "2b1b2f36-2c08-576c-88a1-d0ada6fb9853",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Feint check",
							uuid = "566a8eec-df62-a094-b1ac-262fc901e4bf",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
								22,
								30,
								34,
								39,
								41,
							},
							name = "牵制职业",
							uuid = "66b6fe09-6830-1530-bd6c-f99cc26fdf10",
							version = 3,
						},
					},
				},
				mechanicTime = 452.7,
				name = "[P2] 牵制",
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = -2,
				timerStartOffset = -9.5,
				uuid = "47fbb7eb-d233-4f36-a0f2-397df9edfa52",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7560,
							conditions = 
							{
								
								{
									"c4905970-0fd7-8ded-a377-f0b15e2f3fad",
									true,
								},
								
								{
									"1c1636b2-c7fe-7aa5-8d3f-e802fb72c694",
									true,
								},
							},
							endIfUsed = true,
							name = "昏乱",
							targetType = "Current Target",
							uuid = "00317b3c-7627-b4e2-9bf6-f7df84b3b0d0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1203,
							name = "Addle check",
							uuid = "1c1636b2-c7fe-7aa5-8d3f-e802fb72c694",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
								27,
								35,
								42,
							},
							name = "昏乱职业",
							uuid = "c4905970-0fd7-8ded-a377-f0b15e2f3fad",
							version = 3,
						},
					},
				},
				mechanicTime = 452.7,
				name = "[P2] 昏乱",
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = -2,
				timerStartOffset = -9.5,
				uuid = "f1772d0c-f6ef-2d8e-821f-12d02c965c0b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2887,
							conditions = 
							{
								
								{
									"288ad48e-d0bb-ca57-b393-193d2252c456",
									true,
								},
								
								{
									"25fbac89-92aa-0763-9c07-b9c31034dd68",
									true,
								},
							},
							endIfUsed = true,
							name = "武装解除",
							targetType = "Current Target",
							uuid = "46d52346-ab69-9e6c-ac76-2b6ec112a3bb",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 860,
							name = "Dismantle check",
							uuid = "25fbac89-92aa-0763-9c07-b9c31034dd68",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								31,
							},
							name = "武装解除职业",
							uuid = "288ad48e-d0bb-ca57-b393-193d2252c456",
							version = 3,
						},
					},
				},
				mechanicTime = 452.7,
				name = "[P2] 武装解除",
				randomTimeout = 8,
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "353f595d-b53a-5cdb-86e6-f963d5578ca2",
				version = 2,
			},
		},
	},
	[86] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local spellID = eventArgs.spellID\nlocal drawer = TensorCore.getMoogleDrawer()\n\nif drawer and (spellID == 25536 or spellID == 25537) then\n  local turn = spellID == 25536 and (-math.pi / 3) or (math.pi / 3)\n  local fullAngle = 2 * math.pi / 3\n  local firstHitDelay = (eventArgs.channelTimeMax + 0.8) * 1000\n  local nextHitLead = 1000\n  local casterID = eventArgs.entityID\n\n  drawer:addTimedConeOnEnt(firstHitDelay, casterID, 40, fullAngle, nil, 0, nil, false, turn, false)\n  drawer:addTimedConeOnEnt(2000, casterID, 40, fullAngle, nil, firstHitDelay - nextHitLead, nil, false, -turn, false)\n  drawer:addTimedConeOnEnt(2000, casterID, 40, fullAngle, nil, firstHitDelay, nil, false, math.pi, false)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"82cd40dc-c3bc-cd15-8c9d-735926727c3b",
									true,
								},
							},
							name = "逐刀绘制三次 120°",
							uuid = "ef184e0b-b027-75bf-8c78-22ad350ecd8c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "奋力一挥 25536/25537",
							spellIDList = 
							{
								25536,
								25537,
							},
							uuid = "82cd40dc-c3bc-cd15-8c9d-735926727c3b",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 465.3,
				name = "[P2] 奋力一挥 1 - 三连 120°",
				timeRange = true,
				timelineIndex = 86,
				timerEndOffset = -2.4000000953674,
				timerStartOffset = -4,
				uuid = "bb0b75b4-c74a-6313-83f3-ce38b9e29635",
				version = 2,
			},
		},
	},
	[90] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local spellID = eventArgs.spellID\nlocal drawer = TensorCore.getMoogleDrawer()\n\nif drawer and (spellID == 25536 or spellID == 25537) then\n  local turn = spellID == 25536 and (-math.pi / 3) or (math.pi / 3)\n  local fullAngle = 2 * math.pi / 3\n  local firstHitDelay = (eventArgs.channelTimeMax + 0.8) * 1000\n  local nextHitLead = 1000\n  local casterID = eventArgs.entityID\n\n  drawer:addTimedConeOnEnt(firstHitDelay, casterID, 40, fullAngle, nil, 0, nil, false, turn, false)\n  drawer:addTimedConeOnEnt(2000, casterID, 40, fullAngle, nil, firstHitDelay - nextHitLead, nil, false, -turn, false)\n  drawer:addTimedConeOnEnt(2000, casterID, 40, fullAngle, nil, firstHitDelay, nil, false, math.pi, false)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"851e88ab-0244-99de-b182-ac90a356835a",
									true,
								},
							},
							name = "逐刀绘制三次 120°",
							uuid = "b5084d2e-44d1-78a0-9977-d2a981f32069",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "奋力一挥 25536/25537",
							spellIDList = 
							{
								25536,
								25537,
							},
							uuid = "851e88ab-0244-99de-b182-ac90a356835a",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 473.8,
				name = "[P2] 奋力一挥 2 - 三连 120°",
				timeRange = true,
				timelineIndex = 90,
				timerEndOffset = -2.4,
				timerStartOffset = -3.6,
				uuid = "c761f8ae-873d-6ccf-8bc7-432ae806260b",
				version = 2,
			},
		},
	},
	[97] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\ndata.string_dsr = data.string_dsr or {}\ndata.string_dsr.eyePos = nil\ndata.string_dsr.cometCount = nil\ndata.string_dsr.cometsArmed = nil\ndata.string_dsr.drawnExaflares = nil\ndata.string_dsr.p3WheelFirstSpellID = nil\ndata.string_dsr.p3WheelSecondSpellID = nil\ndata.string_dsr.p3WheelEntityID = nil\nself.used = true",
							endIfUsed = true,
							name = "Unlock face and reset phase state",
							uuid = "e82519d8-0525-fb60-ae16-9561f8b7f193",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 602.3,
				name = "[P3] 换相清理",
				timeRange = true,
				timelineIndex = 97,
				timerEndOffset = 0.5,
				timerStartOffset = -0.5,
				uuid = "4c26c561-d4f9-e307-afa5-906d2a76fd5e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"017ada43-afc0-8397-b13b-f360cc5badb3",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3458,
							targetType = "ContentID",
							uuid = "c75052da-d1bc-6c03-8203-cc416784f9d8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "017ada43-afc0-8397-b13b-f360cc5badb3",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 602.3,
				name = "[P3] 自动目标：Nidhogg P3",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 97,
				timerEndOffset = 10,
				timerStartOffset = -2,
				uuid = "8f4d1ff7-d792-a057-8e31-4048584d7cfd",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2241,
							conditions = 
							{
								
								{
									"6b793fa6-dc8e-baa3-b235-9937d53d3e69",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "残影",
							uuid = "af4d9beb-9b76-7e51-aeb2-23527c199b22",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								30,
							},
							name = "残影职业",
							uuid = "6b793fa6-dc8e-baa3-b235-9937d53d3e69",
							version = 3,
						},
					},
				},
				mechanicTime = 602.3,
				name = "[P3] 残影",
				timelineIndex = 97,
				timerOffset = -8,
				uuid = "7f2151b9-110f-472f-ba1e-890310ede02e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"92a308ca-869c-cfab-b481-e854e378f83a",
									true,
								},
								
								{
									"b724da2f-a9ac-4b40-a889-e7955f0e6184",
									true,
								},
							},
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "c5d02e8b-7d5d-c3c6-80af-abc4c213987e",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "92a308ca-869c-cfab-b481-e854e378f83a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 6,
							buffIDList = 
							{
								1826,
								1951,
								1934,
							},
							category = "Self",
							name = "Missing Buffs",
							uuid = "b724da2f-a9ac-4b40-a889-e7955f0e6184",
							version = 3,
						},
					},
				},
				mechanicTime = 602.3,
				name = "[P3] 远敏团队减伤 1",
				timeRange = true,
				timelineIndex = 97,
				timerEndOffset = -1.5,
				timerStartOffset = -15,
				uuid = "3ac03dcd-f5b2-809b-aa50-227824ce8b40",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"b3bb6b47-6d5a-7432-b03c-d1630a470156",
									true,
								},
								
								{
									"52513bdc-e73e-5380-940f-e555b7f0f09f",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "d365a6a9-0691-df2c-9bec-b08038d971b9",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "b3bb6b47-6d5a-7432-b03c-d1630a470156",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 6,
							buffIDList = 
							{
								1826,
								1951,
								1934,
							},
							category = "Self",
							name = "Missing Buffs",
							uuid = "52513bdc-e73e-5380-940f-e555b7f0f09f",
							version = 3,
						},
					},
				},
				mechanicTime = 602.3,
				name = "[P3] 远敏团队减伤 2",
				timelineIndex = 97,
				uuid = "440ac5d8-9fcf-5ec4-990f-c3bfda719af3",
				version = 2,
			},
		},
	},
	[98] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"0b601406-86a9-33b0-a9a5-7fe9f667bd69",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "心眼",
							uuid = "cc005328-2f62-d01e-abf5-3c5a63805e30",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"18d35cf0-a075-0707-9969-e318ea97e613",
									true,
								},
								
								{
									"01c4ce0c-6d00-305b-8713-4c559e750578",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "金刚极意",
							uuid = "0208e15c-5aa9-2966-8de1-c92e7e772822",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"6559e6a4-7b72-964c-a306-b6fec9ff9dfa",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "神秘纹",
							uuid = "cfb73711-9efd-26c8-904b-064e19203766",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "01c4ce0c-6d00-305b-8713-4c559e750578",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "0b601406-86a9-33b0-a9a5-7fe9f667bd69",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "18d35cf0-a075-0707-9969-e318ea97e613",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "6559e6a4-7b72-964c-a306-b6fec9ff9dfa",
							version = 3,
						},
					},
				},
				mechanicTime = 602.3,
				name = "[P3] 近战个人减伤",
				timelineIndex = 98,
				timerOffset = -3,
				uuid = "ee963924-8502-440c-ab52-f8dc2e0bd958",
				version = 2,
			},
		},
	},
	[99] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nif eventArgs.markerID == 319 then data.string_dsr.towerMarker = 1\nelseif eventArgs.markerID == 320 then data.string_dsr.towerMarker = 2\nelseif eventArgs.markerID == 321 then data.string_dsr.towerMarker = 3 end\nself.used = true",
							conditions = 
							{
								
								{
									"4a8f66a9-540f-2f15-b24f-729ff9405a68",
									true,
								},
								
								{
									"420846f5-0fa4-7079-a318-3de6fe1c4578",
									true,
								},
							},
							endIfUsed = true,
							name = "Store tower number",
							uuid = "8e1467f9-5656-a9c0-986d-d77b99cd58dd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return eventArgs.markerID == 319 or eventArgs.markerID == 320 or eventArgs.markerID == 321",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							markerIDList = 
							{
								319,
								320,
								321,
							},
							name = "Tower marker",
							uuid = "4a8f66a9-540f-2f15-b24f-729ff9405a68",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionLua = "local player = TensorCore.mGetPlayer()\nreturn player and eventArgs.entityID == player.id",
							conditionType = 10,
							dequeueIfLuaFalse = true,
							name = "Marker is on self",
							partyTargetType = "Event Entity",
							uuid = "420846f5-0fa4-7079-a318-3de6fe1c4578",
							version = 3,
						},
					},
				},
				eventType = 4,
				mechanicTime = 620.5,
				name = "[P3] 塔轮次标记状态",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "1819cfb3-f88d-ae86-87df-3315475322b1",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nif not player or not player.pos then\n  return\nend\n\nif state.towerSnapshotCollecting ~= true then\n  state.towerSnapshotCollecting = true\n  state.towerSnapshotReady = false\n  state.towerTarget = nil\n  state.towerTargetKind = nil\n  state.towerSlot = nil\n  state.towerGroupIDs = nil\n  state.towerSlots = nil\n  state.towerSnapshotPositions = nil\nend\n\nlocal groupBuffs = { 3004, 3005, 3006 }\nlocal expectedCounts = { 3, 2, 3 }\nlocal group = tonumber(state.towerMarker)\nif group ~= 1 and group ~= 2 and group ~= 3 then\n  group = nil\n  for i = 1, 3 do\n    if TensorCore.hasBuff(player.id, groupBuffs[i]) then\n      group = i\n      break\n    end\n  end\nend\nif not group then\n  return\nend\nstate.towerMarker = group\n\nlocal party = TensorCore.getEntityGroupList(\"Party\") or {}\nlocal partyByID = {}\nlocal liveGroupIDs = {}\nfor _, member in pairs(party) do\n  local entityID = tonumber(member.id) or member.id\n  partyByID[entityID] = member\n  if TensorCore.hasBuff(member.id, groupBuffs[group]) then\n    liveGroupIDs[#liveGroupIDs + 1] = entityID\n  end\nend\nif #liveGroupIDs == expectedCounts[group] then\n  state.towerGroupIDs = liveGroupIDs\nend\n\nlocal members = {}\nfor _, entityID in ipairs(state.towerGroupIDs or {}) do\n  local key = tonumber(entityID) or entityID\n  local member = partyByID[key] or TensorCore.mGetEntity(entityID)\n  if member and member.pos\n      and type(member.pos.x) == \"number\"\n      and type(member.pos.z) == \"number\" then\n    members[#members + 1] = member\n  end\nend\nif #members ~= expectedCounts[group] then\n  return\nend\n\nlocal slots = {}\nif group == 1 then\n  local rearIndex = 1\n  for i = 2, #members do\n    if members[i].pos.z > members[rearIndex].pos.z then\n      rearIndex = i\n    end\n  end\n  local sides = {}\n  for i, member in ipairs(members) do\n    if i ~= rearIndex then\n      sides[#sides + 1] = member\n    end\n  end\n  table.sort(sides, function(a, b)\n    return a.pos.x < b.pos.x\n  end)\n  slots[tonumber(sides[1].id) or sides[1].id] = \"left\"\n  slots[tonumber(members[rearIndex].id) or members[rearIndex].id] = \"rear\"\n  slots[tonumber(sides[2].id) or sides[2].id] = \"right\"\nelse\n  table.sort(members, function(a, b)\n    return a.pos.x < b.pos.x\n  end)\n  slots[tonumber(members[1].id) or members[1].id] = \"left\"\n  if group == 2 then\n    slots[tonumber(members[2].id) or members[2].id] = \"right\"\n  else\n    slots[tonumber(members[2].id) or members[2].id] = \"middle\"\n    slots[tonumber(members[3].id) or members[3].id] = \"right\"\n  end\nend\n\nstate.towerSlots = slots\nstate.towerSnapshotPositions = {}\nfor _, member in ipairs(members) do\n  local entityID = tonumber(member.id) or member.id\n  state.towerSnapshotPositions[entityID] = {\n    x = member.pos.x,\n    y = member.pos.y,\n    z = member.pos.z,\n  }\nend\nlocal playerID = tonumber(player.id) or player.id\nstate.towerSlot = slots[playerID]\nstate.towerSnapshotReady = state.towerSlot ~= nil\n\nlocal directionReady =\n  TensorCore.hasBuff(player.id, 2755) or\n  TensorCore.hasBuff(player.id, 2756) or\n  TensorCore.hasBuff(player.id, 2757)\nif directionReady and state.towerSnapshotReady then\n  state.towerSnapshotCollecting = false\n  self.used = true\nend",
							name = "621秒实时采样塔组位置",
							uuid = "e730ba93-f559-0b18-acdc-f9a429fcf465",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nif not state or not state.towerSnapshotReady or not player then\n  return\nend\n\nlocal towerType = nil\nif TensorCore.hasBuff(player.id, 2755) then\n  towerType = \"circle\"\nelseif TensorCore.hasBuff(player.id, 2756) then\n  towerType = \"forward\"\nelseif TensorCore.hasBuff(player.id, 2757) then\n  towerType = \"backward\"\nend\nif not towerType then\n  return\nend\n\nlocal groupHasFacing = false\nlocal directionCount = 0\nfor _, entityID in ipairs(state.towerGroupIDs or {}) do\n  local hasCircle = TensorCore.hasBuff(entityID, 2755)\n  local hasForward = TensorCore.hasBuff(entityID, 2756)\n  local hasBackward = TensorCore.hasBuff(entityID, 2757)\n  if hasCircle or hasForward or hasBackward then\n    directionCount = directionCount + 1\n  end\n  if hasForward or hasBackward then\n    groupHasFacing = true\n  end\nend\nif directionCount ~= #(state.towerGroupIDs or {}) then\n  return\nend\n\nlocal nidhogg = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3458, subgroup = \"Nearest\" })\nif not nidhogg or not nidhogg.pos then\n  return\nend\n\nlocal arenaX = 100\nlocal arenaZ = 100\nlocal towerRingRadius = 7.5\nlocal outerLeftX = 90.666\nlocal outerRightX = 109.333\nlocal outerZ = 90.666\n\nlocal function targetRing(side)\n  if side == \"left\" then\n    return {\n      x = arenaX - towerRingRadius,\n      y = nidhogg.pos.y,\n      z = arenaZ,\n    }\n  elseif side == \"right\" then\n    return {\n      x = arenaX + towerRingRadius,\n      y = nidhogg.pos.y,\n      z = arenaZ,\n    }\n  elseif side == \"rear\" or side == \"middle\" then\n    return {\n      x = arenaX,\n      y = nidhogg.pos.y,\n      z = arenaZ + towerRingRadius,\n    }\n  end\n  return nil\nend\n\nlocal function targetOuter(side)\n  if side == \"left\" then\n    return { x = outerLeftX, y = nidhogg.pos.y, z = outerZ }\n  elseif side == \"right\" then\n    return { x = outerRightX, y = nidhogg.pos.y, z = outerZ }\n  end\n  return nil\nend\n\nlocal target = nil\nlocal targetKind = nil\nif state.towerMarker == 1 or state.towerMarker == 3 then\n  local side = nil\n  if groupHasFacing then\n    if towerType == \"forward\" then\n      side = \"right\"\n    elseif towerType == \"backward\" then\n      side = \"left\"\n    elseif towerType == \"circle\" then\n      side = state.towerMarker == 1 and \"rear\" or \"middle\"\n    end\n  else\n    side = state.towerSlot\n  end\n  target = targetRing(side)\n  targetKind = target and (\"world-\" .. side .. \"-ring\") or nil\nelseif state.towerMarker == 2 then\n  if towerType == \"forward\" then\n    target = targetOuter(\"right\")\n    targetKind = \"world-right-outer\"\n  elseif towerType == \"backward\" then\n    target = targetOuter(\"left\")\n    targetKind = \"world-left-outer\"\n  elseif not groupHasFacing then\n    target = targetOuter(state.towerSlot)\n    targetKind = target and\n      (\"world-\" .. state.towerSlot .. \"-outer\") or nil\n  end\nend\nif not target then\n  return\nend\n\nstate.towerType = towerType\nstate.towerGroupHasFacing = groupHasFacing\nstate.towerTarget = target\nstate.towerTargetKind = targetKind\nstate.nidhoggID = nidhogg.id\nstate.otherTwo = nil\nif state.towerMarker == 2 then\n  local playerID = tonumber(player.id) or player.id\n  for _, entityID in ipairs(state.towerGroupIDs or {}) do\n    if (tonumber(entityID) or entityID) ~= playerID then\n      state.otherTwo = entityID\n      break\n    end\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"988d2591-715e-6590-8b0b-122ab1944df5",
									true,
								},
							},
							endIfUsed = true,
							name = "等待整组方向并生成塔目标",
							uuid = "b9080b5a-882c-b07d-8709-79d85ec7698d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 5,
							buffIDList = 
							{
								2755,
								2756,
								2757,
							},
							category = "Self",
							conditionLua = "local player = TensorCore.mGetPlayer()\nreturn player and (TensorCore.hasBuff(player.id, 2755) or TensorCore.hasBuff(player.id, 2756) or TensorCore.hasBuff(player.id, 2757))",
							matchAnyBuff = true,
							name = "Wait for tower direction buff",
							uuid = "988d2591-715e-6590-8b0b-122ab1944df5",
							version = 3,
						},
					},
				},
				mechanicTime = 620.5,
				name = "[P3] 塔方向状态",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 10,
				uuid = "95530328-d329-be7b-9f7f-1387cd51bbcb",
				version = 2,
			},
		},
	},
	[100] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local moogle = TensorCore.getMoogleDrawer()\nlocal function raiseOpacity(color)\n  local r, g, b, a = GUI:ColorConvertU32ToFloat4(color)\n  return GUI:ColorConvertFloat4ToU32(r, g, b, math.min(a + 0.15, 1))\nend\nlocal drawer = TensorCore.getCachedDrawer(\n  raiseOpacity(moogle.colorStart),\n  raiseOpacity(moogle.colorMid),\n  raiseOpacity(moogle.colorEnd),\n  GUI:ColorConvertFloat4ToU32(1, 1, 1, 1),\n  moogle.outlineThickness,\n  0,\n  0\n)\ndrawer:setGradient(moogle.gradientDistance, moogle.gradientMinOpacity, moogle.gradientIntensity)\ndrawer:setHeightOffset(moogle.heightOffset)\nif eventArgs.entityID then\n  if eventArgs.spellID == 26386 then\n    drawer:addTimedCircleOnEnt(11266, eventArgs.entityID, 8)\n    drawer:addTimedDonutOnEnt(3000, eventArgs.entityID, 8, 40, 11266)\n  elseif eventArgs.spellID == 26387 then\n    drawer:addTimedDonutOnEnt(11266, eventArgs.entityID, 8, 40)\n    drawer:addTimedCircleOnEnt(3000, eventArgs.entityID, 8, 11266)\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"bf38c79a-0f8e-b2b5-a856-9e4ddd07d418",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw circle and donut sequence",
							uuid = "9051e768-2daf-f2c4-aa4b-883983496c4a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return eventArgs.spellID == 26386 or eventArgs.spellID == 26387",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Gnash and Lash",
							spellIDList = 
							{
								26386,
								26387,
							},
							uuid = "bf38c79a-0f8e-b2b5-a856-9e4ddd07d418",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 630.2,
				name = "[P3] 第一次钢铁月环",
				timeRange = true,
				timelineIndex = 100,
				timerEndOffset = 16,
				timerStartOffset = -10,
				uuid = "feaef6d7-ee8c-a767-ab88-f258fc924100",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal spellID = tonumber(eventArgs.spellID)\nlocal currentTimer = tonumber(TensorReactions_CurrentTimer)\nif (spellID ~= 26386 and spellID ~= 26387) or currentTimer == nil then\n  self.used = true\n  return\nend\n\n-- 两轮连旋的 channel 实战为 622.591 / 643.900；取无事件区间中的 638\n-- 作为轮次边界，回放倒退时不再依赖旧 state 是否为 nil。\nif currentTimer < 638 then\n  state.p3WheelFirstSpellID = spellID\n  state.p3WheelFirstResolved = false\n  state.p3WheelFirstResolvedAt = nil\n  state.p3WheelSecondSpellID = nil\n  state.p3WheelSecondFirstResolved = false\n  state.p3WheelSecondFirstResolvedAt = nil\n  state.p3SecondStackResolvedAt = nil\nelse\n  state.p3WheelSecondSpellID = spellID\n  state.p3WheelSecondFirstResolved = false\n  state.p3WheelSecondFirstResolvedAt = nil\n  state.p3SecondStackResolvedAt = nil\nend\nstate.p3WheelEntityID = eventArgs.entityID\nself.used = true",
							conditions = 
							{
								
								{
									"81a4a6fc-bbb4-2745-817d-ef779f9b0c94",
									true,
								},
							},
							endIfUsed = true,
							name = "记录两轮钢铁月环顺序",
							uuid = "c104f96d-0f87-014c-ab90-e71f4271662c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "仅钢铁月环读条",
							spellIDList = 
							{
								26386,
								26387,
							},
							uuid = "81a4a6fc-bbb4-2745-817d-ef779f9b0c94",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 630.2,
				name = "[P3] 钢铁月环顺序状态",
				timeRange = true,
				timelineIndex = 100,
				timerEndOffset = 22,
				timerStartOffset = -10,
				uuid = "064217a2-41ce-8f6c-905a-431a6b4e3f68",
				version = 2,
			},
		},
	},
	[101] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nlocal state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nif not state or not player or not player.pos then\n  self.used = true\n  return\nend\n\nlocal function validPoint(point)\n  return point\n    and type(point.x) == \"number\"\n    and type(point.z) == \"number\"\nend\n\nlocal function activeWheel(stored)\n  local spellID = tonumber(stored)\n  local entityID = state.p3WheelEntityID or state.nidhoggID\n  local nidhogg = entityID and TensorCore.mGetEntity(entityID) or nil\n  local channelID = nidhogg and nidhogg.castinginfo\n    and tonumber(nidhogg.castinginfo.channelingid) or nil\n  if channelID == 26386 or channelID == 26387 then\n    spellID = channelID\n  end\n  return spellID\nend\n\nlocal function northSafePoint(spellID)\n  if spellID == 26386 then\n    return { x = 100, y = player.pos.y, z = 90 }\n  elseif spellID == 26387 then\n    return { x = 100, y = player.pos.y, z = 93.2 }\n  end\n  return nil\nend\n\nlocal function drawArrowTower()\n  local towerType = state.towerType\n  if towerType ~= \"forward\" and towerType ~= \"backward\" then\n    return\n  end\n  if type(player.pos.h) ~= \"number\" then\n    return\n  end\n  local heading = player.pos.h\n  if towerType == \"backward\" then\n    heading = heading + math.pi\n  end\n  local x, y, z = TensorCore.getPosInDirection(player.pos, heading, 14, true)\n  local drawer = TensorCore.getStaticDrawer(520093951)\n  if drawer and type(drawer.addCircle) == \"function\" then\n    drawer:addCircle(x, y, z, 5)\n  end\nend\n\nlocal marker = tonumber(state.towerMarker)\nlocal base = state.towerTarget\nlocal target = nil\nif marker == 1 then\n  if validPoint(base) then\n    target = base\n  end\n  drawArrowTower()\nelseif marker == 2 or marker == 3 then\n  target = northSafePoint(activeWheel(state.p3WheelFirstSpellID))\nend\n\nif target and type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  MuAiGuide.FrameDirect(target.x, target.z, 0.5)\nend\nself.used = true",
							endIfUsed = true,
							name = "MuAiCore 阶段指路+14m预估落塔范围",
							uuid = "6ef3230d-6759-4c63-b75e-d2bc957bdea7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 630.3,
				name = "[P3] 第1轮塔位",
				timeRange = true,
				timelineIndex = 101,
				timerStartOffset = -9,
				uuid = "6aa8d1c1-e8c0-5a2b-807c-1408d095b1ef",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nlocal target = state and TensorCore.mGetEntity(state.nidhoggID)\nif state and player and target and state.towerMarker == 1 and (state.towerType == \"forward\" or state.towerType == \"backward\") then\n  local heading = TensorCore.getHeadingToTarget(player.pos, target.pos)\n  if state.towerType == \"backward\" then heading = heading + math.pi end\n  TensorCore.API.TensorACR.setLockFaceHeading(heading)\n  TensorCore.API.TensorACR.toggleLockFace(true)\nend\nself.used = true",
							endIfUsed = true,
							name = "Lock tower 1 facing",
							uuid = "c999a129-5724-4c98-8fbf-0c82ede87906",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 630.3,
				name = "[P3] 第1轮塔锁面",
				timeRange = true,
				timelineIndex = 101,
				timerEndOffset = -0.64999997615814,
				timerStartOffset = -1,
				uuid = "1ea388e3-e255-0ab1-b8e2-fd28818d3986",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\nself.used = true",
							endIfUsed = true,
							name = "Unlock facing",
							uuid = "aa3e10f3-4372-c401-9613-3b12334378e3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 630.3,
				name = "[P3] 第1轮塔解锁",
				timeRange = true,
				timelineIndex = 101,
				timerEndOffset = 1.4,
				timerStartOffset = 1,
				uuid = "e793d40e-940a-c5b6-9992-301251636af3",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nif not state or not player or not player.id then\n  return\nend\n\nlocal towerMarker = tonumber(state.towerMarker)\nlocal towerType = state.towerType\nif not towerMarker or not towerType then\n  return\nend\nif towerMarker ~= 1 then\n  self.used = true\n  return\nend\n\nlocal drawer = TensorCore.getStaticDrawer(520093951)\ndrawer:addTimedCircleOnEnt(9000, player.id, 5, 0, false, true)\nif towerType == \"forward\" then\n  drawer:addTimedArrowOnEnt(9000, player.id, 2, 0.25, 0.8, 0.7, nil, 0, false, 0, false)\nelseif towerType == \"backward\" then\n  drawer:addTimedArrowOnEnt(9000, player.id, 2, 0.25, 0.8, 0.7, nil, 0, false, math.pi, false)\nend\nself.used = true",
							endIfUsed = true,
							name = "自身OnEnt塔圈与方向箭头",
							uuid = "ab728086-fa44-20ae-a751-377215d4923a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 630.3,
				name = "[P3] 第1轮自身塔圈与方向预览",
				timeRange = true,
				timelineIndex = 101,
				timerEndOffset = -8,
				timerStartOffset = -9,
				uuid = "dc574553-ef34-5adf-9908-3ad590d21f13",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not eventArgs.entityID then\n  self.used = true\n  return\nend\n\ndata.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nstate.ownTowerEntityID = eventArgs.entityID\nstate.ownTowerRound = 1\n\nTensorCore.getStaticDrawer(520093951):addTimedCircleOnEnt(\n  6700, eventArgs.entityID, 5, 0, false, true)\nself.used = true",
							conditions = 
							{
								
								{
									"2fcbe152-e4b2-5305-9cbf-265ecccbdd6c",
									true,
								},
								
								{
									"d5866f6e-87ec-e3e5-8a03-82b1a46da421",
									true,
								},
							},
							endIfUsed = true,
							name = "落塔后将5m圈绑定实际塔实体",
							uuid = "a6a51d5b-23e4-948f-873d-4877b1265140",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "堕天龙炎冲三种跳跃",
							spellIDList = 
							{
								26382,
								26383,
								26384,
							},
							uuid = "2fcbe152-e4b2-5305-9cbf-265ecccbdd6c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 10,
							dequeueIfLuaFalse = true,
							name = "Event target is self",
							partyTargetType = "Event Target",
							uuid = "d5866f6e-87ec-e3e5-8a03-82b1a46da421",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 630.3,
				name = "[P3] 第1轮落塔后接管自身塔圈",
				timeRange = true,
				timelineIndex = 101,
				timerEndOffset = 1,
				timerStartOffset = -0.5,
				uuid = "9617a8c2-c08d-b269-9c2b-0c5b283e8c0c",
				version = 2,
			},
		},
	},
	[102] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"ae65e37a-ca39-2007-b6f8-52f24ec09b21",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "7f7e9deb-3626-8921-bd78-4420a074142f",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"5b991bda-281f-6f6b-8832-24df303bd15c",
									true,
								},
								
								{
									"73cacd19-f852-e129-9fbe-9eb2f17d62d8",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "26f40eb9-7a62-2665-8b4e-2bff1370a6a0",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"ae4ca906-1292-26da-a6be-c2715a421a1b",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "6f9c343f-7687-221f-ab8a-ee65dc4be207",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "73cacd19-f852-e129-9fbe-9eb2f17d62d8",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "ae65e37a-ca39-2007-b6f8-52f24ec09b21",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "5b991bda-281f-6f6b-8832-24df303bd15c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "ae4ca906-1292-26da-a6be-c2715a421a1b",
							version = 3,
						},
					},
				},
				mechanicTime = 630.4,
				name = "[P3] 近战个人减伤",
				timelineIndex = 102,
				timerOffset = -3,
				uuid = "174e9ddc-5228-6c34-a96d-2d16c514fed7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nlocal state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nif not state or not player or not player.pos then\n  self.used = true\n  return\nend\n\nlocal towerRingRadius = 7.5\n\nlocal function sendGuide(target)\n  if target and type(MuAiGuide) == \"table\"\n      and type(MuAiGuide.FrameDirect) == \"function\" then\n    MuAiGuide.FrameDirect(target.x, target.z, 0.5)\n  end\nend\n\nlocal function projectRadius(base, radius)\n  local dx = base.x - 100\n  local dz = base.z - 100\n  local length = math.sqrt(dx * dx + dz * dz)\n  if length < 0.001 then\n    return base\n  end\n  return {\n    x = 100 + dx / length * radius,\n    y = base.y,\n    z = 100 + dz / length * radius,\n  }\nend\n\nlocal function activeWheel(stored)\n  local spellID = tonumber(stored)\n  local entityID = state.p3WheelEntityID or state.nidhoggID\n  local nidhogg = entityID and TensorCore.mGetEntity(entityID) or nil\n  local channelID = nidhogg and nidhogg.castinginfo\n    and tonumber(nidhogg.castinginfo.channelingid) or nil\n  if channelID == 26386 or channelID == 26387 then\n    spellID = channelID\n  end\n  return spellID\nend\n\nlocal marker = tonumber(state.towerMarker)\nlocal firstSpellID = activeWheel(state.p3WheelFirstSpellID)\nlocal target = nil\nif marker == 3 then\n  local base = state.towerTarget\n  if base and type(base.x) == \"number\" and type(base.z) == \"number\" then\n    if firstSpellID == 26386 then\n      target = projectRadius(base, 10)\n    elseif firstSpellID == 26387 then\n      target = projectRadius(base, towerRingRadius)\n    end\n  end\nelseif marker == 1 or marker == 2 then\n  if firstSpellID == 26386 then\n    target = { x = 100, y = player.pos.y, z = 90 }\n  elseif firstSpellID == 26387 then\n    target = { x = 100, y = player.pos.y, z = 93.2 }\n  end\nend\n\nsendGuide(target)\nself.used = true",
							endIfUsed = true,
							name = "MuAiCore 第1轮踩塔安全区",
							uuid = "e3364617-2405-3787-8046-ee43cf3418be",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 630.4,
				name = "[P3] 第1轮踩塔·钢铁月环前半",
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 3.4,
				uuid = "0380dbe4-1463-00c9-bf9f-e8f83f987c5e",
				version = 2,
			},
		},
	},
	[103] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nlocal state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nif not state or not player or not player.pos then\n  self.used = true\n  return\nend\n\nlocal towerRingRadius = 7.5\n\nlocal function sendGuide(target)\n  if target and type(MuAiGuide) == \"table\"\n      and type(MuAiGuide.FrameDirect) == \"function\" then\n    MuAiGuide.FrameDirect(target.x, target.z, 0.5)\n  end\nend\n\nlocal function projectRadius(base, radius)\n  local dx = base.x - 100\n  local dz = base.z - 100\n  local length = math.sqrt(dx * dx + dz * dz)\n  if length < 0.001 then\n    return base\n  end\n  return {\n    x = 100 + dx / length * radius,\n    y = base.y,\n    z = 100 + dz / length * radius,\n  }\nend\n\nlocal function activeWheel(stored)\n  local spellID = tonumber(stored)\n  local entityID = state.p3WheelEntityID or state.nidhoggID\n  local nidhogg = entityID and TensorCore.mGetEntity(entityID) or nil\n  local channelID = nidhogg and nidhogg.castinginfo\n    and tonumber(nidhogg.castinginfo.channelingid) or nil\n  if channelID == 26386 or channelID == 26387 then\n    spellID = channelID\n  end\n  return spellID\nend\n\nlocal currentTimer = tonumber(TensorReactions_CurrentTimer)\nlocal resolvedAt = tonumber(state.p3WheelFirstResolvedAt)\nlocal firstResolved = currentTimer ~= nil\n  and resolvedAt ~= nil\n  and currentTimer >= resolvedAt\nlocal marker = tonumber(state.towerMarker)\nlocal firstSpellID = activeWheel(state.p3WheelFirstSpellID)\nlocal target = nil\nif marker == 3 then\n  local base = state.towerTarget\n  if base and type(base.x) == \"number\" and type(base.z) == \"number\" then\n    if firstSpellID == 26386 then\n      target = projectRadius(base, firstResolved and towerRingRadius or 10)\n    elseif firstSpellID == 26387 then\n      target = projectRadius(base, firstResolved and 10 or towerRingRadius)\n    end\n  end\nelseif marker == 1 or marker == 2 then\n  if firstSpellID == 26386 then\n    target = {\n      x = 100,\n      y = player.pos.y,\n      z = firstResolved and 93.2 or 90,\n    }\n  elseif firstSpellID == 26387 then\n    target = {\n      x = 100,\n      y = player.pos.y,\n      z = firstResolved and 90 or 93.2,\n    }\n  end\nend\n\nsendGuide(target)\nself.used = true",
							endIfUsed = true,
							name = "MuAiCore 第1轮踩塔安全区切换",
							uuid = "3b3ef3e5-b92d-440c-bc41-60dc20f3e767",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 633.8,
				name = "[P3] 第1轮踩塔·钢铁月环后半",
				timeRange = true,
				timelineIndex = 103,
				timerEndOffset = 3,
				uuid = "b06bf78e-bea7-546a-9cab-419e1c7bc37f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nstate.p3WheelFirstResolved = true\nstate.p3WheelFirstResolvedAt = tonumber(TensorReactions_CurrentTimer)\nself.used = true",
							conditions = 
							{
								
								{
									"ba32144c-0f98-9f6b-b2d7-5225fab4b95e",
									true,
								},
							},
							endIfUsed = true,
							name = "记录首次钢铁月环已判定",
							uuid = "04dd40d2-2f08-21e3-95d3-d346f0904568",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "首次钢铁或月环判定",
							spellIDList = 
							{
								26389,
								26390,
							},
							uuid = "ba32144c-0f98-9f6b-b2d7-5225fab4b95e",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 633.8,
				name = "[P3] 第一轮钢铁月环首次判定状态",
				timeRange = true,
				timelineIndex = 103,
				timerEndOffset = 1.5,
				timerStartOffset = -1,
				uuid = "d0815d53-3576-8cb0-849a-f8d1a39d23f3",
				version = 2,
			},
		},
	},
	[106] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nlocal state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nif not state or not player or not player.pos then\n  self.used = true\n  return\nend\n\nlocal towerRingRadius = 7.5\n\nlocal function validPoint(point)\n  return point\n    and type(point.x) == \"number\"\n    and type(point.z) == \"number\"\nend\n\nlocal function projectRadius(base, radius)\n  local dx = base.x - 100\n  local dz = base.z - 100\n  local length = math.sqrt(dx * dx + dz * dz)\n  if length < 0.001 then\n    return base\n  end\n  return {\n    x = 100 + dx / length * radius,\n    y = base.y,\n    z = 100 + dz / length * radius,\n  }\nend\n\nlocal function activeWheel(stored)\n  local spellID = tonumber(stored)\n  local entityID = state.p3WheelEntityID or state.nidhoggID\n  local nidhogg = entityID and TensorCore.mGetEntity(entityID) or nil\n  local channelID = nidhogg and nidhogg.castinginfo\n    and tonumber(nidhogg.castinginfo.channelingid) or nil\n  if channelID == 26386 or channelID == 26387 then\n    spellID = channelID\n  end\n  return spellID\nend\n\nlocal function secondHalfNorthPoint(firstSpellID)\n  if firstSpellID == 26386 then\n    return { x = 100, y = player.pos.y, z = 93.2 }\n  elseif firstSpellID == 26387 then\n    return { x = 100, y = player.pos.y, z = 90 }\n  end\n  return nil\nend\n\nlocal function drawArrowTower()\n  local towerType = state.towerType\n  if towerType ~= \"forward\" and towerType ~= \"backward\" then\n    return\n  end\n  if type(player.pos.h) ~= \"number\" then\n    return\n  end\n  local heading = player.pos.h\n  if towerType == \"backward\" then\n    heading = heading + math.pi\n  end\n  local x, y, z = TensorCore.getPosInDirection(player.pos, heading, 14, true)\n  local drawer = TensorCore.getStaticDrawer(520093951)\n  if drawer and type(drawer.addCircle) == \"function\" then\n    drawer:addCircle(x, y, z, 5)\n  end\nend\n\nlocal marker = tonumber(state.towerMarker)\nlocal base = state.towerTarget\nlocal firstSpellID = activeWheel(state.p3WheelFirstSpellID)\nlocal target = nil\nif marker == 1 then\n  target = secondHalfNorthPoint(firstSpellID)\nelseif marker == 2 then\n  if validPoint(base) then\n    target = base\n  end\n  drawArrowTower()\nelseif marker == 3 and validPoint(base) then\n  if firstSpellID == 26386 then\n    target = projectRadius(base, towerRingRadius)\n  elseif firstSpellID == 26387 then\n    target = projectRadius(base, 10)\n  end\nend\n\nif target and type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  MuAiGuide.FrameDirect(target.x, target.z, 0.5)\nend\nself.used = true",
							endIfUsed = true,
							name = "MuAiCore 阶段指路+14m预估落塔范围",
							uuid = "b7f6e75c-6f6c-75e5-b92d-865136834bf3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 640.2,
				name = "[P3] 第2轮塔位",
				timeRange = true,
				timelineIndex = 106,
				timerStartOffset = -3.4,
				uuid = "f0f82f7d-037c-2e34-aba7-668cec71692a",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nlocal target = state and TensorCore.mGetEntity(state.otherTwo)\nif state and player and target and state.towerMarker == 2 and (state.towerType == \"forward\" or state.towerType == \"backward\") then\n  local heading = TensorCore.getHeadingToTarget(player.pos, target.pos)\n  if state.towerType == \"backward\" then heading = heading + math.pi end\n  TensorCore.API.TensorACR.setLockFaceHeading(heading)\n  TensorCore.API.TensorACR.toggleLockFace(true)\nend\nself.used = true",
							endIfUsed = true,
							name = "Lock tower 2 facing",
							uuid = "8ba844da-df0b-acac-81e8-220bbadc5221",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 640.2,
				name = "[P3] 第2轮塔锁面",
				timeRange = true,
				timelineIndex = 106,
				timerEndOffset = -0.25,
				timerStartOffset = -0.6,
				uuid = "61ec1967-a65c-09d9-83c9-035ae1a5e930",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\nself.used = true",
							endIfUsed = true,
							name = "Unlock facing",
							uuid = "491f73ee-ea1a-5b7f-a29e-89077dc04a9a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 640.2,
				name = "[P3] 第2轮塔解锁",
				timeRange = true,
				timelineIndex = 106,
				timerEndOffset = 1.4,
				timerStartOffset = 1,
				uuid = "e4bf0741-d33b-cc71-8efc-57be46a5c4c1",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nlocal state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nif not state or not player or not player.pos then\n  self.used = true\n  return\nend\n\nlocal function sendGuide(target)\n  if target and type(MuAiGuide) == \"table\"\n      and type(MuAiGuide.FrameDirect) == \"function\" then\n    MuAiGuide.FrameDirect(target.x, target.z, 0.5)\n  end\nend\n\nlocal function projectRadius(base, radius)\n  local dx = base.x - 100\n  local dz = base.z - 100\n  local length = math.sqrt(dx * dx + dz * dz)\n  if length < 0.001 then\n    return base\n  end\n  return {\n    x = 100 + dx / length * radius,\n    y = base.y,\n    z = 100 + dz / length * radius,\n  }\nend\n\nlocal function activeWheel(state, stored)\n  local spellID = tonumber(stored)\n  local nidhogg = state.nidhoggID and TensorCore.mGetEntity(state.nidhoggID) or nil\n  local channelID = nidhogg and nidhogg.castinginfo\n    and tonumber(nidhogg.castinginfo.channelingid) or nil\n  if channelID == 26386 or channelID == 26387 then\n    spellID = channelID\n  end\n  return spellID\nend\n\nlocal function northSafePoint(spellID, y)\n  if spellID == 26386 then\n    return { x = 100, y = y, z = 90 }\n  elseif spellID == 26387 then\n    return { x = 100, y = y, z = 93.2 }\n  end\n  return nil\nend\n\nlocal towerType = state.towerType\nif towerType ~= \"circle\"\n    and towerType ~= \"forward\"\n    and towerType ~= \"backward\" then\n  if TensorCore.hasBuff(player.id, 2755) then\n    towerType = \"circle\"\n  elseif TensorCore.hasBuff(player.id, 2756) then\n    towerType = \"forward\"\n  elseif TensorCore.hasBuff(player.id, 2757) then\n    towerType = \"backward\"\n  end\nend\n\nlocal marker = tonumber(state.towerMarker)\nlocal spellID = activeWheel(state, state.p3WheelSecondSpellID)\nlocal target = nil\nif marker == 1 then\n  local side = nil\n  if state.towerGroupHasFacing == true then\n    if towerType == \"forward\" then\n      side = \"right\"\n    elseif towerType == \"backward\" then\n      side = \"left\"\n    end\n  elseif state.towerGroupHasFacing == false then\n    if state.towerSlot == \"left\" or state.towerSlot == \"right\" then\n      side = state.towerSlot\n    end\n  end\n\n  if side then\n    local x = side == \"left\" and 90.666 or 109.333\n    local base = { x = x, y = player.pos.y, z = 90.666 }\n    if spellID == 26387 then\n      target = projectRadius(base, 7.5)\n    else\n      target = base\n    end\n  elseif state.towerGroupHasFacing ~= nil then\n    target = northSafePoint(spellID, player.pos.y)\n  end\nelseif marker == 2 then\n  target = northSafePoint(spellID, player.pos.y)\nend\n\nsendGuide(target)\nself.used = true",
							endIfUsed = true,
							name = "MuAiCore 第2轮左右踩塔安全区",
							uuid = "914b7ae6-cb09-a1e0-820b-16b54f2866dc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 640.2,
				name = "[P3] 第2轮左右踩塔",
				timeRange = true,
				timelineIndex = 106,
				timerEndOffset = 6.6,
				uuid = "a931b209-852a-7d68-8921-a62a99f18ba7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nif not state or not player or not player.id then\n  return\nend\n\nlocal towerMarker = tonumber(state.towerMarker)\nlocal towerType = state.towerType\nif not towerMarker or not towerType then\n  return\nend\nif towerMarker ~= 2 then\n  self.used = true\n  return\nend\n\nlocal drawer = TensorCore.getStaticDrawer(520093951)\ndrawer:addTimedCircleOnEnt(3400, player.id, 5, 0, false, true)\nif towerType == \"forward\" then\n  drawer:addTimedArrowOnEnt(3400, player.id, 2, 0.25, 0.8, 0.7, nil, 0, false, 0, false)\nelseif towerType == \"backward\" then\n  drawer:addTimedArrowOnEnt(3400, player.id, 2, 0.25, 0.8, 0.7, nil, 0, false, math.pi, false)\nend\nself.used = true",
							endIfUsed = true,
							name = "自身OnEnt塔圈与方向箭头",
							uuid = "8799da2a-1b0f-0267-ba0a-77addc2538b9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 640.2,
				name = "[P3] 第2轮自身塔圈与方向预览",
				timeRange = true,
				timelineIndex = 106,
				timerEndOffset = -2.9,
				timerStartOffset = -3.4,
				uuid = "2da04880-6334-af32-922e-21eff75d71be",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not eventArgs.entityID then\n  self.used = true\n  return\nend\n\ndata.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nstate.ownTowerEntityID = eventArgs.entityID\nstate.ownTowerRound = 2\n\nTensorCore.getStaticDrawer(520093951):addTimedCircleOnEnt(\n  6700, eventArgs.entityID, 5, 0, false, true)\nself.used = true",
							conditions = 
							{
								
								{
									"a9d00a06-e4a7-1722-b0c0-96052247197d",
									true,
								},
								
								{
									"4fd72085-0627-0455-8022-c9e7376dee5c",
									true,
								},
							},
							endIfUsed = true,
							name = "落塔后将5m圈绑定实际塔实体",
							uuid = "711b6281-d456-57ff-92f9-1be351e6f4f0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "堕天龙炎冲三种跳跃",
							spellIDList = 
							{
								26382,
								26383,
								26384,
							},
							uuid = "a9d00a06-e4a7-1722-b0c0-96052247197d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 10,
							dequeueIfLuaFalse = true,
							name = "Event target is self",
							partyTargetType = "Event Target",
							uuid = "4fd72085-0627-0455-8022-c9e7376dee5c",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 640.2,
				name = "[P3] 第2轮落塔后接管自身塔圈",
				timeRange = true,
				timelineIndex = 106,
				timerEndOffset = 1,
				timerStartOffset = -0.5,
				uuid = "408ff386-a12f-67dd-9e54-ddbba17c3a3a",
				version = 2,
			},
		},
	},
	[108] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nif not state then\n  self.used = true\n  return\nend\n\nlocal marker = tonumber(state.towerMarker)\nlocal waitsForThird = false\nif marker == 1 then\n  if state.towerGroupHasFacing == true then\n    waitsForThird = state.towerType == \"circle\"\n  elseif state.towerGroupHasFacing == false then\n    waitsForThird = state.towerSlot == \"rear\"\n  end\nend\n\nlocal function activeWheel(stored)\n  local spellID = tonumber(stored)\n  local entityID = state.p3WheelEntityID or state.nidhoggID\n  local nidhogg = entityID and TensorCore.mGetEntity(entityID) or nil\n  local channelID = nidhogg and nidhogg.castinginfo\n    and tonumber(nidhogg.castinginfo.channelingid) or nil\n  if channelID == 26386 or channelID == 26387 then\n    spellID = channelID\n  end\n  return spellID\nend\n\nif waitsForThird\n    and type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  local currentTimer = tonumber(TensorReactions_CurrentTimer)\n  local stackResolvedAt = tonumber(state.p3SecondStackResolvedAt)\n  local firstResolvedAt = tonumber(state.p3WheelSecondFirstResolvedAt)\n  local stackResolved = currentTimer ~= nil\n    and stackResolvedAt ~= nil\n    and currentTimer >= stackResolvedAt\n  local firstResolved = currentTimer ~= nil\n    and firstResolvedAt ~= nil\n    and currentTimer >= firstResolvedAt\n  local spellID = activeWheel(state.p3WheelSecondSpellID)\n  local towerRingRadius = 7.5\n  local steelOuterRadius = 10\n  local targetZ = nil\n\n  if not stackResolved then\n    if spellID == 26386 then\n      targetZ = 100 - steelOuterRadius\n    elseif spellID == 26387 then\n      targetZ = 93.2\n    end\n  elseif spellID == 26386 then\n    if firstResolved then\n      targetZ = 100 + towerRingRadius\n    else\n      targetZ = 100 + steelOuterRadius\n    end\n  elseif spellID == 26387 then\n    targetZ = 100 + towerRingRadius\n  end\n\n  if targetZ ~= nil then\n    MuAiGuide.FrameDirect(100, targetZ, 0.5)\n  end\nend\nself.used = true",
							endIfUsed = true,
							name = "MuAiCore 1麻第二次分摊后去C塔",
							uuid = "6acbb720-2d45-06ba-ac63-fad644369e16",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 646.8,
				name = "[P3] 1麻第二次分摊后去第三轮C塔",
				timeRange = true,
				timelineIndex = 108,
				timerEndOffset = 11,
				uuid = "ac2c935d-c101-4abc-ac4b-33bac4d859a2",
				version = 2,
			},
		},
	},
	[109] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nlocal state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nif not state or not player or not player.pos then\n  self.used = true\n  return\nend\n\nlocal function validPoint(point)\n  return point\n    and type(point.x) == \"number\"\n    and type(point.z) == \"number\"\nend\n\nlocal function activeWheel(stored)\n  local spellID = tonumber(stored)\n  local entityID = state.p3WheelEntityID or state.nidhoggID\n  local nidhogg = entityID and TensorCore.mGetEntity(entityID) or nil\n  local channelID = nidhogg and nidhogg.castinginfo\n    and tonumber(nidhogg.castinginfo.channelingid) or nil\n  if channelID == 26386 or channelID == 26387 then\n    spellID = channelID\n  end\n  return spellID\nend\n\nlocal function northSafePoint(spellID)\n  if spellID == 26386 then\n    return { x = 100, y = player.pos.y, z = 90 }\n  elseif spellID == 26387 then\n    return { x = 100, y = player.pos.y, z = 93.2 }\n  end\n  return nil\nend\n\nlocal function drawArrowTower()\n  local towerType = state.towerType\n  if towerType ~= \"forward\" and towerType ~= \"backward\" then\n    return\n  end\n  if type(player.pos.h) ~= \"number\" then\n    return\n  end\n  local heading = player.pos.h\n  if towerType == \"backward\" then\n    heading = heading + math.pi\n  end\n  local x, y, z = TensorCore.getPosInDirection(player.pos, heading, 14, true)\n  local drawer = TensorCore.getStaticDrawer(520093951)\n  if drawer and type(drawer.addCircle) == \"function\" then\n    drawer:addCircle(x, y, z, 5)\n  end\nend\n\nlocal marker = tonumber(state.towerMarker)\nlocal base = state.towerTarget\nlocal target = nil\nif marker == 2 then\n  target = northSafePoint(activeWheel(state.p3WheelSecondSpellID))\nelseif marker == 3 then\n  if validPoint(base) then\n    target = base\n  end\n  drawArrowTower()\nend\n\nif target and type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  MuAiGuide.FrameDirect(target.x, target.z, 0.5)\nend\nself.used = true",
							endIfUsed = true,
							name = "MuAiCore 阶段指路+14m预估落塔范围",
							uuid = "72dc7845-a61c-efa8-945a-3e8d13edf231",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 651.2,
				name = "[P3] 第3轮塔位",
				timeRange = true,
				timelineIndex = 109,
				timerStartOffset = -11,
				uuid = "ce41350d-cc3b-c973-b178-a29618a1ed6b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nlocal target = state and TensorCore.mGetEntity(state.nidhoggID)\nif state and player and target and state.towerMarker == 3 and (state.towerType == \"forward\" or state.towerType == \"backward\") then\n  local heading = TensorCore.getHeadingToTarget(player.pos, target.pos)\n  if state.towerType == \"backward\" then heading = heading + math.pi end\n  TensorCore.API.TensorACR.setLockFaceHeading(heading)\n  TensorCore.API.TensorACR.toggleLockFace(true)\nend\nself.used = true",
							endIfUsed = true,
							name = "Lock tower 3 facing",
							uuid = "8ab5a04b-d5f9-0642-8b3f-2064cd262bd8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 651.2,
				name = "[P3] 第3轮塔锁面",
				timeRange = true,
				timelineIndex = 109,
				timerEndOffset = -0.65,
				timerStartOffset = -1,
				uuid = "b93eb472-9fad-bc6c-863c-4c40e0e782ba",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\nself.used = true",
							endIfUsed = true,
							name = "Unlock facing",
							uuid = "1edb2f72-f9f0-4e2b-abd8-fd1cdf8baa12",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 651.2,
				name = "[P3] 第3轮塔解锁",
				timeRange = true,
				timelineIndex = 109,
				timerEndOffset = 1.4,
				timerStartOffset = 1,
				uuid = "75c0fa56-40de-2543-83db-7cc9ff481d81",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nif not state or not player or not player.id then\n  return\nend\n\nlocal towerMarker = tonumber(state.towerMarker)\nlocal towerType = state.towerType\nif not towerMarker or not towerType then\n  return\nend\nif towerMarker ~= 3 then\n  self.used = true\n  return\nend\n\nlocal drawer = TensorCore.getStaticDrawer(520093951)\ndrawer:addTimedCircleOnEnt(11000, player.id, 5, 0, false, true)\nif towerType == \"forward\" then\n  drawer:addTimedArrowOnEnt(11000, player.id, 2, 0.25, 0.8, 0.7, nil, 0, false, 0, false)\nelseif towerType == \"backward\" then\n  drawer:addTimedArrowOnEnt(11000, player.id, 2, 0.25, 0.8, 0.7, nil, 0, false, math.pi, false)\nend\nself.used = true",
							endIfUsed = true,
							name = "自身OnEnt塔圈与方向箭头",
							uuid = "320610da-edb2-eae4-84d5-973b8dcbb1bc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 651.2,
				name = "[P3] 第3轮自身塔圈与方向预览",
				timeRange = true,
				timelineIndex = 109,
				timerEndOffset = -10.5,
				timerStartOffset = -11,
				uuid = "bed1228f-5104-58b8-a694-9717310d3bc1",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not eventArgs.entityID then\n  self.used = true\n  return\nend\n\ndata.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nstate.ownTowerEntityID = eventArgs.entityID\nstate.ownTowerRound = 3\n\nTensorCore.getStaticDrawer(520093951):addTimedCircleOnEnt(\n  6700, eventArgs.entityID, 5, 0, false, true)\nself.used = true",
							conditions = 
							{
								
								{
									"ac7eda4d-352c-35f3-93fb-530438e031b0",
									true,
								},
								
								{
									"366920bb-8a3d-4265-9c7c-9fd9544639f3",
									true,
								},
							},
							endIfUsed = true,
							name = "落塔后将5m圈绑定实际塔实体",
							uuid = "c11f0bc3-9206-2163-bc31-61916b9456a4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "堕天龙炎冲三种跳跃",
							spellIDList = 
							{
								26382,
								26383,
								26384,
							},
							uuid = "ac7eda4d-352c-35f3-93fb-530438e031b0",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 10,
							dequeueIfLuaFalse = true,
							name = "Event target is self",
							partyTargetType = "Event Target",
							uuid = "366920bb-8a3d-4265-9c7c-9fd9544639f3",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 651.2,
				name = "[P3] 第3轮落塔后接管自身塔圈",
				timeRange = true,
				timelineIndex = 109,
				timerEndOffset = 1,
				timerStartOffset = -0.5,
				uuid = "70e956a9-aed9-b3a6-b8f8-c7aa6f976e79",
				version = 2,
			},
		},
	},
	[110] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local moogle = TensorCore.getMoogleDrawer()\nlocal function raiseOpacity(color)\n  local r, g, b, a = GUI:ColorConvertU32ToFloat4(color)\n  return GUI:ColorConvertFloat4ToU32(r, g, b, math.min(a + 0.15, 1))\nend\nlocal drawer = TensorCore.getCachedDrawer(\n  raiseOpacity(moogle.colorStart),\n  raiseOpacity(moogle.colorMid),\n  raiseOpacity(moogle.colorEnd),\n  GUI:ColorConvertFloat4ToU32(1, 1, 1, 1),\n  moogle.outlineThickness,\n  0,\n  0\n)\ndrawer:setGradient(moogle.gradientDistance, moogle.gradientMinOpacity, moogle.gradientIntensity)\ndrawer:setHeightOffset(moogle.heightOffset)\nif eventArgs.entityID then\n  if eventArgs.spellID == 26386 then\n    drawer:addTimedCircleOnEnt(11266, eventArgs.entityID, 8)\n    drawer:addTimedDonutOnEnt(3000, eventArgs.entityID, 8, 40, 11266)\n  elseif eventArgs.spellID == 26387 then\n    drawer:addTimedDonutOnEnt(11266, eventArgs.entityID, 8, 40)\n    drawer:addTimedCircleOnEnt(3000, eventArgs.entityID, 8, 11266)\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"cadc8077-6bc3-f7a3-bbc9-2b3b1aeca911",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw circle and donut sequence",
							uuid = "dbc4c436-ee63-2e05-bbd2-0baae10629cf",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return eventArgs.spellID == 26386 or eventArgs.spellID == 26387",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Gnash and Lash",
							spellIDList = 
							{
								26386,
								26387,
							},
							uuid = "cadc8077-6bc3-f7a3-bbc9-2b3b1aeca911",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 651.6,
				name = "[P3] 第二次钢铁月环",
				timeRange = true,
				timelineIndex = 110,
				timerEndOffset = 16,
				timerStartOffset = -10,
				uuid = "ebe457b0-7385-51ef-994b-ffb0ac6f63f8",
				version = 2,
			},
		},
	},
	[111] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"cfcd3597-e041-01ce-96f3-1a9919aea5a7",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "8a0fb7d2-785e-049c-8cbf-f75ae6ae1c00",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"aa3ff72e-41b8-c892-91d7-84e38cd5b912",
									true,
								},
								
								{
									"9a9b89e2-9990-5a1d-819e-b35392d00a0c",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "6174fb72-54d1-f20a-9e10-06edad1e9b8c",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"be0ae42d-a743-06ac-a965-25b3ef97025a",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "698ba51b-4972-98d1-9671-e1989c0e8237",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "9a9b89e2-9990-5a1d-819e-b35392d00a0c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "cfcd3597-e041-01ce-96f3-1a9919aea5a7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "aa3ff72e-41b8-c892-91d7-84e38cd5b912",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "be0ae42d-a743-06ac-a965-25b3ef97025a",
							version = 3,
						},
					},
				},
				mechanicTime = 651.9,
				name = "[P3] 近战个人减伤",
				timelineIndex = 111,
				timerOffset = -3,
				uuid = "864af626-fbf3-c9bd-8569-ebc484b15660",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2887,
							conditions = 
							{
								
								{
									"c4ff87ae-8710-6ff4-8c86-5cc01763382b",
									true,
								},
								
								{
									"bda021bf-b278-fe0a-95aa-833f6787934b",
									true,
								},
							},
							endIfUsed = true,
							name = "武装解除",
							targetType = "Current Target",
							uuid = "59f76eea-a685-1f97-b16c-4e0965a5aee3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 860,
							name = "Dismantle check",
							uuid = "bda021bf-b278-fe0a-95aa-833f6787934b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								31,
							},
							name = "武装解除职业",
							uuid = "c4ff87ae-8710-6ff4-8c86-5cc01763382b",
							version = 3,
						},
					},
				},
				mechanicTime = 651.9,
				name = "[P3] 武装解除",
				randomTimeout = 8,
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 111,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "f6f53a1e-6553-e286-92b0-f5425fc8bac2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							conditions = 
							{
								
								{
									"2258c833-77b6-0bba-85ab-115beae0b99f",
									true,
								},
								
								{
									"cea4338e-c366-0397-aac2-45cdb73fe404",
									true,
								},
							},
							endIfUsed = true,
							name = "牵制",
							targetType = "Current Target",
							uuid = "a5f259bd-1183-eb2e-8e72-bbf76ea36461",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Feint check",
							uuid = "cea4338e-c366-0397-aac2-45cdb73fe404",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
								22,
								30,
								34,
								39,
								41,
							},
							name = "牵制职业",
							uuid = "2258c833-77b6-0bba-85ab-115beae0b99f",
							version = 3,
						},
					},
				},
				mechanicTime = 651.9,
				name = "[P3] 牵制",
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 111,
				timerEndOffset = -6,
				timerStartOffset = -10,
				uuid = "20cf33b4-4ccd-c335-9f8e-84bd223378ca",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7560,
							conditions = 
							{
								
								{
									"7a78ce7a-e8d8-f0e4-a997-5a59da977b89",
									true,
								},
								
								{
									"a3d32c91-d913-fd6e-ba17-aa88e53fe9a9",
									true,
								},
							},
							endIfUsed = true,
							name = "昏乱",
							targetType = "Current Target",
							uuid = "efcba2ef-c4c0-5ddd-aded-452bd9ad1f67",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1203,
							name = "Addle check",
							uuid = "a3d32c91-d913-fd6e-ba17-aa88e53fe9a9",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
								27,
								35,
								42,
							},
							name = "昏乱职业",
							uuid = "7a78ce7a-e8d8-f0e4-a997-5a59da977b89",
							version = 3,
						},
					},
				},
				mechanicTime = 651.9,
				name = "[P3] 昏乱",
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 111,
				timerEndOffset = -6,
				timerStartOffset = -10,
				uuid = "db86c2c8-eac7-7d5a-8957-4b78eaf57344",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\ndata.string_dsr.p3SecondStackResolvedAt = tonumber(TensorReactions_CurrentTimer)\nself.used = true",
							conditions = 
							{
								
								{
									"3d0f45fb-8360-c832-bc4a-f58b9ab7d607",
									true,
								},
							},
							endIfUsed = true,
							name = "记录第二次分摊实际判定时间",
							uuid = "3efaadfd-49a1-5086-9af9-b010cbaea641",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "第二次暴君之瞳判定",
							spellIDList = 
							{
								26388,
							},
							uuid = "3d0f45fb-8360-c832-bc4a-f58b9ab7d607",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 651.9,
				name = "[P3] 第二次暴君之瞳判定状态",
				timeRange = true,
				timelineIndex = 111,
				timerEndOffset = 1.5,
				timerStartOffset = -1,
				uuid = "239a98a9-1549-8b9d-bf5f-bcfdb8aab614",
				version = 2,
			},
		},
	},
	[113] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nstate.p3WheelSecondFirstResolved = true\nstate.p3WheelSecondFirstResolvedAt = tonumber(TensorReactions_CurrentTimer)\nself.used = true",
							conditions = 
							{
								
								{
									"55cab82e-5fbd-538a-aeb8-f108adf63d13",
									true,
								},
							},
							endIfUsed = true,
							name = "记录第二轮首次钢铁月环已判定",
							uuid = "f6c7dd35-c304-775f-9c5e-be88c852a99e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "第二轮首次钢铁或月环判定",
							spellIDList = 
							{
								26389,
								26390,
							},
							uuid = "55cab82e-5fbd-538a-aeb8-f108adf63d13",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 655.3,
				name = "[P3] 第二轮钢铁月环首次判定状态",
				timeRange = true,
				timelineIndex = 113,
				timerEndOffset = 1.5,
				timerStartOffset = -1,
				uuid = "194994da-660d-0552-bd71-123138de1c13",
				version = 2,
			},
		},
	},
	[114] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nif not state or tonumber(state.towerMarker) ~= 1 then\n  self.used = true\n  return\nend\n\nlocal base = state.towerTarget\nif not base or type(base.x) ~= \"number\" or type(base.z) ~= \"number\" then\n  self.used = true\n  return\nend\n\nlocal spellID = tonumber(state.p3WheelSecondSpellID)\nlocal safeRadius = nil\nif spellID == 26386 then\n  safeRadius = 7.5\nelseif spellID == 26387 then\n  safeRadius = 10\nend\n\nlocal radius = safeRadius\nif type(radius) ~= \"number\" then\n  self.used = true\n  return\nend\n\nlocal dx = base.x - 100\nlocal dz = base.z - 100\nlocal length = math.sqrt(dx * dx + dz * dz)\nif length <= 0.001 then\n  self.used = true\n  return\nend\n\nif type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  local targetX = 100 + dx / length * radius\n  local targetZ = 100 + dz / length * radius\n  MuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nend\nself.used = true",
							endIfUsed = true,
							name = "1麻第三塔后按轮盘留内或去外",
							uuid = "b6c284ae-0a60-2dc6-87a2-f9729563d191",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 657.8,
				name = "[P3] 1麻第三塔后轮盘交接",
				timeRange = true,
				timelineIndex = 114,
				timerEndOffset = 0.59,
				uuid = "6ad92856-a30f-e416-b714-51e76cace109",
				version = 2,
			},
		},
	},
	[115] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nif not state or tonumber(state.towerMarker) ~= 1 then\n  self.used = true\n  return\nend\n\nlocal base = state.towerTarget\nif not base or type(base.x) ~= \"number\" or type(base.z) ~= \"number\" then\n  self.used = true\n  return\nend\n\nlocal radius = 10\nif type(radius) ~= \"number\" then\n  self.used = true\n  return\nend\n\nlocal dx = base.x - 100\nlocal dz = base.z - 100\nlocal length = math.sqrt(dx * dx + dz * dz)\nif length <= 0.001 then\n  self.used = true\n  return\nend\n\nif type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  local targetX = 100 + dx / length * radius\n  local targetZ = 100 + dz / length * radius\n  MuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nend\nself.used = true",
							endIfUsed = true,
							name = "1麻沿本人塔方向外出引导",
							uuid = "5df869c0-c75d-6dab-8c40-aeb763ed61bc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 658.4,
				name = "[P3] 1麻第三塔后外侧引导",
				timeRange = true,
				timelineIndex = 115,
				timerEndOffset = 1.89,
				uuid = "4286aa8c-c4bd-e902-88f8-ea82472c186b",
				version = 2,
			},
		},
	},
	[116] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nif not state or tonumber(state.towerMarker) ~= 1 then\n  self.used = true\n  return\nend\n\nlocal base = state.towerTarget\nif not base or type(base.x) ~= \"number\" or type(base.z) ~= \"number\" then\n  self.used = true\n  return\nend\n\nlocal radius = 6\nif type(radius) ~= \"number\" then\n  self.used = true\n  return\nend\n\nlocal dx = base.x - 100\nlocal dz = base.z - 100\nlocal length = math.sqrt(dx * dx + dz * dz)\nif length <= 0.001 then\n  self.used = true\n  return\nend\n\nif type(MuAiGuide) == \"table\"\n    and type(MuAiGuide.FrameDirect) == \"function\" then\n  local targetX = 100 + dx / length * radius\n  local targetZ = 100 + dz / length * radius\n  MuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nend\nself.used = true",
							endIfUsed = true,
							name = "1麻离开分身正面",
							uuid = "ab85d6ac-1b54-ae1e-ad88-86f2fbc7a3fc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 664.9,
				name = "[P3] 1麻第三塔后躲武神枪",
				timeRange = true,
				timelineIndex = 116,
				timerStartOffset = -4.6,
				uuid = "5b19efa4-0169-6f9e-9646-f41b922f0244",
				version = 2,
			},
		},
	},
	[118] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = data.string_dsr\nif type(root) ~= \"table\" then\n  root = {}\n  data.string_dsr = root\nend\n\nlocal aoeID = tonumber(eventArgs.aoeID)\nlocal x = tonumber(eventArgs.x)\nlocal y = tonumber(eventArgs.y)\nlocal z = tonumber(eventArgs.z)\nlocal startTime = tonumber(eventArgs.startTime)\nif not aoeID or not x or not y or not z or not startTime then\n  self.used = true\n  return\nend\n\nlocal dx = x - 100\nlocal dz = z - 100\nif math.abs(dx) < 3 or math.abs(dz) < 3 then\n  self.used = true\n  return\nend\n\nlocal quadrant\nif dx < 0 then\n  quadrant = dz < 0 and \"NW\" or \"SW\"\nelse\n  quadrant = dz < 0 and \"NE\" or \"SE\"\nend\n\nlocal state = root.p3FourTowers\nlocal anchorStartTime = type(state) == \"table\"\n  and tonumber(state.anchorStartTime or state.startTime) or nil\nif type(state) ~= \"table\"\n    or not anchorStartTime\n    or math.abs(startTime - anchorStartTime) > 2 then\n  state = {\n    startTime = startTime,\n    anchorStartTime = startTime,\n    towers = {},\n    ready = false,\n  }\n  root.p3FourTowers = state\nend\n\nstate.towers[quadrant] = {\n  x = x,\n  y = y,\n  z = z,\n  count = aoeID - 26390,\n}\n\nlocal quadrants = { \"NW\", \"NE\", \"SW\", \"SE\" }\nlocal observed = 0\nlocal total = 0\nfor i = 1, #quadrants do\n  local tower = state.towers[quadrants[i]]\n  if tower then\n    observed = observed + 1\n    total = total + tower.count\n  end\nend\nstate.observed = observed\nstate.total = total\nstate.ready = false\n\nif observed == 4 then\n  local homeByRole = {\n    MT = \"NW\",\n    ST = \"NE\",\n    H1 = \"SW\",\n    H2 = \"SE\",\n    D1 = \"SW\",\n    D2 = \"SE\",\n    D3 = \"NW\",\n    D4 = \"NE\",\n  }\n  local anchorRole = {\n    H1 = true,\n    H2 = true,\n    D3 = true,\n    D4 = true,\n  }\n  local leftOf = {\n    NW = \"NE\",\n    NE = \"SE\",\n    SE = \"SW\",\n    SW = \"NW\",\n  }\n  local rightOf = {\n    NW = \"SW\",\n    NE = \"NW\",\n    SE = \"NE\",\n    SW = \"SE\",\n  }\n  local opposite = {\n    NW = \"SE\",\n    NE = \"SW\",\n    SE = \"NW\",\n    SW = \"NE\",\n  }\n\n  local function innerPoint(tower)\n    local toCenterX = 100 - tower.x\n    local toCenterZ = 100 - tower.z\n    local length = math.sqrt(toCenterX * toCenterX + toCenterZ * toCenterZ)\n    if length < 0.001 then\n      return tower.x, tower.z\n    end\n    return tower.x + toCenterX / length * 4,\n      tower.z + toCenterZ / length * 4\n  end\n\n  local targets = {}\n  for role, home in pairs(homeByRole) do\n    local destination = home\n    if not anchorRole[role] and state.towers[home].count == 1 then\n      local left = leftOf[home]\n      local right = rightOf[home]\n      if state.towers[left].count > 2 then\n        destination = left\n      elseif state.towers[right].count > 2 then\n        destination = right\n      else\n        destination = opposite[home]\n      end\n    end\n\n    local tower = state.towers[destination]\n    local targetX, targetZ = tower.x, tower.z\n    if not anchorRole[role] then\n      targetX, targetZ = innerPoint(tower)\n    end\n    targets[role] = {\n      x = targetX,\n      y = tower.y,\n      z = targetZ,\n      towerX = tower.x,\n      towerY = tower.y,\n      towerZ = tower.z,\n      towerCount = tower.count,\n      quadrant = destination,\n    }\n  end\n\n  state.targetsByRole = targets\n  state.pattern = string.format(\n    \"NW%d NE%d SW%d SE%d\",\n    state.towers.NW.count,\n    state.towers.NE.count,\n    state.towers.SW.count,\n    state.towers.SE.count)\n  state.ready = true\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"70222872-0e39-bac8-9522-abf8b22b44d2",
									true,
								},
							},
							name = "记录同轮四塔世界坐标并按左右中分配",
							uuid = "c37fddc7-a621-87f7-a3ee-a7e0d0304e6c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local id = tonumber(eventArgs.aoeID)\nreturn id ~= nil and id >= 26391 and id <= 26394",
							dequeueIfLuaFalse = true,
							name = "八人四塔 AOE 26391-26394",
							uuid = "70222872-0e39-bac8-9522-abf8b22b44d2",
							version = 3,
						},
					},
				},
				eventType = 18,
				mechanicTime = 676.9,
				name = "[P3] 八人四塔状态与分配",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = -0.20000000298023,
				timerStartOffset = -5.1999998092651,
				uuid = "f22764db-80af-adf4-80b5-f8eccc485e50",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = data.string_dsr\nif type(root) ~= \"table\" then\n  root = {}\n  data.string_dsr = root\nend\n\nlocal solver = root.p3FourTowerGuideSolver\nif type(solver) ~= \"table\" then\n  solver = {\n    quadrants = { \"NW\", \"NE\", \"SW\", \"SE\" },\n    roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" },\n    towers = {\n      NW = {},\n      NE = {},\n      SW = {},\n      SE = {},\n    },\n    homeByRole = {\n      MT = \"NW\",\n      ST = \"NE\",\n      H1 = \"SW\",\n      H2 = \"SE\",\n      D1 = \"SW\",\n      D2 = \"SE\",\n      D3 = \"NW\",\n      D4 = \"NE\",\n    },\n    anchorRole = {\n      H1 = true,\n      H2 = true,\n      D3 = true,\n      D4 = true,\n    },\n    leftOf = {\n      NW = \"NE\",\n      NE = \"SE\",\n      SE = \"SW\",\n      SW = \"NW\",\n    },\n    rightOf = {\n      NW = \"SW\",\n      NE = \"NW\",\n      SE = \"NE\",\n      SW = \"SE\",\n    },\n    opposite = {\n      NW = \"SE\",\n      NE = \"SW\",\n      SE = \"NW\",\n      SW = \"NE\",\n    },\n  }\n  root.p3FourTowerGuideSolver = solver\nend\n\nlocal towers = solver.towers\nfor i = 1, #solver.quadrants do\n  local tower = towers[solver.quadrants[i]]\n  tower.present = false\nend\n\nlocal aoes = Argus.getCurrentAOEs()\nlocal matched = 0\nlocal duplicate = false\nfor _, aoe in pairs(aoes) do\n  local aoeID = tonumber(aoe.aoeID)\n  if aoeID and aoeID >= 26391 and aoeID <= 26394 then\n    local x = tonumber(aoe.x)\n    local y = tonumber(aoe.y)\n    local z = tonumber(aoe.z)\n    if x and y and z then\n      local dx = x - 100\n      local dz = z - 100\n      if math.abs(dx) >= 3 and math.abs(dz) >= 3 then\n        local quadrant\n        if dx < 0 then\n          quadrant = dz < 0 and \"NW\" or \"SW\"\n        else\n          quadrant = dz < 0 and \"NE\" or \"SE\"\n        end\n\n        matched = matched + 1\n        local tower = towers[quadrant]\n        if tower.present then\n          duplicate = true\n        else\n          tower.present = true\n          tower.x = x\n          tower.y = y\n          tower.z = z\n          tower.count = aoeID - 26390\n        end\n      end\n    end\n  end\nend\n\nlocal observed = 0\nlocal total = 0\nfor i = 1, #solver.quadrants do\n  local tower = towers[solver.quadrants[i]]\n  if tower.present then\n    observed = observed + 1\n    total = total + tower.count\n  end\nend\nif matched ~= 4 or duplicate or observed ~= 4 or total ~= 8 then\n  return\nend\n\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nif not playerID or type(party) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal role\nfor i = 1, #solver.roles do\n  local candidate = solver.roles[i]\n  if tonumber(party[candidate] and party[candidate].id) == playerID then\n    role = candidate\n    break\n  end\nend\nif not role then\n  return\nend\n\nlocal home = solver.homeByRole[role]\nlocal destination = home\nif not solver.anchorRole[role] and towers[home].count == 1 then\n  local left = solver.leftOf[home]\n  local right = solver.rightOf[home]\n  if towers[left].count > 2 then\n    destination = left\n  elseif towers[right].count > 2 then\n    destination = right\n  else\n    destination = solver.opposite[home]\n  end\nend\n\nlocal tower = towers[destination]\nlocal targetX = tower.x\nlocal targetZ = tower.z\nif not solver.anchorRole[role] then\n  local toCenterX = 100 - tower.x\n  local toCenterZ = 100 - tower.z\n  local length = math.sqrt(\n    toCenterX * toCenterX + toCenterZ * toCenterZ)\n  if length >= 0.001 then\n    targetX = tower.x + toCenterX / length * 4\n    targetZ = tower.z + toCenterZ / length * 4\n  end\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\n\nlocal drawer = solver.targetTowerDrawer\nif not drawer then\n  local fill = GUI:ColorConvertFloat4ToU32(0.05, 0.45, 1, 0.22)\n  local outline = GUI:ColorConvertFloat4ToU32(1, 1, 1, 0.95)\n  drawer = TensorCore.getCachedFlatDrawer(\n    nil, nil, fill, outline, 2, 0)\n  solver.targetTowerDrawer = drawer\nend\ndrawer:addCircle(tower.x, tower.y, tower.z, 5, false)\nself.used = true",
							endIfUsed = true,
							name = "自身目标塔圈与 MuAi 动态指路",
							uuid = "3e377ac8-cc85-80e6-85ca-256d3b0323d5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 676.9,
				name = "[P3] 八人四塔范围与动态指路",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = -0.20000000298023,
				timerStartOffset = -5,
				uuid = "73b1eb6f-d366-53ae-bfac-9c0c0c80587b",
				version = 2,
			},
		},
	},
	[119] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"cf536c27-621d-a1e5-91f6-842ba8c953d0",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "adbfda51-271a-7418-8e60-cf1d2570ba16",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"a1dc8a44-b8de-4ed7-9317-6ee8b9562ab6",
									true,
								},
								
								{
									"deb9b8d3-2283-bd20-ab85-51f7b41869cb",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "27f8f9c0-bb84-0462-90d4-872bbf175fc3",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"8cc87833-db2d-0acc-9c17-e69a236fb292",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "af7d8ea1-4e66-6657-b5c6-69730c7cba90",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "deb9b8d3-2283-bd20-ab85-51f7b41869cb",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "cf536c27-621d-a1e5-91f6-842ba8c953d0",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "a1dc8a44-b8de-4ed7-9317-6ee8b9562ab6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "8cc87833-db2d-0acc-9c17-e69a236fb292",
							version = 3,
						},
					},
				},
				mechanicTime = 678.5,
				name = "[P3] 近战个人减伤",
				timelineIndex = 119,
				timerOffset = -3,
				uuid = "f006d584-d1bc-98ce-83ef-4fa97f6c6eee",
				version = 2,
			},
		},
	},
	[120] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = data.string_dsr\nif type(root) ~= \"table\" then\n  root = {}\n  data.string_dsr = root\nend\nlocal state = root.p3SoulTether\nif type(state) ~= \"table\" then\n  state = {}\n  root.p3SoulTether = state\nend\n\nlocal dangerDrawer = TensorCore.getMoogleFlatDrawer(0)\nlocal cloneDrawer = state.cloneDrawer\nif not cloneDrawer or state.cloneDrawerUsesDefaultTerrain ~= true then\n  local purple = GUI:ColorConvertFloat4ToU32(0.58, 0.16, 1, 0.42)\n  local outline = GUI:ColorConvertFloat4ToU32(0.92, 0.82, 1, 0.95)\n  cloneDrawer = TensorCore.getCachedFlatDrawer(\n    nil, nil, purple, outline, 2, 0)\n  state.cloneDrawer = cloneDrawer\n  state.cloneDrawerUsesDefaultTerrain = true\nend\n\nlocal tethers = Argus.getCurrentTethers()\nfor sourceID, sourceTethers in pairs(tethers or {}) do\n  for i = 1, #sourceTethers do\n    local tetherData = sourceTethers[i]\n    if tonumber(tetherData.type) == 84 then\n      local source = TensorCore.getEntityByGroup(\"ID\", sourceID)\n      if source and tonumber(source.contentid) == 3458 then\n        local target = TensorCore.getEntityByGroup(\"ID\", tetherData.targetid)\n        if dangerDrawer and target and target.pos then\n          dangerDrawer:addCircle(\n            target.pos.x, target.pos.y, target.pos.z, 5, false)\n        end\n        if cloneDrawer and source.pos\n            and tonumber(Argus.getEntityModel(sourceID)) == 12606 then\n          cloneDrawer:addCircle(\n            source.pos.x, source.pos.y, source.pos.z, 3, false)\n        end\n      end\n    end\n  end\nend\nself.used = true",
							name = "每帧绘制分身落点与实时接线死刑圈",
							uuid = "b9a7ee7a-04b3-d9e0-801f-7a7945941b46",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 683.9,
				name = "[P3] 追魂炮分身与接线动态范围",
				timeRange = true,
				timelineIndex = 120,
				timerEndOffset = 0.5,
				timerStartOffset = -7,
				uuid = "423d6e3d-d025-ebee-9310-495ddb666219",
				version = 2,
			},
		},
	},
	[127] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\ndata.string_dsr = data.string_dsr or {}\ndata.string_dsr.eyePos = nil\ndata.string_dsr.cometCount = nil\ndata.string_dsr.cometsArmed = nil\ndata.string_dsr.drawnExaflares = nil\nself.used = true",
							endIfUsed = true,
							name = "Unlock face and reset phase state",
							uuid = "9eb42744-97a2-2938-8352-a01cbeb5d2ac",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 757,
				name = "[P4] 换相清理",
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 0.5,
				timerStartOffset = -0.5,
				uuid = "51b5ac66-29ac-7b6d-a9a7-e3df0d21ba23",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"b0b88978-d615-9358-87e9-01d59824044f",
									true,
								},
								
								{
									"910976a5-bb9b-1156-98ee-d39c479c62ea",
									true,
								},
							},
							endIfUsed = true,
							name = "选择世界西侧蓝眼",
							setTarget = true,
							targetContentID = 11318,
							targetType = "ContentID",
							uuid = "b4397751-3ad3-1ec9-8d9d-6505b95840e6",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"b0b88978-d615-9358-87e9-01d59824044f",
									true,
								},
								
								{
									"d5f9ef2b-cc26-9534-b4bc-df9b446008da",
									true,
								},
							},
							endIfUsed = true,
							name = "选择世界东侧红眼",
							setTarget = true,
							targetContentID = 11317,
							targetType = "ContentID",
							uuid = "57ad5f04-df5c-a086-a699-96fbf1ac5723",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "b0b88978-d615-9358-87e9-01d59824044f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\" or playerID == nil then\n  return false\nend\n\nlocal roles = { \"MT\", \"H1\", \"D1\", \"D2\" }\nlocal matches = 0\nfor i = 1, #roles do\n  local role = roles[i]\n  if tonumber(party[role] and party[role].id) == playerID then\n    matches = matches + 1\n  end\nend\nreturn matches == 1",
							name = "西列职能",
							uuid = "910976a5-bb9b-1156-98ee-d39c479c62ea",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\" or playerID == nil then\n  return false\nend\n\nlocal roles = { \"ST\", \"H2\", \"D3\", \"D4\" }\nlocal matches = 0\nfor i = 1, #roles do\n  local role = roles[i]\n  if tonumber(party[role] and party[role].id) == playerID then\n    matches = matches + 1\n  end\nend\nreturn matches == 1",
							name = "东列职能",
							uuid = "d5f9ef2b-cc26-9534-b4bc-df9b446008da",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 757,
				name = "[P4] 自动目标：Eyes P4-1",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "8d18988f-107d-b08f-a4d5-edd57b5ffbfb",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\n\nif type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal selfRole\nlocal roleMatches = 0\nfor i = 1, #roles do\n  local role = roles[i]\n  if tonumber(party[role] and party[role].id) == playerID then\n    selfRole = role\n    roleMatches = roleMatches + 1\n  end\nend\nif roleMatches ~= 1 then\n  return\nend\n\nlocal spots = {\n  MT = { 95, 95 },\n  D1 = { 95, 98 },\n  D2 = { 95, 102 },\n  H1 = { 95, 105 },\n  ST = { 105, 95 },\n  D3 = { 105, 98 },\n  D4 = { 105, 102 },\n  H2 = { 105, 105 },\n}\nlocal target = spots[selfRole]\nif target == nil then\n  return\nend\n\nguide.FrameDirect(target[1], target[2], 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi 职能预站位指路",
							uuid = "29327908-9b18-b6e0-968e-8825ebfe5b1e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 757,
				name = "[P4] 红蓝点名前职能预站位指路",
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 16.799999237061,
				uuid = "5390cf0f-7674-6c71-8ddf-7511952eaad3",
				version = 2,
			},
		},
	},
	[128] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"d67455f1-ea93-07f6-a6c1-d30fba2af4d2",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "cbe8fab5-525a-77da-b372-aa7c5df53b13",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"c4586242-010a-e6c3-be81-dad9330a0740",
									true,
								},
								
								{
									"6a5aa4e0-861f-8799-a674-42b46967225b",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "10a1f72f-6f35-b694-8c56-fb448468a3e3",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"48f13032-f956-e24c-b440-191fba660553",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "4999921d-2544-19e9-9199-09e3f34ce99a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "6a5aa4e0-861f-8799-a674-42b46967225b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "d67455f1-ea93-07f6-a6c1-d30fba2af4d2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "c4586242-010a-e6c3-be81-dad9330a0740",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "48f13032-f956-e24c-b440-191fba660553",
							version = 3,
						},
					},
				},
				mechanicTime = 772.7,
				name = "[P4] 近战个人减伤",
				timelineIndex = 128,
				timerOffset = -10.699999809265,
				uuid = "d22a8497-7b53-c86f-88a1-ab896a705f26",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\n\nif type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(Argus) ~= \"table\"\n    or type(Argus.getTethersOnEnt) ~= \"function\"\n    or type(Argus.isEntityVisible) ~= \"function\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal selfRole\nlocal roleMatches = 0\nfor i = 1, #roles do\n  local role = roles[i]\n  if tonumber(party[role] and party[role].id) == playerID then\n    selfRole = role\n    roleMatches = roleMatches + 1\n  end\nend\nif roleMatches ~= 1 then\n  return\nend\n\nlocal tetherID\nfor _, tether in ipairs(Argus.getTethersOnEnt(playerID) or {}) do\n  local current = tonumber(tether.type)\n  if current == 51 or current == 52 then\n    tetherID = current\n    break\n  end\nend\nif tetherID == nil then\n  return\nend\n\nlocal isDPS = selfRole == \"D1\" or selfRole == \"D2\"\n  or selfRole == \"D3\" or selfRole == \"D4\"\nlocal westGroup = selfRole == \"MT\" or selfRole == \"H1\"\n  or selfRole == \"D1\" or selfRole == \"D2\"\nlocal groupX = westGroup and 90 or 110\nlocal yellowX = westGroup and 83 or 117\nlocal blueX\nlocal blueZ\nif selfRole == \"MT\" then\n  blueX, blueZ = 90, 93\nelseif selfRole == \"ST\" then\n  blueX, blueZ = 110, 93\nelseif selfRole == \"H1\" then\n  blueX, blueZ = 90, 107\nelseif selfRole == \"H2\" then\n  blueX, blueZ = 110, 107\nend\n\nlocal function visibleEntityAt(entities, x, z)\n  local best\n  local bestDistance\n  for _, entity in pairs(entities or {}) do\n    local pos = entity and entity.pos or nil\n    local ex = tonumber(pos and pos.x)\n    local ez = tonumber(pos and pos.z)\n    if ex ~= nil and ez ~= nil and Argus.isEntityVisible(entity) then\n      local dx = ex - x\n      local dz = ez - z\n      local distance = dx * dx + dz * dz\n      if distance <= 1\n          and (bestDistance == nil or distance < bestDistance) then\n        best = entity\n        bestDistance = distance\n      end\n    end\n  end\n  return best\nend\n\nlocal yellowEntities = TensorCore.entityList(\"contentid=11316\")\nlocal blueEntities = TensorCore.entityList(\"contentid=11315\")\nlocal yellow = visibleEntityAt(yellowEntities, yellowX, 100)\nlocal blue = blueX and visibleEntityAt(blueEntities, blueX, blueZ) or nil\n\ndata.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal state = data.string_dsr\nlocal anyVisible = false\nfor _, entity in pairs(yellowEntities or {}) do\n  if Argus.isEntityVisible(entity) then\n    anyVisible = true\n    break\n  end\nend\nif not anyVisible then\n  for _, entity in pairs(blueEntities or {}) do\n    if Argus.isEntityVisible(entity) then\n      anyVisible = true\n      break\n    end\n  end\nend\nif anyVisible then\n  state.p4BallsSeen = true\nelseif state.p4BallsSeen ~= true then\n  return\nend\n\nlocal function drawTargetBall(entity)\n  local pos = entity and entity.pos or nil\n  if type(pos) ~= \"table\" then\n    return\n  end\n  local drawer = state.p4TargetBallDrawer\n  if not drawer then\n    local fill = GUI:ColorConvertFloat4ToU32(0.05, 0.45, 1, 0.22)\n    local outline = GUI:ColorConvertFloat4ToU32(1, 1, 1, 0.95)\n    drawer = TensorCore.getCachedFlatDrawer(\n      nil, nil, fill, outline, 2, 0)\n    state.p4TargetBallDrawer = drawer\n  end\n  drawer:addCircle(\n    tonumber(pos.x), tonumber(pos.y) or 0, tonumber(pos.z), 6, false)\nend\n\nlocal targetX\nlocal targetZ\nif yellow ~= nil then\n  local desiredTether = isDPS and 52 or 51\n  if isDPS then\n    drawTargetBall(yellow)\n  end\n  if tetherID ~= desiredTether then\n    targetX, targetZ = 100, 100\n  elseif isDPS then\n    targetX, targetZ = yellow.pos.x, yellow.pos.z\n  else\n    targetX, targetZ = groupX, 100\n  end\nelse\n  local desiredTether = isDPS and 51 or 52\n  if tetherID ~= desiredTether then\n    targetX, targetZ = groupX, 100\n  elseif isDPS then\n    targetX, targetZ = 90, 100\n  elseif blue ~= nil then\n    drawTargetBall(blue)\n    targetX, targetZ = blue.pos.x, blue.pos.z\n  else\n    targetX, targetZ = 90, 100\n  end\nend\n\nif type(targetX) == \"number\" and type(targetZ) == \"number\" then\n  guide.FrameDirect(targetX, targetZ, 0.5)\nend\nself.used = true",
							endIfUsed = true,
							name = "本人目标球圈与 MuAi 动态指路",
							uuid = "af29c7bc-2005-3169-8c9b-9f82ecc83f2e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 772.7,
				name = "[P4] 撞球目标范围与动态指路",
				timeRange = true,
				timelineIndex = 128,
				timerEndOffset = 20,
				timerStartOffset = 7.0999999046326,
				uuid = "f85532fb-63ba-f5ee-9ea7-818d6ec6e12b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\n\nif type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(Argus) ~= \"table\"\n    or type(Argus.getTethersOnEnt) ~= \"function\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal selfRole\nlocal roleMatches = 0\nfor i = 1, #roles do\n  local role = roles[i]\n  if tonumber(party[role] and party[role].id) == playerID then\n    selfRole = role\n    roleMatches = roleMatches + 1\n  end\nend\nif roleMatches ~= 1 then\n  return\nend\n\nlocal tetherID\nfor _, tether in ipairs(Argus.getTethersOnEnt(playerID) or {}) do\n  local current = tonumber(tether.type)\n  if current == 51 or current == 52 then\n    tetherID = current\n    break\n  end\nend\nif tetherID == nil then\n  return\nend\n\nlocal isDPS = selfRole == \"D1\" or selfRole == \"D2\"\n  or selfRole == \"D3\" or selfRole == \"D4\"\nlocal westGroup = selfRole == \"MT\" or selfRole == \"H1\"\n  or selfRole == \"D1\" or selfRole == \"D2\"\nlocal desiredTether = isDPS and 52 or 51\n\nlocal targetX\nlocal targetZ = 100\nif tetherID ~= desiredTether then\n  targetX = 100\nelse\n  targetX = westGroup and 90 or 110\nend\n\nguide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "黄球二次变大前换线与等待指路",
							uuid = "c660ce94-a96b-4ef9-bcee-43d1670275b4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 772.7,
				name = "[P4] 黄球二次变大前换线与等待指路",
				timeRange = true,
				timelineIndex = 128,
				timerEndOffset = 7.1,
				timerStartOffset = 1.1,
				uuid = "8220a05f-8321-ccda-aeba-251aac5e9171",
				version = 2,
			},
		},
	},
	[129] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local targetID = tonumber(eventArgs.targetID)\nif targetID == nil then\n  return\nend\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer ~= nil then\n  drawer:addTimedCircleOnEnt(2000, targetID, 1)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"4fd3e749-8964-ced5-9b10-7e8ab8187921",
									true,
								},
							},
							endIfUsed = true,
							name = "第1轮被撞目标 2s 小圈",
							uuid = "a9c15e50-d969-d797-9936-10ed3d55ab66",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26820,
							name = "Mirage Dive",
							uuid = "4fd3e749-8964-ced5-9b10-7e8ab8187921",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 798.8,
				name = "[P4] 幻象冲1双目标小圈",
				timeRange = true,
				timelineIndex = 129,
				timerEndOffset = 1.2,
				timerStartOffset = 0.6,
				uuid = "ae472005-2627-b0d3-997a-fbe3fcd1f7a7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\n\nif type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal selfRole\nlocal roleMatches = 0\nfor i = 1, #roles do\n  local role = roles[i]\n  if tonumber(party[role] and party[role].id) == playerID then\n    selfRole = role\n    roleMatches = roleMatches + 1\n  end\nend\nif roleMatches ~= 1 then\n  return\nend\n\nlocal spots = {\n  MT = { 85, 95 },\n  ST = { 95, 95 },\n  H1 = { 95, 105 },\n  H2 = { 85, 105 },\n  D1 = { 90, 100 },\n  D2 = { 90, 100 },\n  D3 = { 90, 100 },\n  D4 = { 90, 100 },\n}\nlocal target = spots[selfRole]\nif target == nil then\n  return\nend\n\nguide.FrameDirect(target[1], target[2], 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi 职能待机指路",
							uuid = "8cc6edb3-acf7-01cc-82fb-3715de452c22",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 798.8,
				name = "[P4] 幻象冲开局职能待机指路",
				timeRange = true,
				timelineIndex = 129,
				timerEndOffset = -1.2,
				timerStartOffset = -6.1,
				uuid = "70f975b2-89f6-33bb-945c-993a3d175721",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\"\n    or type(Argus) ~= \"table\"\n    or type(Argus.getTethersOnEnt) ~= \"function\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleIDs = {}\nlocal seenIDs = {}\nlocal redIDs = {}\nfor i = 1, #roles do\n  local role = roles[i]\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or seenIDs[id] then\n    return\n  end\n  seenIDs[id] = true\n  roleIDs[role] = id\n\n  local isRed = false\n  for _, tether in ipairs(Argus.getTethersOnEnt(id) or {}) do\n    if tonumber(tether.type) == 52 then\n      isRed = true\n      break\n    end\n  end\n  if isRed then\n    redIDs[#redIDs + 1] = id\n  end\nend\nif #redIDs ~= 4 then\n  return\nend\n\ndata.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal state = {\n  roleIDs = roleIDs,\n  homeSlotByID = {},\n  logicalSlotByID = {},\n  rounds = {},\n}\nstate.homeSlotByID[roleIDs.MT] = 1\nstate.homeSlotByID[roleIDs.ST] = 2\nstate.homeSlotByID[roleIDs.H1] = 3\nstate.homeSlotByID[roleIDs.H2] = 4\nstate.logicalSlotByID[roleIDs.MT] = 1\nstate.logicalSlotByID[roleIDs.ST] = 2\nstate.logicalSlotByID[roleIDs.H1] = 3\nstate.logicalSlotByID[roleIDs.H2] = 4\ndata.string_dsr.p4Mirage = state\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer == nil then\n  return\nend\nfor i = 1, #redIDs do\n  drawer:addTimedCircleOnEnt(2000, redIDs[i], 4)\nend\nself.used = true",
							endIfUsed = true,
							name = "第1轮红线四人 4m 范围",
							uuid = "6cba266a-0c05-26fb-bfe9-39bc7d915fb3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 798.8,
				name = "[P4] 幻象冲1红线四人范围",
				timelineIndex = 129,
				timerOffset = -1.2,
				uuid = "a757c38a-8dc4-654f-bdc0-21791be95dd7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local round = 1\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or type(party) ~= \"table\"\n    or playerID == nil\n    or type(Argus) ~= \"table\"\n    or type(Argus.getTethersOnEnt) ~= \"function\" then\n  return\nend\n\ndata.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal root = data.string_dsr\nlocal state = root.p4Mirage\nif round == 1 and (type(state) ~= \"table\" or tonumber(state.version) ~= 2) then\n  local roleNames = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\n  local roleIDs = {}\n  local roleByID = {}\n  for _, roleName in ipairs(roleNames) do\n    local id = tonumber(party[roleName] and party[roleName].id)\n    if id == nil or roleByID[id] ~= nil then\n      return\n    end\n    roleIDs[roleName] = id\n    roleByID[id] = roleName\n  end\n  state = {\n    version = 2,\n    roleIDs = roleIDs,\n    roleByID = roleByID,\n    homeSlotByID = {},\n    logicalSlotByID = {},\n    rounds = {},\n  }\n  state.homeSlotByID[roleIDs.MT] = 1\n  state.homeSlotByID[roleIDs.ST] = 2\n  state.homeSlotByID[roleIDs.H1] = 3\n  state.homeSlotByID[roleIDs.H2] = 4\n  state.logicalSlotByID[roleIDs.MT] = 1\n  state.logicalSlotByID[roleIDs.ST] = 2\n  state.logicalSlotByID[roleIDs.H1] = 3\n  state.logicalSlotByID[roleIDs.H2] = 4\n  root.p4Mirage = state\nend\nif type(state) ~= \"table\"\n    or tonumber(state.version) ~= 2\n    or type(state.roleIDs) ~= \"table\"\n    or type(state.roleByID) ~= \"table\"\n    or type(state.logicalSlotByID) ~= \"table\"\n    or type(state.rounds) ~= \"table\" then\n  return\nend\n\nlocal roundState = state.rounds[round]\nif type(roundState) ~= \"table\" then\n  roundState = {}\n  state.rounds[round] = roundState\nend\n\nif roundState.ready ~= true then\n  local targets = {}\n  local seen = {}\n  local entities = TensorCore.entityList(\"contentid=3458\")\n  for _, entity in pairs(type(entities) == \"table\" and entities or {}) do\n    local casting = entity and entity.castinginfo or nil\n    local lastCastID = tonumber(casting and casting.lastcastid)\n    local sinceCast = tonumber(casting and casting.timesincecast)\n    local function addTarget(rawID)\n      local targetID = tonumber(rawID)\n      if targetID ~= nil and targetID ~= 0\n          and state.roleByID[targetID] ~= nil\n          and tonumber(state.logicalSlotByID[targetID]) ~= nil\n          and seen[targetID] ~= true then\n        seen[targetID] = true\n        targets[#targets + 1] = targetID\n      end\n    end\n    if tonumber(casting and casting.castingid) == 26820\n        and type(casting.castingtargets) == \"table\" then\n      for _, targetID in ipairs(casting.castingtargets) do\n        addTarget(targetID)\n      end\n    end\n    if lastCastID == 26820\n        and sinceCast ~= nil and sinceCast >= 0 and sinceCast <= 1600 then\n      addTarget(entity and entity.targetid)\n    end\n  end\n  if #targets == 2 then\n    table.sort(targets, function(a, b)\n      return tonumber(state.logicalSlotByID[a]) < tonumber(state.logicalSlotByID[b])\n    end)\n    local targetA = targets[1]\n    local targetB = targets[2]\n    local slotA = tonumber(state.logicalSlotByID[targetA])\n    local slotB = tonumber(state.logicalSlotByID[targetB])\n    if slotA ~= nil and slotB ~= nil and slotA ~= slotB then\n      local swapperA\n      local swapperB\n      if round == 1 then\n        swapperA = tonumber(state.roleIDs.D1)\n        swapperB = tonumber(state.roleIDs.D2)\n      elseif round == 2 then\n        swapperA = tonumber(state.roleIDs.D3)\n        swapperB = tonumber(state.roleIDs.D4)\n      elseif round == 3 then\n        local firstTargets = state.firstRoundTargets\n        local homeSlotByID = state.homeSlotByID\n        if type(firstTargets) == \"table\"\n            and #firstTargets == 2\n            and type(homeSlotByID) == \"table\" then\n          swapperA = tonumber(firstTargets[1])\n          swapperB = tonumber(firstTargets[2])\n          local homeA = tonumber(homeSlotByID[swapperA])\n          local homeB = tonumber(homeSlotByID[swapperB])\n          if homeA ~= nil and homeB ~= nil and homeA > homeB then\n            swapperA, swapperB = swapperB, swapperA\n          end\n        end\n      end\n      if swapperA ~= nil and swapperB ~= nil and swapperA ~= swapperB then\n        roundState.targets = { targetA, targetB }\n        roundState.assignments = {\n          [swapperA] = { targetID = targetA, slot = slotA },\n          [swapperB] = { targetID = targetB, slot = slotB },\n        }\n        roundState.ready = true\n        roundState.snapshotSource = \"recent_cast_targets\"\n        state.logicalSlotByID[swapperA] = slotA\n        state.logicalSlotByID[swapperB] = slotB\n        if round == 1 then\n          state.firstRoundTargets = { targetA, targetB }\n        end\n      end\n    end\n  end\nend\n\nlocal assignments = roundState.assignments\nif roundState.ready ~= true or type(assignments) ~= \"table\" then\n  return\nend\n\nlocal function currentTether(id)\n  for _, tether in ipairs(Argus.getTethersOnEnt(id) or {}) do\n    local tetherType = tonumber(tether.type)\n    if tetherType == 51 or tetherType == 52 then\n      return tetherType\n    end\n  end\nend\n\nlocal slotCoordinates = {\n  [1] = { 85, 95 },\n  [2] = { 95, 95 },\n  [3] = { 95, 105 },\n  [4] = { 85, 105 },\n}\n\nlocal targetX\nlocal targetZ\nlocal ownAssignment = assignments[playerID]\nif type(ownAssignment) == \"table\" then\n  local tetherType = currentTether(playerID)\n  if tetherType == 51 then\n    local target = TensorCore.mGetEntity(tonumber(ownAssignment.targetID))\n    local pos = target and target.pos or nil\n    targetX = tonumber(pos and pos.x)\n    targetZ = tonumber(pos and pos.z)\n  elseif tetherType == 52 then\n    local spot = slotCoordinates[tonumber(ownAssignment.slot)]\n    if spot then\n      targetX, targetZ = spot[1], spot[2]\n    end\n  end\nelse\n  local targetAssignment\n  for _, assignment in pairs(assignments) do\n    if tonumber(assignment and assignment.targetID) == playerID then\n      targetAssignment = assignment\n      break\n    end\n  end\n  if type(targetAssignment) == \"table\" then\n    local tetherType = currentTether(playerID)\n    if tetherType == 52 then\n      local spot = slotCoordinates[tonumber(targetAssignment.slot)]\n      if spot then\n        targetX, targetZ = spot[1], spot[2]\n      end\n    elseif tetherType == 51 then\n      targetX, targetZ = 90, 100\n    end\n  end\nend\n\nif type(targetX) == \"number\" and type(targetZ) == \"number\" then\n  guide.FrameDirect(targetX, targetZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "第1轮双目标快照与 MuAi 换线指路",
							uuid = "46e3a4d6-35b5-c400-a4c0-1a293c04a24d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 798.8,
				name = "[P4] 幻象冲1换线动态指路",
				timeRange = true,
				timelineIndex = 129,
				timerEndOffset = 5.8,
				timerStartOffset = 0.8,
				uuid = "73147fab-55b6-6f7b-a6f9-7ef4b771cf5c",
				version = 2,
			},
		},
	},
	[130] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\"\n    or type(Argus) ~= \"table\"\n    or type(Argus.getTethersOnEnt) ~= \"function\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleIDs = {}\nlocal seenIDs = {}\nlocal redIDs = {}\nfor i = 1, #roles do\n  local role = roles[i]\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or seenIDs[id] then\n    return\n  end\n  seenIDs[id] = true\n  roleIDs[role] = id\n\n  local isRed = false\n  for _, tether in ipairs(Argus.getTethersOnEnt(id) or {}) do\n    if tonumber(tether.type) == 52 then\n      isRed = true\n      break\n    end\n  end\n  if isRed then\n    redIDs[#redIDs + 1] = id\n  end\nend\nif #redIDs ~= 4 then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer == nil then\n  return\nend\nfor i = 1, #redIDs do\n  drawer:addTimedCircleOnEnt(2000, redIDs[i], 4)\nend\nself.used = true",
							endIfUsed = true,
							name = "第2轮红线四人 4m 范围",
							uuid = "0f6c58fe-c1e9-fadc-bca8-a559968ce712",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 804.7,
				name = "[P4] 幻象冲2红线四人范围",
				timelineIndex = 130,
				timerOffset = -2,
				uuid = "0fa3f9e6-da80-6376-9199-1140c9b632da",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local targetID = tonumber(eventArgs.targetID)\nif targetID == nil then\n  return\nend\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer ~= nil then\n  drawer:addTimedCircleOnEnt(2000, targetID, 1)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"64f03d52-8a65-be80-a22b-b4f08eee837a",
									true,
								},
							},
							endIfUsed = true,
							name = "第2轮被撞目标 2s 小圈",
							uuid = "7ee7b4ee-d299-88ba-9927-a226d0bf44ca",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26820,
							name = "Mirage Dive",
							uuid = "64f03d52-8a65-be80-a22b-b4f08eee837a",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 804.7,
				name = "[P4] 幻象冲2双目标小圈",
				timeRange = true,
				timelineIndex = 130,
				timerEndOffset = 0.3,
				timerStartOffset = -0.2,
				uuid = "a7fc7adf-0079-c54d-9e6c-346597125ec7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local round = 2\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or type(party) ~= \"table\"\n    or playerID == nil\n    or type(Argus) ~= \"table\"\n    or type(Argus.getTethersOnEnt) ~= \"function\" then\n  return\nend\n\ndata.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal root = data.string_dsr\nlocal state = root.p4Mirage\nif round == 1 and (type(state) ~= \"table\" or tonumber(state.version) ~= 2) then\n  local roleNames = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\n  local roleIDs = {}\n  local roleByID = {}\n  for _, roleName in ipairs(roleNames) do\n    local id = tonumber(party[roleName] and party[roleName].id)\n    if id == nil or roleByID[id] ~= nil then\n      return\n    end\n    roleIDs[roleName] = id\n    roleByID[id] = roleName\n  end\n  state = {\n    version = 2,\n    roleIDs = roleIDs,\n    roleByID = roleByID,\n    homeSlotByID = {},\n    logicalSlotByID = {},\n    rounds = {},\n  }\n  state.homeSlotByID[roleIDs.MT] = 1\n  state.homeSlotByID[roleIDs.ST] = 2\n  state.homeSlotByID[roleIDs.H1] = 3\n  state.homeSlotByID[roleIDs.H2] = 4\n  state.logicalSlotByID[roleIDs.MT] = 1\n  state.logicalSlotByID[roleIDs.ST] = 2\n  state.logicalSlotByID[roleIDs.H1] = 3\n  state.logicalSlotByID[roleIDs.H2] = 4\n  root.p4Mirage = state\nend\nif type(state) ~= \"table\"\n    or tonumber(state.version) ~= 2\n    or type(state.roleIDs) ~= \"table\"\n    or type(state.roleByID) ~= \"table\"\n    or type(state.logicalSlotByID) ~= \"table\"\n    or type(state.rounds) ~= \"table\" then\n  return\nend\n\nlocal roundState = state.rounds[round]\nif type(roundState) ~= \"table\" then\n  roundState = {}\n  state.rounds[round] = roundState\nend\n\nif roundState.ready ~= true then\n  local targets = {}\n  local seen = {}\n  local entities = TensorCore.entityList(\"contentid=3458\")\n  for _, entity in pairs(type(entities) == \"table\" and entities or {}) do\n    local casting = entity and entity.castinginfo or nil\n    local lastCastID = tonumber(casting and casting.lastcastid)\n    local sinceCast = tonumber(casting and casting.timesincecast)\n    local function addTarget(rawID)\n      local targetID = tonumber(rawID)\n      if targetID ~= nil and targetID ~= 0\n          and state.roleByID[targetID] ~= nil\n          and tonumber(state.logicalSlotByID[targetID]) ~= nil\n          and seen[targetID] ~= true then\n        seen[targetID] = true\n        targets[#targets + 1] = targetID\n      end\n    end\n    if tonumber(casting and casting.castingid) == 26820\n        and type(casting.castingtargets) == \"table\" then\n      for _, targetID in ipairs(casting.castingtargets) do\n        addTarget(targetID)\n      end\n    end\n    if lastCastID == 26820\n        and sinceCast ~= nil and sinceCast >= 0 and sinceCast <= 1600 then\n      addTarget(entity and entity.targetid)\n    end\n  end\n  if #targets == 2 then\n    table.sort(targets, function(a, b)\n      return tonumber(state.logicalSlotByID[a]) < tonumber(state.logicalSlotByID[b])\n    end)\n    local targetA = targets[1]\n    local targetB = targets[2]\n    local slotA = tonumber(state.logicalSlotByID[targetA])\n    local slotB = tonumber(state.logicalSlotByID[targetB])\n    if slotA ~= nil and slotB ~= nil and slotA ~= slotB then\n      local swapperA\n      local swapperB\n      if round == 1 then\n        swapperA = tonumber(state.roleIDs.D1)\n        swapperB = tonumber(state.roleIDs.D2)\n      elseif round == 2 then\n        swapperA = tonumber(state.roleIDs.D3)\n        swapperB = tonumber(state.roleIDs.D4)\n      elseif round == 3 then\n        local firstTargets = state.firstRoundTargets\n        local homeSlotByID = state.homeSlotByID\n        if type(firstTargets) == \"table\"\n            and #firstTargets == 2\n            and type(homeSlotByID) == \"table\" then\n          swapperA = tonumber(firstTargets[1])\n          swapperB = tonumber(firstTargets[2])\n          local homeA = tonumber(homeSlotByID[swapperA])\n          local homeB = tonumber(homeSlotByID[swapperB])\n          if homeA ~= nil and homeB ~= nil and homeA > homeB then\n            swapperA, swapperB = swapperB, swapperA\n          end\n        end\n      end\n      if swapperA ~= nil and swapperB ~= nil and swapperA ~= swapperB then\n        roundState.targets = { targetA, targetB }\n        roundState.assignments = {\n          [swapperA] = { targetID = targetA, slot = slotA },\n          [swapperB] = { targetID = targetB, slot = slotB },\n        }\n        roundState.ready = true\n        roundState.snapshotSource = \"recent_cast_targets\"\n        state.logicalSlotByID[swapperA] = slotA\n        state.logicalSlotByID[swapperB] = slotB\n        if round == 1 then\n          state.firstRoundTargets = { targetA, targetB }\n        end\n      end\n    end\n  end\nend\n\nlocal assignments = roundState.assignments\nif roundState.ready ~= true or type(assignments) ~= \"table\" then\n  return\nend\n\nlocal function currentTether(id)\n  for _, tether in ipairs(Argus.getTethersOnEnt(id) or {}) do\n    local tetherType = tonumber(tether.type)\n    if tetherType == 51 or tetherType == 52 then\n      return tetherType\n    end\n  end\nend\n\nlocal slotCoordinates = {\n  [1] = { 85, 95 },\n  [2] = { 95, 95 },\n  [3] = { 95, 105 },\n  [4] = { 85, 105 },\n}\n\nlocal targetX\nlocal targetZ\nlocal ownAssignment = assignments[playerID]\nif type(ownAssignment) == \"table\" then\n  local tetherType = currentTether(playerID)\n  if tetherType == 51 then\n    local target = TensorCore.mGetEntity(tonumber(ownAssignment.targetID))\n    local pos = target and target.pos or nil\n    targetX = tonumber(pos and pos.x)\n    targetZ = tonumber(pos and pos.z)\n  elseif tetherType == 52 then\n    local spot = slotCoordinates[tonumber(ownAssignment.slot)]\n    if spot then\n      targetX, targetZ = spot[1], spot[2]\n    end\n  end\nelse\n  local targetAssignment\n  for _, assignment in pairs(assignments) do\n    if tonumber(assignment and assignment.targetID) == playerID then\n      targetAssignment = assignment\n      break\n    end\n  end\n  if type(targetAssignment) == \"table\" then\n    local tetherType = currentTether(playerID)\n    if tetherType == 52 then\n      local spot = slotCoordinates[tonumber(targetAssignment.slot)]\n      if spot then\n        targetX, targetZ = spot[1], spot[2]\n      end\n    elseif tetherType == 51 then\n      targetX, targetZ = 90, 100\n    end\n  end\nend\n\nif type(targetX) == \"number\" and type(targetZ) == \"number\" then\n  guide.FrameDirect(targetX, targetZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "第2轮双目标快照与 MuAi 换线指路",
							uuid = "e717e0e2-a3c4-d2f1-87aa-5eb8592f0d4e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 804.7,
				name = "[P4] 幻象冲2换线动态指路",
				timeRange = true,
				timelineIndex = 130,
				timerEndOffset = 5,
				uuid = "5e1aa116-eead-f90e-9995-9ceeec865061",
				version = 2,
			},
		},
	},
	[131] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\"\n    or type(Argus) ~= \"table\"\n    or type(Argus.getTethersOnEnt) ~= \"function\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleIDs = {}\nlocal seenIDs = {}\nlocal redIDs = {}\nfor i = 1, #roles do\n  local role = roles[i]\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or seenIDs[id] then\n    return\n  end\n  seenIDs[id] = true\n  roleIDs[role] = id\n\n  local isRed = false\n  for _, tether in ipairs(Argus.getTethersOnEnt(id) or {}) do\n    if tonumber(tether.type) == 52 then\n      isRed = true\n      break\n    end\n  end\n  if isRed then\n    redIDs[#redIDs + 1] = id\n  end\nend\nif #redIDs ~= 4 then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer == nil then\n  return\nend\nfor i = 1, #redIDs do\n  drawer:addTimedCircleOnEnt(2000, redIDs[i], 4)\nend\nself.used = true",
							endIfUsed = true,
							name = "第3轮红线四人 4m 范围",
							uuid = "0d5b1f21-406e-7151-890f-7d0b5f4591b5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 809.8,
				name = "[P4] 幻象冲3红线四人范围",
				timelineIndex = 131,
				timerOffset = -2,
				uuid = "feec6537-1881-34a8-81b2-666cb740b396",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local targetID = tonumber(eventArgs.targetID)\nif targetID == nil then\n  return\nend\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer ~= nil then\n  drawer:addTimedCircleOnEnt(2000, targetID, 1)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"77fc9513-b238-4194-82d3-4ddf0bf572b0",
									true,
								},
							},
							endIfUsed = true,
							name = "第3轮被撞目标 2s 小圈",
							uuid = "d9b37b40-ce92-f2be-96d8-303bd3072e47",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26820,
							name = "Mirage Dive",
							uuid = "77fc9513-b238-4194-82d3-4ddf0bf572b0",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 809.8,
				name = "[P4] 幻象冲3双目标小圈",
				timeRange = true,
				timelineIndex = 131,
				timerEndOffset = 0.3,
				timerStartOffset = -0.2,
				uuid = "1b3bdc9c-2352-4760-897d-c90281a41a37",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local round = 3\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or type(party) ~= \"table\"\n    or playerID == nil\n    or type(Argus) ~= \"table\"\n    or type(Argus.getTethersOnEnt) ~= \"function\" then\n  return\nend\n\ndata.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal root = data.string_dsr\nlocal state = root.p4Mirage\nif round == 1 and (type(state) ~= \"table\" or tonumber(state.version) ~= 2) then\n  local roleNames = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\n  local roleIDs = {}\n  local roleByID = {}\n  for _, roleName in ipairs(roleNames) do\n    local id = tonumber(party[roleName] and party[roleName].id)\n    if id == nil or roleByID[id] ~= nil then\n      return\n    end\n    roleIDs[roleName] = id\n    roleByID[id] = roleName\n  end\n  state = {\n    version = 2,\n    roleIDs = roleIDs,\n    roleByID = roleByID,\n    homeSlotByID = {},\n    logicalSlotByID = {},\n    rounds = {},\n  }\n  state.homeSlotByID[roleIDs.MT] = 1\n  state.homeSlotByID[roleIDs.ST] = 2\n  state.homeSlotByID[roleIDs.H1] = 3\n  state.homeSlotByID[roleIDs.H2] = 4\n  state.logicalSlotByID[roleIDs.MT] = 1\n  state.logicalSlotByID[roleIDs.ST] = 2\n  state.logicalSlotByID[roleIDs.H1] = 3\n  state.logicalSlotByID[roleIDs.H2] = 4\n  root.p4Mirage = state\nend\nif type(state) ~= \"table\"\n    or tonumber(state.version) ~= 2\n    or type(state.roleIDs) ~= \"table\"\n    or type(state.roleByID) ~= \"table\"\n    or type(state.logicalSlotByID) ~= \"table\"\n    or type(state.rounds) ~= \"table\" then\n  return\nend\n\nlocal roundState = state.rounds[round]\nif type(roundState) ~= \"table\" then\n  roundState = {}\n  state.rounds[round] = roundState\nend\n\nif roundState.ready ~= true then\n  local targets = {}\n  local seen = {}\n  local entities = TensorCore.entityList(\"contentid=3458\")\n  for _, entity in pairs(type(entities) == \"table\" and entities or {}) do\n    local casting = entity and entity.castinginfo or nil\n    local lastCastID = tonumber(casting and casting.lastcastid)\n    local sinceCast = tonumber(casting and casting.timesincecast)\n    local function addTarget(rawID)\n      local targetID = tonumber(rawID)\n      if targetID ~= nil and targetID ~= 0\n          and state.roleByID[targetID] ~= nil\n          and tonumber(state.logicalSlotByID[targetID]) ~= nil\n          and seen[targetID] ~= true then\n        seen[targetID] = true\n        targets[#targets + 1] = targetID\n      end\n    end\n    if tonumber(casting and casting.castingid) == 26820\n        and type(casting.castingtargets) == \"table\" then\n      for _, targetID in ipairs(casting.castingtargets) do\n        addTarget(targetID)\n      end\n    end\n    if lastCastID == 26820\n        and sinceCast ~= nil and sinceCast >= 0 and sinceCast <= 1600 then\n      addTarget(entity and entity.targetid)\n    end\n  end\n  if #targets == 2 then\n    table.sort(targets, function(a, b)\n      return tonumber(state.logicalSlotByID[a]) < tonumber(state.logicalSlotByID[b])\n    end)\n    local targetA = targets[1]\n    local targetB = targets[2]\n    local slotA = tonumber(state.logicalSlotByID[targetA])\n    local slotB = tonumber(state.logicalSlotByID[targetB])\n    if slotA ~= nil and slotB ~= nil and slotA ~= slotB then\n      local swapperA\n      local swapperB\n      if round == 1 then\n        swapperA = tonumber(state.roleIDs.D1)\n        swapperB = tonumber(state.roleIDs.D2)\n      elseif round == 2 then\n        swapperA = tonumber(state.roleIDs.D3)\n        swapperB = tonumber(state.roleIDs.D4)\n      elseif round == 3 then\n        local firstTargets = state.firstRoundTargets\n        local homeSlotByID = state.homeSlotByID\n        if type(firstTargets) == \"table\"\n            and #firstTargets == 2\n            and type(homeSlotByID) == \"table\" then\n          swapperA = tonumber(firstTargets[1])\n          swapperB = tonumber(firstTargets[2])\n          local homeA = tonumber(homeSlotByID[swapperA])\n          local homeB = tonumber(homeSlotByID[swapperB])\n          if homeA ~= nil and homeB ~= nil and homeA > homeB then\n            swapperA, swapperB = swapperB, swapperA\n          end\n        end\n      end\n      if swapperA ~= nil and swapperB ~= nil and swapperA ~= swapperB then\n        roundState.targets = { targetA, targetB }\n        roundState.assignments = {\n          [swapperA] = { targetID = targetA, slot = slotA },\n          [swapperB] = { targetID = targetB, slot = slotB },\n        }\n        roundState.ready = true\n        roundState.snapshotSource = \"recent_cast_targets\"\n        state.logicalSlotByID[swapperA] = slotA\n        state.logicalSlotByID[swapperB] = slotB\n        if round == 1 then\n          state.firstRoundTargets = { targetA, targetB }\n        end\n      end\n    end\n  end\nend\n\nlocal assignments = roundState.assignments\nif roundState.ready ~= true or type(assignments) ~= \"table\" then\n  return\nend\n\nlocal function currentTether(id)\n  for _, tether in ipairs(Argus.getTethersOnEnt(id) or {}) do\n    local tetherType = tonumber(tether.type)\n    if tetherType == 51 or tetherType == 52 then\n      return tetherType\n    end\n  end\nend\n\nlocal slotCoordinates = {\n  [1] = { 85, 95 },\n  [2] = { 95, 95 },\n  [3] = { 95, 105 },\n  [4] = { 85, 105 },\n}\n\nlocal targetX\nlocal targetZ\nlocal ownAssignment = assignments[playerID]\nif type(ownAssignment) == \"table\" then\n  local tetherType = currentTether(playerID)\n  if tetherType == 51 then\n    local target = TensorCore.mGetEntity(tonumber(ownAssignment.targetID))\n    local pos = target and target.pos or nil\n    targetX = tonumber(pos and pos.x)\n    targetZ = tonumber(pos and pos.z)\n  elseif tetherType == 52 then\n    local spot = slotCoordinates[tonumber(ownAssignment.slot)]\n    if spot then\n      targetX, targetZ = spot[1], spot[2]\n    end\n  end\nelse\n  local targetAssignment\n  for _, assignment in pairs(assignments) do\n    if tonumber(assignment and assignment.targetID) == playerID then\n      targetAssignment = assignment\n      break\n    end\n  end\n  if type(targetAssignment) == \"table\" then\n    local tetherType = currentTether(playerID)\n    if tetherType == 52 then\n      local spot = slotCoordinates[tonumber(targetAssignment.slot)]\n      if spot then\n        targetX, targetZ = spot[1], spot[2]\n      end\n    elseif tetherType == 51 then\n      targetX, targetZ = 90, 100\n    end\n  end\nend\n\nif type(targetX) == \"number\" and type(targetZ) == \"number\" then\n  guide.FrameDirect(targetX, targetZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "第3轮双目标快照与 MuAi 换线指路",
							uuid = "60f4d541-6a5d-872c-bb3e-4ae0345e392b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 809.8,
				name = "[P4] 幻象冲3换线动态指路",
				timeRange = true,
				timelineIndex = 131,
				timerEndOffset = 5,
				uuid = "eed13bad-958e-19b2-9ff4-44d51d7d656b",
				version = 2,
			},
		},
	},
	[132] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"01487e23-0527-6ef4-a67a-0b99da7d2f8b",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetType = "Enemy",
							uuid = "03b32b10-cf00-ae3b-bea0-c63c8a7c288c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "01487e23-0527-6ef4-a67a-0b99da7d2f8b",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 814.9,
				name = "[P4] 自动目标：Eyes P4-2",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 132,
				timerEndOffset = 25,
				timerStartOffset = -10,
				uuid = "d24269e0-5125-0eb9-a0f2-46dd66f894d7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\"\n    or type(Argus) ~= \"table\"\n    or type(Argus.getTethersOnEnt) ~= \"function\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleIDs = {}\nlocal seenIDs = {}\nlocal redIDs = {}\nfor i = 1, #roles do\n  local role = roles[i]\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or seenIDs[id] then\n    return\n  end\n  seenIDs[id] = true\n  roleIDs[role] = id\n\n  local isRed = false\n  for _, tether in ipairs(Argus.getTethersOnEnt(id) or {}) do\n    if tonumber(tether.type) == 52 then\n      isRed = true\n      break\n    end\n  end\n  if isRed then\n    redIDs[#redIDs + 1] = id\n  end\nend\nif #redIDs ~= 4 then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer == nil then\n  return\nend\nfor i = 1, #redIDs do\n  drawer:addTimedCircleOnEnt(2000, redIDs[i], 4)\nend\nself.used = true",
							endIfUsed = true,
							name = "第4轮红线四人 4m 范围",
							uuid = "737ea997-286e-9c0e-96c1-e4d5c8fcabb6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 814.9,
				name = "[P4] 幻象冲4红线四人范围",
				timelineIndex = 132,
				timerOffset = -2,
				uuid = "eb62a637-07b4-c5b7-8059-d5a7ea1413ad",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local targetID = tonumber(eventArgs.targetID)\nif targetID == nil then\n  return\nend\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer ~= nil then\n  drawer:addTimedCircleOnEnt(2000, targetID, 1)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"69e319d3-1f5f-0c2b-9538-8ffc26f1e3ad",
									true,
								},
							},
							endIfUsed = true,
							name = "第4轮被撞目标 2s 小圈",
							uuid = "312374d7-64ba-6618-91c6-8fd0f8438a37",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26820,
							name = "Mirage Dive",
							uuid = "69e319d3-1f5f-0c2b-9538-8ffc26f1e3ad",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 814.9,
				name = "[P4] 幻象冲4双目标小圈",
				timeRange = true,
				timelineIndex = 132,
				timerEndOffset = 0.3,
				timerStartOffset = -0.2,
				uuid = "0f8be4ea-ddc7-0c53-a200-3e30b73583b9",
				version = 2,
			},
		},
	},
	[133] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"384ad132-3031-7f5f-a77d-e103a2077505",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "421d4bd0-be26-8234-8e3e-fc76e63b29c9",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"4f78e2a8-bcd1-f1a5-8645-996ff36f2c56",
									true,
								},
								
								{
									"dabf06db-013f-5268-a106-09a9bc4c707f",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "2a889fd1-b957-b359-846f-e069f2b01d79",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"d322ff6b-82b5-7443-a035-31230db541b5",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "fccac141-fd32-3be4-8d39-43fba86742d9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "dabf06db-013f-5268-a106-09a9bc4c707f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "384ad132-3031-7f5f-a77d-e103a2077505",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "4f78e2a8-bcd1-f1a5-8645-996ff36f2c56",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "d322ff6b-82b5-7443-a035-31230db541b5",
							version = 3,
						},
					},
				},
				mechanicTime = 824.7,
				name = "[P4] 近战个人减伤",
				timelineIndex = 133,
				timerOffset = -3,
				uuid = "12144de9-42b6-9da5-b8bc-b258b755fabc",
				version = 2,
			},
		},
	},
	[135] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"0654970e-98fc-d262-aaf3-2c7a13c06c95",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetType = "Enemy",
							uuid = "57b30b2f-7045-a64a-bd5c-776ba244a01a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "0654970e-98fc-d262-aaf3-2c7a13c06c95",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 900,
				name = "[P4] 自动目标：Eyes P4-3",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 135,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "d8c7c8e1-526d-0a30-b3d6-3bb76b56e885",
				version = 2,
			},
		},
	},
	[139] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal ppos = player and player.pos or nil\nif type(party) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(ppos) ~= \"table\" then\n  return\nend\n\nlocal H1ID = tonumber(party.H1 and party.H1.id)\nlocal H2ID = tonumber(party.H2 and party.H2.id)\nlocal D3ID = tonumber(party.D3 and party.D3.id)\nlocal D4ID = tonumber(party.D4 and party.D4.id)\nlocal D1ID = tonumber(party.D1 and party.D1.id)\nlocal D2ID = tonumber(party.D2 and party.D2.id)\nlocal MTID = tonumber(party.MT and party.MT.id)\nlocal STID = tonumber(party.ST and party.ST.id)\nlocal knownRole = playerID == H1ID or playerID == H2ID\n  or playerID == D3ID or playerID == D4ID\n  or playerID == D1ID or playerID == D2ID\n  or playerID == MTID or playerID == STID\nif not knownRole or H1ID == nil or H2ID == nil or H1ID == H2ID then\n  return\nend\n\nlocal px = tonumber(ppos.x)\nlocal pz = tonumber(ppos.z)\nif px == nil or pz == nil then\n  return\nend\n\nlocal targetX = 89\nlocal targetZ = 100\nif playerID == H1ID or playerID == H2ID then\n  local frontDX = px - 90.55\n  local frontDZ = pz - 106.75\n  local backDX = px - 87.45\n  local backDZ = pz - 106.75\n  if frontDX * frontDX + frontDZ * frontDZ\n      <= backDX * backDX + backDZ * backDZ then\n    targetX = 90.55\n    targetZ = 106.75\n  else\n    targetX = 87.45\n    targetZ = 106.75\n  end\n\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							name = "H1H2 阶段动态指路",
							uuid = "50c09ce8-3e93-4cd5-9f5d-a9ad876a43df",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 915.9,
				name = "[P4.5] 纯净心灵引导 H1H2",
				timeRange = true,
				timelineIndex = 139,
				timerStartOffset = -15.9,
				uuid = "1c7bb104-163b-f777-a8b8-8ee2c36469ae",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal firstID = type(party) == \"table\" and tonumber(party.H1 and party.H1.id) or nil\nlocal secondID = type(party) == \"table\" and tonumber(party.H2 and party.H2.id) or nil\nif firstID == nil or secondID == nil or firstID == secondID then\n  return\nend\n\nlocal charibert = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3642, subgroup = \"Nearest\" })\nlocal charibertID = tonumber(charibert and charibert.id)\nif charibertID == nil then\n  return\nend\nstate.p1PureCharibertID = charibertID\n\nlocal drawer = state.p1PureHealerDrawer\nif drawer == nil then\n  drawer = TensorCore.getStaticDrawer(\n    GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.4))\n  state.p1PureHealerDrawer = drawer\nend\n\ndrawer:addTimedConeOnEnt(\n  15900, charibertID, 18, math.rad(30), firstID, 0, false, false)\ndrawer:addTimedConeOnEnt(\n  15900, charibertID, 18, math.rad(30), secondID, 0, false, false)\nself.used = true",
							name = "绘制 H1H2 绿色跟随扇形",
							uuid = "de55b175-785f-a2e1-b828-0ba718c9c18b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 915.9,
				name = "[P4.5] 光翼闪扇形 H1H2（绿）",
				timelineIndex = 139,
				timerOffset = -15.89999961853,
				uuid = "99ceec8a-7aac-c289-af8f-5f77e1dffbc1",
				version = 2,
			},
		},
	},
	[140] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"cbac0eab-d232-afc2-8121-580da8495957",
									true,
								},
								
								{
									"31bdbde2-36be-2adf-b119-e5d4b54440e6",
									true,
								},
								
								{
									"cd92b68f-f420-1a4b-bb88-e2c4601a4233",
									true,
								},
								
								{
									"aeb34e53-2add-a8f8-9b59-7cba35dc3eb7",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "8292a029-2463-33d4-ae04-4f41fa1ba170",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "cbac0eab-d232-afc2-8121-580da8495957",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1934,
							category = "Self",
							uuid = "31bdbde2-36be-2adf-b119-e5d4b54440e6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1951,
							category = "Self",
							uuid = "cd92b68f-f420-1a4b-bb88-e2c4601a4233",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1826,
							category = "Self",
							uuid = "aeb34e53-2add-a8f8-9b59-7cba35dc3eb7",
							version = 3,
						},
					},
				},
				enabled = false,
				mechanicTime = 920.9,
				name = "[P4] 远敏团队减伤",
				timelineIndex = 140,
				timerOffset = -3,
				uuid = "0ba2c667-f88d-9228-abfa-dca3b972e941",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal ppos = player and player.pos or nil\nif type(party) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(ppos) ~= \"table\" then\n  return\nend\n\nlocal H1ID = tonumber(party.H1 and party.H1.id)\nlocal H2ID = tonumber(party.H2 and party.H2.id)\nlocal D3ID = tonumber(party.D3 and party.D3.id)\nlocal D4ID = tonumber(party.D4 and party.D4.id)\nlocal D1ID = tonumber(party.D1 and party.D1.id)\nlocal D2ID = tonumber(party.D2 and party.D2.id)\nlocal MTID = tonumber(party.MT and party.MT.id)\nlocal STID = tonumber(party.ST and party.ST.id)\nlocal knownRole = playerID == H1ID or playerID == H2ID\n  or playerID == D3ID or playerID == D4ID\n  or playerID == D1ID or playerID == D2ID\n  or playerID == MTID or playerID == STID\nif not knownRole or D3ID == nil or D4ID == nil or D3ID == D4ID then\n  return\nend\n\nlocal px = tonumber(ppos.x)\nlocal pz = tonumber(ppos.z)\nif px == nil or pz == nil then\n  return\nend\n\nlocal targetX = 89\nlocal targetZ = 100\nif playerID == D3ID or playerID == D4ID then\n  local frontDX = px - 90.55\n  local frontDZ = pz - 106.75\n  local backDX = px - 87.45\n  local backDZ = pz - 106.75\n  if frontDX * frontDX + frontDZ * frontDZ\n      <= backDX * backDX + backDZ * backDZ then\n    targetX = 90.55\n    targetZ = 106.75\n  else\n    targetX = 87.45\n    targetZ = 106.75\n  end\nelseif playerID == H1ID or playerID == H2ID then\n  targetX = 82\n  targetZ = 100\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							name = "D3D4 阶段动态指路",
							uuid = "e29e58a5-7c54-7d9f-9908-3a2158968fb5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 920.9,
				name = "[P4.5] 纯净心灵引导 D3D4",
				timeRange = true,
				timelineIndex = 140,
				timerStartOffset = -5,
				uuid = "347c72c6-b525-0906-a75e-7f13be592a1f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal firstID = type(party) == \"table\" and tonumber(party.D3 and party.D3.id) or nil\nlocal secondID = type(party) == \"table\" and tonumber(party.D4 and party.D4.id) or nil\nif firstID == nil or secondID == nil or firstID == secondID then\n  return\nend\n\nlocal charibert = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3642, subgroup = \"Nearest\" })\nlocal charibertID = tonumber(charibert and charibert.id)\nif charibertID == nil then\n  return\nend\nstate.p1PureCharibertID = charibertID\n\nlocal drawer = state.p1PureRangedDrawer\nif drawer == nil then\n  drawer = TensorCore.getStaticDrawer(\n    GUI:ColorConvertFloat4ToU32(1, 0.6470588235, 0, 0.4))\n  state.p1PureRangedDrawer = drawer\nend\n\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), firstID, 0, false, false)\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), secondID, 0, false, false)\nself.used = true",
							name = "绘制 D3D4 橙色跟随扇形",
							uuid = "a7074e7c-3d1d-ba17-bc37-e6d75776c558",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 920.9,
				name = "[P4.5] 光翼闪扇形 D3D4（橙）",
				timelineIndex = 140,
				timerOffset = -5,
				uuid = "e0b6aeb3-5b29-ab16-b5bb-f5d5750f6416",
				version = 2,
			},
		},
	},
	[142] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal ppos = player and player.pos or nil\nif type(party) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(ppos) ~= \"table\" then\n  return\nend\n\nlocal H1ID = tonumber(party.H1 and party.H1.id)\nlocal H2ID = tonumber(party.H2 and party.H2.id)\nlocal D3ID = tonumber(party.D3 and party.D3.id)\nlocal D4ID = tonumber(party.D4 and party.D4.id)\nlocal D1ID = tonumber(party.D1 and party.D1.id)\nlocal D2ID = tonumber(party.D2 and party.D2.id)\nlocal MTID = tonumber(party.MT and party.MT.id)\nlocal STID = tonumber(party.ST and party.ST.id)\nlocal knownRole = playerID == H1ID or playerID == H2ID\n  or playerID == D3ID or playerID == D4ID\n  or playerID == D1ID or playerID == D2ID\n  or playerID == MTID or playerID == STID\nif not knownRole or D1ID == nil or D2ID == nil or D1ID == D2ID then\n  return\nend\n\nlocal px = tonumber(ppos.x)\nlocal pz = tonumber(ppos.z)\nif px == nil or pz == nil then\n  return\nend\n\nlocal targetX = 89\nlocal targetZ = 100\nif playerID == D1ID or playerID == D2ID then\n  local frontDX = px - 90.55\n  local frontDZ = pz - 106.75\n  local backDX = px - 87.45\n  local backDZ = pz - 106.75\n  if frontDX * frontDX + frontDZ * frontDZ\n      <= backDX * backDX + backDZ * backDZ then\n    targetX = 90.55\n    targetZ = 106.75\n  else\n    targetX = 87.45\n    targetZ = 106.75\n  end\nelseif playerID == D3ID or playerID == D4ID then\n  targetX = 96\n  targetZ = 101.5\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							name = "D1D2 阶段动态指路",
							uuid = "7656bf30-792a-081b-9b38-2e87c8c2b0de",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 925.9,
				name = "[P4.5] 纯净心灵引导 D1D2",
				timeRange = true,
				timelineIndex = 142,
				timerStartOffset = -5,
				uuid = "ad89cfa4-6a77-bfd8-a9c6-6a16960ac255",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal firstID = type(party) == \"table\" and tonumber(party.D1 and party.D1.id) or nil\nlocal secondID = type(party) == \"table\" and tonumber(party.D2 and party.D2.id) or nil\nif firstID == nil or secondID == nil or firstID == secondID then\n  return\nend\n\nlocal charibert = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3642, subgroup = \"Nearest\" })\nlocal charibertID = tonumber(charibert and charibert.id)\nif charibertID == nil then\n  return\nend\nstate.p1PureCharibertID = charibertID\n\nlocal drawer = state.p1PureMeleeDrawer\nif drawer == nil then\n  drawer = TensorCore.getStaticDrawer(\n    GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.4))\n  state.p1PureMeleeDrawer = drawer\nend\n\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), firstID, 0, false, false)\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), secondID, 0, false, false)\nself.used = true",
							name = "绘制 D1D2 红色跟随扇形",
							uuid = "9684f2a7-e701-76c2-ade9-c537ed65bea3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 925.9,
				name = "[P4.5] 光翼闪扇形 D1D2（红）",
				timelineIndex = 142,
				timerOffset = -5,
				uuid = "409a4ad8-3a54-ba4b-824a-db3261777746",
				version = 2,
			},
		},
	},
	[144] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal ppos = player and player.pos or nil\nif type(party) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(ppos) ~= \"table\" then\n  return\nend\n\nlocal H1ID = tonumber(party.H1 and party.H1.id)\nlocal H2ID = tonumber(party.H2 and party.H2.id)\nlocal D3ID = tonumber(party.D3 and party.D3.id)\nlocal D4ID = tonumber(party.D4 and party.D4.id)\nlocal D1ID = tonumber(party.D1 and party.D1.id)\nlocal D2ID = tonumber(party.D2 and party.D2.id)\nlocal MTID = tonumber(party.MT and party.MT.id)\nlocal STID = tonumber(party.ST and party.ST.id)\nlocal knownRole = playerID == H1ID or playerID == H2ID\n  or playerID == D3ID or playerID == D4ID\n  or playerID == D1ID or playerID == D2ID\n  or playerID == MTID or playerID == STID\nif not knownRole or MTID == nil or STID == nil or MTID == STID then\n  return\nend\n\nlocal px = tonumber(ppos.x)\nlocal pz = tonumber(ppos.z)\nif px == nil or pz == nil then\n  return\nend\n\nlocal targetX = 89\nlocal targetZ = 100\nif playerID == MTID or playerID == STID then\n  local frontDX = px - 90.55\n  local frontDZ = pz - 106.75\n  local backDX = px - 87.45\n  local backDZ = pz - 106.75\n  if frontDX * frontDX + frontDZ * frontDZ\n      <= backDX * backDX + backDZ * backDZ then\n    targetX = 90.55\n    targetZ = 106.75\n  else\n    targetX = 87.45\n    targetZ = 106.75\n  end\nelseif playerID == D1ID or playerID == D2ID then\n  targetX = 82\n  targetZ = 97\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							name = "MTST 阶段动态指路",
							uuid = "d0124ffd-cc1f-104a-9fe9-1ce90381406b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 930.9,
				name = "[P4.5] 纯净心灵引导 MTST",
				timeRange = true,
				timelineIndex = 144,
				timerStartOffset = -5,
				uuid = "9d12ef97-2840-f09a-a961-0145ec542097",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal state = data.string_dsr\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nlocal firstID = type(party) == \"table\" and tonumber(party.MT and party.MT.id) or nil\nlocal secondID = type(party) == \"table\" and tonumber(party.ST and party.ST.id) or nil\nif firstID == nil or secondID == nil or firstID == secondID then\n  return\nend\n\nlocal charibert = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3642, subgroup = \"Nearest\" })\nlocal charibertID = tonumber(charibert and charibert.id)\nif charibertID == nil then\n  return\nend\nstate.p1PureCharibertID = charibertID\n\nlocal drawer = state.p1PureTankDrawer\nif drawer == nil then\n  drawer = TensorCore.getStaticDrawer(\n    GUI:ColorConvertFloat4ToU32(0, 0, 1, 0.4))\n  state.p1PureTankDrawer = drawer\nend\n\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), firstID, 0, false, false)\ndrawer:addTimedConeOnEnt(\n  5000, charibertID, 18, math.rad(30), secondID, 0, false, false)\nself.used = true",
							name = "绘制 MTST 蓝色跟随扇形",
							uuid = "72bcc6a6-1fb1-a363-b5e2-33dd10b79058",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 930.9,
				name = "[P4.5] 光翼闪扇形 MTST（蓝）",
				timelineIndex = 144,
				timerOffset = -5,
				uuid = "d7f1ad9f-9456-096c-9f76-2f91b9368fc3",
				version = 2,
			},
		},
	},
	[146] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"c1da9eb1-e789-9234-970e-3ecea606f516",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetType = "Enemy",
							uuid = "e30aac99-8149-1e99-bc2d-34b60691daf2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "c1da9eb1-e789-9234-970e-3ecea606f516",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 935.9,
				name = "[P4] 自动目标：Eyes P4-4",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 146,
				timerEndOffset = 10,
				timerStartOffset = 1,
				uuid = "e5488f2d-a350-34da-b89b-bf547bd2e69a",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							conditions = 
							{
								
								{
									"ec69e208-8df3-7e97-a9b2-e6ebb4ba9f75",
									true,
								},
								
								{
									"2741a413-ef7e-9a30-afc5-e42493e6ef6a",
									true,
								},
							},
							endIfUsed = true,
							name = "牵制",
							targetType = "Current Target",
							uuid = "1428ac3a-de2a-daed-a1b0-0c8f6a5fd9a6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Feint check",
							uuid = "2741a413-ef7e-9a30-afc5-e42493e6ef6a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
								22,
								30,
								34,
								39,
								41,
							},
							name = "牵制职业",
							uuid = "ec69e208-8df3-7e97-a9b2-e6ebb4ba9f75",
							version = 3,
						},
					},
				},
				mechanicTime = 935.9,
				name = "[P4] 牵制",
				timelineIndex = 146,
				timerOffset = -10,
				uuid = "838b0ed8-2de8-5f45-869d-143225fe0021",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2887,
							conditions = 
							{
								
								{
									"e6e5a170-5c33-c7fe-adca-2273bcefd17f",
									true,
								},
								
								{
									"f51f514f-8939-86de-a6c4-4fff68f870c4",
									true,
								},
							},
							endIfUsed = true,
							name = "武装解除",
							targetType = "Current Target",
							uuid = "aadf673d-7994-93b2-9ea9-1c52741a03ff",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 860,
							name = "Dismantle check",
							uuid = "f51f514f-8939-86de-a6c4-4fff68f870c4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								31,
							},
							name = "武装解除职业",
							uuid = "e6e5a170-5c33-c7fe-adca-2273bcefd17f",
							version = 3,
						},
					},
				},
				mechanicTime = 935.9,
				name = "[P4] 武装解除",
				randomTimeout = 8,
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 146,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "5ef9551a-c230-5c9d-b2dc-cc40cb39819f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"229d0dff-f035-0f2e-802e-2fa7744de825",
									true,
								},
								
								{
									"f28b3508-072a-b493-900a-597f096c2027",
									true,
								},
							},
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "06c37ef9-2af9-00c2-bd98-3a4a486ed366",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "229d0dff-f035-0f2e-802e-2fa7744de825",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 6,
							buffIDList = 
							{
								1826,
								1951,
								1934,
							},
							category = "Self",
							name = "Missing Buffs",
							uuid = "f28b3508-072a-b493-900a-597f096c2027",
							version = 3,
						},
					},
				},
				mechanicTime = 935.9,
				name = "[P4] 远敏团队减伤",
				timeRange = true,
				timelineIndex = 146,
				timerEndOffset = -1.5,
				timerStartOffset = -15,
				uuid = "5c9bfc9a-0292-6932-b9d1-ea88b6bd56d9",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7560,
							conditions = 
							{
								
								{
									"b4a9553a-2146-3df3-b5eb-cbaabe180042",
									true,
								},
								
								{
									"200b7780-b67a-9f73-a848-abce9693c791",
									true,
								},
							},
							endIfUsed = true,
							name = "昏乱",
							targetType = "Current Target",
							uuid = "ab34a0ed-a69b-5712-8456-9fb68f9b3dc9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1203,
							name = "Addle check",
							uuid = "200b7780-b67a-9f73-a848-abce9693c791",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
								27,
								35,
								42,
							},
							name = "昏乱职业",
							uuid = "b4a9553a-2146-3df3-b5eb-cbaabe180042",
							version = 3,
						},
					},
				},
				mechanicTime = 935.9,
				name = "[P4] 昏乱",
				timelineIndex = 146,
				timerOffset = -10,
				uuid = "3ff1681a-36c4-3a99-9fb2-9f546a151174",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"591ca473-386a-46fc-9ac4-7d878e9e06aa",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "cfa0d63a-aa41-3151-9546-1c18fb1179de",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"2434fb16-c675-a522-be43-6f5ecb873758",
									true,
								},
								
								{
									"cf457286-52a9-a0d7-ab73-c7ba30c66849",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "12637daa-bda9-968b-b554-7aa3dbc587e4",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"f7f289c1-a1f0-a787-878f-34f2da53462e",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "a7738ade-d700-ee84-a3e6-9d9b786e6d61",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "cf457286-52a9-a0d7-ab73-c7ba30c66849",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "591ca473-386a-46fc-9ac4-7d878e9e06aa",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "2434fb16-c675-a522-be43-6f5ecb873758",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "f7f289c1-a1f0-a787-878f-34f2da53462e",
							version = 3,
						},
					},
				},
				mechanicTime = 935.9,
				name = "[P4] 近战个人减伤",
				timelineIndex = 146,
				timerOffset = -3,
				uuid = "17e6cb60-f526-abff-8f10-f0b888ad2b31",
				version = 2,
			},
		},
	},
	[150] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"9c01851e-f8fb-7150-b568-e178867ec196",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetType = "Enemy",
							uuid = "5950d6e3-c582-944b-b21f-6c81d3480450",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "9c01851e-f8fb-7150-b568-e178867ec196",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 996,
				name = "[P4] 自动目标：Eyes P4-5",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 150,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "1b09c2b1-08ba-ad54-8b60-4fdf29761c38",
				version = 2,
			},
		},
	},
	[156] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\ndata.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\ndata.string_dsr.eyePos = nil\ndata.string_dsr.cometCount = nil\ndata.string_dsr.cometsArmed = nil\ndata.string_dsr.drawnExaflares = nil\ndata.string_dsr.p5WrathMarkerID = nil\ndata.string_dsr.p5WrathCauterizeID = nil\ndata.string_dsr.p5WrathLiquidID = nil\ndata.string_dsr.p5WrathLiquidSide = nil\ndata.string_dsr.p5WrathAltarID = nil\ndata.string_dsr.p5WrathAltarSide = nil\ndata.string_dsr.p5WrathThunderID1 = nil\ndata.string_dsr.p5WrathThunderID2 = nil\ndata.string_dsr.p5WrathThunderLeftID = nil\ndata.string_dsr.p5WrathThunderRightID = nil\ndata.string_dsr.p5WrathThunderScanBucket = nil\ndata.string_dsr.p5WrathWarriorID = nil\nself.used = true",
							endIfUsed = true,
							name = "Unlock face and reset phase state",
							uuid = "a21b2870-fb66-7044-be55-1e81c8e38d8e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1034.3,
				name = "[P5] 换相清理",
				timeRange = true,
				timelineIndex = 156,
				timerEndOffset = 0.5,
				timerStartOffset = -0.5,
				uuid = "585828dd-afa4-86bd-a2df-0e26f0524b16",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal root = data.string_dsr\nroot.p5WrathThunderID1 = nil\nroot.p5WrathThunderID2 = nil\nroot.p5WrathThunderLeftID = nil\nroot.p5WrathThunderRightID = nil\n\nlocal firstID\nlocal firstDuration\nlocal secondID\nlocal secondDuration\nlocal count = 0\nfor _, member in pairs(TensorCore.getEntityGroupList(\"Party\") or {}) do\n  local memberID = tonumber(member and member.id)\n  if memberID ~= nil and member.alive ~= false then\n    local buff = TensorCore.getBuff(member, 2833)\n    local remaining = tonumber(buff and buff.duration)\n    if remaining ~= nil and remaining > 0 then\n      count = count + 1\n      if count == 1 then\n        firstID = memberID\n        firstDuration = remaining\n      elseif count == 2 then\n        secondID = memberID\n        secondDuration = remaining\n      else\n        return\n      end\n    end\n  end\nend\n\nif count ~= 2\n    or firstID == nil\n    or secondID == nil\n    or firstID == secondID\n    or firstDuration == nil\n    or secondDuration == nil then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer == nil then\n  return\nend\n\nroot.p5WrathThunderID1 = firstID\nroot.p5WrathThunderID2 = secondID\ndrawer:addTimedCircleOnEnt(\n  math.ceil(firstDuration * 1000),\n  firstID,\n  5)\ndrawer:addTimedCircleOnEnt(\n  math.ceil(secondDuration * 1000),\n  secondID,\n  5)\nself.used = true",
							endIfUsed = true,
							name = "记录两名雷翼目标并按剩余时间绘制",
							uuid = "4bba5c44-3876-0ca5-b9d5-6cd55f97bdba",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1034.3,
				name = "[P5] 雷电链两目标范围",
				timeRange = true,
				timelineIndex = 156,
				timerEndOffset = 3,
				timerStartOffset = 1.25,
				uuid = "31d3a0a5-843a-eaf5-ace5-d6030bca6454",
				version = 2,
			},
		},
	},
	[157] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local grouped = Argus and Argus.getCurrentTethers\n  and Argus.getCurrentTethers() or nil\nif type(grouped) ~= \"table\" then\n  return\nend\n\nlocal expected = {\n  [3638] = true,\n  [3636] = true,\n}\nlocal pairsByContentID = {}\nfor sourceKey, tethers in pairs(grouped) do\n  local sourceID = tonumber(sourceKey)\n  local source = sourceID and TensorCore.mGetEntity(sourceID) or nil\n  local contentID = tonumber(source and source.contentid)\n  if expected[contentID] and type(tethers) == \"table\" then\n    for _, tether in pairs(tethers) do\n      local tetherType = tonumber(tether and tether.type)\n      local targetID = tonumber(tether and tether.targetid)\n      if tetherType == 5 and targetID ~= nil then\n        pairsByContentID[contentID] = {\n          sourceID = sourceID,\n          targetID = targetID,\n        }\n        break\n      end\n    end\n  end\nend\n\nlocal ordered = {\n  pairsByContentID[3638],\n  pairsByContentID[3636],\n}\nfor i = 1, 2 do\n  local pair = ordered[i]\n  local source = pair and TensorCore.mGetEntity(pair.sourceID) or nil\n  local target = pair and TensorCore.mGetEntity(pair.targetID) or nil\n  if source == nil or target == nil\n      or type(source.pos) ~= \"table\"\n      or type(target.pos) ~= \"table\" then\n    return\n  end\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif drawer == nil or type(drawer.addTimedRectOnEnt) ~= \"function\" then\n  return\nend\n\nlocal uuids = {}\nfor i = 1, 2 do\n  local pair = ordered[i]\n  local ok, uuid = pcall(function()\n    return drawer:addTimedRectOnEnt(\n      6200, pair.sourceID, 50, 16, pair.targetID, 0, true)\n  end)\n  if not ok or type(uuid) ~= \"string\" then\n    if Argus and type(Argus.deleteTimedShape) == \"function\" then\n      for j = 1, #uuids do\n        Argus.deleteTimedShape(uuids[j])\n      end\n    end\n    return\n  end\n  uuids[#uuids + 1] = uuid\nend\nself.used = true",
							endIfUsed = true,
							name = "从当前两条红线一次绘制两块矩形",
							uuid = "49c55034-51b7-2aa9-9edb-4296ada379ff",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1036.7,
				name = "[P5] 螺旋枪两线矩形",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = -5.7,
				timerOffset = -6.2,
				timerStartOffset = -6.2,
				uuid = "5d3e62e7-812b-e44f-870e-f68965d87786",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local dragon\nlocal dragonCount = 0\nfor _, entity in pairs(TensorCore.entityList(\"contentid=3984\") or {}) do\n  local id = tonumber(entity and entity.id)\n  local pos = entity and entity.pos or nil\n  if id ~= nil\n      and entity.alive ~= false\n      and type(pos) == \"table\"\n      and type(pos.x) == \"number\"\n      and type(pos.z) == \"number\" then\n    dragon = entity\n    dragonCount = dragonCount + 1\n  end\nend\n\nif dragonCount ~= 1 then\n  return\nend\n\nlocal whiteDrawer = TensorCore.getCachedDrawer(\n  GUI:ColorConvertFloat4ToU32(1, 1, 1, 0.62),\n  GUI:ColorConvertFloat4ToU32(1, 1, 1, 0.32),\n  GUI:ColorConvertFloat4ToU32(1, 1, 1, 0.08),\n  GUI:ColorConvertFloat4ToU32(1, 1, 1, 0.95),\n  2)\nwhiteDrawer:addTimedRectOnEnt(6000, dragon.id, 60, 10)\nself.used = true",
							endIfUsed = true,
							name = "绘制白龙旋风冲",
							uuid = "c2479c4f-8852-e003-a5a0-a9cbbc8d8dd3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1036.7,
				name = "[P5] 白龙旋风冲",
				timelineIndex = 157,
				timerEndOffset = 70,
				timerOffset = -6,
				timerStartOffset = -10,
				uuid = "39e5acfd-1f9e-958e-98ee-c78f8c8db441",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local x = tonumber(eventArgs.x)\nlocal y = tonumber(eventArgs.y)\nlocal z = tonumber(eventArgs.z)\nlocal radius = tonumber(eventArgs.radius)\nif x ~= nil and y ~= nil and z ~= nil and radius ~= nil and radius > 0 then\n  local drawer = TensorCore.getCachedDrawer(\n    GUI:ColorConvertFloat4ToU32(0.05, 1, 0.25, 0.58),\n    GUI:ColorConvertFloat4ToU32(0.05, 1, 0.25, 0.34),\n    GUI:ColorConvertFloat4ToU32(0.02, 0.45, 0.12, 0.10),\n    GUI:ColorConvertFloat4ToU32(0.20, 1, 0.40, 0.92),\n    2)\n  drawer:addTimedCircle(5200, x, y, z, radius)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"de61c336-6db5-3176-adb7-218558d8cacc",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw actual green twister",
							uuid = "ff5c4c03-fabe-5741-ab77-a6b71d7a6d38",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 2001168,
							eventSpellID = 27531,
							name = "Twister ground effect",
							uuid = "de61c336-6db5-3176-adb7-218558d8cacc",
							version = 3,
						},
					},
				},
				eventType = 29,
				loop = true,
				mechanicTime = 1036.7,
				name = "[P5] 龙卷实际范围",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 6,
				timerStartOffset = 0.8,
				uuid = "7d61d476-e760-72fb-9da3-44d9a3eaa6e4",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local entityID = tonumber(eventArgs.entityID)\nif entityID ~= nil then\n  data.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\n  data.string_dsr.p5WrathMarkerID = entityID\n\n  local drawer = TensorCore.getCachedDrawer(\n    1207942497, 1207942497, 1207942497, 4205190917, 3)\n  drawer:addTimedCircleOnEnt(6200, entityID, 24, 0, false, true)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"adbaa188-4eaf-0b77-9723-2b74231b20ed",
									true,
								},
							},
							endIfUsed = true,
							name = "Capture marker and draw P2-style blue circle",
							uuid = "9cb442b9-7af9-7fad-b95c-285acc9a2202",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 14,
							name = "Marker 14",
							uuid = "adbaa188-4eaf-0b77-9723-2b74231b20ed",
							version = 3,
						},
					},
				},
				eventType = 4,
				mechanicTime = 1036.7,
				name = "[P5] 蓝标记范围",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 12,
				timerStartOffset = -10,
				uuid = "b25f731e-2f23-991c-a02f-1261b149c7a4",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal knight = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3639, subgroup = \"Nearest\" })\nif player and knight then\n  local drawer = TensorCore.getStaticDrawer(520093951)\n  drawer:addTimedArrowOnEnt(10000, player.id, 2, 1, 1, 1, knight.id)\n  drawer:addTimedCircleOnEnt(10000, knight.id, 6)\nend\nself.used = true",
							endIfUsed = true,
							name = "Draw arrow to warrior knight",
							uuid = "522be47b-741d-a2c7-ab59-d89c92766d51",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1036.7,
				name = "[P5] 战狂骑士定位箭头",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = -4.2,
				timerStartOffset = -5,
				uuid = "002dd079-dbe8-789d-b3c8-6a2e5efac969",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(Argus) ~= \"table\"\n    or type(Argus.getCurrentTethers) ~= \"function\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal members = {}\nlocal byID = {}\nfor i = 1, #roles do\n  local roleEntry = party[roles[i]]\n  local id = tonumber(roleEntry and roleEntry.id)\n  if id == nil or byID[id] ~= nil then\n    return\n  end\n\n  local entity = TensorCore.mGetEntity(id)\n  local pos = entity and entity.pos or nil\n  if entity == nil\n      or entity.alive == false\n      or type(pos) ~= \"table\"\n      or type(pos.x) ~= \"number\"\n      or type(pos.z) ~= \"number\" then\n    return\n  end\n\n  local member = { id = id, roleIndex = i, entity = entity }\n  members[#members + 1] = member\n  byID[id] = member\nend\n\nlocal dragon\nlocal dragonCount = 0\nfor _, entity in pairs(TensorCore.entityList(\"contentid=3984\") or {}) do\n  local id = tonumber(entity and entity.id)\n  local pos = entity and entity.pos or nil\n  if id ~= nil\n      and entity.alive ~= false\n      and type(pos) == \"table\"\n      and type(pos.x) == \"number\"\n      and type(pos.z) == \"number\" then\n    dragon = entity\n    dragonCount = dragonCount + 1\n  end\nend\nif dragonCount ~= 1 then\n  return\nend\n\nlocal centerX, centerZ = 100, 100\nlocal nx = dragon.pos.x - centerX\nlocal nz = dragon.pos.z - centerZ\nlocal nLength = math.sqrt(nx * nx + nz * nz)\nif nLength < 15 or nLength > 30 then\n  return\nend\nnx, nz = nx / nLength, nz / nLength\nlocal rx, rz = -nz, nx\n\nlocal root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal markerID = tonumber(root and root.p5WrathMarkerID)\nif markerID == nil or byID[markerID] == nil then\n  return\nend\n\nlocal tetherByTarget = {}\nlocal sourceSeen = {}\nlocal tetherCount = 0\nfor rawSourceID, tethers in pairs(Argus.getCurrentTethers() or {}) do\n  local sourceID = tonumber(rawSourceID)\n  local source = sourceID and TensorCore.mGetEntity(sourceID) or nil\n  local contentID = tonumber(source and source.contentid)\n  if sourceID ~= nil\n      and (contentID == 3636 or contentID == 3638)\n      and type(tethers) == \"table\" then\n    for _, tether in pairs(tethers) do\n      local targetID = tonumber(tether and tether.targetid)\n      if tonumber(tether and tether.type) == 5\n          and targetID ~= nil\n          and byID[targetID] ~= nil\n          and tetherByTarget[targetID] == nil\n          and sourceSeen[sourceID] ~= true then\n        tetherByTarget[targetID] = { source = source, sourceID = sourceID }\n        sourceSeen[sourceID] = true\n        tetherCount = tetherCount + 1\n      end\n    end\n  end\nend\nif tetherCount ~= 2 or tetherByTarget[markerID] ~= nil then\n  return\nend\n\nlocal targetX\nlocal targetZ\nif playerID == markerID then\n  local diagonal = math.sqrt(300)\n  targetX = centerX + nx * 10 - rx * diagonal\n  targetZ = centerZ + nz * 10 - rz * diagonal\nelseif tetherByTarget[playerID] ~= nil then\n  local source = tetherByTarget[playerID].source\n  local sourcePos = source and source.pos or nil\n  if type(sourcePos) ~= \"table\"\n      or type(sourcePos.x) ~= \"number\"\n      or type(sourcePos.z) ~= \"number\" then\n    return\n  end\n\n  local sourceSide =\n      (sourcePos.x - centerX) * rx + (sourcePos.z - centerZ) * rz\n  if math.abs(sourceSide) < 0.1 then\n    return\n  end\n\n  local sideSign = sourceSide > 0 and 1 or -1\n  local back = math.sqrt(336)\n  targetX = centerX - nx * back - rx * sideSign * 8\n  targetZ = centerZ - nz * back - rz * sideSign * 8\nelse\n  local idle = {}\n  for i = 1, #members do\n    local member = members[i]\n    if member.id ~= markerID and tetherByTarget[member.id] == nil then\n      idle[#idle + 1] = member\n    end\n  end\n  if #idle ~= 5 then\n    return\n  end\n\n  local forwardOffsets = { -6, -2, 2, 6, 10 }\n  local slots = {}\n  for i = 1, #forwardOffsets do\n    local forward = forwardOffsets[i]\n    local lateral = math.sqrt(400 - forward * forward)\n    slots[i] = {\n      x = centerX + nx * forward + rx * lateral,\n      z = centerZ + nz * forward + rz * lateral,\n    }\n  end\n\n  local memberUsed = {}\n  local slotUsed = {}\n  local assignment = {}\n  for _ = 1, 5 do\n    local bestMember\n    local bestSlot\n    local bestDistance\n    local bestRoleIndex\n    for i = 1, #idle do\n      if memberUsed[i] ~= true then\n        local pos = idle[i].entity.pos\n        for j = 1, #slots do\n          if slotUsed[j] ~= true then\n            local dx = pos.x - slots[j].x\n            local dz = pos.z - slots[j].z\n            local distance = dx * dx + dz * dz\n            local better = bestDistance == nil\n                or distance < bestDistance - 0.000001\n            if not better\n                and bestDistance ~= nil\n                and math.abs(distance - bestDistance) <= 0.000001 then\n              better = idle[i].roleIndex < bestRoleIndex\n                  or (idle[i].roleIndex == bestRoleIndex and j < bestSlot)\n            end\n            if better then\n              bestMember = i\n              bestSlot = j\n              bestDistance = distance\n              bestRoleIndex = idle[i].roleIndex\n            end\n          end\n        end\n      end\n    end\n\n    if bestMember == nil or bestSlot == nil then\n      return\n    end\n    memberUsed[bestMember] = true\n    slotUsed[bestSlot] = true\n    assignment[idle[bestMember].id] = slots[bestSlot]\n  end\n\n  local ownSlot = assignment[playerID]\n  if ownSlot == nil then\n    return\n  end\n  targetX, targetZ = ownSlot.x, ownSlot.z\nend\n\nif type(targetX) == \"number\" and type(targetZ) == \"number\" then\n  guide.FrameDirect(targetX, targetZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "MuAi opening assignment guidance",
							uuid = "8143f420-0d7c-f4d2-af27-c8ad29ce9397",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1036.7,
				name = "[P5] 一运开场动态指路",
				timeRange = true,
				timelineIndex = 157,
				timerStartOffset = -6.2,
				uuid = "b8488eb9-1b66-877a-b247-00864866d85d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal targetID = tonumber(eventArgs.entityID)\nif targetID ~= nil then\n  data.string_dsr.p5WrathCauterizeID = targetID\nend\n\nlocal player = TensorCore.mGetPlayer()\nlocal pos = player and player.pos or nil\nif type(pos) == \"table\"\n    and type(pos.x) == \"number\"\n    and type(pos.z) == \"number\" then\n  local greenDrawer = TensorCore.getCachedDrawer(\n    GUI:ColorConvertFloat4ToU32(0.05, 1, 0.25, 0.58),\n    GUI:ColorConvertFloat4ToU32(0.05, 1, 0.25, 0.34),\n    GUI:ColorConvertFloat4ToU32(0.02, 0.45, 0.12, 0.10),\n    GUI:ColorConvertFloat4ToU32(0.20, 1, 0.40, 0.92),\n    2)\n  greenDrawer:addTimedCircle(\n    1400, pos.x, tonumber(pos.y) or 0, pos.z, 1)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"937eb3f7-388f-3b33-b48a-ba274f0f3a39",
									true,
								},
							},
							endIfUsed = true,
							name = "缓存俯冲目标并静态快照自身旋风",
							uuid = "8454ffe0-3b32-2f96-b88e-d59908ba8bc2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 20,
							name = "Marker 20",
							uuid = "937eb3f7-388f-3b33-b48a-ba274f0f3a39",
							version = 3,
						},
					},
				},
				eventType = 4,
				mechanicTime = 1036.7,
				name = "[P5] 俯冲点名与旋风快照",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 0.5,
				timerStartOffset = -0.3,
				uuid = "905adf91-ce21-f841-8a52-156b2b05b57f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal cauterizeID = tonumber(root and root.p5WrathCauterizeID)\nif guide == nil\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or playerID ~= cauterizeID then\n  return\nend\n\nlocal warrior = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3639, subgroup = \"Nearest\" })\nlocal pos = warrior and warrior.pos or nil\nif type(pos) ~= \"table\"\n    or type(pos.x) ~= \"number\"\n    or type(pos.z) ~= \"number\" then\n  return\nend\n\nlocal dx = pos.x - 100\nlocal dz = pos.z - 100\nlocal length = math.sqrt(dx * dx + dz * dz)\nif length < 5 or length > 15 then\n  return\nend\n\nguide.FrameDirect(\n  100 - dx / length * 20,\n  100 - dz / length * 20,\n  0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi 指向战士安全区对面",
							uuid = "6e6dea6a-d277-9ccd-9ad5-bc0af9e93706",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1036.7,
				name = "[P5] 俯冲点名动态指路",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 5.4,
				uuid = "db3cb124-0e85-eda5-95d7-8dbcf4bb8487",
				version = 2,
			},
		},
	},
	[160] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss\nlocal bossCount = 0\nfor _, entity in pairs(TensorCore.entityList(\"contentid=3632\") or {}) do\n  local id = tonumber(entity and entity.id)\n  local pos = entity and entity.pos or nil\n  if id ~= nil\n      and entity.alive ~= false\n      and type(pos) == \"table\"\n      and type(pos.x) == \"number\"\n      and type(pos.z) == \"number\" then\n    boss = entity\n    bossCount = bossCount + 1\n  end\nend\nif bossCount ~= 1 then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nfor _, member in pairs(TensorCore.getEntityGroupList(\"Party\") or {}) do\n  local memberID = tonumber(member and member.id)\n  if memberID ~= nil and member.alive ~= false then\n    drawer:addTimedConeOnEnt(3300, boss.id, 50, math.rad(30), memberID)\n  end\nend\nself.used = true",
							endIfUsed = true,
							name = "Draw timeline protean cones",
							uuid = "12f747fa-ea28-b742-aa27-dc7995e07098",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1042.2,
				name = "[P5] 阿斯卡隆之仁八方扇形",
				timelineIndex = 160,
				timerEndOffset = 10,
				timerOffset = -3.2999999523163,
				timerStartOffset = -10,
				uuid = "13a66390-ff34-7bf3-a022-16c66d5ec96e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"7437f3e6-d9b4-f61e-ac4e-ce35438d1962",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "心眼",
							uuid = "4e42cc1a-f0c2-01e1-9b35-83b5d41fa182",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"44f7c530-57c1-3235-9767-0266275b2d7e",
									true,
								},
								
								{
									"d1e6cfd9-c3d0-ce9b-a122-bfd2497393b7",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "金刚极意",
							uuid = "d9b7b8cb-e3eb-1784-b6b6-3a3c89044aaf",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"c885ccb0-fdf2-0c8d-9c61-cc75e1930c41",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "神秘纹",
							uuid = "2415b493-ebd3-76b9-b7d6-d7dd31e064e1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "d1e6cfd9-c3d0-ce9b-a122-bfd2497393b7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "7437f3e6-d9b4-f61e-ac4e-ce35438d1962",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "44f7c530-57c1-3235-9767-0266275b2d7e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "c885ccb0-fdf2-0c8d-9c61-cc75e1930c41",
							version = 3,
						},
					},
				},
				mechanicTime = 1042.2,
				name = "[P5] 近战个人减伤",
				timelineIndex = 160,
				timerOffset = -3,
				uuid = "baca2cba-787a-b31a-805c-97d504698c7e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2241,
							conditions = 
							{
								
								{
									"071a6c93-d23b-702e-aa45-4b8e9d5c5bb5",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "残影",
							uuid = "f73e0ad5-0200-ad22-a641-2a547df30374",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								30,
							},
							name = "残影职业",
							uuid = "071a6c93-d23b-702e-aa45-4b8e9d5c5bb5",
							version = 3,
						},
					},
				},
				mechanicTime = 1042.2,
				name = "[P5] 残影",
				timelineIndex = 160,
				timerOffset = -3,
				uuid = "1121869a-0a1d-a018-a79e-6ba3c7aeae41",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 157,
							conditions = 
							{
								
								{
									"7608030e-64f7-0bb1-bff1-4c2e3ccf8cdb",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "魔罩",
							uuid = "ede60c43-8ad4-e91b-bc2a-964975194bee",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
							},
							name = "魔罩职业",
							uuid = "7608030e-64f7-0bb1-bff1-4c2e3ccf8cdb",
							version = 3,
						},
					},
				},
				mechanicTime = 1042.2,
				name = "[P5] 魔罩",
				timelineIndex = 160,
				timerOffset = -3,
				uuid = "7b4b49ab-c0d8-533e-a28c-9fa248773c9b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal root = data.string_dsr\nlocal helperID = tonumber(eventArgs.entityID)\nlocal helper = helperID and TensorCore.mGetEntity(helperID) or nil\nlocal helperPos = helper and helper.pos or nil\nif type(helperPos) ~= \"table\"\n    or type(helperPos.x) ~= \"number\"\n    or type(helperPos.z) ~= \"number\" then\n  return\nend\n\nlocal bestID\nlocal bestDistance\nlocal secondDistance\nfor _, member in pairs(TensorCore.getEntityGroupList(\"Party\") or {}) do\n  local memberID = tonumber(member and member.id)\n  local pos = member and member.pos or nil\n  if memberID ~= nil\n      and member.alive ~= false\n      and type(pos) == \"table\"\n      and type(pos.x) == \"number\"\n      and type(pos.z) == \"number\" then\n    local dx = pos.x - helperPos.x\n    local dz = pos.z - helperPos.z\n    local distance = dx * dx + dz * dz\n    if bestDistance == nil or distance < bestDistance then\n      secondDistance = bestDistance\n      bestDistance = distance\n      bestID = memberID\n    elseif secondDistance == nil or distance < secondDistance then\n      secondDistance = distance\n    end\n  end\nend\n\nif bestID == nil\n    or bestDistance == nil\n    or bestDistance > 4\n    or (secondDistance ~= nil and secondDistance <= bestDistance + 4) then\n  return\nend\n\nroot.p5WrathAltarID = bestID\nroot.p5WrathAltarSide = nil\n\nlocal warrior = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3639, subgroup = \"Nearest\" })\nlocal warriorPos = warrior and warrior.pos or nil\nif type(warriorPos) == \"table\"\n    and type(warriorPos.x) == \"number\"\n    and type(warriorPos.z) == \"number\" then\n  local safeX = warriorPos.x - 100\n  local safeZ = warriorPos.z - 100\n  local length = math.sqrt(safeX * safeX + safeZ * safeZ)\n  if length >= 5 and length <= 15 then\n    safeX, safeZ = safeX / length, safeZ / length\n    local lateralX, lateralZ = -safeZ, safeX\n    local sideValue =\n      (helperPos.x - 100) * lateralX + (helperPos.z - 100) * lateralZ\n    if sideValue >= 2 then\n      root.p5WrathAltarSide = 1\n    elseif sideValue <= -2 then\n      root.p5WrathAltarSide = -1\n    end\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"770421d8-0e26-71c7-83f0-8634911d637a",
									true,
								},
							},
							endIfUsed = true,
							name = "唯一位置匹配圣坛核爆目标",
							uuid = "fd3259de-1fd6-4f69-9de2-357cdc8656ad",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25573,
							name = "圣坛核爆 helper 25573",
							uuid = "770421d8-0e26-71c7-83f0-8634911d637a",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1042.2,
				name = "[P5] 圣坛核爆目标状态",
				timeRange = true,
				timelineIndex = 160,
				timerEndOffset = 1.1,
				timerStartOffset = 0.6,
				uuid = "536e1db2-4214-47d6-9532-b3c4eacbe1bd",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal timelineTime = tonumber(TensorReactions_CurrentTimer)\nif guide == nil\n    or type(guide.FrameDirect) ~= \"function\"\n    or root == nil\n    or playerID == nil\n    or timelineTime == nil then\n  return\nend\n\nlocal liquidID = tonumber(root.p5WrathLiquidID)\nlocal altarID = tonumber(root.p5WrathAltarID)\nif liquidID == nil\n    or altarID == nil\n    or liquidID == altarID then\n  return\nend\n\nlocal fireType\nlocal side\nif playerID == liquidID then\n  fireType = \"liquid\"\n  side = tonumber(root.p5WrathLiquidSide)\nelseif playerID == altarID then\n  fireType = \"altar\"\n  side = tonumber(root.p5WrathAltarSide)\n  if side ~= 1 and side ~= -1 then\n    local liquidSide = tonumber(root.p5WrathLiquidSide)\n    if liquidSide == 1 or liquidSide == -1 then\n      side = -liquidSide\n    end\n  end\nend\n\nlocal warriorID = tonumber(root.p5WrathWarriorID)\nlocal warrior = warriorID and TensorCore.mGetEntity(warriorID) or nil\nlocal warriorPos = warrior and warrior.pos or nil\nlocal warriorValid = tonumber(warrior and warrior.contentid) == 3639\n    and type(warriorPos) == \"table\"\n    and type(warriorPos.x) == \"number\"\n    and type(warriorPos.z) == \"number\"\n\nif not warriorValid then\n  warrior = nil\n  warriorPos = nil\n  root.p5WrathWarriorID = nil\n\n  local warriorDistance\n  local playerPos = player and player.pos or nil\n  for _, candidate in pairs(\n      TensorCore.entityList(\"contentid=3639\") or {}) do\n    local candidatePos = candidate and candidate.pos or nil\n    if type(candidatePos) == \"table\"\n        and type(candidatePos.x) == \"number\"\n        and type(candidatePos.z) == \"number\" then\n      local distance = 0\n      if type(playerPos) == \"table\"\n          and type(playerPos.x) == \"number\"\n          and type(playerPos.z) == \"number\" then\n        local dx = candidatePos.x - playerPos.x\n        local dz = candidatePos.z - playerPos.z\n        distance = dx * dx + dz * dz\n      end\n      if warrior == nil or distance < warriorDistance then\n        warrior = candidate\n        warriorDistance = distance\n      end\n    end\n  end\n\n  warriorID = tonumber(warrior and warrior.id)\n  warriorPos = warrior and warrior.pos or nil\n  if warriorID ~= nil then\n    root.p5WrathWarriorID = warriorID\n  end\nend\n\nif type(warriorPos) ~= \"table\"\n    or type(warriorPos.x) ~= \"number\"\n    or type(warriorPos.z) ~= \"number\" then\n  return\nend\n\nlocal safeX = warriorPos.x - 100\nlocal safeZ = warriorPos.z - 100\nlocal length = math.sqrt(safeX * safeX + safeZ * safeZ)\nif length < 5 or length > 15 then\n  return\nend\nsafeX, safeZ = safeX / length, safeZ / length\nlocal lateralX, lateralZ = -safeZ, safeX\nlocal targetX\nlocal targetZ\n\nif fireType ~= nil then\n  if side ~= 1 and side ~= -1 then\n    return\n  end\n\n  if fireType == \"liquid\" then\n    if timelineTime < 1044.3 then\n      targetX = 100 - safeX * 6 + lateralX * side * 18\n      targetZ = 100 - safeZ * 6 + lateralZ * side * 18\n    elseif timelineTime < 1045.45 then\n      targetX = 100 + lateralX * side * 19\n      targetZ = 100 + lateralZ * side * 19\n    elseif timelineTime < 1046.65 then\n      targetX = 100 + safeX * 6 + lateralX * side * 18\n      targetZ = 100 + safeZ * 6 + lateralZ * side * 18\n    elseif timelineTime < 1047.8 then\n      targetX = warriorPos.x + lateralX * side * 13\n      targetZ = warriorPos.z + lateralZ * side * 13\n    else\n      targetX = warriorPos.x\n      targetZ = warriorPos.z\n    end\n  else\n    if timelineTime < 1044.6 then\n      targetX = 100 - safeX * 5 + lateralX * side * 18\n      targetZ = 100 - safeZ * 5 + lateralZ * side * 18\n    elseif timelineTime < 1046.2 then\n      targetX = 100 + lateralX * side * 19\n      targetZ = 100 + lateralZ * side * 19\n    elseif timelineTime < 1047.7 then\n      targetX = warriorPos.x + lateralX * side * 15\n      targetZ = warriorPos.z + lateralZ * side * 15\n    else\n      targetX = warriorPos.x\n      targetZ = warriorPos.z\n    end\n  end\nelse\n  local firstThunderID = tonumber(root.p5WrathThunderID1)\n  local secondThunderID = tonumber(root.p5WrathThunderID2)\n  if firstThunderID == nil\n      or secondThunderID == nil\n      or firstThunderID == secondThunderID then\n    local scanBucket = math.floor(timelineTime * 5)\n    if tonumber(root.p5WrathThunderScanBucket) == scanBucket then\n      return\n    end\n    root.p5WrathThunderScanBucket = scanBucket\n\n    local scannedFirstID\n    local scannedSecondID\n    local scannedCount = 0\n    for _, member in pairs(\n        TensorCore.getEntityGroupList(\"Party\") or {}) do\n      local memberID = tonumber(member and member.id)\n      if memberID ~= nil and member.alive ~= false then\n        local buff = TensorCore.getBuff(member, 2833)\n        local remaining = tonumber(buff and buff.duration)\n        if remaining ~= nil and remaining > 0 then\n          scannedCount = scannedCount + 1\n          if scannedCount == 1 then\n            scannedFirstID = memberID\n          elseif scannedCount == 2 then\n            scannedSecondID = memberID\n          else\n            return\n          end\n        end\n      end\n    end\n    if scannedCount ~= 2\n        or scannedFirstID == nil\n        or scannedSecondID == nil\n        or scannedFirstID == scannedSecondID then\n      return\n    end\n    firstThunderID = scannedFirstID\n    secondThunderID = scannedSecondID\n    root.p5WrathThunderID1 = firstThunderID\n    root.p5WrathThunderID2 = secondThunderID\n    root.p5WrathThunderLeftID = nil\n    root.p5WrathThunderRightID = nil\n    root.p5WrathThunderScanBucket = nil\n  end\n  if firstThunderID == liquidID\n      or firstThunderID == altarID\n      or secondThunderID == liquidID\n      or secondThunderID == altarID then\n    return\n  end\n\n  local ordinaryX = warriorPos.x - safeX * 4.5\n  local ordinaryZ = warriorPos.z - safeZ * 4.5\n  local thunderLeftX = warriorPos.x + safeX * 3.5 - lateralX * 3.5\n  local thunderLeftZ = warriorPos.z + safeZ * 3.5 - lateralZ * 3.5\n  local thunderRightX = warriorPos.x + safeX * 3.5 + lateralX * 3.5\n  local thunderRightZ = warriorPos.z + safeZ * 3.5 + lateralZ * 3.5\n\n  local thunderLeftID = tonumber(root.p5WrathThunderLeftID)\n  local thunderRightID = tonumber(root.p5WrathThunderRightID)\n  local cacheMatches = thunderLeftID ~= nil\n      and thunderRightID ~= nil\n      and thunderLeftID ~= thunderRightID\n      and ((thunderLeftID == firstThunderID\n              and thunderRightID == secondThunderID)\n        or (thunderLeftID == secondThunderID\n              and thunderRightID == firstThunderID))\n  if not cacheMatches then\n    local firstThunder = TensorCore.mGetEntity(firstThunderID)\n    local secondThunder = TensorCore.mGetEntity(secondThunderID)\n    local firstPos = firstThunder and firstThunder.pos or nil\n    local secondPos = secondThunder and secondThunder.pos or nil\n    if type(firstPos) ~= \"table\"\n        or type(firstPos.x) ~= \"number\"\n        or type(firstPos.z) ~= \"number\"\n        or type(secondPos) ~= \"table\"\n        or type(secondPos.x) ~= \"number\"\n        or type(secondPos.z) ~= \"number\" then\n      return\n    end\n\n    local firstLeftX = firstPos.x - thunderLeftX\n    local firstLeftZ = firstPos.z - thunderLeftZ\n    local firstRightX = firstPos.x - thunderRightX\n    local firstRightZ = firstPos.z - thunderRightZ\n    local secondLeftX = secondPos.x - thunderLeftX\n    local secondLeftZ = secondPos.z - thunderLeftZ\n    local secondRightX = secondPos.x - thunderRightX\n    local secondRightZ = secondPos.z - thunderRightZ\n    local directDistance =\n        firstLeftX * firstLeftX\n        + firstLeftZ * firstLeftZ\n        + secondRightX * secondRightX\n        + secondRightZ * secondRightZ\n    local swappedDistance =\n        firstRightX * firstRightX\n        + firstRightZ * firstRightZ\n        + secondLeftX * secondLeftX\n        + secondLeftZ * secondLeftZ\n    if directDistance <= swappedDistance then\n      thunderLeftID = firstThunderID\n      thunderRightID = secondThunderID\n    else\n      thunderLeftID = secondThunderID\n      thunderRightID = firstThunderID\n    end\n    root.p5WrathThunderLeftID = thunderLeftID\n    root.p5WrathThunderRightID = thunderRightID\n  end\n\n  if playerID == thunderLeftID then\n    targetX = thunderLeftX\n    targetZ = thunderLeftZ\n  elseif playerID == thunderRightID then\n    targetX = thunderRightX\n    targetZ = thunderRightZ\n  else\n    targetX = ordinaryX\n    targetZ = ordinaryZ\n  end\nend\n\nguide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi 普通、雷与火圈安全区指路",
							uuid = "126b4a74-d38a-5935-b16d-a1b175c7e260",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1042.2,
				name = "[P5] 旋风后安全区与火圈动态指路",
				timeRange = true,
				timelineIndex = 160,
				timerEndOffset = 8.2,
				timerStartOffset = 0.7,
				uuid = "f02b87ca-6ef2-c8b3-9437-7eec88471c0d",
				version = 2,
			},
		},
	},
	[161] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal root = data.string_dsr\nlocal hitTargets = eventArgs.hitTargets\nlocal targetID = tonumber(type(hitTargets) == \"table\" and hitTargets[1])\nlocal castX = tonumber(eventArgs.castPosX)\nlocal castZ = tonumber(eventArgs.castPosZ)\nif targetID == nil or castX == nil or castZ == nil then\n  return\nend\n\nlocal isPartyMember = false\nfor _, member in pairs(TensorCore.getEntityGroupList(\"Party\") or {}) do\n  if tonumber(member and member.id) == targetID then\n    isPartyMember = true\n    break\n  end\nend\nif not isPartyMember then\n  return\nend\n\nroot.p5WrathLiquidID = targetID\nroot.p5WrathLiquidSide = nil\n\nlocal warrior = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3639, subgroup = \"Nearest\" })\nlocal pos = warrior and warrior.pos or nil\nif type(pos) == \"table\"\n    and type(pos.x) == \"number\"\n    and type(pos.z) == \"number\" then\n  local safeX = pos.x - 100\n  local safeZ = pos.z - 100\n  local length = math.sqrt(safeX * safeX + safeZ * safeZ)\n  if length >= 5 and length <= 15 then\n    safeX, safeZ = safeX / length, safeZ / length\n    local lateralX, lateralZ = -safeZ, safeX\n    local sideValue =\n      (castX - 100) * lateralX + (castZ - 100) * lateralZ\n    if sideValue >= 2 then\n      root.p5WrathLiquidSide = 1\n    elseif sideValue <= -2 then\n      root.p5WrathLiquidSide = -1\n    end\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"a8b6ba5f-4586-1539-a170-a55673e8ff0c",
									true,
								},
							},
							endIfUsed = true,
							name = "读取首发苍天火液目标",
							uuid = "1329b559-182b-91f5-9135-9ac77641038c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 27537,
							name = "苍天火液 27537",
							uuid = "a8b6ba5f-4586-1539-a170-a55673e8ff0c",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 1043,
				name = "[P5] 苍天火液目标状态",
				timeRange = true,
				timelineIndex = 161,
				timerEndOffset = 0.3,
				timerStartOffset = -0.2,
				uuid = "fa132d58-72a7-a9e9-8997-6077603e45c7",
				version = 2,
			},
		},
	},
	[174] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3632,
							targetType = "ContentID",
							uuid = "ea16c292-c767-51fc-a9c4-76b264cdfd52",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1057.2,
				name = "[P5] 自动目标：Thordan P5-1",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 174,
				timerEndOffset = 5,
				timerStartOffset = -10,
				uuid = "38141fc5-ae2b-0087-aea6-cad24b14bd59",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"11270765-301b-a4de-993d-50790d746d5b",
									true,
								},
								
								{
									"ee1c6590-1dab-e650-a14d-e2a50ebdb423",
									true,
								},
								
								{
									"8b65c67f-5533-591c-a2c8-b00792eda7f1",
									true,
								},
								
								{
									"d7675074-7cc0-2655-b165-f385f4c0024b",
									true,
								},
								
								{
									"5e3976ca-3b72-8963-b5cb-7dc726060a4e",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "8b2aa6d7-e663-adda-88e7-f8ffaf54d79f",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "11270765-301b-a4de-993d-50790d746d5b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1934,
							category = "Self",
							uuid = "ee1c6590-1dab-e650-a14d-e2a50ebdb423",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1951,
							category = "Self",
							uuid = "8b65c67f-5533-591c-a2c8-b00792eda7f1",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1826,
							category = "Self",
							uuid = "d7675074-7cc0-2655-b165-f385f4c0024b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 4,
							inRangeValue = 20,
							minTargetPercent = true,
							partyTargetNumber = 100,
							partyTargetSubType = "Number",
							uuid = "5e3976ca-3b72-8963-b5cb-7dc726060a4e",
							version = 3,
						},
					},
				},
				mechanicTime = 1057.2,
				name = "[P5] 远敏团队减伤",
				timeRange = true,
				timelineIndex = 174,
				timerEndOffset = -1,
				timerStartOffset = -15,
				uuid = "3cfdfa4e-1da3-f5e6-a7e4-c896bc49bf96",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							conditions = 
							{
								
								{
									"ba861a9c-6024-b736-8d32-eb9d434ca1ee",
									true,
								},
								
								{
									"20db0eb3-b66f-b76d-8e95-30328eac2b8d",
									true,
								},
							},
							endIfUsed = true,
							name = "牵制",
							targetType = "Current Target",
							uuid = "085cc1f9-2da1-4f2a-9d39-86820451225a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Feint check",
							uuid = "20db0eb3-b66f-b76d-8e95-30328eac2b8d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
								22,
								30,
								34,
								39,
								41,
							},
							name = "牵制职业",
							uuid = "ba861a9c-6024-b736-8d32-eb9d434ca1ee",
							version = 3,
						},
					},
				},
				mechanicTime = 1057.2,
				name = "[P5] 牵制",
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 174,
				timerEndOffset = -3,
				timerStartOffset = -7,
				uuid = "fd71ded3-0db1-6a69-872c-67bd5bd99250",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7560,
							conditions = 
							{
								
								{
									"d9e66d22-df42-2232-b2d7-6a94d5593d0c",
									true,
								},
								
								{
									"4a90d447-deff-c7c6-b7a0-a11f2a6efedb",
									true,
								},
							},
							endIfUsed = true,
							name = "昏乱",
							targetType = "Current Target",
							uuid = "703bc2e7-f120-9ba6-b340-f4655cda68d4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1203,
							name = "Addle check",
							uuid = "4a90d447-deff-c7c6-b7a0-a11f2a6efedb",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
								27,
								35,
								42,
							},
							name = "昏乱职业",
							uuid = "d9e66d22-df42-2232-b2d7-6a94d5593d0c",
							version = 3,
						},
					},
				},
				mechanicTime = 1057.2,
				name = "[P5] 昏乱",
				timeRange = true,
				timelineIndex = 174,
				timerEndOffset = -1,
				timerStartOffset = -7,
				uuid = "2e0cdf41-50c9-9527-ab26-03cb5f7c6afb",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2887,
							conditions = 
							{
								
								{
									"023cdd14-eb69-a222-903f-25a9b2a500b3",
									true,
								},
								
								{
									"4ad5ffb1-d606-614c-8250-a27411db05cd",
									true,
								},
							},
							endIfUsed = true,
							name = "武装解除",
							targetType = "Current Target",
							uuid = "1b6c8cd4-688d-07bb-b55f-96b1a9bc7c3f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 860,
							name = "Dismantle check",
							uuid = "4ad5ffb1-d606-614c-8250-a27411db05cd",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								31,
							},
							name = "武装解除职业",
							uuid = "023cdd14-eb69-a222-903f-25a9b2a500b3",
							version = 3,
						},
					},
				},
				mechanicTime = 1057.2,
				name = "[P5] 武装解除",
				randomTimeout = 8,
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 174,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "6b0fe669-fffe-3ff4-a427-e211333ee147",
				version = 2,
			},
		},
	},
	[176] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "70cbd9f2-a1e6-a24b-907d-281d8f43da40",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1070.8,
				name = "[P5] 阿斯卡隆之威 第一轮1 范围",
				timelineIndex = 176,
				timerOffset = -1.5,
				uuid = "78bcf70d-947e-8436-b5db-03bffd952460",
				version = 2,
			},
		},
	},
	[177] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "2a4671b3-e77f-d424-bae4-b716a601c323",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1072.4,
				name = "[P5] 阿斯卡隆之威 第一轮2 范围",
				timelineIndex = 177,
				timerOffset = -1.5,
				uuid = "62028298-5291-1555-ae9b-f79668ae281c",
				version = 2,
			},
		},
	},
	[178] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							conditions = 
							{
								
								{
									"61d4e753-2490-f2f7-bc5e-f876c1bfb9ba",
									true,
								},
								
								{
									"da34dff4-c3a8-31d0-bd11-65c8e78b48f2",
									true,
								},
							},
							endIfUsed = true,
							name = "牵制",
							targetType = "Current Target",
							uuid = "4b8b2195-3336-0759-825d-b8ed92e104c0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Feint check",
							uuid = "da34dff4-c3a8-31d0-bd11-65c8e78b48f2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
								22,
								30,
								34,
								39,
								41,
							},
							name = "牵制职业",
							uuid = "61d4e753-2490-f2f7-bc5e-f876c1bfb9ba",
							version = 3,
						},
					},
				},
				mechanicTime = 1074,
				name = "[P5] 牵制",
				timeRange = true,
				timelineIndex = 178,
				timerEndOffset = -8,
				timerStartOffset = -10,
				uuid = "f596ad6b-cb6b-27e4-a52e-cc1b5e21b42b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7560,
							conditions = 
							{
								
								{
									"2a16bd76-0c30-0d1d-b5a0-8a1cfa88adc8",
									true,
								},
								
								{
									"f65d6113-afcf-0fef-9107-52b3b131dd45",
									true,
								},
							},
							endIfUsed = true,
							name = "昏乱",
							targetType = "Current Target",
							uuid = "cec6359e-c8dd-a82f-9dbd-450bb3a7e96d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1203,
							name = "Addle check",
							uuid = "f65d6113-afcf-0fef-9107-52b3b131dd45",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
								27,
								35,
								42,
							},
							name = "昏乱职业",
							uuid = "2a16bd76-0c30-0d1d-b5a0-8a1cfa88adc8",
							version = 3,
						},
					},
				},
				mechanicTime = 1074,
				name = "[P5] 昏乱",
				timeRange = true,
				timelineIndex = 178,
				timerEndOffset = -8,
				timerStartOffset = -10,
				uuid = "6f9366b2-576f-2829-8633-60678e7fce56",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "a83a3cd0-5fc6-fb60-a032-45a9575994a0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1074,
				name = "[P5] 阿斯卡隆之威 第一轮3 范围",
				timelineIndex = 178,
				timerOffset = -1.5,
				uuid = "2db8cd6a-a2be-0434-93cb-d2c2ad48c543",
				version = 2,
			},
		},
	},
	[181] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local drawer = TensorCore.getMoogleDrawer()\nlocal id = eventArgs.entityID\nif id then\n  drawer:addTimedDonutOnEnt(2900, id, 6, 12, 4987)\n  drawer:addTimedDonutOnEnt(2900, id, 12, 18, 6862)\n  drawer:addTimedDonutOnEnt(2900, id, 18, 24, 8784)\n  drawer:addTimedDonutOnEnt(2900, id, 24, 30, 10685)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"8604edf6-8652-f1cf-8a9d-3a5f194e13f4",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw four impact rings",
							uuid = "9584a3bd-22ae-15fd-9923-9aed258e733b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25558,
							name = "Heavy Impact",
							uuid = "8604edf6-8652-f1cf-8a9d-3a5f194e13f4",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1088.2,
				name = "[P5] 圣杖重击四段环（二）",
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 14,
				timerStartOffset = -1,
				uuid = "02ae90e8-41f5-aff4-95c9-9946d25f6b62",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\ndata.string_dsr.p5Op2 = {\n  version = 1,\n  markerByID = {},\n  markerCount = 0,\n  whiteCircles = {},\n}\nself.used = true",
							endIfUsed = true,
							name = "初始化二运 pull 状态",
							uuid = "45a1532a-0854-c0b1-b5ca-8f2806c154a5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1088.2,
				name = "[P5] 二运状态初始化",
				timelineIndex = 181,
				timerOffset = 1.35,
				uuid = "e0b0985b-4c56-3a41-849b-0f3b4ec239ae",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = data.string_dsr\nlocal op = root and root.p5Op2 or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal party = type(MuAiGuide) == \"table\" and MuAiGuide.Party or nil\nif type(op) ~= \"table\"\n    or playerID == nil\n    or type(party) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\n\nif op.roleReady ~= true then\n  local roleNames = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\n  local roleIDs = {}\n  local roleByID = {}\n  local valid = true\n  for index, roleName in ipairs(roleNames) do\n    local id = tonumber(party[roleName] and party[roleName].id)\n    if id == nil or roleByID[id] ~= nil then\n      valid = false\n      break\n    end\n    roleIDs[index] = id\n    roleByID[id] = index\n  end\n  if valid and roleByID[playerID] ~= nil then\n    op.roleIDs = roleIDs\n    op.roleByID = roleByID\n    op.selfRoleIndex = roleByID[playerID]\n    op.roleReady = true\n  end\nend\n\nif op.orientationReady ~= true then\n  local entities = TensorCore.entityList(\"contentid=3641\")\n  local best\n  local bestDistance\n  for _, entity in pairs(type(entities) == \"table\" and entities or {}) do\n    local pos = entity and entity.pos or nil\n    local x = type(pos) == \"table\" and tonumber(pos.x) or nil\n    local z = type(pos) == \"table\" and tonumber(pos.z) or nil\n    if x ~= nil and z ~= nil then\n      local dx = x - 100\n      local dz = z - 100\n      local radius = math.sqrt(dx * dx + dz * dz)\n      if radius >= 6 and radius <= 12 then\n        local distance = math.abs(radius - 9)\n        if bestDistance == nil or distance < bestDistance then\n          bestDistance = distance\n          best = entity\n        end\n      end\n    end\n  end\n  local pos = best and best.pos or nil\n  local x = type(pos) == \"table\" and tonumber(pos.x) or nil\n  local z = type(pos) == \"table\" and tonumber(pos.z) or nil\n  if x ~= nil and z ~= nil then\n    local dx = x - 100\n    local dz = z - 100\n    local radius = math.sqrt(dx * dx + dz * dz)\n    if radius > 0 then\n      op.warrior1EntityID = tonumber(best.id)\n      op.fx = dx / radius\n      op.fz = dz / radius\n      op.rx = -op.fz\n      op.rz = op.fx\n      op.orientationReady = true\n    end\n  end\nend\n\nif op.roleReady ~= true or op.orientationReady ~= true then\n  return\nend\n\nif op.doomReady ~= true then\n  local now = tonumber(TensorReactions_CurrentTimer)\n  if now ~= nil and now >= 1092.75\n      and (op.nextDoomScanAt == nil or now >= op.nextDoomScanAt) then\n    op.nextDoomScanAt = now + 0.2\n    op.doomScanIDs = type(op.doomScanIDs) == \"table\" and op.doomScanIDs or {}\n    local doomIDs = op.doomScanIDs\n    local count = 0\n    for _, id in ipairs(op.roleIDs) do\n      local entity = TensorCore.mGetEntity(id)\n      local hasDoom = entity ~= nil and TensorCore.hasBuff(entity, 2976)\n      doomIDs[id] = hasDoom\n      if hasDoom then\n        count = count + 1\n      end\n    end\n    if count == 4 then\n      op.doomIDs = doomIDs\n      op.doomReady = true\n    end\n  end\nend\n\nif op.doomReady == true and op.selfIsDoom == nil then\n  local selfIsDoom = op.doomIDs[playerID] == true\n  local rank = 0\n  for _, id in ipairs(op.roleIDs) do\n    if (op.doomIDs[id] == true) == selfIsDoom then\n      rank = rank + 1\n      if id == playerID then\n        break\n      end\n    end\n  end\n  if rank >= 1 and rank <= 4 then\n    op.selfIsDoom = selfIsDoom\n    op.selfGroupRank = rank\n  end\nend\n\nlocal targetX\nlocal targetZ\nlocal forward\nlocal right\nif op.selfIsDoom == nil then\n  local fixedRight = -10.5 + (op.selfRoleIndex - 1) * 3\n  local fixedX = 100 + fixedRight * op.rx\n  local fixedZ = 100 + fixedRight * op.rz\n  targetX = fixedX\n  targetZ = fixedZ\n\n  if op.selfLineSettled ~= true then\n    local playerPos = player and player.pos or nil\n    local playerX = playerPos and tonumber(playerPos.x) or nil\n    local playerZ = playerPos and tonumber(playerPos.z) or nil\n    if playerX ~= nil and playerZ ~= nil then\n      local dx = playerX - fixedX\n      local dz = playerZ - fixedZ\n      if dx * dx + dz * dz <= 0.5625 then\n        op.selfLineSettled = true\n      end\n    end\n  end\n\n  local roleIndex = op.selfRoleIndex\n  if op.selfLineSettled == true and roleIndex > 1 and roleIndex < 8 then\n    local leftEntity = TensorCore.mGetEntity(op.roleIDs[roleIndex - 1])\n    local rightEntity = TensorCore.mGetEntity(op.roleIDs[roleIndex + 1])\n    local leftPos = leftEntity and leftEntity.pos or nil\n    local rightPos = rightEntity and rightEntity.pos or nil\n    local leftX = leftPos and tonumber(leftPos.x) or nil\n    local leftZ = leftPos and tonumber(leftPos.z) or nil\n    local rightX = rightPos and tonumber(rightPos.x) or nil\n    local rightZ = rightPos and tonumber(rightPos.z) or nil\n    if leftX ~= nil and leftZ ~= nil and rightX ~= nil and rightZ ~= nil then\n      targetX = (leftX + rightX) * 0.5\n      targetZ = (leftZ + rightZ) * 0.5\n    end\n  end\nelseif op.selfIsDoom then\n  local rank = op.selfGroupRank\n  if rank == 1 then\n    forward, right = 0, -13\n  elseif rank == 2 then\n    forward, right = 16, -12\n  elseif rank == 3 then\n    forward, right = 16, 12\n  elseif rank == 4 then\n    forward, right = 0, 13\n  end\nelse\n  local rank = op.selfGroupRank\n  if rank == 1 then\n    forward, right = 0, -20.5\n  elseif rank == 2 then\n    forward, right = -16, -12\n  elseif rank == 3 then\n    forward, right = -16, 12\n  elseif rank == 4 then\n    forward, right = 0, 20.5\n  end\nend\n\nif targetX == nil and forward ~= nil and right ~= nil then\n  targetX = 100 + forward * op.fx + right * op.rx\n  targetZ = 100 + forward * op.fz + right * op.rz\nend\n\nif targetX ~= nil and targetZ ~= nil then\n  op.currentTargetX = targetX\n  op.currentTargetZ = targetZ\n  MuAiGuide.FrameDirect(targetX, targetZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "横排后按死宣组内顺位前往安全点",
							uuid = "011cda1c-17d7-6885-b8cc-22faf7e1bab3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1088.2,
				name = "[P5] 二运横排与首轮安全点动态指路",
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 14.05,
				timerStartOffset = 1.55,
				uuid = "e49b5385-90b7-98cb-99d7-b9e6d4938816",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal root = data.string_dsr\nroot.p5Op2 = type(root.p5Op2) == \"table\" and root.p5Op2 or {\n  version = 1,\n  markerByID = {},\n  markerCount = 0,\n  whiteCircles = {},\n}\nlocal op = root.p5Op2\nlocal hitTargets = eventArgs.hitTargets\nif type(hitTargets) == \"table\" then\n  local doomIDs = {}\n  local count = 0\n  for _, rawID in ipairs(hitTargets) do\n    local id = tonumber(rawID)\n    if id ~= nil and doomIDs[id] ~= true then\n      doomIDs[id] = true\n      count = count + 1\n    end\n  end\n  if count == 4 then\n    op.doomIDs = doomIDs\n    op.doomReady = true\n    op.selfIsDoom = nil\n    op.selfGroupRank = nil\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"c008ca13-faf5-f79a-87ac-eec9909838b8",
									true,
								},
								
								{
									"71710ff4-7d05-58ee-9243-95e95735aa7d",
									true,
								},
							},
							endIfUsed = true,
							name = "记录 Deathstorm 四目标",
							uuid = "48183d1e-678b-ce7a-8308-d4aaec747439",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 27540,
							name = "Deathstorm 27540",
							uuid = "c008ca13-faf5-f79a-87ac-eec9909838b8",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3983,
							name = "Deathstorm 来源 CID 3983",
							uuid = "71710ff4-7d05-58ee-9243-95e95735aa7d",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 1088.2,
				name = "[P5] 二运死宣四目标状态",
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 4.5,
				timerStartOffset = 3.2,
				uuid = "cd2c0335-baa0-728c-ad48-e72446a07706",
				version = 2,
			},
		},
	},
	[182] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal center = { x = 100, y = 0, z = 100 }\nlocal heading = math.rad(180 - eventArgs.a1 * 45)\nlocal x, y, z = TensorCore.getPosInDirection(center, heading, 23, true)\ndata.string_dsr.eyePos = { x = x, y = y, z = z }\nself.used = true",
							conditions = 
							{
								
								{
									"82dd5e5b-7f5f-38c5-adf8-ce99ad811d13",
									true,
								},
								
								{
									"2f7b4ad0-c860-26b8-83c7-af3f2d9c831d",
									true,
								},
								
								{
									"389cb7c4-4719-449c-acd1-35a7963d7b8f",
									true,
								},
								
								{
									"83946229-477c-0b08-8d35-33df6edd2ed8",
									true,
								},
							},
							endIfUsed = true,
							name = "Store eye position",
							uuid = "1c1a168e-a280-6831-80b9-123ec12f8a3f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return eventArgs.a1 >= 0 and eventArgs.a1 <= 7 and eventArgs.a2 == 1 and eventArgs.a3 == 2",
							dequeueIfLuaFalse = true,
							name = "龙眼 a1 >= 0",
							uuid = "82dd5e5b-7f5f-38c5-adf8-ce99ad811d13",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 2,
							dequeueIfLuaFalse = true,
							eventIntValue = 7,
							name = "龙眼 a1 <= 7",
							uuid = "2f7b4ad0-c860-26b8-83c7-af3f2d9c831d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventIntValue = 1,
							name = "龙眼 a2 == 1",
							uuid = "389cb7c4-4719-449c-acd1-35a7963d7b8f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							eventIntValue = 2,
							name = "龙眼 a3 == 2",
							uuid = "83946229-477c-0b08-8d35-33df6edd2ed8",
							version = 3,
						},
					},
				},
				eventType = 14,
				mechanicTime = 1092,
				name = "[P5] 龙眼位置状态（二）",
				timeRange = true,
				timelineIndex = 182,
				timerEndOffset = 0.5,
				timerStartOffset = -0.5,
				uuid = "b6028037-9f3b-631a-8013-9105a3830b2b",
				version = 2,
			},
		},
	},
	[187] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nif player and eventArgs.channelTimeMax and eventArgs.channelTimeMax > 0 then\n  TensorCore.getMoogleDrawer():addTimedCircleOnEnt(eventArgs.channelTimeMax * 1000, player.id, 5)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"9e18d698-ad4d-f52c-a155-158c7ea6fa4c",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw personal spread",
							uuid = "b06ab0a7-f978-b9ee-a821-a4fe7e7cb8a9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25548,
							name = "Heavensflame",
							uuid = "9e18d698-ad4d-f52c-a155-158c7ea6fa4c",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1102.3,
				name = "[P5] 苍穹之炎个人范围（二）",
				timeRange = true,
				timelineIndex = 187,
				timerEndOffset = 12,
				timerStartOffset = -10,
				uuid = "dd16ca28-4007-6fe6-9888-fc18f90ee783",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.getMoogleDrawer():addTimedCircle(11200, eventArgs.x, eventArgs.y, eventArgs.z, 1, 5500)\nself.used = true",
							conditions = 
							{
								
								{
									"7954598d-5682-4b47-ba1c-4772bbcac6d6",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw delayed puddle",
							uuid = "053a7110-6dba-c433-95d8-7a6142dd0226",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return eventArgs.aoeID == 27542",
							dequeueIfLuaFalse = true,
							name = "Doom puddle AOE",
							uuid = "7954598d-5682-4b47-ba1c-4772bbcac6d6",
							version = 3,
						},
					},
				},
				eventType = 18,
				mechanicTime = 1102.3,
				name = "[P5] 死亡水圈",
				timeRange = true,
				timelineIndex = 187,
				timerEndOffset = 20,
				timerStartOffset = -2,
				uuid = "f383ad2f-74ae-c4e1-bc68-c97a34ad3b16",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal root = data.string_dsr\nroot.p5Op2 = type(root.p5Op2) == \"table\" and root.p5Op2 or {\n  version = 1,\n  markerByID = {},\n  markerCount = 0,\n  whiteCircles = {},\n}\nlocal op = root.p5Op2\nop.whiteCircles = type(op.whiteCircles) == \"table\" and op.whiteCircles or {}\n\nlocal x = tonumber(eventArgs.x)\nlocal y = tonumber(eventArgs.y)\nlocal z = tonumber(eventArgs.z)\nif x ~= nil and y ~= nil and z ~= nil then\n  local duplicate = false\n  for _, position in ipairs(op.whiteCircles) do\n    local dx = x - position.x\n    local dz = z - position.z\n    if dx * dx + dz * dz < 0.25 then\n      duplicate = true\n      break\n    end\n  end\n  if not duplicate and #op.whiteCircles < 4 then\n    op.whiteCircles[#op.whiteCircles + 1] = { x = x, y = y, z = z }\n    op.whiteByRank = nil\n  end\n  op.whiteReady = #op.whiteCircles == 4\nend\nself.used = true",
							conditions = 
							{
								
								{
									"54b9d9d2-f0e5-4163-a417-a9e9d4392e06",
									true,
								},
							},
							endIfUsed = true,
							name = "记录四个实际白圈世界坐标",
							uuid = "9f6afb22-bda6-3bfb-84b4-f59f280002cc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return tonumber(eventArgs.aoeID) == 27542",
							dequeueIfLuaFalse = true,
							name = "死亡白圈 AOE 27542",
							uuid = "54b9d9d2-f0e5-4163-a417-a9e9d4392e06",
							version = 3,
						},
					},
				},
				eventType = 18,
				loop = true,
				mechanicTime = 1102.3,
				name = "[P5] 二运白圈四位置状态",
				timeRange = true,
				timelineIndex = 187,
				timerEndOffset = 0.5,
				timerStartOffset = -0.3,
				uuid = "f67a47a1-3cc0-5852-962e-7b62f6339e47",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local op = type(data.string_dsr) == \"table\" and data.string_dsr.p5Op2 or nil\nif type(op) ~= \"table\"\n    or op.orientationReady ~= true\n    or op.selfIsDoom == nil\n    or type(MuAiGuide) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal forward = 0\nlocal right = 0\nif not op.selfIsDoom then\n  local rank = op.selfGroupRank\n  if rank == 1 then\n    forward, right = -7, -13\n  elseif rank == 2 then\n    forward, right = -9, -9\n  elseif rank == 3 then\n    forward, right = -11, 4\n  elseif rank == 4 then\n    forward, right = -7, 13\n  else\n    return\n  end\nend\n\nlocal targetX = 100 + forward * op.fx + right * op.rx\nlocal targetZ = 100 + forward * op.fz + right * op.rz\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "死宣直进；其余沿边或黑魔身后",
							uuid = "0f76832e-504b-5454-aab1-149a97d2a4de",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1102.3,
				name = "[P5] 二运旋风地震第一段动态指路",
				timeRange = true,
				timelineIndex = 187,
				timerEndOffset = 1.8,
				uuid = "17cddc58-9003-9dac-bcfa-24d62729a639",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local op = type(data.string_dsr) == \"table\" and data.string_dsr.p5Op2 or nil\nif type(op) ~= \"table\"\n    or op.orientationReady ~= true\n    or op.selfIsDoom == nil\n    or type(MuAiGuide) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\nMuAiGuide.FrameDirect(100, 100, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "躲过第二轮扩散后回战士小怪二",
							uuid = "0603248a-3588-83d4-965b-f63355d6f170",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1102.3,
				name = "[P5] 二运回中动态指路",
				timeRange = true,
				timelineIndex = 187,
				timerEndOffset = 5.7,
				timerStartOffset = 1.8,
				uuid = "dffbd61a-7eaa-4019-ad86-07fd7e99bd05",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local op = type(data.string_dsr) == \"table\" and data.string_dsr.p5Op2 or nil\nif type(op) ~= \"table\"\n    or op.orientationReady ~= true\n    or op.selfIsDoom == nil\n    or type(MuAiGuide) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal forward\nlocal right\nlocal rank = op.selfGroupRank\nif op.selfIsDoom then\n  if rank == 1 then\n    forward, right = 0, -8.5\n  elseif rank == 2 then\n    forward, right = -3.5, -2.5\n  elseif rank == 3 then\n    forward, right = -3.5, 2.5\n  elseif rank == 4 then\n    forward, right = 0, 8.5\n  end\nelse\n  forward = 4\n  if rank == 1 then\n    right = -4.5\n  elseif rank == 2 then\n    right = -1.5\n  elseif rank == 3 then\n    right = 1.5\n  elseif rank == 4 then\n    right = 4.5\n  end\nend\n\nif forward ~= nil and right ~= nil then\n  local targetX = 100 + forward * op.fx + right * op.rx\n  local targetZ = 100 + forward * op.fz + right * op.rz\n  MuAiGuide.FrameDirect(targetX, targetZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "死宣左右诱导圆；无死宣上方横排",
							uuid = "b8238dbf-1d5a-72cd-a2a9-f45db5783b92",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1102.3,
				name = "[P5] 2.5运标记前预站位动态指路",
				timeRange = true,
				timelineIndex = 187,
				timerEndOffset = 7.92,
				timerStartOffset = 5.7,
				uuid = "570257f2-3d49-7c0f-b04a-c1bdb14d9db7",
				version = 2,
			},
		},
	},
	[189] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.string_dsr\nlocal player = TensorCore.mGetPlayer()\nlocal thordan = TensorCore.mGetEntity(eventArgs.entityID)\n\nif not state or not state.eyePos or not player or not player.pos\n    or not thordan or not thordan.pos then\n  self.used = true\n  return\nend\n\nlocal heading = TensorCore.Avoidance.getHeadingBetweenPos(\n  player.pos,\n  state.eyePos,\n  thordan.pos\n) + math.pi\n\nTensorCore.API.TensorACR.setLockFaceHeading(heading)\nTensorCore.API.TensorACR.toggleLockFace(true)\nTensorCore.getStaticDrawer(520093951):addTimedArrow(\n  1800,\n  player.pos.x,\n  player.pos.y,\n  player.pos.z,\n  heading,\n  6,\n  1\n)\nself.used = true",
							conditions = 
							{
								
								{
									"6e68d1de-fc1b-d5a4-a295-8abe88ab0777",
									true,
								},
								
								{
									"387b5fed-e9a8-e88f-a925-704fb496e121",
									true,
								},
							},
							endIfUsed = true,
							name = "Lock away from gaze",
							uuid = "d0b6a4f6-d060-78a8-85e8-1faf9c0e7cd4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25552,
							name = "Gaze cast 25552",
							uuid = "6e68d1de-fc1b-d5a4-a295-8abe88ab0777",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3632,
							name = "Thordan C3632",
							uuid = "387b5fed-e9a8-e88f-a925-704fb496e121",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 1114.2,
				name = "[P5] Dragon's Gaze 自动背对（二）",
				timeRange = true,
				timelineIndex = 189,
				timerEndOffset = 1,
				timerStartOffset = -0.5,
				uuid = "dca5f917-60f4-a16d-b67c-9ac95ce2320a",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\nself.used = true",
							conditions = 
							{
								
								{
									"25a8ad1c-6c8e-75d8-b6d0-c82e107afc63",
									true,
								},
								
								{
									"2b2fe23b-94fd-537f-9923-daf683010e02",
									true,
								},
							},
							endIfUsed = true,
							name = "Unlock facing",
							uuid = "a242ac5e-49c4-d586-87d4-e5861017aab1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25553,
							name = "Gaze resolve 25553",
							uuid = "25a8ad1c-6c8e-75d8-b6d0-c82e107afc63",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3632,
							name = "Thordan C3632",
							uuid = "2b2fe23b-94fd-537f-9923-daf683010e02",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 1114.2,
				name = "[P5] Dragon's Gaze 精确解锁（二）",
				timeRange = true,
				timelineIndex = 189,
				timerEndOffset = 2.5,
				timerStartOffset = 0.5,
				uuid = "699cbe00-710d-5ffc-82cb-487cb9fd91f3",
				version = 2,
			},
		},
	},
	[190] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nif player and eventArgs.entityID and eventArgs.channelTimeMax and eventArgs.channelTimeMax > 0 then\n  TensorCore.getStaticDrawer(520158976):addTimedArrowOnEnt(eventArgs.channelTimeMax * 1000, eventArgs.entityID, 16, 1, 2, 3, player.id)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"92084817-bbdb-c6ed-87dc-f215ee3d72d0",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw knockback direction",
							uuid = "58bd627c-09e3-6aca-8398-a3a883ed8230",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25308,
							name = "Faith Unmoving",
							uuid = "92084817-bbdb-c6ed-87dc-f215ee3d72d0",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1115.3,
				name = "[P5] 信仰不移击退方向（三）",
				timeRange = true,
				timelineIndex = 190,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "a0d0b1de-466b-4b85-9e00-972699935f26",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal entityID = tonumber(eventArgs.entityID)\nlocal markerID = tonumber(eventArgs.markerID)\nif playerID == nil or entityID ~= playerID\n    or markerID == nil or markerID < 281 or markerID > 284 then\n  return\nend\n\ndata.string_dsr = type(data.string_dsr) == \"table\" and data.string_dsr or {}\nlocal root = data.string_dsr\nroot.p5Op2 = type(root.p5Op2) == \"table\" and root.p5Op2 or {\n  version = 1,\n  whiteCircles = {},\n}\nlocal op = root.p5Op2\nop.selfMarkerID = markerID\nop.markerTargetX = nil\nop.markerTargetZ = nil\nself.used = true",
							conditions = 
							{
								
								{
									"a17b298a-3e10-813e-a81d-81db355c6d5e",
									true,
								},
								
								{
									"e908acff-88fd-849f-bdc1-7879f985b570",
									true,
								},
							},
							endIfUsed = true,
							name = "记录本人 PS 标记",
							uuid = "e219272e-b92f-ae40-875e-252fc2bd496e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							markerIDList = 
							{
								281,
								282,
								283,
								284,
							},
							name = "PS 标记 281–284",
							uuid = "a17b298a-3e10-813e-a81d-81db355c6d5e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 10,
							dequeueIfLuaFalse = true,
							name = "Marker is on self",
							partyTargetType = "Event Entity",
							uuid = "e908acff-88fd-849f-bdc1-7879f985b570",
							version = 3,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 1115.3,
				name = "[P5] 2.5运本人标记状态",
				timeRange = true,
				timelineIndex = 190,
				timerEndOffset = -4.65,
				timerStartOffset = -5.15,
				uuid = "1c3d2e63-4407-6feb-88d7-e8b6886ccf57",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local op = type(data.string_dsr) == \"table\" and data.string_dsr.p5Op2 or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(op) ~= \"table\"\n    or playerID == nil\n    or type(op.selfMarkerID) ~= \"number\"\n    or type(op.roleByID) ~= \"table\"\n    or type(op.fx) ~= \"number\" or type(op.fz) ~= \"number\"\n    or type(op.rx) ~= \"number\" or type(op.rz) ~= \"number\"\n    or op.selfIsDoom == nil\n    or type(op.selfGroupRank) ~= \"number\"\n    or type(MuAiGuide) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\n\nif type(op.markerTargetX) ~= \"number\" or type(op.markerTargetZ) ~= \"number\" then\n  local markerRadius = 2\n  local diagonalScale = markerRadius / math.sqrt(10.25)\n  local markerID = tonumber(op.selfMarkerID)\n  local forward\n  local right\n  if markerID == 281 then\n    forward = 0\n    right = op.selfGroupRank <= 2 and -markerRadius or markerRadius\n  elseif markerID == 282 then\n    if op.selfIsDoom then\n      forward, right = -2.5 * diagonalScale, 2 * diagonalScale\n    else\n      forward, right = 2.5 * diagonalScale, -2 * diagonalScale\n    end\n  elseif markerID == 283 then\n    if op.selfIsDoom then\n      forward, right = -2.5 * diagonalScale, -2 * diagonalScale\n    else\n      forward, right = 2.5 * diagonalScale, 2 * diagonalScale\n    end\n  elseif markerID == 284\n      and type(Argus) == \"table\"\n      and type(Argus.getTethersOnEnt) == \"function\" then\n    local selfRole = tonumber(op.roleByID[playerID])\n    local partnerID\n    local partnerCount = 0\n    for _, tether in ipairs(Argus.getTethersOnEnt(playerID) or {}) do\n      local candidateID = tonumber(tether.partnerid)\n      if tonumber(tether.type) == 9\n          and candidateID ~= nil\n          and tonumber(op.roleByID[candidateID]) ~= nil then\n        partnerID = candidateID\n        partnerCount = partnerCount + 1\n      end\n    end\n    local partnerRole = partnerID and tonumber(op.roleByID[partnerID]) or nil\n    if partnerCount == 1\n        and selfRole ~= nil and partnerRole ~= nil\n        and selfRole ~= partnerRole then\n      forward = selfRole > partnerRole and -markerRadius or markerRadius\n      right = 0\n      op.selfMarkerPartnerID = partnerID\n    end\n  end\n\n  if forward ~= nil and right ~= nil then\n    op.markerTargetX = 100 + forward * op.fx + right * op.rx\n    op.markerTargetZ = 100 + forward * op.fz + right * op.rz\n  end\nend\n\nif type(op.markerTargetX) == \"number\" and type(op.markerTargetZ) == \"number\" then\n  MuAiGuide.FrameDirect(op.markerTargetX, op.markerTargetZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "按本人标记与 Tether 9 伙伴前往站位",
							uuid = "7999177f-afb1-18b2-b857-5e7a84560177",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1115.3,
				name = "[P5] 2.5运标记站位动态指路",
				timeRange = true,
				timelineIndex = 190,
				timerEndOffset = 0.44999998807907,
				timerStartOffset = -5.039999961853,
				uuid = "ebe76781-d99a-4cff-afdf-84dc49764398",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local op = type(data.string_dsr) == \"table\" and data.string_dsr.p5Op2 or nil\nif type(op) ~= \"table\"\n    or op.selfIsDoom ~= true\n    or type(op.selfGroupRank) ~= \"number\"\n    or type(op.whiteCircles) ~= \"table\"\n    or #op.whiteCircles ~= 4\n    or type(op.rx) ~= \"number\" or type(op.rz) ~= \"number\"\n    or type(MuAiGuide) ~= \"table\"\n    or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\n\nif type(op.whiteByRank) ~= \"table\" then\n  local sorted = {}\n  for _, position in ipairs(op.whiteCircles) do\n    local right = (position.x - 100) * op.rx + (position.z - 100) * op.rz\n    local insertAt = #sorted + 1\n    for index, existing in ipairs(sorted) do\n      local existingRight = (existing.x - 100) * op.rx + (existing.z - 100) * op.rz\n      if right < existingRight then\n        insertAt = index\n        break\n      end\n    end\n    table.insert(sorted, insertAt, position)\n  end\n  op.whiteByRank = sorted\nend\n\nlocal target = op.whiteByRank[op.selfGroupRank]\nif target then\n  MuAiGuide.FrameDirect(target.x, target.z, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "击退后前往本人对应实际白圈",
							uuid = "1aaf8448-a510-2fa5-acaa-ffe9e675758b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1115.3,
				name = "[P5] 2.5运死宣踩白圈动态指路",
				timeRange = true,
				timelineIndex = 190,
				timerEndOffset = 2.5,
				timerStartOffset = 0.45,
				uuid = "f4152a71-55a8-1f4d-b3b7-c1f087b039e4",
				version = 2,
			},
		},
	},
	[193] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"58a2768c-d6bc-e64d-a714-9143d4f1a311",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "心眼",
							uuid = "228046b6-6bdc-9306-b7b1-dc0667a69f2b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"aafaf9e5-5ead-c662-afac-38fdb7b4da1d",
									true,
								},
								
								{
									"a02c19a5-e361-f622-a2fc-206c7993109d",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "金刚极意",
							uuid = "ac6cce40-8d6c-f4e9-9601-3fd6d512ff94",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"fe531697-e6a2-c36a-8038-e9123821621b",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "神秘纹",
							uuid = "9b8853f3-49c3-f936-85e5-a361d60b33b9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "a02c19a5-e361-f622-a2fc-206c7993109d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "58a2768c-d6bc-e64d-a714-9143d4f1a311",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "aafaf9e5-5ead-c662-afac-38fdb7b4da1d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "fe531697-e6a2-c36a-8038-e9123821621b",
							version = 3,
						},
					},
				},
				mechanicTime = 1117.8,
				name = "[P5] 近战个人减伤",
				timelineIndex = 193,
				timerOffset = -3,
				uuid = "5d17fbf8-e5bb-c3b5-876e-9b8b5f256b30",
				version = 2,
			},
		},
	},
	[194] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"b4314325-2d64-0109-a83d-efe3a567a207",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3632,
							targetType = "ContentID",
							uuid = "7f67a597-5ae5-2650-89c3-5b12875d783a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "b4314325-2d64-0109-a83d-efe3a567a207",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 1120.2,
				name = "[P5] 自动目标：Thordan P5-2",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 194,
				timerEndOffset = 5,
				uuid = "9febe98b-4b9f-f2db-a381-6e61371a1afe",
				version = 2,
			},
		},
	},
	[196] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"6f94ea12-efe5-73ee-8876-449906741a03",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3632,
							targetType = "ContentID",
							uuid = "85871072-3603-aacf-9da5-b0538e115b5a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "6f94ea12-efe5-73ee-8876-449906741a03",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 1142.2,
				name = "[P5] 自动目标：Thordan P5-3",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 196,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "4d00109d-e6f9-b9a6-9fbb-aef04b6da538",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"230c9346-6d93-3ea8-890f-07c7b801b032",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "49aac71b-0b41-2585-b180-286ab6325d40",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"53cdaaa2-7f5f-aa73-947b-e776835fb48e",
									true,
								},
								
								{
									"05b77a7b-4fe8-adf6-8af5-c03ce57df5fe",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "07e2bb21-d6aa-798d-9986-6e9c0a993655",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"5e2851e0-e628-4f29-bbd0-0a1d14906ba1",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "cfb73844-396c-def4-b1a9-7293162d5467",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "05b77a7b-4fe8-adf6-8af5-c03ce57df5fe",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "230c9346-6d93-3ea8-890f-07c7b801b032",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "53cdaaa2-7f5f-aa73-947b-e776835fb48e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "5e2851e0-e628-4f29-bbd0-0a1d14906ba1",
							version = 3,
						},
					},
				},
				mechanicTime = 1142.2,
				name = "[P5] 近战个人减伤",
				timelineIndex = 196,
				timerOffset = -3,
				uuid = "47da18c6-04ee-a624-a801-95292884ad19",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7560,
							conditions = 
							{
								
								{
									"88d6e1dd-b739-37a4-81e2-da92424eb383",
									true,
								},
								
								{
									"6d50af23-4af7-95cb-82df-5053b5d6439e",
									true,
								},
								
								{
									"4b8abb9f-cc62-f394-a748-76330d173900",
									true,
								},
							},
							endIfUsed = true,
							name = "昏乱",
							targetType = "Current Target",
							uuid = "9ba790a9-4428-04a9-a77f-c80285ef0cf3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1203,
							name = "Addle check",
							uuid = "6d50af23-4af7-95cb-82df-5053b5d6439e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25542,
							uuid = "4b8abb9f-cc62-f394-a748-76330d173900",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
								27,
								35,
								42,
							},
							name = "昏乱职业",
							uuid = "88d6e1dd-b739-37a4-81e2-da92424eb383",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1142.2,
				name = "[P5] 昏乱",
				timeRange = true,
				timelineIndex = 196,
				timerEndOffset = 5,
				timerStartOffset = -30,
				uuid = "76f5e5cc-61e8-aaf6-bd9e-93a237b63830",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							conditions = 
							{
								
								{
									"4b0bf539-b890-068c-b282-fe1beb93b862",
									true,
								},
								
								{
									"e5dc46a4-886d-6d27-8f96-d8e82f4f2949",
									true,
								},
								
								{
									"59e94662-4079-4bce-bc55-cc5b7514ad7d",
									true,
								},
							},
							endIfUsed = true,
							name = "牵制",
							targetType = "Current Target",
							uuid = "7f49fd15-cca9-f89d-8698-db699ffb7741",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Feint check",
							uuid = "e5dc46a4-886d-6d27-8f96-d8e82f4f2949",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25542,
							uuid = "59e94662-4079-4bce-bc55-cc5b7514ad7d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
								22,
								30,
								34,
								39,
								41,
							},
							name = "牵制职业",
							uuid = "4b0bf539-b890-068c-b282-fe1beb93b862",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1142.2,
				name = "[P5] 牵制",
				timeRange = true,
				timelineIndex = 196,
				timerEndOffset = 5,
				timerStartOffset = -30,
				uuid = "b0a3c8ee-17ad-0fdf-9f78-f5d58da34760",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2887,
							conditions = 
							{
								
								{
									"791cec81-dce2-672b-81c5-82a1d987af61",
									true,
								},
								
								{
									"42346133-e005-d03c-b960-08a6f3eb657f",
									true,
								},
							},
							endIfUsed = true,
							name = "武装解除",
							targetType = "Current Target",
							uuid = "12d4f3e1-7620-5f9d-b24b-b99185437800",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 860,
							name = "Dismantle check",
							uuid = "42346133-e005-d03c-b960-08a6f3eb657f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								31,
							},
							name = "武装解除职业",
							uuid = "791cec81-dce2-672b-81c5-82a1d987af61",
							version = 3,
						},
					},
				},
				mechanicTime = 1142.2,
				name = "[P5] 武装解除",
				randomTimeout = 8,
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 196,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "9da6070e-d01c-377c-9504-0f667458bb33",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"8f8c398f-d715-8ea9-9615-3cd4d96010f9",
									true,
								},
								
								{
									"da10f9ae-045f-30f1-9a49-1632d1a037b0",
									true,
								},
								
								{
									"95db07e0-e226-fe69-9ad3-afadd8c7be63",
									true,
								},
								
								{
									"1e8f5f3c-837f-8f93-bb75-a24274eedc7b",
									true,
								},
								
								{
									"83683451-0ac8-7190-9f1f-795d50810a38",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "3b4c6523-47a2-bb29-b177-128a04a8cffc",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "8f8c398f-d715-8ea9-9615-3cd4d96010f9",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1934,
							category = "Self",
							uuid = "da10f9ae-045f-30f1-9a49-1632d1a037b0",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1951,
							category = "Self",
							uuid = "95db07e0-e226-fe69-9ad3-afadd8c7be63",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1826,
							category = "Self",
							uuid = "1e8f5f3c-837f-8f93-bb75-a24274eedc7b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25542,
							uuid = "83683451-0ac8-7190-9f1f-795d50810a38",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1142.2,
				name = "[P5] 远敏团队减伤",
				timeRange = true,
				timelineIndex = 196,
				timerEndOffset = 5,
				timerStartOffset = -30,
				uuid = "3559b40e-f2a9-b916-9246-9338db68cf3c",
				version = 2,
			},
		},
	},
	[198] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "0e530229-a510-d40e-9163-225f60b7b31b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1161.6,
				name = "[P5] 阿斯卡隆之威 第二轮1 范围",
				timelineIndex = 198,
				timerOffset = -1.5,
				uuid = "6cbbceb4-5e14-7534-9bfb-1daab65a4dd3",
				version = 2,
			},
		},
	},
	[199] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "e83b2c05-abaa-ca6e-854f-f68750768941",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1163.2,
				name = "[P5] 阿斯卡隆之威 第二轮2 范围",
				timelineIndex = 199,
				timerOffset = -1.5,
				uuid = "6f497fe5-6f7a-d5af-beb9-b191696c1833",
				version = 2,
			},
		},
	},
	[200] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							conditions = 
							{
								
								{
									"7c3a46f6-6368-62fc-8196-bf85597a0237",
									true,
								},
								
								{
									"4891b69c-ce01-c09a-8fe6-8851bfd5c557",
									true,
								},
							},
							endIfUsed = true,
							name = "牵制",
							targetType = "Current Target",
							uuid = "afda4862-ddc0-8647-8d59-b3033bc98045",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Feint check",
							uuid = "4891b69c-ce01-c09a-8fe6-8851bfd5c557",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
								22,
								30,
								34,
								39,
								41,
							},
							name = "牵制职业",
							uuid = "7c3a46f6-6368-62fc-8196-bf85597a0237",
							version = 3,
						},
					},
				},
				mechanicTime = 1164.9,
				name = "[P5] 牵制",
				timeRange = true,
				timelineIndex = 200,
				timerEndOffset = -5,
				timerStartOffset = -10,
				uuid = "4403018d-3d32-9bbb-ad9e-82f468a563cd",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7560,
							conditions = 
							{
								
								{
									"14bab1be-d0c6-5b91-a430-9b01eabafa41",
									true,
								},
								
								{
									"a889dbd1-8369-4dca-a43f-5dbd585d7abc",
									true,
								},
							},
							endIfUsed = true,
							name = "昏乱",
							targetType = "Current Target",
							uuid = "26a885a3-a0bd-4fbb-af9c-fd8e016182f1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1203,
							name = "Addle check",
							uuid = "a889dbd1-8369-4dca-a43f-5dbd585d7abc",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
								27,
								35,
								42,
							},
							name = "昏乱职业",
							uuid = "14bab1be-d0c6-5b91-a430-9b01eabafa41",
							version = 3,
						},
					},
				},
				mechanicTime = 1164.9,
				name = "[P5] 昏乱",
				timeRange = true,
				timelineIndex = 200,
				timerEndOffset = -5,
				timerStartOffset = -10,
				uuid = "85af041b-5cc5-e9f3-8cb6-625594818586",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3632, subgroup = \"Nearest\" })\nif not boss or not boss.id then\n  return\nend\n\nlocal drawer = TensorCore.getMoogleDrawer()\nif not drawer then\n  return\nend\n\ndrawer:addTimedConeOnEnt(1500, boss.id, 50, math.pi / 2, nil, 0, false, true)\nself.used = true",
							name = "单次附着骑神90度扇形",
							uuid = "9262c28b-f1d3-a9d0-a42e-2134c860b7dc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1164.9,
				name = "[P5] 阿斯卡隆之威 第二轮3 范围",
				timelineIndex = 200,
				timerOffset = -1.5,
				uuid = "6bc5ca9d-e34d-d958-8702-dd1b028d2a0c",
				version = 2,
			},
		},
	},
	[203] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\ndata.string_dsr = data.string_dsr or {}\ndata.string_dsr.eyePos = nil\ndata.string_dsr.cometCount = nil\ndata.string_dsr.cometsArmed = nil\ndata.string_dsr.drawnExaflares = nil\nself.used = true",
							endIfUsed = true,
							name = "Unlock face and reset phase state",
							uuid = "42f5ba21-bf1e-a939-81b4-c82a6f14498b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1217.6,
				name = "[P6] 换相清理",
				timeRange = true,
				timelineIndex = 203,
				timerEndOffset = 0.5,
				timerStartOffset = -0.5,
				uuid = "77742f06-dee8-ef63-ab0a-849e8fa31f0d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"9109b8f5-7bf6-8e3f-a533-1e020cb4cbef",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetType = "Enemy",
							uuid = "1edb9353-752a-1240-a033-9d94585caf66",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "9109b8f5-7bf6-8e3f-a533-1e020cb4cbef",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 1217.6,
				name = "[P6] 自动目标：P6 当前敌人",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 203,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "12054e00-5fe2-7697-8804-3337cac8f058",
				version = 2,
			},
		},
	},
	[205] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local duration = (eventArgs.channelTimeMax + 1.2) * 1000\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal moogleDrawer = TensorCore.getMoogleDrawer()\nlocal outlineThickness =\n  (tonumber(moogleDrawer and moogleDrawer.outlineThickness) or 1.5) + 0.5\n\nlocal fireColor =\n  GUI:ColorConvertFloat4ToU32(1, 0.12, 0.02, 0.45)\nlocal iceColor =\n  GUI:ColorConvertFloat4ToU32(0.05, 0.55, 1, 0.45)\nlocal blackOutline =\n  GUI:ColorConvertFloat4ToU32(0, 0, 0, 1)\nlocal whiteOutline =\n  GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)\n\nlocal fireDrawer = TensorCore.getStaticDrawer(fireColor)\nlocal iceDrawer = TensorCore.getStaticDrawer(iceColor)\nlocal ownFireDrawer = TensorCore.getCachedDrawer(\n  fireColor, nil, fireColor, blackOutline, outlineThickness)\nlocal ownIceDrawer = TensorCore.getCachedDrawer(\n  iceColor, nil, iceColor, whiteOutline, outlineThickness)\n\nlocal dragon = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3458, subgroup = \"Nearest\" })\nif dragon then\n  local tethers = Argus.getTethersOnEnt(dragon.id)\n  for i = 1, #tethers do\n    local partnerID = tonumber(tethers[i].partnerid)\n    if partnerID then\n      local drawer =\n        partnerID == playerID and ownFireDrawer or fireDrawer\n      drawer:addTimedConeOnEnt(\n        duration, dragon.id, 100, math.rad(15), partnerID)\n    end\n  end\nend\n\ndragon = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 4954, subgroup = \"Nearest\" })\nif dragon then\n  local tethers = Argus.getTethersOnEnt(dragon.id)\n  for i = 1, #tethers do\n    local partnerID = tonumber(tethers[i].partnerid)\n    if partnerID then\n      local drawer =\n        partnerID == playerID and ownIceDrawer or iceDrawer\n      drawer:addTimedConeOnEnt(\n        duration, dragon.id, 100, math.rad(15), partnerID)\n    end\n  end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"7bcda3e6-9459-f085-a3af-d5962482e9c8",
									true,
								},
							},
							endIfUsed = true,
							name = "绘制火红与冰蓝龙息扇形",
							uuid = "bade93a5-0d75-3654-83b7-2409f3890122",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return (eventArgs.sourceEntityContentID == 3458 or eventArgs.sourceEntityContentID == 4954) and eventArgs.newTargetID and eventArgs.newTargetID > 0",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "双龙吐息读条",
							spellIDList = 
							{
								27954,
								27955,
								27956,
								27957,
							},
							uuid = "7bcda3e6-9459-f085-a3af-d5962482e9c8",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1235.1,
				name = "[P6] 第一次龙牙龙爪连线扇形",
				timeRange = true,
				timelineIndex = 205,
				timerEndOffset = 2,
				timerStartOffset = -10,
				uuid = "c6c40192-1674-6425-b6af-5320b74f9473",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"7ee6631d-7799-f74e-82f4-cd3a6544ea42",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "7fd586a3-33cd-172c-949f-b9bed3f5105b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"e18713e5-4bb0-31fc-b936-bd402d083216",
									true,
								},
								
								{
									"a7b61e4b-6511-c976-8652-004e47055514",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "6b980c16-61a8-2cd2-862e-8f17218f61a9",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"e6f2d11a-8cc8-371a-9f7b-4c0914944397",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "bc5baa5e-b84f-6eed-a05e-37cc479b63f2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "a7b61e4b-6511-c976-8652-004e47055514",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "7ee6631d-7799-f74e-82f4-cd3a6544ea42",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "e18713e5-4bb0-31fc-b936-bd402d083216",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "e6f2d11a-8cc8-371a-9f7b-4c0914944397",
							version = 3,
						},
					},
				},
				mechanicTime = 1235.1,
				name = "[P6] 近战个人减伤",
				timelineIndex = 205,
				timerOffset = -3,
				uuid = "3db44286-7999-4a61-8b25-3c590381f606",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local nidhogg = TensorCore.mGetEntity(eventArgs.entityID)\nlocal hraesvelgr = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 4954, subgroup = \"Nearest\" })\nif nidhogg and hraesvelgr then\n  local nSpell = eventArgs.spellID\n  local hSpell = hraesvelgr.castinginfo.channelingid\n  local duration = (eventArgs.channelTimeMax + 1.2) * 1000\n  local drawer = TensorCore.getMoogleDrawer()\n  if nSpell == 27955 and hSpell == 27957 then\n    local tanks = TensorCore.getEntityGroupList(\"Tank\")\n    if tanks then\n      for _, tank in pairs(tanks) do\n        if tank.alive then\n          drawer:addTimedCircleOnEnt(duration, tank.id, 6)\n        end\n      end\n    end\n  elseif nSpell == 27954 and hSpell == 27957 then\n    if hraesvelgr.targetid then\n      drawer:addTimedCircleOnEnt(duration, hraesvelgr.targetid, 15)\n    end\n    drawer:addTimedConeOnEnt(\n      duration, nidhogg.id, 50, math.rad(30))\n  elseif nSpell == 27955 and hSpell == 27956 then\n    if nidhogg.targetid then\n      drawer:addTimedCircleOnEnt(duration, nidhogg.targetid, 15)\n    end\n    drawer:addTimedConeOnEnt(\n      duration, hraesvelgr.id, 50, math.rad(30))\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"9e9d6d4e-9976-a7ce-b3b4-1574d149a9e7",
									true,
								},
							},
							endIfUsed = true,
							name = "绘制吐息坦克机制",
							uuid = "48cfe392-3dac-ac72-a2ae-d64beee61f8e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "邪龙吐息读条",
							spellIDList = 
							{
								27954,
								27955,
							},
							uuid = "9e9d6d4e-9976-a7ce-b3b4-1574d149a9e7",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1235.1,
				name = "[P6] 第一次双龙吐息坦克机制",
				timeRange = true,
				timelineIndex = 205,
				timerEndOffset = 2,
				timerStartOffset = -10,
				uuid = "0b2b4014-7e1d-6e60-9c02-cca575864301",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil\n    or type(Argus) ~= \"table\"\n    or type(Argus.getCurrentTethers) ~= \"function\" then\n  return\nend\n\nlocal roles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal idByRole = {}\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  idByRole[role] = id\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\nif selfRole == nil then\n  return\nend\n\nlocal groups = {\n  { fixed = \"H1\", mover = \"D3\", x = 95.115, z = 119.39 },\n  { fixed = \"H2\", mover = \"D4\", x = 104.885, z = 119.39 },\n  { fixed = \"D1\", mover = \"D2\", x = 100.0, z = 108.725 },\n}\nlocal targetByRole = {}\nfor _, group in ipairs(groups) do\n  targetByRole[group.fixed] = group\n  targetByRole[group.mover] = group\nend\n\nlocal colorByID = {}\nfor rawSourceID, tethers in pairs(Argus.getCurrentTethers() or {}) do\n  local sourceID = tonumber(rawSourceID)\n  if sourceID ~= nil and roleByID[sourceID] ~= nil\n      and type(tethers) == \"table\" then\n    for _, tether in pairs(tethers) do\n      local tetherType = tonumber(tether and tether.type)\n      if tetherType == 194 then\n        colorByID[sourceID] = \"fire\"\n      elseif tetherType == 195 or tetherType == 196 then\n        colorByID[sourceID] = \"ice\"\n      end\n    end\n  end\nend\n\nlocal fireCount = 0\nlocal iceCount = 0\nfor _, role in ipairs(roles) do\n  local color = colorByID[idByRole[role]]\n  if color == \"fire\" then\n    fireCount = fireCount + 1\n  elseif color == \"ice\" then\n    iceCount = iceCount + 1\n  end\nend\n\nif fireCount ~= 3 or iceCount ~= 3 then\n  return\nend\n\nlocal sameGroups = {}\nfor index, group in ipairs(groups) do\n  local fixedColor = colorByID[idByRole[group.fixed]]\n  local moverColor = colorByID[idByRole[group.mover]]\n  if fixedColor ~= nil and fixedColor == moverColor then\n    sameGroups[#sameGroups + 1] = index\n  end\nend\n\nif #sameGroups == 2 then\n  local first = groups[sameGroups[1]]\n  local second = groups[sameGroups[2]]\n  local firstColor = colorByID[idByRole[first.fixed]]\n  local secondColor = colorByID[idByRole[second.fixed]]\n  if firstColor == secondColor then\n    return\n  end\n  targetByRole[first.mover] = second\n  targetByRole[second.mover] = first\nelseif #sameGroups ~= 0 then\n  return\nend\n\nlocal target = targetByRole[selfRole]\nif target ~= nil then\n  guide.FrameDirect(target.x, target.z, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "按三组冰火组合动态指路",
							uuid = "9a126380-d391-a6bd-84ee-52aee9db2bb9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1235.1,
				name = "[P6] 第一次冰火线换位动态指路",
				timeRange = true,
				timelineIndex = 205,
				timerEndOffset = 1,
				timerStartOffset = -6.5,
				uuid = "5f96c873-79a3-8116-94ea-ecd999440c67",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- 场地坐标按 1:2 转换为游戏世界坐标。\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal roleByID = {}\nfor _, role in ipairs({ \"MT\", \"ST\" }) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\nif selfRole == nil then\n  return\nend\n\nlocal nidhogg = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3458, subgroup = \"Nearest\" })\nlocal hraesvelgr = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 4954, subgroup = \"Nearest\" })\nif not nidhogg or not hraesvelgr then\n  return\nend\n\nlocal nSpell = tonumber(\n  nidhogg.castinginfo and nidhogg.castinginfo.channelingid)\nlocal hSpell = tonumber(\n  hraesvelgr.castinginfo and hraesvelgr.castinginfo.channelingid)\nlocal x, z\n\nif nSpell == 27955 and hSpell == 27957 then\n  x, z = 100.0, 100.0\nelseif (nSpell == 27954 and hSpell == 27957)\n    or (nSpell == 27955 and hSpell == 27956) then\n  if selfRole == \"MT\" then\n    x, z = 84.36, 87.71\n  else\n    x, z = 115.64, 87.71\n  end\nelse\n  return\nend\n\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "按吐息分支指引坦克站位",
							uuid = "368a7a88-1426-08d1-9449-e257dae18e48",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1235.1,
				name = "[P6] 第一次双龙吐息坦克动态指路",
				timeRange = true,
				timelineIndex = 205,
				timerEndOffset = 1,
				timerStartOffset = -6.5,
				uuid = "46d64c7e-4f52-8589-8614-c27d95d66f0e",
				version = 2,
			},
		},
	},
	[207] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetSubType = "Highest HP",
							targetType = "Enemy",
							uuid = "f41ffae6-c9ac-dfe1-9a0d-fc0b2c66096f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1243.1,
				name = "[P6] 自动目标：P6 Highest HP-1",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 207,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "3a17f324-d0a8-d0c7-beff-870bcad8b83b",
				version = 2,
			},
		},
	},
	[208] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 4954,
							targetType = "ContentID",
							uuid = "ac0e1b70-1fe8-90ca-8e05-11174c9dff83",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1254.2,
				name = "[P6] 自动目标：Hraesvelgr-1",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 208,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "da980254-4b6c-0c13-99bc-260ea1bd1655",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"e3c51dfa-d9dc-140f-8e6f-5646f9393aef",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "b7c7f75d-6feb-2bde-8125-e79c780adeab",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"8a5742e7-bbb4-a069-98c8-5c6242cb3b1d",
									true,
								},
								
								{
									"09186240-9fac-9931-af7f-7b48edae5982",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "3f01d59d-2d69-44d4-9b68-114d52ba7a37",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"8f3c52a2-7bf0-400e-917f-11b68454a9ec",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "be111cbc-4494-c36d-95e1-bf29b0c55ca1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "09186240-9fac-9931-af7f-7b48edae5982",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "e3c51dfa-d9dc-140f-8e6f-5646f9393aef",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "8a5742e7-bbb4-a069-98c8-5c6242cb3b1d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "8f3c52a2-7bf0-400e-917f-11b68454a9ec",
							version = 3,
						},
					},
				},
				mechanicTime = 1254.2,
				name = "[P6] 近战个人减伤",
				timelineIndex = 208,
				timerOffset = -3,
				uuid = "617ea510-cce1-b29c-a628-255bfcfbcaf9",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\n-- 27970 (Hraesvelgr) resolves on H1 / MT group.\n-- 27972 (Nidhogg) resolves on H2 / ST group.\nlocal h1ID = tonumber(party.H1 and party.H1.id)\nlocal h2ID = tonumber(party.H2 and party.H2.id)\nif h1ID == nil or h2ID == nil or h1ID == h2ID then\n  return\nend\n\nlocal whiteDrawer = TensorCore.getStaticDrawer(\n  GUI:ColorConvertFloat4ToU32(1, 1, 1, 1))\nlocal grayDrawer = TensorCore.getStaticDrawer(\n  GUI:ColorConvertFloat4ToU32(0.38, 0.38, 0.38, 1))\n\nwhiteDrawer:addTimedCircleOnEnt(5400, h1ID, 4)\ngrayDrawer:addTimedCircleOnEnt(5400, h2ID, 4)\nself.used = true",
							endIfUsed = true,
							name = "按双龙颜色绘制治疗分摊圈",
							uuid = "f90f9543-117a-1a4c-a0a2-27469435412c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1254.2,
				name = "[P6] 首次双分摊白灰治疗圈",
				timelineIndex = 208,
				timerOffset = -5,
				uuid = "6d94393c-d3c2-36a1-8ba1-82426874a9ae",
				version = 2,
			},
		},
	},
	[209] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local dragon = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 3458, subgroup = \"Nearest\" })\nif dragon then TensorCore.getMoogleDrawer():addTimedRectOnEnt(8700, dragon.id, 80, 22) end\nself.used = true",
							endIfUsed = true,
							name = "Draw Cauterize lane",
							uuid = "1dce05dd-a0ae-d07b-897f-9c783eff1b4d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1268.6,
				name = "[P6] 尼德霍格俯冲预绘",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = -8.2,
				timerStartOffset = -8.7,
				uuid = "0d925321-988c-4035-9d3c-7d82a0a2bbef",
				version = 2,
			},
		},
	},
	[211] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local duration = (eventArgs.channelTimeMax + 0.8) * 1000\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif ent then\n  local offset = (eventArgs.spellID == 27939 or eventArgs.spellID == 27940) and 11 or -11\n  local h = ent.pos.h\n  local x = ent.pos.x + offset * math.cos(h)\n  local z = ent.pos.z - offset * math.sin(h)\n  local drawer = TensorCore.getMoogleDrawer()\n  drawer:addTimedRect(duration, x, ent.pos.y, z, 50, 22, h)\n  local tanks = TensorCore.getEntityGroupList(\"Tank\")\n  if tanks then\n    for _, tank in pairs(tanks) do\n      if tank.alive then drawer:addTimedCircleOnEnt(duration, tank.id, 10) end\n    end\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"201af0ba-c57a-2f18-95ce-b0eccaea4e5e",
									true,
								},
							},
							endIfUsed = true,
							name = "绘制神圣之翼矩形与坦克圈",
							uuid = "729d3270-8433-8c35-9b9e-a95b1c602405",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return eventArgs.spellID == 27939 or eventArgs.spellID == 27940 or eventArgs.spellID == 27942 or eventArgs.spellID == 27943",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "神圣之翼读条",
							spellIDList = 
							{
								27939,
								27940,
								27942,
								27943,
							},
							uuid = "201af0ba-c57a-2f18-95ce-b0eccaea4e5e",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1268.7,
				name = "[P6] 神圣之翼左右矩形与坦克圈",
				timeRange = true,
				timelineIndex = 211,
				timerEndOffset = 70,
				timerStartOffset = -10,
				uuid = "7958223d-9077-c9d7-8a66-f7db71ee6f94",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- MT使用中线站位；D1/D2使用近战最远站位。\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nlocal d1ID = tonumber(party.D1 and party.D1.id)\nlocal d2ID = tonumber(party.D2 and party.D2.id)\nif mtID == nil or stID == nil or d1ID == nil or d2ID == nil\n    or mtID == stID or d1ID == d2ID\n    or mtID == d1ID or mtID == d2ID\n    or stID == d1ID or stID == d2ID then\n  return\nend\n\nlocal selfRole = \"PT\"\nif playerID == mtID then\n  selfRole = \"MT\"\nelseif playerID == stID then\n  selfRole = \"ST\"\nend\nlocal selfIsMelee = playerID == d1ID or playerID == d2ID\n\ndata.stringDsrP6Hallowed1 = data.stringDsrP6Hallowed1 or {}\nlocal state = data.stringDsrP6Hallowed1\nif state.hraesvelgrID == nil or state.nidhoggID == nil then\n  local hraesvelgr = TensorCore.getEntityByGroup(\n    \"ContentID\", { contentid = 4954, subgroup = \"Nearest\" })\n  local nidhogg = TensorCore.getEntityByGroup(\n    \"ContentID\", { contentid = 3458, subgroup = \"Nearest\" })\n  if not hraesvelgr or not nidhogg then\n    return\n  end\n  state.hraesvelgrID = tonumber(hraesvelgr.id)\n  state.nidhoggID = tonumber(nidhogg.id)\nend\n\nlocal hraesvelgr = TensorCore.mGetEntity(state.hraesvelgrID)\nlocal nidhogg = TensorCore.mGetEntity(state.nidhoggID)\nif not hraesvelgr or not nidhogg then\n  state.hraesvelgrID = nil\n  state.nidhoggID = nil\n  return\nend\n\nlocal hSpell = tonumber(\n  hraesvelgr.castinginfo and hraesvelgr.castinginfo.channelingid)\nlocal safeNorth\nlocal tanksNear\nif hSpell == 27939 then\n  safeNorth = true\n  tanksNear = true\nelseif hSpell == 27940 then\n  safeNorth = true\n  tanksNear = false\nelseif hSpell == 27942 then\n  safeNorth = false\n  tanksNear = true\nelseif hSpell == 27943 then\n  safeNorth = false\n  tanksNear = false\nelse\n  return\nend\n\nlocal nidhoggX = tonumber(nidhogg.pos and nidhogg.pos.x)\nif nidhoggX == nil or math.abs(nidhoggX - 100) < 1 then\n  return\nend\nlocal safeEast = nidhoggX < 100\n\nlocal targetX\nlocal targetZ\nif selfRole == \"PT\" then\n  if tanksNear then\n    if selfIsMelee then\n      targetX = safeEast and 103 or 100\n      if safeEast then\n        targetZ = safeNorth and 89 or 111\n      else\n        targetZ = safeNorth and 99 or 101\n      end\n    else\n      targetX = safeEast and 102 or 82\n      targetZ = safeNorth and 82 or 118\n    end\n  else\n    targetX = safeEast and 118 or 100\n    targetZ = safeNorth and 97 or 103\n  end\nelseif selfRole == \"MT\" then\n  if tanksNear then\n    if safeEast then\n      targetX = 120\n      targetZ = safeNorth and 98.5 or 101.5\n    else\n      targetX = 97.5\n      targetZ = safeNorth and 97.5 or 102.5\n    end\n  else\n    targetX = safeEast and 102.5 or 80\n    targetZ = safeNorth and 97.5 or 102.5\n  end\nelse\n  if tanksNear then\n    targetX = safeEast and 120 or 97.5\n    if safeNorth then\n      targetZ = safeEast and 82.5 or 80\n    else\n      targetZ = safeEast and 117.5 or 120\n    end\n  else\n    targetX = safeEast and 102.5 or 80\n    targetZ = safeNorth and 80 or 120\n  end\nend\n\nguide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "按四分之一安全区与近远死刑动态指路",
							uuid = "c7de7d7f-d6ed-29fa-ae19-9618d4b2de19",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1268.7,
				name = "[P6] 第一次神圣之翼人群与双T动态指路",
				timeRange = true,
				timelineIndex = 211,
				timerEndOffset = 0.5,
				timerStartOffset = -9,
				uuid = "271dfd2d-9105-7805-8750-704577e30036",
				version = 2,
			},
		},
	},
	[212] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal root = data.string_dsr\nlocal entityID = tonumber(eventArgs.entityID)\nlocal duration = tonumber(eventArgs.buffDuration)\nif entityID == nil or duration == nil or duration <= 0 then\n  self.used = true\n  return\nend\n\nlocal state = root.p6Vow\nif type(state) ~= \"table\" or (tonumber(state.pass) or 0) >= 5 then\n  state = { pass = 0, valid = true }\n  root.p6Vow = state\nend\n\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nlocal idByRole = {}\nlocal mappingValid = type(party) == \"table\"\nif mappingValid then\n  for _, role in ipairs(roles) do\n    local id = tonumber(party[role] and party[role].id)\n    if id == nil or roleByID[id] ~= nil then\n      mappingValid = false\n      break\n    end\n    roleByID[id] = role\n    idByRole[role] = id\n  end\nend\n\nlocal pass = (tonumber(state.pass) or 0) + 1\nlocal holderRole = mappingValid and roleByID[entityID] or nil\nif pass == 1 then\n  local isDPS = holderRole == \"D1\" or holderRole == \"D2\"\n    or holderRole == \"D3\" or holderRole == \"D4\"\n  state.initialRole = isDPS and holderRole or nil\n  state.valid = mappingValid and isDPS\nelseif state.valid and holderRole ~= state.receiverRole then\n  state.valid = false\nend\n\nlocal receiverRole\nif state.valid then\n  if pass == 1 then\n    receiverRole = \"MT\"\n  elseif pass == 2 then\n    receiverRole = \"ST\"\n  elseif pass == 3 then\n    receiverRole = state.initialRole == \"D1\" and \"D2\" or \"D1\"\n  elseif pass == 4 then\n    receiverRole = state.initialRole == \"D1\" and \"D1\" or \"D2\"\n  end\nend\n\nstate.pass = pass\nstate.holderID = entityID\nstate.holderRole = holderRole\nstate.receiverRole = receiverRole\nstate.receiverID = receiverRole and idByRole[receiverRole] or nil\n\nif type(Argus2) == \"table\"\n    and type(Argus2.addTimedCircleFilled) == \"function\"\n    and type(GUI) == \"table\"\n    and type(GUI.ColorConvertFloat4ToU32) == \"function\" then\n  local pinkStart = GUI:ColorConvertFloat4ToU32(1.00, 0.42, 0.64, 0.42)\n  local pinkMid = GUI:ColorConvertFloat4ToU32(1.00, 0.70, 0.82, 0.30)\n  local pinkEnd = GUI:ColorConvertFloat4ToU32(1.00, 0.42, 0.64, 0.42)\n  local purple = GUI:ColorConvertFloat4ToU32(0.62, 0.16, 0.92, 0.98)\n  local greenFill = GUI:ColorConvertFloat4ToU32(0.10, 1.00, 0.28, 0.28)\n  local greenOutline = GUI:ColorConvertFloat4ToU32(0.20, 1.00, 0.36, 0.96)\n  local delay = math.max(0, math.floor((duration - 4) * 1000 + 0.5))\n\n  local function drawDanger(drawDelay)\n    Argus2.addTimedCircleFilled(\n      4000, 0, 0, 0, 5, 50,\n      pinkStart, pinkEnd, pinkMid,\n      drawDelay, entityID,\n      purple, 2, 2, 0.10, 1.8,\n      false, true)\n  end\n\n  if pass == 1 then\n    drawDanger(0)\n  end\n  drawDanger(delay)\n\n  if state.valid and state.receiverID ~= nil then\n    Argus2.addTimedCircleFilled(\n      4000, 0, 0, 0, 1, 32,\n      greenFill, greenFill, nil,\n      delay, state.receiverID,\n      greenOutline, 2, 0, 0.28, 0,\n      false, true)\n  end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"8591d194-1a58-8a2a-a36c-0d73130dba2c",
									true,
								},
							},
							endIfUsed = true,
							name = "记录传毒顺位并预绘交接范围",
							uuid = "952c1d16-9ce8-2cf0-bea9-482da49f3b5e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventBuffID = 2896,
							name = "Mortal Vow",
							uuid = "8591d194-1a58-8a2a-a36c-0d73130dba2c",
							version = 3,
						},
					},
				},
				eventType = 8,
				mechanicTime = 1277.2,
				name = "[P6] 灭杀的誓言传毒范围与顺位状态",
				timeRange = true,
				timelineIndex = 212,
				timerEndOffset = 105,
				timerStartOffset = -35,
				uuid = "462a943d-5968-b7f2-8c22-2890c87e3ba9",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local expectedPass = 1\nlocal root = data.string_dsr\nlocal state = type(root) == \"table\" and root.p6Vow or nil\nif type(state) ~= \"table\"\n    or state.valid ~= true\n    or tonumber(state.pass) ~= expectedPass then\n  return\nend\n\nlocal holderID = tonumber(state.holderID)\nlocal receiverID = tonumber(state.receiverID)\nif holderID == nil or receiverID == nil then\n  return\nend\n\nlocal vow = TensorCore.getBuff(holderID, 2896)\nlocal remaining = tonumber(vow and vow.duration)\nif remaining == nil or remaining <= 0 or remaining > 4.1 then\n  return\nend\n\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal holder = TensorCore.mGetEntity(holderID)\nlocal receiver = TensorCore.mGetEntity(receiverID)\nlocal holderPos = holder and holder.pos or nil\nlocal receiverPos = receiver and receiver.pos or nil\nlocal targetX\nlocal targetZ\n\nif expectedPass == 4 then\n  if playerID == holderID and receiverPos ~= nil then\n    targetX = tonumber(receiverPos.x)\n    targetZ = tonumber(receiverPos.z)\n  elseif playerID == receiverID and holderPos ~= nil then\n    targetX = tonumber(holderPos.x)\n    targetZ = tonumber(holderPos.z)\n  end\nelseif playerID == holderID then\n  targetX = 100\n  targetZ = 100\nelseif playerID == receiverID then\n  local playerPos = player.pos\n  local px = tonumber(playerPos and playerPos.x)\n  local pz = tonumber(playerPos and playerPos.z)\n  if px == nil or pz == nil then\n    return\n  end\n  local dx = px - 100\n  local dz = pz - 100\n  if dx * dx + dz * dz > 2.25 then\n    targetX = 100\n    targetZ = 100\n  elseif holderPos ~= nil then\n    targetX = tonumber(holderPos.x)\n    targetZ = tonumber(holderPos.z)\n  end\nend\n\nif targetX ~= nil and targetZ ~= nil then\n  guide.FrameDirect(targetX, targetZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "按毒剩余时间动态指引交接",
							uuid = "ba8432bc-9ac2-8359-9954-68968979932f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1277.2,
				name = "[P6] 第一次传毒动态指路",
				timeRange = true,
				timelineIndex = 212,
				timerEndOffset = 0.8,
				timerStartOffset = -5.2,
				uuid = "a63aa45a-fe13-a190-a22a-27ed916a5f35",
				version = 2,
			},
		},
	},
	[213] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3458,
							targetType = "ContentID",
							uuid = "0a3535c4-3315-e0ff-bab7-dba99ac597b7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1282.7,
				name = "[P6] 自动目标：Nidhogg-1",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 213,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "bcf21823-0537-0648-9946-300e14ab01b6",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if type(data.string_dsr) ~= \"table\" then\n  data.string_dsr = {}\nend\n\ndata.string_dsr.p6Wroth = {\n  assignmentReady = false,\n  routeReady = false,\n}\nself.used = true",
							endIfUsed = true,
							name = "清空本轮十字火路线与分配状态",
							uuid = "ddad1b11-459d-941e-9717-00e15ea7ba99",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1282.7,
				name = "[P6] 十字火状态初始化",
				timelineIndex = 213,
				timerOffset = 0.1,
				uuid = "2642d511-9172-5b4d-8c21-820ae24d1269",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p6Wroth or nil\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nif type(state) ~= \"table\"\n    or type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\n-- Replay can retain several Hraesvelgr entities. The active Cauterize AOE\n-- is the authoritative source for this pull's real dive lane.\nlocal dive\nif type(Argus) == \"table\" and type(Argus.getCurrentAOEs) == \"function\" then\n  for _, aoe in ipairs(Argus.getCurrentAOEs() or {}) do\n    if aoe ~= nil and aoe.aoeID == 27967 and aoe.contentID == 4954 then\n      dive = aoe\n      break\n    end\n  end\nend\n\nlocal flameCount = 0\nlocal firstCount = 0\nlocal secondCount = 0\nlocal secondZ = 0\nlocal first1X, first1Z\nlocal first2X, first2Z\nlocal first3X, first3Z\n\nfor _, flame in pairs(TensorCore.entityList(\"contentid=3459\") or {}) do\n  local pos = flame and flame.pos or nil\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    flameCount = flameCount + 1\n    local dx = x - 100\n    local dz = z - 100\n    if dx * dx + dz * dz <= 100 then\n      firstCount = firstCount + 1\n      if firstCount == 1 then\n        first1X, first1Z = x, z\n      elseif firstCount == 2 then\n        first2X, first2Z = x, z\n      elseif firstCount == 3 then\n        first3X, first3Z = x, z\n      end\n    else\n      secondCount = secondCount + 1\n      secondZ = secondZ + z\n    end\n  end\nend\n\nif dive ~= nil\n    and flameCount == 6\n    and firstCount == 3\n    and secondCount == 3 then\n  local sideX = dive.x < 95 and 1 or -1\n  local halfZ = secondZ / secondCount < 100 and 1 or -1\n  local startX = 100 + 21.5 * sideX\n  local startZ = 100 + 9.5 * halfZ\n\n  local diveDx = startX - dive.x\n  local diveDz = startZ - dive.z\n  local sinHeading = math.sin(dive.heading)\n  local cosHeading = math.cos(dive.heading)\n  local forward = diveDx * sinHeading + diveDz * cosHeading\n  local lateral = diveDx * cosHeading - diveDz * sinHeading\n  local inDive = forward >= 0\n      and forward <= dive.aoeLength\n      and math.abs(lateral) <= dive.aoeWidth * 0.5\n\n  local first1Dx = math.abs(startX - first1X)\n  local first1Dz = math.abs(startZ - first1Z)\n  local first2Dx = math.abs(startX - first2X)\n  local first2Dz = math.abs(startZ - first2Z)\n  local first3Dx = math.abs(startX - first3X)\n  local first3Dz = math.abs(startZ - first3Z)\n  local inFirstCross = (first1Dx <= 44 and first1Dz <= 3)\n      or (first1Dz <= 44 and first1Dx <= 3)\n      or (first2Dx <= 44 and first2Dz <= 3)\n      or (first2Dz <= 44 and first2Dx <= 3)\n      or (first3Dx <= 44 and first3Dz <= 3)\n      or (first3Dz <= 44 and first3Dx <= 3)\n\n  if not inDive and not inFirstCross then\n    state.sideX = sideX\n    state.halfZ = halfZ\n    state.forwardZ = -halfZ\n\n    state.startX = startX\n    state.startZ = startZ\n    state.drop2X = 100 + 19 * sideX\n    state.drop2Z = 100 + 12.5 * halfZ\n    state.drop3X = 100 + 12.5 * sideX\n    state.drop3Z = 100 + 18 * halfZ\n    state.drop4X = 100 + 4 * sideX\n    state.drop4Z = 100 + 18 * halfZ\n    state.retreat1X = 100 + 2 * sideX\n    state.retreat1Z = 100 + 14 * halfZ\n    state.retreat2X = 100\n    state.retreat2Z = 100 + 8 * halfZ\n    state.centerX = 100\n    state.centerZ = 100\n    state.routeReady = true\n  else\n    state.routeReady = false\n  end\nend\n\nif state.routeReady == true\n    and type(state.startX) == \"number\"\n    and type(state.startZ) == \"number\" then\n  guide.FrameDirect(state.startX, state.startZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "按俯冲与两组火球持续指向第一落点",
							uuid = "e09f2405-4d19-6970-ae11-59824f93596e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1282.7,
				name = "[P6] 十字火起跑点动态指路",
				timeRange = true,
				timelineIndex = 213,
				timerEndOffset = 10.7,
				timerStartOffset = 3.6,
				uuid = "ca871854-3f77-c970-8a0a-92841bac5cdd",
				version = 2,
			},
		},
	},
	[214] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"1992c688-0163-8649-a146-009d2594563f",
									true,
								},
								
								{
									"006acaf9-5110-87c4-898c-bd20f2925a60",
									true,
								},
								
								{
									"d1506441-7348-c238-ac91-8ef7b49ee5fe",
									true,
								},
							},
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "23b9a8b3-31a7-f1bf-ad66-a5e53fa48ec0",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "1992c688-0163-8649-a146-009d2594563f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 6,
							buffIDList = 
							{
								1826,
								1951,
								1934,
							},
							category = "Self",
							name = "Missing Buffs",
							uuid = "006acaf9-5110-87c4-898c-bd20f2925a60",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 4,
							inRangeValue = 20,
							minTargetPercent = true,
							partyTargetNumber = 100,
							partyTargetSubType = "Number",
							uuid = "d1506441-7348-c238-ac91-8ef7b49ee5fe",
							version = 3,
						},
					},
				},
				mechanicTime = 1293.5,
				name = "[P6] 远敏团队减伤",
				timeRange = true,
				timelineIndex = 214,
				timerStartOffset = -4,
				uuid = "d20e01b1-6fbe-6b09-b780-88d61c9ef957",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p6Wroth or nil\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nif type(state) ~= \"table\"\n    or state.routeReady ~= true\n    or type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or type(state.drop2X) ~= \"number\"\n    or type(state.drop2Z) ~= \"number\" then\n  return\nend\n\nguide.FrameDirect(state.drop2X, state.drop2Z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "第一跳后持续指向第二落点",
							uuid = "8da3892a-ae08-cb1c-9e68-3d7e21d8e917",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1293.5,
				name = "[P6] 十字火第一跳后第二落点指路",
				timeRange = true,
				timelineIndex = 214,
				timerEndOffset = 1.55,
				uuid = "238b9ef8-a446-15c1-99de-3df393f2f3bc",
				version = 2,
			},
		},
	},
	[215] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local dragon = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 4954, subgroup = \"Nearest\" })\nif dragon then TensorCore.getMoogleDrawer():addTimedRectOnEnt(8800, dragon.id, 80, 22) end\nself.used = true",
							endIfUsed = true,
							name = "Draw Cauterize lane",
							uuid = "b0317ce7-b2ca-ebb4-9437-fa397df67e46",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1293.6,
				name = "[P6] 赫拉斯瓦尔格俯冲预绘",
				timeRange = true,
				timelineIndex = 215,
				timerEndOffset = -8.3,
				timerStartOffset = -8.8,
				uuid = "4d742ce6-d2f7-b954-baef-18d2a24d3ac9",
				version = 2,
			},
		},
	},
	[216] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"f2d2bcbe-6d49-b0e6-a428-91eeb62adf93",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "心眼",
							uuid = "c067e73d-0318-3f44-b03b-c258d969bf24",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"5cf8eadb-156b-970a-98d9-c32ba4587232",
									true,
								},
								
								{
									"c7e0e814-02c2-a085-b56a-d8e13cd8dbcf",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "金刚极意",
							uuid = "c0f5d69c-b49d-aceb-9c72-52059be9e9dc",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"43639cd6-08fe-b820-bd33-9bfadea00395",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "神秘纹",
							uuid = "8f9dcdd8-4e8a-8b13-83d6-7455250c0fd2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "c7e0e814-02c2-a085-b56a-d8e13cd8dbcf",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "f2d2bcbe-6d49-b0e6-a428-91eeb62adf93",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "5cf8eadb-156b-970a-98d9-c32ba4587232",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "43639cd6-08fe-b820-bd33-9bfadea00395",
							version = 3,
						},
					},
				},
				mechanicTime = 1295.2,
				name = "[P6] 近战个人减伤",
				timelineIndex = 216,
				timerOffset = -3,
				uuid = "bdec4837-9ab2-30ae-9e02-72d7e1582723",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p6Wroth or nil\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nif type(state) ~= \"table\"\n    or state.routeReady ~= true\n    or type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or type(state.drop3X) ~= \"number\"\n    or type(state.drop3Z) ~= \"number\" then\n  return\nend\n\nguide.FrameDirect(state.drop3X, state.drop3Z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "第二跳后持续指向贴边第三落点",
							uuid = "ad1d2e01-e403-e0c1-9782-c6b2d52be96c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1295.2,
				name = "[P6] 十字火第二跳后第三落点指路",
				timeRange = true,
				timelineIndex = 216,
				timerEndOffset = 1.45,
				uuid = "ffd9cf42-2b24-0189-9ea1-cb382dd563ce",
				version = 2,
			},
		},
	},
	[217] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p6Wroth or nil\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nif type(state) ~= \"table\"\n    or state.routeReady ~= true\n    or type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or type(state.drop4X) ~= \"number\"\n    or type(state.drop4Z) ~= \"number\" then\n  return\nend\n\nguide.FrameDirect(state.drop4X, state.drop4Z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "第三跳后持续指向第四落点",
							uuid = "60744bab-33f2-cd4d-9d4e-6b2beb64cde8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1296.8,
				name = "[P6] 十字火第三跳后第四落点指路",
				timeRange = true,
				timelineIndex = 217,
				timerEndOffset = 1.45,
				uuid = "ec7f100b-7591-98c1-b1b4-c74adc558c09",
				version = 2,
			},
		},
	},
	[218] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							conditions = 
							{
								
								{
									"5c2ec39a-d51c-7020-a195-7c4ac30f896d",
									true,
								},
								
								{
									"a2e5f312-2c5a-0ffa-aa8f-5278ba8c9e68",
									true,
								},
							},
							endIfUsed = true,
							name = "牵制",
							targetContentID = 3458,
							targetType = "ContentID",
							uuid = "0b33cd5c-d7e7-2e07-b6f6-6bda98ea8f5e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Feint check",
							uuid = "a2e5f312-2c5a-0ffa-aa8f-5278ba8c9e68",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
								22,
								30,
								34,
								39,
								41,
							},
							name = "牵制职业",
							uuid = "5c2ec39a-d51c-7020-a195-7c4ac30f896d",
							version = 3,
						},
					},
				},
				mechanicTime = 1298.4,
				name = "[P6] 牵制",
				timelineIndex = 218,
				timerOffset = -10,
				uuid = "21e925fe-2d84-72fe-b109-7e4d83f84cfc",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7560,
							conditions = 
							{
								
								{
									"4f9de999-74cd-aa26-be99-ce8d1688f387",
									true,
								},
								
								{
									"32d1ec9c-832c-ea83-b392-fd84bf3796e7",
									true,
								},
							},
							endIfUsed = true,
							name = "昏乱",
							targetContentID = 3458,
							targetType = "ContentID",
							uuid = "06549980-223a-591f-82b9-2c82b0890ca6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1203,
							name = "Addle check",
							uuid = "32d1ec9c-832c-ea83-b392-fd84bf3796e7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
								27,
								35,
								42,
							},
							name = "昏乱职业",
							uuid = "4f9de999-74cd-aa26-be99-ce8d1688f387",
							version = 3,
						},
					},
				},
				mechanicTime = 1298.4,
				name = "[P6] 昏乱",
				timelineIndex = 218,
				timerOffset = -10,
				uuid = "ac81094a-e42f-b7bb-831a-5f0be227afab",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2887,
							conditions = 
							{
								
								{
									"36ec5a83-a3c3-eceb-baf2-e8e129d522b4",
									true,
								},
								
								{
									"6ea74613-32e0-fe91-8eda-5a77f5e7a61d",
									true,
								},
							},
							endIfUsed = true,
							name = "武装解除",
							targetType = "Current Target",
							uuid = "5bd27b94-a5b9-6ec8-a3d4-f11e6e94179f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 860,
							name = "Dismantle check",
							uuid = "6ea74613-32e0-fe91-8eda-5a77f5e7a61d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								31,
							},
							name = "武装解除职业",
							uuid = "36ec5a83-a3c3-eceb-baf2-e8e129d522b4",
							version = 3,
						},
					},
				},
				mechanicTime = 1298.4,
				name = "[P6] 武装解除",
				randomTimeout = 8,
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 218,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "ffa9d22b-b0d6-5996-b470-3af777fcbdfe",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p6Wroth or nil\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nif type(state) ~= \"table\"\n    or state.routeReady ~= true\n    or type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nif state.hotTail == nil then\n  local bosses = TensorCore.entityList(\"contentid=3458\")\n  for _, boss in pairs(bosses or {}) do\n    local castingID = tonumber(boss and boss.castinginfo and boss.castinginfo.castingid)\n    if castingID == 27949 then\n      state.hotTail = true\n      break\n    elseif castingID == 27947 then\n      state.hotTail = false\n      break\n    end\n  end\n\n  if state.hotTail == nil\n      and type(Argus) == \"table\"\n      and type(Argus.getCurrentAOEs) == \"function\" then\n    local aoes = Argus.getCurrentAOEs()\n    for i = 1, #aoes do\n      local aoeID = tonumber(aoes[i] and aoes[i].aoeID)\n      if aoeID == 27950 then\n        state.hotTail = true\n        break\n      elseif aoeID == 27948 then\n        state.hotTail = false\n        break\n      end\n    end\n  end\nend\n\nlocal forwardZ = tonumber(state.forwardZ)\nif state.hotTail == nil\n    or (forwardZ ~= 1 and forwardZ ~= -1) then\n  return\nend\n\nlocal safeZ = 100 + (state.hotTail and forwardZ * 10 or 0)\nguide.FrameDirect(100, safeZ, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "按辣翅辣尾直接指向安全侧",
							uuid = "2845a7be-dd36-6eb1-ac72-12e77faf706b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1298.4,
				name = "[P6] 十字火四火后安全侧动态指路",
				timeRange = true,
				timelineIndex = 218,
				timerEndOffset = 3.6,
				uuid = "5066d82c-d7ef-c54c-a973-9dd693b3ad30",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local party = TensorCore.getEntityGroupList(\"Party\")\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal spread = {}\nlocal stack = {}\nlocal memberCount = 0\n\nfor _, entity in pairs(party) do\n  local entityID = tonumber(entity and entity.id)\n  if entityID ~= nil then\n    memberCount = memberCount + 1\n\n    local spreadBuff = TensorCore.getBuff(entity, 2758)\n    local stackBuff = TensorCore.getBuff(entity, 2759)\n    if spreadBuff ~= nil and stackBuff ~= nil then\n      return\n    end\n\n    if spreadBuff ~= nil then\n      local duration = tonumber(spreadBuff.duration)\n      if duration == nil or duration <= 0 then\n        return\n      end\n      spread[#spread + 1] = { id = entityID, duration = duration }\n    elseif stackBuff ~= nil then\n      local duration = tonumber(stackBuff.duration)\n      if duration == nil or duration <= 0 then\n        return\n      end\n      stack[#stack + 1] = { id = entityID, duration = duration }\n    end\n  end\nend\n\nif memberCount ~= 8 or #spread ~= 4 or #stack ~= 2 then\n  return\nend\n\nlocal spreadFill = GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.18)\nlocal spreadOutline = GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.95)\nlocal stackFill = GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.18)\nlocal stackOutline = GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.95)\n\nlocal spreadDrawer = TensorCore.getCachedDrawer(\n  spreadFill, spreadFill, spreadFill, spreadOutline, 2)\nlocal stackDrawer = TensorCore.getCachedDrawer(\n  stackFill, stackFill, stackFill, stackOutline, 2)\n\nfor i = 1, #spread do\n  local target = spread[i]\n  spreadDrawer:addTimedCircleOnEnt(\n    target.duration * 1000, target.id, 5, 0, nil, true)\nend\n\nfor i = 1, #stack do\n  local target = stack[i]\n  stackDrawer:addTimedCircleOnEnt(\n    target.duration * 1000, target.id, 4, 0, nil, true)\nend\n\nself.used = true",
							endIfUsed = true,
							name = "一次绘制六人分散红圈与分摊绿圈",
							uuid = "2046e136-6e37-48e7-ba3a-93ae856acd7e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1298.4,
				name = "[P6] 邪念之炎分散与分摊范围",
				timeRange = true,
				timelineIndex = 218,
				timerEndOffset = 1.5,
				uuid = "512b0543-e1e5-e9d3-a01d-145ef03a52e5",
				version = 2,
			},
		},
	},
	[219] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetSubType = "Highest HP",
							targetType = "Enemy",
							uuid = "8e4812e3-dfe1-ef9e-bc82-72e97b778cc5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1306.5,
				name = "[P6] 自动目标：P6 Highest HP-2",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 219,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "1fe7dcbe-4e16-1772-8aa6-1ca18df93813",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p6Wroth or nil\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(state) ~= \"table\"\n    or state.assignmentReady ~= true\n    or type(state.categoryByID) ~= \"table\"\n    or type(state.markerByID) ~= \"table\"\n    or type(state.idByMarker) ~= \"table\"\n    or type(state.preTargetByMarker) ~= \"table\"\n    or type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal category = state.categoryByID[playerID]\nlocal marker = tonumber(state.markerByID[playerID])\nif marker == nil then\n  return\nend\n\nif category == \"none\" then\n  local stackMarker = marker == 9 and 6 or marker == 10 and 7 or nil\n  local stackID = stackMarker and tonumber(state.idByMarker[stackMarker]) or nil\n  local stackEntity = stackID and TensorCore.mGetEntity(stackID) or nil\n  local pos = stackEntity and stackEntity.pos or nil\n  if type(pos) ~= \"table\"\n      or type(pos.x) ~= \"number\"\n      or type(pos.z) ~= \"number\" then\n    return\n  end\n  guide.FrameDirect(pos.x, pos.z, 0.5)\n  self.used = true\n  return\nend\n\nlocal target = state.preTargetByMarker[marker]\nif type(target) ~= \"table\"\n    or type(target.x) ~= \"number\"\n    or type(target.z) ~= \"number\" then\n  return\nend\n\nguide.FrameDirect(target.x, target.z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "分散保持世界坐标且分摊搭档跟随锁链目标",
							uuid = "3f47cc36-6e08-71e9-9bc1-f5d40dde05b9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1306.5,
				name = "[P6] 十字火分散分摊结算动态指路",
				timeRange = true,
				timelineIndex = 219,
				timerEndOffset = 0.85,
				timerStartOffset = -1,
				uuid = "47d40298-7374-b491-a075-42ecb0d25171",
				version = 2,
			},
		},
	},
	[220] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"cd0f8ae1-ed6b-cb0a-a73e-02c9cf18b690",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "b010b5e9-2241-6374-a09b-db0da81a0e9a",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"a119cb7d-0577-8dd4-bef9-e47d014ac41c",
									true,
								},
								
								{
									"62737ab5-8fca-27ba-a855-3804d49422da",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "c31dd699-ba4b-8273-96e0-d478c57ad579",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"8a21ac8f-a694-b921-80af-b4ac560f5dd5",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "a9487f80-ddad-b3b3-a2b7-5fb6f557ad5b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "62737ab5-8fca-27ba-a855-3804d49422da",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "cd0f8ae1-ed6b-cb0a-a73e-02c9cf18b690",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "a119cb7d-0577-8dd4-bef9-e47d014ac41c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "8a21ac8f-a694-b921-80af-b4ac560f5dd5",
							version = 3,
						},
					},
				},
				mechanicTime = 1307.1,
				name = "[P6] 近战个人减伤",
				timelineIndex = 220,
				timerOffset = -3,
				uuid = "7aad5449-38b7-6904-9f5b-6b5418864056",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local root = type(data.string_dsr) == \"table\" and data.string_dsr or nil\nlocal state = type(root) == \"table\" and root.p6Wroth or nil\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(state) ~= \"table\"\n    or state.routeReady ~= true\n    or type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nif state.assignmentReady ~= true then\n  local party = guide.Party\n  if type(party) == \"table\" then\n    local roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\n    local groups = { spread = {}, stack = {}, none = {} }\n    local categoryByID = {}\n    local entityByID = {}\n\n    for order = 1, #roles do\n      local role = roles[order]\n      local member = party[role]\n      local id = tonumber(member and member.id)\n      if id ~= nil then\n        local category\n        if TensorCore.hasBuff(id, 2758) then\n          category = \"spread\"\n        elseif TensorCore.hasBuff(id, 2759) then\n          category = \"stack\"\n        else\n          category = \"none\"\n        end\n        categoryByID[id] = category\n        entityByID[id] = TensorCore.mGetEntity(id) or member\n        table.insert(groups[category], { id = id, role = role, order = order })\n      end\n    end\n\n    if #groups.spread == 4 and #groups.stack == 2 and #groups.none == 2 then\n      local late = {}\n      local vow = type(root.p6Vow) == \"table\" and root.p6Vow or nil\n      if type(vow) == \"table\"\n          and vow.valid == true\n          and tonumber(vow.pass) == 2 then\n        local holderID = tonumber(vow.holderID)\n        local receiverID = tonumber(vow.receiverID)\n        if holderID ~= nil then late[holderID] = true end\n        if receiverID ~= nil then late[receiverID] = true end\n      end\n\n      local function moveLateLast(list)\n        local result = {}\n        for i = 1, #list do\n          if late[list[i].id] ~= true then\n            table.insert(result, list[i])\n          end\n        end\n        for i = 1, #list do\n          if late[list[i].id] == true then\n            table.insert(result, list[i])\n          end\n        end\n        return result\n      end\n\n      groups.spread = moveLateLast(groups.spread)\n      groups.stack = moveLateLast(groups.stack)\n      groups.none = moveLateLast(groups.none)\n\n      local fallbackMarkerByID = {}\n      for i = 1, #groups.spread do fallbackMarkerByID[groups.spread[i].id] = i end\n      for i = 1, #groups.stack do fallbackMarkerByID[groups.stack[i].id] = 5 + i end\n      for i = 1, #groups.none do fallbackMarkerByID[groups.none[i].id] = 8 + i end\n\n      local techMarkerByID = {}\n      local techIDByMarker = {}\n      local techValid = true\n      for id, category in pairs(categoryByID) do\n        local entity = entityByID[id]\n        local marker = tonumber(entity and entity.marker)\n        local matches = (category == \"spread\" and marker ~= nil and marker >= 1 and marker <= 4)\n          or (category == \"stack\" and (marker == 6 or marker == 7))\n          or (category == \"none\" and (marker == 9 or marker == 10))\n        if not matches or techIDByMarker[marker] ~= nil then\n          techValid = false\n          break\n        end\n        techMarkerByID[id] = marker\n        techIDByMarker[marker] = id\n      end\n\n      local markerByID = techValid and techMarkerByID or fallbackMarkerByID\n      local idByMarker = {}\n      local complete = true\n      for id, marker in pairs(markerByID) do\n        if idByMarker[marker] ~= nil then\n          complete = false\n          break\n        end\n        idByMarker[marker] = id\n      end\n      local expectedMarkers = { 1, 2, 3, 4, 6, 7, 9, 10 }\n      for i = 1, #expectedMarkers do\n        if idByMarker[expectedMarkers[i]] == nil then\n          complete = false\n          break\n        end\n      end\n\n      if complete then\n        state.categoryByID = categoryByID\n        state.markerByID = markerByID\n        state.idByMarker = idByMarker\n        state.assignmentMode = techValid and \"marker\" or \"role\"\n        state.assignmentReady = true\n      end\n    end\n  end\nend\n\nif state.assignmentReady ~= true\n    or type(state.categoryByID) ~= \"table\"\n    or type(state.markerByID) ~= \"table\"\n    or type(state.idByMarker) ~= \"table\" then\n  return\nend\n\nif state.hotTail == nil then\n  local bosses = TensorCore.entityList(\"contentid=3458\")\n  for _, boss in pairs(bosses or {}) do\n    local castingID = tonumber(boss and boss.castinginfo and boss.castinginfo.castingid)\n    if castingID == 27949 then\n      state.hotTail = true\n      break\n    elseif castingID == 27947 then\n      state.hotTail = false\n      break\n    end\n  end\n\n  if state.hotTail == nil\n      and type(Argus) == \"table\"\n      and type(Argus.getCurrentAOEs) == \"function\" then\n    local aoes = Argus.getCurrentAOEs()\n    for i = 1, #aoes do\n      local aoeID = tonumber(aoes[i] and aoes[i].aoeID)\n      if aoeID == 27950 then\n        state.hotTail = true\n        break\n      elseif aoeID == 27948 then\n        state.hotTail = false\n        break\n      end\n    end\n  end\nend\n\nlocal forwardZ = tonumber(state.forwardZ)\nlocal marker = tonumber(state.markerByID[playerID])\nif state.hotTail == nil\n    or marker == nil\n    or (forwardZ ~= 1 and forwardZ ~= -1) then\n  return\nend\n\nif type(state.preTargetByMarker) ~= \"table\"\n    or state.preTargetHotTail ~= state.hotTail then\n  local offsets = {\n    [1] = 18,\n    [2] = 12,\n    [3] = 6,\n    [4] = 0,\n    [6] = -18,\n    [7] = -9,\n    [9] = -18,\n    [10] = -9,\n  }\n  local targetZ = 100 + (state.hotTail and forwardZ * 10 or 0)\n  local targets = {}\n  for mark, offset in pairs(offsets) do\n    targets[mark] = { x = 100 + forwardZ * offset, z = targetZ }\n  end\n  state.preTargetByMarker = targets\n  state.preTargetHotTail = state.hotTail\nend\n\nlocal target = state.preTargetByMarker[marker]\nif type(target) ~= \"table\" then\n  return\nend\n\nstate.playerMarker = marker\nstate.finalX = target.x\nstate.finalZ = target.z\nguide.FrameDirect(target.x, target.z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "按辣翅辣尾与完整标记分配指向预站位",
							uuid = "e113911b-79ef-f0c0-a59a-d63e490d74ee",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1307.1,
				name = "[P6] 十字火分散分摊预站位动态指路",
				timeRange = true,
				timelineIndex = 220,
				timerEndOffset = -1.6,
				timerStartOffset = -5.1,
				uuid = "43ffbad1-1cc0-3185-b0b8-c5bf6473bf60",
				version = 2,
			},
		},
	},
	[222] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local expectedPass = 2\nlocal root = data.string_dsr\nlocal state = type(root) == \"table\" and root.p6Vow or nil\nif type(state) ~= \"table\"\n    or state.valid ~= true\n    or tonumber(state.pass) ~= expectedPass then\n  return\nend\n\nlocal holderID = tonumber(state.holderID)\nlocal receiverID = tonumber(state.receiverID)\nif holderID == nil or receiverID == nil then\n  return\nend\n\nlocal vow = TensorCore.getBuff(holderID, 2896)\nlocal remaining = tonumber(vow and vow.duration)\nif remaining == nil or remaining <= 0 or remaining > 4.1 then\n  return\nend\n\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal holder = TensorCore.mGetEntity(holderID)\nlocal receiver = TensorCore.mGetEntity(receiverID)\nlocal holderPos = holder and holder.pos or nil\nlocal receiverPos = receiver and receiver.pos or nil\nlocal targetX\nlocal targetZ\n\nif expectedPass == 4 then\n  if playerID == holderID and receiverPos ~= nil then\n    targetX = tonumber(receiverPos.x)\n    targetZ = tonumber(receiverPos.z)\n  elseif playerID == receiverID and holderPos ~= nil then\n    targetX = tonumber(holderPos.x)\n    targetZ = tonumber(holderPos.z)\n  end\nelseif playerID == holderID then\n  targetX = 100\n  targetZ = 100\nelseif playerID == receiverID then\n  local playerPos = player.pos\n  local px = tonumber(playerPos and playerPos.x)\n  local pz = tonumber(playerPos and playerPos.z)\n  if px == nil or pz == nil then\n    return\n  end\n  local dx = px - 100\n  local dz = pz - 100\n  if dx * dx + dz * dz > 2.25 then\n    targetX = 100\n    targetZ = 100\n  elseif holderPos ~= nil then\n    targetX = tonumber(holderPos.x)\n    targetZ = tonumber(holderPos.z)\n  end\nend\n\nif targetX ~= nil and targetZ ~= nil then\n  guide.FrameDirect(targetX, targetZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "按毒剩余时间动态指引交接",
							uuid = "5e5c81c7-fa1c-f1af-bb12-a1559fa88df7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1311.5,
				name = "[P6] 第二次传毒动态指路",
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 0.8,
				timerStartOffset = -5.2,
				uuid = "1a2aa552-e5c5-6907-ab12-73e141667096",
				version = 2,
			},
		},
	},
	[223] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 4954,
							targetType = "ContentID",
							uuid = "1f05d4df-498c-7f75-b950-8368e79993a4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1323.7,
				name = "[P6] 自动目标：Hraesvelgr-2",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 223,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "1f10fe79-4c1d-953d-a147-dd6da96613d4",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"ce8a4c94-7ec7-c95c-a046-67ce41f81721",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "cf8ea74e-66f5-1ac2-82f3-14ee8fd55b31",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"31fdff36-2481-1d5c-b276-5521f627a0fa",
									true,
								},
								
								{
									"620749f5-5a34-5098-992f-cf759fc15947",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "1b7ff093-ebd8-cbff-ae4a-49d50e2aab2a",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"7eda1907-31ed-f937-8845-8b4e0b86b363",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "08cbe0f1-27c3-1e1a-8e81-f3f2f48c6325",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "620749f5-5a34-5098-992f-cf759fc15947",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "ce8a4c94-7ec7-c95c-a046-67ce41f81721",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "31fdff36-2481-1d5c-b276-5521f627a0fa",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "7eda1907-31ed-f937-8845-8b4e0b86b363",
							version = 3,
						},
					},
				},
				mechanicTime = 1323.7,
				name = "[P6] 近战个人减伤",
				timelineIndex = 223,
				timerOffset = -3,
				uuid = "f09ce04b-8b38-0100-b728-afa51c75decc",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2241,
							conditions = 
							{
								
								{
									"24d6335c-2b2b-db79-b8d6-6b8c80dac830",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "残影",
							uuid = "ecea5f46-81c0-be5d-b930-eefd2b78239b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								30,
							},
							name = "残影职业",
							uuid = "24d6335c-2b2b-db79-b8d6-6b8c80dac830",
							version = 3,
						},
					},
				},
				mechanicTime = 1323.7,
				name = "[P6] 残影",
				timelineIndex = 223,
				timerOffset = -2.5,
				uuid = "a35f00be-30dd-4cc7-8cdf-51eaf664a569",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 157,
							conditions = 
							{
								
								{
									"aa17c4ca-d7a1-fbf2-8136-64aec3cffb62",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "魔罩",
							uuid = "3ac17452-33ca-ca39-80a6-ce74b7afc059",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								25,
							},
							name = "魔罩职业",
							uuid = "aa17c4ca-d7a1-fbf2-8136-64aec3cffb62",
							version = 3,
						},
					},
				},
				mechanicTime = 1323.7,
				name = "[P6] 魔罩",
				timelineIndex = 223,
				timerOffset = -2.5,
				uuid = "3811bd2b-5f65-a18e-80fc-c8cc096a151e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\n-- Second Akh Afah: 27970 (Hraesvelgr) resolves on H2 / ST group.\n-- 27972 (Nidhogg) resolves on H1 / MT group.\nlocal h1ID = tonumber(party.H1 and party.H1.id)\nlocal h2ID = tonumber(party.H2 and party.H2.id)\nif h1ID == nil or h2ID == nil or h1ID == h2ID then\n  return\nend\n\nlocal whiteDrawer = TensorCore.getStaticDrawer(\n  GUI:ColorConvertFloat4ToU32(1, 1, 1, 1))\nlocal grayDrawer = TensorCore.getStaticDrawer(\n  GUI:ColorConvertFloat4ToU32(0.38, 0.38, 0.38, 1))\n\nwhiteDrawer:addTimedCircleOnEnt(5400, h2ID, 4)\ngrayDrawer:addTimedCircleOnEnt(5400, h1ID, 4)\nself.used = true",
							endIfUsed = true,
							name = "按双龙颜色绘制第二次治疗分摊圈",
							uuid = "057712c7-6da8-acd2-8cb2-1a549e5862a1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1323.7,
				name = "[P6] 第二次双分摊白灰治疗圈",
				timelineIndex = 223,
				timerOffset = -5,
				uuid = "5bf052d0-55a7-a550-ba9b-215682d0d4de",
				version = 2,
			},
		},
	},
	[229] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- MT使用中线站位。\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal roleByID = {}\nfor _, role in ipairs({ \"MT\", \"ST\" }) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\nlocal selfRole = roleByID[playerID] or \"PT\"\n\nlocal hraesvelgr = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 4954, subgroup = \"Nearest\" })\nif not hraesvelgr then\n  return\nend\nlocal hSpell = tonumber(\n  hraesvelgr.castinginfo and hraesvelgr.castinginfo.channelingid)\nlocal pattern = ({\n  [27939] = { safeNorth = true, tanksNear = true },\n  [27940] = { safeNorth = true, tanksNear = false },\n  [27942] = { safeNorth = false, tanksNear = true },\n  [27943] = { safeNorth = false, tanksNear = false },\n})[hSpell]\nif pattern == nil then\n  return\nend\n\nlocal nidhogg = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3458, subgroup = \"Nearest\" })\nlocal nSpell = tonumber(nidhogg and nidhogg.castinginfo\n  and nidhogg.castinginfo.channelingid)\nlocal hotTail\nif nSpell == 27947 or nSpell == 27948 then\n  hotTail = false\nelseif nSpell == 27949 or nSpell == 27950 then\n  hotTail = true\nelse\n  return\nend\nlocal z\nif pattern.safeNorth then\n  z = hotTail and 87.5 or 97.5\nelse\n  z = hotTail and 112.5 or 102.5\nend\n\nlocal x\nif pattern.tanksNear then\n  if selfRole == \"MT\" then\n    x = 102.5\n  elseif selfRole == \"ST\" then\n    x = 120.5\n  else\n    x = 85\n  end\nelse\n  if selfRole == \"MT\" then\n    x = 97.5\n  elseif selfRole == \"ST\" then\n    x = 79.5\n  else\n    x = 119\n  end\nend\n\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "按神圣之翼与辣翅辣尾动态指路",
							uuid = "d0b5ddf9-42f7-cb49-b283-4d3d82df9cf1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1337,
				name = "[P6] 第二次神圣之翼人群与双T动态指路",
				timeRange = true,
				timelineIndex = 229,
				timerEndOffset = 0.5,
				timerStartOffset = -9,
				uuid = "fbe638ff-fa39-a516-a8b7-1fc5dc59705c",
				version = 2,
			},
		},
	},
	[230] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local expectedPass = 3\nlocal root = data.string_dsr\nlocal state = type(root) == \"table\" and root.p6Vow or nil\nif type(state) ~= \"table\"\n    or state.valid ~= true\n    or tonumber(state.pass) ~= expectedPass then\n  return\nend\n\nlocal holderID = tonumber(state.holderID)\nlocal receiverID = tonumber(state.receiverID)\nif holderID == nil or receiverID == nil then\n  return\nend\n\nlocal vow = TensorCore.getBuff(holderID, 2896)\nlocal remaining = tonumber(vow and vow.duration)\nif remaining == nil or remaining <= 0 or remaining > 4.1 then\n  return\nend\n\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal holder = TensorCore.mGetEntity(holderID)\nlocal receiver = TensorCore.mGetEntity(receiverID)\nlocal holderPos = holder and holder.pos or nil\nlocal receiverPos = receiver and receiver.pos or nil\nlocal targetX\nlocal targetZ\n\nif expectedPass == 4 then\n  if playerID == holderID and receiverPos ~= nil then\n    targetX = tonumber(receiverPos.x)\n    targetZ = tonumber(receiverPos.z)\n  elseif playerID == receiverID and holderPos ~= nil then\n    targetX = tonumber(holderPos.x)\n    targetZ = tonumber(holderPos.z)\n  end\nelseif playerID == holderID then\n  targetX = 100\n  targetZ = 100\nelseif playerID == receiverID then\n  local playerPos = player.pos\n  local px = tonumber(playerPos and playerPos.x)\n  local pz = tonumber(playerPos and playerPos.z)\n  if px == nil or pz == nil then\n    return\n  end\n  local dx = px - 100\n  local dz = pz - 100\n  if dx * dx + dz * dz > 2.25 then\n    targetX = 100\n    targetZ = 100\n  elseif holderPos ~= nil then\n    targetX = tonumber(holderPos.x)\n    targetZ = tonumber(holderPos.z)\n  end\nend\n\nif targetX ~= nil and targetZ ~= nil then\n  guide.FrameDirect(targetX, targetZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "按毒剩余时间动态指引交接",
							uuid = "c46167a6-f0b1-f87f-ae5c-bea5e7ea3fde",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1345.5,
				name = "[P6] 第三次传毒动态指路",
				timeRange = true,
				timelineIndex = 230,
				timerEndOffset = 0.8,
				timerStartOffset = -5.2,
				uuid = "afdf40ce-7baf-d514-bac3-833304d26467",
				version = 2,
			},
		},
	},
	[232] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local duration = (eventArgs.channelTimeMax + 1.2) * 1000\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nlocal moogleDrawer = TensorCore.getMoogleDrawer()\nlocal outlineThickness =\n  (tonumber(moogleDrawer and moogleDrawer.outlineThickness) or 1.5) + 0.5\n\nlocal fireColor =\n  GUI:ColorConvertFloat4ToU32(1, 0.12, 0.02, 0.45)\nlocal iceColor =\n  GUI:ColorConvertFloat4ToU32(0.05, 0.55, 1, 0.45)\nlocal blackOutline =\n  GUI:ColorConvertFloat4ToU32(0, 0, 0, 1)\nlocal whiteOutline =\n  GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)\n\nlocal fireDrawer = TensorCore.getStaticDrawer(fireColor)\nlocal iceDrawer = TensorCore.getStaticDrawer(iceColor)\nlocal ownFireDrawer = TensorCore.getCachedDrawer(\n  fireColor, nil, fireColor, blackOutline, outlineThickness)\nlocal ownIceDrawer = TensorCore.getCachedDrawer(\n  iceColor, nil, iceColor, whiteOutline, outlineThickness)\n\nlocal dragon = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3458, subgroup = \"Nearest\" })\nif dragon then\n  local tethers = Argus.getTethersOnEnt(dragon.id)\n  for i = 1, #tethers do\n    local partnerID = tonumber(tethers[i].partnerid)\n    if partnerID then\n      local drawer =\n        partnerID == playerID and ownFireDrawer or fireDrawer\n      drawer:addTimedConeOnEnt(\n        duration, dragon.id, 100, math.rad(15), partnerID)\n    end\n  end\nend\n\ndragon = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 4954, subgroup = \"Nearest\" })\nif dragon then\n  local tethers = Argus.getTethersOnEnt(dragon.id)\n  for i = 1, #tethers do\n    local partnerID = tonumber(tethers[i].partnerid)\n    if partnerID then\n      local drawer =\n        partnerID == playerID and ownIceDrawer or iceDrawer\n      drawer:addTimedConeOnEnt(\n        duration, dragon.id, 100, math.rad(15), partnerID)\n    end\n  end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"b7b7c0ac-e4ba-3809-a19b-a77c4b9ed6db",
									true,
								},
							},
							endIfUsed = true,
							name = "绘制火红与冰蓝龙息扇形",
							uuid = "d36f3477-149d-ec30-99a5-c47a1d6f06f0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return (eventArgs.sourceEntityContentID == 3458 or eventArgs.sourceEntityContentID == 4954) and eventArgs.newTargetID and eventArgs.newTargetID > 0",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "双龙吐息读条",
							spellIDList = 
							{
								27954,
								27955,
								27956,
								27957,
							},
							uuid = "b7b7c0ac-e4ba-3809-a19b-a77c4b9ed6db",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1355.7,
				name = "[P6] 第二次龙牙龙爪连线扇形",
				timeRange = true,
				timelineIndex = 232,
				timerEndOffset = 2,
				timerStartOffset = -10,
				uuid = "a4d73462-8987-8718-9fb0-ba78b6c64a58",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local nidhogg = TensorCore.mGetEntity(eventArgs.entityID)\nlocal hraesvelgr = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 4954, subgroup = \"Nearest\" })\nif nidhogg and hraesvelgr then\n  local nSpell = eventArgs.spellID\n  local hSpell = hraesvelgr.castinginfo.channelingid\n  local duration = (eventArgs.channelTimeMax + 1.2) * 1000\n  local drawer = TensorCore.getMoogleDrawer()\n  if nSpell == 27955 and hSpell == 27957 then\n    local tanks = TensorCore.getEntityGroupList(\"Tank\")\n    if tanks then\n      for _, tank in pairs(tanks) do\n        if tank.alive then\n          drawer:addTimedCircleOnEnt(duration, tank.id, 6)\n        end\n      end\n    end\n  elseif nSpell == 27954 and hSpell == 27957 then\n    if hraesvelgr.targetid then\n      drawer:addTimedCircleOnEnt(duration, hraesvelgr.targetid, 15)\n    end\n    drawer:addTimedConeOnEnt(\n      duration, nidhogg.id, 50, math.rad(30))\n  elseif nSpell == 27955 and hSpell == 27956 then\n    if nidhogg.targetid then\n      drawer:addTimedCircleOnEnt(duration, nidhogg.targetid, 15)\n    end\n    drawer:addTimedConeOnEnt(\n      duration, hraesvelgr.id, 50, math.rad(30))\n  end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"c20322e5-4311-4d32-9911-ca6df6f4b3ed",
									true,
								},
							},
							endIfUsed = true,
							name = "绘制吐息坦克机制",
							uuid = "7de9242b-aa3e-c461-a33c-23ca71081e92",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "邪龙吐息读条",
							spellIDList = 
							{
								27954,
								27955,
							},
							uuid = "c20322e5-4311-4d32-9911-ca6df6f4b3ed",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1355.7,
				name = "[P6] 第二次双龙吐息坦克机制",
				timeRange = true,
				timelineIndex = 232,
				timerEndOffset = 2,
				timerStartOffset = -10,
				uuid = "2b755570-fe10-5ed5-b6a7-8af3f5c2e98f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- 固定站位按 1:2 转换；D3/D4 的 Z 坐标向内修正以避开 20–35 米冰环。\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nlocal idByRole = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\n  idByRole[role] = id\nend\n\nlocal selfRole = roleByID[playerID]\nif selfRole == nil then\n  return\nend\n\nlocal nidhogg = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3458, subgroup = \"Nearest\" })\nlocal hraesvelgr = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 4954, subgroup = \"Nearest\" })\nif not nidhogg or not hraesvelgr then\n  return\nend\n\nlocal x, z\nif selfRole == \"MT\" or selfRole == \"ST\" then\n  local nSpell = tonumber(\n    nidhogg.castinginfo and nidhogg.castinginfo.channelingid)\n  local hSpell = tonumber(\n    hraesvelgr.castinginfo and hraesvelgr.castinginfo.channelingid)\n\n  if nSpell == 27955 and hSpell == 27957 then\n    x, z = 100.0, 100.0\n  elseif (nSpell == 27954 and hSpell == 27957)\n      or (nSpell == 27955 and hSpell == 27956) then\n    if selfRole == \"MT\" then\n      x, z = 84.25, 87.25\n    else\n      x, z = 115.75, 112.75\n    end\n  else\n    return\n  end\nelse\n  if type(Argus) ~= \"table\"\n      or type(Argus.getTethersOnEnt) ~= \"function\" then\n    return\n  end\n\n  local tethered = {}\n  local function collectTethers(dragon)\n    for _, tether in pairs(Argus.getTethersOnEnt(dragon.id) or {}) do\n      local partnerID = tonumber(tether and tether.partnerid)\n      local role = partnerID and roleByID[partnerID] or nil\n      if role ~= nil and role ~= \"MT\" and role ~= \"ST\" then\n        tethered[partnerID] = true\n      end\n    end\n  end\n\n  collectTethers(nidhogg)\n  collectTethers(hraesvelgr)\n\n  local nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\n  local tetherCount = 0\n  for _, role in ipairs(nonTankRoles) do\n    if tethered[idByRole[role]] then\n      tetherCount = tetherCount + 1\n    end\n  end\n  if tetherCount ~= 6 then\n    return\n  end\n\n  local targets = {\n    H1 = { x = 100.0, z = 80.0 },\n    H2 = { x = 100.0, z = 120.0 },\n    D1 = { x = 103.775, z = 89.4 },\n    D2 = { x = 96.225, z = 110.6 },\n    D3 = { x = 107.75, z = 82.25 },\n    D4 = { x = 92.25, z = 117.75 },\n  }\n  local target = targets[selfRole]\n  if target == nil then\n    return\n  end\n  x, z = target.x, target.z\nend\n\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "按固定职能站位与吐息分支指路",
							uuid = "e99badbe-63db-343b-b685-92ab0bb5b2ff",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1355.7,
				name = "[P6] 第二次双龙吐息八人固定动态指路",
				timeRange = true,
				timelineIndex = 232,
				timerEndOffset = 1,
				timerStartOffset = -6.5,
				uuid = "a394f911-2fc1-df2c-94b4-4de97dceb7fe",
				version = 2,
			},
		},
	},
	[234] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"d7f7df23-0569-ea85-93ad-e90ddc239c5b",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3458,
							targetType = "ContentID",
							uuid = "a070ed39-0cd2-54fb-8d8d-677e4d61d821",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "d7f7df23-0569-ea85-93ad-e90ddc239c5b",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 1369,
				name = "[P6] 自动目标：Nidhogg 续打",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 234,
				timerEndOffset = 5,
				timerStartOffset = -8,
				uuid = "1d54f357-5d6c-4dba-9476-47e573a0d241",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local duration = eventArgs.channelTimeMax * 1000\nTensorCore.getMoogleDrawer():addTimedRectOnEnt(duration, eventArgs.entityID, 80, 22)\nself.used = true",
							conditions = 
							{
								
								{
									"87c2743f-24be-9a07-9f38-d1608a970f99",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw Cauterize lane",
							uuid = "2871a73d-938e-056a-ac16-714d97d156ad",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 27966,
							name = "俯冲读条",
							uuid = "87c2743f-24be-9a07-9f38-d1608a970f99",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1369,
				name = "[P6] 双龙俯冲：尼德霍格",
				timeRange = true,
				timelineIndex = 234,
				timerEndOffset = 1,
				timerStartOffset = -6,
				uuid = "3b43123e-7315-4e14-ac3d-4ba64fd0ee7a",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local duration = eventArgs.channelTimeMax * 1000\nTensorCore.getMoogleDrawer():addTimedRectOnEnt(duration, eventArgs.entityID, 80, 22)\nself.used = true",
							conditions = 
							{
								
								{
									"12e12397-077a-d0f5-b6d8-90ef474501e6",
									true,
								},
							},
							endIfUsed = true,
							name = "Draw Cauterize lane",
							uuid = "50752396-cd3f-8084-8ed7-576880cc4603",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 27967,
							name = "俯冲读条",
							uuid = "12e12397-077a-d0f5-b6d8-90ef474501e6",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1369,
				name = "[P6] 双龙俯冲：赫拉斯瓦尔格",
				timeRange = true,
				timelineIndex = 234,
				timerEndOffset = 1,
				timerStartOffset = -6,
				uuid = "761a635c-de25-9b76-a541-f9c0b0153da5",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal nidhogg = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 3458, subgroup = \"Nearest\" })\nlocal hraesvelgr = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 4954, subgroup = \"Nearest\" })\nif not nidhogg or not hraesvelgr\n    or not nidhogg.pos or not hraesvelgr.pos then\n  return\nend\n\nlocal nSpell = tonumber(\n  nidhogg.castinginfo and nidhogg.castinginfo.channelingid)\nlocal hSpell = tonumber(\n  hraesvelgr.castinginfo and hraesvelgr.castinginfo.channelingid)\nif nSpell ~= 27966 or hSpell ~= 27967 then\n  return\nend\n\nlocal nX = tonumber(nidhogg.pos.x)\nlocal hX = tonumber(hraesvelgr.pos.x)\nif nX == nil or hX == nil or math.abs(nX - hX) < 1 then\n  return\nend\n\nlocal leftDragon = nX < hX and nidhogg or hraesvelgr\nlocal rightDragon = nX < hX and hraesvelgr or nidhogg\nlocal x, z\n\nif playerID == mtID then\n  x, z = leftDragon.pos.x, 80.0\nelseif playerID == stID then\n  x, z = rightDragon.pos.x, 80.0\nelse\n  local boiling = TensorCore.hasBuff(player, 2898) == true\n  local freezing = TensorCore.hasBuff(player, 2899) == true\n  if boiling == freezing then\n    return\n  end\n\n  local targetDragon = freezing and nidhogg or hraesvelgr\n  local targetX = tonumber(targetDragon.pos and targetDragon.pos.x)\n  if targetX == nil or math.abs(targetX - 100.0) < 1 then\n    return\n  end\n\n  local side = targetX < 100.0 and -1 or 1\n  x, z = 100.0 + side * 4.0, 94.0\nend\n\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "按左右龙与渐热渐冻指路",
							uuid = "71ea955d-3098-8531-986b-e52797ff8320",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1369,
				name = "[P6] 最终双龙俯冲动态指路",
				timeRange = true,
				timelineIndex = 234,
				timerEndOffset = 0.2,
				timerStartOffset = -5.2,
				uuid = "14056582-842a-af98-9459-a35853b74e15",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"263d24de-c2fc-29bf-8629-751bd3220f2b",
									true,
								},
							},
							name = "热病前选中自己",
							setTarget = true,
							uuid = "4f8b2147-48c1-63cc-83a9-b37fda8d198e",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"4ba07b23-a06f-c3e2-b621-270f2211e093",
									true,
								},
							},
							name = "热病前停止所有行动",
							stopAllActions = true,
							uuid = "c3ca9fd4-2973-0ac3-b9ef-809d2f3007ed",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"17397fe1-92ee-c03f-959d-314497992d1d",
									true,
								},
								
								{
									"5075d0b9-42b8-ab98-9d35-2d19b99ab0d4",
									true,
								},
								
								{
									"d7a75739-66fd-1717-938e-a85b3ae10017",
									true,
								},
							},
							endIfUsed = true,
							name = "热病消失恢复所有行动",
							resumeAllActions = true,
							uuid = "af56d228-2528-5e0f-9d0f-ddf4318ef121",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 2,
							buffID = 2898,
							category = "Self",
							comparator = 2,
							name = "渐热 <=2s",
							uuid = "263d24de-c2fc-29bf-8629-751bd3220f2b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 1,
							buffID = 2898,
							category = "Self",
							comparator = 2,
							name = "渐热 <=1s",
							uuid = "4ba07b23-a06f-c3e2-b621-270f2211e093",
							version = 3,
						},
					},
					
					{
						data = 
						{
							actionUUID = "c3ca9fd4-2973-0ac3-b9ef-809d2f3007ed",
							category = "Action",
							name = "已停止所有行动",
							uuid = "17397fe1-92ee-c03f-959d-314497992d1d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 2898,
							category = "Self",
							name = "渐热已消失",
							uuid = "5075d0b9-42b8-ab98-9d35-2d19b99ab0d4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 960,
							category = "Self",
							name = "热病已消失",
							uuid = "d7a75739-66fd-1717-938e-a85b3ae10017",
							version = 3,
						},
					},
				},
				mechanicTime = 1369,
				name = "[P6] 双龙俯冲热病停手",
				timeRange = true,
				timelineIndex = 234,
				timerEndOffset = 6,
				timerStartOffset = -2.5,
				uuid = "42d5cef0-3acf-969d-890b-25a153ffb49a",
				version = 2,
			},
		},
	},
	[235] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 3458,
							targetType = "ContentID",
							uuid = "5395bf07-fd10-8531-8099-3ea58d4b7dc7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1375.1,
				name = "[P6] 自动目标：Nidhogg-2",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 235,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "a6ca7183-a777-4444-b87f-52d3896287ac",
				version = 2,
			},
		},
	},
	[236] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local expectedPass = 4\nlocal root = data.string_dsr\nlocal state = type(root) == \"table\" and root.p6Vow or nil\nif type(state) ~= \"table\"\n    or state.valid ~= true\n    or tonumber(state.pass) ~= expectedPass then\n  return\nend\n\nlocal holderID = tonumber(state.holderID)\nlocal receiverID = tonumber(state.receiverID)\nif holderID == nil or receiverID == nil then\n  return\nend\n\nlocal vow = TensorCore.getBuff(holderID, 2896)\nlocal remaining = tonumber(vow and vow.duration)\nif remaining == nil or remaining <= 0 or remaining > 4.1 then\n  return\nend\n\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(guide) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal holder = TensorCore.mGetEntity(holderID)\nlocal receiver = TensorCore.mGetEntity(receiverID)\nlocal holderPos = holder and holder.pos or nil\nlocal receiverPos = receiver and receiver.pos or nil\nlocal targetX\nlocal targetZ\n\nif expectedPass == 4 then\n  if playerID == holderID and receiverPos ~= nil then\n    targetX = tonumber(receiverPos.x)\n    targetZ = tonumber(receiverPos.z)\n  elseif playerID == receiverID and holderPos ~= nil then\n    targetX = tonumber(holderPos.x)\n    targetZ = tonumber(holderPos.z)\n  end\nelseif playerID == holderID then\n  targetX = 100\n  targetZ = 100\nelseif playerID == receiverID then\n  local playerPos = player.pos\n  local px = tonumber(playerPos and playerPos.x)\n  local pz = tonumber(playerPos and playerPos.z)\n  if px == nil or pz == nil then\n    return\n  end\n  local dx = px - 100\n  local dz = pz - 100\n  if dx * dx + dz * dz > 2.25 then\n    targetX = 100\n    targetZ = 100\n  elseif holderPos ~= nil then\n    targetX = tonumber(holderPos.x)\n    targetZ = tonumber(holderPos.z)\n  end\nend\n\nif targetX ~= nil and targetZ ~= nil then\n  guide.FrameDirect(targetX, targetZ, 0.5)\n  self.used = true\nend",
							endIfUsed = true,
							name = "按毒剩余时间动态指引交接",
							uuid = "9ee47d9f-9739-3dd1-b0f9-72c3374115ef",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1379.1,
				name = "[P6] 第四次传毒原地动态指路",
				timeRange = true,
				timelineIndex = 236,
				timerEndOffset = 0.8,
				timerStartOffset = -5.2,
				uuid = "a95b9345-4474-b518-bbc0-31424b004058",
				version = 2,
			},
		},
	},
	[237] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"7dc747cb-8271-3247-ae5a-f143fe9aedca",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetType = "Enemy",
							uuid = "d615a0b0-a3ab-308b-8208-94a41da4bbf8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "7dc747cb-8271-3247-ae5a-f143fe9aedca",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 1401.7,
				name = "[P6] 自动目标：P6 收尾",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 237,
				timerEndOffset = 5,
				timerStartOffset = -10,
				uuid = "48d2066f-68a3-242f-a823-eea0609f684f",
				version = 2,
			},
		},
	},
	[242] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"dd2fb71c-9cb1-fb7a-94fb-5c19fc14ac54",
									true,
								},
								
								{
									"33a1c884-9f47-8eab-8a15-01edba649bd5",
									true,
								},
								
								{
									"5287f0af-ff78-82ef-847e-1544eae30839",
									true,
								},
								
								{
									"cbf233f3-b03b-b641-88c5-758e27044985",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "e8570f56-7a1e-271c-a887-14894c7c759b",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "dd2fb71c-9cb1-fb7a-94fb-5c19fc14ac54",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1934,
							category = "Self",
							uuid = "33a1c884-9f47-8eab-8a15-01edba649bd5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1951,
							category = "Self",
							uuid = "5287f0af-ff78-82ef-847e-1544eae30839",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1826,
							category = "Self",
							uuid = "cbf233f3-b03b-b641-88c5-758e27044985",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 2696,
							category = "Self",
							uuid = "984228fb-0e97-8d6e-ab49-8527be323439",
							version = 3,
						},
					},
				},
				mechanicTime = 1532.8,
				name = "[P6] 远敏团队减伤",
				timeRange = true,
				timelineIndex = 242,
				timerEndOffset = -1,
				timerStartOffset = -14,
				uuid = "1edfc1aa-4f2b-0630-aa1c-09b455330045",
				version = 2,
			},
		},
	},
	[243] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\ndata.string_dsr = data.string_dsr or {}\ndata.string_dsr.eyePos = nil\ndata.string_dsr.cometCount = nil\ndata.string_dsr.cometsArmed = nil\ndata.string_dsr.drawnExaflares = nil\nself.used = true",
							endIfUsed = true,
							name = "Unlock face and reset phase state",
							uuid = "d7a05762-3877-0729-a14d-1f47cf2b965e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1542.1,
				name = "[P7] 换相清理",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 0.5,
				timerStartOffset = -0.5,
				uuid = "cff3f1fb-57fd-e4ab-b665-36d9aca0b120",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"4ef1b9b2-da1d-da16-84f7-1b67b04a2841",
									true,
								},
							},
							endIfUsed = true,
							name = "Select target",
							setTarget = true,
							targetContentID = 11319,
							targetType = "ContentID",
							uuid = "3c3c3934-1f84-2b7c-8ec0-15a41a24eb13",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetTarget() == nil",
							name = "Only when no current target",
							uuid = "4ef1b9b2-da1d-da16-84f7-1b67b04a2841",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 1542.1,
				name = "[P7] 自动目标：龙王 Thordan",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "44871121-ab99-63b4-8b19-5aab5cc7dc03",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.string_dsr = data.string_dsr or {}\nlocal thordan = TensorCore.getEntityByGroup(\"ContentID\", { contentid = 11319, subgroup = \"Nearest\" })\ndata.string_dsr.godThordanID = thordan and thordan.id or nil\nself.used = true",
							endIfUsed = true,
							name = "Store God Thordan ID",
							uuid = "a7dddf6d-6911-ec72-9e14-d4075e0c942a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1542.1,
				name = "[P7] 龙王实体状态",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 0.8,
				uuid = "184020b7-426d-d436-ac73-f6e702c29c9e",
				version = 2,
			},
		},
	},
	[244] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local stateKey = \"p7ExaflareFrame1\"\nlocal hitTime = 1553\nlocal previewLead = 0.2\nlocal now = tonumber(TensorReactions_CurrentTimer)\nif now == nil then\n  self.used = true\n  return\nend\n\ndata.string_dsr = data.string_dsr or {}\nlocal root = data.string_dsr\nlocal state = root[stateKey]\n\nif state == nil or state.anchor ~= hitTime or now < hitTime - 7.0 then\n  root[stateKey] = nil\n  state = nil\nend\n\nif state == nil and now <= hitTime then\n  local aoes = Argus.getCurrentDirectionalAOEs(true) or {}\n  local matches = {}\n  for index = 1, #aoes do\n    local aoe = aoes[index]\n    local startTime = tonumber(aoe and aoe.startTime)\n    local radius = tonumber(aoe and aoe.aoeLength) or tonumber(aoe and aoe.radius)\n    if aoe and tonumber(aoe.aoeID) == 28060\n        and startTime ~= nil and radius ~= nil\n        and tonumber(aoe.x) ~= nil and tonumber(aoe.y) ~= nil\n        and tonumber(aoe.z) ~= nil and tonumber(aoe.heading) ~= nil then\n      matches[#matches + 1] = {\n        x = tonumber(aoe.x),\n        y = tonumber(aoe.y),\n        z = tonumber(aoe.z),\n        heading = tonumber(aoe.heading),\n        radius = radius,\n        startTime = startTime,\n      }\n    end\n  end\n\n  table.sort(matches, function(left, right)\n    return left.startTime > right.startTime\n  end)\n\n  local selected = {}\n  if #matches >= 3 then\n    local newestStart = matches[1].startTime\n    for index = 1, #matches do\n      local candidate = matches[index]\n      if math.abs(candidate.startTime - newestStart) <= 50 then\n        local duplicate = false\n        for savedIndex = 1, #selected do\n          local saved = selected[savedIndex]\n          local dx = saved.x - candidate.x\n          local dz = saved.z - candidate.z\n          if dx * dx + dz * dz < 0.01 then\n            duplicate = true\n            break\n          end\n        end\n        if not duplicate then\n          selected[#selected + 1] = candidate\n          if #selected == 3 then\n            break\n          end\n        end\n      end\n    end\n  end\n\n  if #selected == 3 then\n    state = {\n      anchor = hitTime,\n      origins = {},\n      points = {},\n      stepInterval = 1.825,\n      fill = GUI:ColorConvertFloat4ToU32(1, 0.10, 0.02, 0.88),\n      outline = GUI:ColorConvertFloat4ToU32(0.45, 0, 0, 1),\n    }\n\n    for sourceIndex = 1, #selected do\n      local source = selected[sourceIndex]\n      local origin = { x = source.x, y = source.y, z = source.z }\n      state.origins[#state.origins + 1] = {\n        x = source.x,\n        y = source.y,\n        z = source.z,\n        radius = source.radius,\n      }\n      for lane = -1, 1 do\n        local heading = source.heading + lane * math.pi / 2\n        for step = 1, 5 do\n          local x, y, z = TensorCore.getPosInDirection(\n            origin, heading, 6.91 * step, true)\n          if x ~= nil and y ~= nil and z ~= nil then\n            state.points[#state.points + 1] = {\n              step = step,\n              x = x,\n              y = y,\n              z = z,\n              radius = source.radius,\n            }\n          end\n        end\n      end\n    end\n    root[stateKey] = state\n  end\nend\n\nif state ~= nil then\n  local currentStep = 0\n  if now >= hitTime then\n    currentStep = math.floor((now - hitTime) / state.stepInterval) + 1\n  end\n\n  if currentStep <= 5 then\n    local drawer = TensorCore.getCachedDrawer(\n      state.fill, state.fill, state.fill, state.outline, 3)\n\n    if currentStep == 0 then\n      for index = 1, #state.origins do\n        local origin = state.origins[index]\n        drawer:addCircle(\n          origin.x, origin.y, origin.z, origin.radius)\n      end\n    end\n\n    local currentJudgment = hitTime\n    if currentStep > 0 then\n      currentJudgment = hitTime + currentStep * state.stepInterval\n    end\n\n    local nextStep\n    if currentStep < 5 and now >= currentJudgment - previewLead then\n      nextStep = currentStep + 1\n    end\n\n    for index = 1, #state.points do\n      local point = state.points[index]\n      if point.step == currentStep or point.step == nextStep then\n        drawer:addCircle(\n          point.x, point.y, point.z, point.radius)\n      end\n    end\n  end\nend\n\nself.used = true",
							endIfUsed = true,
							name = "三枚地火当前步与判定前下一步",
							uuid = "0747a21b-20f2-fbc0-87a5-98a22b55bc13",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1553,
				name = "[P7] 地火当前步与判定前下一步 1",
				timeRange = true,
				timelineIndex = 244,
				timerEndOffset = 9.5,
				timerStartOffset = -7.2,
				uuid = "eac16541-237b-4e59-8332-24b53cc6e73a",
				version = 2,
			},
		},
	},
	[245] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 11319, subgroup = \"Highest HP\" })\nif not boss then\n  return\nend\n\nlocal buff = TensorCore.getBuff(boss, 2056)\nlocal stacks = tonumber(buff and buff.stacks)\nif stacks ~= 298 and stacks ~= 299 then\n  return\nend\n\nlocal moogleDrawer = TensorCore.getMoogleDrawer()\nlocal outlineThickness =\n  (tonumber(moogleDrawer and moogleDrawer.outlineThickness) or 1.5) + 0.5\n\nlocal fireColor =\n  GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)\nlocal iceColor =\n  GUI:ColorConvertFloat4ToU32(0, 0.38, 1, 1)\nlocal fireOutline =\n  GUI:ColorConvertFloat4ToU32(0.48, 0, 0, 1)\nlocal iceOutline =\n  GUI:ColorConvertFloat4ToU32(0, 0.12, 0.48, 1)\n\nif stacks == 298 then\n  local drawer = TensorCore.getCachedFlatDrawer(\n    fireColor, fireColor, fireColor, fireOutline, outlineThickness)\n  drawer:addTimedCircleOnEnt(6300, boss.id, 8)\nelse\n  local drawer = TensorCore.getCachedFlatDrawer(\n    iceColor, iceColor, iceColor, iceOutline, outlineThickness)\n  drawer:addTimedDonutOnEnt(6300, boss.id, 8, 50)\nend\n\nself.used = true",
							endIfUsed = true,
							name = "按龙王剑色绘制钢铁或月环",
							uuid = "aadc5369-0ec9-20ee-9f63-ee6fd8e65dce",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1553.3,
				name = "[P7] 阿斯卡隆钢铁月环 1",
				timeRange = true,
				timelineIndex = 245,
				timerEndOffset = -5.4,
				timerOffset = -6,
				timerStartOffset = -6,
				uuid = "511203e3-1c39-fcb2-afa6-aab5755406e6",
				version = 2,
			},
		},
	},
	[246] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D1\"\nlocal firstTank = \"MT\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D1接刀 / 双T分开",
							uuid = "2054c2ad-f080-d783-8ae0-3d4e890be9ff",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1561.2,
				name = "[P7] 三剑一体平A动态指路 1-D1",
				timeRange = true,
				timelineIndex = 246,
				timerStartOffset = -3.5,
				uuid = "3201ebcd-3084-2e00-8c12-c91c50db1bda",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "10da8225-da09-3487-98f1-a2d9d65f0ee6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1561.2,
				name = "[P7] 三剑一体平A范围 双T 1-D1",
				timelineIndex = 246,
				timerOffset = -3.5,
				uuid = "f73097fc-3d52-631b-8971-ccf82d18b8cc",
				version = 2,
			},
		},
	},
	[247] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D2\"\nlocal firstTank = \"MT\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D2接刀 / 双T分开",
							uuid = "73c19aaa-abf9-6203-9afb-7d4e33c5cc36",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1565.3,
				name = "[P7] 三剑一体平A动态指路 1-D2",
				timeRange = true,
				timelineIndex = 247,
				timerStartOffset = -3.5,
				uuid = "d0f7e534-e74a-3e79-b905-f34f6f77fc8c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "394bdcb1-e5dd-3efa-bc15-4eb4ce690adc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1565.3,
				name = "[P7] 三剑一体平A范围 双T 1-D2",
				timelineIndex = 247,
				timerOffset = -3.5,
				uuid = "4506702e-cae3-033f-8ae7-062a138a6654",
				version = 2,
			},
		},
	},
	[248] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"6fb44e15-6a6f-bece-84bb-3c5637f68f32",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "bb891e66-1083-154b-a287-bf06aefe4a85",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"e8c7ce39-85d9-659a-ac76-2aabb0d87ee6",
									true,
								},
								
								{
									"6f156465-33cb-4bf0-8ab6-25bf3005707f",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "8108429c-3c6d-3a09-a186-1fcad31c811b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"e6359cf9-e892-218f-a780-a1a27f1164c1",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "9eaad205-391f-1c2f-968a-47c3f80e3134",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "6f156465-33cb-4bf0-8ab6-25bf3005707f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "6fb44e15-6a6f-bece-84bb-3c5637f68f32",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "e8c7ce39-85d9-659a-ac76-2aabb0d87ee6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "e6359cf9-e892-218f-a780-a1a27f1164c1",
							version = 3,
						},
					},
				},
				mechanicTime = 1573.9,
				name = "[P7] 近战个人减伤",
				timelineIndex = 248,
				timerOffset = -2.5,
				uuid = "973bc977-38a1-fe75-889d-dec648978f5c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "self.used = true\n\nlocal round = 1\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\n\ndata.string_dsr = type(data.string_dsr) == \"table\"\n    and data.string_dsr or {}\nlocal root = data.string_dsr\nlocal state = root.p7AkhMornTowerGuide\nif type(state) ~= \"table\" or state.round ~= round then\n  state = {\n    round = round,\n    towers = {},\n    sawFirstAOE = false,\n    firstResolved = false,\n  }\n  root.p7AkhMornTowerGuide = state\nend\n\nlocal firstAOEActive = false\nif type(Argus) == \"table\"\n    and type(Argus.getCurrentAOEs) == \"function\" then\n  for _, aoe in pairs(Argus.getCurrentAOEs() or {}) do\n    local id = tonumber(aoe and aoe.aoeID)\n    if id == 29452 or id == 29453 or id == 29454 then\n      local x = tonumber(aoe.x)\n      local y = tonumber(aoe.y)\n      local z = tonumber(aoe.z)\n      if x and y and z then\n        state.towers[id] = { x = x, y = y, z = z }\n        firstAOEActive = true\n        state.sawFirstAOE = true\n      end\n    end\n  end\nend\nif state.sawFirstAOE and not firstAOEActive then\n  state.firstResolved = true\nend\n\nlocal bossID = tonumber(root.godThordanID)\nlocal boss = bossID and TensorCore.mGetEntity(bossID) or nil\nif not boss then\n  boss = TensorCore.getEntityByGroup(\n    \"ContentID\", { contentid = 11319, subgroup = \"Nearest\" })\n  if boss then\n    root.godThordanID = tonumber(boss.id)\n  end\nend\n\n-- When replay starts a few frames before Argus exposes the cast AOEs,\n-- derive the same three radius-8 centers from the live boss heading.\nlocal bossPos = boss and boss.pos or nil\nlocal bossHeading = tonumber(bossPos and bossPos.h)\nif bossPos and bossHeading then\n  local offsets = {\n    [29453] = -math.pi / 3, -- boss left-front\n    [29452] = math.pi / 3,  -- boss right-front\n    [29454] = math.pi,      -- boss rear\n  }\n  for id, offset in pairs(offsets) do\n    if state.towers[id] == nil then\n      local position = TensorCore.getPosInDirection(\n        bossPos,\n        TensorCore.convertHeading(bossHeading + offset),\n        8)\n      if type(position) == \"table\"\n          and tonumber(position.x)\n          and tonumber(position.y)\n          and tonumber(position.z) then\n        state.towers[id] = {\n          x = tonumber(position.x),\n          y = tonumber(position.y),\n          z = tonumber(position.z),\n        }\n      end\n    end\n  end\nend\n\nlocal towerOrder = { 29453, 29452, 29454 }\nfor _, id in ipairs(towerOrder) do\n  if type(state.towers[id]) ~= \"table\" then\n    return\n  end\nend\n\nif not state.drawer then\n  local fill = GUI:ColorConvertFloat4ToU32(0.05, 0.9, 0.2, 0.26)\n  local outline = GUI:ColorConvertFloat4ToU32(0.2, 1, 0.35, 0.95)\n  state.drawer = TensorCore.getCachedFlatDrawer(\n    nil, nil, fill, outline, 2, 0)\nend\nfor _, id in ipairs(towerOrder) do\n  local tower = state.towers[id]\n  state.drawer:addCircle(tower.x, tower.y, tower.z, 4, false)\nend\n\nif not boss or type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\nlocal selfRole = roleByID[playerID]\nif selfRole == nil then\n  return\nend\n\nlocal buff = TensorCore.getBuff(boss, 2056)\nlocal stacks = tonumber(buff and buff.stacks)\nif stacks == 298 or stacks == 299 then\n  state.sword = stacks\nend\nif state.sword == nil then\n  return\nend\n\nlocal towerID\nif round == 1 then\n  if selfRole == \"H1\" or selfRole == \"D1\" or selfRole == \"D3\" then\n    towerID = 29453\n  elseif selfRole == \"H2\" or selfRole == \"D2\" or selfRole == \"D4\" then\n    towerID = 29452\n  else\n    towerID = 29454\n  end\nelse\n  if selfRole == \"MT\" then\n    towerID = 29452\n  elseif selfRole == \"ST\" then\n    towerID = 29454\n  else\n    towerID = 29453\n  end\nend\n\nlocal tower = state.towers[towerID]\nlocal centerX = tonumber(bossPos and bossPos.x)\nlocal centerZ = tonumber(bossPos and bossPos.z)\nif not tower or not centerX or not centerZ then\n  return\nend\n\nlocal dx = tower.x - centerX\nlocal dz = tower.z - centerZ\nlocal length = math.sqrt(dx * dx + dz * dz)\nif length < 0.001 then\n  return\nend\n\n-- Tower centers sit on radius 8, exactly at the steel/donut boundary.\n-- Before the first hit, steel moves 1.5 out and donut 1.5 in.\n-- After the sword resolves, all assignments settle 1.5 inward for healing\n-- while remaining comfortably inside the radius-4 tower.\nlocal shift = -1.5\nif not state.firstResolved and state.sword == 298 then\n  shift = 1.5\nend\nlocal targetX = tower.x + dx / length * shift\nlocal targetZ = tower.z + dz / length * shift\nguide.FrameDirect(targetX, targetZ, 0.5)\n",
							endIfUsed = true,
							name = "绿色塔圈与 MuAi 动态指路",
							uuid = "6a2a669b-fb09-0a66-8073-bdecd7fd91b8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1573.9,
				name = "[P7] 死亡轮回塔 1（332）范围与动态指路",
				timeRange = true,
				timelineIndex = 248,
				timerEndOffset = 5.7,
				timerStartOffset = -6.7,
				uuid = "aed52555-a6bc-f77e-b6ab-7661fcf09d7f",
				version = 2,
			},
		},
	},
	[249] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 11319, subgroup = \"Highest HP\" })\nif not boss then\n  return\nend\n\nlocal buff = TensorCore.getBuff(boss, 2056)\nlocal stacks = tonumber(buff and buff.stacks)\nif stacks ~= 298 and stacks ~= 299 then\n  return\nend\n\nlocal moogleDrawer = TensorCore.getMoogleDrawer()\nlocal outlineThickness =\n  (tonumber(moogleDrawer and moogleDrawer.outlineThickness) or 1.5) + 0.5\n\nlocal fireColor =\n  GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)\nlocal iceColor =\n  GUI:ColorConvertFloat4ToU32(0, 0.38, 1, 1)\nlocal fireOutline =\n  GUI:ColorConvertFloat4ToU32(0.48, 0, 0, 1)\nlocal iceOutline =\n  GUI:ColorConvertFloat4ToU32(0, 0.12, 0.48, 1)\n\nif stacks == 298 then\n  local drawer = TensorCore.getCachedFlatDrawer(\n    fireColor, fireColor, fireColor, fireOutline, outlineThickness)\n  drawer:addTimedCircleOnEnt(6300, boss.id, 8)\nelse\n  local drawer = TensorCore.getCachedFlatDrawer(\n    iceColor, iceColor, iceColor, iceOutline, outlineThickness)\n  drawer:addTimedDonutOnEnt(6300, boss.id, 8, 50)\nend\n\nself.used = true",
							endIfUsed = true,
							name = "按龙王剑色绘制钢铁或月环",
							uuid = "617197ea-f995-d6a4-a4f0-5ebf131132b0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1574,
				name = "[P7] 阿斯卡隆钢铁月环 2",
				timeRange = true,
				timelineIndex = 249,
				timerEndOffset = -5.4,
				timerOffset = -6,
				timerStartOffset = -6,
				uuid = "a1901746-58a3-4ac2-81e3-ea05e8e48b17",
				version = 2,
			},
		},
	},
	[250] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D3\"\nlocal firstTank = \"ST\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D3接刀 / 双T分开",
							uuid = "e9320e53-3be2-09eb-b834-acf9d0f489cb",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1585.8,
				name = "[P7] 三剑一体平A动态指路 2-D3",
				timeRange = true,
				timelineIndex = 250,
				timerStartOffset = -3.5,
				uuid = "6495f724-5812-0b7d-8a0a-b6e0db38f289",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "c70ddf3a-afa4-c829-8ffe-c62cda83c903",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1585.8,
				name = "[P7] 三剑一体平A范围 双T 2-D3",
				timelineIndex = 250,
				timerOffset = -3.5,
				uuid = "3fe6b57d-4593-40ba-ba7c-4ef49cc089e8",
				version = 2,
			},
		},
	},
	[251] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D4\"\nlocal firstTank = \"ST\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D4接刀 / 双T分开",
							uuid = "b04ba637-98a3-9551-94b5-eab32d6cba3c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1589.9,
				name = "[P7] 三剑一体平A动态指路 2-D4",
				timeRange = true,
				timelineIndex = 251,
				timerStartOffset = -3.5,
				uuid = "d12ae173-ab1b-20ed-acb4-d660b403fb0e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "e5d27086-ea42-6903-82e6-a9c0e6f11f5b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1589.9,
				name = "[P7] 三剑一体平A范围 双T 2-D4",
				timelineIndex = 251,
				timerOffset = -3.5,
				uuid = "c14157bb-80ba-8fc6-a749-66d7df67609b",
				version = 2,
			},
		},
	},
	[252] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local aoes = Argus.getCurrentAOEs()\nif type(aoes) ~= \"table\" then\n  return\nend\n\nlocal nextAOE = nil\nlocal nextStage = nil\nlocal swordMode = nil\n\nfor i = 1, #aoes do\n  local aoe = aoes[i]\n  local aoeID = tonumber(aoe and aoe.aoeID)\n\n  local stage = nil\n  if aoeID == 28058 then\n    stage = 1\n  elseif aoeID == 28114 then\n    stage = 2\n  elseif aoeID == 28115 then\n    stage = 3\n  elseif aoeID == 28049 then\n    swordMode = 298\n  elseif aoeID == 28050 then\n    swordMode = 299\n  end\n\n  if stage and (not nextStage or stage < nextStage) then\n    nextAOE = aoe\n    nextStage = stage\n  end\nend\n\nif not nextAOE or not nextStage then\n  return\nend\n\nlocal aoeX = tonumber(nextAOE.x)\nlocal aoeZ = tonumber(nextAOE.z)\nif not aoeX or not aoeZ then\n  return\nend\n\nif not swordMode and nextStage == 1 then\n  local boss = TensorCore.getEntityByGroup(\n    \"ContentID\", { contentid = 11319, subgroup = \"Nearest\" })\n  local buff = boss and TensorCore.getBuff(boss, 2056)\n  local stacks = tonumber(buff and buff.stacks)\n  if stacks == 298 or stacks == 299 then\n    swordMode = stacks\n  else\n    return\n  end\nend\n\nlocal targetRadius = 11\nif swordMode == 298 then\n  targetRadius = 9.5\nelseif swordMode == 299 then\n  targetRadius = 6.5\nend\n\nlocal dx = 100 - aoeX\nlocal dz = 100 - aoeZ\nlocal length = math.sqrt(dx * dx + dz * dz)\nif length < 0.001 then\n  return\nend\n\nlocal targetX = 100 + dx / length * targetRadius\nlocal targetZ = 100 + dz / length * targetRadius\n\nif not MuAiGuide or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "按当前核爆顺序与钢铁月环指路",
							uuid = "6977ccf8-fd36-d68e-8e65-a2187561669e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1600.8,
				name = "[P7] 第一次十亿核爆动态指路",
				timeRange = true,
				timelineIndex = 252,
				timerEndOffset = 8.1,
				timerStartOffset = -9,
				uuid = "afea15cc-0378-2352-8efd-7bfbdd41531c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local settings = type(MoogleTelegraphs) == \"table\" and MoogleTelegraphs.Settings or nil\nlocal blacklist = type(settings) == \"table\" and settings.aoeIDUserBlacklist or nil\nif type(blacklist) ~= \"table\" then\n  return\nend\n\n-- 28057 is only the boss read; these three IDs own the actual 50m AOEs.\nblacklist[28058] = \"十亿核爆剑\"\nblacklist[28114] = \"十亿核爆剑\"\nblacklist[28115] = \"十亿核爆剑\"\nself.used = true",
							endIfUsed = true,
							name = "屏蔽十亿核爆剑自动AOE",
							uuid = "af5c01dd-93f3-5451-99f0-d0e8948a7988",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1600.8,
				name = "[P7] 第一次十亿核爆屏蔽自动AOE",
				timelineIndex = 252,
				timerOffset = -9.2,
				uuid = "325a5bfe-0361-6ea2-9879-583ad94d33f2",
				version = 2,
			},
		},
	},
	[253] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 11319, subgroup = \"Highest HP\" })\nif not boss then\n  return\nend\n\nlocal buff = TensorCore.getBuff(boss, 2056)\nlocal stacks = tonumber(buff and buff.stacks)\nif stacks ~= 298 and stacks ~= 299 then\n  return\nend\n\nlocal moogleDrawer = TensorCore.getMoogleDrawer()\nlocal outlineThickness =\n  (tonumber(moogleDrawer and moogleDrawer.outlineThickness) or 1.5) + 0.5\n\nlocal fireColor =\n  GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)\nlocal iceColor =\n  GUI:ColorConvertFloat4ToU32(0, 0.38, 1, 1)\nlocal fireOutline =\n  GUI:ColorConvertFloat4ToU32(0.48, 0, 0, 1)\nlocal iceOutline =\n  GUI:ColorConvertFloat4ToU32(0, 0.12, 0.48, 1)\n\nif stacks == 298 then\n  local drawer = TensorCore.getCachedFlatDrawer(\n    fireColor, fireColor, fireColor, fireOutline, outlineThickness)\n  drawer:addTimedCircleOnEnt(6300, boss.id, 8)\nelse\n  local drawer = TensorCore.getCachedFlatDrawer(\n    iceColor, iceColor, iceColor, iceOutline, outlineThickness)\n  drawer:addTimedDonutOnEnt(6300, boss.id, 8, 50)\nend\n\nself.used = true",
							endIfUsed = true,
							name = "按龙王剑色绘制钢铁或月环",
							uuid = "e7194d04-dd6e-fd11-be90-6e03f24f44e6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1600.9,
				name = "[P7] 阿斯卡隆钢铁月环 3",
				timeRange = true,
				timelineIndex = 253,
				timerEndOffset = -5.4,
				timerOffset = -6,
				timerStartOffset = -6,
				uuid = "54933149-66e7-28ee-bf52-5fd304d69ea4",
				version = 2,
			},
		},
	},
	[254] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"ff9f923d-368c-5e42-9009-cc2b1ffc07c7",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "a7e1e4a3-ff82-41a6-becb-db000ef5409a",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"5cf19939-b695-7208-a7e1-8750a8e5f179",
									true,
								},
								
								{
									"efe73dee-d4da-e9c9-8905-17959f331606",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "7b755316-9751-ad9e-ac27-efe4319b4858",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"383c3a8e-e1f6-d56d-8962-5ce502fc02b3",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "b4c00610-011f-72e7-88f2-4fa726ca15aa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "efe73dee-d4da-e9c9-8905-17959f331606",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "ff9f923d-368c-5e42-9009-cc2b1ffc07c7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "5cf19939-b695-7208-a7e1-8750a8e5f179",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "383c3a8e-e1f6-d56d-8962-5ce502fc02b3",
							version = 3,
						},
					},
				},
				mechanicTime = 1608.7,
				name = "[P7] 近战个人减伤",
				timelineIndex = 254,
				timerOffset = -10,
				uuid = "bc40a2ce-7526-50f3-8a25-3abb0909e660",
				version = 2,
			},
		},
	},
	[255] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"H1\"\nlocal firstTank = \"MT\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：H1接刀 / 双T分开",
							uuid = "08ed9552-09c7-6b11-b26a-58bb8ce23c9e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1619,
				name = "[P7] 三剑一体平A动态指路 3-H1",
				timeRange = true,
				timelineIndex = 255,
				timerStartOffset = -3.5,
				uuid = "95cd004b-df46-3667-bad7-c2b31f047967",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "25b4a22f-7303-f6b2-9f91-21772a42cfdc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1619,
				name = "[P7] 三剑一体平A范围 双T 3-H1",
				timelineIndex = 255,
				timerOffset = -3.5,
				uuid = "13edb48a-ca25-0faa-8ce1-008a47eef66b",
				version = 2,
			},
		},
	},
	[256] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"H2\"\nlocal firstTank = \"MT\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：H2接刀 / 双T分开",
							uuid = "0c7de964-2746-b5b8-b6ba-13d945aa2df5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1623.1,
				name = "[P7] 三剑一体平A动态指路 3-H2",
				timeRange = true,
				timelineIndex = 256,
				timerStartOffset = -3.5,
				uuid = "eb6f6ff6-93b3-89e5-8e41-7c0594ecf245",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "b47a46bc-f35c-063d-86d5-174340021374",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1623.1,
				name = "[P7] 三剑一体平A范围 双T 3-H2",
				timelineIndex = 256,
				timerOffset = -3.5,
				uuid = "42a27af8-b50b-9d8a-9f10-456c4061de35",
				version = 2,
			},
		},
	},
	[257] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local stateKey = \"p7ExaflareFrame2\"\nlocal hitTime = 1632\nlocal previewLead = 0.2\nlocal now = tonumber(TensorReactions_CurrentTimer)\nif now == nil then\n  self.used = true\n  return\nend\n\ndata.string_dsr = data.string_dsr or {}\nlocal root = data.string_dsr\nlocal state = root[stateKey]\n\nif state == nil or state.anchor ~= hitTime or now < hitTime - 7.0 then\n  root[stateKey] = nil\n  state = nil\nend\n\nif state == nil and now <= hitTime then\n  local aoes = Argus.getCurrentDirectionalAOEs(true) or {}\n  local matches = {}\n  for index = 1, #aoes do\n    local aoe = aoes[index]\n    local startTime = tonumber(aoe and aoe.startTime)\n    local radius = tonumber(aoe and aoe.aoeLength) or tonumber(aoe and aoe.radius)\n    if aoe and tonumber(aoe.aoeID) == 28060\n        and startTime ~= nil and radius ~= nil\n        and tonumber(aoe.x) ~= nil and tonumber(aoe.y) ~= nil\n        and tonumber(aoe.z) ~= nil and tonumber(aoe.heading) ~= nil then\n      matches[#matches + 1] = {\n        x = tonumber(aoe.x),\n        y = tonumber(aoe.y),\n        z = tonumber(aoe.z),\n        heading = tonumber(aoe.heading),\n        radius = radius,\n        startTime = startTime,\n      }\n    end\n  end\n\n  table.sort(matches, function(left, right)\n    return left.startTime > right.startTime\n  end)\n\n  local selected = {}\n  if #matches >= 3 then\n    local newestStart = matches[1].startTime\n    for index = 1, #matches do\n      local candidate = matches[index]\n      if math.abs(candidate.startTime - newestStart) <= 50 then\n        local duplicate = false\n        for savedIndex = 1, #selected do\n          local saved = selected[savedIndex]\n          local dx = saved.x - candidate.x\n          local dz = saved.z - candidate.z\n          if dx * dx + dz * dz < 0.01 then\n            duplicate = true\n            break\n          end\n        end\n        if not duplicate then\n          selected[#selected + 1] = candidate\n          if #selected == 3 then\n            break\n          end\n        end\n      end\n    end\n  end\n\n  if #selected == 3 then\n    state = {\n      anchor = hitTime,\n      origins = {},\n      points = {},\n      stepInterval = 1.825,\n      fill = GUI:ColorConvertFloat4ToU32(1, 0.10, 0.02, 0.88),\n      outline = GUI:ColorConvertFloat4ToU32(0.45, 0, 0, 1),\n    }\n\n    for sourceIndex = 1, #selected do\n      local source = selected[sourceIndex]\n      local origin = { x = source.x, y = source.y, z = source.z }\n      state.origins[#state.origins + 1] = {\n        x = source.x,\n        y = source.y,\n        z = source.z,\n        radius = source.radius,\n      }\n      for lane = -1, 1 do\n        local heading = source.heading + lane * math.pi / 2\n        for step = 1, 5 do\n          local x, y, z = TensorCore.getPosInDirection(\n            origin, heading, 6.91 * step, true)\n          if x ~= nil and y ~= nil and z ~= nil then\n            state.points[#state.points + 1] = {\n              step = step,\n              x = x,\n              y = y,\n              z = z,\n              radius = source.radius,\n            }\n          end\n        end\n      end\n    end\n    root[stateKey] = state\n  end\nend\n\nif state ~= nil then\n  local currentStep = 0\n  if now >= hitTime then\n    currentStep = math.floor((now - hitTime) / state.stepInterval) + 1\n  end\n\n  if currentStep <= 5 then\n    local drawer = TensorCore.getCachedDrawer(\n      state.fill, state.fill, state.fill, state.outline, 3)\n\n    if currentStep == 0 then\n      for index = 1, #state.origins do\n        local origin = state.origins[index]\n        drawer:addCircle(\n          origin.x, origin.y, origin.z, origin.radius)\n      end\n    end\n\n    local currentJudgment = hitTime\n    if currentStep > 0 then\n      currentJudgment = hitTime + currentStep * state.stepInterval\n    end\n\n    local nextStep\n    if currentStep < 5 and now >= currentJudgment - previewLead then\n      nextStep = currentStep + 1\n    end\n\n    for index = 1, #state.points do\n      local point = state.points[index]\n      if point.step == currentStep or point.step == nextStep then\n        drawer:addCircle(\n          point.x, point.y, point.z, point.radius)\n      end\n    end\n  end\nend\n\nself.used = true",
							endIfUsed = true,
							name = "三枚地火当前步与判定前下一步",
							uuid = "b384f2ac-42bf-f496-95c5-58c783f8efff",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1632,
				name = "[P7] 地火当前步与判定前下一步 2",
				timeRange = true,
				timelineIndex = 257,
				timerEndOffset = 9.5,
				timerStartOffset = -7.2,
				uuid = "8cddb92f-422b-fc20-8892-355627b9eb19",
				version = 2,
			},
		},
	},
	[258] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 11319, subgroup = \"Highest HP\" })\nif not boss then\n  return\nend\n\nlocal buff = TensorCore.getBuff(boss, 2056)\nlocal stacks = tonumber(buff and buff.stacks)\nif stacks ~= 298 and stacks ~= 299 then\n  return\nend\n\nlocal moogleDrawer = TensorCore.getMoogleDrawer()\nlocal outlineThickness =\n  (tonumber(moogleDrawer and moogleDrawer.outlineThickness) or 1.5) + 0.5\n\nlocal fireColor =\n  GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)\nlocal iceColor =\n  GUI:ColorConvertFloat4ToU32(0, 0.38, 1, 1)\nlocal fireOutline =\n  GUI:ColorConvertFloat4ToU32(0.48, 0, 0, 1)\nlocal iceOutline =\n  GUI:ColorConvertFloat4ToU32(0, 0.12, 0.48, 1)\n\nif stacks == 298 then\n  local drawer = TensorCore.getCachedFlatDrawer(\n    fireColor, fireColor, fireColor, fireOutline, outlineThickness)\n  drawer:addTimedCircleOnEnt(6300, boss.id, 8)\nelse\n  local drawer = TensorCore.getCachedFlatDrawer(\n    iceColor, iceColor, iceColor, iceOutline, outlineThickness)\n  drawer:addTimedDonutOnEnt(6300, boss.id, 8, 50)\nend\n\nself.used = true",
							endIfUsed = true,
							name = "按龙王剑色绘制钢铁或月环",
							uuid = "7bccc779-fec7-2a3f-a8d2-8ff0476e0328",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1632.3,
				name = "[P7] 阿斯卡隆钢铁月环 4",
				timeRange = true,
				timelineIndex = 258,
				timerEndOffset = -5.4,
				timerOffset = -6,
				timerStartOffset = -6,
				uuid = "ad555673-20cf-314a-ad74-1d9801161e2a",
				version = 2,
			},
		},
	},
	[259] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D1\"\nlocal firstTank = \"ST\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D1接刀 / 双T分开",
							uuid = "e8f5ea3e-56a8-aeaa-900e-7d8c19347e27",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1640.2,
				name = "[P7] 三剑一体平A动态指路 4-D1",
				timeRange = true,
				timelineIndex = 259,
				timerStartOffset = -3.5,
				uuid = "201046d2-517f-1f1a-af20-13d050668f39",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "f942ce67-395d-1aba-ab44-d1f95f29c8fa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1640.2,
				name = "[P7] 三剑一体平A范围 双T 4-D1",
				timelineIndex = 259,
				timerOffset = -3.5,
				uuid = "a620b078-c8ba-9b57-bef9-bf25ebdf093c",
				version = 2,
			},
		},
	},
	[260] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"3dbdd9b3-12d3-cb82-8a9f-a7aafe2b4fc1",
									true,
								},
								
								{
									"c3936850-5b3d-0f4f-9855-8ed601e6c31a",
									true,
								},
								
								{
									"06f96707-4ff6-1077-8b82-cc319d9b92ed",
									true,
								},
								
								{
									"3557a422-5c15-4b52-9db2-e3b727f2de80",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "d234967f-405d-80b1-89ae-f83b4f4b2d49",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "3dbdd9b3-12d3-cb82-8a9f-a7aafe2b4fc1",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1934,
							category = "Self",
							uuid = "c3936850-5b3d-0f4f-9855-8ed601e6c31a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1951,
							category = "Self",
							uuid = "06f96707-4ff6-1077-8b82-cc319d9b92ed",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1826,
							category = "Self",
							uuid = "3557a422-5c15-4b52-9db2-e3b727f2de80",
							version = 3,
						},
					},
				},
				mechanicTime = 1644.3,
				name = "[P7] 远敏团队减伤",
				timelineIndex = 260,
				timerOffset = 1,
				uuid = "627d6d4d-6bce-7d11-8fce-e9d05971d5da",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D2\"\nlocal firstTank = \"ST\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D2接刀 / 双T分开",
							uuid = "30df6b0a-a0a2-fbf9-9dc5-6dc654e0459d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1644.3,
				name = "[P7] 三剑一体平A动态指路 4-D2",
				timeRange = true,
				timelineIndex = 260,
				timerStartOffset = -3.5,
				uuid = "7a9330d7-ece4-83ef-8511-e566cdc82343",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "72c7dd66-c5b2-3ea2-b55c-84e28412ebdc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1644.3,
				name = "[P7] 三剑一体平A范围 双T 4-D2",
				timelineIndex = 260,
				timerOffset = -3.5,
				uuid = "27feb6e4-b715-2add-8604-fc9da92b33ab",
				version = 2,
			},
		},
	},
	[261] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"1ab47082-7e3d-2858-9e28-6393daf88b46",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "e9adfb51-55a5-00aa-b1d2-830f0cddb2ca",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"4cecefd3-b892-80c0-a56d-d8f3f6768a6f",
									true,
								},
								
								{
									"b02ace81-2089-8f06-9c10-506decfa6005",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "661555cf-bcc0-5e2b-8f8b-3bbc3bb983dd",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"3716167b-8fda-d4c0-962a-1e29ef26a5e7",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "579c64bf-fc07-3672-96c9-14e6e950744b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "b02ace81-2089-8f06-9c10-506decfa6005",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "1ab47082-7e3d-2858-9e28-6393daf88b46",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "4cecefd3-b892-80c0-a56d-d8f3f6768a6f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "3716167b-8fda-d4c0-962a-1e29ef26a5e7",
							version = 3,
						},
					},
				},
				mechanicTime = 1652.9,
				name = "[P7] 近战个人减伤",
				timelineIndex = 261,
				timerOffset = -3,
				uuid = "621fe1d0-80c9-f4e9-b2e4-21d1d3932535",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							conditions = 
							{
								
								{
									"c2fd61e3-6456-baf0-979e-f47100e9825a",
									true,
								},
								
								{
									"6e7ec83f-257a-8b64-9581-3bebedc17e85",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							name = "牵制",
							targetType = "Current Target",
							uuid = "9b9574b7-ffc7-3fe9-89b0-7f66d2a182b1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1195,
							name = "Feint check",
							uuid = "6e7ec83f-257a-8b64-9581-3bebedc17e85",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
								22,
								30,
								34,
								39,
								41,
							},
							name = "牵制职业",
							uuid = "c2fd61e3-6456-baf0-979e-f47100e9825a",
							version = 3,
						},
					},
				},
				mechanicTime = 1652.9,
				name = "[P7] 牵制",
				timelineIndex = 261,
				timerOffset = -2,
				uuid = "4e5b7891-4b47-4e02-8262-4ca3cc1054f6",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 2887,
							conditions = 
							{
								
								{
									"2943fb66-e104-be57-aa82-3bb1291b6e72",
									true,
								},
								
								{
									"b618f983-3836-b7e4-834a-0602b5049f23",
									true,
								},
							},
							endIfUsed = true,
							name = "武装解除",
							targetType = "Current Target",
							uuid = "cfd430ee-47d8-acae-a84e-1d64614f322e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 860,
							name = "Dismantle check",
							uuid = "b618f983-3836-b7e4-834a-0602b5049f23",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								31,
							},
							name = "武装解除职业",
							uuid = "2943fb66-e104-be57-aa82-3bb1291b6e72",
							version = 3,
						},
					},
				},
				mechanicTime = 1652.9,
				name = "[P7] 武装解除",
				randomTimeout = 8,
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 261,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "bd110b5b-c17b-481e-97b5-ae9d9056a4d6",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "self.used = true\n\nlocal round = 2\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\n\ndata.string_dsr = type(data.string_dsr) == \"table\"\n    and data.string_dsr or {}\nlocal root = data.string_dsr\nlocal state = root.p7AkhMornTowerGuide\nif type(state) ~= \"table\" or state.round ~= round then\n  state = {\n    round = round,\n    towers = {},\n    sawFirstAOE = false,\n    firstResolved = false,\n  }\n  root.p7AkhMornTowerGuide = state\nend\n\nlocal firstAOEActive = false\nif type(Argus) == \"table\"\n    and type(Argus.getCurrentAOEs) == \"function\" then\n  for _, aoe in pairs(Argus.getCurrentAOEs() or {}) do\n    local id = tonumber(aoe and aoe.aoeID)\n    if id == 29452 or id == 29453 or id == 29454 then\n      local x = tonumber(aoe.x)\n      local y = tonumber(aoe.y)\n      local z = tonumber(aoe.z)\n      if x and y and z then\n        state.towers[id] = { x = x, y = y, z = z }\n        firstAOEActive = true\n        state.sawFirstAOE = true\n      end\n    end\n  end\nend\nif state.sawFirstAOE and not firstAOEActive then\n  state.firstResolved = true\nend\n\nlocal bossID = tonumber(root.godThordanID)\nlocal boss = bossID and TensorCore.mGetEntity(bossID) or nil\nif not boss then\n  boss = TensorCore.getEntityByGroup(\n    \"ContentID\", { contentid = 11319, subgroup = \"Nearest\" })\n  if boss then\n    root.godThordanID = tonumber(boss.id)\n  end\nend\n\n-- When replay starts a few frames before Argus exposes the cast AOEs,\n-- derive the same three radius-8 centers from the live boss heading.\nlocal bossPos = boss and boss.pos or nil\nlocal bossHeading = tonumber(bossPos and bossPos.h)\nif bossPos and bossHeading then\n  local offsets = {\n    [29453] = -math.pi / 3, -- boss left-front\n    [29452] = math.pi / 3,  -- boss right-front\n    [29454] = math.pi,      -- boss rear\n  }\n  for id, offset in pairs(offsets) do\n    if state.towers[id] == nil then\n      local position = TensorCore.getPosInDirection(\n        bossPos,\n        TensorCore.convertHeading(bossHeading + offset),\n        8)\n      if type(position) == \"table\"\n          and tonumber(position.x)\n          and tonumber(position.y)\n          and tonumber(position.z) then\n        state.towers[id] = {\n          x = tonumber(position.x),\n          y = tonumber(position.y),\n          z = tonumber(position.z),\n        }\n      end\n    end\n  end\nend\n\nlocal towerOrder = { 29453, 29452, 29454 }\nfor _, id in ipairs(towerOrder) do\n  if type(state.towers[id]) ~= \"table\" then\n    return\n  end\nend\n\nif not state.drawer then\n  local fill = GUI:ColorConvertFloat4ToU32(0.05, 0.9, 0.2, 0.26)\n  local outline = GUI:ColorConvertFloat4ToU32(0.2, 1, 0.35, 0.95)\n  state.drawer = TensorCore.getCachedFlatDrawer(\n    nil, nil, fill, outline, 2, 0)\nend\nfor _, id in ipairs(towerOrder) do\n  local tower = state.towers[id]\n  state.drawer:addCircle(tower.x, tower.y, tower.z, 4, false)\nend\n\nif not boss or type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\nlocal selfRole = roleByID[playerID]\nif selfRole == nil then\n  return\nend\n\nlocal buff = TensorCore.getBuff(boss, 2056)\nlocal stacks = tonumber(buff and buff.stacks)\nif stacks == 298 or stacks == 299 then\n  state.sword = stacks\nend\nif state.sword == nil then\n  return\nend\n\nlocal towerID\nif round == 1 then\n  if selfRole == \"H1\" or selfRole == \"D1\" or selfRole == \"D3\" then\n    towerID = 29453\n  elseif selfRole == \"H2\" or selfRole == \"D2\" or selfRole == \"D4\" then\n    towerID = 29452\n  else\n    towerID = 29454\n  end\nelse\n  if selfRole == \"MT\" then\n    towerID = 29452\n  elseif selfRole == \"ST\" then\n    towerID = 29454\n  else\n    towerID = 29453\n  end\nend\n\nlocal tower = state.towers[towerID]\nlocal centerX = tonumber(bossPos and bossPos.x)\nlocal centerZ = tonumber(bossPos and bossPos.z)\nif not tower or not centerX or not centerZ then\n  return\nend\n\nlocal dx = tower.x - centerX\nlocal dz = tower.z - centerZ\nlocal length = math.sqrt(dx * dx + dz * dz)\nif length < 0.001 then\n  return\nend\n\n-- Tower centers sit on radius 8, exactly at the steel/donut boundary.\n-- Before the first hit, steel moves 1.5 out and donut 1.5 in.\n-- After the sword resolves, all assignments settle 1.5 inward for healing\n-- while remaining comfortably inside the radius-4 tower.\nlocal shift = -1.5\nif not state.firstResolved and state.sword == 298 then\n  shift = 1.5\nend\nlocal targetX = tower.x + dx / length * shift\nlocal targetZ = tower.z + dz / length * shift\nguide.FrameDirect(targetX, targetZ, 0.5)\n",
							endIfUsed = true,
							name = "绿色塔圈与 MuAi 动态指路",
							uuid = "f2ce8bc4-4fe2-357e-98ea-48f43f05103e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1652.9,
				name = "[P7] 死亡轮回塔 2（116）范围与动态指路",
				timeRange = true,
				timelineIndex = 261,
				timerEndOffset = 6.8,
				timerStartOffset = -6.7,
				uuid = "8587d4e0-96f8-fb43-bd4c-f8e85c8179d0",
				version = 2,
			},
		},
	},
	[262] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 11319, subgroup = \"Highest HP\" })\nif not boss then\n  return\nend\n\nlocal buff = TensorCore.getBuff(boss, 2056)\nlocal stacks = tonumber(buff and buff.stacks)\nif stacks ~= 298 and stacks ~= 299 then\n  return\nend\n\nlocal moogleDrawer = TensorCore.getMoogleDrawer()\nlocal outlineThickness =\n  (tonumber(moogleDrawer and moogleDrawer.outlineThickness) or 1.5) + 0.5\n\nlocal fireColor =\n  GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)\nlocal iceColor =\n  GUI:ColorConvertFloat4ToU32(0, 0.38, 1, 1)\nlocal fireOutline =\n  GUI:ColorConvertFloat4ToU32(0.48, 0, 0, 1)\nlocal iceOutline =\n  GUI:ColorConvertFloat4ToU32(0, 0.12, 0.48, 1)\n\nif stacks == 298 then\n  local drawer = TensorCore.getCachedFlatDrawer(\n    fireColor, fireColor, fireColor, fireOutline, outlineThickness)\n  drawer:addTimedCircleOnEnt(6300, boss.id, 8)\nelse\n  local drawer = TensorCore.getCachedFlatDrawer(\n    iceColor, iceColor, iceColor, iceOutline, outlineThickness)\n  drawer:addTimedDonutOnEnt(6300, boss.id, 8, 50)\nend\n\nself.used = true",
							endIfUsed = true,
							name = "按龙王剑色绘制钢铁或月环",
							uuid = "ed6eeb18-034f-a9f5-b696-3f2acb4c38c6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1653,
				name = "[P7] 阿斯卡隆钢铁月环 5",
				timeRange = true,
				timelineIndex = 262,
				timerEndOffset = -5.4,
				timerOffset = -6,
				timerStartOffset = -6,
				uuid = "75fae8f2-9db2-5eb6-bfdb-44316f00ada0",
				version = 2,
			},
		},
	},
	[263] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D3\"\nlocal firstTank = \"MT\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D3接刀 / 双T分开",
							uuid = "633887d5-6c3f-08ea-bf0e-f74e0e7caeb0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1665.9,
				name = "[P7] 三剑一体平A动态指路 5-D3",
				timeRange = true,
				timelineIndex = 263,
				timerStartOffset = -3.5,
				uuid = "37a801c4-ba1c-0682-8a88-b2319d7c716f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "3bdba5df-c165-73b5-91a1-2177fd85ec4f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1665.9,
				name = "[P7] 三剑一体平A范围 双T 5-D3",
				timelineIndex = 263,
				timerOffset = -3.5,
				uuid = "56f4f6a9-bfea-f110-bef6-07132a50e5aa",
				version = 2,
			},
		},
	},
	[264] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D4\"\nlocal firstTank = \"MT\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D4接刀 / 双T分开",
							uuid = "b0531861-631e-e8c0-aeff-7ac855ae0206",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1670,
				name = "[P7] 三剑一体平A动态指路 5-D4",
				timeRange = true,
				timelineIndex = 264,
				timerStartOffset = -3.5,
				uuid = "2af2f49f-9b34-9453-b733-2766b0acb19f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "577ef2f4-f2c1-1f36-9953-5017536b55cc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1670,
				name = "[P7] 三剑一体平A范围 双T 5-D4",
				timelineIndex = 264,
				timerOffset = -3.5,
				uuid = "cff0b89f-fa50-bf9a-b678-f7fe65f7dd73",
				version = 2,
			},
		},
	},
	[265] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local aoes = Argus.getCurrentAOEs()\nif type(aoes) ~= \"table\" then\n  return\nend\n\nlocal nextAOE = nil\nlocal nextStage = nil\nlocal swordMode = nil\n\nfor i = 1, #aoes do\n  local aoe = aoes[i]\n  local aoeID = tonumber(aoe and aoe.aoeID)\n\n  local stage = nil\n  if aoeID == 28058 then\n    stage = 1\n  elseif aoeID == 28114 then\n    stage = 2\n  elseif aoeID == 28115 then\n    stage = 3\n  elseif aoeID == 28049 then\n    swordMode = 298\n  elseif aoeID == 28050 then\n    swordMode = 299\n  end\n\n  if stage and (not nextStage or stage < nextStage) then\n    nextAOE = aoe\n    nextStage = stage\n  end\nend\n\nif not nextAOE or not nextStage then\n  return\nend\n\nlocal aoeX = tonumber(nextAOE.x)\nlocal aoeZ = tonumber(nextAOE.z)\nif not aoeX or not aoeZ then\n  return\nend\n\nif not swordMode and nextStage == 1 then\n  local boss = TensorCore.getEntityByGroup(\n    \"ContentID\", { contentid = 11319, subgroup = \"Nearest\" })\n  local buff = boss and TensorCore.getBuff(boss, 2056)\n  local stacks = tonumber(buff and buff.stacks)\n  if stacks == 298 or stacks == 299 then\n    swordMode = stacks\n  else\n    return\n  end\nend\n\nlocal targetRadius = 11\nif swordMode == 298 then\n  targetRadius = 9.5\nelseif swordMode == 299 then\n  targetRadius = 6.5\nend\n\nlocal dx = 100 - aoeX\nlocal dz = 100 - aoeZ\nlocal length = math.sqrt(dx * dx + dz * dz)\nif length < 0.001 then\n  return\nend\n\nlocal targetX = 100 + dx / length * targetRadius\nlocal targetZ = 100 + dz / length * targetRadius\n\nif not MuAiGuide or type(MuAiGuide.FrameDirect) ~= \"function\" then\n  return\nend\n\nMuAiGuide.FrameDirect(targetX, targetZ, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "按当前核爆顺序与钢铁月环指路",
							uuid = "0b1f3625-57c2-39eb-a60b-bc32b0bf6cba",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1680.9,
				name = "[P7] 第二次十亿核爆动态指路",
				timeRange = true,
				timelineIndex = 265,
				timerEndOffset = 8.1,
				timerStartOffset = -9,
				uuid = "fd61de40-d7ad-ae27-a146-086bd3bda6cc",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local settings = type(MoogleTelegraphs) == \"table\" and MoogleTelegraphs.Settings or nil\nlocal blacklist = type(settings) == \"table\" and settings.aoeIDUserBlacklist or nil\nif type(blacklist) ~= \"table\" then\n  return\nend\n\n-- 28057 is only the boss read; these three IDs own the actual 50m AOEs.\nblacklist[28058] = \"十亿核爆剑\"\nblacklist[28114] = \"十亿核爆剑\"\nblacklist[28115] = \"十亿核爆剑\"\nself.used = true",
							endIfUsed = true,
							name = "屏蔽十亿核爆剑自动AOE",
							uuid = "e1f7047b-9b02-3d62-b1ed-eb4243a1a495",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1680.9,
				name = "[P7] 第二次十亿核爆屏蔽自动AOE",
				timelineIndex = 265,
				timerOffset = -9.2,
				uuid = "797e2aeb-ae45-6215-b8fb-d42014f22c77",
				version = 2,
			},
		},
	},
	[266] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 11319, subgroup = \"Highest HP\" })\nif not boss then\n  return\nend\n\nlocal buff = TensorCore.getBuff(boss, 2056)\nlocal stacks = tonumber(buff and buff.stacks)\nif stacks ~= 298 and stacks ~= 299 then\n  return\nend\n\nlocal moogleDrawer = TensorCore.getMoogleDrawer()\nlocal outlineThickness =\n  (tonumber(moogleDrawer and moogleDrawer.outlineThickness) or 1.5) + 0.5\n\nlocal fireColor =\n  GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)\nlocal iceColor =\n  GUI:ColorConvertFloat4ToU32(0, 0.38, 1, 1)\nlocal fireOutline =\n  GUI:ColorConvertFloat4ToU32(0.48, 0, 0, 1)\nlocal iceOutline =\n  GUI:ColorConvertFloat4ToU32(0, 0.12, 0.48, 1)\n\nif stacks == 298 then\n  local drawer = TensorCore.getCachedFlatDrawer(\n    fireColor, fireColor, fireColor, fireOutline, outlineThickness)\n  drawer:addTimedCircleOnEnt(6300, boss.id, 8)\nelse\n  local drawer = TensorCore.getCachedFlatDrawer(\n    iceColor, iceColor, iceColor, iceOutline, outlineThickness)\n  drawer:addTimedDonutOnEnt(6300, boss.id, 8, 50)\nend\n\nself.used = true",
							endIfUsed = true,
							name = "按龙王剑色绘制钢铁或月环",
							uuid = "6ea198d7-8e67-11bd-82ce-670b4dce6367",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1681,
				name = "[P7] 阿斯卡隆钢铁月环 6",
				timeRange = true,
				timelineIndex = 266,
				timerEndOffset = -5.4000000953674,
				timerOffset = -6,
				timerStartOffset = -6,
				uuid = "439e9701-46ee-c974-a213-fdd0c093b67f",
				version = 2,
			},
		},
	},
	[267] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"394c5e13-1deb-6f97-ba0a-3c8928f67c45",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "9fea8d80-54a9-bfba-b02f-73cad9db6c76",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"09304c6a-4293-688b-b05d-df55f40b4ccd",
									true,
								},
								
								{
									"60c85cf7-29f0-1eb8-bd39-e6aae43742c1",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "7eae5002-32b7-4595-9bd2-f8b02d900126",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"d97a91d0-2011-e735-b9ff-ebf48f411eb0",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "5211fc66-9bc8-96de-9e36-4817ee984d15",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "60c85cf7-29f0-1eb8-bd39-e6aae43742c1",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "394c5e13-1deb-6f97-ba0a-3c8928f67c45",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "09304c6a-4293-688b-b05d-df55f40b4ccd",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "d97a91d0-2011-e735-b9ff-ebf48f411eb0",
							version = 3,
						},
					},
				},
				mechanicTime = 1688.9,
				name = "[P7] 近战个人减伤",
				timelineIndex = 267,
				timerOffset = -3,
				uuid = "21a97a81-16a6-6dc8-9787-309e9edd0f3d",
				version = 2,
			},
		},
	},
	[268] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"H1\"\nlocal firstTank = \"ST\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：H1接刀 / 双T分开",
							uuid = "f41b8590-6180-3f2d-bd7f-2b013611e37d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1699.1,
				name = "[P7] 三剑一体平A动态指路 6-H1",
				timeRange = true,
				timelineIndex = 268,
				timerStartOffset = -3.5,
				uuid = "550f6f27-5c99-b622-ae5d-40dbd0b7a906",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "3f787b85-6edc-a156-9c86-1ce79312607f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1699.1,
				name = "[P7] 三剑一体平A范围 双T 6-H1",
				timelineIndex = 268,
				timerOffset = -3.5,
				uuid = "33362c04-8235-cdf5-96d2-e4ecaf48cc37",
				version = 2,
			},
		},
	},
	[269] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"H2\"\nlocal firstTank = \"ST\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：H2接刀 / 双T分开",
							uuid = "269db41c-70af-ec53-99a2-e05edcf41353",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1703.2,
				name = "[P7] 三剑一体平A动态指路 6-H2",
				timeRange = true,
				timelineIndex = 269,
				timerStartOffset = -3.5,
				uuid = "f1b9df6a-f945-2808-83fa-d5b450663066",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "231ccf6f-c890-0fe3-a5a0-be720aa5ec8c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1703.2,
				name = "[P7] 三剑一体平A范围 双T 6-H2",
				timelineIndex = 269,
				timerOffset = -3.5,
				uuid = "273c6917-2ee5-a128-84e9-0bffd472795a",
				version = 2,
			},
		},
	},
	[270] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local stateKey = \"p7ExaflareFrame3\"\nlocal hitTime = 1712\nlocal previewLead = 0.2\nlocal now = tonumber(TensorReactions_CurrentTimer)\nif now == nil then\n  self.used = true\n  return\nend\n\ndata.string_dsr = data.string_dsr or {}\nlocal root = data.string_dsr\nlocal state = root[stateKey]\n\nif state == nil or state.anchor ~= hitTime or now < hitTime - 7.0 then\n  root[stateKey] = nil\n  state = nil\nend\n\nif state == nil and now <= hitTime then\n  local aoes = Argus.getCurrentDirectionalAOEs(true) or {}\n  local matches = {}\n  for index = 1, #aoes do\n    local aoe = aoes[index]\n    local startTime = tonumber(aoe and aoe.startTime)\n    local radius = tonumber(aoe and aoe.aoeLength) or tonumber(aoe and aoe.radius)\n    if aoe and tonumber(aoe.aoeID) == 28060\n        and startTime ~= nil and radius ~= nil\n        and tonumber(aoe.x) ~= nil and tonumber(aoe.y) ~= nil\n        and tonumber(aoe.z) ~= nil and tonumber(aoe.heading) ~= nil then\n      matches[#matches + 1] = {\n        x = tonumber(aoe.x),\n        y = tonumber(aoe.y),\n        z = tonumber(aoe.z),\n        heading = tonumber(aoe.heading),\n        radius = radius,\n        startTime = startTime,\n      }\n    end\n  end\n\n  table.sort(matches, function(left, right)\n    return left.startTime > right.startTime\n  end)\n\n  local selected = {}\n  if #matches >= 3 then\n    local newestStart = matches[1].startTime\n    for index = 1, #matches do\n      local candidate = matches[index]\n      if math.abs(candidate.startTime - newestStart) <= 50 then\n        local duplicate = false\n        for savedIndex = 1, #selected do\n          local saved = selected[savedIndex]\n          local dx = saved.x - candidate.x\n          local dz = saved.z - candidate.z\n          if dx * dx + dz * dz < 0.01 then\n            duplicate = true\n            break\n          end\n        end\n        if not duplicate then\n          selected[#selected + 1] = candidate\n          if #selected == 3 then\n            break\n          end\n        end\n      end\n    end\n  end\n\n  if #selected == 3 then\n    state = {\n      anchor = hitTime,\n      origins = {},\n      points = {},\n      stepInterval = 1.825,\n      fill = GUI:ColorConvertFloat4ToU32(1, 0.10, 0.02, 0.88),\n      outline = GUI:ColorConvertFloat4ToU32(0.45, 0, 0, 1),\n    }\n\n    for sourceIndex = 1, #selected do\n      local source = selected[sourceIndex]\n      local origin = { x = source.x, y = source.y, z = source.z }\n      state.origins[#state.origins + 1] = {\n        x = source.x,\n        y = source.y,\n        z = source.z,\n        radius = source.radius,\n      }\n      for lane = -1, 1 do\n        local heading = source.heading + lane * math.pi / 2\n        for step = 1, 5 do\n          local x, y, z = TensorCore.getPosInDirection(\n            origin, heading, 6.91 * step, true)\n          if x ~= nil and y ~= nil and z ~= nil then\n            state.points[#state.points + 1] = {\n              step = step,\n              x = x,\n              y = y,\n              z = z,\n              radius = source.radius,\n            }\n          end\n        end\n      end\n    end\n    root[stateKey] = state\n  end\nend\n\nif state ~= nil then\n  local currentStep = 0\n  if now >= hitTime then\n    currentStep = math.floor((now - hitTime) / state.stepInterval) + 1\n  end\n\n  if currentStep <= 5 then\n    local drawer = TensorCore.getCachedDrawer(\n      state.fill, state.fill, state.fill, state.outline, 3)\n\n    if currentStep == 0 then\n      for index = 1, #state.origins do\n        local origin = state.origins[index]\n        drawer:addCircle(\n          origin.x, origin.y, origin.z, origin.radius)\n      end\n    end\n\n    local currentJudgment = hitTime\n    if currentStep > 0 then\n      currentJudgment = hitTime + currentStep * state.stepInterval\n    end\n\n    local nextStep\n    if currentStep < 5 and now >= currentJudgment - previewLead then\n      nextStep = currentStep + 1\n    end\n\n    for index = 1, #state.points do\n      local point = state.points[index]\n      if point.step == currentStep or point.step == nextStep then\n        drawer:addCircle(\n          point.x, point.y, point.z, point.radius)\n      end\n    end\n  end\nend\n\nself.used = true",
							endIfUsed = true,
							name = "三枚地火当前步与判定前下一步",
							uuid = "fb587972-49bb-5e94-8d54-c7c77ac1f4fa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1712,
				name = "[P7] 地火当前步与判定前下一步 3",
				timeRange = true,
				timelineIndex = 270,
				timerEndOffset = 9.5,
				timerStartOffset = -7.1999998092651,
				uuid = "ab7d008a-d8c3-bb9b-9a9a-50025bd8a9f9",
				version = 2,
			},
		},
	},
	[271] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 11319, subgroup = \"Highest HP\" })\nif not boss then\n  return\nend\n\nlocal buff = TensorCore.getBuff(boss, 2056)\nlocal stacks = tonumber(buff and buff.stacks)\nif stacks ~= 298 and stacks ~= 299 then\n  return\nend\n\nlocal moogleDrawer = TensorCore.getMoogleDrawer()\nlocal outlineThickness =\n  (tonumber(moogleDrawer and moogleDrawer.outlineThickness) or 1.5) + 0.5\n\nlocal fireColor =\n  GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)\nlocal iceColor =\n  GUI:ColorConvertFloat4ToU32(0, 0.38, 1, 1)\nlocal fireOutline =\n  GUI:ColorConvertFloat4ToU32(0.48, 0, 0, 1)\nlocal iceOutline =\n  GUI:ColorConvertFloat4ToU32(0, 0.12, 0.48, 1)\n\nif stacks == 298 then\n  local drawer = TensorCore.getCachedFlatDrawer(\n    fireColor, fireColor, fireColor, fireOutline, outlineThickness)\n  drawer:addTimedCircleOnEnt(6300, boss.id, 8)\nelse\n  local drawer = TensorCore.getCachedFlatDrawer(\n    iceColor, iceColor, iceColor, iceOutline, outlineThickness)\n  drawer:addTimedDonutOnEnt(6300, boss.id, 8, 50)\nend\n\nself.used = true",
							endIfUsed = true,
							name = "按龙王剑色绘制钢铁或月环",
							uuid = "10f03c05-f0ce-695c-a5cc-599cd4598678",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1712.2,
				name = "[P7] 阿斯卡隆钢铁月环 7",
				timeRange = true,
				timelineIndex = 271,
				timerEndOffset = -5.4000000953674,
				timerOffset = -6,
				timerStartOffset = -6,
				uuid = "0abba78c-343e-0081-bce7-13bb887d5121",
				version = 2,
			},
		},
	},
	[272] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D1\"\nlocal firstTank = \"MT\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D1接刀 / 双T分开",
							uuid = "3647b642-21c0-936d-b23b-b7dc93e3c924",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1720.2,
				name = "[P7] 三剑一体平A动态指路 7-D1",
				timeRange = true,
				timelineIndex = 272,
				timerStartOffset = -3.5,
				uuid = "1a784875-5ef0-60ca-8053-12fc57265b0c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "4bcd9e99-ee56-d5e9-8d10-e65a113b80a5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1720.2,
				name = "[P7] 三剑一体平A范围 双T 7-D1",
				timelineIndex = 272,
				timerOffset = -3.5,
				uuid = "1c36dbea-d6fb-3154-87ce-185d654c85d3",
				version = 2,
			},
		},
	},
	[273] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D2\"\nlocal firstTank = \"MT\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D2接刀 / 双T分开",
							uuid = "97fe2cea-b19e-a7cc-9c27-f40152e83cea",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1724.3,
				name = "[P7] 三剑一体平A动态指路 7-D2",
				timeRange = true,
				timelineIndex = 273,
				timerStartOffset = -3.5,
				uuid = "ca5d7004-51fa-0fa6-9706-8a6a41b32323",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "2c1bb429-81ca-3451-a010-38179b972f3c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1724.3,
				name = "[P7] 三剑一体平A范围 双T 7-D2",
				timelineIndex = 273,
				timerOffset = -3.5,
				uuid = "eba95306-e5ac-b7d0-9d7b-dad5403acba9",
				version = 2,
			},
		},
	},
	[274] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7498,
							conditions = 
							{
								
								{
									"61faa5ce-e741-caef-8897-fbe9c8b52a8f",
									true,
								},
							},
							endIfUsed = true,
							name = "心眼",
							uuid = "dea4a7d2-1ad2-602e-85e6-5271d79fbe7a",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7394,
							conditions = 
							{
								
								{
									"53c491ad-54ec-f20e-9f80-d80e0cb45964",
									true,
								},
								
								{
									"e3ef3957-a7a1-b384-880a-cec90e6e5a8a",
									true,
								},
							},
							endIfUsed = true,
							name = "金刚极意",
							uuid = "9ca38206-8db3-2db1-ac8a-17ed48886e25",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 24404,
							conditions = 
							{
								
								{
									"fce9b378-a6b1-eef3-9764-2d2ec5fe8aea",
									true,
								},
							},
							endIfUsed = true,
							name = "神秘纹",
							uuid = "2a4e7925-9d22-5bf8-80bd-dc95d5133449",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1179,
							category = "Self",
							uuid = "e3ef3957-a7a1-b384-880a-cec90e6e5a8a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								34,
							},
							name = "心眼职业",
							uuid = "61faa5ce-e741-caef-8897-fbe9c8b52a8f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								20,
							},
							name = "金刚极意职业",
							uuid = "53c491ad-54ec-f20e-9f80-d80e0cb45964",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								39,
							},
							name = "神秘纹职业",
							uuid = "fce9b378-a6b1-eef3-9764-2d2ec5fe8aea",
							version = 3,
						},
					},
				},
				mechanicTime = 1732.9,
				name = "[P7] 近战个人减伤",
				timelineIndex = 274,
				timerOffset = -3,
				uuid = "fb393cef-2ccb-8ade-8796-1df38bccfce2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "self.used = true\n\nlocal round = 3\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\n\ndata.string_dsr = type(data.string_dsr) == \"table\"\n    and data.string_dsr or {}\nlocal root = data.string_dsr\nlocal state = root.p7AkhMornTowerGuide\nif type(state) ~= \"table\" or state.round ~= round then\n  state = {\n    round = round,\n    towers = {},\n    sawFirstAOE = false,\n    firstResolved = false,\n  }\n  root.p7AkhMornTowerGuide = state\nend\n\nlocal firstAOEActive = false\nif type(Argus) == \"table\"\n    and type(Argus.getCurrentAOEs) == \"function\" then\n  for _, aoe in pairs(Argus.getCurrentAOEs() or {}) do\n    local id = tonumber(aoe and aoe.aoeID)\n    if id == 29452 or id == 29453 or id == 29454 then\n      local x = tonumber(aoe.x)\n      local y = tonumber(aoe.y)\n      local z = tonumber(aoe.z)\n      if x and y and z then\n        state.towers[id] = { x = x, y = y, z = z }\n        firstAOEActive = true\n        state.sawFirstAOE = true\n      end\n    end\n  end\nend\nif state.sawFirstAOE and not firstAOEActive then\n  state.firstResolved = true\nend\n\nlocal bossID = tonumber(root.godThordanID)\nlocal boss = bossID and TensorCore.mGetEntity(bossID) or nil\nif not boss then\n  boss = TensorCore.getEntityByGroup(\n    \"ContentID\", { contentid = 11319, subgroup = \"Nearest\" })\n  if boss then\n    root.godThordanID = tonumber(boss.id)\n  end\nend\n\n-- When replay starts a few frames before Argus exposes the cast AOEs,\n-- derive the same three radius-8 centers from the live boss heading.\nlocal bossPos = boss and boss.pos or nil\nlocal bossHeading = tonumber(bossPos and bossPos.h)\nif bossPos and bossHeading then\n  local offsets = {\n    [29453] = -math.pi / 3, -- boss left-front\n    [29452] = math.pi / 3,  -- boss right-front\n    [29454] = math.pi,      -- boss rear\n  }\n  for id, offset in pairs(offsets) do\n    if state.towers[id] == nil then\n      local position = TensorCore.getPosInDirection(\n        bossPos,\n        TensorCore.convertHeading(bossHeading + offset),\n        8)\n      if type(position) == \"table\"\n          and tonumber(position.x)\n          and tonumber(position.y)\n          and tonumber(position.z) then\n        state.towers[id] = {\n          x = tonumber(position.x),\n          y = tonumber(position.y),\n          z = tonumber(position.z),\n        }\n      end\n    end\n  end\nend\n\nlocal towerOrder = { 29453, 29452, 29454 }\nfor _, id in ipairs(towerOrder) do\n  if type(state.towers[id]) ~= \"table\" then\n    return\n  end\nend\n\nif not state.drawer then\n  local fill = GUI:ColorConvertFloat4ToU32(0.05, 0.9, 0.2, 0.26)\n  local outline = GUI:ColorConvertFloat4ToU32(0.2, 1, 0.35, 0.95)\n  state.drawer = TensorCore.getCachedFlatDrawer(\n    nil, nil, fill, outline, 2, 0)\nend\nfor _, id in ipairs(towerOrder) do\n  local tower = state.towers[id]\n  state.drawer:addCircle(tower.x, tower.y, tower.z, 4, false)\nend\n\nif not boss or type(party) ~= \"table\"\n    or type(guide.FrameDirect) ~= \"function\"\n    or playerID == nil then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\nlocal selfRole = roleByID[playerID]\nif selfRole == nil then\n  return\nend\n\nlocal buff = TensorCore.getBuff(boss, 2056)\nlocal stacks = tonumber(buff and buff.stacks)\nif stacks == 298 or stacks == 299 then\n  state.sword = stacks\nend\nif state.sword == nil then\n  return\nend\n\nlocal towerID\nif round == 1 then\n  if selfRole == \"H1\" or selfRole == \"D1\" or selfRole == \"D3\" then\n    towerID = 29453\n  elseif selfRole == \"H2\" or selfRole == \"D2\" or selfRole == \"D4\" then\n    towerID = 29452\n  else\n    towerID = 29454\n  end\nelse\n  if selfRole == \"MT\" then\n    towerID = 29452\n  elseif selfRole == \"ST\" then\n    towerID = 29454\n  else\n    towerID = 29453\n  end\nend\n\nlocal tower = state.towers[towerID]\nlocal centerX = tonumber(bossPos and bossPos.x)\nlocal centerZ = tonumber(bossPos and bossPos.z)\nif not tower or not centerX or not centerZ then\n  return\nend\n\nlocal dx = tower.x - centerX\nlocal dz = tower.z - centerZ\nlocal length = math.sqrt(dx * dx + dz * dz)\nif length < 0.001 then\n  return\nend\n\n-- Tower centers sit on radius 8, exactly at the steel/donut boundary.\n-- Before the first hit, steel moves 1.5 out and donut 1.5 in.\n-- After the sword resolves, all assignments settle 1.5 inward for healing\n-- while remaining comfortably inside the radius-4 tower.\nlocal shift = -1.5\nif not state.firstResolved and state.sword == 298 then\n  shift = 1.5\nend\nlocal targetX = tower.x + dx / length * shift\nlocal targetZ = tower.z + dz / length * shift\nguide.FrameDirect(targetX, targetZ, 0.5)\n",
							endIfUsed = true,
							name = "绿色塔圈与 MuAi 动态指路",
							uuid = "0953ece3-73e9-b6c8-89a0-dd12ee609d3c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1732.9,
				name = "[P7] 死亡轮回塔 3（116）范围与动态指路",
				timeRange = true,
				timelineIndex = 274,
				timerEndOffset = 7.9,
				timerStartOffset = -6.7,
				uuid = "4930777d-0000-4147-bc61-b78c3a3158b1",
				version = 2,
			},
		},
	},
	[275] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"e8d2247c-d54b-089e-bee8-be9f140b4f03",
									true,
								},
								
								{
									"05aa5aa2-2c47-a79f-8074-06860891e79a",
									true,
								},
								
								{
									"ffb70e5b-1606-cd67-a424-19cdd9399650",
									true,
								},
								
								{
									"c3dd264b-a279-2656-8420-b9da44fd7911",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum3_Hotbar_Tactician",
							name = "策动",
							uuid = "a188b349-a61f-a3c4-88db-d3378a40a364",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList = 
							{
								23,
								31,
								38,
							},
							name = "远敏职业",
							uuid = "e8d2247c-d54b-089e-bee8-be9f140b4f03",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1934,
							category = "Self",
							uuid = "05aa5aa2-2c47-a79f-8074-06860891e79a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1951,
							category = "Self",
							uuid = "ffb70e5b-1606-cd67-a424-19cdd9399650",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 1826,
							category = "Self",
							uuid = "c3dd264b-a279-2656-8420-b9da44fd7911",
							version = 3,
						},
					},
				},
				mechanicTime = 1733,
				name = "[P7] 远敏团队减伤",
				timeRange = true,
				timelineIndex = 275,
				timerEndOffset = 15,
				timerStartOffset = -5,
				uuid = "ee47bddb-0b42-72a2-996f-9a51a34685c2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local boss = TensorCore.getEntityByGroup(\n  \"ContentID\", { contentid = 11319, subgroup = \"Highest HP\" })\nif not boss then\n  return\nend\n\nlocal buff = TensorCore.getBuff(boss, 2056)\nlocal stacks = tonumber(buff and buff.stacks)\nif stacks ~= 298 and stacks ~= 299 then\n  return\nend\n\nlocal moogleDrawer = TensorCore.getMoogleDrawer()\nlocal outlineThickness =\n  (tonumber(moogleDrawer and moogleDrawer.outlineThickness) or 1.5) + 0.5\n\nlocal fireColor =\n  GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)\nlocal iceColor =\n  GUI:ColorConvertFloat4ToU32(0, 0.38, 1, 1)\nlocal fireOutline =\n  GUI:ColorConvertFloat4ToU32(0.48, 0, 0, 1)\nlocal iceOutline =\n  GUI:ColorConvertFloat4ToU32(0, 0.12, 0.48, 1)\n\nif stacks == 298 then\n  local drawer = TensorCore.getCachedFlatDrawer(\n    fireColor, fireColor, fireColor, fireOutline, outlineThickness)\n  drawer:addTimedCircleOnEnt(6300, boss.id, 8)\nelse\n  local drawer = TensorCore.getCachedFlatDrawer(\n    iceColor, iceColor, iceColor, iceOutline, outlineThickness)\n  drawer:addTimedDonutOnEnt(6300, boss.id, 8, 50)\nend\n\nself.used = true",
							endIfUsed = true,
							name = "按龙王剑色绘制钢铁或月环",
							uuid = "7d1891bd-57f8-bfa1-b3b2-03d3a2bcf97f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1733,
				name = "[P7] 阿斯卡隆钢铁月环 8",
				timeRange = true,
				timelineIndex = 275,
				timerEndOffset = -5.4,
				timerOffset = -6,
				timerStartOffset = -6,
				uuid = "71b552fb-d8bd-bfed-a9e2-b4e6cdcdbb64",
				version = 2,
			},
		},
	},
	[276] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D3\"\nlocal firstTank = \"ST\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D3接刀 / 双T分开",
							uuid = "cb21ecf9-7f64-51e4-b5b8-cd308c04bd28",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1747,
				name = "[P7] 三剑一体平A动态指路 8-D3",
				timeRange = true,
				timelineIndex = 276,
				timerStartOffset = -3.5,
				uuid = "1ccfa4ea-d64d-75c2-ad25-84b517de7d53",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "79dcf5df-ed76-73b8-a991-ec1642b326c7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1747,
				name = "[P7] 三剑一体平A范围 双T 8-D3",
				timelineIndex = 276,
				timerOffset = -3.5,
				uuid = "ba5e3abf-e036-3116-8864-c89e1a29b8a1",
				version = 2,
			},
		},
	},
	[277] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = tonumber(player and player.id)\nif type(party) ~= \"table\"\n    or playerID == nil\n    or type(player.pos) ~= \"table\" then\n  return\nend\n\nlocal roles = { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nlocal roleByID = {}\nfor _, role in ipairs(roles) do\n  local id = tonumber(party[role] and party[role].id)\n  if id == nil or roleByID[id] ~= nil then\n    return\n  end\n  roleByID[id] = role\nend\n\nlocal selfRole = roleByID[playerID]\n\n-- Helpers use the same ContentID. Select the entity actually at the arena centre,\n-- so replay-specific runtime entity IDs and temporary outer helpers are ignored.\nlocal bosses = TensorCore.getEntityGroupList(\n  \"ContentID\", { contentid = 11319, noAliveCheck = true })\nif type(bosses) ~= \"table\" then\n  return\nend\n\nlocal boss\nlocal bestDistance2 = math.huge\nfor _, entity in pairs(bosses) do\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and z ~= nil then\n    local dx = x - 100.0\n    local dz = z - 100.0\n    local distance2 = dx * dx + dz * dz\n    if distance2 < bestDistance2 then\n      boss = entity\n      bestDistance2 = distance2\n    end\n  end\nend\n\nlocal bossPos = boss and boss.pos\nlocal bossX = tonumber(bossPos and bossPos.x)\nlocal bossZ = tonumber(bossPos and bossPos.z)\nif bossX == nil or bossZ == nil or bestDistance2 > 9.0 then\n  return\nend\n\n-- Trinity's physical hit snapshots the closest non-tank. Re-resolve it every\n-- frame so the circle follows target swaps inside the 3.5-second guide window.\nlocal closestPos\nlocal closestDistance2 = math.huge\nlocal nonTankRoles = { \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nfor _, role in ipairs(nonTankRoles) do\n  local id = tonumber(party[role] and party[role].id)\n  local entity = id and TensorCore.mGetEntity(id) or nil\n  local pos = entity and entity.pos\n  local x = tonumber(pos and pos.x)\n  local y = tonumber(pos and pos.y)\n  local z = tonumber(pos and pos.z)\n  if x ~= nil and y ~= nil and z ~= nil then\n    local dx = x - bossX\n    local dz = z - bossZ\n    local distance2 = dx * dx + dz * dz\n    if distance2 < closestDistance2 then\n      closestPos = pos\n      closestDistance2 = distance2\n    end\n  end\nend\n\nif closestPos ~= nil\n    and type(Argus) == \"table\"\n    and type(Argus.addCircleFilled) == \"function\" then\n  local _, _, colorEnd, colorOutline, outlineThickness =\n    TensorCore.getMoogleColors()\n  if colorEnd ~= nil and colorOutline ~= nil and outlineThickness ~= nil then\n    Argus.addCircleFilled(\n      closestPos.x, closestPos.y, closestPos.z, 3.0, 50,\n      colorEnd, colorOutline, outlineThickness)\n  end\nend\n\nif selfRole == nil\n    or type(guide.FrameDirect) ~= \"function\" then\n  return\nend\n\nlocal assignedGuide = \"D4\"\nlocal firstTank = \"ST\"\nlocal isTank = selfRole == \"MT\" or selfRole == \"ST\"\nif not isTank and selfRole ~= assignedGuide then\n  return\nend\n\nlocal bossHeading = tonumber(bossPos.h)\nif bossHeading == nil then\n  return\nend\n\nlocal x, z\nlocal function positionAt(heading, distance)\n  local px, _, pz = TensorCore.getPosInDirection(\n    bossPos, heading, distance, true)\n  return tonumber(px), tonumber(pz)\nend\n\nif isTank then\n  if selfRole == firstTank then\n    x, z = positionAt(bossHeading, 8.5)\n  else\n    local angle = math.rad(50)\n    local leftX, leftZ = positionAt(bossHeading - angle, 9.5)\n    local rightX, rightZ = positionAt(bossHeading + angle, 9.5)\n    if leftX == nil or rightX == nil then\n      return\n    end\n    local playerX = tonumber(player.pos.x)\n    local playerZ = tonumber(player.pos.z)\n    if playerX == nil or playerZ == nil then\n      return\n    end\n    local leftDistance2 = (leftX - playerX) ^ 2 + (leftZ - playerZ) ^ 2\n    local rightDistance2 = (rightX - playerX) ^ 2 + (rightZ - playerZ) ^ 2\n    if leftDistance2 <= rightDistance2 then\n      x, z = leftX, leftZ\n    else\n      x, z = rightX, rightZ\n    end\n  end\nelse\n  -- Only the role taking this hit is routed, directly to the boss centre.\n  x, z = bossX, bossZ\nend\n\nif x == nil or z == nil then\n  return\nend\nguide.FrameDirect(x, z, 0.5)\nself.used = true",
							endIfUsed = true,
							name = "MuAi动态指路：D4接刀 / 双T分开",
							uuid = "0278f0cd-4007-e3f3-81ea-dfa5e5a42606",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1751.1,
				name = "[P7] 三剑一体平A动态指路 8-D4",
				timeRange = true,
				timelineIndex = 277,
				timerStartOffset = -3.5,
				uuid = "6441f8a8-373d-2302-8a8b-52558d3f4c02",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Trinity hits the first- and second-enmity tanks with radius-3 magic circles.\nlocal guide = type(MuAiGuide) == \"table\" and MuAiGuide or nil\nlocal party = guide and guide.Party or nil\nif type(party) ~= \"table\" then\n  return\nend\n\nlocal mtID = tonumber(party.MT and party.MT.id)\nlocal stID = tonumber(party.ST and party.ST.id)\nif mtID == nil or stID == nil or mtID == stID then\n  return\nend\n\nlocal colorStart, colorMid, colorEnd, colorOutline, outlineThickness =\n  TensorCore.getMoogleColors()\nif colorStart == nil or colorMid == nil or colorEnd == nil\n    or colorOutline == nil or outlineThickness == nil then\n  return\nend\n\n-- One entity-attached timed draw per tank; default render flags retain terrain warp.\nlocal drawer = TensorCore.getCachedDrawer(\n  colorStart, colorMid, colorEnd, colorOutline, outlineThickness)\ndrawer:addTimedCircleOnEnt(3500, mtID, 3.0)\ndrawer:addTimedCircleOnEnt(3500, stID, 3.0)\nself.used = true",
							endIfUsed = true,
							name = "双T平A范围 3m（一次性）",
							uuid = "8d7a39df-13a2-606f-ae61-eead3bed3670",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1751.1,
				name = "[P7] 三剑一体平A范围 双T 8-D4",
				timelineIndex = 277,
				timerOffset = -3.5,
				uuid = "ef66f873-d29a-0f04-b709-7c51e67fe0ae",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "dsw",
	version = "1.0.5",
}



return tbl