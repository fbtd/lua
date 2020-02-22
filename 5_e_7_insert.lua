#!/usr/bin/env lua

l1  = {1, 2, 3 , 4, ["a"] = "A", ["b"] = "B"}
l10 = {10, 20, 30 , 40, ["a"] = "AA", ["b"] = "BB"}

function add_to_list (pos, src_l, dest_l)
    table.move(src_l, pos, pos + #dest_l, pos + #dest_l)
    table.move(dest_l, 1, #dest_l, pos, src_l)
    return src_l
end

function print_table (t)
    for k, v in pairs(t) do
        print(k, " - ", v)
    end
end

add_to_list(3, l1, l10)
print_table(l1)
