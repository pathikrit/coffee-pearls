next_permutation = (p, n = p.length) ->
  break for i in [n-1..1] when p[i-1] < p[i]
  if i is 0 then return false
  p[i..n] = p[i..n].reverse()
  swap = (x,y) -> [p[x], p[y]] = [p[y], p[x]]
  (swap i-1, j; break) for j in [i..n] when p[i-1] < p[j]
  return true

permute = (n, callback = console.log) ->
  callback c = 0, p = [1..n]
  callback ++c, p while next_permutation p


permute 4
