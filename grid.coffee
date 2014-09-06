---
---


makeCell = (x, y, width) ->
  cell = $(document.createElement('div')).addClass('cell').addClass('dead')
    .css({
      position: 'absolute'
      left: x * width + 'px'
      bottom: y * width + 'px'
    })

  inside = $(document.createElement('div')).addClass('inside')
  cell.append(inside)
  return cell

addCell = (container, x, y, width) ->
  cell = makeCell x, y, width
  container.append cell
  return cell

makeColumn = (container, x, width, sizeY) ->
  (addCell container, x, y, width for y in [1..sizeY])

makeGrid = (container, width, sizeY, sizeX) ->
  (makeColumn container, x, width, sizeY for x in [1..sizeX])

createCell = (cell) ->
  console.log cell
  cell.removeClass 'dead'
  cell.addClass 'alive'

killCell = (cell) ->
  cell.removeClass 'alive'
  cell.addClass 'dead'

createGeneration = (generation, grid) ->
  (generation.map (c) -> createCell grid[c.x][c.y])

killAllCells = (grid) ->
  grid.map (column) -> column.map (cell) -> killCell cell

#----------------#

sizeX = 50
sizeY = 20
width = 28

container = $('#container')

grid = makeGrid container, width, sizeY, sizeX

cells = [{x: 2, y: 3}, {x: 3, y: 2}]

createGeneration cells, grid

#----------------#

