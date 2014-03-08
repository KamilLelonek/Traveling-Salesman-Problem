class @City
  constructor: (@id, @x, @y) ->

  distanceTo: (city) =>
    d1 = city.x - @x
    d2 = city.y - @y
    Math.sqrt d1*d1 + d2*d2

class @Individual
  constructor: (@cities = []) ->
    @weight = 0

  calculateWeight: =>
    return @weight if @weight
    count = @cities.length - 1
    @cities.each (element, index) =>
      if index isnt count
        nextElement = @cities[index + 1]
        @weight += element.distanceTo nextElement

class @Population
  constructor: (@individuals = []) ->