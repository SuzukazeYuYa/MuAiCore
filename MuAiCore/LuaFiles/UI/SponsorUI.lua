local SponsorUI = {}
--[[
===========================
    赞助者名单
===========================
]]

SponsorUI.draw = function()
    local M = MuAiGuide
    if not M.SponsorUI.open then
        return
    end
    if not M.FinalSponsorList then
        M.FinalSponsorList = M.LocalSponsorList
    end
    GUI:SetNextWindowPos(M.MainUI.uiPos.x, M.MainUI.uiPos.y)
    GUI:SetNextWindowSize(400, 0, GUI.SetCond_Appearing)
    M.SponsorUI.visible, M.SponsorUI.open = GUI:Begin("鸣谢&赞助者名单", M.SponsorUI.open)
    if M.SponsorUI.visible then
        GUI:Dummy(20, 5)
        GUI:Dummy(20, 20)
        GUI:SameLine()
        GUI:Image(GetLuaModsPath() .. 'MuAiCore/Image/thx_title.png', 330, 35)
        GUI:TextColored(0, 1, 0, 1, '          感谢在开发中的帮助')
        GUI:SameLine()
        GUI:TextColored(1, 1, 0, 1, '(不分先后)')
        GUI:Dummy(20, 5)
        GUI:Columns(3, 'ThanksList', false)
        for _, info in pairs(M.ThxList) do
            local iconPath = GetLuaModsPath() .. 'MuAiCore/Image/HeadIcons/' .. info.icon .. '.png'
            GUI:Image(iconPath, 40, 40)
            GUI:SameLine()
            GUI:BeginGroup()
            GUI:Dummy(20, 5)
            GUI:Text(info.id)
            GUI:EndGroup()
            GUI:NextColumn()
        end
        GUI:Columns(1)
        GUI:Dummy(20, 20)
        GUI:Dummy(20, 20)
        GUI:SameLine()
        GUI:Image(GetLuaModsPath() .. 'MuAiCore/Image/sponsor_title.png', 330, 35)
        GUI:TextColored(0, 1, 0, 1, '                感谢支持')
        GUI:SameLine()
        GUI:TextColored(1, 1, 0, 1, '(不分先后)')
        GUI:Dummy(20, 5)
        --赞助者名单
        GUI:Columns(3, 'SponsorList', false)
        for _, spName in pairs(M.FinalSponsorList) do
            local iconPath = GetLuaModsPath() .. 'MuAiCore/Image/HeadIcons/' .. spName.icon .. '.png'
            iconPath = string.gsub(iconPath, "\\", "/")
            if not FileExists(iconPath) then
                iconPath = GetLuaModsPath() .. 'MuAiCore/Image/HeadIcons/mini.png'
            end
            GUI:Image(iconPath, 40, 40)
            GUI:SameLine()
            GUI:BeginGroup()
            GUI:Dummy(20, 5)
            GUI:Text(spName.id)
            GUI:EndGroup()
            GUI:NextColumn()
        end
        GUI:Columns(1)
        GUI:Dummy(20, 10)
        GUI:Separator()
        GUI:Dummy(20, 10)
        GUI:Text(' 如果您也登上赞助名单, 可通过以下两种方式:')
        GUI:Text('   1.请在打赏后截图给作者进行添加(金额不限)')
        GUI:Text('   2.以前打赏过的朋友, 可以直接联系作者添加')
        GUI:TextColored(1,0,0,1,' 注意:赞助仅代表您个人支持本插件, 无任何特殊权限')
        GUI:Dummy(20, 5)
        GUI:Text(' 祝大家玩的开心！')
        GUI:Dummy(20, 15)
    end
    GUI:SetWindowSize(400, 0)
    GUI:End()
end
return SponsorUI