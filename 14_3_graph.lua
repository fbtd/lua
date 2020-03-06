#!/usr/bin/env lua

local function name2node (graph, name)
    local node = graph[name]
    if not node then    -- make a new node
        node = {name = name, adj = {}}
        graph[name] = node
    end
    return node
end

function readgraph ()
    local graph = {}
    for line in io.lines() do
        namefrom, nameto = string.match(line, "(%S+)%s+(%S+)")
        local from = name2node(graph, namefrom)
        local to   = name2node(graph, nameto)
        from.adj[to] = true
    end
    return graph
end

function printgraph (graph)
    graph_seq = {}
    for nodename, node in pairs(graph) do
        table.insert(graph_seq, node)
    end
    table.sort(graph_seq, function(n1, n2) return n1.name < n2.name end)

    for _, node in ipairs(graph_seq) do
        print("node:", node.name)
        for adj, active in pairs(node.adj) do
            if active then print(" - ", adj.name) end
        end
    end
end

function format_path (paths, verbose)
    if verbose then
        print()
        for depth_n, _ in ipairs(paths) do
        print("depth: ", depth_n)
            for n, path_n in ipairs(paths[depth_n]) do
                print("    path: ", n)
                print("        prev: ", path_n.prev)
                print("        node: ", path_n.node.name)
            end
        end
    end
    local result = {}
    local path_n = #paths[#paths]
    for i = #paths, 0, -1 do
        result[i] = paths[i][path_n]["node"]
        path_n    = paths[i][path_n]["prev"]
        if not path_n then return result end
    end
end

function findpath (start, dest)
    local paths     = {{{node = start}}}
    local visited   = {start=true}
    local depth     = 1
    while true do
        paths[depth+1] = {}
        for i, path in ipairs(paths[depth]) do
            for a in pairs(path["node"].adj) do
                io.write(".")
                if not visited[a] then
                    visited[a] = true
                    table.insert(paths[depth+1], {prev = i, node = a})
                    if a == dest then   -- FOUND
                        return format_path(paths, true)
                    end
                end
            end
        end
        depth = depth+1
        if depth > (MAXDEPTH or 100) then
            error("max depth reached")
        end
    end
end

g = readgraph()
-- printgraph (g)

a = name2node(g, "a")
d = name2node(g, "somewhere")
path = findpath(a, d)
print()
for _, p in ipairs(path) do
    print(p.name)
end
