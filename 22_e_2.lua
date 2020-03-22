#!/usr/bin/env lua

local foo
do
    local _ENV = _ENV
    function foo () print(X) end    -- foo is a local variable, X is a free name
                                    -- X referst to the original _ENV.X
end
X=13        -- set _ENV.X (in the original ENV, of which foo has a reference (upvalue)
_ENV = nil  -- goodbye global names
foo()       -- prints 13, _ENV(the orginal one).X
X=0         -- _ENV is nil, _ENV.X raises an error
