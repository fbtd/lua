#!/usr/bin/env lua

function receive ()
    local status, value = coroutine.resume(p)
    return value
end

function send (v)
    coroutine.yield(v)
end

function producer ()
    for i=1, 5 do
        os.execute("sleep 1")
        send(os.time())
    end
end

function consumer ()
    while true do
        local v = receive()
        if v == nil then return end
        print("--" .. v .. "--")
    end
end

p = coroutine.create(producer)
consumer()
