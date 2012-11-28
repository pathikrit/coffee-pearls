a_star =                        # returns the goal node (or null if path not found). To reconstruct path follow the node.__src till null
  (
    start,                      # starting node
    neighbors,                  # a function that takes in a node and returns list of neighbors
    h,                          # heuristic distance from goal - must be 'admissable' i.e. heurisitic(x) <= distance(x,y) + heuristic(y) for all x,y
    dist = -> 1,                # takes two adjacent nodes (from neighbours) and returns distance between them (optional - default is 1)
    isGoal = (x) -> h(x) is 0   # returns true off node is goal (optional - assumes heurisitc(goal) = 0)
  ) ->

    closed = {}                 # set of nodes already evaluated
    open = [start]              # set of tentative nodes to be evaluated

    g = []                      # 'g-score' - the exact cost to reach this node from start
    g[start] = 0

    while true
      c = null                  # todo: we should use priorityqueue to store nodes with priority = 'F-score' i.e. F = G + H
      c = n for n in open when not c or g[n] + h(n) < g[c] + h(c)
      if not c or isGoal c then return c
      open.splice open.indexOf(c), 1
      closed[c] = true

      for n in neighbors c when not closed[n] and (n not in open or g[c] + dist(c, n) <= g[n])
        n.__src = c
        g[n] = g[c] + dist(c, n)
        open.push n unless n in open

module.exports = a_star