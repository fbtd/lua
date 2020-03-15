#!/usr/bin/env lua

local function iterator (self, index)
    if index >= #self-1 then return nil end
    return index + 1, self[index + 1]
end

function fileAsArray (fname)

    local f = io.open(fname, "r+")
    assert(f, "error in opening " .. fname)

    local mt = {
        __index = function (_, index)
            f:seek("set", index)
            return f:read(1)
        end,

        __newindex = function (_, index, v)
            f:seek("set", index)
            assert(f:write(v))
        end,

        __pairs = function (self)
            return iterator, self, 0
        end,

        __len = function (_)
            return f:seek("end")
        end
    }

    local array = {}
    setmetatable(array, mt)

    return array
end

array = fileAsArray "./tmpfiles/out.txt"
print(array[6])
array[6] = 'x'
print(#array)

for i, c in pairs(array) do
    print(i, c)
end
