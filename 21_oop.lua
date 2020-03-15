#!/usr/bin/env lua

Account = {balance=0}

-- function Account.new (self, o)
function Account:new (o)
    o = o or {}
    self.__index = self
    setmetatable(o, self)
    return o
end

function Account:deposit (v)
    self.balance = self.balance + v
end

function Account:withdraw (v)
    if self.balance < v then error "insufficent founds" end
        self.balance = self.balance - v
end

-- a = Account.new(Account)
a = Account:new()
a:deposit(1000)
a:withdraw(200)
print(a.balance)

--> Account.new(self = Account)
SpecialAccount = Account:new()

--> Account.new(self = SpecialAccount)
s = SpecialAccount:new{limit=1000}
