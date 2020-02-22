#!/usr/bin/env lua

angle  = math.pi / 4
height = 10.0

base = height * math.tan(angle)
vol  = base ^2 * math.pi * height / 3

print("vol = ", vol)
