#!/usr/bin/env lua

longlist = {}
for i = 1, 1e5 do
    table.insert(longlist, i)
end

function my_concat (t, sep)
    s = t[1]
    for i = 2, #t do
        s = s .. sep .. t[i]
    end
    return s
end

start_time = os.time()
cll = table.concat(longlist, " ")
print("BUILTIN - len: ", #cll, " time: ", os.time() - start_time)

start_time = os.time()
cll = my_concat(longlist, " ")
print("MINE    - len: ", #cll, " time: ", os.time() - start_time)
