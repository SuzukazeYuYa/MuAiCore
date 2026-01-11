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
						actionLua = "local target = TensorCore.mGetTarget()\nlocal drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 2), 1)\ndrawer:addCircle(target.pos.x, target.pos.y, target.pos.z, 0.1, true)\nself.used = true",
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
			name = "目标脚下画个红点",
			uuid = "f6607c59-fc75-1a2f-b73e-8825dbe3d5b3",
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
			},
			conditions = 
			{
			},
			name = "------ m11s ------",
			uuid = "0022e2e8-45db-6edb-a69f-77507c8e294e",
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
						actionLua = "local redDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 1)),\n        2\n)\nif MuAiGuide.M11SMapType == nil or MuAiGuide.M11SMapType ~= 1 then\n\tredDrawer:addRect(100, 0, 80, 40, 40, 0, true)\t\nelse\n\tredDrawer:addRect(84, 0, 80, 40, 20, 0, true)\n\tredDrawer:addRect(116, 0, 80, 40, 20, 0, true)\nend\nself.used = true",
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
				},
			},
			eventType = 13,
			name = "M11S地图边框",
			uuid = "15ffb251-5885-55b5-adf0-15a00a7fcba5",
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
						conditions = 
						{
							
							{
								"33081aec-3993-8b8d-8273-333d8dbe5eb3",
								true,
							},
							
							{
								"9270d6bb-e3bd-ade6-bbf9-965bc15b63d4",
								true,
							},
						},
						uuid = "6016ba94-6734-10e9-921f-5e51238a5ac5",
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
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnumPuzzle4_Start",
						name = "已进入4运",
						uuid = "33081aec-3993-8b8d-8273-333d8dbe5eb3",
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
						uuid = "9270d6bb-e3bd-ade6-bbf9-965bc15b63d4",
						version = 2,
					},
					inheritedIndex = 2,
				},
			},
			enabled = false,
			eventType = 12,
			name = "M12S四运",
			uuid = "d83846fe-78bc-e879-bbba-ad89739d4197",
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
		inheritedIndex = 9,
	},
	
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
		inheritedIndex = 10,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local player = TensorCore.mGetPlayer()\nlocal tethers = Argus.getTethersOnEnt(player.id)\nlocal linkFrom = nil\nfor _, tether in pairs(tethers) do\n    if tether.type == 57 or tether.type == 249 then\n        linkFrom = TensorCore.mGetEntity(tether.partnerid)\n    end\nend\n\nif linkFrom ~= nil then\n    local targetPos = nil\n    if MuAiGuide.M11SMapType == 1 then\n        if linkFrom.pos.x < 100 then\n            if linkFrom.pos.z < 100 then\n                targetPos = { x = 116, z = 120 }\n            else\n                targetPos = { x = 116, z = 80 }\n            end\n        else\n            if linkFrom.pos.z < 100 then\n                targetPos = { x = 84, z = 120 }\n            else\n                targetPos = { x = 84, z = 80 }\n            end\n        end\n    elseif MuAiGuide.M11SMapType == 2 then\n        if linkFrom.pos.z < 90 then --上\n            targetPos = { x = 120, z = 120 }\n        elseif linkFrom.pos.x < 90 then --左\n            targetPos = { x = 120, z = 80 }\n        elseif linkFrom.pos.z >110  then -- 下\n            targetPos = { x = 80, z = 80 }\n        else -- 右边\n            targetPos = { x = 80, z = 120 }\n        end\n    end\n    if targetPos ~= nil then\n        local length = TensorCore.getDistance2d(linkFrom.pos, targetPos)\n        local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5), 1)\n        local heading = TensorCore.getHeadingToTarget(linkFrom.pos, targetPos)\n        drawer:addArrow(linkFrom.pos.x, 0, linkFrom.pos.z, heading, length + 1, 1, 1, 1,  false)\n        drawer:addArrow(linkFrom.pos.x, 0, linkFrom.pos.z, heading, length + 1, 0.03, 0.5, 0.5, true)\n    end\nend\nself.used = true ",
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
				},
			},
			conditions = 
			{
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "if MuAiGuide.M11SMapType ~= 1 and MuAiGuide.M11SMapType ~= 2 then\n    return false\nend\n\nlocal player = TensorCore.mGetPlayer()\nlocal tethers = Argus.getTethersOnEnt(player.id)\nif tethers == nil or table.size(tethers) <= 0 then\n    return false\nend\nfor _, tether in pairs(tethers) do\n    if tether.type == 57 or tether.type == 249 then\n        return true\n    end\nend\nreturn false",
						uuid = "2fbd9c0f-e39c-a512-9798-2586a5646898",
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
						uuid = "16607308-c4ad-eb3e-ac3e-9036a0da5b58",
						version = 2,
					},
					inheritedIndex = 2,
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
			name = "---------------------- m12s --",
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
						actionLua = "local M = MuAiGuide\nM.M12S = {}\n--- M12S初始化\nM.M12S.InitM12SData = function()\n    --- 完成状态，表示当前副本进度已经完成了哪些\n    M.M12S.StateEnum = {\n        Start = 0,\n        -- 4运开始\n        Puzzle4_Start = 400,\n        -- 刷复制体1\n        Puzzle4_Spawn_Copy1 = 401,\n        -- 刷复制体2\n        Puzzle4_Spawn_Copy2 = 402,\n        -- 第一次连线\n        Puzzle4_Spawn_FirstLink = 403,\n        -- 找到上下刀\n        Puzzle4_Spawn_GetSKills = 404,\n        -- 第二次预备\n        Puzzle4_Spawn_SecondLink = 405,\n        -- 接线开始\n        Puzzle4_Spawn_CatchLink = 406,\n        -- 拉线结束\n        Puzzle4_Spawn_CatchEnd = 407,\n    }\n\n    M.M12S.DataEnum = {\n        -- 先刷数字点\n        Puzzle4Number = 401,\n        -- 先刷字母点\n        Puzzle4Char= 402,\n        --A点上下刀\n        UpDownSkillA = 403, \n        -- C点上下刀\n        UpDownSkillC = 404,\n        -- 集合\n        Gather = 113,\n        -- 大钢铁\n        Disperse = 112,\n    }\n\n    M.M12S.CurrentState = M.M12S.StateEnum.Start\n    M.M12S.Puzzle4Copy = {}\n    M.M12S.FirstLinkGuidePos = nil\n    M.M12S.SecondLinkGuidePos = nil\n    M.M12S.SecondLinkTargetId = nil\n    M.M12S.FirstLinkPos = nil\n    M.M12S.SecondLinkType = nil\n    M.M12S.SubMonsterSkillType = nil\n    M.M12S.LinkInfo = {}\n    M.Info(\"M12S初始化/重置数据完成!\")\nend\n\nM.M12S.InitM12SData()\nself.used = true",
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
				},
			},
			eventType = 11,
			name = "M12S初始化",
			uuid = "01c21e3b-f835-8520-b7fa-247cf2d8b76b",
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
						},
						name = "四运",
						uuid = "4dc29bbe-3a6a-0c9c-a66e-24b1414f6e2d",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nif ent.pos.z > 100 then\n    MuAiGuide.Info(\"【C】上下刀，23外躲钢铁\")\n    M.M12S.SubMonsterSkillType = M.M12S.DataEnum.UpDownSkillC\nelse\n    MuAiGuide.Info(\"【A】上下刀，14点上安全\")\n    M.M12S.SubMonsterSkillType = M.M12S.DataEnum.UpDownSkillA\nend\n-- 切换到2次连线\nM.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Spawn_SecondLink\nself.used = true",
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
						name = "四运-上下刀小怪位置采集",
						uuid = "8a4f6557-87e7-9029-a22e-5289e266af18",
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
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_Spawn_GetSKills",
						name = "四运-获取小怪上下刀阶段",
						uuid = "e8896ce2-b9e1-bfa5-aa77-bb583e31fcbe",
						version = 2,
					},
					inheritedIndex = 5,
				},
			},
			eventType = 3,
			name = "M12S阶段切换[开始读条]",
			uuid = "b48d47b0-28c9-0e72-82e7-abf66b902646",
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
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle4_Spawn_GetSKills \nMuAiGuide.Info(\"准备观察小怪刀方向\")\nself.used = true",
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
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_Spawn_FirstLink ",
						name = "四运-第一次连线结束",
						uuid = "7e92a291-58df-a968-8b38-75b9258c978f",
						version = 2,
					},
					inheritedIndex = 2,
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
				},
			},
			eventType = 2,
			name = "M12S切换阶段[读条后]",
			uuid = "021a9e74-9ec4-8881-beb5-cb1621c7a609",
			version = 2,
		},
		inheritedIndex = 15,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\n--- step 1.2\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Start then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=14383\")) do\n        if Argus.isEntityVisible(ent) then\n            if M.M12S.Puzzle4Step1Type == nil then\n                local curEntAngle = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n                for i = 0, 7 do\n                    local curAngle = i * math.pi / 4\n                    if M.IsSameDirection(curAngle, curEntAngle) then\n                        if i % 2 == 0 then\n                            M.M12S.Puzzle4Step1Type = M.M12S.DataEnum.Puzzle4Char\n                        elseif i % 2 == 1 then\n                            M.M12S.Puzzle4Step1Type = M.M12S.DataEnum.Puzzle4Number\n                        end\n                    end\n                end\n            end\n            if not table.contains(M.M12S.Puzzle4Copy, ent.id) then\n                table.insert(M.M12S.Puzzle4Copy, ent.id)\n            end\n        end\n    end\n    if M.M12S.Puzzle4Step1Type ~= nil and table.size(M.M12S.Puzzle4Copy) == 4 then\n        --进入到下一个状态\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Spawn_Copy1\n        if M.M12S.Puzzle4Step1Type == M.M12S.DataEnum.Puzzle4Char then\n            M.Info(\"字母点先刷新：\")\n            M.Info(\"第一次分摊：MT组去A，ST组去B\")\n            M.Info(\"第二次分摊：MT组去4，ST组去3\")\n        else\n            M.Info(\"数字点先刷新：\")\n            M.Info(\"第一次分摊：MT组去4，ST组去3\")\n            M.Info(\"第二次分摊：MT组去A，ST组去B\")\n        end\n    end\nend\n\n--- step 1.2\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Spawn_Copy1 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=14383\")) do\n        if Argus.isEntityVisible(ent) then\n            if not table.contains(M.M12S.Puzzle4Copy, ent.id) then\n                table.insert(M.M12S.Puzzle4Copy, ent.id)\n            end\n        end\n    end\n    if table.size(M.M12S.Puzzle4Copy) == 8 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Spawn_Copy2\n        M.Info(\"第二波复制体刷新完成\")\n    end\nend\n\n--- 连线阶段\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Spawn_Copy2 then\n    local tethers = Argus.getTethersOnEnt(M.GetPlayer().id)\n    if tethers ~= nil and table.size(tethers) > 0 then\n        for _, tether in pairs(tethers) do\n            if tether.type == 117 then\n                local partner = TensorCore.mGetEntity(tether.partnerid)\n                local targetPos = M.GetPointAtDistance({ x = 100, y = 0, z = 100 }, partner.pos, 6)\n                M.M12S.FirstLinkGuidePos = targetPos\n                M.M12S.FirstLinkPos = partner.pos\n                M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Spawn_FirstLink\n                break\n            end\n        end\n    end\nend\n\n--- 如果仍然处在连线阶段中\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Spawn_FirstLink then\n    MuAiGuide.FrameDirect(M.M12S.FirstLinkGuidePos.x, M.M12S.FirstLinkGuidePos.z)\nend\n\n--- 接线准备阶段\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Spawn_SecondLink then\n    M.M12S.LinkInfo.Ids = {}\n    M.M12S.LinkInfo.Data = {}\n    for _, ent in pairs(TensorCore.entityList(\"contentid=14380\")) do\n        if Argus.isEntityVisible(ent) then\n            if not table.contains(M.M12S.LinkInfo.Ids, ent.id) then\n                local tethers = Argus.getTethersOnEnt(ent.id)\n                for _, tether in pairs(tethers) do\n                    if tether.type == 112 or tether.type == 113 then\n                        local curLinkMstInfo = {\n                            id = ent.id,\n                            pos = ent.pos,\n                            type = tether.type\n                        }\n                        for i = 1, 8 do\n                            local curDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n                            if M.IsSameDirection(math.pi * i / 4, curDir) then\n                                curLinkMstInfo.dirIdx = i\n                                break\n                            end\n                        end\n                        table.insert(M.M12S.LinkInfo.Ids, ent.id)\n                        M.M12S.LinkInfo.Data[curLinkMstInfo.dirIdx] = curLinkMstInfo\n                        break\n                    end\n                end\n            end\n        end\n    end\n    if table.size(M.M12S.LinkInfo.Ids) == 8 then\n        local fstIdx = 0\n        for i = 1, 8 do\n            local curDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, M.M12S.FirstLinkPos)\n            if M.IsSameDirection(math.pi * i / 4, curDir) then\n                fstIdx = i\n                break\n            end\n        end\n        if fstIdx > 0 then\n            -- 右下开始索引，C点为8\n            if table.contains({2, 4, 5, 7}, fstIdx) then --BA43\n                M.M12S.SecondLinkType = M.M12S.DataEnum.Gather\n            else\n                M.M12S.SecondLinkType = M.M12S.DataEnum.Disperse\n            end\n            local backSub = M.M12S.LinkInfo.Data[fstIdx]\n            if backSub.type == M.M12S.SecondLinkType then\n                M.M12S.SecondLinkGuidePos = backSub.pos\n                M.M12S.SecondLinkTargetId = backSub.id\n            else\n                local newIdx = 0\n                if fstIdx % 2 == 1 then\n                    newIdx = fstIdx + 1\n                else\n                    newIdx = fstIdx - 1\n                end\n                local otherSub = M.M12S.LinkInfo.Data[newIdx]\n                M.M12S.SecondLinkGuidePos = otherSub.pos\n                M.M12S.SecondLinkTargetId = otherSub.id\n            end\n            M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Spawn_CatchLink\n        end\n    end\nend\n\n-- 如果连线对象不对，就一直指路\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Spawn_CatchLink then\n    local tethers = Argus.getTethersOnEnt(M.GetPlayer().id)\n    local isTargetRight = false\n    for _, tether in pairs(tethers) do\n        if tether.type == 117 then\n            M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Spawn_CatchEnd\n            break\n        end\n        if tether.type == M.M12S.SecondLinkType and tether.partnerid == M.M12S.SecondLinkTargetId then\n            isTargetRight = true\n            break\n        end\n    end\n    if not isTargetRight then\n        MuAiGuide.FrameDirect(M.M12S.SecondLinkGuidePos.x, M.M12S.SecondLinkGuidePos.z)\n    end\nend\n\n\nself.used = true",
						conditions = 
						{
							
							{
								"250a3ef9-23a2-399b-8a2d-66b792869a2b",
								true,
							},
							
							{
								"c49e6db7-9889-e5e3-bd20-a7b2376720c8",
								true,
							},
						},
						uuid = "9ebdedda-7d26-aad2-8171-acd02de4488d",
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
						uuid = "250a3ef9-23a2-399b-8a2d-66b792869a2b",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle4_Start",
						name = "四运已开始",
						uuid = "c49e6db7-9889-e5e3-bd20-a7b2376720c8",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M12S四运主循环 ",
			uuid = "246c8fb0-b1af-d697-9ebd-b28f2f91e8b5",
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
						actionLua = "local M = MuAiGuide\n\nfor job, ent in pairs(MuAiGuide.Party) do\n    local tethers = Argus.getTethersOnEnt(ent.id)\n    d(\"-------------------------------\")\n    d(ent.name)\n    for _, tether in pairs(tethers) do\n       \n        d(tether.type)\n    end\n    d(\"-------------------------------\")\nend\n-- local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5), 1)\n--drawer:addTimedArrow(5000,100, 0, 100, 0, 20, 1, 1, 1)\n  d(M.M12S.CurrentState)\nself.used = true",
						gVar = "ACR_RikuNIN3_CD",
						uuid = "06275492-4708-d684-a09e-ecfa811e7f4a",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			enabled = false,
			name = "TEST",
			uuid = "eaf28a6c-3d20-407a-8506-e831f03006ba",
			version = 2,
		},
		inheritedIndex = 17,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle4_Spawn_GetSKills \nself.used = true",
						uuid = "54cb451b-22a3-2b42-b634-84d65a99a8aa",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			enabled = false,
			eventType = 12,
			name = "testFrame",
			uuid = "83898426-1459-2294-b52d-fbafeb6d698e",
			version = 2,
		},
	}, 
	inheritedProfiles = 
	{
	},
}



return tbl