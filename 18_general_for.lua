-- general for:
for var_1, ... , var_n in <exprlist> do <block> end

-- is equilvalent to:
do
    -- _f: iterator function
    -- _s: invariant state
    -- _var: control variable
    local _f, _s, _var = <explist>
    while true do
        local var_1, ... , var_n  = _f(_s, _var)
        _var = var_1
        if _var == nil then break end
        <block>
    end
end
