handleCalculate = (cities) =>
  $('#btn-calculate')
  .toggleClass('hidden', cities.isEmpty())
  .click =>
      calculate cities

calculate = (cities) =>
  @storage = new Storage()
  Country.initialize cities
  tsp      = new TSP values()
  tsp.inject cities
  tsp.calculate showTotalResult, @storage

values = =>
  populationCount    = parseInt $("#population-count").val()
  iterationCount     = parseInt $("#iteration-count").val()
  percentageMutation = parseInt $("#percentage-mutation").val()
  percentageCrossing = parseInt $("#percentage-crossing").val()
  [populationCount, iterationCount, percentageMutation, percentageCrossing]

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