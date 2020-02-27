#!/usr/bin/env lua

function newpoly (coefficents)
    return function (x)
        local sum = 0
        local tmp_x = 1
        for _, c in ipairs(coefficents) do
            sum   = sum   + tmp_x * c
            tmp_x = tmp_x * x
        end
        return sum
    end
end

p1 = newpoly({3, 0, 1})
p2 = newpoly({0, 0, 2})

print(p1(0))
print(p1(5))
print(p1(10))
