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
									"cef3c9f4-b0d6-f0db-b123-309743374dcd",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_IronWill",
							uuid = "a80b4642-d4bd-2894-97fd-e4c9e3038355",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "cef3c9f4-b0d6-f0db-b123-309743374dcd",
							version = 2,
						},
					},
				},
				mechanicTime = 16.4,
				name = "【PLD】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 3,
				timerEndOffset = 5,
				uuid = "e1db3e5e-5384-92c5-b285-8d9f0a56f7e2",
				version = 2,
			},
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
				name = "----骑士----",
				timelineIndex = 7,
				uuid = "9b20b251-d07b-5103-a96e-e4b015398f8d",
				version = 2,
			},
			inheritedIndex = 16,
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
				uuid = "2ae42cf0-46ab-91a5-bfb3-60c94f66d41e",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"525e6d31-a801-9bd1-9e38-c9feec1d434b",
									true,
								},
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"21c9b821-6a7d-8cc9-8bd2-5f0051c7cc2c",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							uuid = "525e6d31-a801-9bd1-9e38-c9feec1d434b",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 1",
							name = "p1-1全减",
							uuid = "21c9b821-6a7d-8cc9-8bd2-5f0051c7cc2c",
							version = 2,
						},
					},
				},
				mechanicTime = 24.2,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 7,
				timerStartOffset = -9,
				uuid = "457fe1e0-3df4-d1c4-b487-2ca3c0895279",
				version = 2,
			},
			inheritedIndex = 18,
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
									"9b7d78f8-0c1b-57d6-9bd5-ea8b7beebdaf",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 1",
							name = "p1-1全减",
							uuid = "9b7d78f8-0c1b-57d6-9bd5-ea8b7beebdaf",
							version = 2,
						},
					},
				},
				mechanicTime = 24.2,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 7,
				timerOffset = -7,
				timerStartOffset = -4,
				uuid = "e8eb2a4f-051d-073e-b025-e42772350ec2",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"525e6d31-a801-9bd1-9e38-c9feec1d434b",
									true,
								},
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"fa99064b-d690-7ad9-beab-3d7cc885ce44",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							uuid = "525e6d31-a801-9bd1-9e38-c9feec1d434b",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 1",
							name = "p1-1全减",
							uuid = "fa99064b-d690-7ad9-beab-3d7cc885ce44",
							version = 2,
						},
					},
				},
				mechanicTime = 24.2,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 7,
				timerStartOffset = -14,
				uuid = "68ffeeb9-1d61-cbf5-9f5c-953c856c642b",
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
				mechanicTime = 24.2,
				name = "---------------",
				timelineIndex = 7,
				uuid = "24ae9d54-a622-f758-9b19-f6eeed395bd3",
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
				mechanicTime = 24.2,
				name = "--自己无敌吃--",
				timelineIndex = 7,
				uuid = "356d1823-541b-5b71-bd68-38a42a3f39b2",
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
							actionID = 30,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
									true,
								},
								
								{
									"d35dec42-8547-845e-a501-8f8b0a311a8b",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_HallowedGround",
							ignoreWeaveRules = true,
							uuid = "79eb3402-396f-be4b-93c9-e249e8996732",
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
							actionID = 30,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 2",
							name = "p1-1无敌",
							uuid = "d35dec42-8547-845e-a501-8f8b0a311a8b",
							version = 2,
						},
					},
				},
				mechanicTime = 24.2,
				name = "【PLD】神圣领域",
				timeRange = true,
				timelineIndex = 7,
				timerStartOffset = -2,
				uuid = "70d05f31-c79e-a2f7-a507-a3a49beec35c",
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
				mechanicTime = 24.2,
				name = "---------------",
				timelineIndex = 7,
				uuid = "fda3708f-ae33-9ee9-9f88-54a65a124262",
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
				mechanicTime = 24.2,
				name = "--搭档减伤吃--",
				timelineIndex = 7,
				uuid = "f3101182-528f-4ed0-80dd-e954d4b83a68",
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
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
									true,
								},
								
								{
									"c84b26f1-9cfb-170d-be49-ea28be7a2d5f",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_InterventionOT",
							ignoreWeaveRules = true,
							targetType = "Other Tank",
							uuid = "4e3b0fe5-f53a-8d0b-83de-322f63e3677a",
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
							actionID = 7393,
							category = "Self",
							conditionType = 6,
							gaugeValue = 50,
							uuid = "d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 3",
							name = "搭档减伤吃",
							uuid = "c84b26f1-9cfb-170d-be49-ea28be7a2d5f",
							version = 2,
						},
					},
				},
				mechanicTime = 24.2,
				name = "【PLD】干预",
				timeRange = true,
				timelineIndex = 7,
				timerStartOffset = -4,
				uuid = "30d3630d-0828-b037-ab2f-f5cfb9c78ebe",
				version = 2,
			},
			inheritedIndex = 26,
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
				uuid = "b7729405-fe38-5dd2-a79a-82100e98fbba",
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
									"cc3e4c40-1fd6-8e12-b923-7150d7a7aaed",
									true,
								},
								
								{
									"9939ca7f-2fe1-8f93-9c4f-34ea3b6577fd",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "7a1c0199-a47e-af27-ae16-4803b6e722e9",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "cc3e4c40-1fd6-8e12-b923-7150d7a7aaed",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 3 or MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 4",
							name = "p1不吃",
							uuid = "9939ca7f-2fe1-8f93-9c4f-34ea3b6577fd",
							version = 2,
						},
					},
				},
				mechanicTime = 24.2,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 7,
				timerEndOffset = 5,
				timerStartOffset = -4,
				uuid = "e24b7563-3312-690a-ab7d-ac7f75d74923",
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
									"b05e6bbc-8e56-9c83-aac4-7f25591532a3",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_ShirkOT",
							uuid = "5e9bd4b4-86b0-2c2e-8bbb-8eff300a8b7e",
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
							uuid = "b05e6bbc-8e56-9c83-aac4-7f25591532a3",
							version = 2,
						},
					},
				},
				mechanicTime = 24.2,
				name = " 退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 7,
				timerEndOffset = 5,
				timerStartOffset = -2,
				uuid = "ced38a9a-45e8-dfd1-80b3-8dbb86ea5e03",
				version = 2,
			},
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
				},
				mechanicTime = 40.3,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 11,
				timerStartOffset = -19.5,
				uuid = "2906b1df-8c99-7299-8334-bed7c136c7d9",
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
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 40.3,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 11,
				timerOffset = -7,
				timerStartOffset = -4,
				uuid = "16bd6780-e757-ad3a-bcf8-2d4a8a871a42",
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
									"04a31d37-562b-edb5-8739-ed1f78120b37",
									true,
								},
								
								{
									"48dacd52-d593-6522-9ddc-1c307a053a40",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_ReleaseIronWill",
							uuid = "c2516961-9227-22b9-9fb8-c1e7e2881f41",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "04a31d37-562b-edb5-8739-ed1f78120b37",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 3 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 4",
							name = "p1-2不吃",
							uuid = "48dacd52-d593-6522-9ddc-1c307a053a40",
							version = 2,
						},
					},
				},
				mechanicTime = 40.3,
				name = "【PLD】关闭盾姿",
				timeRange = true,
				timelineIndex = 11,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "7f418ae3-ad6a-efe8-84d6-5a8f0ba51b28",
				version = 2,
			},
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
									"c8ea8aef-c2a7-b604-9137-c3b050d20198",
									true,
								},
								
								{
									"7e38e12d-5c5b-51bf-83a6-a1ffc1095452",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "35de6ea7-43c7-9690-8ab6-d7f96bd461e6",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "c8ea8aef-c2a7-b604-9137-c3b050d20198",
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
							uuid = "7e38e12d-5c5b-51bf-83a6-a1ffc1095452",
							version = 2,
						},
					},
				},
				mechanicTime = 80,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 21,
				timerEndOffset = 6,
				timerStartOffset = 2,
				uuid = "bbc997c6-7025-f361-a76e-13f1cfd9bb88",
				version = 2,
			},
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
									"cef3c9f4-b0d6-f0db-b123-309743374dcd",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_IronWill",
							uuid = "a80b4642-d4bd-2894-97fd-e4c9e3038355",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "cef3c9f4-b0d6-f0db-b123-309743374dcd",
							version = 2,
						},
					},
				},
				mechanicTime = 113.7,
				name = "【PLD】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 28,
				timerEndOffset = 5,
				uuid = "75d238c2-7144-9df5-94d8-b9c677fcff0f",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"c8ea8aef-c2a7-b604-9137-c3b050d20198",
									true,
								},
								
								{
									"7e38e12d-5c5b-51bf-83a6-a1ffc1095452",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "35de6ea7-43c7-9690-8ab6-d7f96bd461e6",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "c8ea8aef-c2a7-b604-9137-c3b050d20198",
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
							uuid = "7e38e12d-5c5b-51bf-83a6-a1ffc1095452",
							version = 2,
						},
					},
				},
				mechanicTime = 121.1,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 29,
				timerEndOffset = 6,
				timerStartOffset = 2,
				uuid = "7aea7d7d-0690-64a5-bc59-4136bc781287",
				version = 2,
			},
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
				uuid = "03b0883f-74fc-be9d-b37d-2f6db7d72e35",
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
				mechanicTime = 129.5,
				name = "--自己全减吃--",
				timelineIndex = 30,
				uuid = "e5f4f6bb-6ffa-14d8-8f36-b9682405a20a",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"525e6d31-a801-9bd1-9e38-c9feec1d434b",
									true,
								},
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"13a1ac5f-4e21-7147-82ce-086f22a042f1",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							uuid = "525e6d31-a801-9bd1-9e38-c9feec1d434b",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1",
							name = "p1-2全减",
							uuid = "13a1ac5f-4e21-7147-82ce-086f22a042f1",
							version = 2,
						},
					},
				},
				mechanicTime = 129.5,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 30,
				timerStartOffset = -9,
				uuid = "886cfae4-02a0-f918-868a-c13ce0ed807c",
				version = 2,
			},
			inheritedIndex = 18,
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
									"27c5dca3-9341-e4ed-a3ea-b70b588ae125",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1",
							name = "p1-2全减",
							uuid = "27c5dca3-9341-e4ed-a3ea-b70b588ae125",
							version = 2,
						},
					},
				},
				mechanicTime = 129.5,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 30,
				timerOffset = -7,
				timerStartOffset = -4,
				uuid = "ab00c6fc-a2d8-8517-b5e2-f91c3c346269",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"525e6d31-a801-9bd1-9e38-c9feec1d434b",
									true,
								},
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"50e17d34-20b1-eac3-bcdb-4140305d38bb",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							uuid = "525e6d31-a801-9bd1-9e38-c9feec1d434b",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1",
							name = "p1-2全减",
							uuid = "50e17d34-20b1-eac3-bcdb-4140305d38bb",
							version = 2,
						},
					},
				},
				mechanicTime = 129.5,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 30,
				timerStartOffset = -14,
				uuid = "e15a7b59-dff2-7608-9dd1-1bf88f5ebf4b",
				version = 2,
			},
			inheritedIndex = 20,
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
				uuid = "21188487-f41b-4f9e-b9a9-25b35356bc42",
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
				mechanicTime = 129.5,
				name = "--自己无敌吃--",
				timelineIndex = 30,
				uuid = "14a3554a-918a-317b-82c7-0ba9b0e4b346",
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
									"5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
									true,
								},
								
								{
									"c9eee6eb-6afd-83bd-898b-e23196d3352e",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_HallowedGround",
							uuid = "79eb3402-396f-be4b-93c9-e249e8996732",
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
							actionID = 30,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 2",
							name = "p1-2无敌",
							uuid = "c9eee6eb-6afd-83bd-898b-e23196d3352e",
							version = 2,
						},
					},
				},
				mechanicTime = 129.5,
				name = "【PLD】神圣领域",
				timeRange = true,
				timelineIndex = 30,
				timerStartOffset = -5,
				uuid = "3206a229-f372-62ab-a267-a6852453d8c4",
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
				mechanicTime = 129.5,
				name = "---------------",
				timelineIndex = 30,
				uuid = "07f43276-a75f-f05c-8e82-79c47691259e",
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
				mechanicTime = 129.5,
				name = "--搭档减伤吃--",
				timelineIndex = 30,
				uuid = "d64415d3-212a-759d-a4ba-ab359258999d",
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
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
									true,
								},
								
								{
									"fb3e294c-4a02-311a-8567-3bcba4a8a04d",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_InterventionOT",
							ignoreWeaveRules = true,
							targetType = "Other Tank",
							uuid = "4e3b0fe5-f53a-8d0b-83de-322f63e3677a",
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
							actionID = 7393,
							category = "Self",
							conditionType = 6,
							gaugeValue = 50,
							uuid = "d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 3",
							name = "搭档减伤吃",
							uuid = "fb3e294c-4a02-311a-8567-3bcba4a8a04d",
							version = 2,
						},
					},
				},
				mechanicTime = 129.5,
				name = "【PLD】干预",
				timeRange = true,
				timelineIndex = 30,
				timerStartOffset = -4,
				uuid = "ca34370d-407d-1c16-822b-682820e3b0e8",
				version = 2,
			},
			inheritedIndex = 26,
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
				uuid = "6bd49879-aa86-5920-bdbb-2d205d5e0e7e",
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
									"cc3e4c40-1fd6-8e12-b923-7150d7a7aaed",
									true,
								},
								
								{
									"5324311c-ff07-bdd7-aa4c-30024fa1a3c2",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "7a1c0199-a47e-af27-ae16-4803b6e722e9",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "cc3e4c40-1fd6-8e12-b923-7150d7a7aaed",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 3 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 4",
							name = "p1-2不吃",
							uuid = "5324311c-ff07-bdd7-aa4c-30024fa1a3c2",
							version = 2,
						},
					},
				},
				mechanicTime = 129.5,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 30,
				timerEndOffset = 5,
				timerStartOffset = -4,
				uuid = "589f2625-6d89-17f3-8172-fb270c9bb518",
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
									"c3045686-f478-85a7-ba8f-067d89b1a39d",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_ShirkOT",
							uuid = "5e9bd4b4-86b0-2c2e-8bbb-8eff300a8b7e",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 2",
							name = "p1-2全减/无敌",
							uuid = "c3045686-f478-85a7-ba8f-067d89b1a39d",
							version = 2,
						},
					},
				},
				mechanicTime = 129.5,
				name = " 退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 30,
				timerEndOffset = 5,
				timerStartOffset = -2,
				uuid = "944c0cee-a365-9939-9aa8-e0bb69de666d",
				version = 2,
			},
		},
	},
	[35] = 
	{
		
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
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
				},
				mechanicTime = 145.6,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 35,
				timerStartOffset = -19.5,
				uuid = "32a52649-75d3-8764-8cd9-000ff9add95c",
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
				mechanicTime = 145.6,
				name = "---------------",
				timelineIndex = 35,
				uuid = "8c0a2d9e-f19a-d75e-a01c-ad811fb068b9",
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
				mechanicTime = 145.6,
				name = "--自己无敌吃--",
				timelineIndex = 35,
				uuid = "d3aadc3a-c795-313a-ba5f-65f5aaad7536",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"b184dc51-56e3-ffad-9ac3-f7010aba0728",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 2 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 3 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 4",
							name = "p1-2非全减",
							uuid = "b184dc51-56e3-ffad-9ac3-f7010aba0728",
							version = 2,
						},
					},
				},
				mechanicTime = 145.6,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 35,
				timerStartOffset = -9,
				uuid = "63c80325-b05a-4b45-880a-c73ef0db46e5",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"890030eb-4bbb-2522-8502-aa4894014d59",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 2 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 3 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 4",
							name = "p1-2非全减",
							uuid = "890030eb-4bbb-2522-8502-aa4894014d59",
							version = 2,
						},
					},
				},
				mechanicTime = 145.6,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 35,
				timerStartOffset = -14,
				uuid = "ddedba0d-d732-d6ef-8a62-b5404bc19a14",
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
				mechanicTime = 145.6,
				name = "--自己全减吃--",
				timelineIndex = 35,
				uuid = "5c2b5fd6-a876-a4e1-aab8-ba2363fc5019",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"a5b5865c-7221-5595-a5fb-559f9c92f57d",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 1",
							name = "p1-2全减",
							uuid = "a5b5865c-7221-5595-a5fb-559f9c92f57d",
							version = 2,
						},
					},
				},
				mechanicTime = 145.6,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 35,
				timerOffset = -7,
				timerStartOffset = -4,
				uuid = "54236e20-15ed-dfeb-9d38-112862618c06",
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
				mechanicTime = 145.6,
				name = "---------------",
				timelineIndex = 35,
				uuid = "04991e85-8523-e58d-b436-b52e5238493b",
				version = 2,
			},
			inheritedIndex = 18,
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
									"d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
									true,
								},
								
								{
									"e2edf900-16d3-066b-a9f0-d474e40d32b2",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_InterventionOT",
							ignoreWeaveRules = true,
							targetType = "Other Tank",
							uuid = "4e3b0fe5-f53a-8d0b-83de-322f63e3677a",
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
							actionID = 7393,
							category = "Self",
							conditionType = 6,
							gaugeValue = 50,
							uuid = "d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 2 or MuAiGuide.Config.FruMitigation.Tank.P1_Death2 == 3",
							name = "p1-2无敌/不吃",
							uuid = "e2edf900-16d3-066b-a9f0-d474e40d32b2",
							version = 2,
						},
					},
				},
				mechanicTime = 145.6,
				name = "【PLD】干预",
				timeRange = true,
				timelineIndex = 35,
				timerStartOffset = -4,
				uuid = "11d89a3e-8e99-7699-91dc-18baf0a19231",
				version = 2,
			},
			inheritedIndex = 26,
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
									"c8ea8aef-c2a7-b604-9137-c3b050d20198",
									true,
								},
								
								{
									"ee319ad2-9315-95c5-9010-9116e32a99c6",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "35de6ea7-43c7-9690-8ab6-d7f96bd461e6",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "c8ea8aef-c2a7-b604-9137-c3b050d20198",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P2_Open == 1\n",
							name = "p2无敌",
							uuid = "ee319ad2-9315-95c5-9010-9116e32a99c6",
							version = 2,
						},
					},
				},
				mechanicTime = 203.8,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 39,
				timerEndOffset = 6,
				timerStartOffset = 2,
				uuid = "414088d4-bffb-8ab4-88ba-9403155eaa7d",
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
									"04a31d37-562b-edb5-8739-ed1f78120b37",
									true,
								},
								
								{
									"0d569cbb-ccfa-6978-9dae-f8dbd8f5ce5f",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_ReleaseIronWill",
							uuid = "c2516961-9227-22b9-9fb8-c1e7e2881f41",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "04a31d37-562b-edb5-8739-ed1f78120b37",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P2_Open == 2\n",
							name = "p2不吃",
							uuid = "0d569cbb-ccfa-6978-9dae-f8dbd8f5ce5f",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 203.8,
				name = "【PLD】关闭盾姿",
				timeRange = true,
				timelineIndex = 39,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "29f80043-26ae-1f75-8f7d-c4570c1518fa",
				version = 2,
			},
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
				uuid = "29050719-e4d4-e37e-8131-708429612a4d",
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
				mechanicTime = 214.9,
				name = "--自己无敌吃--",
				timelineIndex = 40,
				uuid = "4ecefc16-c9b9-1472-96ec-6f538478e88d",
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
							actionID = 30,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
									true,
								},
								
								{
									"d35dec42-8547-845e-a501-8f8b0a311a8b",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_HallowedGround",
							ignoreWeaveRules = true,
							uuid = "79eb3402-396f-be4b-93c9-e249e8996732",
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
							actionID = 30,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P1_Death1 == 2",
							name = "p1-1无敌",
							uuid = "d35dec42-8547-845e-a501-8f8b0a311a8b",
							version = 2,
						},
					},
				},
				mechanicTime = 214.9,
				name = "【PLD】神圣领域",
				timeRange = true,
				timelineIndex = 40,
				timerStartOffset = -2,
				uuid = "b6cb3578-b024-ca1f-87fc-e746cfee40f4",
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
				mechanicTime = 214.9,
				name = "---------------",
				timelineIndex = 40,
				uuid = "2c35d361-5627-5282-a1e3-2eb4ae3f170a",
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
				mechanicTime = 214.9,
				name = "--搭档无敌吃--",
				timelineIndex = 40,
				uuid = "58d3c16b-4d0f-3731-a555-b831a058c49f",
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
									"cef3c9f4-b0d6-f0db-b123-309743374dcd",
									true,
								},
								
								{
									"41aaf45d-dda8-92e7-9f02-abd9392f53a3",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_IronWill",
							uuid = "a80b4642-d4bd-2894-97fd-e4c9e3038355",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "cef3c9f4-b0d6-f0db-b123-309743374dcd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P2_Open == 2\n",
							name = "p2",
							uuid = "41aaf45d-dda8-92e7-9f02-abd9392f53a3",
							version = 2,
						},
					},
				},
				mechanicTime = 214.9,
				name = "【PLD】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 40,
				timerStartOffset = -5,
				uuid = "8401db39-e38a-97c7-a895-f1d29278c9ad",
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
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 219,
				name = "---------------",
				timelineIndex = 41,
				uuid = "4eeebf47-b507-d2b3-9172-8f4c474b3afb",
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
				mechanicTime = 219,
				name = "--搭档无敌吃--",
				timelineIndex = 41,
				uuid = "d889f32f-3e0b-83d3-a71b-f795b31d3696",
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
									"c8ea8aef-c2a7-b604-9137-c3b050d20198",
									true,
								},
								
								{
									"481d8dee-5425-6f1c-8394-c0cd4cd36594",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "35de6ea7-43c7-9690-8ab6-d7f96bd461e6",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "c8ea8aef-c2a7-b604-9137-c3b050d20198",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P2_Open == 2",
							name = "p2-3",
							uuid = "481d8dee-5425-6f1c-8394-c0cd4cd36594",
							version = 2,
						},
					},
				},
				mechanicTime = 219,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 41,
				timerEndOffset = 6,
				uuid = "0333adbf-ab42-dc2d-87c2-e4a46cc9ee08",
				version = 2,
			},
			inheritedIndex = 6,
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
									"04a31d37-562b-edb5-8739-ed1f78120b37",
									true,
								},
								
								{
									"fbc10741-2813-11a1-a730-62e093e65a9f",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_ReleaseIronWill",
							uuid = "c2516961-9227-22b9-9fb8-c1e7e2881f41",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "04a31d37-562b-edb5-8739-ed1f78120b37",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isOT",
							uuid = "fbc10741-2813-11a1-a730-62e093e65a9f",
							version = 2,
						},
					},
				},
				mechanicTime = 247.1,
				name = "【PLD】关闭盾姿",
				timeRange = true,
				timelineIndex = 49,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "e8d8e60e-78f2-873f-bbcb-758a1c375230",
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
									"cef3c9f4-b0d6-f0db-b123-309743374dcd",
									true,
								},
								
								{
									"2762e96a-d882-735e-8179-3550993a27a1",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_IronWill",
							uuid = "a80b4642-d4bd-2894-97fd-e4c9e3038355",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "cef3c9f4-b0d6-f0db-b123-309743374dcd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"mt\"",
							name = "isMT",
							uuid = "2762e96a-d882-735e-8179-3550993a27a1",
							version = 2,
						},
					},
				},
				mechanicTime = 247.1,
				name = "【PLD】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 49,
				timerEndOffset = 5,
				uuid = "9664d622-0b9b-3572-9679-6d3935088a18",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"525e6d31-a801-9bd1-9e38-c9feec1d434b",
									true,
								},
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							uuid = "525e6d31-a801-9bd1-9e38-c9feec1d434b",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
				},
				mechanicTime = 283.4,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 65,
				timerEndOffset = 5,
				timerStartOffset = -2,
				uuid = "928678a0-2aa3-b3ac-a2fe-2ff5dc540789",
				version = 2,
			},
			inheritedIndex = 18,
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
								
								{
									"b3f2bdb6-8ab3-5c1b-a752-f89546f0a1ab",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							conditionType = 4,
							enmityValue = 100,
							uuid = "b3f2bdb6-8ab3-5c1b-a752-f89546f0a1ab",
							version = 2,
						},
					},
				},
				mechanicTime = 292.6,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 5,
				timerStartOffset = 1,
				uuid = "9fbf14e6-59cc-6e05-b01f-fa96ff953052",
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
							gVar = "ACR_RikuPLD3_Gauge",
							uuid = "c2d7ec11-858b-b2d9-892c-70981602d1db",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 292.6,
				name = "开职业量谱",
				timelineIndex = 68,
				uuid = "2ef01331-2c03-9dd6-b5be-6daf8ea27bef",
				version = 2,
			},
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"525e6d31-a801-9bd1-9e38-c9feec1d434b",
									true,
								},
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							uuid = "525e6d31-a801-9bd1-9e38-c9feec1d434b",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
				},
				mechanicTime = 306.6,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 71,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "3d98b5f8-a10f-b3fd-bf4b-a8e448da4f6d",
				version = 2,
			},
			inheritedIndex = 20,
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
							aType = "ACR",
							gVar = "ACR_RikuPLD3_Gauge",
							gVarValue = 2,
							uuid = "6be0b4b0-2c3c-4e5e-a0f2-4f29d2165a85",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 331.8,
				name = "关职业量谱",
				timelineIndex = 80,
				uuid = "62c86ed9-825b-be0b-938e-eb004897b113",
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
				uuid = "48f27a87-e063-c1e0-a079-9b9d2282a737",
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
				mechanicTime = 500,
				name = "--P3一死刑不吃--",
				timelineIndex = 119,
				uuid = "57b2596b-267b-65fc-80ec-28f9698b8d77",
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
									"04a31d37-562b-edb5-8739-ed1f78120b37",
									true,
								},
								
								{
									"22f37adc-5d09-4f3e-94bb-9b3e7f24841f",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_ReleaseIronWill",
							uuid = "c2516961-9227-22b9-9fb8-c1e7e2881f41",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "04a31d37-562b-edb5-8739-ed1f78120b37",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 3 or MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 4",
							name = "p3-不吃",
							uuid = "22f37adc-5d09-4f3e-94bb-9b3e7f24841f",
							version = 2,
						},
					},
				},
				mechanicTime = 500,
				name = "【PLD】关闭盾姿",
				timeRange = true,
				timelineIndex = 119,
				timerEndOffset = 5,
				timerStartOffset = -5,
				uuid = "3bd13323-bad3-b9af-a484-7d94dd8c7416",
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
				mechanicTime = 500,
				name = "---------------",
				timelineIndex = 119,
				uuid = "c8b31131-a1a9-e1f5-a70c-abec4cd7d0c1",
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
				mechanicTime = 500,
				name = "--P3一死刑自己吃--",
				timelineIndex = 119,
				uuid = "b7989682-e16f-7ea7-9df3-b1a81b2f8977",
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
									"cef3c9f4-b0d6-f0db-b123-309743374dcd",
									true,
								},
								
								{
									"4097405e-4e1b-64cc-9f4a-b70293d21383",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_IronWill",
							uuid = "a80b4642-d4bd-2894-97fd-e4c9e3038355",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "cef3c9f4-b0d6-f0db-b123-309743374dcd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 1 or MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 2",
							name = "p3-1/2",
							uuid = "4097405e-4e1b-64cc-9f4a-b70293d21383",
							version = 2,
						},
					},
				},
				mechanicTime = 500,
				name = "【PLD】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 119,
				timerEndOffset = 5,
				uuid = "a75f14a4-35be-2aca-afc8-f1d50add6d0b",
				version = 2,
			},
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
									"cef3c9f4-b0d6-f0db-b123-309743374dcd",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_IronWill",
							uuid = "a80b4642-d4bd-2894-97fd-e4c9e3038355",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "cef3c9f4-b0d6-f0db-b123-309743374dcd",
							version = 2,
						},
					},
				},
				mechanicTime = 554,
				name = "【PLD】开启盾姿 ",
				randomOffset = 5,
				timeRange = true,
				timelineIndex = 130,
				timerEndOffset = 5,
				uuid = "bbeaebd5-c99e-6914-8184-68ae2e013a87",
				version = 2,
			},
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
				uuid = "77b1d861-3450-281d-9fa4-4a192d97d32c",
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
				name = "--自己全减吃--",
				timelineIndex = 140,
				uuid = "4f31fcfb-816c-76fa-8aa8-faba30664afb",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"525e6d31-a801-9bd1-9e38-c9feec1d434b",
									true,
								},
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"6da6e786-a99a-9912-87a4-f7cbc626b877",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							uuid = "525e6d31-a801-9bd1-9e38-c9feec1d434b",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 1",
							name = "p3-1",
							uuid = "6da6e786-a99a-9912-87a4-f7cbc626b877",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 595.4,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 140,
				timerStartOffset = -9,
				uuid = "529944e5-d857-fd61-8dfe-db210188700f",
				version = 2,
			},
			inheritedIndex = 18,
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
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
								
								{
									"82f99353-c4e6-563d-b8c3-b194ac5cc877",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 1",
							name = "p3-1",
							uuid = "82f99353-c4e6-563d-b8c3-b194ac5cc877",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 595.4,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 140,
				timerStartOffset = -19.5,
				uuid = "a27d71b1-23c2-a6c6-ac2f-f9985f8e7a63",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"6cc2b141-6d84-25dc-b3ac-27394d5f1eb6",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 1",
							name = "p3-1",
							uuid = "6cc2b141-6d84-25dc-b3ac-27394d5f1eb6",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 595.4,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 140,
				timerOffset = -7,
				timerStartOffset = -4,
				uuid = "1ba9cc3a-32db-700a-b877-e956d04182b0",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"525e6d31-a801-9bd1-9e38-c9feec1d434b",
									true,
								},
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"148cc582-9013-c592-a2f2-60408466414d",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							uuid = "525e6d31-a801-9bd1-9e38-c9feec1d434b",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 1",
							name = "p3-1",
							uuid = "148cc582-9013-c592-a2f2-60408466414d",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 595.4,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 140,
				timerStartOffset = -14,
				uuid = "fac82f2e-1af5-7aaa-9401-d225d399e95b",
				version = 2,
			},
			inheritedIndex = 21,
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
				uuid = "506efa63-5d8f-f46e-976b-7bed9f413609",
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
				name = "--自己无敌吃--",
				timelineIndex = 140,
				uuid = "e90e83df-8b2e-f07d-9e78-ed52f4f28a50",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
									true,
								},
								
								{
									"731f54c8-1ca0-3827-b48d-79a79128751d",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_HallowedGround",
							uuid = "79eb3402-396f-be4b-93c9-e249e8996732",
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
							actionID = 30,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 2",
							name = "p3-1",
							uuid = "731f54c8-1ca0-3827-b48d-79a79128751d",
							version = 2,
						},
					},
				},
				mechanicTime = 595.4,
				name = "【PLD】神圣领域",
				timeRange = true,
				timelineIndex = 140,
				timerStartOffset = -5,
				uuid = "e826dcc0-7c98-6c13-98d0-0916c4e33a3c",
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
				name = "---------------",
				timelineIndex = 140,
				uuid = "a6b25efa-3908-eee0-9929-d1585edd1f06",
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
				uuid = "fac85e97-4693-c6bf-bd0d-88964f300606",
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
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
									true,
								},
								
								{
									"626c9c08-8b17-2681-b88a-847502e38690",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_InterventionOT",
							ignoreWeaveRules = true,
							targetType = "Other Tank",
							uuid = "4e3b0fe5-f53a-8d0b-83de-322f63e3677a",
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
							actionID = 7393,
							category = "Self",
							conditionType = 6,
							gaugeValue = 50,
							uuid = "d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_BlackRing == 3",
							name = "p3-1",
							uuid = "626c9c08-8b17-2681-b88a-847502e38690",
							version = 2,
						},
					},
				},
				mechanicTime = 595.4,
				name = "【PLD】干预",
				timeRange = true,
				timelineIndex = 140,
				timerStartOffset = -4,
				uuid = "6d7ac166-0289-3369-a0d0-532c6d12a2b8",
				version = 2,
			},
			inheritedIndex = 27,
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
				uuid = "33517387-589f-cedb-8c64-443ba34d357e",
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
									"cc3e4c40-1fd6-8e12-b923-7150d7a7aaed",
									true,
								},
								
								{
									"cc5bb5e2-4dc1-5366-84e3-184db00de48b",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "7a1c0199-a47e-af27-ae16-4803b6e722e9",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "cc3e4c40-1fd6-8e12-b923-7150d7a7aaed",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 1 or MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 2",
							name = "自己吃二运超级跳",
							uuid = "cc5bb5e2-4dc1-5366-84e3-184db00de48b",
							version = 2,
						},
					},
				},
				mechanicTime = 595.4,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 140,
				timerEndOffset = 5,
				timerStartOffset = -4,
				uuid = "121edd77-b447-db2b-b110-a6943a35f095",
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
				uuid = "81e04e68-4262-76e7-b19d-5991df65c952",
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
				mechanicTime = 644.3,
				name = "--自己全减吃--",
				timelineIndex = 150,
				uuid = "43d07016-69b8-2237-b056-4c7591ab6da0",
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
								
								{
									"d569fab0-b25e-a042-b262-cad97674a11f",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 1",
							name = "p3",
							uuid = "d569fab0-b25e-a042-b262-cad97674a11f",
							version = 2,
						},
					},
				},
				mechanicTime = 644.3,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 150,
				timerStartOffset = -19.5,
				uuid = "65ebc6ad-6c55-5f02-9dd0-26165eebbc9e",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"29340ad5-404d-da02-8fe7-49e1e21f01d1",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 1",
							name = "p3",
							uuid = "29340ad5-404d-da02-8fe7-49e1e21f01d1",
							version = 2,
						},
					},
				},
				mechanicTime = 644.3,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 150,
				timerStartOffset = -9,
				uuid = "03732bdd-98e5-c840-9183-18bd877f745f",
				version = 2,
			},
			inheritedIndex = 18,
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
									"0f80351e-ef12-4740-8e03-c7db342f75dd",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 1",
							name = "p3",
							uuid = "0f80351e-ef12-4740-8e03-c7db342f75dd",
							version = 2,
						},
					},
				},
				mechanicTime = 644.3,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 150,
				timerOffset = -7,
				timerStartOffset = -4,
				uuid = "b550ec6b-713b-3f55-92c2-049b8b168f5a",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"af4be6b3-661f-a98b-a666-5de145077b88",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 1",
							name = "p3",
							uuid = "af4be6b3-661f-a98b-a666-5de145077b88",
							version = 2,
						},
					},
				},
				mechanicTime = 644.3,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 150,
				timerStartOffset = -14,
				uuid = "debca805-e9c4-477e-8748-724b784fe86a",
				version = 2,
			},
			inheritedIndex = 20,
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
				uuid = "f9d190d6-12fa-a2ee-afcd-c6b6b2a04fcf",
				version = 2,
			},
			inheritedIndex = 21,
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
				uuid = "a1b9a74d-4b8c-8e7c-89e6-5e52ea1af33e",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
									true,
								},
								
								{
									"e169ac0c-1e96-fb3e-b1aa-bbe6dee2fc00",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_HallowedGround",
							uuid = "79eb3402-396f-be4b-93c9-e249e8996732",
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
							actionID = 30,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 2",
							name = "p3",
							uuid = "e169ac0c-1e96-fb3e-b1aa-bbe6dee2fc00",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 644.3,
				name = "【PLD】神圣领域",
				timeRange = true,
				timelineIndex = 150,
				timerStartOffset = -5,
				uuid = "ff39d187-f3cb-6fbc-9e06-b2b2cc381f07",
				version = 2,
			},
			inheritedIndex = 23,
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
				uuid = "97555c7d-da52-6e08-bac6-f9e7ce084c55",
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
				mechanicTime = 644.3,
				name = "--搭档减伤吃--",
				timelineIndex = 150,
				uuid = "61f5fd52-b070-f11f-8e80-67174b5845cf",
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
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
									true,
								},
								
								{
									"05e7f78c-abda-cc3d-ad1d-0abd10162cbb",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_InterventionOT",
							ignoreWeaveRules = true,
							targetType = "Other Tank",
							uuid = "4e3b0fe5-f53a-8d0b-83de-322f63e3677a",
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
							actionID = 7393,
							category = "Self",
							conditionType = 6,
							gaugeValue = 50,
							uuid = "d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P3_DarkestDance == 3",
							name = "p3",
							uuid = "05e7f78c-abda-cc3d-ad1d-0abd10162cbb",
							version = 2,
						},
					},
				},
				mechanicTime = 644.3,
				name = "【PLD】干预",
				timeRange = true,
				timelineIndex = 150,
				timerStartOffset = -4,
				uuid = "093d4661-1850-a850-a488-4bd24eaabfa3",
				version = 2,
			},
			inheritedIndex = 26,
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
				uuid = "b9ecff0e-ca7c-8253-a385-c801bc453352",
				version = 2,
			},
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
									"c8ea8aef-c2a7-b604-9137-c3b050d20198",
									true,
								},
								
								{
									"27b05503-5beb-5898-bf22-873f010cb6aa",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "35de6ea7-43c7-9690-8ab6-d7f96bd461e6",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "c8ea8aef-c2a7-b604-9137-c3b050d20198",
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
							uuid = "27b05503-5beb-5898-bf22-873f010cb6aa",
							version = 2,
						},
					},
				},
				mechanicTime = 705.3,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 156,
				timerEndOffset = 5,
				uuid = "be41d0f4-8840-9d64-82cd-8a06056f73b9",
				version = 2,
			},
			inheritedIndex = 1,
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
									"c8ea8aef-c2a7-b604-9137-c3b050d20198",
									true,
								},
								
								{
									"4d3a5c91-f542-1289-b1ec-c4bb2ed8c254",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 9832,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "2aa44800-4ef2-7792-ab90-5629f5d46d8d",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "c8ea8aef-c2a7-b604-9137-c3b050d20198",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isOT",
							uuid = "4d3a5c91-f542-1289-b1ec-c4bb2ed8c254",
							version = 2,
						},
					},
				},
				mechanicTime = 729.2,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 162,
				timerEndOffset = 5,
				uuid = "067dc15c-c529-83fc-b25f-b6ca90dec408",
				version = 2,
			},
			inheritedIndex = 6,
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
				uuid = "7d5ca556-d873-b084-8003-7f2526952f87",
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
				mechanicTime = 760.4,
				name = "--自己全减吃--",
				timelineIndex = 172,
				uuid = "2ceab232-7ffc-070c-8086-2b54ecb4cd50",
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
								
								{
									"a28b0340-bbdd-5a76-8ca2-3cf459224932",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_DarkestDance == 1",
							name = "p4",
							uuid = "a28b0340-bbdd-5a76-8ca2-3cf459224932",
							version = 2,
						},
					},
				},
				mechanicTime = 760.4,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 172,
				timerStartOffset = -15,
				uuid = "5bea1066-ab27-39d9-8828-4487010befd9",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"6d697860-1606-bb9e-9ab8-6c0cc9b2998d",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_DarkestDance == 1",
							name = "p4",
							uuid = "6d697860-1606-bb9e-9ab8-6c0cc9b2998d",
							version = 2,
						},
					},
				},
				mechanicTime = 760.4,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 172,
				timerStartOffset = -5,
				uuid = "35c42cc0-818e-446c-981a-a2684a0dae3e",
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
									"6dabb14a-b394-5d13-aae2-da307551f551",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_DarkestDance == 1",
							name = "p4",
							uuid = "6dabb14a-b394-5d13-aae2-da307551f551",
							version = 2,
						},
					},
				},
				mechanicTime = 760.4,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 172,
				timerOffset = -7,
				timerStartOffset = -4,
				uuid = "fd6c4a0a-061d-c1dd-bf72-76aedf33bc56",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"af9ddee4-af6f-780c-9da8-c9fb1345027b",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_DarkestDance == 1",
							name = "p4",
							uuid = "af9ddee4-af6f-780c-9da8-c9fb1345027b",
							version = 2,
						},
					},
				},
				mechanicTime = 760.4,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 172,
				timerStartOffset = -10,
				uuid = "8722bd5d-8b3b-d283-b077-8c59984e2a07",
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
				},
				enabled = false,
				mechanicTime = 760.4,
				name = "---------------",
				timelineIndex = 172,
				uuid = "a8b46827-639a-ea1d-826e-bcc695e6d05a",
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
				enabled = false,
				mechanicTime = 760.4,
				name = "--自己无敌吃--",
				timelineIndex = 172,
				uuid = "c4ed047d-f780-d8b9-953a-61d161f35235",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
									true,
								},
								
								{
									"eb058515-8528-b293-ab88-2d4fd5ec1cfc",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_HallowedGround",
							uuid = "79eb3402-396f-be4b-93c9-e249e8996732",
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
							actionID = 30,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_DarkestDance == 2",
							name = "p4",
							uuid = "eb058515-8528-b293-ab88-2d4fd5ec1cfc",
							version = 2,
						},
					},
				},
				mechanicTime = 760.4,
				name = "【PLD】神圣领域",
				timeRange = true,
				timelineIndex = 172,
				timerStartOffset = -5,
				uuid = "6bd28edd-4ce6-09ad-8920-874bc1cab5af",
				version = 2,
			},
			inheritedIndex = 23,
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
				uuid = "88b0c514-48da-651e-96c5-394caed0455b",
				version = 2,
			},
			inheritedIndex = 21,
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
				uuid = "8b6f844b-5c22-6fac-9ce6-1d12c9cec12f",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"fed120c1-2715-241c-960f-45973e41c4e0",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 1\n",
							name = "p4",
							uuid = "fed120c1-2715-241c-960f-45973e41c4e0",
							version = 2,
						},
					},
				},
				mechanicTime = 773.5,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 175,
				timerStartOffset = -5,
				uuid = "6ee310f2-7dcf-1006-823a-a1953ae23d3e",
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
								
								{
									"4c56049a-8ee2-e216-9cc7-ba9189373eea",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 1\n",
							name = "p4",
							uuid = "4c56049a-8ee2-e216-9cc7-ba9189373eea",
							version = 2,
						},
					},
				},
				mechanicTime = 773.5,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 175,
				timerStartOffset = -15,
				uuid = "5e13cfb0-3fe3-ee82-8319-ccc877e01e5f",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"1f0ef84e-8efa-1a52-b9a5-c0c888cbcc38",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 1\n",
							name = "p4",
							uuid = "1f0ef84e-8efa-1a52-b9a5-c0c888cbcc38",
							version = 2,
						},
					},
				},
				mechanicTime = 773.5,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 175,
				timerOffset = -7,
				timerStartOffset = -4,
				uuid = "4436eb31-8ad9-d8ac-b213-07cc30597f80",
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
				},
				enabled = false,
				mechanicTime = 773.5,
				name = "--自己减伤吃--",
				timelineIndex = 175,
				uuid = "4464a382-37fd-96f6-acd8-7d75cbb6c888",
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
				mechanicTime = 773.5,
				name = "---------------",
				timelineIndex = 175,
				uuid = "c427de7b-1bb4-8750-b2c9-d0bdfd37f951",
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
				mechanicTime = 773.5,
				name = "--搭档减伤吃--",
				timelineIndex = 175,
				uuid = "81704d6f-76be-f470-911b-777c3848e072",
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
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
									true,
								},
								
								{
									"37671bee-5673-95ba-a73e-28ac6105eb39",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_InterventionOT",
							ignoreWeaveRules = true,
							targetType = "Other Tank",
							uuid = "4e3b0fe5-f53a-8d0b-83de-322f63e3677a",
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
							actionID = 7393,
							category = "Self",
							conditionType = 6,
							gaugeValue = 50,
							uuid = "d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 2",
							name = "p4",
							uuid = "37671bee-5673-95ba-a73e-28ac6105eb39",
							version = 2,
						},
					},
				},
				mechanicTime = 773.5,
				name = "【PLD】干预",
				timeRange = true,
				timelineIndex = 175,
				timerStartOffset = -4,
				uuid = "b54fbfe3-3d12-0799-a0f4-fcd56e115fd2",
				version = 2,
			},
			inheritedIndex = 26,
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
				uuid = "79bd8d86-c7b3-e55c-8c56-222d9d1c18a5",
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
							actionID = 7533,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"c8ea8aef-c2a7-b604-9137-c3b050d20198",
									true,
								},
								
								{
									"27b05503-5beb-5898-bf22-873f010cb6aa",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 12809,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "877f22cc-bc3e-d5f8-8323-c03bec73892a",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "c8ea8aef-c2a7-b604-9137-c3b050d20198",
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
							uuid = "27b05503-5beb-5898-bf22-873f010cb6aa",
							version = 2,
						},
					},
				},
				mechanicTime = 773.5,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 175,
				timerEndOffset = 5,
				uuid = "30ac7f5a-6137-891e-8687-e746fc484f55",
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
									"c8ea8aef-c2a7-b604-9137-c3b050d20198",
									true,
								},
								
								{
									"4d3a5c91-f542-1289-b1ec-c4bb2ed8c254",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 9832,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "2aa44800-4ef2-7792-ab90-5629f5d46d8d",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "c8ea8aef-c2a7-b604-9137-c3b050d20198",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isOT",
							uuid = "4d3a5c91-f542-1289-b1ec-c4bb2ed8c254",
							version = 2,
						},
					},
				},
				mechanicTime = 773.5,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 175,
				timerEndOffset = 5,
				uuid = "8d6a857a-c464-3e75-b231-bc296dc8d56f",
				version = 2,
			},
			inheritedIndex = 11,
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
				},
				mechanicTime = 845.7,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 198,
				timerStartOffset = -14,
				uuid = "9584c94c-8cff-d3bb-8d65-022ec19a440e",
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
							aType = "ACR",
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 845.7,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 198,
				timerOffset = -7,
				timerStartOffset = -7,
				uuid = "1125c78f-622f-1bc7-ace0-44b13c6e0604",
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
								
								{
									"386c26f0-3d5e-31cc-a4cc-f08f209cd36a",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 3 and MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 3\n",
							name = "p4",
							uuid = "386c26f0-3d5e-31cc-a4cc-f08f209cd36a",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 845.7,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 198,
				timerStartOffset = -19,
				uuid = "01702f3c-880f-35e8-829c-a153895cd130",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"7bddd546-b6f1-8ebb-8545-031d28c222ae",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn1 == 3 and MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 3\n",
							name = "p4",
							uuid = "7bddd546-b6f1-8ebb-8545-031d28c222ae",
							version = 2,
						},
						inheritedIndex = 1,
					},
				},
				mechanicTime = 845.7,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 198,
				timerStartOffset = -9,
				uuid = "b780cd39-1750-d0c2-94da-2d4484aa01c9",
				version = 2,
			},
			inheritedIndex = 15,
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
				uuid = "23a230f9-213d-d9d1-9c0a-d2765d874ce4",
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
				mechanicTime = 854.9,
				name = "--自己减伤吃--",
				timelineIndex = 202,
				uuid = "add705e4-6cd1-7104-98df-0204d592ff0c",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"fed120c1-2715-241c-960f-45973e41c4e0",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 1\n",
							name = "p4",
							uuid = "fed120c1-2715-241c-960f-45973e41c4e0",
							version = 2,
						},
					},
				},
				mechanicTime = 854.9,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 202,
				timerStartOffset = -5,
				uuid = "2250f303-42dc-d9b3-8129-bc7569cf563b",
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
								
								{
									"4c56049a-8ee2-e216-9cc7-ba9189373eea",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 1\n",
							name = "p4",
							uuid = "4c56049a-8ee2-e216-9cc7-ba9189373eea",
							version = 2,
						},
					},
				},
				mechanicTime = 854.9,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 202,
				timerStartOffset = -15,
				uuid = "476fc9aa-98eb-4b61-b3c2-6dd979e6bd1e",
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
									"1f0ef84e-8efa-1a52-b9a5-c0c888cbcc38",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 1\n",
							name = "p4",
							uuid = "1f0ef84e-8efa-1a52-b9a5-c0c888cbcc38",
							version = 2,
						},
					},
				},
				mechanicTime = 854.9,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 202,
				timerOffset = -7,
				timerStartOffset = -2,
				uuid = "e5f84c52-1c67-dd15-9a53-7d251522cdca",
				version = 2,
			},
			inheritedIndex = 16,
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
				uuid = "dd106510-8085-33e3-b9cc-3972b005a984",
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
				mechanicTime = 854.9,
				name = "--搭档减伤吃--",
				timelineIndex = 202,
				uuid = "9fbe08c3-6872-ff19-8f43-e6789b97d720",
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
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
									true,
								},
								
								{
									"37671bee-5673-95ba-a73e-28ac6105eb39",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_InterventionOT",
							ignoreWeaveRules = true,
							targetType = "Other Tank",
							uuid = "4e3b0fe5-f53a-8d0b-83de-322f63e3677a",
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
							actionID = 7393,
							category = "Self",
							conditionType = 6,
							gaugeValue = 50,
							uuid = "d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P4_AkhMorn2 == 2",
							name = "p4",
							uuid = "37671bee-5673-95ba-a73e-28ac6105eb39",
							version = 2,
						},
					},
				},
				mechanicTime = 854.9,
				name = "【PLD】干预",
				timeRange = true,
				timelineIndex = 202,
				timerStartOffset = -4,
				uuid = "5037ba44-2607-05f4-af22-f681e4966973",
				version = 2,
			},
			inheritedIndex = 26,
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
				uuid = "47e1010c-a97f-8a14-950b-4b1771af45c0",
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
							actionID = 7533,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"c8ea8aef-c2a7-b604-9137-c3b050d20198",
									true,
								},
								
								{
									"4d3a5c91-f542-1289-b1ec-c4bb2ed8c254",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 9832,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "2aa44800-4ef2-7792-ab90-5629f5d46d8d",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "c8ea8aef-c2a7-b604-9137-c3b050d20198",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isOT",
							uuid = "4d3a5c91-f542-1289-b1ec-c4bb2ed8c254",
							version = 2,
						},
					},
				},
				mechanicTime = 854.9,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 202,
				timerEndOffset = 5,
				uuid = "f223d2ce-826e-4be3-9486-39775489d1ee",
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
							actionID = 7533,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"c8ea8aef-c2a7-b604-9137-c3b050d20198",
									true,
								},
								
								{
									"27b05503-5beb-5898-bf22-873f010cb6aa",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuDRK3_Hotbar_Provoke",
							targetContentID = 12809,
							targetName = "9832",
							targetType = "ContentID",
							uuid = "877f22cc-bc3e-d5f8-8323-c03bec73892a",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "c8ea8aef-c2a7-b604-9137-c3b050d20198",
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
							uuid = "27b05503-5beb-5898-bf22-873f010cb6aa",
							version = 2,
						},
					},
				},
				mechanicTime = 854.9,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 202,
				timerEndOffset = 5,
				uuid = "9a5b981c-ebe7-cae6-9041-711ba825d573",
				version = 2,
			},
			inheritedIndex = 11,
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 2",
							name = "p5",
							uuid = "289167d2-a9f5-1317-89c4-9ce635c717c2",
							version = 2,
						},
					},
				},
				mechanicTime = 984.8,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 209,
				timerStartOffset = -3,
				uuid = "43e93dbe-3ee5-b1de-8011-bfef82248469",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"731c2f93-02c9-072f-a6d5-1e6d517f2dba",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 2",
							name = "p5",
							uuid = "731c2f93-02c9-072f-a6d5-1e6d517f2dba",
							version = 2,
						},
					},
				},
				mechanicTime = 1011.4,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 215,
				timerStartOffset = -14,
				uuid = "05c0687d-be81-338b-beb8-6c171331e17c",
				version = 2,
			},
			inheritedIndex = 17,
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
									"3c30c1ad-589e-2573-806d-953af8b10db2",
									true,
								},
								
								{
									"e0961642-9ceb-6b9f-9b5e-c6b15589d705",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "3eb02a61-5e36-8dd2-861a-1526ea25f2b3",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "3c30c1ad-589e-2573-806d-953af8b10db2",
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
							uuid = "e0961642-9ceb-6b9f-9b5e-c6b15589d705",
							version = 2,
						},
					},
				},
				mechanicTime = 1029.6,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 218,
				timerStartOffset = -5,
				uuid = "0936ace8-aace-bab0-84b0-d31307c5635a",
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
									"7cc43a81-a74b-cc60-991e-2b8ced4cad42",
									true,
								},
								
								{
									"912128c9-3de1-0fcc-8ba1-571f1f761be9",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_ShirkOT",
							uuid = "ab3c180f-072f-5279-abb7-43ecbcb9bc5b",
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
							uuid = "912128c9-3de1-0fcc-8ba1-571f1f761be9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"mt\"",
							name = "isMT",
							uuid = "7cc43a81-a74b-cc60-991e-2b8ced4cad42",
							version = 2,
						},
					},
				},
				mechanicTime = 1029.6,
				name = " 退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 218,
				timerStartOffset = -5,
				uuid = "4c2c2f1c-2c29-2af0-afc9-ff979f8131a9",
				version = 2,
			},
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
				uuid = "2eb7b215-6d27-e6a4-a8f5-ced15ceca66e",
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
				mechanicTime = 1033.6,
				name = "--自己全减吃--",
				timelineIndex = 222,
				uuid = "e864adb2-6791-3a01-a3b4-972c58655fde",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"e38f6dd9-22e7-da59-ae28-424814ab842c",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 1",
							name = "p5",
							uuid = "e38f6dd9-22e7-da59-ae28-424814ab842c",
							version = 2,
						},
					},
				},
				mechanicTime = 1033.6,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 222,
				timerStartOffset = -14,
				uuid = "68682c7c-2519-4cdc-9020-cfeee701f069",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"dd5b24c8-dd07-77a9-9fc0-77c2178c2919",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 1",
							name = "p5",
							uuid = "dd5b24c8-dd07-77a9-9fc0-77c2178c2919",
							version = 2,
						},
					},
				},
				mechanicTime = 1033.6,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 222,
				timerOffset = -7,
				timerStartOffset = -7,
				uuid = "d80deaa3-4705-29d7-b863-310de6325584",
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
								
								{
									"2bac90ac-8175-edbe-812f-526834a3669c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 1",
							name = "p5",
							uuid = "2bac90ac-8175-edbe-812f-526834a3669c",
							version = 2,
						},
					},
				},
				mechanicTime = 1033.6,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 222,
				timerStartOffset = -19,
				uuid = "fe5911ee-eb13-a7b6-bc0b-d3ff490e5740",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"abfbaddc-f107-2f26-8d33-7cfdd6f1c821",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 1",
							name = "p5",
							uuid = "abfbaddc-f107-2f26-8d33-7cfdd6f1c821",
							version = 2,
						},
					},
				},
				mechanicTime = 1033.6,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 222,
				timerStartOffset = -9,
				uuid = "0a61954a-4b89-f22e-b741-f2f8387ab373",
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
				mechanicTime = 1033.6,
				name = "---------------",
				timelineIndex = 222,
				uuid = "0e966880-f157-9202-a97a-708203de8817",
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
				mechanicTime = 1033.6,
				name = "--自己无敌吃--",
				timelineIndex = 222,
				uuid = "1750ddb4-a387-f567-b640-1a2be1c37e66",
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
							actionID = 30,
							allowInterrupt = true,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
									true,
								},
								
								{
									"f4c312e7-1915-1da4-a920-26777595ce8d",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_HallowedGround",
							ignoreWeaveRules = true,
							uuid = "79eb3402-396f-be4b-93c9-e249e8996732",
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
							actionID = 30,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 2",
							name = "p5",
							uuid = "f4c312e7-1915-1da4-a920-26777595ce8d",
							version = 2,
						},
					},
				},
				mechanicTime = 1033.6,
				name = "【PLD】神圣领域",
				timeRange = true,
				timelineIndex = 222,
				timerStartOffset = -8,
				uuid = "9c2e4be1-ac1c-a4b4-93f4-f45e674a7fb5",
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
							aType = "ACR",
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
									true,
								},
								
								{
									"cfb4df5f-ba2a-d026-8f92-2b18ef182853",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_InterventionOT",
							ignoreWeaveRules = true,
							targetType = "Other Tank",
							uuid = "4e3b0fe5-f53a-8d0b-83de-322f63e3677a",
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
							actionID = 7393,
							category = "Self",
							conditionType = 6,
							gaugeValue = 50,
							uuid = "d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death1 == 2",
							name = "p5",
							uuid = "cfb4df5f-ba2a-d026-8f92-2b18ef182853",
							version = 2,
						},
					},
				},
				mechanicTime = 1033.6,
				name = "【PLD】干预",
				timeRange = true,
				timelineIndex = 222,
				timerStartOffset = -4,
				uuid = "d56c472b-3aa4-1ebb-8413-b8d4803cc91d",
				version = 2,
			},
			inheritedIndex = 26,
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
				uuid = "845f7624-b99a-31dc-882e-2628a696840e",
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
									"3c30c1ad-589e-2573-806d-953af8b10db2",
									true,
								},
								
								{
									"19b687a9-cc6a-d770-8c84-b9c36b7ccf4d",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "3eb02a61-5e36-8dd2-861a-1526ea25f2b3",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "3c30c1ad-589e-2573-806d-953af8b10db2",
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
							uuid = "19b687a9-cc6a-d770-8c84-b9c36b7ccf4d",
							version = 2,
						},
					},
				},
				mechanicTime = 1033.6,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 5,
				uuid = "00b50a0b-9347-c75e-9ab8-561192e8b459",
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
									"912128c9-3de1-0fcc-8ba1-571f1f761be9",
									true,
								},
								
								{
									"bd920b45-f333-4da1-85af-d70ae32ac4f4",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_ShirkOT",
							uuid = "ab3c180f-072f-5279-abb7-43ecbcb9bc5b",
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
							uuid = "912128c9-3de1-0fcc-8ba1-571f1f761be9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isot",
							uuid = "bd920b45-f333-4da1-85af-d70ae32ac4f4",
							version = 2,
						},
					},
				},
				mechanicTime = 1033.6,
				name = "  退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 222,
				timerEndOffset = 5,
				uuid = "4f044ef9-dc07-a4aa-90bb-ed7a25c37f29",
				version = 2,
			},
			inheritedIndex = 13,
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
								
								{
									"45d6f9c4-9c21-e4fc-a309-113e64dda1a7",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 2\n",
							name = "p5",
							uuid = "45d6f9c4-9c21-e4fc-a309-113e64dda1a7",
							version = 2,
						},
					},
				},
				mechanicTime = 1097.4,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 237,
				timerStartOffset = -3,
				uuid = "9e0fd32c-9e13-c051-84de-a1aabf4cd3ad",
				version = 2,
			},
			inheritedIndex = 2,
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
									"3c30c1ad-589e-2573-806d-953af8b10db2",
									true,
								},
								
								{
									"e0961642-9ceb-6b9f-9b5e-c6b15589d705",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "3eb02a61-5e36-8dd2-861a-1526ea25f2b3",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "3c30c1ad-589e-2573-806d-953af8b10db2",
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
							uuid = "e0961642-9ceb-6b9f-9b5e-c6b15589d705",
							version = 2,
						},
					},
				},
				mechanicTime = 1146.3,
				name = " 挑衅",
				timeRange = true,
				timelineIndex = 247,
				timerStartOffset = -5,
				uuid = "afad9868-8fbc-fc5f-9018-237d92b07b30",
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
									"7cc43a81-a74b-cc60-991e-2b8ced4cad42",
									true,
								},
								
								{
									"912128c9-3de1-0fcc-8ba1-571f1f761be9",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_ShirkOT",
							uuid = "ab3c180f-072f-5279-abb7-43ecbcb9bc5b",
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
							uuid = "912128c9-3de1-0fcc-8ba1-571f1f761be9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"mt\"",
							name = "isMT",
							uuid = "7cc43a81-a74b-cc60-991e-2b8ced4cad42",
							version = 2,
						},
					},
				},
				mechanicTime = 1146.3,
				name = " 退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 247,
				timerStartOffset = -5,
				uuid = "bfd181b8-40b0-57a6-b158-4e2ffe71fedb",
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
				},
				conditions = 
				{
				},
				enabled = false,
				mechanicTime = 1150.3,
				name = "---------------",
				timelineIndex = 251,
				uuid = "564edad8-88f2-496a-bb68-c2227e38eaa7",
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
				mechanicTime = 1150.3,
				name = "--自己全减吃--",
				timelineIndex = 251,
				uuid = "329fec8a-82b7-95a8-a6f1-d626610c2e0f",
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
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"e38f6dd9-22e7-da59-ae28-424814ab842c",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 1",
							name = "p5",
							uuid = "e38f6dd9-22e7-da59-ae28-424814ab842c",
							version = 2,
						},
					},
				},
				mechanicTime = 1150.3,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 251,
				timerStartOffset = -14,
				uuid = "a48e857b-1566-aeca-908f-15b13b324f00",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"dd5b24c8-dd07-77a9-9fc0-77c2178c2919",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_HolySheltron",
							uuid = "3bc9a472-6a70-ceee-be06-6838e7cc5445",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 1",
							name = "p5",
							uuid = "dd5b24c8-dd07-77a9-9fc0-77c2178c2919",
							version = 2,
						},
					},
				},
				mechanicTime = 1150.3,
				name = "【PLD】圣盾阵",
				timeRange = true,
				timelineIndex = 251,
				timerOffset = -7,
				timerStartOffset = -7,
				uuid = "4da3c987-25d3-6a35-8822-16c3f8a3c33b",
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
								
								{
									"2bac90ac-8175-edbe-812f-526834a3669c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 1",
							name = "p5",
							uuid = "2bac90ac-8175-edbe-812f-526834a3669c",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 1150.3,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 251,
				timerStartOffset = -19,
				uuid = "b3006248-de0a-1707-bc90-318994da156a",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"abfbaddc-f107-2f26-8d33-7cfdd6f1c821",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Bulwark",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 22,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 1",
							name = "p5",
							uuid = "abfbaddc-f107-2f26-8d33-7cfdd6f1c821",
							version = 2,
						},
					},
				},
				mechanicTime = 1150.3,
				name = "【PLD】壁垒",
				timeRange = true,
				timelineIndex = 251,
				timerStartOffset = -9,
				uuid = "a97a4a6a-c98c-8e2e-97d1-d90912711730",
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
				mechanicTime = 1150.3,
				name = "---------------",
				timelineIndex = 251,
				uuid = "91ce2be9-54dd-2310-a4df-97ddb5611a8e",
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
				mechanicTime = 1150.3,
				name = "--自己无敌吃--",
				timelineIndex = 251,
				uuid = "ffbb5851-347a-4474-98c1-267421b6861a",
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
							actionID = 30,
							allowInterrupt = true,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
									true,
								},
								
								{
									"f4c312e7-1915-1da4-a920-26777595ce8d",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_HallowedGround",
							ignoreWeaveRules = true,
							uuid = "79eb3402-396f-be4b-93c9-e249e8996732",
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
							actionID = 30,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "5d75a6c1-f933-5561-9c7e-3a5f42ec2714",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 2",
							name = "p5",
							uuid = "f4c312e7-1915-1da4-a920-26777595ce8d",
							version = 2,
						},
					},
				},
				mechanicTime = 1150.3,
				name = "【PLD】神圣领域",
				timeRange = true,
				timelineIndex = 251,
				timerStartOffset = -8,
				uuid = "1b0af0d2-bd79-0379-a77e-f7e2291fc3a4",
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
							aType = "ACR",
							actionID = 7393,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
									true,
								},
								
								{
									"cfb4df5f-ba2a-d026-8f92-2b18ef182853",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuPLD3_Tankbar_InterventionOT",
							ignoreWeaveRules = true,
							targetType = "Other Tank",
							uuid = "4e3b0fe5-f53a-8d0b-83de-322f63e3677a",
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
							actionID = 7393,
							category = "Self",
							conditionType = 6,
							gaugeValue = 50,
							uuid = "d6dc01a0-9862-74bd-aa8b-9c5e04acf155",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 2",
							name = "p5",
							uuid = "cfb4df5f-ba2a-d026-8f92-2b18ef182853",
							version = 2,
						},
					},
				},
				mechanicTime = 1150.3,
				name = "【PLD】干预",
				timeRange = true,
				timelineIndex = 251,
				timerStartOffset = -4,
				uuid = "d44c8a17-8a65-0f43-8817-96e86ea47e22",
				version = 2,
			},
			inheritedIndex = 26,
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
				uuid = "44e0125e-82cc-9c28-a4e7-31db9d324218",
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
									"3c30c1ad-589e-2573-806d-953af8b10db2",
									true,
								},
								
								{
									"19b687a9-cc6a-d770-8c84-b9c36b7ccf4d",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_Provoke",
							uuid = "3eb02a61-5e36-8dd2-861a-1526ea25f2b3",
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
							buffID = 79,
							category = "Self",
							name = "钢铁信念",
							uuid = "3c30c1ad-589e-2573-806d-953af8b10db2",
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
							uuid = "19b687a9-cc6a-d770-8c84-b9c36b7ccf4d",
							version = 2,
						},
					},
				},
				mechanicTime = 1150.3,
				name = "  挑衅",
				timeRange = true,
				timelineIndex = 251,
				timerEndOffset = 5,
				uuid = "ce21b37a-d5b3-5ba8-ba02-bde464f6103a",
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
									"912128c9-3de1-0fcc-8ba1-571f1f761be9",
									true,
								},
								
								{
									"bd920b45-f333-4da1-85af-d70ae32ac4f4",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Hotbar_ShirkOT",
							uuid = "ab3c180f-072f-5279-abb7-43ecbcb9bc5b",
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
							uuid = "912128c9-3de1-0fcc-8ba1-571f1f761be9",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return _G[\"ACR_\"..gACRSelectedProfiles[TensorCore.mGetPlayer().job]..\"_TankStance\"] == \"ot\"",
							name = "isot",
							uuid = "bd920b45-f333-4da1-85af-d70ae32ac4f4",
							version = 2,
						},
					},
				},
				mechanicTime = 1150.3,
				name = "  退避",
				randomOffset = 11,
				timeRange = true,
				timelineIndex = 251,
				timerEndOffset = 5,
				uuid = "8dbf9827-ee96-da4a-b858-226af2741f69",
				version = 2,
			},
			inheritedIndex = 13,
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
							actionID = 7531,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"8c7c2f1f-329f-780a-9347-f9e4ae77485d",
									true,
								},
								
								{
									"2bac90ac-8175-edbe-812f-526834a3669c",
									true,
								},
							},
							gVar = "ACR_RikuDRK3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "b1de83ea-1aad-0697-8c97-5dcf7f941e3e",
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
							actionID = 7531,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8c7c2f1f-329f-780a-9347-f9e4ae77485d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 1",
							name = "p5",
							uuid = "2bac90ac-8175-edbe-812f-526834a3669c",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 1187.6,
				name = "【PLD】铁壁",
				timeRange = true,
				timelineIndex = 262,
				timerEndOffset = 5,
				timerStartOffset = -2.5,
				uuid = "ea783cd1-d295-59cd-bff1-ed5d46cc4ed8",
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
							aType = "ACR",
							actionID = 36927,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
									true,
								},
								
								{
									"e38f6dd9-22e7-da59-ae28-424814ab842c",
									true,
								},
							},
							gVar = "ACR_RikuPLD3_Tankbar_Guardian",
							ignoreWeaveRules = true,
							uuid = "689f1902-a012-d42a-8f2b-521b41d3452c",
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
							actionID = 36920,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "ae002791-bc5f-3a5a-9c64-e7a5bf65f464",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Tank.P5_Death2 == 1",
							name = "p5",
							uuid = "e38f6dd9-22e7-da59-ae28-424814ab842c",
							version = 2,
						},
					},
				},
				mechanicTime = 1187.6,
				name = "【PLD】极致防御",
				timeRange = true,
				timelineIndex = 262,
				timerEndOffset = 10,
				timerStartOffset = 2.5,
				uuid = "8ca5a688-6e7b-bf89-bafd-0beee421e940",
				version = 2,
			},
			inheritedIndex = 17,
		},
	},
	inheritedProfiles = 
	{
	},
	mapID = 1238,
	version = 5,
}



return tbl