class @Builder
  constructor: (callback) ->
    @reader = new FileReader()
    @reader.onload = (event) =>
      @_read(event) and callback @cities

  readFile: (file) ->
    @reader.readAsBinaryString file

  _read: (event) ->
    fileContent = event.target.result
    fileLines   = fileContent.split '\r\n'

    for line in fileLines
      if line.startsWith /[0-9]/
        city = line.match /\S+/g
        @_buildCity city[0], city[1], city[2]

  _buildCity: (id, x, y) ->
    @cities ?= []
    @cities.push new City(id, x, y)