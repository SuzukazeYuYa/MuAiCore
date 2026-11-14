local tbl = 
{
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "bcab934e-0710-53bf-a603-178761501b5c",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif MuAiGuide.Reactions.Settings.DutyHelper.enabled then\n\tMuAiGuide.Reactions.Settings.DutyHelper.saved = true\n\tMuAiGuide.Reactions.Settings.DutyHelper.enabled = false\nend\n\nself.used = true",
							gVar = "ACR_RikuWAR3_CD",
							name = "Disable Duty Helper",
							uuid = "a7d807a8-f61a-5cd2-8650-c633dd89894d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 13.7,
				name = "关闭副本助手",
				timelineIndex = 1,
				timerOffset = -13,
				uuid = "0bfa30e8-d60c-5613-8f36-91ce524068e2",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.log(\"Stance is enabled, remembering this for later\")\nMuAiGuide.Reactions.Data.StanceEnabled = true\nself.used = true",
							conditions = 
							{
								
								{
									"bd3552fb-ce81-5fb3-8f74-75a8f5a14782",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_CD",
							name = "Remember Has Stance",
							uuid = "ba68c7de-9a2a-514d-beb8-c4ca19cbc843",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.log(\"Stance is disabled, remembering this for later\")\nMuAiGuide.Reactions.Data.StanceEnabled = false\nself.used = true",
							conditions = 
							{
								
								{
									"611e0093-32eb-57fd-ac30-182627e9f676",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_CD",
							name = "Remember No Stance",
							uuid = "4bd8db2c-e5c9-591f-96f8-316f275447c2",
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
								91,
								743,
								79,
								1833,
							},
							category = "Self",
							matchAnyBuff = true,
							name = "Has Stance",
							uuid = "bd3552fb-ce81-5fb3-8f74-75a8f5a14782",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 6,
							buffIDList = 
							{
								91,
								743,
								79,
								1833,
							},
							category = "Self",
							name = "No Stance",
							uuid = "611e0093-32eb-57fd-ac30-182627e9f676",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 13.7,
				name = "记录坦克姿态",
				timelineIndex = 1,
				timerOffset = -13,
				uuid = "aeb18429-e71f-533a-9174-3cb51fac0b77",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Toggle(\"setpots\", true)\nMuAiGuide.Reactions.Toggle(\"aoe\", true)\nif MuAiGuide.Reactions.Settings.Reactions.fruLatePot >= 2 then\n\tMuAiGuide.Reactions.Toggle(\"pots\", false)\nend\nself.used = true",
							gVar = "ACR_RikuWAR3_CD",
							name = "Set Toggles",
							uuid = "341efc47-3ec6-578c-bb00-a0f554bccdbb",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 13.7,
				name = "初始化开关",
				timelineIndex = 1,
				timerOffset = -13.60000038147,
				uuid = "678dc838-eaee-55fa-b348-6ef9e744131e",
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
							actionLua = "-- P2 Scythe Kick inner radius.\nMoogleTelegraphs.Settings.aoeIDUserSetDonuts[40203]= {name=\"Scythe Kick (FRU)\", radius=4, source=\"String 反应\"}\n\n-- P2 Mirrors' Reflected Scythe Kicks\nMoogleTelegraphs.Settings.aoeIDUserSetDonuts[40204] = {name=\"Reflected Scythe Kick (FRU)\", radius=4, source=\"String 反应\"}\nMoogleTelegraphs.Settings.aoeIDUserSetDonuts[40205] = {name=\"Reflected Scythe Kick (FRU)\", radius=4, source=\"String 反应\"}\n\n-- P5 Exas\nMoogleTelegraphs.Settings.aoeIDUserSetDonuts[40118] = {name=\"Path of Darkness (FRU)\", radius=4, source=\"String 反应\"}\nMoogleTelegraphs.Settings.aoeIDUserSetDonuts[40307] = {name=\"Path of Light (FRU)\", radius=4, source=\"String 反应\"}\n\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Donut Inner Radii",
							uuid = "b22b4232-3e10-50b0-99fc-62e18ad4313f",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- P2 Twin Silence (90* first -> 270* second)\nMoogleTelegraphs.Settings.aoeIDUserSetCones[40194] = {name=\"Twin Silence (FRU)\", angle=90, source=\"String 反应\"}\nMoogleTelegraphs.Settings.aoeIDUserSetCones[40195] = {name=\"Twin Silence (FRU)\", angle=270, source=\"String 反应\"}\n-- (270* first -> 90* second)\nMoogleTelegraphs.Settings.aoeIDUserSetCones[40193] = {name=\"Twin Stillness (FRU)\", angle=270, source=\"String 反应\"}\nMoogleTelegraphs.Settings.aoeIDUserSetCones[40196] = {name=\"Twin Stillness (FRU)\", angle=90, source=\"String 反应\"}\n\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Cone Angles",
							uuid = "3389231e-0da8-55bd-a530-b073ded90f1d",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- P1 Knockback telegraph (covers entire arena, useless)\nMoogleTelegraphs.Settings.aoeIDUserBlacklist[40162] = \"Blastburn (FRU) - String 反应\"\nMoogleTelegraphs.Settings.aoeIDUserBlacklist[40130] = \"Blastburn (FRU) - String 反应\"\n\n-- P1 Towers that only require a single person to soak\nMoogleTelegraphs.Settings.aoeIDUserBlacklist[40135] = \"Explosion (FRU) - String 反应\"\nMoogleTelegraphs.Settings.aoeIDUserBlacklist[40131] = \"Explosion (FRU) - String 反应\"\n\n-- Intermission AOEs that already have an in-game telegraph\nMoogleTelegraphs.Settings.aoeIDUserBlacklist[40256] = \"Hiemal Storm (FRU) - String 反应\"\n\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Blacklist Useless Draws",
							uuid = "4fbfa6e0-2471-5a39-8132-7d7f5f12cc16",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 13.7,
				name = "配置电报范围",
				timelineIndex = 1,
				timerOffset = -13,
				uuid = "40a2f7c5-ad54-5b66-887b-0108ffbebd80",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal mtID = eventArgs.prevDetectionTargetID\nlocal otID = eventArgs.detectionTargetID\n\nif (mtID == nil) then\n    MuAiGuide.Reactions.log(\"[Tank Roles] MT ID was nil!\", 5)\n    self.used = true\n    return\nend\nif (otID == nil) then\n    MuAiGuide.Reactions.log(\"[Tank Roles] OT ID was nil!\", 5)\n    self.used = true\n    return\nend\n\nlocal mtEnt = TensorCore.mGetEntity(mtID)\nlocal otEnt = TensorCore.mGetEntity(otID)\n\nif (mtEnt == nil) then\n    MuAiGuide.Reactions.log(\"[Tank Roles] MT returned nil ent!\", 5)\n    self.used = true\n    return\nend\nif (otEnt == nil) then\n    MuAiGuide.Reactions.log(\"[Tank Roles] OT returned nil ent!\", 5)\n    self.used = true\n    return\nend\n\n---@enum\nlocal jobEnum = {\n    [19] = 1, -- PLD\n    [21] = 2, -- DRK\n    [32] = 3, -- DRK\n    [37] = 4, -- GNB\n}\nlocal playerID = TensorCore.mGetPlayer().id\nlocal playerIsMT = playerID == mtID\nlocal playerIsOT = playerID == otID\nlocal buddyEnt = playerIsMT and otEnt or mtEnt\n\ndata.selfIsMT = playerIsMT\ndata.selfIsOT = playerIsOT\ndata.mtRole = jobEnum[mtEnt.job]\ndata.otRole = jobEnum[otEnt.job]\ndata.tankBuddyRole = jobEnum[buddyEnt.job]\ndata.mtID = mtID\ndata.otID = otID\n\nlocal str = string.format(\"[Tank Roles] MTRole: %d, OTRole: %d, BuddyRole: %s, MTID: %d, OTID: %d, SelfIsMT: %s\", data.mtRole, data.otRole, tostring(data.tankBuddyRole), mtID, otID, tostring(playerIsMT))\nMuAiGuide.Reactions.log(str, 5)\n\nself.used = true",
							conditions = 
							{
								
								{
									"0cb85bb1-31c8-5a92-872d-03a07b5d4f89",
									true,
								},
								
								{
									"c66ba4d0-d869-557b-8eca-20a83a02b4e6",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_CD",
							name = "Set Tank Roles",
							uuid = "5d89786f-97a7-5d4d-a2b9-7d65987e0333",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Main Tank",
							name = "Get MT",
							uuid = "0cb85bb1-31c8-5a92-872d-03a07b5d4f89",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Off Tank",
							name = "Get OT",
							uuid = "c66ba4d0-d869-557b-8eca-20a83a02b4e6",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 13.7,
				name = "确定双坦分工",
				timelineIndex = 1,
				timerOffset = -2.5,
				uuid = "111e3997-ea91-5811-9b66-80200c17e24e",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal party = MuAiGuide.Reactions.API.getAgnosticPartyList(\"Party\")\nif (not table.valid(party)) then\n    MuAiGuide.Reactions.log(\"[Record Party IDs] Failed to retrieve party list!\", 5)\n    self.used = true\n    return\nend\n\nlocal idArray = {}\nlocal count = 0\n---@diagnostic disable-next-line: param-type-mismatch\nfor _, ent in pairs(party) do\n    count = count + 1\n    table.insert(idArray, ent.id)\nend\n\nif (count ~= 8) then\n    MuAiGuide.Reactions.log(\"[Record Party IDs] Didn't retrieve 8 party members. Retrieved \" .. tostring(count), 5)\n    self.used = true\n    return\nend\ndata.partyIDArray = idArray\nself.used = true",
							gVar = "ACR_RikuWHM3_CD",
							name = "Record Party IDs",
							uuid = "80bc74d2-392e-59f9-8018-387d8b842d67",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 13.7,
				name = "记录队伍成员",
				timelineIndex = 1,
				timerOffset = -5,
				uuid = "03235ac7-5376-5c6c-8f02-7974413d3e13",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				eventType = 9,
				execute = "if MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready then MuAiGuide.Reactions.resetTransient(true) end\nself.used = true",
				executeType = 2,
				mechanicTime = 13.7,
				name = "团灭清理",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1500.5,
				timerStartOffset = -23.7,
				uuid = "05e1a110-05dd-deeb-a3aa-2e7e74d37004",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "f3db38b8-d9d6-5f19-a3b4-1badb4aaf0df",
			},
			objectType = "folder",
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
							actionLua = "-- P1 before-KB telegraph, for redrawing to make it less cluttered\nMoogleTelegraphs.Settings.aoeIDUserBlacklist[40161] = \"Burn Strike (FRU) - String 反应\"\n\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Blacklist Redrawn Telegraphs",
							uuid = "1da3af1f-ebe5-5191-8c2f-1b7df3448951",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 13.7,
				name = "屏蔽重复电报",
				timelineIndex = 1,
				timerOffset = -13,
				uuid = "d68553b9-0e96-5dd9-8a73-ba5525f34388",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal center = {x=100, y=1, z=100}\nlocal radius = 21\n\nlocal south = TensorCore.getPosInDirection(center, math.rad(0), radius+3)\nMuAiGuide.Reactions.addTimedWorldText(1500000, \"S\", south, nil, nil, 3)\n\nlocal east = TensorCore.getPosInDirection(center, math.rad(90), radius+3)\nMuAiGuide.Reactions.addTimedWorldText(1500000, \"E\", east, nil, nil, 3)\n\nlocal north = TensorCore.getPosInDirection(center, math.rad(180), radius+3)\nMuAiGuide.Reactions.addTimedWorldText(1500000, \"N\", north, nil, nil, 3)\n\nlocal west = TensorCore.getPosInDirection(center, math.rad(270), radius+3)\nMuAiGuide.Reactions.addTimedWorldText(1500000, \"W\", west, nil, nil, 3)\n\nself.used = true\n",
							gVar = "ACR_RikuWAR3_CD",
							uuid = "3aa1b208-fd2b-5e8e-81fc-436f5aa06452",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 13.7,
				name = "场地方位文字",
				timelineIndex = 1,
				timerOffset = -13,
				uuid = "b7a54c2a-a8e6-5d63-b7b8-0e0dc905cb09",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(3000, TensorCore.mGetPlayer().id, 6, 6000, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"b34cf492-f28c-5151-a231-2f3092411648",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Queue Partners",
							uuid = "a4767129-0852-51bb-b63b-b26bed34833f",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal playerID = TensorCore.mGetPlayer().id\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nfor _, ent in pairs(party) do\n    if (ent.id ~= playerID) then\n        drawer:addTimedCircleOnEnt(3000, ent.id, 6, 6000, false, nil, 256)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"636a1ad0-c4da-521f-9418-ddd6af87715e",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Queue Spread",
							uuid = "494fcb12-027e-5dfb-9fb5-50e63616978e",
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
							eventSpellID = 40144,
							name = "Partners",
							uuid = "b34cf492-f28c-5151-a231-2f3092411648",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40148,
							name = "Spread",
							uuid = "636a1ad0-c4da-521f-9418-ddd6af87715e",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 13.7,
				name = "暴风破分散分摊范围",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1,
				timerStartOffset = -13.5,
				uuid = "46765851-707e-585d-880e-d576b7189cf1",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then return end\n\nlocal entPos = ent.pos\nlocal x = entPos.x\nlocal z = entPos.z\nlocal h = eventArgs.heading\nlocal coneAngle = math.rad(22.5)\nlocal coneAdvancement = math.rad(22.5)\n\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedCone(2000, x, 0.05, z, 25, coneAngle, h, nil, false, nil, 256)\ndrawer:addTimedCone(2000, x, 0.05, z, 25, coneAngle, h - (coneAdvancement * 1), 2000, false, nil, 256)\ndrawer:addTimedCone(2000, x, 0.05, z, 25, coneAngle, h - (coneAdvancement * 2), 4000, false, nil, 256)\n\nself.used = true",
							conditions = 
							{
								
								{
									"c2f95afc-4f9b-56d3-ade2-4ffa110cbdab",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Queue Cones",
							uuid = "90911af5-3ee3-5ab9-bb28-1315ebd20731",
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
							eventSpellID = 40145,
							name = "Cast ID",
							uuid = "c2f95afc-4f9b-56d3-ade2-4ffa110cbdab",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				loop = true,
				mechanicTime = 13.7,
				name = "暴风破后续扇形",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "ef7392dc-307d-5f70-aea5-91a4a90b54bb",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then return end\n\nlocal bossID = eventArgs.entityID\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal coneAngle = math.rad(22.5)\nfor _, ent in pairs(party) do\n    drawer:addTimedConeOnEnt(5000, bossID, 60, coneAngle, ent.id, 2000, false, nil, nil, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"b0572ad7-65c9-5aaa-924f-f4b68d5d20bd",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Cones",
							uuid = "53e42e56-99a9-571a-9f42-721a3db2c8b5",
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
							name = "Either",
							spellIDList = 
							{
								40144,
								40148,
							},
							uuid = "b0572ad7-65c9-5aaa-924f-f4b68d5d20bd",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 13.7,
				name = "暴风破引导扇形",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1,
				timerStartOffset = -13.5,
				uuid = "f34ea8ec-7a33-5a35-b6a0-2391380efef4",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Partners\", true, 9)\nself.used = true",
							conditions = 
							{
								
								{
									"b34cf492-f28c-5151-a231-2f3092411648",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Queue Partners",
							uuid = "a4767129-0852-51bb-b63b-b26bed34833f",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Spread\", true, 9)\nself.used = true",
							conditions = 
							{
								
								{
									"636a1ad0-c4da-521f-9418-ddd6af87715e",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Queue Spread",
							uuid = "494fcb12-027e-5dfb-9fb5-50e63616978e",
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
							eventSpellID = 40144,
							name = "Partners",
							uuid = "b34cf492-f28c-5151-a231-2f3092411648",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40148,
							name = "Spread",
							uuid = "636a1ad0-c4da-521f-9418-ddd6af87715e",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 13.7,
				name = "暴风破分散分摊播报",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1,
				timerStartOffset = -13.5,
				uuid = "3ae97b84-77bc-5c72-846b-0c2b2ca81cfd",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DECEEC6, nil, 0x4DECEEC6, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCenteredRect(5000, 100, 0.05, 100, 0.15, 30, math.rad(90), 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"d4f07b0d-9770-5463-be95-8a6dfbefc803",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_CD",
							name = "Draw Centerline",
							uuid = "865f60ae-dd3a-5564-af8c-7c3740045371",
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
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "Is Tank",
							partyTargetType = "Tank",
							uuid = "d4f07b0d-9770-5463-be95-8a6dfbefc803",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 13.7,
				name = "坦克中线参考",
				timelineIndex = 1,
				timerOffset = -13.64999961853,
				uuid = "40001c41-0686-5ac1-b4c2-f6b655981f9b",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal drawer = TensorCore.getCachedDrawer(0x4D0000FF, nil, 0x4D0000FF, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedCircle(7200000, 100, 0.05, 100, 20, 0, false, nil, 256)\nself.used = true",
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Arena",
							uuid = "07f1f68f-c2f5-5477-a9ac-af608c13fa8b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				enabled = false,
				mechanicTime = 13.7,
				name = "场地边界",
				timelineIndex = 1,
				timerOffset = -13,
				uuid = "823ef899-0e31-5715-9190-6590e2f9316d",
				version = 2,
			},
		},
	}, 
	[9] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "55fe6f02-0161-5a93-a7cb-de47a0f7555d",
			},
			objectType = "folder",
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
							actionLua = "data.p1CloneMech = \"stack\"\nself.used = true",
							conditions = 
							{
								
								{
									"20b324c1-ac1f-50b0-8db3-ac41bbba6cfc",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Store Stacks",
							uuid = "b9000538-afd3-524c-a4b6-f4beb62b2ea8",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p1CloneMech = \"spread\"\nself.used = true",
							conditions = 
							{
								
								{
									"1cec652f-685a-5bb2-86c7-279fe4e2a24f",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Store Spread",
							uuid = "82cb3baa-b35c-5b55-8f40-3e3b14e56fa8",
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
							eventSpellID = 40154,
							name = "Stacks",
							uuid = "20b324c1-ac1f-50b0-8db3-ac41bbba6cfc",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40155,
							name = "Spread",
							uuid = "1cec652f-685a-5bb2-86c7-279fe4e2a24f",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 3,
				mechanicTime = 34.7,
				name = "记录分散分摊",
				timeRange = true,
				timelineIndex = 9,
				timerStartOffset = -6,
				uuid = "704b4dfe-c3f5-5f48-8366-2cedc3507a66",
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
							actionLua = "data.p1CyclonicStartTime = nil\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Reset Time",
							uuid = "dc0bcf92-a732-5c66-b0a7-7ed5c00dfbf6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 34.7,
				name = "重置暴风破计时",
				timelineIndex = 9,
				timerOffset = 3,
				uuid = "b4cc15b9-c218-5a7e-999b-b283bdef9e15",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "7b9e0f64-a0a1-50a1-8268-42c5ee0388bd",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Stack Later\", true, 5)\nself.used = true",
							conditions = 
							{
								
								{
									"20b324c1-ac1f-50b0-8db3-ac41bbba6cfc",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Call Stacks",
							uuid = "b9000538-afd3-524c-a4b6-f4beb62b2ea8",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Spread Later\", true, 5)\nself.used = true",
							conditions = 
							{
								
								{
									"1cec652f-685a-5bb2-86c7-279fe4e2a24f",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Call Spreads",
							uuid = "82cb3baa-b35c-5b55-8f40-3e3b14e56fa8",
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
							eventSpellID = 40154,
							name = "Stacks",
							uuid = "20b324c1-ac1f-50b0-8db3-ac41bbba6cfc",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40155,
							name = "Spread",
							uuid = "1cec652f-685a-5bb2-86c7-279fe4e2a24f",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 34.7,
				name = "雾龙分散分摊播报",
				timeRange = true,
				timelineIndex = 9,
				timerStartOffset = -6,
				uuid = "596405fc-b09b-547b-93b5-b47f52196046",
				version = 2,
			},
		},
	},
	[11] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "d104a55c-8f8e-5b33-aab3-1eaa5e5ed29b",
			},
			objectType = "folder",
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
							actionLua = "data.p1PowderMarkID = eventArgs.detectionTargetID\nself.used = true",
							conditions = 
							{
								
								{
									"694e2ae1-a990-55e2-a1ea-87634f97e618",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Set Powder Mark ID",
							uuid = "37c6c8d5-b15d-51a8-842b-78f4357623dd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"d71d2fd8-faf7-5b2c-ba4f-1ebd3fca56af",
									true,
								},
							},
							filterTargetType = "Party",
							name = "Powder Mark Filter",
							uuid = "694e2ae1-a990-55e2-a1ea-87634f97e618",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 4166,
							category = "Party",
							name = "Has Powder Mark",
							partyTargetType = "Detection Target",
							uuid = "d71d2fd8-faf7-5b2c-ba4f-1ebd3fca56af",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 40.3,
				name = "记录爆印目标",
				timelineIndex = 11,
				timerEndOffset = -2,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "8e04285a-3f0b-52e7-a712-6fccd711b82c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "6ed5517a-cd55-595b-86c3-461c141bb6ca",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then return end\n\nlocal pos = ent.pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedRect(9150, pos.x, 0.05, pos.z, 50, 16, pos.h, nil, false, nil, 256)\n\nself.used = true",
							conditions = 
							{
								
								{
									"507ce46c-8e94-5cf6-86e2-4e2750c53a5d",
									true,
								},
								
								{
									"66183d06-abca-5e7a-bad6-f8750559a42e",
									true,
								},
								
								{
									"5e40aaa0-ad4b-56ee-bde6-245bdd02c852",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Blasting Zone",
							uuid = "ba79b3d2-dd13-5063-8f95-8ca409b0b092",
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
							conditionLua = "return eventArgs.entityContentID == 9708",
							conditionType = 10,
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 9708,
							inGroupTargetContentID = 9708,
							inGroupTargetType = "ContentID",
							name = "ContentID",
							partyTargetType = "Event Entity",
							uuid = "507ce46c-8e94-5cf6-86e2-4e2750c53a5d",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.newAnimID == 210",
							dequeueIfLuaFalse = true,
							eventArgType = 4,
							eventIntValue = 210,
							name = "New AnimID",
							uuid = "66183d06-abca-5e7a-bad6-f8750559a42e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.oldAnimID == 34",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							eventIntValue = 34,
							name = "Old AnimID",
							uuid = "5e40aaa0-ad4b-56ee-bde6-245bdd02c852",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 23,
				loop = true,
				mechanicTime = 40.3,
				name = "爆破领域直线",
				timeRange = true,
				timelineIndex = 11,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "d495e627-0bc5-5575-b174-b5b9afed9eaa",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nif (data.p1CloneMech == \"spread\") then\n    local party = TensorCore.getEntityGroupList(\"Party\")\n    if (not table.valid(party)) then\n        self.used = true\n        return\n    end\n\n    local fruMoogle1 = TensorCore.getMoogleDrawer()\n    local drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    for _, ent in pairs(party) do\n        drawer:addTimedCircleOnEnt(5000, ent.id, 5, 4800, false, nil, 256)\n    end\nelseif (data.p1CloneMech == \"stack\") then\n    local fruMuai2 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\n    fruMuai2:setGradient(3, 0.15, 2)\n    fruMuai2:setHeightOffset(0.05)\n    fruMuai2:addTimedCircleOnEnt(5000, TensorCore.mGetPlayer().id, 6, 4800, false, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"67a0b0fe-14f0-50ac-8197-2a297b498cd3",
									true,
								},
								
								{
									"9f4aa53e-3b32-5a19-ba94-fd65bba1ac80",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Stack/Spread",
							uuid = "ba79b3d2-dd13-5063-8f95-8ca409b0b092",
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
							conditionLua = "return data.p1CloneMech ~= nil",
							dequeueIfLuaFalse = true,
							name = "Clone Mech Stored",
							uuid = "67a0b0fe-14f0-50ac-8197-2a297b498cd3",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.newAnimID == 210 and eventArgs.oldAnimID == 34 and eventArgs.entityContentID == 9708",
							conditions = 
							{
								
								{
									"089f018c-d219-b2c7-afee-3d07e754323f",
									true,
								},
								
								{
									"852a9a11-2438-f57b-a42a-ad62d8b89921",
									true,
								},
								
								{
									"d1f035d6-837f-3d05-8b8a-bef14b167d86",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							name = "AnimID Check",
							partyTargetNumber = 0,
							uuid = "9f4aa53e-3b32-5a19-ba94-fd65bba1ac80",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 4,
							eventIntValue = 210,
							name = "newAnimID 等于 210",
							uuid = "089f018c-d219-b2c7-afee-3d07e754323f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 3,
							eventIntValue = 34,
							name = "oldAnimID 等于 34",
							uuid = "852a9a11-2438-f57b-a42a-ad62d8b89921",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							eventArgOptionType = 2,
							eventEntityContentID = 9708,
							name = "entityContentID 等于 9708",
							uuid = "d1f035d6-837f-3d05-8b8a-bef14b167d86",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 23,
				mechanicTime = 40.3,
				name = "雾龙分散分摊范围",
				timeRange = true,
				timelineIndex = 11,
				timerEndOffset = 3,
				timerStartOffset = -3,
				uuid = "cd35f3a7-26bb-562c-969f-2798e5af4363",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(data.p1CloneMech, true, 7)\nself.used = true",
							conditions = 
							{
								
								{
									"66183d06-abca-5e7a-bad6-f8750559a42e",
									true,
								},
								
								{
									"e8870e3a-1217-509a-978b-7bf549a6db71",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "TTS Clone Mech",
							uuid = "ba79b3d2-dd13-5063-8f95-8ca409b0b092",
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
							conditionLua = "return data.p1CloneMech ~= nil",
							dequeueIfLuaFalse = true,
							name = "Clone Mech Stored",
							uuid = "66183d06-abca-5e7a-bad6-f8750559a42e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.newAnimID == 210 and eventArgs.oldAnimID == 34 and eventArgs.entityContentID == 9708",
							conditions = 
							{
								
								{
									"34a5bd8f-b895-ffc1-b570-af3b28e65863",
									true,
								},
								
								{
									"dd1ce9ad-9528-4460-bcf9-8da01b189b3b",
									true,
								},
								
								{
									"08082039-d102-5f88-9561-0752b42b8659",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							name = "AnimID Check",
							partyTargetNumber = 0,
							uuid = "e8870e3a-1217-509a-978b-7bf549a6db71",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 4,
							eventIntValue = 210,
							name = "newAnimID 等于 210",
							uuid = "34a5bd8f-b895-ffc1-b570-af3b28e65863",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 3,
							eventIntValue = 34,
							name = "oldAnimID 等于 34",
							uuid = "dd1ce9ad-9528-4460-bcf9-8da01b189b3b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							eventArgOptionType = 2,
							eventEntityContentID = 9708,
							name = "entityContentID 等于 9708",
							uuid = "08082039-d102-5f88-9561-0752b42b8659",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 23,
				mechanicTime = 40.3,
				name = "雾龙分散分摊播报",
				timeRange = true,
				timelineIndex = 11,
				timerEndOffset = 3,
				timerStartOffset = -3,
				uuid = "35fdbb4d-b8e7-5539-b9c3-345e8f72dded",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal drawTime = (40.3 - TensorReactions_CurrentTimer) * 1000\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(drawTime, eventArgs.detectionTargetID, 10, nil, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"694e2ae1-a990-55e2-a1ea-87634f97e618",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Timed Draw Powder Mark",
							uuid = "37c6c8d5-b15d-51a8-842b-78f4357623dd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"d71d2fd8-faf7-5b2c-ba4f-1ebd3fca56af",
									true,
								},
							},
							filterTargetType = "Party",
							name = "Powder Mark Filter",
							uuid = "694e2ae1-a990-55e2-a1ea-87634f97e618",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 4166,
							category = "Party",
							name = "Has Powder Mark",
							partyTargetType = "Detection Target",
							uuid = "d71d2fd8-faf7-5b2c-ba4f-1ebd3fca56af",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 40.3,
				name = "爆印目标范围",
				timelineIndex = 11,
				timerEndOffset = -2,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "641c3100-ea1a-511f-897d-d687968b932e",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pm = TensorCore.mGetEntity(data.p1PowderMarkID).pos\nlocal closest = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal dist = TensorCore.getDistance2d(pm, closest)\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addDonut(pm.x, 0.05, pm.z, dist-0.5, dist, false, 256)\ndrawer:addCircle(closest.x, 0.05, closest.z, 10, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"146cd19c-0aaf-55c3-9c23-828f300a3069",
									true,
								},
								
								{
									"d3c915a8-0d47-5780-8284-df5f0c72ba6a",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Draw Closest",
							uuid = "c25dfc90-f8fc-5757-8025-3047c5dd366c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"2f3bb281-74bc-5604-a125-9f4fd7f51358",
									true,
								},
							},
							filterTargetType = "Party",
							name = "Powder Mark Filter",
							uuid = "146cd19c-0aaf-55c3-9c23-828f300a3069",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 4166,
							category = "Party",
							name = "Has Powder Mark",
							partyTargetType = "Detection Target",
							uuid = "2f3bb281-74bc-5604-a125-9f4fd7f51358",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"2f3bb281-74bc-5604-a125-9f4fd7f51358",
									false,
								},
								
								{
									"b1da3352-b859-5f19-9994-9f78029101ba",
									true,
								},
							},
							filterTargetType = "Party",
							name = "Nearest to Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "d3c915a8-0d47-5780-8284-df5f0c72ba6a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 2,
							hpType = 2,
							hpValue = 1,
							name = "Exists",
							partyTargetType = "Detection Target",
							uuid = "b1da3352-b859-5f19-9994-9f78029101ba",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				loop = true,
				mechanicTime = 40.3,
				name = "爆印最近连锁范围",
				timeRange = true,
				timelineIndex = 11,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -4.5,
				uuid = "bc8eba91-14bb-52bb-9d3f-94237dd240e1",
				version = 2,
			},
		},
	},
	[12] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "2a3dd7f7-bbb7-537b-97f5-e228b66b06f1",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal bossID = eventArgs.entityID\nlocal coneAngle = math.rad(22.5)\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nfor _, ent in pairs(party) do\n    drawer:addTimedConeOnEnt(3600, bossID, 25, coneAngle, ent.id, 4000, false, nil, nil, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"81447dc1-5cf6-58c8-8d65-4445cb31eb55",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Cones",
							uuid = "ce3eb6df-2620-563f-9d22-bf0c5b94d49c",
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
							name = "Channel ID",
							spellIDList = 
							{
								40329,
								40330,
							},
							uuid = "81447dc1-5cf6-58c8-8d65-4445cb31eb55",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 50,
				name = "暴风破扇形预判",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 3,
				timerStartOffset = -5,
				uuid = "b75ba2d1-9e19-584a-8811-3da05a614cd6",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal playerID = TensorCore.mGetPlayer().id\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nfor _, ent in pairs(party) do\n    if (ent.id ~= playerID) then\n        drawer:addTimedCircleOnEnt(3700, ent.id, 6, 6000, false, nil, 256)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"c3fbaf5b-7d53-5b98-b39d-0caaf2e80602",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Spread",
							uuid = "1867f967-a660-5263-991b-b810f44ff1f2",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(3700, TensorCore.mGetPlayer().id, 6, 6000, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"7ccd6482-51ef-5fec-b7d8-8020d9d5ce10",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Partners",
							uuid = "7ac6dc04-a4bc-5cd4-b756-7add673f2d80",
							version = 2.1,
						},
						inheritedIndex = 2,
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
							eventSpellID = 40330,
							name = "Spread",
							uuid = "c3fbaf5b-7d53-5b98-b39d-0caaf2e80602",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40329,
							name = "Partners",
							uuid = "7ccd6482-51ef-5fec-b7d8-8020d9d5ce10",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 50,
				name = "暴风破分散分摊范围",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 3,
				timerStartOffset = -5,
				uuid = "50e322b4-0f96-5d46-9380-1c998219ffd9",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Spread\", true, 5)\nself.used = true",
							conditions = 
							{
								
								{
									"c3fbaf5b-7d53-5b98-b39d-0caaf2e80602",
									true,
								},
								
								{
									"09d8f2e9-08d2-5873-9102-bce9f689c8e0",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Shotcall Spread",
							uuid = "70e4d0e9-5e39-56d0-a2a6-4456e94c69f3",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Partners\", true, 5)\nself.used = true",
							conditions = 
							{
								
								{
									"7ccd6482-51ef-5fec-b7d8-8020d9d5ce10",
									true,
								},
								
								{
									"09d8f2e9-08d2-5873-9102-bce9f689c8e0",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Shotcall Partners",
							uuid = "91e6270e-66ef-5cbe-9e0d-db292fc567c4",
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
							eventSpellID = 40330,
							name = "Spread",
							uuid = "c3fbaf5b-7d53-5b98-b39d-0caaf2e80602",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40329,
							name = "Partners",
							uuid = "7ccd6482-51ef-5fec-b7d8-8020d9d5ce10",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							channelCheckTimeRemain = 4.5,
							channelCheckType = 3,
							comparator = 2,
							conditionType = 5,
							name = "Channel Time",
							partyTargetType = "Event Entity",
							uuid = "09d8f2e9-08d2-5873-9102-bce9f689c8e0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 50,
				name = "暴风破分散分摊播报",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 3,
				timerStartOffset = -5,
				uuid = "1db8d36a-ada1-50b5-a795-ca6cd6ea19f6",
				version = 2,
			},
		},
	},
	[13] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "c23ad4bc-4378-5673-95cc-4b3967990b0a",
			},
			objectType = "folder",
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
							actionLua = "data.p1UtopianSafeElement = 9711\nself.used = true",
							conditions = 
							{
								
								{
									"5e3b0e16-9ace-57d6-a6c4-f7f2dd00d8fc",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Store Lightning",
							uuid = "ee928c8e-fa45-5efa-b044-61e73abf269b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p1UtopianSafeElement = 9710\nself.used = true",
							conditions = 
							{
								
								{
									"bfb222da-f847-54f0-8029-65167e5bd25b",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Store Fire",
							uuid = "15f06ec9-02d4-58f6-bbf4-8c8220719ee8",
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
							eventSpellID = 40150,
							name = "Lightning Safe",
							uuid = "5e3b0e16-9ace-57d6-a6c4-f7f2dd00d8fc",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40151,
							name = "Fire Safe",
							uuid = "bfb222da-f847-54f0-8029-65167e5bd25b",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 3,
				mechanicTime = 56.2,
				name = "记录安全属性",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = 3,
				timerStartOffset = -3,
				uuid = "48dc59c9-2465-5768-9147-3cda95dda3df",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "efd6f0f6-d347-568b-84e5-984229e73e8a",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Lightning Safe\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"5e3b0e16-9ace-57d6-a6c4-f7f2dd00d8fc",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Lightning Safe",
							uuid = "ee928c8e-fa45-5efa-b044-61e73abf269b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Fire Safe\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"bfb222da-f847-54f0-8029-65167e5bd25b",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Fire Safe",
							uuid = "15f06ec9-02d4-58f6-bbf4-8c8220719ee8",
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
							eventSpellID = 40150,
							name = "Lightning Safe",
							uuid = "5e3b0e16-9ace-57d6-a6c4-f7f2dd00d8fc",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40151,
							name = "Fire Safe",
							uuid = "bfb222da-f847-54f0-8029-65167e5bd25b",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 56.2,
				name = "安全属性播报",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = 3,
				timerStartOffset = -3,
				uuid = "f182b9ad-53f9-5861-a979-f55c40c2d3fd",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then return end\n\nlocal entPos = ent.pos\nlocal x = entPos.x\nlocal z = entPos.z\nlocal h = eventArgs.heading\nlocal coneAngle = math.rad(22.5)\nlocal coneAdvancement = math.rad(22.5)\n\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedCone(2000, x, 0.05, z, 25, coneAngle, h, nil, false, nil, 256)\ndrawer:addTimedCone(2000, x, 0.05, z, 25, coneAngle, h - (coneAdvancement * 1), 2000, false, nil, 256)\ndrawer:addTimedCone(2000, x, 0.05, z, 25, coneAngle, h - (coneAdvancement * 2), 4000, false, nil, 256)\n\nself.used = true",
							conditions = 
							{
								
								{
									"c2f95afc-4f9b-56d3-ade2-4ffa110cbdab",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Queue Cones",
							uuid = "90911af5-3ee3-5ab9-bb28-1315ebd20731",
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
							eventSpellID = 40145,
							name = "Cast ID",
							uuid = "c2f95afc-4f9b-56d3-ade2-4ffa110cbdab",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				loop = true,
				mechanicTime = 56.2,
				name = "暴风破扇形范围",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = 1,
				timerStartOffset = -5,
				uuid = "65c28194-888e-58e1-aa97-fab76e320109",
				version = 2,
			},
		},
	},
	[16] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "5cda4ce7-6830-5e48-8a57-81a378e72ef4",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then return end\n\nif (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\n\nlocal headingToEnt = TensorCore.getHeadingToTarget(data.arenaCenter, ent.pos)\nlocal farPos = TensorCore.getPosInDirection(data.arenaCenter, headingToEnt, 40)\n\n-- Orange slim line in middle to know how close you can get to the KB.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D0070FF, nil, 0x4D0070FF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedRect(3000, farPos.x, 0.05, farPos.z, 80, 0.22, headingToEnt + math.pi, 7700, false, nil, 256)\n-- Redraw the Burnt Strike hit itself.\nlocal fruMoogle2 = TensorCore.getMoogleDrawer()\nlocal fruMuai2 = TensorCore.getCachedDrawer((fruMoogle2.colorStart and fruMoogle2.colorStart % 0x1000000 + 0x4D000000), (fruMoogle2.colorMid and fruMoogle2.colorMid % 0x1000000 + 0x4D000000), (fruMoogle2.colorEnd and fruMoogle2.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai2:setGradient(3, 0.15, 2)\nfruMuai2:setHeightOffset(0.05)\nfruMuai2:addTimedRect(3700, farPos.x, 0.05, farPos.z, 80, 10, headingToEnt + math.pi, 4000, false, nil, 256)\n\ndata.p1BurntStrikeHeading = TensorCore.convertHeading(headingToEnt)\n\nself.used = true",
							conditions = 
							{
								
								{
									"6e73a4d0-cabf-56a5-95a4-f56e7f2ae47a",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Redraw Burnt Strike",
							uuid = "81c37ddd-8ce0-5956-a625-25ce867cc3dc",
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
							eventSpellID = 40161,
							name = "Channel ID",
							spellIDList = 
							{
								40161,
							},
							uuid = "6e73a4d0-cabf-56a5-95a4-f56e7f2ae47a",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 60.2,
				name = "燃烧击火属性击退",
				timeRange = true,
				timelineIndex = 16,
				timerEndOffset = 6,
				timerStartOffset = -2,
				uuid = "143c31d7-59fb-5072-b7f5-e2cd70f66bda",
				version = 2,
			},
		},
	},
	[17] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "8bbdb36d-90bc-5a1d-8bb5-aeea92957915",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then\n    MuAiGuide.Reactions.log(\"[Utopian Safe Side] OnEntityAdd entity was nil!?\", 5)\n    self.used = true\n    return\nend\n\nif (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\n\nlocal h = TensorCore.getHeadingToTarget(data.arenaCenter, ent.pos)\nlocal d = TensorCore.getDistance2d(data.arenaCenter, ent.pos)\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedArrow(5000, 100, 0.05, 100, h, d, 1, nil, nil, nil, false, 256)\n\nself.used = true",
							conditions = 
							{
								
								{
									"2ba710b1-981a-5bea-9bbe-3417d56bc455",
									true,
								},
								
								{
									"ffe80c6b-851d-516f-bd4a-c5e49d910c54",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Safe Arrow",
							uuid = "b0f72dec-1507-50f8-927d-2f48c8c7f1c1",
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
							conditionLua = "return data.p1UtopianSafeElement == eventArgs.entityContentID",
							dequeueIfLuaFalse = true,
							name = "Correct Content ID",
							uuid = "2ba710b1-981a-5bea-9bbe-3417d56bc455",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then return false end\nreturn math.abs(ent.pos.z - 100) < 2",
							dequeueIfLuaFalse = true,
							name = "On West-East",
							uuid = "ffe80c6b-851d-516f-bd4a-c5e49d910c54",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 5,
				mechanicTime = 62.2,
				name = "光轮安全半场",
				timeRange = true,
				timelineIndex = 17,
				timerEndOffset = 3,
				timerStartOffset = -3,
				uuid = "ef455ef0-4e80-58cf-b4f4-30c8439e9d26",
				version = 2,
			},
		},
	},
	[18] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "c21c3a04-9ae9-5083-97de-ed79b7711804",
			},
			objectType = "folder",
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
							actionLua = "if (data.p1UtopianTethers == nil) then\n    ---@type integer[]\n    data.p1UtopianTethers = {}\n    data.p1UtopianTetherCount = 0\nend\n\ndata.p1UtopianTetherCount = data.p1UtopianTetherCount + 1\ntable.insert(data.p1UtopianTethers, eventArgs.newTargetID)\n\nself.used = true",
							conditions = 
							{
								
								{
									"d0ae2b3c-1d0d-543c-b462-30b9ed5def06",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Tether Target",
							uuid = "eed7a44e-473e-5cd2-816e-403e1e194a54",
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
							comparator = 3,
							conditionLua = "return eventArgs.newTetherID == 249",
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 249,
							name = "Tether ID",
							uuid = "d0ae2b3c-1d0d-543c-b462-30b9ed5def06",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 15,
				loop = true,
				mechanicTime = 66.2,
				name = "记录罪壤刺目标",
				timeRange = true,
				timelineIndex = 18,
				timerEndOffset = 2,
				timerStartOffset = -6,
				uuid = "0f3ce035-7120-5a04-92ad-e7f9e95e1b73",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "df86ae4b-eb8e-5c27-9766-5d94310773cd",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal ent1 = TensorCore.mGetEntity(data.p1UtopianTethers[1])\nlocal ent2 = TensorCore.mGetEntity(data.p1UtopianTethers[2])\n\nlocal isEnt1DPS = MuAiGuide.Reactions.dpsJobs[ent1.job] == true\nlocal isEnt2DPS = MuAiGuide.Reactions.dpsJobs[ent2.job] == true\nif (isEnt1DPS == isEnt2DPS) then\n    if (isEnt1DPS) then\n        MuAiGuide.Reactions.Shotcall(\"Double DPS Tethers\", true, 9)\n    else\n        MuAiGuide.Reactions.Shotcall(\"Double Support Tethers\", true, 9)\n    end\nelse\n    MuAiGuide.Reactions.Shotcall(\"Tethers Different Roles\", true, 9)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"d0ae2b3c-1d0d-543c-b462-30b9ed5def06",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Shotcall Tether",
							uuid = "eed7a44e-473e-5cd2-816e-403e1e194a54",
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
							conditionLua = "return data.p1UtopianTetherCount == 2",
							name = "Tethers Recorded",
							uuid = "d0ae2b3c-1d0d-543c-b462-30b9ed5def06",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 66.2,
				name = "罪壤刺分组播报",
				timeRange = true,
				timelineIndex = 18,
				timerEndOffset = 2,
				timerStartOffset = -6,
				uuid = "20393b5c-4ef0-5e5c-8eb1-2427f5dc650c",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal drawer = TensorCore.getCachedDrawer(0x4D79EB0E, nil, 0x4D79EB0E, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedCircleOnEnt(12000, data.p1UtopianTethers[1], 0.25, 0, false, nil, 256)\ndrawer:addTimedCircleOnEnt(12000, data.p1UtopianTethers[2], 0.25, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"6046285b-8e3c-5882-b340-2022caf10ef6",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Shotcall Tether",
							uuid = "eed7a44e-473e-5cd2-816e-403e1e194a54",
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
							conditionLua = "return data.p1UtopianTetherCount == 2",
							name = "Tethers Recorded",
							uuid = "6046285b-8e3c-5882-b340-2022caf10ef6",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 66.2,
				name = "罪壤刺目标范围",
				timeRange = true,
				timelineIndex = 18,
				timerEndOffset = 2,
				timerStartOffset = -6,
				uuid = "9d28fc3a-2ff7-5907-88f1-50b3faef4679",
				version = 2,
			},
		},
	},
	[19] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "fd967e96-1eb6-5ada-931e-559695c90c84",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move in\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"d5876784-16f2-562f-9c3c-a243a5c1fa37",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							name = "Shotcall Move In",
							uuid = "9f326ea4-bec1-5a14-be52-d748b8cde0d9",
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
							eventSpellID = 40161,
							name = "Cast ID",
							uuid = "d5876784-16f2-562f-9c3c-a243a5c1fa37",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 72.5,
				name = "靠近播报",
				timeRange = true,
				timelineIndex = 19,
				timerEndOffset = 1,
				timerStartOffset = -5,
				uuid = "ef22bec8-e052-5ceb-97a0-0322ce19460f",
				version = 2,
			},
		},
	},
	[20] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "25662c0c-abf7-521f-8b37-95d8a161fc6e",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal drawTime = (78.5 - TensorReactions_CurrentTimer) * 1000\nlocal drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\n\nfor _, ent in pairs(party) do\n    if (TensorCore.hasBuff(ent.id, 4165)) then\n        drawer:addTimedCircleOnEnt(drawTime, ent.id, 6, nil, false, nil, 256)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"56a60eea-19ee-558d-84a4-c3c7143e871e",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Sinsmokes",
							uuid = "7805222b-82ea-5513-ae15-9258fd4a8c3a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 4165,
							category = "Party",
							dequeueIfLuaFalse = true,
							name = "Fated Burn Mark Exists",
							partyTargetNumber = 2,
							partyTargetSubType = "Number",
							uuid = "56a60eea-19ee-558d-84a4-c3c7143e871e",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 78.5,
				name = "罪壤刺分摊范围",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = -1.5,
				timerOffset = -3,
				timerStartOffset = -4,
				uuid = "f8847462-b75c-5849-93bb-088620806cdd",
				version = 2,
			},
		},
	},
	[21] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "205322a1-39f3-50f7-aa49-945c277aa599",
			},
			objectType = "folder",
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
									"a1149ea4-b9fa-5022-812e-00f7807d7c70",
									true,
								},
								
								{
									"8dfc223a-a42b-5cce-945a-236d694de158",
									false,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							setTarget = true,
							targetType = "Enemy",
							uuid = "6213dab8-e9dc-5c18-841e-d6aa64f63ca4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Find Boss",
							uuid = "a1149ea4-b9fa-5022-812e-00f7807d7c70",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Current Target",
							name = "Target Filter",
							uuid = "8dfc223a-a42b-5cce-945a-236d694de158",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 80,
				name = "选中首领",
				timeRange = true,
				timelineIndex = 21,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "ec172a7b-1069-5ab5-aef1-444260acead3",
				version = 2,
			},
		},
	},
	[22] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "b7d0ea5e-37c0-513f-ac03-69be08f0dc5b",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nif (data.p1TetherCount == nil) then\n    data.p1TetherCount = 0\n    data.p1TetherInfo = {}\n    data.p1TetherEntIDs = {}\nend\ndata.p1TetherCount = data.p1TetherCount + 1\nlocal isFire = eventArgs.newTetherID == 249\nlocal tetherTypeString = isFire and \"fire\" or \"lightning\"\nlocal shortStr = isFire and \"F\" or \"L\"\nlocal textColor = isFire and 4014567932 or 4026299465\n\nlocal targetID = eventArgs.newTargetID\nlocal tetherInfo = { id = targetID, type = tetherTypeString }\ntable.insert(data.p1TetherInfo, tetherInfo)\ndata.p1TetherEntIDs[targetID] = true\n\nMuAiGuide.Reactions.addTimedWorldTextOnEnt(13000, tostring(data.p1TetherCount) .. shortStr, targetID, textColor, true, 2, 1.5)\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DFFA000, nil, 0x4DFFA000, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(3000, targetID, 0.2, 10000, false, nil, 256)\n\nlocal whiteDotUUID = data.p1FOFWhiteDotUUIDs[targetID]\nif (whiteDotUUID ~= nil) then\n    Argus.deleteTimedShape(whiteDotUUID)\n    data.p1FOFWhiteDotUUIDs[targetID] = nil\nend\n\nif TensorCore.mGetPlayer().id == targetID then\n    if data.p1TetherCount == 1 or data.p1TetherCount == 3 then\n        data.playerDirection = \"west\"\n    elseif data.p1TetherCount == 2 or data.p1TetherCount == 4 then\n        data.playerDirection = \"east\"\n    end\nend\n\ndata.p1FOFUpdateWorldText = true\n\nself.used = true",
							conditions = 
							{
								
								{
									"e103fed2-768d-5875-8dda-7a7582646397",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Tether Info",
							uuid = "f08669cb-ff8b-54af-a4b3-f8b4436240f6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.newTetherID == 249 or eventArgs.newTetherID == 287",
							conditions = 
							{
								
								{
									"339230bd-5972-dc74-a680-36e0da9e8297",
									true,
								},
								
								{
									"ebd10529-0807-7aa9-b498-da163ca13290",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "Valid Tether ID",
							partyTargetNumber = 0,
							uuid = "e103fed2-768d-5875-8dda-7a7582646397",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 5,
							eventIntValue = 249,
							name = "newTetherID 等于 249",
							uuid = "339230bd-5972-dc74-a680-36e0da9e8297",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 5,
							eventIntValue = 287,
							name = "newTetherID 等于 287",
							uuid = "ebd10529-0807-7aa9-b498-da163ca13290",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 15,
				loop = true,
				mechanicTime = 85.9,
				name = "记录罪壤断连线",
				timeRange = true,
				timelineIndex = 22,
				timerEndOffset = 19,
				timerStartOffset = 4,
				uuid = "b033862d-d450-5d1f-a007-c45f8634b5ee",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "5fba42ef-e280-596b-95ed-e1447488468f",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal drawTime = (114.5 - TensorReactions_CurrentTimer) * 1000\nlocal drawer = TensorCore.getCachedDrawer(0x4DFFFFE7, nil, 0x4DFFFFE7, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\n\ndata.p1FOFWhiteDotUUIDs = {}\n\nfor _, ent in pairs(party) do\n    data.p1FOFWhiteDotUUIDs[ent.id] = drawer:addTimedCircleOnEnt(drawTime, ent.id, 0.215, 0, false, nil, 256)\nend\n\nself.used = true",
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw White Dots",
							uuid = "72f84283-7c56-5a39-9e63-f6853ee6d9c1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 85.9,
				name = "队员位置白点",
				timelineIndex = 22,
				timerEndOffset = 8,
				timerOffset = 5,
				timerStartOffset = 3,
				uuid = "13d2505c-3733-52e1-9003-88fc616ee75a",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif (data.p1FOFAMTetherCount == nil) then\n    data.p1FOFAMTetherCount = 0\nend\n\ndata.p1FOFAMTetherCount = data.p1FOFAMTetherCount + 1\n\nlocal curCount = data.p1FOFAMTetherCount\nlocal markerID\nif (curCount == 1) then\n    markerID = 9\nelseif (curCount == 2) then\n    markerID = 6\nelseif (curCount == 3) then\n    markerID = 10\nelse\n    markerID = 7\nend\n\nlocal ent = TensorCore.mGetEntity(eventArgs.newTargetID)\nif (ent == nil or ent.marker == markerID) then\n    self.used = true\n    return\nend\n\nMuAiGuide.Reactions.Data.autoMarkersSet = true\nActionList:Get(12, markerID):Cast(eventArgs.newTargetID)\nself.used = true",
							conditions = 
							{
								
								{
									"0e616b03-3fef-5dff-8ef8-d735e93e2791",
									true,
								},
								
								{
									"297cd211-a9c0-57c1-b302-423801db2e45",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Mark Tethers",
							uuid = "1fcf20ac-d0cf-5fa0-a33a-d84b01126639",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruP1FOFAM == true",
							dequeueIfLuaFalse = true,
							name = "FoF AM Enabled",
							uuid = "0e616b03-3fef-5dff-8ef8-d735e93e2791",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.newTetherID == 249 or eventArgs.newTetherID == 287",
							conditions = 
							{
								
								{
									"3c29702b-475b-ed2b-961d-419dffcdc76a",
									true,
								},
								
								{
									"83a1ecde-4878-eb22-bf3b-05422d08c309",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "Tether ID",
							partyTargetNumber = 0,
							uuid = "297cd211-a9c0-57c1-b302-423801db2e45",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 5,
							eventIntValue = 249,
							name = "newTetherID 等于 249",
							uuid = "3c29702b-475b-ed2b-961d-419dffcdc76a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 5,
							eventIntValue = 287,
							name = "newTetherID 等于 287",
							uuid = "83a1ecde-4878-eb22-bf3b-05422d08c309",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				eventType = 15,
				loop = true,
				mechanicTime = 85.9,
				name = "标记连线顺序",
				timeRange = true,
				timelineIndex = 22,
				timerEndOffset = 19,
				timerStartOffset = 4,
				uuid = "01d479ef-193f-59c7-b322-7b8113bfaf13",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Tether \"..data.p1TetherCount..\" on you\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"076b5366-1c8d-55ea-bd3d-8994186e2db8",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Shotcall Tether Count",
							uuid = "ca0ac6e0-8678-5052-a39b-984a493a5d65",
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
							conditionLua = "return data.p1TetherEntIDs ~= nil and data.p1TetherEntIDs[TensorCore.mGetPlayer().id] == true",
							name = "Player Tethered",
							uuid = "076b5366-1c8d-55ea-bd3d-8994186e2db8",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 85.9,
				name = "连线次数播报",
				timeRange = true,
				timelineIndex = 22,
				timerEndOffset = 19,
				timerStartOffset = 4,
				uuid = "4ef0d2fc-daeb-5f09-bfaf-d8bd79af1c4d",
				version = 2,
			},
		},
	},
	[23] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "98803cdd-914d-5694-9e04-c8cb20f03665",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal party = MuAiGuide.Reactions.partyInfo()\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal validUUIDs = {}\nlocal textTime = (113.7 - TensorReactions_CurrentTimer) * 1000\nlocal emptyString = \"\"\nlocal partyCount = 0\n\nfor _, ent in pairs(party) do\n    partyCount = partyCount + 1\n    local uuid = MuAiGuide.Reactions.addTimedWorldTextOnEnt(textTime, emptyString, ent.id, 0, false, 2, 0.25)\n    validUUIDs[uuid] = true\nend\n\nif (partyCount < 8) then\n    MuAiGuide.Reactions.log(\"[FoF Flex Helper] Attempted to set up party list, but not all 8 party members were found? Is someone dead?\", 5)\n    self.used = true\n    return\nend\n\n---@type TimedWorldText[]\ndata.p1FOFHelperWorldTexts = {}\n\nfor _, worldText in pairs(MuAiGuide.Reactions.Data.timedWorldTextDraws) do\n    if (validUUIDs[worldText.uuid]) then\n        table.insert(data.p1FOFHelperWorldTexts, worldText)\n    end\nend\n\ndata.p1FOFHelperSetup = true\nself.used = true",
							conditions = 
							{
								
								{
									"a4de18c3-6674-5b25-977c-bc785fe899c2",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Initialize Flex Helper",
							uuid = "cecf1196-1766-5eac-80a7-a6d34371c602",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruP1FOFHelper == true",
							dequeueIfLuaFalse = true,
							name = "Flex Helper Enabled",
							uuid = "a4de18c3-6674-5b25-977c-bc785fe899c2",
							version = 3,
						},
						inheritedIndex = 1,
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 101.5,
				name = "初始化罪壤断补位",
				timelineIndex = 23,
				timerOffset = -8,
				uuid = "c2d60615-c058-572c-8b5a-b82bd18a8301",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\ndata.p1FOFUpdateWorldText = false\n\n---@type table<integer, boolean>\nlocal hasTetherDic = data.p1TetherEntIDs\nlocal worldTextArray = data.p1FOFHelperWorldTexts\n\n---@class GameObjectWithWorldText: GameObject\n---@field worldText TimedWorldText\n\n---@type GameObjectWithWorldText[]\nlocal sortCache = data.StringFRU_FoFSort\nif sortCache == nil then\n    sortCache = {\n        entities = {},\n        byX = function(a, b) return a.pos.x < b.pos.x end,\n        byZ = function(a, b) return a.pos.z < b.pos.z end,\n    }\n    data.StringFRU_FoFSort = sortCache\nend\nlocal nonTetheredEnts = sortCache.entities\nlocal nonTetheredCount = 0\nlocal emptyString = \"\"\nfor i = 1, 8 do\n    local worldText = worldTextArray[i]\n    worldText.bg = false\n    worldText.str = emptyString\n    worldText.color = 0\n    if (hasTetherDic[worldText.entID] ~= true) then\n        local ent = TensorCore.mGetEntity(worldText.entID)\n        ---@diagnostic disable-next-line: inject-field\n        ent.worldText = worldText\n        nonTetheredCount = nonTetheredCount + 1\n        nonTetheredEnts[nonTetheredCount] = ent\n    end\nend\n\nfor i = nonTetheredCount + 1, #nonTetheredEnts do\n    nonTetheredEnts[i] = nil\nend\n\nif (nonTetheredCount < 4) then\n    MuAiGuide.Reactions.log(\"[FoF Flex Helper] Less than 4 non-tethered players found. Y'all about to be dead.\")\n    self.used = true\n    return\nend\n\nlocal stratType = MuAiGuide.Reactions.Settings.Reactions.fruP1FOFHelperType\nif stratType == 1 then -- West to East / NAUR\n    table.sort(nonTetheredEnts, sortCache.byX)\nelseif stratType == 2 then -- North to South / EU LPDU\n    table.sort(nonTetheredEnts, sortCache.byZ)\nend\n\nlocal west1 = nonTetheredEnts[1].worldText\nlocal west2 = nonTetheredEnts[2].worldText\nlocal east1 = nonTetheredEnts[nonTetheredCount].worldText\nlocal east2 = nonTetheredEnts[nonTetheredCount - 1].worldText\n\nwest1.bg = true\nwest1.color = 4294967295\nwest1.heightAddition = 0.5\n\nwest2.bg = true\nwest2.color = 4294967295\nwest2.heightAddition = 0.5\n\neast1.bg = true\neast1.color = 4294967295\neast1.heightAddition = 0.5\n\neast2.bg = true\neast2.color = 4294967295\neast2.heightAddition = 0.5\n\nif stratType == 1 then\n    west1.str = \"W1\"\n    west2.str = \"W2\"\n    east1.str = \"E1\"\n    east2.str = \"E2\"\nelseif stratType == 2 then\n    west1.str = \"N1\"\n    west2.str = \"N2\"\n    east1.str = \"S2\"\n    east2.str = \"S1\"\nelseif stratType == 3 then\n    west1.str = \"\"\n    west2.str = \"\"\n    east1.str = \"\"\n    east2.str = \"\"\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"244e964c-e1c2-59bc-8296-90b893ae3c66",
									true,
								},
								
								{
									"e03fce3c-16b1-5106-a330-384aebc195bd",
									true,
								},
								
								{
									"96b484db-6396-5db7-995e-3e592600142d",
									true,
								},
								
								{
									"6439e10a-6f82-5eae-b7cc-62d1ac67d176",
									false,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Update FoF WorldText",
							uuid = "af6c4b93-3bc6-518d-9444-e5ed83db6ad5",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\ndata.p1FOFUpdateWorldText = false\n\n---@type table<integer, boolean>\nlocal hasTetherDic = data.p1TetherEntIDs\nlocal worldTextArray = data.p1FOFHelperWorldTexts\n\n---@class GameObjectWithWorldText: GameObject\n---@field worldText TimedWorldText\n\n---@type GameObjectWithWorldText[]\nlocal sortCache = data.StringFRU_FoFSort\nif sortCache == nil then\n    sortCache = {\n        entities = {},\n        byX = function(a, b) return a.pos.x < b.pos.x end,\n        byZ = function(a, b) return a.pos.z < b.pos.z end,\n    }\n    data.StringFRU_FoFSort = sortCache\nend\nlocal nonTetheredEnts = sortCache.entities\nlocal nonTetheredCount = 0\nlocal emptyString = \"\"\nfor i = 1, 8 do\n    local worldText = worldTextArray[i]\n    worldText.bg = false\n    worldText.str = emptyString\n    worldText.color = 0\n    if (hasTetherDic[worldText.entID] ~= true) then\n        local ent = TensorCore.mGetEntity(worldText.entID)\n        ---@diagnostic disable-next-line: inject-field\n        ent.worldText = worldText\n        nonTetheredCount = nonTetheredCount + 1\n        nonTetheredEnts[nonTetheredCount] = ent\n    end\nend\n\nfor i = nonTetheredCount + 1, #nonTetheredEnts do\n    nonTetheredEnts[i] = nil\nend\n\nif (nonTetheredCount < 4) then\n    MuAiGuide.Reactions.log(\"[FoF Flex Helper] Less than 4 non-tethered players found. Y'all about to be dead.\")\n    self.used = true\n    return\nend\n\nlocal stratType = MuAiGuide.Reactions.Settings.Reactions.fruP1FOFHelperType\nif stratType == 1 then -- West to East / NAUR\n    table.sort(nonTetheredEnts, sortCache.byX)\nelseif stratType == 2 then -- North to South / EU LPDU\n    table.sort(nonTetheredEnts, sortCache.byZ)\nend\n\nlocal west1 = nonTetheredEnts[1].worldText\nlocal west2 = nonTetheredEnts[2].worldText\nlocal east1 = nonTetheredEnts[nonTetheredCount].worldText\nlocal east2 = nonTetheredEnts[nonTetheredCount - 1].worldText\n\nwest1.bg = true\nwest1.color = 4284743523\nwest1.heightAddition = 0.5\n\nwest2.bg = true\nwest2.color = 4284743523\nwest2.heightAddition = 0.5\n\neast1.bg = true\neast1.color = 4284743523\neast1.heightAddition = 0.5\n\neast2.bg = true\neast2.color = 4284743523\neast2.heightAddition = 0.5\n\nif stratType == 1 then\n    west1.str = \"W1\"\n    west2.str = \"W2\"\n    east1.str = \"E1\"\n    east2.str = \"E2\"\nelseif stratType == 2 then\n    west1.str = \"N1\"\n    west2.str = \"N2\"\n    east1.str = \"S2\"\n    east2.str = \"S1\"\nelseif stratType == 3 then\n    west1.str = \"\"\n    west2.str = \"\"\n    east1.str = \"\"\n    east2.str = \"\"\nend\n\nlocal playerID = TensorCore.mGetPlayer().id\nif west1.entID == playerID or west2.entID == playerID then\n    data.playerDirection = \"west\"\nelseif east1.entID == playerID or east2.entID == playerID then\n    data.playerDirection = \"east\"\nend\n\ndata.p1FOFHelperHasFinished = true\n\nself.used = true",
							conditions = 
							{
								
								{
									"244e964c-e1c2-59bc-8296-90b893ae3c66",
									true,
								},
								
								{
									"e03fce3c-16b1-5106-a330-384aebc195bd",
									true,
								},
								
								{
									"96b484db-6396-5db7-995e-3e592600142d",
									true,
								},
								
								{
									"6439e10a-6f82-5eae-b7cc-62d1ac67d176",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Finalize FoF WorldText",
							uuid = "bbd0522e-5ab4-534a-b8ca-1215a3441465",
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
							conditionLua = "return data.p1FOFHelperSetup == true",
							dequeueIfLuaFalse = true,
							name = "Helper Setup Finished",
							uuid = "244e964c-e1c2-59bc-8296-90b893ae3c66",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p1FOFHelperHasFinished ~= true",
							dequeueIfLuaFalse = true,
							name = "Helper Not Finalized",
							uuid = "e03fce3c-16b1-5106-a330-384aebc195bd",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p1FOFUpdateWorldText == true",
							dequeueIfLuaFalse = true,
							name = "Needs updated",
							uuid = "96b484db-6396-5db7-995e-3e592600142d",
							version = 3,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p1TetherCount == 4",
							dequeueIfLuaFalse = true,
							name = "Four Tethers",
							uuid = "6439e10a-6f82-5eae-b7cc-62d1ac67d176",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				loop = true,
				mechanicTime = 101.5,
				name = "更新罪壤断补位提示",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 5,
				timerStartOffset = -10,
				uuid = "e7c941e5-ba35-5bbb-983c-77562eda2ba3",
				version = 2,
			},
		},
	},
	[24] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "b6463a4d-7946-5b6f-a005-4aa90c6599a7",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal playerID = TensorCore.mGetPlayer().id\nlocal callStr = \"\"\n\nfor i = 1, 4 do\n    local tetherInfo = data.p1TetherInfo[i]\n    if (tetherInfo.type == \"fire\") then\n        callStr = callStr .. \"F\"\n    else\n        callStr = callStr .. \"L\"\n    end\n\n    if (tetherInfo.id == playerID) then\n        callStr = callStr .. \"(YOU)\"\n    end\n\n    if (i < 4) then\n        callStr = callStr .. \", \"\n    end\nend\n\nMuAiGuide.Reactions.Shotcall(callStr, false, 13)\nself.used = true",
							conditions = 
							{
								
								{
									"0c7c5aee-44f6-5d41-a4e0-a63ba80e25d1",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Shotcall Tethers",
							uuid = "93cc8746-b709-5ea6-96a9-4c326f669184",
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
							conditionLua = "return data.p1TetherCount == 4",
							name = "Four Tethers",
							uuid = "0c7c5aee-44f6-5d41-a4e0-a63ba80e25d1",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 102.2,
				name = "连线顺序播报",
				timeRange = true,
				timelineIndex = 24,
				timerEndOffset = 3,
				timerStartOffset = -5,
				uuid = "a0fb2d4d-dae9-5a64-9bc5-651ef89fddbc",
				version = 2,
			},
		},
	},
	[25] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "29f2e8e8-8ed4-5136-98fb-4b1457a9a3af",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\n---@type GameObject[]\nlocal nonTetheredArray = {}\nlocal isTetherDic = data.p1TetherEntIDs\n\nfor _, ent in pairs(party) do\n    if (isTetherDic[ent.id] ~= true) then\n        table.insert(nonTetheredArray, ent)\n    end\nend\n\n-- Priority comes from the Party Roster conga order (issue #46). This also\n-- fixes the legacy bug where the dictionary was keyed by a field the old\n-- priority-list entries never carried (entityID vs id), so the sort below\n-- actually ranks players now.\nlocal prioDic = MuAiGuide.Reactions.Roster.prio(\"conga\").byId\ntable.sort(nonTetheredArray, function(a, b)\n    return (prioDic[a.id] or 99) < (prioDic[b.id] or 99)\nend)\n\nfor i = 1, 4 do\n    local ent = nonTetheredArray[i]\n    if (ent == nil) then break end\n    if (ent.marker ~= i) then\n        ActionList:Get(12, i):Cast(ent.id)\n    end\nend\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"eee35151-1d9f-5336-ab38-cbcae73cb70e",
									true,
								},
								
								{
									"5f9200b7-1a7b-5e73-accf-3d1d1785686c",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Automark Players",
							uuid = "1279211b-c66b-5adf-9494-26cc8ca6a513",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruP1FOFAM == true",
							dequeueIfLuaFalse = true,
							name = "FoF AM Enabled",
							uuid = "eee35151-1d9f-5336-ab38-cbcae73cb70e",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p1TetherCount == 4",
							name = "Four Tethers",
							uuid = "5f9200b7-1a7b-5e73-accf-3d1d1785686c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				loop = true,
				mechanicTime = 105.8,
				name = "标记无连线队员",
				throttleTime = 500,
				timeRange = true,
				timelineIndex = 25,
				timerEndOffset = -0.5,
				timerStartOffset = -8,
				uuid = "d97d1681-3209-54df-a99d-875d41496dcc",
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
							actionLua = "-- 罪壤断: 每次更新重选连线玩家之外最近 1/3 人, 判定事件结束本轮.\nlocal key = 25\nlocal rounds = data.StringFRUFoFDraws\nif rounds == nil then rounds = {}; data.StringFRUFoFDraws = rounds end\nlocal state = rounds[key]\nif state == nil then\n    state = {draws = {}, targets = {}}\n    rounds[key] = state\nend\nlocal remaining = (106.4 - TensorReactions_CurrentTimer) * 1000\nif remaining <= 0 or (data.StringFRUDrawHits and data.StringFRUDrawHits[key]) then\n    for i = 1, 3 do\n        if state.draws[i] then Argus.deleteTimedShape(state.draws[i]); state.draws[i] = nil end\n    end\n    self.used = true\n    return\nend\nlocal info = data.p1TetherInfo and data.p1TetherInfo[1]\nif info == nil then self.used = true; return end\nlocal source = TensorCore.mGetEntity(info.id)\nif source == nil then self.used = true; return end\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal id1, id2, id3\nlocal d1, d2, d3 = math.huge, math.huge, math.huge\nlocal origin = source.pos\nfor _, ent in pairs(party) do\n    if ent.id ~= source.id then\n        local dx, dz = ent.pos.x - origin.x, ent.pos.z - origin.z\n        local d = dx * dx + dz * dz\n        if d < d1 or (d == d1 and (id1 == nil or ent.id < id1)) then\n            id3, d3, id2, d2, id1, d1 = id2, d2, id1, d1, ent.id, d\n        elseif d < d2 or (d == d2 and (id2 == nil or ent.id < id2)) then\n            id3, d3, id2, d2 = id2, d2, ent.id, d\n        elseif d < d3 or (d == d3 and (id3 == nil or ent.id < id3)) then\n            id3, d3 = ent.id, d\n        end\n    end\nend\nlocal targets = state.targets\ntargets[1], targets[2], targets[3] = id1, id2, id3\nlocal fire = info.type == \"fire\"\nlocal count = fire and 1 or 3\nlocal angle = math.rad(fire and 90 or 120)\nlocal drawer = state.drawer\nif drawer == nil then\n    local colors = TensorCore.getMoogleDrawer()\n    drawer = TensorCore.getCachedDrawer((colors.colorStart and colors.colorStart % 0x1000000 + 0x4D000000),\n        (colors.colorMid and colors.colorMid % 0x1000000 + 0x4D000000),\n        (colors.colorEnd and colors.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\nfor i = 1, 3 do\n    local target = i <= count and targets[i] or nil\n    local draw = state.draws[i]\n    if target == nil then\n        if draw then Argus.deleteTimedShape(draw); state.draws[i] = nil end\n        state[i] = nil\n    elseif draw == nil or state[i] ~= target or state.sourceID ~= source.id or state.angle ~= angle then\n        if draw and not drawer:updateTimedConeOnEnt(draw, nil, source.id, nil, angle, target) then\n            draw = nil\n        end\n        if draw == nil then\n            draw = drawer:addTimedConeOnEnt(remaining, source.id, 60, angle, target, 0, false, nil, nil, nil, 256)\n        end\n        state.draws[i] = draw\n        if draw then state[i] = target end\n    end\nend\nstate.sourceID, state.angle = source.id, angle\nself.used = true\n",
							conditions = 
							{
								
								{
									"600c7065-d843-53c3-90e1-5d849181bf70",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Cones",
							uuid = "c6ff4b8c-fb7c-5199-86ac-587ac9bfda3e",
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
							conditionLua = "return data.p1TetherInfo ~= nil",
							dequeueIfLuaFalse = true,
							name = "Tethers Recorded",
							uuid = "600c7065-d843-53c3-90e1-5d849181bf70",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 105.8,
				name = "罪壤断雷火扇形",
				timeRange = true,
				timelineIndex = 25,
				timerEndOffset = 0.6,
				timerStartOffset = -2,
				uuid = "33cabc65-923b-5904-af5b-6a88cf3432e3",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif data.p1TetherInfo and data.p1TetherInfo[3] and data.p1TetherInfo[3].id == TensorCore.mGetPlayer().id then\n    MuAiGuide.Reactions.Shotcall(\"Swap\", true)\nend\nself.used = true",
							gVar = "ACR_RikuDRG3_CD",
							uuid = "57e9227b-85a3-5b93-bc7f-ba74d44fb7ba",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 105.8,
				name = "连线换位播报",
				timelineIndex = 25,
				uuid = "004cfbee-d7b3-5103-a70b-23a9c7a1e9d8",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Dark First\", true)\nMuAiGuide.Reactions.Shotcall(\"Party Out / OT In\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"f64aa173-1fd9-5ad9-9098-0073a30203d4",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "TTS Dark First",
							uuid = "e6f06481-b114-569d-b903-f0875d3acc3e",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Light First\", true)\nMuAiGuide.Reactions.Shotcall(\"Party In / MT Out\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"762fdaf4-ce81-5533-a4ae-80b3c6e18c8b",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "TTS Light First",
							uuid = "9b1080c4-b132-5ce1-8de4-9ca31aa42c13",
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
							eventSpellID = 40233,
							name = "Dark First",
							uuid = "f64aa173-1fd9-5ad9-9098-0073a30203d4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40313,
							name = "Light First",
							uuid = "762fdaf4-ce81-5533-a4ae-80b3c6e18c8b",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 105.8,
				name = "首轮雷火播报",
				timeRange = true,
				timelineIndex = 25,
				timerEndOffset = -5,
				timerStartOffset = -10,
				uuid = "80cb4047-43a2-55f1-a6c8-f6cb3774c515",
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
							actionLua = "data.StringFRUDrawHits = data.StringFRUDrawHits or {}\ndata.StringFRUDrawHits[25] = true\nself.used = true",
							conditions = 
							{
								
								{
									"0bbe434d-2442-3980-95ea-a371eddfdf85",
									true,
								},
							},
							name = "结束本轮绘图",
							uuid = "3be2ed7b-743d-1e4b-a5d3-b623c620976c",
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
							name = "实际判定技能",
							spellIDList = 
							{
								40143,
								40156,
							},
							uuid = "0bbe434d-2442-3980-95ea-a371eddfdf85",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 105.8,
				name = "罪壤断判定结束",
				timeRange = true,
				timelineIndex = 25,
				timerEndOffset = 0.6,
				timerStartOffset = -0.6,
				uuid = "2af4c021-b93a-0092-a77a-c8f280c1727b",
				version = 2,
			},
		},
	},
	[26] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "8005013e-1c82-565c-8c7e-56760534a8ae",
			},
			objectType = "folder",
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
							actionLua = "-- 罪壤断: 每次更新重选连线玩家之外最近 1/3 人, 判定事件结束本轮.\nlocal key = 26\nlocal rounds = data.StringFRUFoFDraws\nif rounds == nil then rounds = {}; data.StringFRUFoFDraws = rounds end\nlocal state = rounds[key]\nif state == nil then\n    state = {draws = {}, targets = {}}\n    rounds[key] = state\nend\nlocal remaining = (109.2 - TensorReactions_CurrentTimer) * 1000\nif remaining <= 0 or (data.StringFRUDrawHits and data.StringFRUDrawHits[key]) then\n    for i = 1, 3 do\n        if state.draws[i] then Argus.deleteTimedShape(state.draws[i]); state.draws[i] = nil end\n    end\n    self.used = true\n    return\nend\nlocal info = data.p1TetherInfo and data.p1TetherInfo[2]\nif info == nil then self.used = true; return end\nlocal source = TensorCore.mGetEntity(info.id)\nif source == nil then self.used = true; return end\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal id1, id2, id3\nlocal d1, d2, d3 = math.huge, math.huge, math.huge\nlocal origin = source.pos\nfor _, ent in pairs(party) do\n    if ent.id ~= source.id then\n        local dx, dz = ent.pos.x - origin.x, ent.pos.z - origin.z\n        local d = dx * dx + dz * dz\n        if d < d1 or (d == d1 and (id1 == nil or ent.id < id1)) then\n            id3, d3, id2, d2, id1, d1 = id2, d2, id1, d1, ent.id, d\n        elseif d < d2 or (d == d2 and (id2 == nil or ent.id < id2)) then\n            id3, d3, id2, d2 = id2, d2, ent.id, d\n        elseif d < d3 or (d == d3 and (id3 == nil or ent.id < id3)) then\n            id3, d3 = ent.id, d\n        end\n    end\nend\nlocal targets = state.targets\ntargets[1], targets[2], targets[3] = id1, id2, id3\nlocal fire = info.type == \"fire\"\nlocal count = fire and 1 or 3\nlocal angle = math.rad(fire and 90 or 120)\nlocal drawer = state.drawer\nif drawer == nil then\n    local colors = TensorCore.getMoogleDrawer()\n    drawer = TensorCore.getCachedDrawer((colors.colorStart and colors.colorStart % 0x1000000 + 0x4D000000),\n        (colors.colorMid and colors.colorMid % 0x1000000 + 0x4D000000),\n        (colors.colorEnd and colors.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\nfor i = 1, 3 do\n    local target = i <= count and targets[i] or nil\n    local draw = state.draws[i]\n    if target == nil then\n        if draw then Argus.deleteTimedShape(draw); state.draws[i] = nil end\n        state[i] = nil\n    elseif draw == nil or state[i] ~= target or state.sourceID ~= source.id or state.angle ~= angle then\n        if draw and not drawer:updateTimedConeOnEnt(draw, nil, source.id, nil, angle, target) then\n            draw = nil\n        end\n        if draw == nil then\n            draw = drawer:addTimedConeOnEnt(remaining, source.id, 60, angle, target, 0, false, nil, nil, nil, 256)\n        end\n        state.draws[i] = draw\n        if draw then state[i] = target end\n    end\nend\nstate.sourceID, state.angle = source.id, angle\nself.used = true\n",
							conditions = 
							{
								
								{
									"600c7065-d843-53c3-90e1-5d849181bf70",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Cones",
							uuid = "c6ff4b8c-fb7c-5199-86ac-587ac9bfda3e",
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
							conditionLua = "return data.p1TetherInfo ~= nil",
							dequeueIfLuaFalse = true,
							name = "Tethers Recorded",
							uuid = "600c7065-d843-53c3-90e1-5d849181bf70",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 108.6,
				name = "罪壤断雷火扇形",
				timeRange = true,
				timelineIndex = 26,
				timerEndOffset = 0.6,
				timerStartOffset = -2,
				uuid = "077c4ab5-0afd-512c-84c0-46ebb2750de1",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif data.p1TetherInfo and data.p1TetherInfo[4] and data.p1TetherInfo[4].id == TensorCore.mGetPlayer().id then\n    MuAiGuide.Reactions.Shotcall(\"Swap\", true)\nend\nself.used = true",
							gVar = "ACR_RikuDRG3_CD",
							uuid = "57e9227b-85a3-5b93-bc7f-ba74d44fb7ba",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 108.6,
				name = "换位播报",
				timelineIndex = 26,
				uuid = "c2411c10-aca2-5e3d-aca0-a66d8d19a17c",
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
							actionLua = "data.StringFRUDrawHits = data.StringFRUDrawHits or {}\ndata.StringFRUDrawHits[26] = true\nself.used = true",
							conditions = 
							{
								
								{
									"08e8b043-1427-9d35-8828-763e075a8b51",
									true,
								},
							},
							name = "结束本轮绘图",
							uuid = "32e3a9ce-3366-4aed-8545-09b8cc43e907",
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
							name = "实际判定技能",
							spellIDList = 
							{
								40143,
								40156,
							},
							uuid = "08e8b043-1427-9d35-8828-763e075a8b51",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 108.6,
				name = "罪壤断判定结束",
				timeRange = true,
				timelineIndex = 26,
				timerEndOffset = 0.6,
				timerStartOffset = -0.6,
				uuid = "44e8d9e8-16bf-ce02-8694-01762b69ea7f",
				version = 2,
			},
		},
	},
	[27] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "361f13b5-aa43-57f4-97e7-f7f164906e81",
			},
			objectType = "folder",
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
							actionLua = "-- 罪壤断: 每次更新重选连线玩家之外最近 1/3 人, 判定事件结束本轮.\nlocal key = 27\nlocal rounds = data.StringFRUFoFDraws\nif rounds == nil then rounds = {}; data.StringFRUFoFDraws = rounds end\nlocal state = rounds[key]\nif state == nil then\n    state = {draws = {}, targets = {}}\n    rounds[key] = state\nend\nlocal remaining = (111.9 - TensorReactions_CurrentTimer) * 1000\nif remaining <= 0 or (data.StringFRUDrawHits and data.StringFRUDrawHits[key]) then\n    for i = 1, 3 do\n        if state.draws[i] then Argus.deleteTimedShape(state.draws[i]); state.draws[i] = nil end\n    end\n    self.used = true\n    return\nend\nlocal info = data.p1TetherInfo and data.p1TetherInfo[3]\nif info == nil then self.used = true; return end\nlocal source = TensorCore.mGetEntity(info.id)\nif source == nil then self.used = true; return end\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal id1, id2, id3\nlocal d1, d2, d3 = math.huge, math.huge, math.huge\nlocal origin = source.pos\nfor _, ent in pairs(party) do\n    if ent.id ~= source.id then\n        local dx, dz = ent.pos.x - origin.x, ent.pos.z - origin.z\n        local d = dx * dx + dz * dz\n        if d < d1 or (d == d1 and (id1 == nil or ent.id < id1)) then\n            id3, d3, id2, d2, id1, d1 = id2, d2, id1, d1, ent.id, d\n        elseif d < d2 or (d == d2 and (id2 == nil or ent.id < id2)) then\n            id3, d3, id2, d2 = id2, d2, ent.id, d\n        elseif d < d3 or (d == d3 and (id3 == nil or ent.id < id3)) then\n            id3, d3 = ent.id, d\n        end\n    end\nend\nlocal targets = state.targets\ntargets[1], targets[2], targets[3] = id1, id2, id3\nlocal fire = info.type == \"fire\"\nlocal count = fire and 1 or 3\nlocal angle = math.rad(fire and 90 or 120)\nlocal drawer = state.drawer\nif drawer == nil then\n    local colors = TensorCore.getMoogleDrawer()\n    drawer = TensorCore.getCachedDrawer((colors.colorStart and colors.colorStart % 0x1000000 + 0x4D000000),\n        (colors.colorMid and colors.colorMid % 0x1000000 + 0x4D000000),\n        (colors.colorEnd and colors.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\nfor i = 1, 3 do\n    local target = i <= count and targets[i] or nil\n    local draw = state.draws[i]\n    if target == nil then\n        if draw then Argus.deleteTimedShape(draw); state.draws[i] = nil end\n        state[i] = nil\n    elseif draw == nil or state[i] ~= target or state.sourceID ~= source.id or state.angle ~= angle then\n        if draw and not drawer:updateTimedConeOnEnt(draw, nil, source.id, nil, angle, target) then\n            draw = nil\n        end\n        if draw == nil then\n            draw = drawer:addTimedConeOnEnt(remaining, source.id, 60, angle, target, 0, false, nil, nil, nil, 256)\n        end\n        state.draws[i] = draw\n        if draw then state[i] = target end\n    end\nend\nstate.sourceID, state.angle = source.id, angle\nself.used = true\n",
							conditions = 
							{
								
								{
									"600c7065-d843-53c3-90e1-5d849181bf70",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Cones",
							uuid = "c6ff4b8c-fb7c-5199-86ac-587ac9bfda3e",
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
							conditionLua = "return data.p1TetherInfo ~= nil",
							dequeueIfLuaFalse = true,
							name = "Tethers Recorded",
							uuid = "600c7065-d843-53c3-90e1-5d849181bf70",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 111.3,
				name = "罪壤断雷火扇形",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = 0.6,
				timerStartOffset = -2.5,
				uuid = "a0866261-39c3-5832-9d73-3af79d8250df",
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
							actionLua = "data.StringFRUDrawHits = data.StringFRUDrawHits or {}\ndata.StringFRUDrawHits[27] = true\nself.used = true",
							conditions = 
							{
								
								{
									"4e630725-a30e-06ff-81ed-125383183a2c",
									true,
								},
							},
							name = "结束本轮绘图",
							uuid = "e5a239f8-9777-ea57-8762-4dc2af879501",
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
							name = "实际判定技能",
							spellIDList = 
							{
								40143,
								40156,
							},
							uuid = "4e630725-a30e-06ff-81ed-125383183a2c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 111.3,
				name = "罪壤断判定结束",
				timeRange = true,
				timelineIndex = 27,
				timerEndOffset = 0.6,
				timerStartOffset = -0.6,
				uuid = "e3bf2b69-48d6-ba55-87a6-7a219fd241a3",
				version = 2,
			},
		},
	},
	[28] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "678919c2-ef16-5dc4-aad9-6ab2115e4aae",
			},
			objectType = "folder",
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
							actionLua = "-- 罪壤断: 每次更新重选连线玩家之外最近 1/3 人, 判定事件结束本轮.\nlocal key = 28\nlocal rounds = data.StringFRUFoFDraws\nif rounds == nil then rounds = {}; data.StringFRUFoFDraws = rounds end\nlocal state = rounds[key]\nif state == nil then\n    state = {draws = {}, targets = {}}\n    rounds[key] = state\nend\nlocal remaining = (114.3 - TensorReactions_CurrentTimer) * 1000\nif remaining <= 0 or (data.StringFRUDrawHits and data.StringFRUDrawHits[key]) then\n    for i = 1, 3 do\n        if state.draws[i] then Argus.deleteTimedShape(state.draws[i]); state.draws[i] = nil end\n    end\n    self.used = true\n    return\nend\nlocal info = data.p1TetherInfo and data.p1TetherInfo[4]\nif info == nil then self.used = true; return end\nlocal source = TensorCore.mGetEntity(info.id)\nif source == nil then self.used = true; return end\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal id1, id2, id3\nlocal d1, d2, d3 = math.huge, math.huge, math.huge\nlocal origin = source.pos\nfor _, ent in pairs(party) do\n    if ent.id ~= source.id then\n        local dx, dz = ent.pos.x - origin.x, ent.pos.z - origin.z\n        local d = dx * dx + dz * dz\n        if d < d1 or (d == d1 and (id1 == nil or ent.id < id1)) then\n            id3, d3, id2, d2, id1, d1 = id2, d2, id1, d1, ent.id, d\n        elseif d < d2 or (d == d2 and (id2 == nil or ent.id < id2)) then\n            id3, d3, id2, d2 = id2, d2, ent.id, d\n        elseif d < d3 or (d == d3 and (id3 == nil or ent.id < id3)) then\n            id3, d3 = ent.id, d\n        end\n    end\nend\nlocal targets = state.targets\ntargets[1], targets[2], targets[3] = id1, id2, id3\nlocal fire = info.type == \"fire\"\nlocal count = fire and 1 or 3\nlocal angle = math.rad(fire and 90 or 120)\nlocal drawer = state.drawer\nif drawer == nil then\n    local colors = TensorCore.getMoogleDrawer()\n    drawer = TensorCore.getCachedDrawer((colors.colorStart and colors.colorStart % 0x1000000 + 0x4D000000),\n        (colors.colorMid and colors.colorMid % 0x1000000 + 0x4D000000),\n        (colors.colorEnd and colors.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\nfor i = 1, 3 do\n    local target = i <= count and targets[i] or nil\n    local draw = state.draws[i]\n    if target == nil then\n        if draw then Argus.deleteTimedShape(draw); state.draws[i] = nil end\n        state[i] = nil\n    elseif draw == nil or state[i] ~= target or state.sourceID ~= source.id or state.angle ~= angle then\n        if draw and not drawer:updateTimedConeOnEnt(draw, nil, source.id, nil, angle, target) then\n            draw = nil\n        end\n        if draw == nil then\n            draw = drawer:addTimedConeOnEnt(remaining, source.id, 60, angle, target, 0, false, nil, nil, nil, 256)\n        end\n        state.draws[i] = draw\n        if draw then state[i] = target end\n    end\nend\nstate.sourceID, state.angle = source.id, angle\nself.used = true\n",
							conditions = 
							{
								
								{
									"600c7065-d843-53c3-90e1-5d849181bf70",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Cones",
							uuid = "c6ff4b8c-fb7c-5199-86ac-587ac9bfda3e",
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
							conditionLua = "return data.p1TetherInfo ~= nil",
							dequeueIfLuaFalse = true,
							name = "Tethers Recorded",
							uuid = "600c7065-d843-53c3-90e1-5d849181bf70",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 113.7,
				name = "罪壤断雷火扇形",
				timeRange = true,
				timelineIndex = 28,
				timerEndOffset = 0.6,
				timerStartOffset = -2.5,
				uuid = "503d4b06-df8d-59eb-b419-5e44e2a266ca",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Data.clearMarkers = true\nself.used = true",
							conditions = 
							{
								
								{
									"08a43222-fe68-5d60-9506-8530dca36a14",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Clear Markers",
							uuid = "b52a352e-9ecc-5f73-a5a9-21835c5d5780",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruP1FOFAM == true",
							dequeueIfLuaFalse = true,
							name = "FoF AM Enabled",
							uuid = "08a43222-fe68-5d60-9506-8530dca36a14",
							version = 3,
						},
						inheritedIndex = 1,
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				mechanicTime = 113.7,
				name = "清除连线标记",
				timelineIndex = 28,
				timerOffset = 3,
				uuid = "fbfe1d36-52f9-568b-9404-88748f126da3",
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
							actionLua = "data.StringFRUDrawHits = data.StringFRUDrawHits or {}\ndata.StringFRUDrawHits[28] = true\nself.used = true",
							conditions = 
							{
								
								{
									"6e25e1d0-dc8d-bd8c-9a16-4ff1a1a0df03",
									true,
								},
							},
							name = "结束本轮绘图",
							uuid = "7451be9e-cb27-3758-9a8d-fd8f911b6a3e",
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
							name = "实际判定技能",
							spellIDList = 
							{
								40143,
								40156,
							},
							uuid = "6e25e1d0-dc8d-bd8c-9a16-4ff1a1a0df03",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 113.7,
				name = "罪壤断判定结束",
				timeRange = true,
				timelineIndex = 28,
				timerEndOffset = 0.6,
				timerStartOffset = -0.6,
				uuid = "b8618a8b-e972-fad2-bb52-9db6cdbc5210",
				version = 2,
			},
		},
	},
	[32] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "6b275b46-0e3e-5501-bd07-146885f51aed",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then return end\nMuAiGuide.Reactions.addTimedWorldText(10000, \"4\", ent.pos, 3931632764, true, 4.25)\nself.used = true",
							conditions = 
							{
								
								{
									"4ee0eb30-b709-56e7-a08b-d03074807fa4",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "WorldText 4",
							uuid = "4271a336-5839-5705-812c-7c46ca3c7945",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then return end\nMuAiGuide.Reactions.addTimedWorldText(10000, \"3\", ent.pos, 3931632764, true, 4.25)\nself.used = true",
							conditions = 
							{
								
								{
									"f78a42e4-5e61-5314-a7b3-0bb26e9d614f",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "WorldText 3",
							uuid = "b983ba97-4851-5eb1-9489-2fa41273d8da",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then return end\nMuAiGuide.Reactions.addTimedWorldText(10000, \"2\", ent.pos, 3931632764, true, 4.25)\nself.used = true",
							conditions = 
							{
								
								{
									"7f29bbe4-718d-5f2e-b1b9-33245a94e574",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "WorldText 2",
							uuid = "be452129-cfa6-5d7c-a3a1-303a3c6defb3",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then return end\nMuAiGuide.Reactions.addTimedWorldText(10000, \"1\", ent.pos, 3931632764, true, 4.25)\n\nlocal drawer = TensorCore.getCachedDrawer(0x4DFF2100, 0x4DFF2100, 0x4DFF2100, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedCircle(10000, ent.pos.x, 0.05, ent.pos.z, 4, nil, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"2e13cdc9-d462-575c-bb23-7c656aecb4ef",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "WorldText 1",
							uuid = "1f8c3bcb-8405-506b-a009-f81e51582d97",
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
							eventSpellID = 40126,
							name = "Four",
							spellIDList = 
							{
								40124,
								40127,
							},
							uuid = "4ee0eb30-b709-56e7-a08b-d03074807fa4",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							eventSpellID = 40126,
							name = "Three",
							spellIDList = 
							{
								40126,
								40123,
							},
							uuid = "f78a42e4-5e61-5314-a7b3-0bb26e9d614f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							eventSpellID = 40125,
							name = "Two",
							spellIDList = 
							{
								40125,
								40122,
							},
							uuid = "7f29bbe4-718d-5f2e-b1b9-33245a94e574",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							eventSpellID = 40135,
							name = "One",
							spellIDList = 
							{
								40135,
								40131,
							},
							uuid = "2e13cdc9-d462-575c-bb23-7c656aecb4ef",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				loop = true,
				mechanicTime = 140.9,
				name = "塔内人数提示",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = -2,
				timerStartOffset = -10,
				uuid = "bccc8a09-9edb-5593-9e2b-ef1d22f1cde2",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D0070FF, nil, 0x4D0070FF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCenteredRect((142.9 - TensorReactions_CurrentTimer) * 1000, 100, 0.05, 100, 40, 0.22, math.pi, nil, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"1c3b5fae-5458-5bdf-ab0e-31157c41defd",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw KB Line",
							uuid = "661cebe5-f99d-5526-8d32-9b00f5a03580",
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
							eventSpellID = 40129,
							name = "Channel ID",
							uuid = "1c3b5fae-5458-5bdf-ab0e-31157c41defd",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 140.9,
				name = "燃烧击击退方向",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = -3,
				timerStartOffset = -9,
				uuid = "e2068008-2300-5d97-bbcf-f83217c33ab7",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\n-- Get all AOEs to find tower positions\nlocal aoes = Argus.getCurrentAOEs()\nif not table.valid(aoes) then\n    self.used = true\n    return\nend\n\n-- Map of tower channel IDs to required player count\nlocal towerIDToCount = {\n    [40135] = 1, [40131] = 1,\n    [40125] = 2, [40122] = 2,\n    [40126] = 3, [40123] = 3,\n    [40124] = 4, [40127] = 4\n}\n\n-- Find and sort towers by Z position (north to south)\nlocal towers = {}\nfor _, aoe in pairs(aoes) do\n    if towerIDToCount[aoe.aoeID] then\n        table.insert(towers, {\n            pos = {x = aoe.x, y = aoe.y, z = aoe.z},\n            count = towerIDToCount[aoe.aoeID]\n        })\n    end\nend\n\ntable.sort(towers, function(a,b) return a.pos.z < b.pos.z end)\nif #towers ~= 3 then\n    self.used = true \n    return\nend\n\n-- Fixed roles\nlocal targetTower\nif gCurrentRole == 7 then \n    targetTower = towers[1] -- North\nelseif gCurrentRole == 4 then\n    targetTower = towers[2] -- Middle\nelseif gCurrentRole == 8 then\n    targetTower = towers[3] -- South\nelse\n    -- Flex roles logic\n    local myDefaultTower\n    if gCurrentRole == 1 then\n        myDefaultTower = towers[1]\n    elseif gCurrentRole == 3 then  \n        myDefaultTower = towers[2]\n    elseif gCurrentRole == 2 then\n        myDefaultTower = towers[3]\n    end\n    \n    -- Adjust if default tower needs less than 2 players\n    if myDefaultTower and myDefaultTower.count < 2 then\n        for _, tower in ipairs(towers) do\n            if tower.count >= 3 then\n                targetTower = tower\n                break\n            end\n        end\n    else\n        targetTower = myDefaultTower\n    end\nend\n\nif targetTower then\n    -- Draw arrow from center to target tower\n    local drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    local centerPos = {x = 100, y = 0, z = targetTower.pos.z}\n    local heading = TensorCore.getHeadingToTarget(centerPos, targetTower.pos)\n    drawer:addTimedArrow(10000, centerPos.x, 0.05, centerPos.z, heading, 7, 1, nil, nil, nil, false, 256)\nend\n\nself.used = true",
							gVar = "ACR_RikuPCT3_CD",
							uuid = "35589b48-ef89-53e7-8bc1-34787cf994f2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				enabled = false,
				mechanicTime = 140.9,
				name = "个人踩塔指路",
				timelineIndex = 32,
				timerOffset = -5,
				uuid = "a538bce3-80bc-50be-8aed-14a1fb4765cc",
				version = 2,
			},
		},
	},
	[33] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "964cf554-9144-5737-990f-704433a412e8",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move in\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"d5876784-16f2-562f-9c3c-a243a5c1fa37",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							name = "Shotcall Move In",
							uuid = "9f326ea4-bec1-5a14-be52-d748b8cde0d9",
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
							eventSpellID = 40161,
							name = "Cast ID",
							uuid = "d5876784-16f2-562f-9c3c-a243a5c1fa37",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 142.9,
				name = "靠近播报",
				timeRange = true,
				timelineIndex = 33,
				timerEndOffset = 1,
				timerStartOffset = -5,
				uuid = "7e285d1d-b514-5da5-b993-28c97c9a3780",
				version = 2,
			},
		},
	},
	[34] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "f4383069-a1d7-562e-a055-1d3edc443852",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Toggle(\"dash\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"e7f09482-4d97-5f83-b45e-faf9e5939e35",
									true,
								},
								
								{
									"5dc3448f-5e19-5597-8cb1-23ac2e01fcc4",
									false,
								},
								
								{
									"e14754cb-9f72-595c-8c23-c813aac14299",
									false,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRG3_CD",
							uuid = "8a9582ca-4b34-574f-83ba-ce600f28bdcc",
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
							eventSpellID = 40131,
							name = "Cast ID",
							spellIDList = 
							{
								40122,
								40123,
								40124,
								40125,
								40126,
								40126,
								40131,
								40135,
							},
							uuid = "e7f09482-4d97-5f83-b45e-faf9e5939e35",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "Is Tank",
							partyTargetType = "Tank",
							uuid = "e14754cb-9f72-595c-8c23-c813aac14299",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "NINJA",
							name = "Is NIN",
							uuid = "5dc3448f-5e19-5597-8cb1-23ac2e01fcc4",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 2,
				mechanicTime = 144.9,
				name = "燃烧击返场突进",
				timeRange = true,
				timelineIndex = 34,
				timerEndOffset = 1,
				timerStartOffset = -2.5,
				uuid = "67114836-1f79-5aef-8352-a216351aea11",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Toggle(\"dash\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"82bd98fd-fd79-5fd1-9f5c-bd522fa0c8a7",
									true,
								},
								
								{
									"ab41e054-487d-5174-9a8f-6c390fc1d44a",
									true,
								},
								
								{
									"ba6525f9-5681-5f29-aea9-84c698d9e2f0",
									true,
								},
							},
							gVar = "ACR_TensorViper3_Hotbar_Slither",
							name = "Toggle Dash",
							uuid = "8422a28a-152e-57d6-b418-737ccf9fe9a1",
							variableTogglesType = 2,
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
							category = "Self",
							conditionLua = "return eventArgs.entityID == TensorCore.mGetPlayer().id",
							conditionType = 9,
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 37964,
							name = "On Player",
							partyTargetType = "Event Entity",
							uuid = "82bd98fd-fd79-5fd1-9f5c-bd522fa0c8a7",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "Is Tank",
							partyTargetType = "Tank",
							uuid = "ab41e054-487d-5174-9a8f-6c390fc1d44a",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.newAnimID == 200",
							dequeueIfLuaFalse = true,
							eventArgType = 4,
							eventIntValue = 200,
							eventSpellID = 37964,
							name = "Anim ID",
							uuid = "ba6525f9-5681-5f29-aea9-84c698d9e2f0",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 23,
				mechanicTime = 144.9,
				name = "坦克火剑即时突进",
				timeRange = true,
				timelineIndex = 34,
				timerEndOffset = 1.5,
				timerStartOffset = -4,
				uuid = "4994db5f-984a-552a-b951-2822f199cd5b",
				version = 2,
			},
		},
	},
	[35] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "8df0782e-a845-540c-86f2-4948ab421a11",
			},
			objectType = "folder",
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
							actionLua = "data.p1PowderMarkID = nil\nself.used = true",
							gVar = "ACR_RikuMNK3_CD",
							name = "Reset Mark",
							uuid = "5bb2fd27-13df-5d5e-a879-9eb364599e8f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 145.6,
				name = "清除爆印目标",
				timelineIndex = 35,
				timerOffset = -7,
				uuid = "b06cce98-da23-51fb-adb7-77deb22ce5b5",
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
							actionLua = "data.p1PowderMarkID = eventArgs.detectionTargetID\nself.used = true",
							conditions = 
							{
								
								{
									"694e2ae1-a990-55e2-a1ea-87634f97e618",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Set Powder Mark ID",
							uuid = "37c6c8d5-b15d-51a8-842b-78f4357623dd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"d71d2fd8-faf7-5b2c-ba4f-1ebd3fca56af",
									true,
								},
							},
							filterTargetType = "Party",
							name = "Powder Mark Filter",
							uuid = "694e2ae1-a990-55e2-a1ea-87634f97e618",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 4166,
							category = "Party",
							name = "Has Powder Mark",
							partyTargetType = "Detection Target",
							uuid = "d71d2fd8-faf7-5b2c-ba4f-1ebd3fca56af",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 145.6,
				name = "记录爆印目标",
				timelineIndex = 35,
				timerEndOffset = -2,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "d5f1501d-e7e2-520f-b26b-46c749ea67fe",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "df99cb46-4374-571a-b24c-51624209aaf9",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal drawTime = (145.6 - TensorReactions_CurrentTimer) * 1000\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(drawTime, eventArgs.detectionTargetID, 10, nil, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"694e2ae1-a990-55e2-a1ea-87634f97e618",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Timed Draw Powder Mark",
							uuid = "37c6c8d5-b15d-51a8-842b-78f4357623dd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"d71d2fd8-faf7-5b2c-ba4f-1ebd3fca56af",
									true,
								},
							},
							filterTargetType = "Party",
							name = "Powder Mark Filter",
							uuid = "694e2ae1-a990-55e2-a1ea-87634f97e618",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 4166,
							category = "Party",
							name = "Has Powder Mark",
							partyTargetType = "Detection Target",
							uuid = "d71d2fd8-faf7-5b2c-ba4f-1ebd3fca56af",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 145.6,
				name = "爆印目标范围",
				timelineIndex = 35,
				timerEndOffset = -2,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "50b5ba73-a4ab-5186-a93c-339de2d925d9",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pm = TensorCore.mGetEntity(data.p1PowderMarkID).pos\nlocal closest = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal dist = TensorCore.getDistance2d(pm, closest)\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addDonut(pm.x, 0.05, pm.z, dist-0.5, dist, false, 256)\ndrawer:addCircle(closest.x, 0.05, closest.z, 10, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"146cd19c-0aaf-55c3-9c23-828f300a3069",
									true,
								},
								
								{
									"d3c915a8-0d47-5780-8284-df5f0c72ba6a",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Draw Closest",
							uuid = "c25dfc90-f8fc-5757-8025-3047c5dd366c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"2f3bb281-74bc-5604-a125-9f4fd7f51358",
									true,
								},
							},
							filterTargetType = "Party",
							name = "Powder Mark Filter",
							uuid = "146cd19c-0aaf-55c3-9c23-828f300a3069",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 4166,
							category = "Party",
							name = "Has Powder Mark",
							partyTargetType = "Detection Target",
							uuid = "2f3bb281-74bc-5604-a125-9f4fd7f51358",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"2f3bb281-74bc-5604-a125-9f4fd7f51358",
									false,
								},
								
								{
									"b1da3352-b859-5f19-9994-9f78029101ba",
									true,
								},
							},
							filterTargetType = "Party",
							name = "Nearest to Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "d3c915a8-0d47-5780-8284-df5f0c72ba6a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 2,
							hpType = 2,
							hpValue = 1,
							name = "Exists",
							partyTargetType = "Detection Target",
							uuid = "b1da3352-b859-5f19-9994-9f78029101ba",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				loop = true,
				mechanicTime = 145.6,
				name = "爆印最近连锁范围",
				timeRange = true,
				timelineIndex = 35,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -4.5,
				uuid = "182bf401-eb27-544a-a8af-9fae0cbb8c7d",
				version = 2,
			},
		},
	},
	[37] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "5ff6484d-ff5e-5b42-947b-ad2ac118ba47",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\ndata.p2StartTime = Now()\ndata.currentPhase = 2\nMuAiGuide.Reactions.Data.fruPhaseTiming = data.p2StartTime\nself.used = true",
							conditions = 
							{
								
								{
									"17dcf937-ac7b-5bcc-8a73-190e0cf3dd81",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Set P2 Start Time",
							uuid = "dd188058-ea59-5947-8570-577b9f59ecb8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.a1 == 35 and eventArgs.a2 == 1 and eventArgs.a3 == 0",
							conditions = 
							{
								
								{
									"26b3692a-553b-b1bd-b24c-7def49eac25f",
									true,
								},
								
								{
									"01b239b3-7fd2-0540-af8a-bb7c501b155a",
									true,
								},
								
								{
									"395b7b30-e28a-1cdc-a1bf-00225081e794",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							name = "Valid Args",
							partyTargetNumber = 0,
							uuid = "17dcf937-ac7b-5bcc-8a73-190e0cf3dd81",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventIntValue = 35,
							name = "a1 等于 35",
							uuid = "26b3692a-553b-b1bd-b24c-7def49eac25f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 2,
							eventIntValue = 1,
							name = "a2 等于 1",
							uuid = "01b239b3-7fd2-0540-af8a-bb7c501b155a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 3,
							name = "a3 等于 0",
							uuid = "395b7b30-e28a-1cdc-a1bf-00225081e794",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 21,
				mechanicTime = 160,
				name = "初始化希瓦阶段",
				timeRange = true,
				timelineIndex = 37,
				timerEndOffset = 200,
				timerStartOffset = -5,
				uuid = "a3b68470-4c6a-570b-be7b-e938711f9681",
				version = 2,
			},
		},
	},
	[39] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "50a85991-6131-592b-88f7-3edd91c1a982",
			},
			objectType = "folder",
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
									"a1149ea4-b9fa-5022-812e-00f7807d7c70",
									true,
								},
								
								{
									"8dfc223a-a42b-5cce-945a-236d694de158",
									false,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							setTarget = true,
							targetType = "Enemy",
							uuid = "6213dab8-e9dc-5c18-841e-d6aa64f63ca4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Find Boss",
							uuid = "a1149ea4-b9fa-5022-812e-00f7807d7c70",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Current Target",
							name = "Target Filter",
							uuid = "8dfc223a-a42b-5cce-945a-236d694de158",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 203.8,
				name = "选中首领",
				timeRange = true,
				timelineIndex = 39,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "f012fe9d-b97e-5e88-8eb0-e7865c180b6e",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\ndata.p2StartTime = Now()\ndata.currentPhase = 2\nMuAiGuide.Reactions.Data.fruPhaseTiming = data.p2StartTime\nself.used = true",
							conditions = 
							{
								
								{
									"17dcf937-ac7b-5bcc-8a73-190e0cf3dd81",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Set P2 Start Time",
							uuid = "dd188058-ea59-5947-8570-577b9f59ecb8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.a1 == 35 and eventArgs.a2 == 1 and eventArgs.a3 == 0",
							conditions = 
							{
								
								{
									"7ec79695-a998-b62e-a877-180fbd617301",
									true,
								},
								
								{
									"2fe40185-e382-7eb6-a31d-18b10b2b0919",
									true,
								},
								
								{
									"8e3d1416-16dd-f794-b8d2-03dc3a24d328",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							name = "Valid Args",
							partyTargetNumber = 0,
							uuid = "17dcf937-ac7b-5bcc-8a73-190e0cf3dd81",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventIntValue = 35,
							name = "a1 等于 35",
							uuid = "7ec79695-a998-b62e-a877-180fbd617301",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 2,
							eventIntValue = 1,
							name = "a2 等于 1",
							uuid = "2fe40185-e382-7eb6-a31d-18b10b2b0919",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 3,
							name = "a3 等于 0",
							uuid = "8e3d1416-16dd-f794-b8d2-03dc3a24d328",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 21,
				mechanicTime = 203.8,
				name = "初始化希瓦阶段",
				timeRange = true,
				timelineIndex = 39,
				timerStartOffset = -100,
				uuid = "b943b799-2120-5fd8-bfd2-723430e74a38",
				version = 2,
			},
		},
	},
	[45] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "8333ba56-d085-510d-8e8b-5c5248b565b0",
			},
			objectType = "folder",
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
							actionLua = "data.p2FirstKick = \"in\"\nself.used = true",
							conditions = 
							{
								
								{
									"93689a32-be5d-5108-be67-1c53942acb17",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Record In",
							uuid = "c6c8cf8d-5061-5ecf-a5a3-a99e4976ec27",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p2FirstKick = \"out\"\nself.used = true",
							conditions = 
							{
								
								{
									"269d9708-6e31-5977-bdf3-396c5bb1246e",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Out",
							uuid = "7499fdaa-23ff-5079-8271-9b855c53e5f5",
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
							eventSpellID = 40203,
							name = "Scythe In",
							uuid = "93689a32-be5d-5108-be67-1c53942acb17",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40202,
							name = "Axe Out",
							uuid = "269d9708-6e31-5977-bdf3-396c5bb1246e",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "核心逻辑",
				eventType = 3,
				mechanicTime = 238.9,
				name = "记录回旋踢类型",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 3,
				timerStartOffset = -2,
				uuid = "4afdde52-2079-523f-a7c0-be2f0ac524b6",
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
							actionLua = "if (data.p2IciclePuddleIDs == nil) then\n    data.p2IciclePuddleIDs = {}\nend\n\nif (data.p2IciclePuddleCount == nil) then\n    data.p2IciclePuddleCount = 0\nend\ndata.p2IciclePuddleCount = data.p2IciclePuddleCount + 1\n\ndata.p2IciclePuddleIDs[eventArgs.entityID2] = true\nself.used = true",
							conditions = 
							{
								
								{
									"299621ad-a551-583c-8618-f1a6c4ad1c5e",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Marked",
							uuid = "d5aef551-c949-517d-bf9b-8fc417922c1d",
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
							eventMarkerID = 345,
							name = "Marker ID",
							uuid = "299621ad-a551-583c-8618-f1a6c4ad1c5e",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 4,
				loop = true,
				mechanicTime = 238.9,
				name = "记录冰圈点名",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 4,
				timerStartOffset = -1,
				uuid = "1088fcae-769d-5be2-ad13-463cd95e5d25",
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
							actionLua = "data.meBaitingPuddle = data.p2IciclePuddleIDs[TensorCore.mGetPlayer().id] == true\nself.used = true",
							conditions = 
							{
								
								{
									"63304914-7b2f-5ea3-9193-f0acb6799df7",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Player Puddle Status",
							uuid = "d5aef551-c949-517d-bf9b-8fc417922c1d",
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
							conditionLua = "return data.p2IciclePuddleCount == 4",
							name = "Puddles Recorded",
							uuid = "63304914-7b2f-5ea3-9193-f0acb6799df7",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 238.9,
				name = "记录自身冰圈状态",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 4,
				timerStartOffset = -1,
				uuid = "4cf7f43c-e395-59a1-81a8-70372df71a95",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nif (data.p2InitIcicleCount == nil) then\n    data.p2InitIcicleCount = 1\nelse\n    data.p2InitIcicleCount = data.p2InitIcicleCount + 1\nend\n\nif (data.p2InitIcicleCount > 2) then\n    self.used = true\n    return\nend\n\nif (data.p2InitIcicleFirstPos == nil) then\n    local ent = TensorCore.mGetEntity(eventArgs.entityID)\n    if (ent == nil) then\n        MuAiGuide.Reactions.log(\"[P2 Init Icicle] Couldn't retrieve entity for first icicle!\", 5)\n        self.used = true\n        return\n    end\n\n    data.p2InitIcicleFirstPos = ent.pos\n    self.used = true\n    return\nend\n\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then\n    MuAiGuide.Reactions.log(\"[P2 Init Icicle] Couldn't retrieve entity for second icicle!\", 5)\n        self.used = true\n        return\nend\n\nlocal firstPos = data.p2InitIcicleFirstPos\nlocal secondPos = ent.pos\n\nif (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\n\nlocal baseHeading1 = TensorCore.getHeadingToTarget(data.arenaCenter, firstPos)\nlocal baseHeading2 = TensorCore.getHeadingToTarget(data.arenaCenter, secondPos)\n\nlocal nmHeading1 = TensorCore.convertHeading(baseHeading1)\nlocal nmHeading2 = TensorCore.convertHeading(baseHeading2)\nlocal north = math.pi\n\nlocal d1 = TensorCore.convertHeading(nmHeading1 - north)\nlocal d2 = TensorCore.convertHeading(nmHeading2 - north)\n\nlocal drawer1 = TensorCore.getCachedDrawer(0x4D00FF7B, nil, 0x4D00FF7B, 0xFFFFFFFF, 2, 0, 256)\ndrawer1:setGradient(3, 0.15, 2)\ndrawer1:setHeightOffset(0.05)\nlocal drawer2 = TensorCore.getCachedDrawer(0x4D62FF00, nil, 0x4D62FF00, 0xFFFFFFFF, 2, 0, 256)\ndrawer2:setGradient(3, 0.15, 2)\ndrawer2:setHeightOffset(0.05)\n\nif (d1 < d2) then\n    drawer1:addTimedArrow(6000, 100, 0.05, 100, baseHeading1, 15, 1.1, nil, nil, 10000, false, 256)\n    drawer2:addTimedArrow(6000, 100, 0.05, 100, baseHeading2, 15, 1.1, nil, nil, 10000, false, 256)\n    MuAiGuide.Reactions.addTimedWorldText(15000, \"G1\", firstPos, 4160749543, true, 3.5)\n    MuAiGuide.Reactions.addTimedWorldText(15000, \"G2\", secondPos, 4160749543, true, 3.5)\nelse\n    drawer1:addTimedArrow(6000, 100, 0.05, 100, baseHeading2, 15, 1.1, nil, nil, 10000, false, 256)\n    drawer2:addTimedArrow(6000, 100, 0.05, 100, baseHeading1, 15, 1.1, nil, nil, 10000, false, 256)\n    MuAiGuide.Reactions.addTimedWorldText(15000, \"G1\", secondPos, 4160749543, true, 3.5)\n    MuAiGuide.Reactions.addTimedWorldText(15000, \"G2\", firstPos, 4160749543, true, 3.5)\nend\n\nlocal nDir = math.round(nmHeading1 * (4 / north))\nlocal isCardinal = (nDir % 2) == 0\n\nif (isCardinal) then\n    data.p2IcicleDir = \"cardinal\"\nelse\n    data.p2IcicleDir = \"ordinal\"\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"b4671947-0ed4-530c-b867-ec639c175c53",
									true,
								},
								
								{
									"798ccd00-7994-55d1-bfa5-e2c3aef7258b",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Label Icicles",
							uuid = "907c5924-d707-5d1e-8f55-2ead4f62bc59",
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
							eventSpellID = 40198,
							name = "Channel ID",
							uuid = "b4671947-0ed4-530c-b867-ec639c175c53",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p2InitIcicleCount == nil or data.p2InitIcicleCount < 2",
							dequeueIfLuaFalse = true,
							name = "Icicle Count",
							uuid = "798ccd00-7994-55d1-bfa5-e2c3aef7258b",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 3,
				loop = true,
				mechanicTime = 238.9,
				name = "初始化希瓦阶段",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 3,
				timerStartOffset = -2,
				uuid = "6c565d71-21df-58b8-a48a-46bfd8d5c247",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "72608a43-ab0f-55bf-b6bb-fd8784ff0c72",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal cardinalPuddles = data.p2IcicleDir == \"ordinal\"\nlocal player = TensorCore.mGetPlayer()\nlocal isPlayerPuddle = data.p2IciclePuddleIDs[player.id] == true\nlocal playerDefaultIsCardinal = MuAiGuide.Reactions.dpsJobs[player.job] ~= true\nlocal playerGoesCardinal = (cardinalPuddles and isPlayerPuddle) or (not cardinalPuddles and not isPlayerPuddle)\nlocal shouldSwap = playerDefaultIsCardinal ~= playerGoesCardinal\nlocal callStr = (shouldSwap and \"Swap, \" or \"Stay, \") .. data.p2FirstKick\nMuAiGuide.Reactions.Shotcall(callStr, true)\nself.used = true",
							conditions = 
							{
								
								{
									"028e6ca5-53e3-5550-ae01-82a4ac8da864",
									true,
								},
								
								{
									"3dd496be-840a-5cff-aae8-72c7e3cdf291",
									true,
								},
								
								{
									"0a912cd8-38a8-59d1-8671-f42ab56a49b3",
									true,
								},
								
								{
									"e991ced9-c712-5b2e-ba14-8c73d6bbb57d",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Call Echo DD",
							uuid = "b3ac8c48-d7b4-5831-b562-fe4227695e62",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruColorIcicles == true",
							dequeueIfLuaFalse = true,
							name = "Setting Checked",
							uuid = "028e6ca5-53e3-5550-ae01-82a4ac8da864",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p2IcicleDir ~= nil",
							name = "Icicles Recorded",
							uuid = "3dd496be-840a-5cff-aae8-72c7e3cdf291",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p2IciclePuddleCount == 4",
							name = "Puddles Recorded",
							uuid = "0a912cd8-38a8-59d1-8671-f42ab56a49b3",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p2FirstKick ~= nil",
							name = "Kick Recorded",
							uuid = "e991ced9-c712-5b2e-ba14-8c73d6bbb57d",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 238.9,
				name = "钻石星尘站位播报",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 3,
				timerStartOffset = -2,
				uuid = "ff56c50b-1f77-5aaf-93fd-54817f3edde9",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal cardinalPuddles = data.p2IcicleDir == \"ordinal\"\nlocal player = TensorCore.mGetPlayer()\nlocal isPlayerPuddle = data.p2IciclePuddleIDs[player.id] == true\nlocal north = math.pi\nlocal northWest = north - math.rad(45)\nlocal puddleStartH, baitStartH\nif (cardinalPuddles) then\n    puddleStartH = north\n    baitStartH = northWest\nelse\n    puddleStartH = northWest\n    baitStartH = north\nend\n\nlocal playerH\nif (isPlayerPuddle) then\n    playerH = puddleStartH\nelse\n    playerH = baitStartH\nend\n\nlocal arrowLength, tipLength\nif (data.p2FirstKick == \"in\") then\n    if (isPlayerPuddle) then\n        arrowLength, tipLength = 5.5, 2.5\n    else\n        arrowLength, tipLength = 1, 0.5\n    end\nelse\n    tipLength = 2\n    if (isPlayerPuddle) then\n        arrowLength = 18\n    else\n        arrowLength = 14\n    end\nend\n\nlocal drawTime\nif (isPlayerPuddle) then\n    drawTime = (247.1 - TensorReactions_CurrentTimer) * 1000\nelse\n    drawTime = (246.7 - TensorReactions_CurrentTimer) * 1000\nend\n\nlocal drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal increment = math.rad(90)\nfor i = 0, 3 do\n    local h = playerH + (increment * i)\n    drawer:addTimedArrow(drawTime, 100, 0.05, 100, h, arrowLength, 0.15, tipLength, nil, 0, false, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"028e6ca5-53e3-5550-ae01-82a4ac8da864",
									true,
								},
								
								{
									"3dd496be-840a-5cff-aae8-72c7e3cdf291",
									true,
								},
								
								{
									"0a912cd8-38a8-59d1-8671-f42ab56a49b3",
									true,
								},
								
								{
									"e991ced9-c712-5b2e-ba14-8c73d6bbb57d",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Echo DD",
							uuid = "b3ac8c48-d7b4-5831-b562-fe4227695e62",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruColorIcicles == true",
							dequeueIfLuaFalse = true,
							name = "Setting Checked",
							uuid = "028e6ca5-53e3-5550-ae01-82a4ac8da864",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p2IcicleDir ~= nil",
							name = "Icicles Recorded",
							uuid = "3dd496be-840a-5cff-aae8-72c7e3cdf291",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p2IciclePuddleCount == 4",
							name = "Puddles Recorded",
							uuid = "0a912cd8-38a8-59d1-8671-f42ab56a49b3",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p2FirstKick ~= nil",
							name = "Kick Recorded",
							uuid = "e991ced9-c712-5b2e-ba14-8c73d6bbb57d",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 238.9,
				name = "钻石星尘站位箭头",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 3,
				timerStartOffset = -2,
				uuid = "ad9cee1d-c73e-5414-b0cc-ef676c0806d0",
				version = 2,
			},
		},
	},
	[46] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "28c89fc0-9aca-51d5-a63a-f76a9c231cc2",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move In\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"f1ad3484-9363-57ab-8d7f-1434061b15ec",
									true,
								},
								
								{
									"b7a4a383-a936-52f4-b347-b906e7954a04",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							name = "Shotcall Move In",
							uuid = "21ebe3b2-a7f8-5a5f-9e06-19253fac98ee",
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
							conditionLua = "return data.meBaitingPuddle ~= true",
							dequeueIfLuaFalse = true,
							name = "Player Is Not Puddle",
							uuid = "b7a4a383-a936-52f4-b347-b906e7954a04",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40202,
							name = "Axe Kick",
							uuid = "f1ad3484-9363-57ab-8d7f-1434061b15ec",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 244.5,
				name = "靠近播报",
				timeRange = true,
				timelineIndex = 46,
				timerEndOffset = 2,
				timerStartOffset = -5,
				uuid = "eeb2a67b-d8ac-5bdf-a07a-433474322a94",
				version = 2,
			},
		},
	},
	[47] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "7163f0da-ee4c-52d8-b22d-102c0132f7d4",
			},
			objectType = "folder",
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
							actionLua = "if (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							uuid = "e0cf84df-c305-56e9-8bf4-99077d3ad7e3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 245.1,
				name = "记录场地中心",
				timelineIndex = 47,
				timerOffset = -8,
				uuid = "e7a13eec-4e89-5220-807a-18d166208442",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "b9cba3ef-5e57-51a3-9fef-51362ac23c9b",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal center = data.arenaCenter\nlocal closestFour = MuAiGuide.Reactions.API.getNearestNumToPos(data.arenaCenter, 4)\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nfor i = 1, 4 do\n    local id = closestFour[i]\n    if (id == nil) then break end\n    local ent = TensorCore.mGetEntity(id)\n    local h = TensorCore.getHeadingToTarget(center, ent.pos)\n    drawer:addCone(100, 0.05, 100, 25, math.rad(30), h, false, 256)\nend\n\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Cones",
							uuid = "2ad85f3e-9ff8-50d0-b074-d32c0a616723",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 245.1,
				name = "光之海浪近距扇形",
				timeRange = true,
				timelineIndex = 47,
				timerEndOffset = 0.35,
				timerStartOffset = -3.5,
				uuid = "1042f611-fad9-5925-aaac-862d1cfdcab2",
				version = 2,
			},
		},
	},
	[49] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "f0c63e25-09f9-5fde-9ca4-94c30c4bcf65",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal arrowDelayTime = (251.8 - TensorReactions_CurrentTimer) * 1000\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedArrowOnEnt(5000, TensorCore.mGetPlayer().id, 7, 0.35, nil, nil, eventArgs.entityID, arrowDelayTime, false, nil, nil, 256)\ndata.ddShivaPos = TensorCore.mGetEntity(eventArgs.entityID).pos\nself.used = true",
							conditions = 
							{
								
								{
									"9dae3d2a-ae3b-56f0-8914-b7b7e22262fe",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Arrow To Shiva",
							uuid = "0bd61043-df34-5328-81f5-aaed172c6dac",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.oldAnimID == 3201 and eventArgs.newAnimID == 34",
							conditions = 
							{
								
								{
									"43a51c87-0f24-84c4-aee7-153b59f138fb",
									true,
								},
								
								{
									"e8390fbb-3fcc-9c5d-a1d3-b68302d6c397",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							name = "Anim ID",
							partyTargetNumber = 0,
							uuid = "9dae3d2a-ae3b-56f0-8914-b7b7e22262fe",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 3,
							eventIntValue = 3201,
							name = "oldAnimID 等于 3201",
							uuid = "43a51c87-0f24-84c4-aee7-153b59f138fb",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 4,
							eventIntValue = 34,
							name = "newAnimID 等于 34",
							uuid = "e8390fbb-3fcc-9c5d-a1d3-b68302d6c397",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 23,
				mechanicTime = 247.1,
				name = "希瓦位置箭头",
				timeRange = true,
				timelineIndex = 49,
				timerEndOffset = 3,
				timerStartOffset = -3,
				uuid = "6f81e3a2-8150-51f2-87e4-61ae1431ed6f",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then\n    MuAiGuide.Reactions.log(\"[Shiva Donut] Ent was nil?\", 5)\n    self.used = true\n    return\nend\n\nif (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\nlocal h = TensorCore.getHeadingToTarget(data.arenaCenter, ent.pos)\nlocal d = TensorCore.getDistance2d(data.arenaCenter, ent.pos)\nlocal toWallDistance = 20 - d\nlocal halfDistance = toWallDistance / 2\nlocal x, _, z = TensorCore.getPosInDirection(data.arenaCenter, h, d + halfDistance, true)\n\nlocal donutStartTime = 255.5\nlocal donutEndTime = 263.7\nlocal donutDelayTime = (donutStartTime - TensorReactions_CurrentTimer) * 1000\nlocal donutDrawTime = (donutEndTime - donutStartTime) * 1000\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedDonut(donutDrawTime, x, 0.05, z, 30.25, 30.75, donutDelayTime, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"9dae3d2a-ae3b-56f0-8914-b7b7e22262fe",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Safe Donut",
							uuid = "0bd61043-df34-5328-81f5-aaed172c6dac",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.oldAnimID == 3201 and eventArgs.newAnimID == 34",
							conditions = 
							{
								
								{
									"907d1e0a-2da8-535d-8a5e-75fef2727f1d",
									true,
								},
								
								{
									"e59a9f29-0b1b-0fff-8e82-4a3b759d8903",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							name = "Anim ID",
							partyTargetNumber = 0,
							uuid = "9dae3d2a-ae3b-56f0-8914-b7b7e22262fe",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 3,
							eventIntValue = 3201,
							name = "oldAnimID 等于 3201",
							uuid = "907d1e0a-2da8-535d-8a5e-75fef2727f1d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 4,
							eventIntValue = 34,
							name = "newAnimID 等于 34",
							uuid = "e59a9f29-0b1b-0fff-8e82-4a3b759d8903",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 23,
				mechanicTime = 247.1,
				name = "钻石星尘安全范围",
				timeRange = true,
				timelineIndex = 49,
				timerEndOffset = 3,
				timerStartOffset = -3,
				uuid = "e50024e1-88c0-5acd-88ac-59e54667a5d6",
				version = 2,
			},
		},
	},
	[57] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "fdd98d30-e75a-5adf-a4e7-b31217d72736",
			},
			objectType = "folder",
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
							actionLua = "if (data.p2SinboundHolyLocations == nil) then\n    ---@type SinboundHolyInfo[]\n    data.p2SinboundHolyLocations = {}\nend\n\nlocal curTime = Now()\nlocal posTable = { x = eventArgs.castPosX, y = 0, z = eventArgs.castPosZ }\n---@type SinboundHolyInfo\nlocal info = {\n    pos = posTable,\n    startTime = curTime,\n    endTime = curTime + 11000\n}\ntable.insert(data.p2SinboundHolyLocations, info)\nself.used = true",
							conditions = 
							{
								
								{
									"969ffe2d-2986-5430-9cdd-1a9b01c1a4d7",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Record Puddle Info",
							uuid = "0b10c611-3e44-5d4c-a4d8-9ef961542bb7",
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
							eventSpellID = 40209,
							name = "Cast ID",
							uuid = "969ffe2d-2986-5430-9cdd-1a9b01c1a4d7",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 2,
				loop = true,
				mechanicTime = 259.9,
				name = "记录冰圈位置",
				timeRange = true,
				timelineIndex = 57,
				timerEndOffset = 2,
				timerStartOffset = -9,
				uuid = "64f54944-0a10-586c-b621-96fd4c45eafc",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "a49b7502-70ea-5c3c-a60d-c2fc31a6d295",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircle(11350, eventArgs.castPosX, 0.05, eventArgs.castPosZ, 6, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"969ffe2d-2986-5430-9cdd-1a9b01c1a4d7",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Record Puddle Info",
							uuid = "0b10c611-3e44-5d4c-a4d8-9ef961542bb7",
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
							eventSpellID = 40209,
							name = "Cast ID",
							uuid = "969ffe2d-2986-5430-9cdd-1a9b01c1a4d7",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				loop = true,
				mechanicTime = 259.9,
				name = "罪壤神圣冰圈",
				timeRange = true,
				timelineIndex = 57,
				timerEndOffset = 2,
				timerStartOffset = -9,
				uuid = "f11b708a-b07b-5338-9fea-f9c0d2450dd9",
				version = 2,
			},
		},
	},
	[58] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "bc15f0fe-c94c-50db-a6aa-28f7613fe2d3",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif (data.p2LookawayEntID == nil) then\n    local entities = TensorCore.entityList(\"contentid=12809\")\n    if (not table.valid(entities)) then\n        self.used = true\n        return\n    end\n\n    for _, ent in pairs(entities) do\n        if (Argus.isEntityVisible(ent.id)) then\n            data.p2LookawayEntID = ent.id\n            break\n        end\n    end\n\n    if (data.p2LookawayEntID == nil) then\n        MuAiGuide.Reactions.log(\"[FRU] Couldn't find Usurper of Frost for Lookaway!\", 5)\n        self.used = true\n        return\n    end\nend\n\nlocal lookawayEnt = TensorCore.mGetEntity(data.p2LookawayEntID)\nif (lookawayEnt == nil) then\n    self.used = true\n    return\nend\n\nlocal playerPos = TensorCore.mGetPlayer().pos\nTensorCore.API.TensorACR.toggleLockFace(true)\nTensorCore.API.TensorACR.setLockFaceHeading(TensorCore.getHeadingToTarget(lookawayEnt.pos, playerPos))\n\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Lookaway",
							uuid = "785ed7da-dc41-562c-abfe-8ecfdd7637c0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				loop = true,
				mechanicTime = 263.7,
				name = "背对分身",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 58,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -1,
				uuid = "66ff4d2f-f317-58e8-959d-d251093adf46",
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
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\ndata.p2ShiningArmorDone = true\nself.used = true",
							conditions = 
							{
								
								{
									"583b7e80-e605-526e-a352-8c3557cb636a",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Stop Lookaway",
							uuid = "b1199f0a-9e0c-5934-b686-5dafd919630d",
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
							eventSpellID = 40185,
							name = "Shining Armor ID",
							uuid = "583b7e80-e605-526e-a352-8c3557cb636a",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 2,
				mechanicTime = 263.7,
				name = "结束背对",
				timeRange = true,
				timelineIndex = 58,
				timerEndOffset = 2,
				timerStartOffset = -1.5,
				uuid = "21061ccb-fde5-519f-813f-3058ca0b7af9",
				version = 2,
			},
		},
	},
	[59] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "3a0c89d0-c4cd-5c78-a957-ffc73de78824",
			},
			objectType = "folder",
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
									"c7e40b43-1cfc-566b-bdca-ee2441c3f8fa",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							stopMoving = true,
							uuid = "8e053064-bfa3-5b0f-a13f-582758596019",
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
							eventSpellID = 40184,
							name = "Frost Armor ID",
							uuid = "c7e40b43-1cfc-566b-bdca-ee2441c3f8fa",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 2,
				mechanicTime = 263.7,
				name = "停止移动",
				timeRange = true,
				timelineIndex = 59,
				timerEndOffset = 1.5,
				timerStartOffset = -1.5,
				uuid = "d146afa0-05a5-537d-b6b5-5a5b98dc5703",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\n---@class SinboundHolyInfo\n---@field pos ThreeDimensionalPos\n---@field startTime integer\n---@field endTime integer\n\n---@alias AutoSlideStage\n---| 0 #Pre-channel phase.\n---| 1 #Channeling.\n---| 2 #Casted.\n\n---@class AutoIceSlideBase\n---@field shivaPos Position\n---@field behindShivaPos ThreeDimensionalPos\n---@field currentStage AutoSlideStage\n---@field backFirst boolean?\n---@field puddleInfo SinboundHolyInfo[]\n---@field puddleCount integer\n---@field cursedAimPos ThreeDimensionalPos?\n---@field isBehindShiva function\n---@field isNearShiva function\n---@field pathIntersectsPuddle function\n---@field pathIntersectsAnyPuddle function\n\n---@param startX number\n---@param startZ number\n---@param endX number\n---@param endZ number\n---@param puddleInfo SinboundHolyInfo\n---@param curTime integer\n---@return boolean\nlocal pathIntersectsPuddleFunc = function (startX, startZ, endX, endZ, puddleInfo, curTime)\n    local timeToEnd = curTime - puddleInfo.endTime\n    if (timeToEnd >= 0) then return false end\n    local puddlePos = puddleInfo.pos\n    local x1, _, x2, _ = MuAiGuide.Reactions.API.findSegmentCircleIntersections(puddlePos.x, puddlePos.z, 6, startX, startZ, endX, endZ)\n    return x1 ~= nil or x2 ~= nil\nend\n\n---@param startX number\n---@param startZ number\n---@param endX number\n---@param endZ number\n---@param ignoreFirstTwo boolean?\n---@return boolean\nlocal pathIntersectsAnyPuddleFunc = function (startX, startZ, endX, endZ, ignoreFirstTwo)\n    local info = data.p2AutoIceSlide\n    local puddles, count = info.puddleInfo, info.puddleCount\n    local checkFunc = info.pathIntersectsPuddle\n    local curTime = Now()\n    local startIndex = ignoreFirstTwo and 3 or 1\n    for i = startIndex, count do\n        if (checkFunc(startX, startZ, endX, endZ, puddles[i], curTime)) then\n            return true\n        end\n    end\n\n    return false\nend\n\nif (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\nlocal center = data.arenaCenter\nlocal shivaPos = data.ddShivaPos\nlocal headingToShiva = TensorCore.getHeadingToTarget(center, shivaPos)\nlocal behindShivaPos = TensorCore.getPosInDirection(center, headingToShiva, 17.5)\n\n---@param startPos TwoDimensionalPos\n---@return boolean\nlocal canPosGetBehindShiva = function (startPos)\n    local startH = TensorCore.getHeadingToTarget(startPos, behindShivaPos)\n    \nend\n\n--Calculate the position to begin aiming at in case it's cursed pattern.\n--There's probably a better way to do this, especially that doesn't essentialy use brute forcing but meh. If it works, it works.\nlocal awayFromShiva = TensorCore.getHeadingToTarget(shivaPos, center)\nlocal angleIncrement = math.rad(10)\n---@type ThreeDimensionalPos?\nlocal cursedAimPos = nil\nfor i = 1, 18 do\n    local x, _, z = TensorCore.getPosInDirection(center, awayFromShiva + (angleIncrement * i), 17.5, true)\n    if (not pathIntersectsAnyPuddleFunc(100, 100, x, z)) then\n        cursedAimPos = { x = x, y = 0, z = z }\n        break\n    end\n    x, _, z = TensorCore.getPosInDirection(center, awayFromShiva - (angleIncrement * i), 17.5, true)\n    if (not pathIntersectsAnyPuddleFunc(100, 100, x, z)) then\n        cursedAimPos = { x = x, y = 0, z = z }\n        break\n    end\nend\n\nif (cursedAimPos ~= nil) then\n    local fruMuai1 = TensorCore.getCachedDrawer(0x4D7AB0F3, nil, 0x4D7AB0F3, 0xFFFFFFFF, 2, 0, 256)\n    fruMuai1:setGradient(3, 0.15, 2)\n    fruMuai1:setHeightOffset(0.05)\n    fruMuai1:addTimedCircle(8000, cursedAimPos.x, 0.05, cursedAimPos.z, 0.65, 0, false, nil, 256)\nend\n\n---@type SinboundHolyInfo[]\nlocal puddleInfoArray = data.p2SinboundHolyLocations\nlocal puddleCount = #puddleInfoArray\n\n---@param checkPos TwoDimensionalPos\n---@return boolean\nlocal isBehindShivaFunc = function (checkPos)\n    local pos = data.p2AutoIceSlide.shivaPos\n    return not MuAiGuide.Reactions.API.isInsideCone(checkPos, pos, pos.h, 4.7124)\nend\n\n---@param checkPos TwoDimensionalPos\n---@return boolean\nlocal isInWallFunc = function (checkPos)\n    return TensorCore.getDistance2d(checkPos, center) >= 19.9\nend\n\n---@param checkPos TwoDimensionalPos\n---@return boolean\nlocal isNearShivaFunc = function (checkPos)\n    return TensorCore.getDistance2d(checkPos, data.p2AutoIceSlide.behindShivaPos) < 15\nend\n\n---@type AutoIceSlideBase\ndata.p2AutoIceSlide = {\n    shivaPos = { x = shivaPos.x, y = 0, z = shivaPos.z, h = TensorCore.getHeadingToTarget(shivaPos, data.arenaCenter) },\n    behindShivaPos = behindShivaPos,\n    currentStage = 0,\n    backFirst = nil,\n    puddleInfo = data.p2SinboundHolyLocations,\n    puddleCount = puddleCount,\n    cursedAimPos = cursedAimPos,\n    isBehindShiva = isBehindShivaFunc,\n    isNearShiva = isNearShivaFunc,\n    isInWall = isInWallFunc,\n    pathIntersectsPuddle = pathIntersectsPuddleFunc,\n    pathIntersectsAnyPuddle = pathIntersectsAnyPuddleFunc\n}\n\nself.used = true",
							conditions = 
							{
								
								{
									"08ece7a9-9a12-5fad-a914-ec5f7c5439cb",
									true,
								},
								
								{
									"acf24784-9c5f-5998-be53-fcd8b77b3319",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Run Ice Setup",
							uuid = "8353fbe8-357e-508c-a481-6439c6448545",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 911,
							category = "Self",
							name = "Has Thin Ice",
							uuid = "08ece7a9-9a12-5fad-a914-ec5f7c5439cb",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruAutoIceSlide == true",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "acf24784-9c5f-5998-be53-fcd8b77b3319",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				enabled = false,
				mechanicTime = 263.7,
				name = "初始化滑冰移动",
				timeRange = true,
				timelineIndex = 59,
				timerEndOffset = 3,
				uuid = "5b13a9ce-3306-5ee3-9de8-b400612ed14d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "7d7f84cb-52e8-52d9-8359-e0f9f2bb09e7",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedDonutOnEnt(9000, TensorCore.mGetPlayer().id, 31.85, 32.05, nil, false, nil, 256)\nself.used = true",
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Slide Radius Donut",
							uuid = "0c2421b9-ee9f-564e-9755-6a43b387993d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 263.7,
				name = "滑冰距离参考",
				timelineIndex = 59,
				timerOffset = -5,
				uuid = "f1d60fdd-67a6-5c96-9e98-858c685eef72",
				version = 2,
			},
		},
	},
	[61] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "e0918d4b-dc6e-5f8f-9c62-e56ad9e9628b",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif data.TwinCasts == nil then data.TwinCasts = 0 end\ndata.TwinCasts = data.TwinCasts + 1\n\nif data.TwinCasts < 2 then\n    MuAiGuide.Reactions.Shotcall(\"Move\", true)\nelse\n    data.bothTwinsCast = Now()\n    data.bothTwinsCastRandom = math.random(750, 3500)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"c05ad881-c5f3-5268-9e8a-287ac5a115a4",
									true,
								},
								
								{
									"4d07c4c1-8aa5-56c8-a74b-74d22dbaddab",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "d6a1fc41-3153-566d-85d4-ab717635b4bf",
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
							spellIDList = 
							{
								40193,
								40196,
								40194,
								40195,
							},
							uuid = "c05ad881-c5f3-5268-9e8a-287ac5a115a4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							channelCheckTimeRemain = 0.5,
							channelCheckType = 3,
							comparator = 2,
							conditionType = 5,
							eventArgType = 2,
							partyTargetType = "Event Entity",
							uuid = "4d07c4c1-8aa5-56c8-a74b-74d22dbaddab",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 3,
				loop = true,
				mechanicTime = 272.3,
				name = "记录双剑技判定",
				timeRange = true,
				timelineIndex = 61,
				timerEndOffset = 5,
				timerStartOffset = -10,
				uuid = "ed82f2ab-ca23-55cf-b74e-b85cfd2d6c4f",
				version = 2,
			},
		},
	},
	[62] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "efd374b0-a1a3-5893-a15a-805ff33fd7ed",
			},
			objectType = "folder",
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
							gVar = "ACR_RikuWHM3_CD",
							name = "Disable Lockface",
							uuid = "86b3535d-c30f-567c-bcc6-e8f7230a84b8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 276.1,
				name = "关闭锁定朝向",
				timelineIndex = 62,
				timerOffset = -0.5,
				uuid = "2e9effa9-aa1c-572d-8872-b5e075283da5",
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
									"a1149ea4-b9fa-5022-812e-00f7807d7c70",
									true,
								},
								
								{
									"8dfc223a-a42b-5cce-945a-236d694de158",
									false,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							setTarget = true,
							targetType = "Enemy",
							uuid = "6213dab8-e9dc-5c18-841e-d6aa64f63ca4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Find Boss",
							uuid = "a1149ea4-b9fa-5022-812e-00f7807d7c70",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Current Target",
							name = "Target Filter",
							uuid = "8dfc223a-a42b-5cce-945a-236d694de158",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 276.1,
				name = "选中首领",
				timeRange = true,
				timelineIndex = 62,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "04de2171-e455-5a26-b2ff-6ba5a0ef2bfc",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Toggle(\"dash\", false)\nself.used = true",
							gVar = "ACR_RikuSCH3_CD",
							uuid = "915dabe8-0467-5540-8c39-41c1e5e35eb9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 276.1,
				name = "暂停突进",
				timelineIndex = 62,
				timerOffset = 1.5,
				uuid = "53eb43d3-3785-577a-b614-c3968051dd1d",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Toggle(\"dash\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"e99538cd-971a-52f3-a934-30e5ac443bf9",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Toggle Dash",
							uuid = "adec961c-fdb4-5206-9c45-bf2ab1d0fc3b",
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
							conditionLua = "if (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\nreturn TensorCore.getDistance2d(data.arenaCenter, TensorCore.mGetPlayer().pos) > 8.5",
							dequeueIfLuaFalse = true,
							name = "Not Near Mid",
							uuid = "e99538cd-971a-52f3-a934-30e5ac443bf9",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 276.1,
				name = "突进首领",
				timeRange = true,
				timelineIndex = 62,
				timerEndOffset = 1,
				timerStartOffset = -0.25,
				uuid = "aea06482-041f-5e1e-8cb8-1232dde339a4",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "13f295f2-b122-503c-8e55-b57d470f7361",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal player = TensorCore.mGetPlayer()\nlocal pos = player.pos\nlocal arrowH = player.camera.h + math.pi\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addArrow(pos.x, 0.05, pos.z, arrowH, 31, 0.35, nil, nil, false, 256)\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Camera Arrow",
							uuid = "25a2e58d-bbcc-5d17-a200-83f3715c02d9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 276.1,
				name = "视角滑冰方向",
				timeRange = true,
				timelineIndex = 62,
				timerEndOffset = -2,
				timerStartOffset = -12,
				uuid = "303ef651-a518-5931-8a43-becfb83d3953",
				version = 2,
			},
		},
	},
	[64] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "c0c2af23-241c-5ba5-856f-39e1616c9bb6",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedRectOnEnt(5800, eventArgs.entityID, 65, 6, eventArgs.entityID2, 0, true, false, nil, nil, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"417a4377-4d1a-5f5e-a133-4e11b7f4204f",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Line Stack",
							uuid = "ecc55670-1da6-556c-b622-7bf20197e3f0",
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
							eventMarkerID = 525,
							name = "Marker ID",
							uuid = "417a4377-4d1a-5f5e-a133-4e11b7f4204f",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 4,
				mechanicTime = 283,
				name = "神圣路分摊范围",
				timeRange = true,
				timelineIndex = 64,
				timerStartOffset = -7.5,
				uuid = "e5e38b7e-a3f7-5e2d-8ce8-d6ae03efa5cd",
				version = 2,
			},
		},
	},
	[68] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "8f3c0694-81e0-595f-b070-c5a698ed2e20",
			},
			objectType = "folder",
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
							actionLua = "if (data.p2RedMirrorSpots == nil) then\n    data.p2RedMirrorSpots = {}\nend\n\nif (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\n\nlocal north = math.pi\nlocal increment = north / 4\nlocal h = north - (increment * (eventArgs.a1 - 1))\nlocal pos = TensorCore.getPosInDirection(data.arenaCenter, h, 20)\ntable.insert(data.p2RedMirrorSpots, pos)\n\nself.used = true",
							conditions = 
							{
								
								{
									"d5cd8097-fa01-5afe-8917-40a72510e79e",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Red Mirror Spot",
							uuid = "49479ba9-13b4-5c32-a520-dc101d4ce961",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.a2 == 256 and eventArgs.a3 == 512",
							conditions = 
							{
								
								{
									"8051e765-0d2c-95e4-827b-96bffed6dcc2",
									true,
								},
								
								{
									"56362527-b036-356c-b7ba-a34e0b596951",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							name = "Valid Args",
							partyTargetNumber = 0,
							uuid = "d5cd8097-fa01-5afe-8917-40a72510e79e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 2,
							eventIntValue = 256,
							name = "a2 等于 256",
							uuid = "8051e765-0d2c-95e4-827b-96bffed6dcc2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 3,
							eventIntValue = 512,
							name = "a3 等于 512",
							uuid = "56362527-b036-356c-b7ba-a34e0b596951",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 14,
				loop = true,
				mechanicTime = 292.6,
				name = "记录红镜位置",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 5,
				timerStartOffset = -3,
				uuid = "9f4abd10-7186-5fa9-a67a-13f10483133c",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal mirrorEntities = TensorCore.entityList(\"contentid=9317\")\nif (not table.valid(mirrorEntities)) then\n    self.used = true\n    return\nend\n\nif (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\nlocal visibleMirrors = {}\nfor _, ent in pairs(mirrorEntities) do\n    local isVisible = Argus.isEntityVisible(ent.id)\n    local centerDistance = TensorCore.getDistance2d(data.arenaCenter, ent.pos)\n    if (isVisible and centerDistance > 19 and centerDistance < 25) then\n        table.insert(visibleMirrors, ent)\n    end\nend\n\nif (#visibleMirrors ~= 3) then\n    MuAiGuide.Reactions.log(\"[Set Mirrors] Visible mirror count wasn't 3! Was \" .. tostring(#visibleMirrors), 5)\n    return\nend\n\nlocal redPos1 = data.p2RedMirrorSpots[1]\nlocal redPos2 = data.p2RedMirrorSpots[2]\n\nfor mirrorIndex = 1, 3 do\n    local mirrorEnt = visibleMirrors[mirrorIndex]\n    local redDist1 = TensorCore.getDistance2d(mirrorEnt.pos, redPos1)\n    local redDist2 = TensorCore.getDistance2d(mirrorEnt.pos, redPos2)\n    if (redDist1 > 3 and redDist2 > 3) then\n        local h = TensorCore.getHeadingToTarget(data.arenaCenter, mirrorEnt.pos)\n        data.p2BlueMirrorSpot = mirrorEnt.pos\n        break\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"c34834e1-abf6-5cdb-9ab7-e996a9182eed",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Mirrors",
							uuid = "e3cf01a7-fc8e-5a43-a022-6dbfbf037315",
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
							conditionLua = "return data.p2RedMirrorSpots ~= nil and data.p2RedMirrorSpots[2] ~= nil",
							name = "Red Mirrors Recorded",
							uuid = "c34834e1-abf6-5cdb-9ab7-e996a9182eed",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 292.6,
				name = "初始化镜子",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 5,
				timerStartOffset = -3,
				uuid = "e8357797-9a6d-50cb-8301-a36779dfc6f5",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "92c61fb9-e8b4-518d-9d3a-ab7d8ddf68ff",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal mirrorEntities = TensorCore.entityList(\"contentid=9317\")\nif (not table.valid(mirrorEntities)) then\n    self.used = true\n    return\nend\n\nif (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\nlocal visibleMirrors = {}\nfor _, ent in pairs(mirrorEntities) do\n    local isVisible = Argus.isEntityVisible(ent.id)\n    local centerDistance = TensorCore.getDistance2d(data.arenaCenter, ent.pos)\n    if (isVisible and centerDistance > 19 and centerDistance < 25) then\n        table.insert(visibleMirrors, ent)\n    end\nend\n\nif (#visibleMirrors ~= 3) then\n    MuAiGuide.Reactions.log(\"[Set Mirrors] Visible mirror count wasn't 3! Was \" .. tostring(#visibleMirrors), 5)\n    return\nend\n\nlocal redPos1 = data.p2RedMirrorSpots[1]\nlocal redPos2 = data.p2RedMirrorSpots[2]\n\nfor mirrorIndex = 1, 3 do\n    local mirrorEnt = visibleMirrors[mirrorIndex]\n    local redDist1 = TensorCore.getDistance2d(mirrorEnt.pos, redPos1)\n    local redDist2 = TensorCore.getDistance2d(mirrorEnt.pos, redPos2)\n    if (redDist1 > 3 and redDist2 > 3) then\n        local h = TensorCore.getHeadingToTarget(data.arenaCenter, mirrorEnt.pos)\n        local fruMuai1 = TensorCore.getCachedDrawer(0x4DFF4F00, nil, 0x4DFF4F00, 0xFFFFFFFF, 2, 0, 256)\n        fruMuai1:setGradient(3, 0.15, 2)\n        fruMuai1:setHeightOffset(0.05)\n        fruMuai1:addTimedArrow(5000, 100, 0.05, 100, h, 10, 1, nil, nil, 0, false, 256) --Blue arrow towards mirror.\n        local fruMuai2 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\n        fruMuai2:setGradient(3, 0.15, 2)\n        fruMuai2:setHeightOffset(0.05)\n        fruMuai2:addTimedArrow(5000, 100, 0.05, 100, h + math.pi, 10, 1, nil, nil, 0, false, 256) --Green arrow away from mirror.\n        break\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"c34834e1-abf6-5cdb-9ab7-e996a9182eed",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Mirror Arrows",
							uuid = "e3cf01a7-fc8e-5a43-a022-6dbfbf037315",
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
							conditionLua = "return data.p2RedMirrorSpots ~= nil and data.p2RedMirrorSpots[2] ~= nil",
							name = "Red Mirrors Recorded",
							uuid = "c34834e1-abf6-5cdb-9ab7-e996a9182eed",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 292.6,
				name = "首轮镜子站位箭头",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 5,
				timerStartOffset = -3,
				uuid = "8f0dd629-4eb7-504b-8c1b-1012ed7ab2ac",
				version = 2,
			},
		},
	},
	[71] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "b6aa7c66-7654-590e-ae99-b547e2012bf7",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pos = data.p2BlueMirrorSpot\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedDonut((306.6 - TensorReactions_CurrentTimer) * 1000, pos.x, 0.05, pos.z, 4, 20, nil, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"5d7a9a95-9183-58f0-88a0-49d1db16f0cc",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Draw Reflected Scythe Kick",
							uuid = "78093bfb-88b2-5025-9c78-95b231a0b218",
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
							eventArgType = 2,
							eventSpellID = 40203,
							name = "Scythe Kick ID",
							uuid = "5d7a9a95-9183-58f0-88a0-49d1db16f0cc",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 306.6,
				name = "镜像镰形回旋踢",
				timeRange = true,
				timelineIndex = 71,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "4d12c4ff-a6ee-5073-bbf5-e681811b94ae",
				version = 2,
			},
		},
	},
	[72] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "ef638433-d84e-57c8-bba7-bd7b289f4f99",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal cache = data.StringFRU_BossMirrorDraw\nif cache == nil then\n    cache = {entities = {}, distances = {}}\n    cache.less = function(a, b)\n        return cache.distances[a.id] < cache.distances[b.id]\n    end\n    data.StringFRU_BossMirrorDraw = cache\nend\n\nlocal sortedEnts = cache.entities\nlocal count = 0\nfor _, ent in pairs(party) do\n    count = count + 1\n    sortedEnts[count] = ent\nend\nfor i = count + 1, #sortedEnts do\n    sortedEnts[i] = nil\nend\n\nif (sortedEnts[4] == nil) then\n    MuAiGuide.Reactions.log(\"[Draw Boss/Mirror Cones] No 4th ent found.\")\n    self.used = true\n    return\nend\n\nlocal bossPos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal bluePos = data.p2BlueMirrorSpot\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal coneAngle = math.rad(30)\n\nfor i = 1, count do\n    local ent = sortedEnts[i]\n    cache.distances[ent.id] = TensorCore.getDistance2d(ent.pos, bossPos)\nend\ntable.sort(sortedEnts, cache.less)\n\nfor i = 1, 4 do\n    local h = TensorCore.getHeadingToTarget(bossPos, sortedEnts[i].pos)\n    drawer:addCone(bossPos.x, 0.05, bossPos.z, 40, coneAngle, h, false, 256)\nend\n\nfor i = 1, count do\n    local ent = sortedEnts[i]\n    cache.distances[ent.id] = TensorCore.getDistance2d(ent.pos, bluePos)\nend\ntable.sort(sortedEnts, cache.less)\n\nfor i = 1, 4 do\n    local h = TensorCore.getHeadingToTarget(bluePos, sortedEnts[i].pos)\n    drawer:addCone(bluePos.x, 0.05, bluePos.z, 40, coneAngle, h, false, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"84a1eb08-4071-5ddb-9863-ea528a615314",
									true,
								},
								
								{
									"b29d6641-c3c6-5947-b5fd-c079d2ab6068",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Cones",
							uuid = "8cbdf9e5-3471-5d0b-86b6-2ddcf0259835",
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
							conditionLua = "return data.p2BlueMirrorSpot ~= nil",
							name = "Mirrors Setup",
							uuid = "84a1eb08-4071-5ddb-9863-ea528a615314",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Get Boss",
							uuid = "b29d6641-c3c6-5947-b5fd-c079d2ab6068",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				loop = true,
				mechanicTime = 307.2,
				name = "本体与蓝镜扇形",
				timeRange = true,
				timelineIndex = 72,
				timerEndOffset = 0.35,
				timerStartOffset = -5,
				uuid = "f5a6191a-8d84-582c-923a-ab7cbd9895a7",
				version = 2,
			},
		},
	},
	[76] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "c68e77d7-7438-5651-a73d-891983b6c62e",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal cache = data.StringFRU_RedMirrorDraw\nif cache == nil then\n    cache = {entities = {}, distances = {}}\n    cache.less = function(a, b)\n        return cache.distances[a.id] < cache.distances[b.id]\n    end\n    data.StringFRU_RedMirrorDraw = cache\nend\n\nlocal sortedEnts = cache.entities\nlocal count = 0\nfor _, ent in pairs(party) do\n    count = count + 1\n    sortedEnts[count] = ent\nend\nfor i = count + 1, #sortedEnts do\n    sortedEnts[i] = nil\nend\n\nif (sortedEnts[4] == nil) then\n    self.used = true\n    return\nend\n\nlocal redPos1 = data.p2RedMirrorSpots[1]\nlocal redPos2 = data.p2RedMirrorSpots[2]\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal coneAngle = math.rad(30)\n\nfor i = 1, count do\n    local ent = sortedEnts[i]\n    cache.distances[ent.id] = TensorCore.getDistance2d(ent.pos, redPos1)\nend\ntable.sort(sortedEnts, cache.less)\n\nfor i = 1, 4 do\n    local h = TensorCore.getHeadingToTarget(redPos1, sortedEnts[i].pos)\n    drawer:addCone(redPos1.x, 0.05, redPos1.z, 40, coneAngle, h, false, 256)\nend\n\nfor i = 1, count do\n    local ent = sortedEnts[i]\n    cache.distances[ent.id] = TensorCore.getDistance2d(ent.pos, redPos2)\nend\ntable.sort(sortedEnts, cache.less)\n\nfor i = 1, 4 do\n    local h = TensorCore.getHeadingToTarget(redPos2, sortedEnts[i].pos)\n    drawer:addCone(redPos2.x, 0.05, redPos2.z, 40, coneAngle, h, false, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"84a1eb08-4071-5ddb-9863-ea528a615314",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Cones",
							uuid = "8cbdf9e5-3471-5d0b-86b6-2ddcf0259835",
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
							conditionLua = "return data.p2RedMirrorSpots ~= nil",
							dequeueIfLuaFalse = true,
							name = "Mirrors Setup",
							uuid = "84a1eb08-4071-5ddb-9863-ea528a615314",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				loop = true,
				mechanicTime = 317.1,
				name = "红镜扇形",
				timeRange = true,
				timelineIndex = 76,
				timerEndOffset = 0.15000000596046,
				timerStartOffset = -5,
				uuid = "13d02790-aaff-5857-9749-2e80ebce830d",
				version = 2,
			},
		},
	},
	[77] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "64ed60d5-80ce-54ca-b571-13df4f933b90",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal drawTime = (322.5 - TensorReactions_CurrentTimer) * 1000\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(drawTime, TensorCore.mGetPlayer().id, 5, nil, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"f0005060-f33c-5581-952d-55f07b1e74f3",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRG3_CD",
							name = "Draw Share Radius",
							uuid = "f74280c8-9a17-5158-b34d-b4f012228051",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal drawTime = (322.5 - TensorReactions_CurrentTimer) * 1000\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nfor _, ent in pairs(party) do\n    drawer:addTimedCircleOnEnt(drawTime, ent.id, 5, nil, false, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"da684a7a-d9a8-5cfa-8021-83bcfcda3ce5",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRG3_CD",
							name = "Draw Spreads",
							uuid = "bd953e50-6199-55ba-9382-729413ce4dc4",
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
							eventSpellID = 40220,
							name = "Partners",
							uuid = "f0005060-f33c-5581-952d-55f07b1e74f3",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40221,
							name = "Spread",
							uuid = "da684a7a-d9a8-5cfa-8021-83bcfcda3ce5",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 322.5,
				name = "强放逐分散分摊范围",
				timeRange = true,
				timelineIndex = 77,
				timerStartOffset = -8,
				uuid = "11bb6da6-1ce9-5610-a771-c2d8415e5e84",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Partners\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"f0005060-f33c-5581-952d-55f07b1e74f3",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRG3_CD",
							name = "TTS Partners",
							uuid = "f74280c8-9a17-5158-b34d-b4f012228051",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Spread\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"da684a7a-d9a8-5cfa-8021-83bcfcda3ce5",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRG3_CD",
							name = "TTS Spread",
							uuid = "bd953e50-6199-55ba-9382-729413ce4dc4",
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
							eventSpellID = 40220,
							name = "Partners",
							uuid = "f0005060-f33c-5581-952d-55f07b1e74f3",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40221,
							name = "Spread",
							uuid = "da684a7a-d9a8-5cfa-8021-83bcfcda3ce5",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 322.5,
				name = "强放逐分散分摊播报",
				timeRange = true,
				timelineIndex = 77,
				timerStartOffset = -8,
				uuid = "9c8a8948-5d83-5208-96d0-27f2e44c8263",
				version = 2,
			},
		},
	},
	[80] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "79d02d98-c3af-5f96-a5bb-16c556e350e4",
			},
			objectType = "folder",
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
							actionLua = "if (data.p2LRTetherCount == nil) then\n    data.p2LRTetherCount = 0\n    data.p2LRTetherInfo = {}\nend\ndata.p2LRTetherCount = data.p2LRTetherCount + 1\n\ndata.p2LRTetherInfo[eventArgs.newTargetID] = eventArgs.sourceEntityID\ndata.p2LRTetherInfo[eventArgs.sourceEntityID] = eventArgs.newTargetID\nself.used = true",
							conditions = 
							{
								
								{
									"4d7a2f3a-9876-5a8d-8ce4-2f4d80e40540",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Tether",
							uuid = "e4802b45-0dbd-533e-af00-595283a966ce",
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
							comparator = 3,
							conditionLua = "return eventArgs.newTetherID == 110",
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 110,
							name = "Tether ID",
							uuid = "4d7a2f3a-9876-5a8d-8ce4-2f4d80e40540",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 15,
				loop = true,
				mechanicTime = 331.8,
				name = "记录光暴连线",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 2,
				timerStartOffset = -1,
				uuid = "997d4ad5-5dc1-5df6-a857-f40243fce643",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "728152a1-b117-5e3b-b97e-4fdc3c7e41e9",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal playerID = TensorCore.mGetPlayer().id\nif eventArgs.sourceEntityID == playerID or eventArgs.newTargetID == playerID then\n    local fruMuai1 = TensorCore.getCachedDrawer(0x4DEC86C7, nil, 0x4DEC86C7, 0xFFFFFFFF, 2, 0, 256)\n    fruMuai1:setGradient(3, 0.15, 2)\n    fruMuai1:setHeightOffset(0.05)\n    fruMuai1:addTimedRectOnEnt(8000, eventArgs.sourceEntityID, 5, 0.1, eventArgs.newTargetID, 0, false, false, nil, nil, nil, 256)\nelse\n    local fruMuai2 = TensorCore.getCachedDrawer(0x4DEC8687, nil, 0x4DEC8687, 0xFFFFFFFF, 2, 0, 256)\n    fruMuai2:setGradient(3, 0.15, 2)\n    fruMuai2:setHeightOffset(0.05)\n    fruMuai2:addTimedRectOnEnt(8000, eventArgs.sourceEntityID, 5, 0.1, eventArgs.newTargetID, 0, false, false, nil, nil, nil, 256)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"13120e9f-2c33-5f87-b46e-9d8c1b06ec2a",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Draw Tether Rectangle",
							uuid = "26b9cb2d-6e77-5021-99bd-d7357952e813",
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
							comparator = 3,
							conditionLua = "return eventArgs.newTetherID == 110",
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 110,
							name = "Tether ID",
							uuid = "13120e9f-2c33-5f87-b46e-9d8c1b06ec2a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local playerID = TensorCore.mGetPlayer().id\nreturn eventArgs.sourceEntityID == playerID or eventArgs.newTargetID == playerID",
							dequeueIfLuaFalse = true,
							name = "On Self",
							uuid = "4412e7a6-ade0-586a-b54a-fbfd8ce94b69",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "机制绘图",
				eventType = 15,
				loop = true,
				mechanicTime = 331.8,
				name = "光暴连线范围",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 4,
				timerStartOffset = -1,
				uuid = "6405e9a8-0ee1-5eb9-825b-c9ca19f1bf1b",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\n---@type GameObject[]\nlocal supports = {}\n---@type GameObject[]\nlocal dps = {}\n\nfor _, ent in pairs(party) do\n    if (data.p2LRTetherInfo[ent.id] ~= nil) then\n        if (MuAiGuide.Reactions.dpsJobs[ent.job]) then\n            table.insert(dps, ent)\n        else\n            table.insert(supports, ent)\n        end\n    end\nend\n\nlocal supportCount = #supports\nlocal dpsCount = #dps\n\nif ((supportCount + dpsCount) ~= 6) then\n    MuAiGuide.Reactions.log(\"[4-4 LR Helper] Support+DPS tethers didn't equal 6!\", 5)\n    self.used = true\n    return\nend\n\n-- Sort supports west-to-east.\ntable.sort(supports, function (entA, entB)\n    return entA.pos.x < entB.pos.x\nend)\n\n-- Sort dps east-to-west.\ntable.sort(dps, function (entA, entB)\n    return entA.pos.x > entB.pos.x\nend)\n\n---@type GameObject[]\nlocal finalLineup = {}\n\nif (supportCount == 3 and dpsCount == 3) then\n    for i = 1, 3 do\n        finalLineup[i] = supports[i]\n        finalLineup[i + 3] = dps[i]\n    end\nelse\n    if (supportCount == 2) then\n        finalLineup[1] = dps[4]\n        finalLineup[2] = supports[1]\n        finalLineup[3] = supports[2]\n        finalLineup[4] = dps[1]\n        finalLineup[5] = dps[2]\n        finalLineup[6] = dps[3]\n    else\n        for i = 1, 4 do\n            finalLineup[i] = supports[i]\n        end\n        finalLineup[5] = dps[1]\n        finalLineup[6] = dps[2]\n    end\nend\n\n---@type GameObject[]\nlocal crissCross = {}\ncrissCross[1] = finalLineup[3]\ncrissCross[2] = finalLineup[5]\ncrissCross[3] = finalLineup[1]\ncrissCross[4] = finalLineup[4]\ncrissCross[5] = finalLineup[2]\ncrissCross[6] = finalLineup[6]\n\n-- WorldText is here mainly for debug helping in case something wasn't coded right. Remove later once proved to be working reliably.\nMuAiGuide.Reactions.addTimedWorldTextOnEnt(5000, \"NW\", crissCross[1].id, nil, true, 1.5)\nMuAiGuide.Reactions.addTimedWorldTextOnEnt(5000, \"N\", crissCross[2].id, nil, true, 1.5)\nMuAiGuide.Reactions.addTimedWorldTextOnEnt(5000, \"NE\", crissCross[3].id, nil, true, 1.5)\nMuAiGuide.Reactions.addTimedWorldTextOnEnt(5000, \"SE\", crissCross[4].id, nil, true, 1.5)\nMuAiGuide.Reactions.addTimedWorldTextOnEnt(5000, \"S\", crissCross[5].id, nil, true, 1.5)\nMuAiGuide.Reactions.addTimedWorldTextOnEnt(5000, \"SW\", crissCross[6].id, nil, true, 1.5)\n\nlocal pi = math.pi\nlocal rad = math.rad(60)\nlocal arrowHeadings = {\n    [1] = pi + rad,\n    [2] = pi,\n    [3] = pi - rad,\n    [4] = rad,\n    [5] = 0,\n    [6] = -rad\n}\nlocal callStrings = {\n    [1] = \"NorthWest\",\n    [2] = \"North\",\n    [3] = \"NorthEast\",\n    [4] = \"SouthEast\",\n    [5] = \"South\",\n    [6] = \"SouthWest\"\n}\n\nlocal playerID = TensorCore.mGetPlayer().id\nfor i = 1, 6 do\n    if (crissCross[i].id == playerID) then\n        MuAiGuide.Reactions.Shotcall(callStrings[i], true)\n        local fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\n        fruMuai1:setGradient(3, 0.15, 2)\n        fruMuai1:setHeightOffset(0.05)\n        fruMuai1:addTimedArrow(5000, 100, 0.05, 100, arrowHeadings[i], 10, 1, nil, nil, 0, false, 256)\n        break\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"3d344115-c2af-5097-9e24-b339f3f8bdc0",
									true,
								},
								
								{
									"56f0b628-fdff-54e5-89b8-3306bf87c2fd",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Run 4-4 Helper",
							uuid = "97d74f92-d7d9-56ac-b076-c7ea795dea72",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruP2LightRampant44Helper == true",
							dequeueIfLuaFalse = true,
							name = "Helper Enabled",
							uuid = "3d344115-c2af-5097-9e24-b339f3f8bdc0",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p2LRTetherCount == 6",
							name = "All Tethers Recorded",
							uuid = "56f0b628-fdff-54e5-89b8-3306bf87c2fd",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 331.8,
				name = "光暴四四分组指路",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 2,
				timerStartOffset = -1,
				uuid = "6384f4f6-9bdb-58be-839a-386c0547d3a7",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedCircleOnEnt((345.9 - TensorReactions_CurrentTimer) * 1000, eventArgs.entityID2, 6, nil, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"e090bb69-2c56-57c5-9233-51e275d0a885",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Puddle Radius",
							uuid = "dfb5afac-9fae-5b9f-955f-b91fe06b7574",
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
							eventMarkerID = 375,
							name = "Marker ID",
							uuid = "e090bb69-2c56-57c5-9233-51e275d0a885",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 4,
				loop = true,
				mechanicTime = 331.8,
				name = "光暴放圈范围",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 4,
				timerStartOffset = -1,
				uuid = "bd47b999-cf14-5f8f-94e7-eb77894c2d4d",
				version = 2,
			},
		},
	},
	[81] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "45adf266-c22b-5d50-ab4c-96c81bcb2d2a",
			},
			objectType = "folder",
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
									"0ff67ca6-bec1-5e4d-b9df-e582d79b24bb",
									true,
								},
							},
							gVar = "ACR_TensorViper3_Reawaken",
							gVarValue = 2,
							uuid = "cb693c37-c4f0-5dd0-93a2-05bcb6729130",
							variableTogglesType = "QT Toggles",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"0ff67ca6-bec1-5e4d-b9df-e582d79b24bb",
									true,
								},
							},
							gVar = "ACR_TensorViper3_Reawaken",
							gVarValue = "True",
							uuid = "1af2808d-505c-5fc7-b671-3a578b93ebbc",
							variableTogglesType = "QT Toggles",
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
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							name = "Is VPR",
							uuid = "0ff67ca6-bec1-5e4d-b9df-e582d79b24bb",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 335.9,
				name = "蝰蛇祖灵降临开关",
				throttleTime = 16000,
				timeRange = true,
				timelineIndex = 81,
				timerEndOffset = 5,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "09f3936b-0438-5647-bb90-aa13575e2b2b",
				version = 2,
			},
		},
	},
	[85] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "e54483eb-13c1-5274-b694-01ab92a49e88",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nif (data.p2LROrbCount == nil) then data.p2LROrbCount = 0 end\ndata.p2LROrbCount = data.p2LROrbCount + 1\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(2850, eventArgs.entityID, 11, nil, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"b60c316c-38ca-5380-ab91-020a4f56b2cb",
									true,
								},
								
								{
									"2e2082eb-2a19-55cb-9e76-5d66130b4de8",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Predraw Big Orb",
							uuid = "69e70f02-6cdd-59f4-a68c-97f20f17739c",
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
							eventEntityContentID = 9318,
							name = "Content ID",
							uuid = "b60c316c-38ca-5380-ab91-020a4f56b2cb",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p2LROrbCount == nil or data.p2LROrbCount < 3",
							dequeueIfLuaFalse = true,
							name = "Count Check",
							uuid = "2e2082eb-2a19-55cb-9e76-5d66130b4de8",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 5,
				loop = true,
				mechanicTime = 343,
				name = "光暴首轮光球预兆",
				timeRange = true,
				timelineIndex = 85,
				timerEndOffset = 3,
				timerStartOffset = -2,
				uuid = "094abd20-55bf-5923-b132-95a063e1f2f1",
				version = 2,
			},
		},
	},
	[88] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "6e0cba3d-9315-59d9-9f5a-8e12eebe1639",
			},
			objectType = "folder",
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
							gVar = "ACR_RikuDRK3_CD",
							ignoreWeaveRules = true,
							uuid = "210bb157-1090-55c4-8ee9-b4eec12a546f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 348.7,
				name = "开启疾跑",
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = -9,
				timerStartOffset = -11,
				uuid = "6ad2526b-f4fe-5d2c-8a2d-88d09a19cad7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "a019ab62-bd4e-5a31-a37b-ad6762005767",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal drawTime = (348.7 - TensorReactions_CurrentTimer) * 1000\nfor _, ent in pairs(party) do\n    if (TensorCore.hasBuff(ent.id, 4159)) then\n        drawer:addTimedCircleOnEnt(drawTime, ent.id, 5, nil, false, nil, 256)\n    end\nend\n\nself.used = true",
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Stacks",
							uuid = "eacb01b9-cc27-5d52-aaf5-bd8ff08a75ae",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 348.7,
				name = "光暴分组分摊范围",
				timelineIndex = 88,
				timerOffset = -5,
				uuid = "246e34f4-5cd5-5b53-b62f-d85b5b8822b5",
				version = 2,
			},
		},
	},
	[90] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "fcc30674-3f15-5d57-b23c-2e202ed60d10",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Take Middle Tower\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"4301ecff-6b59-5999-a46b-6737fa6d7136",
									true,
								},
								
								{
									"5082d1d3-8145-5590-9cc7-004a7ea4ac0c",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Shotcall Take Tower",
							uuid = "f0f46367-2876-5955-8c93-d5257528a875",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 2257,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Has Lightsteeped",
							uuid = "4301ecff-6b59-5999-a46b-6737fa6d7136",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.hasBuff(TensorCore.mGetPlayer().id, 2257, nil, 2)",
							dequeueIfLuaFalse = true,
							name = "Stacks Check",
							uuid = "5082d1d3-8145-5590-9cc7-004a7ea4ac0c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 355,
				name = "踩塔播报",
				timeRange = true,
				timelineIndex = 90,
				timerOffset = -1,
				timerStartOffset = -3,
				uuid = "02c4027f-4360-5221-967d-d22c7559e099",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircle((357.7 - TensorReactions_CurrentTimer) * 1000, 100, 0.05, 100, 4, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"4301ecff-6b59-5999-a46b-6737fa6d7136",
									true,
								},
								
								{
									"5082d1d3-8145-5590-9cc7-004a7ea4ac0c",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Tower Green",
							uuid = "f0f46367-2876-5955-8c93-d5257528a875",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D0000FF, nil, 0x4D0000FF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircle((357.7 - TensorReactions_CurrentTimer) * 1000, 100, 0.05, 100, 4, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"4301ecff-6b59-5999-a46b-6737fa6d7136",
									true,
								},
								
								{
									"5082d1d3-8145-5590-9cc7-004a7ea4ac0c",
									false,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Tower Red",
							uuid = "836aaa6b-ee63-5cc1-8040-cc17d536ada4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 2257,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Has Lightsteeped",
							uuid = "4301ecff-6b59-5999-a46b-6737fa6d7136",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.hasBuff(TensorCore.mGetPlayer().id, 2257, nil, 2)",
							dequeueIfLuaFalse = true,
							name = "Stacks Check",
							uuid = "5082d1d3-8145-5590-9cc7-004a7ea4ac0c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 355,
				name = "光暴四人塔",
				timeRange = true,
				timelineIndex = 90,
				timerOffset = -1,
				timerStartOffset = -3,
				uuid = "cfece5cf-06ee-5870-9488-612925a9d0a5",
				version = 2,
			},
		},
	},
	[92] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "6fbccb55-6ab4-59ca-8401-7795c863caef",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(5000, TensorCore.mGetPlayer().id, 5, nil, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"f0005060-f33c-5581-952d-55f07b1e74f3",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRG3_CD",
							name = "Draw Share Radius",
							uuid = "f74280c8-9a17-5158-b34d-b4f012228051",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal playerID = TensorCore.mGetPlayer().id\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nfor _, ent in pairs(party) do\n    if (ent.id ~= playerID) then\n        drawer:addTimedCircleOnEnt(5000, ent.id, 5, nil, false, nil, 256)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"da684a7a-d9a8-5cfa-8021-83bcfcda3ce5",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRG3_CD",
							name = "Draw Spreads",
							uuid = "bd953e50-6199-55ba-9382-729413ce4dc4",
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
							eventSpellID = 40220,
							name = "Partners",
							uuid = "f0005060-f33c-5581-952d-55f07b1e74f3",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40221,
							name = "Spread",
							uuid = "da684a7a-d9a8-5cfa-8021-83bcfcda3ce5",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 360.8,
				name = "强放逐分散分摊范围",
				timeRange = true,
				timelineIndex = 92,
				timerStartOffset = -8,
				uuid = "24875b34-d31c-51de-a771-fc1e5e8288fe",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Partners\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"f0005060-f33c-5581-952d-55f07b1e74f3",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRG3_CD",
							name = "TTS Partners",
							uuid = "f74280c8-9a17-5158-b34d-b4f012228051",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Spread\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"da684a7a-d9a8-5cfa-8021-83bcfcda3ce5",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRG3_CD",
							name = "TTS Spread",
							uuid = "bd953e50-6199-55ba-9382-729413ce4dc4",
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
							eventSpellID = 40220,
							name = "Partners",
							uuid = "f0005060-f33c-5581-952d-55f07b1e74f3",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40221,
							name = "Spread",
							uuid = "da684a7a-d9a8-5cfa-8021-83bcfcda3ce5",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 360.8,
				name = "强放逐分散分摊播报",
				timeRange = true,
				timelineIndex = 92,
				timerStartOffset = -8,
				uuid = "3530448c-a914-5ce3-8fa1-b43334e10ead",
				version = 2,
			},
		},
	},
	[93] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "0958123c-97ed-5fb2-9e64-b631b35cb83a",
			},
			objectType = "folder",
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
									"a1149ea4-b9fa-5022-812e-00f7807d7c70",
									true,
								},
								
								{
									"8dfc223a-a42b-5cce-945a-236d694de158",
									false,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							setTarget = true,
							targetType = "Enemy",
							uuid = "6213dab8-e9dc-5c18-841e-d6aa64f63ca4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Find Boss",
							uuid = "a1149ea4-b9fa-5022-812e-00f7807d7c70",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Current Target",
							name = "Target Filter",
							uuid = "8dfc223a-a42b-5cce-945a-236d694de158",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 363.5,
				name = "选中首领",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "fade6783-95d5-55ad-b5fd-bbd794c32482",
				version = 2,
			},
		},
	},
	[95] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "4eb8f8a7-dc5e-5598-8d86-1d4897868ac5",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogleDirect = TensorCore.getMoogleDrawer()\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal coneAngle = math.rad(60)\nlocal drawTime = (369.8 - TensorReactions_CurrentTimer) * 1000\nfor _, ent in pairs(party) do\n    Argus2.addTimedConeFilled(drawTime, 100, 0.05, 100, 25, coneAngle, 0, 15, (fruMoogleDirect.colorStart and fruMoogleDirect.colorStart % 0x1000000 + 0x4D000000), (fruMoogleDirect.colorEnd and fruMoogleDirect.colorEnd % 0x1000000 + 0x4D000000), (fruMoogleDirect.colorMid and fruMoogleDirect.colorMid % 0x1000000 + 0x4D000000), 0, nil, ent.id, 0xFFFFFFFF, 2, 3, 0.15, 2, false, nil, nil, nil, 256, nil, nil, nil, nil)\nend\n\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Cones",
							uuid = "2ad85f3e-9ff8-50d0-b074-d32c0a616723",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 368.8,
				name = "光之海啸扇形",
				timeRange = true,
				timelineIndex = 95,
				timerEndOffset = -1,
				timerStartOffset = -3.5,
				uuid = "3f30642d-22e3-5d1b-9950-14b444e639cb",
				version = 2,
			},
		},
	},
	[99] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "fa5e1509-40f8-5806-b01e-2a58b0eb0e40",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Knockback Soon\", true)\nself.used = true",
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							uuid = "817cd8ca-8d85-5798-b366-291a9ef89475",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 387.8,
				name = "击退预警播报",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 4,
				uuid = "546f4bb8-a179-5e32-9290-b5d07b3b7e46",
				version = 2,
			},
		},
	},
	[102] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "9b072bc4-8b77-5be5-8b61-f6ffc5227eee",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n---@class LightCrystalInfo\n---@field id integer\n---@field pos ThreeDimensionalPos\n---@field isAlive boolean\n\n---@type LightCrystalInfo[]\ndata.addsCrystalInfoArray = {\n    [1] = {\n        id = -1,\n        pos = {x = 100, y = 0, z = 85},\n        isAlive = true,\n    },\n    [2] = {\n        id = -1,\n        pos = {x = 85, y = 0, z = 100},\n        isAlive = true,\n    },\n    [3] = {\n        id = -1,\n        pos = {x = 100, y = 0, z = 115},\n        isAlive = true,\n    },\n    [4] = {\n        id = -1,\n        pos = {x = 115, y = 0, z = 100},\n        isAlive = true,\n    },\n}\n\n-- tables are ref objects so we can do this for an easy 'looparound' for helping do line cleave shit\ndata.addsCrystalInfoArray[0] = data.addsCrystalInfoArray[4]\ndata.addsCrystalInfoArray[5] = data.addsCrystalInfoArray[1]\n\n---@type integer[]\ndata.addsCrystalIDArray = {\n    [0] = -1,\n    [1] = -1,\n    [2] = -1,\n    [3] = -1,\n    [4] = -1,\n    [5] = -1,\n}\n\n-- to have as a basic easy lua condition for fast checking\ndata.addsRecordedCrystalCount = 0\ndata.addsDeadCrystalCount = 0\n\nlocal player = TensorCore.mGetPlayer()\nlocal jobID = player.job\nlocal isMelee = MuAiGuide.Reactions.meleeJobs[jobID] == true\nlocal isTank = MuAiGuide.Reactions.tankJobs[jobID] == true\ndata.selfIsMeleeRange = isMelee or isTank\ndata.addsLastAutoTarget = Now()\ndata.addsRunAutoTarget = true\nself.used = true",
							gVar = "ACR_RikuDRK3_CD",
							name = "Run Adds Setup",
							uuid = "0809bff5-1756-5105-9924-c8f378a95d66",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 418.8,
				name = "初始化水晶阶段",
				timelineIndex = 102,
				timerOffset = -15,
				uuid = "cc061033-dcfb-5220-9db5-0a65695524a0",
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
							actionLua = "data.addsIceID = eventArgs.entityID\nself.used = true",
							conditions = 
							{
								
								{
									"aced7d43-ca5c-5f94-89fa-d4702878e35b",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_CD",
							name = "Set Ice ID",
							uuid = "c1280da2-2275-5bcb-b603-cdf2e8fb47b9",
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
							eventEntityContentID = 9358,
							name = "Content ID",
							uuid = "aced7d43-ca5c-5f94-89fa-d4702878e35b",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 5,
				mechanicTime = 418.8,
				name = "记录永久冰晶",
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 1,
				timerStartOffset = -4,
				uuid = "2dd63784-57be-51bd-9323-56001ab8d007",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal id = eventArgs.entityID\nlocal ent = TensorCore.mGetEntity(id)\nif (ent == nil) then\n    MuAiGuide.Reactions.log(\"[Light ID Record] Crystal ent added was nil!?\", 5)\n    self.used = true\n    return\nend\n\nlocal pos = ent.pos\nlocal x = pos.x\nlocal z = pos.z\n\nlocal crystalIndex = -1\nlocal infoArray = data.addsCrystalInfoArray\nfor i = 1, 4 do\n    local info = infoArray[i]\n    local cPos = info.pos\n    local dx = cPos.x - x\n    local dz = cPos.z - z\n    local sqDist = dx * dx + dz * dz\n    if (sqDist < 3) then\n        crystalIndex = i\n        info.id = id\n        break\n    end\nend\n\nif (crystalIndex <= 0) then\n    MuAiGuide.Reactions.log(\"Couldn't find crystal index for coordinates: \" .. tostring(x) .. \",\" .. tostring(z), 5)\n    self.used = true\n    return\nend\n\n--MuAiGuide.Reactions.addTimedWorldText(15000, tostring(crystalIndex), pos, nil, true, 1.5)\n--local debugString = string.format(\"[Light ID Record] Recorded %d (%.2f,%.2f) to index %d\", id, x, z, crystalIndex)\n--MuAiGuide.Reactions.log(debugString, 5)\n\nlocal idArray = data.addsCrystalIDArray\nidArray[crystalIndex] = id\n-- to account for loop-around\n-- we don't need to do this for the info array as it'll already be done by ref\nif (crystalIndex == 4) then\n    idArray[0] = id\nelseif (crystalIndex == 1) then\n    idArray[5] = id\nend\nlocal curCount = data.addsRecordedCrystalCount\ndata.addsRecordedCrystalCount = curCount + 1\n\nself.used = true",
							conditions = 
							{
								
								{
									"a60d80d3-0a4d-5819-9bbb-5192c1e45505",
									true,
								},
								
								{
									"34bc1298-f229-5be3-b7cd-f06ac7f6f191",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_CD",
							name = "Record Light ID",
							uuid = "4107fc55-5271-5ca3-a96d-2ecd06bea545",
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
							eventEntityContentID = 13555,
							name = "Content ID",
							uuid = "a60d80d3-0a4d-5819-9bbb-5192c1e45505",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return Argus.getEntityModel(eventArgs.entityID) == 17827",
							dequeueIfLuaFalse = true,
							name = "Model ID",
							uuid = "34bc1298-f229-5be3-b7cd-f06ac7f6f191",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 5,
				loop = true,
				mechanicTime = 418.8,
				name = "记录光水晶",
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 1,
				timerStartOffset = -4,
				uuid = "1d28978d-9893-53a7-aea1-d60a9956c7b3",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal id = eventArgs.entityID\nlocal idArray = data.addsCrystalIDArray\nfor i = 1, 4 do\n    if (id == idArray[i]) then\n        data.addsCrystalInfoArray[i].isAlive = false\n        local newCount = data.addsDeadCrystalCount + 1\n        data.addsDeadCrystalCount = newCount\n        --local debugString = string.format(\"[Set Light Dead] ID %d, Index %d set as dead.\", id, i)\n        --MuAiGuide.Reactions.log(debugString, 5)\n        self.used = true\n        return\n    end\nend\n\nMuAiGuide.Reactions.log(\"Couldn't find crystal with ID of \" .. tostring(id), 5)\nself.used = true",
							conditions = 
							{
								
								{
									"b44ca36f-7890-5c9f-9f63-34f587a78b1f",
									true,
								},
								
								{
									"d3b067ea-50ac-5dad-97e8-51c89e546d3c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_CD",
							name = "Set Light Dead",
							uuid = "189ea92a-d774-52c1-b422-447efaebeb03",
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
							conditionLua = "return eventArgs.entityContentID == 13555",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 13555,
							name = "Content ID",
							uuid = "b44ca36f-7890-5c9f-9f63-34f587a78b1f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.newAnimID == 72",
							dequeueIfLuaFalse = true,
							eventArgType = 4,
							eventIntValue = 72,
							name = "New Anim ID",
							uuid = "d3b067ea-50ac-5dad-97e8-51c89e546d3c",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 23,
				loop = true,
				mechanicTime = 418.8,
				name = "更新光水晶存活状态",
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 41,
				timerStartOffset = 8,
				uuid = "84d6461c-d5e5-52f6-8f5b-7cd5843384f3",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "d28c665f-195a-5a68-a86f-b7eb64d64c31",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal enrageTime = 466.4\nlocal endDrawTime = enrageTime - 10\nlocal drawTime = (endDrawTime - TensorReactions_CurrentTimer) * 1000\nlocal drawer = TensorCore.getCachedDrawer(0x4DFF00BF, nil, 0x4DFF00BF, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\n\ndrawer:addTimedDonut(drawTime, 85, 0.05, 100, 4.9, 5, nil, false, nil, 256)\ndrawer:addTimedDonut(drawTime, 100, 0.05, 85, 4.9, 5, nil, false, nil, 256)\ndrawer:addTimedDonut(drawTime, 100, 0.05, 115, 4.9, 5, nil, false, nil, 256)\ndrawer:addTimedDonut(drawTime, 115, 0.05, 100, 4.9, 5, nil, false, nil, 256)\n\nself.used = true",
							gVar = "ACR_RikuDRK3_CD",
							name = "Draw Max Melee",
							uuid = "96d5dfff-d7ff-581d-bb97-a8c566f29095",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 418.8,
				name = "水晶近战距离参考",
				timelineIndex = 102,
				timerOffset = -2,
				uuid = "9ebfb835-8e5d-5741-9a11-ac190d4f3909",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal infoArray = data.addsCrystalInfoArray\nlocal drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal getH = TensorCore.getHeadingToTarget\nlocal posInDir = TensorCore.getPosInDirection\nfor i = 1, 4 do\n    local nb1 = infoArray[i-1].pos\n    local nb2 = infoArray[i+1].pos\n    local cur = infoArray[i].pos\n    local h1 = getH(cur, nb1)\n    local h2 = getH(cur, nb2)\n    local x1, _, z1 = posInDir(cur, h1, -2.5, true)\n    local x2, _, z2 = posInDir(cur, h2, -2.5, true)\n    drawer:addTimedLine(10000, x1, 0.05, z1, cur.x, 0.05, cur.z, 8)\n    drawer:addTimedLine(10000, x2, 0.05, z2, cur.x, 0.05, cur.z, 8)\nend\n\nself.used = true",
							gVar = "ACR_RikuDRK3_CD",
							name = "Draw Line Cleave Spots",
							uuid = "fe3303c6-c25e-5ddd-868e-8536a44bd3fa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 418.8,
				name = "水晶直线安全站位",
				timelineIndex = 102,
				timerOffset = -5,
				uuid = "163722f8-f860-56ef-b0e1-ec7807e72321",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "目标选择",
				uuid = "2aa2580c-51e2-23c0-a8f0-b56e33f1791c",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "目标选择",
				name = "水晶规则",
				uuid = "ea6f534c-795f-5bff-9b3f-4f41de424341",
			},
			objectType = "folder",
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
							actionLua = "local acr = TensorCore.API.TensorACR\nif acr.addBlacklistEntry ~= nil then\n    local dot = acr.addBlacklistEntry(13556, \"暗水晶\")\n    dot.enabled = true\n    dot.allowIfTarget = false\n    dot.allowSmartDoT = false\nend\n\nlocal aoe = acr.addAOEBlacklistEntry(13556, \"暗水晶\")\naoe.enabled = true\nself.used = true\n",
							name = "设置暗水晶DoT和AOE规则",
							uuid = "a6ec0797-3d9a-1ca1-91d8-8212b743ea5f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "目标选择/水晶规则",
				mechanicTime = 418.8,
				name = "暗水晶禁持续伤害和群攻",
				timelineIndex = 102,
				timerOffset = -5,
				uuid = "23e56896-6e8b-af48-88ee-c7885e0f570c",
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
									"d3e1d177-c04b-3662-957d-3dab168a9b3e",
									true,
								},
								
								{
									"07248c67-53a0-7bf2-b8da-a02acb35d10a",
									true,
								},
							},
							endIfUsed = true,
							name = "误选后切回光水晶",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "416eb04e-f022-a193-8a20-eab1397e4143",
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
									"d3e1d177-c04b-3662-957d-3dab168a9b3e",
									true,
								},
								
								{
									"07248c67-53a0-7bf2-b8da-a02acb35d10a",
									false,
								},
								
								{
									"6a508360-b2e6-9f19-a2ca-02cc1c9f5812",
									true,
								},
							},
							endIfUsed = true,
							name = "光水晶清空后切到永久冰晶",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "50bd2457-05af-dade-9f12-79d65bf13c87",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							conditionType = 2,
							contentid = 13556,
							name = "当前选中暗水晶",
							uuid = "d3e1d177-c04b-3662-957d-3dab168a9b3e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 2,
							hpType = 2,
							hpValue = 1,
							name = "候选目标存活",
							partyTargetType = "Detection Target",
							uuid = "c6800578-91d7-ab8d-8216-d85225fae393",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"c6800578-91d7-ab8d-8216-d85225fae393",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "最近的存活光水晶",
							partyTargetContentID = 13555,
							uuid = "07248c67-53a0-7bf2-b8da-a02acb35d10a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"c6800578-91d7-ab8d-8216-d85225fae393",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "存活的永久冰晶",
							partyTargetContentID = 9358,
							uuid = "6a508360-b2e6-9f19-a2ca-02cc1c9f5812",
							version = 3,
						},
					},
				},
				displayPath = "目标选择/水晶规则",
				eventType = 12,
				mechanicTime = 418.8,
				name = "暗水晶误选纠正",
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 60,
				timerStartOffset = -1.5,
				uuid = "9cb41202-0bd6-893f-8926-f1ac1643672d",
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
									"73bd4b7b-4a68-2440-9e30-5027cd95d837",
									true,
								},
								
								{
									"e58028a1-d9ea-40e1-8a1b-5b403b42e8b8",
									true,
								},
								
								{
									"aaf9c76f-3380-d2d6-a7fd-5c7e4ed2dccb",
									true,
								},
								
								{
									"ece04411-9411-ebb0-ba88-1c9f2815878d",
									true,
								},
							},
							endIfUsed = true,
							name = "选中光水晶",
							setTarget = true,
							targetContentID = 13555,
							targetType = "ContentID",
							uuid = "94edfe98-1412-8e6b-b1f2-67d5cf910868",
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
									"73bd4b7b-4a68-2440-9e30-5027cd95d837",
									true,
								},
								
								{
									"e58028a1-d9ea-40e1-8a1b-5b403b42e8b8",
									true,
								},
								
								{
									"84c3c17f-8541-3146-ad39-5fa7d9f7b7b2",
									true,
								},
								
								{
									"ece04411-9411-ebb0-ba88-1c9f2815878d",
									false,
								},
							},
							endIfUsed = true,
							name = "选中永久冰晶",
							setTarget = true,
							targetContentID = 9358,
							targetType = "ContentID",
							uuid = "bf57b228-311d-5acf-9109-b5056950247b",
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
							conditionLua = "return FFXIV_Common_BotRunning",
							dequeueIfLuaFalse = true,
							name = "辅助已开启",
							uuid = "73bd4b7b-4a68-2440-9e30-5027cd95d837",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 2,
							dequeueIfLuaFalse = true,
							hpType = 2,
							name = "玩家生命检查",
							uuid = "e58028a1-d9ea-40e1-8a1b-5b403b42e8b8",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local target = TensorCore.mGetTarget()\nreturn target == nil or target.hp.current == 0 or target.contentid == 9358",
							name = "需要切换到光水晶",
							uuid = "aaf9c76f-3380-d2d6-a7fd-5c7e4ed2dccb",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local target = TensorCore.mGetTarget()\nreturn target == nil or target.hp.current == 0",
							name = "未选中目标或目标已死亡",
							uuid = "84c3c17f-8541-3146-ad39-5fa7d9f7b7b2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"b1adbdd6-5c44-21d5-8fdb-5e1b345c9bc4",
									true,
								},
								
								{
									"54df1e95-3feb-ce29-b1c4-44da06e43af3",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "存在攻击范围内光水晶",
							partyTargetContentID = 13555,
							uuid = "ece04411-9411-ebb0-ba88-1c9f2815878d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 2,
							hpType = 2,
							hpValue = 1,
							name = "目标存活",
							partyTargetType = "Detection Target",
							uuid = "b1adbdd6-5c44-21d5-8fdb-5e1b345c9bc4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- checks if detection target is in max attack range\n-- setting first arg to nil will make function auto adjust to an action that fits current jobs max attack range\nreturn eventArgs.detectionTargetID ~= nil and MuAiGuide.Reactions.API.IsInRange(nil, eventArgs.detectionTargetID)",
							name = "目标在最大攻击范围内",
							uuid = "54df1e95-3feb-ce29-b1c4-44da06e43af3",
							version = 3,
						},
					},
				},
				displayPath = "目标选择",
				enabled = false,
				loop = true,
				mechanicTime = 418.8,
				name = "水晶自动选中(备用)",
				throttleTime = 1000,
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 50,
				uuid = "c3d83ac8-90c8-8aca-8601-ebf30c6a2d1d",
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
									"8260ed1c-4295-4e96-8f95-64e2ae10e114",
									true,
								},
							},
							name = "选中目标",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "6e90d861-4f9b-ee03-8294-642796be38a8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "ContentID",
							name = "至少出现4个光水晶",
							partyTargetContentID = 13555,
							partyTargetNumber = 4,
							uuid = "8260ed1c-4295-4e96-8f95-64e2ae10e114",
							version = 3,
						},
					},
				},
				displayPath = "目标选择",
				mechanicTime = 418.8,
				name = "光水晶出现时选中",
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 2,
				timerStartOffset = -1.5,
				uuid = "5ecc35a0-5480-8628-926e-724f4bd9a6a4",
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
									"de1d47d9-f2da-91a2-a764-37e6aed0d05f",
									true,
								},
								
								{
									"61b80036-ed22-a3ff-8815-327316467fce",
									true,
								},
								
								{
									"0e37c596-fb28-9784-a548-2ff2a402c1fe",
									true,
								},
							},
							endIfUsed = true,
							name = "选中最近光水晶",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "a569bce6-e8f0-dc28-a0f9-c6502e85b885",
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
									"de1d47d9-f2da-91a2-a764-37e6aed0d05f",
									true,
								},
								
								{
									"61b80036-ed22-a3ff-8815-327316467fce",
									true,
								},
								
								{
									"f1ef926b-c846-985b-a025-c56468dcadf6",
									true,
								},
							},
							endIfUsed = true,
							name = "选中最高血量光水晶",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "e6d61c39-a028-0ae5-89e3-6b8ec036341c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"7df6b3e2-d110-bc53-9ae2-1f0609fc9d48",
									true,
								},
								
								{
									"a81c8af1-51b1-a664-ba9f-f8db619e5243",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "坦克或近战",
							partyTargetNumber = 0,
							uuid = "de1d47d9-f2da-91a2-a764-37e6aed0d05f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.addsDeadCrystalCount < 4",
							dequeueIfLuaFalse = true,
							name = "仍有光水晶存活",
							uuid = "61b80036-ed22-a3ff-8815-327316467fce",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"efe4c934-5682-1199-90ba-1e5f2d3a9774",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							filterTargetType = "ContentID",
							name = "7米内最近光水晶",
							partyTargetContentID = 13555,
							uuid = "0e37c596-fb28-9784-a548-2ff2a402c1fe",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"3da1b64c-9075-7e87-9fdc-1e8e995108bf",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							filterTargetSubtype = "Highest HP",
							filterTargetType = "ContentID",
							name = "21.5米内最高血量光水晶",
							partyTargetContentID = 13555,
							uuid = "f1ef926b-c846-985b-a025-c56468dcadf6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							name = "坦克职业",
							partyTargetType = "Tank",
							uuid = "7df6b3e2-d110-bc53-9ae2-1f0609fc9d48",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							name = "近战职业",
							partyTargetType = "Melee DPS",
							uuid = "a81c8af1-51b1-a664-ba9f-f8db619e5243",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							comparator = 2,
							conditionType = 4,
							inRangeValue = 7,
							name = "距离不超过7米",
							partyTargetType = "Detection Target",
							uuid = "efe4c934-5682-1199-90ba-1e5f2d3a9774",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							comparator = 2,
							conditionType = 4,
							inRangeValue = 21.5,
							name = "距离不超过21.5米",
							partyTargetType = "Detection Target",
							uuid = "3da1b64c-9075-7e87-9fdc-1e8e995108bf",
							version = 3,
						},
					},
				},
				displayPath = "目标选择",
				loop = true,
				mechanicTime = 418.8,
				name = "近战坦克选光水晶",
				throttleTime = 500,
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 60,
				timerStartOffset = 12,
				uuid = "8b7e326a-3dcb-25de-9411-f740b3b2b281",
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
									"102cc88e-44b7-9395-a3b7-06ddf3399ee8",
									true,
								},
								
								{
									"054c2b8c-a5d5-caab-86c0-cfb022d8be40",
									true,
								},
								
								{
									"e545298a-c5f6-7db4-9267-b0f8ee8f9d08",
									true,
								},
								
								{
									"1749c85b-38b3-4539-b91c-bc92fded91c1",
									false,
								},
							},
							endIfUsed = true,
							name = "选中最高血量光水晶",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "bbf1d3d3-a456-5dc6-aab6-4071fd3f09b4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"bcc5a086-96b2-658f-ad26-46ff4d573c0e",
									true,
								},
								
								{
									"97fda78f-9f77-b7a3-8524-476c4492b750",
									true,
								},
							},
							matchAnyBuff = true,
							name = "远程输出或治疗",
							partyTargetNumber = 0,
							uuid = "102cc88e-44b7-9395-a3b7-06ddf3399ee8",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							name = "远程输出职业",
							partyTargetType = "Ranged DPS",
							uuid = "bcc5a086-96b2-658f-ad26-46ff4d573c0e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.addsDeadCrystalCount < 4",
							dequeueIfLuaFalse = true,
							name = "仍有光水晶存活",
							uuid = "054c2b8c-a5d5-caab-86c0-cfb022d8be40",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							name = "治疗职业",
							partyTargetType = "Healer",
							uuid = "97fda78f-9f77-b7a3-8524-476c4492b750",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"c9e571f2-5df1-5132-92e1-3483b9cf1eec",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							filterTargetSubtype = "Highest HP",
							filterTargetType = "ContentID",
							name = "26.5米内最高血量光水晶",
							partyTargetContentID = 13555,
							uuid = "e545298a-c5f6-7db4-9267-b0f8ee8f9d08",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							comparator = 2,
							conditionType = 4,
							inRangeValue = 26.5,
							name = "距离不超过26.5米",
							partyTargetType = "Detection Target",
							uuid = "c9e571f2-5df1-5132-92e1-3483b9cf1eec",
							version = 3,
						},
					},
					
					{
						data = 
						{
							conditionType = 3,
							hpValue = 0.0099999997764826,
							name = "当前目标存活",
							uuid = "1749c85b-38b3-4539-b91c-bc92fded91c1",
							version = 3,
						},
					},
				},
				displayPath = "目标选择",
				loop = true,
				mechanicTime = 418.8,
				name = "远程治疗选光水晶",
				throttleTime = 2000,
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 60,
				timerStartOffset = 10,
				uuid = "05563e75-a2ba-a176-b18a-91403bfa8411",
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
									"f7165b11-7b63-a4fa-a585-2107a5e21240",
									true,
								},
							},
							name = "选中永久冰晶",
							setTarget = true,
							targetContentID = 9358,
							targetType = "ContentID",
							uuid = "4900c751-003e-fa52-8309-067ed208aa02",
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
							conditionLua = "return data.addsDeadCrystalCount >= 4",
							name = "4个光水晶均已死亡",
							uuid = "f7165b11-7b63-a4fa-a585-2107a5e21240",
							version = 3,
						},
					},
				},
				displayPath = "目标选择",
				enabled = false,
				mechanicTime = 418.8,
				name = "冰晶选中(计数备用)",
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 40,
				timerStartOffset = 15,
				uuid = "34289014-55c4-ed7b-9b0a-8f0967ca02c8",
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
									"ce53770b-ad23-a3e9-b00e-6be117ffa28c",
									false,
								},
							},
							name = "选中永久冰晶",
							setTarget = true,
							targetContentID = 9358,
							targetType = "ContentID",
							uuid = "dc61fae2-08c3-91dc-ba97-12383ffaaebf",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"8f0e6869-b307-d706-b8ec-c05ae3eff036",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "存在存活光水晶",
							partyTargetContentID = 13555,
							uuid = "ce53770b-ad23-a3e9-b00e-6be117ffa28c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							conditionType = 2,
							hpValue = 0.0099999997764826,
							name = "目标存活",
							partyTargetType = "Detection Target",
							uuid = "8f0e6869-b307-d706-b8ec-c05ae3eff036",
							version = 3,
						},
					},
				},
				displayPath = "目标选择",
				mechanicTime = 418.8,
				name = "光水晶清空后选冰晶",
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 60,
				timerStartOffset = 15,
				uuid = "9e3ac107-5faa-e2a1-9956-edc055d1e317",
				version = 2,
			},
		},
	},
	[108] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "43f072ca-73ee-5a69-9dab-244e4aed4d06",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircle(9500, eventArgs.castPosX, 0.05, eventArgs.castPosZ, 4, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"969ffe2d-2986-5430-9cdd-1a9b01c1a4d7",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Record Puddle Info",
							uuid = "0b10c611-3e44-5d4c-a4d8-9ef961542bb7",
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
							eventSpellID = 40257,
							name = "Cast ID",
							uuid = "969ffe2d-2986-5430-9cdd-1a9b01c1a4d7",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				eventType = 2,
				loop = true,
				mechanicTime = 431.1,
				name = "严冬射线放圈",
				timeRange = true,
				timelineIndex = 108,
				timerEndOffset = 20,
				timerStartOffset = -5,
				uuid = "f0e97079-fc7a-54d2-a691-b6558d7e33ab",
				version = 2,
			},
		},
	},
	[117] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "f016a472-5812-55fd-b954-8ab5009f16da",
			},
			objectType = "folder",
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
							actionLua = "data.p2AddsDeadTime = Now()\ndata.p3JunctionTime = data.p2AddsDeadTime + 13289\nself.used = true",
							conditions = 
							{
								
								{
									"84c3376b-f78b-50a2-a31d-0fe8e2cd895f",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Set Death Time",
							uuid = "c488e632-b10c-5f7b-8b8d-3816abed4d08",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.a1 == 25 and eventArgs.a2 == 1 and eventArgs.a3 == 2",
							conditions = 
							{
								
								{
									"6f3ed9e6-605b-63d1-a8a1-58cf89355ce6",
									true,
								},
								
								{
									"d6aa7aaf-bd67-ddbd-badb-b268e54839c1",
									true,
								},
								
								{
									"5c5e37a2-a99f-d484-b0e0-e9d5f8b29568",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							name = "Valid Args",
							partyTargetNumber = 0,
							uuid = "84c3376b-f78b-50a2-a31d-0fe8e2cd895f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventIntValue = 25,
							name = "a1 等于 25",
							uuid = "6f3ed9e6-605b-63d1-a8a1-58cf89355ce6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 2,
							eventIntValue = 1,
							name = "a2 等于 1",
							uuid = "d6aa7aaf-bd67-ddbd-badb-b268e54839c1",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 3,
							eventIntValue = 2,
							name = "a3 等于 2",
							uuid = "5c5e37a2-a99f-d484-b0e0-e9d5f8b29568",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 14,
				mechanicTime = 453.2,
				name = "记录水晶阶段结束",
				timeRange = true,
				timelineIndex = 117,
				timerEndOffset = 50,
				timerStartOffset = -30,
				uuid = "bae089c2-3d8b-55ab-826e-8be614071e36",
				version = 2,
			},
		},
	},
	[120] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "9d746b9f-942f-52a1-8f2e-ebbc60375a06",
			},
			objectType = "folder",
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
							actionLua = "if (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							uuid = "e0cf84df-c305-56e9-8bf4-99077d3ad7e3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 514,
				name = "记录场地中心",
				timelineIndex = 120,
				timerOffset = -2,
				uuid = "57dfbbb9-60c4-51d9-90d7-77f8372c7d5d",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- Roster-based FRU priority setup (Party Roster framework, issue #46).\n-- Ranks derive from the roster's conga order (T1 T2 H1 H2 M1 M2 R1 R2):\n-- supports rank T1>T2>H1>H2, DPS rank M1>M2>R1>R2, absolute rank 1..8 --\n-- identical to the legacy default TTHHMMRC priority list. Water swap and\n-- Darklit keep consuming the same derived tables (lower rank = higher prio).\nlocal LOG_PREFIX = \"[Priority Setup] \"\n\nlocal Roster = MuAiGuide.Reactions.Roster\nif (Roster == nil or Roster.current == nil or Roster.current() == nil) then\n    MuAiGuide.Reactions.log(LOG_PREFIX .. \"No Party Roster resolved! Failure state.\", 5)\n    self.used = true\n    return\nend\n\nlocal prio = Roster.prio(\"conga\")\nif (#prio.byRank ~= 8) then\n    MuAiGuide.Reactions.log(LOG_PREFIX .. \"Roster resolved \" .. tostring(#prio.byRank) .. \"/8 members! Failure state.\", 5)\n    self.used = true\n    return\nend\n\nlocal supports = Roster.order(\"supports\")\nlocal dps = Roster.order(\"dps\")\nif (#supports ~= 4 or #dps ~= 4) then\n    MuAiGuide.Reactions.log(LOG_PREFIX .. \"Support/DPS split was not 4/4! Failure state.\", 5)\n    self.used = true\n    return\nend\n\n---@type table<integer, 1|2|3|4>\ndata.supportPriority = {}\n---@type table<integer, 1|2|3|4>\ndata.dpsPriority = {}\nlocal priorityDictionary = {}\n\nfor i = 1, 4 do\n    data.supportPriority[supports[i].id] = i\n    data.dpsPriority[dps[i].id] = i\nend\nfor rank = 1, 8 do\n    priorityDictionary[prio.byRank[rank]] = rank\nend\n\ndata.priorityDictionary = priorityDictionary\ndata.hasSetupPriority = true\n\nMuAiGuide.Reactions.log(LOG_PREFIX .. \"Priorities derived from the Party Roster (conga order).\", 5)\nself.used = true\n",
							conditions = 
							{
								
								{
									"592f1872-77e5-56a8-88ed-b2250a40ee76",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Set Priority Data",
							uuid = "b78a9d28-d185-5e06-aa08-7e21d30aec44",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Roster ~= nil and MuAiGuide.Reactions.Roster.current ~= nil and MuAiGuide.Reactions.Roster.current() ~= nil",
							name = "Priority List Exists",
							uuid = "592f1872-77e5-56a8-88ed-b2250a40ee76",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 514,
				name = "初始化优先级",
				timelineIndex = 120,
				timerOffset = -2,
				uuid = "9225ec98-5ad9-55ce-a74b-4af0372eecc2",
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
							actionLua = "local lbAction = ActionList:Get(5,3)\nreturn lbAction, eventArgs.detectionTargetID, true, true",
							conditions = 
							{
								
								{
									"fbfc8910-c6ae-593b-acb6-53bfb940be0e",
									true,
								},
								
								{
									"8c03bbce-496c-56b7-a625-00072b85d53b",
									true,
								},
								
								{
									"abc095cb-4449-56f1-a4ce-52685ee53644",
									true,
								},
								
								{
									"5820d2fb-b885-5c03-aa6b-9ba791cfac7d",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							luaReturnsAction = true,
							uuid = "53adb0fb-fe8e-570c-8fbd-0bad85cad38a",
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
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "Is Melee",
							partyTargetType = "Melee DPS",
							uuid = "fbfc8910-c6ae-593b-acb6-53bfb940be0e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruP3MeleeLimitBreak == true",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "8c03bbce-496c-56b7-a625-00072b85d53b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Boss Targetable",
							uuid = "abc095cb-4449-56f1-a4ce-52685ee53644",
							version = 3,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local currentLB, perBarLB = TensorCore.getLBGauge()\nreturn currentLB >= (perBarLB * 3)",
							name = "Has LB3",
							uuid = "5820d2fb-b885-5c03-aa6b-9ba791cfac7d",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 514,
				name = "近战即时极限技",
				timeRange = true,
				timelineIndex = 120,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "822ffa4f-dddf-5f41-a7e7-ac74ca450d57",
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
									"a1149ea4-b9fa-5022-812e-00f7807d7c70",
									true,
								},
								
								{
									"8dfc223a-a42b-5cce-945a-236d694de158",
									false,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							setTarget = true,
							targetType = "Enemy",
							uuid = "6213dab8-e9dc-5c18-841e-d6aa64f63ca4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Find Boss",
							uuid = "a1149ea4-b9fa-5022-812e-00f7807d7c70",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Current Target",
							name = "Target Filter",
							uuid = "8dfc223a-a42b-5cce-945a-236d694de158",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 514,
				name = "选中首领",
				timeRange = true,
				timelineIndex = 120,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "d83576f3-f458-5102-aeb8-96fb4c98483c",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\n---@class ApocDrawInfo\n---@field Pos1 ThreeDimensionalPos\n---@field Pos2 ThreeDimensionalPos\n---@field Rot 16|64\n---@field Explosions ExplosionInfo[]\n\n---@class ExplosionInfo\n---@field Len integer\n---@field XVal number[]\n---@field ZVal number[]\n\n---@type ApocDrawInfo[]\ndata.p3ApocDrawInfo = {\n    {\n        Rot = 64,\n        Pos1 = { x = 90.101, y = 0, z = 109.899 },\n        Pos2 = { x = 109.899, y = 0, z = 90.101 },\n        Explosions = {\n            {\n                Len = 4,\n                XVal = { 90.101, 100, 100, 109.899 },\n                ZVal = { 109.899, 100, 100, 90.101 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 100, 100, 100, 100, 109.899 },\n                ZVal = { 109.899, 86, 100, 100, 114, 90.101 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 90.101, 100, 100, 109.899, 109.899 },\n                ZVal = { 90.101, 109.899, 86, 114, 90.101, 109.899 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 90.101, 86, 114, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 90.101, 109.899, 109.899, 114 },\n                ZVal = { 100, 90.101, 109.899, 90.101, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 109.899, 86, 114, 90.101, 100 },\n            },\n        }\n    },\n    {\n        Rot = 16,\n        Pos1 = { x = 90.101, y = 0, z = 109.899 },\n        Pos2 = { x = 109.899, y = 0, z = 90.101 },\n        Explosions = {\n            {\n                Len = 4,\n                XVal = { 90.101, 100, 100, 109.899 },\n                ZVal = { 109.899, 100, 100, 90.101 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 109.899, 100, 100, 90.101, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 90.101, 109.899, 109.899, 114 },\n                ZVal = { 100, 90.101, 109.899, 90.101, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 90.101, 86, 114, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 90.101, 100, 100, 109.899, 109.899 },\n                ZVal = { 90.101, 109.899, 86, 114, 90.101, 109.899 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 109.899, 86, 114, 90.101, 100 },\n            },\n        }\n    },\n    {\n        Rot = 64,\n        Pos1 = { x = 100, y = 0, z = 114 },\n        Pos2 = { x = 100, y = 0, z = 86 },\n        Explosions = {\n            {\n                Len = 4,\n                XVal = { 100, 100, 100, 100 },\n                ZVal = { 86, 100, 100, 114 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 100, 100, 100, 100, 109.899 },\n                ZVal = { 90.101, 86, 100, 100, 114, 109.899 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 90.101, 86, 114, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 90.101, 109.899, 109.899, 114 },\n                ZVal = { 100, 90.101, 109.899, 90.101, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 109.899, 86, 114, 90.101, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 90.101, 100, 100, 109.899, 109.899 },\n                ZVal = { 90.101, 109.899, 86, 114, 90.101, 109.899 },\n            },\n        }\n    },\n    {\n        Rot = 16,\n        Pos1 = { x = 100, y = 0, z = 114 },\n        Pos2 = { x = 100, y = 0, z = 86 },\n        Explosions = {\n            {\n                Len = 4,\n                XVal = { 100, 100, 100, 100 },\n                ZVal = { 86, 100, 100, 114 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 100, 100, 100, 100, 109.899 },\n                ZVal = { 109.899, 86, 100, 100, 114, 90.101 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 109.899, 86, 114, 90.101, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 90.101, 109.899, 109.899, 114 },\n                ZVal = { 100, 90.101, 109.899, 90.101, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 90.101, 86, 114, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 90.101, 100, 100, 109.899, 109.899 },\n                ZVal = { 90.101, 109.899, 86, 114, 90.101, 109.899 },\n            },\n        }\n    },\n    {\n        Rot = 64,\n        Pos1 = { x = 109.899, y = 0, z = 109.899 },\n        Pos2 = { x = 90.101, y = 0, z = 90.101 },\n        Explosions = {\n            {\n                Len = 4,\n                XVal = { 90.101, 100, 100, 109.899 },\n                ZVal = { 90.101, 100, 100, 109.899 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 90.101, 100, 100, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 90.101, 109.899, 109.899, 114 },\n                ZVal = { 100, 90.101, 109.899, 90.101, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 109.899, 86, 114, 90.101, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 90.101, 100, 100, 109.899, 109.899 },\n                ZVal = { 90.101, 109.899, 86, 114, 90.101, 109.899 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 90.101, 86, 114, 109.899, 100 },\n            },\n        }\n    },\n    {\n        Rot = 16,\n        Pos1 = { x = 109.899, y = 0, z = 109.899 },\n        Pos2 = { x = 90.101, y = 0, z = 90.101 },\n        Explosions = {\n            {\n                Len = 4,\n                XVal = { 90.101, 100, 100, 109.899 },\n                ZVal = { 90.101, 100, 100, 109.899 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 100, 100, 100, 100, 109.899 },\n                ZVal = { 90.101, 86, 100, 100, 114, 109.899 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 90.101, 100, 100, 109.899, 109.899 },\n                ZVal = { 90.101, 109.899, 86, 114, 90.101, 109.899 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 109.899, 86, 114, 90.101, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 90.101, 109.899, 109.899, 114 },\n                ZVal = { 100, 90.101, 109.899, 90.101, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 90.101, 86, 114, 109.899, 100 },\n            },\n        }\n    },\n    {\n        Rot = 64,\n        Pos1 = { x = 114, y = 0, z = 100 },\n        Pos2 = { x = 86, y = 0, z = 100 },\n        Explosions = {\n            {\n                Len = 4,\n                XVal = { 86, 100, 100, 114 },\n                ZVal = { 100, 100, 100, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 109.899, 100, 100, 90.101, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 109.899, 86, 114, 90.101, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 90.101, 100, 100, 109.899, 109.899 },\n                ZVal = { 90.101, 109.899, 86, 114, 90.101, 109.899 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 90.101, 86, 114, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 90.101, 109.899, 109.899, 114 },\n                ZVal = { 100, 90.101, 109.899, 90.101, 109.899, 100 },\n            },\n        }\n    },\n    {\n        Rot = 16,\n        Pos1 = { x = 114, y = 0, z = 100 },\n        Pos2 = { x = 86, y = 0, z = 100 },\n        Explosions = {\n            {\n                Len = 4,\n                XVal = { 86, 100, 100, 114 },\n                ZVal = { 100, 100, 100, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 90.101, 100, 100, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 90.101, 86, 114, 109.899, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 90.101, 90.101, 100, 100, 109.899, 109.899 },\n                ZVal = { 90.101, 109.899, 86, 114, 90.101, 109.899 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 100, 100, 109.899, 114 },\n                ZVal = { 100, 109.899, 86, 114, 90.101, 100 },\n            },\n            {\n                Len = 6,\n                XVal = { 86, 90.101, 90.101, 109.899, 109.899, 114 },\n                ZVal = { 100, 90.101, 109.899, 90.101, 109.899, 100 },\n            },\n        }\n    },\n}\n\n---@type integer[]\ndata.p3ApocTimeInfo = {\n    11151,\n    13167,\n    15167,\n    17179,\n    19179,\n    21196,\n}\n\n---@param pos1 ThreeDimensionalPos\n---@param pos2 ThreeDimensionalPos\n---@param rotValue 16|64\n---@return ApocDrawInfo?\ndata.p3FindCorrectApocPattern = function (pos1, pos2, rotValue)\n    local apocInfoArray = data.p3ApocDrawInfo\n    local getDist = TensorCore.getDistance2d\n    for i = 1, 8 do\n        local apocInfo = apocInfoArray[i]\n        if (rotValue == apocInfo.Rot) then\n            local apocPos1 = apocInfo.Pos1\n            local apocPos2 = apocInfo.Pos2\n            local sameDist1 = getDist(apocPos1, pos1)\n            if (sameDist1 < 1) then\n                local sameDist2 = getDist(apocPos2, pos2)\n                if (sameDist2 < 1) then return apocInfo end\n            end\n\n            local oppDist1 = getDist(apocPos1, pos2)\n            if (oppDist1 < 1) then\n                local oppDist2 = getDist(apocPos2, pos1)\n                if (oppDist2 < 1) then return apocInfo end\n            end\n        end\n    end\n\n    return nil\nend\n\n---@param apocInfo ApocDrawInfo\ndata.p3DrawApocPattern = function (apocInfo)\n    local fruMoogle1 = TensorCore.getMoogleDrawer()\n    local drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    local timeValues = data.p3ApocTimeInfo\n    local explosionArray = apocInfo.Explosions\n    for i = 1, 6 do\n        local drawTime = i == 1 and 9000 or 2000\n        local delayTime = timeValues[i] - drawTime\n        local explosions = explosionArray[i]\n        for j = 1, explosions.Len do\n            local x = explosions.XVal[j]\n            local z = explosions.ZVal[j]\n            drawer:addTimedCircle(drawTime, x, 0.05, z, 9, delayTime, false, nil, 256)\n        end\n    end\nend\n\nself.used = true",
							gVar = "ACR_RikuDRK3_CD",
							name = "Init Apoc Tables",
							uuid = "c02dcde3-e0d1-555d-bf3c-b3afc53261a2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 514,
				name = "初始化启示数据",
				timeRange = true,
				timelineIndex = 120,
				timerEndOffset = -1,
				timerOffset = -12,
				timerStartOffset = -10,
				uuid = "ec6e792e-1223-5c87-917c-9d1ca5137de9",
				version = 2,
			},
		},
	},
	[123] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "33c0814e-f778-5ed8-b507-aa619604260b",
			},
			objectType = "folder",
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
							actionLua = "if (data.p3URDarkTethers == nil) then\n    data.p3URDarkTethers = {}\nend\n\nif (data.p3URTetherCount == nil) then\n    data.p3URTetherCount = 1\nelse\n    data.p3URTetherCount = data.p3URTetherCount + 1\nend\n\ntable.insert(data.p3URDarkTethers, eventArgs.sourceEntityID)\nself.used = true",
							conditions = 
							{
								
								{
									"dd157469-380e-547d-afff-c5811b759305",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Dark Tether",
							uuid = "657fbc80-2870-591e-94fe-5c3f0343c178",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nif (data.p3URYellowTethers == nil) then\n    data.p3URYellowTethers = {}\nend\n\nif (data.p3URTetherCount == nil) then\n    data.p3URTetherCount = 1\nelse\n    data.p3URTetherCount = data.p3URTetherCount + 1\nend\n\ntable.insert(data.p3URYellowTethers, eventArgs.sourceEntityID)\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DEC8687, nil, 0x4DEC8687, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedRectOnEnt(36000, eventArgs.sourceEntityID, 5, 0.1, eventArgs.newTargetID, 0, false, false, nil, nil, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"9a267607-e72d-5e62-b2c4-f51152c65635",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Yellow Tether",
							uuid = "d940be52-6b55-5d9b-8b4d-0e3dd9f856a0",
							version = 2.1,
						},
						inheritedIndex = 2,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.newTetherID == 133",
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 133,
							name = "Dark Tether",
							uuid = "dd157469-380e-547d-afff-c5811b759305",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.newTetherID == 134",
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 134,
							name = "Yellow Tether",
							uuid = "9a267607-e72d-5e62-b2c4-f51152c65635",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 15,
				loop = true,
				mechanicTime = 532.4,
				name = "记录压缩连线",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 6,
				uuid = "3469d732-9f7f-579d-a993-3bdeeb7cf187",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\n\nlocal darkHourglassEnt = TensorCore.mGetEntity(data.p3URDarkTethers[1])\nif (darkHourglassEnt == nil) then\n    MuAiGuide.Reactions.log(\"[UR Helper] Dark Hourglass Entity ID returned nil!\", 5)\n    self.used = true\n    return\nend\n\nlocal darkH = TensorCore.getHeadingToTarget(data.arenaCenter, darkHourglassEnt.pos)\nlocal halfPi = math.pi / 2\n\nlocal soloYellowEnt\n\nfor i = 1, 3 do\n    local ent = TensorCore.mGetEntity(data.p3URYellowTethers[i])\n    if (ent == nil) then\n        MuAiGuide.Reactions.log(\"[UR Helper] Yellow Hourglass at index \" .. i .. \" returned nil!\", 5)\n    else\n        local yellowH = TensorCore.getHeadingToTarget(data.arenaCenter, ent.pos)\n        local deltaH = yellowH - darkH\n        local normalizedDiff = TensorCore.restoreHeading(deltaH)\n        if (math.abs(normalizedDiff + halfPi) <= 0.2 or math.abs(normalizedDiff - halfPi) <= 0.2) then\n            soloYellowEnt = ent\n            break\n        end\n    end\nend\n\nif (soloYellowEnt == nil) then\n    MuAiGuide.Reactions.log(\"[UR Helper] Couldn't find relative south yellow hourglass!\", 5)\n    self.used = true\n    return\nend\n\ndata.p3URHelperSoloYellowH = TensorCore.restoreHeading(TensorCore.getHeadingToTarget(data.arenaCenter, soloYellowEnt.pos))\nself.used = true",
							conditions = 
							{
								
								{
									"6f8a0508-f505-5349-9101-78b0e58c97e6",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Set Relative South",
							uuid = "c442f83d-7441-5e4a-8858-1744fafbf983",
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
							conditionLua = "return data.p3URTetherCount == 5",
							name = "Tether Count",
							uuid = "6f8a0508-f505-5349-9101-78b0e58c97e6",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 532.4,
				name = "定位单黄沙漏",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 6,
				timerStartOffset = 2,
				uuid = "d87df221-8270-5791-bf25-1e1008bd1323",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "0f26e5b3-215a-5509-88f9-3315ffbebbaf",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal playerID = TensorCore.mGetPlayer().id\nlocal fireID = 2455\nfor _, ent in pairs(party) do\n    if (ent.id ~= playerID and MuAiGuide.Reactions.dpsJobs[ent.job]) then\n        local fireInfo = TensorCore.getBuff(ent.id, fireID)\n        if (fireInfo ~= nil and fireInfo.duration < 15) then\n            local str\n            if (MuAiGuide.Reactions.meleeJobs[ent.job]) then\n                str = \"(M)\"\n            else\n                str = \"(R)\"\n            end\n            MuAiGuide.Reactions.addTimedWorldTextOnEnt(7500, \"Fire \" .. str, ent.id, 4043309055, true, 2, 1.5)\n            break\n        end\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"5ff634cb-27c8-54a3-a9e8-83d4322d877b",
									true,
								},
								
								{
									"ebc79d72-a000-5167-8d84-126b352e4ce1",
									true,
								},
								
								{
									"de40b492-725e-53b8-bbfb-622b70a88fbc",
									true,
								},
								
								{
									"5ba038eb-8682-5294-841d-e6b5f7a0bfa6",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Handle x2 DPS Short",
							uuid = "9a0fc638-1e69-5ae4-b20f-1c19260b82b2",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal playerID = TensorCore.mGetPlayer().id\nlocal fireID = 2455\nfor _, ent in pairs(party) do\n    if (ent.id ~= playerID and not MuAiGuide.Reactions.dpsJobs[ent.job]) then\n        local fireInfo = TensorCore.getBuff(ent.id, fireID)\n        if (fireInfo ~= nil and fireInfo.duration > 25) then\n            local str\n            if (MuAiGuide.Reactions.healJobs[ent.job]) then\n                str = \"(H)\"\n            else\n                str = \"(T)\"\n            end\n            MuAiGuide.Reactions.addTimedWorldTextOnEnt(12500, \"Fire \" .. str, ent.id, 4043309055, true, 2, 1.5)\n            break\n        end\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"5ff634cb-27c8-54a3-a9e8-83d4322d877b",
									true,
								},
								
								{
									"ebc79d72-a000-5167-8d84-126b352e4ce1",
									true,
								},
								
								{
									"de40b492-725e-53b8-bbfb-622b70a88fbc",
									false,
								},
								
								{
									"8e24dd49-2344-5bc6-a34d-0a4b1f7f548d",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Handle x2 Support Long",
							uuid = "2e589e06-50f0-5bc5-bc9a-18061b53b216",
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
								2455,
								2462,
							},
							category = "Party",
							matchAnyBuff = true,
							minTargetPercent = true,
							name = "Buffs Exist",
							partyTargetNumber = 100,
							partyTargetSubType = "Number",
							uuid = "5ff634cb-27c8-54a3-a9e8-83d4322d877b",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruP3URHelper == true",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "ebc79d72-a000-5167-8d84-126b352e4ce1",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "Is DPS",
							partyTargetType = "DPS",
							uuid = "de40b492-725e-53b8-bbfb-622b70a88fbc",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 15,
							buffID = 2455,
							category = "Self",
							comparator = 2,
							name = "Short Fire",
							uuid = "5ba038eb-8682-5294-841d-e6b5f7a0bfa6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 3,
							buffDuration = 25,
							buffID = 2455,
							category = "Self",
							name = "Long Fire",
							uuid = "8e24dd49-2344-5bc6-a34d-0a4b1f7f548d",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 532.4,
				name = "同组火点名提示",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 3,
				timerOffset = 3,
				timerStartOffset = -1,
				uuid = "db8ee158-7cc7-575a-bcf2-96fdae587ddb",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal stackDrawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nstackDrawer:setGradient(3, 0.15, 2)\nstackDrawer:setHeightOffset(0.05)\nlocal drawTime = 4000\n\nlocal fireID = 2455\nlocal iceID = 2462\nlocal stackID = 2454\n\nfor _, ent in pairs(party) do\n    local entID = ent.id\n    local fireBuff = TensorCore.getBuff(entID, fireID)\n    local isFire = fireBuff ~= nil\n    local iceBuff = TensorCore.getBuff(entID, iceID)\n    local isIce = iceBuff ~= nil\n    local stackBuff = TensorCore.getBuff(entID, stackID)\n    local isStack = stackBuff ~= nil\n\n    if (isFire) then\n        local delay = (fireBuff.duration * 1000) - drawTime\n        drawer:addTimedCircleOnEnt(drawTime, entID, 8, delay, false, nil, 256)\n    end\n    if (isIce) then\n        local delay = (iceBuff.duration * 1000) - drawTime\n        drawer:addTimedDonutOnEnt(drawTime, entID, 3, 12, delay, false, nil, 256)\n    end\n    if (isStack) then\n        local delay = (stackBuff.duration * 1000) - drawTime\n        stackDrawer:addTimedCircleOnEnt(drawTime, entID, 6, delay, false, nil, 256)\n    end\n\n    if (not isFire and not isIce and not isStack) then\n        MuAiGuide.Reactions.log(\"[UR Draws] \" .. ent.name .. \" had no relevant debuffs to draw!\", 5)\n    end\nend\n\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Queue Debuff Draws",
							uuid = "626cfb5b-879a-590d-90e7-83d159096b5c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 532.4,
				name = "时间压缩点名范围",
				timelineIndex = 123,
				timerEndOffset = 6,
				timerOffset = 3,
				timerStartOffset = 2,
				uuid = "824a9929-c9fc-5042-80ad-ddcc382d3f79",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif (data.arenaCenter == nil) then\n    data.arenaCenter = { x = 100, y = 0, z = 100 }\nend\nlocal soloPos = TensorCore.getPosInDirection(data.arenaCenter, data.p3URHelperSoloYellowH, 10)\nsoloPos.y = 2.5\nMuAiGuide.Reactions.addTimedWorldText(36000, \"Solo\", soloPos, 4294967295, true, 3.25)\nself.used = true",
							conditions = 
							{
								
								{
									"81184794-b87c-587c-8088-5427d478a29f",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "WorldText Solo Yellow",
							uuid = "c442f83d-7441-5e4a-8858-1744fafbf983",
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
							conditionLua = "return data.p3URHelperSoloYellowH ~= nil",
							name = "Solo Yellow Found",
							uuid = "81184794-b87c-587c-8088-5427d478a29f",
							version = 3,
						},
						inheritedIndex = 1,
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 532.4,
				name = "单黄沙漏提示",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 6,
				timerStartOffset = 2,
				uuid = "69d3a493-82ce-5680-93ca-3120a63108fb",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fireID = 2455\nlocal iceID = 2462\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = player.id\nlocal fireBuff = TensorCore.getBuff(playerID, fireID)\nlocal isFire = fireBuff ~= nil\nlocal isIce = TensorCore.hasBuff(playerID, iceID)\nlocal isDPS = MuAiGuide.Reactions.dpsJobs[player.job] == true\nlocal lengthType\n\nif (isIce) then\n    if (isDPS) then\n        lengthType = 2\n    else\n        lengthType = 0\n    end\nelseif (isFire) then\n    if (fireBuff.duration < 12) then\n        lengthType = 0\n    elseif (fireBuff.duration < 24) then\n        lengthType = 1\n    else\n        lengthType = 2\n    end\nend\n\nif (lengthType == nil) then\n    MuAiGuide.Reactions.log(\"[UR Helper Setup] Couldn't determine player buff type!\", 5)\n    self.used = true\n    return\nend\n\n---@type string[]\nlocal callArray\n---@type number[]\nlocal arrowHeadings\n---@type number[]\nlocal arrowLengths\n---@type string|nil\nlocal assignedRole = nil\n---@type boolean\nlocal isDoubleRole = false\n\nlocal pi = math.pi\nlocal halfPi = pi / 2\nlocal quarterPi = pi / 4\nlocal beamDistance = 8.1\nlocal fireDistance = 15\nlocal rewindDistance = 7.9\nlocal rewindMidDist = 0.15\nlocal relativeSouth = data.p3URHelperSoloYellowH\n\nif (isDPS) then\n    -- Handle DPS permutations.\n    if (lengthType == 0) then\n        -- Handle 10s DPS Fires.\n        callArray = {\n            \"Fire Out\",\n            \"Rewind Out (at traffic light)\",\n            \"Stack Mid\",\n            \"Bait Beam\",\n            \"Stack Mid\",\n            \"Wait\",\n        }\n        arrowHeadings = { relativeSouth + quarterPi, relativeSouth - quarterPi }\n        arrowLengths = {\n            fireDistance,\n            rewindDistance,\n            nil,\n            beamDistance,\n            nil,\n            nil,\n        }\n        assignedRole = \"Short DPS Fire\"\n        isDoubleRole = true\n    elseif (lengthType == 1) then\n        -- Handle 20s DPS Fire.\n        callArray = {\n            \"Stack Mid\",\n            \"Rewind Near Mid\",\n            \"Fire Out\",\n            \"Chill Mid\",\n            \"Stack Mid\",\n            \"Bait Beam\",\n        }\n        arrowHeadings = { relativeSouth + halfPi }\n        arrowLengths = {\n            nil,\n            rewindMidDist,\n            fireDistance,\n            nil,\n            nil,\n            beamDistance,\n        }\n        assignedRole = \"Medium DPS Fire\"\n    elseif (lengthType == 2) then\n        -- Handle 30s DPS, Fire or Ice.\n        callArray = {\n            \"Stack Mid\",\n            \"Bait Beam\",\n            \"Stack Mid\",\n            \"Rewind Near Mid\",\n            \"Fire Out\",\n            \"Wait\",\n        }\n        arrowHeadings = { relativeSouth }\n        arrowLengths = {\n            nil,\n            beamDistance,\n            nil,\n            rewindMidDist,\n            fireDistance,\n            nil,\n        }\n        if (isIce) then\n            -- DPS Ice only difference is turning dropping a fire out to stacking mid.\n            assignedRole = \"Long DPS Ice\"\n            callArray[5] = \"Stack Mid\"\n            arrowLengths[5] = nil\n        else\n            assignedRole = \"Long DPS Fire\"\n        end\n    end\nelse\n    -- Handle Support Permutations\n    if (lengthType == 0) then\n        -- Handle 10s Support, Fire or Ice.\n        callArray = {\n            \"Fire Out\",\n            \"Rewind Out (at traffic cone)\",\n            \"Stack Mid\",\n            \"Bait Beam\",\n            \"Stack Mid\",\n            \"Wait\",\n        }\n        arrowHeadings = { relativeSouth + pi }\n        arrowLengths = {\n            fireDistance,\n            rewindDistance,\n            nil,\n            beamDistance,\n            nil,\n            nil,\n        }\n        if (isIce) then\n            callArray[1] = \"Stack Mid\"\n            arrowLengths[1] = nil\n            assignedRole = \"Short Support Ice\"\n        else\n            assignedRole = \"Short Support Fire\"\n        end\n    elseif (lengthType == 1) then\n        -- Handle 20s Support Fire.\n        callArray = {\n            \"Stack Mid\",\n            \"Rewind Out (at traffic cone)\",\n            \"Fire Out\",\n            \"Chill Mid\",\n            \"Stack Mid\",\n            \"Bait Beam\",\n        }\n        arrowHeadings = { relativeSouth - halfPi }\n        arrowLengths = {\n            nil,\n            rewindDistance,\n            fireDistance,\n            nil,\n            nil,\n            beamDistance,\n        }\n        assignedRole = \"Medium Support Fire\"\n    elseif (lengthType == 2) then\n        -- Handle 30s Support Fires.\n        callArray = {\n            \"Stack Mid\",\n            \"Bait Beam\",\n            \"Stack Mid\",\n            \"Rewind Near Mid\",\n            \"Fire Out\",\n            \"Chill Mid\",\n        }\n        local relativeNorth = relativeSouth + pi\n        arrowHeadings = { relativeNorth - quarterPi, relativeNorth + quarterPi }\n        arrowLengths = {\n            nil,\n            beamDistance,\n            nil,\n            rewindMidDist,\n            fireDistance,\n            nil,\n        }\n        assignedRole = \"Long Support Fire\"\n        isDoubleRole = true\n    end\nend\n\nif (assignedRole == nil) then\n    MuAiGuide.Reactions.log(\"[UR Helper Setup] Player had no assigned role set! What went wrong?\", 5)\n    self.used = true\n    return\nend\n\nMuAiGuide.Reactions.log(\"[UR Helper Setup] Ran successfully. Player was assigned as \" .. assignedRole, 5)\n\ndata.p3URHelperArrowHeadings = arrowHeadings\ndata.p3URHelperShotcalls = callArray\ndata.p3URHelperArrowLengths = arrowLengths\ndata.p3URHelperCurrentStep = 0\ndata.p3URHelperDoubleRole = isDoubleRole\ndata.p3URHelperPerformNextStep = function()\n    local curStep = data.p3URHelperCurrentStep + 1\n    data.p3URHelperCurrentStep = curStep\n    local callString = data.p3URHelperShotcalls[curStep]\n    if (callString == nil) then\n        MuAiGuide.Reactions.log(\"[UR Helper] callString was nil for step \" .. curStep, 5)\n        return\n    end\n    MuAiGuide.Reactions.Shotcall(callString, true, 3)\n    local arrowLength = data.p3URHelperArrowLengths[curStep]\n    if (arrowLength == nil) then return end\n    local drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    drawer:addTimedArrow(3000, 100, 0.05, 100, data.p3URHelperArrowHeadings[1], arrowLength, 0.75, nil, nil, 0, false, 256)\n    if (data.p3URHelperArrowHeadings[2] ~= nil) then\n        drawer:addTimedArrow(3000, 100, 0.05, 100, data.p3URHelperArrowHeadings[2], arrowLength, 0.75, nil, nil, 0, false, 256)\n    end\nend\n\ndata.p3URHelperHasRun = true\nself.used = true",
							conditions = 
							{
								
								{
									"5033ec51-fbe8-5715-9458-2bdbf9bcfc23",
									true,
								},
								
								{
									"2139ec85-3138-5628-99cc-34d369ffe7db",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Run Setup",
							uuid = "1d75a94f-bbf6-5f5f-8006-eb38c37a31b9",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruP3URHelper == true",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "5033ec51-fbe8-5715-9458-2bdbf9bcfc23",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3URHelperSoloYellowH ~= nil",
							name = "Solo Yellow Found",
							uuid = "2139ec85-3138-5628-99cc-34d369ffe7db",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 532.4,
				name = "初始化压缩指路",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 6,
				timerStartOffset = 2,
				uuid = "32aabde5-5b27-5944-9a89-b68be8d76e0a",
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
							actionLua = "data.p3URHelperPerformNextStep()\nself.used = true",
							conditions = 
							{
								
								{
									"da08351a-b2cd-541b-a913-e950016418ae",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Run Next Step",
							uuid = "5fb9b1a2-75a4-5481-90bf-281216817cb0",
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
							conditionLua = "return data.p3URHelperHasRun == true",
							name = "Helper Ran",
							uuid = "da08351a-b2cd-541b-a913-e950016418ae",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 532.4,
				name = "推进压缩指路",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 6,
				timerStartOffset = 2,
				uuid = "88d46301-8421-5dbf-aa3a-b07f23e65b7c",
				version = 2,
			},
		},
	},
	[126] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "63d93362-cb27-525a-9740-1c3925543b08",
			},
			objectType = "folder",
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
							actionLua = "data.p3URHelperPerformNextStep()\nself.used = true",
							conditions = 
							{
								
								{
									"da08351a-b2cd-541b-a913-e950016418ae",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Run Next Step",
							uuid = "5fb9b1a2-75a4-5481-90bf-281216817cb0",
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
							conditionLua = "return data.p3URHelperHasRun == true",
							name = "Helper Ran",
							uuid = "da08351a-b2cd-541b-a913-e950016418ae",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 544.2,
				name = "推进压缩指路",
				timeRange = true,
				timelineIndex = 126,
				timerEndOffset = 1,
				uuid = "f8cbfb6f-f636-5802-b196-299da2b64400",
				version = 2,
			},
		},
	},
	[127] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "4c8cb860-8630-5495-af75-79732c2ca272",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif (data.p3URHourglassRotations == nil) then\n    ---@type RecordedRotationInfo[]\n    data.p3URHourglassRotations = {}\nend\n\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then\n    MuAiGuide.Reactions.log(\"[UR Hourglass Rotation] Entity ID \" .. eventArgs.entityID .. \" returned nil ent!\", 5)\n    self.used = true\n    return\nend\n\n---@class RecordedRotationInfo\n---@field pos ThreeDimensionalPos\n---@field rotation integer\n\n---@type ThreeDimensionalPos\nlocal pos = { x = ent.pos.x, y = 0, z = ent.pos.z }\nlocal rotInfo = { pos = pos, rotation = eventArgs.newActiveAura1 }\ntable.insert(data.p3URHourglassRotations, rotInfo)\nself.used = true",
							conditions = 
							{
								
								{
									"75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
									true,
								},
								
								{
									"23a07897-0433-5264-950f-2455327cf360",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Rotation",
							uuid = "6a5cc725-c871-524f-a6ef-67670c03e3e0",
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
							conditionLua = "return eventArgs.entityContentID == 9825",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 9825,
							name = "Valid ContentID",
							uuid = "75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.newActiveAura1 == 1233 or eventArgs.newActiveAura1 == 1032",
							conditions = 
							{
								
								{
									"9503622f-440e-469d-89a8-ab13ad451c67",
									true,
								},
								
								{
									"5747fc5f-c2f1-dcfb-9757-69d61299e6ac",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "Valid Aura",
							partyTargetNumber = 0,
							uuid = "23a07897-0433-5264-950f-2455327cf360",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1233,
							name = "newActiveAura1 等于 1233",
							uuid = "9503622f-440e-469d-89a8-ab13ad451c67",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1032,
							name = "newActiveAura1 等于 1032",
							uuid = "5747fc5f-c2f1-dcfb-9757-69d61299e6ac",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 25,
				loop = true,
				mechanicTime = 549.3,
				name = "记录沙漏转向",
				timeRange = true,
				timelineIndex = 127,
				timerStartOffset = -5,
				uuid = "da892a3e-a7f5-5048-8a13-ef867dd26dff",
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
							actionLua = "data.p3URHourglassRotations = nil\nself.used = true",
							gVar = "ACR_RikuWHM3_CD",
							name = "Reset Beam Info",
							uuid = "1c3753b3-9da4-58db-8542-4bcfc360b4b1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 549.3,
				name = "重置激光数据",
				timelineIndex = 127,
				timerOffset = 1,
				uuid = "0f86edc6-7bc8-5907-a6f7-5e4646d1c859",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "f0cd9090-ff33-5285-b396-93b239d7379e",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then\n    MuAiGuide.Reactions.log(\"[UR Hourglass Rotation] Entity ID \" .. eventArgs.entityID .. \" returned nil ent!\", 5)\n    self.used = true\n    return\nend\nif (data.arenaCenter == nil) then\n    data.arenaCenter = { x = 100, y = 0, z = 100 }\nend\n\nlocal h = TensorCore.getHeadingToTarget(data.arenaCenter, ent.pos)\nlocal adjustH = math.rad(65)\nif (eventArgs.newActiveAura1 == 1032) then\n    adjustH = -adjustH\nend\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedArrow(5000, ent.pos.x, 0.05, ent.pos.z, h + adjustH, 3, 0.25, nil, nil, 0, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
									true,
								},
								
								{
									"23a07897-0433-5264-950f-2455327cf360",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Bait Arrow",
							uuid = "6a5cc725-c871-524f-a6ef-67670c03e3e0",
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
							conditionLua = "return eventArgs.entityContentID == 9825",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 9825,
							name = "Valid ContentID",
							uuid = "75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.newActiveAura1 == 1233 or eventArgs.newActiveAura1 == 1032",
							conditions = 
							{
								
								{
									"6c929e89-6427-4966-8ee8-61c262b7f774",
									true,
								},
								
								{
									"a9c06e08-1ec7-e708-b263-68e7ec96c1e2",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "Valid Aura",
							partyTargetNumber = 0,
							uuid = "23a07897-0433-5264-950f-2455327cf360",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1233,
							name = "newActiveAura1 等于 1233",
							uuid = "6c929e89-6427-4966-8ee8-61c262b7f774",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1032,
							name = "newActiveAura1 等于 1032",
							uuid = "a9c06e08-1ec7-e708-b263-68e7ec96c1e2",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 25,
				loop = true,
				mechanicTime = 549.3,
				name = "激光诱导箭头",
				timeRange = true,
				timelineIndex = 127,
				timerStartOffset = -5,
				uuid = "7b63e512-5f17-538c-9c0f-5ba4dd125a2e",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal hourglassInfo = data.p3URHourglassRotations\nlocal partyIDs = data.partyIDArray\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal frameEntities\nfor hourglassIndex = 1, 3 do\n    local info = hourglassInfo[hourglassIndex]\n    if (info == nil) then break end -- Sometimes only two hourglasses are going at once.\n    if frameEntities == nil then\n        local scratch = data.StringFRU_MeltdownEntities\n        if scratch == nil then\n            scratch = {}\n            data.StringFRU_MeltdownEntities = scratch\n        end\n        for i = 1, 8 do\n            scratch[i] = TensorCore.mGetEntity(partyIDs[i])\n        end\n        frameEntities = scratch\n    end\n    ---@type ThreeDimensionalPos\n    local hourglassPos = info.pos\n    local bestDistance = 999\n    local bestID = nil\n    local bestPos = nil\n\n    for i = 1, 8 do\n        local ent = frameEntities[i]\n        if (ent ~= nil and ent.alive) then\n            local d = TensorCore.getDistance2d(ent.pos, hourglassPos)\n            if (d < bestDistance) then\n                bestDistance = d\n                bestID = partyIDs[i]\n                bestPos = ent.pos\n            end\n        end\n    end\n\n    if (bestID ~= nil) then\n        local h = TensorCore.getHeadingToTarget(hourglassPos, bestPos)\n        drawer:addRect(hourglassPos.x, 0.05, hourglassPos.z, 40, 5, h, false, 256)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"7576abdb-2c92-5853-a0cd-db0388b8f0a7",
									true,
								},
							},
							gVar = "ACR_RikuWHM3_CD",
							name = "Draw Meltdown Baits",
							uuid = "7099ec23-9444-500f-9c42-59949d4f4541",
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
							conditionLua = "return data.p3URHourglassRotations ~= nil",
							dequeueIfLuaFalse = true,
							name = "Hourglasses Recorded",
							uuid = "7576abdb-2c92-5853-a0cd-db0388b8f0a7",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				loop = true,
				mechanicTime = 549.3,
				name = "诱导激光范围",
				timeRange = true,
				timelineIndex = 127,
				timerStartOffset = -2.25,
				uuid = "2b1f922d-7df8-5d47-bf6c-6104b52a09fd",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nlocal entPos = ent.pos\nlocal recordedInfo = data.p3URHourglassRotations\nlocal closestRotation\nfor i = 1, 3 do\n    local info = recordedInfo[i]\n    if (info == nil) then break end\n    local d = TensorCore.getDistance2d(info.pos, entPos)\n    if (d < 3) then\n        closestRotation = info.rotation\n        break\n    end\nend\n\nif (closestRotation == nil) then\n    MuAiGuide.Reactions.log(\"[Draw Beam Rotations] Couldn't find closest rotation info for entity ID \" .. eventArgs.entityID, 5)\n    self.used = true\n    return\nend\n\nlocal angleIncrease = math.rad(15)\nif (closestRotation == 1233) then\n    angleIncrease = -angleIncrease\nend\n\nlocal drawTime = 2000\nlocal initH = eventArgs.heading + angleIncrease\nlocal x = entPos.x\nlocal z = entPos.z\n\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedRect(drawTime, x, 0.05, z, 40, 5, initH, nil, false, nil, 256)\nlocal baseMechTime = 2040\nlocal incrementTime = 1050\n\nfor i = 1, 8 do\n    local timeToMech = baseMechTime + (incrementTime * i)\n    local delayTime = timeToMech - drawTime\n    local h = initH + (angleIncrease * i)\n    drawer:addTimedRect(drawTime, x, 0.05, z, 40, 5, h, delayTime, false, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0c4d0110-5967-56ff-a4dd-1a3b849f8989",
									true,
								},
								
								{
									"9eee3cd5-4806-586f-9d45-d1ce352ffd49",
									true,
								},
							},
							gVar = "ACR_RikuWHM3_CD",
							name = "Queue Rotations",
							uuid = "1af54f95-5f52-5150-8d22-e3e90cb9f526",
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
							eventSpellID = 40235,
							name = "Cast ID",
							uuid = "0c4d0110-5967-56ff-a4dd-1a3b849f8989",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3URHourglassRotations ~= nil",
							dequeueIfLuaFalse = true,
							name = "Rotations Recorded",
							uuid = "9eee3cd5-4806-586f-9d45-d1ce352ffd49",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				loop = true,
				mechanicTime = 549.3,
				name = "沙漏旋转激光",
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "4a8576b5-9c3d-5260-b801-90eb6015f9ec",
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
							actionLua = "data.p3URHelperPerformNextStep()\nself.used = true",
							conditions = 
							{
								
								{
									"da08351a-b2cd-541b-a913-e950016418ae",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Run Next Step",
							uuid = "5fb9b1a2-75a4-5481-90bf-281216817cb0",
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
							conditionLua = "return data.p3URHelperHasRun == true",
							name = "Helper Ran",
							uuid = "da08351a-b2cd-541b-a913-e950016418ae",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 549.3,
				name = "推进压缩指路",
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 1,
				uuid = "3bf90abf-8afc-59e0-b59b-d5b8167c4bf0",
				version = 2,
			},
		},
	},
	[130] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "f41ceec2-e026-51fc-8b06-9a8b5ed87523",
			},
			objectType = "folder",
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
							actionLua = "data.p3URHelperPerformNextStep()\nself.used = true",
							conditions = 
							{
								
								{
									"da08351a-b2cd-541b-a913-e950016418ae",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Run Next Step",
							uuid = "5fb9b1a2-75a4-5481-90bf-281216817cb0",
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
							conditionLua = "return data.p3URHelperHasRun == true",
							name = "Helper Ran",
							uuid = "da08351a-b2cd-541b-a913-e950016418ae",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 554,
				name = "推进压缩指路",
				timeRange = true,
				timelineIndex = 130,
				timerEndOffset = 1,
				uuid = "8799cc5b-b407-56ab-80e6-ceaf1a284d83",
				version = 2,
			},
		},
	},
	[131] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "72126899-7331-5f4e-9374-4f0056203e64",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif (data.p3URHourglassRotations == nil) then\n    ---@type RecordedRotationInfo[]\n    data.p3URHourglassRotations = {}\nend\n\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then\n    MuAiGuide.Reactions.log(\"[UR Hourglass Rotation] Entity ID \" .. eventArgs.entityID .. \" returned nil ent!\", 5)\n    self.used = true\n    return\nend\n\n---@class RecordedRotationInfo\n---@field pos ThreeDimensionalPos\n---@field rotation integer\n\n---@type ThreeDimensionalPos\nlocal pos = { x = ent.pos.x, y = 0, z = ent.pos.z }\nlocal rotInfo = { pos = pos, rotation = eventArgs.newActiveAura1 }\ntable.insert(data.p3URHourglassRotations, rotInfo)\nself.used = true",
							conditions = 
							{
								
								{
									"75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
									true,
								},
								
								{
									"23a07897-0433-5264-950f-2455327cf360",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Rotation",
							uuid = "6a5cc725-c871-524f-a6ef-67670c03e3e0",
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
							conditionLua = "return eventArgs.entityContentID == 9825",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 9825,
							name = "Valid ContentID",
							uuid = "75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.newActiveAura1 == 1233 or eventArgs.newActiveAura1 == 1032",
							conditions = 
							{
								
								{
									"323d9759-232e-095f-b3cd-465d59e6d16f",
									true,
								},
								
								{
									"af40e0b3-4cc9-277d-9aac-0cfba9d064dc",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "Valid Aura",
							partyTargetNumber = 0,
							uuid = "23a07897-0433-5264-950f-2455327cf360",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1233,
							name = "newActiveAura1 等于 1233",
							uuid = "323d9759-232e-095f-b3cd-465d59e6d16f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1032,
							name = "newActiveAura1 等于 1032",
							uuid = "af40e0b3-4cc9-277d-9aac-0cfba9d064dc",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 25,
				loop = true,
				mechanicTime = 558.8,
				name = "记录沙漏转向",
				timeRange = true,
				timelineIndex = 131,
				timerStartOffset = -5,
				uuid = "95a49a66-53c4-529e-8174-f7f51e5e7923",
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
							actionLua = "data.p3URHourglassRotations = nil\nself.used = true",
							gVar = "ACR_RikuWHM3_CD",
							name = "Reset Beam Info",
							uuid = "1c3753b3-9da4-58db-8542-4bcfc360b4b1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 558.8,
				name = "重置激光数据",
				timelineIndex = 131,
				timerOffset = 1,
				uuid = "638cec40-6298-533c-b132-39ab60c610dd",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "5793396d-b800-5ae1-8c19-a88f22834ee3",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then\n    MuAiGuide.Reactions.log(\"[UR Hourglass Rotation] Entity ID \" .. eventArgs.entityID .. \" returned nil ent!\", 5)\n    self.used = true\n    return\nend\nif (data.arenaCenter == nil) then\n    data.arenaCenter = { x = 100, y = 0, z = 100 }\nend\n\nlocal h = TensorCore.getHeadingToTarget(data.arenaCenter, ent.pos)\nlocal adjustH = math.rad(65)\nif (eventArgs.newActiveAura1 == 1032) then\n    adjustH = -adjustH\nend\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedArrow(5000, ent.pos.x, 0.05, ent.pos.z, h + adjustH, 3, 0.25, nil, nil, 0, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
									true,
								},
								
								{
									"23a07897-0433-5264-950f-2455327cf360",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Bait Arrow",
							uuid = "6a5cc725-c871-524f-a6ef-67670c03e3e0",
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
							conditionLua = "return eventArgs.entityContentID == 9825",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 9825,
							name = "Valid ContentID",
							uuid = "75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.newActiveAura1 == 1233 or eventArgs.newActiveAura1 == 1032",
							conditions = 
							{
								
								{
									"31187ae0-6c89-8f8d-85d1-4f678a2817eb",
									true,
								},
								
								{
									"f237caca-7150-244f-aab0-3adbfd7b4d71",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "Valid Aura",
							partyTargetNumber = 0,
							uuid = "23a07897-0433-5264-950f-2455327cf360",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1233,
							name = "newActiveAura1 等于 1233",
							uuid = "31187ae0-6c89-8f8d-85d1-4f678a2817eb",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1032,
							name = "newActiveAura1 等于 1032",
							uuid = "f237caca-7150-244f-aab0-3adbfd7b4d71",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 25,
				loop = true,
				mechanicTime = 558.8,
				name = "激光诱导箭头",
				timeRange = true,
				timelineIndex = 131,
				timerStartOffset = -5,
				uuid = "f42f8dc9-8a0e-570d-836f-c7990f94a945",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal hourglassInfo = data.p3URHourglassRotations\nlocal partyIDs = data.partyIDArray\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal frameEntities\nfor hourglassIndex = 1, 3 do\n    local info = hourglassInfo[hourglassIndex]\n    if (info == nil) then break end -- Sometimes only two hourglasses are going at once.\n    if frameEntities == nil then\n        local scratch = data.StringFRU_MeltdownEntities\n        if scratch == nil then\n            scratch = {}\n            data.StringFRU_MeltdownEntities = scratch\n        end\n        for i = 1, 8 do\n            scratch[i] = TensorCore.mGetEntity(partyIDs[i])\n        end\n        frameEntities = scratch\n    end\n    ---@type ThreeDimensionalPos\n    local hourglassPos = info.pos\n    local bestDistance = 999\n    local bestID = nil\n    local bestPos = nil\n\n    for i = 1, 8 do\n        local ent = frameEntities[i]\n        if (ent ~= nil and ent.alive) then\n            local d = TensorCore.getDistance2d(ent.pos, hourglassPos)\n            if (d < bestDistance) then\n                bestDistance = d\n                bestID = partyIDs[i]\n                bestPos = ent.pos\n            end\n        end\n    end\n\n    if (bestID ~= nil) then\n        local h = TensorCore.getHeadingToTarget(hourglassPos, bestPos)\n        drawer:addRect(hourglassPos.x, 0.05, hourglassPos.z, 40, 5, h, false, 256)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"7576abdb-2c92-5853-a0cd-db0388b8f0a7",
									true,
								},
							},
							gVar = "ACR_RikuWHM3_CD",
							name = "Draw Meltdown Baits",
							uuid = "7099ec23-9444-500f-9c42-59949d4f4541",
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
							conditionLua = "return data.p3URHourglassRotations ~= nil",
							dequeueIfLuaFalse = true,
							name = "Hourglasses Recorded",
							uuid = "7576abdb-2c92-5853-a0cd-db0388b8f0a7",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				loop = true,
				mechanicTime = 558.8,
				name = "诱导激光范围",
				timeRange = true,
				timelineIndex = 131,
				timerStartOffset = -2.25,
				uuid = "218f2a12-d3fc-5405-bda1-026497f99aa3",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nlocal entPos = ent.pos\nlocal recordedInfo = data.p3URHourglassRotations\nlocal closestRotation\nfor i = 1, 3 do\n    local info = recordedInfo[i]\n    if (info == nil) then break end\n    local d = TensorCore.getDistance2d(info.pos, entPos)\n    if (d < 3) then\n        closestRotation = info.rotation\n        break\n    end\nend\n\nif (closestRotation == nil) then\n    MuAiGuide.Reactions.log(\"[Draw Beam Rotations] Couldn't find closest rotation info for entity ID \" .. eventArgs.entityID, 5)\n    self.used = true\n    return\nend\n\nlocal angleIncrease = math.rad(15)\nif (closestRotation == 1233) then\n    angleIncrease = -angleIncrease\nend\n\nlocal drawTime = 2000\nlocal initH = eventArgs.heading + angleIncrease\nlocal x = entPos.x\nlocal z = entPos.z\n\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedRect(drawTime, x, 0.05, z, 40, 5, initH, nil, false, nil, 256)\nlocal baseMechTime = 2040\nlocal incrementTime = 1050\n\nfor i = 1, 8 do\n    local timeToMech = baseMechTime + (incrementTime * i)\n    local delayTime = timeToMech - drawTime\n    local h = initH + (angleIncrease * i)\n    drawer:addTimedRect(drawTime, x, 0.05, z, 40, 5, h, delayTime, false, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0c4d0110-5967-56ff-a4dd-1a3b849f8989",
									true,
								},
								
								{
									"9eee3cd5-4806-586f-9d45-d1ce352ffd49",
									true,
								},
							},
							gVar = "ACR_RikuWHM3_CD",
							name = "Queue Rotations",
							uuid = "1af54f95-5f52-5150-8d22-e3e90cb9f526",
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
							eventSpellID = 40235,
							name = "Cast ID",
							uuid = "0c4d0110-5967-56ff-a4dd-1a3b849f8989",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3URHourglassRotations ~= nil",
							dequeueIfLuaFalse = true,
							name = "Rotations Recorded",
							uuid = "9eee3cd5-4806-586f-9d45-d1ce352ffd49",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				loop = true,
				mechanicTime = 558.8,
				name = "沙漏旋转激光",
				timeRange = true,
				timelineIndex = 131,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "1fb1de63-9601-5651-bfe7-6e92e4d09dc8",
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
							actionLua = "data.p3URHelperPerformNextStep()\nself.used = true",
							conditions = 
							{
								
								{
									"da08351a-b2cd-541b-a913-e950016418ae",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Run Next Step",
							uuid = "5fb9b1a2-75a4-5481-90bf-281216817cb0",
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
							conditionLua = "return data.p3URHelperHasRun == true",
							name = "Helper Ran",
							uuid = "da08351a-b2cd-541b-a913-e950016418ae",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 558.8,
				name = "推进压缩指路",
				timeRange = true,
				timelineIndex = 131,
				timerEndOffset = 1,
				uuid = "97b1c34e-8282-584f-b9ed-b7e212277f3c",
				version = 2,
			},
		},
	},
	[133] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "de8f1d03-7c30-50e0-8f66-a8feb25e2e3b",
			},
			objectType = "folder",
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
							actionLua = "data.p3URHelperPerformNextStep()\nself.used = true",
							conditions = 
							{
								
								{
									"da08351a-b2cd-541b-a913-e950016418ae",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Run Next Step",
							uuid = "5fb9b1a2-75a4-5481-90bf-281216817cb0",
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
							conditionLua = "return data.p3URHelperHasRun == true",
							name = "Helper Ran",
							uuid = "da08351a-b2cd-541b-a913-e950016418ae",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 563.6,
				name = "推进压缩指路",
				timeRange = true,
				timelineIndex = 133,
				timerEndOffset = 1,
				uuid = "59a39a2c-f90e-5065-b71d-65c500d9e70b",
				version = 2,
			},
		},
	},
	[134] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "62c2629b-0ae8-5769-9258-bf4829c2b128",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif (data.p3URHourglassRotations == nil) then\n    ---@type RecordedRotationInfo[]\n    data.p3URHourglassRotations = {}\nend\n\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then\n    MuAiGuide.Reactions.log(\"[UR Hourglass Rotation] Entity ID \" .. eventArgs.entityID .. \" returned nil ent!\", 5)\n    self.used = true\n    return\nend\n\n---@class RecordedRotationInfo\n---@field pos ThreeDimensionalPos\n---@field rotation integer\n\n---@type ThreeDimensionalPos\nlocal pos = { x = ent.pos.x, y = 0, z = ent.pos.z }\nlocal rotInfo = { pos = pos, rotation = eventArgs.newActiveAura1 }\ntable.insert(data.p3URHourglassRotations, rotInfo)\nself.used = true",
							conditions = 
							{
								
								{
									"75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
									true,
								},
								
								{
									"23a07897-0433-5264-950f-2455327cf360",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Rotation",
							uuid = "6a5cc725-c871-524f-a6ef-67670c03e3e0",
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
							conditionLua = "return eventArgs.entityContentID == 9825",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 9825,
							name = "Valid ContentID",
							uuid = "75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.newActiveAura1 == 1233 or eventArgs.newActiveAura1 == 1032",
							conditions = 
							{
								
								{
									"ea682771-3ea1-1b4b-b12a-d4c41439a6ae",
									true,
								},
								
								{
									"e787feca-4f6d-ea36-bbc1-d6e7a8e6f01d",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "Valid Aura",
							partyTargetNumber = 0,
							uuid = "23a07897-0433-5264-950f-2455327cf360",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1233,
							name = "newActiveAura1 等于 1233",
							uuid = "ea682771-3ea1-1b4b-b12a-d4c41439a6ae",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1032,
							name = "newActiveAura1 等于 1032",
							uuid = "e787feca-4f6d-ea36-bbc1-d6e7a8e6f01d",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 25,
				loop = true,
				mechanicTime = 569.3,
				name = "记录沙漏转向",
				timeRange = true,
				timelineIndex = 134,
				timerStartOffset = -5,
				uuid = "97e6e5b8-c6ee-55c3-908e-618f2a145fba",
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
							actionLua = "data.p3URHourglassRotations = nil\nself.used = true",
							gVar = "ACR_RikuWHM3_CD",
							name = "Reset Beam Info",
							uuid = "1c3753b3-9da4-58db-8542-4bcfc360b4b1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 569.3,
				name = "重置激光数据",
				timelineIndex = 134,
				timerOffset = 1,
				uuid = "d857fc17-1dee-5b19-b09a-9e3288b23741",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "0f24cd7b-3808-5e56-bd26-1e85251bc7f3",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif (ent == nil) then\n    MuAiGuide.Reactions.log(\"[UR Hourglass Rotation] Entity ID \" .. eventArgs.entityID .. \" returned nil ent!\", 5)\n    self.used = true\n    return\nend\nif (data.arenaCenter == nil) then\n    data.arenaCenter = { x = 100, y = 0, z = 100 }\nend\n\nlocal h = TensorCore.getHeadingToTarget(data.arenaCenter, ent.pos)\nlocal adjustH = math.rad(65)\nif (eventArgs.newActiveAura1 == 1032) then\n    adjustH = -adjustH\nend\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedArrow(5000, ent.pos.x, 0.05, ent.pos.z, h + adjustH, 3, 0.25, nil, nil, 0, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
									true,
								},
								
								{
									"23a07897-0433-5264-950f-2455327cf360",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Bait Arrow",
							uuid = "6a5cc725-c871-524f-a6ef-67670c03e3e0",
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
							conditionLua = "return eventArgs.entityContentID == 9825",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 9825,
							name = "Valid ContentID",
							uuid = "75b72545-fb95-5ad4-a9c1-ce8f539ee62d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.newActiveAura1 == 1233 or eventArgs.newActiveAura1 == 1032",
							conditions = 
							{
								
								{
									"726ecf9c-0c72-dd2e-9728-e059041b0958",
									true,
								},
								
								{
									"fc9eb5e1-f10f-94ad-8e34-ed969c87fefe",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "Valid Aura",
							partyTargetNumber = 0,
							uuid = "23a07897-0433-5264-950f-2455327cf360",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1233,
							name = "newActiveAura1 等于 1233",
							uuid = "726ecf9c-0c72-dd2e-9728-e059041b0958",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 6,
							eventIntValue = 1032,
							name = "newActiveAura1 等于 1032",
							uuid = "fc9eb5e1-f10f-94ad-8e34-ed969c87fefe",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 25,
				loop = true,
				mechanicTime = 569.3,
				name = "激光诱导箭头",
				timeRange = true,
				timelineIndex = 134,
				timerStartOffset = -5,
				uuid = "41a74c63-4536-5f8d-933b-a0b8d90efc5e",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal hourglassInfo = data.p3URHourglassRotations\nlocal partyIDs = data.partyIDArray\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal frameEntities\nfor hourglassIndex = 1, 3 do\n    local info = hourglassInfo[hourglassIndex]\n    if (info == nil) then break end -- Sometimes only two hourglasses are going at once.\n    if frameEntities == nil then\n        local scratch = data.StringFRU_MeltdownEntities\n        if scratch == nil then\n            scratch = {}\n            data.StringFRU_MeltdownEntities = scratch\n        end\n        for i = 1, 8 do\n            scratch[i] = TensorCore.mGetEntity(partyIDs[i])\n        end\n        frameEntities = scratch\n    end\n    ---@type ThreeDimensionalPos\n    local hourglassPos = info.pos\n    local bestDistance = 999\n    local bestID = nil\n    local bestPos = nil\n\n    for i = 1, 8 do\n        local ent = frameEntities[i]\n        if (ent ~= nil and ent.alive) then\n            local d = TensorCore.getDistance2d(ent.pos, hourglassPos)\n            if (d < bestDistance) then\n                bestDistance = d\n                bestID = partyIDs[i]\n                bestPos = ent.pos\n            end\n        end\n    end\n\n    if (bestID ~= nil) then\n        local h = TensorCore.getHeadingToTarget(hourglassPos, bestPos)\n        drawer:addRect(hourglassPos.x, 0.05, hourglassPos.z, 40, 5, h, false, 256)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"7576abdb-2c92-5853-a0cd-db0388b8f0a7",
									true,
								},
							},
							gVar = "ACR_RikuWHM3_CD",
							name = "Draw Meltdown Baits",
							uuid = "7099ec23-9444-500f-9c42-59949d4f4541",
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
							conditionLua = "return data.p3URHourglassRotations ~= nil",
							dequeueIfLuaFalse = true,
							name = "Hourglasses Recorded",
							uuid = "7576abdb-2c92-5853-a0cd-db0388b8f0a7",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				loop = true,
				mechanicTime = 569.3,
				name = "诱导激光范围",
				timeRange = true,
				timelineIndex = 134,
				timerStartOffset = -2.25,
				uuid = "7d76aad3-3a68-5a81-9056-912b72c2f82e",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nlocal entPos = ent.pos\nlocal recordedInfo = data.p3URHourglassRotations\nlocal closestRotation\nfor i = 1, 3 do\n    local info = recordedInfo[i]\n    if (info == nil) then break end\n    local d = TensorCore.getDistance2d(info.pos, entPos)\n    if (d < 3) then\n        closestRotation = info.rotation\n        break\n    end\nend\n\nif (closestRotation == nil) then\n    MuAiGuide.Reactions.log(\"[Draw Beam Rotations] Couldn't find closest rotation info for entity ID \" .. eventArgs.entityID, 5)\n    self.used = true\n    return\nend\n\nlocal angleIncrease = math.rad(15)\nif (closestRotation == 1233) then\n    angleIncrease = -angleIncrease\nend\n\nlocal drawTime = 2000\nlocal initH = eventArgs.heading + angleIncrease\nlocal x = entPos.x\nlocal z = entPos.z\n\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedRect(drawTime, x, 0.05, z, 40, 5, initH, nil, false, nil, 256)\nlocal baseMechTime = 2040\nlocal incrementTime = 1050\n\nfor i = 1, 8 do\n    local timeToMech = baseMechTime + (incrementTime * i)\n    local delayTime = timeToMech - drawTime\n    local h = initH + (angleIncrease * i)\n    drawer:addTimedRect(drawTime, x, 0.05, z, 40, 5, h, delayTime, false, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0c4d0110-5967-56ff-a4dd-1a3b849f8989",
									true,
								},
								
								{
									"9eee3cd5-4806-586f-9d45-d1ce352ffd49",
									true,
								},
							},
							gVar = "ACR_RikuWHM3_CD",
							name = "Queue Rotations",
							uuid = "1af54f95-5f52-5150-8d22-e3e90cb9f526",
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
							eventSpellID = 40235,
							name = "Cast ID",
							uuid = "0c4d0110-5967-56ff-a4dd-1a3b849f8989",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3URHourglassRotations ~= nil",
							dequeueIfLuaFalse = true,
							name = "Rotations Recorded",
							uuid = "9eee3cd5-4806-586f-9d45-d1ce352ffd49",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				loop = true,
				mechanicTime = 569.3,
				name = "沙漏旋转激光",
				timeRange = true,
				timelineIndex = 134,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "9b7518a4-10e7-53ce-9632-2d8cd7af188f",
				version = 2,
			},
		},
	},
	[135] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "dc10170a-d295-5d96-be8e-b02eb7147f33",
			},
			objectType = "folder",
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
							actionLua = "local playerPos = TensorCore.mGetPlayer().pos\ndata.p3RewindPos = playerPos\nif (data.arenaCenter == nil) then data.arenaCenter = { x = 100, y = 0, z = 100 } end\ndata.p3RewindHeading = TensorCore.getHeadingToTarget(data.arenaCenter, playerPos)\nself.used = true",
							conditions = 
							{
								
								{
									"9bd282fe-736e-5a9e-b1fb-33633c088962",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDNC3_CD",
							name = "Set Rewind Spot",
							uuid = "51be74ac-a28f-5e0d-b188-2959a777729b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffDuration = 0.25,
							buffID = 2452,
							category = "Self",
							comparator = 2,
							name = "Has Return",
							uuid = "9bd282fe-736e-5a9e-b1fb-33633c088962",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 574.9,
				name = "记录回返位置",
				timeRange = true,
				timelineIndex = 135,
				timerEndOffset = -5,
				timerStartOffset = -35,
				uuid = "27da3114-86ce-5956-864b-611ea3c59515",
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
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(true)\nTensorCore.API.TensorACR.setLockFaceHeading(data.p3RewindHeading)\nself.used = true",
							conditions = 
							{
								
								{
									"baccb841-2a72-5509-9dfa-c6d8405f6bdc",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Enable Lockface",
							uuid = "feff9ea1-de3e-5a49-ad2a-4ed43f1bfa11",
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
							buffCheckType = 3,
							buffDuration = 2,
							buffID = 2452,
							category = "Self",
							comparator = 2,
							name = "Rewind Duration",
							uuid = "baccb841-2a72-5509-9dfa-c6d8405f6bdc",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 574.9,
				name = "开启锁定朝向",
				timeRange = true,
				timelineIndex = 135,
				timerEndOffset = -1,
				timerStartOffset = -5,
				uuid = "9097fc7f-309d-5ba2-be94-41a7e8ecaf98",
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
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(true)\nTensorCore.API.TensorACR.setHardLockFace(true)\nTensorCore.API.TensorACR.setLockFaceHeading(data.p3RewindHeading)\nself.used = true",
							conditions = 
							{
								
								{
									"7cb67de8-c7d1-5665-bd27-426e5944e267",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Force Lockface",
							uuid = "6ce26b84-5ce5-5a1c-8eb0-a5daa40f28a4",
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
							buffCheckType = 3,
							buffDuration = 0.5,
							buffID = 2452,
							category = "Self",
							comparator = 2,
							name = "Short Rewind Duration",
							uuid = "7cb67de8-c7d1-5665-bd27-426e5944e267",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 574.9,
				name = "保持锁定朝向",
				timeRange = true,
				timelineIndex = 135,
				timerEndOffset = -1,
				timerStartOffset = -5,
				uuid = "053f21e5-4aa9-5e89-a64a-2f9f061d9702",
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
							gVar = "ACR_RikuNIN3_CD",
							name = "Stop Lockface",
							uuid = "27caf3f6-154d-5b96-9451-a3744aeac229",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 574.9,
				name = "结束锁定朝向",
				timelineIndex = 135,
				timerEndOffset = 5,
				timerOffset = 0.5,
				timerStartOffset = 0.5,
				uuid = "d9b0dee2-baf2-525b-9dfb-99b6b0aa394e",
				version = 2,
			},
		},
	},
	[138] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "6998ad80-141c-5b3c-ad57-ecbc1e3e0c35",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Stack Middle\", true)\nself.used = true",
							gVar = "ACR_RikuDRG3_CD",
							uuid = "04800128-9716-56b0-a946-e232b0012e7d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 578.6,
				name = "分摊播报",
				timelineIndex = 138,
				timerOffset = -3,
				uuid = "bb8258cc-ef64-5146-80c0-139e23a7eee9",
				version = 2,
			},
		},
	},
	[142] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "1bdcbfd5-2fd0-562f-9af0-0a87c12a93bf",
			},
			objectType = "folder",
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
							actionLua = "self.used = true",
							conditions = 
							{
								
								{
									"7cf37c46-c6db-5880-a62c-7fb1a70b9084",
									true,
								},
								
								{
									"ce188fe9-e3cc-54d3-ab80-c496db9d5b65",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Throttle",
							uuid = "56c19fa9-e9f3-5b6d-8403-4d3a24e5a20e",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- Waters can appear on dead people, so we can't use grouplist func.\nlocal party = TensorCore.entityList(\"type=1\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal textTime = (651.2 - TensorReactions_CurrentTimer) * 1000\nlocal waterID = 2461\nlocal playerID = TensorCore.mGetPlayer().id\nlocal playerWater = TensorCore.getBuff(playerID, waterID)\nlocal playerDuration = 0\nif (playerWater ~= nil) then\n    playerDuration = playerWater.duration\nend\n\n---@param ent GameObject\n---@return boolean\nlocal function checkWater(ent)\n    if (ent.contentid ~= 0) then return false end\n    local entID = ent.id\n    if (entID == playerID) then return false end\n    local waterBuff = TensorCore.getBuff(entID, waterID)\n    local waterDuration = 0\n    if (waterBuff ~= nil) then\n        waterDuration = waterBuff.duration\n     end\n    local durDiff = math.abs(waterDuration - playerDuration)\n    if (durDiff > 3) then return false end\n    local jobID = ent.job\n    local roleString\n    if (MuAiGuide.Reactions.meleeJobs[jobID]) then\n        roleString = \"(M)\"\n    elseif (MuAiGuide.Reactions.rangedJobs[jobID]) then\n        roleString = \"(R)\"\n    elseif (MuAiGuide.Reactions.healJobs[jobID]) then\n        roleString = \"(H)\"\n    else\n        roleString = \"(T)\"\n    end\n    MuAiGuide.Reactions.addTimedWorldTextOnEnt(textTime, \"Water \" .. roleString, entID, 4176318006, true, 2, 1.5)\n    return true\nend\n\nfor _, ent in pairs(party) do\n    if (checkWater(ent)) then break end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"7cf37c46-c6db-5880-a62c-7fb1a70b9084",
									true,
								},
								
								{
									"ce188fe9-e3cc-54d3-ab80-c496db9d5b65",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDNC3_CD",
							name = "WorldText Other Water",
							uuid = "0455639c-5f3c-5f01-bb87-32a900a18e37",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 2461,
							category = "Party",
							name = "Waters Exist In Party",
							partyTargetNumber = 2,
							partyTargetSubType = "Number",
							uuid = "ce188fe9-e3cc-54d3-ab80-c496db9d5b65",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruApocWaterSwapLabel == 1",
							dequeueIfLuaFalse = true,
							name = "Check Settings",
							uuid = "7cf37c46-c6db-5880-a62c-7fb1a70b9084",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 612.6,
				name = "同类水点名提示",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 142,
				timerEndOffset = 3,
				timerStartOffset = 0.25,
				uuid = "a5c918af-c906-5147-ad85-769f5fbd9f0c",
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
							actionLua = "self.used = true",
							conditions = 
							{
								
								{
									"b3f6d22e-10da-52c3-98b6-0fe3221d88bb",
									true,
								},
								
								{
									"ce188fe9-e3cc-54d3-ab80-c496db9d5b65",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Throttle",
							uuid = "56c19fa9-e9f3-5b6d-8403-4d3a24e5a20e",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- revamp\nlocal waterID = 2461\nlocal playerID = MuAiGuide.Reactions.playerID()\nlocal playerWater = TensorCore.getBuff(playerID, waterID)\nlocal playerDuration = 0\nif (playerWater ~= nil) then\n    playerDuration = playerWater.duration\nend\n\nlocal party = MuAiGuide.Reactions.partyInfo()\nfor i=1, #party do\n    local ent = party[i]\n    local waterBuff = TensorCore.getBuff(ent.id, waterID)\n    local waterDuration = waterBuff and waterBuff.duration or 0\n    local roleString\n    if MuAiGuide.Reactions.isSupport(ent.job) then roleString = \"(S)\" end\n    if MuAiGuide.Reactions.isDPS(ent.job) then roleString = \"(D)\" end\n\n    local timer = 7000\n\n    local durDiff = math.abs(waterDuration - playerDuration)\n    if playerID ~= ent.id and durDiff < 3 then\n        timer = waterDuration * 1000\n    end\n\n    if waterBuff == nil or waterDuration == 0 then\n        MuAiGuide.Reactions.addTimedWorldTextOnEnt(timer, \"None \" .. roleString, ent.id, 4294244596, true, 2, 1)\n    elseif waterDuration <= 11 then\n        MuAiGuide.Reactions.addTimedWorldTextOnEnt(timer, \"1st \" .. roleString, ent.id, 4281130284, true, 2, 1)\n    elseif waterDuration <= 31 then\n        MuAiGuide.Reactions.addTimedWorldTextOnEnt(timer, \"2nd \" .. roleString, ent.id, 4281414112, true, 2, 1)\n    elseif waterDuration <= 41 then\n        MuAiGuide.Reactions.addTimedWorldTextOnEnt(timer, \"3rd \" .. roleString, ent.id, 4279758051, true, 2, 1)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"b3f6d22e-10da-52c3-98b6-0fe3221d88bb",
									true,
								},
								
								{
									"ce188fe9-e3cc-54d3-ab80-c496db9d5b65",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDNC3_CD",
							name = "WorldText All Waters",
							uuid = "0455639c-5f3c-5f01-bb87-32a900a18e37",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 2461,
							category = "Party",
							name = "Waters Exist In Party",
							partyTargetNumber = 2,
							partyTargetSubType = "Number",
							uuid = "ce188fe9-e3cc-54d3-ab80-c496db9d5b65",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruApocWaterSwapLabel == 2",
							dequeueIfLuaFalse = true,
							name = "Check Settings",
							uuid = "b3f6d22e-10da-52c3-98b6-0fe3221d88bb",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 612.6,
				name = "水点名分组提示",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 142,
				timerEndOffset = 3,
				timerStartOffset = 0.25,
				uuid = "62e4997d-878b-52f1-8bf5-d8643328b40a",
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
							actionLua = "self.used = true",
							conditions = 
							{
								
								{
									"24991982-31dd-502b-aeae-418523587bdc",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Throttle",
							uuid = "3a6bfbf8-36cb-5542-afb2-7833e5f8306a",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\n-- Waters can appear on dead people, so we can't use grouplist func.\nlocal party = TensorCore.entityList(\"type=1\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal playerID = TensorCore.mGetPlayer().id\nlocal drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal drawTime = 3500\n\nlocal waterID = 2461\nfor _, ent in pairs(party) do\n    if (ent.id ~= playerID) then\n        local waterBuff = TensorCore.getBuff(ent.id, waterID)\n        if (waterBuff ~= nil) then\n            local durationMs = waterBuff.duration * 1000\n            local delayTime = durationMs - drawTime\n            local oldDraw = durationMs > 15000 and durationMs < 33000\n            drawer:addTimedCircleOnEnt(drawTime, ent.id, 6, delayTime, false, nil, 256)\n        end\n    end\nend\n\nlocal playerWater = TensorCore.getBuff(playerID, waterID)\nif (playerWater ~= nil) then\n    local drawer2 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\n    drawer2:setGradient(3, 0.15, 2)\n    drawer2:setHeightOffset(0.05)\n    local durationMs = playerWater.duration * 1000\n    local delayTime = durationMs - drawTime\n    local oldDraw = durationMs > 15000 and durationMs < 33000\n    drawer2:addTimedCircleOnEnt(drawTime, playerID, 6, delayTime, false, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"24991982-31dd-502b-aeae-418523587bdc",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDNC3_CD",
							name = "Queue Water Draws",
							uuid = "58578f48-7f50-5103-b4af-60e453d04327",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 2461,
							category = "Party",
							name = "Waters Exist In Party",
							partyTargetNumber = 2,
							partyTargetSubType = "Number",
							uuid = "24991982-31dd-502b-aeae-418523587bdc",
							version = 3,
						},
						inheritedIndex = 1,
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 612.6,
				name = "启示水点名范围",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 142,
				timerEndOffset = 3,
				uuid = "333cc511-2ce6-561a-bcb4-ff55570f9b7a",
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
							actionLua = "self.used = true",
							conditions = 
							{
								
								{
									"f97cb4c3-cdf3-5348-a597-5663a00ac73b",
									true,
								},
								
								{
									"20272eba-b512-5b0a-8aab-e5c4ee211cd9",
									true,
								},
								
								{
									"6e8be910-ebc0-5583-908b-e1d45a0d1570",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Throttle",
							uuid = "0d01ac7c-1876-5cdb-b072-6a60f40376a1",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- Waters can appear on dead people, so we can't use grouplist func.\nlocal party = TensorCore.entityList(\"type=1\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal waterID = 2461\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = player.id\nlocal playerWater = TensorCore.getBuff(playerID, waterID)\nlocal playerDuration = 0\nif (playerWater ~= nil) then\n    playerDuration = playerWater.duration\nend\nlocal isPlayerDPS = MuAiGuide.Reactions.dpsJobs[player.job] == true\nlocal playerPriority\nif (isPlayerDPS) then\n    playerPriority = data.dpsPriority[playerID]\nelse\n    playerPriority = data.supportPriority[playerID]\nend\n\nif (playerPriority == nil) then\n    MuAiGuide.Reactions.log(\"[Water Swap] Player priority was nil!?\", 5)\n    self.used = true\n    return\nend\n\ndata.p3ApocSwapped = false\n---@param ent GameObject\n---@return boolean\nlocal function determineSwap(ent)\n    if (ent.contentid ~= 0) then return false end\n    local entID = ent.id\n\n    -- Ignore the player themselves, duh!\n    if (entID == playerID) then return false end\n\n    -- Get the entity's water buff.\n    local waterBuff = TensorCore.getBuff(entID, waterID)\n    local waterDuration = 0\n    if (waterBuff ~= nil) then\n        -- Assume no buff is duration 0, otherwise set to duration.\n        waterDuration = waterBuff.duration\n    end\n    local durDiff = math.abs(waterDuration - playerDuration)\n    -- We only want to look at the ent with the same duration as the player.\n    if (durDiff > 3) then return false end\n\n    local isDPS = MuAiGuide.Reactions.dpsJobs[ent.job] == true\n    -- If duration is the same, but our 'partner' is the opposite role, no swap necessary.\n    if (isDPS ~= isPlayerDPS) then\n        MuAiGuide.Reactions.Shotcall(\"Stay\", true)\n        return true\n    end\n\n    -- Otherwise, flex based on priority (lower integer value swaps)\n    local entPriority\n    if (isDPS) then\n        entPriority = data.dpsPriority[entID]\n    else\n        entPriority = data.supportPriority[entID]\n    end\n\n    if (entPriority == nil) then\n        MuAiGuide.Reactions.log(\"[Water Swap] Player's water partner priority returned nil!?\", 5)\n        return true\n    end\n\n    MuAiGuide.Reactions.log(string.format(\"[Water Swap] Player Priority is %d, partner priority is %d\", playerPriority, entPriority), 5)\n\n    if (playerPriority < entPriority) then\n        -- Swap if we have a lower numerical priority (higher on the list)\n        MuAiGuide.Reactions.Shotcall(\"Swap\", true)\n        data.p3ApocSwapped = true\n    else\n        MuAiGuide.Reactions.Shotcall(\"Stay\", true)\n    end\n    return true\nend\n\nfor _, ent in pairs(party) do\n    if (determineSwap(ent)) then break end\nend\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"f97cb4c3-cdf3-5348-a597-5663a00ac73b",
									true,
								},
								
								{
									"20272eba-b512-5b0a-8aab-e5c4ee211cd9",
									true,
								},
								
								{
									"6e8be910-ebc0-5583-908b-e1d45a0d1570",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "Determine Swap",
							uuid = "19d15311-32a6-514d-9943-6f4f77113fae",
							version = 2.1,
						},
						inheritedIndex = 2,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruApocWaterSwap == true",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "f97cb4c3-cdf3-5348-a597-5663a00ac73b",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							buffID = 2461,
							category = "Party",
							name = "Waters Exist In Party",
							partyTargetNumber = 2,
							partyTargetSubType = "Number",
							uuid = "20272eba-b512-5b0a-8aab-e5c4ee211cd9",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.hasSetupPriority == true",
							dequeueIfLuaFalse = true,
							name = "Priority Set",
							uuid = "6e8be910-ebc0-5583-908b-e1d45a0d1570",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 612.6,
				name = "确定水分摊换组",
				throttleTime = 500,
				timeRange = true,
				timelineIndex = 142,
				timerEndOffset = 3,
				timerStartOffset = 0.25,
				uuid = "cd317fa9-4b82-589e-b05f-e2642d7f8d14",
				version = 2,
			},
		},
	},
	[144] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "e159eb31-d110-5c34-ae90-abb18545165a",
			},
			objectType = "folder",
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
							actionLua = "data.p3ApocCount = 0\ndata.p3ApocBothRecorded = false\nself.used = true",
							gVar = "ACR_RikuDRK3_CD",
							uuid = "7078a992-afb9-5f11-a1f8-0f558484e8fa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 619.6,
				name = "初始化启示计数",
				timelineIndex = 144,
				timerOffset = -5,
				uuid = "0e14d998-4315-59ce-8726-036f05a9e20d",
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
							actionLua = "local curCount = data.p3ApocCount + 1\ndata.p3ApocCount = curCount\n\nif (curCount > 2) then\n    self.used = true\n    return\nend\n\nlocal entPos = TensorCore.mGetEntity(eventArgs.entityID).pos\n\n---@class ApocInfo\n---@field pos ThreeDimensionalPos\n---@field safeDir \"cw\"|\"ccw\"\n---@field rotValue 16|64\n\nif (data.p3Apoc1 == nil) then\n    ---@type ApocInfo\n    data.p3Apoc1 = {\n        pos = { x = entPos.x, y = 0, z = entPos.z },\n        safeDir = eventArgs.a3 == 16 and \"ccw\" or \"cw\",\n        rotValue = eventArgs.a3\n    }\nelseif (data.p3Apoc2 == nil) then\n    ---@type ApocInfo\n    data.p3Apoc2 = {\n        pos = { x = entPos.x, y = 0, z = entPos.z },\n        safeDir = eventArgs.a3 == 16 and \"ccw\" or \"cw\",\n        rotValue = eventArgs.a3\n    }\n    data.p3ApocBothRecorded = true\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"309d496a-09b2-5218-a079-59736b2fd4e7",
									true,
								},
								
								{
									"d8ebce35-303a-508d-b2b0-ba1052627a4b",
									true,
								},
								
								{
									"448f18f3-7823-5d1f-8db0-afacbd101450",
									true,
								},
								
								{
									"874ba835-8229-50e0-ac11-141bcf858f7c",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Record Init Apoc",
							uuid = "38c32a11-72a0-5aad-9735-7627ddd73891",
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
							conditionLua = "return eventArgs.entityContentID == 2011391",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 2011391,
							name = "Content ID",
							uuid = "309d496a-09b2-5218-a079-59736b2fd4e7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3ApocCount < 2",
							dequeueIfLuaFalse = true,
							name = "Count",
							uuid = "d8ebce35-303a-508d-b2b0-ba1052627a4b",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Filter",
							conditionLua = "return eventArgs.a3 == 16 or eventArgs.a3 == 64",
							conditions = 
							{
								
								{
									"125725ac-00f0-1bbb-9e51-fcc3ffe4d600",
									true,
								},
								
								{
									"9c5e7dc1-1841-964d-8ebc-ae132e73a2fd",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "Valid Rotation",
							partyTargetNumber = 0,
							uuid = "448f18f3-7823-5d1f-8db0-afacbd101450",
							version = 3,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.getDistance2d(data.arenaCenter, TensorCore.mGetEntity(eventArgs.entityID).pos) > 3",
							dequeueIfLuaFalse = true,
							name = "Not Mid",
							uuid = "874ba835-8229-50e0-ac11-141bcf858f7c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 3,
							eventIntValue = 16,
							name = "a3 等于 16",
							uuid = "125725ac-00f0-1bbb-9e51-fcc3ffe4d600",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							eventArgType = 3,
							eventIntValue = 64,
							name = "a3 等于 64",
							uuid = "9c5e7dc1-1841-964d-8ebc-ae132e73a2fd",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 19,
				loop = true,
				mechanicTime = 619.6,
				name = "记录启示起点",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 10,
				timerStartOffset = -5,
				uuid = "0e0ee85f-63fd-58d1-8b0c-8c38a4ae36bf",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "8e93122d-2b55-5be7-8cd0-b0f8143b4205",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal firstInfo = data.p3Apoc1\nlocal secondInfo = data.p3Apoc2\n\nlocal adjustment = math.rad(45)\nif (firstInfo.safeDir == \"cw\") then\n    adjustment = -adjustment\nend\n\nlocal heading1 = TensorCore.getHeadingToTarget(data.arenaCenter, firstInfo.pos)\nlocal heading2 = TensorCore.getHeadingToTarget(data.arenaCenter, secondInfo.pos)\n\nlocal nmHeading1 = TensorCore.convertHeading(heading1)\nlocal nmHeading2 = TensorCore.convertHeading(heading2)\nlocal north = math.pi\n\nlocal d1 = TensorCore.convertHeading(nmHeading1 - north)\nlocal d2 = TensorCore.convertHeading(nmHeading2 - north)\n\nlocal dpsPos, supportPos\nif (d1 < d2) then\n    dpsPos = secondInfo.pos\n    supportPos = firstInfo.pos\nelse\n    dpsPos = firstInfo.pos\n    supportPos = secondInfo.pos\nend\n\nlocal player = TensorCore.mGetPlayer()\nlocal isPlayerDPS = MuAiGuide.Reactions.dpsJobs[player.job] == true\nif MuAiGuide.Reactions.Settings.Reactions.fruApocPermaSwap and data.p3ApocSwapped == true then\n    isPlayerDPS = not isPlayerDPS\nend\n\nlocal h\nif (isPlayerDPS) then\n    h = TensorCore.getHeadingToTarget(data.arenaCenter, dpsPos)\nelse\n    h = TensorCore.getHeadingToTarget(data.arenaCenter, supportPos)\nend\n\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedArrow(8000, 100, 0.05, 100, h + adjustment, 14, 0.75, nil, nil, 2000, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"15d28744-0dee-58ff-8d6f-23be778d0030",
									true,
								},
								
								{
									"ce8c9c04-279b-57fc-ac37-42b6d7805b25",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Static Apoc",
							uuid = "98266ca7-b449-5b06-8fac-b6679106fa41",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruApocStrat == 1",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "15d28744-0dee-58ff-8d6f-23be778d0030",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3ApocCount == 2",
							name = "Apocs Recorded",
							uuid = "ce8c9c04-279b-57fc-ac37-42b6d7805b25",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 619.6,
				name = "启示固定指路",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 5,
				uuid = "40efbb18-00fc-56fc-816b-e17aaf4b6196",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nif (data.p3ApocDrawCount == nil) then data.p3ApocDrawCount = 0 end\ndata.p3ApocDrawCount = data.p3ApocDrawCount + 1\n\nlocal entPos = TensorCore.mGetEntity(eventArgs.entityID).pos\nif (data.p3ApocDrawCount <= 12) then\n\tlocal fruMoogle1 = TensorCore.getMoogleDrawer()\n\tlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\n\tfruMuai1:setGradient(3, 0.15, 2)\n\tfruMuai1:setHeightOffset(0.05)\n\tfruMuai1:addTimedCircle(9000, entPos.x, 0.05, entPos.z, 9, 2126, false, nil, 256)\nelse\n\tlocal fruMoogle2 = TensorCore.getMoogleDrawer()\n\tlocal fruMuai2 = TensorCore.getCachedDrawer((fruMoogle2.colorStart and fruMoogle2.colorStart % 0x1000000 + 0x4D000000), (fruMoogle2.colorMid and fruMoogle2.colorMid % 0x1000000 + 0x4D000000), (fruMoogle2.colorEnd and fruMoogle2.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\n\tfruMuai2:setGradient(3, 0.15, 2)\n\tfruMuai2:setHeightOffset(0.05)\n\tfruMuai2:addTimedCircle(2000, entPos.x, 0.05, entPos.z, 9, 9126, false, nil, 256)\nend\n\nif data.p3ApocDrawCount >= 29 and TensorCore.getDistance2d(entPos, data.arenaCenter) > 3 then\n\tlocal num = -45\n\tif eventArgs.a3 == 16 then num = 45 end\n\tlocal projectedPos = TensorCore.rotatePosAroundPos(data.arenaCenter, entPos, math.rad(num))\n\tlocal fruMoogle3 = TensorCore.getMoogleDrawer()\n\tlocal fruMuai3 = TensorCore.getCachedDrawer((fruMoogle3.colorStart and fruMoogle3.colorStart % 0x1000000 + 0x4D000000), (fruMoogle3.colorMid and fruMoogle3.colorMid % 0x1000000 + 0x4D000000), (fruMoogle3.colorEnd and fruMoogle3.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\n\tfruMuai3:setGradient(3, 0.15, 2)\n\tfruMuai3:setHeightOffset(0.05)\n\tfruMuai3:addTimedCircle(2000, projectedPos.x, 0.05, projectedPos.z, 9, 9126+2016, false, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"1ecc9a1b-e4c3-5fb8-97c4-f951471b1625",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							name = "Draw Explosion",
							uuid = "e7e52ed6-2fc4-5d4f-9fa5-0d3a4e0c366f",
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
							conditionLua = "return eventArgs.entityContentID == 2011391",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 2011391,
							name = "Content ID",
							uuid = "1ecc9a1b-e4c3-5fb8-97c4-f951471b1625",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				eventType = 19,
				loop = true,
				mechanicTime = 619.6,
				name = "启示地火预兆(旧版)",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 90,
				timerStartOffset = -10,
				uuid = "4126b8a3-1f6a-546e-9d0b-cd6273539ec1",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal firstInfo = data.p3Apoc1\nlocal secondInfo = data.p3Apoc2\n\nlocal adjustment = math.rad(45)\nif (firstInfo.safeDir == \"cw\") then\n    adjustment = -adjustment\nend\n\nlocal heading1 = TensorCore.getHeadingToTarget(data.arenaCenter, firstInfo.pos)\nlocal heading2 = TensorCore.getHeadingToTarget(data.arenaCenter, secondInfo.pos)\n\nlocal nmHeading1 = TensorCore.convertHeading(heading1 + adjustment)\nlocal nmHeading2 = TensorCore.convertHeading(heading2 + adjustment)\nlocal north = math.pi\n\nlocal d1 = TensorCore.convertHeading(nmHeading1 - north)\nlocal d2 = TensorCore.convertHeading(nmHeading2 - north)\n\nlocal dpsPos, supportPos\nif (d1 < d2) then\n    dpsPos = secondInfo.pos\n    supportPos = firstInfo.pos\nelse\n    dpsPos = firstInfo.pos\n    supportPos = secondInfo.pos\nend\n\nlocal player = TensorCore.mGetPlayer()\nlocal isPlayerDPS = MuAiGuide.Reactions.dpsJobs[player.job] == true\nif MuAiGuide.Reactions.Settings.Reactions.fruApocPermaSwap and data.p3ApocSwapped == true then\n    isPlayerDPS = not isPlayerDPS\nend\n\nlocal h\nif (isPlayerDPS) then\n    h = TensorCore.getHeadingToTarget(data.arenaCenter, dpsPos)\nelse\n    h = TensorCore.getHeadingToTarget(data.arenaCenter, supportPos)\nend\n\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedArrow(8000, 100, 0.05, 100, h + adjustment, 14, 0.75, nil, nil, 2000, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"0f239a2b-8893-57bb-9f20-cba432332dd0",
									true,
								},
								
								{
									"edc65520-38e0-5034-9ce5-f8d48a4c6921",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Color Apoc",
							uuid = "72d4308b-8a57-5de9-80de-5fd98974e8bc",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruApocStrat == 2",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "0f239a2b-8893-57bb-9f20-cba432332dd0",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3ApocCount == 2",
							name = "Apocs Recorded",
							uuid = "edc65520-38e0-5034-9ce5-f8d48a4c6921",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 619.6,
				name = "启示颜色指路",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 5,
				uuid = "e0d37241-8da6-5625-82c1-99f8b13c445d",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal firstInfo = data.p3Apoc1\nlocal secondInfo = data.p3Apoc2\n\nlocal heading1 = TensorCore.getHeadingToTarget(data.arenaCenter, firstInfo.pos)\nlocal heading2 = TensorCore.getHeadingToTarget(data.arenaCenter, secondInfo.pos)\n\nlocal adjustment = math.rad(45)\nif (firstInfo.safeDir == \"cw\") then\n    adjustment = -adjustment\nend\n\nlocal drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedArrow(8000, 100, 0.05, 100, heading1 + adjustment, 14, 0.75, nil, nil, 2000, false, 256)\ndrawer:addTimedArrow(8000, 100, 0.05, 100, heading2 + adjustment, 14, 0.75, nil, nil, 2000, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"13ee90d2-bf5a-56c7-bf26-9bae116b52c7",
									true,
								},
								
								{
									"a75928f1-49e8-5136-8290-7a242b2a8273",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Both Safe Dir",
							uuid = "34462c2a-68ad-558a-aed9-52bc1ccf8412",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruApocStrat == nil or MuAiGuide.Reactions.Settings.Reactions.fruApocStrat == 0",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "13ee90d2-bf5a-56c7-bf26-9bae116b52c7",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3ApocCount == 2",
							name = "Apocs Recorded",
							uuid = "a75928f1-49e8-5136-8290-7a242b2a8273",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 619.6,
				name = "启示双组指路",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 5,
				uuid = "cd2ba9b0-d090-5ea3-bf88-c5fd6f5ccad4",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal apoc1 = data.p3Apoc1\nlocal apoc2 = data.p3Apoc2\n\nlocal matchingApocTable = data.p3FindCorrectApocPattern(apoc1.pos, apoc2.pos, apoc1.rotValue)\nif (matchingApocTable == nil) then\n    local pos1Str = string.format(\"(%.3f, %.3f)\", apoc1.pos.x, apoc1.pos.z)\n    local pos2Str = string.format(\"(%.3f, %.3f)\", apoc2.pos.x, apoc2.pos.z)\n    local str = string.format(\"[Apoc Draw] Couldn't find matching draws for %s %s %d\", pos1Str, pos2Str, apoc1.rotValue)\n    MuAiGuide.Reactions.log(str, 5)\n    self.used = true\n    return\nend\n\ndata.p3DrawApocPattern(matchingApocTable)\nself.used = true",
							conditions = 
							{
								
								{
									"431b66da-2f20-5c27-bf4a-897f984bba6f",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_CD",
							name = "Queue Apoc Draws",
							uuid = "87239574-bb1f-5a11-a122-df27b2e65985",
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
							conditionLua = "return data.p3ApocBothRecorded == true",
							name = "Both Starting Recorded",
							uuid = "431b66da-2f20-5c27-bf4a-897f984bba6f",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 619.6,
				name = "启示地火预兆",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 5,
				timerStartOffset = -1,
				uuid = "4b9720b7-c9f5-5c73-a674-eb9b448295e3",
				version = 2,
			},
		},
	},
	[146] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "fab81e30-2032-577d-8217-4ac24812317d",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal timeToMech = 3450\nlocal drawTime = 2250\nlocal delayTime = timeToMech - drawTime\nlocal playerID = TensorCore.mGetPlayer().id\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nfor _, ent in pairs(party) do\n    if (ent.id ~= playerID) then\n        drawer:addTimedCircleOnEnt(drawTime, ent.id, 5, delayTime, false, nil, 256)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0c11f525-cbfa-51d0-aeaf-4aff55fdd91d",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Draw Spread",
							uuid = "31053f03-075e-562e-a818-2832bcbe3626",
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
							eventSpellID = 40288,
							name = "Channel ID",
							uuid = "0c11f525-cbfa-51d0-aeaf-4aff55fdd91d",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 624.7,
				name = "碎灵一击分散范围",
				timeRange = true,
				timelineIndex = 146,
				timerEndOffset = -1,
				timerStartOffset = -6,
				uuid = "dddfded1-cef7-50e4-a10f-338cbae893c4",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Spread\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"6e6f7e93-06d3-541a-94a9-70de36b11252",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Shotcall Spread",
							uuid = "031d1da0-0f8b-53cc-a63c-7891d40b293b",
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
							eventSpellID = 40271,
							name = "Water ID",
							uuid = "6e6f7e93-06d3-541a-94a9-70de36b11252",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 624.7,
				name = "分散播报",
				timeRange = true,
				timelineIndex = 146,
				timerStartOffset = -5,
				uuid = "a58da330-7fb0-544e-8f18-6c6ae364f6dc",
				version = 2,
			},
		},
	},
	[148] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "2b3dbeb6-f0b2-5563-a697-c79bbacb483a",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move In\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"f14ba209-2975-585b-b2e4-544665dcfa40",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRG3_CD",
							name = "Shotcall Move In",
							uuid = "92166915-05a5-5a66-be3a-42bb7087fec7",
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
							eventSpellID = 40297,
							name = "Apoc Cast ID",
							uuid = "f14ba209-2975-585b-b2e4-544665dcfa40",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 635.4,
				name = "靠近播报",
				timeRange = true,
				timelineIndex = 148,
				timerEndOffset = 1,
				timerStartOffset = -1,
				uuid = "a9beafc2-c9e6-5500-b65e-73bd385666e1",
				version = 2,
			},
		},
	},
	[149] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "8d25a9e3-74d9-593b-8b52-c9315ee07be9",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Swap Reminder\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"9751af30-d923-59a0-b81d-a5192c673f6d",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Swap Shotcall",
							uuid = "b4a14c66-3770-5f8f-a3fc-650c6149091f",
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
							conditionLua = "return data.p3ApocSwapped == true",
							dequeueIfLuaFalse = true,
							name = "Has Swapped",
							uuid = "9751af30-d923-59a0-b81d-a5192c673f6d",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 642.1,
				name = "水分摊换组提醒",
				timelineIndex = 149,
				timerOffset = -5,
				uuid = "2e4a2456-a37e-5da9-9a91-ec7362a99b54",
				version = 2,
			},
		},
	},
	[150] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "0e5ea010-db79-5cf4-850c-2698c78a1c0d",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"KB Left\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"fed4ab51-6d07-5a21-87f8-d6318520662f",
									true,
								},
								
								{
									"58854707-0718-5f63-b8a8-3edc2faaee9f",
									true,
								},
								
								{
									"ecea764f-9756-59f3-8a6c-21d2448a85f2",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "DPS Swap Left",
							uuid = "9287b9d9-2f37-5a67-b900-6c228bc38a8c",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"KB Right\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"fed4ab51-6d07-5a21-87f8-d6318520662f",
									false,
								},
								
								{
									"58854707-0718-5f63-b8a8-3edc2faaee9f",
									true,
								},
								
								{
									"ecea764f-9756-59f3-8a6c-21d2448a85f2",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "Support Swap Right",
							uuid = "bdeb6c9d-c46c-54d2-ad66-6d1348ec3239",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"KB Right\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"fed4ab51-6d07-5a21-87f8-d6318520662f",
									true,
								},
								
								{
									"58854707-0718-5f63-b8a8-3edc2faaee9f",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "DPS Default Right",
							uuid = "eccaef7b-5b82-53fc-8cf6-57e5119219fd",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"KB Left\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"fed4ab51-6d07-5a21-87f8-d6318520662f",
									false,
								},
								
								{
									"58854707-0718-5f63-b8a8-3edc2faaee9f",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "Support Default Left",
							uuid = "2b75dcc9-c460-510e-9757-276c55d836d7",
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
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "Is DPS",
							partyTargetType = "DPS",
							uuid = "fed4ab51-6d07-5a21-87f8-d6318520662f",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruApocWaterSwap == true",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "58854707-0718-5f63-b8a8-3edc2faaee9f",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3ApocSwapped == true",
							dequeueIfLuaFalse = true,
							name = "Has Swapped",
							uuid = "ecea764f-9756-59f3-8a6c-21d2448a85f2",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 644.3,
				name = "击退方向播报",
				timelineIndex = 150,
				timerOffset = -0.25,
				uuid = "636cb3f8-4f98-5323-bf88-47b0905ca0e9",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCircle(pos.x, 0.05, pos.z, 8, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"76cc44ca-9eff-5103-8e02-4050ec798eb0",
									true,
								},
								
								{
									"550e3ae0-23bb-5c93-a43d-2151cf90ccdf",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw DD On Farthest",
							uuid = "12d053d1-195f-5c47-93fe-cc4846c2966f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Get Boss",
							uuid = "76cc44ca-9eff-5103-8e02-4050ec798eb0",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Filter",
							conditionType = 4,
							filterTargetSubtype = "Furthest",
							filterTargetType = "Party",
							name = "Furthest From Prev",
							partyTargetType = "Detection Target",
							rangeCheckSourceType = "Detection Target",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "550e3ae0-23bb-5c93-a43d-2151cf90ccdf",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				loop = true,
				mechanicTime = 644.3,
				name = "暗夜舞蹈远距诱导",
				timeRange = true,
				timelineIndex = 150,
				timerStartOffset = -2.25,
				uuid = "2b25a70f-9c5f-558f-8408-73bd761f0d8a",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal firstInfo = data.p3Apoc1\nlocal secondInfo = data.p3Apoc2\n\nlocal heading1 = TensorCore.getHeadingToTarget(data.arenaCenter, firstInfo.pos)\nlocal heading2 = TensorCore.getHeadingToTarget(data.arenaCenter, secondInfo.pos)\n\nlocal adjustment = math.rad(90)\n\nlocal drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedArrow(5500, 100, 0.05, 100, heading1 + adjustment, 14, 0.75, nil, nil, 0, false, 256)\ndrawer:addTimedArrow(5500, 100, 0.05, 100, heading2 + adjustment, 14, 0.75, nil, nil, 0, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"23386dc5-7b05-5450-964b-2aa3f72e968c",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							name = "Draw Final Safe Corridors",
							uuid = "2960cc2d-3a1e-5207-92d6-6c8f78526fe6",
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
							conditionLua = "return data.p3ApocBothRecorded == true",
							dequeueIfLuaFalse = true,
							name = "Both Starting Recorded",
							uuid = "23386dc5-7b05-5450-964b-2aa3f72e968c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 644.3,
				name = "坦克引导方向",
				timelineIndex = 150,
				timerOffset = -5,
				uuid = "3669092c-9a4e-5103-a124-4d897198d1f8",
				version = 2,
			},
		},
	},
	[151] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "4b91b8a8-6d12-504b-8ef0-18dc7ff69372",
			},
			objectType = "folder",
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
							actionLua = "self.used = true",
							conditions = 
							{
								
								{
									"f46a9edf-fa9f-5a4a-b8df-5eca97f7ab0c",
									true,
								},
								
								{
									"c1e4ad69-5a57-519d-bbfe-0c4044f1247e",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_CD",
							name = "Throttle",
							uuid = "43be01ca-b0db-5d1f-bebe-5e71fffc3969",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Toggle(\"dash\", true)\ndata.p3SomberDash = true\nself.used = true",
							conditions = 
							{
								
								{
									"f46a9edf-fa9f-5a4a-b8df-5eca97f7ab0c",
									true,
								},
								
								{
									"c1e4ad69-5a57-519d-bbfe-0c4044f1247e",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRG3_CD",
							name = "Toggle Dash",
							uuid = "78b5adca-f20a-5ec2-ae7b-2ced9d3df57b",
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
							eventSpellID = 40183,
							name = "Cast ID",
							uuid = "f46a9edf-fa9f-5a4a-b8df-5eca97f7ab0c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3SomberDash ~= true",
							dequeueIfLuaFalse = true,
							name = "Not Dashed",
							uuid = "c1e4ad69-5a57-519d-bbfe-0c4044f1247e",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 2,
				mechanicTime = 647.2,
				name = "返场突进",
				throttleTime = 650,
				timeRange = true,
				timelineIndex = 151,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "191af7ce-3b44-5813-9ce4-715c322cfde5",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Toggle(\"dash\", true)\ndata.p3SomberDash = true\nself.used = true",
							conditions = 
							{
								
								{
									"82bd98fd-fd79-5fd1-9f5c-bd522fa0c8a7",
									true,
								},
								
								{
									"ba6525f9-5681-5f29-aea9-84c698d9e2f0",
									true,
								},
								
								{
									"2aa9b563-4452-5117-aead-fb3c54fb4def",
									true,
								},
							},
							gVar = "ACR_TensorViper3_Hotbar_Slither",
							name = "Toggle Dash",
							uuid = "8422a28a-152e-57d6-b418-737ccf9fe9a1",
							variableTogglesType = 2,
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
							category = "Self",
							conditionLua = "return eventArgs.entityID == TensorCore.mGetPlayer().id",
							conditionType = 9,
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 37964,
							name = "On Player",
							partyTargetType = "Event Entity",
							uuid = "82bd98fd-fd79-5fd1-9f5c-bd522fa0c8a7",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.newAnimID == 200",
							dequeueIfLuaFalse = true,
							eventArgType = 4,
							eventIntValue = 200,
							eventSpellID = 37964,
							name = "Anim ID",
							uuid = "ba6525f9-5681-5f29-aea9-84c698d9e2f0",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3SomberDash ~= true",
							dequeueIfLuaFalse = true,
							name = "Not Dashed",
							uuid = "2aa9b563-4452-5117-aead-fb3c54fb4def",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 23,
				mechanicTime = 647.2,
				name = "即时返场突进",
				timeRange = true,
				timelineIndex = 151,
				timerEndOffset = 1.5,
				timerStartOffset = -0.25,
				uuid = "73003583-8b36-57a0-817b-ddeb90f64686",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "573a200d-e89a-55d0-9b93-8ff16c1e2676",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal bossEnt = TensorCore.mGetEntity(eventArgs.detectionTargetID)\nif (bossEnt == nil) then\n    self.used = true\n    return\nend\n\nlocal drawTime = (647.2 - TensorReactions_CurrentTimer) * 1000\nlocal playerID = TensorCore.mGetPlayer().id\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedArrowOnEnt(drawTime, bossEnt.id, 12, 0.5, nil, nil, playerID, 0, false, nil, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"eb0a9232-accc-54f5-a689-6c4db5a4ab2c",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Draw Arrow",
							uuid = "baac8dcc-a66b-5024-b748-4968ae42dec1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Get Boss",
							uuid = "eb0a9232-accc-54f5-a689-6c4db5a4ab2c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 647.2,
				name = "击退指路箭头",
				timelineIndex = 151,
				timerOffset = -3,
				uuid = "cdf335da-e839-5136-ba1a-971ddc0585a3",
				version = 2,
			},
		},
	},
	[156] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "3bfe90a6-3a3e-5062-83a4-4ff46640ba6b",
			},
			objectType = "folder",
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
									"a1149ea4-b9fa-5022-812e-00f7807d7c70",
									true,
								},
								
								{
									"8dfc223a-a42b-5cce-945a-236d694de158",
									false,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							setTarget = true,
							targetType = "Enemy",
							uuid = "6213dab8-e9dc-5c18-841e-d6aa64f63ca4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Find Boss",
							uuid = "a1149ea4-b9fa-5022-812e-00f7807d7c70",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Current Target",
							name = "Target Filter",
							uuid = "8dfc223a-a42b-5cce-945a-236d694de158",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 705.3,
				name = "选中首领",
				timeRange = true,
				timelineIndex = 156,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "8e9343a5-2859-55fa-83ab-3cd48b3ba94d",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\ndata.p4DarklitSetupRan = false\n\nif (data.hasSetupPriority ~= true) then\n    MuAiGuide.Reactions.log(\"[Darklit Setup] Priority setup hasn't ran successfully!\")\n    self.used = true\n    return\nend\n\nlocal playerID = TensorCore.mGetPlayer().id\nlocal addWorldText = MuAiGuide.Reactions.addTimedWorldTextOnEnt\n\n---@param worldText \"N\"|\"S\"|\"NW\"|\"SW\"|\"NE\"|\"SE\"\nlocal function handlePlayer(worldText)\n    ---@type table<string, string>\n    local shotcallLUT = {\n        [\"N\"] = \"North\",\n        [\"S\"] = \"South\",\n        [\"NW\"] = \"NorthWest\",\n        [\"SW\"] = \"SouthWest\",\n        [\"NE\"] = \"NorthEast\",\n        [\"SE\"] = \"SouthEast\",\n    }\n    MuAiGuide.Reactions.Shotcall(shotcallLUT[worldText], true)\n    local pi = math.pi\n    local halfPi = pi / 2\n    local adjustH = math.rad(25)\n    ---@type table<string, number>\n    local headingLUT = {\n        [\"N\"] = pi,\n        [\"S\"] = 0,\n        [\"NW\"] = -halfPi-adjustH,\n        [\"SW\"] = -halfPi+adjustH,\n        [\"NE\"] = halfPi+adjustH,\n        [\"SE\"] = halfPi-adjustH,\n    }\n    local fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\n    fruMuai1:setGradient(3, 0.15, 2)\n    fruMuai1:setHeightOffset(0.05)\n    fruMuai1:addTimedArrow(8000, 100, 0.05, 100, headingLUT[worldText], 8, 1, nil, nil, 0, false, 256)\nend\n\n---@param worldText \"N\"|\"S\"|\"NW\"|\"SW\"|\"NE\"|\"SE\"\n---@param entID integer\nlocal function drawWorldText(worldText, entID)\n    if (playerID == entID) then\n        handlePlayer(worldText)\n    end\n\n    addWorldText(8000, worldText, entID, 3756906654, true, 2.15, 1.5)\nend\n\n---@param ent1 GameObject\n---@param ent2 GameObject\nlocal function recordTetherPair(ent1, ent2)\n    MuAiGuide.Reactions.log(\"[Darklit Recorder] Running recordTetherPair on \" .. ent1.name .. \" and \" .. ent2.name, 5)\n    local darklitData = data.p4DarklitData\n    local isTethered = darklitData.isTethered\n    local curCount = darklitData.tetherCount\n    if (not isTethered[ent1.id]) then\n        MuAiGuide.Reactions.log(\"[Darklit Recorder] Adding \" .. ent1.name .. \" to isTethered.\", 5)\n        isTethered[ent1.id] = true\n        curCount = curCount + 1\n    end\n    if (not isTethered[ent2.id]) then\n        MuAiGuide.Reactions.log(\"[Darklit Recorder] Adding \" .. ent2.name .. \" to isTethered.\", 5)\n        isTethered[ent2.id] = true\n        curCount = curCount + 1\n    end\n    darklitData.tetherCount = curCount\n    local isHealer = MuAiGuide.Reactions.healJobs\n    if (isHealer[ent1.job] or isHealer[ent2.job]) then\n        MuAiGuide.Reactions.log(\n            \"[Darklit Recorder] Registering \" .. ent1.name .. \" and \" .. ent2.name .. \" to isConnectedToHealer.\", 5)\n        local isConnectedToHealer = darklitData.isConnectedToHealer\n        isConnectedToHealer[ent1.id] = true\n        isConnectedToHealer[ent2.id] = true\n    end\n    darklitData.finishedTethers = curCount >= 4\n    darklitData.isValid = darklitData.finishedTethers and darklitData.finishedStacks\nend\n\n---@param id integer\nlocal function recordStack(id)\n    local darklitData = data.p4DarklitData\n    if (darklitData.isStack[id]) then return end\n    MuAiGuide.Reactions.log(\"[Darklit Recorder] Adding \" .. tostring(id) .. \" to isStack.\", 5)\n    darklitData.isStack[id] = true\n    local curCount = darklitData.stackCount + 1\n    darklitData.stackCount = curCount\n    darklitData.finishedStacks = curCount >= 2\n    darklitData.isValid = darklitData.finishedTethers and darklitData.finishedStacks\nend\n\n---Be sure to call solveTethers before solveStacks, as solveStacks relies on the tether stack side being set.\nlocal function solveTethers()\n    local darklitData = data.p4DarklitData\n    if (not darklitData.finishedTethers) then\n        MuAiGuide.Reactions.log(\"[Darklit Solver] SolveTethers called while tether count was invalid!\", 5)\n        return\n    end\n\n    local partyIDs = data.partyIDs\n    if (partyIDs == nil) then\n        MuAiGuide.Reactions.log(\"[Darklit Tether Solver] partyIDs was nil, using fallback.\", 5)\n        partyIDs = data.partyIDArray\n        if (partyIDs == nil) then\n            MuAiGuide.Reactions.log(\"[Darklit Tether Solver] Party ID array fallback was nil!\", 5)\n            return\n        end\n    end\n\n    local isTethered = darklitData.isTethered\n    local healerConnected = darklitData.isConnectedToHealer\n    local isStack = darklitData.isStack\n    local isHealer = MuAiGuide.Reactions.healJobs\n\n    for i = 1, 8 do\n        local id = partyIDs[i]\n        if (isTethered[id]) then\n            local ent = TensorCore.mGetEntity(id)\n            if (ent == nil) then\n                MuAiGuide.Reactions.log(\"[Darklit Tether Solver] GetEnt returned nil for ID: \" .. tostring(id), 5)\n            else\n                local side = nil\n                if (healerConnected[id] and not isHealer[ent.job]) then\n                    drawWorldText(\"S\", id)\n                    side = 2\n                else\n                    drawWorldText(\"N\", id)\n                    side = 1\n                end\n\n                if (isStack[id]) then\n                    darklitData.tetherStackSide = side\n                    MuAiGuide.Reactions.log(\"[Darklit Tether Solver] Tethered Stack side set to \" .. tostring(side), 5)\n                end\n            end\n        end\n    end\nend\n\nlocal function solveStacks()\n    local darklitData = data.p4DarklitData\n    if (not darklitData.finishedStacks) then\n        MuAiGuide.Reactions.log(\"[Darklit Stack Solver] SolveStacks called while stack count was invalid!\", 5)\n        return\n    end\n\n    local stackSide = darklitData.tetherStackSide\n    if (stackSide == nil) then\n        MuAiGuide.Reactions.log(\"[Darklit Stack Solver] SolveStacks called without tether stack side being set!\", 5)\n        return\n    end\n\n    ---@type table<integer, 1|2|3|4>\n    local dpsPriority = data.dpsPriority\n    if (dpsPriority == nil) then\n        MuAiGuide.Reactions.log(\n            \"[Darklit Stack Solver] SolveStacks called but priority hasn't been set up! Did something go wrong earlier in the fight?\",\n            5)\n        return\n    end\n\n    ---@type integer[]\n    local partyIDs = data.partyIDs\n    if (partyIDs == nil) then\n        MuAiGuide.Reactions.log(\"[Darklit Stack Solver] partyIDs was nil, using fallback.\", 5)\n        ---@type integer[]\n        partyIDs = data.partyIDArray\n        if (partyIDs == nil) then\n            MuAiGuide.Reactions.log(\"[Darklit Stack Solver] Party ID array fallback was nil!\", 5)\n            return\n        end\n    end\n\n    local isTethered = darklitData.isTethered\n    local isTank = MuAiGuide.Reactions.tankJobs\n    local isHealer = MuAiGuide.Reactions.healJobs\n    local tankID, healerID, dps1ID, dps2ID = 0, 0, 0, 0\n\n    for i = 1, 8 do\n        local id = partyIDs[i]\n        if (not isTethered[id]) then\n            local ent = TensorCore.mGetEntity(id)\n            if (ent == nil) then\n                MuAiGuide.Reactions.log(\"[Darklit Stack Solver] Ent returned nil! ID: \" .. tostring(id), 5)\n            else\n                local jobID = ent.job\n                if (isTank[jobID]) then\n                    tankID = id\n                elseif (isHealer[jobID]) then\n                    healerID = id\n                elseif (dps1ID == 0) then\n                    dps1ID = id\n                else\n                    dps2ID = id\n                    break\n                end\n            end\n        end\n    end\n\n    if (tankID == 0 or healerID == 0 or dps1ID == 0 or dps2ID == 0) then\n        MuAiGuide.Reactions.log(\"[Darklit Stack Solver] A non-tethered ID was left 0!\", 5)\n        return\n    end\n\n    local prio1, prio2 = dpsPriority[dps1ID], dpsPriority[dps2ID]\n    if (prio1 == nil or prio2 == nil) then\n        MuAiGuide.Reactions.log(\"[Darklit Stack Solver] Priority for one of the DPS roles returned nil!\", 5)\n        return\n    end\n    local nw, ne, sw, se = 0, 0, 0, 0\n    if (MuAiGuide.Reactions.Settings.Reactions.fruDarklitLPDU) then\n        nw = healerID\n        sw = tankID\n        if (prio1 < prio2) then\n            ne = dps1ID\n            se = dps2ID\n        else\n            ne = dps2ID\n            se = dps1ID\n        end\n    else\n        -- damn NA flexing logic kinda sucks dick compared to EU\n        nw = healerID\n        ne = tankID\n        local dps1Ranged = prio1 > 2\n        local dps2Ranged = prio2 > 2\n        if (dps1Ranged and dps2Ranged) then\n            -- handle ranged swap, lower value (higher on list) goes se\n            if (prio1 < prio2) then se, sw = dps1ID, dps2ID\n            else se, sw = dps2ID, dps1ID end\n        elseif (not dps1Ranged and not dps2Ranged) then\n            -- handle melee swap, lower value (higher on list) goes sw\n            if (prio1 < prio2) then sw, se = dps1ID, dps2ID\n            else sw, se = dps2ID, dps1ID end\n        else\n            -- ranged defaults SW, melee SE\n            if (dps1Ranged) then sw, se = dps1ID, dps2ID\n            else sw, se = dps2ID, dps1ID end\n        end\n    end\n\n    if (nw == 0 or ne == 0 or sw == 0 or se == 0) then\n        MuAiGuide.Reactions.log(\"[Darklit Stack Solver] One of the intercard directions was left 0!\", 5)\n        return\n    end\n\n    local isStack = darklitData.isStack\n    if (stackSide == 1) then\n        if (isStack[nw]) then\n            nw, sw = sw, nw\n        elseif (isStack[ne]) then\n            ne, se = se, ne\n        end\n    else\n        if (isStack[sw]) then\n            nw, sw = sw, nw\n        elseif (isStack[se]) then\n            ne, se = se, ne\n        end\n    end\n\n    drawWorldText(\"NW\", nw)\n    drawWorldText(\"NE\", ne)\n    drawWorldText(\"SW\", sw)\n    drawWorldText(\"SE\", se)\nend\n\n---@class DarklitData\n---@field isTethered table<integer, boolean>\n---@field isConnectedToHealer table<integer, boolean>\n---@field tetherCount integer\n---@field isStack table<integer, boolean>\n---@field stackCount integer\n---@field finishedTethers boolean\n---@field finishedStacks boolean\n---@field isValid boolean\n---@field recordTetherPair function\n---@field recordStack function\n---@field solveTethers function\n---@field solveStacks function\n---@field tetherStackSide nil|1|2\n\n---@type DarklitData\ndata.p4DarklitData = {\n    isTethered = {},\n    isConnectedToHealer = {},\n    tetherCount = 0,\n    isStack = {},\n    stackCount = 0,\n    finishedTethers = false,\n    finishedStacks = false,\n    isValid = false,\n    recordTetherPair = recordTetherPair,\n    recordStack = recordStack,\n    solveTethers = solveTethers,\n    solveStacks = solveStacks,\n}\n\nMuAiGuide.Reactions.log(\"Darklit Setup successfully ran.\", 5)\ndata.p4DarklitSetupRan = true\nself.used = true\n",
							gVar = "ACR_RikuDRK3_CD",
							name = "Init Darklit Vars",
							uuid = "76fab5eb-d383-5e63-b9ea-d8cf1788d495",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 705.3,
				name = "初始化双巫女阶段",
				timelineIndex = 156,
				timerOffset = -5,
				uuid = "cdbfa904-58a6-575c-8169-1005ce036d5e",
				version = 2,
			},
		},
	},
	[157] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "42742d6f-7e61-565f-8e63-63ddc6e97dec",
			},
			objectType = "folder",
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
							actionLua = "data.p4FragmentID = eventArgs.entityID\nlocal fragmentEnt = TensorCore.mGetEntity(eventArgs.entityID)\ndata.p4FragmentHitRadius = fragmentEnt.hitradius + 0.15\nself.used = true",
							conditions = 
							{
								
								{
									"14330d09-dbe6-525f-8f48-8b2f5c15f82e",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Fragment Data",
							uuid = "2085fd23-e7bf-522c-8fe2-299c3d5ad5f9",
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
							eventEntityContentID = 13559,
							name = "Content ID",
							uuid = "14330d09-dbe6-525f-8f48-8b2f5c15f82e",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 5,
				mechanicTime = 712.9,
				name = "记录未来碎片",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 8,
				timerStartOffset = -2,
				uuid = "eefecd16-3a63-5b1a-ab70-239a29021c80",
				version = 2,
			},
		},
	},
	[158] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "a7c7b1ff-309c-5ab5-8b78-5e75ed714ea3",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"63fc7c11-1562-5eb1-b8c8-44b166b273a7",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							uuid = "f8fcd1ec-a659-591a-8fd3-d176ad512e97",
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
							eventSpellID = 40237,
							name = "Akh Rhai ID",
							uuid = "63fc7c11-1562-5eb1-b8c8-44b166b273a7",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 724.1,
				name = "移动播报",
				timeRange = true,
				timelineIndex = 158,
				timerEndOffset = 3,
				timerStartOffset = -3,
				uuid = "d2f678ad-aa83-5a33-9c70-8e36c3cf738e",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(3500, data.p4FragmentID, data.p4FragmentHitRadius + 4, nil, false, nil, 256)\nself.used = true",
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Fragment Exclusion Zone",
							uuid = "e232e77e-fb73-5178-b991-8ff88b8dd57e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 724.1,
				name = "碎片避让范围",
				timelineIndex = 158,
				timerOffset = -3.5,
				uuid = "c69e98e2-c126-511d-8cca-08f091bb5d20",
				version = 2,
			},
		},
	},
	[162] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "38c39cbd-4d5a-5229-8501-53e08de686ab",
			},
			objectType = "folder",
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
							actionLua = "data.p4UsurperID = eventArgs.detectionTargetID\nself.used = true",
							conditions = 
							{
								
								{
									"63c13eb3-80dd-5c29-9f48-654a28261937",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Record Usurper ID",
							uuid = "f0479ef6-d784-5480-84b5-71069d147a9c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "ContentID",
							name = "Usurper Filter",
							partyTargetContentID = 12809,
							uuid = "63c13eb3-80dd-5c29-9f48-654a28261937",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 729.2,
				name = "记录光之巫女",
				timelineIndex = 162,
				timerOffset = -5,
				uuid = "c2debc87-f7ac-5edf-a150-75eb43556c1a",
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
							actionLua = "data.p4OracleID = eventArgs.detectionTargetID\nself.used = true",
							conditions = 
							{
								
								{
									"85cddbd1-198f-5e35-9c76-0da0f1be7d5e",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Record Oracle ID",
							uuid = "5e16823e-fb9c-5033-8c43-df32d6250e77",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "ContentID",
							name = "Oracle Filter",
							partyTargetContentID = 9832,
							uuid = "85cddbd1-198f-5e35-9c76-0da0f1be7d5e",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 729.2,
				name = "记录暗之巫女",
				timelineIndex = 162,
				timerOffset = 1.5,
				uuid = "819fba62-7a7f-d62c-880e-a1b831d52cb6",
				version = 2,
			},
		},
	},
	[166] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "90ca58b0-8739-5155-9f22-7f6feb94f625",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n---@class DarklitTetherInfo\n---@field healerID integer?\n---@field tankID integer?\n---@field dpsIDs integer[]\n---@field alreadyRecorded table<integer, boolean>\n---@field tetherPartners table<integer, table<integer, boolean>>\n\n---@type DarklitTetherInfo\ndata.p4DarklitTethers = {\n    healerID = nil,\n    tankID = nil,\n    dpsIDs = {},\n    alreadyRecorded = {},\n    tetherPartners = {},\n}\n\ndata.p4DarklitTethersCount = 0\n\ndata.p4DarklitTethersTryAddEnt = function(entID)\n    local tetherInfoTable = data.p4DarklitTethers\n    if (tetherInfoTable.alreadyRecorded[entID]) then\n        return\n    end\n    tetherInfoTable.alreadyRecorded[entID] = true\n    local ent = TensorCore.mGetEntity(entID)\n    if (MuAiGuide.Reactions.tankJobs[ent.job]) then\n        if (tetherInfoTable.tankID ~= nil) then return end\n        tetherInfoTable.tankID = ent.id\n        MuAiGuide.Reactions.log(\"[Darklit Tethers] Assigned \" .. ent.name .. \" as tank tether.\", 5)\n        return\n    end\n\n    if (MuAiGuide.Reactions.healJobs[ent.job]) then\n        if (tetherInfoTable.healerID ~= nil) then return end\n        tetherInfoTable.healerID = ent.id\n        MuAiGuide.Reactions.log(\"[Darklit Tethers] Assigned \" .. ent.name .. \" as healer tether.\", 5)\n        return\n    end\n\n    -- They have to be a DPS at this point, no need to check their job.\n    table.insert(tetherInfoTable.dpsIDs, ent.id)\n    MuAiGuide.Reactions.log(\"[Darklit Tethers] Added \" .. ent.name .. \" to dps tethers.\", 5)\nend\n\n---@param sourceID integer\n---@param targetID integer\ndata.p4DarklitTethersAssignPartners = function(sourceID, targetID)\n    local partnerInfos = data.p4DarklitTethers.tetherPartners\n\n    -- Ensure sourceID has a partner table\n    if (partnerInfos[sourceID] == nil) then\n        partnerInfos[sourceID] = {}\n    end\n    -- Ensure targetID has a partner table\n    if (partnerInfos[targetID] == nil) then\n        partnerInfos[targetID] = {}\n    end\n\n    partnerInfos[sourceID][targetID] = true\n    partnerInfos[targetID][sourceID] = true\nend\n\n---@param sourceID integer\n---@param targetID integer\n---@return boolean\ndata.p4DarklitTethersIsPartnered = function(sourceID, targetID)\n    local partnerSet = data.p4DarklitTethers.tetherPartners[sourceID]\n    if (partnerSet == nil) then\n        MuAiGuide.Reactions.log(\"[Darklit Tethers] Tether Partner Table for ID \" .. sourceID .. \" was nil!\", 5)\n        return false\n    end\n\n    return partnerSet[targetID] == true\nend\n\nself.used = true",
							gVar = "ACR_RikuDNC3_CD",
							name = "Initialize Darklit Tethers",
							uuid = "4f6be71f-2651-50f1-8cfe-d1c4a2119619",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 738.2,
				name = "初始化龙诗连线",
				timelineIndex = 166,
				timerOffset = -5,
				uuid = "b5d5eb0d-ab01-55a1-94ab-ab0d509a487e",
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
							actionLua = "local sourceID = eventArgs.sourceEntityID\nlocal targetID = eventArgs.newTargetID\ndata.p4DarklitTethersTryAddEnt(sourceID)\ndata.p4DarklitTethersTryAddEnt(targetID)\ndata.p4DarklitTethersAssignPartners(sourceID, targetID)\ndata.p4DarklitTethersCount = data.p4DarklitTethersCount + 1\nself.used = true",
							conditions = 
							{
								
								{
									"4433b638-9d56-56ad-b8a9-29eea775f7ca",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Record Tether",
							uuid = "ddba122c-bb05-5f21-b841-f1588894276d",
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
							comparator = 3,
							conditionLua = "return eventArgs.newTetherID == 110",
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 110,
							name = "Tether ID",
							uuid = "4433b638-9d56-56ad-b8a9-29eea775f7ca",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 15,
				loop = true,
				mechanicTime = 738.2,
				name = "记录龙诗连线",
				timeRange = true,
				timelineIndex = 166,
				timerEndOffset = 4,
				timerStartOffset = -1,
				uuid = "858d8b52-5580-5802-ae56-cdd689c69c43",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal sourceEnt = TensorCore.mGetEntity(eventArgs.sourceEntityID)\nif (sourceEnt == nil) then\n    MuAiGuide.Reactions.log(\"[Record Tether] Source Ent returned nil!\", 5)\n    self.used = true\n    return\nend\nlocal targetEnt = TensorCore.mGetEntity(eventArgs.newTargetID)\nif (targetEnt == nil) then\n    MuAiGuide.Reactions.log(\"[Record Tether] Target Ent returned nil!\", 5)\n    self.used = true\n    return\nend\n\ndata.p4DarklitData.recordTetherPair(sourceEnt, targetEnt)\nself.used = true",
							conditions = 
							{
								
								{
									"0e036050-936f-5ac5-b9f7-93a81694e1b1",
									true,
								},
								
								{
									"b0b1a0fc-f19e-5bbb-a595-704a4c64ff02",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Record Tether",
							uuid = "20a79fb5-7bbd-5be1-af2c-61bf61a63708",
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
							conditionLua = "return data.p4DarklitSetupRan == true",
							dequeueIfLuaFalse = true,
							name = "Setup Ran",
							uuid = "0e036050-936f-5ac5-b9f7-93a81694e1b1",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.newTetherID == 110",
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 110,
							name = "Tether ID",
							uuid = "b0b1a0fc-f19e-5bbb-a595-704a4c64ff02",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 15,
				loop = true,
				mechanicTime = 738.2,
				name = "解析龙诗连线",
				timeRange = true,
				timelineIndex = 166,
				timerEndOffset = 4,
				timerStartOffset = -1,
				uuid = "05aae2e2-8b47-5c99-bd85-c9a1fe92ce5c",
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
							actionLua = "data.p4DarklitData.recordStack(eventArgs.entityID)\nself.used = true",
							conditions = 
							{
								
								{
									"293307df-e7b9-56a0-9b8c-7bab2a68148e",
									true,
								},
								
								{
									"53b765b9-0ecd-5a6c-9079-2df3efd8d9bf",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							name = "Record Water",
							uuid = "016228a7-85ad-5ae0-ad53-6f3c14cb1e0a",
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
							conditionLua = "return data.p4DarklitSetupRan == true",
							dequeueIfLuaFalse = true,
							name = "Setup Ran",
							uuid = "53b765b9-0ecd-5a6c-9079-2df3efd8d9bf",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 62,
							name = "Marker ID",
							uuid = "293307df-e7b9-56a0-9b8c-7bab2a68148e",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 4,
				loop = true,
				mechanicTime = 738.2,
				name = "记录龙诗水点名",
				timeRange = true,
				timelineIndex = 166,
				timerStartOffset = -10,
				uuid = "20fd4c20-ec0d-54b1-95e6-8306c025bda3",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "f951c668-7855-5603-81ae-a4a7620d01c9",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal playerID = TensorCore.mGetPlayer().id\nif eventArgs.sourceEntityID == playerID or eventArgs.newTargetID == playerID then\n    local fruMuai1 = TensorCore.getCachedDrawer(0x4DEC86C7, nil, 0x4DEC86C7, 0xFFFFFFFF, 2, 0, 256)\n    fruMuai1:setGradient(3, 0.15, 2)\n    fruMuai1:setHeightOffset(0.05)\n    fruMuai1:addTimedRectOnEnt(6000, eventArgs.sourceEntityID, 5, 0.1, eventArgs.newTargetID, 0, false, false, nil, nil, nil, 256)\nelse\n    local fruMuai2 = TensorCore.getCachedDrawer(0x4DEC8687, nil, 0x4DEC8687, 0xFFFFFFFF, 2, 0, 256)\n    fruMuai2:setGradient(3, 0.15, 2)\n    fruMuai2:setHeightOffset(0.05)\n    fruMuai2:addTimedRectOnEnt(6000, eventArgs.sourceEntityID, 5, 0.1, eventArgs.newTargetID, 0, false, false, nil, nil, nil, 256)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"13120e9f-2c33-5f87-b46e-9d8c1b06ec2a",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Draw Tether Rectangle",
							uuid = "26b9cb2d-6e77-5021-99bd-d7357952e813",
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
							comparator = 3,
							conditionLua = "return eventArgs.newTetherID == 110",
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 110,
							name = "Tether ID",
							uuid = "13120e9f-2c33-5f87-b46e-9d8c1b06ec2a",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 15,
				loop = true,
				mechanicTime = 738.2,
				name = "龙诗连线范围",
				timeRange = true,
				timelineIndex = 166,
				timerEndOffset = 4,
				timerStartOffset = -1,
				uuid = "3b89e6ee-6de9-5154-8ce5-8b009dc07e35",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal darklitTethers = data.p4DarklitTethers\n\nif (darklitTethers.healerID == nil) then\n    MuAiGuide.Reactions.log(\"[Darklit Tether Helper] No Healer ID was stored for tethers!\", 5)\n    self.used = true\n    return\nend\n\nif (darklitTethers.tankID == nil) then\n    MuAiGuide.Reactions.log(\"[Darklit Tether Helper] No Tank ID was stored for tethers!\", 5)\n    self.used = true\n    return\nend\n\nif (table.size(darklitTethers.dpsIDs) ~= 2) then\n    MuAiGuide.Reactions.log(\"[Darklit Tether Helper] DPS IDs did not have a count of 2 for tethers!\", 5)\n    self.used = true\n    return\nend\n\nlocal healerEnt = TensorCore.mGetEntity(darklitTethers.healerID)\n\nif (healerEnt == nil or not healerEnt.alive) then\n    MuAiGuide.Reactions.log(\"[Darklit Tether Helper] Healer entity returned nil or wasn't alive!\", 5)\n    self.used = true\n    return\nend\n\nlocal tankEnt = TensorCore.mGetEntity(darklitTethers.tankID)\n\nif (tankEnt == nil or not tankEnt.alive) then\n    MuAiGuide.Reactions.log(\"[Darklit Tether Helper] Tank entity returned nil or wasn't alive!\", 5)\n    self.used = true\n    return\nend\n\nlocal dps1 = TensorCore.mGetEntity(darklitTethers.dpsIDs[1])\nlocal dps2 = TensorCore.mGetEntity(darklitTethers.dpsIDs[2])\n\nif (dps1 == nil or not dps1.alive or dps2 == nil or not dps2.alive) then\n    MuAiGuide.Reactions.log(\"[Darklit Tether Helper] A DPS entity returned nil or wasn't alive!\", 5)\n    self.used = true\n    return\nend\n\n---@type GameObject\nlocal northWestEnt = healerEnt\n---@type GameObject\nlocal northEastEnt = tankEnt\n---@type GameObject\nlocal southWestEnt = nil\n---@type GameObject\nlocal southEastEnt = nil\n\n-- Barring another priority list GUI for this, we'll just have to use the actual entity positions and hope people are in their proper spots according to the strat.\n-- However, if two DPS on the same side are tethered, we can still use P3's priority setup, with the lower numerical value swapping first, as they should be 'G1'\n\nlocal isWest1 = dps1.pos.x < 100\nlocal isWest2 = dps2.pos.x < 100\n\nif (isWest1 == isWest2) then\n    -- If both DPS are same side, we need to figure out who's swapping.\n    local prio1 = data.dpsPriority[dps1.id]\n    local prio2 = data.dpsPriority[dps2.id]\n    if (prio1 == nil or prio2 == nil) then\n        MuAiGuide.Reactions.log(\"[Darklit Tether Helper] Couldn't determine priority for one of the DPS entities!\", 5)\n        self.used = true\n        return\n    end\n\n    local swapEnt, stayEnt = nil, nil\n    -- Higher priority (lower numerical value) swaps first.\n    if (prio1 < prio2) then\n        swapEnt = dps1\n        stayEnt = dps2\n    else\n        swapEnt = dps2\n        stayEnt = dps1\n    end\n\n    if (isWest1) then\n        southWestEnt = stayEnt\n        southEastEnt = swapEnt\n    else\n        southWestEnt = swapEnt\n        southEastEnt = stayEnt\n    end\nelse\n    -- If DPS are opposite sides, we can just assign immediately.\n    if (isWest1) then\n        southWestEnt = dps1\n        southEastEnt = dps2\n    else\n        southEastEnt = dps1\n        southWestEnt = dps2\n    end\nend\n\nif (southWestEnt == nil) then\n    MuAiGuide.Reactions.log(\"[Darklit Tether Helper] SouthWest DPS failed to be assigned!\", 5)\n    self.used = true\n    return\nend\n\nif (southEastEnt == nil) then\n    MuAiGuide.Reactions.log(\"[Darklit Tether Helper] SouthEast DPS failed to be assigned!\", 5)\n    self.used = true\n    return\nend\n\nlocal isPartnered = data.p4DarklitTethersIsPartnered\nlocal nwID = northWestEnt.id\nlocal neID = northEastEnt.id\nlocal swID = southWestEnt.id\nlocal seID = southEastEnt.id\n\nlocal nwToSe = isPartnered(nwID, seID)\nlocal neToSw = isPartnered(neID, swID)\nlocal nwToSw = isPartnered(nwID, swID)\nlocal neToSe = isPartnered(neID, seID)\nlocal nwToNe = isPartnered(nwID, neID)\nlocal swToSe = isPartnered(swID, seID)\n\n---@enum QuadrantEnum\nlocal QuadrantEnum = {\n    NW = 1,\n    NE = 2,\n    SW = 3,\n    SE = 4,\n}\n\n---@type table<QuadrantEnum, integer?>\nlocal resultArray = {\n    [1] = nil,\n    [2] = nil,\n    [3] = nil,\n    [4] = nil,\n}\n\n---@type table<QuadrantEnum, \"N\"|\"S\"?>\nlocal stringArray = {\n    [1] = nil,\n    [2] = nil,\n    [3] = nil,\n    [4] = nil,\n}\n\nif (nwToNe and swToSe) then\n    -- Potentially either hourglass or box.\n    if (nwToSw) then\n        -- Box, east side swaps north-south.\n        resultArray[QuadrantEnum.NW] = nwID -- NW stays.\n        resultArray[QuadrantEnum.NE] = seID -- NE is assigned SE.\n        resultArray[QuadrantEnum.SW] = swID -- SW stays.\n        resultArray[QuadrantEnum.SE] = neID -- SE is assigned NE.\n    else\n        -- Hourglass, NE and SW swap.\n        resultArray[QuadrantEnum.NW] = nwID -- NW stays.\n        resultArray[QuadrantEnum.NE] = swID -- NE is assigned SW.\n        resultArray[QuadrantEnum.SW] = neID -- SW is assigned NE.\n        resultArray[QuadrantEnum.SE] = seID -- SE stays.\n    end\nelseif (nwToSw and nwToSe and neToSe and neToSw) then\n    -- Bowtie pattern. Everyone stays.\n    resultArray[QuadrantEnum.NW] = nwID\n    resultArray[QuadrantEnum.NE] = neID\n    resultArray[QuadrantEnum.SW] = swID\n    resultArray[QuadrantEnum.SE] = seID\nelse\n    -- Unknown pattern.\n    local boolStr = string.format(\n    \"[Darklit Tether Helper] Unknown pattern! Connections were NW-SE: %s, NE-SW: %s, NW-SW: %s, NE-SE: %s, NW-NE: %s, SW-SE: %s\"\n    , tostring(nwToSe), tostring(neToSw), tostring(nwToSw), tostring(neToSe), tostring(nwToNe), tostring(swToSe))\n    MuAiGuide.Reactions.log(boolStr, 5)\n    self.used = true\n    return\nend\n\nlocal northColor = 4115595212\nlocal southColor = 4125294414\nlocal southStr = \"S\"\nlocal northStr = \"N\"\nlocal playerID = TensorCore.mGetPlayer().id\nfor i = 1, 4 do\n    local entID = resultArray[i]\n    if (entID == nil) then\n        MuAiGuide.Reactions.log(\"[Darklit Tether Helper] Ent ID for quadrant \" .. i .. \" was nil!\", 5)\n    else\n        ---@type string\n        local sideStr = nil\n        ---@type integer\n        local sideColor = nil\n        if (i < 3) then\n            sideStr = northStr\n            sideColor = northColor\n        else\n            sideStr = southStr\n            sideColor = southColor\n        end\n        ---@type number\n        local textSize = 1.5\n        if (entID == playerID) then\n            textSize = 2.25\n            if (sideStr == northStr) then\n                MuAiGuide.Reactions.Shotcall(\"North\", true)\n            else\n                MuAiGuide.Reactions.Shotcall(\"South\", true)\n            end\n        end\n        MuAiGuide.Reactions.addTimedWorldTextOnEnt(5000, sideStr, entID, sideColor, true, textSize, 1.5)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"b96b8efa-88a7-5f02-8cac-1593985e1f6d",
									true,
								},
								
								{
									"7a520954-8252-5ed1-8a8d-45a37b935bbd",
									true,
								},
								
								{
									"4d3c29d8-6e78-5227-8cab-5c6fa6fa98f5",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Run NAUR Tether Helper",
							uuid = "b88f1606-1884-5b98-ab21-b48bac0f5fed",
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
							conditionLua = "return data.hasSetupPriority == true",
							dequeueIfLuaFalse = true,
							name = "Priority Set",
							uuid = "b96b8efa-88a7-5f02-8cac-1593985e1f6d",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruDarklitTetherNAUR == true",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "7a520954-8252-5ed1-8a8d-45a37b935bbd",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p4DarklitTethersCount == 4",
							name = "Tether Count",
							uuid = "4d3c29d8-6e78-5227-8cab-5c6fa6fa98f5",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				mechanicTime = 738.2,
				name = "龙诗连线指路",
				timeRange = true,
				timelineIndex = 166,
				timerEndOffset = 4,
				uuid = "de5ae2c2-bc67-510c-a8ce-99dd3546ad57",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\n-- We use GroupList func here because I don't know if waters can appear on dead people in Darklit?\n-- And, if people are dead, it's almost certainly a wipe anyways.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\n\nlocal waterID = 2461\nfor _, ent in pairs(party) do\n    local entID = ent.id\n    local waterBuff = TensorCore.getBuff(entID, waterID)\n    if (waterBuff ~= nil) then\n        local buffTimeMs = waterBuff.duration * 1000\n        drawer:addTimedCircleOnEnt(3000, ent.id, 6, buffTimeMs - 3000, false, nil, 256)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"8a2707f9-1ba6-5076-b4dc-c86b860ba40a",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDNC3_CD",
							name = "Queue Water Draws",
							uuid = "58578f48-7f50-5103-b4af-60e453d04327",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 2461,
							category = "Party",
							name = "Waters Exist",
							partyTargetNumber = 2,
							partyTargetSubType = "Number",
							uuid = "8a2707f9-1ba6-5076-b4dc-c86b860ba40a",
							version = 3,
						},
						inheritedIndex = 1,
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 738.2,
				name = "龙诗水点名范围",
				timeRange = true,
				timelineIndex = 166,
				timerEndOffset = 4,
				timerOffset = 5,
				uuid = "a24343df-2343-5a97-88ae-d3ab3386212b",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- We use GroupList func here because I don't know if waters can appear on dead people in Darklit?\n-- And, if people are dead, it's almost certainly a wipe anyways.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal isTethered = data.p4DarklitTethers.alreadyRecorded\nlocal waterID = 2461\n\nfor _, ent in pairs(party) do\n    if (TensorCore.hasBuff(ent.id, waterID)) then\n        if (isTethered[ent.id]) then\n            MuAiGuide.Reactions.addTimedWorldTextOnEnt(5000, \"Water-T\", ent.id, 4227849038, true, 2, 0)\n        else\n            MuAiGuide.Reactions.addTimedWorldTextOnEnt(5000, \"Water\", ent.id, 4227849038, true, 2, 0)\n        end\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"d263abd1-6b41-5e41-a8cf-5094e14caeff",
									true,
								},
								
								{
									"973c81c5-4a1f-5694-ba52-2ba45ac7fa93",
									true,
								},
								
								{
									"75bbf071-1104-5044-8f2a-c15193ae2038",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "WorldText Waters",
							uuid = "da18a662-c05d-5310-a5b1-84127f0ffeb1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 2461,
							category = "Party",
							name = "Waters Exist",
							partyTargetNumber = 2,
							partyTargetSubType = "Number",
							uuid = "d263abd1-6b41-5e41-a8cf-5094e14caeff",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p4DarklitTethersCount == 4",
							name = "Tether Count",
							uuid = "973c81c5-4a1f-5694-ba52-2ba45ac7fa93",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p4DarklitTethers ~= nil and data.p4DarklitTethers.alreadyRecorded[TensorCore.mGetPlayer().id] ~= true",
							name = "Player Not Tethered",
							uuid = "75bbf071-1104-5044-8f2a-c15193ae2038",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 738.2,
				name = "龙诗水点名提示",
				timeRange = true,
				timelineIndex = 166,
				timerEndOffset = 4,
				timerOffset = 5,
				uuid = "c9f224b9-2376-546b-a6d0-94e1a925b2ce",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal role = \"Support\"\nif MuAiGuide.Reactions.isDPS(eventArgs.entityID) then\n    role = \"DPS\"\nend\n\nMuAiGuide.Reactions.addTimedWorldTextOnEnt(5000, tostring(role)..\" Stack\", eventArgs.entityID, nil, true, 2)\nself.used = true",
							conditions = 
							{
								
								{
									"c4e3b574-6faa-50ad-85d0-df66fc83131c",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "8ddb24ae-25a2-54d8-901f-0a38df6cf6b3",
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
							eventArgType = 2,
							eventMarkerID = 62,
							uuid = "c4e3b574-6faa-50ad-85d0-df66fc83131c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				eventType = 4,
				loop = true,
				mechanicTime = 738.2,
				name = "龙诗分摊提示",
				timeRange = true,
				timelineIndex = 166,
				timerStartOffset = -10,
				uuid = "420617ee-ec16-5f25-be35-48883813853c",
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
							actionLua = "data.p4DarklitData.solveTethers()\nself.used = true",
							conditions = 
							{
								
								{
									"e6b3ed95-cde5-59b7-aeb6-f8a0a03a4513",
									true,
								},
								
								{
									"abe2d454-87d5-5d2b-914a-3375463138bc",
									true,
								},
								
								{
									"1821d9d7-5392-523f-b2f3-defbe873a33c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_CD",
							name = "Solve Tethers",
							uuid = "a1fe52ce-02f5-592d-9f32-ff7c9255f89b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p4DarklitData.solveStacks()\nself.used = true",
							conditions = 
							{
								
								{
									"e6b3ed95-cde5-59b7-aeb6-f8a0a03a4513",
									true,
								},
								
								{
									"abe2d454-87d5-5d2b-914a-3375463138bc",
									true,
								},
								
								{
									"1821d9d7-5392-523f-b2f3-defbe873a33c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_CD",
							name = "Solve Stacks",
							uuid = "b7d35310-60b8-5a75-842d-140b384f32ab",
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
							conditionLua = "return data.p4DarklitSetupRan == true",
							dequeueIfLuaFalse = true,
							name = "Setup Ran",
							uuid = "e6b3ed95-cde5-59b7-aeb6-f8a0a03a4513",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruDarklitTetherNAUR == true",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "abe2d454-87d5-5d2b-914a-3375463138bc",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p4DarklitData.isValid == true",
							name = "Finished Recording",
							uuid = "1821d9d7-5392-523f-b2f3-defbe873a33c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 738.2,
				name = "龙诗站位指路",
				throttleTime = 1500,
				timeRange = true,
				timelineIndex = 166,
				timerEndOffset = 6,
				timerStartOffset = -2,
				uuid = "f2f8c241-331c-5cd8-b04f-e89672a5b8e7",
				version = 2,
			},
		},
	},
	[168] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "e17348e7-21d2-5d18-a88c-d79976830c24",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal center = data.arenaCenter\nlocal id1, id2, id3, id4 = 0, 0, 0, 0\nlocal pos1, pos2, pos3, pos4\nlocal dist1, dist2, dist3, dist4 = 9999, 9999, 9999, 9999\n\n---@type integer[]\nlocal partyIDs = data.partyIDArray\n\nfor i = 1, 8 do\n    local id = partyIDs[i]\n    local ent = TensorCore.mGetEntity(id)\n    if ent ~= nil and ent.alive then\n    local pos = ent.pos\n    -- Calculate distance manually to avoid the sqrt operation from getDistance2d & lua-to-C call overhead\n    local dx = pos.x - center.x\n    local dz = pos.z - center.z\n    local sqDist = dx * dx + dz * dz\n\n    if (sqDist < dist1) then\n        -- Shift others down\n        id4, dist4, pos4 = id3, dist3, pos3\n        id3, dist3, pos3 = id2, dist2, pos2\n        id2, dist2, pos2 = id1, dist1, pos1\n        id1, dist1, pos1 = id, sqDist, pos\n    elseif (sqDist < dist2) then\n        id4, dist4, pos4 = id3, dist3, pos3\n        id3, dist3, pos3 = id2, dist2, pos2\n        id2, dist2, pos2 = id, sqDist, pos\n    elseif (sqDist < dist3) then\n        id4, dist4, pos4 = id3, dist3, pos3\n        id3, dist3, pos3 = id, sqDist, pos\n    elseif (sqDist < dist4) then\n        id4, dist4, pos4 = id, sqDist, pos\n    end\n    end\nend\n\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer(0x4DFFFFFF, nil, 0x4DFFFFFF, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nif (id1 > 0) then\n    drawer:addCone(100, 0.05, 100, 30, 1.0471975, TensorCore.getHeadingToTarget(center, pos1), false, 256)\nend\nif (id2 > 0) then\n    drawer:addCone(100, 0.05, 100, 30, 1.0471975, TensorCore.getHeadingToTarget(center, pos2), false, 256)\nend\nif (id3 > 0) then\n    drawer:addCone(100, 0.05, 100, 30, 1.0471975, TensorCore.getHeadingToTarget(center, pos3), false, 256)\nend\nif (id4 > 0) then\n    drawer:addCone(100, 0.05, 100, 30, 1.0471975, TensorCore.getHeadingToTarget(center, pos4), false, 256)\nend\n\nself.used = true",
							gVar = "ACR_TensorViper3_CD",
							name = "Draw 4 Closest",
							uuid = "8de6c8d1-c6f7-5b96-9a70-2a4b44fb80a1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 749.3,
				name = "光之海浪近距扇形",
				randomOffset = 0.85000002384186,
				timeRange = true,
				timelineIndex = 168,
				timerEndOffset = 0.85000002384186,
				timerStartOffset = -3,
				uuid = "9ded2181-18da-5167-9dd0-4b4210cb3061",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "目标选择",
				uuid = "0a546c90-9f88-a3ec-c2a5-e3d2de677de0",
			},
			objectType = "folder",
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
									"7e99841a-1855-c810-8d26-3c0f779313f6",
									true,
								},
								
								{
									"e1d9c6b6-936e-c815-9e7b-6d1ebd079fd7",
									true,
								},
							},
							name = "选中目标",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "4e1f2a58-caef-37b8-92e8-1c556b034537",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"26ff7cd7-e8cc-1cb6-ac85-b88f8fdb64c2",
									true,
								},
							},
							filterTargetSubtype = "Highest HP",
							filterTargetType = "Enemy",
							name = "范围内最高血量目标",
							uuid = "e1d9c6b6-936e-c815-9e7b-6d1ebd079fd7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "近战输出职业",
							partyTargetType = "Melee DPS",
							uuid = "7e99841a-1855-c810-8d26-3c0f779313f6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							comparator = 2,
							conditionType = 4,
							inRangeValue = 10.449999809265,
							name = "近战距离检查",
							partyTargetType = "Detection Target",
							uuid = "26ff7cd7-e8cc-1cb6-ac85-b88f8fdb64c2",
							version = 3,
						},
					},
				},
				displayPath = "目标选择",
				loop = true,
				mechanicTime = 749.3,
				name = "近战优先高血量",
				throttleTime = 1500,
				timeRange = true,
				timelineIndex = 168,
				timerEndOffset = 36,
				uuid = "108fee45-0883-4027-b7e7-52deab704226",
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
									"5d2564bf-b167-16de-a2e0-2b2be2520be4",
									true,
								},
								
								{
									"31e2f741-b066-0ffe-b012-f861166dee39",
									true,
								},
							},
							name = "选中目标",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "349bdfe7-5e73-d2e1-9832-d9195d279125",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"b8132558-0a33-22f1-a68c-d50ab7474d5f",
									true,
								},
								
								{
									"a94ab14a-b5e4-3e33-bdf9-2e344a2f2fc5",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "远程输出或治疗",
							partyTargetNumber = 0,
							uuid = "5d2564bf-b167-16de-a2e0-2b2be2520be4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							name = "远程输出职业",
							partyTargetType = "Ranged DPS",
							uuid = "b8132558-0a33-22f1-a68c-d50ab7474d5f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							name = "治疗职业",
							partyTargetType = "Healer",
							uuid = "a94ab14a-b5e4-3e33-bdf9-2e344a2f2fc5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"25a62f35-befa-19b2-8509-fa3cac9c5a7e",
									true,
								},
							},
							filterTargetSubtype = "Highest HP",
							filterTargetType = "Enemy",
							name = "范围内最高血量敌人",
							uuid = "31e2f741-b066-0ffe-b012-f861166dee39",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							comparator = 2,
							conditionType = 4,
							inRangeValue = 31.125,
							name = "远程距离检查",
							partyTargetType = "Detection Target",
							uuid = "25a62f35-befa-19b2-8509-fa3cac9c5a7e",
							version = 3,
						},
					},
				},
				displayPath = "目标选择",
				loop = true,
				mechanicTime = 749.3,
				name = "远程治疗优先高血量",
				throttleTime = 1500,
				timeRange = true,
				timelineIndex = 168,
				timerEndOffset = 36,
				uuid = "141c5077-4bcf-2270-9d4d-34bbc219467e",
				version = 2,
			},
		},
	},
	[169] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "ca952adc-5f11-54ff-94bf-14f5626396d7",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal timeToMech = 3100\nlocal drawTime = 2000\nlocal delayTime = timeToMech - drawTime\nlocal playerID = TensorCore.mGetPlayer().id\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nfor _, ent in pairs(party) do\n    if (ent.id ~= playerID) then\n        drawer:addTimedCircleOnEnt(drawTime, ent.id, 5, delayTime, false, nil, 256)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0c11f525-cbfa-51d0-aeaf-4aff55fdd91d",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Draw Spread",
							uuid = "31053f03-075e-562e-a818-2832bcbe3626",
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
							eventSpellID = 40288,
							name = "Channel ID",
							uuid = "0c11f525-cbfa-51d0-aeaf-4aff55fdd91d",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 752.3,
				name = "碎灵一击分散范围",
				timeRange = true,
				timelineIndex = 169,
				timerEndOffset = -1,
				timerStartOffset = -6,
				uuid = "cd87d9e3-31a9-5e7c-afac-004ca01bd202",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Spread, Then Water Stack\", true)\nself.used = true",
							gVar = "ACR_TensorViper3_CD",
							name = "Shotcall Next Mechs",
							uuid = "7535591d-8e19-527d-bf19-2ff362b7719b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 752.3,
				name = "先分散后分摊播报",
				timelineIndex = 169,
				timerOffset = -2.4000000953674,
				uuid = "caeac6aa-2515-507e-a47f-31edea3e7dd4",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(3500, data.p4FragmentID, data.p4FragmentHitRadius + 5, nil, false, nil, 256)\nself.used = true",
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Fragment Exclusion Zone",
							uuid = "e232e77e-fb73-5178-b991-8ff88b8dd57e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 752.3,
				name = "碎片避让范围",
				timelineIndex = 169,
				timerOffset = -3.5,
				uuid = "2eb2c109-5761-5461-a20c-641dce72f4de",
				version = 2,
			},
		},
	},
	[171] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "def9fb72-0c3a-584f-af6d-522588adacfd",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(3500, data.p4FragmentID, data.p4FragmentHitRadius + 6, nil, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"fb3eb0d8-4b1d-588e-93dc-ec0ea951a1e8",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Fragment Exclusion Zone",
							uuid = "e232e77e-fb73-5178-b991-8ff88b8dd57e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 2461,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Has Water",
							uuid = "fb3eb0d8-4b1d-588e-93dc-ec0ea951a1e8",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 757.3,
				name = "碎片避让范围",
				timelineIndex = 171,
				timerOffset = -3.5,
				uuid = "34a9cf95-e1bd-5190-bd1e-da458112370d",
				version = 2,
			},
		},
	},
	[172] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "712e72de-9667-53fa-ad7c-0c225f465546",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal entPos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCircle(entPos.x, 0.05, entPos.z, 8, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"4c90ae35-ac57-5b91-9d2f-d36b70160e04",
									true,
								},
								
								{
									"700884fb-83ae-599f-b0a1-3279c96e0374",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Circle",
							uuid = "d0315945-b287-559e-a899-cdfe86f1a915",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "ContentID",
							name = "Oracle Filter",
							partyTargetContentID = 9832,
							uuid = "4c90ae35-ac57-5b91-9d2f-d36b70160e04",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetSubtype = "Furthest",
							filterTargetType = "Party",
							name = "Furthest From Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "700884fb-83ae-599f-b0a1-3279c96e0374",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 760.4,
				name = "真夜舞蹈远距诱导",
				timeRange = true,
				timelineIndex = 172,
				timerEndOffset = 0.34999999403954,
				timerStartOffset = -2.5,
				uuid = "8d859f11-eb14-5898-bc08-a9c95a8596d9",
				version = 2,
			},
		},
	},
	[173] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "ba575594-446a-583b-8708-1c09813842a0",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal entPos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCircle(entPos.x, 0.05, entPos.z, 8, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"4c90ae35-ac57-5b91-9d2f-d36b70160e04",
									true,
								},
								
								{
									"99d7ce29-51c8-52b2-b25d-7a114deb43ba",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Circle",
							uuid = "d0315945-b287-559e-a899-cdfe86f1a915",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "ContentID",
							name = "Oracle Filter",
							partyTargetContentID = 9832,
							uuid = "4c90ae35-ac57-5b91-9d2f-d36b70160e04",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Party",
							name = "Nearest To Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "99d7ce29-51c8-52b2-b25d-7a114deb43ba",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 763.9,
				name = "真夜舞蹈近距诱导",
				timeRange = true,
				timelineIndex = 173,
				timerEndOffset = 0.10000000149012,
				timerStartOffset = -2.5,
				uuid = "628f7792-00af-572c-9f3c-6c4b604fbb3f",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(6850, data.p4FragmentID, data.p4FragmentHitRadius + 8, nil, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"cc93b220-1e55-554e-b1fa-bdd675ae3ddb",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Fragment Exclusion Zone",
							uuid = "e232e77e-fb73-5178-b991-8ff88b8dd57e",
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
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "Is Tank",
							partyTargetType = "Tank",
							uuid = "cc93b220-1e55-554e-b1fa-bdd675ae3ddb",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 763.9,
				name = "碎片避让范围",
				timelineIndex = 173,
				timerOffset = -6.8499999046326,
				uuid = "afa26ab6-e73a-5d4d-a4ac-98cf0938ec58",
				version = 2,
			},
		},
	},
	[175] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "1c6b4a8b-ace7-59a9-935c-9f22c9883487",
			},
			objectType = "folder",
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
							actionLua = "-- FRU 光巫女死亡轮回: 每次 OnFrame 更新读取对应首领当前目标, 不固定画在本人.\nlocal remaining = (777.8 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUTankStacks\nif rounds == nil then\n    rounds = {}\n    data.StringFRUTankStacks = rounds\nend\nlocal state = rounds[\"175_p4UsurperID\"]\nif state == nil then state = {}; rounds[\"175_p4UsurperID\"] = state end\nif remaining <= 0 then\n    if state.draw then Argus.deleteTimedShape(state.draw) end\n    state.draw = nil\n    self.used = true\n    return\nend\n\nlocal bossID = data.p4UsurperID\nif bossID == nil then self.used = true; return end\nlocal boss = TensorCore.mGetEntity(bossID)\nif boss == nil then self.used = true; return end\nlocal target = TensorCore.mGetEntity(boss.targetid)\n-- 自身读条时目标可能暂时为首领/未可读; 只保留本轮最后有效的玩家附着.\nif target == nil or target.contentid ~= 0 then self.used = true; return end\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4DFFFFFF, nil, 0x4DFFFFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\nif state.draw and state.targetID ~= target.id then\n    if not drawer:updateTimedCircleOnEnt(state.draw, nil, target.id) then state.draw = nil end\nend\nif state.draw == nil then\n    state.draw = drawer:addTimedCircleOnEnt(remaining, target.id, 4, 0, false, true, 256)\nend\nif state.draw then state.targetID = target.id end\nself.used = true\n",
							gVar = "ACR_TensorViper3_CD",
							name = "跟随首领当前分摊目标",
							uuid = "01824758-6523-5e1e-8cc6-d11b00256d2e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 773.5,
				name = "光巫女死亡轮回",
				timeRange = true,
				timelineIndex = 175,
				timerEndOffset = 4.3,
				timerStartOffset = -4,
				uuid = "baa7558c-0d0e-582b-a3aa-6cb67770e267",
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
							actionLua = "-- FRU 暗巫女死亡轮回: 每次 OnFrame 更新读取对应首领当前目标, 不固定画在本人.\nlocal remaining = (777.8 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUTankStacks\nif rounds == nil then\n    rounds = {}\n    data.StringFRUTankStacks = rounds\nend\nlocal state = rounds[\"175_p4OracleID\"]\nif state == nil then state = {}; rounds[\"175_p4OracleID\"] = state end\nif remaining <= 0 then\n    if state.draw then Argus.deleteTimedShape(state.draw) end\n    state.draw = nil\n    self.used = true\n    return\nend\n\nlocal bossID = data.p4OracleID\nif bossID == nil then self.used = true; return end\nlocal boss = TensorCore.mGetEntity(bossID)\nif boss == nil then self.used = true; return end\nlocal target = TensorCore.mGetEntity(boss.targetid)\n-- 自身读条时目标可能暂时为首领/未可读; 只保留本轮最后有效的玩家附着.\nif target == nil or target.contentid ~= 0 then self.used = true; return end\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\nif state.draw and state.targetID ~= target.id then\n    if not drawer:updateTimedCircleOnEnt(state.draw, nil, target.id) then state.draw = nil end\nend\nif state.draw == nil then\n    state.draw = drawer:addTimedCircleOnEnt(remaining, target.id, 4, 0, false, true, 256)\nend\nif state.draw then state.targetID = target.id end\nself.used = true\n",
							gVar = "ACR_TensorViper3_CD",
							name = "跟随首领当前分摊目标",
							uuid = "01824758-6523-5e1e-8cc6-d11b00256d2e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 773.5,
				name = "暗巫女死亡轮回",
				timeRange = true,
				timelineIndex = 175,
				timerEndOffset = 4.3,
				timerStartOffset = -4,
				uuid = "5e707cd2-845e-5a0d-a770-19ee6cefd073",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(3500, data.p4FragmentID, data.p4FragmentHitRadius + 4, nil, false, nil, 256)\nself.used = true",
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Fragment Exclusion Zone",
							uuid = "e232e77e-fb73-5178-b991-8ff88b8dd57e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 773.5,
				name = "碎片避让范围",
				timelineIndex = 175,
				timerOffset = -3.5,
				uuid = "5f255101-1d60-5192-b106-ae4e85bc6a70",
				version = 2,
			},
		},
	},
	[176] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "b5008925-d848-53fe-98af-e08ddfe188d4",
			},
			objectType = "folder",
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
							actionLua = "-- FRU 无尽顿悟分摊: 每次 OnFrame 更新读取对应首领当前目标, 不固定画在本人.\nlocal remaining = (784.4 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUTankStacks\nif rounds == nil then\n    rounds = {}\n    data.StringFRUTankStacks = rounds\nend\nlocal state = rounds[\"176_p4UsurperID\"]\nif state == nil then state = {}; rounds[\"176_p4UsurperID\"] = state end\nif remaining <= 0 then\n    if state.draw then Argus.deleteTimedShape(state.draw) end\n    state.draw = nil\n    self.used = true\n    return\nend\n\nlocal bossID = data.p4UsurperID\nif bossID == nil then self.used = true; return end\nlocal boss = TensorCore.mGetEntity(bossID)\nif boss == nil then self.used = true; return end\nlocal target = TensorCore.mGetEntity(boss.targetid)\n-- 自身读条时目标可能暂时为首领/未可读; 只保留本轮最后有效的玩家附着.\nif target == nil or target.contentid ~= 0 then self.used = true; return end\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4DFFFFFF, nil, 0x4DFFFFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\nif state.draw and state.targetID ~= target.id then\n    if not drawer:updateTimedCircleOnEnt(state.draw, nil, target.id) then state.draw = nil end\nend\nif state.draw == nil then\n    state.draw = drawer:addTimedCircleOnEnt(remaining, target.id, 4, 0, false, true, 256)\nend\nif state.draw then state.targetID = target.id end\nself.used = true\n",
							gVar = "ACR_RikuDNC3_CD",
							name = "跟随首领当前分摊目标",
							uuid = "aac198ce-9893-5ce5-938d-4c9015009161",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 783.4,
				name = "无尽顿悟分摊",
				timeRange = true,
				timelineIndex = 176,
				timerEndOffset = 1,
				timerOffset = -5.1999998092651,
				timerStartOffset = -6,
				uuid = "2afeb9db-7d35-529c-baea-15fee5a0b55e",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Party stack\", true)\nself.used = true",
							gVar = "ACR_RikuDNC3_CD",
							uuid = "aac198ce-9893-5ce5-938d-4c9015009161",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 783.4,
				name = "全队分摊播报",
				timelineIndex = 176,
				timerOffset = -5.1999998092651,
				timerStartOffset = -5.1999998092651,
				uuid = "67a2dd56-8b6c-56a4-9664-14466f196cce",
				version = 2,
			},
		},
	},
	[179] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "7d12c092-b178-5668-a33f-6c05f6ac51ca",
			},
			objectType = "folder",
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
							actionLua = "---@class CTHourglassInfo\n---@field hourglassIDs integer[]\n---@field yellowTethers table<integer, boolean>\n---@field purpleTethers table<integer, boolean>\n---@field tetherCount integer\n---@field northPurpleID integer?\n---@field northPurpleIsWest boolean?\n\n---@type CTHourglassInfo\ndata.p4CTHourglassInfo = {\n    hourglassIDs = {},\n    yellowTethers = {},\n    purpleTethers = {},\n    tetherCount = 0,\n}\n\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Initialize CT Vars",
							uuid = "34873c2b-f1fc-53b5-bf3d-8da5a23753ff",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 798.9,
				name = "初始化结晶沙漏",
				timelineIndex = 179,
				timerOffset = -5,
				uuid = "07eed752-dfe3-5c08-8386-4900aba2613e",
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
							actionLua = "table.insert(data.p4CTHourglassInfo.hourglassIDs, eventArgs.entityID)\nself.used = true",
							conditions = 
							{
								
								{
									"dabf2f31-93d8-566e-abed-c1267f40c209",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Hourglass Ent",
							uuid = "ae784a0c-674f-5a1e-88aa-7ce21d445f8a",
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
							eventEntityContentID = 9823,
							name = "Content ID",
							uuid = "dabf2f31-93d8-566e-abed-c1267f40c209",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 5,
				loop = true,
				mechanicTime = 798.9,
				name = "记录结晶沙漏",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 5,
				timerStartOffset = -2,
				uuid = "be9b99c4-e9dc-54a0-9a75-acbd0cf2d843",
				version = 2,
			},
		},
	},
	[180] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "0b007cde-a3f7-57d3-b7bd-3e699a690294",
			},
			objectType = "folder",
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
							actionLua = "local info = data.p4CTHourglassInfo\ninfo.tetherCount = info.tetherCount + 1\ninfo.yellowTethers[eventArgs.sourceEntityID] = true\nself.used = true",
							conditions = 
							{
								
								{
									"5484aa9b-f4c2-5d6f-820d-14738c4a534a",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Yellow Tether",
							uuid = "649282d8-bf47-554e-b4c3-a6c615d267a4",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal info = data.p4CTHourglassInfo\ninfo.tetherCount = info.tetherCount + 1\nlocal entID = eventArgs.sourceEntityID\ninfo.purpleTethers[entID] = true\nlocal ent = TensorCore.mGetEntity(entID)\nif (ent == nil) then\n    MuAiGuide.Reactions.log(\"[Record Purple Tether] Ent of ID \" .. entID .. \" returned nil!\", 5)\n    self.used = true\n    return\nend\nif (ent.pos.z < 100) then\n    MuAiGuide.Reactions.log(\"[Record Purple Tether] North purple tether set as ID \" .. entID, 5)\n    info.northPurpleID = entID\n    info.northPurpleIsWest = ent.pos.x < 100\nend\nself.used = true",
							conditions = 
							{
								
								{
									"9ec1ca7e-26c8-5aa5-b2c0-8a2d233582d7",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Purple Tether",
							uuid = "4adaed80-eb51-50f6-983f-db1774c642cf",
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
							comparator = 3,
							conditionLua = "return eventArgs.newTetherID == 134",
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 134,
							name = "Yellow Tether",
							uuid = "5484aa9b-f4c2-5d6f-820d-14738c4a534a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.newTetherID == 133",
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 133,
							name = "Purple Tether",
							uuid = "9ec1ca7e-26c8-5aa5-b2c0-8a2d233582d7",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 15,
				loop = true,
				mechanicTime = 802.8,
				name = "记录沙漏连线",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 3,
				timerStartOffset = -3,
				uuid = "58030d94-0719-5276-9495-c50296155187",
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
							actionLua = "if (data.p4DragonHeadID1 == nil) then\n    data.p4DragonHeadID1 = eventArgs.entityID\nelse\n    data.p4DragonHeadID2 = eventArgs.entityID\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"1ac91637-bef9-5290-9f72-6cd9cdb90aea",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Dragon Head ID",
							uuid = "3a31625c-f214-59ca-96d9-374cc55d6bda",
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
							eventEntityContentID = 9323,
							name = "Content ID",
							uuid = "1ac91637-bef9-5290-9f72-6cd9cdb90aea",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 5,
				loop = true,
				mechanicTime = 802.8,
				name = "记录龙头",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 4,
				timerStartOffset = -2,
				uuid = "e41e1f3b-b7c3-5a11-b0c0-afdaedd56334",
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
							actionLua = "data.p4CTPlayerRed = true\ndata.p4CTPlayerBlue = false\nself.used = true",
							conditions = 
							{
								
								{
									"b7f4abe1-0d77-5e81-806f-0a61f7218c9d",
									true,
								},
								
								{
									"af194f26-e135-5462-a8d6-5583e2ca09fc",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Player Red",
							uuid = "af010e5c-5b07-5528-b06c-952bac9d200e",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p4CTPlayerRed = false\ndata.p4CTPlayerBlue = true\nself.used = true",
							conditions = 
							{
								
								{
									"af194f26-e135-5462-a8d6-5583e2ca09fc",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Player Blue",
							uuid = "880521bc-bf6b-5d73-8173-9ae8087622b9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 3263,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Is Red",
							uuid = "b7f4abe1-0d77-5e81-806f-0a61f7218c9d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 3264,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Is Blue",
							uuid = "af194f26-e135-5462-a8d6-5583e2ca09fc",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 802.8,
				name = "记录红蓝点名",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 2,
				timerOffset = -0.5,
				timerStartOffset = -0.5,
				uuid = "c788130a-5eeb-5244-97e0-1f776787a1dd",
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
							actionLua = "data.p4CTPlayerEruption = true\ndata.p4CTPlayerWater = false\ndata.p4CTPlayerIce = false\ndata.p4CTPlayerAero = false\ndata.p4CTPlayerStack = false\nself.used = true",
							conditions = 
							{
								
								{
									"4e6c8f13-6ea1-5e9a-ae2b-b8d9e83d61ec",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Player Eruption",
							uuid = "5d9e4795-f7b0-5959-a0d0-d71395769951",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p4CTPlayerEruption = false\ndata.p4CTPlayerWater = true\ndata.p4CTPlayerIce = false\ndata.p4CTPlayerAero = false\ndata.p4CTPlayerStack = false\nself.used = true",
							conditions = 
							{
								
								{
									"3c680326-a1ed-58bd-bb15-2728ebac8f96",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Player Water",
							uuid = "d43931d1-1bd9-5b37-bebe-56e3da2ca7f2",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p4CTPlayerEruption = false\ndata.p4CTPlayerWater = false\ndata.p4CTPlayerIce = true\ndata.p4CTPlayerAero = false\ndata.p4CTPlayerStack = false\nself.used = true",
							conditions = 
							{
								
								{
									"5049d232-1dba-5ec4-96fa-248963d36da4",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Player Ice",
							uuid = "e9b5fab6-f608-5bde-92f1-48d6cee62139",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p4CTPlayerEruption = false\ndata.p4CTPlayerWater = false\ndata.p4CTPlayerIce = false\ndata.p4CTPlayerAero = true\ndata.p4CTPlayerStack = false\nself.used = true",
							conditions = 
							{
								
								{
									"3be30bce-6eb2-56c4-a1c3-afc34830ff91",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Player Aero",
							uuid = "de8700ae-abf8-5bb2-a014-2b0858f12cfe",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p4CTPlayerEruption = false\ndata.p4CTPlayerWater = false\ndata.p4CTPlayerIce = false\ndata.p4CTPlayerAero = false\ndata.p4CTPlayerStack = true\nself.used = true",
							conditions = 
							{
								
								{
									"18509c99-6557-5769-b241-fad3655bec2d",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "Set Player Stack",
							uuid = "d35a820a-cc7e-5697-912f-6c2b0cb0e00a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 2461,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Is Water",
							uuid = "3c680326-a1ed-58bd-bb15-2728ebac8f96",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 2463,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Is Aero",
							uuid = "3be30bce-6eb2-56c4-a1c3-afc34830ff91",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 2460,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Is Eruption",
							uuid = "4e6c8f13-6ea1-5e9a-ae2b-b8d9e83d61ec",
							version = 3,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							buffID = 2462,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Is Ice",
							uuid = "5049d232-1dba-5ec4-96fa-248963d36da4",
							version = 3,
						},
						inheritedIndex = 4,
					},
					
					{
						data = 
						{
							buffID = 2454,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Is Stack",
							uuid = "18509c99-6557-5769-b241-fad3655bec2d",
							version = 3,
						},
						inheritedIndex = 5,
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 802.8,
				name = "记录结晶点名",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 2,
				timerOffset = -0.5,
				timerStartOffset = -0.5,
				uuid = "ae884667-cca4-5be8-9c73-3f9642c837f7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "84ed3628-77fd-5abf-a2c7-99c6d913c44f",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal waterBuffID = 2461\nlocal blueBuffID = 3264\nlocal redBuffID = 3263\nlocal stackBuffID = 2454\nlocal aeroBuffID = 2463\nlocal iceBuffID = 2462\nlocal eruptionBuffID = 2460\n\nlocal player = TensorCore.mGetPlayer()\nlocal playerID = player.id\n\nlocal function drawArrow(arrowH)\n    local drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256) -- G255 A87\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    drawer:addTimedArrow(5000, 100, 0.05, 100, arrowH, 12, 1, nil, nil, 0, false, 256)\nend\n\nlocal function handleRed()\n    -- Handle red things.\n    local matchingBuffID = 0\n    local isAero = false\n    if (TensorCore.hasBuff(playerID, aeroBuffID)) then\n        matchingBuffID = aeroBuffID\n        isAero = true\n    elseif (TensorCore.hasBuff(playerID, iceBuffID)) then\n        matchingBuffID = iceBuffID\n    else\n        MuAiGuide.Reactions.log(\"[CT Helper] Player was red, but had neither aero or ice!\", 5)\n        return\n    end\n\n    local sameBuffEntID = 0\n    local partyIDs = data.partyIDArray\n    for i = 1, 8 do\n        local id = partyIDs[i]\n        if (id ~= playerID and TensorCore.hasBuff(id, redBuffID) and TensorCore.hasBuff(id, matchingBuffID)) then\n            sameBuffEntID = id\n            break\n        end\n    end\n\n    if (sameBuffEntID == 0) then\n        MuAiGuide.Reactions.log(\"[CT Helper] Was unable to find an ent matching player buff of \" .. matchingBuffID, 5)\n        return\n    end\n\n    local sameBuffEnt = TensorCore.mGetEntity(sameBuffEntID)\n    if (sameBuffEnt == nil) then\n        MuAiGuide.Reactions.log(\"[CT] Helper] Ent matching player buff returned nil!\", 5)\n        return\n    end\n\n    local isPlayerDPS = MuAiGuide.Reactions.dpsJobs[player.job] == true\n    local isPartnerDPS = MuAiGuide.Reactions.dpsJobs[sameBuffEnt.job] == true\n    ---@type boolean?\n    local playerGoesWest = nil\n    if (isPlayerDPS ~= isPartnerDPS) then\n        playerGoesWest = not isPlayerDPS\n    else\n        local playerPriority = data.priorityDictionary[playerID]\n        local partnerPriority = data.priorityDictionary[sameBuffEntID]\n        if (playerPriority == nil or partnerPriority == nil) then\n            MuAiGuide.Reactions.log(\"[CT Helper] Player or Partner priority lookup returned nil!\", 5)\n            return\n        end\n\n        -- Lower numerical value swaps.\n        if (isPlayerDPS) then\n            -- DPS default east, so between two DPS the lower numerical value goes west.\n            playerGoesWest = playerPriority < partnerPriority\n        else\n            -- Supports default west, so between two supports the lower numerical value goes east.\n            playerGoesWest = playerPriority > partnerPriority\n        end\n\n        -- reversed swap order for JP strat (H1 goes west, H2 east instead of vice-versa, etc.)\n        if (MuAiGuide.Reactions.Settings.Reactions.fruJPCTOrder == 2) then\n            playerGoesWest = not playerGoesWest\n        end\n    end\n\n    local arrowH\n    local callStr\n    local shotcallTime = 5\n    if (isAero) then\n        callStr = playerGoesWest and \"SouthWest\" or \"SouthEast\"\n        arrowH = math.rad(45)\n    else\n        shotcallTime = 12\n        callStr = playerGoesWest and \"West\" or \"East\"\n        arrowH = math.rad(90)\n        local stackIsWest = data.p4CTHourglassInfo.northPurpleIsWest\n        if (playerGoesWest == stackIsWest) then\n            callStr = callStr .. \", Then Stack North\"\n        else\n            callStr = callStr .. \", Then Dodge South\"\n        end\n    end\n\n    if (playerGoesWest) then\n        arrowH = -arrowH\n    end\n\n    MuAiGuide.Reactions.Shotcall(callStr, true, shotcallTime)\n    drawArrow(arrowH)\nend\n\nlocal function handleBlue()\n    local northPurpleIsWest = data.p4CTHourglassInfo.northPurpleIsWest\n    if (northPurpleIsWest == nil) then\n        MuAiGuide.Reactions.log(\"[CT Helper] North Purple Is West remained unset!\", 5)\n        return\n    end\n\n    if (TensorCore.hasBuff(playerID, eruptionBuffID)) then\n        MuAiGuide.Reactions.Shotcall(\"North Purple\", true)\n        local arrowH = math.pi - math.rad(45)\n        -- arrowH starts pointing NE because negative rotation is clockwise and pi is north.\n        -- if north purple is west, we can mirror the heading by flipping its sign. Yay [-pi,pi]!\n        if (northPurpleIsWest) then arrowH = -arrowH end\n        drawArrow(arrowH)\n        return\n    end\n\n    --If player isn't eruption, all the other buffs go the same direction.\n    MuAiGuide.Reactions.Shotcall(\"South Purple\", true)\n    local arrowH = 0 - math.rad(45)\n    -- arrowH startings pointing SW.\n    -- if north purple is west, south must be east, so we mirror.\n    if (northPurpleIsWest) then arrowH = -arrowH end\n    drawArrow(arrowH)\nend\n\nif (TensorCore.hasBuff(playerID, redBuffID)) then\n    handleRed()\nelseif (TensorCore.hasBuff(playerID, blueBuffID)) then\n    handleBlue()\nelse\n    MuAiGuide.Reactions.log(\"[CT Helper] Player was neither red or blue!\", 5)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"03292367-87c8-5360-a17d-62ecf88f01e6",
									true,
								},
								
								{
									"c7f575b6-d916-5e32-a53f-64b10e0ebc09",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Arrow Starting Direction",
							uuid = "a38a448e-d3e0-59f9-867f-d8e2576d088e",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruCTHelper == true",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "03292367-87c8-5360-a17d-62ecf88f01e6",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p4CTHourglassInfo ~= nil and data.p4CTHourglassInfo.tetherCount == 4",
							name = "Four Tethers",
							uuid = "c7f575b6-d916-5e32-a53f-64b10e0ebc09",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 802.8,
				name = "时间结晶起步指路",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 4,
				timerStartOffset = -1,
				uuid = "43aecfe9-fdc0-567b-9830-89d66e7e290e",
				version = 2,
			},
		},
	},
	[181] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "51a8a3fb-ca50-54a6-8a2e-2c72dc94d320",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal aoeRadius = 12\nlocal firstDuration = 7166  -- Time until first explosion\nlocal secondDuration = 5355 -- Time for second set\nlocal thirdDuration = 4810  -- Time for third set\n\nlocal hourglasses = TensorCore.entityList(\"contentid=9823\")\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\n\n-- Group tracking \nlocal yellowGroup = {}\nlocal purpleGroup = {}\nlocal noTetherGroup = {}\n\n-- Sort hourglasses into groups\nfor id,glass in pairs(hourglasses) do\n    local tethers = Argus.getTethersOnEnt(id)\n    if table.valid(tethers) then\n        if tethers[1].type == 134 then\n            table.insert(yellowGroup, glass)\n        elseif tethers[1].type == 133 then\n            table.insert(purpleGroup, glass)\n        end\n    else\n        table.insert(noTetherGroup, glass)\n    end\nend\n\n-- Draw all in each group with appropriate timings\nif table.valid(yellowGroup) then\n    for _,glass in pairs(yellowGroup) do\n        drawer:addTimedCircle(firstDuration, glass.pos.x, 0.05, glass.pos.z, aoeRadius, nil, false, nil, 256)\n        \n    end\n    \n    -- Only draw subsequent groups if we found the first\n    for _,glass in pairs(noTetherGroup) do\n        drawer:addTimedCircle(secondDuration, glass.pos.x, 0.05, glass.pos.z, aoeRadius, firstDuration, false, nil, 256)\n    end\n    \n    for _,glass in pairs(purpleGroup) do\n        drawer:addTimedCircle(thirdDuration, glass.pos.x, 0.05, glass.pos.z, aoeRadius, firstDuration + secondDuration, false, nil, 256)\n    end\n    \n    self.used = true\nend\n",
							gVar = "ACR_RikuDNC3_CD",
							name = "Queue Maelstroms",
							uuid = "e175e92e-335b-5a87-9082-6c9cc301e923",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 804.9,
				name = "时间结晶风圈",
				timelineIndex = 181,
				timerOffset = -1.2000000476837,
				timerStartOffset = -1.2000000476837,
				uuid = "a4b02edf-37cc-5170-9042-e6b239818951",
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
							actionLua = "self.used = true",
							conditions = 
							{
								
								{
									"79b71a54-3348-561c-8fee-ea2ef0a30232",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Throttle",
							uuid = "dd61ef35-56bf-57a4-96d1-5b516143a30d",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = MuAiGuide.Reactions.API.getAgnosticPartyList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal waterBuffID = 2461\nlocal stackBuffID = 2454\nlocal aeroBuffID = 2463\nlocal iceBuffID = 2462\nlocal eruptionBuffID = 2460\n\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal moogleDrawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nmoogleDrawer:setGradient(3, 0.15, 2)\nmoogleDrawer:setHeightOffset(0.05)\nlocal fruMoogle2 = TensorCore.getMoogleDrawer()\nlocal aeroDrawer = TensorCore.getCachedDrawer((fruMoogle2.colorStart and fruMoogle2.colorStart % 0x1000000 + 0x4D000000), (fruMoogle2.colorMid and fruMoogle2.colorMid % 0x1000000 + 0x4D000000), (fruMoogle2.colorEnd and fruMoogle2.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\naeroDrawer:setGradient(3, 0.15, 2)\naeroDrawer:setHeightOffset(0.05)\nlocal stackDrawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nstackDrawer:setGradient(3, 0.15, 2)\nstackDrawer:setHeightOffset(0.05)\nlocal drawTime = 5000\n\nlocal function handleBuffDraw(entID)\n    local aeroBuff = TensorCore.getBuff(entID, aeroBuffID)\n    if (aeroBuff ~= nil) then\n        local buffInfo = aeroBuff\n        local delayTime = (buffInfo.duration * 1000) - drawTime\n        aeroDrawer:addTimedCircleOnEnt(5000, entID, 15, delayTime, false, nil, 256)\n        return\n    end\n\n    local iceBuff = TensorCore.getBuff(entID, iceBuffID)\n    if (iceBuff ~= nil) then\n        local buffInfo = iceBuff\n        local delayTime = (buffInfo.duration * 1000) - drawTime\n        moogleDrawer:addTimedDonutOnEnt(5000, entID, 3, 12, delayTime, false, nil, 256)\n        return\n    end\n\n    local eruptionBuff = TensorCore.getBuff(entID, eruptionBuffID)\n    if (eruptionBuff ~= nil) then\n        local buffInfo = eruptionBuff\n        local delayTime = (buffInfo.duration * 1000) - drawTime\n        moogleDrawer:addTimedCircleOnEnt(5000, entID, 6, delayTime, false, nil, 256)\n        return\n    end\n\n    local waterBuff = TensorCore.getBuff(entID, waterBuffID)\n    if (waterBuff ~= nil) then\n        local buffInfo = waterBuff\n        local delayTime = (buffInfo.duration * 1000) - drawTime\n        stackDrawer:addTimedCircleOnEnt(5000, entID, 6, delayTime, false, nil, 256)\n        return\n    end\n\n    local stackBuff = TensorCore.getBuff(entID, stackBuffID)\n    if (stackBuff ~= nil) then\n        local buffInfo = stackBuff\n        local delayTime = (buffInfo.duration * 1000) - drawTime\n        stackDrawer:addTimedCircleOnEnt(5000, entID, 6, delayTime, false, nil, 256)\n        return\n    end\nend\n\n---@diagnostic disable-next-line: param-type-mismatch\nfor _, ent in pairs(party) do\n    handleBuffDraw(ent.id)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"79b71a54-3348-561c-8fee-ea2ef0a30232",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDNC3_CD",
							name = "Queue Debuff Draws",
							uuid = "04f850fe-6750-56c0-8a74-9bf14ae378ae",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 4208,
							category = "Self",
							name = "Have Rewind",
							uuid = "79b71a54-3348-561c-8fee-ea2ef0a30232",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 804.9,
				name = "时间结晶点名范围",
				throttleTime = 1000,
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 2,
				timerStartOffset = -4.5999999046326,
				uuid = "10d07066-f803-50fa-8477-197c500a0f7a",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D15B0DD, nil, 0x4D15B0DD, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedArrowOnEnt(25000, eventArgs.entityID, 3.25, 2, 2, 0, nil, 2500, false, nil, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"10c2d31c-b135-5a06-81cd-37a11a461358",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Dragon Heading",
							uuid = "32a4a79e-62ad-5d3d-a420-5ea935f5c43b",
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
							eventEntityContentID = 9323,
							name = "Content ID",
							uuid = "10c2d31c-b135-5a06-81cd-37a11a461358",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 5,
				loop = true,
				mechanicTime = 804.9,
				name = "龙头行进方向",
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "e3b6bfeb-e709-5b71-ae74-48df549c0d09",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal ent1 = TensorCore.mGetEntity(data.p4DragonHeadID1)\nlocal ent2 = TensorCore.mGetEntity(data.p4DragonHeadID2)\n\nlocal anyStillVisible = false\nlocal playerPos = TensorCore.mGetPlayer().pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\n\nif (ent1 ~= nil and Argus.isEntityVisible(ent1.id)) then\n    local pos = ent1.pos\n    local dist = TensorCore.getDistance2d(playerPos, pos)\n    if (dist < 16) then\n        drawer:addCircle(pos.x, 0.05, pos.z, 12.5, false, 256)\n    end\n    anyStillVisible = true\nend\n\nif (ent2 ~= nil and Argus.isEntityVisible(ent2.id)) then\n    local pos = ent2.pos\n    local dist = TensorCore.getDistance2d(playerPos, pos)\n    if (dist < 16) then\n        drawer:addCircle(pos.x, 0.05, pos.z, 12.5, false, 256)\n    end\n    anyStillVisible = true\nend\n\n-- 短暂无可见龙头不永久停画; 原窗口内每帧继续查询.\n\nself.used = true",
							conditions = 
							{
								
								{
									"328051bd-2f62-571d-8dcc-d20fd2e58fca",
									true,
								},
								
								{
									"da306222-0857-5d6e-b335-64386b48ac44",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw LotL Radius On Nearest",
							uuid = "2b4c6279-8cb6-5559-a2a6-257d97a04d18",
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
							conditionLua = "return data.p4CancelDragonDraw ~= true",
							dequeueIfLuaFalse = true,
							name = "Don't Cancel",
							uuid = "328051bd-2f62-571d-8dcc-d20fd2e58fca",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 3263,
							category = "Lua",
							conditionLua = "return data.p4CTPlayerRed == false",
							dequeueIfLuaFalse = true,
							name = "Not Red",
							uuid = "da306222-0857-5d6e-b335-64386b48ac44",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 804.9,
				name = "光之海浪范围",
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 25,
				timerStartOffset = 5,
				uuid = "ee800b05-2a50-5536-b224-98545aa44bda",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal buffInfo = TensorCore.getBuff(TensorCore.mGetPlayer().id, 2461)\nlocal drawTime = 3000\nlocal drawDelay = (buffInfo.duration * 1000) - drawTime\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(drawTime, data.p4FragmentID, data.p4FragmentHitRadius + 6, drawDelay, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"de7d7d1b-6dac-58d4-aa4b-f2183bd970d7",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Water Exclusion Zone",
							uuid = "e232e77e-fb73-5178-b991-8ff88b8dd57e",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal buffInfo = TensorCore.getBuff(TensorCore.mGetPlayer().id, 2454)\nlocal drawTime = 3000\nlocal drawDelay = (buffInfo.duration * 1000) - drawTime\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(drawTime, data.p4FragmentID, data.p4FragmentHitRadius + 6, drawDelay, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"9cd7c0f9-830f-5fa0-8b96-a69f712d6d63",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Stack Exclusion Zone",
							uuid = "4d1cb7b2-0f6a-562b-8e80-a88b0658be86",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal buffInfo = TensorCore.getBuff(TensorCore.mGetPlayer().id, 2462)\nlocal drawTime = 3000\nlocal drawDelay = (buffInfo.duration * 1000) - drawTime\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(drawTime, data.p4FragmentID, data.p4FragmentHitRadius + 12, drawDelay, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"f6ca056c-4ae1-5d10-bf29-09e6d20fe4cb",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Ice Exclusion Zone",
							uuid = "125eee2b-b916-504b-a2bf-577d82e449a0",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal buffInfo = TensorCore.getBuff(TensorCore.mGetPlayer().id, 2460)\nlocal drawTime = 3000\nlocal drawDelay = (buffInfo.duration * 1000) - drawTime\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(drawTime, data.p4FragmentID, data.p4FragmentHitRadius + 6, drawDelay, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"e1efc307-fbff-5081-b8d0-45c69271f9bc",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Eruption Exclusion Zone",
							uuid = "a1519dcf-338c-55ef-8d88-335d2ef599fa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 2461,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Has Water",
							uuid = "de7d7d1b-6dac-58d4-aa4b-f2183bd970d7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 2454,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Has Stack",
							uuid = "9cd7c0f9-830f-5fa0-8b96-a69f712d6d63",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 2462,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Has Ice",
							uuid = "f6ca056c-4ae1-5d10-bf29-09e6d20fe4cb",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 2460,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Has Eruption",
							uuid = "e1efc307-fbff-5081-b8d0-45c69271f9bc",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 804.9,
				name = "碎片避让范围",
				timeRange = true,
				timelineIndex = 181,
				timerEndOffset = 4,
				timerOffset = -3.5,
				timerStartOffset = -4,
				uuid = "0114dec7-cfc3-5299-92d1-98a03ad7cb85",
				version = 2,
			},
		},
	},
	[182] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "53b44d6a-391f-5df3-b533-061672ab314a",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal player = TensorCore.mGetPlayer()\nlocal party = MuAiGuide.Reactions.API.getAgnosticPartyList(\"Party\")\nif not player or not table.valid(party) then\n    self.used = true\n    return\nend\n\nlocal targetEnt = nil\nfor _, ent in pairs(party) do\n    if ent.id ~= player.id and TensorCore.hasBuff(ent, 2460) then\n        if (player.pos.x > 100 and ent.pos.x > 100) or (player.pos.x < 100 and ent.pos.x < 100) then\n            targetEnt = ent\n            break\n        end\n    end\nend\n\nif targetEnt then\n    local drawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    drawer:addTimedArrowOnEnt(5000, player.id, 3, 0.4, nil, nil, targetEnt.id, 0, false, nil, nil, 256)\n    MuAiGuide.Reactions.Shotcall(\"Stack after dragon\", true)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"f98e9943-a9df-5fec-927f-e4355ec4f002",
									true,
								},
							},
							gVar = "ACR_TensorMagnum3_CD",
							uuid = "cb2e55e1-7b4f-5579-9904-6a29c57c6882",
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
							conditionLua = "return data.p4CTPlayerRed == true",
							name = "isRedIce",
							uuid = "f98e9943-a9df-5fec-927f-e4355ec4f002",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 808.6,
				name = "时间结晶分摊提醒",
				timelineIndex = 182,
				uuid = "b87cf2f2-8883-5077-b836-22726ff9ed60",
				version = 2,
			},
		},
	},
	[184] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "5b1e23dc-3229-527b-b708-6b79ddb8d5ad",
			},
			objectType = "folder",
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
							actionLua = "---@type integer[]\nlocal partyIDs = data.partyIDArray\nfor i = 1, 8 do\n    local id = partyIDs[i]\n    if (TensorCore.hasBuff(id, 2463)) then\n        if (data.p4AeroID1 == nil) then\n            data.p4AeroID1 = id\n        else\n            data.p4AeroID2 = id\n            break\n        end\n    end\nend\n\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Aeros",
							uuid = "e93f5c6e-21b5-5542-9476-45cfa0e29218",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 813.7,
				name = "记录风点名",
				timelineIndex = 184,
				timerOffset = -5,
				uuid = "033b2a7a-a9e2-5ef5-95df-dc2a4b7e2e9f",
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
							actionLua = "if (data.p4LongingPositions == nil) then\n    ---@type ThreeDimensionalPos[]\n    data.p4LongingPositions = {}\n    data.p4LongingCount = 0\nend\nlocal count = data.p4LongingCount + 1\ndata.p4LongingCount = count\n\nlocal pos = { x = eventArgs.castPosX, y = 0, z = eventArgs.castPosZ }\ntable.insert(data.p4LongingPositions, pos)\n\nself.used = true",
							conditions = 
							{
								
								{
									"b5bc1c3d-fb60-51d1-858d-6135458383e2",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record LotL Pos",
							uuid = "bb6e6e6f-03aa-5247-b96a-a13d5c85ff41",
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
							eventSpellID = 40241,
							name = "Cast ID",
							uuid = "b5bc1c3d-fb60-51d1-858d-6135458383e2",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 2,
				loop = true,
				mechanicTime = 813.7,
				name = "记录光之海浪落点",
				timeRange = true,
				timelineIndex = 184,
				timerEndOffset = 20,
				timerStartOffset = -5,
				uuid = "eab09f26-24c3-5668-8b42-074c7dce6df3",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "b6e0e1c6-415d-59dd-8f16-16c0573114ae",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal drawTime = (835.3 - TensorReactions_CurrentTimer) * 1000\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D0000FF, nil, 0x4D0000FF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircle(drawTime, eventArgs.castPosX, 0.05, eventArgs.castPosZ, 1, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"62f6bc69-93e8-5642-8776-55f0fb5f34d1",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Draw Puddle Zone",
							uuid = "71cc1477-1eab-52ca-af67-465b04b1e494",
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
							eventSpellID = 40241,
							name = "Cast ID",
							uuid = "62f6bc69-93e8-5642-8776-55f0fb5f34d1",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				loop = true,
				mechanicTime = 813.7,
				name = "时间结晶放圈",
				timeRange = true,
				timelineIndex = 184,
				timerEndOffset = 30,
				timerStartOffset = -6,
				uuid = "94939eef-2081-51ec-83fa-9a7360553441",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nif (data.p4LongingHelperPuddleCount == nil) then\n    data.p4LongingHelperPuddleCount = 0\n    data.p4CleanseDraws = {}\nend\n\nlocal count = data.p4LongingHelperPuddleCount + 1\ndata.p4LongingHelperPuddleCount = count\nlocal xPos = eventArgs.castPosX\nlocal zPos = eventArgs.castPosZ\nlocal drawTime = (835.3 - TensorReactions_CurrentTimer) * 1000\nlocal isWest = xPos < 100\nlocal firstTwo = count <= 2\n-- Low count means west/east.\n-- Eruption grabs west, Stack grabs east.\nlocal drawForEruption = firstTwo and isWest and data.p4CTPlayerEruption\nlocal drawForStack = firstTwo and not isWest and data.p4CTPlayerStack\n-- High count means sw/se.\n-- Ice grabs SW, water grabs SE.\nlocal drawForIce = not firstTwo and isWest and data.p4CTPlayerIce\nlocal drawForWater = not firstTwo and not isWest and data.p4CTPlayerWater\n\nif (drawForEruption or drawForStack or drawForIce or drawForWater) then\n    local fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\n    fruMuai1:setGradient(3, 0.15, 2)\n    fruMuai1:setHeightOffset(0.05)\n    local uuid1 = fruMuai1:addTimedCircle(drawTime, xPos, 0.05, zPos, 1, 0, false, nil, 256)\n    table.insert(data.p4CleanseDraws, uuid1)\n    local fruMuai2 = TensorCore.getCachedDrawer(0x4DFF00FF, nil, 0x4DFF00FF, 0xFFFFFFFF, 2, 0, 256)\n    fruMuai2:setGradient(3, 0.15, 2)\n    fruMuai2:setHeightOffset(0.05)\n    local uuid2 = fruMuai2:addTimedCircle(drawTime, xPos, 0.05, zPos, 0.25, 9, false, nil, 256)\n    table.insert(data.p4CleanseDraws, uuid2)\n    local lineColor = 2667642624 --G255 A159\n    local playerID = TensorCore.mGetPlayer().id\n    local uuid3 = Argus2.addTimedRectFilled(drawTime, xPos, 0.05, zPos, 20, 0.225, 0, (lineColor % 0x1000000 + 0x4D000000), (lineColor % 0x1000000 + 0x4D000000), nil, 0, nil, playerID, false, 0xFFFFFFFF, 2, 3, 0.15, 2, false, nil, nil, nil, 256, nil, nil, nil, nil)\n    table.insert(data.p4CleanseDraws, uuid3)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"115a9690-3cfa-5b14-8059-f676ac6f380f",
									true,
								},
								
								{
									"296d6473-2441-554d-a1b5-8b4329866a60",
									true,
								},
								
								{
									"f5f85b34-3e16-59c9-87bc-11813950cfc4",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Try Highlight Puddle",
							uuid = "aad3ef18-2fc1-52c7-b901-5da4adebcc68",
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
							eventSpellID = 40241,
							name = "Cast ID",
							uuid = "115a9690-3cfa-5b14-8059-f676ac6f380f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							buffID = 3264,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Is Blue",
							uuid = "296d6473-2441-554d-a1b5-8b4329866a60",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruCTHelper == true",
							dequeueIfLuaFalse = true,
							name = "Option Enabled",
							uuid = "f5f85b34-3e16-59c9-87bc-11813950cfc4",
							version = 3,
						},
						inheritedIndex = 3,
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				loop = true,
				mechanicTime = 813.7,
				name = "放圈接圈指路",
				timeRange = true,
				timelineIndex = 184,
				timerEndOffset = 30,
				timerStartOffset = -6,
				uuid = "86049aec-43e1-588c-babe-07d49f011746",
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
							actionLua = "local uuidArray = data.p4CleanseDraws\nif (data.p4CleanseDraws == nil) then\n    self.used = true\n    return\nend\nlocal arrayCount = #data.p4CleanseDraws\nfor i = 1, arrayCount do\n    local uuid = uuidArray[i]\n    if (uuid ~= nil) then\n        Argus.deleteTimedShape(uuid)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"49ed262a-cf20-53ec-ad5d-2abb68e9a3b8",
									true,
								},
								
								{
									"300477a8-cbf1-5a73-adad-d56f5c9e5a8b",
									true,
								},
								
								{
									"d265e564-52f9-542f-aee1-34077af72743",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Remove Puddle Draws",
							uuid = "1e9246b9-9951-5b6d-913f-dabdab1091f8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"300477a8-cbf1-5a73-adad-d56f5c9e5a8b",
									true,
								},
								
								{
									"d265e564-52f9-542f-aee1-34077af72743",
									true,
								},
							},
							name = "Cleansed",
							partyTargetNumber = 0,
							uuid = "49ed262a-cf20-53ec-ad5d-2abb68e9a3b8",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p4CTPlayerBlue == true",
							name = "Was Blue",
							uuid = "300477a8-cbf1-5a73-adad-d56f5c9e5a8b",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							buffCheckType = 2,
							buffID = 3264,
							category = "Self",
							name = "No Blue",
							uuid = "d265e564-52f9-542f-aee1-34077af72743",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 813.7,
				name = "清除放圈预兆",
				timeRange = true,
				timelineIndex = 184,
				timerEndOffset = 30,
				timerStartOffset = -1,
				uuid = "d6cd8076-3c33-5989-a557-5707eca9b5d6",
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
							actionLua = "-- 暴风半径 15 米, 击退 30 米: 从风点名位置到本人的方向投影.\nlocal wind1 = data.p4AeroID1 and TensorCore.mGetEntity(data.p4AeroID1)\nlocal wind2 = data.p4AeroID2 and TensorCore.mGetEntity(data.p4AeroID2)\nlocal playerPos = TensorCore.mGetPlayer().pos\n        local fruMuai1 = TensorCore.getCachedDrawer(0x4D0000FF, nil, 0x4D0000FF, 0xFFFFFFFF, 2, 0, 256)\n        fruMuai1:setGradient(3, 0.15, 2)\n        fruMuai1:setHeightOffset(0.05)\n        local fruMuai2 = TensorCore.getCachedDrawer(0x4D00DD00, nil, 0x4D00DD00, 0xFFFFFFFF, 2, 0, 256)\n        fruMuai2:setGradient(3, 0.15, 2)\n        fruMuai2:setHeightOffset(0.05)\n        local fruMuai3 = TensorCore.getCachedDrawer(0x4D0000FF, nil, 0x4D0000FF, 0xFFFFFFFF, 2, 0, 256)\n        fruMuai3:setGradient(3, 0.15, 2)\n        fruMuai3:setHeightOffset(0.05)\n        local fruMuai4 = TensorCore.getCachedDrawer(0x4D00DD00, nil, 0x4D00DD00, 0xFFFFFFFF, 2, 0, 256)\n        fruMuai4:setGradient(3, 0.15, 2)\n        fruMuai4:setHeightOffset(0.05)\nif wind1 then\n    local pos = wind1.pos\n    local distance = TensorCore.getDistance2d(pos, playerPos)\n    if distance <= 15 then\n        local heading = TensorCore.getHeadingToTarget(pos, playerPos)\n        local length = distance + 30\n        local x, _, z = TensorCore.getPosInDirection(pos, heading, length, true)\n        local dx, dz = x - 100, z - 100\n        if dx * dx + dz * dz >= 395 then\n            fruMuai1:addArrow(pos.x, 0.05, pos.z, heading, length - 2, 0.25, 2, nil, false, 256)\n        else\n            fruMuai2:addArrow(pos.x, 0.05, pos.z, heading, length - 2, 0.25, 2, nil, false, 256)\n        end\n    end\nend\nif wind2 then\n    local pos = wind2.pos\n    local distance = TensorCore.getDistance2d(pos, playerPos)\n    if distance <= 15 then\n        local heading = TensorCore.getHeadingToTarget(pos, playerPos)\n        local length = distance + 30\n        local x, _, z = TensorCore.getPosInDirection(pos, heading, length, true)\n        local dx, dz = x - 100, z - 100\n        if dx * dx + dz * dz >= 395 then\n            fruMuai3:addArrow(pos.x, 0.05, pos.z, heading, length - 2, 0.25, 2, nil, false, 256)\n        else\n            fruMuai4:addArrow(pos.x, 0.05, pos.z, heading, length - 2, 0.25, 2, nil, false, 256)\n        end\n    end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"7e99a2f8-8a17-5960-83ab-9abea0b404ef",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Draw Aero KB",
							uuid = "f8983444-f8f3-5082-b1f8-d88dda6ccd78",
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
							buffID = 2463,
							category = "Self",
							dequeueIfLuaFalse = true,
							name = "Not Aero",
							uuid = "7e99a2f8-8a17-5960-83ab-9abea0b404ef",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 813.7,
				name = "风点名击退方向",
				timeRange = true,
				timelineIndex = 184,
				timerEndOffset = 0.10000000149012,
				timerStartOffset = -2.5,
				uuid = "f02c6d8e-1bd3-58ba-866c-3d3c79526907",
				version = 2,
			},
		},
	},
	[188] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "88a6bac5-cc8e-5cda-9d0b-11b7e17a04f0",
			},
			objectType = "folder",
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
							actionLua = "if (data.p4WingPositions == nil) then\n    ---@type ThreeDimensionalPos[]\n    data.p4WingPositions = {}\n    data.p4WingCount = 0\nend\n\ndata.p4WingCount = data.p4WingCount + 1\n---@type ThreeDimensionalPos\nlocal pos = { x = eventArgs.castPosX, y = 0, z = eventArgs.castPosZ }\ntable.insert(data.p4WingPositions, pos)\nself.used = true",
							conditions = 
							{
								
								{
									"61d2859f-6edb-5205-934a-a1e033906bad",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "Record Wing Direction",
							uuid = "b82b458a-3f9b-52a7-8d13-539738f185c0",
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
							eventSpellID = 40175,
							name = "Cast ID",
							uuid = "61d2859f-6edb-5205-934a-a1e033906bad",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 2,
				loop = true,
				mechanicTime = 816.7,
				name = "记录神圣之翼方向",
				timeRange = true,
				timelineIndex = 188,
				timerEndOffset = 10,
				timerStartOffset = -4,
				uuid = "57cb35ec-1121-5ed6-ad66-f0b787672a52",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "f8d405eb-edf8-510b-9f29-4b4bb59d46be",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif (data.arenaCenter == nil) then\n    data.arenaCenter = { x = 100, y = 0, z = 100 }\nend\n\nlocal wingPosArray = data.p4WingPositions\nlocal center = data.arenaCenter\nlocal betweenH = TensorCore.Avoidance.getHeadingBetweenPos(center, wingPosArray[1], wingPosArray[2])\nlocal adjustRad = math.rad(12.5)\nlocal mainPos = TensorCore.getPosInDirection(center, betweenH, 20)\nlocal g1Pos = TensorCore.getPosInDirection(center, betweenH + adjustRad, 16.5)\nlocal g2Pos = TensorCore.getPosInDirection(center, betweenH - adjustRad, 16.5)\nMuAiGuide.Reactions.addTimedWorldText(20000, \"Rewinds\", mainPos, 4294836136, true, 3)\nMuAiGuide.Reactions.addTimedWorldText(20000, \"G1\", g1Pos, 4294836136, true, 2)\nMuAiGuide.Reactions.addTimedWorldText(20000, \"G2\", g2Pos, 4294836136, true, 2)\nself.used = true",
							conditions = 
							{
								
								{
									"822a1fb3-c18d-5543-958c-20f9f5829ce7",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							name = "WorldText Rewind Corner",
							uuid = "d914fcfd-8723-52cb-8604-a4e0878f2215",
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
							conditionLua = "return data.p4WingCount == 2",
							name = "Wings Recorded",
							uuid = "822a1fb3-c18d-5543-958c-20f9f5829ce7",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				mechanicTime = 816.7,
				name = "回返角落指路",
				timeRange = true,
				timelineIndex = 188,
				timerEndOffset = 10,
				timerStartOffset = 4,
				uuid = "2a2b56da-901a-5b3e-8dc1-31b92f72424a",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nif (data.arenaCenter == nil) then data.arenaCenter = {x=100,y=0,z=100} end\nlocal drawTime = 11500\nlocal cen = data.arenaCenter\nlocal wingArr = data.p4WingPositions\nlocal pos1 = wingArr[1]\nlocal pos2 = wingArr[2]\nlocal h1 = TensorCore.getHeadingToTarget(cen, pos1)\nlocal h2 = TensorCore.getHeadingToTarget(cen, pos2)\nlocal truePos1 = TensorCore.getPosInDirection(cen, h1, 20)\nlocal truePos2 = TensorCore.getPosInDirection(cen, h2, 20)\nlocal betweenH = TensorCore.Avoidance.getHeadingBetweenPos(cen, truePos1, truePos2)\nlocal x, _, z = TensorCore.getPosInDirection(cen, betweenH, 14.1421, true)\nlocal drawer = TensorCore.getCachedDrawer(0x4D00F400, nil, 0x4D00F400, 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedCenteredRect(drawTime, x, 0.05, z, 10.25, 10.25, betweenH, nil, false, nil, 256)\ndrawer:addTimedArrow(drawTime, 100, 0.05, 100, betweenH, 13, 0.5, 1.1421, nil, 0, false, 256)\n-- reset to original values\nself.used = true",
							conditions = 
							{
								
								{
									"483d0125-d470-5552-905a-5cdc89fb0505",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Wing Overlap",
							uuid = "609716ae-a2b2-5f97-a58c-0ad92943aa43",
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
							conditionLua = "return data.p4WingCount == 2",
							name = "Wings Recorded",
							uuid = "483d0125-d470-5552-905a-5cdc89fb0505",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				mechanicTime = 816.7,
				name = "回溯重叠安全区",
				timeRange = true,
				timelineIndex = 188,
				timerEndOffset = 10,
				timerStartOffset = 4,
				uuid = "fee0685f-5d2e-5c1b-bdef-98814bb78dff",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Soak Dragon Head\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"c57f4fcc-8b0b-5357-854e-f6cf2f670ae2",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "226e7cd6-7c4c-5ec3-a701-938c4f540e82",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 3263,
							category = "Self",
							name = "Has Red",
							uuid = "c57f4fcc-8b0b-5357-854e-f6cf2f670ae2",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 816.7,
				name = "接龙头播报",
				timelineIndex = 188,
				timerOffset = -0.5,
				uuid = "a25ae8f4-9064-5c42-bf4e-97f05ef4a5ff",
				version = 2,
			},
		},
	},
	[192] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "998ada32-a970-52e2-928b-c3871b0054ae",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Spread\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"cebfc0eb-6747-5c53-80ef-cd5936cd402c",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "440a5262-d051-5e2c-99b0-4f11ecf5cbe8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffID = 2452,
							category = "Self",
							uuid = "cebfc0eb-6747-5c53-80ef-cd5936cd402c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 830.1,
				name = "放回返后分散播报",
				timeRange = true,
				timelineIndex = 192,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "2cd72101-700f-54e5-80bb-a4105529ddcf",
				version = 2,
			},
		},
	},
	[194] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "d403f704-e826-5158-8f0f-b5f2fe3d3aed",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif (not table.valid(party)) then\n    self.used = true\n    return\nend\n\nlocal timeToMech = 3375\nlocal drawTime = 3000\nlocal delayTime = timeToMech - drawTime\nlocal playerID = TensorCore.mGetPlayer().id\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nfor _, ent in pairs(party) do\n    if (ent.id ~= playerID) then\n        drawer:addTimedCircleOnEnt(drawTime, ent.id, 5, delayTime, false, nil, 256)\n    end\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0c11f525-cbfa-51d0-aeaf-4aff55fdd91d",
									true,
								},
							},
							gVar = "ACR_RikuDNC3_CD",
							name = "Draw Spread",
							uuid = "31053f03-075e-562e-a818-2832bcbe3626",
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
							eventSpellID = 40288,
							name = "Channel ID",
							uuid = "0c11f525-cbfa-51d0-aeaf-4aff55fdd91d",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 835.3,
				name = "碎灵一击分散范围",
				timeRange = true,
				timelineIndex = 194,
				timerEndOffset = -1,
				timerStartOffset = -6,
				uuid = "3d1cad7f-2c18-5129-a6ee-9993673d3903",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircleOnEnt(4000, data.p4FragmentID, data.p4FragmentHitRadius + 5, nil, false, nil, 256)\nself.used = true",
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Fragment Exclusion Zone",
							uuid = "e232e77e-fb73-5178-b991-8ff88b8dd57e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				mechanicTime = 835.3,
				name = "碎片避让范围",
				timelineIndex = 194,
				timerOffset = -4,
				uuid = "8989f0ab-f634-59f0-bcd2-61f7ad945733",
				version = 2,
			},
		},
	},
	[201] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "a4235fea-6179-5b51-83a7-61c968e75558",
			},
			objectType = "folder",
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
									"a1149ea4-b9fa-5022-812e-00f7807d7c70",
									true,
								},
								
								{
									"8dfc223a-a42b-5cce-945a-236d694de158",
									false,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							setTarget = true,
							targetType = "Enemy",
							uuid = "6213dab8-e9dc-5c18-841e-d6aa64f63ca4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Find Boss",
							uuid = "a1149ea4-b9fa-5022-812e-00f7807d7c70",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Current Target",
							name = "Target Filter",
							uuid = "8dfc223a-a42b-5cce-945a-236d694de158",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "核心逻辑",
				mechanicTime = 850.2,
				name = "选中首领",
				timeRange = true,
				timelineIndex = 201,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "8718c413-05cf-5959-9b98-99f51b23443e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "目标选择",
				uuid = "a4cda674-afbe-7508-0e5c-f816ae7011c4",
			},
			objectType = "folder",
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
									"3dd74168-b09e-44e9-9b29-75462afa1e3c",
									true,
								},
								
								{
									"09873c63-53ae-6f8e-a099-88a6361412f3",
									true,
								},
							},
							name = "选中目标",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "c96abd7e-4f69-ca8c-b2d8-41bc0bb68796",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"c3f752ee-1ab7-e4fe-aca1-3501cc806292",
									true,
								},
							},
							filterTargetSubtype = "Highest HP",
							filterTargetType = "Enemy",
							name = "范围内最高血量目标",
							uuid = "09873c63-53ae-6f8e-a099-88a6361412f3",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "近战输出职业",
							partyTargetType = "Melee DPS",
							uuid = "3dd74168-b09e-44e9-9b29-75462afa1e3c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							comparator = 2,
							conditionType = 4,
							inRangeValue = 9.125,
							name = "近战距离检查",
							partyTargetType = "Detection Target",
							uuid = "c3f752ee-1ab7-e4fe-aca1-3501cc806292",
							version = 3,
						},
					},
				},
				displayPath = "目标选择",
				loop = true,
				mechanicTime = 850.2,
				name = "近战优先高血量",
				throttleTime = 1500,
				timeRange = true,
				timelineIndex = 201,
				timerEndOffset = 36,
				uuid = "90b7875e-ea4e-a63e-89b8-4cfac5ee9980",
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
									"aa6c173d-437c-f9bf-80b2-c92be07bffa9",
									true,
								},
								
								{
									"60e3d2d2-3e73-a272-b69c-2201c986f8f5",
									true,
								},
							},
							name = "选中目标",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "3d9645f6-d60b-e013-9522-6674dffedc59",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"ad9dad45-6ffc-44c0-9cde-812a70bec782",
									true,
								},
								
								{
									"5b155c1d-e145-34da-b764-fefa297fb8d4",
									true,
								},
							},
							dequeueIfLuaFalse = true,
							matchAnyBuff = true,
							name = "远程输出或治疗",
							partyTargetNumber = 0,
							uuid = "aa6c173d-437c-f9bf-80b2-c92be07bffa9",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							name = "远程输出职业",
							partyTargetType = "Ranged DPS",
							uuid = "ad9dad45-6ffc-44c0-9cde-812a70bec782",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 9,
							name = "治疗职业",
							partyTargetType = "Healer",
							uuid = "5b155c1d-e145-34da-b764-fefa297fb8d4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							conditions = 
							{
								
								{
									"0a778f3a-6fa4-b2cb-9a3d-f3f2e269ea6b",
									true,
								},
							},
							filterTargetSubtype = "Highest HP",
							filterTargetType = "Enemy",
							name = "范围内最高血量敌人",
							uuid = "60e3d2d2-3e73-a272-b69c-2201c986f8f5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Party",
							comparator = 2,
							conditionType = 4,
							inRangeValue = 31.125,
							name = "远程距离检查",
							partyTargetType = "Detection Target",
							uuid = "0a778f3a-6fa4-b2cb-9a3d-f3f2e269ea6b",
							version = 3,
						},
					},
				},
				displayPath = "目标选择",
				loop = true,
				mechanicTime = 850.2,
				name = "远程治疗优先高血量",
				throttleTime = 1500,
				timeRange = true,
				timelineIndex = 201,
				timerEndOffset = 36,
				uuid = "e181ae7f-610b-c638-b56a-d733739c493f",
				version = 2,
			},
		},
	},
	[202] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "af2cc642-bc2b-5b35-b705-fcdfd2d0b890",
			},
			objectType = "folder",
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
							actionLua = "-- FRU 光巫女死亡轮回: 每次 OnFrame 更新读取对应首领当前目标, 不固定画在本人.\nlocal remaining = (859.2 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUTankStacks\nif rounds == nil then\n    rounds = {}\n    data.StringFRUTankStacks = rounds\nend\nlocal state = rounds[\"202_p4UsurperID\"]\nif state == nil then state = {}; rounds[\"202_p4UsurperID\"] = state end\nif remaining <= 0 then\n    if state.draw then Argus.deleteTimedShape(state.draw) end\n    state.draw = nil\n    self.used = true\n    return\nend\n\nlocal bossID = data.p4UsurperID\nif bossID == nil then self.used = true; return end\nlocal boss = TensorCore.mGetEntity(bossID)\nif boss == nil then self.used = true; return end\nlocal target = TensorCore.mGetEntity(boss.targetid)\n-- 自身读条时目标可能暂时为首领/未可读; 只保留本轮最后有效的玩家附着.\nif target == nil or target.contentid ~= 0 then self.used = true; return end\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4DFFFFFF, nil, 0x4DFFFFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\nif state.draw and state.targetID ~= target.id then\n    if not drawer:updateTimedCircleOnEnt(state.draw, nil, target.id) then state.draw = nil end\nend\nif state.draw == nil then\n    state.draw = drawer:addTimedCircleOnEnt(remaining, target.id, 4, 0, false, true, 256)\nend\nif state.draw then state.targetID = target.id end\nself.used = true\n",
							gVar = "ACR_TensorViper3_CD",
							name = "跟随首领当前分摊目标",
							uuid = "01824758-6523-5e1e-8cc6-d11b00256d2e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 854.9,
				name = "光巫女死亡轮回",
				timeRange = true,
				timelineIndex = 202,
				timerEndOffset = 4.3,
				timerStartOffset = -4,
				uuid = "200f885c-e383-5ce0-b022-9bcf67d62d3b",
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
							actionLua = "-- FRU 暗巫女死亡轮回: 每次 OnFrame 更新读取对应首领当前目标, 不固定画在本人.\nlocal remaining = (859.2 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUTankStacks\nif rounds == nil then\n    rounds = {}\n    data.StringFRUTankStacks = rounds\nend\nlocal state = rounds[\"202_p4OracleID\"]\nif state == nil then state = {}; rounds[\"202_p4OracleID\"] = state end\nif remaining <= 0 then\n    if state.draw then Argus.deleteTimedShape(state.draw) end\n    state.draw = nil\n    self.used = true\n    return\nend\n\nlocal bossID = data.p4OracleID\nif bossID == nil then self.used = true; return end\nlocal boss = TensorCore.mGetEntity(bossID)\nif boss == nil then self.used = true; return end\nlocal target = TensorCore.mGetEntity(boss.targetid)\n-- 自身读条时目标可能暂时为首领/未可读; 只保留本轮最后有效的玩家附着.\nif target == nil or target.contentid ~= 0 then self.used = true; return end\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\nif state.draw and state.targetID ~= target.id then\n    if not drawer:updateTimedCircleOnEnt(state.draw, nil, target.id) then state.draw = nil end\nend\nif state.draw == nil then\n    state.draw = drawer:addTimedCircleOnEnt(remaining, target.id, 4, 0, false, true, 256)\nend\nif state.draw then state.targetID = target.id end\nself.used = true\n",
							gVar = "ACR_TensorViper3_CD",
							name = "跟随首领当前分摊目标",
							uuid = "01824758-6523-5e1e-8cc6-d11b00256d2e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 854.9,
				name = "暗巫女死亡轮回",
				timeRange = true,
				timelineIndex = 202,
				timerEndOffset = 4.3,
				timerStartOffset = -4,
				uuid = "ca912b40-50bc-5af2-8daf-3b90be788429",
				version = 2,
			},
		},
	},
	[204] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "97762702-997f-59ee-a432-be1a3292e253",
			},
			objectType = "folder",
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
							actionLua = "-- FRU 无尽顿悟分摊: 每次 OnFrame 更新读取对应首领当前目标, 不固定画在本人.\nlocal remaining = (865.8 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUTankStacks\nif rounds == nil then\n    rounds = {}\n    data.StringFRUTankStacks = rounds\nend\nlocal state = rounds[\"204_p4UsurperID\"]\nif state == nil then state = {}; rounds[\"204_p4UsurperID\"] = state end\nif remaining <= 0 then\n    if state.draw then Argus.deleteTimedShape(state.draw) end\n    state.draw = nil\n    self.used = true\n    return\nend\n\nlocal bossID = data.p4UsurperID\nif bossID == nil then self.used = true; return end\nlocal boss = TensorCore.mGetEntity(bossID)\nif boss == nil then self.used = true; return end\nlocal target = TensorCore.mGetEntity(boss.targetid)\n-- 自身读条时目标可能暂时为首领/未可读; 只保留本轮最后有效的玩家附着.\nif target == nil or target.contentid ~= 0 then self.used = true; return end\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4DFFFFFF, nil, 0x4DFFFFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\nif state.draw and state.targetID ~= target.id then\n    if not drawer:updateTimedCircleOnEnt(state.draw, nil, target.id) then state.draw = nil end\nend\nif state.draw == nil then\n    state.draw = drawer:addTimedCircleOnEnt(remaining, target.id, 4, 0, false, true, 256)\nend\nif state.draw then state.targetID = target.id end\nself.used = true\n",
							gVar = "ACR_RikuDNC3_CD",
							name = "跟随首领当前分摊目标",
							uuid = "aac198ce-9893-5ce5-938d-4c9015009161",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 864.8,
				name = "无尽顿悟分摊",
				timeRange = true,
				timelineIndex = 204,
				timerEndOffset = 1,
				timerOffset = -5.1999998092651,
				timerStartOffset = -6,
				uuid = "30ea7a2f-5137-57bc-863d-9d9da5bf5a92",
				version = 2,
			},
		},
	},
	[207] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "73939a17-7eda-54be-a8da-2d7fef1dd24c",
			},
			objectType = "folder",
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
									"a1149ea4-b9fa-5022-812e-00f7807d7c70",
									true,
								},
								
								{
									"8dfc223a-a42b-5cce-945a-236d694de158",
									false,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							setTarget = true,
							targetType = "Enemy",
							uuid = "6213dab8-e9dc-5c18-841e-d6aa64f63ca4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Find Boss",
							uuid = "a1149ea4-b9fa-5022-812e-00f7807d7c70",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							conditionType = 3,
							filterTargetType = "Current Target",
							hpType = 2,
							hpValue = 2,
							name = "Target Exists",
							uuid = "8dfc223a-a42b-5cce-945a-236d694de158",
							version = 3,
						},
						inheritedIndex = 2,
					},
				},
				displayPath = "核心逻辑",
				loop = true,
				mechanicTime = 972.3,
				name = "选中首领",
				timeRange = true,
				timelineIndex = 207,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "4605bde3-721e-5ff0-b512-4afb3641241e",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nlocal tanks = TensorCore.getEntityGroupList(\"Tank\")\nif (tanks == nil or not table.valid(tanks)) then\n    MuAiGuide.Reactions.log(\"[P5 Invuln Order] Tanks returned invalid table!\", 5)\n    self.used = true\n    return\nend\n\nlocal tank1, tank2 = nil, nil\nfor _, ent in pairs(tanks) do\n    if (tank1 == nil) then\n        tank1 = ent\n    elseif (tank2 == nil) then\n        tank2 = ent\n    else\n        MuAiGuide.Reactions.log(\"[P5 Invuln Order] More than two tanks? Huh!?\", 5)\n    end\nend\n\nif (tank1 == nil or tank2 == nil) then\n    MuAiGuide.Reactions.log(\"[P5 Invuln Order] A tank was left nil!\", 5)\n    self.used = true\n    return\nend\n\nlocal invulnPriority = {\n    [21] = 1, -- WAR\n    [19] = 2, -- PLD\n    [37] = 3, -- GNB\n    [32] = 4, -- DRK\n}\n\nlocal p1 = invulnPriority[tank1.job]\nlocal p2 = invulnPriority[tank2.job]\n\n---@type GameObject\nlocal invuln1 = nil\n---@type GameObject\nlocal invuln2 = nil\n\nif p1 < p2 then\n    invuln1, invuln2 = tank1, tank2\nelse\n    invuln1, invuln2 = tank2, tank1\nend\n\ndata.p5Invuln1 = invuln1.id\ndata.p5Invuln2 = invuln2.id\ndata.selfTankLB = false\n\nlocal player = TensorCore.mGetPlayer()\nif (MuAiGuide.Reactions.tankJobs[player.job]) then\n    local limitBreakPriority = {\n        [21] = 1, -- WAR\n        [32] = 2, -- DRK\n        [19] = 3, -- PLD\n        [37] = 4, -- GNB\n    }\n    local lbPrio1 = limitBreakPriority[tank1.job]\n    local lbPrio2 = limitBreakPriority[tank2.job]\n    ---@type GameObject\n    local lbEnt = nil\n\n    if (lbPrio1 < lbPrio2) then\n        lbEnt = tank1\n    else\n        lbEnt = tank2\n    end\n\n    local playerID = player.id\n    if (data.p5Invuln1 == playerID) then\n        data.p5SelfInvuln = 1\n    elseif (data.p5Invuln2 == playerID) then\n        data.p5SelfInvuln = 2\n    else\n        MuAiGuide.Reactions.log(\"[P5 Invuln Order] Player was a tank, but didn't match either invuln ent!?\", 5)\n    end\n\n    if (lbEnt.id == playerID) then\n        data.selfTankLB = true\n    end\nend\n\nself.used = true",
							gVar = "ACR_RikuGNB3_CD",
							name = "Store Tank Order",
							uuid = "527f6be6-17af-50e3-8593-266c171235d8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 972.3,
				name = "安排无敌与极限技顺序",
				timelineIndex = 207,
				timerOffset = -30,
				uuid = "4b646179-6853-5f46-a086-27cea70c477a",
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
							actionLua = "data.p5FulgentFirstSet = false\n\ndata.p5FulgentTimings = {\n    [1] = 6975,\n    [2] = 9080,\n    [3] = 11129,\n    [4] = 13181,\n    [5] = 15237,\n    [6] = 17296,\n    [7] = 19353,\n    [8] = 21401,\n}\n\nself.used = true",
							gVar = "ACR_RikuWAR3_CD",
							name = "Init Variables",
							uuid = "501e2354-ed39-53fd-9e32-83c7d9df82ca",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 972.3,
				name = "初始化光尘时序",
				timelineIndex = 207,
				timerOffset = -15,
				uuid = "6a6add50-c670-51c1-a293-180eba9eb38f",
				version = 2,
			},
		},
	},
	[209] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "a6dc3fd5-27a7-5c84-ab36-7a7e864e45cf",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\n\nlocal channelTime = eventArgs.channelTimeMax*1000\nlocal ProjectedPosition = TensorCore.getPosInDirection(ent.pos, ent.pos.h, 5)\nif data.firstsetdrawnTime == nil or TimeSince(data.firstsetdrawnTime) > 35000 then\n    drawer:addTimedRect(channelTime, ProjectedPosition.x, 0.05, ProjectedPosition.z, 5, 80, ent.pos.h, 2000, false, nil, 256)\n    data.firstsetdrawnTime = Now()\nelse\n    drawer:addTimedRect(2000, ProjectedPosition.x, 0.05, ProjectedPosition.z, 5, 80, ent.pos.h, channelTime, false, nil, 256)\nend\n\nfor i=1,7 do\n    ProjectedPosition = TensorCore.getPosInDirection(ProjectedPosition, ent.pos.h, 5)\n    drawer:addTimedRect(2000, ProjectedPosition.x, 0.05, ProjectedPosition.z, 5, 80, ent.pos.h, channelTime+(2000*i), false, nil, 256)\nend\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"a24e32e6-e776-524a-9edb-40ac49374788",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "8f8a1295-65d7-566d-9f87-a07f623b3103",
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
							eventSpellID = 31651,
							spellIDList = 
							{
								40307,
								40118,
							},
							uuid = "a24e32e6-e776-524a-9edb-40ac49374788",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 984.8,
				name = "光尘之剑预兆(旧版)",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = 20,
				timerStartOffset = -10,
				uuid = "9a14b804-7c3c-584b-a781-2b6252bd0677",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal oldDraw = MuAiGuide.Reactions.Settings.Reactions.fruExasArgusPlus == true\nlocal entPos = TensorCore.mGetEntity(eventArgs.entityID).pos\nlocal entH = TensorCore.restoreHeading(entPos.h)\nlocal pX, pZ = entPos.x, entPos.z\nlocal timings = data.p5FulgentTimings\nlocal drawTime = 2000\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedRect(drawTime, pX, 0.05, pZ, 5, 80, entH, timings[1] - drawTime, false, nil, 256)\nlocal storedSin, storedCos = 5 * math.sin(entH), 5 * math.cos(entH)\nfor i = 2, 8 do\n    pX = pX + storedSin\n    pZ = pZ + storedCos\n    local dx = pX - 100\n    local dz = pZ - 100\n    local sqDist = dx * dx + dz * dz\n    if (sqDist > 448) then break end\n    drawer:addTimedRect(drawTime, pX, 0.05, pZ, 5, 80, entH, timings[i] - drawTime, false, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"a24e32e6-e776-524a-9edb-40ac49374788",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							name = "Queue Exalines",
							uuid = "8f8a1295-65d7-566d-9f87-a07f623b3103",
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
							eventSpellID = 31651,
							name = "Channel IDs",
							spellIDList = 
							{
								40307,
								40118,
							},
							uuid = "a24e32e6-e776-524a-9edb-40ac49374788",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				loop = true,
				mechanicTime = 984.8,
				name = "光尘之剑预兆",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = 20,
				timerStartOffset = -10,
				uuid = "df81cc8e-33f0-5528-ad91-2744080d69b6",
				version = 2,
			},
		},
	},
	[215] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "3d1e964a-a48f-50b5-bbc2-1c53aaf83760",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Split Light Party Stacks\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"54a83c2a-418d-5e8b-9586-a3044602b160",
									true,
								},
								
								{
									"93f33e03-0232-5336-81f6-53b21b8daff0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "db1cada9-5cbf-50fe-848c-e65da2de54aa",
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
							eventArgType = 2,
							eventSpellID = 40310,
							uuid = "54a83c2a-418d-5e8b-9586-a3044602b160",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Party",
							channelCheckTimeRemain = 4,
							channelCheckType = 3,
							comparator = 2,
							conditionType = 5,
							eventArgType = 2,
							partyTargetType = "Event Entity",
							uuid = "93f33e03-0232-5336-81f6-53b21b8daff0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 1011.4,
				name = "双组分摊播报",
				timeRange = true,
				timelineIndex = 215,
				timerEndOffset = 4,
				timerStartOffset = -12,
				uuid = "058cc558-a5d2-5948-bd02-04ab9a8ee35c",
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
							actionLua = "-- FRU 死亡轮回左右分摊: 每次 OnFrame 更新重选首领左右各自最近一人.\n-- 同一目标由原生实体附着持续跟随; 仅换人时更新 UUID, 不降低选人频率.\nlocal remaining = (1011.4 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUSideDraws\nif rounds == nil then\n    rounds = {}\n    data.StringFRUSideDraws = rounds\nend\nlocal state = rounds[215]\nif state == nil then\n    state = {bossSelector = {contentid = 13561, subgroup = \"Highest HP\"}}\n    rounds[215] = state\nend\nif remaining <= 0 then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.leftDraw, state.rightDraw = nil, nil\n    self.used = true\n    return\nend\n\nlocal boss = state.bossID and TensorCore.mGetEntity(state.bossID)\nif boss == nil then\n    boss = TensorCore.getEntityByGroup(\"ContentID\", state.bossSelector)\n    if boss == nil then self.used = true; return end\n    state.bossID = boss.id\nend\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal pos = boss.pos\nlocal cosH, sinH = math.cos(pos.h), math.sin(pos.h)\nlocal leftID, rightID\nlocal leftDist, rightDist = math.huge, math.huge\nfor _, ent in pairs(party) do\n    local dx, dz = ent.pos.x - pos.x, ent.pos.z - pos.z\n    local distance = dx * dx + dz * dz\n    if dx * cosH - dz * sinH > 0 then\n        if distance < leftDist or (distance == leftDist and (leftID == nil or ent.id < leftID)) then\n            leftDist, leftID = distance, ent.id\n        end\n    elseif distance < rightDist or (distance == rightDist and (rightID == nil or ent.id < rightID)) then\n        rightDist, rightID = distance, ent.id\n    end\nend\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\n\nlocal rightDrawer = state.rightDrawer\nif rightDrawer == nil then\n    rightDrawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    rightDrawer:setGradient(3, 0.15, 2)\n    rightDrawer:setHeightOffset(0.05)\n    state.rightDrawer = rightDrawer\nend\n\nif leftID == nil then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    state.leftDraw, state.leftID = nil, nil\nelseif state.leftDraw == nil or state.leftID ~= leftID then\n    if state.leftDraw and not drawer:updateTimedCircleOnEnt(state.leftDraw, nil, leftID) then state.leftDraw = nil end\n    if state.leftDraw == nil then state.leftDraw = drawer:addTimedCircleOnEnt(remaining, leftID, 4, 0, false, true, 256) end\n    if state.leftDraw then state.leftID = leftID end\nend\nif rightID == nil then\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.rightDraw, state.rightID = nil, nil\nelseif state.rightDraw == nil or state.rightID ~= rightID then\n    if state.rightDraw and not rightDrawer:updateTimedCircleOnEnt(state.rightDraw, nil, rightID) then state.rightDraw = nil end\n    if state.rightDraw == nil then state.rightDraw = rightDrawer:addTimedCircleOnEnt(remaining, rightID, 4, 0, false, true, 256) end\n    if state.rightDraw then state.rightID = rightID end\nend\n\nlocal line = state.lineDrawer\nif line == nil then\n    line = TensorCore.getCachedDrawer(0x4DFFFFFF, nil, 0x4DFFFFFF, 0xFFFFFFFF, 2, 0, 256)\n    line:setGradient(3, 0.15, 2)\n    state.lineDrawer = line\nend\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h, 20, 0.05, 0.4, 0.2, false, 256)\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h + math.pi, 20, 0.05, 0, 0, false, 256)\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h, 12, 0.05, 0.4, 0.2, false, 256)\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h, 4, 0.05, 0.4, 0.2, false, 256)\n\nself.used = true\n",
							name = "左右各选最近一人",
							uuid = "32663363-b574-5e71-b8a3-d2aacfb4fe97",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1011.4,
				name = "死亡轮回左右分摊",
				timeRange = true,
				timelineIndex = 215,
				timerStartOffset = -2.5,
				uuid = "5f5aecdd-9958-1af9-a917-d923c4d1fcf2",
				version = 2,
			},
		},
	},
	[218] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "1cfe4755-e7a3-505a-940a-73cbfd837547",
			},
			objectType = "folder",
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
							actionLua = "data.p5WingsDarkFirst = true\nself.used = true",
							conditions = 
							{
								
								{
									"e0121194-2fed-5394-a6fc-2ffc4dcce179",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "Set Dark First",
							uuid = "efbef75c-20ef-529a-ab53-53245ca4f989",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p5WingsDarkFirst = false\nself.used = true",
							conditions = 
							{
								
								{
									"9c5fc87d-7e07-58f7-9780-028ca07db27a",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "Set Light First",
							uuid = "21e3c0f5-67b6-5ddf-8463-ea5e5369eaa2",
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
							eventSpellID = 40233,
							name = "Dark First",
							uuid = "e0121194-2fed-5394-a6fc-2ffc4dcce179",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40313,
							name = "Light First",
							uuid = "9c5fc87d-7e07-58f7-9780-028ca07db27a",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 3,
				mechanicTime = 1029.6,
				name = "记录首轮孤翼属性",
				timeRange = true,
				timelineIndex = 218,
				timerEndOffset = -5,
				timerStartOffset = -10,
				uuid = "626f517d-d72b-593c-ac7f-3c8e1602cb77",
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
							actionLua = "data.p5WingsTargetID = TensorCore.mGetEntity(eventArgs.detectionTargetID).targetid\nself.used = true",
							conditions = 
							{
								
								{
									"b2da71a7-4cd8-5e31-b228-902f93233466",
									true,
								},
								
								{
									"0f054e8c-0a72-5a23-b8f4-064481feca46",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "Record Pandora Target",
							uuid = "09e9e650-bac5-59dd-aeed-e5247d66388a",
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
							name = "Wings IDs",
							spellIDList = 
							{
								40233,
								40313,
							},
							uuid = "b2da71a7-4cd8-5e31-b228-902f93233466",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Get Boss",
							uuid = "0f054e8c-0a72-5a23-b8f4-064481feca46",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 3,
				mechanicTime = 1029.6,
				name = "记录孤翼主坦位置",
				timeRange = true,
				timelineIndex = 218,
				timerEndOffset = -5,
				timerStartOffset = -10,
				uuid = "edde471d-4996-5b30-b98a-ec6bdae7f727",
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
							actionLua = "data.p5FirstTowerPos = { x = 93.938, y = 0, z = 96.5 }\nself.used = true",
							conditions = 
							{
								
								{
									"0dcb86c3-7b79-5ad6-9966-25fa0ce63714",
									true,
								},
								
								{
									"32ba57e6-5d9c-50d5-9ac5-f178ddf54d52",
									true,
								},
								
								{
									"8e16184e-0853-5d57-b22e-0bb102f655e2",
									true,
								},
								
								{
									"b9268385-93af-5f2a-abe9-95022edcd049",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Store NW Pos",
							uuid = "da5e14f8-c873-50fd-91a0-bfa48329cba6",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p5FirstTowerPos = { x = 106.062, y = 0, z = 96.5 }\nself.used = true",
							conditions = 
							{
								
								{
									"0dcb86c3-7b79-5ad6-9966-25fa0ce63714",
									true,
								},
								
								{
									"32ba57e6-5d9c-50d5-9ac5-f178ddf54d52",
									true,
								},
								
								{
									"691d032c-aaeb-5c13-9cfe-9bf9b63213d5",
									true,
								},
								
								{
									"b9268385-93af-5f2a-abe9-95022edcd049",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Store NE Pos",
							uuid = "9fa28c98-a7db-59ef-8586-381fdf5a8e61",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p5FirstTowerPos = { x = 100, y = 0, z = 107 }\nself.used = true",
							conditions = 
							{
								
								{
									"0dcb86c3-7b79-5ad6-9966-25fa0ce63714",
									true,
								},
								
								{
									"32ba57e6-5d9c-50d5-9ac5-f178ddf54d52",
									true,
								},
								
								{
									"d159448b-a75f-5ec1-bc66-8d19cd026065",
									true,
								},
								
								{
									"b9268385-93af-5f2a-abe9-95022edcd049",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Store NW Pos",
							uuid = "3014fc76-d69e-5da4-b4e2-ad02e6b72cd0",
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
							comparator = 3,
							conditionLua = "return eventArgs.a2 == 1",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventIntValue = 1,
							name = "Arg2",
							uuid = "0dcb86c3-7b79-5ad6-9966-25fa0ce63714",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a3 == 2",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							eventIntValue = 2,
							name = "Arg3",
							uuid = "32ba57e6-5d9c-50d5-9ac5-f178ddf54d52",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 51",
							dequeueIfLuaFalse = true,
							eventIntValue = 51,
							name = "NW Tower",
							uuid = "8e16184e-0853-5d57-b22e-0bb102f655e2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 52",
							dequeueIfLuaFalse = true,
							eventIntValue = 52,
							name = "NE Tower",
							uuid = "691d032c-aaeb-5c13-9cfe-9bf9b63213d5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 53",
							dequeueIfLuaFalse = true,
							eventIntValue = 53,
							name = "S Tower",
							uuid = "d159448b-a75f-5ec1-bc66-8d19cd026065",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5FirstTowerPos == nil",
							dequeueIfLuaFalse = true,
							name = "Tower Not Recorded",
							uuid = "b9268385-93af-5f2a-abe9-95022edcd049",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 14,
				mechanicTime = 1029.6,
				name = "记录首塔位置",
				timeRange = true,
				timelineIndex = 218,
				timerEndOffset = -6,
				timerStartOffset = -12,
				uuid = "c9ccf782-920a-5944-ad00-fa6512a68985",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "5c0d2493-8c0c-5f30-84a4-9966288f5fa0",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Dark First\", true)\nMuAiGuide.Reactions.Shotcall(\"Party Out / OT In\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"f64aa173-1fd9-5ad9-9098-0073a30203d4",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "TTS Dark First",
							uuid = "e6f06481-b114-569d-b903-f0875d3acc3e",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Light First\", true)\nMuAiGuide.Reactions.Shotcall(\"Party In / MT Out\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"762fdaf4-ce81-5533-a4ae-80b3c6e18c8b",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "TTS Light First",
							uuid = "9b1080c4-b132-5ce1-8de4-9ca31aa42c13",
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
							eventSpellID = 40233,
							name = "Dark First",
							uuid = "f64aa173-1fd9-5ad9-9098-0073a30203d4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40313,
							name = "Light First",
							uuid = "762fdaf4-ce81-5533-a4ae-80b3c6e18c8b",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 1029.6,
				name = "首轮光暗播报",
				timeRange = true,
				timelineIndex = 218,
				timerEndOffset = -5,
				timerStartOffset = -10,
				uuid = "2619fd1c-3786-5b5b-885a-4778824488ad",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircle(9500, 93.938, 0.05, 96.5, 3, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"e84ac56d-7ab0-5b03-b2aa-e476940be8ac",
									true,
								},
								
								{
									"5191a760-87a4-5c6d-8d3d-3bc55213ac73",
									true,
								},
								
								{
									"8d9238fa-af50-52f2-a94c-e5bbbab90909",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Draw NW Tower",
							uuid = "c667cea5-dcb0-5664-baf8-2baff71322a1",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircle(9500, 106.062, 0.05, 96.5, 3, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"e84ac56d-7ab0-5b03-b2aa-e476940be8ac",
									true,
								},
								
								{
									"5191a760-87a4-5c6d-8d3d-3bc55213ac73",
									true,
								},
								
								{
									"01b95ad3-693d-5123-beb7-9158fcbbf5f8",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Draw NE Tower",
							uuid = "4868d2b7-26a9-56e6-b7bb-00d3b02e62af",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircle(9500, 100, 0.05, 107, 3, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"e84ac56d-7ab0-5b03-b2aa-e476940be8ac",
									true,
								},
								
								{
									"5191a760-87a4-5c6d-8d3d-3bc55213ac73",
									true,
								},
								
								{
									"5f128c04-3fd9-546b-9e38-51c9d1c6c495",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Draw NW Tower",
							uuid = "ac71cbdc-4d64-51d0-a68e-43930eb9cfd9",
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
							comparator = 3,
							conditionLua = "return eventArgs.a2 == 1",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventIntValue = 1,
							name = "Arg2",
							uuid = "e84ac56d-7ab0-5b03-b2aa-e476940be8ac",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a3 == 2",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							eventIntValue = 2,
							name = "Arg3",
							uuid = "5191a760-87a4-5c6d-8d3d-3bc55213ac73",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 51",
							dequeueIfLuaFalse = true,
							eventIntValue = 51,
							name = "NW Tower",
							uuid = "8d9238fa-af50-52f2-a94c-e5bbbab90909",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 52",
							dequeueIfLuaFalse = true,
							eventIntValue = 52,
							name = "NE Tower",
							uuid = "01b95ad3-693d-5123-beb7-9158fcbbf5f8",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 53",
							dequeueIfLuaFalse = true,
							eventIntValue = 53,
							name = "S Tower",
							uuid = "5f128c04-3fd9-546b-9e38-51c9d1c6c495",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 14,
				loop = true,
				mechanicTime = 1029.6,
				name = "复乐园踩塔范围",
				timeRange = true,
				timelineIndex = 218,
				timerStartOffset = -12,
				uuid = "fadc673e-97ca-5377-91a5-e90472f38ac3",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal startPos = data.p5FirstTowerPos\nlocal center = { x = 100, y = 0, z = 100 }\nlocal isDarkFirst = data.p5WingsDarkFirst\nlocal adjustAngle = (math.pi * 2) / 3\nif (isDarkFirst) then adjustAngle = -adjustAngle end\nlocal firstBaitPos = TensorCore.rotatePosAroundPos(center, startPos, adjustAngle)\nlocal firstH = TensorCore.getHeadingToTarget(center, firstBaitPos)\nlocal secondBaitPos = TensorCore.rotatePosAroundPos(center, startPos, adjustAngle / 2)\nlocal secondH = TensorCore.getHeadingToTarget(center, secondBaitPos)\nlocal firstDrawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256) --green\nfirstDrawer:setGradient(3, 0.15, 2)\nfirstDrawer:setHeightOffset(0.05)\nlocal secondDrawer = TensorCore.getCachedDrawer(0x4DFF8525, nil, 0x4DFF8525, 0xFFFFFFFF, 2, 0, 256) --blue\nsecondDrawer:setGradient(3, 0.15, 2)\nsecondDrawer:setHeightOffset(0.05)\nfirstDrawer:addTimedArrow(7000, 100, 0.05, 100, firstH, 6, 0.375, nil, nil, 0, false, 256)\nMuAiGuide.Reactions.addTimedWorldText(7000, \"MT\", firstBaitPos, 4026597120, true, 2)\nsecondDrawer:addTimedArrow(10000, 100, 0.05, 100, secondH, 6, 0.375, nil, nil, 0, false, 256)\nMuAiGuide.Reactions.addTimedWorldText(10000, \"OT\", secondBaitPos, 3959391525, true, 2)\nself.used = true",
							conditions = 
							{
								
								{
									"027743bf-0683-5358-b833-cce7b752729f",
									true,
								},
								
								{
									"71526642-9cee-5a96-8cca-0b0897034a56",
									true,
								},
								
								{
									"fbb74ec1-0b2b-5070-b3b4-cfc0242a1f74",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_CD",
							name = "Draw Tank Bait Arrows",
							uuid = "1e112033-d8a7-5ceb-ab30-8de607e8f3af",
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
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "Self Is Tank",
							partyTargetType = "Tank",
							uuid = "027743bf-0683-5358-b833-cce7b752729f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5FirstTowerPos ~= nil",
							name = "Tower Pos Stored",
							uuid = "71526642-9cee-5a96-8cca-0b0897034a56",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst ~= nil",
							name = "First Wing Stored",
							uuid = "fbb74ec1-0b2b-5070-b3b4-cfc0242a1f74",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 1029.6,
				name = "孤翼坦克引导方向",
				timeRange = true,
				timelineIndex = 218,
				timerEndOffset = -5,
				timerStartOffset = -12,
				uuid = "5f1a8f6e-fe35-501e-abcf-90d6bd28b05b",
				version = 2,
			},
		},
	},
	[219] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "2360480c-3ad9-56e3-bb66-50be39563f25",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal target = TensorCore.mGetEntity(data.p5WingsTargetID)\nif (target == nil) then\n    self.used = true\n    return\nend\n\nlocal cleaveAdjust = math.rad(67.5)\nlocal cleaveAngle = math.rad(225)\nlocal directHeading = TensorCore.getHeadingToTarget(data.arenaCenter, target.pos)\nlocal adjustedHeading = directHeading - cleaveAdjust\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCone(100, 0.05, 100, 30, cleaveAngle, adjustedHeading, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"59872bc0-d63d-5686-969f-f745b5471530",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Dark Cleave",
							uuid = "26dbf9fe-7a5a-51b6-a116-bfe3c3f900db",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal target = TensorCore.mGetEntity(data.p5WingsTargetID)\nif (target == nil) then\n    self.used = true\n    return\nend\n\nlocal cleaveAdjust = math.rad(67.5)\nlocal cleaveAngle = math.rad(225)\nlocal directHeading = TensorCore.getHeadingToTarget(data.arenaCenter, target.pos)\nlocal adjustedHeading = directHeading + cleaveAdjust\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCone(100, 0.05, 100, 30, cleaveAngle, adjustedHeading, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"59391df7-9e77-50b9-b9f0-cd4edab74148",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Light Cleave",
							uuid = "700eb501-943a-5e3a-83fe-cd3820bb1e77",
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
							conditionLua = "return data.p5WingsDarkFirst == true",
							dequeueIfLuaFalse = true,
							name = "Dark First",
							uuid = "59872bc0-d63d-5686-969f-f745b5471530",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst == false",
							dequeueIfLuaFalse = true,
							name = "Light First",
							uuid = "59391df7-9e77-50b9-b9f0-cd4edab74148",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1029.9,
				name = "孤翼第一刀范围",
				timeRange = true,
				timelineIndex = 219,
				timerStartOffset = -3.5,
				uuid = "5e7279f0-eea2-57ae-86c6-ccedf785c724",
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
							actionLua = "if data.StringFRUDrawHits and data.StringFRUDrawHits[219] then self.used = true; return end\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCircle(pos.x, 0.05, pos.z, 4, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"cd97f148-5595-5e10-b4b2-a039cb296336",
									true,
								},
								
								{
									"e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
									true,
								},
								
								{
									"a2990a30-1bf9-5859-ba0b-0f02124c83bf",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Nearest",
							uuid = "ea4120e0-b89e-50e2-a63d-cd75aeb16d68",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if data.StringFRUDrawHits and data.StringFRUDrawHits[219] then self.used = true; return end\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCircle(pos.x, 0.05, pos.z, 4, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"70ec6c8f-7720-5f16-9925-f9542bfb8fd0",
									true,
								},
								
								{
									"e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
									true,
								},
								
								{
									"017fc6c0-1031-55d3-a2b5-e44b83dc9b70",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Farthest",
							uuid = "57585c0b-5ab3-5f0d-93a5-81aa76435f0d",
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
							conditionLua = "return data.p5WingsDarkFirst == true",
							dequeueIfLuaFalse = true,
							name = "Dark First",
							uuid = "cd97f148-5595-5e10-b4b2-a039cb296336",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst == false",
							dequeueIfLuaFalse = true,
							name = "Light First",
							uuid = "70ec6c8f-7720-5f16-9925-f9542bfb8fd0",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Get Boss",
							uuid = "e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Party",
							name = "Get Nearest to Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "a2990a30-1bf9-5859-ba0b-0f02124c83bf",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetSubtype = "Furthest",
							filterTargetType = "Party",
							name = "Get Furthest from Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "017fc6c0-1031-55d3-a2b5-e44b83dc9b70",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1029.9,
				name = "孤翼第一轮连线",
				timeRange = true,
				timelineIndex = 219,
				timerEndOffset = 1.2,
				timerStartOffset = -3.5,
				uuid = "be48aa46-7c7c-5d3f-b0df-673e923d7935",
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
							actionLua = "data.StringFRUDrawHits = data.StringFRUDrawHits or {}\ndata.StringFRUDrawHits[219] = true\nself.used = true",
							conditions = 
							{
								
								{
									"a8bf9293-855e-8154-858b-e3bd913d59a8",
									true,
								},
							},
							name = "结束本轮绘图",
							uuid = "87d158fa-64c4-aa4f-9556-1b0564613476",
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
							name = "实际判定技能",
							spellIDList = 
							{
								39879,
								39880,
							},
							uuid = "a8bf9293-855e-8154-858b-e3bd913d59a8",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1029.9,
				name = "孤翼连线判定结束",
				timeRange = true,
				timelineIndex = 219,
				timerEndOffset = 1.2,
				timerStartOffset = -0.25,
				uuid = "954a751c-799c-cacf-9c89-d0611244253b",
				version = 2,
			},
		},
	},
	[222] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "5a3bfbf3-b5cf-5cc5-9a38-57fff8986873",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal boss = TensorCore.mGetEntity(eventArgs.detectionTargetID)\nif (boss == nil) then\n    self.used = true\n    return\nend\n\nlocal bossTarget = TensorCore.mGetEntity(boss.targetid)\nif (bossTarget == nil) then\n    self.used = true\n    return\nend\n\nlocal cleaveAdjust = math.rad(67.5)\nlocal cleaveAngle = math.rad(225)\nlocal directHeading = TensorCore.getHeadingToTarget(data.arenaCenter, bossTarget.pos)\nlocal adjustedHeading = directHeading - cleaveAdjust\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCone(100, 0.05, 100, 30, cleaveAngle, adjustedHeading, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"c19c4833-553d-5577-a751-d20006a5d5c0",
									true,
								},
								
								{
									"59872bc0-d63d-5686-969f-f745b5471530",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Dark Cleave",
							uuid = "26dbf9fe-7a5a-51b6-a116-bfe3c3f900db",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal boss = TensorCore.mGetEntity(eventArgs.detectionTargetID)\nif (boss == nil) then\n    self.used = true\n    return\nend\n\nlocal bossTarget = TensorCore.mGetEntity(boss.targetid)\nif (bossTarget == nil) then\n    self.used = true\n    return\nend\n\nlocal cleaveAdjust = math.rad(67.5)\nlocal cleaveAngle = math.rad(225)\nlocal directHeading = TensorCore.getHeadingToTarget(data.arenaCenter, bossTarget.pos)\nlocal adjustedHeading = directHeading + cleaveAdjust\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCone(100, 0.05, 100, 30, cleaveAngle, adjustedHeading, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"c19c4833-553d-5577-a751-d20006a5d5c0",
									true,
								},
								
								{
									"59391df7-9e77-50b9-b9f0-cd4edab74148",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Light Cleave",
							uuid = "700eb501-943a-5e3a-83fe-cd3820bb1e77",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditionType = 4,
							filterTargetType = "Enemy",
							name = "Get Boss",
							uuid = "c19c4833-553d-5577-a751-d20006a5d5c0",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst == false",
							dequeueIfLuaFalse = true,
							name = "Dark Second",
							uuid = "59872bc0-d63d-5686-969f-f745b5471530",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst == true",
							dequeueIfLuaFalse = true,
							name = "Light Second",
							uuid = "59391df7-9e77-50b9-b9f0-cd4edab74148",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1033.6,
				name = "孤翼第二刀范围",
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 0.30000001192093,
				timerStartOffset = -2.5,
				uuid = "f40980fd-14cf-5caa-bafd-8ef28044bcdb",
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
							actionLua = "if data.StringFRUDrawHits and data.StringFRUDrawHits[222] then self.used = true; return end\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCircle(pos.x, 0.05, pos.z, 4, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"449a8894-e1f6-55db-9832-bbd8b31eb079",
									true,
								},
								
								{
									"e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
									true,
								},
								
								{
									"a2990a30-1bf9-5859-ba0b-0f02124c83bf",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Nearest",
							uuid = "ea4120e0-b89e-50e2-a63d-cd75aeb16d68",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if data.StringFRUDrawHits and data.StringFRUDrawHits[222] then self.used = true; return end\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCircle(pos.x, 0.05, pos.z, 4, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"ee8e47e8-dcb0-5a15-83b2-ac3b5645ba09",
									true,
								},
								
								{
									"e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
									true,
								},
								
								{
									"017fc6c0-1031-55d3-a2b5-e44b83dc9b70",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Farthest",
							uuid = "57585c0b-5ab3-5f0d-93a5-81aa76435f0d",
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
							conditionLua = "return data.p5WingsDarkFirst == false",
							dequeueIfLuaFalse = true,
							name = "Dark Second",
							uuid = "449a8894-e1f6-55db-9832-bbd8b31eb079",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst == true",
							dequeueIfLuaFalse = true,
							name = "Light Second",
							uuid = "ee8e47e8-dcb0-5a15-83b2-ac3b5645ba09",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Get Boss",
							uuid = "e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Party",
							name = "Get Nearest to Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "a2990a30-1bf9-5859-ba0b-0f02124c83bf",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetSubtype = "Furthest",
							filterTargetType = "Party",
							name = "Get Furthest from Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "017fc6c0-1031-55d3-a2b5-e44b83dc9b70",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1033.6,
				name = "孤翼第二轮连线",
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 1.2,
				timerStartOffset = -2.5,
				uuid = "020ac2d4-cd11-558f-9cf7-5cdb71a3d094",
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
							actionLua = "data.StringFRUDrawHits = data.StringFRUDrawHits or {}\ndata.StringFRUDrawHits[222] = true\nself.used = true",
							conditions = 
							{
								
								{
									"77db6412-b9ad-19f5-b942-0b50387dbc1c",
									true,
								},
							},
							name = "结束本轮绘图",
							uuid = "0ee32ba4-a83f-8bee-8daa-b5aa3a04e8df",
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
							name = "实际判定技能",
							spellIDList = 
							{
								39879,
								39880,
							},
							uuid = "77db6412-b9ad-19f5-b942-0b50387dbc1c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1033.6,
				name = "孤翼连线判定结束",
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 1.2,
				timerStartOffset = -0.25,
				uuid = "d4e23424-4d6b-45ac-80eb-f0daf010807e",
				version = 2,
			},
		},
	},
	[224] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "e86572d3-8bf3-5767-b85e-48e7e226f114",
			},
			objectType = "folder",
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
							actionLua = "data.p5WingsDarkFirst = nil\ndata.p5WingsTargetID = nil\ndata.p5FirstTowerPos = nil\nself.used = true",
							gVar = "ACR_TensorViper3_CD",
							name = "Reset Wing Data",
							uuid = "4bb957bc-79dc-5424-a940-57f6633c66b4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "核心逻辑",
				mechanicTime = 1040.1,
				name = "重置孤翼数据",
				timelineIndex = 224,
				timerOffset = 5,
				uuid = "1fdd6e57-394f-5a04-a0e5-08a55eb35f81",
				version = 2,
			},
		},
	},
	[227] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "7078c71b-46e7-5fc6-abc4-d13bc8226afb",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif MuAiGuide.Reactions.isTank() then\n    MuAiGuide.Reactions.Shotcall(\"Go in front\", true, 2500)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "928b557c-aa0f-5811-802e-c98592bb71ec",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruPolarizingTMRH == true",
							dequeueIfLuaFalse = true,
							uuid = "0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 1051.8,
				name = "星灵之剑-坦克挡枪",
				timelineIndex = 227,
				timerOffset = -2,
				uuid = "4ef62592-5d5c-57ea-9304-a8e54040e2cc",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move center\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40317,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1051.8,
				name = "星灵之剑回中播报",
				timeRange = true,
				timelineIndex = 227,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "b651615b-064d-5533-bd2c-5735185d42e4",
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
							actionLua = "-- FRU 星灵之剑左右挡枪: 每次 OnFrame 更新重选首领左右各自最近一人.\n-- 同一目标由原生实体附着持续跟随; 仅换人时更新 UUID, 不降低选人频率.\nlocal remaining = (1051.5 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUSideDraws\nif rounds == nil then\n    rounds = {}\n    data.StringFRUSideDraws = rounds\nend\nlocal state = rounds[227]\nif state == nil then\n    state = {bossSelector = {contentid = 13561, subgroup = \"Highest HP\"}}\n    rounds[227] = state\nend\nif remaining <= 0 then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.leftDraw, state.rightDraw = nil, nil\n    self.used = true\n    return\nend\n\nlocal boss = state.bossID and TensorCore.mGetEntity(state.bossID)\nif boss == nil then\n    boss = TensorCore.getEntityByGroup(\"ContentID\", state.bossSelector)\n    if boss == nil then self.used = true; return end\n    state.bossID = boss.id\nend\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal pos = boss.pos\nlocal cosH, sinH = math.cos(pos.h), math.sin(pos.h)\nlocal leftID, rightID\nlocal leftDist, rightDist = math.huge, math.huge\nfor _, ent in pairs(party) do\n    local dx, dz = ent.pos.x - pos.x, ent.pos.z - pos.z\n    local distance = dx * dx + dz * dz\n    if dx * cosH - dz * sinH > 0 then\n        if distance < leftDist or (distance == leftDist and (leftID == nil or ent.id < leftID)) then\n            leftDist, leftID = distance, ent.id\n        end\n    elseif distance < rightDist or (distance == rightDist and (rightID == nil or ent.id < rightID)) then\n        rightDist, rightID = distance, ent.id\n    end\nend\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\n\nlocal rightDrawer = state.rightDrawer\nif rightDrawer == nil then\n    rightDrawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    rightDrawer:setGradient(3, 0.15, 2)\n    rightDrawer:setHeightOffset(0.05)\n    state.rightDrawer = rightDrawer\nend\n\nif leftID == nil then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    state.leftDraw, state.leftID = nil, nil\nelseif state.leftDraw == nil or state.leftID ~= leftID then\n    if state.leftDraw and not drawer:updateTimedRectOnEnt(state.leftDraw, nil, nil, nil, nil, leftID) then state.leftDraw = nil end\n    if state.leftDraw == nil then state.leftDraw = drawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, leftID, 0, true, false, true, nil, nil, 256) end\n    if state.leftDraw then state.leftID = leftID end\nend\nif rightID == nil then\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.rightDraw, state.rightID = nil, nil\nelseif state.rightDraw == nil or state.rightID ~= rightID then\n    if state.rightDraw and not rightDrawer:updateTimedRectOnEnt(state.rightDraw, nil, nil, nil, nil, rightID) then state.rightDraw = nil end\n    if state.rightDraw == nil then state.rightDraw = rightDrawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, rightID, 0, true, false, true, nil, nil, 256) end\n    if state.rightDraw then state.rightID = rightID end\nend\n\nself.used = true\n",
							name = "左右各选最近一人",
							uuid = "efae8691-b8dd-0869-90b8-65a2167fb015",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1051.8,
				name = "星灵之剑左右挡枪",
				timeRange = true,
				timelineIndex = 227,
				timerEndOffset = -0.3,
				timerStartOffset = -7.1,
				uuid = "1e765717-cc8b-050a-9c78-156f43196bf8",
				version = 2,
			},
		},
	},
	[228] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "dae45d0b-589b-5821-8733-ed2ea6f36833",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move out\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40234,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1055.8,
				name = "星灵之剑外移播报",
				timeRange = true,
				timelineIndex = 228,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "0ec0e889-fd94-5ec4-b884-72b360ae2f8f",
				version = 2,
			},
		},
	},
	[229] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "f834c0b2-84eb-5d54-b279-c9c8f035ba16",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif MuAiGuide.Reactions.isMelee() then\n    MuAiGuide.Reactions.Shotcall(\"Go in front\", true, 3000)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "928b557c-aa0f-5811-802e-c98592bb71ec",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruPolarizingTMRH == true",
							dequeueIfLuaFalse = true,
							uuid = "0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 1056.4,
				name = "星灵之剑-近战挡枪",
				timelineIndex = 229,
				timerOffset = -2,
				uuid = "97269cd8-0872-5c15-8bb9-85c77e790b96",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move center\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40317,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1056.4,
				name = "星灵之剑回中播报",
				timeRange = true,
				timelineIndex = 229,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "a02b7ecd-9930-59af-aad5-832ea3ab18c8",
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
							actionLua = "-- FRU 星灵之剑左右挡枪: 每次 OnFrame 更新重选首领左右各自最近一人.\n-- 同一目标由原生实体附着持续跟随; 仅换人时更新 UUID, 不降低选人频率.\nlocal remaining = (1056.1 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUSideDraws\nif rounds == nil then\n    rounds = {}\n    data.StringFRUSideDraws = rounds\nend\nlocal state = rounds[229]\nif state == nil then\n    state = {bossSelector = {contentid = 13561, subgroup = \"Highest HP\"}}\n    rounds[229] = state\nend\nif remaining <= 0 then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.leftDraw, state.rightDraw = nil, nil\n    self.used = true\n    return\nend\n\nlocal boss = state.bossID and TensorCore.mGetEntity(state.bossID)\nif boss == nil then\n    boss = TensorCore.getEntityByGroup(\"ContentID\", state.bossSelector)\n    if boss == nil then self.used = true; return end\n    state.bossID = boss.id\nend\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal pos = boss.pos\nlocal cosH, sinH = math.cos(pos.h), math.sin(pos.h)\nlocal leftID, rightID\nlocal leftDist, rightDist = math.huge, math.huge\nfor _, ent in pairs(party) do\n    local dx, dz = ent.pos.x - pos.x, ent.pos.z - pos.z\n    local distance = dx * dx + dz * dz\n    if dx * cosH - dz * sinH > 0 then\n        if distance < leftDist or (distance == leftDist and (leftID == nil or ent.id < leftID)) then\n            leftDist, leftID = distance, ent.id\n        end\n    elseif distance < rightDist or (distance == rightDist and (rightID == nil or ent.id < rightID)) then\n        rightDist, rightID = distance, ent.id\n    end\nend\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\n\nlocal rightDrawer = state.rightDrawer\nif rightDrawer == nil then\n    rightDrawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    rightDrawer:setGradient(3, 0.15, 2)\n    rightDrawer:setHeightOffset(0.05)\n    state.rightDrawer = rightDrawer\nend\n\nif leftID == nil then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    state.leftDraw, state.leftID = nil, nil\nelseif state.leftDraw == nil or state.leftID ~= leftID then\n    if state.leftDraw and not drawer:updateTimedRectOnEnt(state.leftDraw, nil, nil, nil, nil, leftID) then state.leftDraw = nil end\n    if state.leftDraw == nil then state.leftDraw = drawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, leftID, 0, true, false, true, nil, nil, 256) end\n    if state.leftDraw then state.leftID = leftID end\nend\nif rightID == nil then\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.rightDraw, state.rightID = nil, nil\nelseif state.rightDraw == nil or state.rightID ~= rightID then\n    if state.rightDraw and not rightDrawer:updateTimedRectOnEnt(state.rightDraw, nil, nil, nil, nil, rightID) then state.rightDraw = nil end\n    if state.rightDraw == nil then state.rightDraw = rightDrawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, rightID, 0, true, false, true, nil, nil, 256) end\n    if state.rightDraw then state.rightID = rightID end\nend\n\nself.used = true\n",
							name = "左右各选最近一人",
							uuid = "e9ad31a9-48ef-ac55-a8bc-cc73a52dd786",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1056.4,
				name = "星灵之剑左右挡枪",
				timeRange = true,
				timelineIndex = 229,
				timerEndOffset = -0.3,
				timerStartOffset = -2.1,
				uuid = "30c55b23-ad55-9633-8734-020ad23aee9e",
				version = 2,
			},
		},
	},
	[230] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "8ff692e5-380f-52f2-8604-5531e572856e",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move out\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40234,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1060.4,
				name = "星灵之剑外移播报",
				timeRange = true,
				timelineIndex = 230,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "ea2990ee-0c3c-5155-9fba-6316be1658fa",
				version = 2,
			},
		},
	},
	[231] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "900d0b7f-b93b-5236-a0b3-8a63765033eb",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif MuAiGuide.Reactions.isRangedDPS() then\n    MuAiGuide.Reactions.Shotcall(\"Go in front\", true, 3000)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "928b557c-aa0f-5811-802e-c98592bb71ec",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruPolarizingTMRH == true",
							dequeueIfLuaFalse = true,
							uuid = "0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 1061,
				name = "星灵之剑-远程挡枪",
				timelineIndex = 231,
				timerOffset = -2,
				uuid = "6c3e7f9e-230a-5a7a-8860-2c8f75bdfdc7",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move center\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40317,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1061,
				name = "星灵之剑回中播报",
				timeRange = true,
				timelineIndex = 231,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "30ce7971-e722-5a9f-8664-6b86bcdaed31",
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
							actionLua = "-- FRU 星灵之剑左右挡枪: 每次 OnFrame 更新重选首领左右各自最近一人.\n-- 同一目标由原生实体附着持续跟随; 仅换人时更新 UUID, 不降低选人频率.\nlocal remaining = (1060.7 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUSideDraws\nif rounds == nil then\n    rounds = {}\n    data.StringFRUSideDraws = rounds\nend\nlocal state = rounds[231]\nif state == nil then\n    state = {bossSelector = {contentid = 13561, subgroup = \"Highest HP\"}}\n    rounds[231] = state\nend\nif remaining <= 0 then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.leftDraw, state.rightDraw = nil, nil\n    self.used = true\n    return\nend\n\nlocal boss = state.bossID and TensorCore.mGetEntity(state.bossID)\nif boss == nil then\n    boss = TensorCore.getEntityByGroup(\"ContentID\", state.bossSelector)\n    if boss == nil then self.used = true; return end\n    state.bossID = boss.id\nend\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal pos = boss.pos\nlocal cosH, sinH = math.cos(pos.h), math.sin(pos.h)\nlocal leftID, rightID\nlocal leftDist, rightDist = math.huge, math.huge\nfor _, ent in pairs(party) do\n    local dx, dz = ent.pos.x - pos.x, ent.pos.z - pos.z\n    local distance = dx * dx + dz * dz\n    if dx * cosH - dz * sinH > 0 then\n        if distance < leftDist or (distance == leftDist and (leftID == nil or ent.id < leftID)) then\n            leftDist, leftID = distance, ent.id\n        end\n    elseif distance < rightDist or (distance == rightDist and (rightID == nil or ent.id < rightID)) then\n        rightDist, rightID = distance, ent.id\n    end\nend\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\n\nlocal rightDrawer = state.rightDrawer\nif rightDrawer == nil then\n    rightDrawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    rightDrawer:setGradient(3, 0.15, 2)\n    rightDrawer:setHeightOffset(0.05)\n    state.rightDrawer = rightDrawer\nend\n\nif leftID == nil then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    state.leftDraw, state.leftID = nil, nil\nelseif state.leftDraw == nil or state.leftID ~= leftID then\n    if state.leftDraw and not drawer:updateTimedRectOnEnt(state.leftDraw, nil, nil, nil, nil, leftID) then state.leftDraw = nil end\n    if state.leftDraw == nil then state.leftDraw = drawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, leftID, 0, true, false, true, nil, nil, 256) end\n    if state.leftDraw then state.leftID = leftID end\nend\nif rightID == nil then\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.rightDraw, state.rightID = nil, nil\nelseif state.rightDraw == nil or state.rightID ~= rightID then\n    if state.rightDraw and not rightDrawer:updateTimedRectOnEnt(state.rightDraw, nil, nil, nil, nil, rightID) then state.rightDraw = nil end\n    if state.rightDraw == nil then state.rightDraw = rightDrawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, rightID, 0, true, false, true, nil, nil, 256) end\n    if state.rightDraw then state.rightID = rightID end\nend\n\nself.used = true\n",
							name = "左右各选最近一人",
							uuid = "3179abe0-b5fc-6eeb-89f5-98550e5e3a5b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1061,
				name = "星灵之剑左右挡枪",
				timeRange = true,
				timelineIndex = 231,
				timerEndOffset = -0.3,
				timerStartOffset = -2.1,
				uuid = "112dce2f-7b4a-9e63-b72b-ac254f93d66c",
				version = 2,
			},
		},
	},
	[232] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "7cc6cf94-6a3d-538e-9124-884dbb550507",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move out\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40234,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1065,
				name = "星灵之剑外移播报",
				timeRange = true,
				timelineIndex = 232,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "47a01126-e4d7-59b4-8d5a-12ea1e8f2604",
				version = 2,
			},
		},
	},
	[233] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "c8567dd3-692d-5282-8348-49566a58ce6d",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif MuAiGuide.Reactions.isHealer() then\n    MuAiGuide.Reactions.Shotcall(\"Go in front\", true, 3000)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "928b557c-aa0f-5811-802e-c98592bb71ec",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruPolarizingTMRH == true",
							dequeueIfLuaFalse = true,
							uuid = "0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 1065.6,
				name = "星灵之剑-治疗挡枪",
				timelineIndex = 233,
				timerOffset = -2,
				uuid = "ba4a2a7b-52d0-5d4c-abe4-3d20f971cba2",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move center\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40317,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1065.6,
				name = "星灵之剑回中播报",
				timeRange = true,
				timelineIndex = 233,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "c3411dbf-43dd-5f02-8819-4915688a30e2",
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
							actionLua = "-- FRU 星灵之剑左右挡枪: 每次 OnFrame 更新重选首领左右各自最近一人.\n-- 同一目标由原生实体附着持续跟随; 仅换人时更新 UUID, 不降低选人频率.\nlocal remaining = (1065.3 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUSideDraws\nif rounds == nil then\n    rounds = {}\n    data.StringFRUSideDraws = rounds\nend\nlocal state = rounds[233]\nif state == nil then\n    state = {bossSelector = {contentid = 13561, subgroup = \"Highest HP\"}}\n    rounds[233] = state\nend\nif remaining <= 0 then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.leftDraw, state.rightDraw = nil, nil\n    self.used = true\n    return\nend\n\nlocal boss = state.bossID and TensorCore.mGetEntity(state.bossID)\nif boss == nil then\n    boss = TensorCore.getEntityByGroup(\"ContentID\", state.bossSelector)\n    if boss == nil then self.used = true; return end\n    state.bossID = boss.id\nend\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal pos = boss.pos\nlocal cosH, sinH = math.cos(pos.h), math.sin(pos.h)\nlocal leftID, rightID\nlocal leftDist, rightDist = math.huge, math.huge\nfor _, ent in pairs(party) do\n    local dx, dz = ent.pos.x - pos.x, ent.pos.z - pos.z\n    local distance = dx * dx + dz * dz\n    if dx * cosH - dz * sinH > 0 then\n        if distance < leftDist or (distance == leftDist and (leftID == nil or ent.id < leftID)) then\n            leftDist, leftID = distance, ent.id\n        end\n    elseif distance < rightDist or (distance == rightDist and (rightID == nil or ent.id < rightID)) then\n        rightDist, rightID = distance, ent.id\n    end\nend\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\n\nlocal rightDrawer = state.rightDrawer\nif rightDrawer == nil then\n    rightDrawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    rightDrawer:setGradient(3, 0.15, 2)\n    rightDrawer:setHeightOffset(0.05)\n    state.rightDrawer = rightDrawer\nend\n\nif leftID == nil then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    state.leftDraw, state.leftID = nil, nil\nelseif state.leftDraw == nil or state.leftID ~= leftID then\n    if state.leftDraw and not drawer:updateTimedRectOnEnt(state.leftDraw, nil, nil, nil, nil, leftID) then state.leftDraw = nil end\n    if state.leftDraw == nil then state.leftDraw = drawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, leftID, 0, true, false, true, nil, nil, 256) end\n    if state.leftDraw then state.leftID = leftID end\nend\nif rightID == nil then\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.rightDraw, state.rightID = nil, nil\nelseif state.rightDraw == nil or state.rightID ~= rightID then\n    if state.rightDraw and not rightDrawer:updateTimedRectOnEnt(state.rightDraw, nil, nil, nil, nil, rightID) then state.rightDraw = nil end\n    if state.rightDraw == nil then state.rightDraw = rightDrawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, rightID, 0, true, false, true, nil, nil, 256) end\n    if state.rightDraw then state.rightID = rightID end\nend\n\nself.used = true\n",
							name = "左右各选最近一人",
							uuid = "1f4bc9d7-75ab-180c-bc18-494c14c3387b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1065.6,
				name = "星灵之剑左右挡枪",
				timeRange = true,
				timelineIndex = 233,
				timerEndOffset = -0.3,
				timerStartOffset = -2.1,
				uuid = "81bb7611-b048-8fa4-9969-6d7e1ffafb92",
				version = 2,
			},
		},
	},
	[237] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "d4bd433d-2084-5020-a5dc-cca65ac6b7ad",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\n\nlocal channelTime = eventArgs.channelTimeMax*1000\nlocal ProjectedPosition = TensorCore.getPosInDirection(ent.pos, ent.pos.h, 5)\nif data.firstsetdrawnTime == nil or TimeSince(data.firstsetdrawnTime) > 35000 then\n    drawer:addTimedRect(channelTime, ProjectedPosition.x, 0.05, ProjectedPosition.z, 5, 80, ent.pos.h, 2000, false, nil, 256)\n    data.firstsetdrawnTime = Now()\nelse\n    drawer:addTimedRect(2000, ProjectedPosition.x, 0.05, ProjectedPosition.z, 5, 80, ent.pos.h, channelTime, false, nil, 256)\nend\n\nfor i=1,7 do\n    ProjectedPosition = TensorCore.getPosInDirection(ProjectedPosition, ent.pos.h, 5)\n    drawer:addTimedRect(2000, ProjectedPosition.x, 0.05, ProjectedPosition.z, 5, 80, ent.pos.h, channelTime+(2000*i), false, nil, 256)\nend\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"a24e32e6-e776-524a-9edb-40ac49374788",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "8f8a1295-65d7-566d-9f87-a07f623b3103",
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
							eventSpellID = 31651,
							spellIDList = 
							{
								40307,
								40118,
							},
							uuid = "a24e32e6-e776-524a-9edb-40ac49374788",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 1097.4,
				name = "光尘之剑预兆(旧版)",
				timeRange = true,
				timelineIndex = 237,
				timerEndOffset = 20,
				timerStartOffset = -10,
				uuid = "79d399f7-742b-59ae-b428-d793efdacef8",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal oldDraw = MuAiGuide.Reactions.Settings.Reactions.fruExasArgusPlus == true\nlocal entPos = TensorCore.mGetEntity(eventArgs.entityID).pos\nlocal entH = TensorCore.restoreHeading(entPos.h)\nlocal pX, pZ = entPos.x, entPos.z\nlocal timings = data.p5FulgentTimings\nlocal drawTime = 2000\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedRect(drawTime, pX, 0.05, pZ, 5, 80, entH, timings[1] - drawTime, false, nil, 256)\nlocal storedSin, storedCos = 5 * math.sin(entH), 5 * math.cos(entH)\nfor i = 2, 8 do\n    pX = pX + storedSin\n    pZ = pZ + storedCos\n    local dx = pX - 100\n    local dz = pZ - 100\n    local sqDist = dx * dx + dz * dz\n    if (sqDist > 448) then break end\n    drawer:addTimedRect(drawTime, pX, 0.05, pZ, 5, 80, entH, timings[i] - drawTime, false, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"a24e32e6-e776-524a-9edb-40ac49374788",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							name = "Queue Exalines",
							uuid = "8f8a1295-65d7-566d-9f87-a07f623b3103",
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
							eventSpellID = 31651,
							name = "Channel IDs",
							spellIDList = 
							{
								40307,
								40118,
							},
							uuid = "a24e32e6-e776-524a-9edb-40ac49374788",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				loop = true,
				mechanicTime = 1097.4,
				name = "光尘之剑预兆",
				timeRange = true,
				timelineIndex = 237,
				timerEndOffset = 20,
				timerStartOffset = -10,
				uuid = "dbb42817-bd69-570f-b636-f5fb14857b39",
				version = 2,
			},
		},
	},
	[243] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "7420bfa2-6cf5-526e-b5d7-cb7ed56e0644",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Split Light Party Stacks\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"54a83c2a-418d-5e8b-9586-a3044602b160",
									true,
								},
								
								{
									"93f33e03-0232-5336-81f6-53b21b8daff0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "db1cada9-5cbf-50fe-848c-e65da2de54aa",
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
							eventArgType = 2,
							eventSpellID = 40310,
							uuid = "54a83c2a-418d-5e8b-9586-a3044602b160",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Party",
							channelCheckTimeRemain = 4,
							channelCheckType = 3,
							comparator = 2,
							conditionType = 5,
							eventArgType = 2,
							partyTargetType = "Event Entity",
							uuid = "93f33e03-0232-5336-81f6-53b21b8daff0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 1124,
				name = "双组分摊播报",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 4,
				timerStartOffset = -12,
				uuid = "48653526-128b-53bd-ab26-6a42e1ec2504",
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
							actionLua = "-- FRU 死亡轮回左右分摊: 每次 OnFrame 更新重选首领左右各自最近一人.\n-- 同一目标由原生实体附着持续跟随; 仅换人时更新 UUID, 不降低选人频率.\nlocal remaining = (1124.0 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUSideDraws\nif rounds == nil then\n    rounds = {}\n    data.StringFRUSideDraws = rounds\nend\nlocal state = rounds[243]\nif state == nil then\n    state = {bossSelector = {contentid = 13561, subgroup = \"Highest HP\"}}\n    rounds[243] = state\nend\nif remaining <= 0 then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.leftDraw, state.rightDraw = nil, nil\n    self.used = true\n    return\nend\n\nlocal boss = state.bossID and TensorCore.mGetEntity(state.bossID)\nif boss == nil then\n    boss = TensorCore.getEntityByGroup(\"ContentID\", state.bossSelector)\n    if boss == nil then self.used = true; return end\n    state.bossID = boss.id\nend\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal pos = boss.pos\nlocal cosH, sinH = math.cos(pos.h), math.sin(pos.h)\nlocal leftID, rightID\nlocal leftDist, rightDist = math.huge, math.huge\nfor _, ent in pairs(party) do\n    local dx, dz = ent.pos.x - pos.x, ent.pos.z - pos.z\n    local distance = dx * dx + dz * dz\n    if dx * cosH - dz * sinH > 0 then\n        if distance < leftDist or (distance == leftDist and (leftID == nil or ent.id < leftID)) then\n            leftDist, leftID = distance, ent.id\n        end\n    elseif distance < rightDist or (distance == rightDist and (rightID == nil or ent.id < rightID)) then\n        rightDist, rightID = distance, ent.id\n    end\nend\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\n\nlocal rightDrawer = state.rightDrawer\nif rightDrawer == nil then\n    rightDrawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    rightDrawer:setGradient(3, 0.15, 2)\n    rightDrawer:setHeightOffset(0.05)\n    state.rightDrawer = rightDrawer\nend\n\nif leftID == nil then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    state.leftDraw, state.leftID = nil, nil\nelseif state.leftDraw == nil or state.leftID ~= leftID then\n    if state.leftDraw and not drawer:updateTimedCircleOnEnt(state.leftDraw, nil, leftID) then state.leftDraw = nil end\n    if state.leftDraw == nil then state.leftDraw = drawer:addTimedCircleOnEnt(remaining, leftID, 4, 0, false, true, 256) end\n    if state.leftDraw then state.leftID = leftID end\nend\nif rightID == nil then\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.rightDraw, state.rightID = nil, nil\nelseif state.rightDraw == nil or state.rightID ~= rightID then\n    if state.rightDraw and not rightDrawer:updateTimedCircleOnEnt(state.rightDraw, nil, rightID) then state.rightDraw = nil end\n    if state.rightDraw == nil then state.rightDraw = rightDrawer:addTimedCircleOnEnt(remaining, rightID, 4, 0, false, true, 256) end\n    if state.rightDraw then state.rightID = rightID end\nend\n\nlocal line = state.lineDrawer\nif line == nil then\n    line = TensorCore.getCachedDrawer(0x4DFFFFFF, nil, 0x4DFFFFFF, 0xFFFFFFFF, 2, 0, 256)\n    line:setGradient(3, 0.15, 2)\n    state.lineDrawer = line\nend\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h, 20, 0.05, 0.4, 0.2, false, 256)\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h + math.pi, 20, 0.05, 0, 0, false, 256)\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h, 12, 0.05, 0.4, 0.2, false, 256)\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h, 4, 0.05, 0.4, 0.2, false, 256)\n\nself.used = true\n",
							name = "左右各选最近一人",
							uuid = "b8458baa-a303-d476-8e7b-1dab64ff60e1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1124,
				name = "死亡轮回左右分摊",
				timeRange = true,
				timelineIndex = 243,
				timerStartOffset = -2.5,
				uuid = "8c15238f-4ef4-9c0c-a25d-96e034616e22",
				version = 2,
			},
		},
	},
	[247] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "核心逻辑",
				uuid = "ae299ff5-7704-51e7-849d-3e59c7a4f54e",
			},
			objectType = "folder",
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
							actionLua = "data.p5WingsDarkFirst = true\nself.used = true",
							conditions = 
							{
								
								{
									"e0121194-2fed-5394-a6fc-2ffc4dcce179",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "Set Dark First",
							uuid = "efbef75c-20ef-529a-ab53-53245ca4f989",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p5WingsDarkFirst = false\nself.used = true",
							conditions = 
							{
								
								{
									"9c5fc87d-7e07-58f7-9780-028ca07db27a",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "Set Light First",
							uuid = "21e3c0f5-67b6-5ddf-8463-ea5e5369eaa2",
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
							eventSpellID = 40233,
							name = "Dark First",
							uuid = "e0121194-2fed-5394-a6fc-2ffc4dcce179",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40313,
							name = "Light First",
							uuid = "9c5fc87d-7e07-58f7-9780-028ca07db27a",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 3,
				mechanicTime = 1146.3,
				name = "记录首轮孤翼属性",
				timeRange = true,
				timelineIndex = 247,
				timerEndOffset = -5,
				timerStartOffset = -10,
				uuid = "6b0ae236-d21e-5f75-bc41-f07b9415af0e",
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
							actionLua = "data.p5WingsTargetID = TensorCore.mGetEntity(eventArgs.detectionTargetID).targetid\nself.used = true",
							conditions = 
							{
								
								{
									"b2da71a7-4cd8-5e31-b228-902f93233466",
									true,
								},
								
								{
									"0f054e8c-0a72-5a23-b8f4-064481feca46",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorViper3_CD",
							name = "Record Pandora Target",
							uuid = "09e9e650-bac5-59dd-aeed-e5247d66388a",
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
							name = "Wings IDs",
							spellIDList = 
							{
								40233,
								40313,
							},
							uuid = "b2da71a7-4cd8-5e31-b228-902f93233466",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Get Boss",
							uuid = "0f054e8c-0a72-5a23-b8f4-064481feca46",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 3,
				mechanicTime = 1146.3,
				name = "记录孤翼主坦位置",
				timeRange = true,
				timelineIndex = 247,
				timerEndOffset = -5,
				timerStartOffset = -10,
				uuid = "90e21412-26c5-55e6-8a18-c84c21c798ee",
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
							actionLua = "data.p5FirstTowerPos = { x = 93.938, y = 0, z = 96.5 }\nself.used = true",
							conditions = 
							{
								
								{
									"0dcb86c3-7b79-5ad6-9966-25fa0ce63714",
									true,
								},
								
								{
									"32ba57e6-5d9c-50d5-9ac5-f178ddf54d52",
									true,
								},
								
								{
									"8e16184e-0853-5d57-b22e-0bb102f655e2",
									true,
								},
								
								{
									"b9268385-93af-5f2a-abe9-95022edcd049",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Store NW Pos",
							uuid = "da5e14f8-c873-50fd-91a0-bfa48329cba6",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p5FirstTowerPos = { x = 106.062, y = 0, z = 96.5 }\nself.used = true",
							conditions = 
							{
								
								{
									"0dcb86c3-7b79-5ad6-9966-25fa0ce63714",
									true,
								},
								
								{
									"32ba57e6-5d9c-50d5-9ac5-f178ddf54d52",
									true,
								},
								
								{
									"691d032c-aaeb-5c13-9cfe-9bf9b63213d5",
									true,
								},
								
								{
									"b9268385-93af-5f2a-abe9-95022edcd049",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Store NE Pos",
							uuid = "9fa28c98-a7db-59ef-8586-381fdf5a8e61",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p5FirstTowerPos = { x = 100, y = 0, z = 107 }\nself.used = true",
							conditions = 
							{
								
								{
									"0dcb86c3-7b79-5ad6-9966-25fa0ce63714",
									true,
								},
								
								{
									"32ba57e6-5d9c-50d5-9ac5-f178ddf54d52",
									true,
								},
								
								{
									"d159448b-a75f-5ec1-bc66-8d19cd026065",
									true,
								},
								
								{
									"b9268385-93af-5f2a-abe9-95022edcd049",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Store NW Pos",
							uuid = "3014fc76-d69e-5da4-b4e2-ad02e6b72cd0",
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
							comparator = 3,
							conditionLua = "return eventArgs.a2 == 1",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventIntValue = 1,
							name = "Arg2",
							uuid = "0dcb86c3-7b79-5ad6-9966-25fa0ce63714",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a3 == 2",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							eventIntValue = 2,
							name = "Arg3",
							uuid = "32ba57e6-5d9c-50d5-9ac5-f178ddf54d52",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 51",
							dequeueIfLuaFalse = true,
							eventIntValue = 51,
							name = "NW Tower",
							uuid = "8e16184e-0853-5d57-b22e-0bb102f655e2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 52",
							dequeueIfLuaFalse = true,
							eventIntValue = 52,
							name = "NE Tower",
							uuid = "691d032c-aaeb-5c13-9cfe-9bf9b63213d5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 53",
							dequeueIfLuaFalse = true,
							eventIntValue = 53,
							name = "S Tower",
							uuid = "d159448b-a75f-5ec1-bc66-8d19cd026065",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5FirstTowerPos == nil",
							dequeueIfLuaFalse = true,
							name = "Tower Not Recorded",
							uuid = "b9268385-93af-5f2a-abe9-95022edcd049",
							version = 3,
						},
					},
				},
				displayPath = "核心逻辑",
				eventType = 14,
				mechanicTime = 1146.3,
				name = "记录首塔位置",
				timeRange = true,
				timelineIndex = 247,
				timerEndOffset = -6,
				timerStartOffset = -12,
				uuid = "ea5c026a-08d4-579d-97b3-81a8786d85bb",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "ab785492-d907-5ba2-9f98-7fd9629e51ee",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Dark First\", true)\nMuAiGuide.Reactions.Shotcall(\"Party Out / OT In\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"f64aa173-1fd9-5ad9-9098-0073a30203d4",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "TTS Dark First",
							uuid = "e6f06481-b114-569d-b903-f0875d3acc3e",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Light First\", true)\nMuAiGuide.Reactions.Shotcall(\"Party In / OT Out\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"762fdaf4-ce81-5533-a4ae-80b3c6e18c8b",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "TTS Light First",
							uuid = "9b1080c4-b132-5ce1-8de4-9ca31aa42c13",
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
							eventSpellID = 40233,
							name = "Dark First",
							uuid = "f64aa173-1fd9-5ad9-9098-0073a30203d4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40313,
							name = "Light First",
							uuid = "762fdaf4-ce81-5533-a4ae-80b3c6e18c8b",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 1146.3,
				name = "首轮光暗播报",
				timeRange = true,
				timelineIndex = 247,
				timerEndOffset = -5,
				timerStartOffset = -10,
				uuid = "b674b71c-2fce-530f-9ad6-fd84789645f8",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircle(9500, 93.938, 0.05, 96.5, 3, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"e84ac56d-7ab0-5b03-b2aa-e476940be8ac",
									true,
								},
								
								{
									"5191a760-87a4-5c6d-8d3d-3bc55213ac73",
									true,
								},
								
								{
									"8d9238fa-af50-52f2-a94c-e5bbbab90909",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Draw NW Tower",
							uuid = "c667cea5-dcb0-5664-baf8-2baff71322a1",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircle(9500, 106.062, 0.05, 96.5, 3, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"e84ac56d-7ab0-5b03-b2aa-e476940be8ac",
									true,
								},
								
								{
									"5191a760-87a4-5c6d-8d3d-3bc55213ac73",
									true,
								},
								
								{
									"01b95ad3-693d-5123-beb7-9158fcbbf5f8",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Draw NE Tower",
							uuid = "4868d2b7-26a9-56e6-b7bb-00d3b02e62af",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addTimedCircle(9500, 100, 0.05, 107, 3, 0, false, nil, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"e84ac56d-7ab0-5b03-b2aa-e476940be8ac",
									true,
								},
								
								{
									"5191a760-87a4-5c6d-8d3d-3bc55213ac73",
									true,
								},
								
								{
									"5f128c04-3fd9-546b-9e38-51c9d1c6c495",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_CD",
							name = "Draw NW Tower",
							uuid = "ac71cbdc-4d64-51d0-a68e-43930eb9cfd9",
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
							comparator = 3,
							conditionLua = "return eventArgs.a2 == 1",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventIntValue = 1,
							name = "Arg2",
							uuid = "e84ac56d-7ab0-5b03-b2aa-e476940be8ac",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a3 == 2",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							eventIntValue = 2,
							name = "Arg3",
							uuid = "5191a760-87a4-5c6d-8d3d-3bc55213ac73",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 51",
							dequeueIfLuaFalse = true,
							eventIntValue = 51,
							name = "NW Tower",
							uuid = "8d9238fa-af50-52f2-a94c-e5bbbab90909",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 52",
							dequeueIfLuaFalse = true,
							eventIntValue = 52,
							name = "NE Tower",
							uuid = "01b95ad3-693d-5123-beb7-9158fcbbf5f8",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							conditionLua = "return eventArgs.a1 == 53",
							dequeueIfLuaFalse = true,
							eventIntValue = 53,
							name = "S Tower",
							uuid = "5f128c04-3fd9-546b-9e38-51c9d1c6c495",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 14,
				loop = true,
				mechanicTime = 1146.3,
				name = "复乐园踩塔范围",
				timeRange = true,
				timelineIndex = 247,
				timerStartOffset = -12,
				uuid = "ccc815ec-4715-587c-9bf5-3b67a157410e",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal startPos = data.p5FirstTowerPos\nlocal center = { x = 100, y = 0, z = 100 }\nlocal isDarkFirst = data.p5WingsDarkFirst\nlocal adjustAngle = (math.pi * 2) / 3\nif (isDarkFirst) then adjustAngle = -adjustAngle end\nlocal firstBaitPos = TensorCore.rotatePosAroundPos(center, startPos, adjustAngle)\nlocal firstH = TensorCore.getHeadingToTarget(center, firstBaitPos)\nlocal secondBaitPos = TensorCore.rotatePosAroundPos(center, startPos, adjustAngle / 2)\nlocal secondH = TensorCore.getHeadingToTarget(center, secondBaitPos)\nlocal firstDrawer = TensorCore.getCachedDrawer(0x4D00FF00, nil, 0x4D00FF00, 0xFFFFFFFF, 2, 0, 256) --green\nfirstDrawer:setGradient(3, 0.15, 2)\nfirstDrawer:setHeightOffset(0.05)\nlocal secondDrawer = TensorCore.getCachedDrawer(0x4DFF8525, nil, 0x4DFF8525, 0xFFFFFFFF, 2, 0, 256) --blue\nsecondDrawer:setGradient(3, 0.15, 2)\nsecondDrawer:setHeightOffset(0.05)\nfirstDrawer:addTimedArrow(7000, 100, 0.05, 100, firstH, 6, 0.375, nil, nil, 0, false, 256)\nMuAiGuide.Reactions.addTimedWorldText(7000, \"MT\", firstBaitPos, 4026597120, true, 2)\nsecondDrawer:addTimedArrow(10000, 100, 0.05, 100, secondH, 6, 0.375, nil, nil, 0, false, 256)\nMuAiGuide.Reactions.addTimedWorldText(10000, \"OT\", secondBaitPos, 3959391525, true, 2)\nself.used = true",
							conditions = 
							{
								
								{
									"027743bf-0683-5358-b833-cce7b752729f",
									true,
								},
								
								{
									"71526642-9cee-5a96-8cca-0b0897034a56",
									true,
								},
								
								{
									"fbb74ec1-0b2b-5070-b3b4-cfc0242a1f74",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_CD",
							name = "Draw Tank Bait Arrows",
							uuid = "1e112033-d8a7-5ceb-ab30-8de607e8f3af",
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
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "Self Is Tank",
							partyTargetType = "Tank",
							uuid = "027743bf-0683-5358-b833-cce7b752729f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5FirstTowerPos ~= nil",
							name = "Tower Pos Stored",
							uuid = "71526642-9cee-5a96-8cca-0b0897034a56",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst ~= nil",
							name = "First Wing Stored",
							uuid = "fbb74ec1-0b2b-5070-b3b4-cfc0242a1f74",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 1146.3,
				name = "孤翼坦克引导方向",
				timeRange = true,
				timelineIndex = 247,
				timerEndOffset = -5,
				timerStartOffset = -12,
				uuid = "7bfbb04b-15a1-507f-8852-50366671e0b7",
				version = 2,
			},
		},
	},
	[249] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "95f44ac0-5543-5dc7-be2d-e0373d29f8b2",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal target = TensorCore.mGetEntity(data.p5WingsTargetID)\nif (target == nil) then\n    self.used = true\n    return\nend\n\nlocal cleaveAdjust = math.rad(67.5)\nlocal cleaveAngle = math.rad(225)\nlocal directHeading = TensorCore.getHeadingToTarget(data.arenaCenter, target.pos)\nlocal adjustedHeading = directHeading - cleaveAdjust\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCone(100, 0.05, 100, 30, cleaveAngle, adjustedHeading, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"59872bc0-d63d-5686-969f-f745b5471530",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Dark Cleave",
							uuid = "26dbf9fe-7a5a-51b6-a116-bfe3c3f900db",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal target = TensorCore.mGetEntity(data.p5WingsTargetID)\nif (target == nil) then\n    self.used = true\n    return\nend\n\nlocal cleaveAdjust = math.rad(67.5)\nlocal cleaveAngle = math.rad(225)\nlocal directHeading = TensorCore.getHeadingToTarget(data.arenaCenter, target.pos)\nlocal adjustedHeading = directHeading + cleaveAdjust\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCone(100, 0.05, 100, 30, cleaveAngle, adjustedHeading, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"59391df7-9e77-50b9-b9f0-cd4edab74148",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Light Cleave",
							uuid = "700eb501-943a-5e3a-83fe-cd3820bb1e77",
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
							conditionLua = "return data.p5WingsDarkFirst == true",
							dequeueIfLuaFalse = true,
							name = "Dark First",
							uuid = "59872bc0-d63d-5686-969f-f745b5471530",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst == false",
							dequeueIfLuaFalse = true,
							name = "Light First",
							uuid = "59391df7-9e77-50b9-b9f0-cd4edab74148",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1147.4,
				name = "孤翼第一刀范围",
				timeRange = true,
				timelineIndex = 249,
				timerEndOffset = 0.30000001192093,
				timerStartOffset = -3.5,
				uuid = "e56305b8-0592-5252-be32-0acc2ac714a7",
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
							actionLua = "if data.StringFRUDrawHits and data.StringFRUDrawHits[249] then self.used = true; return end\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCircle(pos.x, 0.05, pos.z, 4, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"cd97f148-5595-5e10-b4b2-a039cb296336",
									true,
								},
								
								{
									"e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
									true,
								},
								
								{
									"a2990a30-1bf9-5859-ba0b-0f02124c83bf",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Nearest",
							uuid = "ea4120e0-b89e-50e2-a63d-cd75aeb16d68",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if data.StringFRUDrawHits and data.StringFRUDrawHits[249] then self.used = true; return end\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCircle(pos.x, 0.05, pos.z, 4, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"70ec6c8f-7720-5f16-9925-f9542bfb8fd0",
									true,
								},
								
								{
									"e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
									true,
								},
								
								{
									"017fc6c0-1031-55d3-a2b5-e44b83dc9b70",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Farthest",
							uuid = "57585c0b-5ab3-5f0d-93a5-81aa76435f0d",
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
							conditionLua = "return data.p5WingsDarkFirst == true",
							dequeueIfLuaFalse = true,
							name = "Dark First",
							uuid = "cd97f148-5595-5e10-b4b2-a039cb296336",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst == false",
							dequeueIfLuaFalse = true,
							name = "Light First",
							uuid = "70ec6c8f-7720-5f16-9925-f9542bfb8fd0",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Get Boss",
							uuid = "e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Party",
							name = "Get Nearest to Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "a2990a30-1bf9-5859-ba0b-0f02124c83bf",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetSubtype = "Furthest",
							filterTargetType = "Party",
							name = "Get Furthest from Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "017fc6c0-1031-55d3-a2b5-e44b83dc9b70",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1147.4,
				name = "孤翼第一轮连线",
				timeRange = true,
				timelineIndex = 249,
				timerEndOffset = 1.2,
				timerStartOffset = -3.5,
				uuid = "930abb9d-747e-514f-8c57-4feb5d7bfcca",
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
							actionLua = "data.StringFRUDrawHits = data.StringFRUDrawHits or {}\ndata.StringFRUDrawHits[249] = true\nself.used = true",
							conditions = 
							{
								
								{
									"cdd13f66-ab31-abea-a9c8-9032bf775a99",
									true,
								},
							},
							name = "结束本轮绘图",
							uuid = "eb87309a-2b99-7c36-8b98-7e4800681b79",
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
							name = "实际判定技能",
							spellIDList = 
							{
								39879,
								39880,
							},
							uuid = "cdd13f66-ab31-abea-a9c8-9032bf775a99",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1147.4,
				name = "孤翼连线判定结束",
				timeRange = true,
				timelineIndex = 249,
				timerEndOffset = 1.2,
				timerStartOffset = -0.25,
				uuid = "c2b6d410-05a5-a9d7-894c-7a4f542cf6fd",
				version = 2,
			},
		},
	},
	[250] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "16494e09-4c61-5ef6-822f-b5b7f826d077",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal boss = TensorCore.mGetEntity(eventArgs.detectionTargetID)\nif (boss == nil) then\n    self.used = true\n    return\nend\n\nlocal bossTarget = TensorCore.mGetEntity(boss.targetid)\nif (bossTarget == nil) then\n    self.used = true\n    return\nend\n\nlocal cleaveAdjust = math.rad(67.5)\nlocal cleaveAngle = math.rad(225)\nlocal directHeading = TensorCore.getHeadingToTarget(data.arenaCenter, bossTarget.pos)\nlocal adjustedHeading = directHeading - cleaveAdjust\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCone(100, 0.05, 100, 30, cleaveAngle, adjustedHeading, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"c19c4833-553d-5577-a751-d20006a5d5c0",
									true,
								},
								
								{
									"59872bc0-d63d-5686-969f-f745b5471530",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Dark Cleave",
							uuid = "26dbf9fe-7a5a-51b6-a116-bfe3c3f900db",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal boss = TensorCore.mGetEntity(eventArgs.detectionTargetID)\nif (boss == nil) then\n    self.used = true\n    return\nend\n\nlocal bossTarget = TensorCore.mGetEntity(boss.targetid)\nif (bossTarget == nil) then\n    self.used = true\n    return\nend\n\nlocal cleaveAdjust = math.rad(67.5)\nlocal cleaveAngle = math.rad(225)\nlocal directHeading = TensorCore.getHeadingToTarget(data.arenaCenter, bossTarget.pos)\nlocal adjustedHeading = directHeading + cleaveAdjust\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCone(100, 0.05, 100, 30, cleaveAngle, adjustedHeading, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"c19c4833-553d-5577-a751-d20006a5d5c0",
									true,
								},
								
								{
									"59391df7-9e77-50b9-b9f0-cd4edab74148",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Light Cleave",
							uuid = "700eb501-943a-5e3a-83fe-cd3820bb1e77",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Filter",
							conditionType = 4,
							filterTargetType = "Enemy",
							name = "Get Boss",
							uuid = "c19c4833-553d-5577-a751-d20006a5d5c0",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst == false",
							dequeueIfLuaFalse = true,
							name = "Dark Second",
							uuid = "59872bc0-d63d-5686-969f-f745b5471530",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst == true",
							dequeueIfLuaFalse = true,
							name = "Light Second",
							uuid = "59391df7-9e77-50b9-b9f0-cd4edab74148",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1150.3,
				name = "孤翼第二刀范围",
				timeRange = true,
				timelineIndex = 250,
				timerEndOffset = 0.30000001192093,
				timerStartOffset = -2.5,
				uuid = "343470d0-ab65-509f-9128-3002747a1dc4",
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
							actionLua = "if data.StringFRUDrawHits and data.StringFRUDrawHits[250] then self.used = true; return end\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCircle(pos.x, 0.05, pos.z, 4, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"449a8894-e1f6-55db-9832-bbd8b31eb079",
									true,
								},
								
								{
									"e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
									true,
								},
								
								{
									"a2990a30-1bf9-5859-ba0b-0f02124c83bf",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Nearest",
							uuid = "ea4120e0-b89e-50e2-a63d-cd75aeb16d68",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if data.StringFRUDrawHits and data.StringFRUDrawHits[250] then self.used = true; return end\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal pos = TensorCore.mGetEntity(eventArgs.detectionTargetID).pos\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal fruMuai1 = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\nfruMuai1:setGradient(3, 0.15, 2)\nfruMuai1:setHeightOffset(0.05)\nfruMuai1:addCircle(pos.x, 0.05, pos.z, 4, false, 256)\nself.used = true",
							conditions = 
							{
								
								{
									"ee8e47e8-dcb0-5a15-83b2-ac3b5645ba09",
									true,
								},
								
								{
									"e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
									true,
								},
								
								{
									"017fc6c0-1031-55d3-a2b5-e44b83dc9b70",
									true,
								},
							},
							gVar = "ACR_TensorViper3_CD",
							name = "Draw Farthest",
							uuid = "57585c0b-5ab3-5f0d-93a5-81aa76435f0d",
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
							conditionLua = "return data.p5WingsDarkFirst == false",
							dequeueIfLuaFalse = true,
							name = "Dark Second",
							uuid = "449a8894-e1f6-55db-9832-bbd8b31eb079",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5WingsDarkFirst == true",
							dequeueIfLuaFalse = true,
							name = "Light Second",
							uuid = "ee8e47e8-dcb0-5a15-83b2-ac3b5645ba09",
							version = 3,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Enemy",
							name = "Get Boss",
							uuid = "e0329bcf-84e7-5b6e-9e27-1565e8ba8d8d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetType = "Party",
							name = "Get Nearest to Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "a2990a30-1bf9-5859-ba0b-0f02124c83bf",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Filter",
							filterTargetSubtype = "Furthest",
							filterTargetType = "Party",
							name = "Get Furthest from Prev",
							subtypeRangeCheckSourceType = "Prev Detection Target",
							uuid = "017fc6c0-1031-55d3-a2b5-e44b83dc9b70",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1150.3,
				name = "孤翼第二轮连线",
				timeRange = true,
				timelineIndex = 250,
				timerEndOffset = 1.2,
				timerStartOffset = -2.5,
				uuid = "0d8af5be-1775-55fd-89a7-5032858acfeb",
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
							actionLua = "data.StringFRUDrawHits = data.StringFRUDrawHits or {}\ndata.StringFRUDrawHits[250] = true\nself.used = true",
							conditions = 
							{
								
								{
									"e5af9309-811d-16a9-a230-1be3753fd366",
									true,
								},
							},
							name = "结束本轮绘图",
							uuid = "8164d63f-9776-8e84-acf5-ee7b3b720d5c",
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
							name = "实际判定技能",
							spellIDList = 
							{
								39879,
								39880,
							},
							uuid = "e5af9309-811d-16a9-a230-1be3753fd366",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1150.3,
				name = "孤翼连线判定结束",
				timeRange = true,
				timelineIndex = 250,
				timerEndOffset = 1.2,
				timerStartOffset = -0.25,
				uuid = "9e81151b-3dfe-38ea-913a-4a1c1f362edb",
				version = 2,
			},
		},
	},
	[254] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "6ca206a8-0e72-5c58-8224-aa595451cf0e",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif MuAiGuide.Reactions.isTank() then\n    MuAiGuide.Reactions.Shotcall(\"Go in front\", true, 2500)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "928b557c-aa0f-5811-802e-c98592bb71ec",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruPolarizingTMRH == true",
							dequeueIfLuaFalse = true,
							uuid = "0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 1163.2,
				name = "星灵之剑-坦克挡枪",
				timelineIndex = 254,
				timerOffset = -2,
				uuid = "9303adb9-d677-5964-ad5d-4fa704650378",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move center\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40317,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1163.2,
				name = "星灵之剑回中播报",
				timeRange = true,
				timelineIndex = 254,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "24ca635a-6c1d-529a-8243-43b73dd4b222",
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
							actionLua = "-- FRU 星灵之剑左右挡枪: 每次 OnFrame 更新重选首领左右各自最近一人.\n-- 同一目标由原生实体附着持续跟随; 仅换人时更新 UUID, 不降低选人频率.\nlocal remaining = (1162.9 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUSideDraws\nif rounds == nil then\n    rounds = {}\n    data.StringFRUSideDraws = rounds\nend\nlocal state = rounds[254]\nif state == nil then\n    state = {bossSelector = {contentid = 13561, subgroup = \"Highest HP\"}}\n    rounds[254] = state\nend\nif remaining <= 0 then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.leftDraw, state.rightDraw = nil, nil\n    self.used = true\n    return\nend\n\nlocal boss = state.bossID and TensorCore.mGetEntity(state.bossID)\nif boss == nil then\n    boss = TensorCore.getEntityByGroup(\"ContentID\", state.bossSelector)\n    if boss == nil then self.used = true; return end\n    state.bossID = boss.id\nend\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal pos = boss.pos\nlocal cosH, sinH = math.cos(pos.h), math.sin(pos.h)\nlocal leftID, rightID\nlocal leftDist, rightDist = math.huge, math.huge\nfor _, ent in pairs(party) do\n    local dx, dz = ent.pos.x - pos.x, ent.pos.z - pos.z\n    local distance = dx * dx + dz * dz\n    if dx * cosH - dz * sinH > 0 then\n        if distance < leftDist or (distance == leftDist and (leftID == nil or ent.id < leftID)) then\n            leftDist, leftID = distance, ent.id\n        end\n    elseif distance < rightDist or (distance == rightDist and (rightID == nil or ent.id < rightID)) then\n        rightDist, rightID = distance, ent.id\n    end\nend\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\n\nlocal rightDrawer = state.rightDrawer\nif rightDrawer == nil then\n    rightDrawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    rightDrawer:setGradient(3, 0.15, 2)\n    rightDrawer:setHeightOffset(0.05)\n    state.rightDrawer = rightDrawer\nend\n\nif leftID == nil then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    state.leftDraw, state.leftID = nil, nil\nelseif state.leftDraw == nil or state.leftID ~= leftID then\n    if state.leftDraw and not drawer:updateTimedRectOnEnt(state.leftDraw, nil, nil, nil, nil, leftID) then state.leftDraw = nil end\n    if state.leftDraw == nil then state.leftDraw = drawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, leftID, 0, true, false, true, nil, nil, 256) end\n    if state.leftDraw then state.leftID = leftID end\nend\nif rightID == nil then\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.rightDraw, state.rightID = nil, nil\nelseif state.rightDraw == nil or state.rightID ~= rightID then\n    if state.rightDraw and not rightDrawer:updateTimedRectOnEnt(state.rightDraw, nil, nil, nil, nil, rightID) then state.rightDraw = nil end\n    if state.rightDraw == nil then state.rightDraw = rightDrawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, rightID, 0, true, false, true, nil, nil, 256) end\n    if state.rightDraw then state.rightID = rightID end\nend\n\nself.used = true\n",
							name = "左右各选最近一人",
							uuid = "f2ae70b2-c6ee-a8af-8d0c-a2207d7518cd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1163.2,
				name = "星灵之剑左右挡枪",
				timeRange = true,
				timelineIndex = 254,
				timerEndOffset = -0.3,
				timerStartOffset = -7.1,
				uuid = "b4ea7e2c-3422-cfbd-82f0-c615076918af",
				version = 2,
			},
		},
	},
	[255] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "d77819df-77e5-593b-9536-3f3573c2a1c2",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move out\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40234,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1167.2,
				name = "星灵之剑外移播报",
				timeRange = true,
				timelineIndex = 255,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "f4154eea-f9e7-5dd1-8144-a9a6d5f5915c",
				version = 2,
			},
		},
	},
	[256] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "c3e0bc43-1ef4-5888-be58-4965381991e2",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif MuAiGuide.Reactions.isMelee() then\n    MuAiGuide.Reactions.Shotcall(\"Go in front\", true, 3000)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "928b557c-aa0f-5811-802e-c98592bb71ec",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruPolarizingTMRH == true",
							dequeueIfLuaFalse = true,
							uuid = "0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 1167.8,
				name = "星灵之剑-近战挡枪",
				timelineIndex = 256,
				timerOffset = -2,
				uuid = "2fc6d736-c5df-5eef-a6fa-d6b7d504fb67",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move center\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40317,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1167.8,
				name = "星灵之剑回中播报",
				timeRange = true,
				timelineIndex = 256,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "fbb2480c-61b3-5735-924e-e3d6e1f59489",
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
							actionLua = "-- FRU 星灵之剑左右挡枪: 每次 OnFrame 更新重选首领左右各自最近一人.\n-- 同一目标由原生实体附着持续跟随; 仅换人时更新 UUID, 不降低选人频率.\nlocal remaining = (1167.5 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUSideDraws\nif rounds == nil then\n    rounds = {}\n    data.StringFRUSideDraws = rounds\nend\nlocal state = rounds[256]\nif state == nil then\n    state = {bossSelector = {contentid = 13561, subgroup = \"Highest HP\"}}\n    rounds[256] = state\nend\nif remaining <= 0 then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.leftDraw, state.rightDraw = nil, nil\n    self.used = true\n    return\nend\n\nlocal boss = state.bossID and TensorCore.mGetEntity(state.bossID)\nif boss == nil then\n    boss = TensorCore.getEntityByGroup(\"ContentID\", state.bossSelector)\n    if boss == nil then self.used = true; return end\n    state.bossID = boss.id\nend\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal pos = boss.pos\nlocal cosH, sinH = math.cos(pos.h), math.sin(pos.h)\nlocal leftID, rightID\nlocal leftDist, rightDist = math.huge, math.huge\nfor _, ent in pairs(party) do\n    local dx, dz = ent.pos.x - pos.x, ent.pos.z - pos.z\n    local distance = dx * dx + dz * dz\n    if dx * cosH - dz * sinH > 0 then\n        if distance < leftDist or (distance == leftDist and (leftID == nil or ent.id < leftID)) then\n            leftDist, leftID = distance, ent.id\n        end\n    elseif distance < rightDist or (distance == rightDist and (rightID == nil or ent.id < rightID)) then\n        rightDist, rightID = distance, ent.id\n    end\nend\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\n\nlocal rightDrawer = state.rightDrawer\nif rightDrawer == nil then\n    rightDrawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    rightDrawer:setGradient(3, 0.15, 2)\n    rightDrawer:setHeightOffset(0.05)\n    state.rightDrawer = rightDrawer\nend\n\nif leftID == nil then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    state.leftDraw, state.leftID = nil, nil\nelseif state.leftDraw == nil or state.leftID ~= leftID then\n    if state.leftDraw and not drawer:updateTimedRectOnEnt(state.leftDraw, nil, nil, nil, nil, leftID) then state.leftDraw = nil end\n    if state.leftDraw == nil then state.leftDraw = drawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, leftID, 0, true, false, true, nil, nil, 256) end\n    if state.leftDraw then state.leftID = leftID end\nend\nif rightID == nil then\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.rightDraw, state.rightID = nil, nil\nelseif state.rightDraw == nil or state.rightID ~= rightID then\n    if state.rightDraw and not rightDrawer:updateTimedRectOnEnt(state.rightDraw, nil, nil, nil, nil, rightID) then state.rightDraw = nil end\n    if state.rightDraw == nil then state.rightDraw = rightDrawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, rightID, 0, true, false, true, nil, nil, 256) end\n    if state.rightDraw then state.rightID = rightID end\nend\n\nself.used = true\n",
							name = "左右各选最近一人",
							uuid = "0d75f853-1487-e639-a149-da584074c341",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1167.8,
				name = "星灵之剑左右挡枪",
				timeRange = true,
				timelineIndex = 256,
				timerEndOffset = -0.3,
				timerStartOffset = -2.1,
				uuid = "51188048-3a7f-a78a-a3ed-dbf49a6daf8f",
				version = 2,
			},
		},
	},
	[257] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "38dae40a-625e-50fb-a06c-1e4d715c05db",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move out\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40234,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1171.8,
				name = "星灵之剑外移播报",
				timeRange = true,
				timelineIndex = 257,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "5f9cccc6-3652-5c0d-8e1a-7381615c00c8",
				version = 2,
			},
		},
	},
	[258] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "c89e803d-8b8f-5d13-afb1-c1c55d70cdb9",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif MuAiGuide.Reactions.isRangedDPS() then\n    MuAiGuide.Reactions.Shotcall(\"Go in front\", true, 3000)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "928b557c-aa0f-5811-802e-c98592bb71ec",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruPolarizingTMRH == true",
							dequeueIfLuaFalse = true,
							uuid = "0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 1172.4,
				name = "星灵之剑-远程挡枪",
				timelineIndex = 258,
				timerOffset = -2,
				uuid = "cac2d231-ce94-5dfe-9ec8-5f6ba469881e",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move center\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40317,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1172.4,
				name = "星灵之剑回中播报",
				timeRange = true,
				timelineIndex = 258,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "b7b675cd-c81c-5739-90e9-80d13a4328b6",
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
							actionLua = "-- FRU 星灵之剑左右挡枪: 每次 OnFrame 更新重选首领左右各自最近一人.\n-- 同一目标由原生实体附着持续跟随; 仅换人时更新 UUID, 不降低选人频率.\nlocal remaining = (1172.1 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUSideDraws\nif rounds == nil then\n    rounds = {}\n    data.StringFRUSideDraws = rounds\nend\nlocal state = rounds[258]\nif state == nil then\n    state = {bossSelector = {contentid = 13561, subgroup = \"Highest HP\"}}\n    rounds[258] = state\nend\nif remaining <= 0 then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.leftDraw, state.rightDraw = nil, nil\n    self.used = true\n    return\nend\n\nlocal boss = state.bossID and TensorCore.mGetEntity(state.bossID)\nif boss == nil then\n    boss = TensorCore.getEntityByGroup(\"ContentID\", state.bossSelector)\n    if boss == nil then self.used = true; return end\n    state.bossID = boss.id\nend\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal pos = boss.pos\nlocal cosH, sinH = math.cos(pos.h), math.sin(pos.h)\nlocal leftID, rightID\nlocal leftDist, rightDist = math.huge, math.huge\nfor _, ent in pairs(party) do\n    local dx, dz = ent.pos.x - pos.x, ent.pos.z - pos.z\n    local distance = dx * dx + dz * dz\n    if dx * cosH - dz * sinH > 0 then\n        if distance < leftDist or (distance == leftDist and (leftID == nil or ent.id < leftID)) then\n            leftDist, leftID = distance, ent.id\n        end\n    elseif distance < rightDist or (distance == rightDist and (rightID == nil or ent.id < rightID)) then\n        rightDist, rightID = distance, ent.id\n    end\nend\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\n\nlocal rightDrawer = state.rightDrawer\nif rightDrawer == nil then\n    rightDrawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    rightDrawer:setGradient(3, 0.15, 2)\n    rightDrawer:setHeightOffset(0.05)\n    state.rightDrawer = rightDrawer\nend\n\nif leftID == nil then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    state.leftDraw, state.leftID = nil, nil\nelseif state.leftDraw == nil or state.leftID ~= leftID then\n    if state.leftDraw and not drawer:updateTimedRectOnEnt(state.leftDraw, nil, nil, nil, nil, leftID) then state.leftDraw = nil end\n    if state.leftDraw == nil then state.leftDraw = drawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, leftID, 0, true, false, true, nil, nil, 256) end\n    if state.leftDraw then state.leftID = leftID end\nend\nif rightID == nil then\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.rightDraw, state.rightID = nil, nil\nelseif state.rightDraw == nil or state.rightID ~= rightID then\n    if state.rightDraw and not rightDrawer:updateTimedRectOnEnt(state.rightDraw, nil, nil, nil, nil, rightID) then state.rightDraw = nil end\n    if state.rightDraw == nil then state.rightDraw = rightDrawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, rightID, 0, true, false, true, nil, nil, 256) end\n    if state.rightDraw then state.rightID = rightID end\nend\n\nself.used = true\n",
							name = "左右各选最近一人",
							uuid = "960b1d0e-ef9b-3bd4-8b4b-8d2f4a3d4cc4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1172.4,
				name = "星灵之剑左右挡枪",
				timeRange = true,
				timelineIndex = 258,
				timerEndOffset = -0.3,
				timerStartOffset = -2.1,
				uuid = "c8724aa9-3064-b4b5-a353-cd5b64b34342",
				version = 2,
			},
		},
	},
	[259] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "d699dd50-1749-5381-a387-7bc5e6406eb1",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move out\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40234,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1176.4,
				name = "星灵之剑外移播报",
				timeRange = true,
				timelineIndex = 259,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "a9cad680-579f-573b-932e-d67b10ccd044",
				version = 2,
			},
		},
	},
	[260] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "ad71ddbf-1a9c-570f-8a2a-d7dc7eb08e43",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nif MuAiGuide.Reactions.isHealer() then\n    MuAiGuide.Reactions.Shotcall(\"Go in front\", true, 3000)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "928b557c-aa0f-5811-802e-c98592bb71ec",
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
							conditionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nreturn MuAiGuide.Reactions.Settings.Reactions.fruPolarizingTMRH == true",
							dequeueIfLuaFalse = true,
							uuid = "0059bfd9-aca2-54e7-ad6c-b097270a5f7c",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				mechanicTime = 1177,
				name = "星灵之剑-治疗挡枪",
				timelineIndex = 260,
				timerOffset = -2,
				uuid = "b340f174-8171-5da7-a349-f04a85e5baa3",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Move center\", false)\nself.used = true",
							conditions = 
							{
								
								{
									"07205327-66c5-5127-8336-b5883b624ca0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "3d200cb2-f2eb-5a99-8398-8a40b8af33f0",
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
							eventArgType = 2,
							eventSpellID = 40317,
							uuid = "07205327-66c5-5127-8336-b5883b624ca0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 2,
				mechanicTime = 1177,
				name = "星灵之剑回中播报",
				timeRange = true,
				timelineIndex = 260,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "6804c212-5e71-5138-b4e9-96b77bea9f36",
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
							actionLua = "-- FRU 星灵之剑左右挡枪: 每次 OnFrame 更新重选首领左右各自最近一人.\n-- 同一目标由原生实体附着持续跟随; 仅换人时更新 UUID, 不降低选人频率.\nlocal remaining = (1176.7 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUSideDraws\nif rounds == nil then\n    rounds = {}\n    data.StringFRUSideDraws = rounds\nend\nlocal state = rounds[260]\nif state == nil then\n    state = {bossSelector = {contentid = 13561, subgroup = \"Highest HP\"}}\n    rounds[260] = state\nend\nif remaining <= 0 then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.leftDraw, state.rightDraw = nil, nil\n    self.used = true\n    return\nend\n\nlocal boss = state.bossID and TensorCore.mGetEntity(state.bossID)\nif boss == nil then\n    boss = TensorCore.getEntityByGroup(\"ContentID\", state.bossSelector)\n    if boss == nil then self.used = true; return end\n    state.bossID = boss.id\nend\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal pos = boss.pos\nlocal cosH, sinH = math.cos(pos.h), math.sin(pos.h)\nlocal leftID, rightID\nlocal leftDist, rightDist = math.huge, math.huge\nfor _, ent in pairs(party) do\n    local dx, dz = ent.pos.x - pos.x, ent.pos.z - pos.z\n    local distance = dx * dx + dz * dz\n    if dx * cosH - dz * sinH > 0 then\n        if distance < leftDist or (distance == leftDist and (leftID == nil or ent.id < leftID)) then\n            leftDist, leftID = distance, ent.id\n        end\n    elseif distance < rightDist or (distance == rightDist and (rightID == nil or ent.id < rightID)) then\n        rightDist, rightID = distance, ent.id\n    end\nend\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\n\nlocal rightDrawer = state.rightDrawer\nif rightDrawer == nil then\n    rightDrawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    rightDrawer:setGradient(3, 0.15, 2)\n    rightDrawer:setHeightOffset(0.05)\n    state.rightDrawer = rightDrawer\nend\n\nif leftID == nil then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    state.leftDraw, state.leftID = nil, nil\nelseif state.leftDraw == nil or state.leftID ~= leftID then\n    if state.leftDraw and not drawer:updateTimedRectOnEnt(state.leftDraw, nil, nil, nil, nil, leftID) then state.leftDraw = nil end\n    if state.leftDraw == nil then state.leftDraw = drawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, leftID, 0, true, false, true, nil, nil, 256) end\n    if state.leftDraw then state.leftID = leftID end\nend\nif rightID == nil then\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.rightDraw, state.rightID = nil, nil\nelseif state.rightDraw == nil or state.rightID ~= rightID then\n    if state.rightDraw and not rightDrawer:updateTimedRectOnEnt(state.rightDraw, nil, nil, nil, nil, rightID) then state.rightDraw = nil end\n    if state.rightDraw == nil then state.rightDraw = rightDrawer:addTimedRectOnEnt(remaining, boss.id, 100, 6, rightID, 0, true, false, true, nil, nil, 256) end\n    if state.rightDraw then state.rightID = rightID end\nend\n\nself.used = true\n",
							name = "左右各选最近一人",
							uuid = "f5b6172b-b8a8-ed3b-8f64-7430a25d064b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1177,
				name = "星灵之剑左右挡枪",
				timeRange = true,
				timelineIndex = 260,
				timerEndOffset = -0.3,
				timerStartOffset = -2.1,
				uuid = "825a9e1b-81c5-1d5a-bab3-972c4156ff53",
				version = 2,
			},
		},
	},
	[262] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "001410cf-ea9b-5536-b51c-95e4bda34fd5",
			},
			objectType = "folder",
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
							actionLua = "-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\n\nlocal channelTime = eventArgs.channelTimeMax*1000\nlocal ProjectedPosition = TensorCore.getPosInDirection(ent.pos, ent.pos.h, 5)\nif data.firstsetdrawnTime == nil or TimeSince(data.firstsetdrawnTime) > 35000 or TimeSince(data.firstsetdrawnTime) < 1000 then\n    drawer:addTimedRect(channelTime, ProjectedPosition.x, 0.05, ProjectedPosition.z, 5, 80, ent.pos.h, 2000, false, nil, 256)\n    data.firstsetdrawnTime = Now()\nelse\n    drawer:addTimedRect(2000, ProjectedPosition.x, 0.05, ProjectedPosition.z, 5, 80, ent.pos.h, channelTime, false, nil, 256)\nend\n\nfor i=1,7 do\n    ProjectedPosition = TensorCore.getPosInDirection(ProjectedPosition, ent.pos.h, 5)\n    drawer:addTimedRect(2000, ProjectedPosition.x, 0.05, ProjectedPosition.z, 5, 80, ent.pos.h, channelTime+(2000*i), false, nil, 256)\nend\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"a24e32e6-e776-524a-9edb-40ac49374788",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "8f8a1295-65d7-566d-9f87-a07f623b3103",
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
							eventSpellID = 31651,
							spellIDList = 
							{
								40307,
								40118,
							},
							uuid = "a24e32e6-e776-524a-9edb-40ac49374788",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 1187.6,
				name = "光尘之剑预兆(旧版)",
				timeRange = true,
				timelineIndex = 262,
				timerEndOffset = 20,
				timerStartOffset = -10,
				uuid = "f5e3ba04-273a-5b30-9594-a3fbe560770e",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\n-- FRU Muai: alpha 0x4D, white 2px, gradient 3/0.15/2, flat floor +0.05.\nlocal oldDraw = MuAiGuide.Reactions.Settings.Reactions.fruExasArgusPlus == true\nlocal entPos = TensorCore.mGetEntity(eventArgs.entityID).pos\nlocal entH = TensorCore.restoreHeading(entPos.h)\nlocal pX, pZ = entPos.x, entPos.z\nlocal timings = data.p5FulgentTimings\nlocal drawTime = 2000\nlocal fruMoogle1 = TensorCore.getMoogleDrawer()\nlocal drawer = TensorCore.getCachedDrawer((fruMoogle1.colorStart and fruMoogle1.colorStart % 0x1000000 + 0x4D000000), (fruMoogle1.colorMid and fruMoogle1.colorMid % 0x1000000 + 0x4D000000), (fruMoogle1.colorEnd and fruMoogle1.colorEnd % 0x1000000 + 0x4D000000), 0xFFFFFFFF, 2, 0, 256)\ndrawer:setGradient(3, 0.15, 2)\ndrawer:setHeightOffset(0.05)\ndrawer:addTimedRect(drawTime, pX, 0.05, pZ, 5, 80, entH, timings[1] - drawTime, false, nil, 256)\nlocal storedSin, storedCos = 5 * math.sin(entH), 5 * math.cos(entH)\nfor i = 2, 8 do\n    pX = pX + storedSin\n    pZ = pZ + storedCos\n    local dx = pX - 100\n    local dz = pZ - 100\n    local sqDist = dx * dx + dz * dz\n    if (sqDist > 448) then break end\n    drawer:addTimedRect(drawTime, pX, 0.05, pZ, 5, 80, entH, timings[i] - drawTime, false, nil, 256)\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"a24e32e6-e776-524a-9edb-40ac49374788",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							name = "Queue Exalines",
							uuid = "8f8a1295-65d7-566d-9f87-a07f623b3103",
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
							eventSpellID = 31651,
							name = "Channel IDs",
							spellIDList = 
							{
								40307,
								40118,
							},
							uuid = "a24e32e6-e776-524a-9edb-40ac49374788",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				loop = true,
				mechanicTime = 1187.6,
				name = "光尘之剑预兆",
				timeRange = true,
				timelineIndex = 262,
				timerEndOffset = 20,
				timerStartOffset = -10,
				uuid = "d7eede66-4b7c-5a0a-b504-c0b8300b0baf",
				version = 2,
			},
		},
	},
	[268] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "机制绘图",
				uuid = "7db7285e-056d-5c8c-8b7c-8ae86cd45058",
			},
			objectType = "folder",
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
							actionLua = "if not (MuAiGuide and MuAiGuide.Reactions and MuAiGuide.Reactions.ready) then\n    error(\"[MuAiCore] 时间轴公共模块尚未就绪\")\nend\n\nMuAiGuide.Reactions.Shotcall(\"Split Light Party Stacks\", true)\nself.used = true",
							conditions = 
							{
								
								{
									"54a83c2a-418d-5e8b-9586-a3044602b160",
									true,
								},
								
								{
									"93f33e03-0232-5336-81f6-53b21b8daff0",
									true,
								},
							},
							gVar = "ACR_RikuDRG3_CD",
							uuid = "db1cada9-5cbf-50fe-848c-e65da2de54aa",
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
							eventArgType = 2,
							eventSpellID = 40310,
							uuid = "54a83c2a-418d-5e8b-9586-a3044602b160",
							version = 3,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Party",
							channelCheckTimeRemain = 4,
							channelCheckType = 3,
							comparator = 2,
							conditionType = 5,
							eventArgType = 2,
							partyTargetType = "Event Entity",
							uuid = "93f33e03-0232-5336-81f6-53b21b8daff0",
							version = 3,
						},
					},
				},
				displayPath = "机制绘图",
				eventType = 3,
				mechanicTime = 1214.2,
				name = "双组分摊播报",
				timeRange = true,
				timelineIndex = 268,
				timerEndOffset = 4,
				timerStartOffset = -12,
				uuid = "a398a53b-4e28-5e57-95f6-d7eecfe05662",
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
							actionLua = "-- FRU 死亡轮回左右分摊: 每次 OnFrame 更新重选首领左右各自最近一人.\n-- 同一目标由原生实体附着持续跟随; 仅换人时更新 UUID, 不降低选人频率.\nlocal remaining = (1214.2 - TensorReactions_CurrentTimer) * 1000\nlocal rounds = data.StringFRUSideDraws\nif rounds == nil then\n    rounds = {}\n    data.StringFRUSideDraws = rounds\nend\nlocal state = rounds[268]\nif state == nil then\n    state = {bossSelector = {contentid = 13561, subgroup = \"Highest HP\"}}\n    rounds[268] = state\nend\nif remaining <= 0 then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.leftDraw, state.rightDraw = nil, nil\n    self.used = true\n    return\nend\n\nlocal boss = state.bossID and TensorCore.mGetEntity(state.bossID)\nif boss == nil then\n    boss = TensorCore.getEntityByGroup(\"ContentID\", state.bossSelector)\n    if boss == nil then self.used = true; return end\n    state.bossID = boss.id\nend\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not table.valid(party) then self.used = true; return end\nlocal pos = boss.pos\nlocal cosH, sinH = math.cos(pos.h), math.sin(pos.h)\nlocal leftID, rightID\nlocal leftDist, rightDist = math.huge, math.huge\nfor _, ent in pairs(party) do\n    local dx, dz = ent.pos.x - pos.x, ent.pos.z - pos.z\n    local distance = dx * dx + dz * dz\n    if dx * cosH - dz * sinH > 0 then\n        if distance < leftDist or (distance == leftDist and (leftID == nil or ent.id < leftID)) then\n            leftDist, leftID = distance, ent.id\n        end\n    elseif distance < rightDist or (distance == rightDist and (rightID == nil or ent.id < rightID)) then\n        rightDist, rightID = distance, ent.id\n    end\nend\n\nlocal drawer = state.drawer\nif drawer == nil then\n    drawer = TensorCore.getCachedDrawer(0x4D00FFFF, nil, 0x4D00FFFF, 0xFFFFFFFF, 2, 0, 256)\n    drawer:setGradient(3, 0.15, 2)\n    drawer:setHeightOffset(0.05)\n    state.drawer = drawer\nend\n\nlocal rightDrawer = state.rightDrawer\nif rightDrawer == nil then\n    rightDrawer = TensorCore.getCachedDrawer(0x4DFF66B3, nil, 0x4DFF66B3, 0xFFFFFFFF, 2, 0, 256)\n    rightDrawer:setGradient(3, 0.15, 2)\n    rightDrawer:setHeightOffset(0.05)\n    state.rightDrawer = rightDrawer\nend\n\nif leftID == nil then\n    if state.leftDraw then Argus.deleteTimedShape(state.leftDraw) end\n    state.leftDraw, state.leftID = nil, nil\nelseif state.leftDraw == nil or state.leftID ~= leftID then\n    if state.leftDraw and not drawer:updateTimedCircleOnEnt(state.leftDraw, nil, leftID) then state.leftDraw = nil end\n    if state.leftDraw == nil then state.leftDraw = drawer:addTimedCircleOnEnt(remaining, leftID, 4, 0, false, true, 256) end\n    if state.leftDraw then state.leftID = leftID end\nend\nif rightID == nil then\n    if state.rightDraw then Argus.deleteTimedShape(state.rightDraw) end\n    state.rightDraw, state.rightID = nil, nil\nelseif state.rightDraw == nil or state.rightID ~= rightID then\n    if state.rightDraw and not rightDrawer:updateTimedCircleOnEnt(state.rightDraw, nil, rightID) then state.rightDraw = nil end\n    if state.rightDraw == nil then state.rightDraw = rightDrawer:addTimedCircleOnEnt(remaining, rightID, 4, 0, false, true, 256) end\n    if state.rightDraw then state.rightID = rightID end\nend\n\nlocal line = state.lineDrawer\nif line == nil then\n    line = TensorCore.getCachedDrawer(0x4DFFFFFF, nil, 0x4DFFFFFF, 0xFFFFFFFF, 2, 0, 256)\n    line:setGradient(3, 0.15, 2)\n    state.lineDrawer = line\nend\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h, 20, 0.05, 0.4, 0.2, false, 256)\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h + math.pi, 20, 0.05, 0, 0, false, 256)\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h, 12, 0.05, 0.4, 0.2, false, 256)\nline:addArrow(pos.x, pos.y + 0.05, pos.z, pos.h, 4, 0.05, 0.4, 0.2, false, 256)\n\nself.used = true\n",
							name = "左右各选最近一人",
							uuid = "5715eb22-984f-2668-bf04-31aaa942829b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "机制绘图",
				eventType = 12,
				mechanicTime = 1214.2,
				name = "死亡轮回左右分摊",
				timeRange = true,
				timelineIndex = 268,
				timerStartOffset = -2.5,
				uuid = "3ad2aac3-2f39-8c7d-8130-c4e3038ab18e",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "fru",
	version = "1.0.5",
}



return tbl