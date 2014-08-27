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

  cells.filter (cell) -> cellFate(cell)

c = (x, y) ->
  new ->
    this.x = x
    this.y = y

grid = [c(1, 0), c(0, 1), c(2, 1), c(3, 2)]

console.log(grid)
console.log(grid = advance(grid))
console.log(grid = advance(grid))
