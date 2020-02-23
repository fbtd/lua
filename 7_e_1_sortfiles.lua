#!/usr/bin/env lua

function sortfile ()
    local lines_in = {}
    for l in io.input():lines("L") do
        lines_in[#lines_in+1] = l
    end
    table.sort(lines_in)
    for _, l in ipairs(lines_in) do
        io.write(l)
    end
end

if arg[2] and os.rename(arg[2], arg[2]) then
    io.write(string.format('overwrite file %s? enter "y" to confirm\n', arg[2]))
    if io.read() ~= "y" then
        os.exit()
    end
end

io.input(arg[1])
io.output(arg[2])
sortfile()
