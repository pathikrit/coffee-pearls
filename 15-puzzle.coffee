n = 4       # for 15-puzzle n is 4 i.e. sqrt(15 + 1)

concat = sum = (a,b) -> a+b
valid = (x) -> x isnt null and x isnt undefined

score = (puzzle) -> (cost puzzle, i for i in [0...n*n]).reduce sum
cost = (puzzle, i) -> manhattan (coordinates i), (coordinates puzzle[i])

coordinates = (c) -> x: c%n, y: (c - c%n)/n

manhattan = (p1, p2) -> Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y)

hash = (puzzle) -> (puzzle.map (n) -> n.toString(16)).reduce concat

swap = (puzzle, a, b) ->
  q = puzzle.slice 0
  q.parent = puzzle
  [q[a], q[b]] = [q[b], q[a]]
  return q

move = (puzzle, direction) ->
  z = puzzle.indexOf 0
  offset = switch direction
    when    'up' then -n unless z-n <  0
    when  'down' then +n unless z+n >= n*n
    when  'left' then -1 unless z%n is 0
    when 'right' then +1 unless z%n is n-1
  swap puzzle, z, z+offset unless not valid offset

next = (puzzle) -> (move puzzle, dir for dir in ['up', 'down', 'left', 'right']).filter valid

best = (puzzles) ->
  p = i for puzzle, i in puzzles when (not valid p) or (score puzzle) < score puzzles[p]
  puzzles.splice p, 1

solve = (start) ->
  q = [start]
  seen = {}
  while q.length > 0
    puzzle = (best q)[0]
    return puzzle if (score puzzle) is 0
    seen[hash puzzle] = true
    (q.push i) for i in next puzzle when not seen[hash i] and (score i) <= (score puzzle)
  return null

module.exports = solve

puzzle = [          # 0 denotes empty square
   4,  9,  3,  6,
   5,  2, 10,  0,
  12,  8,  7,  1,
  13, 14, 15, 11
]

print = (puzzle, move = 0) ->
  (console.log 'no solution'; return) if not valid puzzle
  if valid (parent = puzzle.parent) and delete puzzle.parent then print parent, move+1
  str = "Position #{move}:\n"
  (str += (if c>9 then ' ' else '  ') + c + (if i%n is n-1 then '\n' else '')) for c, i in puzzle
  console.log str

print solve puzzle
