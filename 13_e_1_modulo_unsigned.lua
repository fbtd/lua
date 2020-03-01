#!/usr/bin/env lua

function umod (n, m)
    if m < 0 then
        if math.ult(n, m) then return n
        else return n - m
        end
    end

    if n < 0 then
        r = ((n >> 1) % m ) << 1
        r = r + (n & 1)   -- if n is odd, bring back the last bit
        return r % m
    end

    return n % m
end


n, m = -65, -59
print(string.format("0x%x %% 0x%x", n, m))
print(string.format("0x%x", umod(n, m)))
print()

n, m = -59, -65
print(string.format("0x%x %% 0x%x", n, m))
print(string.format("0x%x", umod(n, m)))
print()

n, m = -59, 0x100
print(string.format("0x%x %% 0x%x", n, m))
print(string.format("0x%x", umod(n, m)))
print()

print(umod(19, 10))
