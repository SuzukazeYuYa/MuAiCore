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
			enabled = false,
			name = "------------ MuAiDraw ---------------------------",
			uuid = "4c04d325-7712-422b-be39-a892f38c3b0d",
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
						actionLua = "MuAiGuide.M12S.InitM12SData()\nd('M12S Wipe')\nself.used = true",
						conditions = 
						{
							
							{
								"609f849f-a306-30ed-89bb-763044ebe97d",
								true,
							},
							
							{
								"24eaf65e-0d76-113b-885d-2a9f872362b1",
								true,
							},
						},
						gVar = "ACR_RikuDRG3_CD",
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
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S ~= nil",
						name = "M12S已初始化",
						uuid = "24eaf65e-0d76-113b-885d-2a9f872362b1",
						version = 2,
					},
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
						actionLua = "local target = TensorCore.mGetTarget()\nlocal drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 1 / 255, 1), 1)\ndrawer:addCircle(target.pos.x, target.pos.y, target.pos.z, 0.04, true)\nself.used = true",
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
			enabled = false,
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
						actionLua = "if data.MuAiM11SMark == nil then\n\tdata.MuAiM11SMark = {}\nend\ntable.insert(data.MuAiM11SMark, eventArgs.entityID)\nself.used = true",
						conditions = 
						{
							
							{
								"9620fec1-0095-abec-bb97-e0d78948abb7",
								true,
							},
							
							{
								"4d5427f0-b5d4-7103-b9d6-eb40c66b3f2a",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "被点名放圈",
						uuid = "a08d7ed6-2786-6c18-aca7-8d311294c87a",
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
						uuid = "9620fec1-0095-abec-bb97-e0d78948abb7",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventMarkerID = 30,
						name = "点圈标记",
						uuid = "4d5427f0-b5d4-7103-b9d6-eb40c66b3f2a",
						version = 2,
					},
					inheritedIndex = 2,
				},
			},
			eventType = 4,
			name = "M11S添加MARK",
			uuid = "a72980e1-23b8-4169-b80d-4bbcb3beccf1",
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
					inheritedIndex = 2,
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
						actionLua = "if data.MuAiM11SSpell46166 == nil then\n    data.MuAiM11SSpell46166 = {}\n    data.MuAiM11SSpell46167 = {}\n    data.MuAiM11STowerDir = { math.pi * 3 / 4, math.pi / 4, math.pi * 7 / 4, math.pi * 5 / 4 }\n    data.MuAiM11SOrder = { \"H1\", \"D3\", \"D4\", \"H2\" }\n    data.FindDir = function(id1, id2)\n        local t1 = TensorCore.mGetEntity(id1)\n        local t2 = TensorCore.mGetEntity(id2)\n        local h1 = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, t1.pos)\n        local h2 = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, t2.pos)\n        local ent1, ent2\n        for i = 1, 4 do\n            local dir = data.MuAiM11STowerDir[i]\n            if MuAiGuide.IsSameDirection(dir, h1) then\n                if ent1 == nil then\n                    ent1 = t1\n                else\n                    ent2 = t1\n                end\n            end\n            if MuAiGuide.IsSameDirection(dir, h2) then\n                if ent1 == nil then\n                    ent1 = t2\n                else\n                    ent2 = t2\n                end\n            end\n        end\n        return ent1, ent2\n    end\nend\n\nif eventArgs.spellID == 46166 then\n    table.insert(data.MuAiM11SSpell46166, eventArgs.entityID)\nelseif eventArgs.spellID == 46167 then\n    table.insert(data.MuAiM11SSpell46167, eventArgs.entityID)\nend\n\nlocal guidePos, selfTower\nif MuAiGuide.SelfPos == \"MT\" or MuAiGuide.SelfPos == \"ST\" then\n    if table.size(data.MuAiM11SSpell46166) == 2 then\n        local MtTake, StTake = data.FindDir(data.MuAiM11SSpell46166[1], data.MuAiM11SSpell46166[2])\n        if MuAiGuide.SelfPos == \"MT\" then\n            selfTower = MtTake\n        else\n            selfTower = StTake\n        end\n        local heading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, selfTower.pos)\n        guidePos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\n    end\nelseif MuAiGuide.SelfPos == \"D1\" or MuAiGuide.SelfPos == \"D2\" then\n    if table.size(data.MuAiM11SSpell46167) == 2 then\n        local D1Take, D2Take = data.FindDir(data.MuAiM11SSpell46167[1], data.MuAiM11SSpell46167[2])\n        if MuAiGuide.SelfPos == \"D1\" then\n            selfTower = D1Take\n        else\n            selfTower = D2Take\n        end\n        local heading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, selfTower.pos)\n        guidePos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 8)\n    end\nelse\n    if table.size(data.MuAiM11SSpell46167) == 2 and (not table.contains(data.MuAiM11SMark, MuAiGuide.GetPlayer().id)) then\n        local t1, t2 = data.FindDir(data.MuAiM11SSpell46167[1], data.MuAiM11SSpell46167[2])\n        local selfIdx = MuAiGuide.IndexOf(data.MuAiM11SOrder, MuAiGuide.SelfPos)\n        local otherJob\n        for job, ent in pairs(MuAiGuide.Party) do\n            if ent.id ~= MuAiGuide.GetPlayer().id and table.contains(data.MuAiM11SOrder, job) and (not table.contains(data.MuAiM11SMark, ent.id)) then\n                otherJob = job\n                break\n            end\n        end\n        local otherIndex = MuAiGuide.IndexOf(data.MuAiM11SOrder, otherJob)\n        if selfIdx > otherIndex then\n            selfTower = t2\n        else\n            selfTower = t1\n        end\n        local heading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, selfTower.pos)\n        guidePos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 14)\n    end\nend\n\nif guidePos ~= nil then\n    MuAiGuide.DirectTo(guidePos.x, guidePos.z, 5000)\nend\nself.used = true",
						conditions = 
						{
							
							{
								"e16c03b1-59aa-4644-a384-eb22f3fef5dd",
								true,
							},
							
							{
								"dadf049a-9910-9885-ab10-a3eecdc35f8e",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						uuid = "42a3dd23-f10b-4e65-be32-3d3a6d439f6f",
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
						uuid = "e16c03b1-59aa-4644-a384-eb22f3fef5dd",
						version = 2,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgOptionType = 3,
						eventArgType = 2,
						eventSpellID = 46167,
						name = "46166坦克塔|46167双人塔",
						spellIDList = 
						{
							46167,
							46166,
						},
						uuid = "dadf049a-9910-9885-ab10-a3eecdc35f8e",
						version = 2,
					},
				},
			},
			eventType = 3,
			name = "M11S技能读条",
			uuid = "eb90697a-3de9-b2eb-a153-167ddda24d73",
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
						actionLua = "local player = MuAiGuide.GetPlayer()\nlocal tethers = Argus.getTethersOnEnt(player.id)\nlocal linkFrom = nil\nfor _, tether in pairs(tethers) do\n    if tether.type == 57 or tether.type == 249 then\n        linkFrom = TensorCore.mGetEntity(tether.partnerid)\n    end\nend\n\nif linkFrom ~= nil then\n    local targetPos = nil\n    if MuAiGuide.M11SMapType == 1 then\n        if linkFrom.pos.x < 100 then\n            if linkFrom.pos.z < 100 then\n                targetPos = { x = 116, z = 120 }\n            else\n                targetPos = { x = 116, z = 80 }\n            end\n        else\n            if linkFrom.pos.z < 100 then\n                targetPos = { x = 84, z = 120 }\n            else\n                targetPos = { x = 84, z = 80 }\n            end\n        end\n        if targetPos ~= nil then\n            local length = TensorCore.getDistance2d(linkFrom.pos, targetPos)\n            local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(1, 1, 0, 1), 1)\n            local heading = TensorCore.getHeadingToTarget(linkFrom.pos, targetPos)\n            drawer:addArrow(linkFrom.pos.x, 0, linkFrom.pos.z, heading, length -   0.6, 0.05, 0.6, 0.4, true)\n            drawer:addArrow(linkFrom.pos.x, 0, linkFrom.pos.z, heading, length * 1 / 5, 0.05, 0.6, 0.4, true)\n            drawer:addArrow(linkFrom.pos.x, 0, linkFrom.pos.z, heading, length * 2 / 5, 0.05, 0.6, 0.4, true)\n            drawer:addArrow(linkFrom.pos.x, 0, linkFrom.pos.z, heading, length * 3 / 5, 0.05, 0.6, 0.4, true)\n            drawer:addArrow(linkFrom.pos.x, 0, linkFrom.pos.z, heading, length * 4 / 5, 0.05, 0.6, 0.4, true)\n        end\n    elseif MuAiGuide.M11SMapType == 2 then\n        if linkFrom.pos.z < 90 then\n            --上\n            targetPos = { x = 119.5, z = 119.5 }\n        elseif linkFrom.pos.x < 90 then\n            --左\n            targetPos = { x = 119.5, z = 81.5 }\n        elseif linkFrom.pos.z > 110 then\n            -- 下\n            targetPos = { x = 81.5, z = 81.5 }\n        else\n            -- 右边\n            targetPos = { x = 81.5, z = 119.5 }\n        end\n        MuAiGuide.FrameDirect(targetPos.x, targetPos.z)\n    end\nend\nself.used = true ",
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
						category = "Lua",
						conditionLua = "if MuAiGuide.M11SMapType ~= 1 and MuAiGuide.M11SMapType ~= 2 then\n    return false\nend\n\nlocal player = TensorCore.mGetPlayer()\nlocal tethers = Argus.getTethersOnEnt(player.id)\nif tethers == nil or table.size(tethers) <= 0 then\n    return false\nend\nfor _, tether in pairs(tethers) do\n    if tether.type == 57 or tether.type == 249 then\n        return true\n    end\nend\nreturn false",
						uuid = "2fbd9c0f-e39c-a512-9798-2586a5646898",
						version = 2,
					},
					inheritedIndex = 1,
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
					inheritedIndex = 1,
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
			enabled = false,
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
						actionLua = "local M = MuAiGuide\n\nM.M12S = {}\n--- 完成状态，表示当前副本进度已经完成了哪些\nM.M12S.StateEnum = {\n    Start = 0,\n    -- 门神1运开始\n    GPuzzle1_Start = 1100,\n    -- 自动锁定\n    GPuzzle1_AutoLock = 1101,\n    -- 1运结束\n    GPuzzle1_end = 1199,\n    -- 门神2运开始\n    GPuzzle2_Start = 1200,\n    -- 场地塔刷新完毕,开始循环\n    GPuzzle2_Looping = 1201,\n    -- 门神2运结束\n    GPuzzle2_End = 1299,\n    -- 进入3运\n    GPuzzle3_Start = 1300,\n    -- 已读取蛇位置\n    GPuzzle3_GotSnake = 1301,\n    -- 门神3运结束\n    GPuzzle3_End = 1399,\n    ------------------------------- 本体\n    Puzzle1_Start = 2100,\n    Puzzle1_GotBuff = 2101,\n    Puzzle1_GotSub = 2102,\n    Puzzle1_SubMove = 2103,\n    Puzzle1_End = 2199,\n    --2运开始\n    Puzzle2_Start = 2200,\n    --被连线\n    Puzzle2_GetLink = 2201,\n    -- 已读取所有小怪信息\n    Puzzle2_GetSub = 2202,\n    -- 拉线结束\n    Puzzle2_CatchEnd = 2203,\n    -- 2运第一次放置\n    Puzzle2_Put1 = 2204,\n    Puzzle2_Put2 = 2205,\n    Puzzle2_GoBack = 2206,\n    Puzzle2_GoBackEnd = 2207,\n    Puzzle2_TimeBack = 2208,\n    Puzzle2_TimeBackPut1 = 2209,\n    Puzzle2_TimeBackPut2 = 2210,\n    Puzzle2_TimeBackPut3 = 2211,\n    --2运结束\n    Puzzle2_End = 2299,\n\n    --3运开始\n    Puzzle3_Start = 2300,\n    --获取球信息\n    Puzzle3_GotBall = 2301,\n    --撞球\n    Puzzle3_HpChanged = 2302,\n    --第一次安全区\n    Puzzle3_Safe1 = 2303,\n    --第二次安全区\n    Puzzle3_Safe2 = 2304,\n    --3运结束\n    Puzzle3_End = 2399,\n\n    -- 4运开始\n    Puzzle4_Start = 2400,\n    -- 刷复制体1\n    Puzzle4_Spawn_Copy1 = 2401,\n    -- 刷复制体2\n    Puzzle4_Spawn_Copy2 = 2402,\n    -- 第一次连线\n    Puzzle4_FirstLink = 2403,\n    -- 找到上下刀\n    Puzzle4_GetSKills = 2404,\n    -- 第二次预备\n    Puzzle4_SecondLink = 2405,\n    -- 接线开始\n    Puzzle4_CatchLink = 2406,\n    -- 拉线结束\n    Puzzle4_CatchEnd = 2407,\n    -- 小世界1\n    Puzzle4_Div1 = 2408,\n    -- \n    Puzzle4_Tower1 = 2409,\n    --获得光BUFF\n    Puzzle4_GetBuff = 2410,\n    -- 4次分摊/大圈\n    Puzzle4_ThirdLink = 2411,\n    Puzzle4_Put1 = 2412,\n    Puzzle4_Put2 = 2413,\n    Puzzle4_Put3 = 2414,\n    Puzzle4_PutEnd = 2415,\n    -- 第二次小世界\n    Puzzle4_Tower2 = 2416,\n    -- 塔结束\n    Puzzle4_TowerEnd = 2417,\n    -- 处理远近\n    Puzzle4_TowerFarNear = 2418,\n    -- 第二次小世界小怪观察\n    Puzzle4_div2Subs = 2419,\n    -- 第二次小世界小怪观测\n    Puzzle4_div2SubsEnd = 2420,\n    -- 第二次小世界结束\n    Puzzle4_div2End = 2421,\n    -- 第一复制体爆炸\n    Puzzle4_CopyBoom1 = 2422,\n    -- 第三次小世界结束\n    Puzzle4_div3End = 2423,\n    -- 第二次复制体爆炸\n    Puzzle4_CopyBoom2 = 2424,\n    -- 最终结P\n    PuzzleEnd_Start = 2500,\n}\n\nM.M12S.DataEnum = {\n    A1 = 11, A2 = 12, A3 = 13, A4 = 14,\n    B1 = 21, B2 = 22, B3 = 23, B4 = 24,\n    Gp2_01 = 201, Gp2_02 = 202, Gp2_03 = 203, Gp2_04 = 204, Gp2_end = 299,\n    -- 先刷数字点\n    Puzzle4Number = 401,\n    -- 先刷字母点\n    Puzzle4Char = 402,\n    --A点上下刀\n    UpDownSkillA = 403,\n    -- C点上下刀\n    UpDownSkillC = 404,\n    -- 集合\n    Gather = 113,\n    -- 大钢铁\n    Disperse = 112,\n    --- 扇形\n    Cone = 111,\n    Boss = 9994,\n    -- 判定的线\n    LinkFinal = 117,\n    -- 4D3C\n    Left = 1,\n    -- A1B2\n    Right = 2,\n\n    -- 上下\n    UpDown = 3,\n    -- 左右\n    LeftRight = 4,\n}\n\n-- 根据小队任意成员BUFF情况判断是否切阶段\nM.M12S.StateChangeByBuff = function(buffId)\n    for i, player in pairs(M.Party) do\n        local debuff = TensorCore.getBuff(player.id, buffId)\n        if debuff ~= nil then\n            return true\n        end\n    end\n    return false\nend\n\n--- M12S初始化\nM.M12S.InitM12SData = function()\n    -- 辅助计时器\n    M.M12S.Timer = 0\n    M.M12S.ArmySlayer = nil\n    M.M12S.ArmyInfo = nil\n    M.M12S.Locking = false\n    M.M12S.CurrentBoss = nil\n    -- 当前副本阶段\n    M.M12S.CurrentState = M.M12S.StateEnum.Start\n    M.M12S.GP1Info = {}\n    M.M12S.GP2Info = {\n        -- 场地塔Id\n        ids = {},\n        -- 场地塔信息,索引\n        gTowers = {},\n        gSpawnIdx = 0,\n        -- 玩家塔信息,索引\n        pTowers = {},\n        pSpawnIdx = 0,\n        selfType = 0,\n        pTowerFinish = false,\n        State = M.M12S.DataEnum.Gp2_01\n    }\n    M.M12S.GP3Info = {\n        selfBuff = nil,\n        guidePos = nil,\n    }\n\n    M.M12S.P1Info = {\n        Subs = {},\n        SubOld = {},\n        FireMain = nil,\n        DarkMain = nil,\n        SubsDark = {},\n        SubsFire = {},\n        guideId = nil,\n        buffType = nil,\n        getNear2 = function(ent, list)\n            local nearest = { list[1], list[2] }\n            local distances = {\n                TensorCore.getDistance2d(ent.pos, list[1].pos),\n                TensorCore.getDistance2d(ent.pos, list[2].pos)\n            }\n\n            if distances[1] > distances[2] then\n                nearest[1], nearest[2] = nearest[2], nearest[1]\n                distances[1], distances[2] = distances[2], distances[1]\n            end\n            -- 遍历剩余元素\n            for i = 3, #list do\n                local dist = TensorCore.getDistance2d(ent.pos, list[i].pos)\n                if dist < distances[1] then\n                    -- 比最近的还近，更新最近，原最近变成第二近\n                    nearest[2] = nearest[1]\n                    distances[2] = distances[1]\n                    nearest[1] = list[i]\n                    distances[1] = dist\n                elseif dist < distances[2] then\n                    -- 只比第二近的近，更新第二近\n                    nearest[2] = list[i]\n                    distances[2] = dist\n                end\n            end\n            return nearest\n        end\n    }\n    -- 本体阶段性数据缓存\n    M.M12S.P2Info = {\n        linkIdx = -1,\n        ids = {},\n        Subs = {},\n        orderAsc = { math.pi, math.pi * 2 / 3, math.pi / 3, 0, math.pi * 5 / 3, math.pi * 4 / 3 },\n        orderDesc = { math.pi * 4 / 3, math.pi * 5 / 3, 0, math.pi / 3, math.pi * 2 / 3, math.pi },\n        guidePosAfterLink = nil,\n        guidePosAfterPut1 = nil,\n        guidePosBossBack = nil,\n        guidePosTime1 = nil,\n        getLinkBoss = function(type, order)\n            for i = 1, #order do\n                local rad = order[i]\n                for _, sub in pairs(M.M12S.P2Info.Subs) do\n                    if sub.type == type and M.IsSameDirection(sub.rad, rad) then\n                        return sub\n                    end\n                end\n            end\n        end,\n\n    }\n\n    M.M12S.P3Info = {\n        ids = {},\n        entities = {},\n        -- 撞球信息\n        nearUp, nearDown, upEnt, downEnt,\n        hitBall = false,\n        enterBh = nil,\n        -- 玩家血量 key job value {curHp, maxHp}\n        hps = nil,\n        channelTime = 0,\n    }\n    -- 4运 玩家复制体数据\n    M.M12S.P4CopyInfo = {\n        ids = {},\n        entities = {},\n        guidePos,\n        linkPos,\n        -- 刷新类型：字母点/数字点\n        spawnType = nil,\n        gatherPos1,\n        gatherPos2,\n    }\n    M.M12S.P4NearTargetId = nil\n    -- 4运 被接线BOSS分身、个人需处理数据信息\n    M.M12S.P4CatchLineInfo = {\n        ids = {},\n        entities = {},\n        -- 接线类型, 分摊线/分散线\n        type = nil,\n    }\n    -- 4运 3分身信息\n    M.M12S.P4Sub3Info = {\n        skillType = nil,\n        -- 接线后指路位置\n        GuidePos1 = nil,\n        -- 躲前后左右刀参考站位\n        divGuidePos1 = nil,\n        divGuidePos2 = nil,\n        -- 躲前后左右刀实际站位(小世界)\n        GuidePos2 = nil,\n        -- 躲前后左右刀实际站位(最后)\n        GuidePos3 = nil,\n    }\n    -- 4运 踩塔数据\n    M.M12S.P4TowerData = {}\n\n    M.Info(\"M12S初始化数据完成!\")\nend\n\nM.M12S.InitM12SData()\nd(\"M12S初始化数据完成!\")\nself.used = true\n",
						conditions = 
						{
							
							{
								"6fe5e0b6-2218-6544-9b9f-1c54202db3d2",
								true,
							},
							
							{
								"14feac43-0fe9-acff-9467-14b989e563e3",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "M12S初始化",
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
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S == nil",
						name = "没有进行初始化",
						uuid = "14feac43-0fe9-acff-9467-14b989e563e3",
						version = 2,
					},
				},
			},
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
						gVar = "ACR_TensorViper3_CD",
						name = "M12S-GetBoss",
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
						actionLua = "local M = MuAiGuide\nlocal drawTime = 8000\nif M.M12S.GatherGuideTimer == nil or TimeSince(M.M12S.GatherGuideTimer) > drawTime then\n    local markPlayer\n    for job, ent in pairs(M.Party) do\n        if ent.id == eventArgs.entityID then\n            markPlayer = ent\n            M.M12S.MarkJob = job\n            d(\"获取到分散点名：\" .. job)\n            break\n        end\n    end\n    local groundType\n    for _, ent in pairs(TensorCore.entityList(\"contentid=2015017\")) do\n        if 87 < ent.pos.x and ent.pos.x < 91\n                and 95 < ent.pos.z and ent.pos.z < 97\n        then\n            groundType = 1 -- 左分摊\n            break\n        elseif 109 < ent.pos.x and ent.pos.x < 112\n                and 95 < ent.pos.z and ent.pos.z < 97 then\n            groundType = 2 --右分摊\n            break\n        end\n    end\n    local thGroup = { \"MT\", \"ST\", \"H1\", \"H2\" }\n    local dpsGroup = { \"D1\", \"D2\", \"D3\", \"D4\" }\n    if markPlayer ~= nil then\n        --分散\n        if table.contains(thGroup, M.M12S.MarkJob) and table.contains(thGroup, M.SelfPos)\n                or table.contains(dpsGroup, M.M12S.MarkJob) and table.contains(dpsGroup, M.SelfPos)\n        then\n            d(123123)\n            if M.SelfPos == \"MT\" or M.SelfPos == \"D1\" then\n                if groundType == 1 then\n                    M.DirectTo(110, 85.5, drawTime)\n                else\n                    M.DirectTo(90, 85.5, drawTime)\n                end\n            elseif M.SelfPos == \"ST\" or M.SelfPos == \"D2\" then\n                if groundType == 1 then\n                    M.DirectTo(111.5, 93.5, drawTime)\n                else\n                    M.DirectTo(88.5, 93.5, drawTime)\n                end\n            elseif M.SelfPos == \"H1\" or M.SelfPos == \"D3\" then\n                if groundType == 1 then\n                    M.DirectTo(119.5, 93.5, drawTime)\n                else\n                    M.DirectTo(80.5, 85.5, drawTime)\n                end\n            elseif M.SelfPos == \"H2\" or M.SelfPos == \"D4\" then\n                if groundType == 1 then\n                    M.DirectTo(119.5, 95, drawTime)\n                else\n                    M.DirectTo(80.5, 95, drawTime)\n                end\n            end\n        else\n            if groundType == 1 then\n                M.DirectTo(83.5, 85.5, drawTime)\n            elseif groundType == 2 then\n                M.DirectTo(116.5, 85.5, drawTime)\n            end\n        end\n    end\n    M.M12S.GatherGuideTimer = Now()\nend\nself.used = true",
						conditions = 
						{
							
							{
								"9620fec1-0095-abec-bb97-e0d78948abb7",
								true,
							},
							
							{
								"ad387236-4dfe-d53f-93d6-41177697d231",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "处理分摊分散",
						uuid = "a08d7ed6-2786-6c18-aca7-8d311294c87a",
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
						uuid = "9620fec1-0095-abec-bb97-e0d78948abb7",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventMarkerID = 375,
						name = "点分散",
						uuid = "ad387236-4dfe-d53f-93d6-41177697d231",
						version = 2,
					},
				},
			},
			eventType = 4,
			name = "M12S添加MARK",
			uuid = "a0d021b4-1dd5-1d6c-a905-2559ee27a23c",
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
						actionLua = "local M = MuAiGuide\n\nif TimeSince(M.M12S.Timer) > 22000 then\n    M.M12S.ArmySlayer = false\n    M.M12S.ArmyInfo = nil\nelse\n    if M.M12S.ArmyInfo == nil then\n        M.M12S.ArmyInfo = {}\n        M.M12S.ArmyInfo.ids = {}\n        M.M12S.ArmyInfo.LeftCnt = 1\n        M.M12S.ArmyInfo.RightCnt = 1\n        M.M12S.ArmyInfo.State = 1\n        M.M12S.ArmyInfo.Left = {}\n        M.M12S.ArmyInfo.Right = {}\n        M.M12S.ArmyInfo.All = {}\n        M.M12S.ArmyInfo.FirstPurple = nil\n        M.M12S.ArmyInfo.PositionLeft = {\n            [1] = { x = 95, y = 0, z = 85.5 },\n            [2] = { x = 97, y = 0, z = 93 },\n            [3] = { x = 87, y = 0, z = 86 },\n            [4] = { x = 90, y = 0, z = 95 },\n        }\n        M.M12S.ArmyInfo.PositionRight = {\n            [1] = { x = 105, y = 0, z = 85.5 },\n            [2] = { x = 103, y = 0, z = 93 },\n            [3] = { x = 113, y = 0, z = 86 },\n            [4] = { x = 110, y = 0, z = 95 },\n        }\n        M.M12S.ArmyInfo.GotPos = {\n            [\"MT\"] = false,\n            [\"ST\"] = false,\n            [\"H1\"] = false,\n            [\"H2\"] = false,\n        }\n        M.M12S.ArmyInfo.THOrder = nil\n        M.M12S.ArmyInfo.Timer = 0\n        M.M12S.ArmyInfo.Temp = {}\n    end\n\n    if table.size(M.M12S.ArmyInfo.ids) < 8 then\n        for _, ent in pairs(TensorCore.entityList(\"contentid=14378\")) do\n            if Argus.isEntityVisible(ent) then\n                local model = Argus.getEntityModel(ent.id)\n                if model == 19200 or model == 19201 then\n                    if not table.contains(M.M12S.ArmyInfo.ids, ent.id) then\n                        table.insert(M.M12S.ArmyInfo.ids, ent.id)\n                        if table.size(M.M12S.ArmyInfo.Temp) < 2 then\n                            table.insert(M.M12S.ArmyInfo.Temp, ent)\n                        end\n                    end\n                end\n            end\n        end\n        if table.size(M.M12S.ArmyInfo.Temp) == 2 then\n            if M.M12S.ArmyInfo.Temp[1].pos.y < M.M12S.ArmyInfo.Temp[2].pos.y\n                    or M.M12S.ArmyInfo.Temp[1].pos.x < 100 and M.M12S.ArmyInfo.Temp[2].pos.x < 100 and M.M12S.ArmyInfo.Temp[1].pos.x > M.M12S.ArmyInfo.Temp[2].pos.x\n                    or M.M12S.ArmyInfo.Temp[1].pos.x > 100 and M.M12S.ArmyInfo.Temp[2].pos.x > 100 and M.M12S.ArmyInfo.Temp[1].pos.x < M.M12S.ArmyInfo.Temp[2].pos.x\n            then\n                M.M12S.ArmyInfo.Temp[1], M.M12S.ArmyInfo.Temp[2] = M.M12S.ArmyInfo.Temp[2], M.M12S.ArmyInfo.Temp[1]\n            end\n            for i = 1, #M.M12S.ArmyInfo.Temp do\n                local curEnt = M.M12S.ArmyInfo.Temp[i]\n                local modelTemp = Argus.getEntityModel(curEnt.id)\n                table.insert(M.M12S.ArmyInfo.All, { ent = curEnt, model = modelTemp })\n                if curEnt.pos.x > 100 then\n                    M.M12S.ArmyInfo.Right[M.M12S.ArmyInfo.RightCnt] = curEnt\n                    M.M12S.ArmyInfo.RightCnt = M.M12S.ArmyInfo.RightCnt + 1\n                else\n                    M.M12S.ArmyInfo.Left[M.M12S.ArmyInfo.LeftCnt] = curEnt\n                    M.M12S.ArmyInfo.LeftCnt = M.M12S.ArmyInfo.LeftCnt + 1\n                end\n                if modelTemp == 19200 and M.M12S.ArmyInfo.FirstPurple == nil then\n                    M.M12S.ArmyInfo.FirstPurple = curEnt\n                end\n            end\n            M.M12S.ArmyInfo.Temp = {}\n        end\n        if table.size(M.M12S.ArmyInfo.ids) == 8 then\n            M.M12S.ArmyInfo.Timer = Now()\n        end\n    end\n    if M.M12S.ArmyInfo.FirstPurple ~= nil then\n        local buff = TensorCore.getBuff(M.GetPlayer().id, 3935)\n        if buff == nil then\n            local dps = { \"D1\", \"D2\", \"D3\", \"D4\" }\n            local posListTh, posListDps\n            local entListTh\n            if M.M12S.ArmyInfo.FirstPurple.pos.x > 100 then\n                posListDps = M.M12S.ArmyInfo.PositionLeft\n                posListTh = M.M12S.ArmyInfo.PositionRight\n                entListTh = M.M12S.ArmyInfo.Right\n            else\n                posListDps = M.M12S.ArmyInfo.PositionRight\n                posListTh = M.M12S.ArmyInfo.PositionLeft\n                entListTh = M.M12S.ArmyInfo.Left\n            end\n            if table.contains(dps, M.SelfPos) then\n                local index = M.IndexOf(dps, M.SelfPos)\n                local pos = posListDps[index]\n                M.M12S.ArmyInfo.SelfIdx = index\n                M.FrameDirect(pos.x, pos.z)\n            elseif table.size(M.M12S.ArmyInfo.ids) == 8 then\n                if M.M12S.ArmyInfo.THOrder == nil then\n                    M.M12S.ArmyInfo.THOrder = {}\n                    for i = 1, 4 do\n                        local ball = entListTh[i]\n                        local model = Argus.getEntityModel(ball.id)\n                        if model == 19200 then\n                            if not M.M12S.ArmyInfo.GotPos[\"MT\"] then\n                                M.M12S.ArmyInfo.THOrder[\"MT\"] = i\n                                M.M12S.ArmyInfo.GotPos[\"MT\"] = true\n                            else\n                                M.M12S.ArmyInfo.THOrder[\"ST\"] = i\n                                M.M12S.ArmyInfo.GotPos[\"ST\"] = true\n                            end\n                        else\n                            if not M.M12S.ArmyInfo.GotPos[\"H1\"] then\n                                M.M12S.ArmyInfo.THOrder[\"H1\"] = i\n                                M.M12S.ArmyInfo.GotPos[\"H1\"] = true\n                            else\n                                M.M12S.ArmyInfo.THOrder[\"H2\"] = i\n                                M.M12S.ArmyInfo.GotPos[\"H2\"] = true\n                            end\n                        end\n                    end\n                    M.M12S.ArmyInfo.SelfIdx = M.M12S.ArmyInfo.THOrder[M.SelfPos]\n                    d(M.M12S.ArmyInfo.THOrder)\n                else\n                    local pos = posListTh[M.M12S.ArmyInfo.SelfIdx]\n                    M.FrameDirect(pos.x, pos.z)\n                end\n            end\n        else\n            if M.M12S.ArmyInfo.SelfIdx == 1 then\n                local player = M.GetPlayer()\n                local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                if buff.duration > 8.5 and TensorCore.getDistance2d(player.pos, boss.pos) < 13.8 then\n                    if player.pos.x > 100 then\n                        M.FrameDirect(114, 89)\n                    else\n                        M.FrameDirect(86, 89)\n                    end\n                elseif buff.duration > 5.5 then\n                    M.FrameDirect(100, 101.5)\n                end\n            else\n                if buff.duration > 5.5 then\n                    M.FrameDirect(100, 101.5)\n                end\n            end\n        end\n        if M.Config.Main.M12SExDraw and table.size(M.M12S.ArmyInfo.ids) == 8 then\n            if TimeSince(M.M12S.ArmyInfo.Timer) > 1200 then\n                local changed = false\n                for i, player in pairs(M.Party) do\n                    local debuff = TensorCore.getBuff(player.id, 3935)\n                    if debuff ~= nil and debuff.duration > 11 then\n                        changed = true\n                        break\n                    end\n                end\n                if changed then\n                    M.M12S.ArmyInfo.State = M.M12S.ArmyInfo.State + 1\n                    M.M12S.ArmyInfo.Timer = Now()\n                end\n            end\n            if M.M12S.ArmyInfo.State <= 4 then\n                local target1, target2\n                local ball1 = M.M12S.ArmyInfo.All[M.M12S.ArmyInfo.State * 2 - 1]\n                local ball2 = M.M12S.ArmyInfo.All[M.M12S.ArmyInfo.State * 2]\n                local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                local distance = 10000\n                --找ball1的目标\n                for _, player in pairs(M.Party) do\n                    local curPlayer = TensorCore.mGetEntity(player.id)\n                    if (ball1.ent.pos.x > 100 and curPlayer.pos.x > 100)\n                            or (ball1.ent.pos.x < 100 and curPlayer.pos.x < 100)\n                    then\n                        local dis = TensorCore.getDistance2d(boss.pos, curPlayer.pos)\n                        if dis < distance then\n                            target1 = curPlayer\n                            distance = dis\n                        end\n                    end\n                end\n                distance = 10000\n                --找ball2的目标\n                for _, player in pairs(M.Party) do\n                    local curPlayer = TensorCore.mGetEntity(player.id)\n                    if curPlayer.id ~= target1.id and (\n                            (ball2.ent.pos.x > 100 and curPlayer.pos.x > 100)\n                                    or (ball2.ent.pos.x < 100 and curPlayer.pos.x < 100))\n                    then\n                        local dis = TensorCore.getDistance2d(boss.pos, curPlayer.pos)\n                        if dis < distance then\n                            target2 = curPlayer\n                            distance = dis\n                        end\n                    end\n                end\n                local greenDrawer = Argus2.ShapeDrawer:new(\n                        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.1)),\n                        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.1)),\n                        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.1)),\n                        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n                        1\n                )\n                local purpleDrawer = Argus2.ShapeDrawer:new(\n                        (GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.1)),\n                        (GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.1)),\n                        (GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.1)),\n                        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n                        1\n                )\n\n                if ball1.model == 19200 then\n                    purpleDrawer:addCircle(target1.pos.x, target1.pos.y, target1.pos.z, 6)\n                else\n                    greenDrawer:addCircle(target1.pos.x, target1.pos.y, target1.pos.z, 6)\n                end\n                if ball2.model == 19200 then\n                    purpleDrawer:addCircle(target2.pos.x, target2.pos.y, target2.pos.z, 6)\n                else\n                    greenDrawer:addCircle(target2.pos.x, target2.pos.y, target2.pos.z, 6)\n                end\n            end\n        end\n    end\nend\nself.used = true",
						conditions = 
						{
							
							{
								"79695dbf-76bd-fb59-b4fc-c6c7b59db258",
								true,
							},
							
							{
								"3b5a92e6-57ae-be17-86cc-738c6cb9d5f5",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "致命灾变主循环",
						uuid = "49501902-5a85-0242-b59e-9c16a80420c1",
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
						uuid = "79695dbf-76bd-fb59-b4fc-c6c7b59db258",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.ArmySlayer ~= nil and MuAiGuide.M12S.ArmySlayer == true",
						name = "致命灾变",
						uuid = "3b5a92e6-57ae-be17-86cc-738c6cb9d5f5",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M12S门神致命灾变",
			uuid = "68b39db5-37db-ecc8-a289-060327422b48",
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
						actionLua = "MuAiGuide.M12S.Timer = Now()\nMuAiGuide.M12S.ArmySlayer = true\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"6c184475-9b89-f006-a8ba-c1f430694bc4",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "致命灾变",
						uuid = "dbd7c8c7-c2a4-b68b-b24d-89be11862523",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "--[[\n4976  判断剩余时间\nbuffid = 3558\nstacks :\n当前面向 \n前：1036\n右：1037\n后：1038\n左：1039\n]]\n\n--- 数据采集\nlocal M = MuAiGuide\nM.M12S.GP1Info.head = TensorCore.mGetEntity(eventArgs.entityID)\nM.M12S.CurrentState = M.M12S.StateEnum.GPuzzle1_Start\n\nfor jobNamed, ent in pairs(M.Party) do\n    local buff = TensorCore.getBuff(ent.id, 4762)\n    if buff ~= nil then\n        if M.IsDps(ent.job) then\n            if M.IsDps(M.GetPlayer().job) then\n                M.M12S.GP1Info.opType = M.M12S.DataEnum.Gather\n            else\n                M.M12S.GP1Info.opType = M.M12S.DataEnum.Disperse\n            end\n        else\n            if M.IsDps(M.GetPlayer().job) then\n                M.M12S.GP1Info.opType = M.M12S.DataEnum.Disperse\n            else\n                M.M12S.GP1Info.opType = M.M12S.DataEnum.Gather\n            end\n        end\n    end\nend\n\nlocal curBuff = TensorCore.getBuff(M.GetPlayer().id, 3558)\nif curBuff ~= nil then\n    if M.M12S.GP1Info.opType == M.M12S.DataEnum.Gather then\n        -- 集合 最终目标是设置 打向 math.pi\n        if curBuff.stacks == 1036 then\n            M.M12S.GP1Info.face = math.pi\n        elseif curBuff.stacks == 1037 then\n            M.M12S.GP1Info.face = math.pi * 3 / 2\n        elseif curBuff.stacks == 1038 then\n            M.M12S.GP1Info.face = 0\n        elseif curBuff.stacks == 1039 then\n            M.M12S.GP1Info.face = math.pi / 2\n        end\n    elseif M.Config.Main.M12SAutoFaceType == 3 then\n        M.M12S.GP1Info.face = math.pi\n    else\n        local ToIn = true\n        if M.Config.Main.M12SAutoFaceType == 1 then\n            ToIn = table.contains({ \"MT\", \"D1\", \"D3\", \"H1\" }, M.SelfPos)\n        elseif M.Config.Main.M12SAutoFaceType == 2 then\n            ToIn = table.contains({ \"MT\", \"ST\", \"H2\", \"D1\", \"D2\", \"D4\" }, M.SelfPos)\n        end\n        if M.M12S.GP1Info.head.pos.x > 100 then\n            -- 右半场\n            if ToIn then\n                -- 最终目标是设置 射向 math.pi * 3 / 2\n                if curBuff.stacks == 1036 then\n                    M.M12S.GP1Info.face = math.pi * 3 / 2\n                elseif curBuff.stacks == 1037 then\n                    M.M12S.GP1Info.face = 0\n                elseif curBuff.stacks == 1038 then\n                    M.M12S.GP1Info.face = math.pi / 2\n                elseif curBuff.stacks == 1039 then\n                    M.M12S.GP1Info.face = math.pi\n                end\n            else\n                -- 最终目标是设置 射向 math.pi  / 2\n                if curBuff.stacks == 1036 then\n                    M.M12S.GP1Info.face = math.pi / 2\n                elseif curBuff.stacks == 1037 then\n                    M.M12S.GP1Info.face = math.pi\n                elseif curBuff.stacks == 1038 then\n                    M.M12S.GP1Info.face = math.pi * 3 / 2\n                elseif curBuff.stacks == 1039 then\n                    M.M12S.GP1Info.face = 0\n                end\n            end\n        else\n            if ToIn then\n                -- 最终目标是设置 射向 math.pi  / 2\n                if curBuff.stacks == 1036 then\n                    M.M12S.GP1Info.face = math.pi / 2\n                elseif curBuff.stacks == 1037 then\n                    M.M12S.GP1Info.face = math.pi\n                elseif curBuff.stacks == 1038 then\n                    M.M12S.GP1Info.face = math.pi * 3 / 2\n                elseif curBuff.stacks == 1039 then\n                    M.M12S.GP1Info.face = 0\n                end\n            else\n                if curBuff.stacks == 1036 then\n                    M.M12S.GP1Info.face = math.pi * 3 / 2\n                elseif curBuff.stacks == 1037 then\n                    M.M12S.GP1Info.face = 0\n                elseif curBuff.stacks == 1038 then\n                    M.M12S.GP1Info.face = math.pi / 2\n                elseif curBuff.stacks == 1039 then\n                    M.M12S.GP1Info.face = math.pi\n                end\n            end\n        end\n    end\n    d(\"已采集到蛇头数据\")\nend\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"82f27b87-655b-728c-a0a5-551821fdb883",
								true,
							},
							
							{
								"dc97e63d-ce22-890f-98f6-149f2aebb647",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "1运-采集蛇头位置",
						uuid = "9587bed3-2a71-7954-9227-1fbaff493b9d",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
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
						actionLua = "MuAiGuide.M12S.GP3Info.SubMonster = TensorCore.mGetEntity(eventArgs.entityID)\nMuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.GPuzzle3_GotSnake\nd(\"读条效果获取完毕\")\nself.used = true\n",
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
							
							{
								"c05df42b-66b0-a7dc-8dd3-477d84bc82ea",
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
						category = "Event",
						eventArgType = 2,
						eventSpellID = 46237,
						name = "46237",
						uuid = "82f27b87-655b-728c-a0a5-551821fdb883",
						version = 2,
					},
					inheritedIndex = 6,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.GPuzzle3_Start\n\t\t\tand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.GPuzzle3_End",
						name = "已进入3运",
						uuid = "c05df42b-66b0-a7dc-8dd3-477d84bc82ea",
						version = 2,
					},
					inheritedIndex = 6,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.GPuzzle1_Start",
						name = "未进入1运",
						uuid = "dc97e63d-ce22-890f-98f6-149f2aebb647",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 46229,
						name = "46229-致命灾变",
						uuid = "6c184475-9b89-f006-a8ba-c1f430694bc4",
						version = 2,
					},
				},
			},
			eventType = 3,
			name = "M12S门神阶段切换[开始读条]",
			uuid = "ed3702b5-fda0-d2eb-bfce-9dc253883a46",
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
						actionLua = "TensorCore.API.TensorACR.setLockFaceHeading(MuAiGuide.M12S.GP1Info.face)\nTensorCore.API.TensorACR.toggleLockFace(true)\nMuAiGuide.M12S.Timer = Now()\nMuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.GPuzzle1_AutoLock\nMuAiGuide.M12S.Locking = true\nself.used = true",
						conditions = 
						{
							
							{
								"8785e636-0643-2c4a-877d-b941da280ccf",
								true,
							},
							
							{
								"6d035129-cd47-17cc-ae57-023df4037b1b",
								true,
							},
							
							{
								"080acc92-067a-5769-a4ee-58b0e3e87377",
								true,
							},
							
							{
								"467ad839-919e-2318-9553-473d3680a0a0",
								true,
							},
							
							{
								"d5f34a5d-dc44-d2a4-a4a6-c7f72ae59e82",
								true,
							},
						},
						gVar = "ACR_TensorMagnum3_CD",
						name = "锁定面向",
						uuid = "a058e886-a447-ec2c-b29d-c0360f5ef21d",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\nMuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.GPuzzle1_end\nMuAiGuide.M12S.Locking = false\nself.used = true",
						conditions = 
						{
							
							{
								"8785e636-0643-2c4a-877d-b941da280ccf",
								true,
							},
							
							{
								"6d035129-cd47-17cc-ae57-023df4037b1b",
								true,
							},
							
							{
								"5641790e-35d5-6128-b8ab-65c0fae5590e",
								true,
							},
							
							{
								"cce86369-f0d4-9218-8a97-388bd7e3e162",
								true,
							},
							
							{
								"0c7813c1-db9e-db2e-976d-0b6260a3566f",
								true,
							},
						},
						gVar = "ACR_TensorMagnum3_CD",
						name = "取消锁定面向",
						uuid = "10eef159-d1fd-5ebf-8dc3-6ca2ad3b13b8",
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
						conditionLua = "return MuAiGuide.Config.Main.M12SAutoFace1",
						name = "Config",
						uuid = "8785e636-0643-2c4a-877d-b941da280ccf",
						version = 2,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Self",
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "6d035129-cd47-17cc-ae57-023df4037b1b",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						buffCheckType = 3,
						buffDuration = 2,
						buffID = 4976,
						category = "Self",
						comparator = 2,
						name = "指向判定2秒",
						uuid = "080acc92-067a-5769-a4ee-58b0e3e87377",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.GPuzzle1_Start",
						name = "进入到门神1运",
						uuid = "467ad839-919e-2318-9553-473d3680a0a0",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return TimeSince(MuAiGuide.M12S.Timer) > 3000",
						name = "锁定面向已大于3秒",
						uuid = "cce86369-f0d4-9218-8a97-388bd7e3e162",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.GPuzzle1_AutoLock",
						name = "当前是锁定阶段",
						uuid = "5641790e-35d5-6128-b8ab-65c0fae5590e",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return  MuAiGuide.M12S.Locking == true",
						name = "锁定面向中",
						uuid = "0c7813c1-db9e-db2e-976d-0b6260a3566f",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return  MuAiGuide.M12S.Locking == false",
						name = "没有锁定面向",
						uuid = "d5f34a5d-dc44-d2a4-a4a6-c7f72ae59e82",
						version = 2,
					},
				},
			},
			name = "M12S门神1运自动面向",
			uuid = "288f9733-cd95-3e4b-ab8d-30c5a0d637a7",
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
						actionLua = "local M = MuAiGuide\n\nif data.debug2test == nil or data.debug2test ~= M.M12S.GP2Info.State then\n    d(\"M.M12S.GP2Info.State=\" .. tostring(M.M12S.GP2Info.State))\n    data.debug2test = M.M12S.GP2Info.State\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.GPuzzle2_Start then\n    M.FrameDirect(100, 100)\n    if table.size(M.M12S.GP2Info.ids) < 4 then\n        for _, ent in pairs(TensorCore.entityList(\"contentid=14381\")) do\n            if ent.action == 9352 then\n                if not table.contains(M.M12S.GP2Info.ids, ent.id) then\n                    table.insert(M.M12S.GP2Info.ids, ent.id)\n                    M.M12S.GP2Info.gSpawnIdx = M.M12S.GP2Info.gSpawnIdx + 1\n                    M.M12S.GP2Info.gTowers[M.M12S.GP2Info.gSpawnIdx] = ent\n                end\n            end\n        end\n        if table.size(M.M12S.GP2Info.ids) == 4 then\n            -- 读取BUFF信息，进入循环监视\n            M.M12S.CurrentState = M.M12S.StateEnum.GPuzzle2_Looping\n            if TensorCore.getBuff(M.GetPlayer().id, 4752) then\n                if TensorCore.getBuff(M.GetPlayer().id, 3004) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.A1\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3005) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.A2\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3006) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.A3\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3451) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.A4\n                end\n            elseif TensorCore.getBuff(M.GetPlayer().id, 4754) then\n                if TensorCore.getBuff(M.GetPlayer().id, 3004) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.B1\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3005) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.B2\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3006) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.B3\n                elseif TensorCore.getBuff(M.GetPlayer().id, 3451) then\n                    M.M12S.GP2Info.selfType = M.M12S.DataEnum.B4\n                end\n            end\n            d(\"M.M12S.GP2Info.selfType =\" .. tostring(M.M12S.GP2Info.selfType))\n        end\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.GPuzzle2_Looping then\n    if M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_end then\n        M.M12S.CurrentState = M.M12S.StateEnum.GPuzzle2_End\n    else\n        if (not M.M12S.GP2Info.pTowerFinish) and table.size(M.M12S.GP2Info.ids) < 8 then\n            for _, ent in pairs(TensorCore.entityList(\"contentid=14381\")) do\n                if ent.action == 9352 then\n                    if not table.contains(M.M12S.GP2Info.ids, ent.id) then\n                        table.insert(M.M12S.GP2Info.ids, ent.id)\n                        M.M12S.GP2Info.pSpawnIdx = M.M12S.GP2Info.pSpawnIdx + 1\n                        M.M12S.GP2Info.pTowers[M.M12S.GP2Info.pSpawnIdx] = ent\n                    end\n                end\n            end\n            if table.size(M.M12S.GP2Info.ids) == 8 then\n                M.M12S.GP2Info.pTowerFinish = true\n            end\n        end\n\n        if M.M12S.GP2Info.selfType == M.M12S.DataEnum.A1\n                or M.M12S.GP2Info.selfType == M.M12S.DataEnum.A2 then\n            if M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_01 then\n                local alpha = TensorCore.getBuff(M.GetPlayer().id, 4752)\n                if alpha == nil or alpha.duration <= 0 then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_02\n                else\n                    --等待\n                    M.FrameDirect(100, 100)\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_02 then\n                --拉线\n                if TensorCore.getBuff(M.GetPlayer().id, 2941) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_03\n                else\n                    local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                    if boss ~= nil then\n                        local pos = TensorCore.getPosInDirection(boss.pos, boss.pos.h, 14.5)\n                        M.FrameDirect(pos.x, pos.z)\n                    end\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_03 then\n                --踩塔\n                if TensorCore.getBuff(M.GetPlayer().id, 3935) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_end\n                else\n                    local tower\n                    if M.M12S.GP2Info.selfType == M.M12S.DataEnum.A1 then\n                        tower = M.M12S.GP2Info.gTowers[3]\n                    else\n                        tower = M.M12S.GP2Info.gTowers[4]\n                    end\n                    M.FrameDirect(tower.pos.x, tower.pos.z)\n                end\n            end\n        elseif M.M12S.GP2Info.selfType == M.M12S.DataEnum.A3\n                or M.M12S.GP2Info.selfType == M.M12S.DataEnum.A4 then\n            if M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_01 then\n                --踩塔\n                if TensorCore.getBuff(M.GetPlayer().id, 3935) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_02\n                else\n                    local tower\n                    if M.M12S.GP2Info.selfType == M.M12S.DataEnum.A3 then\n                        tower = M.M12S.GP2Info.gTowers[1]\n                    else\n                        tower = M.M12S.GP2Info.gTowers[2]\n                    end\n                    M.FrameDirect(tower.pos.x, tower.pos.z)\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_02 then\n                --回中\n                local alpha = TensorCore.getBuff(M.GetPlayer().id, 4752)\n                if alpha == nil or alpha.duration <= 0 then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_03\n                else\n                    M.FrameDirect(100, 100)\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_03 then\n                if TensorCore.getBuff(M.GetPlayer().id, 2941) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_end\n                else\n                    local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                    if boss ~= nil then\n                        local pos = TensorCore.getPosInDirection(boss.pos, boss.pos.h, 14.5)\n                        M.FrameDirect(pos.x, pos.z)\n                    end\n                end\n            end\n\n        elseif M.M12S.GP2Info.selfType == M.M12S.DataEnum.B1\n                or M.M12S.GP2Info.selfType == M.M12S.DataEnum.B2 then\n            if TensorCore.getDistance2d(M.GetPlayer().pos, { x = 100, y = 0, z = 100 }) > 14 then\n                M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_end\n            else\n                if M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_01 then\n                    local beta = TensorCore.getBuff(M.GetPlayer().id, 4754)\n                    if beta == nil or beta.duration <= 0 then\n                        M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_02\n                    else\n                        M.FrameDirect(100, 100)\n                    end\n                elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_02 then\n                    if TensorCore.getBuff(M.GetPlayer().id, 2941) then\n                        M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_03\n                    else\n                        local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                        if boss ~= nil then\n                            local pos = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi, 9)\n                            M.FrameDirect(pos.x, pos.z)\n                        end\n                    end\n                elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_03 then\n                    if TensorCore.getBuff(M.GetPlayer().id, 3935) then\n                        M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_04\n                    else\n                        local tower\n                        if M.M12S.GP2Info.selfType == M.M12S.DataEnum.B1 then\n                            tower = M.M12S.GP2Info.pTowers[3]\n                        else\n                            tower = M.M12S.GP2Info.pTowers[4]\n                        end\n                        if tower ~= nil then\n                            M.FrameDirect(tower.pos.x, tower.pos.z)\n                        else\n                            M.FrameDirect(100, 100)\n                        end\n                    end\n                elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_04 then\n                    local buff = TensorCore.getBuff(M.GetPlayer().id, 3935)\n                    if buff ~= nil and buff.duration > 0 then\n                        if M.M12S.GP2Info.guidePosIn == nil then\n                            local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                            M.M12S.GP2Info.guidePosIn = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi / 2, 8)\n                            M.M12S.GP2Info.guidePosOut = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi / 2, 14.5)\n                        end\n                        if buff.duration > 22 then\n                            M.FrameDirect(M.M12S.GP2Info.guidePosIn.x, M.M12S.GP2Info.guidePosIn.z)\n                        elseif buff.duration > 17 then\n                            M.FrameDirect(M.M12S.GP2Info.guidePosOut.x, M.M12S.GP2Info.guidePosOut.z)\n                        --else\n                        --    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_end\n                        end\n                    end\n                end\n            end\n        elseif M.M12S.GP2Info.selfType == M.M12S.DataEnum.B3\n                or M.M12S.GP2Info.selfType == M.M12S.DataEnum.B4 then\n            if M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_01 then\n                local buff = TensorCore.getBuff(M.GetPlayer().id, 3935) --出毒抗\n                if buff ~= nil and buff.duration > 0 then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_02\n                else\n                    local tower\n                    if M.M12S.GP2Info.selfType == M.M12S.DataEnum.B3 then\n                        tower = M.M12S.GP2Info.pTowers[1]\n                    else\n                        tower = M.M12S.GP2Info.pTowers[2]\n                    end\n                    if tower ~= nil then\n                        M.FrameDirect(tower.pos.x, tower.pos.z)\n                    else\n                        M.FrameDirect(100, 100)\n                    end\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_02 then\n                local beta = TensorCore.getBuff(M.GetPlayer().id, 4754)\n                if beta == nil or beta.duration <= 0 then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_03\n                else\n                    M.FrameDirect(100, 100)\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_03 then\n                if TensorCore.getBuff(M.GetPlayer().id, 2941) then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_04\n                else\n                    local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                    if boss ~= nil then\n                        local pos = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi, 9)\n                        M.FrameDirect(pos.x, pos.z)\n                    end\n                end\n            elseif M.M12S.GP2Info.State == M.M12S.DataEnum.Gp2_04 then\n                if TensorCore.getDistance2d(M.GetPlayer().pos, { x = 100, y = 0, z = 100 }) > 14 then\n                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_end\n                else\n                    local buff = TensorCore.getBuff(M.GetPlayer().id, 2941)\n                    if buff and buff.duration > 0 then\n                        if M.M12S.GP2Info.selfType == M.M12S.DataEnum.B3 then\n                            if buff.duration < 6.5 and buff.duration > 5 then\n                                if M.M12S.GP2Info.guidePosIn == nil then\n                                    local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                                    M.M12S.GP2Info.guidePosIn = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi / 2, 8)\n                                    M.M12S.GP2Info.guidePosOut = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi / 2, 14.5)\n                                end\n                            end\n                            if buff.duration > 4.5 then\n                                M.FrameDirect(100, 100)\n                            elseif buff.duration > 1 then\n                                M.FrameDirect(M.M12S.GP2Info.guidePosIn.x, M.M12S.GP2Info.guidePosIn.z)\n                            else\n                                local buff3935 = TensorCore.getBuff(M.GetPlayer().id, 3935)\n                                if buff3935 == nil or buff3935.duration < 8 then\n                                    M.M12S.GP2Info.State = M.M12S.DataEnum.Gp2_end\n                                else\n                                    M.FrameDirect(M.M12S.GP2Info.guidePosOut.x, M.M12S.GP2Info.guidePosOut.z)\n                                end\n                            end\n                        elseif M.M12S.GP2Info.selfType == M.M12S.DataEnum.B4 then\n                            if buff.duration > 6.5 then\n                                M.FrameDirect(100, 100)\n                            else\n                                local isHeadingOk = false\n                                local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                                for i = 1, 4 do\n                                    local dir = math.pi * i / 2\n                                    if M.IsSameDirection(dir, boss.pos.h) then\n                                        isHeadingOk = true\n                                        break\n                                    end\n                                end\n                                if isHeadingOk then\n                                    if M.M12S.GP2Info.guidePosOut == nil then\n                                        M.M12S.GP2Info.guidePosOut = TensorCore.getPosInDirection(boss.pos, boss.pos.h, 14.5)\n                                    else\n                                        M.FrameDirect(M.M12S.GP2Info.guidePosOut.x, M.M12S.GP2Info.guidePosOut.z)\n                                    end\n                                end\n                            end\n                        end\n                    end\n                end\n            end\n        end\n    end\nend\n\nself.used = true",
						conditions = 
						{
							
							{
								"42135860-fa43-bb22-ba90-ab4d78c0b3bd",
								true,
							},
							
							{
								"5f0416e8-58c4-89b4-8c78-b63bd589a932",
								true,
							},
							
							{
								"53868273-c873-a826-a0c3-a3e1586e62d9",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "M12S门神2运主循环",
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
						conditionLua = "return MuAiGuide.M12S ~= nil",
						name = "M12S已初始化",
						uuid = "5f0416e8-58c4-89b4-8c78-b63bd589a932",
						version = 2,
					},
					inheritedIndex = 2,
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
						actionLua = "local M = MuAiGuide\nif M.M12S.CurrentState == M.M12S.StateEnum.GPuzzle3_GotSnake then\n    local buff3935 = TensorCore.getBuff(M.GetPlayer().id, 3935)\n    if buff3935 ~= nil then\n        M.M12S.CurrentState = M.M12S.StateEnum.GPuzzle3_End\n    else\n        if M.M12S.GP3Info.selfBuff == nil then\n            M.M12S.GP3Info.selfBuff = TensorCore.getBuff(M.GetPlayer().id, 3558)\n        else\n            if M.M12S.GP3Info.guidePos == nil then\n                if MuAiGuide.M12S.GP3Info.SubMonster.pos.x < 85 then\n                    --左上出现，十字安全\n                    if M.M12S.GP3Info.selfBuff.stacks == 1078 then\n                        --向上\n                        if M.IsDps(M.GetPlayer().job) then\n                            M.M12S.GP3Info.guidePos = { x = 103.5, z = 106.5 }\n                        else\n                            M.M12S.GP3Info.guidePos = { x = 96.5, z = 113.5 }\n                        end\n                    elseif M.M12S.GP3Info.selfBuff.stacks == 1079 then\n                        --向右\n                        if M.IsDps(M.GetPlayer().job) then\n                            M.M12S.GP3Info.guidePos = { x = 88.5, z = 103.5 }\n                        else\n                            M.M12S.GP3Info.guidePos = { x = 81.5, z = 96.5 }\n                        end\n                    elseif M.M12S.GP3Info.selfBuff.stacks == 1080 then\n                        --向下\n                        if M.IsDps(M.GetPlayer().job) then\n                            M.M12S.GP3Info.guidePos = { x = 103.5, z = 86.5 }\n                        else\n                            M.M12S.GP3Info.guidePos = { x = 96.5, z = 93.5 }\n                        end\n                    elseif M.M12S.GP3Info.selfBuff.stacks == 1081 then\n                        --向左\n                        if M.IsDps(M.GetPlayer().job) then\n                            M.M12S.GP3Info.guidePos = { x = 118.5, z = 103.5 }\n                        else\n                            M.M12S.GP3Info.guidePos = { x = 111.5, z = 96.5 }\n                        end\n                    end\n                else\n                    if M.M12S.GP3Info.selfBuff.stacks == 1078 then\n                        if M.IsDps(M.GetPlayer().job) then\n                            M.M12S.GP3Info.guidePos = { x = 88.5, z = 113.5 }\n                        else\n                            M.M12S.GP3Info.guidePos = { x = 81.5, z = 106.5 }\n                        end\n                        --向上\n                    elseif M.M12S.GP3Info.selfBuff.stacks == 1079 then\n                        --向右\n                        if M.IsDps(M.GetPlayer().job) then\n                            M.M12S.GP3Info.guidePos = { x = 88.5, z = 93.5 }\n                        else\n                            M.M12S.GP3Info.guidePos = { x = 81.5, z = 86.5 }\n                        end\n                    elseif M.M12S.GP3Info.selfBuff.stacks == 1080 then\n                        --向下\n                        if M.IsDps(M.GetPlayer().job) then\n                            M.M12S.GP3Info.guidePos = { x = 118.5, z = 93.5 }\n                        else\n                            M.M12S.GP3Info.guidePos = { x = 111.5, z = 86.5 }\n                        end\n                    elseif M.M12S.GP3Info.selfBuff.stacks == 1081 then\n                        --向左\n                        if M.IsDps(M.GetPlayer().job) then\n                            M.M12S.GP3Info.guidePos = { x = 118.5, z = 113.5 }\n                        else\n                            M.M12S.GP3Info.guidePos = { x = 111.5, z = 106.5 }\n                        end\n                    end\n                end\n            end\n            M.FrameDirect(M.M12S.GP3Info.guidePos.x, M.M12S.GP3Info.guidePos.z)\n        end\n    end\nend\nself.used = true",
						conditions = 
						{
							
							{
								"42135860-fa43-bb22-ba90-ab4d78c0b3bd",
								true,
							},
							
							{
								"ce87c006-b852-9e5b-a11a-1f0b423a832b",
								true,
							},
							
							{
								"0b399c82-8d7f-f81a-9292-bd9ec13413e9",
								true,
							},
							
							{
								"d8f5335a-5f3c-c70f-a98f-078fffd87812",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "M12S门神3运主循环",
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
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S ~= nil",
						name = "M12S已初始化",
						uuid = "ce87c006-b852-9e5b-a11a-1f0b423a832b",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.GPuzzle3_Start\n\t\t\tand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.GPuzzle3_End",
						name = "已进入3运",
						uuid = "0b399c82-8d7f-f81a-9292-bd9ec13413e9",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.GP3Info.SubMonster ~= nil",
						name = "已查找到地形情况",
						uuid = "d8f5335a-5f3c-c70f-a98f-078fffd87812",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M12S门神3运主循环",
			uuid = "c88ef753-2fab-19da-b48b-cd0a69a9505c",
			version = 2,
		},
		inheritedIndex = 19,
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
			enabled = false,
			name = "-- 本体 --",
			uuid = "960bb8b2-a094-8d02-93bf-bed17a863848",
			version = 2,
		},
		inheritedIndex = 27,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle1_Start then\n    local changeState = false\n    for _, ent in pairs(M.Party) do\n        local buff = TensorCore.getBuff(ent.id, 3323)\n        if buff ~= nil then\n            changeState = true\n            M.M12S.CurrentState = M.M12S.StateEnum.Puzzle1_GotBuff\n            M.M12S.Timer = Now()\n            break\n        end\n    end\n    if not changeState then\n        local guidePos = nil\n        if M.SelfPos == \"MT\" then\n            guidePos = { x = 96, z = 96 }\n        elseif M.SelfPos == \"ST\" then\n            guidePos = { x = 104, z = 104 }\n        elseif M.SelfPos == \"H1\" then\n            guidePos = { x = 93, z = 107 }\n        elseif M.SelfPos == \"H2\" then\n            guidePos = { x = 107, z = 93 }\n        elseif M.SelfPos == \"D1\" then\n            guidePos = { x = 96, z = 104 }\n        elseif M.SelfPos == \"D2\" then\n            guidePos = { x = 104, z = 96 }\n        elseif M.SelfPos == \"D3\" then\n            guidePos = { x = 93, z = 93 }\n        elseif M.SelfPos == \"D4\" then\n            guidePos = { x = 107, z = 107 }\n        end\n        M.FrameDirect(guidePos.x, guidePos.z)\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle1_GotBuff and TimeSince(M.M12S.Timer) > 2000 then\n    if table.size(M.M12S.P1Info.SubsDark) == 2 and table.size(M.M12S.P1Info.SubsFire) == 2 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle1_GotSub\n        M.M12S.Timer = Now()\n    else\n        local cnt = 0\n        for _, ent in pairs(TensorCore.entityList(\"contentid=14380\")) do\n            if Argus.isEntityVisible(ent) then\n                cnt = cnt + 1\n            end\n        end\n        if cnt == 12 then\n            for _, ent in pairs(TensorCore.entityList(\"contentid=14380\")) do\n                if Argus.isEntityVisible(ent) then\n                    local _, flag = Argus.getEntityTransforms(ent.id)\n                    if flag == 16 and table.size(M.M12S.P1Info.Subs) < 8 then\n                        table.insert(M.M12S.P1Info.Subs, ent)\n                    else\n                        local index = -1\n                        local rad = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n                        for i = 0, 3 do\n                            local dir = math.pi / 2 * i\n                            if M.IsSameDirection(dir, rad) then\n                                index = i\n                                break\n                            end\n                        end\n                        if index == -1 then\n                            M.M12S.P1Info.FireMain = ent\n                        else\n                            table.insert(M.M12S.P1Info.SubOld, ent)\n                        end\n                    end\n                end\n            end\n\n            local pA = M.M12S.P1Info.SubOld[1].pos\n            local pB = M.M12S.P1Info.SubOld[2].pos\n            local pC = M.M12S.P1Info.SubOld[3].pos\n            local disAB = TensorCore.getDistance2d(pA, pB)\n            local disAC = TensorCore.getDistance2d(pA, pC)\n            local disBC = TensorCore.getDistance2d(pB, pC)\n            if disAB == disAC then\n                M.M12S.P1Info.DarkMain = M.M12S.P1Info.SubOld[1]\n            elseif disAB == disBC then\n                M.M12S.P1Info.DarkMain = M.M12S.P1Info.SubOld[2]\n            elseif disBC == disAC then\n                M.M12S.P1Info.DarkMain = M.M12S.P1Info.SubOld[3]\n            end\n            if table.size(M.M12S.P1Info.Subs) == 8\n                    and M.M12S.P1Info.FireMain ~= nil\n                    and M.M12S.P1Info.DarkMain ~= nil then\n                local others = {}\n                for _, sub in pairs(M.M12S.P1Info.Subs) do\n                    if M.IsSameDirection(sub.pos.h, M.M12S.P1Info.FireMain.pos.h) then\n                        table.insert(M.M12S.P1Info.SubsFire, sub)\n                    else\n                        table.insert(others, sub)\n                    end\n                end\n                M.M12S.P1Info.SubsDark = M.M12S.P1Info.getNear2(M.M12S.P1Info.DarkMain, others)\n                if table.size(M.M12S.P1Info.SubsDark) == 2 and table.size(M.M12S.P1Info.SubsFire) == 2 then\n                    local focus = M.M12S.P1Info.SubsDark[1].pos\n                    M.M12S.P1Info.oldPos = { x = focus.x, y = focus.y, z = focus.z }\n                    M.M12S.P1Info.lastPos = { x = focus.x, y = focus.y, z = focus.z }\n                end\n            end\n        end\n    end\nend\n\n-- 等待位置变化\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle1_GotSub and TimeSince(M.M12S.Timer) > 1000 then\n    local fucus = M.M12S.P1Info.SubsDark[1]\n    local focusSub = TensorCore.mGetEntity(fucus.id)\n    local curPos = { x = focusSub.pos.x, y = focusSub.pos.y, z = focusSub.pos.z }\n    local toOld = TensorCore.getDistance2d(M.M12S.P1Info.oldPos, curPos)\n    if toOld > 0.5 then\n        local toLast = TensorCore.getDistance2d(M.M12S.P1Info.lastPos, curPos)\n        if toLast < 0.5 then\n            --距离元始位置大于0.5 距离新前次检查位置小于0.5表示小怪已经移动完毕\n            M.M12S.CurrentState = M.M12S.StateEnum.Puzzle1_SubMove\n        else\n            M.M12S.P1Info.lastPos = curPos\n            M.M12S.Timer = Now()\n        end\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle1_SubMove then\n    local player = M.GetPlayer()\n    if M.M12S.P1Info.buffType == nil then\n        local buff = TensorCore.getBuff(player.id, 3323)\n        if buff == nil then\n            M.M12S.P1Info.buffType = 2937\n        else\n            M.M12S.P1Info.buffType = 3323\n        end\n    elseif M.M12S.P1Info.buffType == 2937 then\n        local buff = TensorCore.getBuff(player.id, 3323)\n        if buff ~= nil then\n            M.M12S.CurrentState = M.M12S.StateEnum.Puzzle1_End\n        end\n    elseif M.M12S.P1Info.buffType == 3323 then\n        local buff = TensorCore.getBuff(player.id, 2937)\n        if buff ~= nil then\n            M.M12S.CurrentState = M.M12S.StateEnum.Puzzle1_End\n        end\n    end\n    local list\n    if M.M12S.P1Info.buffType == 3323 then\n        list = M.M12S.P1Info.SubsFire\n    else\n        list = M.M12S.P1Info.SubsDark\n    end\n    if M.M12S.P1Info.guideId == nil then\n        local target\n        if table.contains({ \"MT\", \"ST\", \"D1\", \"D2\" }, M.SelfPos) then\n            local distance = 10000\n            for _, ent in pairs(list) do\n                local newEnt = TensorCore.mGetEntity(ent.id)\n                local curDis = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, newEnt.pos)\n                if curDis < distance then\n                    distance = curDis\n                    target = ent\n                end\n            end\n        else\n            local distance = 0\n            for _, ent in pairs(list) do\n                local newEnt = TensorCore.mGetEntity(ent.id)\n                local curDis = TensorCore.getDistance2d({ x = 100, y = 0, z = 100 }, newEnt.pos)\n                if curDis > distance then\n                    distance = curDis\n                    target = ent\n                end\n            end\n        end\n        M.M12S.P1Info.guideId = target.id\n    end\n    local pos = TensorCore.mGetEntity(M.M12S.P1Info.guideId).pos\n    if M.SelfPos == \"MT\" or M.SelfPos == \"ST\" then\n        if pos.z > 100 then\n            M.FrameDirect(100, 106.8, 0.45)\n        else\n            M.FrameDirect(100, 93.2, 0.45)\n        end\n    elseif M.SelfPos == \"D1\" or M.SelfPos == \"D2\" then\n        if M.M12S.P1Info.buffType == 3323 then\n            --暗找火\n            if pos.z > 100 then\n                M.FrameDirect(100, 106.8, 0.45)\n            else\n                M.FrameDirect(100, 93.2, 0.45)\n            end\n        else\n            if pos.x > 100 then\n                M.FrameDirect(106.8, 100, 0.45)\n            else\n                M.FrameDirect(93.2, 100, 0.45)\n            end\n        end\n    else\n        if M.M12S.P1Info.ConeType == 46299 then\n            -- 横着打\n            if M.M12S.P1Info.buffType == 3323 then\n                --暗找火\n                if pos.x > 100 then\n                    if pos.z > 100 then\n                        M.FrameDirect(110, 115.8)\n                    else\n                        M.FrameDirect(110, 84.2)\n                    end\n                else\n                    if pos.z > 100 then\n                        M.FrameDirect(90, 115.8)\n                    else\n                        M.FrameDirect(90, 84.2)\n                    end\n                end\n            else\n                if M.SelfPos == \"H1\" or M.SelfPos == \"H2\" then\n                    if pos.x > 100 then\n                        if pos.z > 100 then\n                            M.FrameDirect(111, 116)\n                        else\n                            M.FrameDirect(111, 84)\n                        end\n                    else\n                        if pos.z > 100 then\n                            M.FrameDirect(89, 116)\n                        else\n                            M.FrameDirect(89, 84)\n                        end\n                    end\n                else\n                    if pos.x > 100 then\n                        if pos.z > 100 then\n                            M.FrameDirect(105.5, 114.5)\n                        else\n                            M.FrameDirect(105.5, 85.5)\n                        end\n                    else\n                        if pos.z > 100 then\n                            M.FrameDirect(94.5, 114.5)\n                        else\n                            M.FrameDirect(94.5, 85.5)\n                        end\n                    end\n                end\n            end\n        elseif M.M12S.P1Info.ConeType == 46298 then\n            -- 竖着打\n            if M.M12S.P1Info.buffType == 3323 then\n                --暗找火\n                if pos.x > 100 then\n                    if pos.z > 100 then\n                        M.FrameDirect(115.8, 110)\n                    else\n                        M.FrameDirect(115.8, 90)\n                    end\n                else\n                    if pos.z > 100 then\n                        M.FrameDirect(84.2, 110)\n                    else\n                        M.FrameDirect(84.2, 90)\n                    end\n                end\n            else\n                if M.SelfPos == \"H1\" or M.SelfPos == \"H2\" then\n                    if pos.x > 100 then\n                        if pos.z > 100 then\n                            M.FrameDirect(116, 110)\n                        else\n                            M.FrameDirect(116, 90)\n                        end\n                    else\n                        if pos.z > 100 then\n                            M.FrameDirect(84, 110)\n                        else\n                            M.FrameDirect(84, 90)\n                        end\n                    end\n                else\n                    if pos.x > 100 then\n                        if pos.z > 100 then\n                            M.FrameDirect(114.5, 105.5)\n                        else\n                            M.FrameDirect(114.5, 94.5)\n                        end\n                    else\n                        if pos.z > 100 then\n                            M.FrameDirect(85.5, 105.5)\n                        else\n                            M.FrameDirect(85.5, 94.5)\n                        end\n                    end\n                end\n            end\n        end\n    end\nend\n\nif M.Config.Main.M12SExDraw and M.M12S.CurrentState == M.M12S.StateEnum.Puzzle1_SubMove then\n    local players = {}\n    for _, player in pairs(M.Party) do\n        table.insert(players, TensorCore.mGetEntity(player.id))\n    end\n    for _, fireEnt in pairs(M.M12S.P1Info.SubsFire) do\n        local curEnt = TensorCore.mGetEntity(fireEnt.id)\n        local dis = nil\n        local targetPlayer\n        for _, player in pairs(players) do\n            local curDis = TensorCore.getDistance2d(player.pos, curEnt.pos)\n            if dis == nil or curDis < dis then\n                targetPlayer = player\n                dis = curDis\n            end\n        end\n        if targetPlayer ~= nil then\n            local drawer = Argus2.ShapeDrawer:new(\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.2)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.2)),\n                    (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.2)),\n                    (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n                    1\n            )\n\n            drawer:addCircle(targetPlayer.pos.x, 0, targetPlayer.pos.z, 5)\n        end\n    end\n    for _, darkEnt in pairs(M.M12S.P1Info.SubsDark) do\n        local curDrk = TensorCore.mGetEntity(darkEnt.id)\n        local near2 = M.M12S.P1Info.getNear2(curDrk, players)\n        if table.size(near2) > 0 then\n            for i, ent in pairs(near2) do\n                local drawer = Argus2.ShapeDrawer:new(\n                        (GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.2)),\n                        (GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.2)),\n                        (GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.2)),\n                        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n                        1\n                )\n                drawer:addCircle(ent.pos.x, 0, ent.pos.z, 5)\n            end\n        end\n    end\nend\n\nself.used = true",
						conditions = 
						{
							
							{
								"ae25bce3-76be-dcb7-af28-63a06c6b7923",
								true,
							},
							
							{
								"27bd62b9-03d7-17d4-af5b-be5b57b2bd03",
								true,
							},
							
							{
								"5eebfd15-ee60-afa9-b0e5-9ae803ab4998",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "本体1运",
						uuid = "b916ece0-0641-6a91-ba0a-4d379c135a0f",
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
						uuid = "ae25bce3-76be-dcb7-af28-63a06c6b7923",
						version = 2,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S ~= nil",
						name = "M12S已初始化",
						uuid = "27bd62b9-03d7-17d4-af5b-be5b57b2bd03",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle1_Start \nand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.Puzzle1_End ",
						name = "1运中",
						uuid = "5eebfd15-ee60-afa9-b0e5-9ae803ab4998",
						version = 2,
					},
					inheritedIndex = 16,
				},
			},
			eventType = 12,
			name = "M12S本体1运主循环",
			uuid = "055265c3-863a-b90b-a145-a430b7c9eaee",
			version = 2,
		},
		inheritedIndex = 22,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle2_Start then\n    local tethers = Argus.getTethersOnEnt(M.GetPlayer().id)\n    if tethers ~= nil and table.size(tethers) > 0 then\n        for _, tether in pairs(tethers) do\n            if tether.type == 117 then\n                local partner = TensorCore.mGetEntity(tether.partnerid)\n                local curEntAngle = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, partner.pos)\n                for i = 1, 8 do\n                    local curAngle = i * math.pi / 4\n                    if M.IsSameDirection(curAngle, curEntAngle) then\n                        M.M12S.P2Info.linkIdx = i\n                        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle2_GetLink\n                        break\n                    end\n                end\n            end\n        end\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle2_GetLink then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=14380\")) do\n        if Argus.isEntityVisible(ent) then\n            if not table.contains(M.M12S.P2Info.ids, ent.id) then\n                local curSubInfo = {}\n                local tethers = Argus.getTethersOnEnt(ent.id)\n                for _, tether in pairs(tethers) do\n                    if tether.type >= 111 and tether.type <= 113 then\n                        curSubInfo.rad = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n                        curSubInfo.entity = ent\n                        curSubInfo.type = tether.type\n                        table.insert(M.M12S.P2Info.ids, ent.id)\n                        table.insert(M.M12S.P2Info.Subs, curSubInfo)\n                        break\n                    end\n                end\n            end\n            if table.size(M.M12S.P2Info.ids) == 6 then\n                M.M12S.CurrentState = M.M12S.StateEnum.Puzzle2_GetSub\n                break\n            end\n        end\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle2_GetSub then\n    local changeState = false\n    for _, player in pairs(M.Party) do\n        --任意一人线判定\n        local tethers = Argus.getTethersOnEnt(player.id)\n        if table.size(tethers) > 0 then\n            for _, tether in pairs(tethers) do\n                if tether.type == M.M12S.DataEnum.LinkFinal then\n                    M.M12S.CurrentState = M.M12S.StateEnum.Puzzle2_CatchEnd\n                    changeState = true\n                    break\n                end\n            end\n        end\n    end\n    if not changeState then\n        if M.M12S.P2Info.linkIdx ~= 8 and M.M12S.P2Info.linkEnt == nil then\n            if M.M12S.P2Info.linkIdx == 4 then\n                local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n                M.M12S.P2Info.linkEnt = { type = M.M12S.DataEnum.Boss, entity = boss, rad = math.pi }\n            elseif M.M12S.P2Info.linkIdx == 3 then\n                M.M12S.P2Info.linkEnt = M.M12S.P2Info.getLinkBoss(M.M12S.DataEnum.Cone, M.M12S.P2Info.orderAsc)\n            elseif M.M12S.P2Info.linkIdx == 2 then\n                M.M12S.P2Info.linkEnt = M.M12S.P2Info.getLinkBoss(M.M12S.DataEnum.Gather, M.M12S.P2Info.orderAsc)\n            elseif M.M12S.P2Info.linkIdx == 1 then\n                M.M12S.P2Info.linkEnt = M.M12S.P2Info.getLinkBoss(M.M12S.DataEnum.Disperse, M.M12S.P2Info.orderAsc)\n            elseif M.M12S.P2Info.linkIdx == 7 then\n                M.M12S.P2Info.linkEnt = M.M12S.P2Info.getLinkBoss(M.M12S.DataEnum.Disperse, M.M12S.P2Info.orderDesc)\n            elseif M.M12S.P2Info.linkIdx == 6 then\n                M.M12S.P2Info.linkEnt = M.M12S.P2Info.getLinkBoss(M.M12S.DataEnum.Gather, M.M12S.P2Info.orderDesc)\n            elseif M.M12S.P2Info.linkIdx == 5 then\n                M.M12S.P2Info.linkEnt = M.M12S.P2Info.getLinkBoss(M.M12S.DataEnum.Cone, M.M12S.P2Info.orderDesc)\n            end\n        end\n        if M.M12S.P2Info.linkEnt ~= nil then\n            local tethers = Argus.getTethersOnEnt(M.GetPlayer().id)\n            local isTargetRight = false\n            if tethers ~= nil and table.size(tethers) > 0 then\n                for _, tether in pairs(tethers) do\n                    if tether.partnerid == M.M12S.P2Info.linkEnt.entity.id then\n                        isTargetRight = true\n                        break\n                    end\n                end\n            end\n            if not isTargetRight then\n                local pos = M.M12S.P2Info.linkEnt.entity.pos\n                M.FrameDirect(pos.x, pos.z)\n            end\n        end\n    end\nend\n\n-- 接线结束\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle2_CatchEnd then\n    if M.M12S.StateChangeByBuff(2941) then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle2_Put1\n        M.M12S.Timer = Now()\n    else\n        if M.M12S.P2Info.guidePosAfterLink ~= nil then\n            M.FrameDirect(M.M12S.P2Info.guidePosAfterLink.x, M.M12S.P2Info.guidePosAfterLink.z)\n        else\n            if M.M12S.P2Info.linkIdx == 4 then\n                M.M12S.P2Info.guidePosAfterLink = { x = 100, z = 90 }\n            elseif M.M12S.P2Info.linkIdx == 1 then\n                M.M12S.P2Info.guidePosAfterLink = { x = 118.7, z = 105 }\n            elseif M.M12S.P2Info.linkIdx == 7 then\n                M.M12S.P2Info.guidePosAfterLink = { x = 81.3, z = 105 }\n            elseif M.M12S.P2Info.linkIdx == 8 then\n                M.M12S.P2Info.guidePosAfterLink = { x = 100, z = 119.3 }\n            else\n                local tableTemp = {}\n                for i = 0, 3 do\n                    local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 90 }, math.pi * (9 + 2 * i) / 12, 8)\n                    table.insert(tableTemp, pos)\n                end\n                local idx = 0\n                if M.M12S.P2Info.linkIdx == 6 then\n                    idx = 4\n                elseif M.M12S.P2Info.linkIdx == 5 then\n                    idx = 3\n                elseif M.M12S.P2Info.linkIdx == 3 then\n                    idx = 2\n                elseif M.M12S.P2Info.linkIdx == 2 then\n                    idx = 1\n                end\n                M.M12S.P2Info.guidePosAfterLink = tableTemp[idx]\n            end\n        end\n    end\nend\n\n-- 第二波处理站位置\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle2_Put1 then\n    if M.M12S.StateChangeByBuff(2941) and TimeSince(M.M12S.Timer) > 6500 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle2_Put2\n        M.M12S.Timer = Now()\n    else\n        if M.M12S.P2Info.guidePosAfterPut1 == nil then\n            if M.M12S.P2Info.linkIdx < 5 then\n                M.M12S.P2Info.guidePosAfterPut1 = { x = 107, z = 93 }\n            else\n                M.M12S.P2Info.guidePosAfterPut1 = { x = 93, z = 93 }\n            end\n            -- M.M12S.Timer\n            if M.M12S.P2Info.linkEnt ~= nil and M.M12S.P2Info.linkEnt.type == M.M12S.DataEnum.Cone then\n                M.M12S.P2Info.guidePosAfterPut1 = { x = M.M12S.P2Info.guidePosAfterPut1.x, z = M.M12S.P2Info.guidePosAfterPut1.z - 1 }\n            end\n        end\n        if M.M12S.P2Info.linkEnt == nil or M.M12S.P2Info.linkEnt.type == M.M12S.DataEnum.Disperse then\n            if TensorCore.getBuff(M.GetPlayer().id, 2941) then\n                M.FrameDirect(M.M12S.P2Info.guidePosAfterPut1.x, M.M12S.P2Info.guidePosAfterPut1.z)\n            else\n                if TimeSince(M.M12S.Timer) > 3500 then\n                    M.FrameDirect(M.M12S.P2Info.guidePosAfterPut1.x, M.M12S.P2Info.guidePosAfterPut1.z)\n                else\n                    M.FrameDirect(M.M12S.P2Info.guidePosAfterLink.x, M.M12S.P2Info.guidePosAfterLink.z)\n                end\n            end\n        else\n            if TimeSince(M.M12S.Timer) > 2500 then\n                M.FrameDirect(M.M12S.P2Info.guidePosAfterPut1.x, M.M12S.P2Info.guidePosAfterPut1.z)\n            else\n                M.FrameDirect(M.M12S.P2Info.guidePosAfterLink.x, M.M12S.P2Info.guidePosAfterLink.z)\n            end\n        end\n    end\nend\n\n-- 去背后\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle2_GoBack and TimeSince(M.M12S.Timer) > 1000 then\n    if M.M12S.P2Info.guidePosBossBack == nil then\n        local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n        local pos = TensorCore.getPosInDirection(boss.pos, boss.pos.h + math.pi, 4)\n        M.M12S.P2Info.guidePosBossBack = pos\n    else\n        if M.M12S.P2Info.linkEnt ~= nil and M.M12S.P2Info.linkEnt.type == M.M12S.DataEnum.Cone then\n            if TimeSince(M.M12S.Timer) > 2500 then\n                M.FrameDirect(M.M12S.P2Info.guidePosBossBack.x, M.M12S.P2Info.guidePosBossBack.z)\n            end\n        else\n            M.FrameDirect(M.M12S.P2Info.guidePosBossBack.x, M.M12S.P2Info.guidePosBossBack.z)\n        end\n    end\nend\n\n-- 第一次重现\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle2_TimeBack and TimeSince(M.M12S.Timer) > 1000 then\n    if M.M12S.StateChangeByBuff(2941) then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle2_TimeBackPut1\n        M.M12S.Timer = Now()\n    else\n        local boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\n        local guidePos\n        if table.contains({ 2, 3, 5, 6 }, M.M12S.P2Info.linkIdx) then\n            local tableTemp = {}\n            for i = 0, 3 do\n                local pos = TensorCore.getPosInDirection(boss.pos, math.pi * (9 + 2 * i) / 12, 8)\n                table.insert(tableTemp, pos)\n            end\n            local idx = 0\n            if M.M12S.P2Info.linkIdx == 6 then\n                idx = 4\n            elseif M.M12S.P2Info.linkIdx == 5 then\n                idx = 3\n            elseif M.M12S.P2Info.linkIdx == 3 then\n                idx = 2\n            elseif M.M12S.P2Info.linkIdx == 2 then\n                idx = 1\n            end\n            guidePos = tableTemp[idx]\n        else\n            local heading, distance\n            if M.M12S.P2Info.linkIdx == 4 then\n                heading = math.pi / 3\n                distance = 5.5\n            elseif M.M12S.P2Info.linkIdx == 1 then\n                heading = math.pi / 3\n                distance = 9\n            elseif M.M12S.P2Info.linkIdx == 8 then\n                heading = math.pi * 5 / 3\n                distance = 5.5\n            elseif M.M12S.P2Info.linkIdx == 7 then\n                heading = math.pi * 5 / 3\n                distance = 9\n            end\n            guidePos = TensorCore.getPosInDirection(boss.pos, heading, distance)\n        end\n        M.FrameDirect(guidePos.x, guidePos.z)\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle2_TimeBackPut1 then\n    local timer = TimeSince(M.M12S.Timer)\n    if timer < 7500 then\n        local guidePos\n        if table.contains({ \"MT\", \"ST\", \"D1\", \"D2\" }, M.SelfPos) then\n            guidePos = { x = 113, z = 100 }\n        else\n            if timer > 5000 then\n                guidePos = { x = 87, z = 100 }\n            else\n                guidePos = { x = 98, z = 89 }\n            end\n        end\n        M.FrameDirect(guidePos.x, guidePos.z)\n    else\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle2_TimeBackPut2\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle2_TimeBackPut2 then\n    if M.M12S.StateChangeByBuff(2941) then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle2_TimeBackPut3\n        M.M12S.Timer = Now()\n    else\n        local guidePos\n        if table.contains({ \"MT\", \"ST\", \"D1\", \"D2\" }, M.SelfPos) then\n            guidePos = { x = 113, z = 100 }\n        else\n            guidePos = { x = 87, z = 100 }\n        end\n        M.FrameDirect(guidePos.x, guidePos.z)\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle2_TimeBackPut3 then\n    local guidePos\n    if TimeSince(M.M12S.Timer) < 5000 then\n        if table.contains({ \"MT\", \"ST\", \"D1\", \"D2\" }, M.SelfPos) then\n            guidePos = { x = 110, z = 87 }\n        else\n            guidePos = { x = 90, z = 100 }\n        end\n        M.FrameDirect(guidePos.x, guidePos.z)\n    else\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle2_End\n        d(\"2运结束\")\n    end\nend\nself.used = true\n",
						conditions = 
						{
							
							{
								"643b092b-6dcd-1349-aef9-3181128bd9c2",
								true,
							},
							
							{
								"be3623c5-978e-0e77-b983-48ee59c1997a",
								true,
							},
							
							{
								"cae75051-4219-56d4-b91e-94762de0b548",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "M12S本体2运主循环",
						uuid = "fa47c99b-5b27-dcc5-84ce-fc2c52de9242",
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
						uuid = "643b092b-6dcd-1349-aef9-3181128bd9c2",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S ~= nil",
						name = "M12S已初始化",
						uuid = "be3623c5-978e-0e77-b983-48ee59c1997a",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle2_Start \n\tand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.Puzzle2_End",
						name = "2运中",
						uuid = "cae75051-4219-56d4-b91e-94762de0b548",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M12S本体2运主循环",
			uuid = "fd49bbfa-8561-3e1f-a70c-3386577dd147",
			version = 2,
		},
		inheritedIndex = 27,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "TensorCore.API.TensorACR.setLockFaceHeading(math.pi)\nTensorCore.API.TensorACR.toggleLockFace(true)\nd(\"自动面向ON\")\nMuAiGuide.M12S.Locking = true\nself.used = true",
						conditions = 
						{
							
							{
								"b443f63c-4f48-9657-8dce-38651fcd335a",
								true,
							},
							
							{
								"46727616-9562-0812-8d34-1438da7f5081",
								true,
							},
							
							{
								"52fc030c-6ac6-7f11-8e35-8775a3026c09",
								true,
							},
							
							{
								"36caece5-aa6f-6de3-a7c8-eae2762a7af2",
								true,
							},
							
							{
								"ef5b65b6-bfc5-15b7-8791-072ef0c783df",
								true,
							},
						},
						gVar = "ACR_TensorMagnum3_CD",
						name = "锁定面向",
						uuid = "67993925-c5ce-099c-ad8d-1be2623669b5",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\nMuAiGuide.M12S.Locking = false\nd(\"自动面向OFF\")\nself.used = true",
						conditions = 
						{
							
							{
								"46727616-9562-0812-8d34-1438da7f5081",
								true,
							},
							
							{
								"85abb005-7e33-3f63-bdd6-67df2bb05a1b",
								true,
							},
							
							{
								"3dc73be8-e856-8d23-8a5f-c64e47a86f95",
								true,
							},
							
							{
								"ef5b65b6-bfc5-15b7-8791-072ef0c783df",
								true,
							},
							
							{
								"b443f63c-4f48-9657-8dce-38651fcd335a",
								true,
							},
						},
						gVar = "ACR_TensorMagnum3_CD",
						name = "取消锁定面向",
						uuid = "b500a102-7ad1-9611-bbcb-6a66d9af060e",
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
						conditionLua = "return MuAiGuide.Config.Main.M12SAutoFace1",
						name = "Config",
						uuid = "b443f63c-4f48-9657-8dce-38651fcd335a",
						version = 2,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Self",
						conditionType = 8,
						localmapid = 1327,
						name = "M12S",
						uuid = "46727616-9562-0812-8d34-1438da7f5081",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle2_Put2",
						name = "当前是锁定阶段",
						uuid = "52fc030c-6ac6-7f11-8e35-8775a3026c09",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return TimeSince(MuAiGuide.M12S.Timer) > 2500",
						name = "锁定面向已大于2.5秒",
						uuid = "85abb005-7e33-3f63-bdd6-67df2bb05a1b",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return  MuAiGuide.M12S.Locking == true",
						name = "锁定面向中",
						uuid = "3dc73be8-e856-8d23-8a5f-c64e47a86f95",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return  MuAiGuide.M12S.Locking == false",
						name = "没有锁定面向",
						uuid = "36caece5-aa6f-6de3-a7c8-eae2762a7af2",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle2_Start \n\tand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.Puzzle2_End\n\tand MuAiGuide.M12S.P2Info.linkEnt ~= nil\n\tand MuAiGuide.M12S.P2Info.linkEnt.type == MuAiGuide.M12S.DataEnum.Cone",
						name = "2运中扇形点名",
						uuid = "ef5b65b6-bfc5-15b7-8791-072ef0c783df",
						version = 2,
					},
					inheritedIndex = 6,
				},
			},
			name = "M12S本体2运自动面向",
			uuid = "3c288afb-43ad-00b0-bc5d-69201059c52e",
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
						actionLua = "--[[\ntransfromModel = \n4757:黑洞\n4758:钢铁\n4759:月环\n4760:上下刀\n4761:左右刀\n]]\nlocal M = MuAiGuide\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle3_Start then\n    local selfPlayer = M.GetPlayer()\n    local buff = TensorCore.getBuff(selfPlayer.id, 4771) or TensorCore.getBuff(selfPlayer.id, 4769)\n    if buff ~= nil and buff.duration < 8 and table.size(M.M12S.P3Info.ids) < 8 then\n        for _, ent in pairs(TensorCore.entityList(\"contentid=14382\")) do\n            local transformModel, _ = Argus.getEntityTransforms(ent.id)\n            if Argus.isEntityVisible(ent) and 4758 <= transformModel and transformModel <= 4761 then\n                if not table.contains(M.M12S.P3Info.ids, ent.id) then\n                    table.insert(M.M12S.P3Info.ids, ent.id)\n                    table.insert(M.M12S.P3Info.entities, { entity = ent, model = transformModel })\n                end\n                if 93 < ent.pos.z and ent.pos.z < 97 then\n                    M.M12S.P3Info.nearUp = { model = transformModel, id = ent.id }\n                elseif 103 < ent.pos.z and ent.pos.z < 107 then\n                    M.M12S.P3Info.nearDown = { model = transformModel, id = ent.id }\n                end\n            end\n        end\n        if table.size(M.M12S.P3Info.ids) == 8 then\n            for _, ent in pairs(M.M12S.P3Info.entities) do\n                if ent.model == M.M12S.P3Info.nearUp.model and ent.entity.id ~= M.M12S.P3Info.nearUp.id\n                        or ent.model == M.M12S.P3Info.nearDown.model and ent.entity.id ~= M.M12S.P3Info.nearDown.id\n                then\n                    if ent.entity.pos.z > 100 then\n                        M.M12S.P3Info.downEnt = ent\n                    else\n                        M.M12S.P3Info.upEnt = ent\n                    end\n                end\n            end\n            if M.M12S.P3Info.upEnt ~= nil and M.M12S.P3Info.downEnt ~= nil then\n                if M.M12S.P3Info.upEnt.model == 4759 or M.M12S.P3Info.downEnt.model == 4759 then\n                    --撞月环，去短边\n                    if M.M12S.P3Info.upEnt.entity.pos.x > 100 then\n                        M.M12S.P3Info.enterBh = M.M12S.DataEnum.Left\n                    else\n                        M.M12S.P3Info.enterBh = M.M12S.DataEnum.Right\n                    end\n                elseif M.M12S.P3Info.upEnt.model == 4758 or M.M12S.P3Info.downEnt.model == 4758 then\n                    --撞钢铁，去长边\n                    if M.M12S.P3Info.upEnt.entity.pos.x > 100 then\n                        M.M12S.P3Info.enterBh = M.M12S.DataEnum.Right\n                    else\n                        M.M12S.P3Info.enterBh = M.M12S.DataEnum.Left\n                    end\n                end\n                d(\"撞球数据采集完毕\")\n                M.M12S.P3Info.hps = {}\n                M.M12S.CurrentState = M.M12S.StateEnum.Puzzle3_GotBall\n                if TensorCore.getBuff(selfPlayer.id, 4771) then\n                    M.M12S.P3Info.NeedAtkBall = true\n                else\n                    M.M12S.P3Info.NeedAtkBall = false\n                end\n                for job, player in pairs(M.Party) do\n                    if not M.IsTank(player.job) and TensorCore.getBuff(player.id, 4771) then\n                        local curPlayer = TensorCore.mGetEntity(player.id)\n                        M.M12S.P3Info.hps[job] = { id = player.id, hpPercent = curPlayer.hp.percent }\n                    end\n                end\n            end\n        end\n    end\nend\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle3_GotBall then\n    --监控3人血量\n    if not M.M12S.P3Info.hitBall then\n        for i, info in pairs(M.M12S.P3Info.hps) do\n            local curPlayer = TensorCore.mGetEntity(info.id)\n            local delta = info.hpPercent - curPlayer.hp.percent\n            if delta > 20 then\n                M.M12S.P3Info.hitBall = true\n                break\n            end\n        end\n    end\n    if M.M12S.P3Info.hitBall then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle3_HpChanged\n    else\n        if M.M12S.P3Info.NeedAtkBall then\n            local selfPlayer = M.GetPlayer()\n            if (not M.M12S.P3Info.hitBall) then\n                local targetId\n                if M.IsDps(selfPlayer.job) or (M.Config.Main.M12SP2is13 and M.IsHealer(selfPlayer.job)) then\n                    targetId = M.M12S.P3Info.downEnt.entity.id\n                else\n                    targetId = M.M12S.P3Info.upEnt.entity.id\n                end\n                local target = TensorCore.mGetEntity(targetId)\n                M.FrameDirect(target.pos.x, target.pos.z)\n            end\n        else\n            M.FrameDirect(100, 100)\n        end\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle3_HpChanged then\n    if M.M12S.P3Info.channelTime ~= nil and M.M12S.P3Info.channelTime > 0 and TimeSince(M.M12S.P3Info.channelTime) > 4500 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle3_Safe1\n        M.M12S.Timer = Now()\n    else\n        if M.M12S.P3Info.BallGone == nil then\n            local cnt = 0\n            for _, entity in pairs(M.M12S.P3Info.ids) do\n                local curEntity = TensorCore.mGetEntity(entity)\n                if Argus.isEntityVisible(curEntity) then\n                    cnt = cnt + 1\n                end\n            end\n            if cnt == 0 then\n                M.M12S.P3Info.BallGone = true\n            end\n        end\n        if M.M12S.P3Info.BallGone then\n            local pos\n            if M.M12S.P3Info.enterBh == M.M12S.DataEnum.Right then\n                pos = { x = 110, z = 98 }\n            else\n                pos = { x = 90, z = 98 }\n            end\n            M.FrameDirect(pos.x, pos.z)\n        else\n            M.FrameDirect(100, 100)\n        end\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle3_Safe1 then\n    if TimeSince(M.M12S.Timer) > 5000 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle3_End\n        d('本体3运结束')\n    else\n        local pos\n        if M.M12S.P3Info.enterBh == M.M12S.DataEnum.Right then\n            pos = { x = 90, z = 98 }\n        else\n            pos = { x = 110, z = 98 }\n        end\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\nself.used = true",
						conditions = 
						{
							
							{
								"643b092b-6dcd-1349-aef9-3181128bd9c2",
								true,
							},
							
							{
								"2df38143-7236-9686-9019-1a28d7e2908c",
								true,
							},
							
							{
								"cae75051-4219-56d4-b91e-94762de0b548",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "M12S本体3运主循环",
						uuid = "fa47c99b-5b27-dcc5-84ce-fc2c52de9242",
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
						uuid = "643b092b-6dcd-1349-aef9-3181128bd9c2",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S ~= nil",
						name = "M12S已初始化",
						uuid = "2df38143-7236-9686-9019-1a28d7e2908c",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle3_Start \n\tand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.Puzzle3_End",
						name = "3运中",
						uuid = "cae75051-4219-56d4-b91e-94762de0b548",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M12S本体3运主循环",
			uuid = "c3c28799-5cb7-1e41-ba63-0c1dc145c447",
			version = 2,
		},
		inheritedIndex = 27,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\nfor _, ent in pairs(TensorCore.entityList(\"contentid=14383\")) do\n    if Argus.isEntityVisible(ent) then\n        if M.M12S.P4CopyInfo.spawnType == nil then\n            local curEntAngle = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n            for i = 0, 7 do\n                local curAngle = i * math.pi / 4\n                if M.IsSameDirection(curAngle, curEntAngle) then\n                    if i % 2 == 0 then\n                        M.M12S.P4CopyInfo.spawnType = M.M12S.DataEnum.Puzzle4Char\n                        if M.Config.Main.M12SP4SendMacro then\n                            if M.Config.Main.M12SP4UpTime then\n                                SendTextCommand(\"/p 第一次分摊：双T去A，远程和奶去B，近战去1\")\n                                SendTextCommand(\"/p 第二次分摊：双T去4，远程和奶去3，近战去D\")\n                            else\n                                SendTextCommand(\"/p 第一次分摊：MT组去A，ST组去B\")\n                                SendTextCommand(\"/p 第二次分摊：MT组去4，ST组去3\")\n                            end\n\n                        end\n                        break\n                    elseif i % 2 == 1 then\n                        M.M12S.P4CopyInfo.spawnType = M.M12S.DataEnum.Puzzle4Number\n                        if M.Config.Main.M12SP4SendMacro then\n                            if M.Config.Main.M12SP4UpTime then\n                                SendTextCommand(\"/p 第一次分摊：双T去4，远程和奶去3，近战去D\")\n                                SendTextCommand(\"/p 第二次分摊：双T去A，远程和奶去B，近战去1\")\n                            else\n                                SendTextCommand(\"/p 第一次分摊：MT组去4，ST组去3\")\n                                SendTextCommand(\"/p 第二次分摊：MT组去A，ST组去B\")\n                            end\n                        end\n                        break\n                    end\n                end\n            end\n        end\n        if not table.contains(M.M12S.P4CopyInfo.ids, ent.id) then\n            table.insert(M.M12S.P4CopyInfo.ids, ent.id)\n        end\n    end\nend\nif M.M12S.P4CopyInfo.spawnType ~= nil and table.size(M.M12S.P4CopyInfo.ids) == 4 then\n    --进入到下一个状态\n    M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Spawn_Copy1\n    if M.M12S.P4CopyInfo.spawnType == M.M12S.DataEnum.Puzzle4Char then\n        if M.Config.Main.M12SP4UpTime then\n            if M.SelfPos == \"MT\" or M.SelfPos == \"ST\" then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 100, z = 84 } -- A\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 88.7, z = 88.7 } -- 4\n            elseif M.IsMelee(M.GetPlayer().job) then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 105.8, z = 94.2 } -- 1\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 91.9, z = 100 } -- D\n            else\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 116, z = 100 } -- B\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 88.7, z = 111.26 } -- 3\n            end\n        else\n            if table.contains({ \"MT\", \"H1\", \"D1\", \"D3\" }, M.SelfPos) then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 100, z = 84 } -- A\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 88.7, z = 88.7 } -- 4\n            else\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 116, z = 100 } -- B\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 88.7, z = 111.26 } -- 3\n            end\n        end\n    else\n        if M.Config.Main.M12SP4UpTime then\n            if M.SelfPos == \"MT\" or M.SelfPos == \"ST\" then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 88.7, z = 88.7 } -- 4\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 100, z = 84 } -- A\n            elseif M.IsMelee(M.GetPlayer().job) then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 91.9, z = 100 } -- D\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 105.8, z = 94.2 } -- 1\n            else\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 88.7, z = 111.26 } -- 3\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 116, z = 100 } -- B\n            end\n        else\n            if table.contains({ \"MT\", \"H1\", \"D1\", \"D3\" }, M.SelfPos) then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 88.7, z = 88.7 } -- 4\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 100, z = 84 } -- A\n            else\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 88.7, z = 111.26 } -- 3\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 116, z = 100 } -- B\n            end\n        end\n    end\nend\nself.used = true",
						conditions = 
						{
							
							{
								"fcdccc63-40b0-afa5-a8c4-261d687192bb",
								true,
							},
							
							{
								"17e7db00-ebfe-195e-b916-02c2a1b37dba",
								true,
							},
							
							{
								"19d1b924-5472-dc2a-ac83-8dedf60abad9",
								true,
							},
							
							{
								"9e22bcfb-aab9-f672-965f-874dea947434",
								true,
							},
							
							{
								"7d098a43-171d-8638-923f-3a68ef6bcf1e",
								true,
							},
						},
						gVar = "ACR_TensorRequiem3_CD",
						name = "Puzzle4_Start[DH]",
						uuid = "278da120-34ad-7653-8f54-24a90e3c98e4",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\nfor _, ent in pairs(TensorCore.entityList(\"contentid=14383\")) do\n    if Argus.isEntityVisible(ent) then\n        if M.M12S.P4CopyInfo.spawnType == nil then\n            local curEntAngle = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n            for i = 0, 7 do\n                local curAngle = i * math.pi / 4\n                if M.IsSameDirection(curAngle, curEntAngle) then\n                    if i % 2 == 0 then\n                        M.M12S.P4CopyInfo.spawnType = M.M12S.DataEnum.Puzzle4Char\n                        if M.Config.Main.M12SP4SendMacro then\n                            if M.Config.Main.M12SP4UpTime then\n                                SendTextCommand(\"/p —————正点分身—————\")\n                                SendTextCommand(\"/p 回溯1：双T去C，人群B，近战2\")\n                                SendTextCommand(\"/p 回溯2：双T去3，人群2，近战C\")\n                            else\n                                SendTextCommand(\"/p —————正点分身—————\")\n                                SendTextCommand(\"/p 回溯1：MT组C，ST组B\")\n                                SendTextCommand(\"/p 回溯2：MT组3，ST组2\")\n                            end\n                        end\n                        break\n                    elseif i % 2 == 1 then\n                        M.M12S.P4CopyInfo.spawnType = M.M12S.DataEnum.Puzzle4Number\n                        if M.Config.Main.M12SP4SendMacro then\n                            if M.Config.Main.M12SP4UpTime then\n                                SendTextCommand(\"/p —————斜点分身—————\")\n                                SendTextCommand(\"/p 回溯1：双T去3，人群2，近战C\")\n                                SendTextCommand(\"/p 回溯2：双T去C，人群B，近战3\")\n                            else\n                                SendTextCommand(\"/p —————斜点分身—————\")\n                                SendTextCommand(\"/p 回溯1：MT组3，ST组2\")\n                                SendTextCommand(\"/p 回溯2：MT组C，ST组B\")\n                            end\n\n                        end\n                        break\n                    end\n                end\n            end\n        end\n        if not table.contains(M.M12S.P4CopyInfo.ids, ent.id) then\n            table.insert(M.M12S.P4CopyInfo.ids, ent.id)\n        end\n    end\nend\nif M.M12S.P4CopyInfo.spawnType ~= nil and table.size(M.M12S.P4CopyInfo.ids) == 4 then\n    --进入到下一个状态\n    M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Spawn_Copy1\n    if M.M12S.P4CopyInfo.spawnType == M.M12S.DataEnum.Puzzle4Char then\n        if M.Config.Main.M12SP4UpTime then\n            if M.SelfPos == \"MT\" or M.SelfPos == \"ST\" then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 100, z = 116 } -- C\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 88.7, z = 111.3 } -- 3\n            elseif M.IsMelee(M.GetPlayer().job) then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 105.8, z = 105.8 } -- 2\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 100, z = 105.8 } -- C\n            else\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 116, z = 100 } -- B\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 111.3, z = 111.3 } -- 2\n            end\n        else\n            if table.contains({ \"MT\", \"H1\", \"D1\", \"D3\" }, M.SelfPos) then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 100, z = 116 } -- C\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 88.7, z = 111.3 } -- 3\n            else\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 116, z = 100 } -- B\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 111.3, z = 111.3 } -- 2\n            end\n        end\n    else\n        if M.Config.Main.M12SP4UpTime then\n            if M.SelfPos == \"MT\" or M.SelfPos == \"ST\" then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 88.7, z = 111.3 } -- 3\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 100, z = 116 } -- C\n            elseif M.IsMelee(M.GetPlayer().job) then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 100, z = 105.8 } -- C\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 105.8, z = 105.8 } -- 2\n            else\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 111.3, z = 111.3 } -- 2\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 116, z = 100 } -- B\n            end\n        else\n            if table.contains({ \"MT\", \"H1\", \"D1\", \"D3\" }, M.SelfPos) then\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 88.7, z = 111.3 } -- 3\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 100, z = 116 } -- C\n            else\n                M.M12S.P4CopyInfo.gatherPos1 = { x = 111.3, z = 111.3 } -- 2\n                M.M12S.P4CopyInfo.gatherPos2 = { x = 116, z = 100 } -- B\n            end\n        end\n    end\nend\nself.used = true",
						conditions = 
						{
							
							{
								"fcdccc63-40b0-afa5-a8c4-261d687192bb",
								true,
							},
							
							{
								"17e7db00-ebfe-195e-b916-02c2a1b37dba",
								true,
							},
							
							{
								"19d1b924-5472-dc2a-ac83-8dedf60abad9",
								true,
							},
							
							{
								"9e22bcfb-aab9-f672-965f-874dea947434",
								true,
							},
							
							{
								"94274971-9c24-92dd-a338-b29feb3a8698",
								true,
							},
						},
						gVar = "ACR_TensorRequiem3_CD",
						name = "Puzzle4_Start[NOCCHH]",
						uuid = "9d0cd8fd-2a56-c052-9ae0-6271fd1ff11e",
						version = 2.1,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Spawn_Copy1 then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=14383\")) do\n        if Argus.isEntityVisible(ent) then\n            if not table.contains(M.M12S.P4CopyInfo.ids, ent.id) then\n                table.insert(M.M12S.P4CopyInfo.ids, ent.id)\n            end\n        end\n    end\n    if table.size(M.M12S.P4CopyInfo.ids) == 8 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Spawn_Copy2\n        d(\"第二波复制体刷新完成\")\n    end\nend\n\n--- 连线阶段\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Spawn_Copy2 then\n    local tethers = Argus.getTethersOnEnt(M.GetPlayer().id)\n    if tethers ~= nil and table.size(tethers) > 0 then\n        for _, tether in pairs(tethers) do\n            if tether.type == 117 then\n                local partner = TensorCore.mGetEntity(tether.partnerid)\n                local targetPos = M.GetPointAtDistance({ x = 100, y = 0, z = 100 }, partner.pos, 6)\n                M.M12S.P4CopyInfo.linkPos = partner.pos\n                M.M12S.P4CopyInfo.guidePos = targetPos\n                M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_FirstLink\n                break\n            end\n        end\n    end\nend\nself.used = true",
						conditions = 
						{
							
							{
								"fcdccc63-40b0-afa5-a8c4-261d687192bb",
								true,
							},
							
							{
								"17e7db00-ebfe-195e-b916-02c2a1b37dba",
								true,
							},
							
							{
								"19d1b924-5472-dc2a-ac83-8dedf60abad9",
								true,
							},
							
							{
								"d6aa8c50-37b5-08f8-864c-ceb7b3065ba7",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "Puzzle4_Spawn_Copy12",
						uuid = "48e3b220-4855-d46f-bf43-7e4af55014e2",
						version = 2.1,
					},
					inheritedIndex = 3,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\n-- MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_SecondLink \nfor _, ent in pairs(TensorCore.entityList(\"contentid=14380\")) do\n    if Argus.isEntityVisible(ent) then\n        if not table.contains(M.M12S.P4CatchLineInfo.ids, ent.id) then\n            local tethers = Argus.getTethersOnEnt(ent.id)\n            for _, tether in pairs(tethers) do\n                if tether.type == 112 or tether.type == 113 then\n                    local curLinkMstInfo = {\n                        id = ent.id,\n                        pos = ent.pos,\n                        type = tether.type\n                    }\n                    for i = 1, 8 do\n                        local curDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n                        if M.IsSameDirection(math.pi * i / 4, curDir) then\n                            curLinkMstInfo.dirIdx = i\n                            break\n                        end\n                    end\n                    table.insert(M.M12S.P4CatchLineInfo.ids, ent.id)\n                    M.M12S.P4CatchLineInfo.entities[curLinkMstInfo.dirIdx] = curLinkMstInfo\n                    break\n                end\n            end\n        end\n    end\nend\nif table.size(M.M12S.P4CatchLineInfo.ids) == 8 then\n    if M.Config.Main.M12SP4SendMacro then\n        local EntA = M.M12S.P4CatchLineInfo.entities[4]\n        if EntA ~= nil then\n            if EntA.type == M.M12S.DataEnum.Gather then\n                SendTextCommand(\"/p 分摊-13出-分摊-24出\")\n            else\n                SendTextCommand(\"/p AC出-分摊-BD出-分摊\")\n            end\n        end\n    end\n    local fstIdx = 0\n    for i = 1, 8 do\n        local curDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, M.M12S.P4CopyInfo.linkPos)\n        if M.IsSameDirection(math.pi * i / 4, curDir) then\n            fstIdx = i\n            break\n        end\n    end\n    if fstIdx > 0 then\n        -- 计算分摊分散\n        -- 右下开始索引，C点为8\n        if table.contains({ 2, 4, 5, 7 }, fstIdx) then\n            --BA43\n            M.M12S.P4CatchLineInfo.type = M.M12S.DataEnum.Gather\n        else\n            M.M12S.P4CatchLineInfo.type = M.M12S.DataEnum.Disperse\n        end\n        local newIdx = 0\n        -- 计算当前应该\n        local backSub = M.M12S.P4CatchLineInfo.entities[fstIdx]\n        if backSub.type == M.M12S.P4CatchLineInfo.type then\n            M.M12S.P4CatchLineInfo.linkPos = backSub.pos\n            M.M12S.P4CatchLineInfo.linkId = backSub.id\n            newIdx = fstIdx\n        else\n            if fstIdx % 2 == 1 then\n                newIdx = fstIdx + 1\n            else\n                newIdx = fstIdx - 1\n            end\n            local otherSub = M.M12S.P4CatchLineInfo.entities[newIdx]\n            M.M12S.P4CatchLineInfo.linkPos = otherSub.pos\n            M.M12S.P4CatchLineInfo.linkId = otherSub.id\n        end\n        -- 计算左右分组\n        if newIdx <= 4 then\n            M.M12S.P4CatchLineInfo.group = M.M12S.DataEnum.Right\n            M.M12S.P4CatchLineInfo.putGatherPos = { x = 107, z = 93 }\n            M.M12S.P4CatchLineInfo.putDispersePos = { x = 111, z = 116 }\n        else\n            M.M12S.P4CatchLineInfo.group = M.M12S.DataEnum.Left\n            M.M12S.P4CatchLineInfo.putGatherPos = { x = 93, z = 93 }\n            M.M12S.P4CatchLineInfo.putDispersePos = { x = 89, z = 116 }\n        end\n        -- 计算点名爆炸顺序\n        if newIdx == 4 or newIdx == 8 then\n            M.M12S.P4CatchLineInfo.order = 1\n        elseif newIdx == 3 or newIdx == 7 then\n            M.M12S.P4CatchLineInfo.order = 2\n        elseif newIdx == 2 or newIdx == 6 then\n            M.M12S.P4CatchLineInfo.order = 3\n        elseif newIdx == 1 or newIdx == 5 then\n            M.M12S.P4CatchLineInfo.order = 4\n        end\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_CatchLink\n    end\nend\nself.used = true",
						conditions = 
						{
							
							{
								"fcdccc63-40b0-afa5-a8c4-261d687192bb",
								true,
							},
							
							{
								"17e7db00-ebfe-195e-b916-02c2a1b37dba",
								true,
							},
							
							{
								"19d1b924-5472-dc2a-ac83-8dedf60abad9",
								true,
							},
							
							{
								"7d098a43-171d-8638-923f-3a68ef6bcf1e",
								true,
							},
							
							{
								"4e9f6ff8-4254-ff8c-b919-145e5e33839e",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "Puzzle4_SecondLink[DH]",
						uuid = "6182d6bc-21c7-1413-b656-716edfb75146",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\n-- MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_SecondLink \nfor _, ent in pairs(TensorCore.entityList(\"contentid=14380\")) do\n    if Argus.isEntityVisible(ent) then\n        if not table.contains(M.M12S.P4CatchLineInfo.ids, ent.id) then\n            local tethers = Argus.getTethersOnEnt(ent.id)\n            for _, tether in pairs(tethers) do\n                if tether.type == 112 or tether.type == 113 then\n                    local curLinkMstInfo = {\n                        id = ent.id,\n                        pos = ent.pos,\n                        type = tether.type\n                    }\n                    for i = 1, 8 do\n                        local curDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n                        if M.IsSameDirection(math.pi * i / 4, curDir) then\n                            curLinkMstInfo.dirIdx = i\n                            break\n                        end\n                    end\n                    table.insert(M.M12S.P4CatchLineInfo.ids, ent.id)\n                    M.M12S.P4CatchLineInfo.entities[curLinkMstInfo.dirIdx] = curLinkMstInfo\n                    break\n                end\n            end\n        end\n    end\nend\nif table.size(M.M12S.P4CatchLineInfo.ids) == 8 then\n    if M.Config.Main.M12SP4SendMacro then\n        local EntA = M.M12S.P4CatchLineInfo.entities[4]\n        if EntA ~= nil then\n            if EntA.type == M.M12S.DataEnum.Gather then\n                SendTextCommand(\"/p 先分摊\")\n            else\n                SendTextCommand(\"/p 先分散\")\n            end\n        end\n    end\n    local linkIdx = 0\n    for i = 1, 8 do\n        local curDir = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, M.M12S.P4CopyInfo.linkPos)\n        if M.IsSameDirection(math.pi * i / 4, curDir) then\n            linkIdx = i\n            break\n        end\n    end\n    if linkIdx > 0 then\n        -- 计算分摊分散 \n        -- 右下开始索引，C点为8\n        if table.contains({ 1, 2, 7, 8 }, linkIdx) then\n            M.M12S.P4CatchLineInfo.type = M.M12S.DataEnum.Gather\n            -- 2B3C分摊\n            local newIdx = 0\n            -- 计算当前应该\n            local backSub = M.M12S.P4CatchLineInfo.entities[linkIdx]\n            if backSub.type == M.M12S.DataEnum.Gather then\n                M.M12S.P4CatchLineInfo.linkPos = backSub.pos\n                M.M12S.P4CatchLineInfo.linkId = backSub.id\n                newIdx = linkIdx\n            else\n                if linkIdx % 2 == 1 then\n                    newIdx = linkIdx + 1\n                else\n                    newIdx = linkIdx - 1\n                end\n                local otherSub = M.M12S.P4CatchLineInfo.entities[newIdx]\n                M.M12S.P4CatchLineInfo.linkPos = otherSub.pos\n                M.M12S.P4CatchLineInfo.linkId = otherSub.id\n                M.M12S.P4CatchLineInfo.linkIdx = newIdx\n            end\n        else\n            M.M12S.P4CatchLineInfo.type = M.M12S.DataEnum.Disperse\n            if M.M12S.P4CatchLineInfo.get2Link == nil then\n                M.M12S.P4CatchLineInfo.get2Link = function(p1, p2)\n                    if M.M12S.P4CatchLineInfo.entities[p1].type == M.M12S.DataEnum.Disperse then\n                        M.M12S.P4CatchLineInfo.linkPos = M.M12S.P4CatchLineInfo.entities[p1].pos\n                        M.M12S.P4CatchLineInfo.linkId = M.M12S.P4CatchLineInfo.entities[p1].id\n                        M.M12S.P4CatchLineInfo.linkIdx = p1\n                    elseif M.M12S.P4CatchLineInfo.entities[p2].type == M.M12S.DataEnum.Disperse then\n                        M.M12S.P4CatchLineInfo.linkPos = M.M12S.P4CatchLineInfo.entities[p2].pos\n                        M.M12S.P4CatchLineInfo.linkId = M.M12S.P4CatchLineInfo.entities[p2].id\n                        M.M12S.P4CatchLineInfo.linkIdx = p2\n                    end\n                end\n            end\n\n            if linkIdx == 4 then\n                -- A找1A中大圈\n                M.M12S.P4CatchLineInfo.SelfMark = M.HeadMark.Stop1\n                M.M12S.P4CatchLineInfo.get2Link(3, 4)\n            elseif linkIdx == 3 then\n                -- 1找2B中大圈\n                M.M12S.P4CatchLineInfo.SelfMark = M.HeadMark.Stop2\n                M.M12S.P4CatchLineInfo.get2Link(1, 2)\n            elseif linkIdx == 5 then\n                -- 4找4D中大圈\n                M.M12S.P4CatchLineInfo.SelfMark = M.HeadMark.Bind2\n                M.M12S.P4CatchLineInfo.get2Link(5, 6)\n            elseif linkIdx == 6 then\n                -- D找3C中大圈\n                M.M12S.P4CatchLineInfo.SelfMark = M.HeadMark.Bind1\n                M.M12S.P4CatchLineInfo.get2Link(7, 8)\n            end\n\n        end\n        local newIdx = M.M12S.P4CatchLineInfo.linkIdx\n        -- 计算点名爆炸顺序\n        if newIdx == 4 or newIdx == 8 then\n            M.M12S.P4CatchLineInfo.order = 1\n        elseif newIdx == 3 or newIdx == 7 then\n            M.M12S.P4CatchLineInfo.order = 2\n        elseif newIdx == 2 or newIdx == 6 then\n            M.M12S.P4CatchLineInfo.order = 3\n        elseif newIdx == 1 or newIdx == 5 then\n            M.M12S.P4CatchLineInfo.order = 4\n        end\n        -- 计算BC放置\n        if linkIdx <= 4 then\n            M.M12S.P4CatchLineInfo.putGatherPos = { x = 110, z = 100 }\n            M.M12S.P4CatchLineInfo.putDispersePos = { x = 100, z = 81 }\n        else\n            M.M12S.P4CatchLineInfo.putGatherPos = { x = 100, z = 110 }\n            M.M12S.P4CatchLineInfo.putDispersePos = { x = 81, z = 100 }\n        end\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_CatchLink\n    end\nend\nself.used = true\n",
						conditions = 
						{
							
							{
								"fcdccc63-40b0-afa5-a8c4-261d687192bb",
								true,
							},
							
							{
								"17e7db00-ebfe-195e-b916-02c2a1b37dba",
								true,
							},
							
							{
								"19d1b924-5472-dc2a-ac83-8dedf60abad9",
								true,
							},
							
							{
								"94274971-9c24-92dd-a338-b29feb3a8698",
								true,
							},
							
							{
								"4e9f6ff8-4254-ff8c-b919-145e5e33839e",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "Puzzle4_SecondLink[NOCCHH]",
						uuid = "9da36163-6014-569d-8eab-ec5898f8466a",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\n-- 如果连线对象不对，就一直指路\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_CatchLink then\n    -- 标记自身\n    if not IsDh\n            and M.M12S.P4CatchLineInfo.SelfMark ~= nil and M.M12S.P4CatchLineInfo.SelfMark > 0\n            and (M.GetPlayer().marker == nil or M.GetPlayer().marker == 0)\n    then\n        if M.M12S.P4CatchLineInfo.SelfMark == M.HeadMark.Stop1 then\n            SendTextCommand(\"/mk stop1 <me>\")\n        elseif M.M12S.P4CatchLineInfo.SelfMark == M.HeadMark.Stop1 then\n            SendTextCommand(\"/mk stop2 <me>\")\n        elseif M.M12S.P4CatchLineInfo.SelfMark == M.HeadMark.Bind1 then\n            SendTextCommand(\"/mk bind1 <me>\")\n        elseif M.M12S.P4CatchLineInfo.SelfMark == M.HeadMark.Bind2 then\n            SendTextCommand(\"/mk bind2 <me>\")\n        end\n    end\n    local changeState = false\n    for _, player in pairs(M.Party) do\n        local tethers = Argus.getTethersOnEnt(player.id)\n        if table.size(tethers) > 0 then\n            for _, tether in pairs(tethers) do\n                if tether.type == M.M12S.DataEnum.LinkFinal then\n                    M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_CatchEnd\n                    M.M12S.Timer = Now()\n                    changeState = true\n                    break\n                end\n            end\n        end\n    end\n    if not changeState then\n        local tethers = Argus.getTethersOnEnt(M.GetPlayer().id)\n        local isTargetRight = false\n        if tethers ~= nil and table.size(tethers) > 0 then\n            for _, tether in pairs(tethers) do\n                if tether.type == M.M12S.P4CatchLineInfo.type and tether.partnerid == M.M12S.P4CatchLineInfo.linkId then\n                    isTargetRight = true\n                    break\n                end\n            end\n        end\n        if not isTargetRight then\n            MuAiGuide.FrameDirect(M.M12S.P4CatchLineInfo.linkPos.x, M.M12S.P4CatchLineInfo.linkPos.z)\n        end\n    end\nend\n\n-- 分散\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_CatchEnd then\n    if TimeSince(M.M12S.Timer) > 4500 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Div1\n        M.M12S.Timer = Now()\n    else\n        if M.M12S.P4Sub3Info.GuidePos1 == nil then\n            if M.M12S.P4Sub3Info.SkillType == M.M12S.DataEnum.UpDownSkillA then\n                local p4 = { x = 93, y = 0, z = 93 }\n                local p1 = { x = 107, y = 0, z = 93 }\n                local to4 = TensorCore.getDistance2d(M.GetPlayer().pos, p4)\n                local to1 = TensorCore.getDistance2d(M.GetPlayer().pos, p1)\n                if to4 > to1 then\n                    M.M12S.P4Sub3Info.GuidePos1 = p1\n                else\n                    M.M12S.P4Sub3Info.GuidePos1 = p4\n                end\n            else\n                local pL = { x = 89, y = 0, z = 103 }\n                local pR = { x = 111, y = 0, z = 103 }\n                local toR = TensorCore.getDistance2d(M.GetPlayer().pos, pR)\n                local toL = TensorCore.getDistance2d(M.GetPlayer().pos, pL)\n                if toR > toL then\n                    M.M12S.P4Sub3Info.GuidePos1 = pL\n                else\n                    M.M12S.P4Sub3Info.GuidePos1 = pR\n                end\n            end\n        else\n            MuAiGuide.FrameDirect(M.M12S.P4Sub3Info.GuidePos1.x, M.M12S.P4Sub3Info.GuidePos1.z)\n        end\n    end\nend\nself.used = true",
						conditions = 
						{
							
							{
								"fcdccc63-40b0-afa5-a8c4-261d687192bb",
								true,
							},
							
							{
								"17e7db00-ebfe-195e-b916-02c2a1b37dba",
								true,
							},
							
							{
								"19d1b924-5472-dc2a-ac83-8dedf60abad9",
								true,
							},
							
							{
								"feaf20ec-a836-48ec-8d87-1989a615466e",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "Puzzle4_Catch",
						uuid = "72765f9f-5844-d6d2-859d-2faba3fedb69",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\n\n-- 小世界1\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Div1 then\n    if TimeSince(M.M12S.Timer) > 4000 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Tower1\n        M.M12S.Timer = Now()\n    else\n        if table.contains({ \"MT\", \"D1\", \"H1\", \"D3\" }, M.SelfPos) then\n            MuAiGuide.FrameDirect(95, 100)\n        else\n            MuAiGuide.FrameDirect(105, 100)\n        end\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Tower1 then\n    if M.M12S.P4TowerData.towerIds == nil then\n        M.M12S.P4TowerData.towerIds = {}\n        M.M12S.P4TowerData.towers = {}\n    end\n    if table.size(M.M12S.P4TowerData.towerIds) < 8 then\n        for i = 3, 6 do\n            for _, ent in pairs(TensorCore.entityList(\"contentid=201501\" .. tostring(i))) do\n                if ent.pos.x > 100 then\n                    if ent.pos.x > 115 then\n                        if ent.pos.z > 100 then\n                            M.M12S.P4TowerData.towers[\"H2\"] = ent\n                        else\n                            M.M12S.P4TowerData.towers[\"D4\"] = ent\n                        end\n                    else\n                        if ent.pos.z > 100 then\n                            M.M12S.P4TowerData.towers[\"ST\"] = ent\n                        else\n                            M.M12S.P4TowerData.towers[\"D2\"] = ent\n                        end\n                    end\n                else\n                    if ent.pos.x > 85 then\n                        if ent.pos.z > 100 then\n                            M.M12S.P4TowerData.towers[\"D1\"] = ent\n                        else\n                            M.M12S.P4TowerData.towers[\"MT\"] = ent\n                        end\n                    else\n                        if ent.pos.z > 100 then\n                            M.M12S.P4TowerData.towers[\"D3\"] = ent\n                        else\n                            M.M12S.P4TowerData.towers[\"H1\"] = ent\n                        end\n                    end\n                end\n                table.insert(M.M12S.P4TowerData.towerIds, ent.id)\n            end\n        end\n    end\n    if table.size(M.M12S.P4TowerData.towerIds) == 8 then\n        if (M.M12S.P4TowerData.Self == nil or M.M12S.P4TowerData.Partner == nil) then\n            M.M12S.P4TowerData.Self = M.M12S.P4TowerData.towers[M.SelfPos]\n            M.M12S.P4TowerData.Partner = M.M12S.P4TowerData.towers[M.GetRMPartner()]\n        else\n            local selfBuff = TensorCore.getBuff(M.GetPlayer().id, 4164)\n            local targetBuff = TensorCore.getBuff(M.Party[M.GetRMPartner()].id, 4164)\n            if selfBuff ~= nil then\n                if M.M12S.P4TowerData.Self.contentid == 2015013 or M.M12S.P4TowerData.Self.contentid == 2015014 then\n                    local temp = M.M12S.P4TowerData.Self\n                    M.M12S.P4TowerData.Self = M.M12S.P4TowerData.Partner\n                    M.M12S.P4TowerData.Partner = temp\n                end\n                M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_GetBuff\n            elseif targetBuff ~= nil then\n                if M.M12S.P4TowerData.Partner.contentid == 2015013 or M.M12S.P4TowerData.Partner.contentid == 2015014 then\n                    local temp = M.M12S.P4TowerData.Self\n                    M.M12S.P4TowerData.Self = M.M12S.P4TowerData.Partner\n                    M.M12S.P4TowerData.Partner = temp\n                end\n                M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_GetBuff\n            else\n                M.FrameDirect(M.M12S.P4TowerData.Self.pos.x, M.M12S.P4TowerData.Self.pos.z)\n            end\n        end\n    end\nend\n\n--- 如果仍然处在连线阶段中\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_GetBuff then\n    M.FrameDirect(M.M12S.P4TowerData.Self.pos.x, M.M12S.P4TowerData.Self.pos.z)\nend\n\nself.used = true",
						conditions = 
						{
							
							{
								"fcdccc63-40b0-afa5-a8c4-261d687192bb",
								true,
							},
							
							{
								"17e7db00-ebfe-195e-b916-02c2a1b37dba",
								true,
							},
							
							{
								"19d1b924-5472-dc2a-ac83-8dedf60abad9",
								true,
							},
							
							{
								"c68062f3-50dd-d220-a621-f4c1317887d7",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "Puzzle4_Tower",
						uuid = "0b3a60e1-d4bf-587b-ba05-de3843ec4a62",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_ThirdLink then\n    if M.M12S.StateChangeByBuff(2941) then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Put1\n        M.M12STimer = Now()\n    else\n        if M.M12S.P4CatchLineInfo.order == 1 and M.M12S.P4CatchLineInfo.type == M.M12S.DataEnum.Disperse then\n            pos = M.M12S.P4CatchLineInfo.putDispersePos\n        else\n            pos = M.M12S.P4CatchLineInfo.putGatherPos\n        end\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\n-- 分摊/分散2\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Put1 then\n    if M.M12S.StateChangeByBuff(2941) and TimeSince(M.M12STimer) > 3000 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Put2\n        M.M12STimer = Now()\n    else\n        if M.M12S.P4CatchLineInfo.order == 2 and M.M12S.P4CatchLineInfo.type == M.M12S.DataEnum.Disperse then\n            pos = M.M12S.P4CatchLineInfo.putDispersePos\n        else\n            pos = M.M12S.P4CatchLineInfo.putGatherPos\n        end\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\n-- 分摊/分散3\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Put2 then\n    if M.M12S.StateChangeByBuff(2941) and TimeSince(M.M12STimer) > 3000 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_Put3\n        M.M12STimer = Now()\n    else\n        if M.M12S.P4CatchLineInfo.order == 3 and M.M12S.P4CatchLineInfo.type == M.M12S.DataEnum.Disperse then\n            pos = M.M12S.P4CatchLineInfo.putDispersePos\n        else\n            pos = M.M12S.P4CatchLineInfo.putGatherPos\n        end\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\n-- 分摊/分散4\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Put3 then\n    if M.M12S.StateChangeByBuff(2941) and TimeSince(M.M12STimer) > 3000 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_PutEnd\n        M.M12STimer = Now()\n    else\n        if M.M12S.P4CatchLineInfo.order == 4 and M.M12S.P4CatchLineInfo.type == M.M12S.DataEnum.Disperse then\n            pos = M.M12S.P4CatchLineInfo.putDispersePos\n        else\n            pos = M.M12S.P4CatchLineInfo.putGatherPos\n        end\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_PutEnd then\n    local pos\n    if table.contains({ \"MT\", \"H1\", \"D1\", \"D3\" }, M.SelfPos) then\n        pos = { x = 90, z = 100 }\n    else\n        pos = { x = 110, z = 100 }\n    end\n    M.FrameDirect(pos.x, pos.z)\nend\nself.used = true",
						conditions = 
						{
							
							{
								"fcdccc63-40b0-afa5-a8c4-261d687192bb",
								true,
							},
							
							{
								"17e7db00-ebfe-195e-b916-02c2a1b37dba",
								true,
							},
							
							{
								"19d1b924-5472-dc2a-ac83-8dedf60abad9",
								true,
							},
							
							{
								"ef66843c-c2f6-9711-80cb-1fa3f12be91f",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "Pazzle4_GatherAndDisperse",
						uuid = "96f8e4a8-5da9-2bc9-bc28-12a87ecb4a5f",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\nM.M12S.P4TowerData.guidePos = nil\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Tower2 then\n    local selfTower = M.M12S.P4TowerData.Self\n    if M.M12S.P4TowerData.guidePos == nil then\n        if selfTower.contentid == 2015016 then\n            -- 火 \n            M.M12S.P4TowerData.guidePos = selfTower.pos\n        elseif selfTower.contentid == 2015013 then\n            -- 风\n            if selfTower.pos.x > 100 then\n                M.M12S.P4TowerData.guidePos = { x = selfTower.pos.x - 2.7, z = selfTower.pos.z }\n            else\n                M.M12S.P4TowerData.guidePos = { x = selfTower.pos.x + 2.7, z = selfTower.pos.z }\n            end\n        elseif selfTower.contentid == 2015014 then\n            -- 暗\n            if selfTower.pos.z > 100 then\n                M.M12S.P4TowerData.guidePos = { x = selfTower.pos.x, z = selfTower.pos.z + 2 }\n            else\n                M.M12S.P4TowerData.guidePos = { x = selfTower.pos.x, z = selfTower.pos.z - 2 }\n            end\n        elseif selfTower.contentid == 2015015 then\n            -- 土\n            M.M12S.P4TowerData.guidePos = selfTower.pos\n        end\n    end\n    local stateChange = M.M12S.StateChangeByBuff(4765)\n    if stateChange then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_TowerEnd\n        M.M12S.Timer = Now()\n    else\n        local size\n        if selfTower.contentid == 2015013 then\n            size = 0.3\n        else\n            size = 0.5\n        end\n        M.FrameDirect(M.M12S.P4TowerData.guidePos.x, M.M12S.P4TowerData.guidePos.z, size)\n    end\nend\n\n-- 踩塔后\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_TowerEnd then\n    if M.M12S.P4TowerData.Self.contentid == 2015013 then\n        -- 风等落地\n        if TimeSince(M.M12S.Timer) > 1000 and M.GetPlayer().pos.y < 0.01 then\n            M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_TowerFarNear\n        end\n    else\n        if M.M12S.P4TowerData.Self.contentid == 2015015 then\n            --土，先移动等待\n            if M.M12S.P4TowerData.Self.pos.z > 100 then\n                M.FrameDirect(M.M12S.P4TowerData.Self.pos.x, M.M12S.P4TowerData.Self.pos.z - 5)\n            else\n                M.FrameDirect(M.M12S.P4TowerData.Self.pos.x, M.M12S.P4TowerData.Self.pos.z + 5)\n            end\n        end\n        if TimeSince(M.M12S.Timer) > 1500 then\n            local anyoneHasFire = false\n            for _, player in pairs(M.Party) do\n                local debuff = TensorCore.getBuff(player.id, 4768)\n                if debuff ~= nil and debuff.duration >= 0 then\n                    anyoneHasFire = true\n                    break\n                end\n            end\n            if not anyoneHasFire then\n                M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_TowerFarNear\n            end\n        end\n    end\nend\n\n-- 远近扇形\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_TowerFarNear then\n    local changeState = true\n    for _, player in pairs(M.Party) do\n        local debuff = TensorCore.getBuff(player.id, 4765)\n        if debuff ~= nil and debuff.duration >= 0 then\n            changeState = false\n            break\n        end\n    end\n    if changeState then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_div2Subs\n    else\n        local player = M.GetPlayer()\n        if TensorCore.getBuff(player.id, 4767) then\n            --近\n            if player.pos.x > 100 then\n                M.FrameDirect(106, 100)\n            else\n                M.FrameDirect(94, 100)\n            end\n        elseif TensorCore.getBuff(player.id, 4766) then\n            -- 远\n            if player.pos.x > 100 then\n                M.FrameDirect(107, 93)\n            else\n                M.FrameDirect(93, 106)\n            end\n        else\n            if table.contains({ \"MT\", \"ST\", \"D1\", \"D2\" }, M.SelfPos) then\n                if M.M12S.P4NearTargetId == nil then\n                    for _, ent in pairs(M.Party) do\n                        local debuff = TensorCore.getBuff(ent.id, 4767)\n                        if debuff ~= nil then\n                            if player.pos.x > 100 and ent.pos.x > 100\n                                    or player.pos.x < 100 and ent.pos.x < 100\n                            then\n                                M.M12S.P4NearTargetId = ent.id\n                                break\n                            end\n                        end\n                    end\n                else\n                    local heading\n                    local curTarget = TensorCore.mGetEntity(M.M12S.P4NearTargetId)\n                    if curTarget.pos.x > 100 then\n                        heading = math.pi / 2\n                    else\n                        heading = math.pi * 3 / 2\n                    end\n                    local targetPos = TensorCore.getPosInDirection(curTarget.pos, heading, 1)\n                    M.FrameDirect(targetPos.x, targetPos.z, 0.3)\n                end\n            else\n                if player.pos.x > 100 then\n                    M.FrameDirect(117, 109)\n                else\n                    M.FrameDirect(83, 91)\n                end\n            end\n        end\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_div2End then\n    if M.M12S.StateChangeByBuff(2941) then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_CopyBoom1\n        M.M12S.Timer = Now()\n    else\n        local pos = M.M12S.P4CopyInfo.gatherPos1\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\nif M.Config.Main.M12SExDraw and M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_TowerFarNear then\n    for i, ent in pairs(M.Party) do\n        local near = TensorCore.getBuff(ent.id, 4767)\n        local far = TensorCore.getBuff(ent.id, 4766)\n        if near ~= nil then\n            local from = TensorCore.mGetEntity(ent.id)\n            local dis, targetPos\n            for _, player in pairs(M.Party) do\n                if player.id ~= from.id then\n                    local entPos = TensorCore.mGetEntity(player.id).pos\n                    local curDis = TensorCore.getDistance2d(entPos, from.pos)\n                    if dis == nil or curDis < dis then\n                        dis = curDis\n                        targetPos = entPos\n                    end\n                end\n            end\n            if targetPos ~= nil then\n                local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.1), 1)\n                local heading = TensorCore.getHeadingToTarget(from.pos, targetPos)\n                drawer:addCone(from.pos.x, from.pos.y, from.pos.z, 20, math.pi / 8, heading, true)\n            end\n        elseif far ~= nil then\n            local from = TensorCore.mGetEntity(ent.id)\n            local dis, targetPos\n            for _, player in pairs(M.Party) do\n                if player.id ~= from.id then\n                    local entPos = TensorCore.mGetEntity(player.id).pos\n                    local curDis = TensorCore.getDistance2d(entPos, from.pos)\n                    if dis == nil or curDis > dis then\n                        dis = curDis\n                        targetPos = entPos\n                    end\n                end\n            end\n            if targetPos ~= nil then\n                local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.1), 1)\n                local heading = TensorCore.getHeadingToTarget(from.pos, targetPos)\n                drawer:addCone(from.pos.x, from.pos.y, from.pos.z, 40, math.pi / 8, heading, true)\n            end\n        end\n    end\nend\n\nif M.Config.Main.M12SExDraw and M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_Tower2 then\n    if M.M12S.P4TowerData.Earth == nil then\n        M.M12S.P4TowerData.Earth = {}\n        for _, ent in pairs(TensorCore.entityList(\"contentid=2015015\")) do\n            table.insert(M.M12S.P4TowerData.Earth, ent)\n        end\n    end\n    if M.M12S.P4TowerData.Self.contentid == 2015013 then\n        local from = M.M12S.P4TowerData.Self\n        local player = M.GetPlayer()\n        local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.2), 1)\n        local heading = TensorCore.getHeadingToTarget(from.pos, player.pos)\n        drawer:addArrow(player.pos.x, player.pos.y, player.pos.z, heading, 21.6, 0.2, 0.4, 0.2, true)\n    end\n    for _, ent in pairs(TensorCore.entityList(\"contentid=2015014\")) do\n        -- 暗\n        local dis = 10000\n        local lockPlayer\n        for _, player in pairs(M.Party) do\n            local curPlayer = TensorCore.mGetEntity(player.id)\n            local disPT = TensorCore.getDistance2d(ent.pos, curPlayer.pos)\n            if disPT <= 4 and disPT < dis then\n                dis = disPT\n                lockPlayer = curPlayer\n            end\n        end\n        if lockPlayer ~= nil then\n            local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(1, 0, 1, 0.1), 1)\n            local heading = TensorCore.getHeadingToTarget(ent.pos, lockPlayer.pos)\n            drawer:addRect(ent.pos.x, ent.pos.y, ent.pos.z, 40, 5, heading, true)\n        end\n    end\nend\n\nif M.Config.Main.M12SExDraw and M.M12S.CurrentState >= M.M12S.StateEnum.Puzzle4_TowerEnd \n        and M.M12S.CurrentState <= M.M12S.StateEnum.Puzzle4_TowerFarNear then\n    local anyoneHasFire = false\n    for _, player in pairs(M.Party) do\n        local debuff = TensorCore.getBuff(player.id, 4768)\n        if debuff ~= nil and debuff.duration >= 0 then\n            anyoneHasFire = true\n            break\n        end\n    end\n    if anyoneHasFire then\n        for _, ent in pairs(M.M12S.P4TowerData.Earth) do\n            local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.1), 1)\n            drawer:addCircle(ent.pos.x, ent.pos.y, ent.pos.z, 4, true)\n        end\n    end\nend\n\nself.used = true",
						conditions = 
						{
							
							{
								"fcdccc63-40b0-afa5-a8c4-261d687192bb",
								true,
							},
							
							{
								"17e7db00-ebfe-195e-b916-02c2a1b37dba",
								true,
							},
							
							{
								"19d1b924-5472-dc2a-ac83-8dedf60abad9",
								true,
							},
							
							{
								"4580abe1-c776-1e96-817c-4bd71e4d90b3",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "Puzzle4_TowerFarNear",
						uuid = "f22b8751-c7ba-b61a-bdaf-d76ef591f545",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_CopyBoom1 then\n    if M.M12S.P4Sub3Info.GuidePos2 == nil then\n        local to1 = TensorCore.getDistance2d(M.M12S.P4Sub3Info.divGuidePos1, M.GetPlayer().pos)\n        local to2 = TensorCore.getDistance2d(M.M12S.P4Sub3Info.divGuidePos2, M.GetPlayer().pos)\n        if to1 < to2 then\n            M.M12S.P4Sub3Info.GuidePos2 = M.M12S.P4Sub3Info.divGuidePos1\n        else\n            M.M12S.P4Sub3Info.GuidePos2 = M.M12S.P4Sub3Info.divGuidePos2\n        end\n    end\n    if TimeSince(M.M12S.Timer) > 14000 then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_div3End\n    else\n        local pos = M.M12S.P4Sub3Info.GuidePos2\n        M.FrameDirect(pos.x, pos.z)\n    end\n\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_div3End then\n    if M.M12S.StateChangeByBuff(2941) then\n        M.M12S.CurrentState = M.M12S.StateEnum.Puzzle4_CopyBoom2\n    else\n        local pos = M.M12S.P4CopyInfo.gatherPos2\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\nif M.M12S.CurrentState == M.M12S.StateEnum.Puzzle4_CopyBoom2 then\n    if M.M12S.P4Sub3Info.GuidePos3 == nil then\n        if M.M12S.P4Sub3Info.teleport == M.M12S.DataEnum.UpDown then\n            local p4 = { x = 93, y = 0, z = 93 }\n            local p1 = { x = 107, y = 0, z = 93 }\n            local to4 = TensorCore.getDistance2d(M.GetPlayer().pos, p4)\n            local to1 = TensorCore.getDistance2d(M.GetPlayer().pos, p1)\n            if to4 > to1 then\n                M.M12S.P4Sub3Info.GuidePos3 = p1\n            else\n                M.M12S.P4Sub3Info.GuidePos3 = p4\n            end\n        else\n            M.M12S.P4Sub3Info.GuidePos3 = { x = 100, y = 0, z = 100 }\n        end\n    else\n        local pos = M.M12S.P4Sub3Info.GuidePos3\n        M.FrameDirect(pos.x, pos.z)\n    end\nend\n\nself.used = true",
						conditions = 
						{
							
							{
								"fcdccc63-40b0-afa5-a8c4-261d687192bb",
								true,
							},
							
							{
								"17e7db00-ebfe-195e-b916-02c2a1b37dba",
								true,
							},
							
							{
								"19d1b924-5472-dc2a-ac83-8dedf60abad9",
								true,
							},
							
							{
								"c0373e9e-51bc-58b5-b882-a9fb84d11e96",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "Puzzle4_CopyBoom",
						uuid = "103176b5-da2e-88e3-9e4e-35c8191fee7b",
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
						uuid = "fcdccc63-40b0-afa5-a8c4-261d687192bb",
						version = 2,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S ~= nil",
						name = "M12S已初始化",
						uuid = "17e7db00-ebfe-195e-b916-02c2a1b37dba",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle4_Start\n\t\tand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.PuzzleEnd_Start",
						name = "四运中",
						uuid = "19d1b924-5472-dc2a-ac83-8dedf60abad9",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.Config.Main.M12SP4Type == 1 ",
						name = "盗火改",
						uuid = "7d098a43-171d-8638-923f-3a68ef6bcf1e",
						version = 2,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.Config.Main.M12SP4Type == 2",
						name = "NOCCHH",
						uuid = "94274971-9c24-92dd-a338-b29feb3a8698",
						version = 2,
					},
					inheritedIndex = 4,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_Start",
						name = "Puzzle4_Start",
						uuid = "9e22bcfb-aab9-f672-965f-874dea947434",
						version = 2,
					},
					inheritedIndex = 3,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle4_Spawn_Copy1\n\t\tand MuAiGuide.M12S.CurrentState <= MuAiGuide.M12S.StateEnum.Puzzle4_Spawn_Copy2",
						name = "Puzzle4_Spawn_Copy12",
						uuid = "d6aa8c50-37b5-08f8-864c-ceb7b3065ba7",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_SecondLink ",
						name = "Puzzle4_SecondLink",
						uuid = "4e9f6ff8-4254-ff8c-b919-145e5e33839e",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle4_CatchLink\n\t\tand MuAiGuide.M12S.CurrentState <= MuAiGuide.M12S.StateEnum.Puzzle4_CatchEnd",
						name = "Puzzle4_Catch",
						uuid = "feaf20ec-a836-48ec-8d87-1989a615466e",
						version = 2,
					},
					inheritedIndex = 8,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle4_Div1\n\t\tand MuAiGuide.M12S.CurrentState <= MuAiGuide.M12S.StateEnum.Puzzle4_GetBuff",
						name = "Puzzle4_Tower",
						uuid = "c68062f3-50dd-d220-a621-f4c1317887d7",
						version = 2,
					},
					inheritedIndex = 8,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle4_ThirdLink\n\t\tand MuAiGuide.M12S.CurrentState <= MuAiGuide.M12S.StateEnum.Puzzle4_PutEnd",
						name = "Pazzle4_GatherAndDisperse",
						uuid = "ef66843c-c2f6-9711-80cb-1fa3f12be91f",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle4_Tower2\n\t\tand MuAiGuide.M12S.CurrentState <= MuAiGuide.M12S.StateEnum.Puzzle4_div2End",
						name = "Puzzle4_TowerFarNear",
						uuid = "4580abe1-c776-1e96-817c-4bd71e4d90b3",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle4_CopyBoom1\n\t\tand MuAiGuide.M12S.CurrentState <= MuAiGuide.M12S.StateEnum.Puzzle4_CopyBoom2",
						name = "Puzzle4_CopyBoom",
						uuid = "c0373e9e-51bc-58b5-b882-a9fb84d11e96",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M12S本体4运主循环",
			uuid = "cf3ae25c-c974-dd93-a124-4473c49119b2",
			version = 2,
		},
		inheritedIndex = 26,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle1_Start\nd(\"进入本体1运\")\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"7ec312d0-ad27-3bf4-ac11-2b30bf0b5fe3",
								true,
							},
							
							{
								"7a4b47c7-510c-5862-a9ef-dc0293959aea",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "1运-开始",
						uuid = "e168ce13-a389-cf0e-bb57-985f14698f22",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if eventArgs.spellID == 46299 then\n    MuAiGuide.M12S.P1Info.ConeType = 46299  -- 横着打\n    d(\"小怪横着打\")\nelseif eventArgs.spellID == 46298 then\n    MuAiGuide.M12S.P1Info.ConeType = 46298  -- 竖着打\n    d(\"小怪竖着打\")\nend\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"04e4bb3c-98d6-addf-bcfb-4d30d420d13e",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "1运-小怪数据采集",
						uuid = "d0a5806e-5591-a173-acb1-c4bfcc973adb",
						version = 2.1,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle2_Start\nd(\"进入本体2运\")\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"39f3cd87-37cb-3eae-9e6e-415d95e85520",
								true,
							},
							
							{
								"cd0dbd88-0d6f-cfa1-98f9-613b884421fe",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "2运-开始",
						uuid = "20198ade-90b0-f178-a7a3-7cb7b0817df8",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle2_GoBack\nd(\"2运-去背后\")\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"35996a0e-8662-0fbd-81aa-d030e1b9acc5",
								true,
							},
							
							{
								"5847d181-1366-9931-a862-06a1ef589bc7",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "2运-去背后",
						uuid = "028d08fd-342a-0d95-9de8-e2e9288e81a3",
						version = 2.1,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "--MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle2_TimeBack\nd(\"2运-时空重现开始\")\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"34e5f095-9ef2-afd4-9210-f9ab4dc43479",
								true,
							},
							
							{
								"d9a58f74-d8eb-86aa-a352-851e164300bf",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "2运-时空重现开始",
						uuid = "b05a709f-b7da-f3df-9abb-60f1aefed93e",
						version = 2.1,
					},
					inheritedIndex = 3,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle3_Start\nd(\"进入本体3运\")\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"f5583e56-8a63-9e1d-aa39-3ca87b4d69ad",
								true,
							},
							
							{
								"79a9055f-5583-68ff-8901-ef735903b8f5",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "3运-开始",
						uuid = "ac4aaa86-96bb-1aa4-9675-0599a6f399a8",
						version = 2.1,
					},
					inheritedIndex = 4,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.P3Info.channelTime = Now()\nd(\"魔力球换边倒计时开始！\")\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"7071da13-f101-8fdc-95a5-0b1d2be31986",
								true,
							},
							
							{
								"bd43953e-af48-47f5-8174-6b611a3e0068",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "3运-魔力球苏醒开始计时",
						uuid = "508efe8f-6db3-50f2-8f3f-75e41017a985",
						version = 2.1,
					},
					inheritedIndex = 5,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local M = MuAiGuide\nlocal boss = TensorCore.mGetEntity(M.M12S.CurrentBoss.id)\nlocal headPos = TensorCore.getPosInDirection(boss.pos, boss.pos.h, 9)\nif M.M12S.CurrentState < M.M12S.StateEnum.Puzzle3_End then\n    M.M12S.CurrentState = M.M12S.StateEnum.Puzzle3_End\n    d('本体3运结束')\nend\nif eventArgs.spellID == 46380 then\n    -- 远分摊\n    if TensorCore.getBuff(M.GetPlayer().id, 4771) then\n        M.DirectTo(headPos.x, headPos.z, 5000)\n    elseif TensorCore.getBuff(M.GetPlayer().id, 4769) then\n        M.DirectTo(boss.pos.x, boss.pos.z, 5000)\n    end\n\td('本体3运-远分摊')\nelseif eventArgs.spellID == 46379 then\n    -- 近分摊\n    if TensorCore.getBuff(M.GetPlayer().id, 4771) then\n        M.DirectTo(boss.pos.x, boss.pos.z, 5000)\n    elseif TensorCore.getBuff(M.GetPlayer().id, 4769) then\n        M.DirectTo(headPos.x, headPos.z, 5000)\n    end\n\td('本体3运-近分摊')\nend\nself.used = true",
						conditions = 
						{
							
							{
								"a760f3a5-f5c3-243b-b15e-34d8b4d3b36c",
								true,
							},
							
							{
								"330e3571-b675-71c2-a8f6-882826ce2a73",
								true,
							},
						},
						gVar = "ACR_RikuMNK3_CD",
						name = "3运-阴界远近",
						uuid = "a48d46e3-cab9-d016-bb0d-60e8af1fa74b",
						version = 2.1,
					},
					inheritedIndex = 7,
				},
				
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
						gVar = "ACR_TensorViper3_CD",
						name = "4运-开始",
						uuid = "4dc29bbe-3a6a-0c9c-a66e-24b1414f6e2d",
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
						gVar = "ACR_TensorViper3_CD",
						name = "4运-小世界上下or左右刀",
						uuid = "c7fb0a3c-f564-435f-b537-9076cf358bc0",
						version = 2.1,
					},
					inheritedIndex = 9,
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
						name = "4运-上下刀小怪位置采集",
						uuid = "8a4f6557-87e7-9029-a22e-5289e266af18",
						version = 2.1,
					},
					inheritedIndex = 5,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.PuzzleEnd_Start\nd(\"四运结束\")\nif MuAiGuide.Config.Main.M12SP4Type ~= nil and MuAiGuide.Config.Main.M12SP4Type == 2 then\n\tfor i = 1,14 do\n\t\tSendTextCommand(\"/mk clear <\"..i..\">\")\n\tend\nend\nself.used = true",
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
						gVar = "ACR_TensorViper3_CD",
						name = "4运-结束",
						uuid = "cc2167a1-328d-a365-8a4d-342ecaf2a03a",
						version = 2.1,
					},
					inheritedIndex = 6,
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
						name = "46345-镜中奇梦",
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
						eventArgType = 2,
						eventSpellID = 46305,
						name = "46305-模仿细胞",
						uuid = "cd0dbd88-0d6f-cfa1-98f9-613b884421fe",
						version = 2,
					},
					inheritedIndex = 6,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 46375,
						name = "46375-蛇踢",
						uuid = "5847d181-1366-9931-a862-06a1ef589bc7",
						version = 2,
					},
					inheritedIndex = 6,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventEntityID = 46316,
						eventSpellID = 46316,
						name = "46316-时空重现",
						uuid = "34e5f095-9ef2-afd4-9210-f9ab4dc43479",
						version = 2,
					},
					inheritedIndex = 7,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 46341,
						name = "46341-变异细胞",
						uuid = "79a9055f-5583-68ff-8901-ef735903b8f5",
						version = 2,
					},
					inheritedIndex = 8,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 46336,
						name = "46336-魔力球苏醒",
						uuid = "bd43953e-af48-47f5-8174-6b611a3e0068",
						version = 2,
					},
					inheritedIndex = 9,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 46296,
						name = "46296-自我复制",
						uuid = "7ec312d0-ad27-3bf4-ac11-2b30bf0b5fe3",
						version = 2,
					},
					inheritedIndex = 10,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgOptionType = 3,
						eventArgType = 2,
						name = "46379-46380-阴界远近",
						spellIDList = 
						{
							46380,
							46379,
						},
						uuid = "330e3571-b675-71c2-a8f6-882826ce2a73",
						version = 2,
					},
					inheritedIndex = 11,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.Puzzle1_Start",
						name = "没到1运",
						uuid = "7a4b47c7-510c-5862-a9ef-dc0293959aea",
						version = 2,
					},
					inheritedIndex = 11,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.Puzzle2_Start",
						name = "没到2运",
						uuid = "39f3cd87-37cb-3eae-9e6e-415d95e85520",
						version = 2,
					},
					inheritedIndex = 8,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.Puzzle3_Start  \n",
						name = "没到3运",
						uuid = "f5583e56-8a63-9e1d-aa39-3ca87b4d69ad",
						version = 2,
					},
					inheritedIndex = 10,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.Puzzle4_Start\n",
						name = "没到4运",
						uuid = "f8f3a749-3db0-a083-a884-8f131db08476",
						version = 2,
					},
					inheritedIndex = 6,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState <= MuAiGuide.M12S.StateEnum.Puzzle1_GotBuff",
						name = "1运-没有拿到",
						uuid = "04e4bb3c-98d6-addf-bcfb-4d30d420d13e",
						version = 2,
					},
					inheritedIndex = 16,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgOptionType = 3,
						eventArgType = 2,
						eventSpellID = 46303,
						name = "1运小怪读条",
						spellIDList = 
						{
							46303,
							46301,
							46299,
							46298,
						},
						uuid = "bf03dd86-0f76-964c-83d1-f6a6ff17585a",
						version = 2,
					},
					inheritedIndex = 17,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle2_Put2",
						name = "2运-第二次处理",
						uuid = "35996a0e-8662-0fbd-81aa-d030e1b9acc5",
						version = 2,
					},
					inheritedIndex = 10,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle2_GoBackEnd",
						name = "2运-背后结束",
						uuid = "d9a58f74-d8eb-86aa-a352-851e164300bf",
						version = 2,
					},
					inheritedIndex = 11,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState >= MuAiGuide.M12S.StateEnum.Puzzle3_Start \nand MuAiGuide.M12S.CurrentState < MuAiGuide.M12S.StateEnum.Puzzle3_End \nand (MuAiGuide.M12S.P3Info.channelTime == nil or MuAiGuide.M12S.P3Info.channelTime <= 0)",
						name = "3运-魔力球苏醒未计时",
						uuid = "7071da13-f101-8fdc-95a5-0b1d2be31986",
						version = 2,
					},
					inheritedIndex = 15,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgOptionType = 3,
						eventArgType = 2,
						name = "4运-小世界上下or左右刀",
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
						name = "4运-获取小怪上下刀阶段",
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
						name = "4运-小世界观察小怪阶段",
						uuid = "3631adb4-7ecb-8c12-99c5-971de14cb24a",
						version = 2,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle4_CopyBoom2 ",
						name = "4运-最后一次炸大圈结束",
						uuid = "5cd9a6f2-9e64-75ea-bb0d-26353272d646",
						version = 2,
					},
					inheritedIndex = 24,
				},
			},
			eventType = 3,
			name = "M12S本体阶段切换[开始读条]",
			uuid = "b48d47b0-28c9-0e72-82e7-abf66b902646",
			version = 2,
		},
		inheritedIndex = 27,
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "--MuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle2_GoBackEnd\nMuAiGuide.M12S.CurrentState = MuAiGuide.M12S.StateEnum.Puzzle2_TimeBack\nMuAiGuide.M12S.Timer = Now()\nd(\"去背后结束\")\nself.used = true",
						conditions = 
						{
							
							{
								"10a41e61-6525-6b14-91c5-b7bc3c7d7f40",
								true,
							},
							
							{
								"1a9129a5-b23b-9778-bfdb-46102db2e043",
								true,
							},
							
							{
								"41b76115-9081-65aa-82fd-f2683ea34860",
								true,
							},
						},
						gVar = "ACR_TensorViper3_CD",
						name = "2运-背后结束",
						uuid = "2a3d0f3d-189f-e32f-87a0-cad7ce2263c0",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
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
						name = "4运-停止1线，开始观察小怪",
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
						name = "4运-第1次小世界结束",
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
						gVar = "ACR_TensorViper3_CD",
						name = "4运-第2次小世界开始",
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
						gVar = "ACR_TensorViper3_CD",
						name = "4运-第2次小世界结束",
						uuid = "0ae1e6fc-db43-fa87-80d2-fcf1e407f6ab",
						version = 2.1,
					},
					inheritedIndex = 4,
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
						category = "Event",
						eventArgType = 2,
						eventSpellID = 46375,
						name = "46375-蛇踢",
						uuid = "1a9129a5-b23b-9778-bfdb-46102db2e043",
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
					inheritedIndex = 3,
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S.CurrentState == MuAiGuide.M12S.StateEnum.Puzzle2_GoBack",
						name = "2运-去背后",
						uuid = "41b76115-9081-65aa-82fd-f2683ea34860",
						version = 2,
					},
					inheritedIndex = 4,
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
			},
			eventType = 2,
			name = "M12S本体切换阶段[读条后]",
			uuid = "021a9e74-9ec4-8881-beb5-cb1621c7a609",
			version = 2,
		},
		inheritedIndex = 28,
	},
	
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
							
							{
								"47395bfe-d1be-33fb-ab6b-31893d391866",
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
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MuAiGuide.M12S ~= nil",
						name = "M12S已初始化",
						uuid = "47395bfe-d1be-33fb-ab6b-31893d391866",
						version = 2,
					},
					inheritedIndex = 2,
				},
			},
			eventType = 12,
			name = "FrameDebug",
			uuid = "83898426-1459-2294-b52d-fbafeb6d698e",
			version = 2,
		},
		inheritedIndex = 27,
	}, 
	inheritedProfiles = 
	{
	},
}



return tbl