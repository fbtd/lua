#!/usr/bin/env lua

function copyfile (format)
    while true do
        mem = io.input():read(format)
        if not mem or (format == "a" and mem == "") then return end
        io.write(mem)
    end
end

copyfile(tonumber(arg[1]) or arg[1])

--[[
~/lua $ time ./7_e_3_copyfiles.lua l < tmpfiles/in.txt >tmpfiles/out.txt
real    0m0.872s
user    0m0.782s
sys     0m0.021s

~/lua $ time ./7_e_3_copyfiles.lua 1 < tmpfiles/in.txt >tmpfiles/out.txt
real    0m10.896s
user    0m10.779s
sys     0m0.092s

~/lua $ time ./7_e_3_copyfiles.lua $((8*1024)) < tmpfiles/in.txt >tmpfiles/out.txt
real    0m0.052s
user    0m0.022s
sys     0m0.030s

~/lua $ time ./7_e_3_copyfiles.lua a < tmpfiles/in.txt >tmpfiles/out.txt
real    0m0.056s
user    0m0.011s
sys     0m0.045s
--]]
