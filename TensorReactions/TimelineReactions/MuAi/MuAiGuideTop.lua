local tbl = 
{
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
							aType = "Lua",
							actionLua = "data.TopJobOrder = {}\ndata.TopJobOrder[MuAiGuide.Party.H1.job] = 1\ndata.TopJobOrder[MuAiGuide.Party.MT.job] = 2\ndata.TopJobOrder[MuAiGuide.Party.ST.job] = 3\ndata.TopJobOrder[MuAiGuide.Party.D1.job] = 4\ndata.TopJobOrder[MuAiGuide.Party.D2.job] = 5\ndata.TopJobOrder[MuAiGuide.Party.D3.job] = 6\ndata.TopJobOrder[MuAiGuide.Party.D4.job] = 7\ndata.TopJobOrder[MuAiGuide.Party.H2.job] = 8\n\n-- 玩家自身\ndata.player = MuAiGuide.GetPlayer()\n-- 自己位置\ndata.selfJobPos = data.TopJobOrder[data.player.job]\n\ndata.DrawAllPos = false\n\nself.used = true\n",
							gVar = "ACR_RikuMNK2_CD",
							uuid = "bdd2bbc8-bd74-06ee-825b-d7a7a91e5f14",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 15,
				name = "初始化",
				timelineIndex = 3,
				timerOffset = -3,
				uuid = "1d3d535e-cd2c-9650-a3b0-33b0169dd71a",
				version = 2,
			},
		},
	},
	[36] = 
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
							actionLua = "data.p2myPSmarker = 416\nself.used = true",
							conditions = 
							{
								
								{
									"054de9f0-2326-51dd-99a8-a00728a42a82",
									true,
								},
								
								{
									"ce2ecaa5-0c60-9c0c-bde2-6c2a9857b47c",
									true,
								},
							},
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "d0c85201-3beb-5e54-ae53-55c92f5d32a6",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p2myPSmarker = 417\nself.used = true",
							conditions = 
							{
								
								{
									"054de9f0-2326-51dd-99a8-a00728a42a82",
									true,
								},
								
								{
									"e3034989-d7ba-45d4-a9c2-b19efe20979d",
									true,
								},
							},
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "bfafcfb3-2d27-c4ef-be43-43ea40b44afc",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p2myPSmarker = 418\nself.used = true",
							conditions = 
							{
								
								{
									"054de9f0-2326-51dd-99a8-a00728a42a82",
									true,
								},
								
								{
									"95beee45-17c9-1f9e-a660-ddc1a8c5279c",
									true,
								},
							},
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "ea8df9bd-bf7c-e53c-8dc1-bb6f9513594b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p2myPSmarker = 419\nself.used = true",
							conditions = 
							{
								
								{
									"054de9f0-2326-51dd-99a8-a00728a42a82",
									true,
								},
								
								{
									"b16e6e28-28a0-5b45-b660-2d37d2a6932c",
									true,
								},
							},
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "8ee5335d-bfce-52f2-adaf-101bb80b22da",
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
							conditionLua = "return eventArgs.entityID == TensorCore.mGetPlayer().id",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							uuid = "054de9f0-2326-51dd-99a8-a00728a42a82",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return eventArgs.entityID == TensorCore.mGetPlayer().id",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 416,
							uuid = "ce2ecaa5-0c60-9c0c-bde2-6c2a9857b47c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return eventArgs.entityID == TensorCore.mGetPlayer().id",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 417,
							uuid = "e3034989-d7ba-45d4-a9c2-b19efe20979d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return eventArgs.entityID == TensorCore.mGetPlayer().id",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 418,
							uuid = "95beee45-17c9-1f9e-a660-ddc1a8c5279c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							conditionLua = "return eventArgs.entityID == TensorCore.mGetPlayer().id",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventMarkerID = 419,
							uuid = "b16e6e28-28a0-5b45-b660-2d37d2a6932c",
							version = 2,
						},
					},
				},
				eventType = 4,
				mechanicTime = 233.9,
				name = "P2_分散指路_获取标记信息",
				timeRange = true,
				timelineIndex = 36,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "90bad858-effb-86a9-ac69-93cf039027e1",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local p = TensorCore.mGetPlayer()\nlocal tethers = Argus.getTethersOnEnt(p.id)\n\nif (table.valid(tethers)) then\n    for _, tether in pairs(tethers) do\n        if (tether.type == 222) then\n            local partner = TensorCore.mGetEntity(tether.partnerid)\n            if (partner ~= nil) then\n                if p.marker ~= nil and partner.marker ~= nil and  p.marker ~= 0 and partner.marker ~= 0 then                   \n                    if partner.marker < p.marker then\n                        data.p2partysynergygroup = \"right\"\n                    else\n                        data.p2partysynergygroup = \"left\"\n                    end\n                else\n\t\t\t\t\td(partner.job)\n                    if data.TopJobOrder[p.job] > data.TopJobOrder[partner.job] then\n                        data.p2partysynergygroup = \"right\"\n                    else\n                        data.p2partysynergygroup = \"left\"\n                    end\n                end\n            end\n            break\n        end\n    end\nend\nd(data.p2partysynergygroup)\nself.used = true",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "6a13ad82-98cf-a865-a6ae-f1de44c525bf",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 233.9,
				name = "P2_分散指路_判断左右",
				timeRange = true,
				timelineIndex = 36,
				timerEndOffset = 10,
				timerStartOffset = 2.2000000476837,
				uuid = "e06ec460-d8f5-e433-8acc-48e983509505",
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
							actionLua = "local drawTime = 13000\nif (data.partyIDsByName == nil) then\n    data.partyIDsByName = {}\n    for _, ent in pairs(TensorCore.getEntityGroupList(\"Party\")) do\n        data.partyIDsByName[ent.name] = ent.id\n    end\nend\n\nlocal p = TensorCore.mGetPlayer()\nlocal drawer = TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5), 2)\n-- 找到眼睛\nlocal eyePos\nfor _, ent in pairs(TensorCore.entityList(\"contentid=7640\")) do\n    drawer:addTimedArrowOnEnt(drawTime, p.id, 1, 0.5, 1, 1, ent.id, 0, true)\n    eyePos = ent.pos\n    break\nend\n\nlocal midglitch = TensorCore.hasBuff(p, 3427)\nlocal eye2centerH = TensorCore.getHeadingToTarget(eyePos, { x = 100, y = 0, z = 100 })\nlocal g1Positions, g2Positions = {}, {}\nlocal c1Positions, c2Positions = {}, {}\nif midglitch then\n    local eyeleftPos = TensorCore.getPosInDirection(eyePos, eye2centerH + math.pi / 2, 10.5)\n    local eyerightPos = TensorCore.getPosInDirection(eyePos, eye2centerH - math.pi / 2, 10.5)\n    local eyeleftPos1 = TensorCore.getPosInDirection(eyePos, eye2centerH + math.pi / 2, 10.5)\n    local eyerightPos1 = TensorCore.getPosInDirection(eyePos, eye2centerH - math.pi / 2, 10.5)\n    for i = 1, 4 do\n        table.insert(g2Positions, TensorCore.getPosInDirection(eyeleftPos, eye2centerH, 20 + i * 10))\n        table.insert(c2Positions, TensorCore.getPosInDirection(eyeleftPos1, eye2centerH, 20 + i * 10))\n        table.insert(g1Positions, TensorCore.getPosInDirection(eyerightPos, eye2centerH, 20 + i * 10))\n        table.insert(c1Positions, TensorCore.getPosInDirection(eyerightPos1, eye2centerH, 20 + i * 10))\n    end\nelse\n    for i = 1, 4 do\n        local lcurH = (eye2centerH + math.pi) + 30 / 180 * math.pi + (i - 1) * 41 / 180 * math.pi\n        local rcurH = (eye2centerH + math.pi) - 30 / 180 * math.pi - (i - 1) * 41 / 180 * math.pi\n        table.insert(g1Positions, TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, lcurH, 19.5))\n        table.insert(g2Positions, TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, rcurH, 19.5))\n        table.insert(c1Positions, TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, lcurH, 19.5))\n        table.insert(c2Positions, TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, rcurH, 19.5))\n    end\nend\n\nif data.DrawAllPos then\n    -- 绘制左分散点\n    MuAiGuide.DrawCircleFloor(c1Positions[1].x, c1Positions[1].z, drawTime, 1.3, 255, 0, 0)\n    MuAiGuide.DrawCircleFloor(c1Positions[2].x, c1Positions[2].z, drawTime, 1.3, 0, 0, 255)\n    MuAiGuide.DrawCircleFloor(c1Positions[3].x, c1Positions[3].z, drawTime, 1.3, 0, 255, 0)\n    MuAiGuide.DrawCircleFloor(c1Positions[4].x, c1Positions[4].z, drawTime, 1.3, 255, 0, 255)\n    -- 绘制右侧分散点\n    if midglitch then\n        MuAiGuide.DrawCircleFloor(c2Positions[1].x, c2Positions[1].z, drawTime, 1.3, 255, 0, 0)\n        MuAiGuide.DrawCircleFloor(c2Positions[2].x, c2Positions[2].z, drawTime, 1.3, 0, 0, 255)\n        MuAiGuide.DrawCircleFloor(c2Positions[3].x, c2Positions[3].z, drawTime, 1.3, 0, 255, 0)\n        MuAiGuide.DrawCircleFloor(c2Positions[4].x, c2Positions[4].z, drawTime, 1.3, 255, 0, 255)\n    else\n        MuAiGuide.DrawCircleFloor(c2Positions[4].x, c2Positions[4].z, drawTime, 1.3, 255, 0, 0)\n        MuAiGuide.DrawCircleFloor(c2Positions[3].x, c2Positions[3].z, drawTime, 1.3, 0, 0, 255)\n        MuAiGuide.DrawCircleFloor(c2Positions[2].x, c2Positions[2].z, drawTime, 1.3, 0, 255, 0)\n        MuAiGuide.DrawCircleFloor(c2Positions[1].x, c2Positions[1].z, drawTime, 1.3, 255, 0, 255)\n    end\nend\n\nlocal map  = { [416] = 1, [419] = 2, [417] = 3, [418] = 4 }\nlocal map2 = { [416] = 4, [419] = 3, [417] = 2, [418] = 1, }\nlocal myPos\nif data.p2partysynergygroup == \"left\" then\n    myPos = g1Positions[map[data.p2myPSmarker]];\nend\nif data.p2partysynergygroup == \"right\" then\n    if midglitch then\n        myPos = g2Positions[map[data.p2myPSmarker]];\n    else\n        myPos = g2Positions[map2[data.p2myPSmarker]];\n    end\nend\nMuAiGuide.DirectTo(myPos.x, myPos.z, drawTime)\nself.used = true\n",
							conditions = 
							{
								
								{
									"7429e95a-0f20-1a01-8eaa-5bcb7bc26525",
									true,
								},
							},
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "141fd41f-3734-9ab1-aea3-3df3b70ffb07",
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
							buffCheckType = 4,
							buffIDList = 
							{
								3427,
								3428,
							},
							category = "Self",
							matchAnyBuff = true,
							uuid = "7429e95a-0f20-1a01-8eaa-5bcb7bc26525",
							version = 2,
						},
					},
				},
				mechanicTime = 233.9,
				name = "P2_分散指路",
				timeRange = true,
				timelineIndex = 36,
				timerEndOffset = 20,
				timerStartOffset = 3,
				uuid = "ff032aa9-82a0-b676-8354-0242905bf190",
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
							actionLua = "if data.p2stackmarkerid == nil then \n\t\tdata.p2stackmarkerid = {} \nend\ntable.insert(data.p2stackmarkerid,eventArgs.entityID)\nself.used = true",
							conditions = 
							{
								
								{
									"b0aa1537-3fd1-38f8-9429-e7fc34f69eb0",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							uuid = "a1089a8c-621a-96e1-9103-08726672654d",
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
							eventMarkerID = 100,
							uuid = "b0aa1537-3fd1-38f8-9429-e7fc34f69eb0",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 241.3,
				name = "p2_指路采集ID",
				timeRange = true,
				timelineIndex = 38,
				timerEndOffset = 20,
				timerStartOffset = -20,
				uuid = "54e03163-ff1a-8791-b981-b5d37d3d539a",
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
							actionLua = "local function ccw(A, B, C)\n    return (C.z - A.z) * (B.x - A.x) > (B.z - A.z) * (C.x - A.x)\nend\nlocal function intersect(A, B, C, D)\n    return ccw(A, C, D) ~= ccw(B, C, D) and ccw(A, B, C) ~= ccw(A, B, D)\nend\nlocal eyePos\nfor _, ent in pairs(TensorCore.entityList(\"contentid=7640\")) do\n    eyePos = ent.pos\n    break\nend\nlocal p = TensorCore.mGetPlayer()\nlocal eyePos2 = { x = 100 - (eyePos.x - 100), y = 0, z = 100 - (eyePos.z - 100) }\nlocal first = TensorCore.mGetEntity(data.p2stackmarkerid[1])\nlocal second = TensorCore.mGetEntity(data.p2stackmarkerid[2])\nif intersect(eyePos, eyePos2, first.pos, second.pos) then\n    --SendTextCommand(\"/e 不换不换！\")\n    data.p2swap = false\nelse\n    data.p2swap = false\n    if TensorCore.getDistance2d(first.pos, eyePos) > TensorCore.getDistance2d(second.pos, eyePos) then\n        local tethers = Argus.getTethersOnEnt(first.id)\n        if (table.valid(tethers)) then\n            for _, tether in pairs(tethers) do\n                if (tether.type == 222) then\n                    local partner = TensorCore.mGetEntity(tether.partnerid)\n                    if (partner ~= nil) then\n                        if p.id == first.id then\n                            SendTextCommand(\"/e 换位！换位！<se.1>\")\n                            data.p2swap = true\n                            self.used = true\n                        end\n                        if partner.id == p.id then\n                            SendTextCommand(\"/e 换位！换位！<se.1>\")\n                            data.p2swap = true\n                            self.used = true\n                        end\n                    end\n                end\n            end\n        end\n    else\n       -- d(\"this person needs to swap: \" .. second.name)\n        local tethers = Argus.getTethersOnEnt(second.id)\n        if (table.valid(tethers)) then\n            for _, tether in pairs(tethers) do\n                if (tether.type == 222) then\n                    local partner = TensorCore.mGetEntity(tether.partnerid)\n                    if (partner ~= nil) then\n                        if p.id == second.id then\n                            SendTextCommand(\"/e 换位！换位！<se.1>\")\n                            data.p2swap = true\n                            self.used = true\n                        end\n                        if partner.id == p.id then\n                            SendTextCommand(\"/e 换位！换位！<se.1>\")\n                            data.p2swap = true\n                            self.used = true\n                        end\n                    end\n                end\n            end\n        end\n    end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"d8cc511e-c7c6-2b41-9141-e3c05b780f5c",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							uuid = "894e0a3d-0c51-0c00-9e85-a8c2813b69d5",
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
							conditionLua = "return data.p2stackmarkerid ~= nil and table.size(data.p2stackmarkerid) == 2",
							uuid = "d8cc511e-c7c6-2b41-9141-e3c05b780f5c",
							version = 2,
						},
					},
				},
				mechanicTime = 248,
				name = "P2_换位提示",
				timelineIndex = 41,
				timerOffset = -2,
				uuid = "8d2719c4-f3cf-e6ce-91e3-54b828785365",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local drawTime = 5000\nlocal points = {}\nlocal middleMPos\nfor _, ent in pairs(TensorCore.entityList(\"contentid=7633\")) do\n    if Argus.isEntityVisible(ent) then\n        table.insert(points,\n            {\n                x = ent.pos.x,\n                y = ent.pos.y,\n                z = ent.pos.z,\n                dx = ent.pos.x - 100,\n                dz = ent.pos.z - 100,\n                magnitude = math.sqrt((ent.pos.x - 100) ^ 2 + (ent.pos.z - 100) ^ 2)\n            })\n    end\nend\n\n-- 定义CalculateAngle函数\nfunction CalculateAngle(_point)\n    local _angle = math.atan2(_point.dz, _point.dx)\n    if _angle < 0 then\n        _angle = _angle + 2 * math.pi\n    end\n    return _angle\nend\n\n-- 对points列表进行排序\ntable.sort(points, function(a, b)\n    return CalculateAngle(a) < CalculateAngle(b)\nend)\n\n-- 遍历points列表，计算夹角并输出满足条件的点\nfor i = 1, #points do\n    local index = i\n    local index0 = i - 1 < 1 and #points or i - 1\n    local index1 = i + 1 > #points and 1 or i + 1\n    local cos0 = (points[index].dx * points[index0].dx + points[index].dz * points[index0].dz)\n        / (points[index].magnitude * points[index0].magnitude)\n    local cos1 = (points[index].dx * points[index1].dx + points[index].dz * points[index1].dz)\n        / (points[index].magnitude * points[index1].magnitude)\n    if cos0 > 0.1 and cos1 > 0.1 then\n        middleMPos = points[i]\n    end\nend\n\nlocal midglitch = TensorCore.hasBuff(TensorCore.mGetPlayer(), 3427)\nlocal center2MH = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, middleMPos)\n\nlocal heading\nif data.p2partysynergygroup == \"left\" then     -- 左\n    if midglitch then                          -- 如果为近线\n        if data.p2swap then                    --需要交换\n            heading = center2MH - math.pi;     -- 换到下面\n        else\n            heading = center2MH + math.pi / 2; -- 不换 到左边\n        end\n    else\n        if data.p2swap then                    --需要交换\n            heading = center2MH - math.pi / 2; --换到右边\n        else\n            heading = center2MH + math.pi / 2; --不换 到左边\n        end\n    end\nelseif data.p2partysynergygroup == \"right\" then -- 右\n    if midglitch then                           -- 如果为近线\n        if data.p2swap then                     --需要交换\n            heading = center2MH + math.pi / 2;  -- 换到左边\n        else\n            heading = center2MH - math.pi;      -- 不换到下面\n        end\n    else\n        if data.p2swap then                    --需要交换\n            heading = center2MH + math.pi / 2; --换到左边\n        else\n            heading = center2MH - math.pi / 2; --不换 到右边\n        end\n    end\nend\n\nif heading ~= nil then\n    local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 3)\n    MuAiGuide.DirectTo(pos.x, pos.z, drawTime)\n    local endPos\n    if midglitch then\n        endPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 15)\n    else\n        endPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, heading, 19)\n    end\n    MuAiGuide.DirectTo(endPos.x, endPos.z, drawTime, 0.5, 4000)\nelse\n    d('没能计算出heading,不能画图')\nend\nself.used = true\n",
							gVar = "ACR_RikuMNK2_CD",
							uuid = "6bfdb1d2-6de9-4911-b2db-4c5a3d50a1f2",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 248,
				name = "P2_击退指路",
				timelineIndex = 41,
				timerOffset = 2,
				uuid = "7de411c0-7b2b-b72b-bcd6-8451ee4dbd34",
				version = 2,
			},
			inheritedIndex = 2,
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
							aType = "Misc",
							conditions = 
							{
								
								{
									"f08d1865-e6fd-fb22-ae4d-dfaf4a2893ba",
									true,
								},
							},
							gVar = "ACR_TensorMagnum2_CD",
							setTarget = true,
							uuid = "5d50b382-5949-35d1-85e5-4afde633a3e0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 4,
							buffIDList = 
							{
								3452,
								3453,
							},
							category = "Self",
							matchAnyBuff = true,
							uuid = "f08d1865-e6fd-fb22-ae4d-dfaf4a2893ba",
							version = 2,
						},
					},
				},
				mechanicTime = 571.4,
				name = "untarget",
				timeRange = true,
				timelineIndex = 93,
				timerStartOffset = -1.5,
				uuid = "1b94d80e-c692-5ed5-a173-60658ea7b585",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p3TVside = \"R\"\ndata.p3TVme = true\n-- SendTextCommand(\"/e 右小电视\")\nself.used = true",
							conditions = 
							{
								
								{
									"d04f19d5-783b-6b08-a8fd-958c7a3e2289",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum2_CD",
							name = "R side",
							uuid = "a5f45a24-a190-40af-ab24-badc1fb9e63b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p3TVside = \"L\"\ndata.p3TVme = true\n-- SendTextCommand(\"/e 左小电视\")\nself.used = true",
							conditions = 
							{
								
								{
									"9d5c4d19-c3b8-cb66-a07c-6ae26c12f832",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum2_CD",
							name = "L side",
							uuid = "58706f67-db41-e572-90fc-39539f49bf4c",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p3TVme = false\n-- SendTextCommand(\"/e 无电视\")\nself.used = true",
							conditions = 
							{
								
								{
									"ac34d40c-635e-aae6-9afa-0702a7d622c7",
									true,
								},
								
								{
									"d04f19d5-783b-6b08-a8fd-958c7a3e2289",
									false,
								},
								
								{
									"9d5c4d19-c3b8-cb66-a07c-6ae26c12f832",
									false,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum2_CD",
							name = "no TV",
							uuid = "3409da7e-7f11-870d-be7c-0b2bdbf89acc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 4,
							buffID = 3452,
							buffIDList = 
							{
								3452,
								3453,
							},
							category = "Party",
							matchAnyBuff = true,
							name = "buff ready",
							partyTargetNumber = 3,
							partyTargetSubType = "Number",
							uuid = "ac34d40c-635e-aae6-9afa-0702a7d622c7",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3452,
							category = "Self",
							name = "R",
							uuid = "d04f19d5-783b-6b08-a8fd-958c7a3e2289",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3453,
							category = "Self",
							name = "L",
							uuid = "9d5c4d19-c3b8-cb66-a07c-6ae26c12f832",
							version = 2,
						},
					},
				},
				mechanicTime = 571.4,
				name = "my TV side",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = -3.5,
				timerStartOffset = -15,
				uuid = "836fbbe2-6729-88d6-9d5d-98c5ad571bae",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p3bossTVside = \"R\"\n-- SendTextCommand(\"/e BOSS 右\")\nself.used = true",
							conditions = 
							{
								
								{
									"f3f27aea-7922-069d-a372-a6928c62757f",
									true,
								},
							},
							endIfUsed = true,
							name = "R side",
							uuid = "51c05204-2631-6cc6-942f-d9cc943191e0",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p3bossTVside = \"L\"\n-- SendTextCommand(\"/e BOSS 左\")\nself.used = true",
							conditions = 
							{
								
								{
									"acf348df-0cca-8eb7-b6a6-75695ce806e5",
									true,
								},
							},
							endIfUsed = true,
							name = "L side",
							uuid = "0c184612-21e7-4515-972b-3bcea76653e4",
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
							eventSpellID = 31595,
							name = "R",
							uuid = "f3f27aea-7922-069d-a372-a6928c62757f",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Event",
							eventArgType = 2,
							eventSpellID = 31596,
							name = "L",
							uuid = "acf348df-0cca-8eb7-b6a6-75695ce806e5",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				eventType = 3,
				mechanicTime = 571.4,
				name = "BOSS TV side",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = -3.5,
				timerStartOffset = -15,
				uuid = "eefb736d-8810-7c9d-99e7-f7b25614aa43",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local posx\nlocal posxL = 103\nlocal posxR = 97\nlocal posz = 85\nlocal drawTime = 7000\nif data.p3bossTVside == \"L\" then\n    posx = posxL\nelseif data.p3bossTVside == \"R\" then\n    posx = posxR\nend\nMuAiGuide.DirectTo(posx, posz, drawTime)\nSendTextCommand(\"/e 锁链1<se.1>\")\nself.used = true\n",
							conditions = 
							{
								
								{
									"2c357614-5bbd-01a4-9530-7ff564fc30ac",
									true,
								},
								
								{
									"9b598bce-8349-a95d-ab9b-c145cd455e42",
									true,
								},
								
								{
									"dda8343f-ab4b-c9f5-acd2-6fd4e0c1616a",
									true,
								},
								
								{
									"2ed0587f-9618-267d-b6b8-48773cf1b396",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "bind 1",
							uuid = "a92e970a-21c7-3d2c-8752-9f7fff5fa9d5",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local posx = 87\nlocal posz = 95\nlocal drawTime = 7000\nMuAiGuide.DirectTo(posx, posz, drawTime)\nSendTextCommand(\"/e 锁链2<se.1>\")\nself.used = true\n",
							conditions = 
							{
								
								{
									"2c357614-5bbd-01a4-9530-7ff564fc30ac",
									true,
								},
								
								{
									"9b598bce-8349-a95d-ab9b-c145cd455e42",
									true,
								},
								
								{
									"dda8343f-ab4b-c9f5-acd2-6fd4e0c1616a",
									true,
								},
								
								{
									"fc20a0d6-91d7-7f04-91a8-03c1443a7678",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "bind 2",
							uuid = "12fa2566-764d-f306-bdd9-0300af989402",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local posx = 87\nlocal posz = 105\nlocal drawTime = 7000\nMuAiGuide.DirectTo(posx, posz, drawTime)\nSendTextCommand(\"/e 锁链3<se.1>\")\nself.used = true\n",
							conditions = 
							{
								
								{
									"2c357614-5bbd-01a4-9530-7ff564fc30ac",
									true,
								},
								
								{
									"9b598bce-8349-a95d-ab9b-c145cd455e42",
									true,
								},
								
								{
									"dda8343f-ab4b-c9f5-acd2-6fd4e0c1616a",
									true,
								},
								
								{
									"7a56c21e-4a3b-8180-866f-e50a3076b6ad",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "bind 3",
							uuid = "972afbfc-ff3d-12e1-808f-f4919aec0e05",
							version = 2.1,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local posx\nlocal posxL = 101.5\nlocal posxR = 98.5\nlocal posz = 90\n\nif data.p3bossTVside == \"L\" then\n    posx = posxL\nelseif data.p3bossTVside == \"R\" then\n    posx = posxR\nend\nlocal drawTime = 7000\nMuAiGuide.DirectTo(posx, posz, drawTime)\nSendTextCommand(\"/e 攻击1\")\nself.used = true",
							conditions = 
							{
								
								{
									"2c357614-5bbd-01a4-9530-7ff564fc30ac",
									true,
								},
								
								{
									"9b598bce-8349-a95d-ab9b-c145cd455e42",
									true,
								},
								
								{
									"7a7c59d2-1eca-1f96-9fa1-10742d775a92",
									true,
								},
								
								{
									"138e3d5c-7309-c96e-8aff-f635c87fe18d",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "attack 1",
							uuid = "ea7904bf-146b-ef32-afff-72b51d4a02c6",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local posx = 111.3\nlocal posz = 100\nlocal drawTime = 7000\nMuAiGuide.DirectTo(posx, posz, drawTime)\nSendTextCommand(\"/e 攻击2\")\nself.used = true\n",
							conditions = 
							{
								
								{
									"2c357614-5bbd-01a4-9530-7ff564fc30ac",
									true,
								},
								
								{
									"9b598bce-8349-a95d-ab9b-c145cd455e42",
									true,
								},
								
								{
									"7a7c59d2-1eca-1f96-9fa1-10742d775a92",
									true,
								},
								
								{
									"60584c9d-8663-90c8-8404-3c3ed4b9e913",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "attack 2",
							uuid = "ae40a8b8-e1bf-ac2f-bc00-b2cf69dda0e9",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local posx = 119.5\nlocal posz = 100\nlocal drawTime = 7000\nMuAiGuide.DirectTo(posx, posz, drawTime)\nSendTextCommand(\"/e 攻击3\")\nself.used = true",
							conditions = 
							{
								
								{
									"2c357614-5bbd-01a4-9530-7ff564fc30ac",
									true,
								},
								
								{
									"9b598bce-8349-a95d-ab9b-c145cd455e42",
									true,
								},
								
								{
									"7a7c59d2-1eca-1f96-9fa1-10742d775a92",
									true,
								},
								
								{
									"b43ef509-4e30-16ca-a1ea-10a7df175f6f",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "attack 3",
							uuid = "0895dff5-a177-056c-804e-39f07f5b860c",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local posx\nlocal posxL = 100.5\nlocal posxR = 99.5\nlocal posz = 110\nif data.p3bossTVside == \"L\" then\n    posx = posxL\nelseif data.p3bossTVside == \"R\" then\n    posx = posxR\nend\nlocal drawTime = 7000\nMuAiGuide.DirectTo(posx, posz, drawTime)\nSendTextCommand(\"/e 攻击4\")\nself.used = true\n",
							conditions = 
							{
								
								{
									"2c357614-5bbd-01a4-9530-7ff564fc30ac",
									true,
								},
								
								{
									"9b598bce-8349-a95d-ab9b-c145cd455e42",
									true,
								},
								
								{
									"7a7c59d2-1eca-1f96-9fa1-10742d775a92",
									true,
								},
								
								{
									"80893446-bfb3-7d45-94f5-f516854a5248",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "attack 4",
							uuid = "e4ff8e6c-1c14-30eb-b96c-bd287061fb20",
							version = 2.1,
						},
						inheritedIndex = 7,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local posx\nlocal posxL = 100.5\nlocal posxR = 99.5\nlocal posz = 119.5\n\nif data.p3bossTVside == \"L\" then\n    posx = posxL\nelseif data.p3bossTVside == \"R\" then\n    posx = posxR\nend\nlocal drawTime = 7000\nMuAiGuide.DirectTo(posx, posz, drawTime)\nSendTextCommand(\"/e 攻击5\")\nself.used = true",
							conditions = 
							{
								
								{
									"2c357614-5bbd-01a4-9530-7ff564fc30ac",
									true,
								},
								
								{
									"9b598bce-8349-a95d-ab9b-c145cd455e42",
									true,
								},
								
								{
									"7a7c59d2-1eca-1f96-9fa1-10742d775a92",
									true,
								},
								
								{
									"79be25e0-6d99-9bef-b5c3-37fa8510ecc1",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "attack 5",
							uuid = "e1e11e52-070e-98a8-9978-d16ef9c956cb",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local posx\nlocal posxL = 105\nlocal posxR = 95\nlocal posz = 85\nlocal TVhead\n\nif data.p3bossTVside == \"L\" then\n    posx = posxL\nelseif data.p3bossTVside == \"R\" then\n    posx = posxR\nend\n\nif data.p3bossTVside ~= data.p3TVside then\n    TVhead = math.pi\nelseif data.p3bossTVside == data.p3TVside then\n    TVhead = math.pi * 2\nend\n\ndata.p3TVheadbind1 = TVhead\n\nlocal newdraw = Argus2.ShapeDrawer:new(\n    (GUI:ColorConvertFloat4ToU32(225 / 255, 55 / 255, 55 / 255, 0.35)),\n    (GUI:ColorConvertFloat4ToU32(225 / 255, 55 / 255, 55 / 255, 0.35)),\n    (GUI:ColorConvertFloat4ToU32(225 / 255, 55 / 255, 55 / 255, 0.35)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 225 / 255, 225 / 255, 0.85)),\n    1.5)\n\nnewdraw:addTimedArrow(\n    7000,\n    posx,\n    0,\n    posz,\n    TVhead,\n    3,\n    0.3,\n    1,\n    0.7,\n    0,\n    false\n)\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"2c357614-5bbd-01a4-9530-7ff564fc30ac",
									true,
								},
								
								{
									"9b598bce-8349-a95d-ab9b-c145cd455e42",
									true,
								},
								
								{
									"dda8343f-ab4b-c9f5-acd2-6fd4e0c1616a",
									true,
								},
								
								{
									"c336c10a-050a-b9eb-bc86-f810a58d7312",
									true,
								},
								
								{
									"2ed0587f-9618-267d-b6b8-48773cf1b396",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "bind 1 head",
							uuid = "6bc12a54-50e1-2c36-b2ef-de0eb7758644",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local posx = 87\nlocal posz = 95\nlocal TVhead\n\nif data.p3TVside == \"L\" then\n    TVhead = math.pi / 2\nelseif data.p3TVside == \"R\" then\n    TVhead = math.pi / -2\nend\n\ndata.p3TVheadbind2 = TVhead\n\nlocal newdraw = Argus2.ShapeDrawer:new(\n    (GUI:ColorConvertFloat4ToU32(225 / 255, 55 / 255, 55 / 255, 0.35)),\n    (GUI:ColorConvertFloat4ToU32(225 / 255, 55 / 255, 55 / 255, 0.35)),\n    (GUI:ColorConvertFloat4ToU32(225 / 255, 55 / 255, 55 / 255, 0.35)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 225 / 255, 225 / 255, 0.85)),\n    1.5)\n\nnewdraw:addTimedArrow(\n    7000,\n    posx,\n    0,\n    posz,\n    TVhead,\n    3,\n    0.3,\n    1,\n    0.7,\n    0,\n    false\n)\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"2c357614-5bbd-01a4-9530-7ff564fc30ac",
									true,
								},
								
								{
									"9b598bce-8349-a95d-ab9b-c145cd455e42",
									true,
								},
								
								{
									"dda8343f-ab4b-c9f5-acd2-6fd4e0c1616a",
									true,
								},
								
								{
									"c336c10a-050a-b9eb-bc86-f810a58d7312",
									true,
								},
								
								{
									"fc20a0d6-91d7-7f04-91a8-03c1443a7678",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "bind 2 head",
							uuid = "2190995e-de44-4bba-93ed-9f9385d27273",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local posx = 87\nlocal posz = 105\nlocal TVhead\n\nif data.p3TVside == \"L\" then\n    TVhead = math.pi / -2\nelseif data.p3TVside == \"R\" then\n    TVhead = math.pi / 2\nend\n\ndata.p3TVheadbind3 = TVhead\n\nlocal newdraw = Argus2.ShapeDrawer:new(\n    (GUI:ColorConvertFloat4ToU32(225 / 255, 55 / 255, 55 / 255, 0.35)),\n    (GUI:ColorConvertFloat4ToU32(225 / 255, 55 / 255, 55 / 255, 0.35)),\n    (GUI:ColorConvertFloat4ToU32(225 / 255, 55 / 255, 55 / 255, 0.35)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 225 / 255, 225 / 255, 0.85)),\n    1.5)\n\nnewdraw:addTimedArrow(\n    7000,\n    posx,\n    0,\n    posz,\n    TVhead,\n    3,\n    0.3,\n    1,\n    0.7,\n    0,\n    false\n)\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"2c357614-5bbd-01a4-9530-7ff564fc30ac",
									true,
								},
								
								{
									"9b598bce-8349-a95d-ab9b-c145cd455e42",
									true,
								},
								
								{
									"dda8343f-ab4b-c9f5-acd2-6fd4e0c1616a",
									true,
								},
								
								{
									"c336c10a-050a-b9eb-bc86-f810a58d7312",
									true,
								},
								
								{
									"7a56c21e-4a3b-8180-866f-e50a3076b6ad",
									true,
								},
							},
							gVar = "ACR_TensorMagnum2_CD",
							name = "bind 3 head",
							uuid = "db67523c-73ec-7351-be69-c810490d4e4c",
							version = 2.1,
						},
						inheritedIndex = 11,
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Party",
							channelCheckTimeRemain = 7,
							channelCheckType = 3,
							comparator = 2,
							conditionType = 5,
							partyTargetType = "Event Entity",
							uuid = "2c357614-5bbd-01a4-9530-7ff564fc30ac",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							eventArgOptionType = 3,
							eventArgType = 2,
							spellIDList = 
							{
								31595,
								31596,
							},
							uuid = "9b598bce-8349-a95d-ab9b-c145cd455e42",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3TVme == true and data.p3bossTVside ~= nil",
							name = "p3 TV me True",
							uuid = "dda8343f-ab4b-c9f5-acd2-6fd4e0c1616a",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3TVme == false and data.p3bossTVside ~= nil",
							name = "p3 TV me False",
							uuid = "7a7c59d2-1eca-1f96-9fa1-10742d775a92",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p3TVside ~= nil",
							name = "p3 TV my side",
							uuid = "c336c10a-050a-b9eb-bc86-f810a58d7312",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 6",
							name = "bind 1",
							uuid = "2ed0587f-9618-267d-b6b8-48773cf1b396",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 7",
							name = "bind 2",
							uuid = "fc20a0d6-91d7-7f04-91a8-03c1443a7678",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 8",
							name = "bind 3",
							uuid = "7a56c21e-4a3b-8180-866f-e50a3076b6ad",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 1",
							name = "attack 1",
							uuid = "138e3d5c-7309-c96e-8aff-f635c87fe18d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 2",
							name = "attack 2",
							uuid = "60584c9d-8663-90c8-8404-3c3ed4b9e913",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 3",
							name = "attack 3",
							uuid = "b43ef509-4e30-16ca-a1ea-10a7df175f6f",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 4",
							name = "attack 4",
							uuid = "80893446-bfb3-7d45-94f5-f516854a5248",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 5",
							name = "attack 5",
							uuid = "79be25e0-6d99-9bef-b5c3-37fa8510ecc1",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 571.4,
				name = "draw TV with Line mark",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = -3.5,
				timerStartOffset = -15,
				uuid = "b02b52cd-d170-faca-b7be-a2b4a3e8e03e",
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
							actionLua = "TensorCore.API.TensorACR.setLockFaceHeading(data.p3TVheadbind1)\ndata.p3tvheadready = true\n-- SendTextCommand(\"/e set bind1 Heading: \"..data.p3TVheadbind1..\"\")\n\nTensorCore.API.TensorACR.toggleLockFace(true)\nself.used = true",
							conditions = 
							{
								
								{
									"91c559ba-e200-bc39-9fb6-7bb27761b861",
									true,
								},
								
								{
									"89908348-b065-4627-a1bc-142e29d61981",
									true,
								},
								
								{
									"82bf9d69-8067-4663-b9ca-3284f7702fd3",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_TensorMagnum2_CD",
							name = "bind 1",
							uuid = "59304e9f-7021-04f7-a426-b80ed792493e",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.setLockFaceHeading(data.p3TVheadbind2)\ndata.p3tvheadready = true\n-- SendTextCommand(\"/e set bind2 Heading: \"..data.p3TVheadbind2..\"\")\n\nTensorCore.API.TensorACR.toggleLockFace(true)\nself.used = true",
							conditions = 
							{
								
								{
									"91c559ba-e200-bc39-9fb6-7bb27761b861",
									true,
								},
								
								{
									"89908348-b065-4627-a1bc-142e29d61981",
									true,
								},
								
								{
									"fa575485-4bdf-ffdf-9669-c41ec529431b",
									true,
								},
							},
							endIfUsed = true,
							name = "bind 2",
							uuid = "c47e3715-0a96-90cd-8a2c-a3a6669a8f34",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "TensorCore.API.TensorACR.setLockFaceHeading(data.p3TVheadbind3)\ndata.p3tvheadready = true\n-- SendTextCommand(\"/e set bind3 Heading: \"..data.p3TVheadbind3..\"\")\n\nTensorCore.API.TensorACR.toggleLockFace(true)\nself.used = true",
							conditions = 
							{
								
								{
									"91c559ba-e200-bc39-9fb6-7bb27761b861",
									true,
								},
								
								{
									"89908348-b065-4627-a1bc-142e29d61981",
									true,
								},
								
								{
									"791af91f-dc4c-7cea-a374-b5210a4fef2b",
									true,
								},
							},
							endIfUsed = true,
							name = "bind 3",
							uuid = "deb94f63-cccd-1848-ae35-7a7d45fae9f9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Party",
							channelCheckTimeRemain = 1.5,
							channelCheckType = 3,
							comparator = 2,
							conditionType = 5,
							partyTargetType = "Event Entity",
							uuid = "91c559ba-e200-bc39-9fb6-7bb27761b861",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							eventArgOptionType = 3,
							eventArgType = 2,
							spellIDList = 
							{
								31595,
								31596,
							},
							uuid = "89908348-b065-4627-a1bc-142e29d61981",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 6 and data.p3TVheadbind1 ~= nil",
							name = "bind 1",
							uuid = "82bf9d69-8067-4663-b9ca-3284f7702fd3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 7 and data.p3TVheadbind2 ~= nil",
							name = "bind 2",
							uuid = "fa575485-4bdf-ffdf-9669-c41ec529431b",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 8 and data.p3TVheadbind3 ~= nil",
							name = "bind 3",
							uuid = "791af91f-dc4c-7cea-a374-b5210a4fef2b",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 571.4,
				name = "Lock Face mark",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = 5,
				timerOffset = -3,
				timerStartOffset = -15,
				uuid = "53af338e-5d79-a746-ad50-c0ac6843a9ce",
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
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\nself.used = true",
							conditions = 
							{
								
								{
									"f8b8eb36-675b-b833-8551-40bc360a68cf",
									true,
								},
							},
							name = "off",
							uuid = "9e2c54be-0bde-6201-8bfd-44bd08de14cd",
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
									"f8b8eb36-675b-b833-8551-40bc360a68cf",
									true,
								},
							},
							setTarget = true,
							targetType = "Enemy",
							uuid = "e0cf7073-748a-6819-91ef-f10a27688af5",
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
							buffID = 2534,
							buffIDList = 
							{
								3452,
								3453,
							},
							category = "Self",
							name = "TV done",
							uuid = "f8b8eb36-675b-b833-8551-40bc360a68cf",
							version = 2,
						},
					},
				},
				mechanicTime = 571.4,
				name = "Lock Face off",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = 10,
				timerOffset = -2,
				timerStartOffset = -2,
				uuid = "b9461d80-d636-0e76-8f53-78a69a646577",
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
							actionLua = "SendTextCommand(\"/mk bind <me>\")\nSendTextCommand(\"/e mk bind <me>\")\n\nself.used = true",
							conditions = 
							{
								
								{
									"d54d5a28-e807-ebd4-bd91-185e70a2ad14",
									true,
								},
								
								{
									"af6e977c-ffec-bb5f-b020-15856b996cb3",
									true,
								},
								
								{
									"301de598-a0e3-f73e-947d-17380bf9095e",
									true,
								},
								
								{
									"4cdb67ce-547d-10f6-824d-49a0d64e2517",
									true,
								},
								
								{
									"01826ad3-9e77-e358-8b92-d6b68898732d",
									true,
								},
							},
							name = "have TV",
							uuid = "ab376f79-6a6e-ad51-abce-e7784cbf0105",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "SendTextCommand(\"/mk attack <me>\")\nSendTextCommand(\"/e mk attack <me>\")\n\nself.used = true",
							conditions = 
							{
								
								{
									"d54d5a28-e807-ebd4-bd91-185e70a2ad14",
									true,
								},
								
								{
									"af6e977c-ffec-bb5f-b020-15856b996cb3",
									true,
								},
								
								{
									"301de598-a0e3-f73e-947d-17380bf9095e",
									true,
								},
								
								{
									"4cdb67ce-547d-10f6-824d-49a0d64e2517",
									false,
								},
								
								{
									"01826ad3-9e77-e358-8b92-d6b68898732d",
									true,
								},
							},
							name = "no TV",
							uuid = "6c2b32f9-c778-e853-bd7b-27e66e373b52",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Party",
							channelCheckTimeRemain = 7.5,
							channelCheckType = 3,
							conditionType = 5,
							partyTargetType = "Event Entity",
							uuid = "d54d5a28-e807-ebd4-bd91-185e70a2ad14",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							eventArgOptionType = 3,
							eventArgType = 2,
							spellIDList = 
							{
								31595,
								31596,
							},
							uuid = "af6e977c-ffec-bb5f-b020-15856b996cb3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return TensorCore.mGetPlayer().marker == 0",
							name = "self no marker",
							uuid = "301de598-a0e3-f73e-947d-17380bf9095e",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 4,
							buffIDList = 
							{
								3452,
								3453,
							},
							category = "Self",
							matchAnyBuff = true,
							name = "TV",
							uuid = "4cdb67ce-547d-10f6-824d-49a0d64e2517",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffCheckType = 4,
							buffID = 3452,
							buffIDList = 
							{
								3452,
								3453,
							},
							category = "Party",
							matchAnyBuff = true,
							name = "buff ready",
							partyTargetNumber = 3,
							partyTargetSubType = "Number",
							uuid = "01826ad3-9e77-e358-8b92-d6b68898732d",
							version = 2,
						},
					},
				},
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 571.4,
				name = "mark self p32",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = -3.5,
				timerStartOffset = -15,
				uuid = "b5de825e-fceb-df50-a6a5-d3e2ffd1f668",
				version = 2,
			},
			inheritedIndex = 7,
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
							actionLua = "local basePos = { x = 100, y = 0, z = 100 }\nif TensorCore.hasBuff(TensorCore.mGetPlayer(), 3504) then\n    for _, ent in pairs(TensorCore.entityList(\"contentid=7636\")) do\n        if Argus.isEntityVisible(ent) then\n            local oemga = ent.pos\n            local heading = TensorCore.getHeadingToTarget(basePos, oemga)\n            TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.5), 1)\n                :addTimedArrow(14000, 100, 0, 100, heading, 10, 1, 1.5, 1.5, 0, true)\n            break\n        end\n    end\nelse\n    for _, ent in pairs(TensorCore.entityList(\"contentid=7695\")) do\n        if Argus.isEntityVisible(ent) then\n            local oemga = ent.pos\n            local heading = TensorCore.getHeadingToTarget(basePos, oemga)\n            TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5), 1)\n                :addTimedArrow(14000, 100, 0, 100, heading, 10, 1, 1.5, 1.5, 0, true)\n            break\n        end\n    end\nend\nself.used = true\n",
							gVar = "ACR_RikuMNK2_CD",
							uuid = "637fcdc4-a4ae-1965-a294-f38f7b6bcf31",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 743,
				name = "p5_1运蓝绿箭头",
				timelineIndex = 131,
				timerOffset = 1,
				uuid = "eafeacd2-cde5-aca0-9c8e-3b456594b7e2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "--[[\n    P5 1运转转手引导数据采集\n]]\n\nlocal player = TensorCore.mGetPlayer()\nd(player.marker)\nif player.marker == 0 then\n    local tethers = Argus.getTethersOnEnt(player.id)\n    for _, tether in pairs(tethers) do\n        d(tether)\n        if (tether.type == 201) then -- 绿线是200 蓝线是201\n            local partner = TensorCore.mGetEntity(tether.partnerid)\n            if partner.marker == 6 then\n                -- 蓝线拉线组\n                data.P51YunLinkPosType = 1\n            elseif partner.marker then\n                -- 蓝线引导组\n                data.P51YunLinkPosType = 2\n            end\n            break\n        end\n    end\nelse\n    if player.marker == 6 then\n        data.P51YunLinkPosType = 1\n    elseif player.marker == 7 then\n        data.P51YunLinkPosType = 2\n    elseif player.marker == 3 or player.marker == 4 then\n        -- 外侧引导组\n        data.P51YunLinkPosType = 4\n    elseif player.marker == 1 or player.marker == 2 then\n        -- 内侧引导组\n        data.P51YunLinkPosType = 3\n    end\nend\nd(data.P51YunLinkPosType)\nlocal C2OmegaHeading\nfor _, ent in pairs(TensorCore.entityList(\"contentid=7695\")) do\n    if Argus.isEntityVisible(ent) then\n        -- 记录场中到蟑螂方向\n        C2OmegaHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, ent.pos)\n        break\n    end\nend\n\ndata.P51YunConnanL = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading + (math.pi / 2), 2.3)\ndata.P51YunConnanR = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading - (math.pi / 2), 2.3)\ndata.P51YunCannonTvL = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading + (math.pi / 2), 4.3)\ndata.P51YunCannonTvR = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading - (math.pi / 2), 4.3)\n\ndata.P51YunDamageUpPosTvL = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 },\n    C2OmegaHeading + (math.pi * 155 / 180), 14)\ndata.P51YunDamageUpPosTvR = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 },\n    C2OmegaHeading - (math.pi * 155 / 180), 14)\ndata.P51YunDamageUpPosL = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 },\n    C2OmegaHeading + (math.pi * 175 / 180), 14)\ndata.P51YunDamageUpPosR = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 },\n    C2OmegaHeading - (math.pi * 175 / 180), 14)\n\nif data.P51YunLinkPosType == 1 then -- 蓝1组上下分散位置\n    data.P51YunLinkEndPos1 = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading + (math.pi / 2),\n        3.5)\n    data.P51YunLinkEndPos2 = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading - (math.pi / 2),\n        3.5)\nelseif data.P51YunLinkPosType == 2 then -- 蓝2组引导位置\n    data.P51YunLinkEndPos1 = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading + (math.pi * 3 / 4),\n        14)\n    data.P51YunLinkEndPos2 = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading - (math.pi * 3 / 4),\n        14)\nelseif data.P51YunLinkPosType == 3 then -- 绿12引导最终位置\n    data.P51YunLinkEndPos1 = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading + (math.pi / 2), 14)\n    data.P51YunLinkEndPos2 = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading - (math.pi / 2), 14)\nelseif data.P51YunLinkPosType == 4 then -- 绿34引导最终位置\n    data.P51YunLinkEndPos1 = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading + (math.pi / 4), 14)\n    data.P51YunLinkEndPos2 = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, C2OmegaHeading - (math.pi / 4), 14)\nend\nself.used = true\n",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "f59a54d1-06bb-9027-ad9d-a4cfcaa3bf88",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 743,
				name = "P5_1运转转引导数据采集",
				timelineIndex = 131,
				timerOffset = 2,
				uuid = "dcdf2107-232d-7df8-9e62-0400913fe2d9",
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
							aType = "Lua",
							actionLua = "--[[\n    转转手156\n]]\nlocal drawTime = 10000\nlocal handpos = TensorCore.mGetEntity(eventArgs.entityID).pos\nlocal handp = TensorCore.getPosInDirection(handpos, handpos.h - math.pi * 2 / 5, 3.5)\nif data.P51YunHandPos == nil then\n    data.P51YunHandPos = {}\nend\nif #data.P51YunHandPos < 6 then\n    table.insert(data.P51YunHandPos, { x = handp.x, z = handpos.z, ex = handp.x, ez = handp.z })\nend\nMuAiGuide.DrawCircleFloor(handp.x, handp.z, drawTime, 1)\nself.used = true\n",
							conditions = 
							{
								
								{
									"20781a97-b24d-e42b-b366-6dfeb58c8d9c",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "clockwise 156",
							uuid = "52b41ef8-0594-bada-985d-b76f266274d5",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "--[[\n    转转手157\n]]\nlocal drawTime = 10000\nlocal handpos = TensorCore.mGetEntity(eventArgs.entityID).pos\nlocal handp = TensorCore.getPosInDirection(handpos, handpos.h + math.pi * 2 / 5, 3.5)\nif data.P51YunHandPos == nil then\n    data.P51YunHandPos = {}\nend\nif #data.P51YunHandPos < 6 then\n    table.insert(data.P51YunHandPos, { x = handp.x, z = handpos.z, ex = handp.x, ez = handp.z })\nend\nMuAiGuide.DrawCircleFloor(handp.x, handp.z,drawTime, 1)\nself.used = true\n",
							conditions = 
							{
								
								{
									"b41f7fab-6ed6-cd0e-ad85-16b4abf33e7d",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "not clockwise 157",
							uuid = "813fac13-01cd-925f-8cc2-90f48c3db816",
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
							eventMarkerID = 156,
							name = "clockwise",
							uuid = "20781a97-b24d-e42b-b366-6dfeb58c8d9c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							eventArgType = 2,
							eventMarkerID = 157,
							name = "not clockwise",
							uuid = "b41f7fab-6ed6-cd0e-ad85-16b4abf33e7d",
							version = 2,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 750.2,
				name = "p5_1转转手引导点",
				timeRange = true,
				timelineIndex = 132,
				timerEndOffset = 15,
				timerStartOffset = 5,
				uuid = "732a0a98-3da3-7f2f-b96d-3e340d6f7e76",
				version = 2,
			},
		},
	},
	[137] = 
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
							actionLua = "--[[\n    P5_1运转转手指路\n]]\n-- 判断自己距离2个预选点哪个更近\nlocal drawTime = 4500\nlocal player = TensorCore.mGetPlayer()\nlocal disSqr = (data.P51YunLinkEndPos1.x - player.pos.x) ^ 2 + (data.P51YunLinkEndPos1.z - player.pos.z) ^ 2\nlocal disSqr2 = (data.P51YunLinkEndPos2.x - player.pos.x) ^ 2 + (data.P51YunLinkEndPos2.z - player.pos.z) ^ 2\n\nif disSqr < disSqr2 then\n    data.P51YunLinkEndPos = data.P51YunLinkEndPos1\nelse\n    data.P51YunLinkEndPos = data.P51YunLinkEndPos2\nend\n\n-- 如果是第一组\nif data.P51YunLinkPosType == 1 then\n    MuAiGuide.DirectTo(data.P51YunLinkEndPos.x, data.P51YunLinkEndPos.z, drawTime)\nelse\n    local minDisSqr =\n        (data.P51YunHandPos[1].x - data.P51YunLinkEndPos.x) ^ 2\n        + (data.P51YunHandPos[1].z - data.P51YunLinkEndPos.z) ^ 2\n\n    local targetPos = data.P51YunHandPos[1]\n    for i = 2, #data.P51YunHandPos, 1 do\n        local p = data.P51YunHandPos[i]\n        local curSqr = (p.x - data.P51YunLinkEndPos.x) ^ 2 + (p.z - data.P51YunLinkEndPos.z) ^ 2\n        if curSqr < minDisSqr then\n            minDisSqr = curSqr\n            targetPos = p\n        end\n    end\n    MuAiGuide.DirectTo(targetPos.ex, targetPos.ez, drawTime)\nend\nself.used = true\n",
							gVar = "ACR_RikuMNK2_CD",
							uuid = "a32429a2-9840-d682-a530-c5835b58e102",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 766.4,
				name = "P5_1运转转手指路",
				timelineIndex = 137,
				timerOffset = -2.7999999523163,
				uuid = "403f7f6b-0252-dba5-9a19-7735b4839aa4",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "--[[\n    P5_1运转转后指路\n]]\nlocal drawTime = 4000\nlocal player = TensorCore.mGetPlayer()\n\nif data.P51YunLinkPosType == 1 or data.P51YunLinkPosType == 2 then\n    if TensorCore.hasBuff(player.id, 2534) then --如果有易伤 根据是否有小电视选择分散点\n        if TensorCore.hasBuff(player.id, 3452) or TensorCore.hasBuff(player.id, 3453) then\n            if TensorCore.isAnyEntityCasting(31639) then\n                MuAiGuide.DirectTo(data.P51YunDamageUpPosTvR.x, data.P51YunDamageUpPosTvR.z, drawTime)\n            else\n                MuAiGuide.DirectTo(data.P51YunDamageUpPosTvL.x, data.P51YunDamageUpPosTvL.z, drawTime)\n            end\n        else\n            if TensorCore.isAnyEntityCasting(31639) then\n                MuAiGuide.DirectTo(data.P51YunDamageUpPosR.x, data.P51YunDamageUpPosR.z, drawTime)\n            else\n                MuAiGuide.DirectTo(data.P51YunDamageUpPosL.x, data.P51YunDamageUpPosL.z, drawTime)\n            end\n        end\n    else\n        -- 没有易伤 根据是否有小电视判断 靠近场还是偏外\n        if TensorCore.hasBuff(player.id, 3452) or TensorCore.hasBuff(player.id, 3453) then\n            if TensorCore.isAnyEntityCasting(31639) then\n                MuAiGuide.DirectTo(data.P51YunCannonTvR.x, data.P51YunCannonTvR.z, drawTime)\n            else\n                MuAiGuide.DirectTo(data.P51YunCannonTvL.x, data.P51YunCannonTvL.z, drawTime)\n            end\n        else\n            if TensorCore.isAnyEntityCasting(31639) then\n                MuAiGuide.DirectTo(data.P51YunConnanR.x, data.P51YunConnanR.z, drawTime)\n            else\n                MuAiGuide.DirectTo(data.P51YunCannonTvL.x, data.P51YunCannonTvL.z, drawTime)\n            end\n        end\n    end\nelse\n    MuAiGuide.DirectTo(data.P51YunLinkEndPos.x, data.P51YunLinkEndPos.z, drawTime)\nend\nself.used = true\n",
							gVar = "ACR_RikuMNK2_CD",
							uuid = "44f2185d-feef-ab49-abcc-c1b83f5d1535",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 771.1,
				name = "P5_1运转转后指路",
				timelineIndex = 139,
				timerOffset = -2.2000000476837,
				uuid = "1af832e3-59d5-1a0e-898a-569e9c312260",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "data.p5bossTVside = \"R\"\n-- SendTextCommand(\"/e BOSS R\")\n\ndata.p5TVbosshead = TensorCore.mGetEntity(eventArgs.entityID).pos.h\n-- SendTextCommand(\"/e TV boss Heading: \"..data.p5TVbosshead..\"\")\n\nself.used = true",
							conditions = 
							{
								
								{
									"f3f27aea-7922-069d-a372-a6928c62757f",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "R side",
							uuid = "51c05204-2631-6cc6-942f-d9cc943191e0",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p5bossTVside = \"L\"\n-- SendTextCommand(\"/e BOSS L\")\n\ndata.p5TVbosshead = TensorCore.mGetEntity(eventArgs.entityID).pos.h\n-- SendTextCommand(\"/e TV boss Heading: \"..data.p5TVbosshead..\"\")\n\nself.used = true",
							conditions = 
							{
								
								{
									"acf348df-0cca-8eb7-b6a6-75695ce806e5",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuNIN3_CD",
							name = "L side",
							uuid = "0c184612-21e7-4515-972b-3bcea76653e4",
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
							eventSpellID = 31638,
							name = "R",
							uuid = "f3f27aea-7922-069d-a372-a6928c62757f",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							eventArgType = 2,
							eventSpellID = 31639,
							name = "L",
							uuid = "acf348df-0cca-8eb7-b6a6-75695ce806e5",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 773.6,
				name = "BOSS TV side get heading",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = -3.5,
				timerStartOffset = -15,
				uuid = "0e216348-b65f-93d1-a046-c666a248d575",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local p5TVhead\n\nif data.p5bossTVside == data.p5myTVside then\n\t\tp5TVhead = data.p5TVbosshead + math.pi\nelseif data.p5bossTVside ~= data.p5myTVside then\n\t\tp5TVhead = data.p5TVbosshead\nend\n\n\nTensorCore.API.TensorACR.setLockFaceHeading(p5TVhead)\nTensorCore.API.TensorACR.toggleLockFace(true)\n\nself.used = true",
							conditions = 
							{
								
								{
									"f0d2d63a-2fc7-aa5c-a24b-8901c45d7505",
									true,
								},
								
								{
									"dbc081d0-ff5d-3eca-b09f-09c8f7b52eac",
									true,
								},
								
								{
									"65c9ec41-f809-091a-bac8-73aa4f0ee6a4",
									true,
								},
							},
							uuid = "59304e9f-7021-04f7-a426-b80ed792493e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Party",
							channelCheckTimeRemain = 1.5,
							channelCheckType = 3,
							comparator = 2,
							conditionType = 5,
							partyTargetType = "Event Entity",
							uuid = "f0d2d63a-2fc7-aa5c-a24b-8901c45d7505",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							eventArgOptionType = 3,
							eventArgType = 2,
							spellIDList = 
							{
								31639,
								31638,
							},
							uuid = "dbc081d0-ff5d-3eca-b09f-09c8f7b52eac",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.p5bossTVside ~= nil and data.p5myTVside ~= nil and data.p5TVbosshead ~= nil",
							name = "p5 TV me",
							uuid = "65c9ec41-f809-091a-bac8-73aa4f0ee6a4",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 773.6,
				name = "Lock Face",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 5,
				timerOffset = -3,
				timerStartOffset = -15,
				uuid = "62e02fbc-ae37-3b23-aacf-18cfd3d80f40",
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
							actionLua = "TensorCore.API.TensorACR.toggleLockFace(false)\nself.used = true",
							conditions = 
							{
								
								{
									"f8b8eb36-675b-b833-8551-40bc360a68cf",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							name = "off",
							uuid = "9e2c54be-0bde-6201-8bfd-44bd08de14cd",
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
									"f8b8eb36-675b-b833-8551-40bc360a68cf",
									true,
								},
							},
							gVar = "ACR_RikuMNK2_CD",
							setTarget = true,
							targetType = "Enemy",
							uuid = "e0cf7073-748a-6819-91ef-f10a27688af5",
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
							buffID = 2534,
							buffIDList = 
							{
								3452,
								3453,
							},
							category = "Self",
							name = "TV done",
							uuid = "f8b8eb36-675b-b833-8551-40bc360a68cf",
							version = 2,
						},
					},
				},
				mechanicTime = 773.6,
				name = "Lock Face off",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 10,
				timerOffset = -2,
				timerStartOffset = -2,
				uuid = "b2b06b6a-e083-13d5-ba1d-32d87958dd6e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p5myTVside = \"R\"\nself.used = true",
							conditions = 
							{
								
								{
									"d04f19d5-783b-6b08-a8fd-958c7a3e2289",
									true,
								},
							},
							endIfUsed = true,
							name = "R side",
							uuid = "a5f45a24-a190-40af-ab24-badc1fb9e63b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.p5myTVside = \"L\"\nself.used = true",
							conditions = 
							{
								
								{
									"9d5c4d19-c3b8-cb66-a07c-6ae26c12f832",
									true,
								},
							},
							endIfUsed = true,
							name = "L side",
							uuid = "58706f67-db41-e572-90fc-39539f49bf4c",
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
							buffID = 3452,
							category = "Self",
							name = "R",
							uuid = "d04f19d5-783b-6b08-a8fd-958c7a3e2289",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3453,
							category = "Self",
							name = "L",
							uuid = "9d5c4d19-c3b8-cb66-a07c-6ae26c12f832",
							version = 2,
						},
					},
				},
				mechanicTime = 773.6,
				name = "my TV side",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = -3.5,
				timerStartOffset = -15,
				uuid = "269cc560-b315-0ca4-8c4f-0db61b77ea77",
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
							actionLua = "local drawTime = 1500\nlocal omegePos\nfor _, ent in pairs(TensorCore.entityList(\"contentid=7636\")) do\n    if Argus.isEntityVisible(ent) then\n        omegePos = ent.pos\n        break\n    end\nend\nif TensorCore.isAnyEntityCasting(31638) then\n    TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.5), 1)\n        :addTimedRect(drawTime, omegePos.x, omegePos.y, omegePos.z, 20, 80, omegePos.h - math.pi / 2, 0, false)\nelse\n    TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, 0.5), 1)\n        :addTimedRect(drawTime, omegePos.x, omegePos.y, omegePos.z, 20, 80, omegePos.h + math.pi / 2, 0, false)\nend\nself.used = true",
							gVar = "ACR_RikuMNK2_CD",
							uuid = "39a5a23b-2c07-c6a9-abc1-040ddaa325c5",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 773.6,
				name = "p51绘制左右刀",
				timelineIndex = 144,
				timerOffset = -4,
				uuid = "53f5ad73-6344-9d30-9edc-10238346b51c",
				version = 2,
			},
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
							actionLua = "local drawTime = 12000\nlocal omegePos\nfor _, ent in pairs(TensorCore.entityList(\"contentid=7695\")) do\n    if Argus.isEntityVisible(ent) then\n        omegePos = ent.pos\n        break\n    end\nend\n\nlocal omegeH = TensorCore.getHeadingToTarget(omegePos, { x = 100, y = 0, z = 100 })\nlocal markInfo = {}\nif TensorCore.isAnyEntityCasting(31636) then\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH + math.pi * 42 / 180, 1.3), type = 1 })  -- 攻击1\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH + math.pi * 16 / 180, 37.6), type = 2 }) -- 攻击2\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH + math.pi * 38 / 180, 14), type = 3 })   -- 攻击3\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH + math.pi * 64 / 180, 15.3), type = 4 }) -- 攻击4\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH + math.pi * 44 / 180, 27.5), type = 6 }) -- 锁链1\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH + math.pi * 18 / 180, 21), type = 7 })   -- 锁链2\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH + math.pi * 29 / 180, 34), type = 0 })   -- 闲人\nelseif TensorCore.isAnyEntityCasting(31637) then\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH - math.pi * 42 / 180, 1.3), type = 1 })  -- 攻击1\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH - math.pi * 16 / 180, 37.6), type = 2 }) -- 攻击2\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH - math.pi * 38 / 180, 14), type = 3 })   -- 攻击3\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH - math.pi * 64 / 180, 15.3), type = 4 }) -- 攻击4\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH - math.pi * 44 / 180, 27.5), type = 6 }) -- 锁链1\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH - math.pi * 18 / 180, 21), type = 7 })   -- 锁链2\n    table.insert(markInfo, { pos = TensorCore.getPosInDirection(omegePos, omegeH - math.pi * 29 / 180, 34), type = 0 })   -- 闲人\nend\nif #markInfo == 0 then\n    self.used = true\n    return\nend\n\nlocal myMarker = TensorCore.mGetPlayer().marker\n\nfor _, mkInfo in ipairs(markInfo) do\n    local maker = mkInfo.type\n    if maker == myMarker then -- 如果是自己，进行指路\n        MuAiGuide.DirectTo(mkInfo.pos.x, mkInfo.pos.z, drawTime, 0.7)\n    end\n    if data.DrawAllPos then\n        if maker == 1 or maker == 2 then\n            MuAiGuide.DrawCircleFloor(mkInfo.pos.x, mkInfo.pos.z, drawTime, 1, 0, 255, 0)   -- 绿\n        elseif maker == 3 or maker == 4 then\n            MuAiGuide.DrawCircleFloor( mkInfo.pos.x, mkInfo.pos.z,drawTime, 1, 255, 0, 255) -- 紫\n        elseif maker == 6 then\n            MuAiGuide.DrawCircleFloor(mkInfo.pos.x, mkInfo.pos.z,drawTime, 1, 0, 255, 255) -- 蓝绿\n        elseif maker == 7 then\n            MuAiGuide.DrawCircleFloor(mkInfo.pos.x, mkInfo.pos.z, drawTime, 1, 255, 0, 0)   -- 红\n        elseif maker == 0 then\n            MuAiGuide.DrawCircleFloor(mkInfo.pos.x, mkInfo.pos.z, drawTime, 1, 255, 255, 0) --黄\n        end\n    end\nend\nself.used = true",
							gVar = "ACR_RikuMNK2_CD",
							uuid = "a5c7f5a6-9dcb-5a5f-9847-254e71e14e59",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 786.4,
				name = "p5_1传指路",
				timelineIndex = 149,
				timerOffset = -9,
				uuid = "9f4cbe73-48db-c3bb-b57d-6b31a44613c2",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionLua = "for _, ent in pairs(TensorCore.entityList(\"contentid=12257\")) do\n    if Argus.isEntityVisible(ent) then\n        TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5), 1)\n            :addTimedArrowOnEnt(15000, TensorCore.mGetPlayer().id, 1, 0.5, 1, 1, ent.id, 0, true)\n        data.P52YunOmegaPos = ent.pos\n        break\n    end\nend\nself.used = true\n",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "0a194d27-8fd7-1358-a492-eb69d33af398",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 844,
				name = "箭头欧米茄M并储存其坐标",
				timelineIndex = 166,
				timerOffset = -15,
				uuid = "cfd983a4-5b07-e52e-a3e8-1c756a859743",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local drawTime = 7000\nlocal player = TensorCore.mGetPlayer()\nlocal midglitch = TensorCore.hasBuff(player, 3427)\nlocal c2mHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, data.P52YunOmegaPos) -- 获取 中心到 M的方向向量\nlocal GetMarkerIndex = function(marker)\n    local index\n    if marker == nil or marker == 0 then\n        index = 0\n    elseif marker == 1 then -- 攻击1\n        index = 1\n    elseif marker == 2 then -- 攻击2\n        index = 2\n    elseif marker == 3 then -- 攻击3\n        index = 3\n    elseif marker == 4 then -- 攻击4\n        index = 4\n    elseif marker == 11\n        or marker == 12 then --方块/圆\n        index = 5\n    elseif marker == 8 then  -- 攻击2\n        index = 6\n    elseif marker == 7 then  -- 攻击3\n        index = 7\n    elseif marker == 6 then  -- 攻击4\n        index = 8\n    end\n    return index\nend\n\nlocal GetTargetPosByIndex = function(index, selfInx)\n    local targetPos\n    for i = 1, 8 do\n        local curHeading = c2mHeading + (2 * i - 1) * math.pi / 8\n        local distance\n        local isSpecial = false\n        if midglitch then\n            if i == 1 or i == 8 then -- 攻击1 锁链1\n                distance = 13;\n                isSpecial = true\n            else\n                distance = 12;\n            end\n        else\n            if i == 2 or i == 7 then -- 攻击2 锁链2\n                distance = 18.5;\n                isSpecial = true\n            else\n                distance = 19.5;\n            end\n        end\n        local pos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, curHeading, distance)\n        if index > 0 and index == i then\n            targetPos = pos -- 记录当前坐标，用于处理无脑塔\n        end\n        if data.DrawAllPos and selfInx then\n            if isSpecial then\n                MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime, 0.7, 0, 255, 255)\n            else\n                MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime, 0.7, 0, 255, 0)\n            end\n        end\n    end\n    return targetPos\nend\n\n-- 获取当前自己的标记\nlocal targetIndex = GetMarkerIndex(player.marker)\ndata.P52YunStartPos = GetTargetPosByIndex(targetIndex, true)\nif data.P52YunStartPos ~= nil then\n    MuAiGuide.DirectTo(data.P52YunStartPos.x, data.P52YunStartPos.z, drawTime)\nend\n\nif not midglitch then\n    local partner\n    local tethers = Argus.getTethersOnEnt(player.id)\n    if (table.valid(tethers)) then\n        for _, tether in pairs(tethers) do\n            if (tether.type == 222) then\n                partner = TensorCore.mGetEntity(tether.partnerid)\n                break\n            end\n        end\n        if partner ~= nil then\n            local pIndex = GetMarkerIndex(partner.marker)\n            data.P52YunPartnerStartPos = GetTargetPosByIndex(pIndex, false)\n        end\n    end\nend\nself.used = true\n",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "91ccf005-393a-46f0-b1ca-59e576e6cf56",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 844,
				name = "P5 斜米分散绘制",
				timelineIndex = 166,
				timerOffset = -7,
				uuid = "aeb4d547-3b3e-d37e-93fa-346a5fab12a6",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[173] = 
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
							actionLua = "local drawTime = 7000\nlocal timeInTower = 4000\n-- 找到双人塔\nlocal towers = {}\n-- 向量（dx， dz）表示场中到这点的向量\nfor _, ent in pairs(TensorCore.entityList(\"contentid=2013246\")) do\n    table.insert(towers,\n        {\n            pos = ent.pos, -- 原始坐标\n            dx = ent.pos.x - 100,\n            dz = ent.pos.z - 100,\n            magnitude = math.sqrt((ent.pos.x - 100) ^ 2 + (ent.pos.z - 100) ^ 2),\n            type = 2\n        })\nend\n\n-- 找到单人塔\nfor _, ent in pairs(TensorCore.entityList(\"contentid=2013245\")) do\n    table.insert(towers,\n        {\n            pos = ent.pos,\n            dx = ent.pos.x - 100,\n            dz = ent.pos.z - 100,\n            magnitude = math.sqrt((ent.pos.x - 100) ^ 2 + (ent.pos.z - 100) ^ 2),\n            type = 1\n        })\nend\n\n-- 先绘制出是哪种塔\nfor _, tower in pairs(towers) do\n    if tower.type == 2 then\n        MuAiGuide.DrawCircleFloor(tower.pos.x, tower.pos.z, drawTime, 3, 255, 0, 255)\n    else\n        MuAiGuide.DrawCircleFloor(tower.pos.x, tower.pos.z, drawTime, 3, 0, 255, 255) -- 绘制绿色圈\n    end\nend\n\nlocal getTargetTower = function(position)\n    local nearTower = {}\n    local cosPiDir3 = math.cos(math.pi / 3)   -- 60度范围\n    local cosPiDir72 = math.cos(math.pi / 72) -- 2.5度，如果某个夹角2.5度还小 近似认为他\n    -- 圆心到玩家原始位置向量\n    local op = { x = position.x - 100, y = 0, z = position.z - 100 }\n    local opMagnitude = math.sqrt(op.x ^ 2 + op.z ^ 2)\n\n    for _, tower in ipairs(towers) do\n        local cosOpt = (op.x * tower.dx + op.z * tower.dz) / (opMagnitude * tower.magnitude)\n        if cosOpt > cosPiDir3 and cosOpt < cosPiDir72 then\n            table.insert(nearTower, tower)\n        end\n    end\n    local targetTower\n    if #nearTower == 1 then\n        targetTower = nearTower[1]\n    elseif nearTower[1].type == 2 then\n        targetTower = nearTower[1]\n    else\n        targetTower = nearTower[2]\n    end\n    return targetTower\nend\n\n-- 如果没找到 之前玩家记录的位置，那么也没法指路了画个圈完事\nif data.P52YunStartPos ~= nil then\n    local isNear = TensorCore.hasBuff(TensorCore.mGetPlayer(), 3427);\n    local selfTower = getTargetTower(data.P52YunStartPos)\n    local m2TowerH = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 },  { x = selfTower.pos.x, 0, z = selfTower.pos.z })\n    if isNear then\n        local startPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, m2TowerH, 2)\n        MuAiGuide.DirectTo(startPos.x, startPos.z, drawTime - timeInTower - 100, 0.5)\n        MuAiGuide.DirectTo(selfTower.pos.x, selfTower.pos.z, timeInTower, 0.5, drawTime - timeInTower)\n    else\n        -- 远线塔内最大距离为 穿塔中心 最贴近塔边\n        if data.P52YunPartnerStartPos ~= nil then\n            local pTower = getTargetTower(data.P52YunPartnerStartPos)\n            local p2meHeading = TensorCore.getHeadingToTarget(pTower.pos, selfTower.pos)\n            local targetPos = TensorCore.getPosInDirection(pTower.pos, p2meHeading, 33.8)\n            local c2tH = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 },  { x = targetPos.x, 0, z = targetPos.z })\n            local startPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, c2tH, 2)\n            MuAiGuide.DirectTo(startPos.x, startPos.z, drawTime - timeInTower - 100, 0.5)\n            MuAiGuide.DirectTo(targetPos.x, targetPos.z, timeInTower, 0.5, drawTime - timeInTower + 100)\n        else\n            local startPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, m2TowerH, 2)\n            MuAiGuide.DirectTo(startPos.x, startPos.z, drawTime - timeInTower - 100, 0.5)\n            local targetPos = TensorCore.getPosInDirection({ x = 100, y = 0, z = 100 }, m2TowerH, 19.5)\n            MuAiGuide.DirectTo(targetPos.x, targetPos.z, timeInTower, 0.5, drawTime - timeInTower + 100)\n        end\n    end\nend\n\nself.used = true\n",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "44b75451-d1be-1972-8fb7-cbe0348c0fee",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 856.4,
				name = "P5_2运踩塔",
				timelineIndex = 173,
				timerOffset = -7,
				uuid = "9eb8b4fe-c64a-cdbc-a36d-e80c3c630a31",
				version = 2,
			},
			inheritedIndex = 1,
		},
	},
	[175] = 
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
							actionLua = "local drawTime = 10000\nlocal menid = eventArgs.entityID\nlocal menpos = TensorCore.mGetEntity(menid).pos\n\ndata.P52YunClockRingPos = menpos\ndata.P52YunClock = 156\n-- 156和157这有这里不同\nlocal pos = TensorCore.getPosInDirection(menpos, menpos.h + (math.pi / 8), 19)\nlocal pos2 = TensorCore.getPosInDirection(menpos, menpos.h - (7 * math.pi / 8), 19)\n\nlocal myMarker = TensorCore.mGetPlayer().marker\nif myMarker ~= nil and myMarker > 0 then\n    if myMarker == 1 or myMarker == 9 or myMarker == 10 then -- 攻击1, 禁止1, 禁止2\n        MuAiGuide.DirectTo(pos2.x, pos2.z, drawTime)\n        data.P52YunClockStartPos = pos2\n    else\n        MuAiGuide.DirectTo(pos.x, pos.z, drawTime)\n        data.P52YunClockStartPos = pos\n    end\nend\nif data.DrawAllPos then\n    MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime)\n    MuAiGuide.DrawCircleFloor(pos2.x, pos2.z, drawTime)\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"baad044e-42db-c2a3-905d-83cd59484cb0",
									true,
								},
							},
							gVar = "ACR_TensorMagnum2_CD",
							name = "156",
							uuid = "dc6d6809-3633-9a3e-a159-24115f771220",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local drawTime = 10000\nlocal menid = eventArgs.entityID\nlocal menpos = TensorCore.mGetEntity(menid).pos\n\ndata.P52YunClockRingPos = menpos\ndata.P52YunClock = 157\n-- 156和157这有这里不同\nlocal pos = TensorCore.getPosInDirection(menpos, menpos.h - (math.pi / 8), 19)\nlocal pos2 = TensorCore.getPosInDirection(menpos, menpos.h + (7 * math.pi / 8), 19)\n\nlocal myMarker = TensorCore.mGetPlayer().marker\nif myMarker ~= nil and myMarker > 0 then\n    if myMarker == 1 or myMarker == 9 or myMarker == 10 then -- 攻击1, 禁止1, 禁止2\n        MuAiGuide.DirectTo(pos2.x, pos2.z, drawTime)\n        data.P52YunClockStartPos = pos2\n    else\n        MuAiGuide.DirectTo(pos.x, pos.z, drawTime)\n        data.P52YunClockStartPos = pos\n    end\nend\nif data.DrawAllPos then\n    MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime)\n    MuAiGuide.DrawCircleFloor(pos2.x, pos2.z, drawTime)\nend\nself.used = true",
							conditions = 
							{
								
								{
									"f41384c7-43a2-6898-9f3a-f05885686a89",
									true,
								},
							},
							gVar = "ACR_TensorMagnum2_CD",
							name = "157",
							uuid = "04967f4c-3834-4f90-a5f9-377eddd93ace",
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
							eventMarkerID = 156,
							name = "156",
							uuid = "baad044e-42db-c2a3-905d-83cd59484cb0",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							eventArgType = 2,
							eventMarkerID = 157,
							name = "157",
							uuid = "f41384c7-43a2-6898-9f3a-f05885686a89",
							version = 2,
						},
					},
				},
				eventType = 4,
				mechanicTime = 873.7,
				name = "P5_2运下半起跑点",
				timeRange = true,
				timelineIndex = 175,
				timerEndOffset = 20,
				timerStartOffset = -20,
				uuid = "df9f1f3a-3ef3-7349-ab8c-b624ed3a98bb",
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
							actionLua = "local drawTime = 10000 -- 绘制持续时间\nlocal basePos = data.P52YunClockRingPos\nlocal heading = basePos.h - math.pi\n-- 攻击12和锁链1，所有可能的位置\nlocal atk12L = TensorCore.getPosInDirection(basePos, heading - (math.pi / 2), 19)\nlocal atk12R = TensorCore.getPosInDirection(basePos, heading + (math.pi / 2), 19)\nlocal bind1L = TensorCore.getPosInDirection(basePos, heading - (math.pi / 2), 9.3)\nlocal bind1R = TensorCore.getPosInDirection(basePos, heading + (math.pi / 2), 9.3)\n\nlocal atk1\nlocal atk2\nlocal bind1\n\nif data.P52YunClock == 156 then\n    atk1 = atk12L\n    atk2 = atk12R\n    bind1 = bind1R\nelseif data.P52YunClock == 157 then\n    atk1 = atk12R\n    atk2 = atk12L\n    bind1 = bind1L\nend\n\n-- 禁止1\nlocal stop1 = TensorCore.getPosInDirection(basePos, heading + (math.pi / 4), 19)\n-- 禁止2\nlocal stop2 = TensorCore.getPosInDirection(basePos, heading - (math.pi / 4), 19)\n-- 锁链2\nlocal bind2 = TensorCore.getPosInDirection(basePos, heading + (math.pi * 7 / 8), 19)\n-- 攻击3\nlocal atk3 = TensorCore.getPosInDirection(basePos, heading - (math.pi * 19 / 20), 12)\n-- 攻击4\nlocal atk4 = TensorCore.getPosInDirection(basePos, heading - (math.pi * 11 / 12), 19)\n\nlocal allPos = {}\ntable.insert(allPos, { pos = atk1, type = 1 })\ntable.insert(allPos, { pos = atk2, type = 1 })\ntable.insert(allPos, { pos = atk3, type = 1 })\ntable.insert(allPos, { pos = atk4, type = 1 })\ntable.insert(allPos, { pos = bind1, type = 2 })\ntable.insert(allPos, { pos = bind2, type = 2 })\ntable.insert(allPos, { pos = stop1, type = 3 })\ntable.insert(allPos, { pos = stop2, type = 3 })\n\n-- 获取当前的标点\nlocal myMarker = TensorCore.mGetPlayer().marker\nlocal myIndex\nif myMarker == 1 then      --攻击1\n    myIndex = 1\nelseif myMarker == 2 then  -- 攻击2\n    myIndex = 2\nelseif myMarker == 3 then  -- 攻击3\n    myIndex = 3\nelseif myMarker == 4 then  -- 攻击4\n    myIndex = 4\nelseif myMarker == 6 then  -- 锁链1\n    myIndex = 5\nelseif myMarker == 7 then  -- 锁链2\n    myIndex = 6\nelseif myMarker == 9 then  -- 禁止1\n    myIndex = 7\nelseif myMarker == 10 then -- 禁止2\n    myIndex = 8\nend\nfor i = 1, #allPos do\n    local pos = allPos[i].pos\n    if i == myIndex then\n        MuAiGuide.DirectTo(pos.x, pos.z, drawTime)\n    end\n    if data.DrawAllPos then\n        local type = allPos[i].type\n        if type == 1 then\n            MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime, 0.8, 255, 255, 0)\n        elseif type == 2 then\n            MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime, 0.8, 255, 0, 255)\n        elseif type == 3 then\n            MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime, 0.8, 255, 0, 0)\n        end\n    end\nend\nself.used = true",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "68c2d5a5-3724-8825-b8bd-65da19b11fbc",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 880.6,
				name = "P5_2传指路",
				timelineIndex = 176,
				timerOffset = -7,
				uuid = "ca07b0a1-3dc3-78a3-ba38-5dc659d284ac",
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
							actionLua = "-- 左右 => 前后 的情况\nlocal alpha = 0.4     -- 透明度\nlocal drawer = Argus2.ShapeDrawer:new(\n    (GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, alpha)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, alpha)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, alpha)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0.85)),\n    1\n)\n\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\ndrawer:addTimedCone(8500, ent.pos.x, ent.pos.y, ent.pos.z, 30, 130 / 180 * math.pi, ent.pos.h + math.pi / 2, 0, true)\ndrawer:addTimedCone(8500, ent.pos.x, ent.pos.y, ent.pos.z, 30, 130 / 180 * math.pi, ent.pos.h - math.pi / 2, 0, true)\ndrawer:addTimedCone(4000, ent.pos.x, ent.pos.y, ent.pos.z, 30, 130 / 180 * math.pi, ent.pos.h, 8500, true)\ndrawer:addTimedCone(4000, ent.pos.x, ent.pos.y, ent.pos.z, 30, 130 / 180 * math.pi, ent.pos.h + math.pi, 8500, true)\n\nself.used = true",
							conditions = 
							{
								
								{
									"e2e7ea69-74c3-5fa7-8323-d6e1d280d707",
									true,
								},
							},
							name = "左/右",
							uuid = "9f91a30c-937a-f573-93af-a7de61705be4",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- 前后 => 左右 的情况\nlocal alpha = 0.4     -- 透明度\nlocal drawer = Argus2.ShapeDrawer:new(\n    (GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, alpha)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, alpha)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, alpha)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0.85)),\n    1\n)\n\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\ndrawer:addTimedCone(8500, ent.pos.x, ent.pos.y, ent.pos.z, 30, 130 / 180 * math.pi, ent.pos.h, 0, true)\ndrawer:addTimedCone(8500, ent.pos.x, ent.pos.y, ent.pos.z, 30, 130 / 180 * math.pi, ent.pos.h + math.pi, 0, true)\ndrawer:addTimedCone(4000, ent.pos.x, ent.pos.y, ent.pos.z, 30, 130 / 180 * math.pi, ent.pos.h + math.pi / 2, 8500, true)\ndrawer:addTimedCone(4000, ent.pos.x, ent.pos.y, ent.pos.z, 30, 130 / 180 * math.pi, ent.pos.h - math.pi / 2, 8500, true)\n\nself.used = true",
							conditions = 
							{
								
								{
									"daf7d11d-ad23-a9dd-9991-9a8accdd9e89",
									true,
								},
							},
							name = "前/后",
							uuid = "28014e9c-69b5-cc17-a02c-aa5e52311cfb",
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
							eventSpellID = 31644,
							eventSpellName = "-1",
							name = "sides",
							uuid = "e2e7ea69-74c3-5fa7-8323-d6e1d280d707",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							eventArgType = 2,
							eventSpellID = 31643,
							eventSpellName = "-1",
							name = "front back",
							uuid = "daf7d11d-ad23-a9dd-9991-9a8accdd9e89",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 927.8,
				name = "P5_3运绘制波动炮",
				timeRange = true,
				timelineIndex = 189,
				timerStartOffset = -20,
				uuid = "62e6d5a9-64d0-00fe-a44a-3639ee241e7e",
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
							actionLua = "local alpha = 0.4\nlocal drawer = Argus2.ShapeDrawer:new(\n    (GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 255 / 255, alpha)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 255 / 255, 0 / 255, alpha)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, alpha)),\n    (GUI:ColorConvertFloat4ToU32(255 / 255, 0 / 255, 0 / 255, 0.85)),\n    1\n)\n\nif data.p5trio3maleID == nil then\n    data.p5trio3maleID = {}\nend\nif data.p5trio3femaleID == nil then\n    data.p5trio3femaleID = {}\nend\n\nfor k, v in pairs(TensorCore.entityList(\"alive,contentid=12257\")) do\n    if Argus.getEntityModel(v) == 15721 then\n        --male\n        if Argus.isEntityVisible(v) then\n            local id, flag = Argus.getEntityTransforms(v.id)\n            if flag == 16 then\n                --circle\n                if not table.contains(data.p5trio3maleID, v.id) then\n                    d('钢铁')\n                    if table.size(data.p5trio3maleID) < 1 then\n                        drawer:addTimedCircle(12500, v.pos.x, v.pos.y, v.pos.z, 10, 0, true)\n                    else\n                        drawer:addTimedCircle(4000, v.pos.x, v.pos.y, v.pos.z, 10, 8500, true)\n                    end\n                    table.insert(data.p5trio3maleID, v.id)\n                end\n            elseif flag == 49 then\n                --donut\n                if not table.contains(data.p5trio3maleID, v.id) then\n                    d('月环')\n                    if table.size(data.p5trio3maleID) < 1 then\n                        drawer:addTimedDonut(12500, v.pos.x, v.pos.y, v.pos.z, 10, 50, 0, true)\n                    else\n                        drawer:addTimedDonut(4000, v.pos.x, v.pos.y, v.pos.z, 10, 50, 8500, true)\n                    end\n                    table.insert(data.p5trio3maleID, v.id)\n                end\n            end\n        end\n    end\nend\n\nfor k, v in pairs(TensorCore.entityList(\"alive,contentid=12258\")) do\n    if Argus.getEntityModel(v) == 15722 then\n        --female\n        if Argus.isEntityVisible(v) then\n            local id, flag = Argus.getEntityTransforms(v.id)\n            if flag == 16 then\n                --cross\n                if not table.contains(data.p5trio3femaleID, v.id) then\n                    d('十字')\n                    if table.size(data.p5trio3femaleID) < 1 then\n                        drawer:addTimedCross(12500, v.pos.x, v.pos.y, v.pos.z, 50, 10, v.pos.h, 0, true)\n                    else\n                        drawer:addTimedCross(4000, v.pos.x, v.pos.y, v.pos.z, 50, 10, v.pos.h, 8500, true)\n                    end\n                    table.insert(data.p5trio3femaleID, v.id)\n                end\n            elseif flag == 49 then\n                --in\n                if not table.contains(data.p5trio3femaleID, v.id) then\n                    d('脚刀')\n                    local left = TensorCore.getPosInDirection(v.pos, v.pos.h + math.pi / 2, 4)\n                    local right = TensorCore.getPosInDirection(v.pos, v.pos.h - math.pi / 2, 4)\n                    if table.size(data.p5trio3femaleID) < 1 then\n                        drawer:addTimedRect(12500, left.x, left.y, left.z, 20, 60, v.pos.h + math.pi / 2, 0, true)\n                        drawer:addTimedRect(12500, right.x, right.y, right.z, 20, 60, v.pos.h - math.pi / 2, 0, true)\n                    else\n                        drawer:addTimedRect(4000, left.x, left.y, left.z, 20, 60, v.pos.h + math.pi / 2, 8500, true)\n                        drawer:addTimedRect(4000, right.x, right.y, right.z, 20, 60, v.pos.h - math.pi / 2, 8500, true)\n                    end\n                    table.insert(data.p5trio3femaleID, v.id)\n                end\n            end\n        end\n    end\nend\nif table.size(data.p5trio3femaleID) + table.size(data.p5trio3maleID) == 4 then\n    self.used = true\nend",
							uuid = "52fa6372-f8d2-7f3c-98fe-ba629702f9ba",
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
							conditionLua = "return data.p5trio3startdraw ~= nil and data.p5trio3startdraw == true",
							dequeueIfLuaFalse = true,
							uuid = "5b816586-67e9-d347-a1f9-d777ca903b8a",
							version = 2,
						},
					},
				},
				mechanicTime = 927.8,
				name = "P5_3运绘制男女",
				timeRange = true,
				timelineIndex = 189,
				timerEndOffset = 60,
				timerStartOffset = -60,
				uuid = "4e028bc4-a550-70e9-be0b-7c95e6c1f606",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[195] = 
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
							actionLua = "local drawTime = 9000 -- 绘制持续时间\nlocal basePos = { x = 100, y = 0, z = 100 }\nlocal TvHeading\nif TensorCore.isAnyEntityCasting(31638) then --右刀读条\n    TvHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, { x = 120, y = 0, z = 100 })\nelse                                         -- 没有就是左刀\n    TvHeading = TensorCore.getHeadingToTarget({ x = 100, y = 0, z = 100 }, { x = 80, y = 0, z = 100 })\nend\n\n-- 攻击1\nlocal atk1 = TensorCore.getPosInDirection(basePos, TvHeading + (math.pi / 2 + math.pi / 72), 19.5)\n-- 攻击2\nlocal atk2 = TensorCore.getPosInDirection(basePos, TvHeading - (math.pi / 2 + math.pi / 72), 19.5)\n-- 锁链1\nlocal bind1 = TensorCore.getPosInDirection(basePos, TvHeading + (math.pi / 2 + math.pi / 72), 9.5)\n-- 禁止1\nlocal stop1 = TensorCore.getPosInDirection(basePos, TvHeading + (math.pi / 4), 14)\n-- 禁止2\nlocal stop2 = TensorCore.getPosInDirection(basePos, TvHeading - (math.pi / 4), 14)\n-- 锁链2\nlocal bind2 = TensorCore.getPosInDirection(basePos, TvHeading + (math.pi * 7 / 8), 19.5)\n-- 攻击3\nlocal atk3 = TensorCore.getPosInDirection(basePos, TvHeading - (math.pi * 19 / 20), 12)\n-- 攻击4\nlocal atk4 = TensorCore.getPosInDirection(basePos, TvHeading - (math.pi * 11 / 12), 19.5)\n\nlocal allPos = {}\ntable.insert(allPos, { pos = atk1, type = 1 })\ntable.insert(allPos, { pos = atk2, type = 1 })\ntable.insert(allPos, { pos = atk3, type = 1 })\ntable.insert(allPos, { pos = atk4, type = 1 })\ntable.insert(allPos, { pos = bind1, type = 2 })\ntable.insert(allPos, { pos = bind2, type = 2 })\ntable.insert(allPos, { pos = stop1, type = 3 })\ntable.insert(allPos, { pos = stop2, type = 3 })\n\n-- 获取当前的标点\nlocal myMarker = TensorCore.mGetPlayer().marker\nlocal myIndex\nif myMarker == 1 then --攻击1\n    myIndex = 1\nelseif myMarker == 2 then -- 攻击2\n    myIndex = 2\nelseif myMarker == 3 then -- 攻击3\n    myIndex = 3\nelseif myMarker == 4 then -- 攻击4\n    myIndex = 4\nelseif myMarker == 6 then -- 锁链1\n    myIndex = 5\nelseif myMarker == 7 then -- 锁链2\n    myIndex = 6\nelseif myMarker == 9 then -- 禁止1\n    myIndex = 7\nelseif myMarker == 10 then -- 禁止2\n    myIndex = 8\nend\n\nfor i = 1, #allPos do\n    local pos = allPos[i].pos\n    if i == myIndex then\n        MuAiGuide.DirectTo(pos.x, pos.z, drawTime)\n    end\n    if data.DrawAllPos then\n        local type = allPos[i].type\n        local color\n        if type == 1 then\n            MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime, 0.8, 255, 255, 0)\n        elseif type == 2 then\n            MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime, 0.8, 255, 0, 255)\n        elseif type == 3 then\n            MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime, 0.8, 255, 0, 0)\n        end\n    end\nend\nself.used = true",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "fa5b7430-d671-a967-bccf-36229d4919d3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 946.4,
				name = "P5_3传指路",
				timelineIndex = 195,
				timerOffset = -9,
				uuid = "187f183e-cd19-404c-80b8-6fbaa8267b2a",
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
							actionLua = "local drawTime = 8000\n\nlocal basePos = { x = 100, y = 0, z = 100 }\nlocal oemga\nfor _, ent in pairs(TensorCore.entityList(\"contentid=7695\")) do\n    if Argus.isEntityVisible(ent) then\n        TensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0 / 255, 255 / 255, 0 / 255, 0.5), 1)\n            :addTimedArrowOnEnt(drawTime, TensorCore.mGetPlayer().id, 1, 0.5, 1, 1, ent.id, 0, true)\n        oemga = ent.pos\n        break\n    end\nend\nlocal heading = TensorCore.getHeadingToTarget(basePos, oemga)\n-- 攻击1\nlocal atk1 = TensorCore.getPosInDirection(basePos, heading + (math.pi / 2), 19.5)\n-- 攻击2\nlocal atk2 = TensorCore.getPosInDirection(basePos, heading - (math.pi / 2), 19.5)\n-- 锁链1\nlocal bind1 = TensorCore.getPosInDirection(basePos, heading + (math.pi / 2), 9.3)\n-- 禁止1\nlocal stop1 = TensorCore.getPosInDirection(basePos, heading + (math.pi / 5), 19.5)\n-- 禁止2\nlocal stop2 = TensorCore.getPosInDirection(basePos, heading - (math.pi / 5), 19.5)\n-- 锁链2\nlocal bind2 = TensorCore.getPosInDirection(basePos, heading + (math.pi * 7 / 8), 19.5)\n-- 攻击3\nlocal atk3 = TensorCore.getPosInDirection(basePos, heading - (math.pi * 19 / 20), 12)\n-- 攻击4\nlocal atk4 = TensorCore.getPosInDirection(basePos, heading - (math.pi * 11 / 12), 19.5)\n\nlocal allPos = {}\ntable.insert(allPos, { pos = atk1, type = 1 })\ntable.insert(allPos, { pos = atk2, type = 1 })\ntable.insert(allPos, { pos = atk3, type = 1 })\ntable.insert(allPos, { pos = atk4, type = 1 })\ntable.insert(allPos, { pos = bind1, type = 2 })\ntable.insert(allPos, { pos = bind2, type = 2 })\ntable.insert(allPos, { pos = stop1, type = 3 })\ntable.insert(allPos, { pos = stop2, type = 3 })\n\n-- 获取当前的标点\nlocal myMarker = TensorCore.mGetPlayer().marker\nlocal myIndex\nif myMarker == 1 then --攻击1\n    myIndex = 1\nelseif myMarker == 2 then -- 攻击2\n    myIndex = 2\nelseif myMarker == 3 then -- 攻击3\n    myIndex = 3\nelseif myMarker == 4 then -- 攻击4\n    myIndex = 4\nelseif myMarker == 6 then -- 锁链1\n    myIndex = 5\nelseif myMarker == 7 then -- 锁链2\n    myIndex = 6\nelseif myMarker == 9 then -- 禁止1\n    myIndex = 7\nelseif myMarker == 10 then -- 禁止2\n    myIndex = 8\nend\n\nfor i = 1, #allPos do\n    local pos = allPos[i].pos\n    if i == myIndex then\n        MuAiGuide.DirectTo(pos.x, pos.z, drawTime)\n    end\n    if data.DrawAllPos then\n        local type = allPos[i].type\n        if type == 1 then\n            MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime, 0.8, 255, 255, 0)\n        elseif type == 2 then\n            MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime, 0.8, 255, 0, 255)\n        elseif type == 3 then\n            MuAiGuide.DrawCircleFloor(pos.x, pos.z, drawTime, 0.8, 255, 0, 0)\n        end\n    end\nend\nself.used = true",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "ba34a31d-c5ca-5c6b-84c1-432636fe2a2e",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 961.6,
				name = "P5_4传指路",
				timelineIndex = 199,
				timerOffset = -9,
				uuid = "bd3e2615-9435-837d-b48a-939b0d21fe4e",
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
							aType = "Lua",
							actionLua = "if not data.P6ArrowFireInit then\n    data.p6ArrowStayOut = {}\n    data.p6ArrowStayIn = {}\n\n    data.P6OutA1 = {}\n    data.P6OutDpsA2 = {}\n    data.P6OutDpsA3 = {}\n    data.P6OutDpsA4 = {}\n\n    data.P6OutTHA2 = {}\n    data.P6OutTHA3 = {}\n    data.P6OutTHA4 = {}\n\n    data.P6InA1 = {}\n\n    data.P6InDpsA2 = {}\n    data.P6InDpsA3 = {}\n\n    data.P6InTHA2 = {}\n    data.P6InTHA3 = {}\n    data.P6InTHA4 = {}\n\n    local midPos = { x = 100, z = 100 }\n    local mid2A = TensorCore.getHeadingToTarget(midPos, { x = 100, y = 0, z = 80 })\n\n    for i = 1, 4, 1 do\n        local stayPosOut = TensorCore.getPosInDirection(midPos, mid2A - math.pi * (2 * i - 1) / 4, 12)\n        local stayPosIn = TensorCore.getPosInDirection(midPos, mid2A - math.pi * (2 * i - 1) / 4, 8)\n        table.insert(data.p6ArrowStayOut, stayPosOut)\n        table.insert(data.p6ArrowStayIn, stayPosIn)\n\n        local posA1Out = TensorCore.getPosInDirection(midPos, mid2A - math.pi * (2 * i - 1) / 4, 16)\n        local posA1In = TensorCore.getPosInDirection(midPos, mid2A - math.pi * (2 * i - 1) / 4, 5)\n        local posA2OutTh = TensorCore.getPosInDirection(midPos, mid2A - math.pi * (2 * i - 1) / 4 - math.pi / 15, 10.5)\n        local THEndLast2 = TensorCore.getPosInDirection(midPos, mid2A - math.pi * i / 2, 12.5)\n        local THEnd = TensorCore.getPosInDirection(midPos, mid2A - math.pi * i / 2, 8)\n\n        table.insert(data.P6OutA1, posA1Out)      -- 1穿外\n        -- DPS 路线\n        table.insert(data.P6OutDpsA2, stayPosOut) -- 3穿内\n        table.insert(data.P6OutDpsA3, posA1Out)   -- 4穿外\n        table.insert(data.P6OutDpsA4, stayPosOut) -- 5穿内\n        -- TH 路线\n        table.insert(data.P6OutTHA2, posA2OutTh)  -- 3穿内贴正点\n        table.insert(data.P6OutTHA3, THEndLast2)  -- 4穿正点\n        table.insert(data.P6OutTHA4, THEnd)       -- 5穿正点内\n\n        table.insert(data.P6InA1, posA1In)        -- 1穿内\n        -- DPS 路线\n        table.insert(data.P6InDpsA2, posA1Out)    -- 3穿外\n        table.insert(data.P6InDpsA3, stayPosOut)  -- 6穿内\n        -- TH 路线\n        table.insert(data.P6InTHA2, posA2OutTh)   -- 3穿外贴正点\n        table.insert(data.P6InTHA3, THEndLast2)   -- 5穿正点\n        table.insert(data.P6InTHA4, THEnd)        -- 6穿正点内\n    end\n\n    data.P6ArrowFireInit = true\nend\nself.used = true\n",
							uuid = "adcd9a90-ed6b-7a36-82e2-4a1c2ca8b7eb",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1182.2,
				name = "天箭点初始化",
				timelineIndex = 219,
				timerOffset = -15,
				uuid = "14418b80-6270-ea55-8393-26afa1467db9",
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
							actionLua = "local arrowPos = TensorCore.mGetEntity(eventArgs.entityID).pos\nif data.P6FirstArrow == nil then  \n    local disSqrType = (arrowPos.x - 100) ^ 2 + (arrowPos.z - 100) ^ 2\n    local player = TensorCore.mGetPlayer()\n    local list\n    if disSqrType > 500 then\n        list = data.p6ArrowStayOut\n        data.P6FirstArrow = 1 --外\n    else\n        list = data.p6ArrowStayIn\n        data.P6FirstArrow = 2 --内\n    end\n    local index = 1\n    local minDisSqr = (player.pos.x - list[1].x) ^ 2 + (player.pos.z - list[1].z) ^ 2\n    -- 获取最近的点stay点\n    for i = 2, 4, 1 do\n        local curSqr = (player.pos.x - list[i].x) ^ 2 + (player.pos.z - list[i].z) ^ 2\n        if curSqr < minDisSqr then\n            index = i\n            minDisSqr = curSqr\n        end\n    end\n    data.P6FirstArrowIdx = index\n    MuAiGuide.DirectTo(list[index].x, list[index].z, 7000)\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"4b5958d8-2f4e-25c3-8d4a-dc9aef3d6e01",
									true,
								},
							},
							uuid = "9aa97312-8414-bbc4-aa1c-b477225b1c57",
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
							eventSpellID = 31651,
							uuid = "4b5958d8-2f4e-25c3-8d4a-dc9aef3d6e01",
							version = 2,
						},
					},
				},
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 1182.2,
				name = "宇宙天箭指路0",
				randomOffset = 20,
				timeRange = true,
				timelineIndex = 219,
				timerEndOffset = 20,
				timerOffset = -20,
				timerStartOffset = -20,
				uuid = "eefd2291-d1f4-9610-ac84-d4636a23088d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "--[[\n    1地火，内穿 外穿外\n]]\nlocal p\nif data.P6FirstArrow == 1 then\n    p = data.P6OutA1[data.P6FirstArrowIdx]\nelseif data.P6FirstArrow == 2 then\n    p = data.P6InA1[data.P6FirstArrowIdx]\nend\nMuAiGuide.DirectTo(p.x, p.z, 2000)\nself.used = true\n",
							uuid = "b737fe7a-5425-8ae6-890d-c8af2cd54861",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1182.2,
				name = "宇宙天箭指路1",
				timelineIndex = 219,
				timerOffset = -0.69999998807907,
				uuid = "bed02b24-68ac-e807-ba9e-eba74079af06",
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
				enabled = false,
				mechanicTime = 1182.2,
				name = "宇宙天箭指路2（占位）",
				timelineIndex = 219,
				timerOffset = 2,
				uuid = "42698f9a-92cb-0e26-a665-a207c12e8bdb",
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
							actionLua = "--[[\n    3地火\n        1.外地火穿内\n        2.内地火穿外\n]] \nlocal p\nlocal player = TensorCore.mGetPlayer()\nif data.P6FirstArrow == 1 then\n    if MuAiGuide.IsDps(player.job) then\n        p = data.P6OutDpsA2[data.P6FirstArrowIdx] -- 穿内\n    else\n        p = data.P6OutTHA2[data.P6FirstArrowIdx] -- 穿内贴正点\n    end\nelseif data.P6FirstArrow == 2 then\n    if MuAiGuide.IsDps(player.job) then\n        p = data.P6InDpsA2[data.P6FirstArrowIdx] -- 穿外\n    else\n        p = data.P6InTHA2[data.P6FirstArrowIdx] -- 穿外贴正点\n    end\nend\nMuAiGuide.DirectTo(p.x, p.z, 2000)\nself.used = true\n",
							uuid = "b737fe7a-5425-8ae6-890d-c8af2cd54861",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1182.2,
				name = "宇宙天箭指路3",
				timelineIndex = 219,
				timerOffset = 3.2999999523163,
				uuid = "5517525f-d68b-a4c2-b083-6916546053a3",
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
							actionLua = "--[[\n    4地火，外地火穿外，内不动\n]]\nlocal p\nlocal player = TensorCore.mGetPlayer()\nif data.P6FirstArrow == 1 then\n    if MuAiGuide.IsDps(player.job) then\n        p = data.P6OutDpsA3[data.P6FirstArrowIdx] -- 穿外\n    else\n        p = data.P6OutTHA3[data.P6FirstArrowIdx] -- 穿正点\n    end\n    MuAiGuide.DirectTo(p.x, p.z, 2000)\nelseif data.P6FirstArrow == 2 then\n  -- 啥都不做\nend\nself.used = true\n",
							uuid = "b737fe7a-5425-8ae6-890d-c8af2cd54861",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1182.2,
				name = "宇宙天箭指路4",
				timelineIndex = 219,
				timerOffset = 5.3000001907349,
				uuid = "9641a15f-e151-d38d-bd3e-96f96b71619d",
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
							actionLua = "--[[\n    5地火，\n    1.外地火D穿内TN穿END\n    2.内地火D不动TN穿正点\n]]\nlocal p\nlocal player = TensorCore.mGetPlayer()\nif data.P6FirstArrow == 1 then\n    if MuAiGuide.IsDps(player.job) then\n        p = data.P6OutDpsA4[data.P6FirstArrowIdx] -- 穿内\n    else\n        p = data.P6OutTHA4[data.P6FirstArrowIdx] -- 穿END\n    end\n    MuAiGuide.DirectTo(p.x, p.z, 2000)\nelseif data.P6FirstArrow == 2 then\n    if not MuAiGuide.IsDps(player.job) then\n        p = data.P6InTHA3[data.P6FirstArrowIdx] -- 穿正点\n        MuAiGuide.DirectTo(p.x, p.z, 2000)\n    end\nend\nself.used = true\n",
							uuid = "d2e22721-5581-aad6-954c-e016a9709576",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1182.2,
				name = "宇宙天箭指路5",
				timelineIndex = 219,
				timerOffset = 7.3000001907349,
				uuid = "f5ac3f08-31df-4468-ba21-1a2ce4222b45",
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
							actionLua = "--[[\n    6地火，\n    1.外地火：不动\n    2.内地火：D穿内TN穿正点\n]]\nlocal p\nlocal player = TensorCore.mGetPlayer()\nif data.P6FirstArrow == 1 then\n    -- 啥都不做\nelseif data.P6FirstArrow == 2 then\n    if MuAiGuide.IsDps(player.job) then\n        p = data.P6InDpsA3[data.P6FirstArrowIdx] --穿进去\n    else\n        p = data.P6InTHA4[data.P6FirstArrowIdx] -- 穿END\n    end\n    MuAiGuide.DirectTo(p.x, p.z, 2000)\nend\nself.used = true\n",
							uuid = "02ccf6c4-073a-1293-96c5-a29923b0c6b4",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1182.2,
				name = "宇宙天箭指路6",
				timelineIndex = 219,
				timerOffset = 9.3000001907349,
				uuid = "3895475c-e49a-1c8b-8396-650b5be4c056",
				version = 2,
			},
		},
	},
	[224] = 
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
							actionLua = "MuAiGuide.DirectTo(100, 100, 5000)\nself.used = true",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "e2367d1a-61a5-a7c6-b2a8-d38d5ca63d92",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1207,
				name = "Go to Mid",
				timelineIndex = 224,
				timerOffset = 3,
				uuid = "72275ec6-388c-d1c8-89ea-477123e2cb1e",
				version = 2,
			},
		},
	},
	[227] = 
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
							actionLua = "if data.p6exaspots == nil then data.p6exaspots = {} end\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nlocal heading = TensorCore.getHeadingToTarget(ent.pos, {x=100,y=0,z=100})\nlocal pos = TensorCore.getPosInDirection(ent.pos, heading, 9)\ntable.insert(data.p6exaspots,pos)\nself.used = true",
							conditions = 
							{
								
								{
									"abe7e47a-539c-7c8d-b900-6087d938f5eb",
									true,
								},
							},
							uuid = "62d4241e-4496-2690-81a4-db47bf3006e2",
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
							eventSpellID = 31661,
							uuid = "abe7e47a-539c-7c8d-b900-6087d938f5eb",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1215.4,
				name = "get exa pos",
				timeRange = true,
				timelineIndex = 227,
				timerEndOffset = 5,
				timerStartOffset = -15,
				uuid = "6b2cf48c-2a17-de33-b05a-5ec6c281d2e6",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local pos1 = data.p6exaspots[1]\nlocal pos2 = data.p6exaspots[2]\nlocal center = {x = 100,y=0,z=100}\nlocal cross = (pos1.x - 100) * (pos2.z-100) - (pos1.z-100) * (pos2.x-100)\nif cross > 0 then\n    pos1 = TensorCore.rotatePosAroundPos(center, pos1, math.pi/4+22.5/180*math.pi)\n    pos2 = TensorCore.rotatePosAroundPos(center, pos2, math.pi/4+22.5/180*math.pi)\nelse\n    pos1 = TensorCore.rotatePosAroundPos(center, pos1, -math.pi/4-22.5/180*math.pi)\n    pos2 = TensorCore.rotatePosAroundPos(center, pos2, -math.pi/4-22.5/180*math.pi)\nend\nlocal heading = TensorCore.getHeadingToTarget(pos1, pos2)\nTensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0/255, 255/255, 0/255, .25),2):addTimedArrow(10000, pos1.x, pos1.y, pos1.z, heading, 3, 1, 2, 2, 0, true)\nlocal heading2 = TensorCore.getHeadingToTarget(center, pos1)\nTensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0/255, 255/255, 0/255, .25),2):addTimedArrow(10000, center.x, center.y, center.z, heading2, 8, 1, 2, 2, 0, true)\ndata.p6exaspots = nil\nself.used = true\n",
							conditions = 
							{
								
								{
									"40a4dcda-11dd-266a-b307-58516db08544",
									true,
								},
							},
							uuid = "61076d2b-444c-8043-9431-8e8e4ab4aaa6",
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
							conditionLua = "return data.p6exaspots ~= nil and table.size(data.p6exaspots) == 4",
							uuid = "40a4dcda-11dd-266a-b307-58516db08544",
							version = 2,
						},
					},
				},
				mechanicTime = 1215.4,
				name = "draw arrow",
				timeRange = true,
				timelineIndex = 227,
				timerEndOffset = 5,
				timerStartOffset = -15,
				uuid = "23186db4-eace-4604-973b-b173b9e1e565",
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
							aType = "Lua",
							actionLua = "local drawTime = 6500\nlocal player = TensorCore.mGetPlayer()\nlocal groupPos = data.TopJobOrder[player.job]\nif groupPos == 1 then\n    MuAiGuide.DirectTo(91, 100, drawTime)      -- H1\nelseif groupPos == 2 then\n    MuAiGuide.DirectTo(100, 91, drawTime)      -- MT\nelseif groupPos == 3 then\n    MuAiGuide.DirectTo(109, 100, drawTime)    -- ST\nelseif groupPos == 4 then\n    MuAiGuide.DirectTo(93.5, 106.5, drawTime)  -- D1\nelseif groupPos == 5 then\n    MuAiGuide.DirectTo(106.5, 106.5, drawTime) -- D2\nelseif groupPos == 6 then\n    MuAiGuide.DirectTo(93.5, 93.5, drawTime)   -- D3\nelseif groupPos == 7 then\n    MuAiGuide.DirectTo(106.5, 93.5, drawTime)  -- D4\nelseif groupPos == 8 then\n    MuAiGuide.DirectTo(100, 109, drawTime)  -- H2\nend\nself.used = true\n",
							gVar = "ACR_RikuMNK2_CD",
							uuid = "2a7a3b98-b806-664b-a077-7ef1571cbfc6",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1236,
				name = "p6第一次8方",
				timelineIndex = 234,
				timerOffset = -5,
				uuid = "c050cd90-57ed-215b-b838-f52034d5beec",
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
							aType = "Lua",
							actionLua = "MuAiGuide.DirectTo(100, 113, 4000, 0.5)\nself.used = true",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "6f44731a-4583-8430-aca5-3c6879f01708",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1238,
				name = "1档",
				timelineIndex = 235,
				uuid = "cc4d5d05-7ef6-e047-bce2-f83e666f5856",
				version = 2,
			},
		},
	},
	[239] = 
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
							actionLua = "local drawTime = 4000\nlocal player = TensorCore.mGetPlayer()\nlocal groupPos = data.TopJobOrder[player.job]\nif groupPos == 1 then\n    MuAiGuide.DirectTo(87, 100, drawTime)      -- H1\nelseif groupPos == 2 then\n    MuAiGuide.DirectTo(100, 87, drawTime)      -- MT\nelseif groupPos == 3 then\n    MuAiGuide.DirectTo(113, 100, drawTime)     -- ST\nelseif groupPos == 4 then\n    MuAiGuide.DirectTo(92, 108, drawTime)  -- D1\nelseif groupPos == 5 then\n    MuAiGuide.DirectTo(108, 108, drawTime) -- D2\nelseif groupPos == 6 then\n    MuAiGuide.DirectTo(92, 92, drawTime)   -- D3\nelseif groupPos == 7 then\n    MuAiGuide.DirectTo(108, 92, drawTime)  -- D4\nelseif groupPos == 8 then\n    MuAiGuide.DirectTo(100, 113, drawTime)     -- H2\nend\nself.used = true",
							conditions = 
							{
								
								{
									"52fd67eb-4645-cf08-a7f8-55d487564b5e",
									true,
								},
							},
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "81a4ec03-5441-5266-a43a-82893301fbe3",
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
							conditionLua = "return data.TopJobOrder[player.job] > 3 and data.TopJobOrder[player.job] < 8\n",
							uuid = "52fd67eb-4645-cf08-a7f8-55d487564b5e",
							version = 2,
						},
					},
				},
				mechanicTime = 1249.3,
				name = "8方去自己点",
				timelineIndex = 239,
				timerOffset = 3,
				uuid = "8765c620-f1f8-8278-9737-118bbcb95717",
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
							aType = "Lua",
							actionLua = "local arrowPos = TensorCore.mGetEntity(eventArgs.entityID).pos\nif data.P6SecondArrow == nil then\n    local disSqrType = (arrowPos.x - 100) ^ 2 + (arrowPos.z - 100) ^ 2\n    local player = TensorCore.mGetPlayer()\n    local list\n    if disSqrType > 500 then\n        list = data.p6ArrowStayOut\n        data.P6SecondArrow = 1 --外\n    else\n        list = data.p6ArrowStayIn\n        data.P6SecondArrow = 2 --内\n    end\n    local groupPos = data.TopJobOrder[player.job]\n    if groupPos == 1 or groupPos == 4 then      -- H1 D1\n        data.P6SecondArrowIdx = 3\n    elseif groupPos == 2 or groupPos == 6 then  -- MT D3\n        data.P6SecondArrowIdx = 4\n    elseif groupPos == 3 or groupPos == 7 then  -- ST D4\n        data.P6SecondArrowIdx = 1\n    elseif groupPos == 5 or groupPos == 8 then  -- H2 D2\n        data.P6SecondArrowIdx = 2\n    end\n    MuAiGuide.DirectTo(list[data.P6SecondArrowIdx].x, list[data.P6SecondArrowIdx].z, 6000)\nend\n",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "9aa97312-8414-bbc4-aa1c-b477225b1c57",
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
							eventSpellID = 31651,
							uuid = "4b5958d8-2f4e-25c3-8d4a-dc9aef3d6e01",
							version = 2,
						},
					},
				},
				enabled = false,
				eventType = 3,
				mechanicTime = 1258.7,
				name = "宇宙天箭指路",
				randomOffset = 20,
				timelineIndex = 242,
				timerOffset = -20,
				uuid = "fc7bf005-5027-e813-88dc-7f6adfa0f94a",
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
							actionLua = "--[[\n    1地火，内穿 外穿外\n]]\nlocal p\nif data.P6FirstArrow == 1 then\n    p = data.P6OutA1[data.P6SecondArrowIdx]\nelseif data.P6FirstArrow == 2 then\n    p = data.P6InA1[data.P6SecondArrowIdx]\nend\nMuAiGuide.DirectTo(p.x, p.z, 2000)\nself.used = true\n",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "b737fe7a-5425-8ae6-890d-c8af2cd54861",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1258.7,
				name = "宇宙天箭指路1",
				timelineIndex = 242,
				timerOffset = -0.69999998807907,
				uuid = "4c742387-a25f-cfb8-bc0e-b8f65ef82635",
				version = 2,
			},
			inheritedIndex = 2,
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
				mechanicTime = 1258.7,
				name = "宇宙天箭指路2（占位）",
				timelineIndex = 242,
				timerOffset = 2,
				uuid = "5a633deb-959f-5a80-b496-a5d44914f4e6",
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
							actionLua = "--[[\n    3地火\n        1.外地火穿内\n        2.内地火穿外\n]] \nlocal p\nlocal player = TensorCore.mGetPlayer()\nif data.P6FirstArrow == 1 then\n    if MuAiGuide.IsDps(player.job) then\n        p = data.P6OutDpsA2[data.P6SecondArrowIdx] -- 穿内\n    else\n        p = data.P6OutTHA2[data.P6SecondArrowIdx] -- 穿内贴正点\n    end\nelseif data.P6FirstArrow == 2 then\n    if MuAiGuide.IsDps(player.job) then\n        p = data.P6InDpsA2[data.P6SecondArrowIdx] -- 穿外\n    else\n        p = data.P6InTHA2[data.P6SecondArrowIdx] -- 穿外贴正点\n    end\nend\nd(data.TopJobOrder[player.job])\nself.used = true\n",
							gVar = "ACR_TensorMagnum2_CD",
							uuid = "b737fe7a-5425-8ae6-890d-c8af2cd54861",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1258.7,
				name = "宇宙天箭指路3",
				timelineIndex = 242,
				timerOffset = 3.2999999523163,
				uuid = "f526ba6a-e238-faa7-9d5e-afc1d531d346",
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
							actionLua = "--[[\n    4地火，外地火穿外，内不动\n]]\nlocal p\nlocal player = TensorCore.mGetPlayer()\nif data.P6FirstArrow == 1 then\n    if MuAiGuide.IsDps(player.job) then\n        p = data.P6OutDpsA3[data.P6SecondArrowIdx] -- 穿外\n    else\n        p = data.P6OutTHA3[data.P6SecondArrowIdx] -- 穿正点\n    end\n    MuAiGuide.DirectTo(p.x, p.z, 2000)\nelseif data.P6FirstArrow == 2 then\n  -- 啥都不做\nend\nself.used = true\n",
							uuid = "b737fe7a-5425-8ae6-890d-c8af2cd54861",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1258.7,
				name = "宇宙天箭指路4",
				timelineIndex = 242,
				timerOffset = 5.3000001907349,
				uuid = "d1a41824-7b18-15ea-af6a-aa977b4dfda3",
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
							actionLua = "--[[\n    5地火，\n    1.外地火D穿内TN穿END\n    2.内地火D不动TN穿正点\n]]\nlocal p\nlocal player = TensorCore.mGetPlayer()\nif data.P6FirstArrow == 1 then\n    if MuAiGuide.IsDps(player.job) then\n        p = data.P6OutDpsA4[data.P6SecondArrowIdx] -- 穿内\n    else\n        p = data.P6OutTHA4[data.P6SecondArrowIdx] -- 穿END\n    end\n    MuAiGuide.DirectTo(p.x, p.z, 2000)\nelseif data.P6FirstArrow == 2 then\n    if not MuAiGuide.IsDps(player.job) then\n        p = data.P6InTHA3[data.P6SecondArrowIdx] -- 穿正点\n        MuAiGuide.DirectTo(p.x, p.z, 2000)\n    end\nend\nself.used = true\n",
							uuid = "d2e22721-5581-aad6-954c-e016a9709576",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1258.7,
				name = "宇宙天箭指路5",
				timelineIndex = 242,
				timerOffset = 7.3000001907349,
				uuid = "573b8f06-5d4c-ad6e-9f2a-49d4265ac2d4",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "--[[\n    6地火，\n    1.外地火：不动\n    2.内地火：D穿内TN穿正点\n]]\nlocal p\nlocal player = TensorCore.mGetPlayer()\nif data.P6FirstArrow == 1 then\n    -- 啥都不做\nelseif data.P6FirstArrow == 2 then\n    if MuAiGuide.IsDps(player.job) then\n        p = data.P6InDpsA3[data.P6SecondArrowIdx] --穿进去\n    else\n        p = data.P6InTHA4[data.P6SecondArrowIdx] -- 穿END\n    end\n    MuAiGuide.DirectTo(p.x, p.z, 2000)\nend\nself.used = true\n",
							uuid = "02ccf6c4-073a-1293-96c5-a29923b0c6b4",
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1258.7,
				name = "宇宙天箭指路6",
				timelineIndex = 242,
				timerOffset = 9.3000001907349,
				uuid = "132bbbea-274a-5fbc-8dea-0961a8e64626",
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
							actionLua = "MuAiGuide.DirectTo(100, 113, 4000)\nself.used = true",
							uuid = "c8525169-da67-c1ff-8db3-1dea72a79015",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1271.9,
				name = "Go to C",
				timelineIndex = 244,
				uuid = "b771e6ec-429f-ac38-8650-ebb651efe123",
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
							aType = "Lua",
							actionLua = "MuAiGuide.DirectTo(100, 100, 5000)\nself.used = true",
							uuid = "e2367d1a-61a5-a7c6-b2a8-d38d5ca63d92",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1283.2,
				name = "Go to Mid",
				timelineIndex = 248,
				timerOffset = 3,
				uuid = "be8d6d5b-2aa7-4f81-9433-c2b573b0e078",
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
							actionLua = "if data.p6exaspots == nil then data.p6exaspots = {} end\nlocal ent = TensorCore.mGetEntity(eventArgs.entityID)\nlocal heading = TensorCore.getHeadingToTarget(ent.pos, {x=100,y=0,z=100})\nlocal pos = TensorCore.getPosInDirection(ent.pos, heading, 9)\ntable.insert(data.p6exaspots,pos)\nself.used = true",
							conditions = 
							{
								
								{
									"abe7e47a-539c-7c8d-b900-6087d938f5eb",
									true,
								},
							},
							uuid = "62d4241e-4496-2690-81a4-db47bf3006e2",
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
							eventSpellID = 31661,
							uuid = "abe7e47a-539c-7c8d-b900-6087d938f5eb",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1291.7,
				name = "get exa pos",
				timeRange = true,
				timelineIndex = 251,
				timerEndOffset = 5,
				timerStartOffset = -15,
				uuid = "75c03b2f-dc71-a15d-8591-a9c58581a305",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local pos1 = data.p6exaspots[1]\nlocal pos2 = data.p6exaspots[2]\nlocal center = {x = 100,y=0,z=100}\nlocal cross = (pos1.x - 100) * (pos2.z-100) - (pos1.z-100) * (pos2.x-100)\nif cross > 0 then\n    pos1 = TensorCore.rotatePosAroundPos(center, pos1, math.pi/4+22.5/180*math.pi)\n    pos2 = TensorCore.rotatePosAroundPos(center, pos2, math.pi/4+22.5/180*math.pi)\nelse\n    pos1 = TensorCore.rotatePosAroundPos(center, pos1, -math.pi/4-22.5/180*math.pi)\n    pos2 = TensorCore.rotatePosAroundPos(center, pos2, -math.pi/4-22.5/180*math.pi)\nend\nlocal heading = TensorCore.getHeadingToTarget(pos1, pos2)\nTensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0/255, 255/255, 0/255, .25),2):addTimedArrow(10000, pos1.x, pos1.y, pos1.z, heading, 3, 1, 2, 2, 0, true)\nlocal heading2 = TensorCore.getHeadingToTarget(center, pos1)\nTensorCore.getStaticDrawer(GUI:ColorConvertFloat4ToU32(0/255, 255/255, 0/255, .25),2):addTimedArrow(10000, center.x, center.y, center.z, heading2, 8, 1, 2, 2, 0, true)\ndata.p6exaspots = nil\nself.used = true\n",
							conditions = 
							{
								
								{
									"40a4dcda-11dd-266a-b307-58516db08544",
									true,
								},
							},
							uuid = "61076d2b-444c-8043-9431-8e8e4ab4aaa6",
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
							conditionLua = "return data.p6exaspots ~= nil and table.size(data.p6exaspots) == 4",
							uuid = "40a4dcda-11dd-266a-b307-58516db08544",
							version = 2,
						},
					},
				},
				mechanicTime = 1291.7,
				name = "draw arrow",
				timeRange = true,
				timelineIndex = 251,
				timerEndOffset = 5,
				timerStartOffset = -15,
				uuid = "e6bf254c-7e03-ad78-b9b3-2096df7c5adc",
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
							actionLua = "MuAiGuide.DirectTo(100, 100, 7000)\nself.used = true",
							uuid = "e2367d1a-61a5-a7c6-b2a8-d38d5ca63d92",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1320.1,
				name = "Go to Mid",
				timelineIndex = 262,
				timerOffset = 3,
				uuid = "5e652990-332e-d997-a888-8df68ff7e63c",
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
							actionLua = "local drawTime = 4000\nlocal player = TensorCore.mGetPlayer()\nlocal groupPos = data.TopJobOrder[player.job]\nif groupPos == 1 then\n    MuAiGuide.DirectTo(87, 100, drawTime)      -- H1\nelseif groupPos == 2 then\n    MuAiGuide.DirectTo(90.8, 90.8, drawTime)   -- D3\nelseif groupPos == 3 then\n    MuAiGuide.DirectTo(113, 100, drawTime)     -- ST\nelseif groupPos == 4 then\n    MuAiGuide.DirectTo(90.8, 109.2, drawTime)  -- D1\nelseif groupPos == 5 then\n    MuAiGuide.DirectTo(109.2, 109.2, drawTime) -- D2\nelseif groupPos == 6 then\n    MuAiGuide.DirectTo(100, 87, drawTime)      -- MT\nelseif groupPos == 7 then\n    MuAiGuide.DirectTo(109.2, 90.8, drawTime)  -- D4\nelseif groupPos == 8 then\n    MuAiGuide.DirectTo(100, 113, drawTime)     -- H2\nend\nself.used = true\n",
							uuid = "d7f1901b-dbd4-5511-b2fe-aaee9d390ba9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 1331.6,
				name = "MTD3换位8方",
				timelineIndex = 265,
				uuid = "e5f68c78-e03e-19c2-a586-4bd71f0f315a",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	mapID = 1122,
	version = 3,
}



return tbl