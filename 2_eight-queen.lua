#!/usr/bin/env lua

N = 8   -- board size

-- check whether position (n, c) is free from attacks
function isplaceok (a, n , c)
    checks = checks + 1
    for i = 1, n - 1 do     -- for each queen already in game
        if (a[i] == c) or   -- same column
           (a[i] + (n - i) == c ) or
           (a[i] - (n - i) == c ) then
            return false    -- the place can be attacked
        end
    end
    return true             -- the place is OK
end

-- print a board
function printsolution (a)
    for i = 1, N do
        for j = 1, N do
            io.write(a[i] == j and "X" or "-", " ")
        end
        io.write("\n")
    end
end

-- add to board 'a' all queens from 'n' to 'N'
function addqueen (a, n)
    if (found) then return nil end
    if n > N then
        found = true
        printsolution(a)    -- all queens have been placed
    else                    -- place the nth queen
        for c = 1, N do
            if isplaceok(a, n, c) then
                a[n] = c    -- place a queen
                addqueen(a, n+1)
            end
        end
    end
end

found = false
checks = 0
addqueen({}, 1)
print("checks: ", checks)
