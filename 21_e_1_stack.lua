#!/usr/bin/env lua

Stack = {}
function Stack:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Stack:push (v)
    table.insert(self, v)
end

function Stack:pop (v)
    return table.remove(self)
end

function Stack:top ()
    return self[#self]
end

function Stack:isempty ()
    return #self == 0
end

StackQueue = Stack:new ()
function StackQueue:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function StackQueue:insertbottom (v)
    table.insert(self, 1, v)
end

s = Stack:new()
print(s:isempty())
s:push(111)
print(s:top())

q = StackQueue:new()
q:push(111)
q:insertbottom(112)
q:insertbottom(113)

while not q:isempty() do
    print(q:pop())
end
