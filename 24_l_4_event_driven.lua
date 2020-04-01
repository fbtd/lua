#!/usr/bin/env lua

-- TODO p247

local lib = require "24_l_3_aio_ugly"

local t = {}
local imp = io.input()
local out = io.output()
local i

-- write-line handler
local function putline ()
end

-- read-line handler
local function getline ()

end

lib.readline(inp, getline)
lib.runloop()
