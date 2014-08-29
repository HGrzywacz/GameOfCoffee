c is a function that returns new object

  c = (x, y) ->
    new ->
      this.x = x
      this.y = y

  isEmpty = (collection) ->
    collection.length == 0

  cellsEqual = (a, b) ->
    (a.x == b.x) && (a.y == b.y)

  isIn = (element, collection, f = cellsEqual) ->
    collection.some (x) -> f x, element

  isNotIn = (element, collection, f) ->
    !isIn element, collection, f

  union = (a, b) ->
    a.concat b.filter (x) -> isNotIn x, a

  flatten = (collection) ->
    collection.reduce union, []

  allNeighbours = (cell) ->
    x = cell.x
    y = cell.y
    return [c(x-1, y), c(x+1, y),
      c(x-1, y-1), c(x, y-1), c(x+1, y-1)
      c(x-1, y+1), c(x, y+1), c(x+1, y+1)]

  cellsClosure = (cells) ->

    emptyNeighbours = (cell) ->
      neighbourhood = allNeighbours cell
      neighbourhood.filter (c) -> isNotIn c, cells

    countNeighbours = (cell) ->
      (cells.filter (nb) ->
        (cell.x - 1 <= nb.x <= cell.x + 1) &&
        (cell.y - 1 <= nb.y <= cell.y + 1) &&
        (!cellsEqual cell, nb)
      ).length

    aliveCellFate = (cell) ->
      neighbours = countNeighbours cell
      if neighbours < 2 then false
      else if neighbours > 3 then false
      else true

    deadCellFate = (cell) ->
      (countNeighbours cell) == 3

    [emptyNeighbours, aliveCellFate, deadCellFate]


  nextGeneration = (cells) ->
    if isEmpty cells then return []

    [emptyNeighbours, aliveCellFate, deadCellFate] = cellsClosure cells

    newAliveCells = (flatten cells.map emptyNeighbours).filter deadCellFate
    stillAliveCells = cells.filter aliveCellFate

    union stillAliveCells, newAliveCells


  glider = [c(0, 1), c(1, 0), c(2, 0), c(2, 1), c(2, 2)]
  beehive = [c(1, 0), c(0, 1), c(2, 1), c(1,2)]
  glider = [c(0, 1), c(1, 0), c(2, 0), c(2, 1), c(2, 2)]
  grid = glider

  advance = () ->
    grid = nextGeneration grid
    console.log grid

  n = 10

  advance() for i in [1..n]
