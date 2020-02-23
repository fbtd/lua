#!/usr/bin/env lua

function seek_back (file, n)
    local n = n or 1
    n = n+1
    local p = file:seek("end",0)
    local lines_form_end = 0
    while p > 0 do
        file:seek("set", p)
        p = p - 1
        if io.read(1) == '\n' then
            n = n - 1
            if n == 0 then
                io.write(io.read("a"))
                return
            end
        end
    end
end

local pos = io.input():seek("end", 0)
if not pos then     -- file not seekable
    local buf = {}
    local index = 1
    for l in io.lines() do
        buf[index] = l
        index = index % (arg[1] or 1) + 1
        print("index ", index)
    end

    for i = index, #buf + index  - 1 do
        io.write(buf[i % #buf + 1])
        io.write('\n')
    end

else                -- file is seekable
    seek_back(io.input(), arg[1] or 1)
end
