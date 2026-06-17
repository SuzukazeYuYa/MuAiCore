local UIMgr = {}
--[[
===========================
    UI控制器
===========================
]]

---@param M MuAiGuide
UIMgr.init = function(M)
    M.UITool = {}
    M.UITool.AddLabel = function(label, normal, space)
        GUI:AlignFirstTextHeightToWidgets()
        if normal then
            GUI:Text(label)
        else
            GUI:BulletText(label)
        end
        if space ~= nil then
            GUI:SameLine(space, 0)
        else
            GUI:SameLine(0, 0)
        end
    end
    M.LoadUI = function(isReload)
        M.UIMap = {}
        M.UINames = {}
        M.Debug('   加载UI模块')
        local path = MuAiGuideRoot .. 'UI'
        local fileNames = FolderList(path)
        for _, fileName in pairs(fileNames) do
            local filePath = path .. "\\" .. fileName
            local uiTable = FileLoad(filePath)
            local uiName = string.gsub(fileName, "%.lua", "")
            if type(uiTable) ~= 'table' then
                M.Debug('    加载' .. uiName .. '失败:')
                d(uiTable)
            end
            if not isReload then
                M[uiName] = {
                    open = false,
                    visible = false,
                }
            end
            M.UIMap[uiName] = uiTable
            table.insert(M.UINames, uiName)
            M.Debug('     加载UI模块:' .. uiName)
        end
        M.Debug('   加载UI模块完毕')
        if M.MainUI ~= nil then
            M.MainUI.uiPos = {}
        end
    end
    M.LoadUI()
    M.DrawUIs = function()
        if M.Develop.UIRefresh then
            M.LoadUI(true)
        end
        for _, uiName in pairs(M.UINames) do
            if M[uiName].open then
                local ok, err = pcall(M.UIMap[uiName].draw)
                if not ok then
                    MuAiGuide.Debug('UI模块加载失败:' .. uiName .. ', 错误信息:' .. err)
                end
            end
        end
        if not M.MainUI.open then
            M.CloseAllUI({ 'MsgUI' })
        end
    end

    --- 显示消息弹窗
    ---@param type number 弹窗类型: 1.更新,2.确认取消, 3.单确认
    M.ShowMsgUI = function(type, msgTbl, onOKClick, onCancelClick, okText, cancelText)
        M.MsgUI.Type = type
        M.MsgUI.MsgTable = msgTbl
        M.MsgUI.OnOkClick = onOKClick
        M.MsgUI.OnCancelClick = onCancelClick
        M.MsgUI.OkText = okText
        M.MsgUI.CancelText = cancelText
        M.MsgUI.open = true
    end

    --- 显示二维码窗口
    ---@param showType number 显示类型：1.微信, 2.支付宝
    M.ShowQRCodeUI = function(showType)
        M.QRCodeUI.type = showType
        M.OpenUI('QRCodeUI')
    end

    --- 打开UI
    ---@param uiName string UI名称
    M.OpenUI = function(uiName)
        M[uiName].open = true
    end

    --- 关闭UI
    ---@param uiName string UI名称
    M.CloseUI = function(uiName)
        M[uiName].open = false
    end

    --- 关闭所有UI
    M.CloseAllUI = function(tbl)
        for _, uiName in pairs(M.UINames) do
            if tbl ~= nil then
                if not table.contains(tbl, uiName) then
                    M[uiName].open = false
                end
            else
                M[uiName].open = false
            end
        end
    end
end
return UIMgr