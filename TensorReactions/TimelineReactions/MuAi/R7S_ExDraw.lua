local tbl = 
{
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
							actionLua = "--local boss = TensorCore.mGetEntity(eventArgs.entityID)\nlocal boss\nfor _, ent in pairs(TensorCore.entityList(\"contentid=13756\")) do\n    if Argus.isEntityVisible(ent) then\n        boss = ent\n        break\n    end\nend\nfor i = 1, 8 do\n    local pos\n    local curH = boss.pos.h + math.pi + math.pi / 4 * (i - 1)\n    pos = TensorCore.getPosInDirection(boss.pos, curH, 8)\n    local color\n    if i == 1 or i == 5 then\n        color = { r = 0, g = 0, b = 1 }\n    elseif i == 3 or i == 7 then\n        color = { r = 0, g = 1, b = 0 }\n    else\n        color = { r = 1, g = 0, b = 0 }\n    end\n    local rDrawer = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0.4)),\n            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0.4)),\n            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0.4)),\n            (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n            2\n    )\n    rDrawer:addCircle(pos.x, pos.y, pos.z, 0.5, true)\nend\nself.used = true",
							gVar = "ACR_TensorViper3_CD",
							uuid = "2dc5bfe4-55b2-c67d-8c12-340a9111958a",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 129.3,
				name = "[MuAi]面基BOSS8方",
				timeRange = true,
				timelineIndex = 31,
				timerEndOffset = 5,
				timerOffset = 0.5,
				timerStartOffset = -8,
				uuid = "2725a92e-a776-626b-be34-a242e20871c1",
				version = 2,
			},
		},
	},
	[55] = 
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
							actionLua = "local drawTime = 15000\nlocal drawPos\ndrawPos = {\n    { x = 88, y = 0, z = -19.5 },\n    { x = 88, y = 0, z = 5 },\n    { x = 112, y = 0, z = -19.5},\n    { x = 112, y = 0, z = 29.5 },\n    { x = 112, y = 0, z = 5 },\n    { x = 88, y = 0, z = 29.5 },\n}\n\nlocal mid1 =\n{\n    { x = 103.5, y = 0, z = -16 },\n    { x = 96.5, y = 0, z = -16 },\n    { x = 103.5, y = 0, z = 1.5 },\n    { x = 103.5, y = 0, z = 26 },\n    { x = 92.5, y = 0, z = 19 },\n\n}\n\nlocal mid2 =\n{\n    { x = 96.5, y = 0, z = 26.0 },\n    { x = 103.5, y = 0, z = 26.0 },\n    { x = 96.5, y = 0, z = 8.5 },\n    { x = 96.5, y = 0, z = -16.0 },\n    { x = 107.5, y = 0, z = -9.0 }\n}\n\nlocal gDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n        2\n)\n\nlocal rDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n        2\n)\nfor i, pos in pairs(drawPos) do\n    gDrawer:addTimedCircle(drawTime, pos.x, pos.y, pos.z, 0.5, 0, true)\nend\n\nlocal boss\nfor _, ent in pairs(TensorCore.entityList(\"contentid=13756\")) do\n    if Argus.isEntityVisible(ent) then\n        boss = ent\n        break\n    end\nend\n\nif boss ~= nil then\n    local curTable \n    if boss.pos.y < 0 then\n        curTable = mid1\n    else\n        curTable = mid2\n    end\n    for _, pos in pairs(curTable) do\n        rDrawer:addTimedCircle(drawTime, pos.x, pos.y, pos.z, 0.5, 0, true)\n    end\nend\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							uuid = "e4d9a267-c092-3f04-b436-6318002cc854",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 288.1,
				name = "[MuAi]P2 冰花参考位置",
				timelineIndex = 55,
				timerOffset = -4,
				uuid = "15268aa4-16fa-8739-a06f-b6a59e6dd81c",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "local drawTime =65000\nlocal drawPos = {\n\t-- in red \n    { x = 82.5, y = -200, z = -12.5 },\n    { x = 117.5, y = -200, z = -12.5  },\n    { x = 117.5, y = -200, z = 22.5 },\n    { x = 82.5, y = -200, z = 22.5 },\n\t-- mid red\n    { x = 100, y = -200, z = -5 },\n    { x = 110, y = -200, z = 5 },\n    { x = 100, y = -200, z = 15 },\n\t{ x = 90, y = -200, z = 5 },\n\t -- out green\n\t{ x = 100, y = -200, z = -12.5 },\n    { x = 117.5, y = -200, z = 5 },\n    { x = 100, y = -200, z = 22.5 },\n    { x = 82.5, y = -200, z =  5}\n}\nlocal gDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n        2\n)\n\nlocal rDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n        2\n)\nfor i, pos in pairs(drawPos) do\n    if i > 8 then\n        gDrawer:addTimedCircle(drawTime, pos.x, pos.y, pos.z, 0.5, 0, true)\n    else\n        rDrawer:addTimedCircle(drawTime, pos.x, pos.y, pos.z, 0.5, 0, true)\n    end\nend\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							uuid = "e4d9a267-c092-3f04-b436-6318002cc854",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 481.6,
				name = "draw pos2",
				timelineIndex = 90,
				timerOffset = -4,
				uuid = "280d7704-4201-3f10-996e-04f8c203a746",
				version = 2,
			},
		},
	},
	[93] = 
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
							actionLua = "local drawTime = 75000\nlocal drawPos = {\n    -- range green\n    { x = 100, y = -200, z = -12.5 },\n    { x = 117.5, y = -200, z = 5 },\n    { x = 100, y = -200, z = 22.5 },\n    { x = 82.5, y = -200, z =  5},\n    -- melee red mlm \n    { x = 82.5, y = -200, z = -12.5 },\n    { x = 117.5, y = -200, z = -12.5 },\n    { x = 117.5, y = -200, z = 22.5 },\n    { x = 82.5, y = -200, z = 22.5 },\n    -- melee red jp\n    { x = 100, y = -200, z = -5 },\n    { x = 110, y = -200, z = 5 },\n    { x = 100, y = -200, z = 15 },\n    { x = 90, y = -200, z =  5},\n\n}\nlocal gDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n        2\n)\n\nlocal rDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n        2\n)\nfor i, pos in pairs(drawPos) do\n    if i <= 4 then\n        gDrawer:addTimedCircle(drawTime, pos.x, pos.y, pos.z, 0.5, 0, true)\n    else\n        rDrawer:addTimedCircle(drawTime, pos.x, pos.y, pos.z, 0.5, 0, true)\n    end\nend\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							uuid = "e4d9a267-c092-3f04-b436-6318002cc854",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 492.3,
				name = "draw pos2",
				timelineIndex = 93,
				timerOffset = -10,
				uuid = "b215117c-c1d9-48f3-8e2b-9df353626d05",
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
							actionLua = "local drawTime = 65000\nlocal drawPos = {\n\t-- in red \n    { x = 90, y = -200, z = -5 },\n    { x = 110, y = -200, z = -5 },\n    { x = 110, y = -200, z = 15 },\n    { x = 90, y = -200, z = 15 },\n\t -- out green\n\t{ x = 100, y = -200, z = -12.5 },\n    { x = 117.5, y = -200, z = 5 },\n    { x = 100, y = -200, z = 22.5 },\n    { x = 82.5, y = -200, z =  5}\n}\nlocal gDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n        2\n)\n\nlocal rDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 0, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n        2\n)\nfor i, pos in pairs(drawPos) do\n    if i > 4 then\n        gDrawer:addTimedCircle(drawTime, pos.x, pos.y, pos.z, 0.5, 0, true)\n    else\n        rDrawer:addTimedCircle(drawTime, pos.x, pos.y, pos.z, 0.5, 0, true)\n    end\nend\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							uuid = "e4d9a267-c092-3f04-b436-6318002cc854",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 529.8,
				name = "draw pos2",
				timelineIndex = 100,
				timerOffset = -4,
				uuid = "ff0199f4-9365-3ca9-9891-d82609b52b6f",
				version = 2,
			},
		},
	},
	[107] = 
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
							actionLua = "--local boss = TensorCore.mGetEntity(eventArgs.entityID)\nlocal boss\nfor _, ent in pairs(TensorCore.entityList(\"contentid=13756\")) do\n    if Argus.isEntityVisible(ent) then\n        boss = ent\n        break\n    end\nend\nfor i = 1, 8 do\n    local pos\n    local curH = boss.pos.h + math.pi + math.pi / 4 * (i - 1)\n    pos = TensorCore.getPosInDirection(boss.pos, curH, 8)\n    local color\n    if i == 1 or i == 5 then\n        color = { r = 0, g = 0, b = 1 }\n    elseif i == 3 or i == 7 then\n        color = { r = 0, g = 1, b = 0 }\n    else\n        color = { r = 1, g = 0, b = 0 }\n    end\n    local rDrawer = Argus2.ShapeDrawer:new(\n            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0.4)),\n            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0.4)),\n            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0.4)),\n            (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n            2\n    )\n    rDrawer:addCircle(pos.x, pos.y, pos.z, 0.5, true)\nend\nself.used = true",
							gVar = "ACR_TensorViper3_CD",
							uuid = "2dc5bfe4-55b2-c67d-8c12-340a9111958a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 543.7,
				name = "[MuAi]面基BOSS8方",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 107,
				timerEndOffset = 5,
				timerOffset = -1,
				timerStartOffset = -8,
				uuid = "f6ebe14c-56d6-f394-aad7-aacc175ec266",
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
							aType = "Lua",
							actionLua = "local drawTime = 40000\nlocal drawPos = {\n\t-- in red \n    { x = 90, y = -200, z = -5 },\n    { x = 110, y = -200, z = -5 },\n    { x = 110, y = -200, z = 15 },\n    { x = 90, y = -200, z = 15 },\n\t\n}\nlocal gDrawer = Argus2.ShapeDrawer:new(\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(0, 1, 0, 0.5)),\n        (GUI:ColorConvertFloat4ToU32(1, 1, 1, 1)),\n        2\n)\n\nfor i, pos in pairs(drawPos) do\n    gDrawer:addTimedCircle(drawTime, pos.x, pos.y, pos.z, 0.5, 0, true)\nend\nself.used = true",
							gVar = "ACR_RikuNIN3_CD",
							uuid = "e4d9a267-c092-3f04-b436-6318002cc854",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 579.6,
				name = "draw pos3",
				timelineIndex = 111,
				timerOffset = -5,
				uuid = "20a3a682-9f7f-f2f7-9e8c-e3956969c17c",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	mapID = 1261,
	version = 2,
}



return tbl