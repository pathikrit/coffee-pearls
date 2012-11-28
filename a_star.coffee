a_star =                        # returns the goal node (or null if path not found). To reconstruct path follow the node.__src till null
  (
    start,                      # starting node
    neighbors,                  # a function that takes in a node and returns list of neighbors
    h,                          # admissable A* heuristic distance from goal i.e. heurisitic(x) <= distance(x,y) + heuristic(y) for all x,y
    dist = -> 1,                # takes two adjacent nodes (from neighbours) and returns distance between them (optional - default is 1)
    isGoal = (x) -> h(x) is 0   # returns true off node is goal (optional - assumes heurisitc(goal) = 0)
  ) ->

    seen = {}                   # set of nodes already evaluated
    q = {}                      # set of tentative nodes to be evaluated, the value is the 'f_score' (F = G + H)
    g = []                      # 'g-score' - the exact cost to reach this node from start

    add = (node, parent) ->
      node.__src = parent
      g[node] = if parent? then g[parent] + dist parent, node else 0
      q[node] = g[node] + h(node)

    remove_best = ->
      best = node for node,f of q when not best or f < q[best]
      if best then seen[best] = true; delete q[best]
      return best

    add start, null

    while true
      c = remove_best()
      if c is null or isGoal c then return c
      add n, c for n in neighbors c when not seen[n] and (q[n] is null or g[c] + dist(c, n) <= g[n])

module.exports = a_star