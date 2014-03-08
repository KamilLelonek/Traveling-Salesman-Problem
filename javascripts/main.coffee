class @Main
  constructor: ->
    @builder = new Builder(@handleCalculate)
    @tsp     = new TSP()
    @handleFileUploads()

  handleFileUploads: =>
    $('#file').change (event) =>
      @builder.readFile event.target.files[0]

  handleCalculate: =>
    cities = @builder.cities
    if cities.length
      $('#btn-calculate').removeClass('hidden').click =>
        @tsp.inject cities
        @tsp.calculate @showResult

  showResult: =>

new Main()