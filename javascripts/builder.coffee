class @Builder
  constructor: (callback) ->
    @reader = new FileReader()
    @reader.onload = (event) =>
      @_buildCities(event) and callback @cities

  readFile: (file) ->
    @cities = []
    try @reader.readAsBinaryString file

  _buildCities: (event) ->
    fileContent = event.target.result
    fileLines   = fileContent.split '\r\n'

    for line in fileLines
      if line.startsWith /[0-9]/
        [id, x, y] = line.match /\S+/g
        @cities.push new City(id, x, y)

    @cities.add @cities.first()