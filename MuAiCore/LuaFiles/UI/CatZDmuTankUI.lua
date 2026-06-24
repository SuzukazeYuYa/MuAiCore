local CatZDmuTankUI = {}

local dropDrownList = { "自己减伤", "自己无敌", "搭档减伤", "搭档无敌", "分摊" }
local dropDrownListP3 = { "自己减伤", "自己无敌", "搭档减伤", "搭档无敌", "分摊", "换T先吃", "换T后吃" }
local wide = 300
local keys = {
    -- P1,
    'RevoltingRuinIII_1',
    'LightingJudgment_1',
    'RevoltingRuinIII_2',
    'LightingJudgment_2',
    -- P2,
    'UltimateEmbrace_1',
    'WingOfDestruction',
    'UltimateEmbrace_2',
    -- P3,
    'ThunderIII_1',
    'ThunderIII_2',
    'ThunderIII_3',
    'ThunderIII_4',
    'ThunderIII_5',
    --'ThunderIII_6',
    --'ThunderIII_7',
    --'ThunderIII_8',
    --'ThunderIII_9',
    --'ThunderIII_10',
    -- P4
    -- P5
    'ChaoticFlare_1',
    'ChaoticFlare_2',
}

CatZDmuTankUI.draw = function()
    local M = MuAiGuide
    if not M.CatZDmuTankUI.open then
        return
    end
    GUI:SetNextWindowPos(M.MainUI.uiPos.x, M.MainUI.uiPos.y)
    GUI:SetNextWindowSize(wide, 0, GUI.SetCond_Appearing)
    M.CatZDmuTankUI.visible, M.CatZDmuTankUI.open = GUI:Begin("CatZ Dmu Mitigation Setting", M.CatZDmuTankUI.open)
    if M.CatZDmuTankUI.visible then
        GUI:TextColored(1,1,0,1, '本插件仅为CatZ的时间轴提供减伤控制UI,')
        GUI:TextColored(1,1,0,1, '如果需要对应的时间轴自行寻找CatZ的开源')
        GUI:TextColored(1,1,0,1, '链接, 本插件不提供该时间轴文件.')
        local curP = 01
        GUI:Columns(2, 'CNName and Value', false)
        local p3Pull = false
        for i = 1, #keys do
            local curConfig = M.Config.DmuCatZCfg[keys[i]]
            if curP ~= curConfig.p then
                GUI:Columns(1)
                GUI:Separator()
                GUI:BulletText('P' .. curConfig.p)
                GUI:Separator()
                GUI:Columns(2)
                curP = curConfig.p
            end
            local itemList
            if curP == 3 then
                itemList = dropDrownListP3
                if not p3Pull then
                    p3Pull = true
                    GUI:AlignFirstTextHeightToWidgets()
                    GUI:Text('  谁拉艾克斯迪斯')
                    GUI:NextColumn()
                    M.Config.DmuCfg.P3.ExDeathTank = GUI:Combo('##ExDeathTank', M.Config.DmuCfg.P3.ExDeathTank, { 'ST', 'MT' }, 2)
                    GUI:NextColumn()
                end
            else
                itemList = dropDrownList
            end
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('  ' .. curConfig.nameCn)
            GUI:NextColumn()
            
            curConfig.value = GUI:Combo("##" .. keys[i], curConfig.value, itemList, #itemList)
            GUI:NextColumn()
        end
    end
    M.SaveConfig(M.Config.DmuCatZMigPath, M.Config.DmuCatZMigFile, 'DmuCatZCfg')
    GUI:SetWindowSize(wide, 0)
    GUI:End()
end
return CatZDmuTankUI