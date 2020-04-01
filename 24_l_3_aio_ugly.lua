#!/usr/bin/env lua

local cmdQueue = {} -- queue for pending operations
local lib = {}

function lib.readline (stream, callback)
    local nextCmd = function ()
        callback(stream:read())
    end
    table.insert(cmdQueue, nextCmd)
end

function lib.wirteline (stram, line, callback)
    local nextCmd = function ()
        callback(stream:write(line))
    end
    table.insert(cmdQueue, nextCmd)
end

function lib.stop ()
    table.insert(cmdQueue, "stop")
end

function lib.runloop ()
    while true do
        local NextCmd = table.remove(cmdQueue, 1)
        if nextCmd == "stop" then
            break
        else
            nextCmd()
        end
    end
end

return lib
