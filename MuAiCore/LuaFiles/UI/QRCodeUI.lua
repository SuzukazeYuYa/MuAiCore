local QRCodeUI = function(M)
    if not M.QRCodeUI.open then
        return
    end
    GUI:SetNextWindowSize(400, 0, GUI.SetCond_Appearing)
    GUI:SetNextWindowPos(M.QRCodeUI.x, M.QRCodeUI.y, GUI.SetCond_Appearing)
    M.QRCodeUI.visible, M.QRCodeUI.open = GUI:Begin("Support Me", M.QRCodeUI.open)
    if M.QRCodeUI.visible then
        local path = nil
        if M.QRCodeUI.type == 1 then
            path = GetLuaModsPath() .. '\\MuAiCore\\Image\\WeChatPayCode.png'
        elseif M.QRCodeUI.type == 2 then
            path = GetLuaModsPath() .. '\\MuAiCore\\Image\\AliPayCode.png'
        end
        if path ~= nil then
            GUI:Image(path, 400, 600)
        else
            M.QRCodeUI.open = false
        end
    end
    GUI:SetWindowSize(415, 0)
    GUI:End()
end
return QRCodeUI