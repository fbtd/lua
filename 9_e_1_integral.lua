#!/usr/bin/env lua

function integration (f, step)
    local step = step or 1e-4
    return function (from, to)
        local integral = 0
        for i = from, to, step do
            integral = integral + f(i) * step
        end
        return integral
    end
end

A = 1
function a (x)
    return A
end

ax = integration(a)
print(ax(0,10))

print(math.sin(1), integration(math.cos,1e-7)(0,1))
