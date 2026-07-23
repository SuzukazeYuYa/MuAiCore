local DancingMadUI = {}
local wide = 350
local newCfgMode = false
local newFileName = ""
local p3MarkOrderDefault = { 'MT', 'ST', 'D1', 'D2', 'D3', 'D4', 'H1', 'H2' }
local p3MarkOrderGroupDefault = { 'T', 'D', 'H' }
local p3MarkOrderGroups = {
    T = { 'MT', 'ST' },
    D = { 'D1', 'D2', 'D3', 'D4' },
    H = { 'H1', 'H2' },
}
local p3MarkOrderRoleGroup = {
    MT = 'T',
    ST = 'T',
    D1 = 'D',
    D2 = 'D',
    D3 = 'D',
    D4 = 'D',
    H1 = 'H',
    H2 = 'H',
}
local p3MarkOrderDetailGroup = nil
local p3MarkOrderDrag = nil
local p3MarkOrderValueOffset = 90

local normalizeP3MarkOrder = function(order)
    local result, seen = {}, {}
    local function add(role)
        if role == nil then
            return
        end
        role = tostring(role)
        if role ~= '' and table.contains(MuAiGuide.JobPosName, role) and seen[role] ~= true then
            table.insert(result, role)
            seen[role] = true
        end
    end
    if type(order) == 'table' then
        for _, role in ipairs(order) do
            add(role)
        end
    end
    for _, role in ipairs(p3MarkOrderDefault) do
        add(role)
    end
    return result
end

local setP3MarkOrder = function(order)
    local M = MuAiGuide
    order = normalizeP3MarkOrder(order)
    M.Config.DmuCfg.P3.markOrderSelf = {}
    M.Config.DmuCfg.P3.markOrder = {}
    for index, role in ipairs(order) do
        M.Config.DmuCfg.P3.markOrderSelf[index] = role
        M.Config.DmuCfg.P3.markOrder[index] = role
    end
end

local getP3MarkOrderState = function(sourceOrder)
    local order = normalizeP3MarkOrder(sourceOrder)
    local groupOrder, roleOrders, seenGroups = {}, {}, {}
    for _, group in ipairs(p3MarkOrderGroupDefault) do
        roleOrders[group] = {}
    end
    for _, role in ipairs(order) do
        local group = p3MarkOrderRoleGroup[role]
        if group ~= nil then
            if seenGroups[group] ~= true then
                table.insert(groupOrder, group)
                seenGroups[group] = true
            end
            table.insert(roleOrders[group], role)
        end
    end
    for _, group in ipairs(p3MarkOrderGroupDefault) do
        if seenGroups[group] ~= true then
            table.insert(groupOrder, group)
        end
        local seenRoles = {}
        for _, role in ipairs(roleOrders[group]) do
            seenRoles[role] = true
        end
        for _, role in ipairs(p3MarkOrderGroups[group]) do
            if seenRoles[role] ~= true then
                table.insert(roleOrders[group], role)
            end
        end
    end
    return groupOrder, roleOrders
end

local buildP3MarkOrder = function(groupOrder, roleOrders)
    local result, seenGroups = {}, {}
    for _, group in ipairs(groupOrder or {}) do
        if p3MarkOrderGroups[group] ~= nil and seenGroups[group] ~= true then
            seenGroups[group] = true
            local seenRoles = {}
            for _, role in ipairs(roleOrders[group] or {}) do
                if p3MarkOrderRoleGroup[role] == group and seenRoles[role] ~= true then
                    table.insert(result, role)
                    seenRoles[role] = true
                end
            end
            for _, role in ipairs(p3MarkOrderGroups[group]) do
                if seenRoles[role] ~= true then
                    table.insert(result, role)
                end
            end
        end
    end
    for _, group in ipairs(p3MarkOrderGroupDefault) do
        if seenGroups[group] ~= true then
            for _, role in ipairs(p3MarkOrderGroups[group]) do
                table.insert(result, role)
            end
        end
    end
    return normalizeP3MarkOrder(result)
end

local moveP3MarkOrderItem = function(list, fromIndex, toIndex)
    if type(list) ~= 'table' then
        return nil
    end
    toIndex = math.floor(tonumber(toIndex) or fromIndex)
    if toIndex < 1 then
        toIndex = 1
    elseif toIndex > #list then
        toIndex = #list
    end
    if fromIndex == toIndex then
        return nil
    end
    local result = {}
    for index, value in ipairs(list) do
        result[index] = value
    end
    local item = table.remove(result, fromIndex)
    if item == nil then
        return nil
    end
    table.insert(result, toIndex, item)
    return result
end

local drawP3MarkOrderChip = function(label, id, width, tooltip)
    local clicked = GUI:Button(label .. '##' .. id, width, 22)
    local hovered = GUI:IsItemHovered(GUI.HoveredFlags_AllowWhenBlockedByPopup
            + GUI.HoveredFlags_AllowWhenBlockedByActiveItem
            + GUI.HoveredFlags_AllowWhenOverlapped)
    if tooltip ~= nil and GUI:IsItemHovered() then
        GUI:SetTooltip(tooltip)
    end
    return clicked, hovered
end

local finishP3MarkOrderDrag = function()
    if p3MarkOrderDrag ~= nil and not GUI:IsMouseDown(0) then
        p3MarkOrderDrag = nil
    end
end

local toggleP3MarkOrderDetailGroup = function(group)
    if p3MarkOrderDetailGroup == group then
        p3MarkOrderDetailGroup = nil
    else
        p3MarkOrderDetailGroup = group
    end
end

local drawP3MarkOrderEditor = function(sourceOrder)
    local M = MuAiGuide
    local groupOrder, roleOrders = getP3MarkOrderState(sourceOrder)
    local changedOrder = nil
    GUI:Dummy(12, 0)
    GUI:SameLine(0, 0)
    GUI:AlignFirstTextHeightToWidgets()
    GUI:Text(' 目标优先级')
    GUI:SameLine(102, 0)
    GUI:TextColored(0.75, 0.75, 0.75, 1, '左侧优先, 拖 H/D/T 调整, 点开细分')
    GUI:Dummy(12, 0)
    GUI:SameLine(0, 0)
    GUI:AlignFirstTextHeightToWidgets()
    GUI:Text(' 标记目标 ')
    GUI:SameLine(p3MarkOrderValueOffset, 0)
    for index, group in ipairs(groupOrder) do
        if index > 1 then
            GUI:SameLine(0, 4)
            GUI:Text('>')
            GUI:SameLine(0, 4)
        end
        local clicked, hovered = drawP3MarkOrderChip(group, 'p3MarkOrderGroup' .. group, 30,
                '按住拖动调整优先级；点击编辑 ' .. group .. ' 组内部顺序: ' .. M.StringJoin(roleOrders[group], '/'))
        if clicked == true and (p3MarkOrderDrag == nil or p3MarkOrderDrag.moved ~= true) then
            toggleP3MarkOrderDetailGroup(group)
        end
        if hovered == true and GUI:IsMouseDown(0) then
            if p3MarkOrderDrag == nil or p3MarkOrderDrag.scope ~= 'group' then
                p3MarkOrderDrag = { scope = 'group', item = group, index = index, moved = false }
            elseif p3MarkOrderDrag.item ~= group then
                local newGroupOrder = moveP3MarkOrderItem(groupOrder, p3MarkOrderDrag.index, index)
                if newGroupOrder ~= nil then
                    p3MarkOrderDrag.index = index
                    p3MarkOrderDrag.moved = true
                    groupOrder = newGroupOrder
                    changedOrder = buildP3MarkOrder(newGroupOrder, roleOrders)
                end
            end
        end
    end
    if changedOrder ~= nil then
        setP3MarkOrder(changedOrder)
        groupOrder, roleOrders = getP3MarkOrderState(changedOrder)
    end

    GUI:Dummy(12, 0)
    GUI:SameLine(p3MarkOrderValueOffset, 0)
    GUI:TextColored(0.75, 0.75, 0.75, 1, M.StringJoin(buildP3MarkOrder(groupOrder, roleOrders), '/'))

    finishP3MarkOrderDrag()
    if p3MarkOrderDetailGroup == nil or roleOrders[p3MarkOrderDetailGroup] == nil then
        return
    end

    GUI:Dummy(12, 0)
    GUI:SameLine(0, 0)
    GUI:AlignFirstTextHeightToWidgets()
    GUI:Text(p3MarkOrderDetailGroup .. ' 细分')
    GUI:SameLine(p3MarkOrderValueOffset, 0)
    local roles = roleOrders[p3MarkOrderDetailGroup]
    for index, role in ipairs(roles) do
        if index > 1 then
            GUI:SameLine(0, 4)
            GUI:Text('>')
            GUI:SameLine(0, 4)
        end
        local _, hovered = drawP3MarkOrderChip(role, 'p3MarkOrderRole' .. p3MarkOrderDetailGroup .. role, 34,
                '按住拖动调整 ' .. p3MarkOrderDetailGroup .. ' 组内部优先级')
        if hovered == true and GUI:IsMouseDown(0) then
            local scope = 'role.' .. p3MarkOrderDetailGroup
            if p3MarkOrderDrag == nil or p3MarkOrderDrag.scope ~= scope then
                p3MarkOrderDrag = { scope = scope, item = role, index = index, moved = false }
            elseif p3MarkOrderDrag.item ~= role then
                local newRoles = moveP3MarkOrderItem(roles, p3MarkOrderDrag.index, index)
                if newRoles ~= nil then
                    p3MarkOrderDrag.index = index
                    p3MarkOrderDrag.moved = true
                    roleOrders[p3MarkOrderDetailGroup] = newRoles
                    roles = newRoles
                    setP3MarkOrder(buildP3MarkOrder(groupOrder, roleOrders))
                end
            end
        end
    end
    finishP3MarkOrderDrag()
end

DancingMadUI.draw = function()
    local M = MuAiGuide
    if not M.DancingMadUI.open then
        newCfgMode = false
        return
    end
    GUI:SetNextWindowPos(M.MainUI.uiPos.x, M.MainUI.uiPos.y)
    GUI:SetNextWindowSize(wide, 0, GUI.SetCond_Appearing)
    M.DancingMadUI.visible, M.DancingMadUI.open = GUI:Begin('Dmu Setting', M.DancingMadUI.open)
    if M.DancingMadUI.visible then
        if GUI:CollapsingHeader('全局设置') then
            GUI:AlignFirstTextHeightToWidgets()
            GUI:BulletText('配置文件工具')
            GUI:SameLine(0, 60)
            GUI:Button('打开存档位置', 150, 22)
            if GUI:IsItemClicked(0) then
                local cmd = string.format('explorer "%s"', M.Config.DmuGuidePath)
                local handle = io.popen(cmd)
                if handle then
                    handle:close()
                end
            end
            if newCfgMode then
                GUI:Dummy(20, 0)
                GUI:SameLine(0, 0)
                M.UITool.AddLabel("新配置名：", false)
                GUI:PushItemWidth(200)
                local havaSame = false
                local NewFileName, NewFileNameChanged = GUI:InputText("##NewFileName", newFileName, GUI.InputTextFlags_CharsNoBlank)
                if NewFileNameChanged then
                    local fileName = NewFileName
                    if M.ContainsIgnoreCase(M.Config.DmuCustomList, fileName)
                            or string.lower(fileName) == "guideconfig"
                            or not M.IsValidConfigName(NewFileName)
                    then
                        GUI:TextColored(1, 0, 0, 1, "已存在该名称文件或者名称不合法,无法创建!")
                        havaSame = true
                    else
                        newFileName = NewFileName
                    end
                end
                GUI:PopItemWidth()
                GUI:Dummy(20, 0)
                GUI:SameLine(0, 0)
                GUI:Button("确认", 100, 20)
                if GUI:IsItemClicked(0) then
                    if not havaSame and M.IsValidConfigName(newFileName) then
                        if M.SaveFileConfig(M.Config.DmuGuidePath, newFileName, M.Config.DmuCfg) then
                            newCfgMode = false
                            if newFileName ~= M.Config.DmuCustomList[M.Config.DmuCustomListIndex] then
                                table.insert(M.Config.DmuCustomList, newFileName)
                            end
                        end
                    else
                        M.ShowMsgUI(3, { "已存在该名称文件或者名称不合法,无法创建!" })
                    end
                end
                GUI:SameLine()
                GUI:Button("取消", 100, 20)
                if GUI:IsItemClicked(0) then
                    newFileName = M.Config.DmuCustomList[M.Config.DmuCustomListIndex]
                    newCfgMode = false
                end
            else
                GUI:Dummy(20, 0)
                GUI:SameLine(0, 0)
                GUI:PushItemWidth(300)
                local configIndex, configIndexChange = GUI:Combo("##configIndex", M.Config.DmuCustomListIndex, M.Config.DmuCustomList, 30)
                if configIndexChange then
                    M.Config.DmuCustomListIndex = configIndex
                    newFileName = M.Config.DmuCustomList[M.Config.DmuCustomListIndex]
                end
                GUI:PopItemWidth()
                if M.Config.DmuCustomListIndex == 1 then
                    GUI:Dummy(20, 0)
                    GUI:SameLine(0, 0)
                    GUI:Button("新建配置", 90, 20)
                    if GUI:IsItemClicked(0) then
                        newFileName = ""
                        newCfgMode = true
                    end
                else
                    GUI:Dummy(20, 0)
                    GUI:SameLine(0, 0)
                    GUI:Button("加载此配置", 90, 20)
                    if GUI:IsItemClicked(0) then
                        local fileName = M.Config.DmuCustomList[M.Config.DmuCustomListIndex]
                        local defCfg = M.CreateDmuDefaultCfg()
                        M.Config.DmuCfg = M.LoadFileConfig(M.Config.DmuGuidePath, fileName, defCfg)
                    end
                    GUI:SameLine()
                    GUI:Button("新建配置", 90, 20)
                    if GUI:IsItemClicked(0) then
                        newFileName = ""
                        newCfgMode = true
                    end
                    GUI:SameLine()
                    GUI:Button("保存到此配置", 100, 20)
                    if GUI:IsItemClicked(0) then
                        M.SaveFileConfig(M.Config.DmuGuidePath, newFileName, M.Config.DmuCfg)
                    end
                end
            end
            GUI:Separator()
            GUI:Columns(3, 'switch', false)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:BulletText('总开关')
            GUI:NextColumn()
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('是否画图')
            GUI:NextColumn()
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('是否指路')
            GUI:NextColumn()
            GUI:Separator()
            for i = 1, 5 do
                local key = 'P' .. i
                local curConfig = M.Config.DmuCfg[key]
                GUI:Dummy(15, 10)
                GUI:SameLine()
                GUI:AlignFirstTextHeightToWidgets()
                GUI:Text(key)
                GUI:SameLine()
                curConfig.enable = GUI:Checkbox('##' .. key .. 'enable', curConfig.enable)
                GUI:NextColumn()
                GUI:Dummy(10, 0)
                GUI:SameLine()
                curConfig.draw = GUI:Checkbox('##' .. key .. 'draw', curConfig.draw)
                GUI:NextColumn()
                GUI:Dummy(10, 0)
                GUI:SameLine()
                curConfig.guide = GUI:Checkbox('##' .. key .. 'guide', curConfig.guide)
                GUI:NextColumn()
                GUI:Separator()
            end
            GUI:Columns(1)
            GUI:BulletText('真假冰和雷')
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.BindEffect = GUI:Checkbox('屏蔽真假AOE特效##effectBind', M.Config.DmuCfg.BindEffect)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('勾选后屏蔽特效, 并且采用A+画紫色危险区\n\n未勾选使用ImGui画图显示黄色危险区')
            end
        end
        if M.Config.DmuCfg.P1.enable and GUI:CollapsingHeader('P1 凯夫卡·众神之像') then
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('一神')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 职能固定  ')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 激光站位顺序  ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(175)
            local dmOrder, dmOrderChanged = GUI:InputText('##BeamOrder',
                    M.StringJoin(M.Config.DmuCfg.P1.BeamOrder, ','), GUI.InputTextFlags_CharsNoBlank)
            if dmOrderChanged then
                M.Config.DmuCfg.P1.BeamOrder = M.StringSplit(dmOrder, ',')
            end
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('二神')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 站位方案: ')
            GUI:SameLine(0, 30)
            GUI:PushItemWidth(130)
            M.Config.DmuCfg.P1.Line2Type = GUI:Combo('##P1Line2Type', M.Config.DmuCfg.P1.Line2Type, { 'MT组上/ST组下', 'T远上/奶近下', }, 2)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('唰啦啦传送')
            GUI:Dummy(0, 0)
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 回转寿司, 相同buff优先正点放  ')
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.P1.transUnOpt = GUI:Checkbox('开启近战负优化[寿司优化]##P1transUnOpt', M.Config.DmuCfg.P1.transUnOpt)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('启动后混乱在外, 睡眠在内 \n\n纯粹是特么的负优化！')
            end
            GUI:Dummy(0, 0)
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('最后雷火')
            GUI:Dummy(15, 0)
            GUI:SameLine(0, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 固定式')
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.P1.autoLookAt = GUI:Checkbox('自动调整面向##P1autoLookAt', M.Config.DmuCfg.P1.autoLookAt)
            if M.Config.DmuCfg.P1.autoLookAt then
                GUI:SameLine(0, 13)
                M.Config.DmuCfg.P1.hardLock = GUI:Checkbox('使用更严格的硬锁定##P1HardLockFace', M.Config.DmuCfg.P1.hardLock)
                if GUI:IsItemHovered() then
                    GUI:SetTooltip('开启后会完全禁止可能会改变面向的事, \n\n约等于停手, 请谨慎使用')
                end
            end
        end
        if M.Config.DmuCfg.P2.enable and GUI:CollapsingHeader('P2 凯夫卡·神') then
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('8次踩塔')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 混合优化, 闲人固定')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 固定方式: ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P2.fixType = GUI:Combo('##T8fixType', M.Config.DmuCfg.P2.fixType, { '职能固定', '扇左钢右', '职能固定[近U]' }, 3)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 最后一脚: ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P2.endTower = GUI:Combo('##endTower', M.Config.DmuCfg.P2.endTower, { '去A点方向', '去两塔之间' }, 2)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(0, 0)
            GUI:BulletText('异三角')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 画图方案: ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(140)
            M.Config.DmuCfg.P2.trineDrawType = GUI:Combo('##trineDrawType', M.Config.DmuCfg.P2.trineDrawType, { '只画当前一次', '当前和下次预览' }, 2)
            GUI:PopItemWidth()
        end
        if M.Config.DmuCfg.P3.enable and GUI:CollapsingHeader('P3 艾克斯迪斯&卡奥斯') then
            GUI:BulletText('一运')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 逃课, 夜音式')
            GUI:Dummy(12, 0)
            GUI:SameLine(0, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 火BUFF左右优先级 ')
            GUI:SameLine(0, 0)
            GUI:PushItemWidth(175)
            local p3fireBuffOrder, p3fireBuffOrderChanged = GUI:InputText('##fireBuffOrder',
                    M.StringJoin(M.Config.DmuCfg.P3.fireBuffOrder, ','), GUI.InputTextFlags_CharsNoBlank)
            GUI:PopItemWidth()
            if p3fireBuffOrderChanged then
                M.Config.DmuCfg.P3.fireBuffOrder = M.StringSplit(p3fireBuffOrder, ',')
            end
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 谁引导超级跳:   ')
            GUI:SameLine()
            GUI:PushItemWidth(40)
            M.Config.DmuCfg.P3.superJump = GUI:Combo('##superJump', M.Config.DmuCfg.P3.superJump, { 'D3', 'D4' }, 2)
            GUI:PopItemWidth()

            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 击退站位方案:   ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            M.Config.DmuCfg.P3.kickType = GUI:Combo('##P3kickType', M.Config.DmuCfg.P3.kickType, { 'THHT', 'HTH', '8人一起' }, 3)
            GUI:PopItemWidth()

            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P3.LockFace = GUI:Checkbox('自动调整面向##p3LockFace', M.Config.DmuCfg.P3.LockFace)
            if M.Config.DmuCfg.P3.LockFace then
                GUI:SameLine(0, 13)
                M.Config.DmuCfg.P3.HardLockFace = GUI:Checkbox('使用更严格的硬锁定##HardLockFace', M.Config.DmuCfg.P3.HardLockFace)
                if GUI:IsItemHovered() then
                    GUI:SetTooltip('开启后会完全禁止可能会改变面向的事, \n\n约等于停手, 请谨慎使用')
                end
            end
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P3.autoTargetEx = GUI:Checkbox('击退前自动切换到EX防止出现锁面向问题##autoTargetEx', M.Config.DmuCfg.P3.autoTargetEx)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('BUFF剩余10秒锁定, BUFF消失停止, 检查\n\n到目标不对会一直tab小艾, 谨慎使用!')
            end
            GUI:BulletText('二运')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 盗火, 按标记顺序')

            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1, 0, 0, 1, ' 以巨大凯夫卡为12点顺时针找线')
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P3.slapHappyDraw = GUI:Checkbox('响亮亮耳光-范围画图##slapHappyDraw', M.Config.DmuCfg.P3.slapHappyDraw)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('分摊/分散60度扇形画图开关.')
            end
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P3.slapHappyDir = GUI:Checkbox('响亮亮耳光-站位箭头##slapHappyDir', M.Config.DmuCfg.P3.slapHappyDir)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('根据当前职能画一个你该去的地方的箭头')
            end
            GUI:Dummy(20, 0)
            GUI:SameLine(0, 0)
            M.Config.DmuCfg.P3.takeLineAttack12 = GUI:Checkbox('攻击1接两根##takeLineAttack12', M.Config.DmuCfg.P3.takeLineAttack12)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('在第1波中, 先由攻击2接第一根, 然后由攻击1同时接后面两根')
            end
            GUI:SameLine(0, 18)
            M.Config.DmuCfg.P3.takeLineStop22 = GUI:Checkbox('禁止2接两根##autoLookAt', M.Config.DmuCfg.P3.takeLineStop22)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('在第4波中, 先由禁止2接两根, 然后由禁止1接最后一根')
            end
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 标记类型:  ')
            GUI:SameLine()
            GUI:PushItemWidth(150)
            M.Config.DmuCfg.P3.markType = GUI:Combo('##P3markType', M.Config.DmuCfg.P3.markType, { '不标记', '标记自身(随机)', '标记全队', '标记自身(优先级)' }, 4)
            GUI:PopItemWidth()
            if GUI:IsItemHovered() then
                GUI:SetTooltip('标记自身(随机): 龙诗同款,自动123先到先得\n\n标记全队: 如果有人噶了导致没有BUFF会不标记\n\n标记自身(优先级): 按照设置的优先级分配123, 如果有人嘎了没BUFF可能会错\n\n  举例, 假设优先级为[MT,ST,D1,D2,D3,D4,H1,H2], \n\n  1.你是D3 buff为第2目标, 且同组点名为MT,D1,D3, 此时你标记为锁链3\n\n  2.你是H1 buff为第1目标, 且同组点名为MT,H1,H2, 此时你标记为攻击2 \n\n标记全队和标记自身(优先级)共用同一套标记优先级。\n另外如果有人抢了标记, 插件是不给你补的, 你得自己手动补一下!')
            end
            if M.Config.DmuCfg.P3.markType == 2 or M.Config.DmuCfg.P3.markType == 4 then
                GUI:Dummy(10, 0)
                GUI:SameLine()
                M.Config.DmuCfg.P3.delayMark = GUI:Checkbox('延迟标记##p3delayMark', M.Config.DmuCfg.P3.delayMark)
                if GUI:IsItemHovered() then
                    GUI:SetTooltip('勾选后会自动检查队友标记情况, 有标记才会标记自己; 否则Buff出来就标.')
                end
                if M.Config.DmuCfg.P3.markType == 4 then
                    drawP3MarkOrderEditor(M.Config.DmuCfg.P3.markOrderSelf)
                end
            elseif M.Config.DmuCfg.P3.markType == 3 then
                drawP3MarkOrderEditor(M.Config.DmuCfg.P3.markOrder)
            end
            GUI:AlignFirstTextHeightToWidgets()
            GUI:BulletText('放圈踩塔')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 盗火orCCHH, 其他请选择关闭')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 方案设置:  ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            local takeTowerTypeChanged
            M.Config.DmuCfg.P3.takeTowerType, takeTowerTypeChanged = GUI:Combo('##takeTowerType', M.Config.DmuCfg.P3.takeTowerType, { '关闭放圈', 'NOCCHH', '盗火', }, 3)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('修改这里选项为CCHH或者盗火时, 下面两个选项\n\n会自动修改, 如果你打的是标准的CCHH或者\n\n盗火, 请勿手动修改下方的两个设置')
            end
            if takeTowerTypeChanged then
                if M.Config.DmuCfg.P3.takeTowerType == 2 then
                    M.Config.DmuCfg.P3.towerGround = 2
                    M.Config.DmuCfg.P3.towerHeading = 1
                else
                    if M.Config.DmuCfg.P3.takeTowerType == 3 then
                        M.Config.DmuCfg.P3.towerGround = 1
                        M.Config.DmuCfg.P3.towerHeading = 1
                    end
                end
            end
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 踩塔12点:  ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            M.Config.DmuCfg.P3.towerHeading = GUI:Combo('##towerHeading', M.Config.DmuCfg.P3.towerHeading, { '脚跟方向', '脚尖方向' }, 2)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 踩塔左右:  ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            M.Config.DmuCfg.P3.towerGround = GUI:Combo('##P3towerGround', M.Config.DmuCfg.P3.towerGround, { '面基', '场基' }, 2)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('面基:以当前自身面向BOSS时的左右分组踩塔\n\n场基:以当前12点为基准进行左右分组踩塔')
            end
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 冰封提示方式:')
            GUI:SameLine()
            GUI:PushItemWidth(110)
            M.Config.DmuCfg.P3.moveEffect = GUI:Combo('##P3moveEffect', M.Config.DmuCfg.P3.moveEffect, { 'Anyone文字', '游戏特效' }, 2)
            GUI:PopItemWidth()
        end
        if M.Config.DmuCfg.P4.enable and GUI:CollapsingHeader('P4 凯夫卡&卡奥斯&新生艾克斯迪斯') then
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 盗火, MWW, 不同的地方做了选项')
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P4.sendMacro = GUI:Checkbox('发宏##p4sendMacro', M.Config.DmuCfg.P4.sendMacro)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('在第三次大十字读条判定在小队频道发宏, \n\n发的是最终解法, 不是绿玩宏, 请谨慎使用！')
            end
            if M.Config.DmuCfg.P4.sendMacro then
                GUI:SameLine(155)
                M.Config.DmuCfg.P4.useEcho = GUI:Checkbox('不发小队而是发默语##p4useEcho', M.Config.DmuCfg.P4.useEcho)
            end
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 动静提示方式:')
            GUI:SameLine(155)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P4.moveEffect = GUI:Combo('##P4moveEffect', M.Config.DmuCfg.P4.moveEffect, { 'Anyone文字', '游戏特效' }, 2)
            GUI:PopItemWidth()
      
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 石化眼提示方式:')
            GUI:SameLine(155)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P4.eyeEffect = GUI:Combo('##P4eyeEffect', M.Config.DmuCfg.P4.eyeEffect, { 'Anyone文字', '游戏特效' }, 2)
            GUI:PopItemWidth()
            
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 雷/水BUFF分散: ')
            GUI:SameLine(155)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P4.disType = GUI:Combo('##P4disType', M.Config.DmuCfg.P4.disType, { 'D左TH右', 'TH左D右' }, 2)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 石化眼站位:  ')
            GUI:SameLine(155)
            GUI:PushItemWidth(120)
            M.Config.DmuCfg.P4.eyeType = GUI:Combo('##P4eyeType', M.Config.DmuCfg.P4.eyeType, { '盗火固定式', '眼进人群出', '眼动人前人后', '其他(关闭)' }, 4)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('盗火固定式: 全员根据自己职能站位, 甚至不需要调整面向\n\n眼进人群出: 眼进圈, 其他人出去, 大家根据真假调整面向(只有眼睛有指路)\n\n眼动人前人后: 人群不动根据雷安全区站在AC方向目标圈上, 眼根据真假进圈或者人群背后(仅支持标准AC站位)')
            end
            GUI:PopItemWidth()
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P4.autoLook = GUI:Checkbox('自动调整面向##p4LockFace', M.Config.DmuCfg.P4.autoLook)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('看向/背对点名2人连线中点, 如果2人离得很远, \n\n且解法为非共线站位, 还是可能吃!')
            end
            if M.Config.DmuCfg.P4.autoLook then
                GUI:SameLine(155, 0)
                M.Config.DmuCfg.P4.harkLock = GUI:Checkbox('使用更严格的硬锁定##P4HardLockFace', M.Config.DmuCfg.P4.harkLock)
                if GUI:IsItemHovered() then
                    GUI:SetTooltip('开启后会完全禁止可能会改变面向的事, \n\n约等于停手, 请谨慎使用')
                end
            end
        end
        if M.Config.DmuCfg.P5.enable and GUI:CollapsingHeader('P5 魔法少女?凯夫卡') then
            GUI:Dummy(0, 0)
            GUI:SameLine()
            GUI:BulletText('疯狂交响曲')
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P5.isLeaning = GUI:Checkbox('斜米站位##p5isLeaning', M.Config.DmuCfg.P5.isLeaning)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('不勾选就是常规八方')
            end
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 站位顺序:  ')
            GUI:SameLine()
            GUI:PushItemWidth(175)
            local p5JobOrder, p5JobOrderChanged = GUI:InputText('##P5MaddeningOrchestraOrder',
                    M.StringJoin(M.Config.DmuCfg.P5.jobOrder, ','), GUI.InputTextFlags_CharsNoBlank)
            if p5JobOrderChanged then
                M.Config.DmuCfg.P5.jobOrder = M.StringSplit(p5JobOrder, ',')
            end
            if GUI:IsItemHovered() then
                GUI:SetTooltip('顺序：C（下）开始逆时针一周')
            end
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine()
            GUI:BulletText('混沌末世（地火）')
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P5.groundFireGuide = GUI:Checkbox('两步法指路##P5groundFireGuide',
                    M.Config.DmuCfg.P5.groundFireGuide)
            if GUI:IsItemHovered() then
                GUI:SetTooltip('单独控制混沌末世的两步法动态指路；同时需要开启P5“是否指路”\n\nPS: 本功能由String佬开发, 感谢！~')
            end
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 预警次数:  ')
            GUI:SameLine()
            local groundCntChanged, groundCntValue
            GUI:PushItemWidth(100)
            groundCntValue, groundCntChanged = GUI:InputInt('##P5groundCnt', M.Config.DmuCfg.P5.groundCnt, 1, 1)
            GUI:PopItemWidth()
            if GUI:IsItemHovered() then
                GUI:SetTooltip('预警颜色: 第1~5个圈颜色分别为红、橙、黄、靛蓝、绿, 超过5个固定为绿色\n\n请根据自身情况调整数量, 建议3~4, 数量过多可能会花!\n\nPS: 设置为0表示关闭')
            end
            if groundCntChanged then
                if groundCntValue < 0 then
                    M.Config.DmuCfg.P5.groundCnt = 0
                elseif groundCntValue > 7 then
                    M.Config.DmuCfg.P5.groundCnt = 7
                else
                    M.Config.DmuCfg.P5.groundCnt = groundCntValue
                end
            end
            GUI:Dummy(0, 0)
            GUI:Dummy(0, 0)
            GUI:SameLine()
            GUI:BulletText('遗弃末世（软狂暴）')
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:TextColored(1, 0, 0, 1, ' 攻略: 斜点出发, 全顺, 其他方案请选择关闭!')
            GUI:Dummy(10, 0)
            GUI:SameLine()
            M.Config.DmuCfg.P5.showBlackHole = GUI:Checkbox('显示黑洞范围##P5showBlackHole', M.Config.DmuCfg.P5.showBlackHole)
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 跑位方案:  ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            M.Config.DmuCfg.P5.forsakenType = GUI:Combo('##P4ForsakenType', M.Config.DmuCfg.P5.forsakenType,
                    { '斜点全顺', '其他（关闭）' }, 2)
            GUI:PopItemWidth()
            GUI:Dummy(0, 0)
            GUI:SameLine(20, 0)
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text(' 跑位起点:  ')
            GUI:SameLine()
            GUI:PushItemWidth(100)
            if M.Config.DmuCfg.P5.forsakenType then
                M.Config.DmuCfg.P5.forsakenTypeStart = GUI:Combo('##P5forsakenTypeStart', M.Config.DmuCfg.P5.forsakenTypeStart, { '左下:4', '右下:3', '右上:2', '左上:1' }, 4)
            end
            GUI:PopItemWidth()
        end
    end
    M.SaveConfig(M.Config.DmuGuidePath, M.Config.DmuGuideFile, 'DmuCfg')
    GUI:SetWindowSize(wide, 0)
    GUI:End()
end

return DancingMadUI
