#!/usr/bin/env lua

bits = 0
--for i = -1, 0, 0 do
i = ~0
while i ~= 0 do
    i = i >> 1
    bits = bits + 1
end
print(bits)

bits = 0
s = string.pack("j",~0)
for i=1, #s do
    v = string.unpack("B", s, i)
    if     v == 255 then bits = bits + 8
    elseif v == 127 then bits = bits + 7
    elseif v == 63  then bits = bits + 6
    elseif v == 31  then bits = bits + 5
    elseif v == 15  then bits = bits + 4
    elseif v == 7   then bits = bits + 3
    elseif v == 3   then bits = bits + 2
    elseif v == 1   then bits = bits + 1
    end
end
print(bits)
