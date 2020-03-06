#!/usr/bin/env lua

function mul (a, b)
    local c
    for i = 1, #a do
        local resultline = {}               -- will contain c[i]
        for k, va in pairs(a[i]) do         -- va = a[i][k]
            for j, vb in pairs(b[k]) do     -- vb = b[k][j]
                local res = (resultline[j] or 0) + va * vb
                resultline[j] = (res ~= 0) and res or nul
            end
        end
        c[i] = resultline
    end
    return c
end
