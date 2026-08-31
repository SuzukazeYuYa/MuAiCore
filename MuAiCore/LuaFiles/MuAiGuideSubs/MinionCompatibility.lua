local Compatibility = {}

local function validString(value)
    return type(value) == 'string' and value ~= ''
end

local function normalizeWindowsPath(path)
    if not validString(path) then
        return nil
    end
    local normalized = path:gsub('/', '\\'):gsub('\\+$', '')
    for segment in normalized:gmatch('[^\\]+') do
        if segment == '.' or segment == '..' then
            return nil
        end
    end
    return normalized
end

local function validateDeleteTarget(path)
    if type(GetStartupPath) ~= 'function' then
        return nil, 'GetStartupPath is unavailable'
    end

    local target = normalizeWindowsPath(path)
    local startupRoot = normalizeWindowsPath(GetStartupPath())
    if target == nil or startupRoot == nil then
        return nil, 'folder path is invalid'
    end

    local targetLower = target:lower()
    local startupLower = startupRoot:lower()
    if targetLower:sub(1, #startupLower + 1) ~= startupLower .. '\\' then
        return nil, 'folder path is outside the Minion startup directory'
    end
    return target
end

local function powerShellLiteral(value)
    return "'" .. value:gsub("'", "''") .. "'"
end

local function deleteFolderWithPowerShell(path)
    local target, validationError = validateDeleteTarget(path)
    if target == nil then
        return false, validationError
    end
    if type(io) ~= 'table' or type(io.popen) ~= 'function' then
        return false, 'io.popen is unavailable'
    end

    local successToken = '__MUAI_FOLDER_DELETE_OK__'
    local literal = powerShellLiteral(target)
    local command = 'powershell.exe -NoProfile -NonInteractive -Command "try { '
            .. 'if (Test-Path -LiteralPath ' .. literal .. ') { '
            .. 'Remove-Item -LiteralPath ' .. literal .. ' -Recurse -Force -ErrorAction Stop }; '
            .. "Write-Output '" .. successToken .. "' } catch { Write-Error $_; exit 1 }\""
    local handle = io.popen(command .. ' 2>&1')
    if handle == nil then
        return false, 'failed to start PowerShell'
    end
    local output = handle:read('*a') or ''
    handle:close()
    if output:find(successToken, 1, true) ~= nil then
        return true
    end
    return false, output ~= '' and output or 'PowerShell did not confirm folder deletion'
end

Compatibility.deleteFolder = function(path)
    if type(FolderDelete) == 'function' then
        return FolderDelete(path)
    end
    return deleteFolderWithPowerShell(path)
end

local function displayName(name)
    if type(GetString) == 'function' then
        local translated = GetString(name)
        if validString(translated) then
            return translated
        end
    end
    return name
end

local function createTabs(tabNames, doTranslate)
    local tabControl = {
        options = {},
        events = {
            onChange = function() end,
            onClick = function() end,
        },
        tabs = {},
    }

    if not validString(tabNames) then
        return tabControl
    end

    for rawName in tabNames:gmatch('[^,]+') do
        local name = rawName
        if doTranslate == true then
            name = displayName(rawName)
        end
        if validString(name) then
            tabControl.tabs[#tabControl.tabs + 1] = {
                onClick = function() end,
                isselected = #tabControl.tabs == 0,
                ishovered = false,
                selected = { name = name, r = .96, g = .15, b = .20, a = 1 },
                hovered = { name = name, r = .89, g = .70, b = .70, a = 1 },
                normal = { name = name, r = 1, g = 1, b = 1, a = 1 },
            }
        end
    end
    return tabControl
end

local function drawTabLabel(color)
    local name = displayName(color.name)
    if color.r > 1 or color.g > 1 or color.b > 1 then
        GUI:TextColored(GUI:ColorConvertRGBtoHSV(color.r, color.g, color.b), color.a, name)
    else
        GUI:TextColored(color.r, color.g, color.b, color.a, name)
    end
    return name
end

local function drawTabs(tabControl)
    assert(type(tabControl) == 'table' and type(tabControl.tabs) == 'table',
            'GUI_DrawTabs requires a tab control created by GUI_CreateTabs')

    local returnIndex
    local returnName
    local counter = 1
    local events = type(tabControl.events) == 'table' and tabControl.events or {}
    local tabCount = #tabControl.tabs

    for index, tab in ipairs(tabControl.tabs) do
        if counter == 1 then
            GUI:AlignFirstTextHeightToWidgets()
        end

        local color = tab.normal
        if tab.isselected then
            color = tab.selected
        elseif tab.ishovered then
            color = tab.hovered
        end
        local name = drawTabLabel(color)
        if tab.isselected then
            returnIndex = index
            returnName = name
        end

        tab.ishovered = GUI:IsItemHovered()
        if tab.ishovered and GUI:IsMouseClicked(0, false) then
            if not tab.isselected and type(events.onChange) == 'function' then
                events.onChange()
            end
            if type(events.onClick) == 'function' then
                events.onClick()
            end
            if type(tab.onClick) == 'function' then
                tab.onClick()
            end
            tab.isselected = true
            for otherIndex, otherTab in ipairs(tabControl.tabs) do
                if otherIndex ~= index then
                    otherTab.isselected = false
                end
            end
        end

        counter = counter + 1
        local itemsPerLine = tonumber(tabControl.itemsPerLine) or (tabCount + 1)
        if counter <= itemsPerLine and index < tabCount then
            GUI:SameLine(0, 8)
            GUI:Text('|')
            GUI:SameLine(0, 8)
        else
            counter = 1
        end
    end

    GUI:Separator()
    GUI:Spacing()
    return returnIndex, returnName
end

Compatibility.install = function(guide)
    local installed = {}

    if type(table.contains) ~= 'function' then
        table.contains = function(target, value)
            if type(target) ~= 'table' then
                return false
            end
            for _, candidate in pairs(target) do
                if candidate == value then
                    return true
                end
            end
            return false
        end
        installed[#installed + 1] = 'table.contains'
    end

    if type(table.deepcompare) ~= 'function' then
        local function deepCompare(left, right, ignoreMetatable, compared)
            if rawequal(left, right) then
                return true
            end
            if type(left) ~= type(right) or type(left) ~= 'table' then
                return false
            end
            if ignoreMetatable ~= true and getmetatable(left) ~= getmetatable(right) then
                return false
            end

            local comparedWithLeft = compared[left]
            if comparedWithLeft ~= nil and comparedWithLeft[right] == true then
                return true
            end
            if comparedWithLeft == nil then
                comparedWithLeft = {}
                compared[left] = comparedWithLeft
            end
            comparedWithLeft[right] = true

            for key, value in pairs(left) do
                if not deepCompare(value, right[key], ignoreMetatable, compared) then
                    return false
                end
            end
            for key in pairs(right) do
                if left[key] == nil then
                    return false
                end
            end
            return true
        end

        table.deepcompare = function(left, right, ignoreMetatable)
            return deepCompare(left, right, ignoreMetatable, {})
        end
        installed[#installed + 1] = 'table.deepcompare'
    end

    if type(GUI_CreateTabs) ~= 'function' then
        GUI_CreateTabs = createTabs
        installed[#installed + 1] = 'GUI_CreateTabs'
    end

    if type(GUI_DrawTabs) ~= 'function' then
        GUI_DrawTabs = drawTabs
        installed[#installed + 1] = 'GUI_DrawTabs'
    end

    if type(guide) == 'table' and guide.DeleteFolder ~= Compatibility.deleteFolder then
        guide.DeleteFolder = Compatibility.deleteFolder
        if type(FolderDelete) ~= 'function' then
            installed[#installed + 1] = 'MuAiGuide.DeleteFolder'
        end
    end

    return installed
end

return Compatibility
