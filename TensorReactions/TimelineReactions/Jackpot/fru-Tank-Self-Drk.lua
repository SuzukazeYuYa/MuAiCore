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
							aType = "ACR",
							conditions = 
							{
								
								{
									"67bdb726-db0a-77c0-80dd-a5da7d5dd1f5",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Grit",
							uuid = "500a5aca-3f24-96a2-ad68-690f830d23a7",
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
							buffCheckType = 2,
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "67bdb726-db0a-77c0-80dd-a5da7d5dd1f5",
							version = 2,
						},
					},
				},
				mechanicTime = 16.4,
				name = "【DRK】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 3,
				timerEndOffset = 5,
				uuid = "0654a325-758f-822f-849a-5fb093bdb3a4",
				version = 2,
			},
			inheritedIndex = 1,
		},
	},
	[7] = 
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
				mechanicTime = 24.2,
				name = "----暗黑骑士----",
				timelineIndex = 7,
				uuid = "c4bdc077-60e7-fc46-9c41-b5043314a394",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 24.2,
				name = "--自己全减吃--",
				timelineIndex = 7,
				uuid = "54105594-ef0a-3c63-806c-cebd023fd378",
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
									"03b6b0d4-7261-0445-9385-06e8b4a01dc6",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_OblationSelf",
							uuid = "829b27b1-9a80-12c7-907a-6d825971e4f8",
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
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 1",
							name = "p1-1全减",
							uuid = "03b6b0d4-7261-0445-9385-06e8b4a01dc6",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 24.2,
				name = "【DRK】献奉",
				timeRange = true,
				timelineIndex = 7,
				timerOffset = -7,
				timerStartOffset = -8,
				uuid = "d851481f-7713-b2b5-912e-6d1d1c3479ce",
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
							aType = "ACR",
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"580a4fc9-b049-aeb6-b393-fef100cd6744",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightSelf",
							ignoreWeaveRules = true,
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 1",
							name = "p1-1全减",
							uuid = "580a4fc9-b049-aeb6-b393-fef100cd6744",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 24.2,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 7,
				timerStartOffset = -6,
				uuid = "ed93f7a2-53b0-ae5a-b9c9-6c0cca6594e1",
				version = 2,
			},
			inheritedIndex = 5,
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
				mechanicTime = 24.2,
				name = "---------------",
				timelineIndex = 7,
				uuid = "18871714-6e0a-4ca5-901d-ee0eb8e3cab4",
				version = 2,
			},
			inheritedIndex = 6,
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
				mechanicTime = 24.2,
				name = "--自己无敌吃--",
				timelineIndex = 7,
				uuid = "f3b61775-23e1-d1fc-9561-5bb4734302e7",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"36f666e7-1b72-8e73-9307-8cdfd7406fb9",
									true,
								},
								
								{
									"4654df9b-ce44-60cb-bd46-54492328a1e9",
									true,
								},
								
								{
									"8ba9673d-5450-1ec5-a0fc-027f4574305c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							ignoreWeaveRules = true,
							uuid = "01a644ff-a749-e4ec-a6f4-e57ab482dc1c",
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
							conditionType = 4,
							enmityValue = 100,
							uuid = "36f666e7-1b72-8e73-9307-8cdfd7406fb9",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							actionID = 36927,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "4654df9b-ce44-60cb-bd46-54492328a1e9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 1",
							name = "p1-1全减",
							uuid = "8ba9673d-5450-1ec5-a0fc-027f4574305c",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 24.2,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 7,
				timerStartOffset = -14,
				uuid = "cf063416-5a8b-134e-8cc2-39f1650e6795",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
									true,
								},
								
								{
									"594dbc47-f453-871c-b3c4-6cd2f0dde2cd",
									true,
								},
								
								{
									"c8e0f02d-ae25-bc01-b2c0-25d66b541206",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_LivingDead",
							uuid = "a990d73c-774f-be61-ac18-c6e0e8808d9f",
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
							actionID = 3638,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							conditionType = 4,
							enmityValue = 100,
							uuid = "594dbc47-f453-871c-b3c4-6cd2f0dde2cd",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 2",
							name = "p1-1无敌",
							uuid = "c8e0f02d-ae25-bc01-b2c0-25d66b541206",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 24.2,
				name = "【DRK】行尸走肉",
				timeRange = true,
				timelineIndex = 7,
				timerStartOffset = -9,
				uuid = "31c36392-6301-3a7c-bbe1-44977e4fabaa",
				version = 2,
			},
			inheritedIndex = 9,
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
				mechanicTime = 24.2,
				name = "---------------",
				timelineIndex = 7,
				uuid = "e24be879-ba80-b5f9-a22c-ee7d1598e224",
				version = 2,
			},
			inheritedIndex = 10,
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
				mechanicTime = 24.2,
				name = "--搭档减伤吃--",
				timelineIndex = 7,
				uuid = "4bb9bcd5-04e9-5af1-bc3a-72d7d85f2804",
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
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"511f1dd0-57b9-ef0f-86e1-777dd21b2797",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightOT",
							ignoreWeaveRules = true,
							targetType = "Other Tank",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 3",
							name = "搭档减伤吃",
							uuid = "511f1dd0-57b9-ef0f-86e1-777dd21b2797",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 24.2,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 7,
				timerStartOffset = -6,
				uuid = "95f042be-7751-66fc-acc5-823c72836eb9",
				version = 2,
			},
			inheritedIndex = 12,
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
				mechanicTime = 24.2,
				name = "---------------",
				timelineIndex = 7,
				uuid = "911b433e-9f05-f836-bd69-82b8c362b18d",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"5350cf08-979a-90ac-b637-3ae4ccd095e4",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 3 or MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 4",
							name = "p1不吃",
							uuid = "5350cf08-979a-90ac-b637-3ae4ccd095e4",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 24.2,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 7,
				timerEndOffset = 5,
				timerStartOffset = -4,
				uuid = "6e6fe62d-91cb-beb7-80cb-1e9c95a3b4e1",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"be1a0eb2-85d4-2b60-b8c1-2b934e111e59",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_ShirkOT",
							uuid = "8fd7f15b-cd53-05a4-8f30-1fb825db7f95",
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
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 1 or MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 2",
							name = "p1自己吃",
							uuid = "be1a0eb2-85d4-2b60-b8c1-2b934e111e59",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 24.2,
				name = " 退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 7,
				timerEndOffset = 5,
				timerStartOffset = -2,
				uuid = "0545f5a2-eee7-7779-898f-7b4f411bcbe9",
				version = 2,
			},
			inheritedIndex = 15,
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
				mechanicTime = 24.2,
				name = "---------------",
				timelineIndex = 7,
				uuid = "12da5a9c-8ea5-ab9b-b6b5-fe66efa9ff0f",
				version = 2,
			},
			inheritedIndex = 16,
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
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_OblationSelf",
							uuid = "829b27b1-9a80-12c7-907a-6d825971e4f8",
							variableTogglesType = 3,
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 40.3,
				name = "【DRK】献奉",
				timeRange = true,
				timelineIndex = 11,
				timerOffset = -7,
				timerStartOffset = -8,
				uuid = "2862e528-ac3c-fe0b-b52c-50c48ffa63c9",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightSelf",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 40.3,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 11,
				timerEndOffset = -1,
				timerStartOffset = -6,
				uuid = "77a3cabd-fb34-9e1b-a530-1d14d4b8d60f",
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
							aType = "ACR",
							actionID = 3634,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"9e827713-6061-356b-b083-a6cb67f8aff1",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "9523fc08-ee81-1a06-8641-e57241f3d9e9",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "9e827713-6061-356b-b083-a6cb67f8aff1",
							version = 2,
						},
					},
				},
				mechanicTime = 40.3,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 11,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "d614881f-c075-945b-ba83-5430920a9a43",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"a6e87fc2-18f8-9d4e-b35e-13f7984533fc",
									true,
								},
								
								{
									"cf8fa8e2-72d3-9e7d-953f-1cd9cecc5d6c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_ReleaseGrit",
							uuid = "ac0bc610-5a4d-e51d-8677-4fe60250b42f",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "a6e87fc2-18f8-9d4e-b35e-13f7984533fc",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 3 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 4",
							name = "p1-2不吃",
							uuid = "cf8fa8e2-72d3-9e7d-953f-1cd9cecc5d6c",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 40.3,
				name = "【DRK】关闭盾姿",
				timeRange = true,
				timelineIndex = 11,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "3526d33c-5062-1951-a07f-01ba055a6f9f",
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
				},
				mechanicTime = 40.3,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 11,
				timerStartOffset = -19.5,
				uuid = "d5b115be-8fdd-2c1e-812f-4968815e01ff",
				version = 2,
			},
			inheritedIndex = 8,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"5350cf08-979a-90ac-b637-3ae4ccd095e4",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 2",
							name = "p1-2全减/无敌",
							uuid = "5350cf08-979a-90ac-b637-3ae4ccd095e4",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 80,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 21,
				timerEndOffset = 6,
				timerStartOffset = 2,
				uuid = "4f162ab0-4e91-8ab7-9d82-beeeddb6b66f",
				version = 2,
			},
			inheritedIndex = 1,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"67bdb726-db0a-77c0-80dd-a5da7d5dd1f5",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Grit",
							uuid = "500a5aca-3f24-96a2-ad68-690f830d23a7",
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
							buffCheckType = 2,
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "67bdb726-db0a-77c0-80dd-a5da7d5dd1f5",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 113.7,
				name = "【DRK】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 28,
				timerEndOffset = 5,
				uuid = "e0e74b13-5145-55f0-9114-e3565ae301a9",
				version = 2,
			},
			inheritedIndex = 1,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"ae014322-47f1-113d-bc96-61c09b197174",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 2",
							name = "p1-2全减/无敌",
							uuid = "ae014322-47f1-113d-bc96-61c09b197174",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 121.1,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 29,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "5026437f-db20-9b35-b7fd-fa49153a6957",
				version = 2,
			},
			inheritedIndex = 1,
		},
	},
	[30] = 
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
				mechanicTime = 129.5,
				name = "---------------",
				timelineIndex = 30,
				uuid = "23b7cf2c-d0e7-9529-95fb-2b1eff10d13f",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 129.5,
				name = "--自己全减吃--",
				timelineIndex = 30,
				uuid = "868465d1-64e7-95bb-93fb-502c26cc6ceb",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"36f666e7-1b72-8e73-9307-8cdfd7406fb9",
									true,
								},
								
								{
									"4654df9b-ce44-60cb-bd46-54492328a1e9",
									true,
								},
								
								{
									"56fbeac1-4336-487e-8eb2-403d6efc7747",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							ignoreWeaveRules = true,
							uuid = "01a644ff-a749-e4ec-a6f4-e57ab482dc1c",
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
							conditionType = 4,
							enmityValue = 100,
							uuid = "36f666e7-1b72-8e73-9307-8cdfd7406fb9",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							actionID = 36927,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "4654df9b-ce44-60cb-bd46-54492328a1e9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1",
							name = "p1-2全减",
							uuid = "56fbeac1-4336-487e-8eb2-403d6efc7747",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 129.5,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 30,
				timerStartOffset = -14,
				uuid = "f35ff938-cbe6-c5b4-8d93-2ef1d358fa9f",
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
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"414f5c18-175b-5259-ad8d-ff17da3449cf",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightMT",
							ignoreWeaveRules = true,
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1",
							name = "p1-2全减",
							uuid = "414f5c18-175b-5259-ad8d-ff17da3449cf",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 129.5,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 30,
				timerStartOffset = -6,
				uuid = "620f0376-0874-124d-8346-39613d318882",
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
							actionID = 3634,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"9e827713-6061-356b-b083-a6cb67f8aff1",
									true,
								},
								
								{
									"51987475-7f68-5565-8fb0-4d0e80bd9f9c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "9523fc08-ee81-1a06-8641-e57241f3d9e9",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "9e827713-6061-356b-b083-a6cb67f8aff1",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1",
							name = "p1-2全减",
							uuid = "51987475-7f68-5565-8fb0-4d0e80bd9f9c",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 129.5,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 30,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "45a48e3e-d1ab-a2cd-b28c-36ffec943de8",
				version = 2,
			},
			inheritedIndex = 5,
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
				mechanicTime = 129.5,
				name = "---------------",
				timelineIndex = 30,
				uuid = "6eca05ed-69dc-eee8-a416-f8e43db60084",
				version = 2,
			},
			inheritedIndex = 6,
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
				mechanicTime = 129.5,
				name = "--自己无敌吃--",
				timelineIndex = 30,
				uuid = "ec56f444-90fd-b614-86a9-e1be5f93c0aa",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
									true,
								},
								
								{
									"594dbc47-f453-871c-b3c4-6cd2f0dde2cd",
									true,
								},
								
								{
									"c8e0f02d-ae25-bc01-b2c0-25d66b541206",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_LivingDead",
							uuid = "a990d73c-774f-be61-ac18-c6e0e8808d9f",
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
							actionID = 3638,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							conditionType = 4,
							enmityValue = 100,
							uuid = "594dbc47-f453-871c-b3c4-6cd2f0dde2cd",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 2",
							name = "p1-2无敌",
							uuid = "c8e0f02d-ae25-bc01-b2c0-25d66b541206",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 129.5,
				name = "【DRK】行尸走肉",
				timeRange = true,
				timelineIndex = 30,
				timerStartOffset = -8,
				uuid = "24e89790-41cb-02a3-810c-ad3c53ed8954",
				version = 2,
			},
			inheritedIndex = 8,
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
				mechanicTime = 129.5,
				name = "---------------",
				timelineIndex = 30,
				uuid = "edff779d-e6f0-bd43-b9c8-b5e37a8e897c",
				version = 2,
			},
			inheritedIndex = 9,
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
				mechanicTime = 129.5,
				name = "--搭档减伤吃--",
				timelineIndex = 30,
				uuid = "0f3f23c4-745b-5b02-9dc5-2d28c86332da",
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
							aType = "ACR",
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"511f1dd0-57b9-ef0f-86e1-777dd21b2797",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightOT",
							ignoreWeaveRules = true,
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 3",
							name = "搭档减伤吃",
							uuid = "511f1dd0-57b9-ef0f-86e1-777dd21b2797",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 129.5,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 30,
				timerStartOffset = -6,
				uuid = "a612e36d-28af-0900-88b6-94b236fb7097",
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
				mechanicTime = 129.5,
				name = "---------------",
				timelineIndex = 30,
				uuid = "3af1c7b1-24d3-2219-9fd6-585a2a320c12",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"5350cf08-979a-90ac-b637-3ae4ccd095e4",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 3 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 4",
							name = "p1-2不吃",
							uuid = "5350cf08-979a-90ac-b637-3ae4ccd095e4",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 129.5,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 30,
				timerEndOffset = 5,
				timerStartOffset = -4,
				uuid = "d4df9363-8632-fd21-b8d8-42cf75d17021",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"d9d520fc-2452-1b63-9d3e-38afd550ce6d",
									true,
								},
								
								{
									"95aa0f5d-d2d1-1147-b854-e0eaec21665e",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_ShirkOT",
							uuid = "8fd7f15b-cd53-05a4-8f30-1fb825db7f95",
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
							comparator = 2,
							conditionType = 4,
							enmityValue = 99.999000549316,
							uuid = "d9d520fc-2452-1b63-9d3e-38afd550ce6d",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 2",
							name = "p1-2全减/无敌",
							uuid = "95aa0f5d-d2d1-1147-b854-e0eaec21665e",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 129.5,
				name = " 退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 30,
				timerEndOffset = 5,
				timerStartOffset = -4,
				uuid = "825131e0-91b6-0282-a183-bb1ffd8d503b",
				version = 2,
			},
			inheritedIndex = 14,
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
				mechanicTime = 129.5,
				name = "---------------",
				timelineIndex = 30,
				uuid = "057e1ccf-c4cb-eb89-8af2-c73d8022b5b7",
				version = 2,
			},
			inheritedIndex = 15,
		},
	},
	[35] = 
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
				mechanicTime = 145.6,
				name = "---------------",
				timelineIndex = 35,
				uuid = "fe78e2c1-768a-2343-a7bf-051d6b19ece9",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 145.6,
				name = "--自己无敌吃--",
				timelineIndex = 35,
				uuid = "31d1016e-52e8-c7ec-a1ae-0635991cd6c8",
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
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_OblationSelf",
							uuid = "829b27b1-9a80-12c7-907a-6d825971e4f8",
							variableTogglesType = 3,
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 145.6,
				name = "【DRK】献奉",
				timeRange = true,
				timelineIndex = 35,
				timerOffset = -7,
				timerStartOffset = -8,
				uuid = "a5bfa8fc-8d70-86c6-b6be-4e2ed559a191",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
				},
				mechanicTime = 145.6,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 35,
				timerStartOffset = -15,
				uuid = "e9bea946-3705-a497-9696-11fd1c124467",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"4654df9b-ce44-60cb-bd46-54492328a1e9",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							ignoreWeaveRules = true,
							uuid = "01a644ff-a749-e4ec-a6f4-e57ab482dc1c",
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
							actionID = 36927,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "4654df9b-ce44-60cb-bd46-54492328a1e9",
							version = 2,
						},
					},
				},
				mechanicTime = 145.6,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 35,
				timerStartOffset = -14,
				uuid = "5917a16d-cb8c-e2d4-bddf-d37f91614f16",
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
							actionID = 3634,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"9e827713-6061-356b-b083-a6cb67f8aff1",
									true,
								},
								
								{
									"51987475-7f68-5565-8fb0-4d0e80bd9f9c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "9523fc08-ee81-1a06-8641-e57241f3d9e9",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "9e827713-6061-356b-b083-a6cb67f8aff1",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 2 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 3 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 4",
							name = "p1-2非全减",
							uuid = "51987475-7f68-5565-8fb0-4d0e80bd9f9c",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 145.6,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 35,
				timerOffset = -5,
				timerStartOffset = -8,
				uuid = "c56bb243-618b-56e8-86de-b18b30c3a49b",
				version = 2,
			},
			inheritedIndex = 8,
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
				mechanicTime = 145.6,
				name = "--自己全减吃--",
				timelineIndex = 35,
				uuid = "4b83362f-5d88-320f-92a8-cb4a6bd6b2ca",
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
							aType = "ACR",
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"fbd12a45-96f6-23b5-999b-60b2356f3299",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightSelf",
							ignoreWeaveRules = true,
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1",
							name = "p1-2全减",
							uuid = "fbd12a45-96f6-23b5-999b-60b2356f3299",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 145.6,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 35,
				timerStartOffset = -6,
				uuid = "c6a25405-ada6-ec0f-81cb-e3891d62fd30",
				version = 2,
			},
			inheritedIndex = 10,
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
				mechanicTime = 145.6,
				name = "---------------",
				timelineIndex = 35,
				uuid = "026e45e4-613a-b64a-a1d5-8ed8b620c617",
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
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"954cc258-9fee-a83f-a53d-ebe4645379a4",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightOT",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 2 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 3",
							name = "p1-2无敌/不吃",
							uuid = "954cc258-9fee-a83f-a53d-ebe4645379a4",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 145.6,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 35,
				timerStartOffset = -6,
				uuid = "78892c95-0ecc-0ef7-9517-bb83354ba26a",
				version = 2,
			},
			inheritedIndex = 12,
		},
	},
	[39] = 
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
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"5350cf08-979a-90ac-b637-3ae4ccd095e4",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = " return MuAiGuide.Config.FruMitigation.Tank.P2_Open == 1\n",
							name = "p2无敌",
							uuid = "5350cf08-979a-90ac-b637-3ae4ccd095e4",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 203.8,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 39,
				timerEndOffset = 10,
				uuid = "52793421-9f30-65b9-b1e4-84eb71bc838f",
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
									"a6e87fc2-18f8-9d4e-b35e-13f7984533fc",
									true,
								},
								
								{
									"32b3f779-8271-10d7-803b-d44b642fabca",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_ReleaseGrit",
							uuid = "ac0bc610-5a4d-e51d-8677-4fe60250b42f",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "a6e87fc2-18f8-9d4e-b35e-13f7984533fc",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P2_Open == 2\n",
							name = "p2不吃",
							uuid = "32b3f779-8271-10d7-803b-d44b642fabca",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 203.8,
				name = "【DRK】关闭盾姿",
				timeRange = true,
				timelineIndex = 39,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "838a6f0f-dbd6-58ac-90f2-0a70733b4a20",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[40] = 
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
				mechanicTime = 214.9,
				name = "---------------",
				timelineIndex = 40,
				uuid = "4fc4c729-78a8-8c7f-81ef-ddebbe2e4462",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 214.9,
				name = "--自己无敌吃--",
				timelineIndex = 40,
				uuid = "c1cb4ce9-fedf-6478-b421-72cfe86b9cf5",
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
									"cf5e6ed3-57e8-5401-9e22-fa93eebc8c50",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_LivingDead",
							uuid = "a990d73c-774f-be61-ac18-c6e0e8808d9f",
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
							actionID = 3638,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							conditionType = 4,
							enmityValue = 100,
							uuid = "594dbc47-f453-871c-b3c4-6cd2f0dde2cd",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P2_Open == 1\n\n",
							name = "p2-2",
							uuid = "cf5e6ed3-57e8-5401-9e22-fa93eebc8c50",
							version = 2,
						},
					},
				},
				mechanicTime = 214.9,
				name = "【DRK】行尸走肉",
				timeRange = true,
				timelineIndex = 40,
				timerStartOffset = -5,
				uuid = "d319fac1-5c13-9617-a723-544142ff0dc9",
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
				enabled = false,
				mechanicTime = 214.9,
				name = "---------------",
				timelineIndex = 40,
				uuid = "bf445db7-39fe-4327-9475-922b4bb93d5e",
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
				mechanicTime = 214.9,
				name = "--搭档无敌吃--",
				timelineIndex = 40,
				uuid = "1b8134b7-aa98-e15a-b8b6-70028b3bcc34",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"7aeece52-de16-c95b-a0c1-1d196c323f03",
									true,
								},
								
								{
									"1b109f36-0dc3-d121-becd-243adb0924c3",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Grit",
							uuid = "7be064ac-9fb7-f0ee-bb35-3bf26e935775",
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
							buffCheckType = 2,
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "7aeece52-de16-c95b-a0c1-1d196c323f03",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P2_Open == 2\n",
							name = "p2",
							uuid = "1b109f36-0dc3-d121-becd-243adb0924c3",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 214.9,
				name = "【DRK】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 40,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "7bbae0a3-a2c9-4f81-add3-1365d4bd56f1",
				version = 2,
			},
			inheritedIndex = 6,
		},
	},
	[41] = 
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
				mechanicTime = 219,
				name = "---------------",
				timelineIndex = 41,
				uuid = "0269f865-5b56-4279-97c7-a73216b2486e",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 219,
				name = "--搭档无敌吃--",
				timelineIndex = 41,
				uuid = "df79bc66-a481-079a-91cb-b4026125baf4",
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
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"97454d14-a8c1-7e3f-9a3b-b14b3f407e8b",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P2_Open == 2",
							name = "p2-3",
							uuid = "97454d14-a8c1-7e3f-9a3b-b14b3f407e8b",
							version = 2,
						},
					},
				},
				mechanicTime = 219,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 41,
				timerEndOffset = 4,
				uuid = "56d78498-b30e-7842-aefb-6bac20e10762",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"7aeece52-de16-c95b-a0c1-1d196c323f03",
									true,
								},
								
								{
									"edfe7dee-0d06-0fa2-9428-2c68139b16a9",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Grit",
							uuid = "7be064ac-9fb7-f0ee-bb35-3bf26e935775",
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
							buffCheckType = 2,
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "7aeece52-de16-c95b-a0c1-1d196c323f03",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"mt\"",
							name = "isMT",
							uuid = "edfe7dee-0d06-0fa2-9428-2c68139b16a9",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 247.1,
				name = "【DRK】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 49,
				timerEndOffset = 5,
				uuid = "3eeee722-6016-685f-a425-3d81661f0f01",
				version = 2,
			},
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
									"a6e87fc2-18f8-9d4e-b35e-13f7984533fc",
									true,
								},
								
								{
									"7357dd1a-4953-457a-aa53-94525b7a524c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_ReleaseGrit",
							uuid = "ac0bc610-5a4d-e51d-8677-4fe60250b42f",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "a6e87fc2-18f8-9d4e-b35e-13f7984533fc",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isOT",
							uuid = "7357dd1a-4953-457a-aa53-94525b7a524c",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 247.1,
				name = "【DRK】关闭盾姿",
				timeRange = true,
				timelineIndex = 49,
				timerEndOffset = 5,
				uuid = "ea71797a-eec1-a88b-a126-303dee093738",
				version = 2,
			},
			inheritedIndex = 2,
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
							aType = "ACR",
							actionID = 3634,
							conditions = 
							{
								
								{
									"6d8c770e-64b1-c532-849b-4f2a5176f279",
									true,
								},
								
								{
									"0fa627a9-8f91-edb4-83c1-35c1d93919b5",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "f6f04141-dad7-c485-9fbb-649e0d1e2ba5",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "6d8c770e-64b1-c532-849b-4f2a5176f279",
							version = 2,
						},
					},
					
					{
						data = 
						{
							conditionType = 4,
							enmityValue = 100,
							uuid = "0fa627a9-8f91-edb4-83c1-35c1d93919b5",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 283.4,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 65,
				timerEndOffset = 5,
				timerOffset = -5,
				timerStartOffset = 2,
				uuid = "699b0143-589b-d1bb-a5c3-e8c508d25ade",
				version = 2,
			},
			inheritedIndex = 5,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
								
								{
									"8abe4c4e-72c6-0cf2-87b9-ee49cee036ee",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
					
					{
						data = 
						{
							conditionType = 4,
							enmityValue = 100,
							uuid = "8abe4c4e-72c6-0cf2-87b9-ee49cee036ee",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 292.6,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 5,
				timerStartOffset = 1,
				uuid = "9e88508a-893e-2383-a391-c1a337e332cc",
				version = 2,
			},
			inheritedIndex = 3,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"4654df9b-ce44-60cb-bd46-54492328a1e9",
									true,
								},
								
								{
									"8935f109-1f29-fdfe-89bc-87baf32d6690",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							uuid = "01a644ff-a749-e4ec-a6f4-e57ab482dc1c",
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
							actionID = 3636,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "4654df9b-ce44-60cb-bd46-54492328a1e9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							conditionType = 4,
							enmityValue = 100,
							uuid = "8935f109-1f29-fdfe-89bc-87baf32d6690",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 306.6,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 71,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "0f0ae333-27cd-0546-9c07-2667216c838b",
				version = 2,
			},
			inheritedIndex = 4,
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
							aType = "ACR",
							actionID = 3634,
							conditions = 
							{
								
								{
									"a4a256b6-f85d-33c1-9e48-d3612b113f1a",
									true,
								},
								
								{
									"2a251068-8ba6-0f8d-9852-bcdfbeb3c595",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "6552063f-9a2c-64a3-a2ca-cd8e21b8a95a",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "a4a256b6-f85d-33c1-9e48-d3612b113f1a",
							version = 2,
						},
					},
					
					{
						data = 
						{
							conditionType = 4,
							enmityValue = 100,
							uuid = "2a251068-8ba6-0f8d-9852-bcdfbeb3c595",
							version = 2,
						},
					},
				},
				mechanicTime = 363.5,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = 6,
				timerOffset = -5,
				timerStartOffset = 3,
				uuid = "eb8b13a2-23dd-732d-bf7a-d2d51c9cde7f",
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
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 500,
				name = "---------------",
				timelineIndex = 119,
				uuid = "2ba84b12-61dd-9ae5-9d79-58e4bda0e852",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 500,
				name = "--P3一死刑不吃--",
				timelineIndex = 119,
				uuid = "a016d5d6-7f6e-8873-8688-a93a8fdb8152",
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
									"a6e87fc2-18f8-9d4e-b35e-13f7984533fc",
									true,
								},
								
								{
									"32b3f779-8271-10d7-803b-d44b642fabca",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_ReleaseGrit",
							uuid = "ac0bc610-5a4d-e51d-8677-4fe60250b42f",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "a6e87fc2-18f8-9d4e-b35e-13f7984533fc",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 3 or MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 4",
							name = "p3-不吃",
							uuid = "32b3f779-8271-10d7-803b-d44b642fabca",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 500,
				name = "【DRK】关闭盾姿",
				timeRange = true,
				timelineIndex = 119,
				timerEndOffset = 5,
				uuid = "97563dc4-5e74-5805-b250-cd0ab7c24735",
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
				enabled = false,
				mechanicTime = 500,
				name = "---------------",
				timelineIndex = 119,
				uuid = "ba268215-0ac5-92d6-a3ee-41abdf2c89f8",
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
				mechanicTime = 500,
				name = "--P3一死刑自己吃--",
				timelineIndex = 119,
				uuid = "11ffbd78-2357-3e6b-a14a-38918ac8dc0a",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"67bdb726-db0a-77c0-80dd-a5da7d5dd1f5",
									true,
								},
								
								{
									"fbccde26-4e08-b39a-80d7-70c1b853f777",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Grit",
							uuid = "500a5aca-3f24-96a2-ad68-690f830d23a7",
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
							buffCheckType = 2,
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "67bdb726-db0a-77c0-80dd-a5da7d5dd1f5",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 1 or MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 2",
							name = "p3-1/2",
							uuid = "fbccde26-4e08-b39a-80d7-70c1b853f777",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 500,
				name = "【DRK】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 119,
				timerEndOffset = 5,
				uuid = "1baf374c-6d59-38bf-9a29-d84733ae599a",
				version = 2,
			},
			inheritedIndex = 6,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"67bdb726-db0a-77c0-80dd-a5da7d5dd1f5",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Grit",
							uuid = "500a5aca-3f24-96a2-ad68-690f830d23a7",
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
							buffCheckType = 2,
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "67bdb726-db0a-77c0-80dd-a5da7d5dd1f5",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 554,
				name = "【DRK】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 130,
				timerEndOffset = 5,
				uuid = "dc068700-6a83-c5e7-89f3-8834f0084ed5",
				version = 2,
			},
			inheritedIndex = 3,
		},
	},
	[140] = 
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
				mechanicTime = 595.4,
				name = "---------------",
				timelineIndex = 140,
				uuid = "df0bdc86-d933-54b7-bd36-32df98393ac8",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 595.4,
				name = "--自己全减吃--",
				timelineIndex = 140,
				uuid = "31f43a54-450f-c7b6-833f-543565514c6b",
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
									"5bd11228-6e04-8814-afac-604676843c7e",
									true,
								},
								
								{
									"3e4c4f65-e01e-cc0b-b6d0-77d74a8c3174",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "a237737c-e2c6-d8d8-8d23-e06334850be5",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "5bd11228-6e04-8814-afac-604676843c7e",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 1",
							name = "p3-1",
							uuid = "3e4c4f65-e01e-cc0b-b6d0-77d74a8c3174",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 595.4,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 140,
				timerStartOffset = -16,
				uuid = "cd7c6a18-24e7-9aae-802d-f3850a3fd621",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"2c00a52d-06b2-ea1e-ace1-5825b5085b85",
									true,
								},
								
								{
									"8eff9f3c-e339-de7d-9251-f11a6fcbd509",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							ignoreWeaveRules = true,
							uuid = "aee1b476-375c-c124-87a3-27ef3dc29434",
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
							actionID = 36927,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "2c00a52d-06b2-ea1e-ace1-5825b5085b85",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 1",
							name = "p3-1",
							uuid = "8eff9f3c-e339-de7d-9251-f11a6fcbd509",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 595.4,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 140,
				timerStartOffset = -14,
				uuid = "f6a3fe6a-6ad4-728f-9d9c-135b02df02fd",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ce1b0d8c-f414-7b9c-abad-c163d217cc8c",
									true,
								},
								
								{
									"766697b8-b8a5-9c05-809c-e2445d6081d3",
									true,
								},
								
								{
									"60e9efa3-e8b5-62b4-8926-9296c67b9e94",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightSelf",
							uuid = "7683f93b-ca4a-a1a7-9d88-fc3375f139b6",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "ce1b0d8c-f414-7b9c-abad-c163d217cc8c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "766697b8-b8a5-9c05-809c-e2445d6081d3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 1",
							name = "p3-1",
							uuid = "60e9efa3-e8b5-62b4-8926-9296c67b9e94",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 595.4,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 140,
				timerStartOffset = -6,
				uuid = "08e56405-84ca-a934-a254-45de295977ac",
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
							actionID = 3634,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5ba831d4-b3b7-01d2-abca-545fb1bbfac3",
									true,
								},
								
								{
									"60bc6d40-20fb-776d-aaa0-d53e26b24cfc",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "287b3309-15fa-9102-9001-1f868f6202ae",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "5ba831d4-b3b7-01d2-abca-545fb1bbfac3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 1",
							name = "p3-1",
							uuid = "60bc6d40-20fb-776d-aaa0-d53e26b24cfc",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 595.4,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 140,
				timerOffset = -5,
				timerStartOffset = -8,
				uuid = "893ea4d6-b12f-85de-ae41-c652a36705b1",
				version = 2,
			},
			inheritedIndex = 7,
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
				mechanicTime = 595.4,
				name = "---------------",
				timelineIndex = 140,
				uuid = "33c470bf-bf05-24c7-adce-4c161f5c2a1c",
				version = 2,
			},
			inheritedIndex = 8,
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
				mechanicTime = 595.4,
				name = "--自己无敌吃--",
				timelineIndex = 140,
				uuid = "eb2a17dc-7024-4794-a8e8-b2b9ecf3efdd",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
									true,
								},
								
								{
									"b0dc6a7d-c562-48af-bef6-88f6e9e8987e",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_LivingDead",
							uuid = "a990d73c-774f-be61-ac18-c6e0e8808d9f",
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
							actionID = 3638,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 2",
							name = "p3-1",
							uuid = "b0dc6a7d-c562-48af-bef6-88f6e9e8987e",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 595.4,
				name = "【DRK】行尸走肉",
				timeRange = true,
				timelineIndex = 140,
				timerStartOffset = -5,
				uuid = "5b82d1ce-b5e1-5199-888a-e94e7b7c7ca7",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"2832a370-7fc6-e01b-8d1b-949869387d85",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_OblationSelf",
							uuid = "e7c8b700-b1e9-0e23-b0d9-7ea24081fff5",
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
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 1\n",
							name = "p3-1",
							uuid = "2832a370-7fc6-e01b-8d1b-949869387d85",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 595.4,
				name = "【DRK】献奉",
				timeRange = true,
				timelineIndex = 140,
				timerOffset = -7,
				timerStartOffset = -8,
				uuid = "903b3c96-55b0-3ec8-8161-9a8b7449f05d",
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
				mechanicTime = 595.4,
				name = "--搭档减伤吃--",
				timelineIndex = 140,
				uuid = "42d6aab6-a994-a238-a545-dc8f486e3ea2",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ce1b0d8c-f414-7b9c-abad-c163d217cc8c",
									true,
								},
								
								{
									"766697b8-b8a5-9c05-809c-e2445d6081d3",
									true,
								},
								
								{
									"60e9efa3-e8b5-62b4-8926-9296c67b9e94",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightOT",
							uuid = "7683f93b-ca4a-a1a7-9d88-fc3375f139b6",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "ce1b0d8c-f414-7b9c-abad-c163d217cc8c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "766697b8-b8a5-9c05-809c-e2445d6081d3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 3",
							name = "p3-1",
							uuid = "60e9efa3-e8b5-62b4-8926-9296c67b9e94",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 595.4,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 140,
				timerStartOffset = -6,
				uuid = "e873550c-10a7-1cf9-b890-41d8e557085b",
				version = 2,
			},
			inheritedIndex = 13,
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
				mechanicTime = 595.4,
				name = "---------------",
				timelineIndex = 140,
				uuid = "fe8ecce3-0c93-b1d0-b4a6-02ed6c46b8ce",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"575eacf6-1538-72ab-8a5b-261a188e217e",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 1 or MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 2",
							name = "自己吃二运超级跳",
							uuid = "575eacf6-1538-72ab-8a5b-261a188e217e",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 595.4,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 140,
				timerEndOffset = 5,
				timerStartOffset = -2,
				uuid = "9555589f-b043-c4e6-b255-5fc495c619ae",
				version = 2,
			},
			inheritedIndex = 15,
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
				mechanicTime = 595.4,
				name = "---------------",
				timelineIndex = 140,
				uuid = "0f9a2f90-79c2-a31c-b7c9-4d9046b44d97",
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
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 644.3,
				name = "---------------",
				timelineIndex = 150,
				uuid = "b5431dbe-b460-bd42-afc4-87ad83abed62",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 644.3,
				name = "--自己全减吃--",
				timelineIndex = 150,
				uuid = "54b4e988-2df4-5f6e-bec1-bfd2cf28cbdf",
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
									"adefd88b-ffb0-b18e-8aa9-074257fa6cd5",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_OblationSelf",
							uuid = "829b27b1-9a80-12c7-907a-6d825971e4f8",
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
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 1",
							name = "p3",
							uuid = "adefd88b-ffb0-b18e-8aa9-074257fa6cd5",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 644.3,
				name = "【DRK】献奉",
				timeRange = true,
				timelineIndex = 150,
				timerOffset = -7,
				timerStartOffset = -8,
				uuid = "0a69e522-9ecf-23ec-846d-2201e4bb757a",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
								
								{
									"f43e185f-07ac-d13d-8375-89c2bcda93a8",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 1",
							name = "p3",
							uuid = "f43e185f-07ac-d13d-8375-89c2bcda93a8",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 644.3,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 150,
				timerStartOffset = -15,
				uuid = "41ab0d99-2be7-4ea8-8a18-4171dab1d9d6",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"4654df9b-ce44-60cb-bd46-54492328a1e9",
									true,
								},
								
								{
									"39d4495f-19ea-384d-8ef6-198c6557852b",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							uuid = "01a644ff-a749-e4ec-a6f4-e57ab482dc1c",
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
							actionID = 3636,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "4654df9b-ce44-60cb-bd46-54492328a1e9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 1",
							name = "p3",
							uuid = "39d4495f-19ea-384d-8ef6-198c6557852b",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 644.3,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 150,
				timerStartOffset = -10,
				uuid = "7f5b537a-1537-dab1-bea3-ecac0e16a77e",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"59a19b26-9a48-d0dc-a290-1dcb77439916",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightSelf",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 1",
							name = "p3",
							uuid = "59a19b26-9a48-d0dc-a290-1dcb77439916",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 644.3,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 150,
				timerStartOffset = -6,
				uuid = "6fd141b1-ba69-f483-830e-9bfb0a76871c",
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
							aType = "ACR",
							actionID = 3634,
							conditions = 
							{
								
								{
									"6d8c770e-64b1-c532-849b-4f2a5176f279",
									true,
								},
								
								{
									"5f0049eb-01c3-d94f-8f2f-2aec2df61639",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "f6f04141-dad7-c485-9fbb-649e0d1e2ba5",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "6d8c770e-64b1-c532-849b-4f2a5176f279",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 1",
							name = "p3",
							uuid = "5f0049eb-01c3-d94f-8f2f-2aec2df61639",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 644.3,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 150,
				timerOffset = -5,
				timerStartOffset = -8,
				uuid = "8ea09cea-af57-a976-9624-4b004db5d5e6",
				version = 2,
			},
			inheritedIndex = 7,
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
				mechanicTime = 644.3,
				name = "---------------",
				timelineIndex = 150,
				uuid = "7191ee77-c7ff-b1f2-a060-6b2e4c2935de",
				version = 2,
			},
			inheritedIndex = 8,
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
				mechanicTime = 644.3,
				name = "--自己无敌吃--",
				timelineIndex = 150,
				uuid = "2587ca42-77f2-adb0-acee-8ab131be346d",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
									true,
								},
								
								{
									"6f9f67c2-ec41-ad93-aa6f-c1e238f98069",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_LivingDead",
							uuid = "a990d73c-774f-be61-ac18-c6e0e8808d9f",
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
							actionID = 3638,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 2",
							name = "p3",
							uuid = "6f9f67c2-ec41-ad93-aa6f-c1e238f98069",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 644.3,
				name = "【DRK】行尸走肉",
				timeRange = true,
				timelineIndex = 150,
				timerStartOffset = -5,
				uuid = "23d63940-4596-6e61-9475-35059ad34158",
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
				mechanicTime = 644.3,
				name = "---------------",
				timelineIndex = 150,
				uuid = "c66eba80-e954-16f1-8bab-b7b90847888c",
				version = 2,
			},
			inheritedIndex = 12,
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
				mechanicTime = 644.3,
				name = "--搭档减伤吃--",
				timelineIndex = 150,
				uuid = "833ce32d-32e8-b1ce-8af8-d308cac1853b",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ce1b0d8c-f414-7b9c-abad-c163d217cc8c",
									true,
								},
								
								{
									"766697b8-b8a5-9c05-809c-e2445d6081d3",
									true,
								},
								
								{
									"f234661f-802e-8167-bede-3e035a01cd84",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightOT",
							uuid = "7683f93b-ca4a-a1a7-9d88-fc3375f139b6",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "ce1b0d8c-f414-7b9c-abad-c163d217cc8c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "766697b8-b8a5-9c05-809c-e2445d6081d3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 3",
							name = "p3",
							uuid = "f234661f-802e-8167-bede-3e035a01cd84",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 644.3,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 150,
				timerStartOffset = -6,
				uuid = "e5bd4fee-6ec0-f382-aca3-ba935ccf40e2",
				version = 2,
			},
			inheritedIndex = 14,
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
				mechanicTime = 644.3,
				name = "---------------",
				timelineIndex = 150,
				uuid = "6b4a949a-2141-abd8-bc3a-a6ee6d3e3d59",
				version = 2,
			},
			inheritedIndex = 15,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"f0ab1639-be4f-87b6-9398-bb61ee37a261",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"mt\"",
							name = "isMT",
							uuid = "f0ab1639-be4f-87b6-9398-bb61ee37a261",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 705.3,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 156,
				timerEndOffset = 5,
				uuid = "0d9ea9b7-1b94-c997-a975-1dbe264912fb",
				version = 2,
			},
			inheritedIndex = 15,
		},
	},
	[162] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7533,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 9832,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isOT",
							uuid = "9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 729.2,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 162,
				timerEndOffset = 5,
				uuid = "8cbde8e2-a1d7-9485-8463-c0532db72ff4",
				version = 2,
			},
			inheritedIndex = 15,
		},
	},
	[172] = 
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
				mechanicTime = 760.4,
				name = "---------------",
				timelineIndex = 172,
				uuid = "f1d73964-055a-3008-a45b-9be6fa845f5f",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 760.4,
				name = "--自己全减吃--",
				timelineIndex = 172,
				uuid = "bd7da914-7290-ee14-a4d1-ccab75eee337",
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
									"da1630f3-9785-2625-a6a5-dc65898adabc",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_OblationSelf",
							uuid = "829b27b1-9a80-12c7-907a-6d825971e4f8",
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
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_DarkestDance == 1",
							name = "p4",
							uuid = "da1630f3-9785-2625-a6a5-dc65898adabc",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 760.4,
				name = "【DRK】献奉",
				timeRange = true,
				timelineIndex = 172,
				timerOffset = -7,
				timerStartOffset = -5,
				uuid = "11758f1f-0e0b-5a2a-9480-8eb445867051",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
								
								{
									"9823c31f-560d-426a-b0ec-f6cec7fd0181",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_DarkestDance == 1",
							name = "p4",
							uuid = "9823c31f-560d-426a-b0ec-f6cec7fd0181",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 760.4,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 172,
				timerStartOffset = -15,
				uuid = "49a4a17f-d377-e83e-9924-a7c8afe17999",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"4654df9b-ce44-60cb-bd46-54492328a1e9",
									true,
								},
								
								{
									"0e9a04c0-a148-9b9b-b2f8-a6fcb693d55b",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							uuid = "01a644ff-a749-e4ec-a6f4-e57ab482dc1c",
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
							actionID = 3636,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "4654df9b-ce44-60cb-bd46-54492328a1e9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_DarkestDance == 1",
							name = "p4",
							uuid = "0e9a04c0-a148-9b9b-b2f8-a6fcb693d55b",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 760.4,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 172,
				timerStartOffset = -10,
				uuid = "59453e81-6ba0-1230-a114-735534ab3667",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"fb18948c-a48a-6846-aa92-88c40fc551ab",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightSelf",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_DarkestDance == 1",
							name = "p4",
							uuid = "fb18948c-a48a-6846-aa92-88c40fc551ab",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 760.4,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 172,
				timerStartOffset = -3,
				uuid = "647c580c-82d0-84f1-ad17-06e97a273954",
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
							aType = "ACR",
							actionID = 3634,
							conditions = 
							{
								
								{
									"6d8c770e-64b1-c532-849b-4f2a5176f279",
									true,
								},
								
								{
									"c465564c-3f1a-0d49-b9c5-50810446d615",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "f6f04141-dad7-c485-9fbb-649e0d1e2ba5",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "6d8c770e-64b1-c532-849b-4f2a5176f279",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_DarkestDance == 1",
							name = "p4",
							uuid = "c465564c-3f1a-0d49-b9c5-50810446d615",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 760.4,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 172,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "4f29ab96-371b-9057-a5fe-2af5792c34d5",
				version = 2,
			},
			inheritedIndex = 7,
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
				mechanicTime = 760.4,
				name = "---------------",
				timelineIndex = 172,
				uuid = "faec1e28-6c60-6ee6-b80c-77d7a13fa2e3",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
									true,
								},
								
								{
									"16ce30be-e97e-8b54-9eae-4f3cf1d72f8b",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_LivingDead",
							uuid = "a990d73c-774f-be61-ac18-c6e0e8808d9f",
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
							actionID = 3638,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_DarkestDance == 2",
							name = "p4",
							uuid = "16ce30be-e97e-8b54-9eae-4f3cf1d72f8b",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 760.4,
				name = "【DRK】行尸走肉",
				timeRange = true,
				timelineIndex = 172,
				timerStartOffset = -5,
				uuid = "b991feb3-ac4a-0609-b901-726d0d1b2af6",
				version = 2,
			},
			inheritedIndex = 9,
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
				mechanicTime = 760.4,
				name = "--自己无敌吃--",
				timelineIndex = 172,
				uuid = "b4f99772-0122-0c88-812c-a17b22f720cd",
				version = 2,
			},
			inheritedIndex = 10,
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
				mechanicTime = 760.4,
				name = "---------------",
				timelineIndex = 172,
				uuid = "36e032b9-2515-7535-ad28-d15f89b74408",
				version = 2,
			},
			inheritedIndex = 11,
		},
	},
	[175] = 
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
				mechanicTime = 773.5,
				name = "---------------",
				timelineIndex = 175,
				uuid = "39003066-34f9-dcbc-bfed-6f93f8ffc59f",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 773.5,
				name = "--自己减伤吃--",
				timelineIndex = 175,
				uuid = "b35ada00-1771-927b-aaa9-38656d1bcdea",
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
				mechanicTime = 773.5,
				name = "--搭档减伤吃--",
				timelineIndex = 175,
				uuid = "968b844d-ea64-6561-80eb-c48d5e08aa31",
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
				enabled = false,
				mechanicTime = 773.5,
				name = "---------------",
				timelineIndex = 175,
				uuid = "fc1e4300-2a60-564f-9698-ba173bf67098",
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
							actionID = 7533,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 9832,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isOT",
							uuid = "9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 773.5,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 175,
				timerStartOffset = -5,
				uuid = "d71b7b07-3a9f-fde9-9230-e440e9310d66",
				version = 2,
			},
			inheritedIndex = 15,
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
				mechanicTime = 773.5,
				name = "---------------",
				timelineIndex = 175,
				uuid = "bc2b8f00-f3b4-c4ba-99c8-4ef0c547b66e",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
								
								{
									"a3a213f7-1ef2-bd3f-8073-e6324632ee63",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 1\n",
							name = "p4",
							uuid = "a3a213f7-1ef2-bd3f-8073-e6324632ee63",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 773.5,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 175,
				timerStartOffset = -12,
				uuid = "3870dadf-93b5-6b36-ab95-a930b44fbd92",
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
							aType = "ACR",
							actionID = 3634,
							conditions = 
							{
								
								{
									"6d8c770e-64b1-c532-849b-4f2a5176f279",
									true,
								},
								
								{
									"0de57b72-dc57-4f46-91c2-277df4731ac0",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "f6f04141-dad7-c485-9fbb-649e0d1e2ba5",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "6d8c770e-64b1-c532-849b-4f2a5176f279",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 1\n",
							name = "p4",
							uuid = "0de57b72-dc57-4f46-91c2-277df4731ac0",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 773.5,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 175,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "82dc5291-67a6-29b6-8460-749b88a607f9",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"fc67891b-52bb-4d3f-aa8d-feb10e9c47bd",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightSelf",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 1\n",
							name = "p4",
							uuid = "fc67891b-52bb-4d3f-aa8d-feb10e9c47bd",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 773.5,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 175,
				timerStartOffset = -5,
				uuid = "7af363f3-af9e-f5f2-b8f2-beac6dbafe12",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"fc67891b-52bb-4d3f-aa8d-feb10e9c47bd",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightOT",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 2",
							name = "p4",
							uuid = "fc67891b-52bb-4d3f-aa8d-feb10e9c47bd",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 773.5,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 175,
				timerStartOffset = -5,
				uuid = "81febb46-9c5b-460b-a64b-714aea6b5869",
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
							actionID = 7533,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 12809,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"mt\"",
							name = "isMT",
							uuid = "9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 773.5,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 175,
				timerStartOffset = -5,
				uuid = "eb1af52f-bc69-7e3e-a65f-c606ec716032",
				version = 2,
			},
			inheritedIndex = 15,
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
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
								
								{
									"a3a213f7-1ef2-bd3f-8073-e6324632ee63",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 3 and MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 3\n",
							name = "p4",
							uuid = "a3a213f7-1ef2-bd3f-8073-e6324632ee63",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 845.7,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 198,
				timerStartOffset = -19,
				uuid = "42e31c97-bd21-6ffe-8c28-46dd5481e448",
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
							aType = "ACR",
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_OblationSelf",
							uuid = "829b27b1-9a80-12c7-907a-6d825971e4f8",
							variableTogglesType = 3,
							version = 2.1,
						},
						inheritedIndex = 1,
					},
				},
				conditions = 
				{
				},
				mechanicTime = 845.7,
				name = "【DRK】献奉",
				timeRange = true,
				timelineIndex = 198,
				timerOffset = -7,
				timerStartOffset = -9,
				uuid = "ed552dca-b23a-31df-9322-4f6e1ae35372",
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
							actionID = 3634,
							conditions = 
							{
								
								{
									"6d8c770e-64b1-c532-849b-4f2a5176f279",
									true,
								},
								
								{
									"d82b2f65-c1cb-b7b5-9f98-dda8cd958842",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "f6f04141-dad7-c485-9fbb-649e0d1e2ba5",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "6d8c770e-64b1-c532-849b-4f2a5176f279",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 3 and MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 3\n",
							name = "p4",
							uuid = "d82b2f65-c1cb-b7b5-9f98-dda8cd958842",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 845.7,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 198,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "51d5fd92-d0cf-b2c8-a377-621d4c75392b",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"4654df9b-ce44-60cb-bd46-54492328a1e9",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							uuid = "01a644ff-a749-e4ec-a6f4-e57ab482dc1c",
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
							actionID = 3636,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "4654df9b-ce44-60cb-bd46-54492328a1e9",
							version = 2,
						},
					},
				},
				mechanicTime = 845.7,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 198,
				timerStartOffset = -14,
				uuid = "a8f3570f-7fa9-c63f-8735-39a491a6ebc1",
				version = 2,
			},
			inheritedIndex = 4,
		},
	},
	[202] = 
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
				mechanicTime = 854.9,
				name = "---------------",
				timelineIndex = 202,
				uuid = "c09abbe3-58b4-ba6c-9a56-02d95cf37ab1",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 854.9,
				name = "--自己减伤吃--",
				timelineIndex = 202,
				uuid = "4f40062d-28ce-5b7e-8615-338d495618d3",
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
				mechanicTime = 854.9,
				name = "--搭档减伤吃--",
				timelineIndex = 202,
				uuid = "5605171a-f497-fa33-8957-c48e9822003e",
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
				enabled = false,
				mechanicTime = 854.9,
				name = "---------------",
				timelineIndex = 202,
				uuid = "4ef5ae87-1003-63e6-91cd-d24f9c3f2c0b",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"71c2dc8a-9e0a-140b-9f44-c8c4614cba40",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightSelf",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 1",
							name = "p4",
							uuid = "71c2dc8a-9e0a-140b-9f44-c8c4614cba40",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 854.9,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 202,
				timerStartOffset = -5,
				uuid = "7f73f6ad-d317-50c3-aad8-f8b33054a537",
				version = 2,
			},
			inheritedIndex = 5,
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
				mechanicTime = 854.9,
				name = "---------------",
				timelineIndex = 202,
				uuid = "9aed0e96-7a48-c95e-a2b7-65fa75492c95",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
								
								{
									"e5fd62f9-481f-0b2d-a27d-1d29197b3789",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 1",
							name = "p4",
							uuid = "e5fd62f9-481f-0b2d-a27d-1d29197b3789",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 854.9,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 202,
				timerStartOffset = -12,
				uuid = "8d350fca-874a-9ded-8d21-b7ccf62be84d",
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
							aType = "ACR",
							actionID = 3634,
							conditions = 
							{
								
								{
									"6d8c770e-64b1-c532-849b-4f2a5176f279",
									true,
								},
								
								{
									"cd42bf4b-add4-e937-9e74-48b0dfe402c0",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "f6f04141-dad7-c485-9fbb-649e0d1e2ba5",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "6d8c770e-64b1-c532-849b-4f2a5176f279",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 1",
							name = "p4",
							uuid = "cd42bf4b-add4-e937-9e74-48b0dfe402c0",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 854.9,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 202,
				timerOffset = -5,
				timerStartOffset = -5,
				uuid = "b563e172-0bdb-d2d4-8189-ce6bfce3aa4a",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"25003403-2a8d-1ba2-9ae7-8d476947dffa",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightOT",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 2",
							name = "p4",
							uuid = "25003403-2a8d-1ba2-9ae7-8d476947dffa",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 854.9,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 202,
				timerStartOffset = -5,
				uuid = "6cc77ded-3c06-ee08-93c4-44d2e69954ff",
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
							actionID = 7533,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 9832,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isOT",
							uuid = "9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 854.9,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 202,
				timerStartOffset = -5,
				uuid = "447a28db-4028-5d87-9325-26d62c359102",
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
							actionID = 7533,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 12809,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"mt\"",
							name = "isMT",
							uuid = "9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 854.9,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 202,
				timerStartOffset = -5,
				uuid = "cfd8af92-d528-4115-8343-ba0d88dd1993",
				version = 2,
			},
			inheritedIndex = 15,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
								
								{
									"2570bcc9-351b-96dc-b081-5e0d6fc70472",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 2",
							name = "p5",
							uuid = "2570bcc9-351b-96dc-b081-5e0d6fc70472",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 984.8,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 209,
				timerStartOffset = -3,
				uuid = "c9dd18dc-5ad4-41a0-ac7b-bef6ee0de9ea",
				version = 2,
			},
			inheritedIndex = 4,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"4654df9b-ce44-60cb-bd46-54492328a1e9",
									true,
								},
								
								{
									"8be62a4b-1a17-ace8-b617-4f1e1e2319b5",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							uuid = "01a644ff-a749-e4ec-a6f4-e57ab482dc1c",
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
							actionID = 3636,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "4654df9b-ce44-60cb-bd46-54492328a1e9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 2",
							name = "p5",
							uuid = "8be62a4b-1a17-ace8-b617-4f1e1e2319b5",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1011.4,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 215,
				timerStartOffset = -14,
				uuid = "3ce2d07c-8675-d9d8-9e58-3616cbbbae2f",
				version = 2,
			},
			inheritedIndex = 3,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"a4f11d16-c270-ccaa-891a-46704e142afd",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isot",
							uuid = "a4f11d16-c270-ccaa-891a-46704e142afd",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 1029.6,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 218,
				timerEndOffset = 2,
				timerStartOffset = -5,
				uuid = "819ac9de-7cf7-e4fd-90c0-81973c7756d9",
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
									"ad264d5e-7021-a254-838a-83ca9f6eca8e",
									true,
								},
								
								{
									"5a99e178-c1d8-be9b-bd28-db2305bcaa2e",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_ShirkOT",
							uuid = "8fd7f15b-cd53-05a4-8f30-1fb825db7f95",
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
							comparator = 2,
							conditionType = 4,
							enmityValue = 99.999000549316,
							uuid = "5a99e178-c1d8-be9b-bd28-db2305bcaa2e",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"mt\"",
							name = "isMT",
							uuid = "ad264d5e-7021-a254-838a-83ca9f6eca8e",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 1029.6,
				name = " 退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 218,
				timerEndOffset = 3,
				timerStartOffset = -5,
				uuid = "326a1a37-85d5-272a-be29-d234c524ad60",
				version = 2,
			},
			inheritedIndex = 14,
		},
	},
	[222] = 
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
				mechanicTime = 1033.6,
				name = "---------------",
				timelineIndex = 222,
				uuid = "f32626aa-dfb8-a54e-891e-0ce9c8e98026",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 1033.6,
				name = "--自己全减吃--",
				timelineIndex = 222,
				uuid = "3e6c7c01-c6bf-a2c1-8856-973c32ef1890",
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
									"36513215-e4f7-c844-a8d3-046715ca735b",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_OblationSelf",
							uuid = "829b27b1-9a80-12c7-907a-6d825971e4f8",
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
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 1",
							name = "p5",
							uuid = "36513215-e4f7-c844-a8d3-046715ca735b",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1033.6,
				name = "【DRK】献奉",
				timeRange = true,
				timelineIndex = 222,
				timerOffset = -7,
				timerStartOffset = -9,
				uuid = "785f4dc9-0243-26c2-8a81-8e24458c7e0c",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
								
								{
									"2570bcc9-351b-96dc-b081-5e0d6fc70472",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 1",
							name = "p5",
							uuid = "2570bcc9-351b-96dc-b081-5e0d6fc70472",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1033.6,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 222,
				timerStartOffset = -18,
				uuid = "5f3b4ac9-8272-a9df-b11e-42a9d2f26704",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"4654df9b-ce44-60cb-bd46-54492328a1e9",
									true,
								},
								
								{
									"5a14301e-91fd-5b7e-beb7-aa40cf41524b",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							uuid = "01a644ff-a749-e4ec-a6f4-e57ab482dc1c",
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
							actionID = 3636,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "4654df9b-ce44-60cb-bd46-54492328a1e9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 1",
							name = "p5",
							uuid = "5a14301e-91fd-5b7e-beb7-aa40cf41524b",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1033.6,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 222,
				timerStartOffset = -14,
				uuid = "889b0c00-94c5-3bdb-8d2f-bace30d508c9",
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
							aType = "ACR",
							actionID = 3634,
							conditions = 
							{
								
								{
									"6d8c770e-64b1-c532-849b-4f2a5176f279",
									true,
								},
								
								{
									"8b9e4e94-d5ee-91e6-958d-00b6da127dd3",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "f6f04141-dad7-c485-9fbb-649e0d1e2ba5",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "6d8c770e-64b1-c532-849b-4f2a5176f279",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 1",
							name = "p5",
							uuid = "8b9e4e94-d5ee-91e6-958d-00b6da127dd3",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1033.6,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 222,
				timerOffset = -5,
				timerStartOffset = -9,
				uuid = "01928a05-8ddc-9495-8ec7-859cfaf46fc1",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"5b521d6f-129e-3861-9d1d-e61f5f430b57",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightSelf",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 1",
							name = "p5",
							uuid = "5b521d6f-129e-3861-9d1d-e61f5f430b57",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1033.6,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 222,
				timerStartOffset = -3,
				uuid = "cf7911ba-e087-42bc-a344-6d63c7d4b036",
				version = 2,
			},
			inheritedIndex = 7,
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
				mechanicTime = 1033.6,
				name = "---------------",
				timelineIndex = 222,
				uuid = "847159e2-827c-8787-aa20-a043c374ee5d",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
									true,
								},
								
								{
									"a94736a5-e4f0-fc1f-a2d9-5dcded680188",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_LivingDead",
							uuid = "a990d73c-774f-be61-ac18-c6e0e8808d9f",
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
							actionID = 3638,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 2",
							name = "p5",
							uuid = "a94736a5-e4f0-fc1f-a2d9-5dcded680188",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1033.6,
				name = "【DRK】行尸走肉",
				timeRange = true,
				timelineIndex = 222,
				timerStartOffset = -8,
				uuid = "f53647f4-83aa-34e0-90d2-4b1e55aa73f6",
				version = 2,
			},
			inheritedIndex = 9,
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
				mechanicTime = 1033.6,
				name = "--自己无敌吃--",
				timelineIndex = 222,
				uuid = "8e0bbb77-6612-957d-b08d-e44e6f0f01ec",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"bc616186-0558-daed-ba9b-16b4359480b9",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightOT",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 2",
							name = "p5",
							uuid = "bc616186-0558-daed-ba9b-16b4359480b9",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1033.6,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 3,
				timerStartOffset = -2,
				uuid = "890c0968-0fb6-9884-a308-5ce88e5a2119",
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
				mechanicTime = 1033.6,
				name = "---------------",
				timelineIndex = 222,
				uuid = "3e8f9519-c7d6-171f-981f-f39c62019599",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"5a99e178-c1d8-be9b-bd28-db2305bcaa2e",
									true,
								},
								
								{
									"71d1af24-0e7c-1104-9548-aac1002348cd",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_ShirkOT",
							uuid = "8fd7f15b-cd53-05a4-8f30-1fb825db7f95",
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
							comparator = 2,
							conditionType = 4,
							enmityValue = 99.999000549316,
							uuid = "5a99e178-c1d8-be9b-bd28-db2305bcaa2e",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isot",
							uuid = "71d1af24-0e7c-1104-9548-aac1002348cd",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 1033.6,
				name = "  退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 3,
				timerStartOffset = -5,
				uuid = "7ddaca6c-7ded-3945-a07c-33b71c0bad96",
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
							aType = "ACR",
							actionID = 7533,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 12809,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"mt\"",
							name = "isMT",
							uuid = "9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 1033.6,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 5,
				uuid = "95fbf769-2e78-dc74-b756-b9e2cd2448cc",
				version = 2,
			},
			inheritedIndex = 15,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
								
								{
									"c31ff721-5397-800a-99a2-bce1dbb9eead",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 2\n",
							name = "p5",
							uuid = "c31ff721-5397-800a-99a2-bce1dbb9eead",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1097.4,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 237,
				timerEndOffset = 5,
				timerStartOffset = -2.5,
				uuid = "dc120fa7-5c4b-9fdb-af64-5fcfc7d169e8",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[240] = 
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
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightSelf",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 1107.5,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 240,
				timerStartOffset = -5,
				uuid = "4d8027e0-6383-eaf5-b1c4-1f3aa955dbea",
				version = 2,
			},
			inheritedIndex = 7,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"a4f11d16-c270-ccaa-891a-46704e142afd",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isot",
							uuid = "a4f11d16-c270-ccaa-891a-46704e142afd",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 1146.3,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 247,
				timerEndOffset = 2,
				timerStartOffset = -5,
				uuid = "eb474362-0fc5-5a70-91b2-4a7ea1880a72",
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
									"ad264d5e-7021-a254-838a-83ca9f6eca8e",
									true,
								},
								
								{
									"5a99e178-c1d8-be9b-bd28-db2305bcaa2e",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_ShirkOT",
							uuid = "8fd7f15b-cd53-05a4-8f30-1fb825db7f95",
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
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"mt\"",
							name = "isMT",
							uuid = "ad264d5e-7021-a254-838a-83ca9f6eca8e",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							comparator = 2,
							conditionType = 4,
							enmityValue = 99.999000549316,
							uuid = "5a99e178-c1d8-be9b-bd28-db2305bcaa2e",
							version = 2,
						},
					},
				},
				mechanicTime = 1146.3,
				name = " 退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 247,
				timerEndOffset = 3,
				timerStartOffset = -5,
				uuid = "c541b02d-86d7-3212-b388-b31956fd2928",
				version = 2,
			},
			inheritedIndex = 14,
		},
	},
	[251] = 
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
				mechanicTime = 1150.3,
				name = "---------------",
				timelineIndex = 251,
				uuid = "1a4ff675-ce9b-de8a-b9c8-d78401618f9d",
				version = 2,
			},
			inheritedIndex = 1,
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
				mechanicTime = 1150.3,
				name = "--自己全减吃--",
				timelineIndex = 251,
				uuid = "1b26b71e-6851-4609-81ef-09acb1a51ba2",
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
									"36513215-e4f7-c844-a8d3-046715ca735b",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_OblationSelf",
							uuid = "829b27b1-9a80-12c7-907a-6d825971e4f8",
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
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 1",
							name = "p5",
							uuid = "36513215-e4f7-c844-a8d3-046715ca735b",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1150.3,
				name = "【DRK】献奉",
				timeRange = true,
				timelineIndex = 251,
				timerOffset = -7,
				timerStartOffset = -9,
				uuid = "abb8e74e-f474-a887-9f9b-5b16cce9021a",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
								
								{
									"2570bcc9-351b-96dc-b081-5e0d6fc70472",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 1",
							name = "p5",
							uuid = "2570bcc9-351b-96dc-b081-5e0d6fc70472",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1150.3,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 251,
				timerStartOffset = -18,
				uuid = "81387d2f-3079-971f-b0c6-ecd3c4e6c051",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"4654df9b-ce44-60cb-bd46-54492328a1e9",
									true,
								},
								
								{
									"5a14301e-91fd-5b7e-beb7-aa40cf41524b",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							uuid = "01a644ff-a749-e4ec-a6f4-e57ab482dc1c",
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
							actionID = 3636,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "4654df9b-ce44-60cb-bd46-54492328a1e9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 1",
							name = "p5",
							uuid = "5a14301e-91fd-5b7e-beb7-aa40cf41524b",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1150.3,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 251,
				timerStartOffset = -14,
				uuid = "3db618f8-3d4b-efb0-b7f4-bc2f817194d0",
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
							aType = "ACR",
							actionID = 3634,
							conditions = 
							{
								
								{
									"6d8c770e-64b1-c532-849b-4f2a5176f279",
									true,
								},
								
								{
									"8b9e4e94-d5ee-91e6-958d-00b6da127dd3",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_DarkMind",
							ignoreWeaveRules = true,
							uuid = "f6f04141-dad7-c485-9fbb-649e0d1e2ba5",
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
							actionID = 3634,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "6d8c770e-64b1-c532-849b-4f2a5176f279",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 1",
							name = "p5",
							uuid = "8b9e4e94-d5ee-91e6-958d-00b6da127dd3",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1150.3,
				name = "【DRK】弃明投暗",
				timeRange = true,
				timelineIndex = 251,
				timerOffset = -5,
				timerStartOffset = -9,
				uuid = "4083bfc4-740c-0d75-a5c2-c5c80b8f7969",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"5b521d6f-129e-3861-9d1d-e61f5f430b57",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightSelf",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 1",
							name = "p5",
							uuid = "5b521d6f-129e-3861-9d1d-e61f5f430b57",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1150.3,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 251,
				timerStartOffset = -3,
				uuid = "0d34d13f-406d-a4e4-b9a9-a9a2d6971f47",
				version = 2,
			},
			inheritedIndex = 7,
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
				mechanicTime = 1150.3,
				name = "---------------",
				timelineIndex = 251,
				uuid = "ad438180-711c-04cb-b81d-ba3e1bdc3fbb",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
									true,
								},
								
								{
									"a94736a5-e4f0-fc1f-a2d9-5dcded680188",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_LivingDead",
							uuid = "a990d73c-774f-be61-ac18-c6e0e8808d9f",
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
							actionID = 3638,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "0f73c4c8-816b-4788-a3fd-e72b9dd3c3d3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 2",
							name = "p5",
							uuid = "a94736a5-e4f0-fc1f-a2d9-5dcded680188",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1150.3,
				name = "【DRK】行尸走肉",
				timeRange = true,
				timelineIndex = 251,
				timerStartOffset = -8,
				uuid = "c9891fe3-e207-d4ac-a9e8-aef76167bc3c",
				version = 2,
			},
			inheritedIndex = 9,
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
				mechanicTime = 1150.3,
				name = "--自己无敌吃--",
				timelineIndex = 251,
				uuid = "27f4a6b2-a535-6789-945f-7f53d6e6ea29",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"53628e10-2c26-c038-b7e1-908bfb5926ee",
									true,
								},
								
								{
									"69915919-2b59-a958-8223-c06fa51e55ff",
									true,
								},
								
								{
									"bc616186-0558-daed-ba9b-16b4359480b9",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Tankbar_TheBlackestNightOT",
							uuid = "6af6d053-f995-3460-aa39-66200fb153f4",
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
							category = "Self",
							conditionType = 3,
							mpType = 2,
							mpValue = 3000,
							uuid = "53628e10-2c26-c038-b7e1-908bfb5926ee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7393,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "69915919-2b59-a958-8223-c06fa51e55ff",
							version = 2,
						},
						inheritedIndex = 3,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 2",
							name = "p5",
							uuid = "bc616186-0558-daed-ba9b-16b4359480b9",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 1150.3,
				name = "【DRK】至黑之夜",
				timeRange = true,
				timelineIndex = 251,
				timerEndOffset = 3,
				timerStartOffset = -2,
				uuid = "b1509c99-f07e-cd8a-88d2-5c4e27f004b9",
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
				mechanicTime = 1150.3,
				name = "---------------",
				timelineIndex = 251,
				uuid = "5141158f-4052-47d0-ba5c-aa51f6c73ea9",
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
							aType = "ACR",
							actionID = 7533,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
									true,
								},
								
								{
									"9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 12809,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "046e6a61-25ce-5483-9dd1-393356f54509",
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
							buffID = 743,
							category = "Self",
							name = "深恶痛绝",
							uuid = "2411cfc1-3dbf-b4ff-82d2-f9809ecef3f6",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"mt\"",
							name = "isMT",
							uuid = "9e2b6d3f-96aa-0f2d-b35b-8b494302f297",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 1150.3,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 251,
				timerEndOffset = 5,
				uuid = "11d1554d-36d8-ae49-a833-50462c508678",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"5a99e178-c1d8-be9b-bd28-db2305bcaa2e",
									true,
								},
								
								{
									"71d1af24-0e7c-1104-9548-aac1002348cd",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Hotbar_ShirkOT",
							uuid = "8fd7f15b-cd53-05a4-8f30-1fb825db7f95",
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
							comparator = 2,
							conditionType = 4,
							enmityValue = 99.999000549316,
							uuid = "5a99e178-c1d8-be9b-bd28-db2305bcaa2e",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isot",
							uuid = "71d1af24-0e7c-1104-9548-aac1002348cd",
							version = 2,
						},
						inheritedIndex = 3,
					},
				},
				mechanicTime = 1150.3,
				name = "  退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 251,
				timerEndOffset = 3,
				timerStartOffset = -5,
				uuid = "d490c3d5-5e75-496e-8684-36437166e7bc",
				version = 2,
			},
			inheritedIndex = 14,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"60f82eab-d231-ccb5-ae30-728b5bfb2f64",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							uuid = "5fcea86b-e3a3-02e0-b002-c36ff52d5a87",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "60f82eab-d231-ccb5-ae30-728b5bfb2f64",
							version = 2,
						},
					},
				},
				mechanicTime = 1187.6,
				name = "【DRK】铁壁",
				timeRange = true,
				timelineIndex = 262,
				timerEndOffset = 5,
				timerStartOffset = -2.5,
				uuid = "3b2e7d25-3879-fe06-a44c-84e6094da8d5",
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
									"4654df9b-ce44-60cb-bd46-54492328a1e9",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_ShadowedVigil",
							uuid = "01a644ff-a749-e4ec-a6f4-e57ab482dc1c",
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
							actionID = 3636,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "4654df9b-ce44-60cb-bd46-54492328a1e9",
							version = 2,
						},
					},
				},
				mechanicTime = 1187.6,
				name = "【DRK】暗影墙",
				timeRange = true,
				timelineIndex = 262,
				timerEndOffset = 5,
				timerStartOffset = 2.5,
				uuid = "b7f431cf-abe5-6d31-b7cf-ddbe9aa413cc",
				version = 2,
			},
			inheritedIndex = 3,
		},
	},
	inheritedProfiles = 
	{
	},
	mapID = 1238,
	version = 5,
}



return tbl