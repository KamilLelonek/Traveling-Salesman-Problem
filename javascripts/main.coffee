class @Main
  constructor: ->
    @builder = new Builder(@handleCalculate)
    @drawer  = new Drawer()
    @tsp     = new TSP()
    @handleFileUploads()

  handleFileUploads: =>
    $('#file').change (event) =>
      @builder.readFile event.target.files[0]

  handleCalculate: (cities) =>
    if cities.length
      $('#btn-calculate').removeClass('hidden').click =>
        @tsp.inject cities
        @tsp.calculate @showTotalResult, @showPartialResult

  showPartialResult: (population) =>
    @drawer.draw population

  showTotalResult: (population) =>

new Main()