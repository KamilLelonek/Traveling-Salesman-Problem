class @Main
  constructor: ->
    builder = new Builder(@handleCalculate)
    $('#file').change (event) =>
      builder.readFile event.target.files[0]

  handleCalculate: (cities) =>
    $('#btn-calculate')
      .toggleClass('hidden', cities.isEmpty())
      .click =>
        @calculate cities

  calculate: (cities) =>
    @storage = new Storage()
    tsp = new TSP()
    tsp.inject cities
    tsp.calculate @showTotalResult, @storage

  showTotalResult: =>
    drawer = new Drawer @storage
#    drawer.drawGraph()
    drawer.drawCharts()
    drawer.drawComparison()

new Main()