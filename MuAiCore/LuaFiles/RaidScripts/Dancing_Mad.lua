local DM = {}
DM.MapId = 001
DM.NameCN = '妖星乱舞绝境战'
DM.Version = '0.0.1'
DM.ScriptName = 'Dancing_Mad';
--- 初始化，将拆分的脚本合并加载
DM.Init = function()
    local folderPath = MuAiGuideRoot .. "RaidScripts\\".. DM.ScriptName
    local list = FolderList(folderPath)
    for _, fileName in pairs(list) do
        MuAiGuide.Debug("已加载副本[" ..  DM.ScriptName .. "]的子脚本：" .. fileName)
        local filePath = folderPath .. "\\" .. fileName
        local script = FileLoad(filePath)
        if script ~= nil then
            script(DM)
        end
    end
end

DM.Init();
return DM