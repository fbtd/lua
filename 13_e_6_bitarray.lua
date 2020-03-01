#!/usr/bin/env lua

function newBitArray (n)
    return string.pack("c" .. n // 8 + 1, "")
end

function setBit (a, n, v)
    local index = n // 8 + 1
    local bit_index = n % 8

    local byte = string.byte(a, index)
    if v then byte = byte | (1 << bit_index)
    else      byte = byte & ~(1 << bit_index) end
    char = string.pack("c1", string.char(byte))
    return string.sub(a, 1, index - 1) .. char .. string.sub(a, index + 1)
    
end

function testBit(a, n)
    local index = n // 8 + 1
    local bit_index = n % 8
    local byte = string.byte(a, index, index) 
    return byte & (1 << bit_index) ~= 0
end

a = newBitArray(100)
a = setBit(a, 3, true)
a = setBit(a, 28, true)
print(testBit(a, 0))
print(testBit(a, 1))
print(testBit(a, 2))
print(testBit(a, 3))
print(testBit(a, 4))
print(testBit(a, 28))
print(testBit(a, 29))
a = setBit(a, 28, false)
a = setBit(a, 29, true)
print(testBit(a, 28))
print(testBit(a, 29))
print(testBit(a, 3))
