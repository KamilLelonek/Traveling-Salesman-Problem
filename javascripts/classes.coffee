class @City
  constructor: (@id, @x, @y) ->

  distanceTo: (city) =>
    d1 = city.x - @x
    d2 = city.y - @y
    Math.sqrt d1*d1 + d2*d2

class @Individual
  constructor: (@cities = []) ->

  length: =>
    @totalLength = 0
    for i in [0 ... @cities.length - 1]
      [element, nextElement] = @cities[i .. i + 1]
      @totalLength += element.distanceTo nextElement
    @totalLength

class @Population
  constructor : (@individuals) ->

  stats: =>
    best    : @individuals.min('length')
    worst   : @individuals.max('length')
    average : @individuals.average('length')