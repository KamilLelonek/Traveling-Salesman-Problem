class @City
  constructor: (@x, @y) ->

class @Path
  constructor: (@cities = []) ->

class @Graph
  constructor: (@paths = []) ->