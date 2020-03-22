#!/usr/bin/env lua

local print = print     -- print is no logner a free name
function foo (_ENV, a)
    print(a+b)          -- local a + _ENV.b
end
foo({b=14}, 12)         -- 12 + 14
foo({b=10}, 1)          -- 1 + 10
