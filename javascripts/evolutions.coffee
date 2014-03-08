class Evolution
  evolve: ->

class @Selection extends Evolution
  select: (@population) ->

class @Crossing extends Evolution
  cross: (@population) ->

class @Mutation extends Evolution
  mutate: (@population) ->