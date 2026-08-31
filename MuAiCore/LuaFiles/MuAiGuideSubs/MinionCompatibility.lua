local Compatibility = {}

local function validString(value)
    return type(value) == 'string' and value ~= ''
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

Compatibility.install = function()
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

    return installed
end

return Compatibility
