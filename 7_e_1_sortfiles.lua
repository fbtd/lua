#!/usr/bin/env lua

function sortfile ()
    local lines_in = {}
    for l in io.lines() do
        lines_in[#lines_in+1] = l
    end
    table.sort(lines_in)
    for _, l in ipairs(lines_in) do
        io.write(l)
    end
end

io.input(arg[1])
io.input(arg[2])
sortfile()
