next_permutation = (p) ->
  n = p.length
  a = i for i in [0...n-1] when p[i] < p[i+1]
  if a is undefined then return false
  b = i for i in [a+1...n] when p[a] < p[i]
  [p[a], p[b]] = [p[b], p[a]]
  p[..a].concat p[a+1..].reverse()

p = [1, 2, 3, 4, 5, 6]
i = 0
loop
  console.log ++i, p
  break unless p = next_permutation p
  
