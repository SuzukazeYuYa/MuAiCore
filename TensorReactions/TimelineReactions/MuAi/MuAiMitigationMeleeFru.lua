local tbl = 
{
	[4] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"b2e9f059-d619-667f-a2a3-bca253ea857b",
									true,
								},
								
								{
									"c4aafab9-4299-4936-a0e1-394b179f7e2d",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinsMite.Target == true",
							name = "SinsMite.Target",
							uuid = "b2e9f059-d619-667f-a2a3-bca253ea857b",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "c4aafab9-4299-4936-a0e1-394b179f7e2d",
							version = 2,
						},
					},
				},
				mechanicTime = 16.4,
				name = "[MuAiMelee]牵制",
				timelineIndex = 4,
				timerOffset = -14.5,
				uuid = "c9d33fea-30c0-dec1-8960-b9dc5a722005",
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
							actionID = 65,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinsMite.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 16.4,
				name = "[MuAiNelee]真言",
				timelineIndex = 4,
				timerOffset = -14,
				uuid = "fdd76df6-64ed-7178-a4e6-8c32ea94f828",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"46f0e862-a7ce-7c1f-b515-efd97db74451",
									true,
								},
								
								{
									"0af9bb55-ef13-d764-86d5-34d838b935c5",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory1.Target == true",
							name = "BurnishedGlory1.Target",
							uuid = "46f0e862-a7ce-7c1f-b515-efd97db74451",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "0af9bb55-ef13-d764-86d5-34d838b935c5",
							version = 2,
						},
					},
				},
				mechanicTime = 85.9,
				name = "[MuAiMelee]牵制",
				timeRange = true,
				timelineIndex = 22,
				timerOffset = -14.5,
				timerStartOffset = -14.5,
				uuid = "058a8b47-4f5a-bbf6-bafb-867385e1a7de",
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
							actionID = 65,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							ignoreWeaveRules = true,
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory1.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 85.9,
				name = "[MuAiNelee]真言",
				timelineIndex = 22,
				timerOffset = -14,
				uuid = "09239e0f-391c-f353-9472-f57a0045457b",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"84bbd260-0598-ac82-88cb-78f69540edd3",
									true,
								},
								
								{
									"3da5251f-c924-3464-bfe1-304b6734bb83",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory2.Target == true",
							name = "BurnishedGlory2.Target",
							uuid = "84bbd260-0598-ac82-88cb-78f69540edd3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "3da5251f-c924-3464-bfe1-304b6734bb83",
							version = 2,
						},
					},
				},
				mechanicTime = 121.1,
				name = "[MuAiMelee]牵制",
				timelineIndex = 29,
				timerOffset = -14.5,
				uuid = "b09d849f-5c07-9a24-a565-e5d4e122d654",
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
							actionID = 65,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory2.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 121.1,
				name = "[MuAiNelee]真言",
				timelineIndex = 29,
				timerOffset = -14,
				uuid = "b2c214f3-bcd7-d389-98ed-2102b39047d3",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"56c55a7a-791d-6c84-aace-b5e0ac096367",
									true,
								},
								
								{
									"ef0699ba-65bc-20c5-90d3-5839ccb6b717",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.DiamondDust.Target == true",
							name = "DiamondDust.Target ",
							uuid = "56c55a7a-791d-6c84-aace-b5e0ac096367",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "ef0699ba-65bc-20c5-90d3-5839ccb6b717",
							version = 2,
						},
					},
				},
				mechanicTime = 235.3,
				name = "[MuAiMelee]牵制",
				timelineIndex = 44,
				timerOffset = -14.5,
				uuid = "cdac9d25-b81d-d838-b06c-0c6d160fdfb8",
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
							actionID = 65,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.DiamondDust.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 235.3,
				name = "[MuAiNelee]真言",
				timelineIndex = 44,
				timerOffset = -14,
				uuid = "0ec1b572-552a-3230-80d3-66abe1152941",
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
							actionID = 65,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							ignoreWeaveRules = true,
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinBound.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 259.9,
				name = "[MuAiNelee]真言",
				timeRange = true,
				timelineIndex = 57,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "8a4b1017-8359-f4ce-8db7-852ec77a0e1e",
				version = 2,
			},
			inheritedIndex = 1,
		},
	},
	[64] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"9290ebe7-534a-2ccd-bde2-67f263ed9e4a",
									true,
								},
								
								{
									"b2fe3692-f689-c326-9a87-05b4a5b66ab8",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedRay.Target == true",
							name = "HallowedRay.Target",
							uuid = "9290ebe7-534a-2ccd-bde2-67f263ed9e4a",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "b2fe3692-f689-c326-9a87-05b4a5b66ab8",
							version = 2,
						},
					},
				},
				mechanicTime = 283,
				name = "[MuAiMelee]牵制",
				timelineIndex = 64,
				timerOffset = -5,
				uuid = "20622ab0-8ad9-474d-a1a0-1c4630e51940",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedRay.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 283,
				name = "[MuAiNelee]真言",
				timelineIndex = 64,
				timerOffset = -14,
				uuid = "7e7b6274-9b78-3fb0-ac10-cadb816a077e",
				version = 2,
			},
		},
	},
	[77] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"18a74856-cc15-84a9-a577-7e9e0b9d2a9f",
									true,
								},
								
								{
									"e8f8297a-8875-5f88-9cb0-7de32b983b00",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.LightRampant.Target == true",
							name = "LightRampant.Target",
							uuid = "18a74856-cc15-84a9-a577-7e9e0b9d2a9f",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "e8f8297a-8875-5f88-9cb0-7de32b983b00",
							version = 2,
						},
					},
				},
				mechanicTime = 322.5,
				name = "[MuAiMelee]牵制",
				timelineIndex = 77,
				timerOffset = -4,
				uuid = "674f1fec-1aed-6c0b-845a-4924ca41a8c7",
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
							actionID = 65,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							ignoreWeaveRules = true,
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.LightRampant.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 322.5,
				name = "[MuAiNelee]真言",
				timelineIndex = 77,
				timerOffset = -14,
				uuid = "41717184-00b2-5657-ac1f-0996b18b7419",
				version = 2,
			},
		},
	},
	[92] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"fa258dcd-dfb9-9d3a-bb85-a1cc88d8531a",
									true,
								},
								
								{
									"0293a8a7-4f85-88b1-aa53-3baf1bc3d38b",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.HouseOfLight.Target == true\n",
							name = "HouseOfLight.Target",
							uuid = "fa258dcd-dfb9-9d3a-bb85-a1cc88d8531a",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "0293a8a7-4f85-88b1-aa53-3baf1bc3d38b",
							version = 2,
						},
					},
				},
				mechanicTime = 360.8,
				name = "[MuAiMelee]牵制",
				timelineIndex = 92,
				timerOffset = -5,
				uuid = "25575fd0-39de-a283-814e-386e87b99c29",
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
							actionID = 65,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							ignoreWeaveRules = true,
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.HouseOfLight.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 360.8,
				name = "[MuAiNelee]真言",
				timelineIndex = 92,
				timerOffset = -14,
				uuid = "0f68ab8a-b0d6-7bda-8d52-35728c7e114e",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"3d5f6e92-5e23-b79b-b819-3fb548510ddb",
									true,
								},
								
								{
									"354c04f6-5455-0ce9-8153-9ec57d955146",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.AbsoluteZero.Target == true",
							name = "AbsoluteZero.Target",
							uuid = "3d5f6e92-5e23-b79b-b819-3fb548510ddb",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "354c04f6-5455-0ce9-8153-9ec57d955146",
							version = 2,
						},
					},
				},
				mechanicTime = 388.7,
				name = "[MuAiMelee]牵制",
				timelineIndex = 100,
				timerOffset = -14,
				uuid = "bba159b2-b652-fcec-9fe2-c5288f868789",
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
							actionID = 65,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.HouseOfLight.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 388.7,
				name = "[MuAiNelee]真言",
				timelineIndex = 100,
				timerOffset = -14,
				uuid = "f81f7574-bc40-89b9-8908-d468910855c4",
				version = 2,
			},
		},
	},
	[121] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.HpOne.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 518.3,
				name = "[MuAiNelee]真言",
				timeRange = true,
				timelineIndex = 121,
				timerOffset = -14,
				timerStartOffset = -5,
				uuid = "0ef12259-e8cb-c315-8c8b-7967400e7a20",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"1d866135-7019-bc3e-ad02-64d20906167a",
									true,
								},
								
								{
									"55b73d41-e7a5-0a97-beaa-5f4dcfe12221",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Relativity.Target == true",
							name = "Relativity.Target",
							uuid = "1d866135-7019-bc3e-ad02-64d20906167a",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "55b73d41-e7a5-0a97-beaa-5f4dcfe12221",
							version = 2,
						},
					},
				},
				mechanicTime = 532.4,
				name = "[MuAiMelee]牵制",
				timelineIndex = 123,
				timerOffset = -14,
				uuid = "df206d1c-872f-a842-85b3-0602ddcc6e8f",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Relativity.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 532.4,
				name = "[MuAiNelee]真言",
				timelineIndex = 123,
				timerOffset = -14,
				uuid = "ece98333-6d8f-2714-b900-73d9caa52e84",
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
							actionID = 4243,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "NINJA",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB1 == true",
							name = "自动极限技",
							uuid = "f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "自动极限技-忍者",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -13,
				uuid = "e267d212-bc5b-5d79-a6ee-43451b80dc40",
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
							actionID = 202,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"182d14da-c06d-402b-aee5-06d15adc7575",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB1 == true",
							name = "自动极限技",
							uuid = "182d14da-c06d-402b-aee5-06d15adc7575",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "自动极限技-武僧",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -13,
				uuid = "e34b40df-6f59-e9cd-b288-2ace1f2aff49",
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
							actionID = 4242,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"182d14da-c06d-402b-aee5-06d15adc7575",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "DRAGOON",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB1 == true",
							name = "自动极限技",
							uuid = "182d14da-c06d-402b-aee5-06d15adc7575",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "自动极限技-龙骑",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -13,
				uuid = "003daf9a-37ac-a2e0-9618-ce6e6ad5bbab",
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
							actionID = 24858,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"182d14da-c06d-402b-aee5-06d15adc7575",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "REAPER",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB1 == true",
							name = "自动极限技",
							uuid = "182d14da-c06d-402b-aee5-06d15adc7575",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "自动极限技-镰刀",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -13,
				uuid = "e1ba3d13-6a47-b5bc-87a8-dc9809b8cd19",
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
							actionID = 34866,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB1 == true",
							name = "自动极限技",
							uuid = "f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "自动极限技-蝰蛇",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -13,
				uuid = "b3b62e93-48b8-805d-aa37-c557a3928c1c",
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
							actionID = 7861,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
									true,
								},
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "SAMURAI",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB1 == true",
							name = "自动极限技",
							uuid = "f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
							version = 2,
						},
					},
				},
				eventType = 3,
				mechanicTime = 532.4,
				name = "自动极限技-武士",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -13,
				uuid = "fb0f01ca-5e0f-3635-8475-687d9766e023",
				version = 2,
			},
			inheritedIndex = 8,
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShockwavePulsar.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 569.3,
				name = "[MuAiNelee]真言",
				timelineIndex = 134,
				timerOffset = -14,
				uuid = "5108ab28-4a42-011b-9d09-714c533386c7",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"4bc5708a-e048-c66a-bea9-24a4e55f7fbb",
									true,
								},
								
								{
									"68a84c6f-b9a8-d5bf-8185-dbc68dbef410",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShellCrusher.Target == true",
							name = "ShellCrusher.Target",
							uuid = "4bc5708a-e048-c66a-bea9-24a4e55f7fbb",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "68a84c6f-b9a8-d5bf-8185-dbc68dbef410",
							version = 2,
						},
					},
				},
				mechanicTime = 587.1,
				name = "[MuAiMelee]牵制",
				timeRange = true,
				timelineIndex = 139,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "f6c088e9-cca9-766f-92f5-9072f7bf7115",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShockwavePulsar.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 587.1,
				name = "[MuAiNelee]真言",
				timelineIndex = 139,
				timerOffset = -14,
				uuid = "f48b6d5c-dd3e-76d1-bb85-cc159f67fd13",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"edf8174c-fbc2-4719-a199-a98b348c8bfb",
									true,
								},
								
								{
									"9ba31348-d669-b1ca-9e76-13f49637a4c4",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkWater.Target == true",
							name = "DarkWater.Target",
							uuid = "edf8174c-fbc2-4719-a199-a98b348c8bfb",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "9ba31348-d669-b1ca-9e76-13f49637a4c4",
							version = 2,
						},
					},
				},
				mechanicTime = 651.2,
				name = "[MuAiMelee]牵制",
				timelineIndex = 152,
				timerOffset = -14,
				uuid = "22a0a5a6-3330-6c58-b253-d08d9e9c416a",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkWater.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 651.2,
				name = "[MuAiNelee]真言",
				timelineIndex = 152,
				timerOffset = -14,
				uuid = "06be0272-ae1a-b827-a867-2b2420ab26a5",
				version = 2,
			},
		},
	},
	[153] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 65,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkWater.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 656.4,
				name = "[MuAiNelee]真言",
				timeRange = true,
				timelineIndex = 153,
				timerOffset = -14,
				timerStartOffset = -14,
				uuid = "94fd2584-6157-d32d-84e6-fb2d3e51bc43",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"b794d9cf-aea5-5ad1-b78a-55819bd653ec",
									true,
								},
								
								{
									"383581d5-b6ef-75d9-b502-8e604fcff9a7",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.MemorySEnd.Target == true",
							name = "MemorySEnd.Target",
							uuid = "b794d9cf-aea5-5ad1-b78a-55819bd653ec",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "383581d5-b6ef-75d9-b502-8e604fcff9a7",
							version = 2,
						},
					},
				},
				mechanicTime = 670.1,
				name = "[MuAiMelee]牵制",
				timelineIndex = 154,
				timerOffset = -14,
				uuid = "9247eb55-7c9a-b471-877f-9ccfe6765cfb",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkWater.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 670.1,
				name = "[MuAiNelee]真言",
				timelineIndex = 154,
				timerOffset = -14,
				uuid = "12aadebd-0163-b91e-a69c-6425ccb5485d",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d3141496-a33d-6a4b-beb1-3646ba79deee",
									true,
								},
								
								{
									"334ffba9-a204-4c3f-85bc-81eef561f508",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetContentID = 12809,
							targetType = "ContentID",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkLitDragonSong.Target == true",
							name = "DarkLitDragonSong.Target",
							uuid = "d3141496-a33d-6a4b-beb1-3646ba79deee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "334ffba9-a204-4c3f-85bc-81eef561f508",
							version = 2,
						},
					},
				},
				mechanicTime = 738.2,
				name = "[MuAiMelee]牵制-琳",
				timelineIndex = 166,
				timerOffset = -14,
				uuid = "68b5704a-8c23-3a9b-bd43-29bdfccf1114",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkLitDragonSong.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 738.2,
				name = "[MuAiNelee]真言",
				timelineIndex = 166,
				timerOffset = -14,
				uuid = "3054689c-9ed3-c3ec-a258-100dc3c86644",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah1.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 783.4,
				name = "[MuAiNelee]真言",
				timelineIndex = 176,
				timerOffset = -14,
				uuid = "86e23bee-903b-8c68-b87c-918b3e4bd846",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d3141496-a33d-6a4b-beb1-3646ba79deee",
									true,
								},
								
								{
									"334ffba9-a204-4c3f-85bc-81eef561f508",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetContentID = 12809,
							targetType = "ContentID",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah1.Target == true",
							name = "MornAfah1.Target",
							uuid = "d3141496-a33d-6a4b-beb1-3646ba79deee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "334ffba9-a204-4c3f-85bc-81eef561f508",
							version = 2,
						},
					},
				},
				mechanicTime = 783.4,
				name = "[MuAiMelee]牵制-琳",
				timelineIndex = 176,
				timerOffset = -14,
				uuid = "3496d33a-fa73-c3ce-a02d-e88558a232f1",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"24ae3595-014b-76a2-a8e5-c0df58af3a1f",
									true,
								},
								
								{
									"6386ccc1-3e36-d3ec-969c-bf4ba0a153a0",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetContentID = 9832,
							targetType = "ContentID",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.CrystallizeTime.Target == true",
							name = "CrystallizeTime.Target",
							uuid = "24ae3595-014b-76a2-a8e5-c0df58af3a1f",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "6386ccc1-3e36-d3ec-969c-bf4ba0a153a0",
							version = 2,
						},
					},
				},
				mechanicTime = 798.9,
				name = "[MuAiMelee]牵制-盖娅",
				timelineIndex = 179,
				timerOffset = -14,
				uuid = "6766438b-b8b2-eabe-a8ed-4430380d2169",
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
							actionID = 65,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.CrystallizeTime.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 798.9,
				name = "[MuAiNelee]真言",
				timelineIndex = 179,
				timerOffset = -2,
				uuid = "6ea4cd68-68bf-9e6a-8fec-5890d6addcc3",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedWings.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 845.7,
				name = "[MuAiNelee]真言",
				timelineIndex = 198,
				timerOffset = -1,
				uuid = "0a734533-c02d-e88d-951e-b4823f696939",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d3141496-a33d-6a4b-beb1-3646ba79deee",
									true,
								},
								
								{
									"334ffba9-a204-4c3f-85bc-81eef561f508",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetContentID = 12809,
							targetType = "ContentID",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah2.Target == true",
							name = "MornAfah2.Target",
							uuid = "d3141496-a33d-6a4b-beb1-3646ba79deee",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "334ffba9-a204-4c3f-85bc-81eef561f508",
							version = 2,
						},
					},
				},
				mechanicTime = 864.8,
				name = "[MuAiMelee]牵制-琳",
				timelineIndex = 204,
				timerOffset = -14,
				uuid = "0916bb3f-fb4a-8e48-a857-64ab06821536",
				version = 2,
			},
			inheritedIndex = 1,
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"74b8761f-6acc-3cff-b4e2-7161995abb89",
									true,
								},
								
								{
									"28cca04a-4bfd-690a-bd6c-1bf7df176e1e",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade1.Target == true",
							name = "FulgentBlade1.Target",
							uuid = "74b8761f-6acc-3cff-b4e2-7161995abb89",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "28cca04a-4bfd-690a-bd6c-1bf7df176e1e",
							version = 2,
						},
					},
				},
				mechanicTime = 984.8,
				name = "[MuAiMelee]牵制",
				timelineIndex = 209,
				timerOffset = -13,
				uuid = "33f4b4d2-9d1a-62c5-850d-0fb8833a60b1",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedWings.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 984.8,
				name = "[MuAiNelee]真言",
				timelineIndex = 209,
				timerOffset = -14,
				uuid = "bf26e623-b92c-8316-a578-78590dd255a9",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ef55a050-ea38-14d9-a088-9d1999054fce",
									true,
								},
								
								{
									"cfb66e53-ba92-d2aa-ac30-bbcefccecd78",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn1.Target == true",
							name = "AkhMorn1.Target",
							uuid = "ef55a050-ea38-14d9-a088-9d1999054fce",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "cfb66e53-ba92-d2aa-ac30-bbcefccecd78",
							version = 2,
						},
					},
				},
				mechanicTime = 1011.4,
				name = "[MuAiMelee]牵制",
				timelineIndex = 215,
				timerOffset = -14,
				uuid = "f10be465-56cf-7697-877b-6de33ec55906",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn1.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 1011.4,
				name = "[MuAiNelee]真言",
				timelineIndex = 215,
				timerOffset = -14,
				uuid = "592b40c8-5556-faa5-96b8-460391a80ab2",
				version = 2,
			},
		},
	},
	[233] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ce629e9c-8242-8e07-aac4-679101994468",
									true,
								},
								
								{
									"106e075d-6aa9-ca8c-95d6-52d59836efe2",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing1.Target == true",
							name = "Polarizing1.Target",
							uuid = "ce629e9c-8242-8e07-aac4-679101994468",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "106e075d-6aa9-ca8c-95d6-52d59836efe2",
							version = 2,
						},
					},
				},
				mechanicTime = 1065.6,
				name = "[MuAiMelee]牵制",
				timelineIndex = 233,
				timerOffset = -14,
				uuid = "1f6ed51b-d638-2fb5-b453-ace43b8e57eb",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing1.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 1065.6,
				name = "[MuAiNelee]真言",
				timelineIndex = 233,
				timerOffset = -14,
				uuid = "bf0a49be-1b32-64eb-8bb0-c1bfcd036890",
				version = 2,
			},
		},
	},
	[236] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 65,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.PandoraBox.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 1085.2,
				name = "[MuAiNelee]真言",
				timelineIndex = 236,
				timerOffset = -10,
				uuid = "b92efb1b-2876-3b5b-b2ae-fe6fb5820d13",
				version = 2,
			},
			inheritedIndex = 2,
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"c5845ee0-300a-94d6-a1be-14318194e30e",
									true,
								},
								
								{
									"9cb86957-5df0-b4e9-b961-ee7f03011f52",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade2.Target == true",
							name = "FulgentBlade2.Target",
							uuid = "c5845ee0-300a-94d6-a1be-14318194e30e",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "9cb86957-5df0-b4e9-b961-ee7f03011f52",
							version = 2,
						},
					},
				},
				mechanicTime = 1097.4,
				name = "[MuAiMelee]牵制",
				timelineIndex = 237,
				timerOffset = -14,
				uuid = "3be07b8b-33b5-2a20-86ff-96a4225e7375",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing1.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 1097.4,
				name = "[MuAiNelee]真言",
				timelineIndex = 237,
				timerOffset = -14,
				uuid = "a9590dcd-6289-b182-ae92-2ec656221e67",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"22a2a88e-5446-3b7c-b6f8-9aa4ec9479a1",
									true,
								},
								
								{
									"71864281-9156-68b7-a3dc-482c4b45ccb1",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn2.Target == true",
							name = "AkhMorn2.Target",
							uuid = "22a2a88e-5446-3b7c-b6f8-9aa4ec9479a1",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "71864281-9156-68b7-a3dc-482c4b45ccb1",
							version = 2,
						},
					},
				},
				mechanicTime = 1124,
				name = "[MuAiMelee]牵制",
				timelineIndex = 243,
				timerOffset = -14,
				uuid = "14e04509-02fb-d603-adbe-3505fe67afbb",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn2.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 1124,
				name = "[MuAiNelee]真言",
				timelineIndex = 243,
				timerOffset = -14,
				uuid = "0df74273-f11f-ae5a-8dda-aad0f76d1567",
				version = 2,
			},
		},
	},
	[260] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"34875641-b779-dac7-b18e-7e70815dd9f2",
									true,
								},
								
								{
									"433848fd-c4ad-f82f-8266-d7c64338f03a",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing2.Target == true",
							name = "Polarizing2.Target",
							uuid = "34875641-b779-dac7-b18e-7e70815dd9f2",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "433848fd-c4ad-f82f-8266-d7c64338f03a",
							version = 2,
						},
					},
				},
				mechanicTime = 1177,
				name = "[MuAiMelee]牵制",
				timelineIndex = 260,
				timerOffset = -14,
				uuid = "cf443ed8-ce9a-65f9-ab39-d5287d7d9962",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing2.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 1177,
				name = "[MuAiNelee]真言",
				timelineIndex = 260,
				timerOffset = -14,
				uuid = "ed71d4a0-cac0-f124-8967-affd1139dfac",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"4f680ce4-6562-d6dd-bfff-0fba03e6d75a",
									true,
								},
								
								{
									"2e6d2d2b-92c3-228e-8d04-d0aa4308f094",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade3.Target == true",
							name = "FulgentBlade3.Target",
							uuid = "4f680ce4-6562-d6dd-bfff-0fba03e6d75a",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "2e6d2d2b-92c3-228e-8d04-d0aa4308f094",
							version = 2,
						},
					},
				},
				mechanicTime = 1187.6,
				name = "牵制",
				timelineIndex = 262,
				timerOffset = -14,
				uuid = "da2a1f15-85d6-3338-8cfb-42f8c0eac65a",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade3.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 1187.6,
				name = "[MuAiNelee]真言",
				timelineIndex = 262,
				timerOffset = -14,
				uuid = "b0fbe296-90c7-1011-997c-f73b24f79b91",
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
							actionID = 7549,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"1071cd63-8dc9-a8b4-892b-1388f14795dd",
									true,
								},
								
								{
									"ec961e6f-5b53-212d-a118-bcb117389089",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_CD",
							targetType = "Current Target",
							uuid = "3f434f17-a6c0-52cb-b4b6-905b8962a6a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn3.Target == true",
							name = "AkhMorn3.Target",
							uuid = "1071cd63-8dc9-a8b4-892b-1388f14795dd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7549,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "牵制CD",
							uuid = "ec961e6f-5b53-212d-a118-bcb117389089",
							version = 2,
						},
					},
				},
				mechanicTime = 1214.2,
				name = "[MuAiMelee]牵制",
				timelineIndex = 268,
				timerOffset = -14,
				uuid = "23b47bf2-b1bc-e871-8e9f-8520f362373c",
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
							actionID = 65,
							conditions = 
							{
								
								{
									"5651b981-09d5-5339-94ad-d8b91d4054bd",
									true,
								},
								
								{
									"1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
									true,
								},
								
								{
									"ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
									true,
								},
							},
							gVar = "ACR_RikuMNK3_CD",
							uuid = "273c7be2-b1f2-ddd9-8df9-c2363fa58a49",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn3.Field == true",
							name = "检查设置",
							uuid = "5651b981-09d5-5339-94ad-d8b91d4054bd",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							name = "武僧",
							uuid = "1f4ff2cd-6bb3-0fd5-afce-5fd00f56f67c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 65,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "真言CD",
							uuid = "ebf6124d-10b2-73b6-bafd-ff9b759b2af7",
							version = 2,
						},
					},
				},
				mechanicTime = 1214.2,
				name = "[MuAiNelee]真言",
				timelineIndex = 268,
				timerOffset = -14,
				uuid = "197e3250-27a2-37a1-a4ef-8d19b65d0f4b",
				version = 2,
			},
			inheritedIndex = 2,
		},
	},
	[272] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							actionID = 4243,
							allowInterrupt = true,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "NINJA",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB2 == true",
							name = "自动极限技",
							uuid = "f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1243.9,
				name = "自动极限技-忍者",
				timeRange = true,
				timelineIndex = 272,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -15,
				uuid = "d2cb66ef-9625-7d99-af12-5e450ed4d389",
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
							actionID = 202,
							allowInterrupt = true,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"182d14da-c06d-402b-aee5-06d15adc7575",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MONK",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB2 == true",
							name = "自动极限技",
							uuid = "182d14da-c06d-402b-aee5-06d15adc7575",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1243.9,
				name = "自动极限技-武僧",
				timeRange = true,
				timelineIndex = 272,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -15,
				uuid = "9b2fefe6-7060-7b16-9948-2c09f2daa11d",
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
							actionID = 4242,
							allowInterrupt = true,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"182d14da-c06d-402b-aee5-06d15adc7575",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "DRAGOON",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB2 == true",
							name = "自动极限技",
							uuid = "182d14da-c06d-402b-aee5-06d15adc7575",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1243.9,
				name = "自动极限技-龙骑",
				timeRange = true,
				timelineIndex = 272,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -15,
				uuid = "23b4fedd-d5b8-5699-9391-adc507ae5817",
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
							actionID = 24858,
							allowInterrupt = true,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"182d14da-c06d-402b-aee5-06d15adc7575",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "REAPER",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB2 == true",
							name = "自动极限技",
							uuid = "182d14da-c06d-402b-aee5-06d15adc7575",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1243.9,
				name = "自动极限技-镰刀",
				timeRange = true,
				timelineIndex = 272,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -15,
				uuid = "ebbccee0-a767-54ba-b783-33713ec9c81b",
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
							actionID = 34866,
							allowInterrupt = true,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "VIPER",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
						inheritedIndex = 2,
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB2 == true",
							name = "自动极限技",
							uuid = "f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1243.9,
				name = "自动极限技-蝰蛇",
				timeRange = true,
				timelineIndex = 272,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -15,
				uuid = "6d4532a6-ff4c-59c9-b6c9-b99e56ac5aea",
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
							actionID = 7861,
							allowInterrupt = true,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"f3d5e820-9518-e76d-b615-05eaef8f0c2d",
									true,
								},
								
								{
									"f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
									true,
								},
								
								{
									"73bb0f5f-076b-85ad-b172-7a6c18a41f61",
									true,
								},
							},
							gVar = "ACR_RikuNIN3_Hotbar_LimitBreak",
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "a89e102e-8e99-af11-b97a-e7cb511dec72",
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
							conditionLua = "local clb,mlb = TensorCore.getLBGauge()\nreturn clb >= 30000",
							name = "LB已满",
							uuid = "73bb0f5f-076b-85ad-b172-7a6c18a41f61",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "SAMURAI",
							uuid = "f3d5e820-9518-e76d-b615-05eaef8f0c2d",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AutoLB2 == true",
							name = "自动极限技",
							uuid = "f4ed3d0c-4be9-01ad-b5af-132da7a8f631",
							version = 2,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1243.9,
				name = "自动极限技-武士",
				timeRange = true,
				timelineIndex = 272,
				timerEndOffset = 15,
				timerOffset = -10,
				timerStartOffset = -15,
				uuid = "84d691f8-3e7d-e23c-8402-d39aed66881b",
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