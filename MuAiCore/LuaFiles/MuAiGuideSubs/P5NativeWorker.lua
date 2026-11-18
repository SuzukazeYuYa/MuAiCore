-- 本机 P5 数值求解。一次只发一份快照，同一事件内收不到结果就交回 Lua。
local Worker = {}
Worker.__index = Worker
local sequence = 0
local headerSize = 14
local waitMs = 0.65
-- 三场日志的实机对照中，约 1750 次点圆比较起才抵得过跨进程往返。
local minimumWorkerPairs = 1750

local function valid(value)
    return type(value) == 'number' and math.abs(value) <= 100000
end

function Worker.start(root)
    root = root:gsub('[\\/]+$', '')
    if root == '' or root:find('[%%!"\r\n]') then return nil, 'invalid_worker_path' end
    local native = root .. '\\Native'
    local executable, err = io.open(native .. '\\MuAiP5Worker.exe', 'rb')
    if not executable then return nil, err or 'p5_worker_missing' end
    executable:close()
    sequence = sequence + 1
    local session = string.format('%d-%d-%.0f-%d', GetCurrentPID(), os.time(), PerfClock() * 1000, sequence)
    local command = 'start "" /b /d "' .. native .. '" powershell.exe -NoProfile -NonInteractive -WindowStyle Hidden '
            .. '-ExecutionPolicy Bypass -File ..\\LuaFiles\\MuAiGuideSubs\\StartP5Worker.ps1 -Session ' .. session .. ' <nul >nul 2>&1'
    local launcher, launchError = io.popen(command, 'r')
    if not launcher then return nil, launchError or 'p5_worker_launch_failed' end
    launcher:close()
    return setmetatable({
        session = session, receipt = root .. '\\Temp\\P5Solver\\' .. session .. '.reply',
        state = 'starting', start = PerfClock(), nextPoll = 0, sent = 0, completed = 0,
        late = 0, timeouts = 0, cached = 0, smallBatches = 0, hits = setmetatable({}, { __mode = 'k' }),
    }, Worker)
end

function Worker:close()
    if self.reply then self.reply:close(); self.reply = nil end
    if self.pipe then self.pipe:close(); self.pipe = nil end
    self.state = 'closed'
end

function Worker:failure(reason)
    self:close()
    self.state, self.reason = 'failed', reason
    return false
end

-- 长度与请求号最后发布。读到新号时，整份结果已经可读。
function Worker:receive(expected)
    local offset, seekError = self.reply:seek('set', 0)
    if not offset then return nil, seekError or 'response_seek_failed' end
    local header, err = self.reply:read(headerSize)
    if not header or #header ~= headerSize then return nil, err end
    if self.expectedId ~= expected then
        self.expectedId, self.expectedPrefix = expected, string.format('%08d ', expected)
    end
    if header:sub(1, 9) ~= self.expectedPrefix then return nil end
    local length = tonumber(header:match(' (%d%d%d%d)\n$'))
    if not length or length < 2 or length > 3000 then return nil, 'invalid_response_length' end
    local data, readError = self.reply:read(length)
    if not data or #data ~= length then return nil, readError or 'incomplete_response' end
    return data
end

function Worker:poll()
    if self.state ~= 'starting' then return end
    local now = PerfClock()
    if now < self.nextPoll then return end
    self.nextPoll = now + 40
    if now - self.start > 10000 then self:failure(self.reason or 'p5_worker_start_timeout'); return end
    if not self.reply then
        self.reply = io.open(self.receipt, 'rb')
        if not self.reply then
            local path = self.receipt:gsub('%.reply$', '.error')
            local failed = io.open(path, 'rb')
            if failed then
                local detail = failed:read(512); failed:close()
                if type(FileDelete) == 'function' then FileDelete(path) end
                self:failure(detail or 'p5_worker_prepare_failed')
            end
            return
        end
        local ok, err = self.reply:setvbuf('no')
        if not ok then self:failure(err or 'response_buffer_failed'); return end
    end
    local ready, err = self:receive(0)
    if err then self:failure(err); return end
    if not ready then return end
    local session, pid = ready:match('^READY 1 ([%d%-]+) (%d+)$')
    if session ~= self.session then self:failure('p5_worker_handshake_mismatch'); return end
    self.pid = tonumber(pid)
    self.pipe, err = io.open('\\\\.\\pipe\\MuAiP5-' .. session, 'r+b')
    if not self.pipe then self.reason = err; return end
    local ok, bufferError = self.pipe:setvbuf('no')
    if not ok then self:failure(bufferError or 'request_buffer_failed'); return end
    self.state, self.reason = 'ready', nil
end

local function numberText(numbers, value)
    local text = numbers[value]
    if not text then
        text = string.format('%.17g', value)
        numbers[value] = text
    end
    return text
end

local function encodeHits(self, hits)
    -- P5 在同一张表内只追加地火，重开一轮会换表。已展开的数据可以跨事件复用。
    local cached = self.hits[hits]
    if not cached or cached.count > #hits then
        cached = { count = 0, fields = {}, numbers = {}, points = setmetatable({}, { __mode = 'k' }) }
        self.hits[hits] = cached
    end
    if cached.count ~= #hits then
        for i = cached.count + 1, #hits do
            local h = hits[i]
            if not valid(h.x) or not valid(h.z) or not valid(h.radius) or h.radius < 0 or not valid(h.order) then return nil end
            local numbers = cached.numbers
            cached.fields[i] = numberText(numbers, h.x) .. ' ' .. numberText(numbers, h.z)
                    .. ' ' .. numberText(numbers, h.radius) .. ' ' .. numberText(numbers, h.order)
        end
        cached.count, cached.text = #hits, nil
    end
    return cached
end

local function encode(guides, roles, circles)
    local fields = { #roles, circles.count }
    for i = 1, #roles do fields[#fields + 1] = #guides[roles[i]].Points end
    for i = 1, #roles do
        for _, p in ipairs(guides[roles[i]].Points) do
            local saved = circles.points[p]
            if not saved or saved.x ~= p.x or saved.z ~= p.z then
                if not valid(p.x) or not valid(p.z) then return nil end
                saved = { x = p.x, z = p.z, text = string.format('%.17g %.17g', p.x, p.z) }
                circles.points[p] = saved
            end
            fields[#fields + 1] = saved.text
        end
    end
    circles.text = circles.text or table.concat(circles.fields, ' ', 1, circles.count)
    fields[#fields + 1] = circles.text
    return table.concat(fields, ' ')
end

local function decode(response, total)
    if response:sub(1, 3) ~= 'OK ' then return nil end
    local values = {}
    for field in response:sub(4):gmatch('%S+') do
        local value = tonumber(field)
        if not valid(value) or #values >= total then return nil end
        values[#values + 1] = value
    end
    if #values == total then return values end
end

local function apply(guides, roles, values)
    local offset = 0
    for i = 1, #roles do
        local guide = guides[roles[i]]
        local last, count = guide.PointTriggers, #guide.Points
        local same = type(last) == 'table' and getmetatable(last) == nil and #last == count
        for j = 1, count do
            if not same or last[j] ~= values[offset + j] then same = false; break end
        end
        if not same then
            local output = {}
            for j = 1, count do output[j] = values[offset + j] end
            guide.PointTriggers = output
        end
        offset = offset + count
    end
end

function Worker:solve(guides, roles, hits, total)
    if self.state ~= 'ready' then return false end
    if self.pending then
        local old, err = self:receive(self.pending)
        if err then return self:failure(err) end
        if not old then
            if PerfClock() - self.pendingAt > 2000 then return self:failure('p5_worker_unresponsive') end
            return false
        end
        -- 这一份已由 Lua 完成。只回收结果，不写入后来的路线。
        self.pending, self.late = nil, self.late + 1
    end
    local circles = encodeHits(self, hits)
    if not circles then self.lastError = 'invalid_groundfire_input'; return false end
    if total * #hits < minimumWorkerPairs then
        self.smallBatches = self.smallBatches + 1
        return false, 'small_batch'
    end
    local input = encode(guides, roles, circles)
    if not input then self.lastError = 'invalid_groundfire_input'; return false end
    if input == self.lastInput then
        apply(guides, roles, self.lastValues)
        self.cached = self.cached + 1
        return true
    end
    self.sent = self.sent + 1
    local ok, err = self.pipe:write(tostring(self.sent) .. ' ' .. input .. '\n')
    if not ok then return self:failure(err or 'request_write_failed') end
    self.pending, self.pendingAt = self.sent, PerfClock()
    repeat
        local data, readError = self:receive(self.sent)
        if readError then return self:failure(readError) end
        if data then
            self.pending = nil
            local values = decode(data, total)
            if not values then self.lastError = data:sub(1, 80); return false end
            self.completed = self.completed + 1
            self.lastInput, self.lastValues, self.lastError = input, values, nil
            apply(guides, roles, values)
            return true
        end
    until PerfClock() - self.pendingAt >= waitMs
    self.timeouts = self.timeouts + 1
    self.lastError = 'reply_deadline'
    return false
end

return Worker
