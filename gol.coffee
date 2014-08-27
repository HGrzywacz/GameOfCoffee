head = (collection) ->
  collection[0]

rest = (collection) ->
  collection.slice(1)

isEmpty = (collection) ->
  collection.length == 0

cellsEqual = (a, b) ->
  (a.x == b.x) && (a.y == b.y)

isIn = (element, collection) ->

  if isEmpty(collection)
    return false

  if cellsEqual(head(collection), element)
    return true
  else
    return isIn(element, rest(collection))


advance = (cells) ->

  countNeighbours = (cell) ->
    (cells.filter (nb) ->
      (nb.x == cell.x - 1 || nb.x == cell.x + 1) &&
      (nb.y == cell.y - 1 || nb.y == cell.y + 1)
    ).length

  cellFate = (cell) ->
    neighbours = countNeighbours(cell)
    if neighbours < 2 then false
    else if neighbours > 3 then false
    else true

  console.log(isIn(c(1,0), cells))
  console.log(isIn(c(1,1), cells))

  cells.filter (cell) -> cellFate(cell)


c = (x, y) ->
  new ->
    this.x = x
    this.y = y

grid = [c(1, 0), c(0, 1), c(2, 1), c(3, 2)]

console.log(grid)
console.log(grid = advance(grid))
console.log(grid = advance(grid))
