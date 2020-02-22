#!/usr/bin/env lua

function fact(n)
    n = tonumber(n)
    if n < 0 then return nil end
    if n == 0 then
        return 1
    else
        return n * fact(n - 1)
    end
end

default = 10
print(fact(arg[1] or default))
