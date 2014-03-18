class @Builder
  constructor: (callback) ->
    @reader = new FileReader()
    @reader.onload = (event) =>
      cities = @_buildCities(event).compact()
      Country.initialize cities
      callback cities

  readFile: (file) ->
    try @reader.readAsBinaryString file
    catch error
      console.log error.message

  _buildCities: (event) ->
    fileContent = event.target.result
    fileLines   = fileContent.split '\r\n'

    for line in fileLines
      if line.startsWith /[0-9]/
        [id, x, y] = line.match /\S+/g
        new City(id, x, y)