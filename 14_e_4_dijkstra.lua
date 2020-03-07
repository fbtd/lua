#!/usr/bin/env lua

function addarc (node, dest_node, cost)
    local arc = {cost = cost, dest_node = dest_node}
    node[arc] = true
end

function readgraph ()
    local graph = {}
    local inv_graph = {}

    for line in io.lines() do
        namefrom, nameto, dist = string.match(line, "(%S+)%s+(%S+)%s+(%S+)")
        dist = tonumber(dist)

        if not graph[namefrom] then
            graph[namefrom] = {}
            inv_graph[graph[namefrom]] = namefrom
        end
        if not graph[nameto] then
            graph[nameto] = {}
            inv_graph[graph[nameto]] = nameto
        end

        addarc(graph[namefrom], graph[nameto], dist)

    end
    return graph, inv_graph
end

function printgraph (graph, inv_graph)
    for node_name, node in pairs(graph) do
        print(node_name)
        for arc in pairs(node) do
            print(" c: " .. arc.cost .. "  d: " .. inv_graph[arc.dest_node])
        end
        print()
    end
end

function getCloserNode (tentatives, visited)
    local min_dist = math.huge
    local closer_node
    for node, dn in pairs(tentatives) do
        if dn.dist < min_dist and not visited[node] then
            closer_node = node
            min_dist = dn.dist
        end
    end
    return closer_node
end

function dijkstra (graph, start_node, dest_node)
    local visited = {}    -- set of all visited nodes
    local tentatives = { [start_node] = {dist = 0, from = nil}}
    local curr_node

    while not visited[dest_node] do
        curr_node = getCloserNode(tentatives, visited)
        for arc in pairs(curr_node) do
            local curr_dist = tentatives[curr_node].dist
            if not tentatives[arc.dest_node] then
                tentatives[arc.dest_node] = {dist = curr_dist + arc.cost, from = curr_node}
            elseif tentatives[arc.dest_node].dist > curr_dist + arc.cost then
                tentatives[arc.dest_node].dist = curr_dist + arc.cost
                tentatives[arc.dest_node].from = curr_node
            end
        end
        visited[curr_node] = true
    end

    local path = {}
    while curr_node do
        local d = tentatives[curr_node].dist - (tentatives[tentatives[curr_node].from] or {dist = 0}).dist
        table.insert(path, {node=curr_node, dist=d})
        curr_node = tentatives[curr_node].from
    end
    return path
end

function printpath(path, inv)
    for _, nc in pairs(path) do
        print(inv[nc.node], nc.dist)
    end
end


ab_land, inv = readgraph()
-- printgraph(ab_land, inv)
printpath(dijkstra(ab_land, ab_land["a"], ab_land["sw"]), inv)
