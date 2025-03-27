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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"b2e9f059-d619-667f-a2a3-bca253ea857b",
									true,
								},
								
								{
									"2a49d79f-ed8b-a5be-9890-deabf39e4136",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "2a49d79f-ed8b-a5be-9890-deabf39e4136",
							version = 2,
						},
					},
				},
				mechanicTime = 16.4,
				name = "[MuAiMagic]混乱",
				timelineIndex = 4,
				timerOffset = -14,
				uuid = "c9d33fea-30c0-dec1-8960-b9dc5a722005",
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
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinsMite.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 16.4,
				name = "[MuAiMagic]抗死",
				timelineIndex = 4,
				timerOffset = -9,
				uuid = "6586f59e-d7bb-ced1-aab2-21e7157e40e9",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinsMite.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 16.4,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 4,
				timerOffset = -8,
				uuid = "cc23f699-96e8-50da-b860-739b79ac1732",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinsMite.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 16.4,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 4,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "5405712c-ea67-d923-abff-bef31ba3bd21",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"46f0e862-a7ce-7c1f-b515-efd97db74451",
									true,
								},
								
								{
									"2a6e3827-e456-492e-82fd-f574455d07e8",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory1.Target == true",
							name = "BurnishedGlory1.Target",
							uuid = "46f0e862-a7ce-7c1f-b515-efd97db74451",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "2a6e3827-e456-492e-82fd-f574455d07e8",
							version = 2,
						},
					},
				},
				mechanicTime = 85.9,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"20715484-8aef-55d6-9d3f-a7882f3ee3e4",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory1.Field == true",
							name = "检查设置",
							uuid = "20715484-8aef-55d6-9d3f-a7882f3ee3e4",
							version = 2,
						},
					},
				},
				mechanicTime = 85.9,
				name = "[MuAiMagic]抗死",
				timelineIndex = 22,
				timerOffset = -9,
				uuid = "6a167f83-613d-30cb-94cc-9708ee4cbb97",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory1.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 85.9,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 22,
				timerOffset = -6,
				uuid = "40b95bfd-ff3e-e19c-92d9-e5ca5d80f842",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory1.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 85.9,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 22,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "1b45a6cb-92df-a7ea-886a-6352ea9e44d9",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"84bbd260-0598-ac82-88cb-78f69540edd3",
									true,
								},
								
								{
									"97e8bdc9-92c6-54cd-b015-ffa83cea7044",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory2.Target == true",
							name = "BurnishedGlory2.Target",
							uuid = "84bbd260-0598-ac82-88cb-78f69540edd3",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "97e8bdc9-92c6-54cd-b015-ffa83cea7044",
							version = 2,
						},
					},
				},
				mechanicTime = 121.1,
				name = "[MuAiMagic]混乱",
				timelineIndex = 29,
				timerOffset = -14,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"e7527478-152b-a69d-9bdf-eb1d5f353aba",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory2.Field == true",
							name = "检查设置",
							uuid = "e7527478-152b-a69d-9bdf-eb1d5f353aba",
							version = 2,
						},
					},
				},
				mechanicTime = 121.1,
				name = "[MuAiMagic]抗死",
				timelineIndex = 29,
				timerOffset = -9,
				uuid = "916dfd00-8523-549e-a58e-9bcc5d8c3b2d",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 121.1,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 29,
				timerOffset = -6,
				uuid = "648b8f30-0458-904e-991e-ed9acff7a1dd",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.BurnishedGlory2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 121.1,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 29,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "a2c7c70a-f35c-9ed5-ba09-4e6283939673",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"56c55a7a-791d-6c84-aace-b5e0ac096367",
									true,
								},
								
								{
									"35ab839c-c673-7100-8c86-1dff89535e08",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "35ab839c-c673-7100-8c86-1dff89535e08",
							version = 2,
						},
					},
				},
				mechanicTime = 235.3,
				name = "[MuAiMagic]混乱",
				timelineIndex = 44,
				timerOffset = -14,
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"5ced99c2-64d4-f93f-9955-5de17c82aa93",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DiamondDust.Field == true",
							name = "检查设置",
							uuid = "5ced99c2-64d4-f93f-9955-5de17c82aa93",
							version = 2,
						},
					},
				},
				mechanicTime = 235.3,
				name = "[MuAiMagic]抗死",
				timelineIndex = 44,
				timerOffset = -9,
				uuid = "6dfc4862-e924-398a-80e5-e9f28ec29e9d",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DiamondDust.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 235.3,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 44,
				timerOffset = -8,
				uuid = "f6636b15-d718-28ac-9493-d3999de45426",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DiamondDust.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 235.3,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "e8854e9c-f8db-d0da-ace4-0a43cf9969b9",
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
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinBound.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 259.9,
				name = "[MuAiMagic]抗死",
				timelineIndex = 57,
				timerOffset = -9.5,
				uuid = "6e293ab2-c0d5-8d61-945e-65319fdd953b",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinBound.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 259.9,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 57,
				timerOffset = -8,
				uuid = "a2502a31-079c-abdd-a630-aa400bff9e5c",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinBound.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 259.9,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 57,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "39881a9c-a54b-f60d-8bbc-0ee5992e9d03",
				version = 2,
			},
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"9290ebe7-534a-2ccd-bde2-67f263ed9e4a",
									true,
								},
								
								{
									"ae5b3651-e2a7-e8cf-aa5d-bc65028d3cb5",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "ae5b3651-e2a7-e8cf-aa5d-bc65028d3cb5",
							version = 2,
						},
					},
				},
				mechanicTime = 283,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedRay.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 283,
				name = "[MuAiMagic]抗死",
				timelineIndex = 64,
				timerOffset = -9.5,
				uuid = "57f0994e-48ef-55ab-a7ef-a8960030c682",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedRay.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 283,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 64,
				timerOffset = -8,
				uuid = "a1393aba-bc44-badd-b1af-dceb600cd563",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedRay.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 283,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 64,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "6c9d2cd9-339c-45dd-a46f-e8376bab76d9",
				version = 2,
			},
			inheritedIndex = 4,
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"18a74856-cc15-84a9-a577-7e9e0b9d2a9f",
									true,
								},
								
								{
									"04f64f2c-cc26-db03-b322-5896f3d3d7d7",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.LightRampant.Target == true",
							name = "LightRampant.Target",
							uuid = "18a74856-cc15-84a9-a577-7e9e0b9d2a9f",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "04f64f2c-cc26-db03-b322-5896f3d3d7d7",
							version = 2,
						},
					},
				},
				mechanicTime = 322.5,
				name = "[MuAiMagic]混乱",
				timelineIndex = 77,
				timerOffset = -4,
				uuid = "674f1fec-1aed-6c0b-845a-4924ca41a8c7",
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
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.LightRampant.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 322.5,
				name = "[MuAiMagic]抗死",
				timelineIndex = 77,
				timerOffset = -0.5,
				uuid = "18a56f31-e417-12f1-bca6-6041887e2df4",
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
							aType = "ACR",
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.LightRampant.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 331.8,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 80,
				timerOffset = -7,
				uuid = "5ad59c37-c973-c95a-a9b5-b1d524a77ef3",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.LightRampant.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 331.8,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "5a0afd0e-4a98-c69f-afa9-b232213967cb",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"fa258dcd-dfb9-9d3a-bb85-a1cc88d8531a",
									true,
								},
								
								{
									"c42ae2c8-4e4b-89c3-b75e-4f31982de3a9",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.HouseOfLight.Target == true\n",
							name = "HouseOfLight.Target",
							uuid = "fa258dcd-dfb9-9d3a-bb85-a1cc88d8531a",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "c42ae2c8-4e4b-89c3-b75e-4f31982de3a9",
							version = 2,
						},
					},
				},
				mechanicTime = 360.8,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HouseOfLight.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 360.8,
				name = "[MuAiMagic]抗死",
				timelineIndex = 92,
				timerOffset = -9.5,
				uuid = "e8edf6a5-b86a-efba-8688-42c6ea64e8af",
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
							aType = "ACR",
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HouseOfLight.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 368.8,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 95,
				timerOffset = -7,
				uuid = "69ae00f0-32c6-d1be-8eba-66bc0e2e5e69",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HouseOfLight.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 368.8,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 95,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "a25f2cab-7162-5b94-8466-79e90307146d",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"3d5f6e92-5e23-b79b-b819-3fb548510ddb",
									true,
								},
								
								{
									"7eeb012f-c346-3937-806c-299246ec2628",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.AbsoluteZero.Target == true",
							name = "AbsoluteZero.Target",
							uuid = "3d5f6e92-5e23-b79b-b819-3fb548510ddb",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "7eeb012f-c346-3937-806c-299246ec2628",
							version = 2,
						},
					},
				},
				mechanicTime = 388.7,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AbsoluteZero.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 388.7,
				name = "[MuAiMagic]抗死",
				timelineIndex = 100,
				timerOffset = -9.5,
				uuid = "f6e5d0b9-8c7a-34b2-b441-a2b8c94d2905",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AbsoluteZero.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 388.7,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 100,
				timerOffset = -8,
				uuid = "14f480a8-c01d-2da4-97b7-23351ab8af37",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AbsoluteZero.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 388.7,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 100,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "90236463-8f96-080e-b96d-44ee7f9557c3",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"1d866135-7019-bc3e-ad02-64d20906167a",
									true,
								},
								
								{
									"3f6fe24c-6a17-f0de-8a8a-162b3d626d61",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "3f6fe24c-6a17-f0de-8a8a-162b3d626d61",
							version = 2,
						},
					},
				},
				mechanicTime = 532.4,
				name = "[MuAiMagic]混乱",
				timelineIndex = 123,
				timerOffset = -14,
				uuid = "df206d1c-872f-a842-85b3-0602ddcc6e8f",
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
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Relativity.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 532.4,
				name = "[MuAiMagic]抗死",
				timelineIndex = 123,
				timerOffset = -9.5,
				uuid = "469bc343-56bc-3d45-ada0-8e38262f7bc3",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Relativity.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 532.4,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 123,
				timerOffset = -8,
				uuid = "03d13ce1-b2b4-0dce-8e9e-97fc007fd89c",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Relativity.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 532.4,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "8bc7ad69-538f-aa31-a2d9-e74816ae73c3",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"4bc5708a-e048-c66a-bea9-24a4e55f7fbb",
									true,
								},
								
								{
									"747e6633-4dfa-5649-a4d9-86e2594265fd",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShellCrusher.Field == true",
							name = "ShellCrusher.Field",
							uuid = "4bc5708a-e048-c66a-bea9-24a4e55f7fbb",
							version = 2,
						},
					},
					
					{
						data = 
						{
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "747e6633-4dfa-5649-a4d9-86e2594265fd",
							version = 2,
						},
					},
				},
				mechanicTime = 587.1,
				name = "[MuAiMagic]混乱",
				timelineIndex = 139,
				timerOffset = -14,
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
							aType = "Lua",
							actionLua = "return MuAiGuide.Config.FruMitigation.ShellCrusher.Field == true",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.SinBound.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 587.1,
				name = "[MuAiMagic]抗死",
				timelineIndex = 139,
				timerOffset = -9.5,
				uuid = "b90403c1-0bc1-922f-9316-b0921a626f8f",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShellCrusher.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 587.1,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 139,
				timerOffset = -5,
				uuid = "df5069d1-45eb-6842-b808-ca3a1c0fc721",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShellCrusher.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 587.1,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 139,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "00906818-8b69-b7ec-9035-e87763f912ad",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"edf8174c-fbc2-4719-a199-a98b348c8bfb",
									true,
								},
								
								{
									"42182336-46de-6fa5-be4b-a567038b6b8b",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "42182336-46de-6fa5-be4b-a567038b6b8b",
							version = 2,
						},
					},
				},
				mechanicTime = 651.2,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkWater.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 651.2,
				name = "[MuAiMagic]抗死",
				timelineIndex = 152,
				timerOffset = -9.5,
				uuid = "2c7bdfb2-b139-9509-b536-2ea1cd9e15d9",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkWater.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 651.2,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 152,
				timerOffset = -5,
				uuid = "fd8231a2-3b00-370f-91a0-74258047c9c4",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkWater.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 651.2,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 152,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "fcef3d43-1f95-cdd3-ba57-9021601a7c27",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShockwavePulsar2.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
						inheritedIndex = 2,
					},
				},
				mechanicTime = 656.4,
				name = "[MuAiMagic]抗死",
				timelineIndex = 153,
				timerOffset = -9.5,
				uuid = "7c890bc6-459a-d597-86cc-9d2c8186aa35",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShockwavePulsar2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 656.4,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 153,
				timerOffset = -4,
				uuid = "4d20c9be-efa6-af8e-ac32-84b88f359fab",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.ShockwavePulsar2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 656.4,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 153,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "38d6fd84-504c-b0eb-ab0c-ddc11cd9685f",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"b794d9cf-aea5-5ad1-b78a-55819bd653ec",
									true,
								},
								
								{
									"d2be5ca6-c1c2-191a-ad29-99d3c67678e9",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "d2be5ca6-c1c2-191a-ad29-99d3c67678e9",
							version = 2,
						},
					},
				},
				mechanicTime = 670.1,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MemorySEnd.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 670.1,
				name = "[MuAiMagic]抗死",
				timelineIndex = 154,
				timerOffset = -9.5,
				uuid = "608fc429-2fcf-5ea9-8c63-7966da018a57",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MemorySEnd.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 670.1,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 154,
				timerOffset = -3,
				uuid = "b090a3ba-72a2-9fb7-99c9-b4e7a47fd2aa",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MemorySEnd.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 670.1,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 154,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "7577aa8f-7b99-0a50-b92b-d4504d23edb6",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d3141496-a33d-6a4b-beb1-3646ba79deee",
									true,
								},
								
								{
									"7858a36a-6dd4-3b42-ad55-45d27a6cb982",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "7858a36a-6dd4-3b42-ad55-45d27a6cb982",
							version = 2,
						},
					},
				},
				mechanicTime = 738.2,
				name = "[MuAiMagic]混乱-琳",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkLitDragonSong.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 738.2,
				name = "[MuAiMagic]抗死",
				timelineIndex = 166,
				timerOffset = -9.5,
				uuid = "54de5909-40b6-b5a4-9944-9cda655b932c",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkLitDragonSong.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 738.2,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 166,
				timerOffset = -8,
				uuid = "9abfb019-06b5-2075-aebe-da2049742876",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.DarkLitDragonSong.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 738.2,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 166,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "18fc8d78-8781-fc67-b236-c660fb0db001",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d3141496-a33d-6a4b-beb1-3646ba79deee",
									true,
								},
								
								{
									"7858a36a-6dd4-3b42-ad55-45d27a6cb982",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "7858a36a-6dd4-3b42-ad55-45d27a6cb982",
							version = 2,
						},
					},
				},
				mechanicTime = 783.4,
				name = "[MuAiMagic]混乱-琳",
				timelineIndex = 176,
				timerOffset = -14,
				uuid = "8b84e4c0-d053-19a7-9cc6-32122ed0bb34",
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
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah1.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 783.4,
				name = "[MuAiMagic]抗死",
				timelineIndex = 176,
				timerOffset = -9.8999996185303,
				uuid = "c69a9129-4639-b14a-90b7-2ac900613136",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah1.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 783.4,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 176,
				timerOffset = -5,
				uuid = "8a6d412b-527f-7ae1-88b5-bf8e4c811bab",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah1.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 783.4,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 176,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "980a87b5-518a-0a77-b91b-8ec2f659003e",
				version = 2,
			},
			inheritedIndex = 4,
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"24ae3595-014b-76a2-a8e5-c0df58af3a1f",
									true,
								},
								
								{
									"0b84fd64-f2a5-970e-b0b2-7593933697c5",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "0b84fd64-f2a5-970e-b0b2-7593933697c5",
							version = 2,
						},
					},
				},
				mechanicTime = 798.9,
				name = "[MuAiMagic]混乱-盖娅",
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
							aType = "ACR",
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.CrystallizeTime.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 798.9,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 179,
				timerOffset = -9,
				uuid = "a5f44308-92dc-0f32-9a71-8552f1d3e2d2",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.CrystallizeTime.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 798.9,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "56d5fc09-0f38-8742-8352-c4d13f415601",
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
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedWings.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 845.7,
				name = "[MuAiMagic]抗死",
				timelineIndex = 198,
				timerOffset = -9,
				uuid = "3cef538c-9528-e597-adef-e0aa0638c6a1",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedWings.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 845.7,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 198,
				timerOffset = -8,
				uuid = "109effc4-4e8e-c21f-a208-5ecd10b9bb05",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							ignoreWeaveRules = true,
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.HallowedWings.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 845.7,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 198,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "c5453fc8-db28-2663-aa9b-868ee69ec4ed",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"d3141496-a33d-6a4b-beb1-3646ba79deee",
									true,
								},
								
								{
									"7858a36a-6dd4-3b42-ad55-45d27a6cb982",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "7858a36a-6dd4-3b42-ad55-45d27a6cb982",
							version = 2,
						},
					},
				},
				mechanicTime = 864.8,
				name = "[MuAiMagic]混乱-琳",
				timelineIndex = 204,
				timerOffset = -14,
				uuid = "4c77f1fd-8d06-a0c4-8f6a-bde6e28961d4",
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
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah2.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 864.8,
				name = "[MuAiMagic]抗死",
				timelineIndex = 204,
				timerOffset = -9.8999996185303,
				uuid = "9af554d7-519a-802d-be2d-fb086a60bf66",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 864.8,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 204,
				timerOffset = -5,
				uuid = "127fd08f-926e-b9ae-9e6c-96b0ba4ce6d6",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.MornAfah2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 864.8,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 204,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "1b7651b4-63d7-2d2c-9d2b-1eabd7f2e45f",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"0b6e39e4-c51f-c3ec-8807-4c9bb0ecc9d0",
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
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade1.Target == true",
							name = "FulgentBlade1.Target",
							uuid = "22d72fcf-a34c-91e1-8d0d-47edb64d71f2",
							version = 2,
						},
						inheritedIndex = 1,
					},
					
					{
						data = 
						{
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "0b6e39e4-c51f-c3ec-8807-4c9bb0ecc9d0",
							version = 2,
						},
					},
				},
				mechanicTime = 984.8,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade1.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 984.8,
				name = "[MuAiMagic]抗死",
				timelineIndex = 209,
				timerOffset = -9.8999996185303,
				uuid = "e68affc2-1c89-42e2-8830-afb8e0cf70b6",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade1.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 984.8,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 209,
				timerOffset = -8,
				uuid = "e9ab5061-764b-11ca-be19-94f0358feafc",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade1.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 984.8,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "2826878e-41f1-4462-bfa5-5b72f07c7e3f",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ef55a050-ea38-14d9-a088-9d1999054fce",
									true,
								},
								
								{
									"2f581bf6-af4a-2f0d-90f6-839b8f42a47c",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "2f581bf6-af4a-2f0d-90f6-839b8f42a47c",
							version = 2,
						},
					},
				},
				mechanicTime = 1011.4,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn1.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 1011.4,
				name = "[MuAiMagic]抗死",
				timelineIndex = 215,
				timerOffset = -9.8999996185303,
				uuid = "183413fb-ee78-1275-82a9-15e2807dacb0",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn1.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 1011.4,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 215,
				timerOffset = -8,
				uuid = "3f1ae2c2-0cdf-9039-9372-07b511c0b60f",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn1.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 1011.4,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 215,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "13b2757e-3485-321b-808a-d2595b3801b3",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ce629e9c-8242-8e07-aac4-679101994468",
									true,
								},
								
								{
									"d665d340-6cad-cb88-aeba-d9b80a4bb95a",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "d665d340-6cad-cb88-aeba-d9b80a4bb95a",
							version = 2,
						},
					},
				},
				mechanicTime = 1065.6,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing1.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 1065.6,
				name = "[MuAiMagic]抗死",
				timelineIndex = 233,
				timerOffset = -9.8999996185303,
				uuid = "cc5bec75-3b30-5b39-8065-5288978d977d",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing1.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 1065.6,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 233,
				timerOffset = -8,
				uuid = "28e768f0-4624-762b-b332-28b43ce31170",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing1.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 1065.6,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 233,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "866eb8ca-a297-6fcf-b74d-aa9f5b3b978c",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.PandoraBox.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 1085.2,
				name = "[MuAiMagic]抗死",
				timelineIndex = 236,
				timerOffset = -9.8999996185303,
				uuid = "a04f6dc5-7631-5fd8-aab1-b406b6b74d63",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.PandoraBox.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 1085.2,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 236,
				timerOffset = -8,
				uuid = "7e3e1f34-b2df-ba1a-bf18-4f300049416a",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.PandoraBox.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 1085.2,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 236,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "5c2a7ea5-c1c0-5391-b3ec-cbdd089cb78d",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"c5845ee0-300a-94d6-a1be-14318194e30e",
									true,
								},
								
								{
									"e1ebfd7e-ba38-ac0a-86da-96259d96dfaf",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "e1ebfd7e-ba38-ac0a-86da-96259d96dfaf",
							version = 2,
						},
					},
				},
				mechanicTime = 1097.4,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade2.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 1097.4,
				name = "[MuAiMagic]抗死",
				timelineIndex = 237,
				timerOffset = -9.8999996185303,
				uuid = "15b50330-8a5c-cfb9-8d67-4ad1bc2d0952",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 1097.4,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 237,
				timerOffset = -8,
				uuid = "02fecaf5-1bcb-0a89-a91d-c37ca64b2b21",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 1097.4,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 237,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "9b69179c-6c1d-74a2-a034-5405a9509a31",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"22a2a88e-5446-3b7c-b6f8-9aa4ec9479a1",
									true,
								},
								
								{
									"aa6ac8e7-75e8-1c37-9d42-884a3cc3da27",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "aa6ac8e7-75e8-1c37-9d42-884a3cc3da27",
							version = 2,
						},
					},
				},
				mechanicTime = 1124,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn2.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 1124,
				name = "[MuAiMagic]抗死",
				timelineIndex = 243,
				timerOffset = -9.8999996185303,
				uuid = "f1f31b13-7799-4483-b0cf-5d84d76e9b74",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 1124,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 243,
				timerOffset = -8,
				uuid = "a6da1a6d-4fb7-a12d-a3e4-7df9bdd21148",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 1124,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "53916818-759d-0336-8aa3-96fd1d26e9ad",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"34875641-b779-dac7-b18e-7e70815dd9f2",
									true,
								},
								
								{
									"5d22fb20-3bee-1a88-93ad-d2575c47b349",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "5d22fb20-3bee-1a88-93ad-d2575c47b349",
							version = 2,
						},
					},
				},
				mechanicTime = 1177,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing2.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 1177,
				name = "[MuAiMagic]抗死",
				timelineIndex = 260,
				timerOffset = -9.8999996185303,
				uuid = "cdea1b59-4a54-1c18-ab7c-b9cef625d628",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 1177,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 260,
				timerOffset = -8,
				uuid = "c0fb8913-b853-4ba2-8da7-c86da6b6ad18",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.Polarizing2.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 1177,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 260,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "94bd777e-c012-72cc-8f5f-aba3ded3da1e",
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"4f680ce4-6562-d6dd-bfff-0fba03e6d75a",
									true,
								},
								
								{
									"a4192fd2-ce22-7ce2-9b31-aae60a8ac226",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "a4192fd2-ce22-7ce2-9b31-aae60a8ac226",
							version = 2,
						},
					},
				},
				mechanicTime = 1187.6,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade3.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 1187.6,
				name = "[MuAiMagic]抗死",
				timelineIndex = 262,
				timerOffset = -9.8999996185303,
				uuid = "dddbf30d-08a5-9196-acb4-dfcd07e92934",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade3.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 1187.6,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 262,
				timerOffset = -8,
				uuid = "3ee86a7c-6dd9-ae7f-89cd-b421cee30045",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.FulgentBlade3.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 1187.6,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 262,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "40465361-b238-8249-9f46-5b3613ce1b20",
				version = 2,
			},
			inheritedIndex = 4,
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
							actionID = 7560,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"1071cd63-8dc9-a8b4-892b-1388f14795dd",
									true,
								},
								
								{
									"7f36a97c-c727-e95e-a265-f9a7251f64a3",
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
							actionID = 7560,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "混乱CD",
							uuid = "7f36a97c-c727-e95e-a265-f9a7251f64a3",
							version = 2,
						},
					},
				},
				mechanicTime = 1214.2,
				name = "[MuAiMagic]混乱",
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
							aType = "ACR",
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "REDMAGE",
							name = "赤魔法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn3.Field == true",
							name = "检查设置",
							uuid = "6e502bac-eb02-9fa5-84f9-f2e4683bf49c",
							version = 2,
						},
					},
				},
				mechanicTime = 1214.2,
				name = "[MuAiMagic]抗死",
				timelineIndex = 268,
				timerOffset = -9.8999996185303,
				uuid = "2d729439-da38-b48b-a911-aab5b4379cd0",
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
							actionID = 34686,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
							},
							gVar = "ACR_RikuPCT3_Hotbar_TemperaCoat",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn3.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
				},
				mechanicTime = 1214.2,
				name = "[MuAiMagic]画盾自身",
				timelineIndex = 268,
				timerOffset = -8,
				uuid = "9524dd97-aa66-3a43-83b4-65dba97ed7ac",
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
							actionID = 34686,
							atomicPriority = true,
							conditions = 
							{
								
								{
									"ad6702b7-e474-0f2e-92e5-707f67652101",
									true,
								},
								
								{
									"883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
									true,
								},
								
								{
									"3c87cdcd-8630-4901-8f86-fecac1abfe10",
									true,
								},
							},
							gVar = "ACR_RikuRDM3_Hotbar_MagickBarrier",
							uuid = "83242cd5-69ca-0914-9b91-8f9477e13c14",
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
							category = "Self",
							conditionType = 13,
							jobValue = "PICTOMANCER",
							name = "绘灵法师",
							uuid = "ad6702b7-e474-0f2e-92e5-707f67652101",
							version = 2,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return MuAiGuide.Config.FruMitigation.AkhMorn3.Field == true",
							name = "检查设置",
							uuid = "883d0cc0-9e17-8fae-9784-d1cc6cd7735c",
							version = 2,
						},
					},
					
					{
						data = 
						{
							buffID = 3686,
							category = "Self",
							name = "有盾",
							uuid = "3c87cdcd-8630-4901-8f86-fecac1abfe10",
							version = 2,
						},
					},
				},
				mechanicTime = 1214.2,
				name = "[MuAiMagic]画盾展开",
				timeRange = true,
				timelineIndex = 268,
				timerEndOffset = -1,
				timerOffset = -8,
				timerStartOffset = -10,
				uuid = "91e0ae01-099a-c32f-90ba-acf8e262e7a9",
				version = 2,
			},
			inheritedIndex = 4,
		},
	},
	inheritedProfiles = 
	{
	},
	mapID = 1238,
	version = 5,
}



return tbl