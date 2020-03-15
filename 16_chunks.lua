#!/usr/bin/env lua

g = "global"

chunky = [[
a, b, c = ...
print("a = ", a)
print("b = ", b)
print("c = ", c)
]]


f = assert(load(chunky))
f(1,2,3)
