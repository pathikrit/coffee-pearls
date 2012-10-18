next_permutation = (p) ->
  i = j = p.length-1
  --i until i is 0 or p[i-1] < p[i]
  if i-- is 0 then return false
  --j until p[i] < p[j]
  [p[i], p[j]] = [p[j], p[i]]
  p[..i].concat p[i+1..].reverse()

p = [1, 2, 3, 4, 5, 6]
i = 0
loop
  console.log ++i, p
  break unless p = next_permutation p
