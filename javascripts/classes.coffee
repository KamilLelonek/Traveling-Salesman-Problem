class @City
  constructor: (@id, @x, @y) ->

class @Individual
  constructor: (@cities = []) ->

class @Population
  constructor: (@individuals = []) ->