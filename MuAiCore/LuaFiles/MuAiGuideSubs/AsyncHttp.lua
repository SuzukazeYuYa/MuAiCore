local AsyncHttp = {}

-- HttpRequest is the host's asynchronous transport. It returns no cancellation
-- handle: retain a small in-flight reservation until its native callback, even
-- after a Lua timeout or guide replacement, rather than starting duplicate jobs.
local transport = rawget(_G, 'MuAiHttpTransport')
if transport == nil then
    transport = { flights = {} }
    rawset(_G, 'MuAiHttpTransport', transport)
end
local pollInterval, timeout, maxBytes, maxFlights, maxPending = 250, 15000, 65536, 6, 8

local function parseUrl(url)
    if type(url) ~= 'string' or url:find('[%c%s]') then return end
    local authority, path = url:match('^https://([^/]+)(/.*)$')
    if authority == nil or not path:match('^/[%w%._~:/%-%?=&%%]*$') then return end
    local host, port = authority:match('^([%w%.%-]+):(%d+)$')
    if host == nil and authority:match('^[%w%.%-]+$') then host, port = authority, 443 end
    port = tonumber(port)
    if host == nil or port == nil or port < 1 or port > 65535 then return end
    return host, port, path
end

local function start(url, host, port, path)
    local flight = { startedAt = Now() }
    transport.flights[url] = flight
    -- Native callbacks retain only this small token, never M or a business
    -- callback. Timed-out/replaced owners can be collected immediately.
    local function finish(body, err, status)
        if flight.done then return end
        if transport.flights[url] == flight then transport.flights[url] = nil end
        flight.done, flight.completedAt, flight.status = true, Now(), tonumber(status)
        if flight.retired then return end
        if err ~= nil then
            flight.err = tostring(err):sub(1, 512)
        elseif flight.status == nil or flight.status < 200 or flight.status >= 300 then
            flight.err = 'HTTP status ' .. tostring(status)
        elseif type(body) ~= 'string' or #body == 0 then
            flight.err = 'empty response'
        elseif #body > maxBytes then
            flight.err = 'response exceeds size limit'
        else
            flight.body = body
        end
    end
    local separator = path:find('?', 1, true) and '&' or '?'
    local ok, result = pcall(HttpRequest, {
        host = host, port = port, path = path .. separator .. 't=' .. tostring(os.time()),
        method = 'GET', https = true, headers = { Connection = 'close' },
        onsuccess = function(body, _, status) finish(body, nil, status) end,
        onfailure = function(err, _, status) finish(nil, err or 'HTTP request failed', status) end,
    })
    if not ok or result == false then finish(nil, ok and 'HTTP request was not accepted' or result) end
    return flight
end

AsyncHttp.init = function(M)
    if type(M.CloseWebRequests) == 'function' then M.CloseWebRequests() end
    local pending, lastPollAt, closed = {}, nil, false

    M.WebRequestAsync = function(key, url, callback)
        local host, port, path = parseUrl(url)
        if closed then return false, 'HTTP owner is closed' end
        if type(key) ~= 'string' or key == '' or type(callback) ~= 'function' or host == nil then
            return false, 'invalid HTTP request'
        end
        local current = pending[key]
        if current ~= nil then
            if current.url ~= url then return false, 'request key already uses another URL' end
            current.callback = callback
            return true
        end
        if type(HttpRequest) ~= 'function' then return false, 'host asynchronous HttpRequest is unavailable' end
        local count = 0
        for _ in pairs(pending) do count = count + 1 end
        if count >= maxPending then return false, 'HTTP request queue is full' end
        pending[key] = { key = key, url = url, host = host, port = port, path = path,
            queuedAt = Now(), callback = callback }
        return true
    end

    M.CloseWebRequests = function()
        closed = true
        for key, request in pairs(pending) do
            if request.flight then
                request.flight.retired, request.flight.body = true, nil
            end
            request.callback = nil
            pending[key] = nil
        end
    end

    M.PollWebRequests = function()
        if closed or next(pending) == nil then return end
        if lastPollAt ~= nil and TimeSince(lastPollAt) < pollInterval then return end
        lastPollAt = Now()
        local finished = {}
        for key, request in pairs(pending) do
            local flight = request.flight
            if flight and flight.done and flight.completedAt - request.queuedAt < timeout then
                pending[key] = nil
                finished[#finished + 1] = { request = request, body = flight.body, err = flight.err }
                flight.body = nil
            elseif TimeSince(request.queuedAt) >= timeout then
                pending[key] = nil
                if flight then flight.retired, flight.body = true, nil end
                finished[#finished + 1] = { request = request, err = 'HTTP request timed out' }
            elseif flight == nil and transport.flights[request.url] == nil then
                local count = 0
                for _ in pairs(transport.flights) do count = count + 1 end
                if count < maxFlights then
                    request.flight = start(request.url, request.host, request.port, request.path)
                end
            end
        end
        for _, result in ipairs(finished) do
            local callback = result.request.callback
            result.request.callback = nil
            -- A callback may replace/close the owner. Do not deliver its peers to
            -- an old guide; isolate one consumer's error from the other results.
            if not closed then
                M.DiagnosticCall('HTTP', '处理后台请求结果', function()
                    callback(result.body, result.err)
                end, { request = result.request.key })
            end
        end
    end
end

return AsyncHttp
