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
							actionLua = "local bossPos = TensorCore.mGetEntity(data.MuAiGd_P1_BOSS.id).pos\nlocal distance\nif TensorCore.isAnyEntityCasting(40144) then -- 火\n    data.MuAiGd_P1_8_Type1 = 1\n    distance = 6\n    MuAiGuide.Info(\"八方然后和搭档分摊。\", true)\nelse\n    data.MuAiGd_P1_8_Type1 = 2\n    local melees = { \"MT\", \"ST\", \"D1\", \"D2\" }\n    if table.contains(melees, MuAiGuide.SelfPos) then\n        distance = 6\n    else\n        distance = 14\n    end\n    MuAiGuide.Info(\"八方然后分散。\", true)\nend\nlocal pos = TensorCore.getPosInDirection(bossPos, data.MuAiGd_P1_8_BaseHeading, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, 5000)\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "25e6b076-bdfc-d583-b16b-027d0cb6cd1c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 13.7,
				name = "[MuAiGuide]BOSS8方",
				timelineIndex = 1,
				timerOffset = -5,
				uuid = "63663593-7871-8d7a-8751-3b224a3c37e7",
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
							actionLua = "local selfIndex = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.JobPos, MuAiGuide.SelfPos)\ndata.MuAiGd_P1_8_BaseHeading = (selfIndex - 1) * math.pi / 4\nlocal pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, data.MuAiGd_P1_8_BaseHeading, 7.5)\nMuAiGuide.DirectTo(pos.x, pos.z, 10000)\nfor _, ent in pairs(TensorCore.entityList(\"contentid=9707\")) do\n    if Argus.isEntityVisible(ent) then\n        data.MuAiGd_P1_BOSS = ent\n        break\n    end\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "25e6b076-bdfc-d583-b16b-027d0cb6cd1c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 13.7,
				name = "[MuAiGuide]8方",
				timelineIndex = 1,
				timerOffset = -12,
				uuid = "db69b28f-01d0-ec40-a2c6-7157106baa6d",
				version = 2,
			},
			inheritedIndex = 4,
		},
	},
	
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
							actionLua = "local heading = data.MuAiGd_P1_8_BaseHeading\nif MuAiGuide.Config.FruCfg.ProteanType == 1 or data.MuAiGd_P1_8_Type1 == 1 then\n    local tankHealer = { \"MT\", \"ST\", \"H1\", \"H2\" }\n    if table.contains(tankHealer, MuAiGuide.SelfPos) then\n        heading = heading + math.pi / 8\n    else\n        heading = heading - math.pi / 8\n    end\nelse\n    heading = heading - math.pi / 8\nend\nlocal bossPos = TensorCore.mGetEntity(data.MuAiGd_P1_BOSS.id).pos\nlocal distance = TensorCore.getDistance2d(MuAiGuide.GetPlayer().pos, bossPos)\n\nif MuAiGuide.SelfPos == \"ST\" and data.MuAiGd_P1_8_Type1 == 2 and  MuAiGuide.Config.FruCfg.ProteanType == 2 then\n    distance = 14\nend\n\nlocal pos = TensorCore.getPosInDirection(bossPos, heading, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, 3000)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "eb782d2d-bfbe-5bd9-bcf4-ccd1a584451d",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 14.4,
				name = "[MuAiGuide]躲",
				timelineIndex = 2,
				uuid = "1691a491-98f8-68ea-8a7b-ab58c3c56a7c",
				version = 2,
			},
		},
	},
	
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
							actionLua = "local bossPos = TensorCore.mGetEntity(data.MuAiGd_P1_BOSS.id).pos\nlocal distance = TensorCore.getDistance2d(MuAiGuide.GetPlayer().pos, bossPos)\nlocal pos = TensorCore.getPosInDirection(bossPos, data.MuAiGd_P1_8_BaseHeading, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, 3000)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "eb782d2d-bfbe-5bd9-bcf4-ccd1a584451d",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 16.4,
				name = "[MuAiGuide]回",
				timelineIndex = 3,
				uuid = "1c3044b6-be9f-ffc6-b5ea-597744ca14d5",
				version = 2,
			},
			inheritedIndex = 1,
		},
	}, 
	[5] = 
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
							actionLua = "local heading = data.MuAiGd_P1_8_BaseHeading\nif MuAiGuide.Config.FruCfg.ProteanType == 1 then\n    local tankHealer = { \"MT\", \"ST\", \"H1\", \"H2\" }\n    if table.contains(tankHealer, MuAiGuide.SelfPos) then\n        heading = heading + math.pi / 8\n    else\n        heading = heading - math.pi / 8\n    end\nelse\n    heading = heading - math.pi / 8\nend\n\nlocal bossPos = TensorCore.mGetEntity(data.MuAiGd_P1_BOSS.id).pos\nlocal distance = TensorCore.getDistance2d(MuAiGuide.GetPlayer().pos, bossPos)\nlocal pos = TensorCore.getPosInDirection(bossPos, heading, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, 3000)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "eb782d2d-bfbe-5bd9-bcf4-ccd1a584451d",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 18.4,
				name = "[MuAiGuide]躲",
				timelineIndex = 5,
				uuid = "88d6bd89-b470-541c-9739-271449826418",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "local selfIndex = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.FruUtopainSkyPosInfo, MuAiGuide.SelfPos)\nlocal heading = (selfIndex - 1) * math.pi / 4\nif MuAiGuide.SelfPos == \"MT\" then\n    heading = heading - math.pi / 90\nelseif MuAiGuide.SelfPos == \"ST\" then\n    heading = heading + math.pi / 90\nend\nlocal pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 19.5)\nMuAiGuide.DirectTo(pos.x, pos.z, 10000)\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "8e76872a-4634-9c51-adab-e5d9fe335b56",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 34.9,
				name = "[MuAiGuide]雾龙8方场边",
				timelineIndex = 10,
				uuid = "77e7a4f4-15ef-490d-8a41-73733cae7c4d",
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
							actionLua = "d(eventArgs.spellID)\nif eventArgs.spellID == 40154 then\n\tMuAiGuide.Info(\"稍后分摊。\", true)\n    data.MuAiGd_SinsmokeType = 1\nelseif eventArgs.spellID == 40155 then\n    data.MuAiGd_SinsmokeType = 2\n\tMuAiGuide.Info(\"稍后分散。\", true)\nelse\n    data.MuAiGd_SinsmokeType = 0\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"3ae5a8a1-6db7-24d7-82de-948b7ce6b6f2",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "乐园绝技类型记录",
							uuid = "04d12805-bffa-03a0-be65-b0f7c452ee51",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							eventSpellID = 40154,
							spellIDList = 
							{
								40154,
								40155,
							},
							uuid = "3ae5a8a1-6db7-24d7-82de-948b7ce6b6f2",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				eventType = 3,
				mechanicTime = 34.9,
				name = "[MuAiGuide]乐园绝技类型记录",
				randomOffset = 3,
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 5,
				timerOffset = -3,
				timerStartOffset = -5,
				uuid = "493ecff4-3afc-467d-b8b3-b3da390f9c39",
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
							actionLua = "local M = MuAiGuide\nlocal drawTime = 10000\nif data.MuAiGd_SinsmokeIndex == nil then\n    data.MuAiGd_SinsmokeIndex = {}\n    -- 雾龙站位情况C开始逆时针一圈, 如果站位不同可以修改这里\n    data.MuAiGd_SinsmokeJobOrder = { \"H2\", \"D2\", \"D4\", \"ST\", \"MT\", \"D3\", \"H1\", \"D1\" }\n    data.MuAiGd_SinsmokeGuideFinish = false\n    M.Debug(\"================================== 雾龙计算开始 ====================================\")\nend\n\nif table.size(data.MuAiGd_SinsmokeIndex) < 3 then\n    -- 采集阶段\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9708\")) do\n        if ent.action == 210 then\n            -- 抬手\n            local pos = M.GetDirectionIndex({ x = 100, z = 100 }, { x = ent.pos.x, z = ent.pos.z })\n            table.insert(data.MuAiGd_SinsmokeIndex, pos)\n            --如果是自己，那么自己往前走\n            local jobName = data.MuAiGd_SinsmokeJobOrder[pos]\n            if jobName then\n                if M.IsMeByPos(jobName) then\n                    -- 指路到前面(给对面的人看的)\n                    local pos1 = M.GetPointAtDistance({ x = 100, y = 0, z = 100 }, ent.pos, 10)\n                    M.DirectTo(pos1.x, pos1.z, 2000)\n                end\n            end\n        end\n    end\nend\n\nif table.size(data.MuAiGd_SinsmokeIndex) == 3\n    and data.MuAiGd_SinsmokeGuideFinish == false then\n   \n    local danger = {}\n    for i = 1, 3, 1 do\n        local pos = data.MuAiGd_SinsmokeIndex[i]\n        table.insert(danger, pos)\n        local opposite = pos + 4\n        if opposite > 8 then\n            opposite = opposite - 8\n        end\n        table.insert(danger, opposite)\n    end\n\n    local safeHeading\n    local selfOrder = M.IndexOf(data.MuAiGd_SinsmokeJobOrder, M.SelfPos)\n    for i = 1, 8, 1 do\n        if not table.contains(danger, i) then\n            if (selfOrder >= 5 and i >= 5) or (selfOrder <= 4 and i <= 4) then\n                safeHeading = (i - 1) * math.pi / 4\n            end\n        end\n    end\n\n    -- debug start\n    local msg = \"危险点\"\n    for i = 1, #danger do\n        msg = msg .. \", \" .. danger[i]\n    end\n    M.Debug(msg)\n    msg = \"本组安全区\" .. (safeHeading / math.pi)\n    M.Debug(msg)\n    local infoPoint = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, safeHeading)\n   \n    -- debug end\n\n    local targetPos\n    if data.MuAiGd_SinsmokeType == 1 then\n        --分摊\n        targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 13)\n        M.Info(\"去\" .. infoPoint .. \"点，分摊。\")\n    elseif data.MuAiGd_SinsmokeType == 2 then\n        -- 按照如下站位进下的指路\n        --      H\n        -- 近   T   远\n        -- 如果站位不同，需要修改\n        if M.SelfPos == \"MT\" or M.SelfPos == \"ST\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 19.5)\n        elseif M.SelfPos == \"H1\" or M.SelfPos == \"H2\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading, 13)\n        elseif M.SelfPos == \"D1\" or M.SelfPos == \"D2\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading - 0.105 * math.pi, 19.5)\n        elseif M.SelfPos == \"D3\" or M.SelfPos == \"D4\" then\n            targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, safeHeading + 0.105 * math.pi, 19.5)\n        end\n        M.Info(\"去\" .. infoPoint .. \"点，分散。\")\n    end\n\n    if table.contains(data.MuAiGd_SinsmokeIndex, selfOrder) then\n        M.DirectTo(targetPos.x, targetPos.z, 8000, 0.5, 2000)\n    else\n        M.DirectTo(targetPos.x, targetPos.z, drawTime)\n    end\n    data.MuAiGd_SinsmokeGuideFinish = true\n    M.Debug(\"================================== 雾龙计算结束 ====================================\")\nend\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"185593c3-8095-1233-a28a-dc5611fb08a2",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "雾龙",
							uuid = "a269d71a-373e-0a3d-a331-59aa86be5681",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_SinsmokeType ~= nil",
							uuid = "185593c3-8095-1233-a28a-dc5611fb08a2",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 34.9,
				name = "[MuAiGuide]雾龙",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 6,
				uuid = "a770ba4a-d4d6-5833-a9ee-63653f52b664",
				version = 2,
			},
			inheritedIndex = 3,
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
							actionLua = "data.MuAiGd_P1_8_2_skillType = eventArgs.spellID \nif eventArgs.spellID == 40329 then\n\tMuAiGuide.Info(\"八方然后和搭档分摊。\", true)\n    data.MuAiGd_SinsmokeType = 1\nelseif eventArgs.spellID == 40330 then\n    data.MuAiGd_SinsmokeType = 2\n\tMuAiGuide.Info(\"八方然后分散。\", true)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"7a41f349-d266-77e6-8594-b2fbc08b0952",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "44fab956-b6e4-c981-bac2-16f0306d0ffd",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							spellIDList = 
							{
								40329,
								40330,
							},
							uuid = "7a41f349-d266-77e6-8594-b2fbc08b0952",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 50,
				name = "[MuAiGuide]2次8方读条采集",
				randomOffset = 10,
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 5,
				timerOffset = -1,
				timerStartOffset = -5,
				uuid = "e8a321fb-3970-e199-8ef1-ef37dc5cbc65",
				version = 2,
			},
			inheritedIndex = 1,
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
							aType = "Lua",
							actionLua = "local melees = { \"MT\", \"ST\", \"D1\", \"D2\" }\nlocal distance \nif not table.contains(melees, MuAiGuide.SelfPos) or (MuAiGuide.Config.FruCfg.ProteanType == 2 and MuAiGuide.SelfPos == \"ST\") then\n    distance = 13\nelse\n    distance = 6\nend\nlocal pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, data.MuAiGd_P1_8_BaseHeading, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, 10000)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "822af936-8a44-e797-ba24-4875441a33c4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 56.2,
				name = "[MuAiGuide]2次8初始引导",
				timelineIndex = 13,
				timerOffset = -6,
				uuid = "799d1fd6-31ac-75d1-af95-4b866ad4720d",
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
							actionLua = "local guideTime = 2000\nlocal heading = data.MuAiGd_P1_8_BaseHeading\nif MuAiGuide.Config.FruCfg.ProteanType == 1 or data.MuAiGd_P1_8_2_skillType == 40329 then\n    local tankHealer = { \"MT\", \"ST\", \"H1\", \"H2\" }\n    if table.contains(tankHealer, MuAiGuide.SelfPos) then\n        heading = heading + math.pi / 8\n    else\n        heading = heading - math.pi / 8\n    end\nelse\n    heading = heading - math.pi / 8\nend\nlocal distance\n\nif data.MuAiGd_P1_8_2_skillType == 40329 then\n    local partner = MuAiGuide.GetBasePartner(MuAiGuide.Config.FruCfg)\n    local p = MuAiGuide.Party[partner]\n    MuAiGuide.DirectToEnt(p.id, guideTime)\n    distance = 7\nelse\n    if MuAiGuide.Config.FruCfg.ProteanType == 1 then\n        local melees = { \"MT\", \"ST\", \"D1\", \"D2\" }\n        if table.contains(melees, MuAiGuide.SelfPos) then\n            distance = 7\n        else\n            distance = 15\n        end\n    else\n        distance = 15\n    end\nend\n\nlocal pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, guideTime)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "cbdcb7cf-49d8-912e-a018-3d6cfe34e25a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 56.2,
				name = "[MuAiGuide]2躲",
				timelineIndex = 13,
				uuid = "f2dae75c-423b-c6cb-b9b0-cd36328bd8be",
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
							aType = "Lua",
							actionLua = "local heading3 \nif MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, 0) or MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi / 4) then\n    heading3 = 0\nelseif MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi * 1 / 2) or MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi * 3 / 4) then\n    heading3 = math.pi * 3 / 4\nelseif MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi) or MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi * 5 / 4) then\n    heading3 = math.pi\nelseif MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi * 3 / 2) or MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi * 7 / 4) then\n    heading3 = math.pi * 7 / 4\nend\nlocal distance = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, MuAiGuide.GetPlayer().pos)\nlocal pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading3, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, 3000)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2e1a3fd2-50a0-02c9-b8d7-3482e43fbe36",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 58.2,
				name = "[MuAiGuide]3躲",
				timelineIndex = 14,
				uuid = "1664ba4d-20fc-73e3-a2a2-596550f08295",
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
							actionLua = "if eventArgs.spellID == 40151 then\n    MuAiGuide.Info(\"找红色。\", true)\nelseif eventArgs.spellID == 40150 then\n    MuAiGuide.Info(\"找蓝色。\", true)\nend\ndata.MuAiGd_P1_8_2_skillType2 = eventArgs.spellID\nself.used = true",
							conditions = 
							{
								
								{
									"38755763-ae32-8795-941c-61e4c56f6df4",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "e5538237-bde4-e326-9c25-59905a896225",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							eventSpellID = 40151,
							spellIDList = 
							{
								40151,
								40150,
							},
							uuid = "38755763-ae32-8795-941c-61e4c56f6df4",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 58.2,
				name = "[MuAiGuide]光轮读条采集",
				timeRange = true,
				timelineIndex = 14,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "5ec58503-83f0-eb3f-b270-fd806a3f4c87",
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
							aType = "Lua",
							actionLua = "local heading4\nif MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, 0) or MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi / 4) then\n    heading4 = math.pi / 8\nelseif MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi * 1 / 2) or MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi * 3 / 4) then\n    heading4 = math.pi * 7 / 8\nelseif MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi) or MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi * 5 / 4) then\n    heading4 = math.pi * 9 / 8\nelseif MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi * 3 / 2) or MuAiGuide.IsSame(data.MuAiGd_P1_8_BaseHeading, math.pi * 7 / 4) then\n    heading4 = math.pi * 15 / 8\nend\nlocal distance = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, MuAiGuide.GetPlayer().pos)\nif distance < 13 then\n\tdistance = 13\nend\nlocal pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading4, distance)\nMuAiGuide.DirectTo(pos.x, pos.z, 3000)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "3322ab0a-b0ae-ef80-8982-9573c746bd05",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 60.2,
				name = "[MuAiGuide]4躲",
				timelineIndex = 16,
				uuid = "d3204e62-9889-f3f6-863a-cadb0b124c10",
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
							aType = "Lua",
							actionLua = "local fireRing, lightingRing\nfor _, ent in pairs(TensorCore.entityList(\"contentid=9710\")) do\n    if ent.pos.z > 90 then\n        fireRing = ent\n        break\n    end\nend\n\nfor _, ent in pairs(TensorCore.entityList(\"contentid=9711\")) do\n    if ent.pos.z > 90 then\n        lightingRing = ent\n        break\n    end\nend\nif fireRing ~= nil and lightingRing ~= nil then\n    local targetRing\n    if data.MuAiGd_P1_8_2_skillType2 == 40151 then     --雷\n        targetRing = fireRing\n    elseif data.MuAiGd_P1_8_2_skillType2 == 40150 then --火\n        targetRing = lightingRing\n    end\n    data.MuAiGd_P1_8_2TargetRing = targetRing\n    local posX, posZ\n    if data.MuAiGd_P1_8_2TargetRing.pos.x < 100 then\n        posX = 94\n    else\n        posX = 106\n    end\n    if MuAiGuide.GetPlayer().pos.z > 100 then\n        posZ = 112\n    else\n        posZ = 88\n    end\n    MuAiGuide.DirectTo(posX, posZ, 4000)\n    self.used = true\nend",
							conditions = 
							{
								
								{
									"a060c8f8-223f-44fa-813e-bf301a45a0bd",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "091f9c0e-d525-f38d-990e-bc279879164a",
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
							conditionLua = "return data.MuAiGd_P1_8_2_skillType2 ~= nil and data.MuAiGd_P1_8_2_skillType2 > 0",
							uuid = "a060c8f8-223f-44fa-813e-bf301a45a0bd",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 66.2,
				name = "[MuAiGuide]光轮出现",
				timeRange = true,
				timelineIndex = 18,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "f87c03c2-448f-ce28-a599-5810eb2e4863",
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
							actionLua = "local hasBuff = {}\nlocal M = MuAiGuide\n\nlocal posX, posZ\nif data.MuAiGd_P1_8_2TargetRing.pos.x < 100 then\n    posX = 94\nelse\n    posX = 106\nend\n\nfor job, ent in pairs(M.Party) do\n    if TensorCore.getBuff(ent.id, 1051) and not table.contains(hasBuff, job) then\n        table.insert(hasBuff, job)\n    end\nend\n--- 0 : 不同组 1：同上 2：同下\nlocal divType = 0\nif table.contains(M.Config.FruCfg.CatchTwoUp, hasBuff[1])\n    and table.contains(M.Config.FruCfg.CatchTwoUp, hasBuff[2])\nthen\n    divType = 1\nelseif table.contains(M.Config.FruCfg.CatchTwoDown, hasBuff[1])\n    and table.contains(M.Config.FruCfg.CatchTwoDown, hasBuff[2]) then\n    divType = 2\nend\n\nif divType == 0 then\n    if table.contains(M.Config.FruCfg.CatchTwoUp, M.SelfPos) then\n        posZ = 95\n    else\n        posZ = 105\n    end\nelse\n    if hasBuff[1] == M.SelfPos or hasBuff[2] == M.SelfPos then\n        local selfIndex, otherIndex\n        local group\n        if divType == 1 then\n            group = M.Config.FruCfg.CatchTwoUp\n        elseif divType == 2 then\n            group = M.Config.FruCfg.CatchTwoDown\n        end\n        local other\n        if hasBuff[1] == M.SelfPos then\n            other = hasBuff[2]\n        else\n            other = hasBuff[1]\n        end\n\n        selfIndex = M.IndexOf(group, M.SelfPos)\n        otherIndex = M.IndexOf(group, other)\n        if group ~= nil then\n            if selfIndex < otherIndex then\n                M.Info(\"高优先级，去上。\", true)\n                posZ = 95\n            else\n                M.Info(\"低优先级，去下。\", true)\n                posZ = 105\n            end\n        end\n    else\n        if table.contains(M.Config.FruCfg.CatchTwoDownFall, M.SelfPos) then\n            if divType == 1 then\n                posZ = 95\n                if table.contains(M.Config.FruCfg.CatchTwoDown, M.SelfPos) then\n                    M.Info(\"补位去上。\", true)\n                end\n            elseif divType == 2 then\n                posZ = 105\n                if table.contains(M.Config.FruCfg.CatchTwoUp, M.SelfPos) then\n                    M.Info(\"补位去下。\", true)\n                end\n            end\n        else\n            if table.contains(M.Config.FruCfg.CatchTwoUp, M.SelfPos) then\n                posZ = 95\n            else\n                posZ = 105\n            end\n        end\n    end\nend\nif posX ~= nil and posZ ~= nil then\n    M.DirectTo(posX, posZ, 15000)\n    data.MuAiGd_P1_TwoGroupKnockPos = {}\n    if posX < 100 then\n        data.MuAiGd_P1_TwoGroupKnockPos.x = 99\n    else\n        data.MuAiGd_P1_TwoGroupKnockPos.x = 101\n    end\n    data.MuAiGd_P1_TwoGroupKnockPos.z = posZ\nend\n\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "0a255b62-7c0a-f9c5-9002-c75f944a5e7f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 66.2,
				name = "[MuAiGuide]分组指路",
				timeRange = true,
				timelineIndex = 18,
				timerEndOffset = 5,
				timerOffset = 0.5,
				uuid = "a491ddf8-c8d6-046b-9ab0-55375ad89787",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[19] = 
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
							actionLua = "if data.MuAiGd_P1_TwoGroupKnockPos ~= nil then\n    MuAiGuide.DirectTo(data.MuAiGd_P1_TwoGroupKnockPos.x, data.MuAiGd_P1_TwoGroupKnockPos.z, 3000)\nend\nself.used = true\n\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "0d853992-b71a-10db-a09b-e6b094bf7e2b",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 72.5,
				name = "[MuAiGuide]击退",
				timelineIndex = 19,
				timerOffset = -1.5,
				uuid = "e6d74ec9-2d16-a8af-b163-e982f266c3dd",
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
							actionLua = "if data.MuAiGd_P1_TwoGroupKnockPos ~= nil then\n\tlocal x \n\tif data.MuAiGd_P1_TwoGroupKnockPos.x > 100 then\n\t\tx = data.MuAiGd_P1_TwoGroupKnockPos.x + 3\n\telse\n\t\tx = data.MuAiGd_P1_TwoGroupKnockPos.x - 3\n\tend\n\tlocal z = data.MuAiGd_P1_TwoGroupKnockPos.z\n    MuAiGuide.DirectTo(x, z, 5000)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "9a703050-ea65-9409-baef-1b568dc44a7f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 72.5,
				name = "[MuAiGuide]击退后",
				timelineIndex = 19,
				timerOffset = 1,
				uuid = "329ed40b-965d-e519-8bb3-c08b0c816f8e",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[23] = 
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
							actionLua = "if data.MuAiGd_P1_FallOfFaithPosInfo == nil then\n    data.MuAiGd_P1_FallOfFaithPosInfo = {\n        UpLeft = { h = math.pi * 9 / 8, length = 5.65 },\n        UpRight = { h = math.pi * 7 / 8, length = 5.65 },\n        DownLeft = { h = math.pi * 15 / 8, length = 5.65 },\n        DownRight = { h = math.pi * 1 / 8, length = 5.65 },\n        UpOut = { h = math.pi, length = 6.5 },\n        UpIn = { h = math.pi, length = 5 },\n        DownOut = { h = 0, length = 6.5 },\n        DownIn = { h = 0, length = 5 },\n        -- 闲人固定使用\n        FireUp = { h = math.pi * 7 / 8 - math.pi / 36, length = 5.7 },\n        FireDown = { h = math.pi * 15 / 8 - math.pi / 36, length = 5.7 },\n    }\n    data.MuAiGd_GetFallOfFaithPos = function(posName)\n        local info = data.MuAiGd_P1_FallOfFaithPosInfo[posName]\n        local endHeading = info.h\n        if MuAiGuide.Config.FruCfg.FruLightFireDir == 1 then\n            endHeading = info.h\n        else\n            endHeading = info.h + math.pi / 2\n        end\n        return TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, endHeading, info.length)\n    end\n\n    data.MuAiGd_P1_RestPosConfig = {}\n    for i = 1, #MuAiGuide.Config.FruCfg.FruLightFireRestPos do\n        table.insert(data.MuAiGd_P1_RestPosConfig, tonumber(MuAiGuide.Config.FruCfg.FruLightFireRestPos[i]))\n    end\n\n    ---@param index number 当前自己是几\n    data.MuAiGd_P1_RestPosChange = function(index)\n        local directions = {\n            { \"UpLeft\", \"UpRight\", \"DownLeft\", \"DownRight\" },\n            { \"UpRight\", \"UpLeft\", \"DownRight\", \"DownLeft\" },\n        }\n        -- 顺序：左上、右上、左下、右下\n        local newIdx = MuAiGuide.IndexOf(data.MuAiGd_P1_RestPosConfig, index)\n        if MuAiGuide.Config.FruCfg.FruLightFireDir == 1 then\n            return directions[1][newIdx]\n        else\n            return directions[2][newIdx]\n        end\n    end\n\n    data.MuAiGd_P1_FallOfFaith = {\n        Record = {},\n        --- 点名人的ID\n        LinkedJob = {},\n        --- 1 点名， 0闲人\n        IsLink = false,\n        SelfIndex = 0\n    }\nend\nlocal M = MuAiGuide\nif table.size(data.MuAiGd_P1_FallOfFaith.LinkedJob) < 4 then\n    for jobPos, ent in pairs(M.Party) do\n        local tethers = Argus.getTethersOnEnt(ent.id)\n        if tethers ~= nil and not table.contains(data.MuAiGd_P1_FallOfFaith.LinkedJob, jobPos) then\n            for _, tether in pairs(tethers) do\n                if tether.type == 31 or tether.type == 249 then\n                    local tetherName\n                    if tether.type == 31 then\n                        tetherName = \"雷\"\n                    else\n                        tetherName = \"火\"\n                    end\n                    local curRecord = {\n                        player = ent,\n                        JobPos = jobPos,\n                        tetherType = tether.type,\n                        tetherName = tetherName,\n                        orderIndex = table.size(data.MuAiGd_P1_FallOfFaith.LinkedJob) + 1\n                    }\n                    table.insert(data.MuAiGd_P1_FallOfFaith.Record, curRecord)\n                    table.insert(data.MuAiGd_P1_FallOfFaith.LinkedJob, jobPos)\n                    if M.IsMe(ent) then\n                        data.MuAiGd_P1_FallOfFaith.IsLink = true\n                        data.MuAiGd_P1_FallOfFaith.SelfIndex = curRecord.orderIndex\n                        M.Info(curRecord.orderIndex ..\n                            \"线点名\" .. curRecord.JobPos .. \"类型：\" .. curRecord.tetherName .. \"。<se.1>\")\n                        local posIndex\n                        -- 上下互换法\n                        if M.Config.FruCfg.FruLightFireType == 1 then\n                            if curRecord.orderIndex == 1 then\n                                posIndex = \"UpIn\"\n                            elseif curRecord.orderIndex == 2 then\n                                posIndex = \"DownIn\"\n                            elseif curRecord.orderIndex == 3 then\n                                posIndex = \"UpOut\"\n                            elseif curRecord.orderIndex == 4 then\n                                posIndex = \"DownOut\"\n                            end\n                        else\n                            -- 闲人固定法\n                            if tether.type == 31 then -- 雷\n                                if curRecord.orderIndex == 1 then\n                                    posIndex = \"UpIn\"\n                                elseif curRecord.orderIndex == 2 then\n                                    posIndex = \"DownIn\"\n                                elseif curRecord.orderIndex == 3 then\n                                    if data.MuAiGd_P1_FallOfFaith.Record[1].tetherType == 31 then\n                                        posIndex = \"UpRight\"\n                                    else\n                                        posIndex = \"UpIn\"\n                                    end\n                                elseif curRecord.orderIndex == 4 then\n                                    if data.MuAiGd_P1_FallOfFaith.Record[2].tetherType == 31 then\n                                        posIndex = \"DownLeft\"\n                                    else\n                                        posIndex = \"DownIn\"\n                                    end\n                                end\n                            else\n                                if curRecord.orderIndex == 1 then\n                                    posIndex = \"FireUp\"\n                                elseif curRecord.orderIndex == 2 then\n                                    posIndex = \"FireDown\"\n                                elseif curRecord.orderIndex == 3 then\n                                    posIndex = \"UpIn\"\n                                elseif curRecord.orderIndex == 4 then\n                                    posIndex = \"DownIn\"\n                                end\n                            end\n                        end\n                        local pos = data.MuAiGd_GetFallOfFaithPos(posIndex)\n                        M.DirectTo(pos.x, pos.z, 15000, 0.3)\n                    else\n                        M.Info(curRecord.orderIndex .. \"线点名\" .. curRecord.JobPos .. \"类型：\" .. curRecord.tetherName .. \"。\")\n                    end\n                    break\n                end\n            end\n        end\n    end\n    if table.size(data.MuAiGd_P1_FallOfFaith.LinkedJob) >= 4 then\n        local record = data.MuAiGd_P1_FallOfFaith.Record\n        M.Info(\"上\" .. record[1].tetherName .. \"\" .. record[3].tetherName .. \", \" .. \"下\" .. record[2].tetherName .. record[4].tetherName, true)\n        if data.MuAiGd_P1_FallOfFaith.IsLink == true then\n            self.used = true\n        else\n            local cnt = 0\n            local order = M.Config.FruCfg.FruLightFirePriority\n            for i = 1, table.size(order) do\n                local curJob = order[i]\n                if not table.contains(data.MuAiGd_P1_FallOfFaith.LinkedJob, curJob) then\n                    cnt = cnt + 1\n                    if M.SelfPos == curJob then\n                        data.MuAiGd_P1_FallOfFaith.SelfIndex = cnt\n                        M.Info(\"闲人:\" .. cnt .. \"。\", true)\n                        local posIdx\n                        if M.Config.FruCfg.FruLightFireType == 1 then\n                            if cnt == 1 then\n                                if record[1].tetherType == 31 then\n                                    posIdx = \"UpRight\"\n                                elseif record[1].tetherType == 249 then\n                                    posIdx = \"UpOut\"\n                                end\n                            elseif cnt == 2 then\n                                if record[1].tetherType == 31 then\n                                    posIdx = \"UpLeft\"\n                                elseif record[1].tetherType == 249 then\n                                    posIdx = \"UpOut\"\n                                end\n                            elseif cnt == 3 then\n                                if record[2].tetherType == 31 then\n                                    posIdx = data.MuAiGd_P1_RestPosChange(cnt)\n                                elseif record[2].tetherType == 249 then\n                                    posIdx = \"DownOut\"\n                                end\n                            elseif cnt == 4 then\n                                if record[2].tetherType == 31 then\n                                    posIdx = data.MuAiGd_P1_RestPosChange(cnt)\n                                elseif record[2].tetherType == 249 then\n                                    posIdx = \"DownOut\"\n                                end\n                            end\n                        else\n                            if cnt == 1 then\n                                posIdx = \"UpOut\"\n                            elseif cnt == 2 then\n                                posIdx = \"UpLeft\"\n                            elseif cnt == 3 then\n                                posIdx = \"DownOut\"\n                            elseif cnt == 4 then\n                                posIdx = \"DownRight\"\n                            end\n                        end\n                        local pos = data.MuAiGd_GetFallOfFaithPos(posIdx)\n                        M.DirectTo(pos.x, pos.z, 15000, 0.3)\n                        break\n                    end\n                end\n            end\n        end\n        self.used = true\n    end\nend\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "雷火线",
							uuid = "cb4d3186-1db3-26fc-a335-6849aabc5b14",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 3,
				mechanicTime = 101.5,
				name = "[MuAiGuide]雷火线指路",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 5,
				timerStartOffset = -10,
				uuid = "d48a1e68-63d9-e8e5-9330-3723784ecf94",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[25] = 
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
							actionLua = "local record1 = data.MuAiGd_P1_FallOfFaith.Record[1]\nlocal record3 = data.MuAiGd_P1_FallOfFaith.Record[3]\nlocal posIdx  = nil\n\nif record1.JobPos == MuAiGuide.SelfPos then\n    if MuAiGuide.Config.FruCfg.FruLightFireType == 1 then\n        posIdx = \"UpOut\"\n    else\n        if record1.tetherType == record3.tetherType then\n            posIdx = \"UpIn\"\n        end\n    end\nelse\n    if record3.JobPos == MuAiGuide.SelfPos then -- 3号点名是自己\n        if MuAiGuide.Config.FruCfg.FruLightFireType == 1 then\n            posIdx = \"UpIn\"\n        else\n            if record1.tetherType == record3.tetherType then\n                posIdx = \"UpIn\"\n            end\n        end\n    else\n        if data.MuAiGd_P1_FallOfFaith.IsLink == false and data.MuAiGd_P1_FallOfFaith.SelfIndex <= 2 then\n            if MuAiGuide.Config.FruCfg.FruLightFireType == 1 then\n                if record3.tetherType == 31 then\n                    MuAiGuide.Info(\"引导3雷点名。\")\n                    posIdx = data.MuAiGd_P1_RestPosChange(data.MuAiGd_P1_FallOfFaith.SelfIndex)\n                else\n                    MuAiGuide.Info(\"引导3火点名。\")\n                    posIdx = \"UpOut\"\n                end\n            end\n        end\n    end\nend\nif posIdx ~= nil then\n    local pos = data.MuAiGd_GetFallOfFaithPos(posIdx)\n    MuAiGuide.DirectTo(pos.x, pos.z, 7000, 0.3)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "1线判定时",
							uuid = "7885b479-a64c-7b9f-addb-4a7a79be5e38",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 105.8,
				name = "[MuAiGuide]1线判定时",
				timelineIndex = 25,
				uuid = "2d31e61e-ca1c-6097-a383-70cab9728294",
				version = 2,
			},
		},
	},
	[26] = 
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
							actionLua = "local record2 = data.MuAiGd_P1_FallOfFaith.Record[2]\nlocal record4 = data.MuAiGd_P1_FallOfFaith.Record[4]\nlocal posIdx  = nil\n\nif record2.JobPos == MuAiGuide.SelfPos then\n    if MuAiGuide.Config.FruCfg.FruLightFireType == 1 then\n        posIdx = \"DownOut\"\n    else\n        if record2.tetherType == record4.tetherType then\n            posIdx = \"DownIn\"\n        end\n    end\nelse\n    if record4.JobPos == MuAiGuide.SelfPos then -- 4号点名是自己\n        if MuAiGuide.Config.FruCfg.FruLightFireType == 1 then\n            posIdx = \"DownIn\"\n        else\n            if record2.tetherType == record4.tetherType then\n                posIdx = \"DownIn\"\n            end\n        end\n    else\n        if data.MuAiGd_P1_FallOfFaith.IsLink == false and data.MuAiGd_P1_FallOfFaith.SelfIndex > 2 then\n            if MuAiGuide.Config.FruCfg.FruLightFireType == 1 then\n                if record4.tetherType == 31 then\n                    MuAiGuide.Info(\"引导4雷点名。\")\n                    posIdx = data.MuAiGd_P1_RestPosChange(data.MuAiGd_P1_FallOfFaith.SelfIndex)\n                else\n                    MuAiGuide.Info(\"引导4火点名。\")\n                    posIdx = \"DownOut\"\n                end\n            end\n        end\n    end\nend\nif posIdx ~= nil then\n    local pos = data.MuAiGd_GetFallOfFaithPos(posIdx)\n    MuAiGuide.DirectTo(pos.x, pos.z, 7000, 0.3)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "2线判定时",
							uuid = "87225787-2685-738a-a067-607ec657a3d7",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 108.6,
				name = "[MuAiGuide]2线判定时",
				timelineIndex = 26,
				uuid = "f2a3e696-aede-3c36-b3c3-8932a1db033e",
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
							actionLua = "for i = 1,14 do\n    SendTextCommand(\"/mk clear <\"..i..\">\")\nend\nself.used = true",
							gVar = "ACR_TensorMagnum3_CD",
							uuid = "bc049a79-aeee-2d74-a908-f9b3b91c3912",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 121.1,
				name = "清标点",
				timelineIndex = 29,
				uuid = "2d86a6b7-2b1e-8f4b-a89b-06feb22a6600",
				version = 2,
			},
		},
	},
	[32] = 
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
							actionLua = "local one = { 40131, 40135 }\nlocal two = { 40122, 40125 }\nlocal three = { 40123, 40126 }\nlocal four = { 40124, 40127 }\n\nif data.MuAiGd_P1_Towers == nil then\n    data.MuAiGd_P1_Towers = {}\nend\n\nif table.contains(one, eventArgs.spellID) then\n    local ent = TensorCore.mGetEntity(eventArgs.entityID)\n    table.insert(data.MuAiGd_P1_Towers, { entity = ent, need = 1 })\nelseif table.contains(two, eventArgs.spellID) then\n    local ent = TensorCore.mGetEntity(eventArgs.entityID)\n    table.insert(data.MuAiGd_P1_Towers, { entity = ent, need = 2 })\nelseif table.contains(three, eventArgs.spellID) then\n    local ent = TensorCore.mGetEntity(eventArgs.entityID)\n    table.insert(data.MuAiGd_P1_Towers, { entity = ent, need = 3 })\nelseif table.contains(four, eventArgs.spellID) then\n    local ent = TensorCore.mGetEntity(eventArgs.entityID)\n    table.insert(data.MuAiGd_P1_Towers, { entity = ent, need = 4 })\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"efe1e409-1d08-9ae8-8701-bbc0288e0a9f",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "54a27c0c-6796-08ef-91e8-238265170ca9",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "塔读条ID",
							spellIDList = 
							{
								40122,
								40123,
								40124,
								40125,
								40126,
								40127,
								40131,
								40135,
							},
							uuid = "efe1e409-1d08-9ae8-8701-bbc0288e0a9f",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 140.9,
				name = "[MuAiGuide]塔数据采集",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = -2,
				timerStartOffset = -10,
				uuid = "6f235a4a-a910-3ae1-a40d-e69d2bf4bf23",
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
							actionLua = "data.MuAiGd_P1_TowerCastingType = eventArgs.spellID\nself.used = true\n",
							conditions = 
							{
								
								{
									"de1aaff4-b6a9-a121-8871-069f75bccd9c",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "0700d340-a1b3-02fd-ba00-077aae5e464c",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							spellIDList = 
							{
								40129,
								40133,
							},
							uuid = "de1aaff4-b6a9-a121-8871-069f75bccd9c",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 140.9,
				name = "[MuAiGuide]读条采集",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = -2,
				timerStartOffset = -10,
				uuid = "fc962f58-cd80-e8c5-93a6-b4c81ee10b57",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "local M = MuAiGuide\nif M.SelfPos ~= \"MT\" and M.SelfPos ~= \"ST\" then\n    local towers = table.deepcopy(data.MuAiGd_P1_Towers)\n    table.sort(towers, function(a, b)\n        return a.entity.pos.z < b.entity.pos.z\n    end)\n    local infoPos = function(index)\n        if index == 1 then\n            return \"上\"\n        elseif index == 2 then\n            return \"中\"\n        elseif index == 3 then\n            return \"下\"\n        end\n        return \"\"\n    end\n    local towerIdx\n    -- 小学塔\n    if M.Config.FruCfg.TakeTowerType == 1 then\n        local selfIndex = M.IndexOf(M.Config.FruCfg.FallTowerOrder, M.SelfPos)\n        if selfIndex <= towers[1].need then\n            towerIdx = 1\n        elseif towers[1].need < selfIndex and selfIndex <= towers[1].need + towers[2].need then\n            towerIdx = 2\n        elseif towers[1].need + towers[2].need < selfIndex and selfIndex <= 6 then\n            towerIdx = 3\n        end\n        M.Info(\"填充踩塔，去\" .. infoPos(towerIdx) .. \"塔\", true)\n    elseif M.Config.FruCfg.TakeTowerType == 2 then\n        if table.contains(M.Config.FruCfg.FixTowerUp, M.SelfPos) then\n            if M.Config.FruCfg.FixTowerUp[1] == M.SelfPos or towers[1].need >= 2 then\n                towerIdx = 1\n            else\n                if towers[2].need > 2 then\n                    towerIdx = 2\n                else\n                    towerIdx = 3\n                end\n            end\n        elseif table.contains(M.Config.FruCfg.FixTowerMid, M.SelfPos) then\n            if M.Config.FruCfg.FixTowerMid[1] == M.SelfPos or towers[2].need >= 2 then\n                towerIdx = 2\n            else\n                if towers[1].need > 2 then\n                    towerIdx = 1\n                else\n                    towerIdx = 3\n                end\n            end\n        elseif table.contains(M.Config.FruCfg.FixTowerDown, M.SelfPos) then\n            if M.Config.FruCfg.FixTowerDown[1] == M.SelfPos or towers[3].need >= 2 then\n                towerIdx = 3\n            else\n                if towers[1].need > 2 then\n                    towerIdx = 1\n                else\n                    towerIdx = 2\n                end\n            end\n        end\n        M.Info(\"固定踩塔，去\" .. infoPos(towerIdx) .. \"塔\", true)\n    elseif M.Config.FruCfg.TakeTowerType == 3 then\n        if table.contains(M.Config.FruCfg.JapanTowerFix, M.SelfPos) then\n            towerIdx = M.IndexOf(M.Config.FruCfg.JapanTowerFix, M.SelfPos)\n        else\n            local selfIndex = M.IndexOf(M.Config.FruCfg.JapanTowerFall, M.SelfPos)\n            if selfIndex <= towers[1].need - 1 then\n                towerIdx = 1\n            elseif towers[1].need - 1 < selfIndex and selfIndex <= towers[1].need + towers[2].need - 2 then\n                towerIdx = 2\n            elseif towers[1].need + towers[2].need - 2 < selfIndex and selfIndex <= 3 then\n                towerIdx = 3\n            end\n        end\n        M.Info(\"日基踩塔，去\" .. infoPos(towerIdx) .. \"塔\", true)\n    end\n\n    local towerPos = towers[towerIdx].entity.pos\n    data.MuAiGd_P1_SelfTowerInfo = { Index = towerIdx, Pos = towerPos }\n    if data.MuAiGd_P1_TowerCastingType == 40129 then\n        local posX, posZ\n        if towerPos.x > 100 then\n            posX = 106\n        else\n            posX = 94\n        end\n        if towerIdx == 1 then\n            posZ = 94\n        elseif towerIdx == 2 then\n            posZ = 100\n        elseif towerIdx == 3 then\n            posZ = 106\n        end\n        M.DirectTo(posX, posZ, 6000)\n    elseif data.MuAiGd_P1_TowerCastingType == 40133 then\n        M.DirectTo(towerPos.x, towerPos.z, 10000)\n    end\nelse\n    local posX, posZ\n    if M.SelfPos == \"MT\" then\n        posZ = 94\n    else\n        posZ = 106\n    end\n    if data.MuAiGd_P1_Towers[1].entity.pos.x > 100 then\n        data.MuAiGd_P1_TowerIsLeft = false\n        if data.MuAiGd_P1_TowerCastingType == 40129 then\n            posX = 94\n        elseif data.MuAiGd_P1_TowerCastingType == 40133 then\n            posX = 85\n        end\n    else\n        data.MuAiGd_P1_TowerIsLeft = true\n        if data.MuAiGd_P1_TowerCastingType == 40129 then\n            posX = 106\n        elseif data.MuAiGd_P1_TowerCastingType == 40133 then\n            posX = 115\n        end\n    end\n    M.DirectTo(posX, posZ, 10000)\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"580974dc-f238-142e-8c97-10454362f8c5",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "c5bdcc5c-2318-a466-9a53-e311565dd1a5",
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
							conditionLua = "return data.MuAiGd_P1_TowerCastingType ~= nil\nand  data.MuAiGd_P1_Towers ~= nil and table.size(data.MuAiGd_P1_Towers) >= 3",
							name = "获取到读条和塔信息",
							uuid = "580974dc-f238-142e-8c97-10454362f8c5",
							version = 2,
						},
					},
				},
				mechanicTime = 140.9,
				name = "[MuAiGuide]踩塔指路",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "d313db81-8d8e-da94-8c73-d3d01aebbffc",
				version = 2,
			},
			inheritedIndex = 3,
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
							actionLua = "if MuAiGuide.SelfPos ~= \"MT\" and MuAiGuide.SelfPos ~= \"ST\" then\n    if data.MuAiGd_P1_TowerCastingType == 40129 then\n        local posX, posZ\n        if data.MuAiGd_P1_SelfTowerInfo.Pos.x > 100 then\n            posX = 101\n        else\n            posX = 99\n        end\n        if data.MuAiGd_P1_SelfTowerInfo.Index == 1 then\n            posZ = 94\n        elseif data.MuAiGd_P1_SelfTowerInfo.Index == 2 then\n            posZ = 100\n        elseif data.MuAiGd_P1_SelfTowerInfo.Index == 3 then\n            posZ = 106\n        end\n        MuAiGuide.DirectTo(posX, posZ, 4000)\n    end\nelse\n    local posX, posZ\n    if data.MuAiGd_P1_TowerIsLeft == true then\n        posX = 101\n    else\n        posX = 99\n    end\n    if MuAiGuide.SelfPos == \"MT\" then\n        posZ = 94\n    else\n        posZ = 106\n    end\n    MuAiGuide.DirectTo(posX, posZ, 2500)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "56b76848-40a6-9c88-a384-92eb80bf56e2",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 140.9,
				name = "[MuAiGuide]火靠近",
				timelineIndex = 32,
				uuid = "bed0da6f-ee8d-e3df-8bbd-7d36f25ae95b",
				version = 2,
			},
			inheritedIndex = 8,
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
							actionLua = "if MuAiGuide.SelfPos ~= \"MT\" and MuAiGuide.SelfPos ~= \"ST\" and data.MuAiGd_P1_TowerCastingType == 40129 then\n    local towerPos = data.MuAiGd_P1_SelfTowerInfo.Pos\n    MuAiGuide.DirectTo(towerPos.x, towerPos.z, 2100)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "11df3678-7386-177e-aba4-19239e145091",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 142.9,
				name = "[MuAiGuide]指塔",
				timelineIndex = 33,
				uuid = "43c5dedd-ee48-577f-babb-f51c170e21d3",
				version = 2,
			},
		},
	},
	[44] = 
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
							actionLua = "--[[\n[MuAiGuide]DD冰花位置收集\n]]\nif data.MuAiGd_DiamondDustStartPoint == nil then\n    data.MuAiGd_DiamondDustStartPoint = {}\n    data.MuAiGd_DiamondDustNeedExChange = false\n    MuAiGuide.Debug(\"===================== DD冰花位置收集 =====================\")\nend\n\nif table.size(data.MuAiGd_DiamondDustStartPoint) < 2 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=12809\")) do\n        local record = MuAiGuide.GetDirectionIndex({ x = 100, y = 0, z = 100 }, ent.pos)\n        if not table.contains(data.MuAiGd_DiamondDustStartPoint, record) and Argus.getEntityModel(ent.id) == 9020 then\n            table.insert(data.MuAiGd_DiamondDustStartPoint, record)\n            MuAiGuide.Debug(\"采集到冰花位置：\" .. record)\n        end\n    end\n    if table.size(data.MuAiGd_DiamondDustStartPoint) == 2 then\n        MuAiGuide.Debug(\"===================== DD冰花位置完毕 =====================\")\n        self.used = true\n    end\nend\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "DD冰花位置收集",
							uuid = "85ace7ef-3075-d8bb-bfda-911ecc57b160",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 3,
				loop = true,
				mechanicTime = 235.3,
				name = "[MuAiGuide]DD冰花位置收集",
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = 10,
				uuid = "587987fc-c74a-cfc8-b342-8ee518cdba34",
				version = 2,
			},
			inheritedIndex = 1,
		},
	},
	[46] = 
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_DiamondDustTarget == nil then\n    M.Debug(\"===================== DD冰花位置收集 && DD 指路1 =====================\")\n    data.MuAiGd_DiamondDustTarget = {}\n    data.MuAiGd_DiamondDustSelfGuideDir = 0\n    ---  DD中的1情况  1： 钢铁冰花，2：钢铁水波，3：月环冰花，4：月环水波\n    data.MuAiGd_DiamondDustSelfGuideType = 0\nend\n\n\nif table.size(data.MuAiGd_DiamondDustTarget) < 4 then\n    for jobPos, player in pairs(M.Party) do\n        if player.id == eventArgs.entityID then\n            table.insert(data.MuAiGd_DiamondDustTarget, M.IndexOf(MuAiGuide.Config.FruCfg.JobPos, jobPos))\n            break\n        end\n    end\n    if table.size(data.MuAiGd_DiamondDustTarget) == 4 then\n        -- 如果点名人的站位序列和初次出现的2个冰花存在重合, 则需要换位\n        for i = 1, #data.MuAiGd_DiamondDustTarget do\n            for j = 1, #data.MuAiGd_DiamondDustStartPoint do\n                if data.MuAiGd_DiamondDustStartPoint[j] == data.MuAiGd_DiamondDustTarget[i] then\n                    data.MuAiGd_DiamondDustNeedExChange = true\n                    M.Info(\"冰花方向重合，需要换位。\", true)\n                    break\n                end\n            end\n            if data.MuAiGd_DiamondDustNeedExChange then\n                break\n            end\n        end\n\n        -- 计算指路方位\n        local selfBaseDir = M.IndexOf(MuAiGuide.Config.FruCfg.JobPos, M.SelfPos)\n        if data.MuAiGd_DiamondDustNeedExChange then\n            if MuAiGuide.Config.FruCfg.DDChangeType == 1 then\n                if M.IsDps(M.GetPlayer().job) then\n                    data.MuAiGd_DiamondDustSelfGuideDir = selfBaseDir - 1\n                else\n                    data.MuAiGd_DiamondDustSelfGuideDir = selfBaseDir + 1\n                end\n            else\n                data.MuAiGd_DiamondDustSelfGuideDir = selfBaseDir - 1\n            end\n            if data.MuAiGd_DiamondDustSelfGuideDir > 8 then\n                data.MuAiGd_DiamondDustSelfGuideDir = data.MuAiGd_DiamondDustSelfGuideDir - 8\n            elseif data.MuAiGd_DiamondDustSelfGuideDir < 0 then\n                data.MuAiGd_DiamondDustSelfGuideDir = data.MuAiGd_DiamondDustSelfGuideDir + 8\n            end\n        else\n            data.MuAiGd_DiamondDustSelfGuideDir = selfBaseDir\n        end\n\n        -- 指路时间\n        -- 钢铁时间\n        local timeAimFar = 7000  -- 冰花人： 直接指过去，呆着\n        local timeFar = 5000     -- 无冰花人： 指过去，等钢/月判定后立刻回中，当前脚本仅指路第一阶段\n        -- 月环时间\n        local timeAimNear = 5000 -- 冰花人 指路到 钢/月判定\n        local timeNear = 5000    -- 没冰花人，呆着\n\n        local guideTime\n        local guideDistance\n        if TensorCore.isAnyEntityCasting(40203) then\n            data.MuAiGd_DiamondDustStandType = 1 --月环\n            -- 冰花点名\n            if table.contains(data.MuAiGd_DiamondDustTarget, selfBaseDir) then\n                guideTime = timeAimNear\n                guideDistance = 3.7\n                data.MuAiGd_DiamondDustSelfGuideType = 3 --月环冰花\n            else\n                guideTime = timeNear\n                guideDistance = 1.5\n                data.MuAiGd_DiamondDustSelfGuideType = 4 --月环水波\n            end\n        elseif TensorCore.isAnyEntityCasting(40202) then\n            data.MuAiGd_DiamondDustStandType = 2 --钢铁\n            -- 冰花点名\n            if table.contains(data.MuAiGd_DiamondDustTarget, selfBaseDir) then\n                guideTime = timeAimFar\n                guideDistance = 19.7\n                data.MuAiGd_DiamondDustSelfGuideType = 1 --钢铁冰花\n            else\n                guideTime = timeFar\n                guideDistance = 16.5\n                data.MuAiGd_DiamondDustSelfGuideType = 2 --钢铁水波\n            end\n        end\n\n        local guidePos = TensorCore.getPosInDirection(\n                { x = 100, y = 0, z = 100 },\n                (data.MuAiGd_DiamondDustSelfGuideDir - 1) * math.pi / 4,\n                guideDistance)\n        M.DirectTo(guidePos.x, guidePos.z, guideTime, 0.3)\n        M.Debug(\"===================== DD冰花位置收集 && DD 指路1 结束 =====================\")\n        self.used = true\n    end\nend\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "DD冰花点名出现",
							uuid = "46ad7d13-8ea9-7dc2-9961-c4c02b5e49c6",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							eventArgType = 2,
							eventMarkerID = 345,
							uuid = "fdc8e6c3-5795-8e23-b268-c66c76d51218",
							version = 2,
						},
					},
				},
				eventType = 4,
				mechanicTime = 244.5,
				name = "[MuAiGuide]DD冰花点名出现",
				timeRange = true,
				timelineIndex = 46,
				timerEndOffset = 1,
				timerStartOffset = -10,
				uuid = "9ad98f8f-bf9d-e4ea-91d0-2394f92a6cd1",
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
							actionLua = "-- 钢铁月环判定瞬间\n-- 指路到场中，然后再指路到击退位置\nlocal selfDir = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.JobPos, MuAiGuide.SelfPos)\nlocal selfSafe\nif MuAiGuide.Config.FruCfg.DDGroupType == 1 then\n    for i = 1, #data.MuAiGd_DiamondDustStartPoint do\n        if (selfDir <= 4 and data.MuAiGd_DiamondDustStartPoint[i] <= 4) or\n            (selfDir >= 5 and data.MuAiGd_DiamondDustStartPoint[i] >= 5)\n        then\n            selfSafe = data.MuAiGd_DiamondDustStartPoint[i]\n            break\n        end\n    end\nelse\n    for i = 1, #data.MuAiGd_DiamondDustStartPoint do\n        if selfDir <= 4 then --ST组\n            if data.MuAiGd_DiamondDustStartPoint[i] == 8 or data.MuAiGd_DiamondDustStartPoint[i] <= 3 then\n                selfSafe = data.MuAiGd_DiamondDustStartPoint[i]\n                break\n            end\n        else\n            if 4 <= data.MuAiGd_DiamondDustStartPoint[i] and data.MuAiGd_DiamondDustStartPoint[i] <= 7 then\n                selfSafe = data.MuAiGd_DiamondDustStartPoint[i]\n                break\n            end\n        end\n    end\nend\n\n-- 击退站位点\ndata.MuAiGd_DiamondDustKnockBackPos = TensorCore.getPosInDirection(\n    { x = 100, y = 0, z = 100 },\n    (selfSafe - 1) * math.pi / 4,\n    2)\n\n-- 1： 钢铁冰花，2：钢铁水波，3：月环冰花，4：月环水波\n--[[if data.MuAiGd_DiamondDustSelfGuideType == 1 then\n    -- 不动\nelse]]\nif data.MuAiGd_DiamondDustSelfGuideType == 2 then\n    -- 立刻回中 大约2500后前往击退位置\n    MuAiGuide.DirectTo(100, 100, 2500)\n    MuAiGuide.DirectTo(data.MuAiGd_DiamondDustKnockBackPos.x, data.MuAiGd_DiamondDustKnockBackPos.z, 2500, 0.5, 4000)\nelseif data.MuAiGd_DiamondDustSelfGuideType == 3 then\n    -- 立刻放冰花\n    local heading = (data.MuAiGd_DiamondDustSelfGuideDir - 1) * math.pi / 4\n    local placePos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\n    MuAiGuide.DirectTo(placePos.x, placePos.z, 2500)\nelseif data.MuAiGd_DiamondDustSelfGuideType == 4 then\n    -- 指路到击退位置\n    MuAiGuide.DirectTo(data.MuAiGd_DiamondDustKnockBackPos.x, data.MuAiGd_DiamondDustKnockBackPos.z, 4000, 0.5, 2500)\nend\n\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "钢铁月环判定",
							uuid = "517c22b7-5ed6-68ed-8b9a-a4b3094ec9e8",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 244.5,
				name = "[MuAiGuide]钢铁月环判定",
				timelineIndex = 46,
				timerOffset = -0.20000000298023,
				uuid = "4bc492bd-4296-ab6d-92f7-5544ae806ce4",
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
							actionLua = "-- 1： 钢铁冰花，2：钢铁水波，3：月环冰花，4：月环水波\nif data.MuAiGd_DiamondDustSelfGuideType == 1 then\n    -- 立刻回中 大约2500后前往击退位置\n    MuAiGuide.DirectTo(100, 100, 2500)\n    MuAiGuide.DirectTo(data.MuAiGd_DiamondDustKnockBackPos.x, data.MuAiGd_DiamondDustKnockBackPos.z, 2500, 0.5, 2500)\nelseif data.MuAiGd_DiamondDustSelfGuideType == 2 then\n    -- 不管\nelseif data.MuAiGd_DiamondDustSelfGuideType == 3 then\n    -- 场中指路1秒 后 指路到击退位置\n    MuAiGuide.DirectTo(100, 100, 1000)\n    MuAiGuide.DirectTo(data.MuAiGd_DiamondDustKnockBackPos.x, data.MuAiGd_DiamondDustKnockBackPos.z, 2500, 0.5, 1000)\nelseif data.MuAiGd_DiamondDustSelfGuideType == 4 then\n    -- 不管\nend\n\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "冰花判定",
							uuid = "69b5a33f-1c45-10cd-8690-7e3a3b3525ad",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 246.7,
				name = "[MuAiGuide]冰花判定",
				timelineIndex = 48,
				uuid = "cf4c653a-84ec-9cfb-a039-eb43c1965127",
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
							actionLua = "local drawTime = 13000\nlocal M = MuAiGuide\nfunction drawArcArrow(startPos, h, timeout)\n    local center = { x = 100, y = 0, z = 100 }\n    -- 圆周半径\n    local r = TensorCore.getDistance2d(center, startPos)\n    local firstH = TensorCore.getHeadingToTarget(center, startPos)\n    local hVale = math.abs(h)\n    local mark\n    if h > 0 then\n        mark = 1\n    else\n        mark = -1\n    end\n    local cnt = math.ceil(hVale / (math.pi / 36)) - 1\n    local rectLength = r * math.sin(math.pi / 72) * 2\n    local lastPos = startPos\n    local curH = firstH + mark * ( math.pi * 19 / 36 - 0.04)\n    local player = TensorCore.mGetPlayer()\n    local posDrawer = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n            (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n            (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n            (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n            10\n    )\n    for i = 1, cnt do\n        posDrawer:addTimedRect(timeout, lastPos.x, player.pos.y, lastPos.z,  rectLength + 0.02, 0.5, curH)\n        local dir = firstH + i * mark * math.pi / 36\n        lastPos = TensorCore.getPosInDirection(center, dir, r)\n        curH = curH + mark * math.pi / 36\n    end\n    local lastH = hVale - cnt * math.pi / 36\n    local lastLength = r * math.sin(lastH / 2) * 2\n    local endH = curH +  mark * lastH / 2\n    posDrawer:addTimedArrow(timeout, lastPos.x, player.pos.y, lastPos.z,  endH, lastLength - 1, 0.5, 1, 1,0)\nend\n\nlocal selfHeading = M.SetHeading2Pi(TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 },\n        data.MuAiGd_DiamondDustKnockBackPos))\nlocal distance = 16.1\nlocal startPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, selfHeading, distance)\nlocal lightBoss\nfor _, ent in pairs(TensorCore.entityList(\"contentid=13554\")) do\n    lightBoss = ent\n    break\nend\n\nlocal OP = { x = startPos.x - 100, z = startPos.z - 100 }\nlocal OB = { x = lightBoss.pos.x - 100, z = lightBoss.pos.z - 100 }\n-- 计算点积和模长，用于计算夹角\nlocal dotProduct = OP.x * OB.x + OP.z * OB.z\nlocal magnitudeOA = math.sqrt(OP.x ^ 2 + OP.z ^ 2)\nlocal magnitudeOB = math.sqrt(OB.x ^ 2 + OB.z ^ 2)\n-- 计算夹角\nlocal theta = math.acos(dotProduct / (magnitudeOA * magnitudeOB))\n-- 使用叉积判断方向\nlocal crossProduct = OP.x * OB.z - OP.z * OB.x\nif crossProduct < 0 then\n    theta = 2 * math.pi - theta\nend\nif M.IsSame(theta, 2 * math.pi) then\n    theta = 0\nend\nlocal wide\nlocal guideHeading\nlocal arrowHeading\nif M.IsSame(math.pi / 4, theta) or M.IsSame(math.pi * 5 / 4, theta) then\n    if M.Config.FruCfg.DDRunType == 1 then\n        M.Info(\"反跑135度！\", true)\n        wide = math.pi * 3 / 4\n        arrowHeading = math.pi * 3 / 4\n    else\n        if M.IsSame(math.pi / 4, theta) then\n            M.Info(\"反跑90度！\", true)\n            wide = math.pi / 2\n            arrowHeading = math.pi  / 2\n        else\n            M.Info(\"正跑90度！\", true)\n            wide = -math.pi / 2\n            arrowHeading = -math.pi / 2\n        end\n    end\n    guideHeading = M.SetHeading2Pi(selfHeading + wide)\nelse\n    clock = 1\n    if M.IsSame(math.pi / 2, theta) or M.IsSame(math.pi * 3 / 2, theta) then\n        M.Info(\"正跑90度！\", true)\n        wide = math.pi / 2\n        arrowHeading = -math.pi / 2\n    elseif M.IsSame(math.pi * 3 / 4, theta) or M.IsSame(math.pi * 7 / 4, theta) then\n        M.Info(\"正跑135度！\", true)\n        wide = math.pi * 3 / 4\n        arrowHeading = -math.pi * 3 / 4\n    elseif M.IsSame(0, theta) or M.IsSame(math.pi, theta) then\n        M.Info(\"正跑180度！\", true)\n        wide = math.pi\n        arrowHeading = -math.pi\n    end\n    guideHeading = selfHeading - wide\nend\nlocal endPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, guideHeading, distance)\nM.DirectTo(endPos.x, endPos.z, drawTime)\nlocal arrowPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, selfHeading, 18)\ndrawArcArrow(arrowPos, arrowHeading, drawTime)\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "80339835-c5e5-2000-be6a-7a3bf542d52d",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 251.1,
				name = "[MuAiGuide]跑圈",
				timelineIndex = 50,
				timerOffset = 1,
				uuid = "ba5a2f21-2839-d605-a4b2-0636a2a4737d",
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
							actionLua = "if MuAiGuide.Config.FruCfg.SkatingHit == 1 then\n\tMuAiGuide.Info(\"滑冰倒计时:3。\" )\n\tTensorCore.addAlertText(0, \"三\", 1, 2, true)\nelseif MuAiGuide.Config.FruCfg.SkatingHit == 2 then\n\tMuAiGuide.Info(\"滑冰倒计时:3。<se.3>\" )\nend\nself.used = true",
							conditions = 
							{
								
								{
									"cae4df73-fb18-225f-8589-b6e884d1bac3",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "358e80c2-70e3-b61c-9af4-08e8665cb7fb",
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
							conditionLua = "return MuAiGuide.Config.FruCfg.SkatingHit > 0",
							name = "开启提示",
							uuid = "cae4df73-fb18-225f-8589-b6e884d1bac3",
							version = 2,
						},
					},
				},
				mechanicTime = 270.3,
				name = "[MuAiGuide]滑冰噪音-倒计时3",
				timelineIndex = 60,
				timerOffset = -3.5,
				uuid = "8da97ce5-8c1d-99a6-b1a6-50dbc5bcf039",
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
							actionLua = "if MuAiGuide.Config.FruCfg.SkatingHit == 1 then\n\tMuAiGuide.Info(\"滑冰倒计时:2。\" )\n\tTensorCore.addAlertText(0, \"二\", 1, 2, true)\nelseif MuAiGuide.Config.FruCfg.SkatingHit == 2 then\n\tMuAiGuide.Info(\"滑冰倒计时:2。<se.3>\" )\nend\nself.used = true",
							conditions = 
							{
								
								{
									"2457176f-0a0f-eeeb-a28c-fe70479f7990",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "bdf29f9f-781e-003b-83b0-a3fc68ffe434",
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
							conditionLua = "return MuAiGuide.Config.FruCfg.SkatingHit > 0",
							name = "开启提示",
							uuid = "2457176f-0a0f-eeeb-a28c-fe70479f7990",
							version = 2,
						},
					},
				},
				mechanicTime = 270.3,
				name = "[MuAiGuide]滑冰噪音-倒计时2",
				timelineIndex = 60,
				timerOffset = -2.5,
				uuid = "b80d439c-28be-d2e2-a6d0-04226badc289",
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
							actionLua = "if MuAiGuide.Config.FruCfg.SkatingHit == 1 then\n\tMuAiGuide.Info(\"滑冰倒计时:1。\" )\n\tTensorCore.addAlertText(0, \"一\", 1, 2, true)\nelseif MuAiGuide.Config.FruCfg.SkatingHit == 2 then\n\tMuAiGuide.Info(\"滑冰倒计时:1。<se.3>\" )\nend\nself.used = true",
							conditions = 
							{
								
								{
									"d40e5773-3218-d8dd-92e4-b514b2d1edbc",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "9d329f56-e896-2fcb-975b-935a259777e2",
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
							conditionLua = "return MuAiGuide.Config.FruCfg.SkatingHit > 0",
							name = "开启提示",
							uuid = "d40e5773-3218-d8dd-92e4-b514b2d1edbc",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 270.3,
				name = "[MuAiGuide]滑冰噪音-倒计时1",
				timelineIndex = 60,
				timerOffset = -1.5,
				uuid = "61873fcf-73ef-d77a-bd87-d48d80fe1921",
				version = 2,
			},
			inheritedIndex = 3,
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
							actionLua = "if MuAiGuide.Config.FruCfg.SkatingHit == 1 then\n\tMuAiGuide.Info(\"滑冰，快走！\" )\n\tTensorCore.addAlertText(0, \"走走走!\", 1, 2, true)\nelseif MuAiGuide.Config.FruCfg.SkatingHit == 2 then\n\tMuAiGuide.Info(\"滑冰，快走！<se.1>\" )\nend\nself.used = true",
							conditions = 
							{
								
								{
									"b53281d1-d9f6-341d-ab24-1e29cd908afb",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2fb75634-ba3b-c72c-bdee-a70deb3508c7",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruCfg.SkatingHit > 0",
							name = "开启提示",
							uuid = "b53281d1-d9f6-341d-ab24-1e29cd908afb",
							version = 2,
						},
					},
				},
				mechanicTime = 270.3,
				name = "[MuAiGuide]滑冰噪音-GOGOGO",
				timelineIndex = 60,
				timerOffset = -0.5,
				uuid = "49faac67-2793-a235-8148-5722cc7c6a9d",
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
							actionLua = "local posDrawer2 = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        nil,\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 0.5)),\n        0.8\n)\n\nposDrawer2:addArrow(Player.pos.x, Player.pos.y, Player.pos.z, Player.camera.h + math.pi, 31, 0.3, 1, 0.3, true)\nself.used = true",
							conditions = 
							{
								
								{
									"235416e3-9403-d65e-afc0-02998fddfef5",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "ca0d0175-c170-e0ab-83d0-1a8d3c002a95",
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
							conditionLua = "return MuAiGuide.Config.AnyOneReactionOn == false",
							name = "检查设置",
							uuid = "235416e3-9403-d65e-afc0-02998fddfef5",
							version = 2,
						},
					},
				},
				eventType = 12,
				mechanicTime = 272.3,
				name = "[MuAiGuide]滑冰瞄准",
				timeRange = true,
				timelineIndex = 61,
				timerOffset = -8,
				timerStartOffset = -8,
				uuid = "1ec79cf5-514d-f465-8d45-a85d9ddb013f",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "local M = MuAiGuide\nlocal guideTime = 10000\nlocal allMirrors = {}\nlocal blueMirror = nil\nfor _, ent in pairs(TensorCore.entityList(\"contentid=9317\")) do\n    if TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, ent.pos) > 15 then\n        table.insert(allMirrors, ent)\n        if blueMirror == nil or ent.id < blueMirror.id then\n            blueMirror = ent\n        end\n    end\nend\n\nlocal redMirror = {}\nfor _, mirror in pairs(allMirrors) do\n    if mirror.id ~= blueMirror.id then\n        table.insert(redMirror, mirror)\n    end\nend\n\nlocal distance1 = TensorCore.getDistance2d(redMirror[1].pos, blueMirror.pos)\nlocal distance2 = TensorCore.getDistance2d(redMirror[2].pos, blueMirror.pos)\nlocal left, right\nif M.GetClock(redMirror[1].pos, redMirror[2].pos) then\n    left  = redMirror[1]\n    right = redMirror[2]\nelse\n    left  = redMirror[2]\n    right = redMirror[1]\nend\n\nif M.IsSame(distance1, distance2) then\n    if M.Config.FruCfg.MirrorSameDistanceType == 1 then\n        \n        local disRed = TensorCore.getDistance2d(redMirror[1].pos, redMirror[2].pos)\n        if disRed > distance1 then\n            if table.contains(M.Config.FruCfg.MirrorPosMelee1, M.SelfPos) then\n                data.MuAiGd_P2_Mirror2 = { pos = right.pos, isLeft = false }\n            else\n                data.MuAiGd_P2_Mirror2 = { pos = left.pos, isLeft = true }\n            end\n        else\n            if table.contains(M.Config.FruCfg.MirrorPosMelee1, M.SelfPos) then\n                data.MuAiGd_P2_Mirror2 = { pos = left.pos, isLeft = true }\n            else\n                data.MuAiGd_P2_Mirror2 = { pos = right.pos, isLeft = false }\n            end\n        end\n    else\n        if table.contains(M.Config.FruCfg.MirrorPosMelee1, M.SelfPos) then\n            data.MuAiGd_P2_Mirror2 = { pos = left.pos, isLeft = true }\n        else\n            data.MuAiGd_P2_Mirror2 = { pos = right.pos, isLeft = false }\n        end\n    end\nelse\n    local far, near\n    if distance1 > distance2 then\n        far  = redMirror[1]\n        near = redMirror[2]\n    else\n        near = redMirror[1]\n        far  = redMirror[2]\n    end\n    if table.contains(M.Config.FruCfg.MirrorPosMelee1, M.SelfPos) then\n        data.MuAiGd_P2_Mirror2 = { pos = far.pos, isLeft = (far.id == left.id) }\n    else\n        data.MuAiGd_P2_Mirror2 = { pos = near.pos, isLeft = (near.id == left.id) }\n    end\nend\nlocal m2cHeading = TensorCore.getHeadingToTarget(blueMirror.pos, { x = 100, y = 0, z = 100 })\nif table.contains(M.Config.FruCfg.MirrorPosMelee1, M.SelfPos) then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=12809\")) do\n        if Argus.isEntityVisible(ent) then\n            data.MuAiGd_P2_BOSS = ent\n            break\n        end\n    end\n    data.MuAiGd_P2_MirrorMelee = true\n    local curMT = TensorCore.getEntityByGroup(\"Main Tank\", \"Nearest\")\n    if curMT ~= nil and curMT.id == M.GetPlayer().id then\n        local mtPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, m2cHeading, 16)\n\t\tM.DirectTo(mtPos.x, mtPos.z, guideTime - 4100)\n    end\nelse\n    data.MuAiGd_P2_MirrorMelee = false\n    local selfIndex = M.IndexOf(M.Config.FruCfg.MirrorPosRange, M.SelfPos)\n    local endHeading\n    if selfIndex == 1 then     --?1\n        endHeading = m2cHeading - 75 / 180 * math.pi\n    elseif selfIndex == 2 then --?2\n        endHeading = m2cHeading - 45 / 180 * math.pi\n    elseif selfIndex == 3 then --?3\n        endHeading = m2cHeading + 45 / 180 * math.pi\n    elseif selfIndex == 4 then --?4\n        endHeading = m2cHeading + 75 / 180 * math.pi\n    end\n    local endPos = TensorCore.getPosInDirection(blueMirror.pos, endHeading, 3)\n    M.DirectTo(endPos.x, endPos.z, guideTime)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "3f737fe6-7887-9bb2-92dc-36920051bb49",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 292.6,
				name = "[MuAiGuide]镜子指路",
				timelineIndex = 68,
				timerEndOffset = 10,
				timerOffset = 2.2000000476837,
				timerStartOffset = -2,
				uuid = "3d46a6be-3783-ce07-85ca-0ff9d219fd31",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "local guideTime = 10000\nif data.MuAiGd_P2_Mirror2 ~= nil then\n    local baseDir = TensorCore.getHeadingToTarget(data.MuAiGd_P2_Mirror2.pos, { x = 100, y = 0, z = 100 })\n    local endHeading\n    local posTable\n    if table.contains(MuAiGuide.Config.FruCfg.MirrorPosMelee1, MuAiGuide.SelfPos) then\n        posTable = MuAiGuide.Config.FruCfg.MirrorPosMelee2\n    else\n        posTable = MuAiGuide.Config.FruCfg.MirrorPosRange\n    end\n    local index = MuAiGuide.IndexOf(posTable, MuAiGuide.SelfPos)\n\n    if index == 1 then\n        endHeading = baseDir - 75 / 180 * math.pi\n    elseif index == 2 then\n        if data.MuAiGd_P2_Mirror2.isLeft then\n            endHeading = baseDir - 45 / 180 * math.pi\n        else\n            endHeading = baseDir\n        end\n    elseif index == 3 then\n        if not data.MuAiGd_P2_Mirror2.isLeft then\n            endHeading = baseDir + 45 / 180 * math.pi\n        else\n            endHeading = baseDir\n        end\n    elseif index == 4 then\n        endHeading = baseDir + 75 / 180 * math.pi\n    end\n    \n    local endPos = TensorCore.getPosInDirection(data.MuAiGd_P2_Mirror2.pos, endHeading, 3)\n    MuAiGuide.DirectTo(endPos.x, endPos.z, guideTime)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "3d17e481-f584-72bd-90c4-253ac1dbac4a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 306.6,
				name = "[MuAiGuide]镜子2指路",
				timelineIndex = 71,
				timerEndOffset = 10,
				timerStartOffset = -2,
				uuid = "308bfcf7-a1cf-208f-8084-ed90f5916d54",
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
							actionLua = "local bossPos = TensorCore.mGetEntity(data.MuAiGd_P2_BOSS.id).pos\nlocal selfIndex = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.MirrorPosMelee1, MuAiGuide.SelfPos)\nlocal heading\nif selfIndex == 1 then\n    heading = bossPos.h + math.pi / 2\nelseif selfIndex == 2 then\n    heading = bossPos.h + math.pi / 6\nelseif selfIndex == 3 then\n    heading = bossPos.h - math.pi / 6\nelseif selfIndex == 4 then\n    heading = bossPos.h - math.pi / 2\nend\nlocal targetPos = TensorCore.getPosInDirection(bossPos, heading, 3)\nMuAiGuide.FrameDirect(targetPos.x, targetPos.z)\nself.used = true\n",
							conditions = 
							{
								
								{
									"e81648ff-fd6b-60d7-bb67-a558ec8f6d6a",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "49bfeaf6-80d5-9f7f-b681-63b8ada4b9ba",
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
							conditionLua = "return data.MuAiGd_P2_MirrorMelee ~= nil \nand data.MuAiGd_P2_MirrorMelee == true\nand data.MuAiGd_P2_BOSS ~= nil",
							uuid = "e81648ff-fd6b-60d7-bb67-a558ec8f6d6a",
							version = 2,
						},
					},
				},
				eventType = 12,
				mechanicTime = 306.6,
				name = "[MuAiGuide]镜子1指路MELEE",
				randomOffset = 10,
				timeRange = true,
				timelineIndex = 71,
				timerOffset = -10,
				timerStartOffset = -5.5,
				uuid = "7ccf8be3-3ad0-aecd-919b-6ddd2453cfa8",
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
							actionLua = "local guideTime = 5000\nif TensorCore.isAnyEntityCasting(40220) then\n    MuAiGuide.Info(\"找搭档分摊。\", true)\n    local partner = MuAiGuide.GetRMPartner()\n    local p = MuAiGuide.Party[partner]\n    MuAiGuide.DirectToEnt(p.id, guideTime)\nelse\n\tMuAiGuide.Info(\"分散。\", true)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "5840bec7-50a0-5eee-91fd-048a1eb247e9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 322.5,
				name = "[MuAiGuide]分摊or分散",
				timelineIndex = 77,
				timerOffset = -4,
				uuid = "f5d0b86f-606a-2740-842e-2400e8bd479d",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "local dropTable = {}\nif MuAiGuide.Config.FruCfg.FruLightRampantType == 1 then\n    if MuAiGuide.Config.FruCfg.FruLightRampantDropType == 1 then\n        dropTable = { {}, {} }\n        for i = 1, 4 do\n            local pos1 = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 7 / 8 - (i - 1) * math.pi / 4, 8)\n            table.insert(dropTable[1], pos1)\n            local pos2 = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 15 / 8 - (i - 1) * math.pi / 4, 8)\n            table.insert(dropTable[2], pos2)\n        end\n        table.insert(dropTable[1], { x = dropTable[1][4].x, y = 0, z = 114 })\n        table.insert(dropTable[2], { x = dropTable[2][4].x, y = 0, z = 86 })\n        local posUp = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math. pi * 7 / 8, 19)\n        local posDown = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, -math. pi / 8, 19)\n        table.insert(dropTable[1], posDown)\n        table.insert(dropTable[2], posUp)\n    else\n        dropTable = {\n            -- 1\n            [1] = {\n                { x = 103, z = 97 },\n                { x = 107.3, z = 92.7 },\n                { x = 108, z = 100 },\n                { x = 105.7, z = 105.7 },\n                { x = 100, z = 111 },\n            },\n            -- 4\n            [2] = {\n                { x = 97, z = 103 },\n                { x = 92.7, z = 107.3 },\n                { x = 92, z = 100 },\n                { x = 94.3, z = 94.3 },\n                { x = 100, z = 89 },\n            },\n        }\n        local posUp = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math. pi * 7 / 8, 19)\n        local posDown = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, -math. pi / 8, 19)\n        table.insert(dropTable[1], posDown)\n        table.insert(dropTable[2], posUp)\n    end\nelse\n    dropTable = {\n        -- D\n        [1] = {\n            { x = 92, z = 100 },\n            { x = 94.3, z = 94.3 },\n            { x = 100, z = 92, },\n            { x = 106, z = 90 },\n            { x = 112, z = 88 },\n            { x = 119, z = 100 },\n        },\n        -- B\n        [2] = {\n            { x = 108, z = 100 },\n            { x = 105.7, z = 105.7 },\n            { x = 100, z = 108, },\n            { x = 94, z = 110, },\n            { x = 88, z = 112 },\n            { x = 81, z = 100, },\n        }\n    }\nend\ndata.MuAiGd_P2_LightRampantDropPos = dropTable\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "9d58ab7e-c3d1-fa76-b194-c2702ea11d90",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 331.8,
				name = "[MuAiGuide]光之暴走-放圈位置定义",
				timelineIndex = 80,
				uuid = "04c8c1dd-c213-b432-ab82-1fd67b858a16",
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
							actionLua = "local guideTime = 5000\nif MuAiGuide.Config.FruCfg.FruLightRampantType == 1 then\n    local posTable = { math.pi * 11 / 8, math.pi * 9 / 8, math.pi * 7 / 8, math.pi * 5 / 8,\n                       math.pi * 13 / 8, math.pi * 15 / 8, math.pi * 1 / 8, math.pi * 3 / 8 }\n    local posOrder = MuAiGuide.Config.FruCfg.FruLightRampantOrder\n    local selfIndex = MuAiGuide.IndexOf(posOrder, MuAiGuide.SelfPos)\n    local heading = posTable[selfIndex]\n    local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 6)\n    MuAiGuide.DirectTo(targetPos.x, targetPos.z, guideTime)\nelseif MuAiGuide.Config.FruCfg.FruLightRampantType == 2 then\n    local posOrder = { \"H2\", \"D2\", \"ST\", \"D4\", \"MT\", \"D3\", \"H1\", \"D1\" }\n    local selfIndex = MuAiGuide.IndexOf(posOrder, MuAiGuide.SelfPos)\n    local heading = (selfIndex - 1) * math.pi / 4\n    local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 6)\n    MuAiGuide.DirectTo(targetPos.x, targetPos.z, guideTime)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "预站位",
							uuid = "2e6576e5-8d1c-70dc-a78e-692bd7a9da41",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 331.8,
				name = "[MuAiGuide]光之暴走-预站位",
				timelineIndex = 80,
				timerOffset = -5,
				uuid = "38b9f6af-b0a3-156e-a702-5c7db4f787b1",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "local guideTime = 9000\nlocal buffId = 4157\nlocal M = MuAiGuide\nlocal linkBuff = TensorCore.getBuff(M.GetPlayer().id, buffId)\nlocal dropTable = data.MuAiGd_P2_LightRampantDropPos\nif M.Config.FruCfg.FruLightRampantType == 1 then\n    -- 计算是否有线（是否有线BUFF）\n    if linkBuff ~= nil then\n        --连线定名\n        local TGroup = {}\n        local DGroup = {}\n        for i = 1, 8 do\n            if i <= 4 then\n                table.insert(TGroup, M.Config.FruCfg.FruLightRampantOrder[i])\n            else\n                table.insert(DGroup, M.Config.FruCfg.FruLightRampantOrder[i])\n            end\n        end\n\n        local selfLinkOrder = 0 --计算自己是第几个有线\n        local targetHeading = 0\n        if table.contains(TGroup, M.SelfPos) then\n            local index = M.IndexOf(TGroup, M.SelfPos)\n            for i = 1, index do\n                local curPlayer = M.Party[TGroup[i]]\n                if TensorCore.getBuff(curPlayer.id, buffId) then\n                    selfLinkOrder = selfLinkOrder + 1\n                end\n            end\n            if selfLinkOrder == 1 then\n                targetHeading = math.pi * 4 / 3\n                M.Info(\"上1，去左上踩塔。\", true)\n            elseif selfLinkOrder == 2 then\n                M.Info(\"上2，去下方踩塔。\", true)\n                targetHeading = 0\n            elseif selfLinkOrder == 3 then\n                M.Info(\"上3，去右上踩塔。\", true)\n                targetHeading = math.pi * 2 / 3\n            elseif selfLinkOrder == 4 then\n                M.Info(\"上4，补位，去左下踩塔。\", true)\n                targetHeading = math.pi * 5 / 3\n            end\n        elseif table.contains(DGroup, M.SelfPos) then\n            local index = M.IndexOf(DGroup, M.SelfPos)\n            for i = 1, index do\n                local curPlayer = M.Party[DGroup[i]]\n                if TensorCore.getBuff(curPlayer.id, buffId) then\n                    selfLinkOrder = selfLinkOrder + 1\n                end\n            end\n            if selfLinkOrder == 1 then\n                M.Info(\"下1，去右下踩塔。\", true)\n                targetHeading = math.pi / 3\n            elseif selfLinkOrder == 2 then\n                M.Info(\"下2，去上踩塔。\", true)\n                targetHeading = math.pi\n            elseif selfLinkOrder == 3 then\n                M.Info(\"下3，去左下踩塔。\", true)\n                targetHeading = math.pi * 5 / 3\n            elseif selfLinkOrder == 4 then\n                targetHeading = math.pi * 2 / 3\n                M.Info(\"下4，补位，去右上踩塔。\", true)\n            end\n        end\n        local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, targetHeading, 18)\n        M.DirectTo(targetPos.x, targetPos.z, guideTime)\n    else\n        M.Info(\"放圈点名。\", true)\n        local noBuffOther\n        for i = 1, 8 do\n            local curJobPos = M.JobPosName[i]\n            if curJobPos ~= M.SelfPos and TensorCore.getBuff(M.Party[curJobPos].id, buffId) == nil then\n                noBuffOther = curJobPos\n            end\n        end\n        --判断优先级\n        local selfIdx = M.IndexOf(M.Config.FruCfg.FruLightRampantOrder, M.SelfPos)\n        local otherIdx = M.IndexOf(M.Config.FruCfg.FruLightRampantOrder, noBuffOther)\n\n        if selfIdx < otherIdx then\n            M.DirectTo(dropTable[1][1].x ,dropTable[1][1].z, 4850)\n        else\n            M.DirectTo(dropTable[2][1].x ,dropTable[2][1].z, 4850)\n        end\n        data.MuAiGd_P2_IsDrop = true\n    end\nelseif M.Config.FruCfg.FruLightRampantType == 2 then\n    if linkBuff then\n        -- 灰9计数表，C逆 一周弧度算位置\n        local headings = {\n            [\"C\"] = 0,\n            [\"3\"] = math.pi / 3,\n            [\"2\"] = 2 * math.pi / 3,\n            [\"A\"] = math.pi,\n            [\"1\"] = 4 * math.pi / 3,\n            [\"4\"] = 5 * math.pi / 3\n        }\n\n        local valueTable = {\n            [\"MT\"] = { \"C\", \"/\", \"/\" },\n            [\"D4\"] = { \"1\", \"C\", \"/\" },\n            [\"ST\"] = { \"2\", \"1\", \"C\" },\n            [\"D2\"] = { \"4\", \"2\", \"1\" },\n            [\"H2\"] = { \"3\", \"4\", \"2\" },\n            [\"D1\"] = { \"A\", \"3\", \"4\" },\n            [\"H1\"] = { \"/\", \"A\", \"3\" },\n            [\"D3\"] = { \"/\", \"/\", \"A\" },\n        }\n\n        -- A顺优先级\n        local order = { \"MT\", \"D4\", \"ST\", \"D2\", \"H2\", \"D1\", \"H1\", \"D3\" }\n        local selfIndex = M.IndexOf(order, M.SelfPos)\n        local cnt = 0\n        for i = 1, selfIndex do\n            local curJobPos = order[i]\n            local curPlayer = M.Party[curJobPos]\n            if not TensorCore.getBuff(curPlayer.id, buffId) then\n                cnt = cnt + 1\n            end\n        end\n        local targetDir = valueTable[M.SelfPos][cnt + 1]\n        local targetHeading = headings[targetDir]\n        local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, targetHeading, 17)\n        M.DirectTo(targetPos.x, targetPos.z, guideTime)\n        data.MuAiGd_P2_IsDrop = false\n        M.Info(\"去\" .. targetDir .. \"点踩塔。\", true)\n    else\n        M.Info(\"放圈点名。\", true)\n        local noBuffOther\n        for i = 1, 8 do\n            local curJobPos = M.JobPosName[i]\n            if curJobPos ~= M.SelfPos and TensorCore.getBuff(M.Party[curJobPos].id, buffId) == nil then\n                noBuffOther = curJobPos\n            end\n        end\n        local order = {\"H1\", \"D3\", \"D1\", \"MT\", \"H2\", \"D4\", \"D2\", \"ST\"}\n        local selfIdx = M.IndexOf(order, M.SelfPos)\n        local otherIdx = M.IndexOf(order, noBuffOther)\n        if selfIdx < otherIdx then\n            M.DirectTo(dropTable[1][1].x ,dropTable[1][1].z, 4850)\n        else\n            M.DirectTo(dropTable[2][1].x ,dropTable[2][1].z, 4850)\n        end\n        data.MuAiGd_P2_IsDrop = true\n    end\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							name = "线分析&指路",
							uuid = "63c0bd19-de44-6780-822c-251564f6c733",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 331.8,
				name = "[MuAiGuide]光之暴走-分析线&指路",
				timelineIndex = 80,
				timerOffset = 1,
				uuid = "df04ad36-0dec-a5b8-86b0-2187c689b527",
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
							actionLua = "local M = MuAiGuide\nif M.Config.FruCfg.FruLightRampantType == 1 then\n    local TGroup = {}\n    local DGroup = {}\n    for i = 1, 8 do\n        if i <= 4 then\n            table.insert(TGroup, M.Config.FruCfg.FruLightRampantOrder[i])\n        else\n            table.insert(DGroup, M.Config.FruCfg.FruLightRampantOrder[i])\n        end\n    end\n    data.MuAiGd_LightRampantGroupUp = {}\n    data.MuAiGd_LightRampantGroupDown = {}\n    local buffCnt = 0\n    for i = 1, 4 do\n        local curPlayer = M.Party[TGroup[i]]\n        if TensorCore.getBuff(curPlayer.id, 4157) then\n            buffCnt = buffCnt + 1\n            if buffCnt == 2 or buffCnt == 4 then\n                table.insert(data.MuAiGd_LightRampantGroupDown, TGroup[i])\n            else\n                table.insert(data.MuAiGd_LightRampantGroupUp, TGroup[i])\n            end\n        end\n    end\n    buffCnt = 0\n    for i = 1, 4 do\n        local curPlayer = M.Party[DGroup[i]]\n        if TensorCore.getBuff(curPlayer.id, 4157) then\n            buffCnt = buffCnt + 1\n            if buffCnt == 2 or buffCnt == 4 then\n                table.insert(data.MuAiGd_LightRampantGroupUp, DGroup[i])\n            else\n                table.insert(data.MuAiGd_LightRampantGroupDown, DGroup[i])\n            end\n        end\n    end\nelseif M.Config.FruCfg.FruLightRampantType == 2 then\n    local valueTable = {\n        [\"MT\"] = { \"C\", \"/\", \"/\" },\n        [\"D4\"] = { \"1\", \"C\", \"/\" },\n        [\"ST\"] = { \"2\", \"1\", \"C\" },\n        [\"D2\"] = { \"4\", \"2\", \"1\" },\n        [\"H2\"] = { \"3\", \"4\", \"2\" },\n        [\"D1\"] = { \"A\", \"3\", \"4\" },\n        [\"H1\"] = { \"/\", \"A\", \"3\" },\n        [\"D3\"] = { \"/\", \"/\", \"A\" },\n    }\n    local left = { \"A\", \"1\", \"4\" }\n    data.MuAiGd_LightRampantGroupLeft = {}\n    data.MuAiGd_LightRampantGroupRight = {}\n    -- A顺优先级\n    local order = { \"MT\", \"D4\", \"ST\", \"D2\", \"H2\", \"D1\", \"H1\", \"D3\" }\n    local cnt = 0\n    for i = 1, 8 do\n        local curJobPos = order[i]\n        local curPlayer = M.Party[curJobPos]\n        local buff = TensorCore.getBuff(curPlayer.id, 4157)\n        if buff == nil then\n            cnt = cnt + 1\n        else\n            local index = cnt + 1\n            local endPos = valueTable[curJobPos][index]\n            if table.contains(left, endPos) then\n                table.insert(data.MuAiGd_LightRampantGroupLeft, curJobPos)\n            else\n                table.insert(data.MuAiGd_LightRampantGroupRight, curJobPos)\n            end\n        end\n    end\nend\nself.used = true\n\n\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "c641c1e0-c330-93d6-a98e-c1a1d2d5c619",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 331.8,
				name = "[MuAiGuide]光之暴走-分摊分组计算",
				timelineIndex = 80,
				timerOffset = 2,
				uuid = "cb6be8aa-dbad-5a0b-aafb-b2019b193705",
				version = 2,
			},
			inheritedIndex = 4,
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
							aType = "Lua",
							actionLua = "local M = MuAiGuide\nfor curJobPos, ent in pairs(M.Party) do\n    local buff = TensorCore.getBuff(ent.id, 4157)\n    if buff == nil then\n        local curPlayer = TensorCore.mGetEntity(ent.id)\n        if MuAiGuide.Config.FruCfg.FruLightRampantType == 1 then\n            if curPlayer.pos.z < 100 then\n                table.insert(data.MuAiGd_LightRampantGroupDown, curJobPos)\n            else\n                table.insert(data.MuAiGd_LightRampantGroupUp, curJobPos)\n            end\n        else\n            if curPlayer.pos.x < 100 then\n                table.insert(data.MuAiGd_LightRampantGroupRight, curJobPos)\n            else\n                table.insert(data.MuAiGd_LightRampantGroupLeft, curJobPos)\n            end\n        end\n\n    end\nend\nif M.Config.FruCfg.FruLightRampantType == 1 then\n    M.Info(\"最终分摊分组，上：\" .. M.StringJoin(data.MuAiGd_LightRampantGroupUp, \",\"))\n    M.Info(\"最终分摊分组，下：\" .. M.StringJoin(data.MuAiGd_LightRampantGroupDown, \",\"))\nelse\n    M.Info(\"最终分摊分组，左：\" .. M.StringJoin(data.MuAiGd_LightRampantGroupLeft, \",\"))\n    M.Info(\"最终分摊分组，右：\" .. M.StringJoin(data.MuAiGd_LightRampantGroupRight, \",\"))\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "a6c1ea18-2ef9-0376-85e3-11c4f319846d",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 339.7,
				name = "[MuAiGuide]光之暴走-分组补充",
				timelineIndex = 82,
				timerOffset = -2,
				uuid = "c49867de-10d6-b9eb-9d12-6ac9faa926aa",
				version = 2,
			},
			inheritedIndex = 3,
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P2_LRDropTable == nil then\n    data.MuAiGd_P2_LRDropState = 1\n    local dropTable = data.MuAiGd_P2_LightRampantDropPos\n    local playerPos = M.GetPlayer().pos\n    local distance1 = TensorCore.getDistance2d(dropTable[1][1], playerPos)\n    local distance2 = TensorCore.getDistance2d(dropTable[2][1], playerPos)\n    if distance1 < distance2 then\n        data.MuAiGd_P2_LRDropTable = dropTable[1]\n    else\n        data.MuAiGd_P2_LRDropTable = dropTable[2]\n    end\nend\nif data.MuAiGd_P2_LRDropTable ~= nil and data.MuAiGd_P2_LRDropState > 0 then\n    local curPos = data.MuAiGd_P2_LRDropTable[data.MuAiGd_P2_LRDropState]\n    M.FrameDirect(curPos.x, curPos.z)\nend\nself.used = true\n\n",
							conditions = 
							{
								
								{
									"18e2136d-485f-dc51-92b9-31efb5d7cc41",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "c25112e0-ec6e-1365-843a-443b8188ba4b",
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
							conditionLua = "return data.MuAiGd_P2_IsDrop ~= nil and data.MuAiGd_P2_IsDrop == true",
							name = "放圈人",
							uuid = "18e2136d-485f-dc51-92b9-31efb5d7cc41",
							version = 2,
						},
					},
				},
				eventType = 12,
				mechanicTime = 339.7,
				name = "[MuAiGuide]光之暴走-放圈指路",
				randomOffset = 3.2000000476837,
				timeRange = true,
				timelineIndex = 82,
				timerEndOffset = 9,
				timerOffset = -4,
				timerStartOffset = -2,
				uuid = "8ad1148f-e927-41e9-84bd-d6e1fe8d2fd6",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "data.MuAiGd_P2_LRDropState = 2\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "7433200e-db52-d2f8-ab50-3c8ab70bb2d4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 339.7,
				name = "[MuAiGuide]光之暴走-放圈1完毕",
				timelineIndex = 82,
				uuid = "c16e0482-22ba-c8f9-9967-d0394ec98d1c",
				version = 2,
			},
		},
	},
	[83] = 
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
							actionLua = "data.MuAiGd_P2_LRDropState = 3\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "7433200e-db52-d2f8-ab50-3c8ab70bb2d4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 341.3,
				name = "[MuAiGuide]光之暴走-放圈2完毕",
				timelineIndex = 83,
				uuid = "61e92956-264b-9dd2-be52-513fc5dd4d76",
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
							aType = "Lua",
							actionLua = "data.MuAiGd_P2_LRDropState = 4\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "7433200e-db52-d2f8-ab50-3c8ab70bb2d4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 342.9,
				name = "[MuAiGuide]光之暴走-放圈3完毕",
				timelineIndex = 84,
				uuid = "ebc998ee-3b70-8dae-ac3b-43d34b7021bb",
				version = 2,
			},
		},
	},
	[85] = 
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
							actionLua = "\nif MuAiGuide and MuAiGuide.Config.FruCfg.FruLightRampantType == 1 then\n    MuAiGuide.DirectTo(100, 119, 5000)\n    local pos\n    if table.contains(data.MuAiGd_LightRampantGroupUp, MuAiGuide.SelfPos) then\n        pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math. pi * 7 / 8, 19)\n    else\n        pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, -math. pi / 8, 19)\n    end\n    MuAiGuide.DirectTo(pos.x, pos.z, 5000)\nelse\n    if table.contains(data.MuAiGd_LightRampantGroupLeft, MuAiGuide.SelfPos) then\n        MuAiGuide.DirectTo(81, 100, 5000)\n    else\n        MuAiGuide.DirectTo(119, 100, 5000)\n    end\nend\n\nif MuAiGuide and MuAiGuide.Config.FruCfg.FruLightRampantType == 1 then\n    for jobPos, player in pairs(MuAiGuide.Party) do\n        if not MuAiGuide.IsMe(player) and TensorCore.getBuff(player.id, 4159) then\n            if table.contains(data.MuAiGd_LightRampantGroupUp, MuAiGuide.SelfPos)\n                    and table.contains(data.MuAiGd_LightRampantGroupUp, jobPos) then\n                MuAiGuide.DirectToEnt(player.id, 5000)\n                break\n            end\n            if table.contains(data.MuAiGd_LightRampantGroupDown, MuAiGuide.SelfPos)\n                    and table.contains(data.MuAiGd_LightRampantGroupDown, jobPos) then\n                MuAiGuide.DirectToEnt(player.id, 5000)\n                break\n            end\n        end\n    end\nelse\n    for jobPos, player in pairs(MuAiGuide.Party) do\n        if not MuAiGuide.IsMe(player) and TensorCore.getBuff(player.id, 4159) then\n            if table.contains(data.MuAiGd_LightRampantGroupLeft, MuAiGuide.SelfPos)\n                    and table.contains(data.MuAiGd_LightRampantGroupLeft, jobPos) then\n                MuAiGuide.DirectToEnt(player.id, 5000)\n                break\n            end\n            if table.contains(data.MuAiGd_LightRampantGroupRight, MuAiGuide.SelfPos)\n                    and table.contains(data.MuAiGd_LightRampantGroupRight, jobPos) then\n                MuAiGuide.DirectToEnt(player.id, 5000)\n                break\n            end\n        end\n    end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"f2801a12-8725-5020-a1f9-828c1a20799c",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "88d1f8fe-edd6-e370-8749-9fc28b8ef6c7",
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
							conditionLua = "return data.MuAiGd_P2_IsDrop == nil or data.MuAiGd_P2_IsDrop == false",
							name = "非放圈人",
							uuid = "f2801a12-8725-5020-a1f9-828c1a20799c",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 343,
				name = "[MuAiGuide]光暴-指路分摊",
				timelineIndex = 85,
				uuid = "b300baf4-9c3f-470c-b120-98cabf414d6f",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "data.MuAiGd_P2_LRDropState = 5\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "7433200e-db52-d2f8-ab50-3c8ab70bb2d4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 344.3,
				name = "[MuAiGuide]光之暴走-放圈4完毕",
				randomOffset = 0.10000000149012,
				timelineIndex = 86,
				uuid = "20096af3-c6cd-2ae7-9495-5b7c3ea3bf03",
				version = 2,
			},
		},
	},
	[87] = 
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
							actionLua = "data.MuAiGd_P2_LRDropState = 6\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "7433200e-db52-d2f8-ab50-3c8ab70bb2d4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 345.9,
				name = "[MuAiGuide]光之暴走-放圈5完毕",
				timelineIndex = 87,
				uuid = "a3f96fa1-b32d-ae88-a093-1747d1332164",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "local buff = TensorCore.getBuff(MuAiGuide.GetPlayer().id, 4159)\nif buff == nil then\n\tif MuAiGuide and MuAiGuide.Config.FruCfg.FruLightRampantType == 1 then\n\t\tfor jobPos, player in pairs(MuAiGuide.Party) do\n\t\t\tif not MuAiGuide.IsMe(player) and TensorCore.getBuff(player.id, 4159) then\n\t\t\t\tif table.contains(data.MuAiGd_LightRampantGroupUp, MuAiGuide.SelfPos)\n\t\t\t\t\t\tand table.contains(data.MuAiGd_LightRampantGroupUp, jobPos) then\n\t\t\t\t\tMuAiGuide.DirectToEnt(player.id, 3000)\n\t\t\t\t\tbreak\n\t\t\t\tend\n\t\t\t\tif table.contains(data.MuAiGd_LightRampantGroupDown, MuAiGuide.SelfPos)\n\t\t\t\t\t\tand table.contains(data.MuAiGd_LightRampantGroupDown, jobPos) then\n\t\t\t\t\tMuAiGuide.DirectToEnt(player.id, 3000)\n\t\t\t\t\tbreak\n\t\t\t\tend\n\t\t\tend\n\t\tend\n\telse\n\t\tfor jobPos, player in pairs(MuAiGuide.Party) do\n\t\t\tif not MuAiGuide.IsMe(player) and TensorCore.getBuff(player.id, 4159) then\n\t\t\t\tif table.contains(data.MuAiGd_LightRampantGroupLeft, MuAiGuide.SelfPos)\n\t\t\t\t\t\tand table.contains(data.MuAiGd_LightRampantGroupLeft, jobPos) then\n\t\t\t\t\tMuAiGuide.DirectToEnt(player.id, 3000)\n\t\t\t\t\tbreak\n\t\t\t\tend\n\t\t\t\tif table.contains(data.MuAiGd_LightRampantGroupRight, MuAiGuide.SelfPos)\n\t\t\t\t\t\tand table.contains(data.MuAiGd_LightRampantGroupRight, jobPos) then\n\t\t\t\t\tMuAiGuide.DirectToEnt(player.id, 3000)\n\t\t\t\t\tbreak\n\t\t\t\tend\n\t\t\tend\n\t\tend\n\tend\nend\nself.used = true",
							conditions = 
							{
								
								{
									"b9c586b2-5a83-98cb-a8d8-2e4d384f6768",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "84db3dda-b574-f59e-9dc0-f681c99430ff",
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
							conditionLua = "return data.MuAiGd_P2_IsDrop ~= nil and data.MuAiGd_P2_IsDrop == true",
							name = "放圈人",
							uuid = "b9c586b2-5a83-98cb-a8d8-2e4d384f6768",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 345.9,
				name = "[MuAiGuide]光之暴走-放圈人和人群合流",
				timelineIndex = 87,
				uuid = "4573448a-388b-0815-86bd-8a25e2db037d",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[91] = 
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
							actionLua = "local buff = TensorCore.getBuff(MuAiGuide.GetPlayer().id, 2257)\nif buff and buff.stacks <= 2 then\n    MuAiGuide.DirectTo(100, 100, 5000)\n    MuAiGuide.Info(\"2层去踩塔。\", true)\nelse\n    MuAiGuide.Info(\"不踩。\", true)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "ad8e4ca1-3dd5-e4cc-a999-8563781b7638",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 357.7,
				name = "[MuAiGuide]光爆后-4人踩塔",
				timelineIndex = 91,
				timerOffset = -5,
				uuid = "b3ff0fd1-15e9-36e1-8b7e-dac02e3dd343",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[92] = 
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
							actionLua = "local guideTime = 3000\nif TensorCore.isAnyEntityCasting(40220) then\n    MuAiGuide.Info(\"找搭档分摊。\", true)\n    local partner = MuAiGuide.GetBasePartner(MuAiGuide.Config.FruCfg)\n    local p = MuAiGuide.Party[partner]\n    MuAiGuide.DirectToEnt(p.id, guideTime)\nelseif TensorCore.isAnyEntityCasting(40221) then\n    MuAiGuide.Info(\"八方分散。\", true)\n    local index = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.JobPos, MuAiGuide.SelfPos)\n    local dir = (index - 1) * math.pi / 4\n    local endPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, dir, 13)\n    MuAiGuide.DirectTo(endPos.x, endPos.z, guideTime)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "5840bec7-50a0-5eee-91fd-048a1eb247e9",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 360.8,
				name = "[MuAiGuide]光爆后-分摊or分散",
				timelineIndex = 92,
				timerOffset = -3,
				uuid = "9aec1874-ca9e-70f8-8369-9cea58d56a80",
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
							actionLua = "local guideTime = 10000\nlocal index = MuAiGuide.IndexOf(MuAiGuide.Config.FruCfg.JobPos, MuAiGuide.SelfPos)\nlocal dir = (index - 1) * math.pi / 4\nlocal endPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, dir, 8)\nMuAiGuide.DirectTo(endPos.x, endPos.z, guideTime)\nself.used = true  ",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2fdca798-c49e-dcef-8436-36cf487e446f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 360.8,
				name = "[MuAiGuide]光爆后-8方分散",
				timelineIndex = 92,
				uuid = "512895ab-c36c-02d0-b277-f03e589afade",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[123] = 
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
							actionLua = "local player = MuAiGuide.GetPlayer()\n--- { 长:1 | 中:2 | 短:3 | 冰:4 }\ndata.MuAiGd_P3_1_type = 0\nlocal fire = TensorCore.getBuff(player.id, 2455)\nif fire then\n    -- 长火\n    if fire.duration > 22 then\n        data.MuAiGd_P3_1_type = 1\n        MuAiGuide.Info(\"长火点名。\", true)\n    elseif fire.duration > 12 then\n        -- 中火\n        data.MuAiGd_P3_1_type = 2\n        MuAiGuide.Info(\"中火点名。\", true)\n    else\n        -- 短火\n        data.MuAiGd_P3_1_type = 3\n        MuAiGuide.Info(\"短火点名。\", true)\n    end\n    MuAiGuide.Debug(\"P3一运buff分析: TYPE = \" .. data.MuAiGd_P3_1_type)\n\tself.used = true\nelseif TensorCore.getBuff(player.id, 2462) then\n    data.MuAiGd_P3_1_type = 4\n    if MuAiGuide.IsDps(player.job) then\n        MuAiGuide.Info(\"冰点名，当做长火！\", true)\n    else\n        MuAiGuide.Info(\"冰点名，当做短火！\", true)\n    end\n    MuAiGuide.Debug(\"P3一运buff分析: TYPE = \" .. data.MuAiGd_P3_1_type)\n    self.used = true\nend",
							gVar = "ACR_TensorRequiem3_CD",
							name = "GetBuffType",
							uuid = "0e69975b-9346-5907-9e56-c896f3e74abf",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "[MuAiGuide]获取BUFF类型",
				randomOffset = 1,
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 10,
				timerOffset = -2,
				timerStartOffset = -2,
				uuid = "03cb0846-6dad-e0e9-9b8e-21798892978d",
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P3_1_Lights == nil then\n    data.MuAiGd_P3_1_Lights = {}\n    data.MuGuide_GetDirType = function(fire)\n        if fire == nil then\n            return 4\n        end\n        if fire then\n            -- 长火\n            if fire.duration > 22 then\n                return 1\n            elseif fire.duration > 12 then\n                -- 中火\n                return 2\n            else\n                -- 短火\n                return 3\n            end\n        end\n    end\n    M.Debug(\"===================== P3一运查找关键灯-开始 =====================\")\nend\n\n-- 采集灯\nif table.size(data.MuAiGd_P3_1_Lights) < 8 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9825\")) do\n        if Argus.getEntityModel(ent.id) == 17832 then\n            local curHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n            data.MuAiGd_P3_1_Lights[ent.id] = { entity = ent, heading = curHeading }\n        end\n    end\nend\n\n--获取12点\nif table.size(data.MuAiGd_P3_1_Lights) == 8 and data.MuAiGd_P3_1_Clock12 == nil then\n    local yellowLineInfo = {}\n    for _, info in pairs(data.MuAiGd_P3_1_Lights) do\n        local lines = Argus.getTethersOnEnt(info.entity.id)\n        for _, line in pairs(lines) do\n            if line.type == 134 then\n                table.insert(yellowLineInfo, info)\n                break\n            end\n        end\n    end\n    if table.size(yellowLineInfo) >= 3 then\n        M.Debug(\"连线灯分析完毕，开始查找12点！\")\n        local function dotProduct(v1, v2)\n            return v1.x * v2.x + v1.z * v2.z\n        end\n        local os1 = { x = yellowLineInfo[1].entity.pos.x - 100, z = yellowLineInfo[1].entity.pos.z - 100 }\n        local os2 = { x = yellowLineInfo[2].entity.pos.x - 100, z = yellowLineInfo[2].entity.pos.z - 100 }\n        local os3 = { x = yellowLineInfo[3].entity.pos.x - 100, z = yellowLineInfo[3].entity.pos.z - 100 }\n        if M.IsSame(dotProduct(os1, os2), 0) then\n            data.MuAiGd_P3_1_Clock12 = yellowLineInfo[3]\n        elseif M.IsSame(dotProduct(os1, os3), 0) then\n            data.MuAiGd_P3_1_Clock12 = yellowLineInfo[2]\n        elseif M.IsSame(dotProduct(os2, os3), 0) then\n            data.MuAiGd_P3_1_Clock12 = yellowLineInfo[1]\n        end\n        if M.Config.LogToEchoMsg then\n            local infoPoint = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, data.MuAiGd_P3_1_Clock12.heading)\n            M.Info(\"当前12点为：\" .. infoPoint .. \"点\")\n        end\n        if data.MuAiGd_P3_1_Clock12 ~= nil then\n            local pos = data.MuAiGd_P3_1_Clock12.entity.pos\n            local redDrawer = Argus2.ShapeDrawer:new(\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)),\n                    8\n            )\n            redDrawer:addTimedCircle(40000, pos.x, pos.y + 3, pos.z, 1.8, 0, true)\n            redDrawer:addTimedCircle(40000, pos.x, pos.y + 4, pos.z, 1.8, 0, true)\n            redDrawer:addTimedCircle(40000, pos.x, pos.y + 5, pos.z, 1.8, 0, true)\n            local type = data.MuAiGd_P3_1_type\n            local dir\n            if M.IsDps(M.GetPlayer().job) then\n                if type == 1 or type == 4 then\n                    dir = 0\n                elseif type == 2 then\n                    dir = -math.pi / 2\n                else\n                    for jobName, ptMember in pairs(M.Party) do\n                        --找到另外一个短火的人\n                        if M.IsDps(ptMember.job) and not M.IsMe(ptMember) then\n                            local fireOther = TensorCore.getBuff(ptMember.id, 2455);\n                            if fireOther and data.MuGuide_GetDirType(fireOther) == 3 then\n                                -- 找到了 开始判断优先级\n                                local selfOrder = M.IndexOf(M.JobPosName, M.SelfPos)\n                                local otherOrder = M.IndexOf(M.JobPosName, jobName)\n                                if selfOrder < otherOrder then\n                                    -- 索引小的优先\n                                    dir = math.pi / 4\n                                    M.Info(\"高优先级短火。\", true)\n                                else\n                                    dir = -math.pi / 4\n                                    M.Info(\"低优先级短火。\", true)\n                                end\n                            end\n                        end\n                    end\n                end\n            else\n                if type == 1 then\n                    for jobName, ptMember in pairs(M.Party) do\n                        --找到另外一个短火的人\n                        if not M.IsDps(ptMember.job) and not M.IsMe(ptMember) then\n                            local fireOther = TensorCore.getBuff(ptMember.id, 2455);\n                            if fireOther and data.MuGuide_GetDirType(fireOther) == 1 then\n                                -- 找到了 开始判断优先级\n                                local selfOrder = M.IndexOf(M.JobPosName, M.SelfPos)\n                                local otherOrder = M.IndexOf(M.JobPosName, jobName)\n                                if selfOrder < otherOrder then\n                                    -- 索引小的优先\n                                    dir = 3 / 4 * math.pi\n                                    M.Info(\"高优先级长火。\", true)\n                                else\n                                    dir = -3 / 4 * math.pi\n                                    M.Info(\"低优先级长火。\", true)\n                                end\n                            end\n                        end\n                    end\n                elseif type == 2 then\n                    dir = math.pi / 2\n                else\n                    dir = math.pi\n                end\n            end\n            local finalDir = data.MuAiGd_P3_1_Clock12.heading + dir\n            if finalDir > math.pi * 2 or M.IsSame(finalDir, math.pi * 2) then\n                finalDir = finalDir - math.pi * 2\n            elseif finalDir < 0 then\n                finalDir = finalDir + math.pi * 2\n            end\n            for _, light in pairs(data.MuAiGd_P3_1_Lights) do\n                if M.IsSame(light.heading, finalDir) then\n                    data.MuAiGd_SelfLight = light\n                    break\n                end\n            end\n            M.Debug(\"最终方向\" .. (finalDir / math.pi))\n            local white = Argus2.ShapeDrawer:new(\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 1, 1, 0.5)),5)\n            white:addTimedRect(40000, 100, 0, 100, 19.8, 4, data.MuAiGd_SelfLight.heading)\n            if M.Config.LogToEchoMsg then\n                local infoPoint = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, finalDir)\n                M.Info(\"机制处理方向：\" .. infoPoint .. \"点。\")\n            end\n            M.Debug(\"===================== P3一运查找关键灯-结束 =====================\")\n            self.used = true\n        end\n    end\nend\n",
							conditions = 
							{
								
								{
									"9609cce8-5dd2-599e-902b-0b50dcff7b7c",
									true,
								},
								
								{
									"24ccac1b-77c5-bc73-9e31-668c100d089c",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "HourglassG9",
							uuid = "c25a8b75-f300-1a72-9e0d-84f923e6cd97",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_P3_1_type ~= nil and data.MuAiGd_P3_1_type > 0",
							name = "已读取到当前BUFF类型",
							uuid = "9609cce8-5dd2-599e-902b-0b50dcff7b7c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruCfg.UltimateRelativityType == 1",
							name = "非摇号模式",
							uuid = "24ccac1b-77c5-bc73-9e31-668c100d089c",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "[MuAiGuide]查找关键灯(灰九)",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 6,
				timerStartOffset = -1,
				uuid = "25b1fa05-3be0-87f3-a68f-dd660934ad10",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P3_1_Lights == nil then\n    data.MuAiGd_P3_1_Lights = {}\n    data.MuGuide_GetDirType = function(fire)\n        if fire == nil then\n            return 4\n        end\n        if fire then\n            -- 长火\n            if fire.duration > 22 then\n                return 1\n            elseif fire.duration > 12 then\n                -- 中火\n                return 2\n            else\n                -- 短火\n                return 3\n            end\n        end\n    end\n    M.Debug(\"===================== P3一运查找关键灯-开始 =====================\")\nend\n\n-- 采集灯\nif table.size(data.MuAiGd_P3_1_Lights) < 8 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9825\")) do\n        if Argus.getEntityModel(ent.id) == 17832 then\n            local curHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n            data.MuAiGd_P3_1_Lights[ent.id] = { entity = ent, heading = curHeading }\n        end\n    end\nend\n\n--获取12点\nif table.size(data.MuAiGd_P3_1_Lights) == 8 and data.MuAiGd_P3_1_Clock12 == nil then\n    local yellowLineInfo = {}\n    for _, info in pairs(data.MuAiGd_P3_1_Lights) do\n        local lines = Argus.getTethersOnEnt(info.entity.id)\n        for _, line in pairs(lines) do\n            if line.type == 134 then\n                table.insert(yellowLineInfo, info)\n                break\n            end\n        end\n    end\n    if table.size(yellowLineInfo) >= 3 then\n        M.Debug(\"连线灯分析完毕，开始查找12点！\")\n        local function dotProduct(v1, v2)\n            return v1.x * v2.x + v1.z * v2.z\n        end\n        local os1 = { x = yellowLineInfo[1].entity.pos.x - 100, z = yellowLineInfo[1].entity.pos.z - 100 }\n        local os2 = { x = yellowLineInfo[2].entity.pos.x - 100, z = yellowLineInfo[2].entity.pos.z - 100 }\n        local os3 = { x = yellowLineInfo[3].entity.pos.x - 100, z = yellowLineInfo[3].entity.pos.z - 100 }\n        if M.IsSame(dotProduct(os1, os2), 0) then\n            data.MuAiGd_P3_1_Clock12 = yellowLineInfo[3]\n        elseif M.IsSame(dotProduct(os1, os3), 0) then\n            data.MuAiGd_P3_1_Clock12 = yellowLineInfo[2]\n        elseif M.IsSame(dotProduct(os2, os3), 0) then\n            data.MuAiGd_P3_1_Clock12 = yellowLineInfo[1]\n        end\n        if M.Config.LogToEchoMsg then\n            local infoPoint = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, data.MuAiGd_P3_1_Clock12.heading)\n            M.Info(\"当前12点为：\" .. infoPoint .. \"点\")\n        end\n        if data.MuAiGd_P3_1_Clock12 ~= nil and M.GetPlayer().marker ~= nil and M.GetPlayer().marker > 0 then\n            local pos = data.MuAiGd_P3_1_Clock12.entity.pos\n            local redDrawer = Argus2.ShapeDrawer:new(\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 1)),\n                    8\n            )\n            redDrawer:addTimedCircle(40000, pos.x, pos.y + 3, pos.z, 1.8, 0, true)\n            redDrawer:addTimedCircle(40000, pos.x, pos.y + 4, pos.z, 1.8, 0, true)\n            redDrawer:addTimedCircle(40000, pos.x, pos.y + 5, pos.z, 1.8, 0, true)\n            local type = data.MuAiGd_P3_1_type\n            local dir\n            if M.IsDps(M.GetPlayer().job) then\n                if type == 1 or type == 4 then\n                    dir = 0\n                elseif type == 2 then\n                    dir = -math.pi / 2\n                else\n                    if M.GetPlayer().marker == 1 then\n                        -- 索引小的优先\n                        dir = math.pi / 4\n                        M.Info(\"攻击1：高优先级短火。\")\n                    else\n                        dir = -math.pi / 4\n                        M.Info(\"攻击2：低优先级短火。\")\n                    end\n                end\n            else\n                if type == 1 then\n                    if M.GetPlayer().marker == 6 then\n                        -- 索引小的优先\n                        dir = 3 / 4 * math.pi\n                        M.Info(\"锁链1：高优先级长火。\")\n                    else\n                        dir = -3 / 4 * math.pi\n                        M.Info(\"锁链2：低优先级长火。\")\n                    end\n                elseif type == 2 then\n                    dir = math.pi / 2\n                else\n                    dir = math.pi\n                end\n            end\n            local finalDir = data.MuAiGd_P3_1_Clock12.heading + dir\n            if finalDir > math.pi * 2 or M.IsSame(finalDir, math.pi * 2) then\n                finalDir = finalDir - math.pi * 2\n            elseif finalDir < 0 then\n                finalDir = finalDir + math.pi * 2\n            end\n            for _, light in pairs(data.MuAiGd_P3_1_Lights) do\n                if M.IsSame(light.heading, finalDir) then\n                    data.MuAiGd_SelfLight = light\n                    break\n                end\n            end\n            M.Debug(\"最终方向\" .. (finalDir / math.pi))\n            local white = Argus2.ShapeDrawer:new(\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                    (GUI:ColorConvertFloat4ToU32(1, 1, 1, 0.5)),5)\n            white:addTimedRect(40000, 100, 0, 100, 19.8, 4, data.MuAiGd_SelfLight.heading)\n            if M.Config.LogToEchoMsg then\n                local infoPoint = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, finalDir)\n                M.Info(\"机制处理方向：\" .. infoPoint .. \"点。\")\n            end\n            M.Debug(\"===================== P3一运查找关键灯-结束 =====================\")\n            self.used = true\n        end\n    end\nend\n",
							conditions = 
							{
								
								{
									"9609cce8-5dd2-599e-902b-0b50dcff7b7c",
									true,
								},
								
								{
									"c2d14198-1c61-9997-bb87-45a1ed968c99",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "HourglassJp",
							uuid = "c25a8b75-f300-1a72-9e0d-84f923e6cd97",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_P3_1_type ~= nil and data.MuAiGd_P3_1_type > 0",
							name = "已读取到当前BUFF类型",
							uuid = "9609cce8-5dd2-599e-902b-0b50dcff7b7c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruCfg.UltimateRelativityType == 2\nor MuAiGuide.Config.FruCfg.UltimateRelativityType == 3",
							name = "日基/科技标点",
							uuid = "c2d14198-1c61-9997-bb87-45a1ed968c99",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "[MuAiGuide]查找关键灯(标记)",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 10,
				timerStartOffset = -1,
				uuid = "d409b890-a2bc-5fa5-98a8-40217bc53c29",
				version = 2,
			},
			inheritedIndex = 3,
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
							actionLua = "local guideTime = 6000\nlocal M = MuAiGuide\nif data.MuAiGd_RelativityFlag == nil then\n    data.MuAiGd_RelativityFlag = {\n        StartPos = false,\n        Fire = false,\n        Fire2 = false,\n        Delay = false,\n        ReturnBuff = false,\n        Converge = false,\n        Ice = false,\n        Turing = false,\n        TuringBack = false,\n        EndGuide = false\n    }\n    data.MuAiGd_P3_BackCenter = function()\n        if data.MuAiGd_P3_CenterPos == nil then\n            data.MuAiGd_P3_CenterPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 },\n                data.MuAiGd_SelfLight.heading, 1)\n        end\n        local targetPos = data.MuAiGd_P3_CenterPos\n        M.DirectTo(targetPos.x, targetPos.z, guideTime, 0.3)\n    end\nend\n-- 火\nlocal fire = TensorCore.getBuff(M.GetPlayer().id, 2455)\n-- 冰\nlocal ice = TensorCore.getBuff(M.GetPlayer().id, 2462)\n-- 分摊\nlocal converge = TensorCore.getBuff(M.GetPlayer().id, 2454)\n-- 回返（未放置）\nlocal delay = TensorCore.getBuff(M.GetPlayer().id, 2464)\n-- 暗焰\nlocal darkFlame = TensorCore.getBuff(M.GetPlayer().id, 2460)\n-- 回返（放置）\nlocal returnBuff = TensorCore.getBuff(M.GetPlayer().id, 2452)\n\n-- 初始位置\nif not data.MuAiGd_RelativityFlag.StartPos and (fire or ice) then\n    if data.MuAiGd_P3_1_type == 3 then\n        local targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 15.5)\n        M.DirectTo(targetPos.x, targetPos.z, guideTime)\n    else\n        data.MuAiGd_P3_BackCenter()\n    end\n    data.MuAiGd_RelativityFlag.StartPos = true\nend\n\n-- 火BUFF\nif not data.MuAiGd_RelativityFlag.Fire and fire then\n    if data.MuAiGd_P3_1_type == 3 then\n        data.MuAiGd_RelativityFlag.Fire = true\n    elseif fire.duration < 5.1 then\n        local targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 15.5)\n        M.DirectTo(targetPos.x, targetPos.z, guideTime)\n        data.MuAiGd_RelativityFlag.Fire = true\n        M.Info(\"场外放火。\", true)\n    end\nend\n\nif data.MuAiGd_P3_1_type == 2 or data.MuAiGd_P3_1_type == 1 then\n    if not data.MuAiGd_RelativityFlag.Fire2 and (fire == nil or fire.duration < 0.1) then\n        data.MuAiGd_P3_BackCenter()\n        M.Info(\"火BUFF放置完毕，回场中。\")\n        data.MuAiGd_RelativityFlag.Fire2 = true\n    end\nend\n\n-- 回返\nif not data.MuAiGd_RelativityFlag.Delay and delay then\n    if delay.duration < 5.1 then\n        local targetPos\n        if darkFlame == nil then\n            targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 1)\n            M.Info(\"场中放回返。\", true)\n        else\n            local distance = TensorCore.getDistance2d({x = 100, y = 0, z = 100}, data.MuAiGd_SelfLight.entity.pos)\n            targetPos = TensorCore.getPosInDirection({x = 100, y = 0, z = 100}, data.MuAiGd_SelfLight.heading, distance - 0.8)\n            M.Info(\"灯下放回返。\", true)\n        end\n        data.MuAiGd_RelativityFlag.Delay = true\n        M.DirectTo(targetPos.x, targetPos.z, guideTime, 0.3)\n    end\nend\n\n-- 放完回返\nif not data.MuAiGd_RelativityFlag.ReturnBuff and returnBuff then\n    data.MuAiGd_RelativityFlag.ReturnBuff = true\n    if not fire or fire.duration >= 10 then\n        M.Info(\"回场中。\", true)\n        data.MuAiGd_P3_BackCenter()\n    end\nend\n\n-- 分摊\nif not data.MuAiGd_RelativityFlag.Converge and converge then\n    if converge.duration < 5.1 then\n        data.MuAiGd_P3_BackCenter()\n        M.Info(\"场中分摊。\", true)\n        data.MuAiGd_RelativityFlag.Converge = true\n    end\nend\n\n-- 冰\nif not data.MuAiGd_RelativityFlag.Ice and ice then\n    if ice.duration < 5.1 then\n        data.MuAiGd_P3_BackCenter()\n        M.Info(\"冰，回场中。\", true)\n        data.MuAiGd_RelativityFlag.Ice = true\n    end\nend\n\n-- 终点\nif data.MuAiGd_RelativityFlag.ReturnBuff and not data.MuAiGd_RelativityFlag.EndGuide then\n    if returnBuff == nil or returnBuff.duration < 0.1 then\n        local targetPos = TensorCore.getPosInDirection({ x = 100, 0, z = 100 }, data.MuAiGd_SelfLight.heading, 1)\n        MuAiGuide.DirectTo(targetPos.x, targetPos.z, 10000)\n        data.MuAiGd_RelativityFlag.EndGuide = true\n        M.Info(\"回场中等待分摊！\", true)\n        self.used = true\n    end\nend\n\n-- 灯开始转了\n-- 黄/顺\nif not data.MuAiGd_RelativityFlag.Turing then\n    local turing = TensorCore.getBuff(data.MuAiGd_SelfLight.entity.id, 2970)\n    if turing and turing.duration > 0 then\n        local posDir\n        if turing.stacks == 269 then\n            M.Info(\"引导逆时针的灯!\", true)\n            posDir = data.MuAiGd_SelfLight.heading - 3 / 8 * math.pi;\n        elseif turing.stacks == 348 then\n            M.Info(\"引导顺时针的灯!\", true)\n            posDir = data.MuAiGd_SelfLight.heading + 3 / 8 * math.pi;\n        end\n        local pos = data.MuAiGd_SelfLight.entity.pos\n        if not M.Config.AnyOneReactionOn then\n            Argus2.addTimedArrowFilled(\n                guideTime,\n                pos.x, 0, pos.z,\n                2, 0.2, 1, 0.25,\n                posDir,\n                GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n                GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n                GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5),\n                0,\n                nil,\n                nil,\n                GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n                1.0,\n                3,\n                0.05,\n                true\n            )\n        end\n        local targetPos = TensorCore.getPosInDirection(pos, posDir, 1.5)\n        M.DirectTo(targetPos.x, targetPos.z, guideTime, 0.2)\n        data.MuAiGd_RelativityFlag.Turing = true\n    end\nend\n\n-- 引导灯结束了 且 获得了火伤buff，需要回中了\nif data.MuAiGd_RelativityFlag.Turing and not data.MuAiGd_RelativityFlag.TuringBack then\n    local buff = TensorCore.getBuff(M.GetPlayer().id, 4383)\n    if buff and buff.duration >= 11 then\n        M.Info(\"引导灯完成, 回场中！\", true)\n        data.MuAiGd_P3_BackCenter()\n        data.MuAiGd_RelativityFlag.TuringBack = true\n    end\nend\n",
							conditions = 
							{
								
								{
									"91218c42-2e34-4e1b-afeb-b178cff662de",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "处理BUFF",
							uuid = "c25a8b75-f300-1a72-9e0d-84f923e6cd97",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_P3_1_Clock12 ~= nil and data.MuAiGd_SelfLight ~= nil",
							name = "找到灯",
							uuid = "91218c42-2e34-4e1b-afeb-b178cff662de",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "[MuAiGuide]BUFF处理",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 42,
				timerStartOffset = -1,
				uuid = "42e8f9f9-e7a4-1f69-b4e4-4c807cc70b94",
				version = 2,
			},
			inheritedIndex = 4,
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
							actionLua = "data.MuAiGd_p3_MarkTime = Now()\nlocal selfIndex = MuAiGuide.IndexOf(MuAiGuide.JobPosName)\ndata.MuAiGd_p3_MarkTimeOffset = (selfIndex - 1) * 200\nself.used = true",
							conditions = 
							{
								
								{
									"1bf477aa-4eff-c15c-ae59-e45662de9898",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "8c21bd8d-112c-c0f9-832a-2027386e33fe",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_P3_1_type ~= nil and data.MuAiGd_P3_1_type > 0 and MuAiGuide.Config.FruCfg.UltimateRelativityType == 2",
							name = "已获取类型+日基",
							uuid = "1bf477aa-4eff-c15c-ae59-e45662de9898",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "[MuAiGuide]日基摇号-数据定义",
				randomOffset = 10,
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 19,
				timerOffset = 1,
				timerStartOffset = -2,
				uuid = "3034ecf8-b3ca-c427-8828-c186759967a4",
				version = 2,
			},
			inheritedIndex = 5,
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
							actionLua = "local M = MuAiGuide\nif M.IsDps(M.GetPlayer().job) then\n    if data.MuAiGd_P3_1_type == 1 or data.MuAiGd_P3_1_type == 4 then\n        M.Info(\"时间压缩摇号：锁链3。\")\n        SendTextCommand(\"/mk bind3 <me>\")\n    elseif data.MuAiGd_P3_1_type == 2 then\n        SendTextCommand(\"/mk stop2 <me>\")\n        M.Info(\"时间压缩摇号：禁止2。\")\n    elseif data.MuAiGd_P3_1_type == 3 then\n        SendTextCommand(\"/mk attack <me>\")\n        M.Info(\"时间压缩摇号：攻击1、2随机。\")\n    end\nelse\n    if data.MuAiGd_P3_1_type == 1 then\n        SendTextCommand(\"/mk bind <me>\")\n        M.Info(\"时间压缩摇号：锁链1、2随机。\")\n    elseif data.MuAiGd_P3_1_type == 2 then\n        SendTextCommand(\"/mk stop1 <me>\")\n        M.Info(\"时间压缩摇号：禁止1。\")\n    elseif data.MuAiGd_P3_1_type == 3 or data.MuAiGd_P3_1_type == 4 then\n        SendTextCommand(\"/mk attack3 <me>\")\n        M.Info(\"时间压缩摇号：攻击3。\")\n    end\nend\ndata.MuAiGd_p3_MarkTime = Now()\nself.used = true",
							conditions = 
							{
								
								{
									"1bf477aa-4eff-c15c-ae59-e45662de9898",
									true,
								},
								
								{
									"901b1b66-28a2-6251-9d6f-b07ec4ddfb67",
									true,
								},
								
								{
									"ccda5683-241c-23e9-af84-4d2b26e6da52",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "8c21bd8d-112c-c0f9-832a-2027386e33fe",
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
							conditionLua = "return data.MuAiGd_P3_1_type ~= nil and data.MuAiGd_P3_1_type > 0 and MuAiGuide.Config.FruCfg.UltimateRelativityType == 2",
							name = "已获取类型+日基",
							uuid = "1bf477aa-4eff-c15c-ae59-e45662de9898",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == nil or TensorCore.mGetPlayer().marker == 0",
							name = "没有标记",
							uuid = "901b1b66-28a2-6251-9d6f-b07ec4ddfb67",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_p3_MarkTime ~= nil and data.MuAiGd_p3_MarkTimeOffset ~= nil and TimeSince(data.MuAiGd_p3_MarkTime) > data.MuAiGd_p3_MarkTimeOffset",
							name = "延迟时间已到",
							uuid = "ccda5683-241c-23e9-af84-4d2b26e6da52",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 532.4,
				name = "[MuAiGuide]日基摇号",
				randomOffset = 10,
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 19,
				timerOffset = -2,
				timerStartOffset = -2,
				uuid = "ef9f2277-7b69-f240-b8ad-ab3ff1a747ac",
				version = 2,
			},
			inheritedIndex = 6,
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
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.setLockFaceHeading(data.MuAiGd_SelfLight.heading)\nTensorCore.API.TensorACR.toggleLockFace(true)\nself.used = true",
							conditions = 
							{
								
								{
									"aba28404-d26b-ba41-89ec-45b696da4b98",
									true,
								},
								
								{
									"151c40ff-5b1e-ff9d-9291-8aa11b5d4a17",
									true,
								},
								
								{
									"bdd5eeba-e30e-fff9-91ac-94ac7b1f80cd",
									true,
								},
							},
							gVar = "ACR_TensorMagnum3_CD",
							uuid = "59304e9f-7021-04f7-a426-b80ed792493e",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.AnyOneReactionOn == false",
							name = "检查设置",
							uuid = "aba28404-d26b-ba41-89ec-45b696da4b98",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 2,
							buffID = 2452,
							category = "Self",
							comparator = 2,
							name = "回返倒计时2秒",
							uuid = "151c40ff-5b1e-ff9d-9291-8aa11b5d4a17",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_SelfLight ~= nil",
							uuid = "bdd5eeba-e30e-fff9-91ac-94ac7b1f80cd",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 574.9,
				name = "[MuAiGuide]锁定面向 开",
				timeRange = true,
				timelineIndex = 135,
				timerEndOffset = 5,
				timerOffset = -3,
				timerStartOffset = -5,
				uuid = "7bfc7f8c-b01e-20d9-bba1-66ab1bc27dac",
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
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\nself.used = true",
							conditions = 
							{
								
								{
									"f507d054-68b0-e7e6-83e5-499fb91178d8",
									true,
								},
								
								{
									"5f94dfd2-c4df-7d68-b00e-c03f0b74a326",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "off lockface",
							uuid = "9e2c54be-0bde-6201-8bfd-44bd08de14cd",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_SelfLight ~= nil",
							uuid = "5f94dfd2-c4df-7d68-b00e-c03f0b74a326",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.AnyOneReactionOn == false",
							name = "检查设置",
							uuid = "f507d054-68b0-e7e6-83e5-499fb91178d8",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 0.5,
							buffID = 2452,
							category = "Self",
							comparator = 2,
							name = "回返倒计时结束",
							uuid = "741373d2-8187-31c0-b1ce-48114ca5796c",
							version = 2,
						},
					},
				},
				mechanicTime = 574.9,
				name = "[MuAiGuide]锁定面向 关",
				timelineIndex = 135,
				timerEndOffset = 10,
				timerOffset = 0.5,
				timerStartOffset = 0.5,
				uuid = "4389350f-7058-4b10-a56e-124b8b3acdf3",
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
							actionLua = "MuAiGuide.Info(\"看向场外。\", true)\nself.used = true",
							gVar = "ACR_RikuWHM3_CD",
							uuid = "af83de3d-2a10-2b37-9cd6-eef65d1696a5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 574.9,
				name = "[MuAiGuide]tts",
				timelineIndex = 135,
				timerOffset = -2,
				uuid = "c8e1a736-fc3b-27ee-a6b9-31dabc6b026e",
				version = 2,
			},
			inheritedIndex = 3,
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
							actionLua = "for i = 1,14 do\n    SendTextCommand(\"/mk clear <\"..i..\">\")\nend\nself.used = true",
							gVar = "ACR_TensorMagnum3_CD",
							uuid = "bc049a79-aeee-2d74-a908-f9b3b91c3912",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 587.1,
				name = "清标点",
				timelineIndex = 139,
				timerOffset = -3,
				uuid = "0e5cef20-fa7b-ec9f-b705-c4aa7df579e6",
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
							actionLua = "local M = MuAiGuide\nlocal typeMap = {}\ndata.MuAiGd_P3_2_PlayerBuffType = {}\nlocal jobOrder\n\nif M.Config.FruCfg.ApocalypseGroupType == 1 then\n    jobOrder =  { \"MT\", \"ST\", \"H1\", \"H2\", \"D1\", \"D2\", \"D3\", \"D4\" }\nelseif M.Config.FruCfg.ApocalypseGroupType == 4 then\n    jobOrder  = { \"H1\", \"H2\", \"MT\", \"ST\", \"D1\", \"D2\", \"D3\", \"D4\" }\nend\nfor i = 1, 8 do\n    local jobName = jobOrder[i]\n    local party = M.Party[jobName]\n    local waterBuff = TensorCore.getBuff(party.id, 2461)\n    local type -- 长3 中2 短1 无4\n    if waterBuff then\n        if waterBuff.duration > 30 then\n            type = 3\n        elseif waterBuff.duration > 20 then\n            type = 2\n        else\n            type = 1\n        end\n    else \n        type = 4\n    end\n    if M.Config.FruCfg.ApocalypseGroupType == 1 then\n        if not typeMap[type] then\n            typeMap[type] = { jobName }\n        else\n            table.insert(typeMap[type], jobName)\n        end\n        data.MuAiGd_P3_2_PlayerBuffType[jobName] = { IsLeft = i <= 4, Type = type }\n    elseif M.Config.FruCfg.ApocalypseGroupType == 4 then\n        if not typeMap[type] then\n            typeMap[type] = { jobName }\n            data.MuAiGd_P3_2_PlayerBuffType[jobName] = { IsLeft = true, Type = type }\n        else\n            table.insert(typeMap[type], jobName)\n            data.MuAiGd_P3_2_PlayerBuffType[jobName] = { IsLeft = false, Type = type }\n        end\n    end\nend\n\nlocal buffTypeName = { \"短\", \"中\", \"长\", \"无\" }\nfor i = 1, 4 do\n    local list = typeMap[i]\n    local info = buffTypeName[i] .. \"：\" .. list[1] .. \", \" .. list[2]\n    M.Info(info)\nend\n\nif M.Config.FruCfg.ApocalypseGroupType == 1 then\n    -- 左侧基础站位\n    local LeftBaseGroup = { \"MT\", \"ST\", \"H1\", \"H2\" }\n    -- 右侧基础站位\n    local RightBaseGroup = { \"D1\", \"D2\", \"D3\", \"D4\" }\n\n    local L2R = {}\n    local R2L = {}\n    local ChangeOrder = function(tbl)\n        if table.size(tbl) == 1 then\n            return { tbl[1], tbl[2] }\n        else\n            local index1 = M.IndexOf(M.JobPosName, tbl[1])\n            local index2 = M.IndexOf(M.JobPosName, tbl[2])\n            if index1 > index2 then\n                return { tbl[2], tbl[1] }\n            end\n        end\n        return { tbl[1], tbl[2] }\n    end\n\n    for _, list in pairs(typeMap) do\n        if table.contains(LeftBaseGroup, list[1]) and table.contains(LeftBaseGroup, list[2]) then\n            --同属TH\n            table.insert(L2R, list[2])\n        elseif table.contains(RightBaseGroup, list[1]) and table.contains(RightBaseGroup, list[2]) then\n            --同属D\n            table.insert(R2L, list[2])\n        end\n    end\n\n    L2R = ChangeOrder(L2R)\n    R2L = ChangeOrder(R2L)\n    local selfNeedChange = false\n    for i = 1, #L2R do\n        if L2R[i] == M.SelfPos then\n            local p = M.Party[R2L[i]]\n            local curP = TensorCore.mGetEntity(p.id)\n            M.DirectTo(curP.pos.x, curP.pos.z, 5000)\n            M.Info(\"与\" .. R2L[i] .. \"交换位置！<se.1>\")\n            data.MuAiGd_P3_2_SelfJob = R2L[i]\n            selfNeedChange = true\n        elseif R2L[i] == M.SelfPos then\n            local p = M.Party[L2R[i]]\n            local curP = TensorCore.mGetEntity(p.id)\n            M.DirectTo(curP.pos.x, curP.pos.z, 5000)\n            M.Info(\"与\" .. L2R[i] .. \"交换位置！<se.1>\")\n            data.MuAiGd_P3_2_SelfJob = L2R[i]\n            selfNeedChange = true\n        else\n            M.Info(L2R[i] .. \"与\" .. R2L[i] .. \"交换位置！\")\n        end\n        data.MuAiGd_P3_2_PlayerBuffType[L2R[i]].IsLeft = not data.MuAiGd_P3_2_PlayerBuffType[L2R[i]].IsLeft\n        data.MuAiGd_P3_2_PlayerBuffType[R2L[i]].IsLeft = not data.MuAiGd_P3_2_PlayerBuffType[R2L[i]].IsLeft\n    end\n    if not selfNeedChange then\n        M.Info(\"不换不换！\")\n        data.MuAiGd_P3_2_SelfJob = M.SelfPos\n    end\nelseif M.Config.FruCfg.ApocalypseGroupType == 4 then\n    data.MuAiGd_P3_2_SelfJob = M.SelfPos\n    if data.MuAiGd_P3_2_PlayerBuffType[MuAiGuide.SelfPos].IsLeft then\n        M.Info(\"优先级分组，去左侧。\")\n        MuAiGuide.DirectTo(93, 100, 4000)\n    else\n        M.Info(\"优先级分组，去右侧。\")\n        MuAiGuide.DirectTo(107, 100, 4000)\n    end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"56d1f839-1252-4b43-8cc4-999284f843c1",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "LeftOrRightOrder",
							uuid = "dd5779db-3e79-1ce9-af31-2a2cf44db09d",
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
							conditionLua = "return MuAiGuide.Config.FruCfg.ApocalypseGroupType == 1 \n\tor MuAiGuide.Config.FruCfg.ApocalypseGroupType == 4",
							name = "处理方案1或4（车头或双分组）",
							uuid = "56d1f839-1252-4b43-8cc4-999284f843c1",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 612.6,
				name = "[MuAiGuide]左右优先级分组",
				timelineIndex = 142,
				timerOffset = 1,
				uuid = "70ee63e7-a987-c5be-99c1-ef37fcd9bd5c",
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
							actionLua = "for job, ent in pairs(MuAiGuide.Party) do\n    local curPlayer = TensorCore.mGetEntity(ent.id)\n    if curPlayer.marker ~= nil then\n        if curPlayer.marker <= 4 then\n            data.MuAiGd_P3_2_PlayerBuffType[job].IsLeft = true\n            if job == MuAiGuide.SelfPos then\n                MuAiGuide.Info(\"检测到攻击标记，去左侧。\")\n                MuAiGuide.DirectTo(93, 100, 4000)\n            end\n        else\n            data.MuAiGd_P3_2_PlayerBuffType[job].IsLeft = false\n            if job == MuAiGuide.SelfPos then\n                MuAiGuide.Info(\"检测到非攻击标记，去右侧。\")\n                MuAiGuide.DirectTo(107, 100, 4000)\n            end\n        end\n    end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"0cff5bdc-502c-0941-999d-33587d87d992",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "ActGroup",
							uuid = "3ce2c79a-9ccb-ccf2-93b4-d0c467c8dc6e",
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
							conditionLua = "return MuAiGuide.Config.FruCfg.ApocalypseGroupType == 2 \n\t   and MuAiGuide.GetPlayer().marker ~= nil \n\t   and MuAiGuide.GetPlayer().marker > 0",
							name = "处理方案2且有标记",
							uuid = "0cff5bdc-502c-0941-999d-33587d87d992",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 612.6,
				name = "[MuAiGuide]ACT标点分组",
				randomOffset = 3,
				timeRange = true,
				timelineIndex = 142,
				timerEndOffset = 3,
				timerOffset = 1.5,
				timerStartOffset = -1,
				uuid = "356ca69b-3ef6-bb5b-a789-828a42b41ab5",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "local M = MuAiGuide\nlocal typeMap = {}\ndata.MuAiGd_P3_2_PlayerBuffType = {}\nlocal jobOrder = { \"H2\", \"H1\", \"ST\", \"MT\", \"D4\", \"D3\", \"D2\", \"D1\" }\nfor i = 1, 8 do\n    local jobName = jobOrder[i]\n    local party = M.Party[jobName]\n    local waterBuff = TensorCore.getBuff(party.id, 2461)\n    local type -- 长 1 中2 短3 无4\n    if waterBuff then\n        if waterBuff.duration > 30 then\n            type = 3\n        elseif waterBuff.duration > 20 then\n            type = 2\n        else\n            type = 1\n        end\n    else\n        type = 4\n    end\n    if not typeMap[type] then\n        typeMap[type] = { jobName }\n    else\n        table.insert(typeMap[type], jobName)\n    end\n    data.MuAiGd_P3_2_PlayerBuffType[jobName] = { IsUp = i <= 4, Type = type }\nend\n\nlocal buffTypeName = { \"短\", \"中\", \"长\", \"无\" }\nfor i = 1, 4 do\n    local list = typeMap[i]\n    local info = buffTypeName[i] .. \"：\" .. list[1] .. \", \" .. list[2]\n    M.Info(info)\nend\n\n-- 上侧基础站位\nlocal UpBaseGroup = { \"MT\", \"ST\", \"H1\", \"H2\", }\n-- 下侧基础站位\nlocal DownBaseGroup = { \"D1\", \"D2\", \"D3\", \"D4\" }\n\nlocal U2D = {}\nlocal D2U = {}\nlocal ChangeOrder = function(tbl)\n    if table.size(tbl) == 1 then\n        return { tbl[1], tbl[2] }\n    else\n        local index1 = M.IndexOf(M.JobPosName, tbl[1])\n        local index2 = M.IndexOf(M.JobPosName, tbl[2])\n        if index1 > index2 then\n            return { tbl[2], tbl[1] }\n        end\n    end\n    return { tbl[1], tbl[2] }\nend\n\nfor _, list in pairs(typeMap) do\n    if table.contains(UpBaseGroup, list[1]) and table.contains(UpBaseGroup, list[2]) then\n        --同属TH\n        table.insert(U2D, list[2])\n    elseif table.contains(DownBaseGroup, list[1]) and table.contains(DownBaseGroup, list[2]) then\n        --同属D\n        table.insert(D2U, list[2])\n    end\nend\n\nU2D = ChangeOrder(U2D)\nD2U = ChangeOrder(D2U)\nlocal selfNeedChange = false\nfor i = 1, #U2D do\n    if U2D[i] == M.SelfPos then\n        local p = M.Party[D2U[i]]\n        local curP = TensorCore.mGetEntity(p.id)\n        M.DirectTo(curP.pos.x, curP.pos.z, 5000)\n        M.Info(\"与\" .. D2U[i] .. \"交换位置！<se.1>\")\n        data.MuAiGd_P3_2_SelfJob = D2U[i]\n        selfNeedChange = true\n    elseif D2U[i] == M.SelfPos then\n        local p = M.Party[U2D[i]]\n        local curP = TensorCore.mGetEntity(p.id)\n        M.DirectTo(curP.pos.x, curP.pos.z, 5000)\n        M.Info(\"与\" .. U2D[i] .. \"交换位置！<se.1>\")\n        data.MuAiGd_P3_2_SelfJob = U2D[i]\n        selfNeedChange = true\n    else\n        M.Info(U2D[i] .. \"与\" .. D2U[i] .. \"交换位置！\")\n    end\n    data.MuAiGd_P3_2_PlayerBuffType[U2D[i]].IsUp = not data.MuAiGd_P3_2_PlayerBuffType[U2D[i]].IsUp\n    data.MuAiGd_P3_2_PlayerBuffType[D2U[i]].IsUp = not data.MuAiGd_P3_2_PlayerBuffType[D2U[i]].IsUp\nend\n\nif not selfNeedChange then\n    M.Info(\"不换不换！\")\n    data.MuAiGd_P3_2_SelfJob = M.SelfPos\nend\n\nlocal endUp = {}\nlocal endDown = {}\nlocal jobOrder2 = { \"D1\", \"D2\", \"MT\", \"ST\", \"D3\", \"H1\", \"D4\", \"H2\" }\nfor i, v in pairs(data.MuAiGd_P3_2_PlayerBuffType) do\n    if v.IsUp then\n        table.insert(endUp, i)\n    else\n        table.insert(endDown, i)\n    end\nend\n\nfunction sortByReferenceOrder(referenceTable, targetTable)\n    local orderMap = {}\n    for index, value in ipairs(referenceTable) do\n        orderMap[value] = index\n    end\n    table.sort(targetTable, function(a, b)\n        return orderMap[a] < orderMap[b]\n    end)\nend\n\nsortByReferenceOrder(jobOrder2, endUp)\nsortByReferenceOrder(jobOrder2, endDown)\nlocal allJob = M.Append(endUp, endDown)\nlocal selfIndex = M.IndexOf(allJob, M.SelfPos)\ndata.MuAiGd_P3_2_SelfJob = M.JobPosName[selfIndex]\n\nM.Info(\"上方最终分组：\" .. M.StringJoin(endUp, \",\"))\nM.Info(\"下方最终分组：\" .. M.StringJoin(endDown, \",\"))\nd(\"最终结果：\" .. data.MuAiGd_P3_2_SelfJob)\nself.used = true\n",
							conditions = 
							{
								
								{
									"56d1f839-1252-4b43-8cc4-999284f843c1",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "UpdownOrder",
							uuid = "dd5779db-3e79-1ce9-af31-2a2cf44db09d",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruCfg.ApocalypseGroupType == 3",
							name = "处理方案3（日基）",
							uuid = "56d1f839-1252-4b43-8cc4-999284f843c1",
							version = 2,
						},
					},
				},
				mechanicTime = 612.6,
				name = "[MuAiGuide]上下优先级分组",
				timelineIndex = 142,
				timerOffset = 1,
				uuid = "a3ebbeef-093b-9ac1-9a51-f3a4246849bd",
				version = 2,
			},
			inheritedIndex = 3,
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P3_2_Objects == nil then\n    data.MuAiGd_P3_2_Objects = {}\n    data.MuAiGd_P3_2_Ids = {}\n    data.MuAiGd_P3_2_GroundFireFinish = false\nend\n\nif eventArgs.entityContentID == 2011391\n        and not table.contains(data.MuAiGd_P3_2_Ids, eventArgs.entityID)\n        and table.size(data.MuAiGd_P3_2_Ids) < 6\nthen\n    table.insert(data.MuAiGd_P3_2_Ids, eventArgs.entityID)\n    if table.size(data.MuAiGd_P3_2_Ids) == 6 and data.MuAiGd_P3_2_GroundFireFinish == false then\n        --- 绘制方向箭头\n        local drawClock = function(clock, index)\n            local baseEnt = TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[index])\n            local baseDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, baseEnt.pos)\n            for i = 1, 3 do\n                local curDir\n                local heading\n                if clock then\n                    curDir = baseDir - math.pi / 4 * (i - 1)\n                    heading = curDir - math.pi / 2\n                else\n                    curDir = baseDir - math.pi / 4 * (i + 1)\n                    heading = curDir + math.pi / 2\n                end\n                local startPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, curDir, 14)\n                local pos = TensorCore.getPosInDirection(startPos, heading, -3)\n                Argus2.addTimedArrowFilled(\n                        15000,\n                        pos.x, 0, pos.z,\n                        5,\n                        2.5,\n                        3,\n                        4,\n                        heading,\n                        GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                        GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                        GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                        0,\n                        nil,\n                        nil,\n                        GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n                        1.0,\n                        3,\n                        0.05,\n                        false\n                )\n            end\n        end\n        local clock = M.GetClock(TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[3]).pos,\n                TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[5]).pos)\n        -- 非标准坐标系，叉乘结果要反着来\n        if clock then\n            M.Debug(\"顺时针\")\n        else\n            M.Debug(\"逆时针\")\n        end\n        -- 画出方向箭头\n        drawClock(clock, 3)\n        drawClock(clock, 4)\n\n        local firstDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 },\n                TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[3]).pos)\n        if firstDir > math.pi then\n            firstDir = firstDir - math.pi\n        elseif M.IsSame(firstDir, math.pi) then\n            firstDir = 0\n        end\n\n        local posTable\n        -- 计算车头法站位\n        if M.Config.FruCfg.ApocalypseType == 1 then\n            local headDir1 = M.SetHeading2Pi(firstDir + math.pi / 2)\n            local headDir2 = M.SetHeading2Pi(firstDir - math.pi / 2)\n            local headDps, headTh\n            if headDir1 > headDir2 then\n                headTh = headDir1\n                headDps = headDir2\n            else\n                headTh = headDir2\n                headDps = headDir1\n            end\n            if clock then\n                posTable = {\n                    [\"MT\"] = { h = headTh, r = 10 },\n                    [\"ST\"] = { h = headTh - math.pi / 4, r = 10 },\n                    [\"H1\"] = { h = headTh - math.pi / 4 - math.pi / 14, r = 18 },\n                    [\"H2\"] = { h = headTh - math.pi / 4 + math.pi / 14, r = 18 },\n                    [\"D1\"] = { h = headDps, r = 10 },\n                    [\"D2\"] = { h = headDps - math.pi / 4, r = 10 },\n                    [\"D3\"] = { h = headDps - math.pi / 4 - math.pi / 14, r = 18 },\n                    [\"D4\"] = { h = headDps - math.pi / 4 + math.pi / 14, r = 18 },\n                }\n            else\n                posTable = {\n                    [\"MT\"] = { h = headTh, r = 10 },\n                    [\"ST\"] = { h = headTh + math.pi / 4, r = 10 },\n                    [\"H1\"] = { h = headTh + math.pi / 4 - math.pi / 14, r = 18 },\n                    [\"H2\"] = { h = headTh + math.pi / 4 + math.pi / 14, r = 18 },\n                    [\"D1\"] = { h = headDps, r = 10 },\n                    [\"D2\"] = { h = headDps + math.pi / 4, r = 10 },\n                    [\"D3\"] = { h = headDps + math.pi / 4 - math.pi / 14, r = 18 },\n                    [\"D4\"] = { h = headDps + math.pi / 4 + math.pi / 14, r = 18 },\n                }\n            end\n\n            local Th = { \"MT\", \"ST\", \"H1\", \"H2\" }\n            local endHeading\n            if data.MuAiGd_P3_2_SelfJob == \"MT\" then\n                endHeading = headTh\n            elseif data.MuAiGd_P3_2_SelfJob == \"D1\" then\n                endHeading = headDps\n            else\n                if table.contains(Th, data.MuAiGd_P3_2_SelfJob) then\n                    endHeading = M.SetHeading2Pi(posTable[\"ST\"].h)\n                else\n                    endHeading = M.SetHeading2Pi(posTable[\"D2\"].h)\n                end\n            end\n            local point = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, endHeading)\n            M.Info(point .. \"点附近分散。\", true)\n            data.MuAiGd_P3_2_MoveInHeading = endHeading\n        else\n            local headDir1\n            local headDir2\n            if clock then\n                headDir1 = M.SetHeading2Pi(firstDir + math.pi / 4)\n                headDir2 = M.SetHeading2Pi(firstDir + math.pi * 5 / 4)\n            else\n                headDir1 = M.SetHeading2Pi(firstDir - math.pi / 4)\n                headDir2 = M.SetHeading2Pi(firstDir - math.pi * 5 / 4)\n            end\n            local headDps, headTh\n            -- 人群基准分散逻辑和双分其实是一样的\n            if M.Config.FruCfg.ApocalypseType == 2 or M.Config.FruCfg.ApocalypseGroupType == 4 then\n                if headDir1 > headDir2 then\n                    headTh = headDir1\n                    headDps = headDir2\n                else\n                    headTh = headDir2\n                    headDps = headDir1\n                end\n            elseif M.Config.FruCfg.ApocalypseType == 3 then\n                headDps = headDir1\n                headTh = headDir2\n            end\n            posTable = {\n                [\"ST\"] = { h = headTh, r = 10 },\n                [\"H1\"] = { h = headTh - math.pi / 14, r = 18 },\n                [\"H2\"] = { h = headTh + math.pi / 14, r = 18 },\n                [\"D2\"] = { h = headDps, r = 10 },\n                [\"D3\"] = { h = headDps - math.pi / 14, r = 18 },\n                [\"D4\"] = { h = headDps + math.pi / 14, r = 18 },\n            }\n            if clock then\n                posTable[\"MT\"] = { h = headTh + math.pi / 4, r = 10 }\n                posTable[\"D1\"] = { h = headDps + math.pi / 4, r = 10 }\n            else\n                posTable[\"MT\"] = { h = headTh - math.pi / 4, r = 10 }\n                posTable[\"D1\"] = { h = headDps - math.pi / 4, r = 10 }\n            end\n\n            local Th = { \"MT\", \"ST\", \"H1\", \"H2\" }\n            local endHeading\n            if data.MuAiGd_P3_2_SelfJob == \"MT\" or data.MuAiGd_P3_2_SelfJob == \"D1\" then\n                endHeading = M.SetHeading2Pi(posTable[data.MuAiGd_P3_2_SelfJob].h)\n            else\n                if table.contains(Th, data.MuAiGd_P3_2_SelfJob) then\n                    endHeading = M.SetHeading2Pi(posTable[\"ST\"].h)\n                else\n                    endHeading = M.SetHeading2Pi(posTable[\"D2\"].h)\n                end\n            end\n            local point = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, endHeading)\n            M.Info(point .. \"点附近分散。\", true)\n            data.MuAiGd_P3_2_MoveInHeading = endHeading\n        end\n\n        local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, posTable[data.MuAiGd_P3_2_SelfJob].h, posTable[data.MuAiGd_P3_2_SelfJob].r)\n        M.DirectTo(targetPos.x, targetPos.z, 10000)\n        data.MuAiGd_P3_2_GroundFireFinish = true\n        -- 如果是引导T，那么计算2个引导点哪个更近\n        if (M.SelfPos == \"MT\" and M.Config.FruCfg.P3DarkestDanceTaker == 1\n                or M.SelfPos == \"ST\" and M.Config.FruCfg.P3DarkestDanceTaker == 2) then\n            local dir1 = M.SetHeading2Pi(firstDir + math.pi / 2)\n            local dir2 = M.SetHeading2Pi(firstDir - math.pi / 2)\n            if data.MuAiGd_P3_2_PlayerBuffType[M.SelfPos].IsLeft then\n                data.MuAiGd_P3_2_MTHeading = math.max(dir1, dir2)\n            else\n                data.MuAiGd_P3_2_MTHeading = math.min(dir1, dir2)\n            end\n            data.MuAiGd_P3_2_MoveInHeading = data.MuAiGd_P3_2_MTHeading\n        end\n        M.Debug(\"地火指路完成！\")\n    end\nend\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"b4440130-996c-831d-9851-dde30a35e355",
									true,
								},
								
								{
									"cba96c53-2cb0-873d-835c-90a70afbf6e6",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_CD",
							name = "Apocalypse_cn",
							uuid = "2e3d3a95-ecba-0df4-91b0-0315322c9003",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruCfg.ApocalypseGroupType ~= 3",
							name = "非日基",
							uuid = "b4440130-996c-831d-9851-dde30a35e355",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_P3_2_SelfJob ~= nil",
							name = "已计算好分散位置",
							uuid = "cba96c53-2cb0-873d-835c-90a70afbf6e6",
							version = 2,
						},
					},
				},
				eventType = 19,
				loop = true,
				mechanicTime = 619.6,
				name = "[MuAiGuide]P3-地火",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 26,
				timerStartOffset = -30,
				uuid = "45154562-c1a3-dfe6-ae5e-418abede0991",
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P3_2_Objects == nil then\n    data.MuAiGd_P3_2_Objects = {}\n    data.MuAiGd_P3_2_Ids = {}\n    data.MuAiGd_P3_2_GroundFireFinish = false\nend\n\nif eventArgs.entityContentID == 2011391\n        and not table.contains(data.MuAiGd_P3_2_Ids, eventArgs.entityID)\n        and table.size(data.MuAiGd_P3_2_Ids) < 6\nthen\n    table.insert(data.MuAiGd_P3_2_Ids, eventArgs.entityID)\n    if table.size(data.MuAiGd_P3_2_Ids) == 6 and data.MuAiGd_P3_2_GroundFireFinish == false then\n        --- 绘制方向箭头\n        local drawClock = function(clock, index)\n            local baseEnt = TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[index])\n            local baseDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, baseEnt.pos)\n            for i = 1, 3 do\n                local curDir\n                local heading\n                if clock then\n                    curDir = baseDir - math.pi / 4 * (i - 1)\n                    heading = curDir - math.pi / 2\n                else\n                    curDir = baseDir - math.pi / 4 * (i + 1)\n                    heading = curDir + math.pi / 2\n                end\n                local startPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, curDir, 14)\n                local pos = TensorCore.getPosInDirection(startPos, heading, -3)\n                Argus2.addTimedArrowFilled(\n                        15000,\n                        pos.x, 0, pos.z,\n                        5,\n                        2.5,\n                        3,\n                        4,\n                        heading,\n                        GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                        GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                        GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 0, 0 / 255, 0.2),\n                        0,\n                        nil,\n                        nil,\n                        GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1),\n                        1.0,\n                        3,\n                        0.05,\n                        false\n                )\n            end\n        end\n        local clock = M.GetClock(TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[3]).pos,\n                TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[5]).pos)\n        -- 非标准坐标系，叉乘结果要反着来\n        if clock then\n            M.Debug(\"顺时针\")\n        else\n            M.Debug(\"逆时针\")\n        end\n        -- 画出方向箭头\n        drawClock(clock, 3)\n        drawClock(clock, 4)\n\n        local firstDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 },\n                TensorCore.mGetEntity(data.MuAiGd_P3_2_Ids[3]).pos)\n        if firstDir > math.pi then\n            firstDir = firstDir - math.pi\n        elseif M.IsSame(firstDir, math.pi) then\n            firstDir = 0\n        end\n        local headTh, headDps\n        if M.Config.FruCfg.ApocalypseType == 1 then\n            --- 特殊情况，13逆\n            if M.IsSame(firstDir, math.pi * 3 / 4) and not clock then\n                headTh = math.pi / 2\n                headDps = math.pi * 3 / 2\n            elseif M.IsSame(firstDir, math.pi / 2) and clock then\n                -- 特殊情况2，BD顺\n                headTh = math.pi * 7 / 4\n                headDps = math.pi * 3 / 4\n            else\n                local headDir1\n                local headDir2\n                if clock then\n                    headDir1 = M.SetHeading2Pi(firstDir + math.pi / 4)\n                    headDir2 = M.SetHeading2Pi(firstDir + math.pi * 5 / 4)\n                else\n                    headDir1 = M.SetHeading2Pi(firstDir - math.pi / 4)\n                    headDir2 = M.SetHeading2Pi(firstDir - math.pi * 5 / 4)\n                end\n                --- b2c3\n                if M.IsSame(headDir1, 0)\n                        or M.IsSame(headDir1, math.pi / 4)\n                        or M.IsSame(headDir1, math.pi / 2)\n                        or M.IsSame(headDir1, math.pi * 7 / 4)\n                then\n                    headTh = headDir2\n                    headDps = headDir1\n                else\n                    headTh = headDir1\n                    headDps = headDir2\n                end\n            end\n        elseif M.Config.FruCfg.ApocalypseType == 2 then\n            local headDir1\n            local headDir2\n            if clock then\n                headDir1 = M.SetHeading2Pi(firstDir + math.pi / 4)\n                headDir2 = M.SetHeading2Pi(firstDir + math.pi * 5 / 4)\n            else\n                headDir1 = M.SetHeading2Pi(firstDir - math.pi / 4)\n                headDir2 = M.SetHeading2Pi(firstDir - math.pi * 5 / 4)\n            end\n            if headDir1 > math.pi * 5 / 8 and headDir1 < math.pi * 13 / 8 then\n                headTh = headDir1\n                headDps = headDir2\n            else\n                headTh = headDir2\n                headDps = headDir1\n            end\n        end\n        local posTable\n        if clock then\n            posTable = {\n                [\"MT\"] = { h = headTh, r = 10 },\n                [\"ST\"] = { h = headTh + math.pi / 4, r = 10 },\n                [\"H1\"] = { h = headTh - math.pi / 14, r = 18 },\n                [\"H2\"] = { h = headTh + math.pi / 14, r = 18 },\n                [\"D1\"] = { h = headDps, r = 10 },\n                [\"D2\"] = { h = headDps + math.pi / 4, r = 10 },\n                [\"D3\"] = { h = headDps - math.pi / 14, r = 18 },\n                [\"D4\"] = { h = headDps + math.pi / 14, r = 18 },\n            }\n        else\n            posTable = {\n                [\"MT\"] = { h = headTh - math.pi / 4, r = 10 },\n                [\"ST\"] = { h = headTh, r = 10 },\n                [\"H1\"] = { h = headTh - math.pi / 14, r = 18 },\n                [\"H2\"] = { h = headTh + math.pi / 14, r = 18 },\n                [\"D1\"] = { h = headDps - math.pi / 4, r = 10 },\n                [\"D2\"] = { h = headDps, r = 10 },\n                [\"D3\"] = { h = headDps - math.pi / 14, r = 18 },\n                [\"D4\"] = { h = headDps + math.pi / 14, r = 18 },\n            }\n        end\n        local Th = { \"MT\", \"ST\", \"H1\", \"H2\" }\n        local endHeading\n        if table.contains(Th, data.MuAiGd_P3_2_SelfJob) then\n            endHeading = headTh\n        else\n            endHeading = headDps\n        end\n        local point = M.GetGamePointByHeading(M.Config.FruCfg.PosInfo, endHeading)\n        M.Info(\"前往\" .. point .. \"点附近分散。\")\n        data.MuAiGd_P3_2_MoveInHeading = endHeading\n        local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 },\n                posTable[data.MuAiGd_P3_2_SelfJob].h, posTable[data.MuAiGd_P3_2_SelfJob].r)\n        M.DirectTo(targetPos.x, targetPos.z, 10000)\n        data.MuAiGd_P3_2_GroundFireFinish = true\n        -- 如果是引导T，分摊在引导位置\n        if M.SelfPos == \"MT\" and M.Config.FruCfg.P3DarkestDanceTaker == 1\n                or M.SelfPos == \"ST\" and M.Config.FruCfg.P3DarkestDanceTaker == 2 then\n            local selfDir = posTable[M.SelfPos].h\n            local dir1 = M.SetHeading2Pi(firstDir + math.pi / 2)\n            local dir2 = M.SetHeading2Pi(firstDir - math.pi / 2)\n            if math.abs(dir1 - selfDir) < math.abs(dir2 - selfDir) then\n                data.MuAiGd_P3_2_MTHeading = dir1\n            else\n                data.MuAiGd_P3_2_MTHeading = dir2\n            end\n            data.MuAiGd_P3_2_MoveInHeading = data.MuAiGd_P3_2_MTHeading\n        end\n        M.Debug(\"地火指路完成！\")\n    end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"b4440130-996c-831d-9851-dde30a35e355",
									true,
								},
								
								{
									"b5110e97-4ee4-88ed-a600-ed8bb2f16726",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_CD",
							name = "Apocalypse_jp",
							uuid = "2e3d3a95-ecba-0df4-91b0-0315322c9003",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruCfg.ApocalypseGroupType == 3",
							name = "日基",
							uuid = "b4440130-996c-831d-9851-dde30a35e355",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_P3_2_SelfJob ~= nil",
							name = "已计算好分散位置",
							uuid = "b5110e97-4ee4-88ed-a600-ed8bb2f16726",
							version = 2,
						},
					},
				},
				eventType = 19,
				loop = true,
				mechanicTime = 619.6,
				name = "[MuAiGuide]P3-地火(日基)",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 26,
				timerStartOffset = -30,
				uuid = "96eb4878-2204-7b0d-9a38-684e70532a5e",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[145] = 
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P3_ChangePositionFinish == nil then\n    data.MuAiGd_P3_ChangePositionFinish = true\nend\n\nif M.Config.FruCfg.ApocalypseChangePos == 2 then\n    local LeftGroup = {}\n    local RightGroup = {}\n    M.Info(\"位置调整：。\")\n    for i = 1, 8 do\n        local jobName = M.JobPosName[i]\n        local party = M.Party[jobName]\n        local curPlayer = TensorCore.mGetEntity(party.id)\n        if data.MuAiGd_P3_2_PlayerBuffType[jobName].IsLeft then\n            table.insert(LeftGroup, { pos = curPlayer.pos, job = jobName })\n        else\n            table.insert(RightGroup, { pos = curPlayer.pos, job = jobName })\n        end\n    end\n    local group\n    local isLeft = data.MuAiGd_P3_2_PlayerBuffType[M.SelfPos].IsLeft\n    if isLeft then\n        group = LeftGroup\n    else\n        group = RightGroup\n    end\n\n    table.sort(group, function(a, b)\n        return a.pos.z < b.pos.z\n    end)\n\n    local top1, top2 = group[1], group[2]\n    local topLeft, topRight\n    if top1.pos.x < top2.pos.x then\n        topLeft = top1\n        topRight = top2\n    else\n        topLeft = top2\n        topRight = top1\n    end\n    local bottom1, bottom2 = group[3], group[4]\n    local bottomLeft, bottomRight\n    if bottom1.pos.x < bottom2.pos.x then\n        bottomLeft = bottom1\n        bottomRight = bottom2\n    else\n        bottomLeft = bottom2\n        bottomRight = bottom1\n    end\n\n    if topLeft.job == M.SelfPos then\n        -- 左上\n        if isLeft then\n            data.MuAiGd_P3_2_SelfJob = \"H1\"\n        else\n            data.MuAiGd_P3_2_SelfJob = \"D2\"\n        end\n    elseif topRight.job == M.SelfPos then\n        -- 右上\n        if isLeft then\n            data.MuAiGd_P3_2_SelfJob = \"MT\"\n        else\n            data.MuAiGd_P3_2_SelfJob = \"D4\"\n        end\n    elseif bottomLeft.job == M.SelfPos then\n        -- 左下\n        if isLeft then\n            data.MuAiGd_P3_2_SelfJob = \"H2\"\n        else\n            data.MuAiGd_P3_2_SelfJob = \"D1\"\n        end\n    elseif bottomRight.job == M.SelfPos then\n        -- 右下\n        if isLeft then\n            data.MuAiGd_P3_2_SelfJob = \"ST\"\n        else\n            data.MuAiGd_P3_2_SelfJob = \"D3\"\n        end\n    end\n    local info\n    if data.MuAiGd_P3_2_SelfJob == \"MT\" or data.MuAiGd_P3_2_SelfJob == \"D1\" then\n        info = \"左上\"\n    elseif data.MuAiGd_P3_2_SelfJob == \"ST\" or data.MuAiGd_P3_2_SelfJob == \"D2\" then\n        info = \"右上\"\n    elseif data.MuAiGd_P3_2_SelfJob == \"H1\" or data.MuAiGd_P3_2_SelfJob == \"D3\" then\n        info = \"左下\"\n    elseif data.MuAiGd_P3_2_SelfJob == \"H2\" or data.MuAiGd_P3_2_SelfJob == \"D4\" then\n        info = \"右下\"\n    end\n    local info2\n    if isLeft then\n        info2 = \"左侧\"\n    else\n        info2 = \"右侧\"\n    end\n    M.Info(\"最终站位：\" .. info2 .. \"，面向BOSS\" .. info .. \"方向（原\" .. data.MuAiGd_P3_2_SelfJob .. \"位）。\")\nelseif M.Config.FruCfg.ApocalypseGroupType == 2 then\n    M.Info(\"根据标记调整位置: \")\n    if M.GetPlayer().marker ~= nil and M.GetPlayer().marker > 0 then\n        if M.GetPlayer().marker == 1 then\n            data.MuAiGd_P3_2_SelfJob = \"MT\"\n            M.Info(\"稍后左侧，出去分散。\")\n        elseif M.GetPlayer().marker == 2 then\n            data.MuAiGd_P3_2_SelfJob = \"ST\"\n            M.Info(\"稍后左侧，安全区上侧分散。\")\n        elseif M.GetPlayer().marker == 3 then\n            data.MuAiGd_P3_2_SelfJob = \"H1\"\n            M.Info(\"稍后左侧，安全区左下分散。\")\n        elseif M.GetPlayer().marker == 4 then\n            data.MuAiGd_P3_2_SelfJob = \"H2\"\n            M.Info(\"稍后左侧，安全区右下分散。\")\n        elseif M.GetPlayer().marker == 6 then\n            data.MuAiGd_P3_2_SelfJob = \"D1\"\n            M.Info(\"稍后右侧，出去分散。\")\n        elseif M.GetPlayer().marker == 7 then\n            data.MuAiGd_P3_2_SelfJob = \"D2\"\n            M.Info(\"稍后右侧，安全区上侧分散。\")\n        elseif M.GetPlayer().marker == 8 then\n            data.MuAiGd_P3_2_SelfJob = \"D3\"\n            M.Info(\"稍后右侧，安全区左下分散。\")\n        else\n            data.MuAiGd_P3_2_SelfJob = \"D4\"\n            M.Info(\"稍后右侧，安全区右下分散。\")\n        end\n    else\n        M.Info(\"科技寄了，自己看吧。\")\n    end\nend\nlocal pos\n--- 计算分散位置\nif M.Config.FruCfg.ApocalypseGroupType == 1 or M.Config.FruCfg.ApocalypseGroupType == 2 then\n    local pPos = MuAiGuide.GetPlayer().pos\n    if data.MuAiGd_P3_2_SelfJob == \"MT\" then\n        pos = { x = pPos.x, z = 90 }\n    elseif data.MuAiGd_P3_2_SelfJob == \"ST\" then\n        pos = { x = pPos.x, z = 110 }\n    elseif data.MuAiGd_P3_2_SelfJob == \"D1\" then\n        pos = { x = pPos.x, z = 110 }\n    elseif data.MuAiGd_P3_2_SelfJob == \"D2\" then\n        pos = { x = pPos.x, z = 90 }\n    elseif data.MuAiGd_P3_2_SelfJob == \"H1\" then\n        pos = { x = 84, z = 92 }\n    elseif data.MuAiGd_P3_2_SelfJob == \"H2\" then\n        pos = { x = 84, z = 108 }\n    elseif data.MuAiGd_P3_2_SelfJob == \"D3\" then\n        pos = { x = 116, z = 108 }\n    elseif data.MuAiGd_P3_2_SelfJob == \"D4\" then\n        pos = { x = 116, z = 92 }\n    end\nelseif M.Config.FruCfg.ApocalypseGroupType == 3 then\n    -- 日基不写了\nelseif M.Config.FruCfg.ApocalypseGroupType == 4 then\n    -- 双分组\n    local isLeft = data.MuAiGd_P3_2_PlayerBuffType[M.SelfPos].IsLeft\n    if data.MuAiGd_P3_2_SelfJob == \"MT\" then\n        pos = { x = 100, z = 92 }\n    elseif data.MuAiGd_P3_2_SelfJob == \"ST\" then\n        pos = { x = 100, z = 100 }\n    elseif data.MuAiGd_P3_2_SelfJob == \"D1\" then\n        if isLeft then\n            pos = { x = 92, z = 100 }\n        else\n            pos = { x = 108, z = 100 }\n        end\n    elseif data.MuAiGd_P3_2_SelfJob == \"D2\" then\n        pos = { x = 100, z = 108 }\n    elseif data.MuAiGd_P3_2_SelfJob == \"H1\" then\n        pos = { x = 82, z = 100 }\n    elseif data.MuAiGd_P3_2_SelfJob == \"H2\" then\n        if isLeft then\n            pos = { x = 91, z = 91 }\n        else\n            pos = { x = 109, z = 91 }\n        end\n    elseif data.MuAiGd_P3_2_SelfJob == \"D3\" then\n        if isLeft then\n            pos = { x = 91, z = 109 }\n        else\n            pos = { x = 109, z = 109 }\n        end\n    elseif data.MuAiGd_P3_2_SelfJob == \"D4\" then\n        pos = { x = 118, z = 100 }\n    end\nend\nif pos then\n    M.DirectTo(pos.x, pos.z, 1700)\nend\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "07213bd5-0834-42f2-b614-68d5cf3437ce",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 623,
				name = "[MuAiGuide]分散",
				timelineIndex = 145,
				timerOffset = -0.5,
				uuid = "5f4e635a-d88f-61b8-a3f8-297445f322ba",
				version = 2,
			},
			inheritedIndex = 1,
		},
	},
	[148] = 
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
							actionLua = "local pos\nlocal endHeading\nif MuAiGuide.Config.FruCfg.ApocalypseGroupType == 4 then\n    local heading1 = MuAiGuide.SetHeading2Pi(data.MuAiGd_P3_2_MoveInHeading)\n    local heading2 = MuAiGuide.SetHeading2Pi(data.MuAiGd_P3_2_MoveInHeading + math.pi)\n    local leftHeading, rightHeading\n    if heading1 < heading2 then\n        leftHeading = heading1\n        rightHeading = heading2\n    else\n        leftHeading = heading2\n        rightHeading = heading1\n    end\n\n    if data.MuAiGd_P3_2_PlayerBuffType[MuAiGuide.SelfPos].IsLeft then\n        endHeading = leftHeading\n    else\n        endHeading = rightHeading\n    end\n    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, data.MuAiGd_P3_2_MoveInHeading, 4)\nelse\n    endHeading = data.MuAiGd_P3_2_MoveInHeading\nend\npos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, endHeading, 4)\nMuAiGuide.Info(\"场中分组分摊。\")\nMuAiGuide.DirectTo(pos.x, pos.z, 6000, 0.5)\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "961624f1-9bcb-a5ac-9c6e-1650ebc5ae27",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 635.4,
				name = "[MuAiGuide]场中分组分摊",
				randomOffset = 1,
				timelineIndex = 148,
				uuid = "dd3ad00f-86f5-46f4-8b5f-9f1b3f140f5a",
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
							actionID = 3,
							allowInterrupt = true,
							atomicPriority = true,
							gVar = "ACR_TensorRequiem3_CD",
							ignoreWeaveRules = true,
							uuid = "ce55794f-8687-bdf2-b23f-58722ef7248a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							conditionType = 6,
							inRangeValue = 10,
							uuid = "0cafd4d1-998e-3408-aaae-95101e215085",
							version = 2,
						},
					},
				},
				mechanicTime = 635.4,
				name = "[MuAiGuide]疾跑",
				timelineIndex = 148,
				timerEndOffset = 40,
				timerOffset = -1,
				uuid = "5b398631-98f6-af5e-a48b-b584d928e6b1",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[149] = 
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
							actionLua = "if MuAiGuide.SelfPos == \"MT\" and MuAiGuide.Config.FruCfg.P3DarkestDanceTaker == 1\n        or MuAiGuide.SelfPos == \"ST\" and MuAiGuide.Config.FruCfg.P3DarkestDanceTaker == 2\nthen\n    local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, data.MuAiGd_P3_2_MTHeading, 19)\n    MuAiGuide.Info(\"远离引导跳跃。\")\n    MuAiGuide.DirectTo(pos.x, pos.z, 2000, 0.5)\nend\nself.used = true\n ",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "404c2b89-13f1-141b-a6fd-aff6ed9dfca7",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 642.1,
				name = "[MuAiGuide]T远离引导跳跃",
				timelineIndex = 149,
				uuid = "72261fa9-7173-7feb-88c9-529ebc9fec51",
				version = 2,
			},
		},
	},
	[151] = 
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
							actionLua = "if data.MuAiGd_KnockBackTime == nil then\n    data.MuAiGd_KnockBackTime = Now()\n    if data.MuAiGd_P3_2_PlayerBuffType[MuAiGuide.SelfPos].IsLeft\n            or data.MuAiGd_P3_2_PlayerBuffType[MuAiGuide.SelfPos].IsUp then\n        MuAiGuide.Info(\"BOSS左后击退。\", true)\n    else\n        MuAiGuide.Info(\"BOSS右后击退。\", true)\n    end\nend\n\n\nif data.MuAiGd_P3_BOSS == nil then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9832\")) do\n        if Argus.isEntityVisible(ent) then\n            data.MuAiGd_P3_BOSS = ent\n            break\n        end\n    end\nend\n\nif data.MuAiGd_P3_BOSS then\n    local isLeadTank = (MuAiGuide.SelfPos == \"MT\" and MuAiGuide.Config.FruConfig.P3DarkestDanceTaker == 1\n            or MuAiGuide.SelfPos == \"ST\" and MuAiGuide.Config.FruConfig.P3DarkestDanceTaker == 2)\n    if not isLeadTank or TimeSince(data.MuAiGd_KnockBackTime) > 2000 then\n        local pos = TensorCore.mGetEntity(data.MuAiGd_P3_BOSS.id).pos\n        local endHeading\n        if data.MuAiGd_P3_2_PlayerBuffType[MuAiGuide.SelfPos].IsLeft\n                or data.MuAiGd_P3_2_PlayerBuffType[MuAiGuide.SelfPos].IsUp then\n            endHeading = pos.h + math.pi * 15 / 18\n        else\n            endHeading = pos.h - math.pi * 15 / 18\n        end\n        local endPos = TensorCore.getPosInDirection(pos, endHeading, 2)\n        MuAiGuide.FrameDirect(endPos.x, endPos.z, 0.3)\n    end\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "b6db2169-6a93-ee27-9d27-151e7ba3b19e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 647.2,
				name = "[MuAiGuide]P3地火后击退",
				timeRange = true,
				timelineIndex = 151,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "c3ef09e4-5ecd-9479-809f-968a156f87a3",
				version = 2,
			},
		},
	},
	[152] = 
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
							actionLua = "local selfState = data.MuAiGd_P3_2_PlayerBuffType[MuAiGuide.SelfPos]\nif selfState.Type == 3 then\n    -- 长水\n    local bossPos = TensorCore.mGetEntity(data.MuAiGd_P3_BOSS.id).pos\n    local bossHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 } , bossPos)\n    local endHeading \n    if selfState.IsLeft or selfState.IsUp then\n        endHeading = bossHeading + math.pi * 3 / 4\n    else\n        endHeading = bossHeading - math.pi * 3 / 4\n    end\n    local endPos = TensorCore.getPosInDirection(bossPos, endHeading, 6.5)\n    MuAiGuide.DirectTo(endPos.x, endPos.z, 4000)\nelse\n    local targetJob\n    for job, state in pairs(data.MuAiGd_P3_2_PlayerBuffType) do\n        if state.Type == 3\n                and job ~= MuAiGuide.SelfPos\n                and\n                ((MuAiGuide.Config.FruCfg.ApocalypseGroupType ~= 3 and selfState.IsLeft == state.IsLeft)\n                        or (MuAiGuide.Config.FruCfg.ApocalypseGroupType == 3 and selfState.IsUp == state.IsUp))\n        then\n            targetJob = job\n            break\n        end\n    end\n    local id = MuAiGuide.Party[targetJob].id\n    MuAiGuide.DirectToEnt(id, 4000)\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "5805cf91-906a-2e91-987a-4a2ac0c401e7",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 651.2,
				name = "[MuAiGuide]击退后分摊",
				timelineIndex = 152,
				timerOffset = -4,
				uuid = "3014db00-9808-8e92-ace6-085fd57dd984",
				version = 2,
			},
		},
	},
	[166] = 
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
							actionLua = "local guideTime = 7000\nlocal posTable = { \n\t{x = 94, z = 94 },\n\t{x = 98, z = 94 },\n\t{x = 102, z = 94 },\n\t{x = 106, z = 94 },\n\t{x = 94, z = 106 },\n\t{x = 98, z = 106 },\n\t{x = 102, z = 106 },\n\t{x = 106, z = 106 },\n }\nlocal posOrder = MuAiGuide.Config.FruCfg.DarkLitOrder\nlocal selfIndex = MuAiGuide.IndexOf(posOrder, MuAiGuide.SelfPos)\nlocal targetPos = posTable[selfIndex]\nMuAiGuide.DirectTo(targetPos.x, targetPos.z, guideTime)\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2c6c86ae-6749-6a77-aeb1-91f0780115eb",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 738.2,
				name = "[MuAiGuide]光暗龙诗-预站位",
				timelineIndex = 166,
				timerOffset = -7,
				uuid = "88dd1ea6-adaf-7409-a9c7-2f88f0378a72",
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
							actionLua = "local buffId1 = 2253 -- 锁链\nlocal buffId2 = 2461 -- 水\nlocal lineId = 110;\n\n-- 8方=> 翻花绳/ 换位 踩塔/引导 => 8方 => 左右刀 => 分摊 => A/C 或者 T 引导\nlocal M = MuAiGuide\n-- 找出ABCD\nlocal groupTH = {}\nlocal groupD = {}\nfor i = 1, 8 do\n    if i <= 4 then\n        table.insert(groupTH, M.Config.FruCfg.DarkLitOrder[i])\n    else\n        table.insert(groupD, M.Config.FruCfg.DarkLitOrder[i])\n    end\nend\n\nlocal noLinkTH = {}\nlocal noLinkD = {}\nlocal waterMarked = {}\nlocal A, B, C, D\n\nlocal jobOrder = M.Append(groupTH, groupD)\nfor i = 1, #jobOrder do\n    local jobPos = jobOrder[i]\n    local ent = M.Party[jobPos]\n    local buff = TensorCore.getBuff(ent.id, buffId1)\n    local buff2 = TensorCore.getBuff(ent.id, buffId2)\n    if buff then\n        M.Debug(jobPos .. \" 连线点名\")\n        if table.contains(groupTH, jobPos) then\n            if A == nil then\n                A = { player = ent, pos = \"A\", job = jobPos }\n            else\n                B = { player = ent, pos = \"B\", job = jobPos }\n            end\n        elseif table.contains(groupD, jobPos) then\n            if C == nil then\n                C = { player = ent, pos = \"C\", job = jobPos }\n            else\n                D = { player = ent, pos = \"D\", job = jobPos }\n            end\n        end\n    else\n        if M.IsDps(ent.job) then\n            table.insert(noLinkD, jobPos)\n        else\n            table.insert(noLinkTH, jobPos)\n        end\n    end\n    if buff2 then\n        M.Debug(jobPos .. \" 分摊点名\")\n        table.insert(waterMarked, jobPos)\n    end\nend\nlocal IsLinked = function(startEnt, entEnt)\n    local tethers = Argus.getTethersOnEnt(startEnt.player.id)\n    for _, tether in pairs(tethers) do\n        if tether.type == lineId and tether.partnerid == entEnt.player.id then\n            return true\n        end\n    end\n    return false\nend\n\n--[[ 判断形状\n 假设连线人从上到下从左到右分别为ABCD\n 1. AB 存在 AC 存在 => 四边形  => AC 互换\n 2. AD 存在 BC 存在 =>交叉\n    2.1 AB存在 => 沙漏   =>BC 互换\n    2.2 AC存在 => 蝴蝶结\n]]\n\nlocal abIsLink = IsLinked(A, B)\nlocal acIsLink = IsLinked(A, C)\nlocal isCross = IsLinked(A, D) and IsLinked(B, C, lineId)\n\nlocal GroupUp = {}\nlocal GroupDown = {}\n-- 类型 1 蝴蝶结 2 四边形，3 沙漏\nlocal type\nif isCross then\n    if acIsLink then\n        type = 1\n        local msg = \"蝴蝶结, 不换\"\n        M.Debug(msg)\n        M.Info(msg, true)\n        GroupUp = { noLinkTH[1], A.job, B.job, noLinkTH[2] }\n        GroupDown = { noLinkD[1], C.job, D.job, noLinkD[2] }\n    elseif abIsLink then\n        local msg = \"沙漏, \" .. B.job .. \"和\" .. C.job .. \"互换\"\n        M.Debug(msg)\n        M.Info(msg, true)\n        GroupUp = { noLinkTH[1], A.job, C.job, noLinkTH[2] }\n        GroupDown = { noLinkD[1], B.job, D.job, noLinkD[2] }\n        type = 3\n    end\nelse\n    if M.Config.FruCfg.DarkLitChangeType == 1 then\n        local msg = \"四边形, \" .. A.job .. \"和\" .. C.job .. \"互换！\"\n        M.Debug(msg)\n        M.Info(msg, true)\n        GroupUp = { noLinkTH[1], C.job, B.job, noLinkTH[2] }\n        GroupDown = { noLinkD[1], A.job, D.job, noLinkD[2] }\n    else\n        local msg = \"四边形, \" .. B.job .. \"和\" .. D.job .. \"互换！\"\n        M.Debug(msg)\n        M.Info(msg, true)\n        GroupUp = { noLinkTH[1], A.job, D.job, noLinkTH[2] }\n        GroupDown = { noLinkD[1], C.job, B.job, noLinkD[2] }\n    end\n    type = 2\nend\n\nM.Debug(\"上部翻花绳后分组: \" .. M.StringJoin(GroupUp, \",\"))\nM.Debug(\"下部翻花绳后分组: \" .. M.StringJoin(GroupDown, \",\"))\n\n-- 分析BUFF, 看看2个水是否在同侧\n\nlocal finalGroupUp\nlocal finalGroupDown\n\n-- 检查上组\nif table.contains(GroupUp, waterMarked[1]) and table.contains(GroupUp, waterMarked[2]) then\n    if table.contains(waterMarked, GroupUp[1]) then\n        finalGroupUp = { GroupDown[1], GroupUp[2], GroupUp[3], GroupUp[4] }\n        finalGroupDown = { GroupUp[1], GroupDown[2], GroupDown[3], GroupDown[4] }\n    else\n        finalGroupUp = { GroupUp[1], GroupUp[2], GroupUp[3], GroupDown[4] }\n        finalGroupDown = { GroupDown[1], GroupDown[2], GroupDown[3], GroupUp[4] }\n    end\nelseif table.contains(GroupDown, waterMarked[1]) and table.contains(GroupDown, waterMarked[2]) then\n    if table.contains(waterMarked, GroupDown[1]) then\n        finalGroupUp = { GroupDown[1], GroupUp[2], GroupUp[3], GroupUp[4] }\n        finalGroupDown = { GroupUp[1], GroupDown[2], GroupDown[3], GroupDown[4] }\n    else\n        finalGroupUp = { GroupUp[1], GroupUp[2], GroupUp[3], GroupDown[4] }\n        finalGroupDown = { GroupDown[1], GroupDown[2], GroupDown[3], GroupUp[4] }\n    end\nelse\n    finalGroupUp = GroupUp\n    finalGroupDown = GroupDown\nend\n\nM.Info(\"上部最终分组: \" .. M.StringJoin(finalGroupUp, \",\"))\nM.Info(\"下部最终分组: \" .. M.StringJoin(finalGroupDown, \",\"))\nM.Debug(\"上部最终分组: \" .. M.StringJoin(finalGroupUp, \",\"))\nM.Debug(\"下部最终分组: \" .. M.StringJoin(finalGroupDown, \",\"))\n-- C 逆时针\ndata.MuAiGd_P4_1_OrderPos = {\n    finalGroupDown[3],\n    finalGroupDown[4],\n    finalGroupUp[4],\n    finalGroupUp[3],\n    finalGroupUp[2],\n    finalGroupUp[1],\n    finalGroupDown[1],\n    finalGroupDown[2],\n}\n\nlocal guideInfo = {\n    { deltaH = -math.pi / 12, distance = 8 },\n    { deltaH = 0,             distance = 4 },\n    { deltaH = 0,             distance = 4 },\n    { deltaH = math.pi / 12,  distance = 6 },\n    { deltaH = -math.pi / 12, distance = 6 },\n    { deltaH = 0,             distance = 4 },\n    { deltaH = 0,             distance = 4 },\n    { deltaH = math.pi / 12,  distance = 8 }\n}\n\nlocal selfIndex = M.IndexOf(data.MuAiGd_P4_1_OrderPos, M.SelfPos)\nlocal selfGuide = guideInfo[selfIndex]\nlocal heading = (selfIndex - 1) * math.pi / 4 + math.pi / 8 + selfGuide.deltaH\nlocal finalPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, selfGuide.distance)\nM.DirectTo(finalPos.x, finalPos.z, 10000)\n\n-- 判断自己组分摊的人是谁\nfor i = 1, #waterMarked do\n    if table.contains(finalGroupUp, M.SelfPos) and table.contains(finalGroupUp, waterMarked[i])\n        or table.contains(finalGroupDown, M.SelfPos) and table.contains(finalGroupDown, waterMarked[i])\n    then\n        data.MuAiGd_P4_1_Converge = waterMarked[i]\n        break\n    end\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "1326ce5d-88b6-3530-ba5c-b4dfef15bb5b",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 738.2,
				name = "[MuAiGuide]光暗龙诗-翻花绳引导光波",
				timelineIndex = 166,
				timerOffset = 2,
				uuid = "1faae67b-df7d-40a7-9f9c-ab5a22a01dde",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[169] = 
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
							actionLua = "local player = MuAiGuide.Party[data.MuAiGd_P4_1_Converge]\nMuAiGuide.DirectToEnt(player.id, 5000)\nself.used = true",
							conditions = 
							{
								
								{
									"b90eac45-89d1-764b-a307-73724fea0087",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "9944cd96-a05b-8bd2-a6fb-97a6bac933c4",
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
							conditionLua = "return MuAiGuide.SelfPos ~= data.MuAiGd_P4_1_Converge",
							uuid = "b90eac45-89d1-764b-a307-73724fea0087",
							version = 2,
						},
					},
				},
				mechanicTime = 752.3,
				name = "[MuAiGuide]光暗龙诗-分摊-点别人",
				timelineIndex = 169,
				timerEndOffset = 5,
				uuid = "7689405b-5111-69a9-a90e-bf0167a9a14d",
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
							actionLua = "local player = TensorCore.mGetEntity(MuAiGuide.GetPlayer().id)\nif eventArgs.spellID == 40228 then\n    MuAiGuide.DirectTo(91, player.pos.z, 5000)\nelse\n    MuAiGuide.DirectTo(109, player.pos.z, 5000)\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"ba71a186-7576-a4f1-b4db-a4de7c0878c2",
									true,
								},
								
								{
									"4cd39d56-1177-db8e-b9b3-a4548e4da94d",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "db26d5ea-358c-ff81-b8b5-01c2ee1a66ed",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							eventArgOptionType = 3,
							eventArgType = 2,
							spellIDList = 
							{
								40228,
								40229,
							},
							uuid = "ba71a186-7576-a4f1-b4db-a4de7c0878c2",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.SelfPos == data.MuAiGd_P4_1_Converge",
							uuid = "4cd39d56-1177-db8e-b9b3-a4548e4da94d",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				eventType = 3,
				mechanicTime = 752.3,
				name = "[MuAiGuide]光暗龙诗-分摊-被点名",
				timelineIndex = 169,
				uuid = "22e4a16a-8d72-cb32-aa4a-8aceeeb76fd0",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "data.MuAiGd_P4_1_SpellID = eventArgs.spellID \nself.used = true",
							conditions = 
							{
								
								{
									"fcda6f0d-3626-6322-83a3-732028ac4d2c",
									true,
								},
							},
							gVar = "ACR_RikuWHM3_CD",
							uuid = "0372657a-808b-c1f7-9bcd-d463a75f7c6a",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "左右刀读条",
							spellIDList = 
							{
								40228,
								40229,
							},
							uuid = "fcda6f0d-3626-6322-83a3-732028ac4d2c",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 752.3,
				name = "[MuAiGuide]左右刀ID读取",
				timeRange = true,
				timelineIndex = 169,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "57bb76b8-c488-bc86-b351-4ce1fc4796a5",
				version = 2,
			},
		},
	},
	[170] = 
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
							actionLua = "local M = MuAiGuide\nlocal isLeadTank = (M.SelfPos == \"MT\" and M.Config.FruCfg.P3DarkestDanceTaker == 1\n        or M.SelfPos == \"ST\" and M.Config.FruCfg.P3DarkestDanceTaker == 2)\nif isLeadTank then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9832\")) do\n        if Argus.isEntityVisible(ent) then\n            data.MuAiGd_P4_BOSS_Gaia = ent\n            break\n        end\n    end\n    if data.MuAiGd_P4_BOSS_Gaia then\n        local maxDistance = 0\n        for i = 1, 8 do\n            local curPos = M.JobPosName[i]\n            if M.SelfPos ~= curPos then\n                local curPlayer = M.Party[curPos]\n                local curEnt = TensorCore.mGetEntity(curPlayer.id)\n                local distance = TensorCore.getDistance2d(curEnt.pos, data.MuAiGd_P4_BOSS_Gaia.pos)\n                if maxDistance < distance then\n                    maxDistance = distance\n                end\n            end\n        end\n\n        local guidePos, up, mid, down\n        if data.MuAiGd_P4_1_SpellID == 40228 then\n            --左半场安全\n            up = { x = 86.3, y = 0, z = 86.3 }\n            mid = { x = 80.5, y = 0, z = 100 }\n            down = { x = 86.3, y = 0, z = 113.7 }\n        else\n            up = { x = 113.7, y = 0, z = 86.3 }\n            mid = { x = 119.5, y = 0, z = 100 }\n            down = { x = 113.7, y = 0, z = 113.7 }\n        end\n        local midDistance = TensorCore.getDistance2d(mid, data.MuAiGd_P4_BOSS_Gaia.pos)\n        if midDistance > maxDistance + 0.5 then\n            guidePos = mid\n        else\n            if data.MuAiGd_P4_BOSS_Gaia.pos.z > 100 and TensorCore.getDistance2d(up, data.MuAiGd_P4_BOSS_Gaia.pos) > maxDistance then\n                guidePos = up\n            elseif data.MuAiGd_P4_BOSS_Gaia.pos.z < 100 and TensorCore.getDistance2d(down, data.MuAiGd_P4_BOSS_Gaia.pos) > maxDistance then\n                guidePos = down\n            end\n        end\n        if guidePos then\n            M.DirectTo(guidePos.x, guidePos.z, 5000)\n        else\n            M.Info(\"未找到合适引导位置，请自行计算！<se.1>\")\n        end\n    end\nelse\n    local player = TensorCore.mGetEntity(M.GetPlayer().id)\n    if data.MuAiGd_P4_1_SpellID == 40228 then\n        M.DirectTo(99, player.pos.z, 5000)\n    else\n        M.DirectTo(101, player.pos.z, 5000)\n    end\nend\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "7210f740-d0f3-2ce3-ba75-b4075af0a2b0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 757.3,
				name = "[MuAiGuide]光暗龙诗-引导",
				timelineIndex = 170,
				uuid = "9e6e5623-ca59-e4d3-9b64-3656ca01e0df",
				version = 2,
			},
		},
	},
	[179] = 
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
							actionLua = "if data.MuAiGd_P4_WaveFrom == nil then\n    data.MuAiGd_P4_WaveFrom = {}\n    data.MuAiGd_P4_WaveGuidePos = -100\nend\n\nif table.size(data.MuAiGd_P4_WaveFrom) < 2 then\n    local entity = TensorCore.mGetEntity(eventArgs.entityID)\n    table.insert(data.MuAiGd_P4_WaveFrom, entity.pos)\n    local cnt = table.size(data.MuAiGd_P4_WaveFrom)\n    if entity.pos.x < 90 then      -- 左边\n        MuAiGuide.Info(\"地火\" .. cnt .. \"来自左边的D方向。\")\n    elseif entity.pos.x > 110 then -- 右边\n        MuAiGuide.Info(\"地火\" .. cnt .. \"来自右边的B方向。\")\n    elseif entity.pos.z < 90 then  -- 上\n        MuAiGuide.Info(\"地火\" .. cnt .. \"来自上边的A方向。\")\n    elseif entity.pos.z > 110 then -- 下\n        MuAiGuide.Info(\"地火\" .. cnt .. \"来自下边的C方向。\")\n    end\n \n    if cnt == 2 then\n        local p1 = data.MuAiGd_P4_WaveFrom[1]\n        local p2 = data.MuAiGd_P4_WaveFrom[2]\n        if MuAiGuide.Config.FruCfg.CrystallizeTimeKnockBack == 1 then --Y字\n            data.MuAiGd_P4_WaveGuideHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, p2)\n        else\n            local centerPoint = { x = (p1.x + p2.x) / 2, y = 0, z = (p1.z + p2.z) / 2 }\n            data.MuAiGd_P4_WaveGuideHeading = MuAiGuide.SetHeading2Pi(TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, centerPoint))\n            local point = MuAiGuide.GetGamePointByHeading(MuAiGuide.Config.FruCfg.PosInfo, data.MuAiGd_P4_WaveGuideHeading)\n            MuAiGuide.Info(\"回返放置位置：\" .. point .. \"点。\")\n        end\n    end\n    self.used = true\nend\n",
							conditions = 
							{
								
								{
									"ff53dc67-78da-a41e-9650-cf4447153514",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "45a12f1f-0bf8-81ba-bd99-4c3227a7db70",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							eventArgType = 2,
							eventSpellID = 40251,
							uuid = "ff53dc67-78da-a41e-9650-cf4447153514",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 798.9,
				name = "[MuAiGuide]查找回返放置位置",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 60,
				timerStartOffset = -1,
				uuid = "8e5f258e-712a-588f-96e1-9fd96100574f",
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
							actionLua = "local Line = Argus2.ShapeDrawer:new(\n    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n    nil,\n    (GUI:ColorConvertFloat4ToU32(1, 1, 1, 0)),\n    (GUI:ColorConvertFloat4ToU32(0, 1, 1, 1)),\n    3\n)\nLine:addTimedCircle(25000, 100, 0, 100, 12.25, 0, false)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "113718ec-237f-9bb4-ba26-6e1b11dd0aad",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 798.9,
				name = "[MuAiGuide]绘制龙头路径",
				timelineIndex = 179,
				uuid = "cdc92c46-49d8-e3e1-905c-c0b07a2d7b69",
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
							actionLua = "data.MuAiGd_p4_MarkTime = Now()\nlocal selfIndex = MuAiGuide.IndexOf(MuAiGuide.JobPosName)\ndata.MuAiGd_p4_MarkTimeOffset = (selfIndex - 1) * 200\nself.used = true",
							endIfUsed = true,
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "8c21bd8d-112c-c0f9-832a-2027386e33fe",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 3,
				mechanicTime = 798.9,
				name = "[MuAiGuide]疯狂摇号-数据定义",
				randomOffset = 10,
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 20,
				timerOffset = 1,
				timerStartOffset = -10,
				uuid = "466b087b-aa2d-4104-9dd1-ca2170c27d68",
				version = 2,
			},
			inheritedIndex = 3,
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
							actionLua = "SendTextCommand(\"/mk attack <me>\")\nMuAiGuide.Info(\"有蓝BUFF，已自动摇号！\")\ndata.MuAiGd_p4_MarkTime = Now()\nself.used = true",
							conditions = 
							{
								
								{
									"1fed5fed-c504-2b7f-9536-3e5d6d8ccaa2",
									true,
								},
								
								{
									"3de1da4c-8b0e-5b71-bf21-51250e66298d",
									true,
								},
								
								{
									"bb517077-607c-691b-b24a-367cf672600b",
									true,
								},
								
								{
									"ffae3ac0-e574-4dc3-9136-c450be890bd0",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "183d8615-93a7-5650-a210-e544cfcfbf34",
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
							conditionLua = "return MuAiGuide.Config.FruCfg.CrystallizeTimeType == 3",
							name = "手摇模式",
							uuid = "1fed5fed-c504-2b7f-9536-3e5d6d8ccaa2",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == nil or TensorCore.mGetPlayer().marker == 0",
							name = "没有标记",
							uuid = "3de1da4c-8b0e-5b71-bf21-51250e66298d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3264,
							category = "Self",
							name = "有蓝BUFF",
							uuid = "bb517077-607c-691b-b24a-367cf672600b",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_p4_MarkTime ~= nil and data.MuAiGd_p4_MarkTimeOffset ~= nil and TimeSince(data.MuAiGd_p4_MarkTime) > data.MuAiGd_p4_MarkTimeOffset",
							name = "延迟时间已到",
							uuid = "ffae3ac0-e574-4dc3-9136-c450be890bd0",
							version = 2,
						},
					},
				},
				loop = true,
				mechanicTime = 798.9,
				name = "[MuAiGuide]疯狂摇号",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 20,
				timerStartOffset = -10,
				uuid = "69755cf1-3e3f-4d1c-a339-8944a8b9274b",
				version = 2,
			},
			inheritedIndex = 4,
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
							actionLua = "local M = MuAiGuide\n\nif data.MuAiGd_P4_Player == nil then\n    data.MuAiGd_P4_ManualMarks = {}\n    data.MuAiGd_P4_BuffCollected = false\n    data.MuAiGd_P4_Player = {}\n    data.MuAiGd_P4_Player.Ice1 = nil\n    data.MuAiGd_P4_Player.Ice2 = nil\n    data.MuAiGd_P4_Player.Ice3 = nil\n    data.MuAiGd_P4_Player.Wind1 = nil\n    data.MuAiGd_P4_Player.Wind2 = nil\n    data.MuAiGd_P4_Player.Water = nil\n    data.MuAiGd_P4_Player.Flame = nil\n    data.MuAiGd_P4_Player.Converge = nil\n    data.MuAiGd_P4_Player.GroupWind = nil\n    --- 1:捡D，2:捡B，3:捡3，4:捡4，5:左龙撞头，6:右龙撞头，7:左下撞龙头，8:右下撞龙头，\n    data.MuAiGd_P4_SelfGuideType = 0\n    data.MuAiGd_P4_InfoGuideType = function()\n        if data.MuAiGd_P4_SelfGuideType == 1 then\n            return \"左侧拾取贡品。\"\n        elseif data.MuAiGd_P4_SelfGuideType == 2 then\n            return \"右侧拾取贡品。\"\n        elseif data.MuAiGd_P4_SelfGuideType == 3 then\n            return \"右下拾取贡品。\"\n        elseif data.MuAiGd_P4_SelfGuideType == 4 then\n            return \"左下拾取贡品。\"\n        elseif data.MuAiGd_P4_SelfGuideType == 5 then\n            return \"撞龙左侧头。\"\n        elseif data.MuAiGd_P4_SelfGuideType == 6 then\n            return \"撞右侧龙头。\"\n        elseif data.MuAiGd_P4_SelfGuideType == 7 then\n            return \"撞左下龙头。\"\n        elseif data.MuAiGd_P4_SelfGuideType == 8 then\n            return \"撞右下龙头。\"\n        end\n        return \"未知类型。\"\n    end\nend\n\n--- 固定位置转换到类型\nlocal FixToType = function(buffId)\n    for i = 1, 4 do\n        local configId = tonumber(M.Config.FruCfg.CrystallizeTimeByBuff[i])\n        if configId == buffId then\n            return i\n        end\n    end\n    return 0\nend\n\nif not data.MuAiGd_P4_BuffCollected then\n    local order = MuAiGuide.Config.FruCfg.CrystallizeTimePriority\n    for i = 1, #order do\n        local job = order[i]\n        local player = M.Party[job]\n\n        local claw3263 = TensorCore.getBuff(player.id, 3263)\n        local booth3264 = TensorCore.getBuff(player.id, 3264)\n\n        local wind2463 = TensorCore.getBuff(player.id, 2463)\n        local ice2462 = TensorCore.getBuff(player.id, 2462)\n        local flame2460 = TensorCore.getBuff(player.id, 2460)\n        local water2461 = TensorCore.getBuff(player.id, 2461)\n        local converge2454 = TensorCore.getBuff(player.id, 2454)\n\n        if ice2462 then\n            if claw3263 then\n                if data.MuAiGd_P4_Player.Ice1 == nil then\n                    data.MuAiGd_P4_Player.Ice1 = player\n                    if MuAiGuide.IsMe(player) then\n                        data.MuAiGd_P4_SelfGuideType = 5\n                        M.Info(\"当前BUFF类型: 红冰, \" .. data.MuAiGd_P4_InfoGuideType())\n                    end\n                    if M.Config.FruCfg.CrystallizeTimeMark then\n                        M.MarkParty(6, player.id)\n                    end\n                else\n                    data.MuAiGd_P4_Player.Ice2 = player\n                    if MuAiGuide.IsMe(player) then\n                        data.MuAiGd_P4_SelfGuideType = 6\n                        M.Info(\"当前BUFF类型: 红冰, \" .. data.MuAiGd_P4_InfoGuideType())\n                    end\n                    if M.Config.FruCfg.CrystallizeTimeMark then\n                        M.MarkParty(7, player.id)\n                    end\n                end\n            else\n                if booth3264 then\n                    data.MuAiGd_P4_Player.Ice3 = player\n                    if MuAiGuide.IsMe(player) then\n                        data.MuAiGd_P4_SelfGuideType = FixToType(2462)\n                        M.Info(\"当前BUFF类型: 蓝冰, 人群=>\" .. data.MuAiGd_P4_InfoGuideType())\n                    end\n                    if M.Config.FruCfg.CrystallizeTimeMark then\n                        M.MarkParty(3, player.id)\n                    end\n                end\n            end\n        end\n        if wind2463 then\n            if data.MuAiGd_P4_Player.Wind1 == nil then\n                data.MuAiGd_P4_Player.Wind1 = player\n                if MuAiGuide.IsMe(player) then\n                    data.MuAiGd_P4_SelfGuideType = 7\n                    M.Info(\"当前BUFF类型: 红风, \" .. data.MuAiGd_P4_InfoGuideType())\n                end\n                if M.Config.FruCfg.CrystallizeTimeMark then\n                    M.MarkParty(9, player.id)\n                end\n            else\n                data.MuAiGd_P4_Player.Wind2 = player\n                if MuAiGuide.IsMe(player) then\n                    data.MuAiGd_P4_SelfGuideType = 8\n                    M.Info(\"当前BUFF类型: 红风, \" .. data.MuAiGd_P4_InfoGuideType())\n                end\n                if M.Config.FruCfg.CrystallizeTimeMark then\n                    M.MarkParty(10, player.id)\n                end\n            end\n        end\n        if water2461 then\n            data.MuAiGd_P4_Player.Water = player\n            if MuAiGuide.IsMe(player) then\n                data.MuAiGd_P4_SelfGuideType = FixToType(2461)\n                M.Info(\"当前BUFF类型: 蓝水, 人群=>\" .. data.MuAiGd_P4_InfoGuideType())\n            end\n            if M.Config.FruCfg.CrystallizeTimeMark then\n                M.MarkParty(4, player.id)\n            end\n        end\n        if flame2460 then\n            data.MuAiGd_P4_Player.Flame = player\n            if MuAiGuide.IsMe(player) then\n                data.MuAiGd_P4_SelfGuideType = FixToType(2460)\n                M.Info(\"当前BUFF类型: 蓝暗, 单走=>\" .. data.MuAiGd_P4_InfoGuideType())\n            end\n            if M.Config.FruCfg.CrystallizeTimeMark then\n                M.MarkParty(1, player.id)\n            end\n        end\n        if converge2454 then\n            data.MuAiGd_P4_Player.Converge = player\n            if MuAiGuide.IsMe(player) then\n                data.MuAiGd_P4_SelfGuideType = FixToType(2454)\n                M.Info(\" 当前BUFF类型: 蓝分摊, 人群=>\" .. data.MuAiGd_P4_InfoGuideType())\n            end\n            if M.Config.FruCfg.CrystallizeTimeMark then\n                M.MarkParty(2, player.id)\n            end\n        end\n    end\n    data.MuAiGd_P4_BuffCollected = true\n    self.used = true\nend",
							gVar = "ACR_TensorMagnum3_CD",
							uuid = "2fbf2e9f-9dc2-7001-9365-919010343d26",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 3,
				mechanicTime = 804.9,
				name = "[MuaiGuide]初始BUFF数据收集",
				randomOffset = 30,
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 30,
				timerOffset = -4,
				timerStartOffset = -4,
				uuid = "b9d38afd-6893-80eb-a67e-0caf590425d5",
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
							actionLua = "local guideTime = 10000\nif data.MuAiGd_P4_Lights == nil then\n    data.MuAiGd_P4_Lights = {}\n    --- 场地类型 1:左上紫色，2:右上紫色\n    data.MuAiGd_P4_GroundType = 0\nend\nlocal M = MuAiGuide\n-- 采集灯\nif table.size(data.MuAiGd_P4_Lights) < 6 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=9823\")) do\n        data.MuAiGd_P4_Lights[ent.id] = ent\n    end\nend\nif table.size(data.MuAiGd_P4_Lights) == 6 then\n    local purpleLines = {}\n    for _, light in pairs(data.MuAiGd_P4_Lights) do\n        local lines = Argus.getTethersOnEnt(light.id)\n        for _, line in pairs(lines) do\n            if line.type == 133 then\n                purpleLines[light.id] = light\n            end\n        end\n    end\n    if table.size(purpleLines) == 2 then\n        for _, purpleLine in pairs(purpleLines) do\n            if purpleLine.pos.z < 100 then\n                if purpleLine.pos.x > 100 then\n                    data.MuAiGd_P4_GroundType = 2\n                else\n                    data.MuAiGd_P4_GroundType = 1\n                end\n            end\n        end\n        -- 如果当前为标点模式，且自身有标点\n        if M.Config.FruCfg.CrystallizeTimeType ~= 1 and M.GetPlayer().marker ~= nil and M.GetPlayer().marker ~= 0 then\n            local oldValue = data.MuAiGd_P4_SelfGuideType\n            local mark = tonumber(M.GetPlayer().marker)\n            if M.GetPlayer().marker <= 4 then\n                --- type 1:捡D，2:捡B，3:捡3，4:捡4，\n                if tonumber(M.Config.FruCfg.CrystallizeMark[\"D\"]) == mark then\n                    data.MuAiGd_P4_SelfGuideType = 1\n                elseif tonumber(M.Config.FruCfg.CrystallizeMark[\"B\"]) == mark then\n                    data.MuAiGd_P4_SelfGuideType = 2\n                elseif tonumber(M.Config.FruCfg.CrystallizeMark[\"3\"]) == mark then\n                    data.MuAiGd_P4_SelfGuideType = 3\n                elseif tonumber(M.Config.FruCfg.CrystallizeMark[\"4\"]) == mark then\n                    data.MuAiGd_P4_SelfGuideType = 4\n                end\n            else\n                if M.Config.FruCfg.CrystallizeTimeActType == 1 then\n                    if M.GetPlayer().marker == 6 then\n                        data.MuAiGd_P4_SelfGuideType = 5\n                    elseif M.GetPlayer().marker == 7 then\n                        data.MuAiGd_P4_SelfGuideType = 6\n                    elseif M.GetPlayer().marker == 9 then\n                        data.MuAiGd_P4_SelfGuideType = 7\n                    elseif M.GetPlayer().marker == 10 then\n                        data.MuAiGd_P4_SelfGuideType = 8\n                    end\n                elseif M.Config.FruCfg.CrystallizeTimeActType == 2 then\n                    if M.GetPlayer().marker == 6 then\n                        data.MuAiGd_P4_SelfGuideType = 7\n                    elseif M.GetPlayer().marker == 7 then\n                        data.MuAiGd_P4_SelfGuideType = 8\n                    elseif M.GetPlayer().marker == 9 then\n                        data.MuAiGd_P4_SelfGuideType = 5\n                    elseif M.GetPlayer().marker == 10 then\n                        data.MuAiGd_P4_SelfGuideType = 6\n                    end\n                end\n            end\n            local markType\n            if mark < 5 or mark >= 15 and mark <= 17 then\n                markType = \"攻击\" .. mark\n            elseif mark < 9 then\n                markType = \"锁链\" .. mark\n            elseif mark < 11 then\n                markType = \"禁止\" .. mark\n            else\n                markType = \"其他\"\n            end\n            if oldValue ~= data.MuAiGd_P4_SelfGuideType then\n                local info = data.MuAiGd_P4_InfoGuideType()\n                if M.Config.FruCfg.CrystallizeTimeType == 2 then\n                    M.Info(\"当前为科技标点模式, 检测到标记：[\" .. markType .. \"]。\")\n                    M.Info(\"逻辑变更为：\" .. info)\n                elseif M.Config.FruCfg.CrystallizeTimeType == 3 then\n                    M.Info(\"当前为自动手摇模式, 检测到标记：[\" .. markType .. \"]。\")\n                    M.Info(\"逻辑变更为：\" .. info)\n                end\n            else\n                M.Info(\"检测到标记：[\" .. markType .. \"], 无需修正处理方案。\")\n            end\n        end\n    end\n\n    if M.IsMe(data.MuAiGd_P4_Player.Flame) then\n        -- 暗单走\n        if data.MuAiGd_P4_GroundType == 1 then\n            M.Info(\"暗焰单走，去左上。\")\n            M.DirectTo(88.67, 84, guideTime, 0.3)\n        else\n            M.Info(\"暗焰单走，去右上。\")\n            M.DirectTo(111.33, 84, guideTime, 0.3)\n        end\n    else\n        if data.MuAiGd_P4_SelfGuideType <= 4 then\n            -- 3个蓝BUFF\n            if data.MuAiGd_P4_GroundType == 1 then\n                M.DirectTo(111.33, 116, guideTime, 0.3)\n                M.Info(\"跟人群一起行动。去右下\")\n            else\n                M.DirectTo(88.67, 116, guideTime, 0.3)\n                M.Info(\"跟人群一起行动。去左下\")\n            end\n        elseif data.MuAiGd_P4_SelfGuideType == 7 then\n            M.DirectTo(88.67, 116, guideTime, 0.3)\n        elseif data.MuAiGd_P4_SelfGuideType == 8 then\n            M.DirectTo(111.33, 116, guideTime, 0.3)\n        elseif data.MuAiGd_P4_SelfGuideType == 5 then\n            M.DirectTo(87.75, 100, guideTime)\n        elseif data.MuAiGd_P4_SelfGuideType == 6 then\n            M.DirectTo(112.25, 100, guideTime)\n        end\n    end\nend\n\nif data.MuAiGd_P4_SelfGuideType <= 4 or data.MuAiGd_P4_SelfGuideType >= 7 then\n    local referenceH\n    --- 画一个击退参考线\n    if data.MuAiGd_P4_GroundType == 2 then\n        referenceH = -math.pi / 6\n    else\n        referenceH = math.pi / 6\n    end\n    local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.5), 1)\n    drawer:addTimedArrow(10000, 100, 0, 100, referenceH, 21, .05, .3, .3, 0, false)\n    drawer:addTimedArrow(10000, 100, 0, 100, referenceH + math.pi, 21, .05, .3, .3, 0, false)\nend\ndata.MuAiGd_P4_Guide1Finish = true\nself.used = true\n",
							gVar = "ACR_TensorMagnum3_CD",
							name = "ResetBUff_And_1stGuide",
							uuid = "fd341487-f82a-4a77-a895-984b05db4d7e",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 804.9,
				name = "[MuAiGuide]分析线&指路1",
				timelineIndex = 181,
				timerOffset = -1.5,
				uuid = "59c6f796-4136-3dc1-b912-b2b69d7ec748",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P4_Flags == nil then\n    data.MuAiGd_P4_Flags = {\n        Water = false,\n        Converge = false,\n        Wind = false,\n        Blue = false,\n        Red = false,\n        MissRed = false,\n        LinkToHead = false,\n        Avoid = false,\n        EndGuide = false,\n        RedGuides = {}\n    }\n    data.MuAiGd_P4_FinalGuide = function()\n        if data.MuAiGd_P4_WaveGuideHeading == nil or data.MuAiGd_P4_WaveGuideHeading < -10 then\n            return false\n        end\n        local endHeading\n        local distance\n        if M.Config.FruCfg.CrystallizeTimeKnockBack == 1 then\n            --Y字 then\n            if M.SelfPos == \"MT\" then\n                endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi / 8\n                distance = 14\n            elseif M.SelfPos == \"ST\" then\n                endHeading = data.MuAiGd_P4_WaveGuideHeading - math.pi / 8\n                distance = 14\n            else\n                endHeading = data.MuAiGd_P4_WaveGuideHeading\n                distance = 4\n            end\n        else\n            local selfIndex = M.IndexOf(M.JobPosName, M.SelfPos)\n            if M.Config.FruCfg.CrystallizeTimeKnockCType == 1 then\n                if selfIndex % 2 == 1 then\n                    -- mt 组\n                    if M.SelfPos == \"MT\" then\n                        endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 11 / 180\n                        distance = 16.1\n                    else\n                        endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 8 / 180\n                        distance = 13\n                    end\n                else\n                    if M.SelfPos == \"ST\" then\n                        endHeading = data.MuAiGd_P4_WaveGuideHeading - math.pi * 11 / 180\n                        distance = 16.1\n                    else\n                        endHeading = data.MuAiGd_P4_WaveGuideHeading - math.pi * 8 / 180\n                        distance = 13\n                    end\n                end\n            else\n                if selfIndex % 2 == 1 then\n                    -- mt 组\n                    if M.SelfPos == \"MT\" then\n                        endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 11 / 180\n                        distance = 13\n                    else\n                        endHeading = data.MuAiGd_P4_WaveGuideHeading + math.pi * 9 / 180\n                        distance = 10.2\n                    end\n                else\n                    if M.SelfPos == \"ST\" then\n                        endHeading = data.MuAiGd_P4_WaveGuideHeading - math.pi * 11 / 180\n                        distance = 13\n                    else\n                        endHeading = data.MuAiGd_P4_WaveGuideHeading - math.pi * 9 / 180\n                        distance = 10.2\n                    end\n                end\n            end\n        end\n        local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, endHeading, distance)\n        local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n        if curReturn ~= nil then\n            M.DirectTo(targetPos.x, targetPos.z, curReturn.duration * 1000)\n        else\n            M.DirectTo(targetPos.x, targetPos.z, 5000)\n        end\n        return true\n    end\n    data.MuAiGd_P4_GetDragonHead = function()\n        local heads = {}\n        local rightHead, leftHead\n        for _, ent in pairs(TensorCore.entityList(\"contentid=9323\")) do\n            if Argus.getEntityModel(ent.id) == 17836 then\n                table.insert(heads, ent)\n            end\n        end\n        if heads[1].pos.x > heads[2].pos.x then\n            rightHead = heads[1]\n            leftHead = heads[2]\n        else\n            leftHead = heads[1]\n            rightHead = heads[2]\n        end\n        return leftHead, rightHead\n    end\nend\n\nif data.MuAiGd_P4_SelfGuideType <= 4 then\n    -- 分摊BUFF倒计时结束\n    -- 水判定，准备击退\n    if data.MuAiGd_P4_Flags.Water == false then\n        if not M.IsMe(data.MuAiGd_P4_Player.Flame) then\n            local curWater = TensorCore.getBuff(data.MuAiGd_P4_Player.Water.id, 2461)\n            if curWater == nil or curWater.duration < 0.9 then\n                local pos\n                if data.MuAiGd_P4_GroundType == 1 then\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi / 6, 17)\n                else\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 11 / 6, 17)\n                end\n                M.DirectTo(pos.x, pos.z, 4000, 0.2)\n                data.MuAiGd_P4_Flags.Water = true\n                M.Info(\"准备击退。\", true)\n            end\n        end\n    end\n\n    if data.MuAiGd_P4_Flags.Wind == false then\n        -- 被击退/暗判定 =>调整位置进行分摊\n        local curWind = TensorCore.getBuff(data.MuAiGd_P4_Player.Wind1.id, 2463)\n        if curWind == nil or curWind.duration < 0.1 then\n            local pos\n            if data.MuAiGd_P4_GroundType == 1 then\n                pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 5 / 4, 19.5)\n            else\n                pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 3 / 4, 19.5)\n            end\n            M.DirectTo(pos.x, pos.z, 4000)\n            data.MuAiGd_P4_Flags.Wind = true\n            M.Info(\"调整位置到斜点。\", true)\n        end\n    end\n\n    if data.MuAiGd_P4_Flags.Converge == false then\n        -- 分摊判定回A\n        local curConverge = TensorCore.getBuff(data.MuAiGd_P4_Player.Converge.id, 2454)\n        if curConverge == nil or curConverge.duration < 0.1 then\n            M.DirectTo(100, 84, 3000)\n            data.MuAiGd_P4_Flags.Converge = true\n            M.Info(\"分摊完毕前往A方向。\")\n        end\n    end\n\n    --- 指路捡垃圾\n    if data.MuAiGd_P4_Flags.Blue == false then\n        local removerList = {}\n        local curBlue = TensorCore.getBuff(M.GetPlayer().id, 3264)\n        if curBlue and curBlue.duration < 18.5 then\n            for _, ent in pairs(TensorCore.entityList(\"contentid=2014529\")) do\n                table.insert(removerList, ent)\n            end\n            if table.size(removerList) >= 4 then\n                for i = 1, #removerList do\n                    for j = 1, #removerList - i do\n                        if removerList[j].pos.x > removerList[j + 1].pos.x then\n                            removerList[j], removerList[j + 1] = removerList[j + 1], removerList[j]\n                        end\n                    end\n                end\n                local pos\n                if data.MuAiGd_P4_SelfGuideType == 1 then\n                    M.Info(\"去D点附近吃贡品。\", true)\n                    pos = removerList[1].pos\n                elseif data.MuAiGd_P4_SelfGuideType == 2 then\n                    M.Info(\"去B点附近吃贡品\", true)\n                    pos = removerList[4].pos\n                elseif data.MuAiGd_P4_SelfGuideType == 3 then\n                    M.Info(\"去\" .. M.Config.FruCfg.PosInfo[2] .. \"点附近吃贡品。\", true)\n                    pos = removerList[3].pos\n                elseif data.MuAiGd_P4_SelfGuideType == 4 then\n                    M.Info(\"去\" .. M.Config.FruCfg.PosInfo[8] .. \"点附近吃贡品。\", true)\n                    pos = removerList[2].pos\n                end\n                M.DirectTo(pos.x, pos.z, curBlue.duration * 1000)\n                data.MuAiGd_P4_Flags.Blue = true\n            end\n        end\n    end\n    if data.MuAiGd_P4_Flags.EndGuide == false then\n        local curBlue = TensorCore.getBuff(M.GetPlayer().id, 3264)\n        if curBlue == nil then\n            if data.MuAiGd_P4_FinalGuide() then\n                M.Info(\"贡品拾取成功！\")\n                data.MuAiGd_P4_Flags.EndGuide = true\n            end\n        end\n    end\nelse\n    if data.MuAiGd_P4_SelfGuideType == 5 or data.MuAiGd_P4_SelfGuideType == 6 then\n        -- 左右撞头\n        if data.MuAiGd_P4_Flags.LinkToHead == false then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw then\n                if curClaw.duration <= 8 then\n                    local leftHead, rightHead = data.MuAiGd_P4_GetDragonHead()\n                    local selfHead\n                    if data.MuAiGd_P4_SelfGuideType == 5 then\n                        selfHead = leftHead\n                    else\n                        selfHead = rightHead\n                    end\n                    local headFront = TensorCore.getPosInDirection(selfHead.pos, selfHead.pos.h, 1.5)\n                    M.CancelDir()\n                    M.FrameDirect(headFront.x, headFront.z)\n                end\n            else\n                data.MuAiGd_P4_Flags.LinkToHead = true\n            end\n        end\n\n        -- 撞头完毕\n        if data.MuAiGd_P4_Flags.MissRed == false then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw == nil then\n                if data.MuAiGd_P4_SelfGuideType == 5 then\n                    if data.MuAiGd_P4_GroundType == 1 then\n                        local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 5 / 4, 19.5)\n                        M.DirectTo(pos.x, pos.z, 4000)\n                        M.Info(\"撞头完毕，和人群分摊。\")\n                    else\n                        if MuAiGuide.Config.FruCfg.CrystallizeTimeBuffType == 1 then\n                            M.Info(\"撞头完毕，躲开大圈。\")\n                            M.DirectTo(80.5, 101.8, 8000, 0.3)\n                        else\n                            M.Info(\"撞头完毕，赤暴走，去右上。\")\n                            local pos  = TensorCore.getPosInDirection({x = 100, y = 0, z = 100}, math.pi * 5 / 6, 6)\n                            M.DirectTo(pos.x, pos.z, 8000)\n                            data.MuAiGd_P4_2_RedIceHead = true\n                        end\n                    end\n                elseif data.MuAiGd_P4_SelfGuideType == 6 then\n                    if data.MuAiGd_P4_GroundType == 2 then\n                        local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 3 / 4, 19.5)\n                        M.DirectTo(pos.x, pos.z, 4000)\n                        M.Info(\"撞头完毕，和人群分摊。\")\n                    else\n                        if MuAiGuide.Config.FruCfg.CrystallizeTimeBuffType == 1 then\n                            M.DirectTo(119.5, 101.8, 4000, 0.3)\n                            M.Info(\"撞头完毕，躲开大圈。\")\n                        else\n                            M.Info(\"撞头完毕，赤暴走，去左上。\")\n                            M.DirectTo(88.67, 84, 4000, 0.3)\n                            local pos  = TensorCore.getPosInDirection({x = 100, y = 0, z = 100}, math.pi * 7 / 6, 6)\n                            M.DirectTo(pos.x, pos.z, 8000)\n                            data.MuAiGd_P4_2_RedIceHead = true\n                        end\n                    end\n                end\n                data.MuAiGd_P4_Flags.MissRed = true\n            end\n        end\n\n        if data.MuAiGd_P4_2_RedIceHead~= nil and data.MuAiGd_P4_2_RedIceHead == true and data.MuAiGd_P4_2_RedIceHead2 == nil then\n            if data.MuAiGd_P4_SelfGuideType == 5 and data.MuAiGd_P4_GroundType == 2 then\n                if MuAiGuide.GetPlayer().pos.x > 102 then\n                    local  pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 3 / 4, 19.5)\n                    M.DirectTo(pos.x, pos.z, 3000)\n                    data.MuAiGd_P4_2_RedIceHead2 = true\n                end\n            elseif data.MuAiGd_P4_SelfGuideType == 6 and data.MuAiGd_P4_GroundType == 1 then\n                if MuAiGuide.GetPlayer().pos.x < 96 then\n                    local  pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 5 / 4, 19.5)\n                    M.DirectTo(pos.x, pos.z, 3000)\n                    data.MuAiGd_P4_2_RedIceHead2 = true\n                end\n            end\n        end\n        \n        -- 分摊\n        if data.MuAiGd_P4_Flags.Converge == false then\n            if data.MuAiGd_P4_SelfGuideType == 5 and data.MuAiGd_P4_GroundType == 1 or data.MuAiGd_P4_SelfGuideType == 6 and data.MuAiGd_P4_GroundType == 2 then\n                local curConverge = TensorCore.getBuff(data.MuAiGd_P4_Player.Converge.id, 2454)\n                if curConverge == nil or curConverge.duration < 0.1 then\n                    M.DirectTo(100, 84, 3000)\n                    data.MuAiGd_P4_Flags.Converge = true\n                    M.Info(\"分摊完毕前往A方向。\")\n                end\n            end\n        end\n\n        if MuAiGuide.Config.FruCfg.CrystallizeTimeBuffType == 1 then\n            -- 躲大圈\n            if data.MuAiGd_P4_Flags.Avoid == false then\n                if data.MuAiGd_P4_SelfGuideType == 5 and data.MuAiGd_P4_GroundType == 2\n                        or data.MuAiGd_P4_SelfGuideType == 6 and data.MuAiGd_P4_GroundType == 1 then\n                    local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n                    if curReturn and curReturn.duration < 16.5 then\n                        M.Info(\"前往A点。\")\n                        M.DirectTo(100, 84, 3000)\n                        data.MuAiGd_P4_Flags.Avoid = true\n                    end\n                end\n            end\n        end\n        -- 终点指路\n        if data.MuAiGd_P4_Flags.EndGuide == false then\n            local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n            if curReturn and curReturn.duration < 13 then\n                if data.MuAiGd_P4_FinalGuide() then\n                    data.MuAiGd_P4_Flags.EndGuide = true\n                end\n            end\n        end\n    else\n        --- 左下右下龙头\n        -- 水判定\n        if data.MuAiGd_P4_Flags.Water == false then\n            local curWater = TensorCore.getBuff(data.MuAiGd_P4_Player.Water.id, 2461)\n            if curWater == nil or curWater.duration < 0.9 then\n                local pos\n                if data.MuAiGd_P4_SelfGuideType == 7 then\n                    if data.MuAiGd_P4_GroundType == 2 then\n                        M.Info(\"吹飞人群。\", true)\n                    end\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 11 / 6, 19.5)\n                    M.DirectTo(pos.x, pos.z, 4000, 0.2)\n                else\n                    if data.MuAiGd_P4_GroundType == 1 then\n                        M.Info(\"吹飞人群。\", true)\n                    end\n                    pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi / 6, 19.5)\n                    M.DirectTo(pos.x, pos.z, 4000, 0.2)\n                end\n                data.MuAiGd_P4_Flags.Water = true\n            end\n        end\n\n        --风判定\n        if data.MuAiGd_P4_Flags.Wind == false then\n            -- 被击退/暗判定 =>调整位置进行分摊\n            local curWind = TensorCore.getBuff(data.MuAiGd_P4_Player.Wind1.id, 2463)\n            if curWind == nil or curWind.duration < 0.1 then\n                if data.MuAiGd_P4_SelfGuideType == 7 then\n                    if data.MuAiGd_P4_GroundType == 1 then\n                        M.DirectTo(92.5, 117.9, 5000)\n                        M.Info(\"躲开大圈。\", true)\n                    end\n                else\n                    if data.MuAiGd_P4_GroundType == 2 then\n                        M.DirectTo(107.5, 117.9, 5000)\n                        M.Info(\"躲开大圈。\", true)\n                    end\n                end\n                data.MuAiGd_P4_Flags.Wind = true\n\t\tM.Info(\"准备撞龙头。\")\n            end\n        end\n\n        -- 左下右下撞头\n        if data.MuAiGd_P4_Flags.LinkToHead == false and data.MuAiGd_P4_Flags.Wind == true then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw then\n                local canDo = false\n                --- 场地类型 1:左上紫色，2:右上紫色\n                if data.MuAiGd_P4_GroundType == 1 then\n                    if data.MuAiGd_P4_SelfGuideType == 7 then\n                        canDo = curClaw.duration <= 23.5\n                    else\n                        canDo = true\n                    end\n                else\n                    if data.MuAiGd_P4_SelfGuideType == 7 then\n                        canDo = true\n                    else\n                        canDo = curClaw.duration <= 23.5\n                    end\n                end\n                if canDo then                \n                    local leftHead, rightHead = data.MuAiGd_P4_GetDragonHead()\n                    local selfHead\n                    if data.MuAiGd_P4_SelfGuideType == 7 then\n                        selfHead = leftHead\n                    else\n                        selfHead = rightHead\n                    end\n                    local headFront = TensorCore.getPosInDirection(selfHead.pos, selfHead.pos.h, 1.5)\n                    M.CancelDir()\n                    M.FrameDirect(headFront.x, headFront.z)\n                    local Line = Argus2.ShapeDrawer:new(\n                            (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)),\n                            nil,\n                            (GUI:ColorConvertFloat4ToU32(1, 1, 1, 0)),\n                            (GUI:ColorConvertFloat4ToU32(0, 1, 1, 1)),\n                            3\n                    )\n                    if data.MuAiGd_P4_SelfGuideType == 7 then\n                        Line:addCircle(92.4, 0, 109.55, 0.5)\n                    else\n                        Line:addCircle(107.6, 0, 109.55, 0.5)\n                    end\n                end\n            else\n                data.MuAiGd_P4_Flags.LinkToHead = true\n            end\n        end\n\n        -- 撞头完毕\n        if data.MuAiGd_P4_Flags.MissRed == false then\n            local curClaw = TensorCore.getBuff(M.GetPlayer().id, 3263)\n            if curClaw == nil then\n                M.Info(\"前往C方向点。\")\n                if data.MuAiGd_P4_SelfGuideType == 7 then\n                    M.DirectTo(92.5, 117.9, 5000)\n                else\n                    M.DirectTo(107.5, 117.9, 5000)\n                end\n                data.MuAiGd_P4_Flags.MissRed = true\n            end\n        end\n\n        -- 终点指路\n        if data.MuAiGd_P4_Flags.EndGuide == false then\n            local curReturn = TensorCore.getBuff(M.GetPlayer().id, 4208)\n            if curReturn and curReturn.duration < 13 then\n                if data.MuAiGd_P4_FinalGuide() then\n                    data.MuAiGd_P4_Flags.EndGuide = true\n                end\n            end\n        end\n    end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"0a1785e8-944f-5948-962b-338d0e244cff",
									true,
								},
							},
							gVar = "ACR_TensorMagnum3_CD",
							name = "buffChecking",
							uuid = "cd63e215-3e32-dbfa-944a-c95ba44302b3",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_P4_Flags == nil or data.MuAiGd_P4_Flags.EndGuide == nil or data.MuAiGd_P4_Flags.EndGuide == false",
							uuid = "0a1785e8-944f-5948-962b-338d0e244cff",
							version = 2,
						},
					},
				},
				eventType = 12,
				mechanicTime = 804.9,
				name = "[MuAiGuide]循环处理BUFF",
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 40,
				timerOffset = -1,
				timerStartOffset = -1,
				uuid = "ee0a67c2-d69e-daaf-99ac-f0ec949b0829",
				version = 2,
			},
			inheritedIndex = 3,
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 3,
							allowInterrupt = true,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"a7ab2538-835d-3ada-8f9f-a40a62c45cf9",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							ignoreWeaveRules = true,
							uuid = "ce55794f-8687-bdf2-b23f-58722ef7248a",
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
							conditionLua = "if MuAiGuide.Config.FruCfg.CrystallizeTimeBuffType == 2\n        and ((data.MuAiGd_P4_SelfGuideType == 5 and data.MuAiGd_P4_GroundType == 2)\n        or (data.MuAiGd_P4_SelfGuideType == 6 and data.MuAiGd_P4_GroundType == 1)) then\n    local ice = TensorCore.getBuff(MuAiGuide.GetPlayer().id, 2462)\n    if ice and ice.duration < 2.5 then\n        return true\n\telse\n\t\treturn false\n    end\nelse\n    return false\nend",
							uuid = "a7ab2538-835d-3ada-8f9f-a40a62c45cf9",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 804.9,
				name = "[MuAiGuide]疾跑",
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 40,
				timerOffset = -1,
				timerStartOffset = -2,
				uuid = "6f32f83e-a1b5-a235-a100-93d1ece109f0",
				version = 2,
			},
			inheritedIndex = 4,
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
							actionID = 7548,
							conditions = 
							{
								
								{
									"de577b2a-0560-16eb-98a5-5e09353fff5c",
									true,
								},
								
								{
									"91b7d982-c22c-37e0-ace4-9a8016ef54fc",
									true,
								},
								
								{
									"3c80be25-6539-4eda-a09d-c0c6c674b4c0",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorRequiem3_CD",
							ignoreWeaveRules = true,
							uuid = "e29c8492-e8c6-964e-8ba9-91f560353b38",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							actionID = 7559,
							allowInterrupt = true,
							conditions = 
							{
								
								{
									"3c80be25-6539-4eda-a09d-c0c6c674b4c0",
									true,
								},
								
								{
									"de577b2a-0560-16eb-98a5-5e09353fff5c",
									true,
								},
								
								{
									"fd7d6133-ded9-381e-8493-aedf9caeb78d",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorRequiem3_CD",
							ignoreWeaveRules = true,
							uuid = "cebe343d-9da5-5660-b103-36d9c8a0191e",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "d(\"[MuAiGuide]自动使用防击退！\")\nself.used = true",
							conditions = 
							{
								
								{
									"de577b2a-0560-16eb-98a5-5e09353fff5c",
									true,
								},
								
								{
									"3c80be25-6539-4eda-a09d-c0c6c674b4c0",
									true,
								},
							},
							gVar = "ACR_TensorRequiem3_CD",
							name = "log",
							uuid = "14b3b544-2ce1-8d09-9cbb-68765b521ad9",
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
							conditionLua = "return MuAiGuide and MuAiGuide.Config.FruCfg.CrystallizeTimeKnockBack == 1",
							name = "Y字击退",
							uuid = "de577b2a-0560-16eb-98a5-5e09353fff5c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7548,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							dequeueIfLuaFalse = true,
							name = "亲疏自行可用",
							uuid = "91b7d982-c22c-37e0-ace4-9a8016ef54fc",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7559,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							dequeueIfLuaFalse = true,
							name = "沉稳咏唱可用",
							uuid = "fd7d6133-ded9-381e-8493-aedf9caeb78d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40289,
							name = "神圣之翼",
							uuid = "3c80be25-6539-4eda-a09d-c0c6c674b4c0",
							version = 2,
						},
					},
				},
				eventType = 2,
				mechanicTime = 835.3,
				name = "[MuAiGuide]Y字自动防击退",
				randomOffset = -5,
				timeRange = true,
				timelineIndex = 194,
				timerEndOffset = 5,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "fc943854-2d7a-c3f2-a3fa-424c142de4d5",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[201] = 
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
							actionLua = "for i = 1,14 do\n    SendTextCommand(\"/mk clear <\"..i..\">\")\nend\nself.used = true",
							gVar = "ACR_TensorMagnum3_CD",
							uuid = "bc049a79-aeee-2d74-a908-f9b3b91c3912",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 850.2,
				name = "清标点",
				timelineIndex = 201,
				uuid = "88d0a2f3-c31c-7c8d-bea0-4fcebf3958c3",
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
							aType = "Lua",
							actionLua = "for _, ent in pairs(TensorCore.entityList(\"contentid=13561\")) do\n    if Argus.isEntityVisible(ent) then\n        data.MuAiGd_P5_BOSS = ent\n        break\n    end\nend\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "eac6cfed-ff3f-dcb6-865a-1c354bca90a4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 972.3,
				name = "[MuAiGuide]获取P5BOSS",
				timelineIndex = 207,
				uuid = "ac4de620-c07a-6259-9401-61a177fcffd1",
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
							aType = "Lua",
							actionLua = "--- 地火，作者：megaminx\n-- local drawer = TensorCore.getCachedDrawer(1275068160, 1006895359, 1174667519)\n\nlocal drawer = Argus2.ShapeDrawer:new(\n    (GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.1)),\n    nil,\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0.4)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n    1\n)\n\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\n--drawer:addTimedRect(8000, ent.pos.x, ent.pos.y, ent.pos.z, 40, 10, ent.pos.h, 0, true)\n\nlocal dumbshit = TensorCore.getPosInDirection(ent.pos, ent.pos.h, 2.5)\ndrawer:addTimedCenteredRect(7000, dumbshit.x, 0, dumbshit.z, 5, 40, ent.pos.h, 0, true)\n\nfor i = 1, 8 do\n    local pos = TensorCore.getPosInDirection(dumbshit, ent.pos.h, 5 * (i))\n    drawer:addTimedCenteredRect(2000, pos.x, 0, pos.z, 5, 40, ent.pos.h, 7000 + (2000 * (i - 1)), true)\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"a6a7f898-31a3-6089-887b-0a99f18e2f08",
									true,
								},
								
								{
									"79f4fe9d-07e6-c26a-928f-59f32ad997b2",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "f536daa6-8d40-faf0-8e17-065b9c2e0982",
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
							eventSpellID = 40118,
							spellIDList = 
							{
								40118,
								40307,
							},
							uuid = "a6a7f898-31a3-6089-887b-0a99f18e2f08",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruCfg.drawShit == true",
							name = "setting check",
							uuid = "79f4fe9d-07e6-c26a-928f-59f32ad997b2",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1001.1,
				name = "[megaminx]画地火",
				timeRange = true,
				timelineIndex = 214,
				timerEndOffset = 250,
				timerStartOffset = -100,
				uuid = "3f1eab28-067f-b86b-929d-8b282470e3e1",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "data.MuAiGd_P5_drawGroup = function(drawTime)\n    if MuAiGuide.Config.FruCfg.drawAknMorn == false then\n        return\n    end\n    local curMT = TensorCore.getEntityByGroup(\"Main Tank\", \"Nearest\")\n    local curST\n    if MuAiGuide.Party[\"MT\"].id == curMT.id then\n        curST = MuAiGuide.Party[\"ST\"]\n    else\n        curST = MuAiGuide.Party[\"MT\"]\n    end\n    local purpleDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n        2\n    )\n    local yellowDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n        2\n    )\n    purpleDrawer:addTimedCircleOnEnt(drawTime, curMT.id, 4)\n    yellowDrawer:addTimedCircleOnEnt(drawTime, curST.id, 4)\nend\ndata.MuAiGd_P5_drawGroup(2500)\nself.used = true\n",
							gVar = "ACR_TensorRuin3_CD",
							uuid = "5b9a62df-cb5f-675a-b1f4-849ac93d6dc9",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1011.4,
				name = "[MuAiGuide]画分摊",
				timelineIndex = 215,
				timerOffset = -2.5,
				uuid = "f61197d0-740d-77ba-bc2a-228dc124413d",
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
							actionLua = "data.MuAiGd_P5_drawDivGroup = function()\n    local M = MuAiGuide\n    if M.Config.FruCfg.drawAknMorn == false then\n        return\n    end\n    local white = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n            (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n            (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n            (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n            2\n    )\n    local boss = TensorCore.mGetEntity(data.MuAiGd_P5_BOSS.id)\n    local bossFront = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, boss.pos.h, 6)\n    white:addArrow(boss.pos.x, boss.pos.y, boss.pos.z, boss.pos.h, 20, 0.05, 0.4, 0.2, true)\n    white:addArrow(boss.pos.x, boss.pos.y, boss.pos.z, boss.pos.h + math.pi, 20, 0.05, 0, 0, true)\n    white:addArrow(boss.pos.x, boss.pos.y, boss.pos.z, boss.pos.h, 12, 0.05, 0.4, 0.2, true)\n    white:addArrow(boss.pos.x, boss.pos.y, boss.pos.z, boss.pos.h, 4, 0.05, 0.4, 0.2, true)\n    local player = MuAiGuide.GetPlayer()\n    local clock = M.GetClock(bossFront, player.pos)\n    local drawer\n    if clock then\n        -- 顺 紫色\n        drawer = Argus2.ShapeDrawer:new(\n                (GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.3)),\n                (GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.3)),\n                (GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.3)),\n                (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n                2\n        )\n    else\n        -- 逆 黄色\n        drawer = Argus2.ShapeDrawer:new(\n                (GUI:ColorConvertFloat4ToU32(1, 1, 0, 0.3)),\n                (GUI:ColorConvertFloat4ToU32(1, 1, 0, 0.3)),\n                (GUI:ColorConvertFloat4ToU32(1, 1, 0, 0.3)),\n                (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n                2\n        )\n    end\n    drawer:addCircle(player.pos.x, player.pos.y, player.pos.z, 4, false)\nend\ndata.MuAiGd_P5_drawDivGroup()\nself.used = true\n",
							gVar = "ACR_TensorRuin3_CD",
							uuid = "5b9a62df-cb5f-675a-b1f4-849ac93d6dc9",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1011.4,
				name = "[MuAiGuide]画分摊New",
				timeRange = true,
				timelineIndex = 215,
				timerOffset = -2.5,
				timerStartOffset = -2.5,
				uuid = "e49b6e6b-d23a-88a2-93d9-df846d94e167",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "if data.MuAiGd_P5GetCastInfo == nil then\n    data.MuAiGd_P5GetCastInfo = function(skillId)\n        local curMT = TensorCore.getEntityByGroup(\"Main Tank\", \"Nearest\")\n        local curST\n        if MuAiGuide.Party[\"MT\"].id == curMT.id then\n            curST = MuAiGuide.Party[\"ST\"]\n        else\n            curST = MuAiGuide.Party[\"MT\"]\n        end\n        if MuAiGuide.SelfPos == \"MT\" or MuAiGuide.SelfPos == \"ST\" then\n            if skillId == 40313 then\n                MuAiGuide.Info(\"先光。\", true)\n            elseif skillId == 40233 then\n                MuAiGuide.Info(\"先暗。\", true)\n            end\n        else\n            if skillId == 40313 then\n                MuAiGuide.Info(\"先光翅膀，去右。\", true)\n            elseif skillId == 40233 then\n                MuAiGuide.Info(\"先暗翅膀，去左。\", true)\n            end\n        end\n        return { MT = curMT, ST = curST, SkillId = skillId }\n    end\nend\n\ndata.MuAiGd_P5CastInfo = data.MuAiGd_P5GetCastInfo(eventArgs.spellID)\nself.used = true",
							conditions = 
							{
								
								{
									"c25ee2de-b639-e5ed-8022-60cbcc01c230",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "198103b8-80ac-dcac-83a6-beee85117067",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							eventSpellID = 40233,
							name = "光与暗黑的双翼",
							spellIDList = 
							{
								40313,
								40233,
							},
							uuid = "c25ee2de-b639-e5ed-8022-60cbcc01c230",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				eventType = 3,
				mechanicTime = 1033.6,
				name = "[MuAiGuide]读条类型分析",
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 20,
				timerStartOffset = -20,
				uuid = "9ed56e58-5dcd-3456-8f73-d72ffa4ec644",
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
							actionLua = "if data.MuAiGd_GetP5TowerTable == nil then\n    data.MuAiGd_P5_Towers = nil\n    data.MuAiGd_GetP5TowerTable = function(a1)\n        local left = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 4 / 3, 7)\n        local right = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, math.pi * 2 / 3, 7)\n        local down = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, 0, 7)\n        if a1 == 51 then\n            return { Down = left, Left = right, Right = down }\n        elseif a1 == 52 then\n            return { Down = right, Left = down, Right = left }\n        elseif a1 == 53 then\n            return { Down = down, Left = left, Right = right }\n        end\n        return nil\n    end\nend\nif data.MuAiGd_P5_Towers == nil then\n\tlocal result = data.MuAiGd_GetP5TowerTable(eventArgs.a1)\n\tif result ~= nil then\n\t\td(eventArgs.a1)\n\t\td(result)\n\t\tdata.MuAiGd_P5_Towers = result\n\tend\nend\nself.used = true",
							conditions = 
							{
								
								{
									"0d3db2d7-d7d4-0c2d-8a72-3fe6b8c71536",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "c5ce03af-9d98-db9c-99c3-585821790223",
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
							conditionLua = "return eventArgs.a2 == 1 and eventArgs.a3 == 2 and data.MuAiGd_P5_Towers == nil",
							uuid = "0d3db2d7-d7d4-0c2d-8a72-3fe6b8c71536",
							version = 2,
						},
					},
				},
				eventType = 14,
				mechanicTime = 1033.6,
				name = "[MuAiGuide]分析塔位置",
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 3,
				timerStartOffset = -20,
				uuid = "5d5aac25-32a9-3239-84a7-30236bbe05f7",
				version = 2,
			},
			inheritedIndex = 4,
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
							actionLua = "if data.MuAiGd_P5_LDStartTime1 == nil then\n    data.MuAiGd_P5_LDStartTime1 = Now()\nend\nif data.MuAiGd_P5_TowerGuide == nil then\n    data.MuAiGd_P5_TowerGuide = function(startTime, towers, castInfo)\n        local purpleDrawer = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.3)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.3)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.3)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 2)),\n            2\n        )\n        local yellowDrawer = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.3)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.3)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.3)),\n            (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 2)),\n            2\n        )\n        --- 绘制左右刀和圆圈范围\n        ---@param playerId number 当前1仇\n        local drawAoeRange = function(playerId, skillId, first)\n            local targetPos = TensorCore.mGetEntity(playerId).pos\n            local curHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, targetPos)\n            local skillType\n            if first then\n                skillType = skillId\n            else\n                if skillId == 40313 then\n                    skillType = 40233\n                else\n                    skillType = 40313\n                end\n            end\n            if skillType == 40313 then\n                yellowDrawer:addCone(100, 0, 100, 20, math.pi * 5 / 4, curHeading + math.pi * 3 / 8, 0, false)\n                local farthest, maxDistance\n                for i, ent in pairs(MuAiGuide.Party) do\n                    local curPos = TensorCore.mGetEntity(ent.id).pos\n                    if farthest == nil then\n                        farthest = curPos\n                        maxDistance = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, curPos)\n                    else\n                        local distance = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, curPos)\n                        if distance > maxDistance then\n                            farthest = curPos\n                            maxDistance = distance\n                        end\n                    end\n                end\n                yellowDrawer:addCircle(farthest.x, farthest.y, farthest.z, 4)\n            elseif skillType == 40233 then\n                purpleDrawer:addCone(100, 0, 100, 20, math.pi * 5 / 4, curHeading - math.pi * 3 / 8, 0, false)\n                local nearest, minDistance\n                for i, ent in pairs(MuAiGuide.Party) do\n                    local curPos = TensorCore.mGetEntity(ent.id).pos\n                    if nearest == nil then\n                        nearest = curPos\n                        minDistance = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, curPos)\n                    else\n                        local distance = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, curPos)\n                        if distance < minDistance then\n                            nearest = curPos\n                            minDistance = distance\n                        end\n                    end\n                end\n                purpleDrawer:addCircle(nearest.x, nearest.y, nearest.z, 4)\n            end\n        end\n\n        local timeSince = TimeSince(startTime)\n        --- 下塔到中心的方向\n        local headingD2U = TensorCore.getHeadingToTarget(towers.Down, { x = 100, y = 0, z = 100 })\n\n        if timeSince < 8000 then\n            if MuAiGuide.Config.FruCfg.drawWinLight == true then\n                drawAoeRange(castInfo.MT.id, castInfo.SkillId, true)\n            end\n            if MuAiGuide.IsMe(castInfo.MT) then\n                local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, headingD2U, 7)\n                MuAiGuide.FrameDirect(pos.x, pos.z)\n            elseif MuAiGuide.IsMe(castInfo.ST) then\n                local heading\n                local distance\n                if castInfo.SkillId == 40313 then\n                    local mid = {\n                        x = (towers.Down.x + towers.Right.x) / 2,\n                        y = 0,\n                        z = (towers.Down.z + towers.Right.z) / 2\n                    }\n                    heading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, mid)\n                    distance = 19.5\n                elseif castInfo.SkillId == 40233 then\n                    local mid = {\n                        x = (towers.Down.x + towers.Left.x) / 2,\n                        y = 0,\n                        z = (towers.Down.z + towers.Left.z) / 2\n                    }\n                    heading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, mid)\n                    distance = 2\n                end\n                local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, distance)\n                MuAiGuide.FrameDirect(pos.x, pos.z)\n            else\n                if table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Down, MuAiGuide.SelfPos) then\n                    local towerHeading = headingD2U + math.pi\n                    local heading\n                    if castInfo.SkillId == 40313 then\n                        heading = towerHeading + 1 / 7\n                    elseif castInfo.SkillId == 40233 then\n                        heading = towerHeading - 1 / 7\n                    end\n                    local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 7)\n                    MuAiGuide.FrameDirect(pos.x, pos.z)\n                else\n                    if MuAiGuide.Config.FruCfg.DarkLightWingsTakeTowerType == 1 then\n                        if castInfo.SkillId == 40313 and table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Right, MuAiGuide.SelfPos) then\n                            local heading = headingD2U - math.pi / 4 - math.pi / 12\n                            local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\n                            MuAiGuide.FrameDirect(pos.x, pos.z)\n                        elseif castInfo.SkillId == 40233 and table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Left, MuAiGuide.SelfPos) then\n                            local heading = headingD2U + math.pi / 4 + math.pi / 12\n                            local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\n                            MuAiGuide.FrameDirect(pos.x, pos.z)\n                        end\n                    else\n                        if table.contains(MuAiGuide.Config.FruCfg.DarkLightWings2.Left, MuAiGuide.SelfPos) then --安全区上塔\n                            if castInfo.SkillId == 40313 then\n                                local heading = headingD2U - math.pi / 4 - math.pi / 12\n                                local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\n                                MuAiGuide.FrameDirect(pos.x, pos.z)\n                            elseif castInfo.SkillId == 40233 then\n                                local heading = headingD2U + math.pi / 4 + math.pi / 12\n                                local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\n                                MuAiGuide.FrameDirect(pos.x, pos.z)\n                            end\n                        end\n                    end\n                end\n            end\n        elseif (timeSince < 12000) then\n            if MuAiGuide.Config.FruCfg.drawWinLight == true then\n                drawAoeRange(castInfo.ST.id, castInfo.SkillId, false)\n            end\n            if MuAiGuide.IsMe(castInfo.MT) then\n                local distance\n                if castInfo.SkillId == 40233 then\n                    distance = 19.5\n                elseif castInfo.SkillId == 40313 then\n                    distance = 2\n                end\n                local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, headingD2U, distance)\n                MuAiGuide.FrameDirect(pos.x, pos.z)\n            elseif MuAiGuide.IsMe(castInfo.ST) then\n                local heading\n                if castInfo.SkillId == 40313 then\n                    local mid = {\n                        x = (towers.Down.x + towers.Right.x) / 2,\n                        y = 0,\n                        z = (towers.Down.z + towers.Right.z) / 2\n                    }\n                    heading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, mid)\n                elseif castInfo.SkillId == 40233 then\n                    local mid = {\n                        x = (towers.Down.x + towers.Left.x) / 2,\n                        y = 0,\n                        z = (towers.Down.z + towers.Left.z) / 2\n                    }\n                    heading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, mid)\n                end\n                local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 7)\n                MuAiGuide.FrameDirect(pos.x, pos.z)\n            else\n                if table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Down, MuAiGuide.SelfPos) then\n                    local pos\n                    if castInfo.SkillId == 40313 then\n                        pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, headingD2U, 10)\n                    elseif castInfo.SkillId == 40233 then\n                        pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, headingD2U, 5)\n                    end\n                    MuAiGuide.FrameDirect(pos.x, pos.z)\n                else\n                    if MuAiGuide.Config.FruCfg.DarkLightWingsTakeTowerType == 1 then\n                        if castInfo.SkillId == 40313 and table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Left, MuAiGuide.SelfPos) then\n                            MuAiGuide.FrameDirect(towers.Left.x, towers.Left.z)\n                        elseif castInfo.SkillId == 40233 and table.contains(MuAiGuide.Config.FruCfg.DarkLightWings.Right, MuAiGuide.SelfPos) then\n                            MuAiGuide.FrameDirect(towers.Right.x, towers.Right.z)\n                        end\n                    else\n                        if table.contains(MuAiGuide.Config.FruCfg.DarkLightWings2.Right, MuAiGuide.SelfPos) then\n                            if castInfo.SkillId == 40313 then\n                                MuAiGuide.FrameDirect(towers.Left.x, towers.Left.z)\n                            elseif castInfo.SkillId == 40233 then\n                                MuAiGuide.FrameDirect(towers.Right.x, towers.Right.z)\n                            end\n                        end\n                    end\n                end\n            end\n        end\n    end\nend\n\ndata.MuAiGd_P5_TowerGuide(data.MuAiGd_P5_LDStartTime1, data.MuAiGd_P5_Towers, data.MuAiGd_P5CastInfo)\nself.used = true\n",
							conditions = 
							{
								
								{
									"aa6083d6-9c1e-d8ad-ad02-5f22e0fae8fa",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "198103b8-80ac-dcac-83a6-beee85117067",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_P5_Towers ~= nil and data.MuAiGd_P5CastInfo ~= nil",
							uuid = "aa6083d6-9c1e-d8ad-ad02-5f22e0fae8fa",
							version = 2,
						},
					},
				},
				eventType = 12,
				mechanicTime = 1033.6,
				name = "[MuAiGuide]左右刀&踩塔指路",
				timeRange = true,
				timelineIndex = 222,
				timerStartOffset = -30,
				uuid = "39ddc27b-7256-3e58-8a24-082cca1c31db",
				version = 2,
			},
			inheritedIndex = 3,
		},
	},
	[226] = 
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
							actionLua = "local M = MuAiGuide\nif data.MuAiGd_P5_DrawPolarizing == nil then\n    data.MuAiGd_P5_DrawPolarizing = function(times)\n        if M.Config.FruCfg.drawWinPolarizing == true then\n            local closest1, closest2 = nil, nil\n            local dist1, dist2 = math.huge, math.huge\n            local boss = TensorCore.mGetEntity(data.MuAiGd_P5_BOSS.id)\n            for _, ent in pairs(M.Party) do\n                local curPlayer = TensorCore.mGetEntity(ent.id)\n                if curPlayer.Alive then\n                    local dist = TensorCore.getDistance2d(boss.pos, curPlayer.pos)\n                    if dist < dist1 then\n                        dist2 = dist1\n                        closest2 = closest1\n                        dist1 = dist\n                        closest1 = curPlayer\n                    elseif dist < dist2 then\n                        dist2 = dist\n                        closest2 = curPlayer\n                    end\n                end\n            end\n            local purpleDrawer = Argus2.ShapeDrawer:new(\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.7)),\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.7)),\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.7)),\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n                    2\n            )\n            local yellowDrawer = Argus2.ShapeDrawer:new(\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.7)),\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.7)),\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, 0.7)),\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 255 / 255, 1)),\n                    2\n            )\n\n            local redDrawer = Argus2.ShapeDrawer:new(\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n                    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 1)),\n                    6\n            )\n            if closest1 ~= nil and closest2 ~= nil then\n                local draw1, draw2\n                if M.GetClock(closest1.pos, closest2.pos) then\n                    draw2 = yellowDrawer\n                    draw1 = purpleDrawer\n                else\n                    draw1 = yellowDrawer\n                    draw2 = purpleDrawer\n                end\n\n                local h1 = TensorCore.getHeadingToTarget(boss.pos, closest1.pos)\n                local h2 = TensorCore.getHeadingToTarget(boss.pos, closest2.pos)\n                draw1:addRect(boss.pos.x, boss.pos.y, boss.pos.z, 40, 6, h1)\n                draw2:addRect(boss.pos.x, boss.pos.y, boss.pos.z, 40, 6, h2)\n                redDrawer:addCircle(closest1.pos.x, closest1.pos.y + 0.5, closest1.pos.z, 0.5, true)\n                redDrawer:addCircle(closest2.pos.x, closest2.pos.y + 0.5, closest2.pos.z, 0.5, true)\n            end\n        end\n\n        local bossPos = TensorCore.mGetEntity(data.MuAiGd_P5_BOSS.id).pos\n        local curPlayers = M.Config.FruCfg.drawWinPolarizingOrder[times]\n        local endHeading\n\n        local distance\n        local IsSelfLead\n        if table.contains(curPlayers, M.SelfPos) then\n            data.MuAiGd_P5_SelfFront = true\n            IsSelfLead = true\n            distance = 5.5\n        else\n            IsSelfLead = false\n            distance = 9.5\n        end\n\n        local isLeft = M.IndexOf(M.JobPosName, M.SelfPos) % 2 == 1\n        if data.MuAiGd_P5_SelfFront and not IsSelfLead then --档过了且不是当前次挡枪\n            isLeft = not isLeft\n        end\n        if isLeft then\n            endHeading = M.SetHeading2Pi(bossPos.h + math.pi * 3 / 4)\n        else\n            endHeading = M.SetHeading2Pi(bossPos.h - math.pi * 3 / 4)\n        end\n\n        local endPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, endHeading, distance)\n        M.FrameDirect(endPos.x, endPos.z)\n    end\n    data.MuAiGd_P5_DrawPolarizingFinish = function(times)\n        local boss = TensorCore.mGetEntity(data.MuAiGd_P5_BOSS.id)\n        local heading = M.SetHeading2Pi(boss.pos.h - math.pi)\n        local endPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 10)\n        M.DirectTo(endPos.x, endPos.z, 1500)\n    end\nend\ndata.MuAiGd_P5_DrawPolarizing(1)\nself.used = true\n",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "9fbbc434-39da-d3a3-a3fb-688fa60bb0f3",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1051.2,
				name = "[MuAiGuide]挡枪-第1波",
				timeRange = true,
				timelineIndex = 226,
				timerEndOffset = 0.30000001192093,
				timerOffset = -5,
				timerStartOffset = -6.5,
				uuid = "2f3523e7-29c0-dc00-a85d-7521367e2f3c",
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
							actionLua = "data.MuAiGd_P5_DrawPolarizingFinish(1)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1051.2,
				name = "[MuAiGuide]挡枪-第1波end",
				timelineIndex = 226,
				timerEndOffset = 0.30000001192093,
				timerOffset = 0.30000001192093,
				timerStartOffset = 0.30000001192093,
				uuid = "4613fc4e-3935-bf42-88a8-fcc9aa00a5c2",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[228] = 
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
							actionLua = "data.MuAiGd_P5_DrawPolarizing(2)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1055.8,
				name = "[MuAiGuide]挡枪-第2波",
				timeRange = true,
				timelineIndex = 228,
				timerEndOffset = 0.30000001192093,
				timerOffset = -2.7000000476837,
				timerStartOffset = -1.5,
				uuid = "32e0afce-5c61-7e90-a3d4-59ba4a8cff58",
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
							actionLua = "data.MuAiGd_P5_DrawPolarizingFinish(1)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1055.8,
				name = "[MuAiGuide]挡枪-第2波end",
				timelineIndex = 228,
				timerEndOffset = 0.30000001192093,
				timerOffset = 0.30000001192093,
				timerStartOffset = 0.30000001192093,
				uuid = "308f38d4-d888-8593-b915-f5b336382455",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "data.MuAiGd_P5_DrawPolarizing(3)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1060.4,
				name = "[MuAiGuide]挡枪-第3波",
				timeRange = true,
				timelineIndex = 230,
				timerEndOffset = 0.30000001192093,
				timerOffset = -2.7000000476837,
				timerStartOffset = -1.5,
				uuid = "cc79fa8d-5071-f3d3-8fd6-6f908a6cf429",
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
							actionLua = "data.MuAiGd_P5_DrawPolarizingFinish(3)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1060.4,
				name = "[MuAiGuide]挡枪-第3波end",
				timelineIndex = 230,
				timerEndOffset = 0.30000001192093,
				timerOffset = 0.30000001192093,
				timerStartOffset = 0.30000001192093,
				uuid = "edbdca3e-552f-fb36-8ac0-6e9fee14e140",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "data.MuAiGd_P5_DrawPolarizing(4)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1065,
				name = "[MuAiGuide]挡枪-第4波",
				timeRange = true,
				timelineIndex = 232,
				timerEndOffset = 0.30000001192093,
				timerStartOffset = -1.5,
				uuid = "8a475ceb-2131-8b23-964e-529bc34105d2",
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
							actionLua = "data.MuAiGd_P5_DrawPolarizingFinish(4)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1065,
				name = "[MuAiGuide]挡枪-第4波end",
				timelineIndex = 232,
				timerEndOffset = 0.30000001192093,
				timerOffset = 0.30000001192093,
				timerStartOffset = 0.30000001192093,
				uuid = "e90d0a8c-fe79-6bee-bd6e-b444803c1c99",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "data.MuAiGd_P5_drawGroup(2500)\nself.used = true\n",
							gVar = "ACR_TensorRuin3_CD",
							uuid = "5b9a62df-cb5f-675a-b1f4-849ac93d6dc9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1124,
				name = "[MuAiGuide]画分摊2",
				timelineIndex = 243,
				timerOffset = -2.5,
				uuid = "053bde7c-d968-565a-947f-ee4995dbf46e",
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
							actionLua = "data.MuAiGd_P5_drawDivGroup()\nself.used = true\n",
							gVar = "ACR_TensorRuin3_CD",
							uuid = "5b9a62df-cb5f-675a-b1f4-849ac93d6dc9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1124,
				name = "[MuAiGuide]画分摊new2",
				timeRange = true,
				timelineIndex = 243,
				timerOffset = -2.5,
				timerStartOffset = -2.5,
				uuid = "38b7ef4c-5319-ffd7-8dbe-16e20831c11a",
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
							actionLua = "d(data.MuAiGd_P5_SelfFront)\nself.used =true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "08c1e3d1-c970-f80d-b3f5-4db1cb2e00d2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1124,
				name = "123",
				timelineIndex = 243,
				uuid = "c1d3fda2-a99b-573e-a7e6-a9e771b7b2e0",
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
							actionLua = "data.MuAiGd_P5_Towers = nil\ndata.MuAiGd_P5CastInfo = nil\ndata.MuAiGd_P5_SelfFront = nil\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "a5e8aa3b-649f-3abc-a4d8-a7bcb66f2420",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1146.3,
				name = "[MuAiGuide]ClearCache",
				timelineIndex = 247,
				timerOffset = -30,
				uuid = "50e9fdda-52f5-b3df-81fd-92a66b734838",
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
							actionLua = "if data.MuAiGd_P5_Towers == nil then\n\tlocal result = data.MuAiGd_GetP5TowerTable(eventArgs.a1)\n\tif result ~= nil then\n\t\td(eventArgs.a1)\n\t\td(result)\n\t\tdata.MuAiGd_P5_Towers = result\n\tend\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"a84a5896-c18a-d96e-98c7-7113928e3731",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "c5ce03af-9d98-db9c-99c3-585821790223",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return eventArgs.a2 == 1 and eventArgs.a3 == 2 and data.MuAiGd_P5_Towers == nil",
							uuid = "a84a5896-c18a-d96e-98c7-7113928e3731",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				eventType = 14,
				mechanicTime = 1150.3,
				name = "[MuAiGuide]分析塔位置",
				timeRange = true,
				timelineIndex = 250,
				timerStartOffset = -20,
				uuid = "6fdcc152-dc0a-2a8b-a278-483079c843c9",
				version = 2,
			},
			inheritedIndex = 5,
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
							actionLua = "data.MuAiGd_P5CastInfo = data.MuAiGd_P5GetCastInfo(eventArgs.spellID)\nd(data.MuAiGd_P5CastInfo)\nself.used = true",
							conditions = 
							{
								
								{
									"c25ee2de-b639-e5ed-8022-60cbcc01c230",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "198103b8-80ac-dcac-83a6-beee85117067",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							eventSpellID = 40233,
							name = "光与暗黑的双翼",
							spellIDList = 
							{
								40313,
								40233,
							},
							uuid = "c25ee2de-b639-e5ed-8022-60cbcc01c230",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1150.3,
				name = "[MuAiGuide]读条类型分析",
				timeRange = true,
				timelineIndex = 250,
				timerEndOffset = 20,
				timerStartOffset = -20,
				uuid = "0d97e63c-d9dc-f5fd-82fa-b059761eda42",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "if data.MuAiGd_P5_LDStartTime2 == nil then\n    data.MuAiGd_P5_LDStartTime2 = Now()\nend\ndata.MuAiGd_P5_TowerGuide(data.MuAiGd_P5_LDStartTime2, data.MuAiGd_P5_Towers, data.MuAiGd_P5CastInfo)\nself.used = true\n",
							conditions = 
							{
								
								{
									"aa6083d6-9c1e-d8ad-ad02-5f22e0fae8fa",
									true,
								},
							},
							gVar = "ACR_RikuGNB3_CD",
							uuid = "198103b8-80ac-dcac-83a6-beee85117067",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.MuAiGd_P5_Towers ~= nil and data.MuAiGd_P5CastInfo ~= nil",
							uuid = "aa6083d6-9c1e-d8ad-ad02-5f22e0fae8fa",
							version = 2,
						},
					},
				},
				eventType = 12,
				mechanicTime = 1150.3,
				name = "[MuAiGuide]左右刀&踩塔指路",
				timeRange = true,
				timelineIndex = 250,
				timerStartOffset = -30,
				uuid = "d5a4ca3f-86ad-2373-bd4d-c150a8159c95",
				version = 2,
			},
			inheritedIndex = 3,
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
							actionLua = "data.MuAiGd_P5_DrawPolarizing(1)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1162.6,
				name = "[MuAiGuide]挡枪-第1波",
				timeRange = true,
				timelineIndex = 253,
				timerEndOffset = 0.30000001192093,
				timerOffset = -2.7000000476837,
				timerStartOffset = -6.5,
				uuid = "8306d329-2d58-1fbf-8b9d-478a047525d4",
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
							actionLua = "data.MuAiGd_P5_DrawPolarizingFinish(1)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1162.6,
				name = "[MuAiGuide]挡枪-第1波end",
				timelineIndex = 253,
				timerEndOffset = 0.30000001192093,
				timerOffset = 0.30000001192093,
				timerStartOffset = 0.30000001192093,
				uuid = "39007bb7-17c4-0ae6-8883-3a348b3dd8ab",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "data.MuAiGd_P5_DrawPolarizing(2)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1167.2,
				name = "[MuAiGuide]挡枪-第2波",
				timeRange = true,
				timelineIndex = 255,
				timerEndOffset = 0.30000001192093,
				timerOffset = -2.7000000476837,
				timerStartOffset = -1.5,
				uuid = "ca7d40f4-abb5-63de-bbb5-d6134dbcf4c2",
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
							actionLua = "data.MuAiGd_P5_DrawPolarizingFinish(2)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1167.2,
				name = "[MuAiGuide]挡枪-第2波end",
				timelineIndex = 255,
				timerEndOffset = 0.30000001192093,
				timerOffset = 0.30000001192093,
				timerStartOffset = 0.30000001192093,
				uuid = "3102cd32-9787-9607-ad0b-577c6da2a2bb",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "data.MuAiGd_P5_DrawPolarizing(3)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1171.8,
				name = "[MuAiGuide]挡枪-第3波",
				timeRange = true,
				timelineIndex = 257,
				timerEndOffset = 0.30000001192093,
				timerOffset = -2.7000000476837,
				timerStartOffset = -1.5,
				uuid = "80229565-48bc-9d15-a492-8dccb2633222",
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
							actionLua = "data.MuAiGd_P5_DrawPolarizingFinish(3)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1171.8,
				name = "[MuAiGuide]挡枪-第3波end",
				timelineIndex = 257,
				timerEndOffset = 0.30000001192093,
				timerOffset = 0.30000001192093,
				timerStartOffset = 0.30000001192093,
				uuid = "de95afe3-cada-4dab-8e6d-704647777528",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "data.MuAiGd_P5_DrawPolarizing(4)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1176.4,
				name = "[MuAiGuide]挡枪-第4波",
				timeRange = true,
				timelineIndex = 259,
				timerEndOffset = 0.30000001192093,
				timerStartOffset = -1.5,
				uuid = "ef1e4190-b303-ebef-8f18-25a1e50ca1dd",
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
							actionLua = "data.MuAiGd_P5_DrawPolarizingFinish(4)\nself.used = true",
							gVar = "ACR_TensorRequiem3_CD",
							uuid = "2b1bc0b8-799b-9417-bba4-46f15893e23f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1176.4,
				name = "[MuAiGuide]挡枪-第4波end",
				timelineIndex = 259,
				timerEndOffset = 0.30000001192093,
				timerOffset = 0.30000001192093,
				timerStartOffset = 0.30000001192093,
				uuid = "4978cd3a-0df5-0182-b796-965b862843ce",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionLua = "data.MuAiGd_P5_drawGroup(2500)\nself.used = true\n",
							gVar = "ACR_TensorRuin3_CD",
							uuid = "5b9a62df-cb5f-675a-b1f4-849ac93d6dc9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1214.2,
				name = "[MuAiGuide]画分摊3",
				timelineIndex = 268,
				timerOffset = -2.5,
				uuid = "ef5ccd59-727a-4d33-afab-678cf74db3f2",
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
							actionLua = "data.MuAiGd_P5_drawDivGroup()\nself.used = true\n",
							gVar = "ACR_TensorRuin3_CD",
							uuid = "5b9a62df-cb5f-675a-b1f4-849ac93d6dc9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 1214.2,
				name = "[MuAiGuide]画分摊new3",
				timeRange = true,
				timelineIndex = 268,
				timerOffset = -2.5,
				timerStartOffset = -2.5,
				uuid = "f72c62e3-d03c-1d5f-a25b-993086dde80f",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	mapID = 1238,
	version = 5,
}



return tbl