#!/usr/bin/env lua

function f (x, u, o)
    return 1 / (o * (2 * math.pi)^.5) * math.exp(-0.5 * ((x-u)/o)^2)
end

function z0 (u1, u2)
    return math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
end

std_1_count = 0

for i = 1, 1000001 do
    u1 = math.random()
    u2 = math.random()
    result = z0(u1,u2) 
    if result < 1 and result > -1 then
        std_1_count = std_1_count +1
    end
end

print(std_1_count)
