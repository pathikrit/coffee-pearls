n = 4       # for 15-puzzle n is 4 i.e. sqrt(15 + 1)

score = (puzzle) ->
  manhattan = (i) -> Math.abs(i%n - puzzle[i]%n) + Math.abs((i-i%n)/n - (puzzle[i] - puzzle[i]%n)/n)
  (puzzle.map manhattan).reduce (a,b) -> a+b

next = (puzzle) ->
  z = puzzle.indexOf 0

  swap = (y) ->
    q = puzzle.slice 0
    [q[z], q[y]] = [q[y], q[z]]
    return q

  [
    swap z-n unless z-n <  0
    swap z+n unless z+n >= n*n
    swap z-1 unless z%n is 0
    swap z+1 unless z%n is n-1
  ].filter (x) -> x isnt undefined

solve = (start) -> require('./a_star') start, next, score

module.exports = solve

puzzle = [          # 0 denotes empty square
   4,  9,  3,  6
   5,  2, 10,  0
  12,  8,  7,  1
  13, 14, 15, 11
]

print = (puzzle, move = 0) ->
  if not puzzle then (console.log 'no solution'; return)
  if (parent = puzzle.__src) and delete puzzle.__src then print parent, move+1
  str = "Position #{move}:\n"
  (str += (if c>9 then ' ' else '  ') + c + (if i%n is n-1 then '\n' else '')) for c, i in puzzle
  console.log str

print solve puzzle
