primes = (n) ->
  c = []
  c[j] = true for j in [i*i .. n] by i for i in [2 .. Math.sqrt(n)] when not c[i]
  i for i in [2 .. n] when not c[i]


console.log primes 100