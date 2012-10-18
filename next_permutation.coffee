next_permutation = (p) ->
  i = j = p.length-1
  --i until i is 0 or p[i-1] < p[i]
  if i-- is 0 then return false
  --j until p[i] < p[j]
  [p[i], p[j]] = [p[j], p[i]]
  p[i+1..] = p[i+1..].reverse()
  return true

permute = (n, callback = console.log) ->
  callback c = 0, p = [1..n]
  callback ++c, p while next_permutation p

permute 4
