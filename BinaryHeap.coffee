class BinaryHeap
  ###
    comparator is a function that takes in 2 nodes a and b and returns positive if a>b, negative if a<b and 0 if a == b
    if min is true then a min-heap, else a max-heap
  ###
  constructor: (comparator = ((a,b) -> a-b), min = true) ->
    @A = [null]               # internally we store the tree as an Ahnentafel list indexed at 1
    @compare = (x, y) -> (if min then 1 else -1) * comparator @A[x], @A[y]

  size: -> @A.length - 1

  insert: (val) ->
    @A.push val
    @bubble 'up', @size()

  delete_root: ->
    @swap @size(), 1
    ret = @A.pop()
    @bubble 'down', 1
    return ret

  bubble: (dir, i) ->
    if dir is 'up' and (@compare i, p = i>>1) < 0 then n = p
    else if dir is 'down'
      lr = @compare l = 2*i, r = l+1
      li = @compare l, i
      ri = @compare r, i
      if li<0 and (ri>=0 or lr<0) then n = l else
      if ri<0 and (li>=0 or lr>=0) then n = r
    if n then (@swap i, n); (@bubble dir, n)

  peek: -> @A[1]
  
  swap: (x, y) -> [@A[x], @A[y]] = [@A[y], @A[x]]


a = [12, 23, 5, -6, 9, 23, 345, 4, 4, 5, 100, 4, 56, 48, 97, 5, 6, 19]
b = new BinaryHeap()
b.insert i for i in a
console.log '\n\n'
console.log b.delete_root() while b.size() > 0
