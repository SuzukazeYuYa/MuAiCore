local tbl = 
{
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"04e3b82f-6f43-20ef-8c84-b5eb7a8a5fd8",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "a3bd7631-8001-0ec5-a9dd-4ef167650c3d",
							variableTogglesType = 3,
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
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinsMite.Target == true",
							name = "罪雷/罪炎",
							uuid = "04e3b82f-6f43-20ef-8c84-b5eb7a8a5fd8",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 24.2,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 7,
				timerStartOffset = -14,
				uuid = "f98343b6-2994-8889-883a-abc59bb6accd",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"d01345a7-ba99-7936-b84a-d6c95d330ddb",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinsMite.Field == true",
							name = "罪雷/罪炎",
							uuid = "d01345a7-ba99-7936-b84a-d6c95d330ddb",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 24.2,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 7,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "a13f699d-a985-8bef-8e03-499bfcbb146a",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 24.2,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 7,
				timerStartOffset = -14,
				uuid = "ccd4b07b-06b2-cbad-9edc-fef7f46318f2",
				version = 2,
			},
		},
	},
	[22] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"04e3b82f-6f43-20ef-8c84-b5eb7a8a5fd8",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "a3bd7631-8001-0ec5-a9dd-4ef167650c3d",
							variableTogglesType = 3,
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
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory1.Target == true\n",
							name = "光焰圆光1",
							uuid = "04e3b82f-6f43-20ef-8c84-b5eb7a8a5fd8",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 85.9,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 22,
				timerStartOffset = -14,
				uuid = "6bfeced7-8e73-d596-ac96-967aa0844904",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"31ab76f4-7187-621e-a662-ed4ce9c463e0",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory1.Field == true\n",
							name = "光焰圆光1",
							uuid = "31ab76f4-7187-621e-a662-ed4ce9c463e0",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 85.9,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 22,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "5b8d5b9f-ae14-e762-bc1d-38617415fc86",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"45b5a263-1078-0c09-a0a3-484e600e9107",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory1.Field == true\n",
							name = "光焰圆光1",
							uuid = "45b5a263-1078-0c09-a0a3-484e600e9107",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 85.9,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 22,
				timerStartOffset = -14,
				uuid = "b521b43b-568a-ecbc-80d6-f8c804ca8312",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"04e3b82f-6f43-20ef-8c84-b5eb7a8a5fd8",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "a3bd7631-8001-0ec5-a9dd-4ef167650c3d",
							variableTogglesType = 3,
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
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory2.Target == true\n",
							name = "光焰圆光1",
							uuid = "04e3b82f-6f43-20ef-8c84-b5eb7a8a5fd8",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 121.1,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 29,
				timerStartOffset = -14,
				uuid = "3c171684-c866-64fd-9541-2fa7f73c3fda",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"31ab76f4-7187-621e-a662-ed4ce9c463e0",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory2.Field == true\n",
							name = "光焰圆光2",
							uuid = "31ab76f4-7187-621e-a662-ed4ce9c463e0",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 121.1,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 29,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "24966034-bb7f-6896-a6ea-78207064945d",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"45e642b8-ea86-a5ac-b8ae-2c3e17b11633",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory2.Field == true\n",
							name = "光焰圆光2",
							uuid = "45e642b8-ea86-a5ac-b8ae-2c3e17b11633",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 121.1,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 29,
				timerStartOffset = -7,
				uuid = "2fe904be-996a-2e45-944a-3874672035c6",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"c058cc26-470e-62db-b9c3-bde9471fad6d",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "9e12b963-6399-416e-8706-3fd2a22c4692",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DiamondDust.Target == true",
							name = "钻石星尘",
							uuid = "c058cc26-470e-62db-b9c3-bde9471fad6d",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 235.3,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 44,
				timerStartOffset = -14.5,
				uuid = "79051607-c524-d348-bb87-8d67a2f4cec7",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"5445b3a1-a843-d27d-9994-c41c0d85fcab",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DiamondDust.Field == true",
							name = "钻石星尘",
							uuid = "5445b3a1-a843-d27d-9994-c41c0d85fcab",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 235.3,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 44,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "70152a4a-af3f-b936-8bd8-f8394fa9959b",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"902e6218-616f-c4ba-bf9f-cf77d14ff1c3",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DiamondDust.Field == true",
							name = "钻石星尘",
							uuid = "902e6218-616f-c4ba-bf9f-cf77d14ff1c3",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 235.3,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 44,
				timerStartOffset = -14,
				uuid = "e2918abe-3b27-ce66-9632-ec260c6933c3",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"5445b3a1-a843-d27d-9994-c41c0d85fcab",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinBound.Field == true",
							name = "罪神圣",
							uuid = "5445b3a1-a843-d27d-9994-c41c0d85fcab",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 259.9,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 57,
				timerOffset = -14,
				timerStartOffset = -10,
				uuid = "88e75b45-9a8b-35f5-8d86-a74b00f6a332",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"e7311729-96d4-eb5d-b5a2-fff96ff5ec9a",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinBound.Field == true",
							name = "罪神圣",
							uuid = "e7311729-96d4-eb5d-b5a2-fff96ff5ec9a",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 259.9,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 57,
				timerStartOffset = -10,
				uuid = "c449219e-80c3-a55e-a348-f8356a79ae8b",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"173a4977-27e4-5e4b-afc9-9c8d70b4464d",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "9e12b963-6399-416e-8706-3fd2a22c4692",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedRay.Target == true\n",
							name = "神圣射线",
							uuid = "173a4977-27e4-5e4b-afc9-9c8d70b4464d",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 283.4,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 65,
				timerStartOffset = -14.5,
				uuid = "e9f9f435-a354-59de-9a32-6b72e70e7e32",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"d0ef0a99-f7be-0136-9718-1eeaf777a7d5",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedRay.Field == true\n",
							name = "神圣射线",
							uuid = "d0ef0a99-f7be-0136-9718-1eeaf777a7d5",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 283.4,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 65,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "a8019037-a9eb-1cf2-9011-b043db9f2892",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"c18e702d-a50a-80b7-8b32-501fe59f2712",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedRay.Field == true\n",
							name = "神圣射线",
							uuid = "c18e702d-a50a-80b7-8b32-501fe59f2712",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 283.4,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 65,
				timerStartOffset = -14,
				uuid = "df200670-7bf4-364b-8115-03b85faf33ab",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "f3af902f-d80c-38f4-adc2-81c76575bd0c",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.LightRampant.Target == true\n",
							name = "光之失控",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 331.8,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 80,
				timerStartOffset = -14,
				uuid = "4f5edc68-0279-ff39-a804-70daaf0e76b7",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"a7eae0f7-4f3f-3af7-8831-8ed1ea837ce0",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.LightRampant.Field == true\n",
							name = "光之失控",
							uuid = "a7eae0f7-4f3f-3af7-8831-8ed1ea837ce0",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 331.8,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 80,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "14b6703b-ccea-c73a-a799-91295c02cced",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"5f47df17-1f0b-1b44-9a09-12e3fd82f603",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.LightRampant.Field == true\n",
							name = "光之失控",
							uuid = "5f47df17-1f0b-1b44-9a09-12e3fd82f603",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 331.8,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 80,
				timerStartOffset = -8,
				uuid = "34566028-3eda-50fd-b492-5b1ba4574f46",
				version = 2,
			},
		},
	},
	[95] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "e5c62ee8-91b6-11ab-bcae-cd34277ade62",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HouseOfLight.Target == true\n",
							name = "光之海啸",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 368.8,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 95,
				timerStartOffset = -14,
				uuid = "f230d3d4-db43-fba8-9585-edbfc8df36b7",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"85c05f64-1e68-d5e2-8b41-b2a77870cb43",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HouseOfLight.Field == true\n",
							name = "光之海啸",
							uuid = "85c05f64-1e68-d5e2-8b41-b2a77870cb43",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 368.8,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 95,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "37a16c10-674c-9727-b2ab-dc9ec9b5fbb7",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"f1b1bdfc-b1f1-73fe-be94-dd76a24fecbc",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HouseOfLight.Field == true\n",
							name = "光之海啸",
							uuid = "f1b1bdfc-b1f1-73fe-be94-dd76a24fecbc",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 368.8,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 95,
				timerStartOffset = -14,
				uuid = "c90594e9-d459-fe15-9302-3376faddad66",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "ffa61f47-0967-6961-80df-2cf7c401b10a",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AbsoluteZero.Target == true\n",
							name = "绝对零度",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 388.7,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 100,
				timerStartOffset = -14,
				uuid = "8f10298c-bdf0-bb1b-b67b-6f6ca8b501c1",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"df76433a-5b0c-0196-a85a-bc2abf33c3a3",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AbsoluteZero.Field == true\n",
							name = "绝对零度",
							uuid = "df76433a-5b0c-0196-a85a-bc2abf33c3a3",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 388.7,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 100,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "e82a4bef-664c-5d59-aae6-9f93b584846d",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"fcf77b20-face-8b32-94a6-fd507f3c9b3c",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AbsoluteZero.Field == true\n",
							name = "绝对零度",
							uuid = "fcf77b20-face-8b32-94a6-fd507f3c9b3c",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 388.7,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 100,
				timerStartOffset = -14,
				uuid = "e3af70a5-8890-4e11-8432-37fa6dbb0c60",
				version = 2,
			},
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "d10e2170-990a-a50f-9da7-5e56c17cbaf2",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Relativity.Target == true\n",
							name = "时间压缩",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 532.4,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 123,
				timerStartOffset = -14,
				uuid = "08e1c75a-3c92-c669-b8cf-1d68b6a71fa6",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"ef4a947c-34a3-5954-b41a-c5003d5a50af",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Relativity.Field == true\n",
							name = "时间压缩",
							uuid = "ef4a947c-34a3-5954-b41a-c5003d5a50af",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 532.4,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 123,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "b3afeaf8-97b1-1544-99a3-accd393df8f7",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"accedc80-6959-8004-8469-7b7584a8f2b2",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Relativity.Field == true\n",
							name = "时间压缩",
							uuid = "accedc80-6959-8004-8469-7b7584a8f2b2",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 532.4,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 123,
				timerStartOffset = -14,
				uuid = "98e01c00-ded2-370a-969d-60e4420bc852",
				version = 2,
			},
		},
	},
	[134] = 
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"5445b3a1-a843-d27d-9994-c41c0d85fcab",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShockwavePulsar.Field == true\n",
							name = "罪熔毁",
							uuid = "5445b3a1-a843-d27d-9994-c41c0d85fcab",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 569.3,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 134,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "3d82b9db-ce60-53e4-a9a2-55a2b9ff0b48",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"e87ac20e-b2d7-9976-b786-8c1384952b4e",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShockwavePulsar.Field == true\n",
							name = "罪熔毁",
							uuid = "e87ac20e-b2d7-9976-b786-8c1384952b4e",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 569.3,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 134,
				timerStartOffset = -14,
				uuid = "1df63513-3e98-9f1e-800d-9357be7ced6b",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "9c2a22d1-d211-2fe4-a5ad-75d0df3e320c",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShellCrusher.Target == true\n",
							name = "破盾一击",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 587.1,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 139,
				timerStartOffset = -14,
				uuid = "3fa185aa-ad22-b635-ac04-dcc07a9e6bc5",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"b3053605-a0d0-819f-9396-e15d414c3345",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShellCrusher.Field == true\n",
							name = "破盾一击",
							uuid = "b3053605-a0d0-819f-9396-e15d414c3345",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 587.1,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 139,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "ae3c8fa8-7024-50c2-a2cf-74a3a24dec3e",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"12ed8c93-3b50-5150-b29a-d437c235be86",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShellCrusher.Field == true\n",
							name = "破盾一击",
							uuid = "12ed8c93-3b50-5150-b29a-d437c235be86",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 587.1,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 139,
				timerStartOffset = -8,
				uuid = "486f85c9-72f4-ff06-ab55-fa672318f950",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "993e3cd3-c4f2-01b2-a06e-2d6cfe53bb97",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkWater.Target == true\n\n",
							name = "黑暗狂水",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 651.2,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 152,
				timerStartOffset = -14,
				uuid = "fb4e9b89-8c5e-0bfb-ba7f-30e02d10bd67",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"f7617e54-56cc-6052-8835-c3dee6ce0733",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkWater.Field == true\n",
							name = "黑暗狂水",
							uuid = "f7617e54-56cc-6052-8835-c3dee6ce0733",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 651.2,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 152,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "9f40f1ad-b047-06ac-a445-dbb1e738366f",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"33bf1be9-d5b7-cfca-b76e-54380c883af3",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkWater.Field == true\n",
							name = "黑暗狂水",
							uuid = "33bf1be9-d5b7-cfca-b76e-54380c883af3",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 651.2,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 152,
				timerStartOffset = -14,
				uuid = "03d0f2b1-168c-023d-8cea-8a1475072553",
				version = 2,
			},
		},
	},
	[154] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "9c031c77-b16f-5a7b-a70c-f9022ee2f832",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MemorySEnd.Target == true\n",
							name = "记忆终结",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 670.1,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 154,
				timerStartOffset = -14.5,
				uuid = "3de6a885-9708-b6b2-962c-1e9869ace1d3",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"87b30a28-6fd9-c79d-befd-5e6d6571382d",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MemorySEnd.Field == true\n",
							name = "记忆终结",
							uuid = "87b30a28-6fd9-c79d-befd-5e6d6571382d",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 670.1,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 154,
				timerOffset = -14,
				timerStartOffset = -14.5,
				uuid = "b52b60bb-43f1-b835-88b1-697732a0ed85",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"9397fd33-56b6-2e9c-8dd1-a55dd604e766",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MemorySEnd.Field == true\n",
							name = "记忆终结",
							uuid = "9397fd33-56b6-2e9c-8dd1-a55dd604e766",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 670.1,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 154,
				timerStartOffset = -10,
				uuid = "dba46259-9187-292a-9b40-9de77498e4c4",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "4ab7a42d-12c0-3a7c-ae3b-dafe20db3f41",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkLitDragonSong.Target == true\n",
							name = "光暗龙诗",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 738.2,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 166,
				timerStartOffset = -14,
				uuid = "9fc29c23-02e6-59b3-a40e-0110306e12fb",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"4b49b0d5-c5eb-6145-83e6-dadb3a09e981",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkLitDragonSong.Field == true\n",
							name = "光暗龙诗",
							uuid = "4b49b0d5-c5eb-6145-83e6-dadb3a09e981",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 738.2,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 166,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "f963bfe3-786f-bbc9-8d81-f693cd3fac8a",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"054e09fc-8358-fc67-8a91-771185eb8032",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkLitDragonSong.Field == true\n",
							name = "光暗龙诗",
							uuid = "054e09fc-8358-fc67-8a91-771185eb8032",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 738.2,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 166,
				timerStartOffset = -14,
				uuid = "53ba21b6-6a5f-8ba9-a6bf-2d431ca2ba59",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "87f48915-372a-095b-aa9b-347ec5545653",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah1.Target == true\n",
							name = "无尽顿悟1",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 783.4,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 176,
				timerStartOffset = -14,
				uuid = "1348ccca-d90c-9d28-8b7e-5ab85b802458",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"1bdc1d31-2379-c969-9ea5-433d7869867c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah1.Field == true\n",
							name = "无尽顿悟1",
							uuid = "1bdc1d31-2379-c969-9ea5-433d7869867c",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 783.4,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 176,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "83e09aa1-8852-af9e-aeac-15ac7ad39363",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"1d36c999-cf6a-7c13-bb54-860a7bc4d40d",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
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
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah1.Field == true\n",
							name = "无尽顿悟1",
							uuid = "1d36c999-cf6a-7c13-bb54-860a7bc4d40d",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 783.4,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 176,
				timerStartOffset = -10,
				uuid = "497c5de8-fc9c-170e-a2f6-f13e44aada1f",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"a7d9901a-f27c-5a5a-820f-6002d5ee5908",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "3e7ceedc-034f-1f4d-8bcc-6b0cbc84da26",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.CrystallizeTime.Target == true\n",
							name = "时间结晶",
							uuid = "a7d9901a-f27c-5a5a-820f-6002d5ee5908",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 798.9,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 179,
				timerStartOffset = -14,
				uuid = "004760c2-3a63-3f37-80bd-2e593c87a094",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"6940ad0f-ae93-ffd9-ba5c-b398ecce0a1a",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.CrystallizeTime.Field == true\n",
							name = "时间结晶",
							uuid = "6940ad0f-ae93-ffd9-ba5c-b398ecce0a1a",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 798.9,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 179,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "4e87350b-3f3b-2d5f-9a7f-0c5574fdf3dd",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"378a3730-2ab0-f79b-9af3-34cffa9a9e00",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.CrystallizeTime.Field == true\n",
							name = "时间结晶",
							uuid = "378a3730-2ab0-f79b-9af3-34cffa9a9e00",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 798.9,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 179,
				timerStartOffset = -10,
				uuid = "0e73a0e7-1503-a7a3-b68e-9e1516354d4c",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"5445b3a1-a843-d27d-9994-c41c0d85fcab",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedWings.Field == true\n",
							name = "神圣之翼",
							uuid = "5445b3a1-a843-d27d-9994-c41c0d85fcab",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 845.7,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 198,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "23166388-b53b-20ae-8e36-da69339ce1bc",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"bda91556-8a86-b554-b47a-d1c7402daf1a",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedWings.Field == true\n",
							name = "神圣之翼",
							uuid = "bda91556-8a86-b554-b47a-d1c7402daf1a",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 845.7,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 198,
				timerStartOffset = -14,
				uuid = "7d1fe195-beb3-598b-83d0-eb5d381c9ca6",
				version = 2,
			},
		},
	},
	[204] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "1fb392f9-9d3f-13de-9632-d9a4127ac793",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah2.Target == true\n",
							name = "无尽顿悟2",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 864.8,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 204,
				timerStartOffset = -14,
				uuid = "f7f9cd54-3b66-e8d3-95e9-2f41baec0cb6",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"1bdc1d31-2379-c969-9ea5-433d7869867c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah2.Field == true\n",
							name = "无尽顿悟2",
							uuid = "1bdc1d31-2379-c969-9ea5-433d7869867c",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 864.8,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 204,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "01a39645-c02a-5bf9-9a12-66cb87560749",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"9274dc85-a176-8e61-a160-050ac7c9f10a",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah2.Field == true\n",
							name = "无尽顿悟2",
							uuid = "9274dc85-a176-8e61-a160-050ac7c9f10a",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 864.8,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 204,
				timerStartOffset = -10,
				uuid = "d6789e6a-1d6b-a491-b138-7914e002c783",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "4638c16a-08ae-9482-8ee8-624529f55eac",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade1.Target == true\n",
							name = "光尘之剑1",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 984.8,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 209,
				timerStartOffset = -10,
				uuid = "9a3e1ac8-588b-32e4-b19c-bbdcda13a7be",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"4b013d21-c17b-4222-865a-af1a1ee38bb6",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade1.Field == true\n",
							name = "光尘之剑1",
							uuid = "4b013d21-c17b-4222-865a-af1a1ee38bb6",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 984.8,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 209,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "40ad759d-ba58-16b0-8bb4-aeceb8544cf0",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"96c17c75-d5a0-d303-af50-bcdbe411bc37",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade1.Field == true\n",
							name = "光尘之剑1",
							uuid = "96c17c75-d5a0-d303-af50-bcdbe411bc37",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 984.8,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 209,
				timerStartOffset = -14,
				uuid = "a8b531f0-0c40-f3fe-b1aa-0fbb93970951",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "5946ff80-3779-d5f3-a979-a0ade0889e80",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn1.Target == true\n",
							name = "死亡轮回1",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1011.4,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 215,
				timerStartOffset = -14,
				uuid = "9a42a7e7-5edc-caf6-8d16-963fec083692",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"74a74d82-1f03-0ef3-bed9-8daae86c0fcb",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn1.Field == true\n",
							name = "死亡轮回1",
							uuid = "74a74d82-1f03-0ef3-bed9-8daae86c0fcb",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1011.4,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 215,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "2945f5c1-cad8-13fc-a24c-f01b2cb8c8ec",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"9f9f4d22-b26e-8e5e-a56c-2f3ee298113d",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn1.Field == true\n",
							name = "死亡轮回1",
							uuid = "9f9f4d22-b26e-8e5e-a56c-2f3ee298113d",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1011.4,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 215,
				timerStartOffset = -14,
				uuid = "37f70896-875f-7a61-b323-0cced0e989a0",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "86ebcfc2-498a-7e14-b582-e52d8f4e7286",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing1.Target == true\n",
							name = "星灵之剑1",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1065,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 232,
				timerStartOffset = -14,
				uuid = "bcc9756e-6cf2-29f0-a437-bce0ee396363",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"92f2bb51-2f50-775f-b018-7004ec379459",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing1.Field == true\n",
							name = "星灵之剑1",
							uuid = "92f2bb51-2f50-775f-b018-7004ec379459",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1065,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 232,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "abf0ac24-472d-66d0-a5b0-bc4e0d092843",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"9296c250-ae1a-3a05-aa72-2c26eaafd67a",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
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
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing1.Field == true\n",
							name = "星灵之剑1",
							uuid = "9296c250-ae1a-3a05-aa72-2c26eaafd67a",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1065,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 232,
				timerStartOffset = -10,
				uuid = "2b21f948-20cc-5668-86d0-082e7fc1a4ff",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "d969a5e2-016e-4b68-b83a-b39611d44019",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade2.Target == true\n",
							name = "光尘之剑2",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1097.4,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 237,
				timerStartOffset = -14,
				uuid = "2ffde658-38a9-e63f-b95d-da8461a52530",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"4b013d21-c17b-4222-865a-af1a1ee38bb6",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade2.Field == true\n",
							name = "光尘之剑2",
							uuid = "4b013d21-c17b-4222-865a-af1a1ee38bb6",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1097.4,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 237,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "9f3131f4-a3cc-464d-b61d-56ee846e663e",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"cd6e3cac-1c6f-fff1-8823-c87a098fed13",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade2.Field == true\n",
							name = "光尘之剑2",
							uuid = "cd6e3cac-1c6f-fff1-8823-c87a098fed13",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1097.4,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 237,
				timerStartOffset = -14,
				uuid = "33291dab-c1be-89fd-8dc0-83dd2c6897d0",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "1b31c339-1adb-c2fe-9a48-0e8d1829538f",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn2.Target == true\n",
							name = "死亡轮回2",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1124,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 243,
				timerStartOffset = -14,
				uuid = "b192cf4c-dc2d-d397-baf6-9f4f55aec79e",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"74a74d82-1f03-0ef3-bed9-8daae86c0fcb",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn2.Field == true\n",
							name = "死亡轮回2",
							uuid = "74a74d82-1f03-0ef3-bed9-8daae86c0fcb",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1124,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 243,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "fa3bcd5c-56d2-0a54-a0c3-9c2474eb75ec",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"1613864a-4a55-75e4-a4cd-ced8c75d43b3",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn2.Field == true\n",
							name = "死亡轮回2",
							uuid = "1613864a-4a55-75e4-a4cd-ced8c75d43b3",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1124,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 243,
				timerStartOffset = -14,
				uuid = "a43469fc-1a16-ec45-a8e6-f39516557416",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "968b81d2-3cc1-05d6-9cfa-6e57e5d84fa9",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing2.Target == true\n",
							name = "星灵之剑2",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1176.4,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 259,
				timerStartOffset = -14,
				uuid = "f4dfa861-34f4-3a9a-802b-f86602e65578",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"92f2bb51-2f50-775f-b018-7004ec379459",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing2.Field == true\n",
							name = "星灵之剑2",
							uuid = "92f2bb51-2f50-775f-b018-7004ec379459",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1176.4,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 259,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "fee1bd93-c02f-a2d6-af51-325b4d4c8414",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"68a7f790-e200-0d15-af23-7fa16b73db03",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing2.Field == true\n",
							name = "星灵之剑2",
							uuid = "68a7f790-e200-0d15-af23-7fa16b73db03",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1176.4,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 259,
				timerStartOffset = -14,
				uuid = "953b4bf9-525b-d16f-84e5-4f68d400e982",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "8efe38c6-8c1e-d5cc-b642-9439eec513b8",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade3.Target == true\n",
							name = "光尘之剑3",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1187.6,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 262,
				timerStartOffset = -14,
				uuid = "010e2da4-e4a5-cc68-9dfa-cf01a016a03a",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"4b013d21-c17b-4222-865a-af1a1ee38bb6",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade3.Field == true\n",
							name = "光尘之剑3",
							uuid = "4b013d21-c17b-4222-865a-af1a1ee38bb6",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1187.6,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 262,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "d28dfe06-2f81-24c5-8fbb-a0fa98dd6257",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"aebb499f-5305-1e3e-85e7-de8579008d37",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade3.Field == true\n",
							name = "光尘之剑3",
							uuid = "aebb499f-5305-1e3e-85e7-de8579008d37",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1187.6,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 262,
				timerStartOffset = -14,
				uuid = "b59cae34-beef-210a-b6e9-033146460d1e",
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
							actionID = 7535,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"bfdff204-732b-1508-a3a5-13668c515867",
									true,
								},
								
								{
									"06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
									true,
								},
								
								{
									"e1ddd672-da06-3edb-8e90-82df6135f0d7",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Reprisal",
							targetType = "Current Target",
							uuid = "f071718e-0445-a73c-b5af-2a7e670b78f2",
							variableTogglesType = 3,
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
							actionCDValue = 0.5,
							actionID = 7535,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "bfdff204-732b-1508-a3a5-13668c515867",
							version = 2,
						},
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 6,
							inRangeValue = 5,
							uuid = "06c14b4e-a8b9-9f9f-ac57-e5731c2bba4c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn3.Target == true\n",
							name = "死亡轮回3",
							uuid = "e1ddd672-da06-3edb-8e90-82df6135f0d7",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1214.2,
				name = "【TANK】雪仇",
				timeRange = true,
				timelineIndex = 268,
				timerStartOffset = -14,
				uuid = "2653a95b-df0c-bfca-9243-880477389e9c",
				version = 2,
			},
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
									"d1b1510b-e792-c9df-98ad-bb62d8761229",
									true,
								},
								
								{
									"721c847b-148b-bed0-adb9-6d6aa997b038",
									true,
								},
								
								{
									"74a74d82-1f03-0ef3-bed9-8daae86c0fcb",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMissionary",
							uuid = "6bb13b05-7ed1-98c4-8cf9-2a76cd2d7048",
							variableTogglesType = 3,
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
							actionID = 16471,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d1b1510b-e792-c9df-98ad-bb62d8761229",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "DARKKNIGHT",
							name = "is DRK",
							uuid = "721c847b-148b-bed0-adb9-6d6aa997b038",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn3.Field == true",
							name = "死亡轮回3",
							uuid = "74a74d82-1f03-0ef3-bed9-8daae86c0fcb",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1214.2,
				name = "【DRK】暗黑布道",
				timeRange = true,
				timelineIndex = 268,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "1decce78-f706-5401-aa68-e694cfd03554",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"687ccafe-29f4-f64b-80b8-7a242dd89425",
									true,
								},
								
								{
									"c779840e-159b-5b27-babb-26c78c46bc88",
									true,
								},
								
								{
									"1f08e0f9-35fa-6ad5-bf47-3c05b4bb87a2",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_DivineVeil",
							uuid = "75b69e30-61bd-f6b3-a5cb-d82d7c4b9170",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							actionID = 3540,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "687ccafe-29f4-f64b-80b8-7a242dd89425",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "PALADIN",
							name = "is PLD",
							uuid = "c779840e-159b-5b27-babb-26c78c46bc88",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn3.Field == true",
							name = "死亡轮回3",
							uuid = "1f08e0f9-35fa-6ad5-bf47-3c05b4bb87a2",
							version = 2,
						},
						inheritedIndex = 7,
					},
				},
				mechanicTime = 1214.2,
				name = "【PLD】圣光幕帘",
				timeRange = true,
				timelineIndex = 268,
				timerStartOffset = -14,
				uuid = "3390aa7a-6695-999e-ac08-6207fa6dc041",
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