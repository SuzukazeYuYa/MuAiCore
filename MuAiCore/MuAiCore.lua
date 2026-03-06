local MuAiCore = {}
local AddonName = "MuAiCore"
local core = MuAiCore
local autoPopMap = { 1238, 1122, 1325, 1327, 1317 }
local mainDrawer, fruConfigDrawer, fruMitigationDrawer
local lastMap, lastJob, updateTime
local updateNeedReLoad = false
local lastVersion
local downloadPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\"
local raidScript, currentScript
local register = {}
local registerOK = false
local wipeTime = 0

--- 开始读条事件
local OnEntityChannel = function(entityID, spellID, targetID, channelTimeMax)
	if currentScript ~= nil and currentScript.OnEntityChannel ~= nil then
		currentScript.OnEntityChannel(entityID, spellID, targetID, channelTimeMax)
	end
end

--- 添加标记时间事件
local OnMarkerAdd = function(entityID, markerID)
	if currentScript ~= nil and currentScript.OnMarkerAdd ~= nil then
		currentScript.OnMarkerAdd(entityID, markerID)
	end
end
--- 注册AOE生成
local OnAOECreate = function(aoeInfo)
	if currentScript ~= nil and currentScript.OnAOECreate ~= nil then
		currentScript.OnAOECreate(aoeInfo)
	end
end

--- 注册阿古斯
local registerArgus = function()
	if Argus == nil then
		register = nil
		return
	else
		register = {}
	end
	if Argus.registerOnEntityChannel ~= nil and not register["OnEntityChannel"] then
		Argus.registerOnEntityChannel(OnEntityChannel)
		register["OnEntityChannel"] = true
	else
		register["OnEntityChannel"] = false
	end
	if Argus.registerOnMarkerAdd ~= nil and not register["OnMarkerAdd"] then
		Argus.registerOnMarkerAdd(OnMarkerAdd)
		register["OnMarkerAdd"] = true
	else
		register["OnMarkerAdd"] = false
	end
	if Argus.registerOnAOECreateFunc ~= nil and not register["OnAOECreate"] then
		Argus.registerOnAOECreateFunc(OnAOECreate)
		register["OnAOECreate"] = true
	else
		register["OnAOECreate"] = false
	end
end

local checkArgusRegister = function()
	if registerOK then
		return
	end
	if register == nil then
		registerArgus()
		return
	end
	local hasNotRegister = false
	for _, state in pairs(register) do
		if not state then
			hasNotRegister = true
			break
		end
	end
	if hasNotRegister then
		registerArgus()
	else
		registerOK = true
		MuAiGuide.Debug("所有事件函数注册完成")
	end
end

--- 读取副本脚本
local LoadScripts = function()
	raidScript = {}
	local folderPath = MuAiGuideRoot .. "Scripts"
	local list = FolderList(folderPath)
	for _, fileName in pairs(list) do
		MuAiGuide.Debug("已加载副本脚本：" .. fileName)
		local filePath = folderPath .. "\\" .. fileName
		local script = FileLoad(filePath)
		if script ~= nil then
			raidScript[script.MapId] = script
		end
	end
	if currentScript ~= nil and raidScript[Player.localmapid] ~= nil then
		currentScript = raidScript[Player.localmapid]
	end
end

local isDrawBlackListOn = function()
	return MuAiGuide.Config.Main.DrawBlackListEnable
			and MuAiGuide.Config.Main.DrawBlackList
			and table.size(MuAiGuide.Config.Main.DrawBlackList) > 0
end

--- 绘图黑名单控制
local disableDrawCheck = function()
	if MoogleTelegraphs == nil or MoogleTelegraphs.Settings == nil then
		return
	end
	if isDrawBlackListOn() then
		if lastMap ~= Player.localmapid then
			if table.contains(MuAiGuide.Config.Main.DrawBlackList, Player.localmapid) then
				MuAiGuide.Info("进入绘制黑名单区域，MoogleTelegraphs的[敌人范围]已关闭。")
				MoogleTelegraphs.Settings.DrawEnemyAoE = false
			elseif table.contains(MuAiGuide.Config.Main.DrawBlackList, lastMap) then
				MuAiGuide.Info("离开绘制黑名单区域，MoogleTelegraphs的[敌人范围]已开启。")
				MoogleTelegraphs.Settings.DrawEnemyAoE = true
			end
		end
	end
end

local attackRangeHackHelper = function()
	if Player == nil or (not MuAiGuide.Config.Main.AttackRangeHelper)
			or MuAiGuide.Config.Main.AtkRangeData == nil or table.size(MuAiGuide.Config.Main.AtkRangeData) == 0 then
		return
	end
	local mapData = MuAiGuide.Config.Main.AtkRangeData[Player.localmapid]
	if mapData == nil then
		return
	end
	local curTarget = TensorCore.mGetTarget()
	if curTarget == nil then
		return
	end
	local bossInfo = mapData[curTarget.contentid]
	if bossInfo == nil then
		return
	end
	local curDistance = TensorCore.getDistance2d(Player.pos, curTarget.pos)
	local hitRange
	if type(bossInfo) == "number" then
		hitRange = bossInfo
	elseif type(bossInfo) == "table" then
		if bossInfo.buff == nil then
			return
		end
		if TensorCore.hasBuff(curTarget.id, bossInfo.buff) then
			hitRange = bossInfo.onBuffRange
		else
			hitRange = bossInfo.range
		end
	end
	local deltaDistance = curDistance - hitRange
	local alpha, color
	local radius
	local maxRange
	if (not MuAiGuide.IsTank(Player.job)) and (not MuAiGuide.IsMelee(Player.job)) then
		maxRange = 25.5
	else
		maxRange = 3.5
	end
	radius = hitRange + maxRange
	local minRange = maxRange - 1.5
	if deltaDistance >= maxRange then
		alpha = MuAiGuide.Config.Main.OutRangeColor.a
		color = MuAiGuide.Config.Main.OutRangeColor
	elseif deltaDistance >= minRange then
		local sub = deltaDistance - minRange
		if sub < 1 then
			alpha = MuAiGuide.Config.Main.InRangeColor.a * sub
		else
			alpha = MuAiGuide.Config.Main.InRangeColor.a
		end
		color = MuAiGuide.Config.Main.InRangeColor
	else
		return
	end
	local drawer = Argus2.ShapeDrawer:new(
			(GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
			(GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
			(GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
			(GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, alpha)),
			MuAiGuide.Config.Main.LineSize
	)
	drawer:addCircle(curTarget.pos.x, curTarget.pos.y, curTarget.pos.z, radius)
end

local attackRangeReMake = function()
	if not MuAiGuide.Config.Main.AttackRangeReplace
			or MoogleTelegraphs == nil or MoogleTelegraphs.Settings == nil
			or Player == nil
	then
		return
	end
	local curTarget = TensorCore.mGetTarget()
	if curTarget == nil or not curTarget.attackable or curTarget.type == 1 then
		return
	end
	MoogleTelegraphs.Settings.DrawAttackRange = false
	local curDistance = TensorCore.getDistance2d(Player.pos, curTarget.pos)
	local hitRange = curTarget.hitRadius
	local deltaDistance = curDistance - hitRange
	local alpha, color
	local radius
	local maxRange
	if (not MuAiGuide.IsTank(Player.job)) and (not MuAiGuide.IsMelee(Player.job)) then
		maxRange = 25.5
	else
		maxRange = 3.5
	end
	radius = hitRange + maxRange
	local minRange = maxRange - 1.5
	local inSideColor = MoogleTelegraphs.Settings.outlineRGB.rangeInside
	local outSideColor = MoogleTelegraphs.Settings.outlineRGB.rangeOutside
	if MoogleTelegraphs.Settings.AlwaysShowAttackRange then
		if deltaDistance >= maxRange then
			alpha = outSideColor.a
			color = outSideColor
		else
			alpha = inSideColor.a
			color = inSideColor
		end
	else
		if deltaDistance >= maxRange then
			alpha = outSideColor.a
			color = outSideColor
		elseif deltaDistance >= minRange then
			local sub = deltaDistance - minRange
			if sub < 1 then
				alpha = inSideColor.a * sub
			else
				alpha = inSideColor.a
			end
			color = inSideColor
		else
			return
		end
	end
	local drawer = Argus2.ShapeDrawer:new(
			(GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
			(GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
			(GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
			(GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, alpha)),
			MoogleTelegraphs.Settings.outlineThickness.range
	)
	drawer:addCircle(curTarget.pos.x, curTarget.pos.y, curTarget.pos.z, radius)
end

local onMapChange = function()
	MuAiGuide.Party = nil
	MuAiGuide.SelfPos = nil
	if table.contains(autoPopMap, Player.localmapid) then
		if MuAiGuide.UI.open == false then
			MuAiGuide.UI.open = true
		end
		MuAiGuide.LoadParty()
		if MuAiGuide.UI.tabs ~= nil then
			for i = 1, 6 do
				MuAiGuide.UI.tabs.tabs[i].isselected = i == 1
			end
		end
	else
		MuAiGuide.UI.open = false
	end

	if raidScript[Player.localmapid] ~= nil then
		-- 进入副本
		currentScript = raidScript[Player.localmapid]
	else
		-- 退出副本
		currentScript = nil
	end

	if isDrawBlackListOn()
			and not table.contains(MuAiGuide.Config.Main.DrawBlackList, Player.localmapid)
			and MoogleTelegraphs and MoogleTelegraphs.Settings and MoogleTelegraphs.Settings.DrawEnemyAoE == false
	then
		MoogleTelegraphs.Settings.DrawEnemyAoE = true
		MuAiGuide.Info("当前已由MuAiGuide管理莫古力敌人范围开关，检测MoogleTelegraphs的[敌人范围]被关闭，已将其恢复到开启状态。")
	end
end

local checkNeedReload = function()
	if updateNeedReLoad and updateTime then
		if TimeSince(updateTime) > 2000 then
			updateNeedReLoad = false
			if MuAiGuide.UI.open then
				MuAiGuide.UI.open = false
				MuAiGuide.FruConfigUI.open = false
				MuAiGuide.FruMitigationUI.open = false
				mainDrawer = FileLoad(MuAiGuideRoot .. "MainUI.lua")
				fruConfigDrawer = FileLoad(MuAiGuideRoot .. "FruConfigUI.lua")
				fruMitigationDrawer = FileLoad(MuAiGuideRoot .. "FruMitigationUI.lua")

			end
			core.InitMuAiGuide()
			if lastVersion ~= MuAiGuide.VERSION then
				lastVersion = MuAiGuide.VERSION
				MuAiGuide.Info("MuAiCore已更新，当前版本：ver." .. MuAiGuide.VERSION)
			end
		end
	end
end

local onRaidUpdate = function()
	if raidScript and raidScript[Player.localmapid] then
		raidScript[Player.localmapid].Update()
		if currentScript == nil then
			currentScript = raidScript[Player.localmapid]
		end
	end
end

local onPlayerChangeJob = function()
	if MuAiGuide and MuAiGuide.Config and MuAiGuide.FruMitigation then
		MuAiGuide.FruMitigation.ChangeJob()
	end
end

local onWipeCheck = function()
	if not MuAiGuide or not MuAiGuide.Party or table.size(MuAiGuide.Party) ~= 4 and table.size(MuAiGuide.Party) ~= 8 then
		return
	end
	local partyCnt = table.size(MuAiGuide.Party)
	local deadCnt = 0
	local outComBatCnt = 0
	for _, ent in pairs(MuAiGuide.Party) do
		local curEnt = TensorCore.mGetEntity(ent.id)
		if curEnt == nil then
			return
		end
		if not curEnt.alive then
			deadCnt = deadCnt + 1
		elseif not curEnt.incombat then
			outComBatCnt = outComBatCnt + 1
		end
	end
	if deadCnt >= partyCnt
			or (deadCnt > 0 and outComBatCnt > 0 and deadCnt + outComBatCnt > partyCnt) then
		if currentScript ~= nil then
			currentScript.OnWipe()
		end
		--MuAiGuide.Debug("团灭")
		wipeTime = Now()
	end
end

local checkHotKeyPress = function()
	if MuAiGuide and MuAiGuide.Config
			and GUI:IsKeyDown(MuAiGuide.Config.Main.KeyBindFirst)
			and GUI:IsKeyPressed(MuAiGuide.Config.Main.KeyBindSecond)
	then
		MuAiGuide.UI.open = not MuAiGuide.UI.open
	end
end
local checkMuAiGuide = function()
	if MuAiGuide == nil then
		core.InitMuAiGuide()
	end
end

ReloadMuAiGuide = function()
	MuAiGuide = nil
	core.InitMuAiGuide()
end

ReloadMuAiScripts = function()
	LoadScripts()
end

core.InitMuAiGuide = function(checkUpdate)
	MuAiGuideRoot = GetLuaModsPath() .. "MuAiCore\\LuaFiles\\"
	MuAiGuide = FileLoad(MuAiGuideRoot .. "MuAiGuide.lua")
	local configDef = FileLoad(MuAiGuideRoot .. "FruOneKeyConfigs.lua")
	configDef(MuAiGuide)
	local mitigationDef = FileLoad(MuAiGuideRoot .. "FruMitigation.lua")
	mitigationDef(MuAiGuide)
	MuAiGuide.InitConfig()
	MuAiGuide.FruMitigation.ChangeJob()
	MuAiGuide.ForceUpdate = function()
		core.ForceUpdate()
	end
	if checkUpdate and MuAiGuide.Config.Main.AutoUpdate then
		core.ForceUpdate()
	end
	if FolderExists(downloadPath) then
		FolderDelete(downloadPath)
	end
	LoadScripts()
	registerArgus()
	MuAiGuide.checkVersion(true)
end

core.DrawMainUI = function()
	if mainDrawer == nil or MuAiGuide.DevelopMode then
		mainDrawer = FileLoad(MuAiGuideRoot .. "MainUI.lua")
	end
	mainDrawer(MuAiGuide)
end

core.DrawFriConfigUI = function()
	if fruConfigDrawer == nil or MuAiGuide.DevelopMode then
		fruConfigDrawer = FileLoad(MuAiGuideRoot .. "FruConfigUI.lua")
	end
	fruConfigDrawer(MuAiGuide)
end

core.DrawFruMitigationUI = function()
	if fruMitigationDrawer == nil or MuAiGuide.DevelopMode then
		fruMitigationDrawer = FileLoad(MuAiGuideRoot .. "FruMitigationUI.lua")
	end
	fruMitigationDrawer(MuAiGuide)
end

core.Initialize = function()
	core.InitMuAiGuide(true)
	lastVersion = MuAiGuide.VERSION
	local Icon = GetLuaModsPath() .. "MuAiCore\\Image\\MainIcon.png"
	local tooltip = "暮霭指路核心功能"
	ml_gui.ui_mgr:AddMember({ id = "MuAiCore", name = "MuAiGuide", onClick = function()
		MuAiGuide.UI.open = not MuAiGuide.UI.open
	end, tooltip = tooltip, texture = Icon }, "FFXIVMINION##MENU_HEADER")
end
core.Update = function()
	checkMuAiGuide()
	checkArgusRegister()
	checkHotKeyPress()
	disableDrawCheck()
	onWipeCheck()
	if lastMap ~= Player.localmapid then
		onMapChange()
		lastMap = Player.localmapid
	end
	if lastJob ~= Player.job then
		onPlayerChangeJob()
		lastJob = Player.job
	end
	onRaidUpdate()
	checkNeedReload()
end

core.Draw = function()
	if MuAiGuide then
		if MuAiGuide.UI.open then
			core.DrawMainUI()
		end
		if MuAiGuide.FruConfigUI.open then
			core.DrawFriConfigUI()
		end
		if MuAiGuide.FruMitigationUI.open and not MuAiGuide.IsHealer(Player.job) then
			core.DrawFruMitigationUI()
		end
		attackRangeHackHelper()
		attackRangeReMake()
	end
end

core.ForceUpdate = function()
	local gitZipUrl = "https://codeload.github.com/SuzukazeYuYa/MuAiCore/zip/refs/heads/main"
	local tempPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\"
	local replacePath = GetStartupPath() .. "\\LuaMods"
	--local replacePath = "D:\\LuaMods"
	local zipFilePath = tempPath .. "repository.zip"
	local extractPath = tempPath .. "Extracted"
	-- 擦屁股代码
	if FileExists(replacePath .. "\\TensorReactions\\TimelineReactions\\Jackpot") then
		FileDelete(replacePath .. "\\TensorReactions\\TimelineReactions\\Jackpot")
	end
	if FileExists(replacePath .. "\\MuAiCore\\LuaFiles\\MitigationDefault") then
		FileDelete(replacePath .. "\\MuAiCore\\LuaFiles\\MitigationDefault")
	end
	-- 执行系统命令的函数
	local function runCommand(cmd)
		local handle = io.popen(cmd)
		local result = handle:read("*a")
		handle:close()
		return result
	end

	-- 下载文件
	local function downloadFile(url, destination)
		d("[MuAiCore]正在下载文件...")
		local cmd = 'curl -L -o "' .. destination .. '" "' .. url .. '"'
		runCommand(cmd)
		d("[MuAiCore]文件下载完成: " .. destination)
	end
	updateTime = nil
	updateNeedReLoad = false
	-- 清理并创建临时目录
	FolderDelete(tempPath)
	FolderCreate(tempPath)

	-- 下载 Zip 文件
	downloadFile(gitZipUrl, zipFilePath)

	-- 检查下载是否成功
	if not io.open(zipFilePath) then
		d("下载失败，无法找到 Zip 文件。")
		return
	end

	-- 解压 Zip 文件
	runCommand('powershell -Command "Expand-Archive -Path \'' .. zipFilePath .. '\' -DestinationPath \'' .. extractPath .. '\'"')
	d("[MuAiCore]解压完成，开始替换更新文件...")
	local exPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\Extracted\\MuAiCore-main"
	local excludeFiles = {
		".gitignore",
		"README.md"
	}
	-- 检查文件名是否需要排除
	function isExcluded(fileName)
		for _, excluded in ipairs(excludeFiles) do
			if fileName == excluded then
				return true
			end
		end
		return false
	end

	function copyFiles(srcFolder, destFolder)
		-- 列出源文件夹中的所有文件和子文件夹
		local filesInSrc = FolderList(srcFolder, [[.*]], true)
		-- 遍历文件列表
		for _, fileName in ipairs(filesInSrc) do
			-- 如果当前文件需要排除，则跳过
			if not isExcluded(fileName) then
				-- 获取源文件的完整路径
				local srcFile = srcFolder .. "\\" .. fileName
				local destFile = destFolder .. "\\" .. fileName

				-- 如果是文件夹
				if FolderExists(srcFile) then
					-- 如果目标文件夹不存在，创建它
					if not FolderExists(destFile) then
						FolderCreate(destFile)
					end

					-- 递归复制该子文件夹中的内容
					copyFiles(srcFile, destFile)  -- 递归调用
					-- 如果是文件
				elseif FileExists(srcFile) then
					-- 确保目标文件夹存在
					local destFolderPath = string.match(destFile, "^(.*[\\/])")  -- 获取文件夹路径
					if not FolderExists(destFolderPath) then
						FolderCreate(destFolderPath)
					end
					-- 如果目标文件存在，比较文件内容
					if FileExists(destFile) then
						d("[MuAiCore]更新：" .. destFile)
					else
						d("[MuAiCore]新增：" .. destFile)
					end
					runCommand("copy /Y " .. srcFile .. " " .. destFile)
				end
			end
		end
	end
	copyFiles(exPath, replacePath)
	-- 清理临时目录
	updateTime = Now()
	updateNeedReLoad = true
end

RegisterEventHandler("Module.Initalize", core.Initialize, AddonName)
RegisterEventHandler("Gameloop.Update", core.Update, AddonName)
RegisterEventHandler("Gameloop.Draw", core.Draw, AddonName)
d("[MuAiCore]加载成功!")