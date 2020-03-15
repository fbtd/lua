#!/usr/bin/env lua

local NWORDS = 2
local MAXGEN = 200
local NOWORD = "\n"
local statetab = {}
math.randomseed(os.time())

function allwords ()
    local line = io.read()
    local pos = 1
    return function ()
        while line do
            local w, e = string.match(line, "(%w+[,;.:]?)()", pos)
            if w then
                pos = e
                return w
            else
                line = io.read()
                pos = 1
            end
        end
        return nil
    end
end

-- TODO: Table structure: prefix.{value, occurrences}
function insert (prefix_table, value)
    prefix = table.concat(prefix_table, " ")
    local list = statetab[prefix]
    if list == nil then
        statetab[prefix] = {value}
    else
        list[#list + 1] = value
    end
end

-- build table
local w = {}
for i = 1, NWORDS do w[i] = NOWORD end

for nextword in allwords() do
    insert(w, nextword)
    table.remove(w, 1)
    table.insert(w, nextword)
end

-- generate text
w = {}
for i = 1, NWORDS do w[i] = NOWORD end

for i = 1, MAXGEN do
    local list = statetab[table.concat(w, " ")]
    local r = math.random(#list)
    local nextword = list[r]
    if nextword == NOWORD then return end
    io.write(nextword, " ")
    table.remove(w, 1)
    table.insert(w, nextword)
end
print()
