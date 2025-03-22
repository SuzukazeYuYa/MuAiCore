local titles = {
    "绝命战士",
    "希瓦·米特隆",
    "暗之巫女",
    "希瓦·米特隆&暗之巫女",
    "潘多拉希瓦·米特隆",
}
local function AddCheckBox(index, M)
    local key = M.FruMitigation.AoeNames[index].key
    local skillName = M.FruMitigation.JobMap[Player.job]
    if (M.FruMitigation.Config[key].Target == nil or skillName[1] == nil) and
            (M.FruMitigation.Config[key].Field == nil or skillName[2] == nil)
    then
        return
    end
    GUI:Columns(3, "TableExample", true)
    GUI:Dummy(10, 10)
    GUI:SameLine(0, 0)
    GUI:AlignFirstTextHeightToWidgets()
    GUI:BulletText(M.FruMitigation.AoeNames[index].name)
    GUI:NextColumn()
    if M.FruMitigation.Config[key].Target ~= nil and skillName[1] ~= nil then
        GUI:Dummy(12, 10)
        GUI:SameLine(0, 0)
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text(skillName[1])
        GUI:SameLine(0, 10)
        M.FruMitigation.Config[key].Target = GUI:Checkbox("##Target" .. key, M.FruMitigation.Config[key].Target)
    end
    GUI:NextColumn()
    if M.FruMitigation.Config[key].Field ~= nil and skillName[2] ~= nil then
        GUI:Dummy(10, 10)
        GUI:SameLine(0, 0)
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text(skillName[2])
        GUI:SameLine(0, 10)
        M.FruMitigation.Config[key].Field = GUI:Checkbox("##Field" .. key, M.FruMitigation.Config[key].Field)
    end
    GUI:Columns(1)
end
local DrawUI = function(M)
    if M.FruMitigationUI.open then
        if not M.UI.open or M.IsHealer(Player.job) then
            M.FruMitigationUI.open = false
            M.FruMitigationUI.NewMode = false
            return
        end
        GUI:SetNextWindowSize(300, 0, GUI.SetCond_Appearing)
        GUI:SetNextWindowPos(M.FruConfigUI.x, M.FruConfigUI.y, GUI.SetCond_Appearing)
        M.FruMitigationUI.visible, M.FruMitigationUI.open = GUI:Begin("Fru Mitigation Setting", M.FruMitigationUI.open)
        if M.FruMitigationUI.visible then
            local lastP = 0
            for i = 1, #M.FruMitigation.AoeNames do
                local curP = M.FruMitigation.AoeNames[i].p
                if lastP ~= curP then
                    GUI:Separator()
                    GUI:BulletText("P" .. M.FruMitigation.AoeNames[i].p .. ". " .. titles[curP])
                    GUI:Separator()
                    lastP = curP
                end
                AddCheckBox(i, M)
            end
            GUI:Separator()
            GUI:Button("发送当前减伤情况到小队频道", 335, 20)
            if GUI:IsItemClicked(0) then
                SendTextCommand("/e 个人团减汇报：")
                local skillName = M.FruMitigation.JobMap[Player.job]
                local lastPSend = 1
                local pMark = "P1: "
                local targetInfo = ""
                local fieldInfo = ""
                for i = 1, #M.FruMitigation.AoeNames do
                    local curInfo = M.FruMitigation.AoeNames[i]
                    local key = M.FruMitigation.AoeNames[i].key
                    if lastPSend ~= curInfo .p then
                        if #targetInfo == 0 then
                            SendTextCommand("/e " .. pMark .. fieldInfo)
                        elseif #fieldInfo == 0 then
                            SendTextCommand("/e " .. pMark .. targetInfo)
                        else
                            SendTextCommand("/e " .. pMark .. skillName[1] .. ":" .. targetInfo .."   ".. skillName[2] .. ": " .. fieldInfo)
                        end
                        pMark = "P" .. curInfo .p .. ": "
                        lastPSend = curInfo .p
                        targetInfo = ""
                        fieldInfo = ""
                    end
                    if M.FruMitigation.Config[key].Target and skillName[1] then
                        if #targetInfo == 0 then
                            targetInfo = curInfo.macroInfo.. "、"
                        else
                            targetInfo = targetInfo .. curInfo.macroInfo .. "、"
                        end
                    end
                    if M.FruMitigation.Config[key].Field and skillName[2] then
                        if #fieldInfo == 0 then
                            fieldInfo = curInfo.macroInfo.. "、"
                        else
                            fieldInfo = fieldInfo .. curInfo.macroInfo .. "、"
                        end
                    end
                end
                if #targetInfo == 0 then
                    SendTextCommand("/e " .. pMark .. fieldInfo)
                elseif #fieldInfo == 0 then
                    SendTextCommand("/e " .. pMark .. targetInfo)
                else
                    SendTextCommand("/e " .. pMark .. skillName[1] .. ":" .. targetInfo .."   ".. skillName[2] .. ": " .. fieldInfo)
                end
                SendTextCommand("/e 如果哪里需要改，请及时提出，谢谢！~<se.3>")
            end
        end
        GUI:SetWindowSize(350, 0)
        GUI:End()
    end
end
return DrawUI