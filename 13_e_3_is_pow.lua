#!/usr/bin/env lua

function ispow2 (n)
    local i = 1
    repeat
        if n == i then return true end
        i = i << 1
    until i == 0
    return false
end

print(ispow2(10))
print(ispow2(0x1000000000010000))
print(ispow2(1024))
print(ispow2(0x1000000000000000))
print(ispow2(0x0100000000000000))
