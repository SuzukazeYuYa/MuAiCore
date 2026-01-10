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
						actionLua = "local redDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0)),\n        (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 1)),\n        2\n)\nif MuAiGuide.M11SMapType == nil or MuAiGuide.M11SMapType == 0 then\n\tredDrawer:addRect(100, 0, 80, 40, 40, 0, true)\t\nelse\n\tredDrawer:addRect(84, 0, 80, 40, 20, 0, true)\n\tredDrawer:addRect(116, 0, 80, 40, 20, 0, true)\nend\nself.used = true",
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
						uuid = "befcb967-2841-45e2-b927-f551c47c3b6c",
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
						category = "Self",
						conditionType = 8,
						localmapid = 1325,
						uuid = "0e493990-e4ec-e1b4-aaf9-fb78fd408a55",
						version = 2,
					},
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
					inheritedIndex = 3,
				},
			},
			eventType = 2,
			name = "M11S地图切换",
			uuid = "e260ac90-04cd-d071-866c-f30f070327c0",
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
						actionLua = "local drawTime = 40000\n\nAnyoneCore.addTimedWorldText(drawTime , \"H1\", {x = 85, y = 0 ,z =  115}, \nGUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 1)\n\nAnyoneCore.addTimedWorldText(drawTime , \"H2/D2\", {x = 105, y = 0 ,z =  95}, \nGUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 1)\n\n\nAnyoneCore.addTimedWorldText(drawTime , \"D3\", {x = 90, y = 0 ,z =  110}, \nGUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 1)\n\nAnyoneCore.addTimedWorldText(drawTime , \"D4\", {x = 105, y = 0 ,z =  105}, \nGUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 1)\n\nAnyoneCore.addTimedWorldText(drawTime , \"D1\", {x = 95, y = 0 ,z =  105}, \nGUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 1)\n\nself.used = true",
						conditions = 
						{
							
							{
								"089e6374-6111-897d-8af0-fcd0c72e28ac",
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
			},
			eventType = 2,
			name = "M11S第一次陨石位置",
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
						actionLua = "local drawTime = 3000\nlocal posLabel = { \"MT\", \"D4\", \"H2\", \"D2\", \"ST\", \"D1\", \"H1\", \"D3\" }\n\nif data.MuAiM11S_Sickle_Data == nil then\n    data.MuAiM11S_Sickle_Data = {}\nend\n\nfunction drawPos(ent)\n    local heading = ent.pos.h\n    for i = 0, 7 do\n        local pos = TensorCore.getPosInDirection(ent.pos, heading - i * math.pi / 4, 4)\n        AnyoneCore.addTimedWorldText(drawTime, posLabel[i + 1], pos, GUI:ColorConvertFloat4ToU32(1, 1, 1, 1), true, 0.8)\n    end\n    -- 更新时间戳\n    data.MuAiM11S_Sickle_Data[ent.id] = {\n        pos = ent.pos,\n        time = Now()\n    }\nend\n\nlocal entList = TensorCore.entityList(\"contentid=108\") or {}\nfor _, ent in pairs(entList) do\n    if Argus.getEntityModel(ent.id) == 19185 and Argus.isEntityVisible(ent) then\n        local dataCache = data.MuAiM11S_Sickle_Data[ent.id]\n\n        if dataCache == nil then\n            drawPos(ent)  -- 首次绘制\n        else\n            local distance = TensorCore.getDistance2d(ent.pos, dataCache.pos)\n            local timeSinceDraw = Now() - dataCache.time\n            local isTimeOut = timeSinceDraw > drawTime - 50\n\n            if distance > 0.5 or isTimeOut then\n                drawPos(ent)  -- 位置变化或超时重新绘制\n            end\n        end\n    end\nend\n\nself.used = true",
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
						actionLua = "local tethers = Argus.getTethersOnEnt(TensorCore.mGetPlayer().id)\nlocal linkFrom = nil\nfor _, tether in pairs(tethers) do\n    if tether.type == 57 or tether.type == 249 then\n        linkFrom = TensorCore.mGetEntity(tether.partnerid)\n    end\nend\n\nif linkFrom ~= nil then\n    local targetPos = nil\n    if linkFrom.pos.x < 100 then\n        if linkFrom.pos.z < 100 then\n            targetPos = { x = 116, z = 120 }\n        else\n            targetPos = { x = 116, z = 80 }\n        end\n    else\n        if linkFrom.pos.z < 100 then\n            targetPos = { x = 84, z = 120 }\n        else\n            targetPos = { x = 84, z = 80 }\n        end\n    end\n    local drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5), 1)\n    local heading = TensorCore.getHeadingToTarget(linkFrom.pos, targetPos)\n    drawer:addArrow(linkFrom.pos.x, 0, linkFrom.pos.z, heading, 60, 1, 1, 1,  false)\n    drawer:addArrow(linkFrom.pos.x, 0, linkFrom.pos.z, heading, 60, 0.03, 1, 1, true)\nend\nself.used = true ",
						conditions = 
						{
							
							{
								"2fbd9c0f-e39c-a512-9798-2586a5646898",
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
						conditionLua = "    if MuAiGuide.M11SMapType ~= 1 then\n        return false\n    end\n\n    local tethers = Argus.getTethersOnEnt(TensorCore.mGetPlayer().id)\n    if tethers == nil or table.size(tethers) <= 0 then\n        return false\n    end\n    for _, tether in pairs(tethers) do\n        if tether.type == 57 or tether.type == 249 then\n            return true\n        end\n    end\n    return false",
						uuid = "2fbd9c0f-e39c-a512-9798-2586a5646898",
						version = 2,
					},
				},
			},
			eventType = 12,
			name = "M11STether",
			uuid = "41a903f9-67f1-06ad-8924-d2be901e0268",
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
						actionLua = "MuAiGuide.M11SMapType = 0\nself.used = true",
						conditions = 
						{
							
							{
								"4b9a2018-ece0-c270-bec7-fb5391d04788",
								true,
							},
						},
						gVar = "ACR_RikuNIN3_CD",
						uuid = "7146ecb6-aca1-f8af-bb52-47f650b8af72",
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
						uuid = "4b9a2018-ece0-c270-bec7-fb5391d04788",
						version = 2,
					},
				},
			},
			eventType = 9,
			name = "OnWipe[团灭]",
			uuid = "b610ef51-6410-2e2c-8cd0-fff9d16334a8",
			version = 2,
		},
		inheritedIndex = 9,
	}, 
	inheritedProfiles = 
	{
	},
}



return tbl