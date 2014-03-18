$('#file').change (event) =>
  builder = new Builder(handleCalculate)
  builder.readFile event.target.files[0]

handleCalculate = (cities) =>
  $('#btn-calculate')
  .toggleClass('hidden', cities.isEmpty())
  .click =>
      calculate cities

calculate = (cities) =>
  switch mode()
    when 'graphical' then graphical cities
    when 'textual'   then textual   cities
    else throw 'Unknown representation mode'

mode = -> $('#btn-mode').find('.active').data('mode')

textual = (cities) =>
  iterator = new Iterator()
  iterator.iterate cities

graphical = (cities) =>

  @storage = new Storage()
  tsp      = new TSP values()
  tsp.inject cities
  tsp.calculate showTotalResult, @storage

  random = new Random cities
  bestRandom = random.bestRandomIndividual values().population_size
  Printer.printSection "Best random individual: #{bestRandom}"

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
$('#iteration-count')    .TouchSpin countData