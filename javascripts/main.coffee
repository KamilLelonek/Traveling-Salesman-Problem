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

  showTotalResult: (population) =>
    # @_drawGraph population
    @_drawCharts()
    @_drawComparison()

  _drawGraph: (population) =>
    graph  = new Graph()
    cities = population.stats().best.cities
    count  = cities.length - 1

    cities.each (element, index) =>
      if index isnt count
        nextElement = cities[index + 1]
        edge = label: element.distanceTo(nextElement)
        graph.addEdge element.id, nextElement.id, edge

    width  = $(document).width()  - 20
    height = $(document).height() - 20

    layouter = new Graph.Layout.Spring graph
    renderer = new Graph.Renderer.Raphael("canvas", graph, width, height)

  _drawCharts: =>
    ctxBests      = $('#chart-bests')   .get(0).getContext('2d')
    ctxWorsts     = $('#chart-worsts')  .get(0).getContext('2d')
    ctxAverages   = $('#chart-averages').get(0).getContext('2d')
    chartBests    = new Chart ctxBests
    chartWorsts   = new Chart ctxWorsts
    chartAverages = new Chart ctxAverages
    chartBests   .Line @_dataBests()
    chartWorsts  .Line @_dataWorsts()
    chartAverages.Line @_dataAverages()

  _dataBests: =>
    labels   : [1 .. @storage.iterationCount]
    datasets : [
      fillColor        : "rgba(192,255,62,0.1)",
      strokeColor      : "lightGray",
      pointColor       : "white",
      pointStrokeColor : "#99CC00",
      data             : @storage.bests.map 'length'
    ]

  _dataWorsts: =>
    labels   : [1 .. @storage.iterationCount]
    datasets : [
      fillColor        : "rgba(255,48,48,0.1)",
      strokeColor      : "lightGray",
      pointColor       : "white",
      pointStrokeColor : "FF4444",
      data             : @storage.worsts.map 'length'
    ]

  _dataAverages: =>
    labels   : [1 .. @storage.iterationCount]
    datasets : [
      fillColor        : "rgba(135,206,250,0.1)",
      strokeColor      : "lightGray",
      pointColor       : "white",
      pointStrokeColor : "#33B5E5",
      data             : @storage.averages
    ]

  _drawComparison: =>
    $("#comparison").highcharts
      title:
        text: "Population comparison"
        x: -20

      subtitle:
        text: "Data from #{@storage.iterationCount} cycles"
        x: -20

      xAxis:
        categories: [1 .. @storage.iterationCount]

      yAxis:
        title:
          text: "Path length"

        plotLines: [
          value : 0
          width : 1
          color : "#808080"
        ]

      colors: [
        '#99CC00'
        '#FF4444'
        '#33B5E5'
      ]

      tooltip:
        valueSuffix: " m"

      legend:
        align         : "left"
        floating      : true
        verticalAlign : "top"
        borderWidth   : 0

      tooltip:
        shared      : true
        crosshairs  : true

      series: [
        {
          name: "Bests"
          data: @storage.bests.map 'length'
        }
        {
          name: "Worsts"
          data: @storage.worsts.map 'length'
        }
        {
          name: "Averages"
          data: @storage.averages
        }
      ]

new Main()