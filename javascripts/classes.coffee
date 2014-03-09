class @City
  constructor: (@id, @x, @y) ->

  distanceTo: (city) =>
    d1 = city.x - @x
    d2 = city.y - @y
    Math.sqrt d1*d1 + d2*d2

class @Individual
  constructor: (@cities = []) ->
    @_totalLength = 0

  length: =>
    return @_totalLength if @_totalLength
    for i in [0 ... @cities.length - 1]
      [element, nextElement] = @cities[i .. i + 1]
      @_totalLength += element.distanceTo nextElement
    @_totalLength

class @Population
  constructor : (@individuals) ->

  stats: =>
    best    : @individuals.min('length')
    worst   : @individuals.max('length')
    average : @individuals.average('length')