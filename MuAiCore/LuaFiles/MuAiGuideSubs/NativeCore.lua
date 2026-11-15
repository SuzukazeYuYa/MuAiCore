local Module = {}

function Module.init(M, moduleRoot)
    local N = { State = 'idle', Reason = nil, Calls = 0, Fallbacks = 0 }
    local entry, pending
    local automaticActivation = true
    local previousNative = type(MuAiGuide) == 'table' and MuAiGuide.NativeCore or nil
    local attempts, retryAt = 0, nil
    local cache = setmetatable({}, { __mode = 'k' })
    local function diagnose(level, message, detail)
        if type(M.Diagnostic) == 'function' then
            M.Diagnostic(level, 'NativeCore', message, detail, 'native_' .. N.State)
        end
    end
    local function fail(reason)
        N.State, N.Reason = 'lua', tostring(reason)
        diagnose('WARN', '原生后端不可用，继续使用原Lua求解', { reason = N.Reason })
        return false
    end
    local function inCombat()
        return Player ~= nil and Player.incombat == true
    end
    function N.close()
        automaticActivation, previousNative = false, nil
        if entry then
            local ok, code = pcall(entry, -1)
            if not ok or (code ~= 0 and code ~= -9) then diagnose('WARN', '原生后端停用回执异常', { code = code }) end
        end
        entry = nil
        if pending then pending.cancelled = true end
        cache = setmetatable({}, { __mode = 'k' })
        N.State = 'closed'
        -- __gc 由原生闭包持有的私有 userdata 触发；旧引用仍在时不会物理卸载。
    end
    function N.takePending()
        local request = pending
        pending = nil
        return request
    end
    function N.activate(previous)
        automaticActivation, previousNative = false, nil
        if previous and previous ~= N and type(previous.takePending) == 'function' then pending = previous.takePending() end
        if entry then return true end
        if pending then
            if pending.expired then
                N.State, N.Reason = 'lua', 'previous_loader_result_unobserved'
            else
                pending.cancelled = false; N.State = 'loading'
            end
            return false
        end
        if inCombat() then N.State = 'waiting'; return false end
        if type(newproxy) ~= 'function' or type(GetCurrentPID) ~= 'function' or type(io.popen) ~= 'function' then
            return fail('host_loading_api_unavailable')
        end
        local closure = tostring(PerfClock):match('function:%s*(%x+)$')
        if not closure then return fail('clock_closure_unavailable') end
        local root = moduleRoot or (GetLuaModsPath() .. 'MuAiCore\\')
        local loader = root .. 'Native\\MuAiNativeLoader.exe'
        local executable = io.open(loader, 'rb')
        if not executable then return fail('loader_file_missing') end
        executable:close()
        local stateRoot = root .. 'Log\\Native\\'
        if not FolderExists(stateRoot) and FolderCreate(stateRoot) ~= true then return fail('state_directory_unavailable') end
        local token = string.format('%.0f', math.floor(PerfClock() * 1000) % 9000000000000000 + 1)
        local receipt = stateRoot .. token .. '.status'
        if loader:find('[%%"\r\n]') or receipt:find('[%%"\r\n]') then return fail('unsupported_shell_path') end
        local started = PerfClock()
        local command = '"' .. loader .. '" --start ' .. tostring(GetCurrentPID()) .. ' ' .. closure .. ' ' .. token .. ' "' .. receipt .. '" 2>&1'
        local ok, pipe = pcall(function()
            local pipe, err = io.popen(command, 'r')
            if not pipe then error(err or 'loader_start_failed') end
            return pipe
        end)
        N.LaunchMs = PerfClock() - started
        if not ok or not pipe then return fail(pipe) end
        pending = { token = token, receipt = receipt, started = started, nextPoll = started, pipe = pipe }
        attempts = attempts + 1
        N.State, N.Reason = 'loading', nil
        return false
    end
    function N.update()
        -- 根 Lua 文件可能被宿主缓存；只有成为当前有效实例后才接管原生 owner。
        if automaticActivation and MuAiGuide == M then
            local previous = previousNative
            automaticActivation, previousNative = false, nil
            if previous and previous ~= N then previous.close() end
            N.activate(previous)
        end
        if N.State == 'retrying' and PerfClock() >= retryAt and not inCombat() then N.activate() end
        if N.State == 'waiting' and not inCombat() then N.activate() end
        if not pending or PerfClock() < pending.nextPoll then return end
        pending.nextPoll = PerfClock() + 100
        local file = io.open(pending.receipt, 'rb')
        if not file then
            if not pending.expired and PerfClock() - pending.started > 20000 then
                pending.expired, pending.cancelled = true, true
                fail('loader_result_unobserved; reload after checking the loader receipt')
            end
            return
        end
        local text, readError = file:read('*a'); file:close()
        if type(text) ~= 'string' then pending = nil; fail(readError or 'loader_receipt_read_failed'); return end
        if text:sub(1, #pending.token + 1) ~= pending.token .. '|' then return end
        local request = pending; pending = nil
        -- 子进程的成功/业务失败回执在启动 shell 已退出后发布；不在发起时读管道。
        local pipeOk, pipeError = pcall(function() request.pipe:read('*a'); request.pipe:close() end)
        if not pipeOk then diagnose('WARN', '原生启动管道回收失败', { error = pipeError }) end
        if type(FileDelete) == 'function' and FileDelete(request.receipt) ~= true then
            diagnose('WARN', '无法删除已读取的原生加载回执', { path = request.receipt })
        end
        if not text:match('|OK 2%s*$') then
            if text:match('|ERROR arm_11%s*$') and not request.cancelled and attempts < 3 then
                N.State, N.Reason, retryAt = 'retrying', 'previous_native_generation_finishing', PerfClock() + 250
                return
            end
            fail(text); return
        end
        local lease = newproxy(true)
        local mt = getmetatable(lease)
        mt.__gc = function() end
        local _, fn = PerfClock(tonumber(request.token), { lease })
        if type(fn) ~= 'function' then fail('bootstrap_entry_unavailable'); return end
        mt.__gc = fn
        if request.cancelled then pcall(fn, -1); N.State = request.expired and 'lua' or 'closed'; return end
        local ok, abi = pcall(fn)
        if not ok or abi ~= 2 then pcall(fn, -1); fail('native_abi_mismatch'); return end
        entry = fn
        N.State, N.Reason, N.LoadMs = 'native', nil, PerfClock() - request.started
        diagnose('INFO', '原生求解后端已加载', { abi = abi, launchMs = N.LaunchMs, loadMs = N.LoadMs })
    end
    function N.reload()
        N.close()
        attempts = 0
        return N.activate()
    end
    function N.status()
        local abi, epoch, hook, calls
        if entry then abi, epoch, hook, calls = entry() end
        return { state = N.State, reason = N.Reason, abi = abi, epoch = epoch, bootstrap = hook,
            calls = calls, fallback = N.Fallbacks, launchMs = N.LaunchMs, loadMs = N.LoadMs }
    end
    function N.groundfire(state)
        if not entry then return false end
        local points, hits = state.Points, state.Hits
        if #points == 0 then state.PointTriggers = {}; return true end
        -- 实机对照：小规模的桥接/整理成本高于原Lua循环，保留原算法。
        if #points < 2 or #points * #hits < 84 then return false end
        local inputs = cache[hits]
        if not inputs or inputs.count > #hits then
            inputs = { count = 0, hits = {}, points = {}, output = {} }
            cache[hits] = inputs
        end
        -- P5 的 Hits 只追加，几何/顺序写入后不再修改；resolved 不参与触发顺序计算。
        for i = inputs.count + 1, #hits do
            local hit, offset = hits[i], (i - 1) * 4
            inputs.hits[offset + 1], inputs.hits[offset + 2] = hit.x, hit.z
            inputs.hits[offset + 3], inputs.hits[offset + 4] = hit.radius, hit.order
        end
        inputs.count = #hits
        for i = 1, #points do
            inputs.points[i * 2 - 1], inputs.points[i * 2] = points[i].x, points[i].z
            inputs.output[i] = 0
        end
        local ok, code = pcall(entry, inputs.points, inputs.hits, #points, #hits, inputs.output, 1)
        if not ok or code ~= 0 then
            N.Fallbacks = N.Fallbacks + 1
            diagnose('WARN', '本次原生求解失败，使用原Lua计算', { code = code })
            return false
        end
        local output = {}
        for i = 1, #points do output[i] = inputs.output[i] end
        state.PointTriggers = output
        N.Calls = N.Calls + 1
        return true
    end
    function N.configUnchanged(plan)
        if not entry or #plan.tables > 512 or #plan.flat > 100000 then return nil end
        for i=1,#plan.tables do
            if getmetatable(plan.tables[i])~=nil then return false end
        end
        local ok,code=pcall(entry,plan.flat,#plan.tables,#plan.flat,2)
        if ok and (code==0 or code==1) then return code==0 end
        N.Fallbacks=N.Fallbacks+1
        diagnose('WARN','本次原生配置检查失败，使用Lua比较',{code=code})
        return nil
    end
    M.NativeCore = N
end

return Module
