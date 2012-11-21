n = 4
concat = sum = (a,b) -> a+b
hex = (n) -> n.toString(16)
valid = (x) -> x isnt null and x isnt undefined

coordinates = (c) -> x: c%n, y: (c - c%n)/n

manhattan = (p1, p2) -> Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y)

cost = (puzzle, i) -> manhattan (coordinates i), (coordinates puzzle[i])
score = (puzzle) -> (cost puzzle, i for i in [0...n*n]).reduce sum

hash = (puzzle) -> (puzzle.map hex).reduce concat

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

solve = (puzzle) ->
  q = [puzzle]
  seen = {}
  while q.length > 0
    p = (best q)[0]
    return p if (score p) is 0
    seen[hash p] = true
    (q.push i) for i in next p when not seen[hash i] and score(i) <= score(p)
  return null


puzzle = [          # 0 denotes empty square
   4,  1,  2,  3,
   5,  9, 10,  6,
  12,  8, 15,  7,
  13, 14,  0, 11
]

print = (puzzle) ->
  (console.log 'no solution'; return) if not valid puzzle
  if valid (parent = puzzle.parent) and delete puzzle.parent then print parent
  str = ''
  (str += (if c>9 then ' ' else '  ') + c + (if i%n is n-1 then '\n' else '')) for c, i in puzzle
  console.log str

print solve puzzle
