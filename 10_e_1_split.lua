#!/usr/bin/env lua

function split (s, sep)
    local t = {}
    local i = 1
    while i <= string.len(s) do
        m_s, m_e = string.find(s, sep, i, true)

        -- no match found       --> what remains is the last piece
        if not (m_s or m_e) then
            t[#t+1] = string.sub(s, i)
            break

        -- match found at i     --> separator - lets skip it
        elseif (m_s == i) then
            i = m_e + 1

        -- match found after i  --> form i to m_s lies a piece
        else
            t[#t+1] = string.sub(s, i, m_s-1)
            i = m_e
        end
    end
    return t
end

strings = {"", " ", "a", "a b c d", "  a     b c    d    "}
for _, s in ipairs(strings) do
    print(s .. ":")
    for k, v in ipairs(split(s, " ")) do
        print(k, ">" .. v .. "<")
    end
    print()
end
