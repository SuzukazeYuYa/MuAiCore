local MenuCompatibility = {}

local memberId = 'MuAiCore'
local parentId = 'FFXIVMINION##MENU_HEADER'
local checkInterval = 1000
local lastCheckAt = 0
local MG

local function getMenuComponent()
    local uiManager = ml_gui and ml_gui.ui_mgr
    local menu = type(uiManager) == 'table' and uiManager.menu or nil
    if type(menu) ~= 'table' or type(menu.components) ~= 'table' then
        return nil
    end
    for _, component in pairs(menu.components) do
        if type(component) == 'table'
                and type(component.header) == 'table'
                and component.header.id == parentId then
            return component
        end
    end
    return nil
end

local function hasMember(members)
    for _, member in pairs(members) do
        if type(member) == 'table' and member.id == memberId then
            return true
        end
    end
    return false
end

local function isDuplicateAt(members, index)
    local member = members[index]
    local id = type(member) == 'table' and member.id or nil
    if type(id) ~= 'string' then
        return false
    end
    for earlier = 1, index - 1 do
        local previous = members[earlier]
        if type(previous) == 'table' and previous.id == id then
            return true
        end
    end
    return false
end

local function moveOwnMemberBeforeTrailingDuplicates(members)
    local ownIndex
    for index = #members, 1, -1 do
        local member = members[index]
        if type(member) == 'table' and member.id == memberId then
            ownIndex = index
            break
        end
    end
    if ownIndex == nil then
        return nil
    end

    local targetIndex = ownIndex
    while targetIndex > 1 and isDuplicateAt(members, targetIndex - 1) do
        targetIndex = targetIndex - 1
    end
    if targetIndex ~= ownIndex then
        local ownMember = table.remove(members, ownIndex)
        table.insert(members, targetIndex, ownMember)
    end
    return targetIndex
end

local function reconcileMenu()
    local uiManager = ml_gui and ml_gui.ui_mgr
    local component = getMenuComponent()
    if type(uiManager) ~= 'table'
            or type(uiManager.AddMember) ~= 'function'
            or type(component) ~= 'table'
            or type(component.members) ~= 'table' then
        return false
    end

    if hasMember(component.members) then
        return false
    end

    uiManager:AddMember({
        id = memberId,
        name = 'MuAiCore',
        onClick = function()
            if type(MuAiGuide) ~= 'table'
                    or MuAiGuide.IsInit ~= true
                    or type(MuAiGuide.MainUI) ~= 'table' then
                d('[MuAiCore]界面不可用：初始化未完成')
                return
            end
            MuAiGuide.MainUI.open = not MuAiGuide.MainUI.open
        end,
        tooltip = '暮霭指路核心功能',
        texture = GetLuaModsPath() .. 'MuAiCore\\Image\\MainIcon.png',
    }, parentId)
    local memberIndex = moveOwnMemberBeforeTrailingDuplicates(component.members)
    MG.Diagnostic('INFO', 'MenuCompatibility', '检测到菜单入口丢失，已重新注册', {
        memberId = memberId,
        parentId = parentId,
        memberIndex = memberIndex,
    }, 'menu_member_restored')
    return true
end

MenuCompatibility.init = function(M)
    MG = M
    M.CheckMenuMember = function(force)
        if force ~= true and lastCheckAt ~= 0 and TimeSince(lastCheckAt) < checkInterval then
            return false
        end
        lastCheckAt = Now()
        return reconcileMenu()
    end
end

return MenuCompatibility
