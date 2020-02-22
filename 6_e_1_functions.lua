#!/usr/bin/env lua

-- 6.1
function printall (t)
    print(table.unpack(t))
end
printall({1,2,3})

-- 6.2
function skip_first (...)
    return select(2, ...)
end
print(skip_first(1,2,3,4))

-- 6.3
function skip_last (...)
    local p = table.pack(...)
    table.remove(p)
    return table.unpack(p)
end
print(skip_last(1,2,3,4))

-- 6.4
function shuffle (...)
    local t = table.pack(...)
    local r = {}
    while #t > 1 do
        r[#r + 1] = table.remove(t, math.random(1, #t))
    end
    return table.unpack(r)
end

c = 0
N = 1e3 +1
for i = 1, N do
    first = shuffle(1,2,3,4)
    if first == 1 then c = c + 4 end
end
print(c/N)  -- about 1.0
print()

-- 6.5  no recursion!
function print_all_comb (t)
    permutations = {t}
    stage_end   = 1
    index = 1
    for stage = 2, #t do                -- for each element in t...
        old_stage_end = stage_end
        stage_end = stage_end * stage
        stage_start = old_stage_end + 1
--      print("stage: ", stage, stage_start, " > ", stage_end)
        for i = 1, stage_start - 1 do    -- for each already computed permutation...
            for j = 1, stage - 1 do      -- swap the t[stage] element in all possible positions
                index = index + 1
                -- deepcopy of a "possible position"
                permutations[index] = {}
                table.move(permutations[i], 1, #t, 1, permutations[index])
                -- the actual permutatin
                old_j = permutations[i][j]
                permutations[index][j] = t[stage]
                permutations[index][stage] = old_j
            end
        end
    end
    print "permutations:"
    for _,p in ipairs(permutations) do
        printall(p)
    end
end
print_all_comb({1,2,3})
--print_all_comb({"a", "b", "c", "d"})
