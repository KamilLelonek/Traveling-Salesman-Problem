class @Main
  constructor: ->
    @handleFileUploads()

  handleFileUploads: =>
    builder = new Builder(@handleCalculate)
    $('#file').change (event) =>
      builder.readFile event.target.files[0]

  handleCalculate: (cities) =>
    if cities.length
      $('#btn-calculate').removeClass('hidden').click => @calculate cities

  calculate: (cities) =>
    @storage = new Storage()
    tsp = new TSP()
    tsp.inject cities
    tsp.calculate @showTotalResult, @storage

  showTotalResult: (population) =>
    # @_drawGraph population
    @_drawCharts()

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
    ctxBests    =  $('#chart-bests')   .get(0).getContext('2d')
    ctxWorsts   =  $('#chart-worsts')  .get(0).getContext('2d')
    ctxAverages =  $('#chart-averages').get(0).getContext('2d')
    chartBests    = new Chart ctxBests
    chartWorsts   = new Chart ctxWorsts
    chartAverages = new Chart ctxAverages
    chartBests   .Line @_dataBests()
    chartWorsts  .Line @_dataWorsts()
    chartAverages.Line @_dataAverages()

  _dataBests: =>
    labels   : [0...@storage.bests.length]
    datasets : [
      fillColor : "rgba(220,220,220,0.5)",
      strokeColor : "rgba(220,220,220,1)",
      pointColor : "rgba(220,220,220,1)",
      pointStrokeColor : "#fff",
      data : @storage.bests.map 'length'
    ]

  _dataWorsts: =>
    labels : [0...@storage.worsts.length]
    datasets : [
      fillColor : "rgba(220,220,220,0.5)",
      strokeColor : "rgba(220,220,220,1)",
      pointColor : "rgba(220,220,220,1)",
      pointStrokeColor : "#fff",
      data : @storage.worsts.map 'length'
    ]

  _dataAverages: =>
    labels : [0...@storage.averages.length]
    datasets : [
      fillColor : "rgba(220,220,220,0.5)",
      strokeColor : "rgba(220,220,220,1)",
      pointColor : "rgba(220,220,220,1)",
      pointStrokeColor : "#fff",
      data : @storage.averages.map 'length'
    ]


new Main()