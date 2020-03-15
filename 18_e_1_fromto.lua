#!/usr/bin/env lua

function iterator(stop_step, current)
    local stop, step = stop_step.stop, stop_step.step
    if current+step > stop then return nil end
    return current + step
end

function fromto(start, stop, step)
    return iterator, {stop=stop, step=step or 1}, start-(step or 1)
end

for i in fromto(-2,12,3) do
    print(i)
end
