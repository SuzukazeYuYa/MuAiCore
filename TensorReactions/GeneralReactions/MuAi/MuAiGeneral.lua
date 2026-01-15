local tbl = 
{
	
	{
		data = 
		{
			actions = 
			{
			},
			conditions = 
			{
			},
			name = "--------------------- MuAiDraw ---------------------------",
			uuid = "4c04d325-7712-422b-be39-a892f38c3b0d",
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
						actionLua = "local redDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 1)),\n        2\n)\nif MuAiGuide.M11SMapType == nil or MuAiGuide.M11SMapType ~= 1 then\n\tredDrawer:addRect(100, 0, 80, 40, 40, 0, true)\t\nelse\n\tredDrawer:addRect(89, 0, 80, 40, 10, 0, true)\n\tredDrawer:addRect(84, 0, 80, 40, 20, 0, true)\n\tredDrawer:addRect(116, 0, 80, 40, 20, 0, true)\n\tredDrawer:addRect(111, 0, 80, 40, 10, 0, true)\nend\nself.used = true",
						conditions = 
						{
							
							{
								"71b6f493-41e3-df25-8619-bbdb57bd01bf",
								true,
							},
						},
						gVar = "ACR_RikuNIN3_CD",
						uuid = "16ba8e37-2a5d-9b6e-a6a5-3593ba5c9ac4",
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
						conditionType = 8,
						localmapid = 1325,
						name = "M11S",
						uuid = "71b6f493-41e3-df25-8619-bbdb57bd01bf",
						version = 2,
					},
					inheritedIndex = 1,
				},
			},
			eventType = 13,
			name = "M11S地图边框",
			uuid = "15ffb251-5885-55b5-adf0-15a00a7fcba5",
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
						actionLua = "MuAiGuide.M11SMapType = 0\nself.used = true",
						conditions = 
						{
							
							{
								"4b9a2018-ece0-c270-bec7-fb5391d04788",
								true,
							},
						},
						gVar = "ACR_RikuNIN3_CD",
						name = "M11sWipe",
						uuid = "7146ecb6-aca1-f8af-bb52-47f650b8af72",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.InitM12SData()\nself.used = true",
						conditions = 
						{
							
							{
								"609f849f-a306-30ed-89bb-763044ebe97d",
								true,
							},
						},
						name = "M12SWipe",
						uuid = "e6bf07be-9f1c-840b-a240-1a8746e75d76",
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
						conditionType = 8,
						localmapid = 1325,
						name = "M11S",
						uuid = "4b9a2018-ece0-c270-bec7-fb5391d04788",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Self",
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "609f849f-a306-30ed-89bb-763044ebe97d",
						version = 2,
					},
					inheritedIndex = 2,
				},
			},
			eventType = 9,
			name = "OnWipe[团灭]",
			uuid = "b610ef51-6410-2e2c-8cd0-fff9d16334a8",
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
						actionLua = "local target = TensorCore.mGetTarget()\nlocal drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 1 / 255, 1), 1)\ndrawer:addCircle(target.pos.x, target.pos.y, target.pos.z, 0.03, true)\nself.used = true",
						conditions = 
						{
							
							{
								"e882c803-8a68-c906-b70f-afbc3e6d7bf3",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						uuid = "659945ac-70c9-be8f-8d1e-d4497eb55c3d",
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
						conditionLua = "local curTarget = TensorCore.mGetTarget() \nreturn curTarget ~= nil \n\t\tand curTarget.attackable\n\t\tand not MuAiGuide.IsTank(TensorCore.mGetPlayer())",
						uuid = "e882c803-8a68-c906-b70f-afbc3e6d7bf3",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "目标脚下画个黄点",
			uuid = "f6607c59-fc75-1a2f-b73e-8825dbe3d5b3",
			version = 2,
		},
		inheritedIndex = 4,
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
			name = "-------- m11s --------",
			uuid = "0022e2e8-45db-6edb-a69f-77507c8e294e",
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
						actionLua = "MuAiGuide.M11SMapType = 1\n",
						conditions = 
						{
							
							{
								"6ccf9f23-4952-5e4c-bbf6-111de25eaffa",
								true,
							},
							
							{
								"0e493990-e4ec-e1b4-aaf9-fb78fd408a55",
								true,
							},
						},
						gVar = "ACR_RikuNIN3_CD",
						name = "拆地板",
						uuid = "62e6a770-339c-de7b-8bf7-1e1aa5badcca",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M11SMapType = 0\nself.used = true",
						conditions = 
						{
							
							{
								"33cd5d48-a7b4-e21e-865e-3da798f01913",
								true,
							},
							
							{
								"0e493990-e4ec-e1b4-aaf9-fb78fd408a55",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "还原地板",
						uuid = "befcb967-2841-45e2-b927-f551c47c3b6c",
						version = 2.1,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M11SMapType = 2\nself.used = true",
						conditions = 
						{
							
							{
								"b07946c0-f072-a961-8d22-cf8fccccc02a",
								true,
							},
						},
						gVar = "ACR_RikuNIN3_CD",
						name = "陨石狂奔 ",
						uuid = "a2803d71-84f4-6362-bf81-8473a4716695",
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
						eventSpellID = 46143,
						name = "拆地图",
						uuid = "6ccf9f23-4952-5e4c-bbf6-111de25eaffa",
						version = 2,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventEntityID = 46086,
						eventSpellID = 46086,
						name = "还原地图",
						uuid = "33cd5d48-a7b4-e21e-865e-3da798f01913",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 46162,
						name = "陨石狂奔",
						uuid = "b07946c0-f072-a961-8d22-cf8fccccc02a",
						version = 2,
					},
					inheritedIndex = 3,
				},
				
				{
					data = 
					{
						category = "Self",
						conditionType = 8,
						localmapid = 1325,
						name = "M11S",
						uuid = "0e493990-e4ec-e1b4-aaf9-fb78fd408a55",
						version = 2,
					},
					inheritedIndex = 3,
				},
			},
			eventType = 2,
			name = "M11S阶段切换",
			uuid = "e260ac90-04cd-d071-866c-f30f070327c0",
			version = 2,
		},
		inheritedIndex = 6,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "AnyoneCore.addTimedWorldText(60000 * 90, \"N\", {x = 100,y = 0 ,z =  77}, GUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 3)\nAnyoneCore.addTimedWorldText(60000 * 90, \"S\", {x = 100,y = 0 ,z =  123}, GUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 3)\nAnyoneCore.addTimedWorldText(60000 * 90, \"W\", {x = 72,y = 0 ,z =  100}, GUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 3)\nAnyoneCore.addTimedWorldText(60000 * 90, \"E\", {x = 128,y = 0 ,z =  100}, GUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 3)\nself.used = true",
						conditions = 
						{
							
							{
								"19fa35c7-1605-8a7a-97a7-6dbaf9b2a568",
								true,
							},
						},
						gVar = "ACR_RikuNIN3_CD",
						uuid = "b909d181-c1fc-4737-b315-5cd0da388cc2",
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
						conditionType = 8,
						localmapid = 1325,
						name = "M11S",
						uuid = "19fa35c7-1605-8a7a-97a7-6dbaf9b2a568",
						version = 2,
					},
				},
			},
			eventType = 11,
			name = "M11S东西南北",
			throttleTime = 5000,
			uuid = "285e83a5-1024-4791-bdac-921a03769a59",
			version = 2,
		},
		inheritedIndex = 7,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local drawTime = 40000\n\nAnyoneCore.addTimedWorldText(drawTime , \"H1\", {x = 85, y = 0 ,z =  115}, \nGUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 1)\n\nAnyoneCore.addTimedWorldText(drawTime , \"H2/D2\", {x = 105, y = 0 ,z =  95}, \nGUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 1)\n\n\nAnyoneCore.addTimedWorldText(drawTime , \"D3\", {x = 90, y = 0 ,z =  110}, \nGUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 1)\n\nAnyoneCore.addTimedWorldText(drawTime , \"D4\", {x = 105, y = 0 ,z =  105}, \nGUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 1)\n\nAnyoneCore.addTimedWorldText(drawTime , \"D1\", {x = 95, y = 0 ,z =  105}, \nGUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 1)\n\nself.used = true",
						conditions = 
						{
							
							{
								"089e6374-6111-897d-8af0-fcd0c72e28ac",
								true,
							},
							
							{
								"36552ff7-f62a-b95c-9b3e-6ec090ee0398",
								true,
							},
						},
						gVar = "ACR_RikuNIN3_CD",
						uuid = "b71e5591-3e6b-758b-b52e-84b8c6cbeccb",
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
						eventSpellID = 46132,
						uuid = "089e6374-6111-897d-8af0-fcd0c72e28ac",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Self",
						conditionType = 8,
						localmapid = 1325,
						name = "M11S",
						uuid = "36552ff7-f62a-b95c-9b3e-6ec090ee0398",
						version = 2,
					},
				},
			},
			eventType = 2,
			name = "M11S陨石位置",
			uuid = "74d161a0-ce78-a135-a5df-53829b8f7124",
			version = 2,
		},
		inheritedIndex = 8,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local drawTime = 3000\nlocal posLabel = { \"MT\", \"D4\", \"H2\", \"D2\", \"ST\", \"D1\", \"H1\", \"D3\" }\n\nif data.MuAiM11S_Sickle_Data == nil then\n    data.MuAiM11S_Sickle_Data = {}\nend\n\nfunction drawPos(ent)\n    local heading = ent.pos.h\n    for i = 0, 7 do\n        local pos = TensorCore.getPosInDirection(ent.pos, heading - i * math.pi / 4, 4)\n        AnyoneCore.addTimedWorldText(drawTime, posLabel[i + 1], pos, GUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 1)\n    end\n    -- 更新时间戳\n    data.MuAiM11S_Sickle_Data[ent.id] = {\n        pos = ent.pos,\n        time = Now()\n    }\nend\n\nlocal entList = TensorCore.entityList(\"contentid=108\") or {}\nfor _, ent in pairs(entList) do\n    if Argus.getEntityModel(ent.id) == 19185 and Argus.isEntityVisible(ent) then\n        local dataCache = data.MuAiM11S_Sickle_Data[ent.id]\n\n        if dataCache == nil then\n            drawPos(ent)  -- 首次绘制\n        else\n            local distance = TensorCore.getDistance2d(ent.pos, dataCache.pos)\n            local timeSinceDraw = Now() - dataCache.time\n            local isTimeOut = timeSinceDraw > drawTime - 50\n\n            if distance > 0.5 or isTimeOut then\n                drawPos(ent)  -- 位置变化或超时重新绘制\n            end\n        end\n    end\nend\n\nself.used = true",
						conditions = 
						{
							
							{
								"cee5c51f-db3d-03b0-9b91-12cc159be349",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						uuid = "9a68066e-0fda-cac6-964b-abd739087ef1",
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
						conditionType = 8,
						localmapid = 1325,
						name = "M11S",
						uuid = "cee5c51f-db3d-03b0-9b91-12cc159be349",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M11S月环8方",
			uuid = "b3503580-71a1-e733-a4c3-578deaae1e88",
			version = 2,
		},
		inheritedIndex = 11,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local player = TensorCore.mGetPlayer()\nlocal tethers = Argus.getTethersOnEnt(player.id)\nlocal linkFrom = nil\nfor _, tether in pairs(tethers) do\n    if tether.type == 57 or tether.type == 249 then\n        linkFrom = TensorCore.mGetEntity(tether.partnerid)\n    end\nend\n\nif linkFrom ~= nil then\n    local targetPos = nil\n    if MuAiGuide.M11SMapType == 1 then\n        if linkFrom.pos.x < 100 then\n            if linkFrom.pos.z < 100 then\n                targetPos = { x = 116, z = 120 }\n            else\n                targetPos = { x = 116, z = 80 }\n            end\n        else\n            if linkFrom.pos.z < 100 then\n                targetPos = { x = 84, z = 120 }\n            else\n                targetPos = { x = 84, z = 80 }\n            end\n        end\n    elseif MuAiGuide.M11SMapType == 2 then\n        if linkFrom.pos.z < 90 then --上\n            targetPos = { x = 120, z = 120 }\n        elseif linkFrom.pos.x < 90 then --左\n            targetPos = { x = 120, z = 80 }\n        elseif linkFrom.pos.z >110  then -- 下\n            targetPos = { x = 80, z = 80 }\n        else -- 右边\n            targetPos = { x = 80, z = 120 }\n        end\n    end\n    if targetPos ~= nil then\n        local length = TensorCore.getDistance2d(linkFrom.pos, targetPos)\n        local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.2), 1)\n        local heading = TensorCore.getHeadingToTarget(linkFrom.pos, targetPos)\n        drawer:addArrow(linkFrom.pos.x, 0, linkFrom.pos.z, heading, length + 1, 0.5, 1, 1,  true)\n        --drawer:addArrow(linkFrom.pos.x, 0, linkFrom.pos.z, heading, length + 1, 0.03, 0.5, 0.5, true)\n    end\nend\nself.used = true ",
						conditions = 
						{
							
							{
								"2fbd9c0f-e39c-a512-9798-2586a5646898",
								true,
							},
							
							{
								"16607308-c4ad-eb3e-ac3e-9036a0da5b58",
								true,
							},
						},
						gVar = "ACR_RikuNIN3_CD",
						uuid = "031241ad-aed6-50cb-aab6-4ace640a267b",
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
						conditionType = 8,
						localmapid = 1325,
						name = "M11S",
						uuid = "16607308-c4ad-eb3e-ac3e-9036a0da5b58",
						version = 2,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "if MuAiGuide.M11SMapType ~= 1 and MuAiGuide.M11SMapType ~= 2 then\n    return false\nend\n\nlocal player = TensorCore.mGetPlayer()\nlocal tethers = Argus.getTethersOnEnt(player.id)\nif tethers == nil or table.size(tethers) <= 0 then\n    return false\nend\nfor _, tether in pairs(tethers) do\n    if tether.type == 57 or tether.type == 249 then\n        return true\n    end\nend\nreturn false",
						uuid = "2fbd9c0f-e39c-a512-9798-2586a5646898",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M11S拉线",
			uuid = "41a903f9-67f1-06ad-8924-d2be901e0268",
			version = 2,
		},
		inheritedIndex = 11,
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
			name = "-------- m12s --------",
			uuid = "d59f33fd-dc8f-4ea2-84c5-a200263ed342",
			version = 2,
		},
		inheritedIndex = 12,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentBoss = TensorCore.mGetTarget()\nself.used = true",
						conditions = 
						{
							
							{
								"af059daa-90a8-74b4-9550-caf534e00639",
								true,
							},
							
							{
								"4851d130-4a01-de13-b3fc-e5bf6e579bc7",
								true,
							},
						},
						uuid = "0df32b43-05f8-e8a9-a31d-6b54cbaa72f1",
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
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "af059daa-90a8-74b4-9550-caf534e00639",
						version = 2,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "local target = TensorCore.mGetTarget()\nreturn target ~= nil\n\tand target.attackable\n\tand (MuAiGuide.M12S.CurrentBoss == nil or MuAiGuide.M12S.CurrentBoss.id ~= target.id)",
						conditionType = 5,
						uuid = "4851d130-4a01-de13-b3fc-e5bf6e579bc7",
						version = 2,
					},
				},
			},
			name = "M12S-GetBoss",
			uuid = "52909867-07a0-dd48-a645-bcbc9d9e4be2",
			version = 2,
		},
		inheritedIndex = 13,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\nM.M12S = {}\n--- M12S初始化\nM.M12S.InitM12SData = function()\n    --- 完成状态，表示当前副本进度已经完成了哪些\n    M.M12S.StateEnum = {\n        Start = 0,\n        GPuzzle2_Start = 1200,\n        -- 场地塔刷新完毕,开始循环\n        GPuzzle2_Looping = 1201,\n        -- 门神2运结束\n        GPuzzle2_End = 1299,\n        -- 进入3运\n        GPuzzle3_Start = 1300,\n        -- 已读取蛇位置\n        GPuzzle3_GotSnake = 1301,\n        -- 门神3运结束\n        GPuzzle3_End = 1399,\n        -- 4运开始\n        Puzzle4_Start = 2400,\n        -- 刷复制体1\n        Puzzle4_Spawn_Copy1 = 2401,\n        -- 刷复制体2\n        Puzzle4_Spawn_Copy2 = 2402,\n        -- 第一次连线\n        Puzzle4_FirstLink = 2403,\n        -- 找到上下刀\n        Puzzle4_GetSKills = 2404,\n        -- 第二次预备\n        Puzzle4_SecondLink = 2405,\n        -- 接线开始\n        Puzzle4_CatchLink = 2406,\n        -- 拉线结束\n        Puzzle4_CatchEnd = 2407,\n        -- 小世界1\n        Puzzle4_Div1 = 2408,\n        -- \n        Puzzle4_Tower1 = 2409,\n        --获得光BUFF\n        Puzzle4_GetBuff = 2410,\n        -- 4次分摊/大圈\n        Puzzle4_ThirdLink = 2411,\n        Puzzle4_Put1 = 2412,\n        Puzzle4_Put2 = 2413,\n        Puzzle4_Put3 = 2414,\n        Puzzle4_PutEnd = 2415,\n        -- 第二次小世界\n        Puzzle4_Tower2 = 2416,\n        -- 塔结束\n        Puzzle4_TowerEnd = 2417,\n        -- 处理远近\n        Puzzle4_TowerFarNear = 2418,\n        -- 第二次小世界小怪观察\n        Puzzle4_div2Subs = 2419,\n        -- 第二次小世界小怪观测\n        Puzzle4_div2SubsEnd = 2420,\n        -- 第二次小世界结束\n        Puzzle4_div2End = 2421,\n        -- 第一复制体爆炸\n        Puzzle4_CopyBoom1 = 2422,\n        -- 第三次小世界结束\n        Puzzle4_div3End = 2423,\n        -- 第二次复制体爆炸\n        Puzzle4_CopyBoom2 = 2424,\n        -- 最终结P\n        PuzzleEnd_Start = 2500,\n    }\n\n    M.M12S.DataEnum = {\n        A1 = 11, A2 = 12, A3 = 13, A4 = 14,\n        B1 = 21, B2 = 22, B3 = 23, B4 = 24,\n        Gp2_01 = 201, Gp2_02 = 202, Gp2_03 = 203, Gp2_04 = 204, Gp2_end = 299,\n        -- 先刷数字点\n        Puzzle4Number = 401,\n        -- 先刷字母点\n        Puzzle4Char = 402,\n        --A点上下刀\n        UpDownSkillA = 403,\n        -- C点上下刀\n        UpDownSkillC = 404,\n        -- 集合\n        Gather = 113,\n        -- 大钢铁\n        Disperse = 112,\n        -- 判定的线\n        LinkFinal = 117,\n        -- 4D3C\n        Left = 1,\n        -- A1B2\n        Right = 2,\n\n        -- 上下\n        UpDown = 3,\n        -- 左右\n        LeftRight = 4,\n    }\n    -- 辅助计时器\n    M.M12S.Timer = 0\n\n    M.M12S.CurrentBoss = nil\n    -- 当前副本阶段\n    M.M12S.CurrentState = M.M12S.StateEnum.Start\n    M.M12S.GP2Info = {\n        -- 场地塔Id\n        ids = {},\n        -- 场地塔信息,索引\n        gTowers = {},\n        gSpawnIdx = 0,\n        -- 玩家塔信息,索引\n        pTowers = {},\n        pSpawnIdx = 0,\n        selfType = 0,\n        pTowerFinish = false,\n        State = M.M12S.DataEnum.Gp2_01\n    }\n    M.M12S.GP3Info = {\n        selfBuff = nil,\n        guidePos = nil, \n    }\n    \n    -- 4运 玩家复制体数据\n    M.M12S.P4CopyInfo = {\n        ids = {},\n        entities = {},\n        guidePos,\n        linkPos,\n        -- 刷新类型：字母点/数字点\n        spawnType = nil,\n        gatherPos1,\n        gatherPos2,\n    }\n    -- 4运 被接线BOSS分身、个人需处理数据信息\n    M.M12S.P4CatchLineInfo = {\n        ids = {},\n        entities = {},\n        -- 接线类型, 分摊线/分散线\n        type = nil,\n    }\n    -- 4运 3分身信息\n    M.M12S.P4Sub3Info = {\n        skillType = nil,\n        -- 接线后指路位置\n        GuidePos1 = nil,\n        -- 躲前后左右刀参考站位\n        divGuidePos1 = nil,\n        divGuidePos2 = nil,\n        -- 躲前后左右刀实际站位(小世界)\n        GuidePos2 = nil,\n        -- 躲前后左右刀实际站位(最后)\n        GuidePos3 = nil,\n    }\n    -- 4运 踩塔数据\n    M.M12S.P4TowerData = {}\n\n    M.Info(\"M12S初始化数据完成!\")\nend\n\n-- 根据小队任意成员BUFF情况判断是否切阶段\nM.M12S.Puzzle4_4TimesChange = function(buffId)\n    for i, player in pairs(M.Party) do\n        local debuff = TensorCore.getBuff(player.id, buffId)\n        if debuff ~= nil then\n            return true\n        end\n    end\n    return false\nend\n\nM.M12S.InitM12SData()\nself.used = true",
						conditions = 
						{
							
							{
								"6fe5e0b6-2218-6544-9b9f-1c54202db3d2",
								true,
							},
						},
						uuid = "3a36b544-1644-d68a-9ebf-9dc08d976e45",
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
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "6fe5e0b6-2218-6544-9b9f-1c54202db3d2",
						version = 2,
					},
					inheritedIndex = 1,
				},
			},
			eventType = 11,
			name = "M12S初始化",
			uuid = "01c21e3b-f835-8520-b7fa-247cf2d8b76b",
			version = 2,
		},
		inheritedIndex = 14,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.GPuzzle2_Start\nd(\"进入门神2运\")\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"1644ed74-d65c-273e-bc55-ba3cff92c5f2",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "进入2运",
						uuid = "b40045c5-7ee7-23e9-baf8-f9323c86cef4",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.GPuzzle3_Start\nd(\"进入门神3运\")\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"980d9718-370d-de12-adc6-5bc75490b141",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "进入3运",
						uuid = "90bbf146-5bad-6e63-ac82-a5b00c656e45",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.GP3Info.SubMonster = TensorCore.mGetEntity(eventArgs.entityID)\nMuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.GPuzzle3_GotSnake\nd(\"读条效果获取完毕\")\nd(MuAiGuide.M12S.GP3Info.SubMonster.pos)\nd(eventArgs.spellID)\nd('--------------------------------------')\nself.used = true\n",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"28c71d1c-aef6-6454-8619-3a6601879186",
								true,
							},
							
							{
								"d1d5aabe-1b01-beeb-8f16-6fc4328870d0",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "破坏场地的蛇数据采集",
						uuid = "941fa26c-0e97-089e-a2e6-22701a7ebb3b",
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
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 48830,
						name = "48330-细胞附身·中期",
						uuid = "1644ed74-d65c-273e-bc55-ba3cff92c5f2",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 48831,
						name = "48331-细胞附身·晚期",
						uuid = "980d9718-370d-de12-adc6-5bc75490b141",
						version = 2,
					},
					inheritedIndex = 3,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgOptionType = 3,
						eventArgType = 2,
						eventSpellID = 46240,
						name = "46240 46241-盛大登场",
						spellIDList = 
						{
							46240,
							46241,
						},
						uuid = "28c71d1c-aef6-6454-8619-3a6601879186",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.GP3Info.SubMonster == nil",
						name = "尚未读取到3运小怪",
						uuid = "d1d5aabe-1b01-beeb-8f16-6fc4328870d0",
						version = 2,
					},
					inheritedIndex = 5,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState > MuAiGuide.M12S.StateEnum.GPuzzle3_Start\n\t\t\tand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.GPuzzle3_End",
						name = "已进入3运",
						uuid = "dc97e63d-ce22-890f-98f6-149f2aebb647",
						version = 2,
					},
				},
			},
			eventType = 3,
			name = "M12S门神阶段切换[开始读条]",
			uuid = "ed3702b5-fda0-d2eb-bfce-9dc253883a46",
			version = 2,
		},
		inheritedIndex = 14,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\n\nif data.debug2test == nil or data.debug2test ~= M.M12S.GP2Info.State then\n    d(\"M.M12S.GP2Info.State=\" .. tostring(M.M12S.GP2Info.State))\n    data.debug2test = M.M12S.GP2Info.State\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.GPuzzle2_Start then\n    M.FrameDirect(100, 100)\n    if table.size(M.M12S.GP2Info.ids) < 4 then\n        for _, ent in pairs(TensorCore.entityList(\"contentid=14381\")) do\n            if ent.action == 9352 then\n                if not table.contains(M.M12S.GP2Info.ids, ent.id) then\n                    table.insert(M.M12S.GP2Info.ids, ent.id)\n                    M.M12S.GP2Info.gSpawnIdx = M.M12S.GP2Info.gSpawnIdx + 1\n                    M.M12S.GP2Info.gTowers[M.M12S.GP2Info.gSpawnIdx] = ent\n                end\n            end\n        end\n        if table.size(M.M12S.GP2Info.ids) == 4 then\n            -- 读取BUFF信息，进入循环监视\n            M.M12S.CurrentState = M.M12S.StateEnum.GPuzzle2_Looping\n            if TensorCore.getBuff(M.GetPlayer().id, 4752) then\n                if TensorCore.getBuff(M.GetPlayer().id, 3004) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.A1\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3005) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.A2\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3006) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.A3\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3451) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.A4\n                end\n            elseif TensorCore.getBuff(M.GetPlayer().id, 4754) then\n                if TensorCore.getBuff(M.GetPlayer().id, 3004) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.B1\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3005) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.B2\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3006) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.B3\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3451) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.B4\n                end\n            end\n            d(\"M.M12S.GP2Info.selfType =\" .. tostring(M.M12S.GP2Info.selfType))\n        end\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.GPuzzle2_Looping then\n    if M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_end then\n        M.M12S.CurrentState = M.M12S.StateEnum.GPuzzle2_End\n    else\n        if (not M.M12S.GP2Info.pTowerFinish) and table.size(M.M12S.GP2Info.ids) < 8 then\n            for _, ent in pairs(TensorCore.entityList(\"contentid=14381\")) do\n                if ent.action == 9352 then\n                    if not table.contains(M.M12S.GP2Info.ids, ent.id) then\n                        table.insert(M.M12S.GP2Info.ids, ent.id)\n                        M.M12S.GP2Info.pSpawnIdx = M.M12S.GP2Info.pSpawnIdx + 1\n                        M.M12S.GP2Info.pTowers[M.M12S.GP2Info.pSpawnIdx] = ent\n                    end\n                end\n            end\n            if table.size(M.M12S.GP2Info.ids) == 8 then\n                M.M12S.GP2Info.pTowerFinish = true\n            end\n        end\n\n        if M.M12S.GP2Info.selfType == M.M12S.DataEnum.A1\n                or M.M12S.GP2Info.selfType == M.M12S.DataEnum.A2 then\n            if M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_01 then\n                local alpha = TensorCore.getBuff(M.GetPlayer().id, 4752)\n                if alpha == nil or alpha.duration <= 0 then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_02\n                else\n                    --等待\n                    M.FrameDirect(100, 100)\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_02 then\n                --拉线\n                if TensorCore.getBuff(M.GetPlayer().id, 2941) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_03\n                else\n                    local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                    if boss ~= nil then\n                        local pos = TensorCore.getPosInDirection(boss.pos, boss.pos.h, 14.5)\n                        M.FrameDirect(pos.x, pos.z)\n                    end\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_03 then\n                --踩塔\n                if TensorCore.getBuff(M.GetPlayer().id, 3935) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_end\n                else\n                    local tower\n                    if M.M12S.GP2Info.selfType == M.M12S.DataEnum.A1 then\n                        tower = M.M12S.GP2Info.gTowers[3]\n                    else\n                        tower = M.M12S.GP2Info.gTowers[4]\n                    end\n                    M.FrameDirect(tower.pos.x, tower.pos.z)\n                end\n            end\n        elseif M.M12S.GP2Info.selfType == M.M12S.DataEnum.A3\n                or M.M12S.GP2Info.selfType == M.M12S.DataEnum.A4 then\n            if M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_01 then\n                --踩塔\n                if TensorCore.getBuff(M.GetPlayer().id, 3935) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_02\n                else\n                    local tower\n                    if M.M12S.GP2Info.selfType == M.M12S.DataEnum.A3 then\n                        tower = M.M12S.GP2Info.gTowers[1]\n                    else\n                        tower = M.M12S.GP2Info.gTowers[2]\n                    end\n                    M.FrameDirect(tower.pos.x, tower.pos.z)\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_02 then\n                --回中\n                local alpha = TensorCore.getBuff(M.GetPlayer().id, 4752)\n                if alpha == nil or alpha.duration <= 0 then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_03\n                else\n                    M.FrameDirect(100, 100)\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_03 then\n                if TensorCore.getBuff(M.GetPlayer().id, 2941) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_end\n                else\n                    local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                    if boss ~= nil then\n                        local pos = TensorCore.getPosInDirection(boss.pos, boss.pos.h, 14.5)\n                        M.FrameDirect(pos.x, pos.z)\n                    end\n                end\n            end\n\n        elseif M.M12S.GP2Info.selfType == M.M12S.DataEnum.B1\n                or M.M12S.GP2Info.selfType == M.M12S.DataEnum.B2 then\n            if M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_01 then\n                local beta = TensorCore.getBuff(M.GetPlayer().id, 4754)\n                if beta == nil or beta.duration <= 0 then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_02\n                else\n                    M.FrameDirect(100, 100)\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_02 then\n                if TensorCore.getBuff(M.GetPlayer().id, 2941) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_03\n                else\n                    local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                    if boss ~= nil then\n                        local pos = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi, 9)\n                        M.FrameDirect(pos.x, pos.z)\n                    end\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_03 then\n                if TensorCore.getBuff(M.GetPlayer().id, 3935) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_04\n                else\n                    local tower\n                    if M.M12S.GP2Info.selfType == M.M12S.DataEnum.B1 then\n                        tower = M.M12S.GP2Info.pTowers[3]\n                    else\n                        tower = M.M12S.GP2Info.pTowers[4]\n                    end\n                    if tower ~= nil then\n                        M.FrameDirect(tower.pos.x, tower.pos.z)\n                    else\n                        M.FrameDirect(100, 100)\n                    end\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_04 then\n                local buff = TensorCore.getBuff(M.GetPlayer().id, 3935)\n                if buff ~= nil and buff.duration > 0 then\n                    if M.M12S.GP2Info.guidePosIn == nil then\n                        local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                        M.M12S.GP2Info.guidePosIn = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi / 2, 8)\n                        M.M12S.GP2Info.guidePosOut = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi / 2, 14.5)\n                    end\n                    if buff.duration > 22 then\n                        M.FrameDirect(M.M12S.GP2Info.guidePosIn.x, M.M12S.GP2Info.guidePosIn.z)\n                    elseif buff.duration > 17 then\n                        M.FrameDirect(M.M12S.GP2Info.guidePosOut.x, M.M12S.GP2Info.guidePosOut.z)\n                    else\n                        M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_end\n                    end\n                end\n            end\n        elseif M.M12S.GP2Info.selfType == M.M12S.DataEnum.B3\n                or M.M12S.GP2Info.selfType == M.M12S.DataEnum.B4 then\n            if M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_01 then\n                local buff = TensorCore.getBuff(M.GetPlayer().id, 3935) --出毒抗\n                if buff ~= nil and buff.duration > 0 then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_02\n                else\n                    local tower\n                    if M.M12S.GP2Info.selfType == M.M12S.DataEnum.B3 then\n                        tower = M.M12S.GP2Info.pTowers[1]\n                    else\n                        tower = M.M12S.GP2Info.pTowers[2]\n                    end\n                    if tower ~= nil then\n                        M.FrameDirect(tower.pos.x, tower.pos.z)\n                    else\n                        M.FrameDirect(100, 100)\n                    end\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_02 then\n                local beta = TensorCore.getBuff(M.GetPlayer().id, 4754)\n                if beta == nil or beta.duration <= 0 then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_03\n                else\n                    M.FrameDirect(100, 100)\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_03 then\n                if TensorCore.getBuff(M.GetPlayer().id, 2941) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_04\n                else\n                    local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                    if boss ~= nil then\n                        local pos = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi, 9)\n                        M.FrameDirect(pos.x, pos.z)\n                    end\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_04 then\n                local buff = TensorCore.getBuff(M.GetPlayer().id, 2941)\n                if buff and buff.duration > 0 then\n                    if M.M12S.GP2Info.selfType == M.M12S.DataEnum.B3 then\n                        if buff.duration < 6.5 and buff.duration > 5 then\n                            if M.M12S.GP2Info.guidePosIn == nil then\n                                local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                                M.M12S.GP2Info.guidePosIn = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi / 2, 8)\n                                M.M12S.GP2Info.guidePosOut = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi / 2, 14.5)\n                            end\n                        end\n                        if buff.duration > 4.5 then\n                            M.FrameDirect(100, 100)\n                        elseif buff.duration > 1 then\n                            M.FrameDirect(M.M12S.GP2Info.guidePosIn.x, M.M12S.GP2Info.guidePosIn.z)\n                        else\n                            local buff3935 = TensorCore.getBuff(M.GetPlayer().id, 3935)\n                            if buff3935 == nil or buff3935.duration < 8 then\n                                M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_end\n                            else\n                                M.FrameDirect(M.M12S.GP2Info.guidePosOut.x, M.M12S.GP2Info.guidePosOut.z)\n                            end\n                        end\n                    elseif M.M12S.GP2Info.selfType == M.M12S.DataEnum.B4 then\n                        if buff.duration < 6.5 then\n                            if M.M12S.GP2Info.guidePosOut == nil then\n                                local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                                M.M12S.GP2Info.guidePosOut = TensorCore.getPosInDirection(boss.pos, boss.pos.h, 14.5)\n                            end\n                            M.FrameDirect(M.M12S.GP2Info.guidePosOut.x, M.M12S.GP2Info.guidePosOut.z)\n                        elseif buff == nil or buff.duration < 0.1 then\n                            M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_end\n                        end\n                    end\n                end\n            end\n        end\n    end\nend\n\nself.used = true",
						conditions = 
						{
							
							{
								"42135860-fa43-bb22-ba90-ab4d78c0b3bd",
								true,
							},
							
							{
								"53868273-c873-a826-a0c3-a3e1586e62d9",
								true,
							},
						},
						uuid = "3beb9fc0-87d2-67b7-8665-6c6ba1676348",
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
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "42135860-fa43-bb22-ba90-ab4d78c0b3bd",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.GPuzzle2_Start\n\t\tand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.GPuzzle2_End",
						name = "门神2运",
						uuid = "53868273-c873-a826-a0c3-a3e1586e62d9",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M12S门神2运主循环",
			uuid = "79562d51-d887-4795-96b7-ca10cab1b0e9",
			version = 2,
		},
		inheritedIndex = 17,
	},
	
	{
		data = 
		{
			actions = 
			{
			},
			conditions = 
			{
				
				{
					data = 
					{
						category = "Self",
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "10a41e61-6525-6b14-91c5-b7bc3c7d7f40",
						version = 2,
					},
					inheritedIndex = 1,
				},
			},
			enabled = false,
			eventType = 2,
			name = "M12S门神切换阶段[读条后]",
			uuid = "4b024502-df43-593f-861e-52e28a341687",
			version = 2,
		},
		inheritedIndex = 16,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\nif M.M12S.CurrentState == M.M12S.StateEnum.GPuzzle3_GotSnake then\n    local buff3935 = TensorCore.getBuff(M.GetPlayer().id, 3935)\n    if buff3935 ~= nil then\n        M.M12S.CurrentState = M.M12S.StateEnum.GPuzzle3_End\n    else\n        if M.M12S.GP3Info.selfBuff == nil then\n            M.M12S.GP3Info.selfBuff = TensorCore.getBuff(M.GetPlayer().id, 3558)\n        end\n        if M.M12S.GP3Info.guidePos == nil then\n            if MuAiGuide.M12S.GP3Info.SubMonster.pos.x < 85 then\n                --左上出现，十字安全\n                if M.M12S.GP3Info.selfBuff.stacks == 1078 then\n                    --向上\n                    if M.IsDps(M.GetPlayer().job) then\n                        M.M12S.GP3Info.guidePos = { x = 103.5, z = 106.5 }\n                    else\n                        M.M12S.GP3Info.guidePos = { x = 96.5, z = 113.5 }\n                    end\n                elseif M.M12S.GP3Info.selfBuff.stacks == 1079 then\n                    --向右\n                    if M.IsDps(M.GetPlayer().job) then\n                        M.M12S.GP3Info.guidePos = { x = 88.5, z = 103.5 }\n                    else\n                        M.M12S.GP3Info.guidePos = { x = 81.5, z = 96.5 }\n                    end\n                elseif M.M12S.GP3Info.selfBuff.stacks == 1080 then\n                    --向下\n                    if M.IsDps(M.GetPlayer().job) then\n                        M.M12S.GP3Info.guidePos = { x = 103.5, z = 86.5 }\n                    else\n                        M.M12S.GP3Info.guidePos = { x = 96.5, z = 93.5 }\n                    end\n                elseif M.M12S.GP3Info.selfBuff.stacks == 1081 then\n                    --向左\n                    if M.IsDps(M.GetPlayer().job) then\n                        M.M12S.GP3Info.guidePos = { x = 118.5, z = 103.5 }\n                    else\n                        M.M12S.GP3Info.guidePos = { x = 111.5, z = 96.5 }\n                    end\n                end\n            else\n                if M.M12S.GP3Info.selfBuff.stacks == 1078 then\n                    if M.IsDps(M.GetPlayer().job) then\n                        M.M12S.GP3Info.guidePos = { x = 88.5, z = 113.5 }\n                    else\n                        M.M12S.GP3Info.guidePos = { x = 81.5, z = 106.5 }\n                    end\n                    --向上\n                elseif M.M12S.GP3Info.selfBuff.stacks == 1079 then\n                    --向右\n                    if M.IsDps(M.GetPlayer().job) then\n                        M.M12S.GP3Info.guidePos = { x = 88.5, z = 93.5 }\n                    else\n                        M.M12S.GP3Info.guidePos = { x = 81.5, z = 86.5 }\n                    end\n                elseif M.M12S.GP3Info.selfBuff.stacks == 1080 then\n                    --向下\n                    if M.IsDps(M.GetPlayer().job) then\n                        M.M12S.GP3Info.guidePos = { x = 118.5, z = 93.5 }\n                    else\n                        M.M12S.GP3Info.guidePos = { x = 111.5, z = 86.5 }\n                    end\n                elseif M.M12S.GP3Info.selfBuff.stacks == 1081 then\n                    --向左\n                    if M.IsDps(M.GetPlayer().job) then\n                        M.M12S.GP3Info.guidePos = { x = 118.5, z = 113.5 }\n                    else\n                        M.M12S.GP3Info.guidePos = { x = 111.5, z = 106.5 }\n                    end\n                end\n            end\n        end\n        M.FrameDirect(M.M12S.GP3Info.guidePos.x, M.M12S.GP3Info.guidePos.z)\n    end\nend\nself.used = true",
						conditions = 
						{
							
							{
								"42135860-fa43-bb22-ba90-ab4d78c0b3bd",
								true,
							},
							
							{
								"0b399c82-8d7f-f81a-9292-bd9ec13413e9",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						uuid = "3beb9fc0-87d2-67b7-8665-6c6ba1676348",
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
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "42135860-fa43-bb22-ba90-ab4d78c0b3bd",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState > MuAiGuide.M12S.StateEnum.GPuzzle3_Start\n\t\t\tand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.GPuzzle3_End",
						name = "已进入3运",
						uuid = "0b399c82-8d7f-f81a-9292-bd9ec13413e9",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M12S门神3运主循环",
			uuid = "c88ef753-2fab-19da-b48b-cd0a69a9505c",
			version = 2,
		},
		inheritedIndex = 18,
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
			name = "-- 本体 --",
			uuid = "960bb8b2-a094-8d02-93bf-bed17a863848",
			version = 2,
		},
		inheritedIndex = 20,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local drawer, pos\nif eventArgs.spellID == 46301 then\n    --火读条\n    drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0.2), 1)\n    pos = TensorCore.mGetEntity(eventArgs.entityID).pos\nelseif eventArgs.spellID == 46303 then\n    --暗读条\n    drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 255 / 255, 0.2), 1)\n    pos = TensorCore.mGetEntity(eventArgs.entityID).pos\nend\nif drawer ~= nil then\n    drawer:addTimedCircle(3000, pos.x, 0, pos.z, 2, 0, true)\nend\nself.used = true\n",
						conditions = 
						{
							
							{
								"5f1a198f-2aad-2829-a667-3542181eb2b4",
								true,
							},
							
							{
								"6da42a21-cb5c-9030-98e2-a3c7c88ea860",
								true,
							},
						},
						uuid = "166ea82c-7e88-fb84-9415-b9df22d34e19",
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
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "5f1a198f-2aad-2829-a667-3542181eb2b4",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgOptionType = 3,
						eventArgType = 2,
						eventEntityID = 46301,
						eventSpellID = 46301,
						spellIDList = 
						{
							46301,
							46303,
						},
						uuid = "6da42a21-cb5c-9030-98e2-a3c7c88ea860",
						version = 2,
					},
				},
			},
			eventType = 3,
			name = "M12S本体一运小怪读条",
			uuid = "0f39daec-7399-2a52-b3b0-7ec0c6a5e610",
			version = 2,
		},
		inheritedIndex = 19,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle4_Start\nd(\"进入4运\")\nself.used = true",
						conditions = 
						{
							
							{
								"97117f4f-6e97-da27-8352-29d3abda1724",
								true,
							},
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"f8f3a749-3db0-a083-a884-8f131db08476",
								true,
							},
						},
						name = "四运-开始",
						uuid = "4dc29bbe-3a6a-0c9c-a66e-24b1414f6e2d",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif ent.pos.z > 100 then\n    if M.Config.Main.M12SP4SendMacro then\n        SendTextCommand(\"/p 【C】上下刀，23外躲钢铁\")\n    end\n\n    M.M12S.P4Sub3Info.SkillType = M.M12S.DataEnum.UpDownSkillC\nelse\n    if M.Config.Main.M12SP4SendMacro then\n        SendTextCommand(\"/p 【A】上下刀，14点上安全\")\n    end\n    M.M12S.P4Sub3Info.SkillType = M.M12S.DataEnum.UpDownSkillA\nend\n-- 切换到2次连线\nM.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_SecondLink\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"7ef8e5dd-d3a3-a937-aff8-95948160bccd",
								true,
							},
							
							{
								"e8896ce2-b9e1-bfa5-aa77-bb583e31fcbe",
								true,
							},
						},
						gVar = "ACR_TensorRequiem3_CD",
						name = "四运-上下刀小怪位置采集",
						uuid = "8a4f6557-87e7-9029-a22e-5289e266af18",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "function condition()\n    return M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_div2Subs\nend\n\nlocal M = MuAiGuide\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif eventArgs.spellID == 46351 then\n    d(\"小怪读条左右刀\")\n    --左右刀\n    if ent.pos.x > 100 then\n        if M.IsTank(M.SelfPos) or M.IsMelee(M.GetPlayer().job) then\n            M.M12S.P4Sub3Info.divGuidePos1 = { x = 110, y = 0, z = 94.5 }\n            M.M12S.P4Sub3Info.divGuidePos2 = { x = 110, y = 0, z = 105.5 }\n        else\n            M.M12S.P4Sub3Info.divGuidePos1 = { x = 114, y = 0, z = 94.5 }\n            M.M12S.P4Sub3Info.divGuidePos2 = { x = 114, y = 0, z = 105.5 }\n        end\n    else\n        if M.IsTank(M.SelfPos) or M.IsMelee(M.GetPlayer().job) then\n            M.M12S.P4Sub3Info.divGuidePos1 = { x = 90, y = 0, z = 94.5 }\n            M.M12S.P4Sub3Info.divGuidePos2 = { x = 90, y = 0, z = 105.5 }\n        else\n            M.M12S.P4Sub3Info.divGuidePos1 = { x = 86, y = 0, z = 94.5 }\n            M.M12S.P4Sub3Info.divGuidePos2 = { x = 86, y = 0, z = 105.5 }\n        end\n    end\n    M.M12S.P4Sub3Info.teleport = M.M12S.DataEnum.UpDown\nelseif eventArgs.spellID == 46352 then\n    d(\"小怪读条左上下刀\")\n    --上下刀\n    if ent.pos.x > 100 then\n        M.M12S.P4Sub3Info.divGuidePos1 = { x = 108, y = 0, z = 100 }\n        M.M12S.P4Sub3Info.divGuidePos2 = { x = 108, y = 0, z = 100 }\n    else\n        M.M12S.P4Sub3Info.divGuidePos1 = { x = 92, y = 0, z = 100 }\n        M.M12S.P4Sub3Info.divGuidePos2 = { x = 92, y = 0, z = 100 }\n    end\n    M.M12S.P4Sub3Info.teleport = M.M12S.DataEnum.LeftRight\nend\nMuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle4_div2SubsEnd\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"2ea47182-803f-86ea-87a5-c23959e8ee83",
								true,
							},
							
							{
								"3631adb4-7ecb-8c12-99c5-971de14cb24a",
								true,
							},
						},
						name = "四运-小世界上下or左右刀",
						uuid = "c7fb0a3c-f564-435f-b537-9076cf358bc0",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.PuzzleEnd_Start\nd(\"四运结束\")\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"97117f4f-6e97-da27-8352-29d3abda1724",
								true,
							},
							
							{
								"5cd9a6f2-9e64-75ea-bb0d-26353272d646",
								true,
							},
						},
						name = "四运-结束",
						uuid = "cc2167a1-328d-a365-8a4d-342ecaf2a03a",
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
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.Puzzle4_Start\n",
						name = "没到四运",
						uuid = "f8f3a749-3db0-a083-a884-8f131db08476",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 46345,
						eventSpellName = "-1",
						name = "46345-镜中奇梦[四运]",
						uuid = "97117f4f-6e97-da27-8352-29d3abda1724",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 46352,
						name = "46352-上下刀",
						uuid = "7ef8e5dd-d3a3-a937-aff8-95948160bccd",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 46351,
						name = "46351-左右刀",
						uuid = "368d39ac-a8b3-820d-8851-86e75fdb80a9",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgOptionType = 3,
						eventArgType = 2,
						name = "小世界上下or左右刀",
						spellIDList = 
						{
							46352,
							46351,
						},
						uuid = "2ea47182-803f-86ea-87a5-c23959e8ee83",
						version = 2,
					},
					inheritedIndex = 5,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_GetSKills",
						name = "四运-获取小怪上下刀阶段",
						uuid = "e8896ce2-b9e1-bfa5-aa77-bb583e31fcbe",
						version = 2,
					},
					inheritedIndex = 5,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_div2Subs",
						name = "四运-小世界观察小怪阶段",
						uuid = "3631adb4-7ecb-8c12-99c5-971de14cb24a",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_CopyBoom2 ",
						name = "四运-最后一次炸大圈结束",
						uuid = "5cd9a6f2-9e64-75ea-bb0d-26353272d646",
						version = 2,
					},
				},
			},
			eventType = 3,
			name = "M12S本体阶段切换[开始读条]",
			uuid = "b48d47b0-28c9-0e72-82e7-abf66b902646",
			version = 2,
		},
		inheritedIndex = 14,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle4_GetSKills \nd(\"四运-停止1线，开始观察小怪\")\nself.used = true",
						conditions = 
						{
							
							{
								"10a41e61-6525-6b14-91c5-b7bc3c7d7f40",
								true,
							},
							
							{
								"7e92a291-58df-a968-8b38-75b9258c978f",
								true,
							},
							
							{
								"daa00ba3-20f1-d296-b968-928cf8113227",
								true,
							},
						},
						name = "四运-停止1线，开始观察小怪",
						uuid = "5826dbfa-b970-b92c-b20c-7183c5845228",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle4_ThirdLink\nd(\"四运-第1次小世界结束\")\nself.used = true",
						conditions = 
						{
							
							{
								"10a41e61-6525-6b14-91c5-b7bc3c7d7f40",
								true,
							},
							
							{
								"daa00ba3-20f1-d296-b968-928cf8113227",
								true,
							},
							
							{
								"c4ab53ea-af69-3c46-a08f-2bd545fc86de",
								true,
							},
						},
						name = "四运-第1次小世界结束",
						uuid = "799f2371-903b-a3c6-b658-f16efc74126e",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle4_Tower2\nd(\"四运-第2次小世界开始\")\nself.used = true",
						conditions = 
						{
							
							{
								"10a41e61-6525-6b14-91c5-b7bc3c7d7f40",
								true,
							},
							
							{
								"daa00ba3-20f1-d296-b968-928cf8113227",
								true,
							},
							
							{
								"15bdb901-b9d9-c57e-91dc-e25357f1ef8b",
								true,
							},
						},
						name = "四运-第2次小世界开始",
						uuid = "06e9faba-df50-8e07-b072-38e0628923c8",
						version = 2.1,
					},
					inheritedIndex = 3,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle4_div2End\nd(\"四运-第2次小世界结束\")\nself.used = true",
						conditions = 
						{
							
							{
								"10a41e61-6525-6b14-91c5-b7bc3c7d7f40",
								true,
							},
							
							{
								"daa00ba3-20f1-d296-b968-928cf8113227",
								true,
							},
							
							{
								"e9b1a7c9-ae70-ba9b-ab54-ee185fe91b91",
								true,
							},
						},
						name = "四运-第2次小世界结束",
						uuid = "0ae1e6fc-db43-fa87-80d2-fcf1e407f6ab",
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
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "10a41e61-6525-6b14-91c5-b7bc3c7d7f40",
						version = 2,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_FirstLink ",
						name = "4运-第一次连线结束",
						uuid = "7e92a291-58df-a968-8b38-75b9258c978f",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_GetBuff ",
						name = "4运-小世界光BUFF",
						uuid = "c4ab53ea-af69-3c46-a08f-2bd545fc86de",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_PutEnd",
						name = "4运-4次分摊分散结束",
						uuid = "15bdb901-b9d9-c57e-91dc-e25357f1ef8b",
						version = 2,
					},
					inheritedIndex = 4,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_div2SubsEnd",
						name = "4运-小世界观察小怪结束",
						uuid = "e9b1a7c9-ae70-ba9b-ab54-ee185fe91b91",
						version = 2,
					},
					inheritedIndex = 5,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 48098,
						name = "48098-心像投影",
						uuid = "daa00ba3-20f1-d296-b968-928cf8113227",
						version = 2,
					},
					inheritedIndex = 4,
				},
			},
			eventType = 2,
			name = "M12S本体切换阶段[读条后]",
			uuid = "021a9e74-9ec4-8881-beb5-cb1621c7a609",
			version = 2,
		},
		inheritedIndex = 21,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\n--- step 1.2\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Start then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=14383\")) do\n        if Argus.isEntityVisible(ent) then\n            if M.M12S.P4CopyInfo.spawnType == nil then\n                local curEntAngle = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n                for i = 0, 7 do\n                    local curAngle = i * math.pi / 4\n                    if M.IsSameDirection(curAngle, curEntAngle) then\n                        if i % 2 == 0 then\n                            M.M12S.P4CopyInfo.spawnType = M.M12S.DataEnum.Puzzle4Char\n                            if M.Config.Main.M12SP4SendMacro then\n                                if M.Config.Main.M12SP4UpTime then\n                                    SendTextCommand(\"/p 第一次分摊：双T去A，远程和奶去B，近战去1\")\n                                    SendTextCommand(\"/p 第二次分摊：双T去4，远程和奶去3，近战去D\")\n                                else\n                                    SendTextCommand(\"/p 第一次分摊：MT组去A，ST组去B\")\n                                    SendTextCommand(\"/p 第二次分摊：MT组去4，ST组去3\")\n                                end\n\n                            end\n                            break\n                        elseif i % 2 == 1 then\n                            M.M12S.P4CopyInfo.spawnType = M.M12S.DataEnum.Puzzle4Number\n                            if M.Config.Main.M12SP4SendMacro then\n                                if M.Config.Main.M12SP4UpTime then\n                                    SendTextCommand(\"/p 第一次分摊：双T去4，远程和奶去3，近战去D\")\n                                    SendTextCommand(\"/p 第二次分摊：双T去A，远程和奶去B，近战去1\")\n                                else\n                                    SendTextCommand(\"/p 第一次分摊：MT组去4，ST组去3\")\n                                    SendTextCommand(\"/p 第二次分摊：MT组去A，ST组去B\")\n                                end\n                            end\n                            break\n                        end\n                    end\n                end\n            end\n            if not table.contains(M.M12S.P4CopyInfo.ids, ent.id) then\n                table.insert(M.M12S.P4CopyInfo.ids, ent.id)\n            end\n        end\n    end\n    if M.M12S.P4CopyInfo.spawnType ~= nil and table.size(M.M12S.P4CopyInfo.ids) == 4 then\n        --进入到下一个状态\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Spawn_Copy1\n        if M.M12S.P4CopyInfo.spawnType == M.M12S.DataEnum.Puzzle4Char then\n            if M.Config.Main.M12SP4UpTime then\n                if M.SelfPos == \"MT\" or M.SelfPos == \"ST\" then\n                    M.M12S.P4CopyInfo.gatherPos1 = { x = 100, z = 84 } -- A\n                    M.M12S.P4CopyInfo.gatherPos2 = { x = 88.7, z = 88.7 } -- 4\n                elseif M.IsMelee(M.GetPlayer().job) then\n                    M.M12S.P4CopyInfo.gatherPos1 = { x = 105.8, z = 94.2 } -- 1\n                    M.M12S.P4CopyInfo.gatherPos2 = { x = 91.9, z = 100 } -- D\n                else\n                    M.M12S.P4CopyInfo.gatherPos1 = { x = 116, z = 100 } -- B\n                    M.M12S.P4CopyInfo.gatherPos2 = { x = 88.7, z = 111.26 } -- 3\n                end\n            else\n                if table.contains({ \"MT\", \"H1\", \"D1\", \"D3\" }, M.SelfPos) then\n                    M.M12S.P4CopyInfo.gatherPos1 = { x = 100, z = 84 } -- A\n                    M.M12S.P4CopyInfo.gatherPos2 = { x = 88.7, z = 88.7 } -- 4\n                else\n                    M.M12S.P4CopyInfo.gatherPos1 = { x = 116, z = 100 } -- B\n                    M.M12S.P4CopyInfo.gatherPos2 = { x = 88.7, z = 111.26 } -- 3\n                end\n            end\n        else\n            if M.Config.Main.M12SP4UpTime then\n                if M.SelfPos == \"MT\" or M.SelfPos == \"ST\" then\n                    M.M12S.P4CopyInfo.gatherPos1 = { x = 88.7, z = 88.7 } -- 4\n                    M.M12S.P4CopyInfo.gatherPos2 = { x = 100, z = 84 } -- A\n                elseif M.IsMelee(M.GetPlayer().job) then\n                    M.M12S.P4CopyInfo.gatherPos1 = { x = 91.9, z = 100 } -- D\n                    M.M12S.P4CopyInfo.gatherPos2 = { x = 105.8, z = 94.2 } -- 1\n                else\n                    M.M12S.P4CopyInfo.gatherPos1 = { x = 88.7, z = 111.26 } -- 3\n                    M.M12S.P4CopyInfo.gatherPos2 = { x = 116, z = 100 } -- B\n                end\n            else\n                if table.contains({ \"MT\", \"H1\", \"D1\", \"D3\" }, M.SelfPos) then\n                    M.M12S.P4CopyInfo.gatherPos1 = { x = 88.7, z = 88.7 } -- 4\n                    M.M12S.P4CopyInfo.gatherPos2 = { x = 100, z = 84 } -- A\n                else\n                    M.M12S.P4CopyInfo.gatherPos1 = { x = 88.7, z = 111.26 } -- 3\n                    M.M12S.P4CopyInfo.gatherPos2 = { x = 116, z = 100 } -- B\n                end\n            end\n        end\n    end\nend\n\n--- step 1.2\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Spawn_Copy1 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=14383\")) do\n        if Argus.isEntityVisible(ent) then\n            if not table.contains(M.M12S.P4CopyInfo.ids, ent.id) then\n                table.insert(M.M12S.P4CopyInfo.ids, ent.id)\n            end\n        end\n    end\n    if table.size(M.M12S.P4CopyInfo.ids) == 8 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Spawn_Copy2\n        d(\"第二波复制体刷新完成\")\n    end\nend\n\n--- 连线阶段\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Spawn_Copy2 then\n    local tethers = Argus.getTethersOnEnt(M.GetPlayer().id)\n    if tethers ~= nil and table.size(tethers) > 0 then\n        for _, tether in pairs(tethers) do\n            if tether.type == 117 then\n                local partner = TensorCore.mGetEntity(tether.partnerid)\n                local targetPos = M.GetPointAtDistance({ x = 100, y = 0, z = 100 }, partner.pos, 6)\n                M.M12S.P4CopyInfo.linkPos = partner.pos\n                M.M12S.P4CopyInfo.guidePos = targetPos\n                M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_FirstLink\n                break\n            end\n        end\n    end\nend\n\n--- 如果仍然处在连线阶段中\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_FirstLink then\n    MuAiGuide.FrameDirect(M.M12S.P4CopyInfo.guidePos.x, M.M12S.P4CopyInfo.guidePos.z)\nend\n\n--- 接线准备阶段\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_SecondLink then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=14380\")) do\n        if Argus.isEntityVisible(ent) then\n            if not table.contains(M.M12S.P4CatchLineInfo.ids, ent.id) then\n                local tethers = Argus.getTethersOnEnt(ent.id)\n                for _, tether in pairs(tethers) do\n                    if tether.type == 112 or tether.type == 113 then\n                        local curLinkMstInfo = {\n                            id = ent.id,\n                            pos = ent.pos,\n                            type = tether.type\n                        }\n                        for i = 1, 8 do\n                            local curDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n                            if M.IsSameDirection(math.pi * i / 4, curDir) then\n                                curLinkMstInfo.dirIdx = i\n                                break\n                            end\n                        end\n                        table.insert(M.M12S.P4CatchLineInfo.ids, ent.id)\n                        M.M12S.P4CatchLineInfo.entities[curLinkMstInfo.dirIdx] = curLinkMstInfo\n                        break\n                    end\n                end\n            end\n        end\n    end\n    if table.size(M.M12S.P4CatchLineInfo.ids) == 8 then\n        if M.Config.Main.M12SP4SendMacro then\n            local EntA =  M.M12S.P4CatchLineInfo.entities[4]\n            if EntA ~= nil then\n                if EntA.type == M.M12S.DataEnum.Gather  then\n                    SendTextCommand(\"/p 分摊-13出-分摊-24出\")\n                else\n                    SendTextCommand(\"/p AC出-分摊-BD出-分摊\")\n                end\n            end \n        end\n        local fstIdx = 0\n        for i = 1, 8 do\n            local curDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, M.M12S.P4CopyInfo.linkPos)\n            if M.IsSameDirection(math.pi * i / 4, curDir) then\n                fstIdx = i\n                break\n            end\n        end\n        if fstIdx > 0 then\n            -- 计算分摊分散\n            -- 右下开始索引，C点为8\n            if table.contains({ 2, 4, 5, 7 }, fstIdx) then\n                --BA43\n                M.M12S.P4CatchLineInfo.type = M.M12S.DataEnum.Gather\n            else\n                M.M12S.P4CatchLineInfo.type = M.M12S.DataEnum.Disperse\n            end\n            local newIdx = 0\n            -- 计算当前应该\n            local backSub = M.M12S.P4CatchLineInfo.entities[fstIdx]\n            if backSub.type == M.M12S.P4CatchLineInfo.type then\n                M.M12S.P4CatchLineInfo.linkPos = backSub.pos\n                M.M12S.P4CatchLineInfo.linkId = backSub.id\n                newIdx = fstIdx\n            else\n                if fstIdx % 2 == 1 then\n                    newIdx = fstIdx + 1\n                else\n                    newIdx = fstIdx - 1\n                end\n                local otherSub = M.M12S.P4CatchLineInfo.entities[newIdx]\n                M.M12S.P4CatchLineInfo.linkPos = otherSub.pos\n                M.M12S.P4CatchLineInfo.linkId = otherSub.id\n            end\n            -- 计算左右分组\n            if newIdx <= 4 then\n                M.M12S.P4CatchLineInfo.group = M.M12S.DataEnum.Right\n                M.M12S.P4CatchLineInfo.putGatherPos = { x = 110, z = 90 }\n                M.M12S.P4CatchLineInfo.putDispersePos = { x = 111, z = 116 }\n            else\n                M.M12S.P4CatchLineInfo.group = M.M12S.DataEnum.Left\n                M.M12S.P4CatchLineInfo.putGatherPos = { x = 90, z = 90 }\n                M.M12S.P4CatchLineInfo.putDispersePos = { x = 89, z = 116 }\n            end\n            -- 计算点名爆炸顺序\n            if newIdx == 4 or newIdx == 8 then\n                M.M12S.P4CatchLineInfo.order = 1\n            elseif newIdx == 3 or newIdx == 7 then\n                M.M12S.P4CatchLineInfo.order = 2\n            elseif newIdx == 2 or newIdx == 6 then\n                M.M12S.P4CatchLineInfo.order = 3\n            elseif newIdx == 1 or newIdx == 5 then\n                M.M12S.P4CatchLineInfo.order = 4\n            end\n            M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_CatchLink\n        end\n    end\nend\n\n-- 如果连线对象不对，就一直指路\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_CatchLink then\n    local changeState = false\n    for _, player in pairs(M.Party) do\n        local tethers = Argus.getTethersOnEnt(player.id)\n        if table.size(tethers) > 0 then\n            for _, tether in pairs(tethers) do\n                if tether.type == M.M12S.DataEnum.LinkFinal then\n                    M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_CatchEnd\n                    M.M12S.Timer = Now()\n                    changeState = true\n                    break\n                end\n            end\n        end\n    end\n    if not changeState then\n        local tethers = Argus.getTethersOnEnt(M.GetPlayer().id)\n        local isTargetRight = false\n        if tethers ~= nil and table.size(tethers) > 0 then\n            for _, tether in pairs(tethers) do\n                if tether.type == M.M12S.P4CatchLineInfo.type and tether.partnerid == M.M12S.P4CatchLineInfo.linkId then\n                    isTargetRight = true\n                    break\n                end\n            end\n        end\n        if not isTargetRight then\n            MuAiGuide.FrameDirect(M.M12S.P4CatchLineInfo.linkPos.x, M.M12S.P4CatchLineInfo.linkPos.z)\n        end\n    end\nend\n\n-- 分散\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_CatchEnd then\n    if TimeSince(M.M12S.Timer) > 4500 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Div1\n        M.M12S.Timer = Now()\n    else\n        if M.M12S.P4Sub3Info.GuidePos1 == nil then\n            if M.M12S.P4Sub3Info.SkillType == M.M12S.DataEnum.UpDownSkillA then\n                local p4 = { x = 93, y = 0, z = 93 }\n                local p1 = { x = 107, y = 0, z = 93 }\n                local to4 = TensorCore.getDistance2d(M.GetPlayer().pos, p4)\n                local to1 = TensorCore.getDistance2d(M.GetPlayer().pos, p1)\n                if to4 > to1 then\n                    M.M12S.P4Sub3Info.GuidePos1 = p1\n                else\n                    M.M12S.P4Sub3Info.GuidePos1 = p4\n                end\n            else\n                local pL = { x = 89, y = 0, z = 103 }\n                local pR = { x = 111, y = 0, z = 103 }\n                local toR = TensorCore.getDistance2d(M.GetPlayer().pos, pR)\n                local toL = TensorCore.getDistance2d(M.GetPlayer().pos, pL)\n                if toR > toL then\n                    M.M12S.P4Sub3Info.GuidePos1 = pL\n                else\n                    M.M12S.P4Sub3Info.GuidePos1 = pR\n                end\n            end\n        else\n            MuAiGuide.FrameDirect(M.M12S.P4Sub3Info.GuidePos1.x, M.M12S.P4Sub3Info.GuidePos1.z)\n        end\n    end\nend\n\n-- 小世界1\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Div1 then\n    if TimeSince(M.M12S.Timer) > 4000 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Tower1\n        M.M12S.Timer = Now()\n    else\n        if table.contains({ \"MT\", \"D1\", \"H1\", \"D3\" }, M.SelfPos) then\n            MuAiGuide.FrameDirect(95, 100)\n        else\n            MuAiGuide.FrameDirect(105, 100)\n        end\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Tower1 then\n    if M.M12S.P4TowerData.towerIds == nil then\n        M.M12S.P4TowerData.towerIds = {}\n        M.M12S.P4TowerData.towers = {}\n    end\n    if table.size(M.M12S.P4TowerData.towerIds) < 8 then\n        for i = 3, 6 do\n            for _, ent in pairs(TensorCore.entityList(\"contentid=201501\" .. tostring(i))) do\n                if ent.pos.x > 100 then\n                    if ent.pos.x > 115 then\n                        if ent.pos.z > 100 then\n                            M.M12S.P4TowerData.towers[\"H2\"] = ent\n                        else\n                            M.M12S.P4TowerData.towers[\"D4\"] = ent\n                        end\n                    else\n                        if ent.pos.z > 100 then\n                            M.M12S.P4TowerData.towers[\"ST\"] = ent\n                        else\n                            M.M12S.P4TowerData.towers[\"D2\"] = ent\n                        end\n                    end\n                else\n                    if ent.pos.x > 85 then\n                        if ent.pos.z > 100 then\n                            M.M12S.P4TowerData.towers[\"D1\"] = ent\n                        else\n                            M.M12S.P4TowerData.towers[\"MT\"] = ent\n                        end\n                    else\n                        if ent.pos.z > 100 then\n                            M.M12S.P4TowerData.towers[\"D3\"] = ent\n                        else\n                            M.M12S.P4TowerData.towers[\"H1\"] = ent\n                        end\n                    end\n                end\n                table.insert(M.M12S.P4TowerData.towerIds, ent.id)\n            end\n        end\n    end\n    if table.size(M.M12S.P4TowerData.towerIds) == 8 then\n        if (M.M12S.P4TowerData.Self == nil or M.M12S.P4TowerData.Partner == nil) then\n            M.M12S.P4TowerData.Self = M.M12S.P4TowerData.towers[M.SelfPos]\n            M.M12S.P4TowerData.Partner = M.M12S.P4TowerData.towers[M.GetRMPartner()]\n        else\n            local selfBuff = TensorCore.getBuff(M.GetPlayer().id, 4164)\n            local targetBuff = TensorCore.getBuff(M.Party[M.GetRMPartner()].id, 4164)\n            if selfBuff ~= nil then\n                if M.M12S.P4TowerData.Self.contentid == 2015013 or M.M12S.P4TowerData.Self.contentid == 2015014 then\n                    local temp = M.M12S.P4TowerData.Self\n                    M.M12S.P4TowerData.Self = M.M12S.P4TowerData.Partner\n                    M.M12S.P4TowerData.Partner = temp\n                end\n                M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_GetBuff\n            elseif targetBuff ~= nil then\n                if M.M12S.P4TowerData.Partner.contentid == 2015013 or M.M12S.P4TowerData.Partner.contentid == 2015014 then\n                    local temp = M.M12S.P4TowerData.Self\n                    M.M12S.P4TowerData.Self = M.M12S.P4TowerData.Partner\n                    M.M12S.P4TowerData.Partner = temp\n                end\n                M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_GetBuff\n            else\n                M.FrameDirect(M.M12S.P4TowerData.Self.pos.x, M.M12S.P4TowerData.Self.pos.z)\n            end\n        end\n    end\nend\n\n--- 如果仍然处在连线阶段中\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_GetBuff then\n    M.FrameDirect(M.M12S.P4TowerData.Self.pos.x, M.M12S.P4TowerData.Self.pos.z)\nend\n\n-- 准备处理分摊分散\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_ThirdLink then\n    if M.M12S.Puzzle4_4TimesChange(2941) then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Put1\n        M.M12STimer = Now()\n    else\n        if M.M12S.P4CatchLineInfo.order == 1 and M.M12S.P4CatchLineInfo.type == M.M12S.DataEnum.Disperse then\n            pos = M.M12S.P4CatchLineInfo.putDispersePos\n        else\n            pos = M.M12S.P4CatchLineInfo.putGatherPos\n        end\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\n-- 分摊/分散2\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Put1 then\n    if M.M12S.Puzzle4_4TimesChange(2941) and TimeSince(M.M12STimer) > 3000 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Put2\n        M.M12STimer = Now()\n    else\n        if M.M12S.P4CatchLineInfo.order == 2 and M.M12S.P4CatchLineInfo.type == M.M12S.DataEnum.Disperse then\n            pos = M.M12S.P4CatchLineInfo.putDispersePos\n        else\n            pos = M.M12S.P4CatchLineInfo.putGatherPos\n        end\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\n-- 分摊/分散3\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Put2 then\n    if M.M12S.Puzzle4_4TimesChange(2941) and TimeSince(M.M12STimer) > 3000 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Put3\n        M.M12STimer = Now()\n    else\n        if M.M12S.P4CatchLineInfo.order == 3 and M.M12S.P4CatchLineInfo.type == M.M12S.DataEnum.Disperse then\n            pos = M.M12S.P4CatchLineInfo.putDispersePos\n        else\n            pos = M.M12S.P4CatchLineInfo.putGatherPos\n        end\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\n-- 分摊/分散4\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Put3 then\n    if M.M12S.Puzzle4_4TimesChange(2941) and TimeSince(M.M12STimer) > 3000 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_PutEnd\n        M.M12STimer = Now()\n    else\n        if M.M12S.P4CatchLineInfo.order == 4 and M.M12S.P4CatchLineInfo.type == M.M12S.DataEnum.Disperse then\n            pos = M.M12S.P4CatchLineInfo.putDispersePos\n        else\n            pos = M.M12S.P4CatchLineInfo.putGatherPos\n        end\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Tower2 then\n    if M.M12S.P4TowerData.guidePos == nil then\n        local selfTower = M.M12S.P4TowerData.Self\n        if selfTower.contentid == 2015016 then\n            -- 火\n            M.M12S.P4TowerData.guidePos = selfTower.pos\n        elseif selfTower.contentid == 2015013 then\n            -- 风\n            if selfTower.pos.x > 100 then\n                M.M12S.P4TowerData.guidePos = { x = selfTower.pos.x - 2, z = selfTower.pos.z }\n            else\n                M.M12S.P4TowerData.guidePos = { x = selfTower.pos.x + 2, z = selfTower.pos.z }\n            end\n        elseif selfTower.contentid == 2015014 then\n            -- 暗\n            if selfTower.pos.z > 100 then\n                M.M12S.P4TowerData.guidePos = { x = selfTower.pos.x, z = selfTower.pos.z + 2 }\n            else\n                M.M12S.P4TowerData.guidePos = { x = selfTower.pos.x, z = selfTower.pos.z - 2 }\n            end\n        elseif selfTower.contentid == 2015015 then\n            -- 土\n            M.M12S.P4TowerData.guidePos = selfTower.pos\n        end\n    end\n    local stateChange = M.M12S.Puzzle4_4TimesChange(4765)\n    if stateChange then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_TowerEnd\n        M.M12S.Timer = Now()\n    else\n        M.FrameDirect(M.M12S.P4TowerData.guidePos.x, M.M12S.P4TowerData.guidePos.z)\n    end\nend\n\n-- 踩塔后\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_TowerEnd then\n    if M.M12S.P4TowerData.Self.contentid == 2015013 then\n        -- 风等落地\n        if TimeSince(M.M12S.Timer) > 1000 and M.GetPlayer().pos.y < 0.01 then\n            M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_TowerFarNear\n        end\n    else\n        if M.M12S.P4TowerData.Self.contentid == 2015015 then\n            --土，先移动等待\n            if M.M12S.P4TowerData.Self.pos.z > 100 then\n                M.FrameDirect(M.M12S.P4TowerData.Self.pos.x, M.M12S.P4TowerData.Self.pos.z - 4)\n            else\n                M.FrameDirect(M.M12S.P4TowerData.Self.pos.x, M.M12S.P4TowerData.Self.pos.z + 4)\n            end\n        end\n        if TimeSince(M.M12S.Timer) > 1500 then\n            local anyoneHasFire = false\n            for _, player in pairs(M.Party) do\n                local debuff = TensorCore.getBuff(player.id, 4768)\n                if debuff ~= nil and debuff.duration >= 0 then\n                    anyoneHasFire = true\n                    break\n                end\n            end\n            if not anyoneHasFire then\n                M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_TowerFarNear\n            end\n        end\n    end\nend\n\n-- 远近扇形\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_TowerFarNear then\n    local changeState = true\n    for _, player in pairs(M.Party) do\n        local debuff = TensorCore.getBuff(player.id, 4765)\n        if debuff ~= nil and debuff.duration >= 0 then\n            changeState = false\n            break\n        end\n    end\n    if changeState then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_div2Subs\n    else\n        local player = M.GetPlayer()\n        if TensorCore.getBuff(player.id, 4767) then\n            --近\n            if player.pos.x > 100 then\n                M.FrameDirect(107, 100)\n            else\n                M.FrameDirect(93, 100)\n            end\n        elseif TensorCore.getBuff(player.id, 4766) then\n            -- 远\n            if player.pos.x > 100 then\n                M.FrameDirect(107, 93)\n            else\n                M.FrameDirect(93, 106)\n            end\n        else\n            if table.contains({ \"MT\", \"ST\", \"D1\", \"D2\" }, M.SelfPos) then\n                local target\n                for _, ent in pairs(M.Party) do\n                    local debuff = TensorCore.getBuff(ent.id, 4767)\n                    if debuff ~= nil then\n                        if player.pos.x > 100 and ent.pos.x > 100\n                                or player.pos.x < 100 and ent.pos.x < 100\n                        then\n                            target = ent\n                            break\n                        end\n                    end\n                end\n                if target ~= nil then\n                    local heading\n                    if target.pos.x > 100 then\n                        heading = math.pi / 2\n                    else\n                        heading = math.pi * 3 / 2\n                    end\n                    local targetPos = TensorCore.getPosInDirection(target.pos, heading, 1)\n                    M.FrameDirect(targetPos.x, targetPos.z, 0.3)\n                end\n            else\n                if player.pos.x > 100 then\n                    M.FrameDirect(117, 109)\n                else\n                    M.FrameDirect(83, 91)\n                end\n            end\n        end\n    end\nend\n\n-- 抓到小怪数据后完成当前\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_div2End then\n    if M.M12S.Puzzle4_4TimesChange(2941) then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_CopyBoom1\n        M.M12S.Timer = Now()\n    else\n        local pos = M.M12S.P4CopyInfo.gatherPos1\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_CopyBoom1 then\n    if M.M12S.P4Sub3Info.GuidePos2 == nil then\n        local to1 = TensorCore.getDistance2d(M.M12S.P4Sub3Info.divGuidePos1, M.GetPlayer().pos)\n        local to2 = TensorCore.getDistance2d(M.M12S.P4Sub3Info.divGuidePos2, M.GetPlayer().pos)\n        if to1 < to2 then\n            M.M12S.P4Sub3Info.GuidePos2 = M.M12S.P4Sub3Info.divGuidePos1\n        else\n            M.M12S.P4Sub3Info.GuidePos2 = M.M12S.P4Sub3Info.divGuidePos2\n        end\n    end\n    if TimeSince(M.M12S.Timer) > 14000 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_div3End\n    else\n        local pos = M.M12S.P4Sub3Info.GuidePos2\n        M.FrameDirect(pos.x, pos.z)\n    end\n  \nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_div3End then\n    if M.M12S.Puzzle4_4TimesChange(2941) then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_CopyBoom2\n    else\n        local pos = M.M12S.P4CopyInfo.gatherPos2\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_CopyBoom2 then\n    if M.M12S.P4Sub3Info.GuidePos3 == nil then\n        if M.M12S.P4Sub3Info.teleport == M.M12S.DataEnum.UpDown then\n            local p4 = { x = 93, y = 0, z = 93 }\n            local p1 = { x = 107, y = 0, z = 93 }\n            local to4 = TensorCore.getDistance2d(M.GetPlayer().pos, p4)\n            local to1 = TensorCore.getDistance2d(M.GetPlayer().pos, p1)\n            if to4 > to1 then\n                M.M12S.P4Sub3Info.GuidePos3 = p1\n            else\n                M.M12S.P4Sub3Info.GuidePos3 = p4\n            end\n        else\n            M.M12S.P4Sub3Info.GuidePos3 = { x = 100, y = 0, z = 100 }\n        end\n    else\n        local pos = M.M12S.P4Sub3Info.GuidePos3\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\nself.used = true",
						conditions = 
						{
							
							{
								"fcdccc63-40b0-afa5-a8c4-261d687192bb",
								true,
							},
							
							{
								"19d1b924-5472-dc2a-ac83-8dedf60abad9",
								true,
							},
						},
						gVar = "ACR_TensorRequiem3_CD",
						uuid = "278da120-34ad-7653-8f54-24a90e3c98e4",
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
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle4_Start\n\t\tand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.PuzzleEnd_Start",
						name = "四运中",
						uuid = "19d1b924-5472-dc2a-ac83-8dedf60abad9",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Self",
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "fcdccc63-40b0-afa5-a8c4-261d687192bb",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M12S本体4运主循环",
			uuid = "cf3ae25c-c974-dd93-a124-4473c49119b2",
			version = 2,
		},
		inheritedIndex = 23,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if data.lastState == nil or data.lastState ~=  MuAiGuide.M12S.CurrentState then\n\tdata.lastState = MuAiGuide.M12S.CurrentState\n\td(\"当前进度：\" .. tostring(MuAiGuide.M12S.CurrentState))\nend\nself.used = true",
						conditions = 
						{
							
							{
								"b85884ca-8a3a-7d01-92c3-e1ac9e2f6f2b",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						uuid = "54cb451b-22a3-2b42-b634-84d65a99a8aa",
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
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "b85884ca-8a3a-7d01-92c3-e1ac9e2f6f2b",
						version = 2,
					},
				},
			},
			enabled = false,
			eventType = 12,
			name = "FrameDebug",
			uuid = "83898426-1459-2294-b52d-fbafeb6d698e",
			version = 2,
		},
		inheritedIndex = 23,
	}, 
	inheritedProfiles = 
	{
	},
}



return tbl