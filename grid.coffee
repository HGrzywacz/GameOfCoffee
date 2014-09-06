---
---

c = this.c

nextGeneration = this.nextGeneration

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
  (addCell container, x, y, width for y in [0..sizeY])

makeGrid = (container, width, sizeY, sizeX) ->
  (makeColumn container, x, width, sizeY for x in [0..sizeX])

createCell = (cell) ->
  cell.removeClass 'dead'
  cell.addClass 'alive'

killCell = (cell) ->
  cell.removeClass 'alive'
  cell.addClass 'dead'

createGeneration = (generation, grid) ->
  (generation.map (c) -> createCell grid[c.x][c.y])

killAllCells = (grid) ->
  grid.map (column) -> column.map (cell) -> killCell cell

getViewportDimensions = (viewport) ->
  [ $(viewport).width(), $(viewport).height()]

getSizes = (width) ->
  [viewportWidth, viewportHeight] = getViewportDimensions window
  sizeX = Math.floor viewportWidth/width - 1
  sizeY = Math.floor viewportHeight/width - 1
  [sizeX, sizeY]

fitGridToWindow = (width, container) ->
  [sizeX, sizeY] = getSizes width
  makeGrid container, width, sizeY, sizeX

makeFilterCellsOutOfGrid = (grid) ->
  filterCellsOutOfGrid = (cell) ->
    return (typeof grid[cell.x][cell.y] != 'undefined')

startLiving = (cells, grid, interval) ->
  filterCellsOutOfGrid = makeFilterCellsOutOfGrid grid

  advanceGeneration = () ->
    cells = nextGeneration cells
    cells = cells.filter filterCellsOutOfGrid
    killAllCells grid
    createGeneration cells, grid

  window.setInterval advanceGeneration, interval

setupGridAndStart = (cells, width, container) ->
  grid = fitGridToWindow width, container
  intervalId = startLiving cells, grid, 300

#----------------#

width = 28

container = $('#container')

cells = [c(4, 3), c(3, 2), c(2, 4), c(3, 4), c(4, 4), c(14, 14), c(14, 15), c(14, 16)]

setupGridAndStart cells, width, container

#----------------#

