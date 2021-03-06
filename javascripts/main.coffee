$('#file').change (event) =>
  fileName = event.target.files[0]
  if fileName
    builder = new Builder(handleCalculate)
    builder.readFile fileName

handleCalculate = (@cities) =>
  $('#btn-calculate')
  .toggleClass('hidden', cities.isEmpty())
  .click =>
      $('textarea').text ''
      console.clear()
      calculate()

calculate = =>
  @storage = new Storage()
  switch mode()
    when 'graphical' then graphical cities
    when 'textual'   then textual   cities
    else throw 'Unknown representation mode'

mode      = -> $('#btn-mode').find('.active').data('mode')
algorithm = -> $('#btn-alg') .find('.active').data('alg')

textual = (cities) =>
  iterator = new Iterator()
  iterator.iterate cities

graphical = (cities) =>
  switch algorithm()
    when 'tsp'    then tsp()
    when 'random' then rand()
    else throw 'Unknown algorithm'

tsp = =>
  performAlgorithm new TSP values()

rand = =>
  performAlgorithm new Random values()

performAlgorithm = (algorithm) =>
  algorithm.inject @cities
  algorithm.calculate showTotalResult, @storage

values = =>
  population_size      : parseInt $("#population-count")   .val()
  generation_count     : parseInt $("#generation-count")   .val()
  mutation_propability : parseInt $("#percentage-mutation").val()
  crossing_propability : parseInt $("#percentage-crossing").val()

showTotalResult = =>
  drawer = new Drawer @storage
  drawer.drawGraph()      if $('#checkbox-graph') .is(':checked')
  drawer.drawCharts()     if $('#checkbox-charts').is(':checked')
  drawer.drawComparison() if $('#checkbox-stats') .is(':checked')

percentageData =
  min     : 0
  max     : 100
  step    : 10
  boostat : 30
  initval : 30
  postfix : '%'

countData =
  min     : 5
  max     : 100
  step    : 1
  initval : 20

$('#percentage-mutation').TouchSpin percentageData
$('#percentage-crossing').TouchSpin percentageData
$('#population-count')   .TouchSpin countData
$('#generation-count')   .TouchSpin countData

$('textarea').autosize()