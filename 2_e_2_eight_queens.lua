#!/usr/bin/env lua

N = 7   -- board size

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

-- check whether board 'a' is a valid solution
function isboardok_old (a)
    for i = 1, N do
        if not isplaceok(a, i, a[i]) then
            return false
        end
    end
    return true
end

-- check whether board 'a' is a valid solution
function isboardok (a)
    ---[[
    total = 0
    for i = 1, N do     -- check coulums
        total = total + a[i]
    end
    if total ~= N * (N+1) /2 then
        return false
    end
    --]]
    return isboardok_old(a)
end

-- print a board
function printsolution (a)
    for i = 1, N do
        for j = 1, N do
            io.write(a[i] == j and "X" or "-", " ")
        end
        io.write("\n")
    end
    io.write("\n")
end

-- generate the nth board
function genboard (n)
    i = 1
    a = {}
    while i <= N do
        a[i] = n % N + 1
        n = n // N
        i = i + 1
    end
    return a
end

checks = 0
for i = 0, N^N-1 do
    b = genboard(i)
    if i % 10000 == 0 then
        printsolution(b)
    end
    if isboardok(b) then
        printsolution(b)
        break
    end
end
print("checks: ", checks)
