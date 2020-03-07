#!/usr/bin/env lua

function listNew()
    return {first = 0, last = -1}
end

function pushFirst (list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end

function pushLast (list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end

function popFirst (list)
    if list.first > list.last then return nil end
    local first_e = list[list.first]
    list[list.first] = nil
    list.first = list.first + 1
    return first_e
end

function popLast (list)
    if list.first > list.last then return nil end
    local last_e = list[list.last]
    list[list.last] = nil
    list.last = list.last - 1
    return last_e
end


myList = listNew()

pushFirst(myList, 1)
pushFirst(myList, 2)
pushFirst(myList, 3)
pushLast(myList, 4)
pushLast(myList, 5)
pushLast(myList, 6)

function printall(list, method)
    local function getMixer ()
        local i = 1
        return function (list)
            i = i + 1
            if i%2 == 0 then return popFirst(list) end
            return popLast(list)
        end
    end
    local f
    if method == "last" then
        f = popLast
    elseif method == "mix" then
        f = getMixer()
    else
        f = popFirst
    end
    while true do
        e = f(myList)
        if e then print(e)
        else return
        end
    end
end

printall(myList, "mix")
