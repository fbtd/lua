#!/usr/bin/env lua

-- serialize numbers, strings and booleans
function basicSerialize (o)
    return string.format("%q", o)
end

function save (name, value, saved)
    saved = saved or {}
    local t = type(value)
    io.write(name, " = ")
    if t == "number" or t == "string" or t == "boolean" or t == "nil" then
        io.write(basicSerialize(value), "\n")
    elseif t == "table" then
        if saved[value] then
            io.write(saved[value], "\n")
        else
            saved[value] = name
            io.write("{}\n")
            for k, v in pairs(value) do
                k = basicSerialize(k)
                local fname = string.format("%s[%s]", name, k)
                save(fname, v, saved)
            end
        end
    else
        error("cannot save a " .. t)
    end
end

a = {x=1, y=2, {3,4,5}}
a[2] = a
a.z = a[1]

save("a", a)
