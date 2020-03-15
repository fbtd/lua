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

placeholder = {}
-- prints a table
function save_c (name, value, isSeq, pname, saved)   -- name: nil = element of sequence
    local saved = saved or {}
    if saved[value] then
        if not isSeq then io.write(pname .. " = ") end
        io.write(saved[value])
    end
    saved[value] = name
    local pname = pname or name

    if not isSeq then io.write(pname .. " = ") end
    io.write("{")
    
    local max_index = 0
    for i, v in ipairs(value) do
        max_index = i
        local t = type(v)
        if t == "number" or t == "string" or t == "boolean" or t == "nil" then
            io.write(basicSerialize(v) .. ", ") -- TODO no "," if last (compare #value)
        elseif t == "table" then
            if saved[v] then        -- is it referring to a saved table?
                io.write(saved[v])
            else
                local fname = name .. "[" .. i .. "]"
                save_c(fname, v, true, saved)
            end
            io.write(", ")
        else
            error("cannot save a " .. t)
        end
    end

    for k, v in pairs(value) do
        if (math.tointeger(k) or math.huge) > max_index then
            -- TODO depending on type, name it ["X"] or .X
            local t = type(v)
            if t == "number" or t == "string" or t == "boolean" or t == "nil" then
                io.write(basicSerialize(k) .. " = " ..  basicSerialize(v) .. ", ")
            elseif t == "table" then
                if saved[v] then        -- is it referring to a saved table?
                    print("X")
                    io.write(basicSeialize(k) .. " = " .. saved[v])
                else
                    local fname = name .. "[" .. basicSerialize(k) .. "]"
                    local pname = basicSerialize(k)
                    save_c(fname, v, false, pname, saved)
                end
                io.write(", ")
            else
                error("cannot save a " .. t)
            end
        end
    end

    io.write("}")
end

a = {x=1, y=2, {3,4,5}, "hello", t = {11,22,33}}
a[3] = a
a.z = a[1]

save("a", a)
-- ~/lua $ ./15_e_5_serialization.lua
-- a = {}
-- a[1] = {}
-- a[1][1] = 3
-- a[1][2] = 4
-- a[1][3] = 5
-- a[2] = a
-- a["z"] = a[1]
-- a["x"] = 1
-- a["y"] = 2
print()

save_c("a", a)
print()
