class @Country
  @initialize: (cities) =>
    @distancesMatrix = @_cross cities

  @_cross: (cities) =>
    firstCity.distanceTo(secondCity) for firstCity in cities for secondCity in cities

  @distanceBetween: (firstCity, secondCity) =>
    @distancesMatrix[firstCity.id - 1][secondCity.id - 1]

class @City
  constructor: (@id, @x, @y) ->

  distanceTo: (city) =>
    return 0 if @id is city.id
    d1 = city.x - @x
    d2 = city.y - @y
    Math.sqrt d1*d1 + d2*d2

class @Individual
  @COUNTER = 0

  constructor: (@cities = []) ->
    @id = @constructor.COUNTER++
    @invalidate()

  invalidate: =>
    TSP.evaluationCount++
    @totalLength = Country.distanceBetween @cities.last(), @cities.first()
    for i in [0 ... @cities.length - 1]
      [element, nextElement] = @cities[i .. i + 1]
      @totalLength += Country.distanceBetween element, nextElement

class @Population
  constructor : (@individuals) ->

  stats: =>
    best  = @individuals.min('totalLength').totalLength
    worst = @individuals.max('totalLength').totalLength
    best    : best
    worst   : worst
    average : (best + worst) / 2