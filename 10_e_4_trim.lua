#!/usr/bin/env lua

function original_trim (s)
    return string.gsub(s, "^%s*(.-)%s*$", "%1")
end

function new_trim (s)
    start = string.find(s, "%s*()")
    for i = string.len(s), start, -1 do
            if (" " ~= string.sub(s, i, i)) then
            return string.sub(s, start, i+1)
        end
    end
end

quad = "x" .. string.rep(" ", 10 * 0x1p10 - 2) .. "x"
print("starting...")
time = os.time()
s = original_trim(quad)
print("original time: ", os.time() - time, "seconds")        -- 14 seconds
time = os.time()
s = new_trim(quad)
print("new trim time: ", os.time() - time, "seconds")        --  0 seconds
print(s)
