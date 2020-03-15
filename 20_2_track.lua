#!/usr/bin/env lua

function track (t)
    local proxy = {}

    -- metatable for proxy
    local mt = {
        __index = function (_, k)
            print("*access to element " .. tostring(k))
            return t[k]
        end,

        __newindex = function(_, k, v)
            print("*update to element " .. tostring(k) .. " - value is now " .. tostring(v))
            t[k] = v
        end,

        __pairs = function ()
            return function (_, k)  -- the interator
                local nextkey, nextvalue = next(t, k)
                if nextkey ~= nil then
                    print("*traversing element " .. tostring(nextkey))
                end
                return nextkey, nextvalue
            end
        end,

        __len = function () return #t end
    }

    setmetatable(proxy, mt)
    return proxy
end
