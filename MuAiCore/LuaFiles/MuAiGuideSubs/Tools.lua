local Tools = {}
--[[
===========================
    通用工具方法
===========================
]]
---@param M MuAiGuide
Tools.init = function(M)
    --- 输出消息到聊天栏
    --- @param msg string
    M.Info = function(msg, ttsOn)
        if not M.Config.Main.LogToEchoMsg then
            return
        end
        local info = "/e  " .. msg
        TensorCore.sendParsedChatMessage("/e {color:0,255,0}{resetcolor}" .. msg)
        --SendTextCommand(info)
        if ttsOn and M.Config.Main.TTS == true then
            TensorCore.addAlertText(0, msg, 1, 2, true)
        end
    end

    --- 计算索引位置
    --- @param orderTable table 基于哪个优先级序列的表
    --- @param value any 元素成员
    --- @return number index 索引
    M.IndexOf = function(orderTable, value)
        value = value or M.SelfPos
        for i = 1, #orderTable, 1 do
            if value == orderTable[i] then
                return i
            end
        end
        return 0
    end

    --- 字符串分割
    --- @param str string 待分割的字符串
    --- @param mark string 分隔符（默认为","）
    --- @return table 分割后的列表
    M.StringSplit = function(str, mark)
        mark = mark or ","
        local input = string.gsub(str, "，", ",")
        input = string.gsub(input, "%s", "")
        local t = {}
        if input == "" then
            return t
        end
        local pattern = "([^" .. mark .. "]+)"
        for match in string.gmatch(input, pattern) do
            table.insert(t, match)
        end
        return t
    end

    --- 列表进行拼接
    --- @param tbl table 表
    --- @param mark string 分隔符
    --- @return table result 拼合后的字符串
    M.StringJoin = function(tbl, mark)
        local result = ""
        if tbl == nil or table.size(tbl) == 0 then
            return result
        end
        for i, v in ipairs(tbl) do
            if i > 1 then
                result = result .. mark
            end
            result = result .. tostring(v)
        end
        return result
    end

    --- 将表B合并到表A中
    M.Append = function(tblA, tblB)
        local tbl = {}
        for _, v in ipairs(tblA) do
            table.insert(tbl, v)
        end
        for _, v in ipairs(tblB) do
            table.insert(tbl, v)
        end
        return tbl
    end

    --- 计算2个弧度之间的夹角（0~π）
    M.GetAngleRadian = function(r1, r2)
        local diff = math.abs(r2 - r1)
        if diff > math.pi then
            diff = 2 * math.pi - diff
        end
        return diff
    end

    --- 判断2个数是否相等
    --- @return boolean 是否相当
    M.IsSame = function(n1, n2)
        if n1 == nil or n2 == nil then
            return n1 == nil and n2 == nil
        end
        if n1 == n2 then
            return true
        end
        local diff = math.abs(n1 - n2)
        if diff < 0.05 then
            return true
        end
        return false
    end

    --- 将给定弧度调整到0~2π
    M.SetHeading2Pi = function(heading)
        -- 处理零值
        if M.IsSame(heading, 0) then
            return 0
        end
        local result = heading % (2 * math.pi)
        if M.IsSame(result, 0) or M.IsSame(result, 2 * math.pi) then
            return 0
        end
        if result < 0 then
            result = result + 2 * math.pi
        end
        return result
    end

    --- 判断2个弧度是否在同一方位
    M.IsSameDirection = function(angle1, angle2, tolerance)
        tolerance = tolerance or 0.05
        angle1 = angle1 % (2 * math.pi)
        if angle1 < 0 then
            angle1 = angle1 + 2 * math.pi
        end
        angle2 = angle2 % (2 * math.pi)
        if angle2 < 0 then
            angle2 = angle2 + 2 * math.pi
        end
        local diff = math.abs(angle1 - angle2)
        if diff > math.pi then
            diff = 2 * math.pi - diff
        end
        return diff <= tolerance
    end

    --- 判断点A到B的顺逆
    --- @return boolean true 顺时针，false 逆时针
    M.GetClock = function(posA, posB, O)
        O = O or { x = 100, z = 100 }
        local OA = { x = posA.x - O.x, z = posA.z - O.z }
        local OB = { x = posB.x - O.x, z = posB.z - O.z }
        local crossProduct = OA.x * OB.z - OA.z * OB.x
        -- 非标准坐标系，叉乘结果要反着来
        if crossProduct > 0 then
            return true
        elseif crossProduct < 0 then
            return false
        end
    end

    --- 移除文件扩展名
    M.RemoveExtension = function(filename)
        local dotIndex = filename:match(".*()%.")
        if dotIndex then
            return filename:sub(1, dotIndex - 1)
        else
            return filename
        end
    end

    --- 不区分大小写方式判断表格存在元素
    M.ContainsIgnoreCase = function(tbl, target)
        if type(tbl) ~= "table" or type(target) ~= "string" then
            return false
        end
        for _, value in ipairs(tbl) do
            if type(value) == "string" and string.lower(value) == string.lower(target) then
                return true
            end
        end
        return false
    end

    M.ShuffleListInPlace = function(tbl)
        for i = #tbl, 2, -1 do
            local j = math.random(i)
            tbl[i], tbl[j] = tbl[j], tbl[i]
        end
    end

    M.GetMidPos = function(posA, posB)
        return {
            x = (posA.x + posB.x) / 2,
            y = (posA.y + posB.y) / 2,
            z = (posA.z + posB.z) / 2,
        }
    end
end
return Tools