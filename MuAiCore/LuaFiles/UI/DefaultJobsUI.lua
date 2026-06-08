local DefaultJobsUI = {
    dragStartIndex = nil,
    selectedIndex = nil,
}

local Height = 550
local weight = 130

local IsSelected = function(index)
    if index == MuAiGuide.DefaultJobsUI.selectedIndex then
        return true
    end
    return false
end

DefaultJobsUI.draw = function()
    local M = MuAiGuide
    if not M.DefaultJobsUI.open then
        return
    end
    GUI:SetNextWindowPos(M.MainUI.uiPos.x, M.MainUI.uiPos.y)
    GUI:SetNextWindowSize(weight, 0, GUI.SetCond_Appearing)
    M.DefaultJobsUI.visible, M.DefaultJobsUI.open = GUI:Begin("默认优先级", M.DefaultJobsUI.open)
    if M.DefaultJobsUI.visible then
        GUI:ListBoxHeader('##DefaultJobs', weight - 20, Height)
        for index = 1, #M.Config.Main.JobOrder do
            local indexStr
            if index < 10 then
                indexStr = '0'.. index
            else
                indexStr = tostring(index)
            end
            GUI:Selectable(
                    indexStr .. ' ' .. M.GetJobFullNameById(M.Config.Main.JobOrder[index]),
                    IsSelected(index),
                    GUI.SelectableFlags_DontClosePopups,
                    0,
                    18
            )
            if GUI:IsItemHovered(GUI.HoveredFlags_AllowWhenBlockedByPopup
                    + GUI.HoveredFlags_AllowWhenBlockedByActiveItem
                    + GUI.HoveredFlags_AllowWhenOverlapped)
            then

                -- 👇 下面这段就是你要的【纯数字list拖动核心】
                if GUI:IsMouseDown(0) then
                    -- 当前鼠标悬浮的索引（你自己获取：比如第几个item）
                    local currentIndex = index

                    -- 1. 第一次按下：记录起点
                    if M.DefaultJobsUI.dragStartIndex == nil then
                        M.DefaultJobsUI.dragStartIndex = currentIndex
                        M.DefaultJobsUI.selectedIndex = currentIndex

                        -- 2. 拖动到不同位置：交换
                    elseif M.DefaultJobsUI.dragStartIndex ~= currentIndex then
                        print("交换索引：" .. M.DefaultJobsUI.dragStartIndex .. " <=> " .. currentIndex)

                        -- 纯数字数组 交换（标准、简洁、你风格）
                        local temp = M.Config.Main.JobOrder[M.DefaultJobsUI.dragStartIndex]
                        M.Config.Main.JobOrder[M.DefaultJobsUI.dragStartIndex] = M.Config.Main.JobOrder[currentIndex]
                        M.Config.Main.JobOrder[currentIndex] = temp

                        -- 交换完，把起点更新到当前位置（保持拖动连贯）
                        M.DefaultJobsUI.dragStartIndex = currentIndex
                        M.DefaultJobsUI.selectedIndex = currentIndex
                    end
                end

                if M.DefaultJobsUI.dragStartIndex ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then
                    M.DefaultJobsUI.dragStartIndex = nil
                end
                if M.DefaultJobsUI.selectedIndex ~= nil and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then
                    M.DefaultJobsUI.selectedIndex = nil
                end
            end
            if index < #M.Config.Main.JobOrder then
                GUI:Separator()
            end
        end
        GUI:ListBoxFooter()
    end
    M.SaveConfig(M.Config.MainPath, M.Config.MainFile, 'Main')

    GUI:SetWindowSize(weight, 0)

    GUI:End()
end
return DefaultJobsUI