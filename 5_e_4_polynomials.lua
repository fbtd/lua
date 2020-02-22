#!/usr/bin/env lua

function calc_poly (p, x)
    t = 0
    for k, v in pairs(p) do
        t = t + x^k * v
    end
    return t
end

function isseq (t)
    nkeys = 0
    for k, _ in pairs(t) do
        nkeys = nkeys + 1
    end
    return #t == nkeys
end

function fill_holes (t)
    if #t == 0 then return t end
    -- find the maximal key
    k_max = 0
    for k, _ in pairs(t) do
        if k > k_max then k_max = k end
    end

    -- fill in the holes with zeroes
    for i = 0, k_max do
        t[i] = t[i] or 0
    end
    return t
end

function calc_poly_noexp (p, x)
    fill_holes(p)
    x_orig = x
    t = p[0]
    for i=1, #p do
        t = t + p[i] * x
        x = x * x_orig
    end
    return t
end

p = {[0]=1000, 4, 1, nil, 1} -- holes
q = {[0]=1000, 4, 1, 0, 1}   -- no holes
print(calc_poly(p, 2))       -- 1028 = 1000 * 2^0 + 4 * 2^1 + 1 * 2^2 + 1 * 2^4
print(calc_poly_noexp(p, 2)) -- 1028

s = {1, 2, 3, 4}
print(isseq(s) and "s is a sequence" or "s is not a seqence")   -- sequence
print(isseq(p) and "p is a sequence" or "p is not a seqence")   -- nope
print(isseq(q) and "q is a sequence" or "q is not a seqence")   -- nope
