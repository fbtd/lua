#!/usr/bin/env lua

function printResult (a)
    for i = 1, #a do
        io.write(a[i], " ")
    end
    io.write("\n")
end

function permgen (a,n)
    n = n or #a
    if n <= 1 then
        coroutine.yield(a)
    else
        for i = 1, n do

            -- put the i-th element as the last one
            a[i], a[n] = a[n], a[i]

            -- generate all permutations of the other element
            permgen(a, n-1)

            -- restore the i-th element
            a[i], a[n] = a[n], a[i]
        end
    end
end

function permutations (t)
--  local co = coroutine.create(function () permgen(t) end)
--  return function ()
--      status, value = coroutine.resume(co)
--      return value
--  end
-- EQUIVALENT TO
    return coroutine.wrap(function () permgen(t) end)
end

for p in permutations({1,2,3,4}) do
    printResult(p)
end
