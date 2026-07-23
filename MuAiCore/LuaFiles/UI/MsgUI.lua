local MsgUI = {}
--[[
===========================
    消息弹窗UI VIEW
===========================
]]
MsgUI.draw = function()
    local M = MuAiGuide
    if not M.MsgUI.open then
        return
    end
    local drawWindow = function()
        GUI:Text("                 MuAiGuide提示")
        GUI:Separator()
        local size = #M.MsgUI.MsgTable
        local lineSpace = 5
        if size == 1 then
            lineSpace = 10
        end
        GUI:Dummy(0, lineSpace)
        for i = 1, #M.MsgUI.MsgTable do
            local curLine = M.MsgUI.MsgTable[i]
            if string.find(curLine, "Tab") then
                local data = MuAiGuide.StringSplit(curLine, "|")
                GUI:Dummy(20, 0)
                GUI:SameLine()
                GUI:TextWrapped(data[2])
            else
                GUI:TextWrapped(curLine)
            end
        end
        GUI:Dummy(0, lineSpace)
        GUI:Separator()
        GUI:Dummy(0, 1)
        local okText =  M.MsgUI.OkText or '确认'
        local cancelText =  M.MsgUI.CancelText or '取消'
        if M.MsgUI.Type == 1 then
            GUI:Dummy(30, 0)
            GUI:SameLine()
            GUI:Button(okText, 100, 25)
            if GUI:IsItemClicked(0) then
                M.MsgUI.open = false
                if M.MsgUI.OnOkClick ~= nil then
                    M.MsgUI.OnOkClick()
                end
            end
            GUI:SameLine(0, 22)
            GUI:Dummy(35, 25)
            GUI:SameLine()
            GUI:Button(cancelText, 100, 25)
            if GUI:IsItemClicked(0) then
                M.MsgUI.open = false
                if M.MsgUI.OnCancelClick ~= nil then
                    M.MsgUI.OnCancelClick()
                end
            end
        elseif M.MsgUI.Type == 2 then
            GUI:Button('详细日志', 100, 25)
            if GUI:IsItemClicked(0) then
                io.popen('start https://docs.qq.com/doc/DWnhXRXBxSXJpU0tS?rtkey=07822459d679f67ae55c279c801Xw1&nlc=1')
            end
            GUI:SameLine(0, 15)
            GUI:Button('更新', 100, 25)
            if GUI:IsItemClicked(0) then
                M.CloseAllUI()
                M.ForceUpdate()
            end
            GUI:SameLine(0, 15)
            GUI:Button(cancelText, 100, 25)
            if GUI:IsItemClicked(0) then
                M.MsgUI.open = false
                if M.MsgUI.OnCancelClick ~= nil then
                    M.MsgUI.OnCancelClick()
                end
            end
        else
            GUI:Dummy(0, 25)
            GUI:SameLine(117)
            GUI:Button(okText, 100, 25)
            if GUI:IsItemClicked(0) then
                M.MsgUI.open = false
                if M.MsgUI.OnOkClick ~= nil then
                    M.MsgUI.OnOkClick()
                end
            end
        end
        GUI:Dummy(0, 0.5)
    end
    local screenWidth, screenHeight = GUI:GetScreenSize()
    local tempWidth, tempHeight = 0, 0
    GUI:SetNextWindowPos(-9999, -9999, GUI.SetCond_Always)
    --数据采集用窗口
    local visible = GUI:Begin("居中使用的隐藏窗口", true, GUI.WindowFlags_NoInputs)
    if visible then
        drawWindow()
    end
    GUI:End()
    tempWidth, tempHeight = GUI:GetWindowSize()
    GUI:PushStyleColor(GUI.Col_WindowBg, 0.0, 0, 0, 0.3)
    GUI:SetNextWindowPos(0, 0, GUI.SetCond_Always)
    GUI:SetNextWindowSize(screenWidth, screenHeight, GUI.SetCond_Appearing) 
    -- 背景窗口
    GUI:Begin("MuAiMsgBoxBgWindow", true,
            GUI.WindowFlags_NoTitleBar
                    + GUI.WindowFlags_NoMove
                    + GUI.WindowFlags_NoScrollbar
                    + GUI.WindowFlags_NoCollapse
    )
    GUI:End()
    GUI:PopStyleColor(1)
    -- 实际窗口
    GUI:SetNextWindowPos((screenWidth - 350) / 2, (screenHeight - tempHeight) / 2 - 50, GUI.SetCond_Always)
    GUI:SetNextWindowSize(350, 0, GUI.SetCond_Appearing)
    M.MsgUI.visible, M.MsgUI.open = GUI:Begin('MuAiMsgBoxTopWindow', M.MsgUI.open,
            GUI.WindowFlags_NoTitleBar
                    + GUI.WindowFlags_NoResize
                    + GUI.WindowFlags_NoMove
                    + GUI.WindowFlags_NoScrollbar
                    + GUI.WindowFlags_NoCollapse

    )
    if M.MsgUI.visible and M.MsgUI.MsgTable ~= nil then
        drawWindow()
        GUI:SetWindowFocus('MuAiMsgBoxBgWindow')
        GUI:SetWindowFocus('MuAiMsgBoxTopWindow')
    end
    GUI:End()
end
return MsgUI