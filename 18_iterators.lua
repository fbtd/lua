#!/usr/bin/env lua

t = {"one", "two", "three", "four"}

function iterator (t, i)
    local r = t[i+1]
    local i = i+1
    if not r then i = nil end
    return i, r
end

function ipairs2 (t)
    return iterator, t, 0
end

for k, v in ipairs2(t) do
    print(k, v)
end
