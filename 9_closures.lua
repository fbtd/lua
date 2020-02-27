#!/usr/bin/env lua

function newCounter ()
    local count = 0
    return function ()
        count = count + 1   -- nonlocal variable
        return count
    end
end

c1 = newCounter()
c2 = newCounter()
print(c1())
print(c2())
print(c1())


print(c1)
print(c2)
