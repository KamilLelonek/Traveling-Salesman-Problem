class @Random
  constructor: (vals) ->
    @population_count = vals['population_size']  ? 100
    @generation_count = vals['generation_count'] ? 20

  inject: (@cities) =>
    @population = @buildRandomPopulation()

  buildRandomPopulation : =>
    new Population [0 ... @population_count].map => new Individual @cities.randomize()

  calculate: (callback, storage) =>
    callback @generation_count.times => storage.store @buildRandomPopulation()