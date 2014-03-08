class Evolution
  evolve: ->

class @Selection extends Evolution
  constructor: (@population) ->

class @Crossing extends Evolution
  constructor: (@population) ->

class @Mutation extends Evolution
  constructor: (@population) ->