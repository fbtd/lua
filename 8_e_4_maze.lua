#!/usr/bin/env lua

moves = 0

function printmoves ()
    moves = moves + 1
    if moves % 1e6 == 0 then
        print(moves)
    end
end

function room1 ()
    printmoves()
    local move = io.read()
    if move == "s" then
        return room3()
    elseif move == "e" then
        return room2()
    else
        print "invalid move"
        return room1()
    end
end

function room2 ()
    printmoves()
    local move = io.read()
    if move == "s" then
        return room4()
    elseif move == "w" then
        return room1()
    else
        print "invalid move"
        return room2()
    end
end

function room3 ()
    printmoves()
    local move = io.read()
    if move == "n" then
        return room1()
    elseif move == "e" then
        return room4()
    else
        print "invalid move"
        return room3()
    end
end

function room4 ()
    printmoves()
    print "YOU WIN!"
end

room1()

--[[ ~/lua $ yes 's
n' | ./8_e_4_maze.lua
1000000
2000000
3000000
...
--]]
