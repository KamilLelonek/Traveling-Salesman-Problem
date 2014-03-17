handleCalculate = (cities) =>
  $('#btn-calculate')
  .toggleClass('hidden', cities.isEmpty())
  .click =>
      calculate cities

calculate = (cities) =>
  switch mode()
    when 'graphical' then graphical cities
    when 'textual'   then textual   cities

mode = ->
  $('.btn-mode.active').data('mode')

textual = (cities) =>
  iterator = new Iterator()
  iterator.iterate cities

graphical = (cities) =>
  @storage = new Storage()
  tsp      = new TSP values()
  tsp.inject cities
  tsp.calculate showTotalResult, @storage

values = =>
  population_size      : parseInt $("#population-count")   .val()
  generation_count     : parseInt $("#iteration-count")    .val()
  mutation_propability : parseInt $("#percentage-mutation").val()
  crossing_propability : parseInt $("#percentage-crossing").val()

showTotalResult = =>
  drawer = new Drawer @storage
  drawer.drawGraph()      if $('#checkbox-graph') .is(':checked')
  drawer.drawCharts()     if $('#checkbox-charts').is(':checked')
  drawer.drawComparison() if $('#checkbox-stats') .is(':checked')

$('#file').change (event) =>
  builder = new Builder(handleCalculate)
  builder.readFile event.target.files[0]

$('#percentage-mutation')
.TouchSpin
    min     : 0
    max     : 100
    step    : 10
    boostat : 30
    initval : 40
    postfix : '%'

$('#percentage-crossing')
.TouchSpin
    min     : 0
    max     : 100
    step    : 10
    boostat : 30
    initval : 40
    postfix : '%'

$('#population-count')
.TouchSpin
    min     : 5
    max     : 100
    step    : 1
    initval : 10

$('#iteration-count')
.TouchSpin
    min     : 5
    max     : 20
    step    : 1
    initval : 10