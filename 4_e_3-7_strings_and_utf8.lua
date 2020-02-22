#!/usr/bin/env lua

function insert (s1, i, s2)
    if string.len(s1) ~= utf8.len(s1) then
        i = utf8.offset(s1, i)
    end
    return s1:sub(1,i-1) .. s2 .. s1:sub(i,-1)
end

print(insert("hèllo world", 1, "start:"))                   -- start:hèllo world
print(insert("hèllo world", 7, "small "))                   -- hèllo small world
print()

function remove (s, start, len)
    stop = start + len
    if string.len(s) ~= utf8.len(s) then
        start = utf8.offset(s, start)
        stop  = utf8.offset(s, stop )
    end
    return s:sub(1,start) .. s:sub(stop,-1)
end

print(remove("hello world", 7, 4))                                  -- hello wd
print(remove("ação", 2, 2))                                         -- ao
print(remove("0ü12345ü789", 2, 2))                                  -- 02345ü789
print()


function ispali(s, ignore_spaces)
    if ignore_spaces then
        s = string.gsub(s, " ","")
        s = string.gsub(s, ".","")
        s = string.gsub(s, ",","")
    end
    return s:reverse() == s
end

print(ispali("step on no pets") and "PALI" or "nope")               -- PALI
print(ispali("step on some pets") and "PALI" or "nope")             -- nope
print(ispali("step on no     pets", false) and "PALI" or "nope")    -- nope
print(ispali("step on no     pets", true) and "PALI" or "nope")     -- PALI
print(ispali("step on no,     pets", false) and "PALI" or "nope")   -- nope
print(ispali("step on no,     pets", true) and "PALI" or "nope")    -- PALI
