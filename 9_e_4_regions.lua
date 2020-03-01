#!/usr/bin/env lua

empty = function (x, y) return false end

function newdisk (cx, cy, r)
    return function (x, y)
        return (x - cx)^2 + (y - cy)^2 <= r^2
    end
end


function newrectangle (p1x, p1y, p2x, p2y)
    return function (x, y)
        return ((p1x <= x and x <= p2x) or (p2x <= x and x <= p1x)) and
               ((p1y <= y and y <= p2y) or (p2y <= y and y <= p1y))
    end
end

function newmoon (cx, cy, r)
    local outer = newdisk(cx, cy, r)
    local inner = newdisk(cx + r*0.5, cy, r * 1.1)
    return difference(outer, inner)
end

function union (r1, r2)
    return function (x, y)
        return  r1(x, y) or r2(x, y)
    end
end

function intersection (r1, r2)
    return function (x, y)
        return  r1(x, y) and r2(x, y)
    end
end

function difference (r1, r2)
    return function (x, y)
        return  r1(x, y) and not r2(x, y)
    end
end

function rotate_center (r, angle)
    return function (x, y)
        local radius = (x^2 + y^2)^0.5
        local cur_angle = math.acos(x/radius)
        if y < 0 then cur_angle = -cur_angle end
        local new_angle = cur_angle - angle
        local nx = math.cos(new_angle) * radius
        local ny = math.sin(new_angle) * radius
        do return r(nx, ny) end
--      print(x, y, cur_angle, new_angle)
--      print()
--      print(x,y, r(x,y))
--      print(nx,ny, r(nx, ny))
    end
end

function translate (r, dx, dy)
    return function (x, y)
        return r(x - dx, y - dy)
    end
end

function rotate (r, cx, cy, angle)
    return translate(rotate_center(translate(r, -cx, -cy), angle), cx, cy)
end

function plot (r, M, N)
    for y = N/2, -N/2, -1 do
        for x = -M/2, M/2 do
            if (x == 0 and y == 0) then
                io.write("@")
            else
                io.write(r(x, y) and "#" or " ")
            end
        end
        io.write("\n")
    end
end

d1 = newdisk(-10,0,10)
d2 = newdisk(20,20,5)
r1 = newrectangle(0,0,10,5)
-- plot(union(d1, r1), 40, 30)
-- plot(newmoon(0,0,10), 40,30)
plot(rotate(r1, 10, 0, math.pi/2), 50, 36)
-- plot(translate(r1, 0, 0), 40, 30)
