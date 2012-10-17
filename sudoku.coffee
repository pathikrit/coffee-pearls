solve = (sudoku, cell = 0) ->
  if cell is 9*9 then return sudoku

  x = cell%9
  y = (cell - x)/9

  if sudoku[x][y] isnt 0 then return solve sudoku, cell+1

  row = (i) -> sudoku[x][i]
  col = (i) -> sudoku[i][y]
  box = (i) -> sudoku[x - x%3 + (i - i%3)/3][y - y%3 + i%3]

  good = (guess) -> [0...9].every (i) -> guess not in [row(i), col(i), box(i)]

  guesses = [1..9].filter good

  solves = (guess) -> sudoku[x][y] = guess; solve sudoku, cell+1

  (guesses.some solves) or sudoku[x][y] = 0

### example usage ###
sudoku = [
  [1,0,0,0,0,7,0,9,0],
  [0,3,0,0,2,0,0,0,8],
  [0,0,9,6,0,0,5,0,0],
  [0,0,5,3,0,0,9,0,0],
  [0,1,0,0,8,0,0,0,2],
  [6,0,0,0,0,4,0,0,0],
  [3,0,0,0,0,0,0,1,0],
  [0,4,0,0,0,0,0,0,7],
  [0,0,7,0,0,0,3,0,0]
]
console.log if solve sudoku then sudoku else 'could not solve'