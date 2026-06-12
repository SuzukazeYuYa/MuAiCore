local G = {}
G.MapId = -1
G.NameCN = '自用脚本'
local curState = FFXIV_Common_BotRunning

G.Update = function()
    --if curState ~= FFXIV_Common_BotRunning then
    --    if FFXIV_Common_BotRunning == true then
    --        TensorCore.sendParsedChatMessage("/e {color:0,255,0}Minion Bot Start!{resetcolor}")
    --    elseif FFXIV_Common_BotRunning == false then
    --        TensorCore.sendParsedChatMessage("/e {color:255,0,0}Minion Bot End!{resetcolor}")
    --    end
    --    curState = FFXIV_Common_BotRunning
    --end
end
return G