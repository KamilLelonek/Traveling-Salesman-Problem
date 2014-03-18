class @TSP
  constructor: (vals) ->
    TSP.evaluationCount = 0
    @population_count = vals['population_size']      ? 100
    @generation_count = vals['generation_count']     ? 20
    @mutation_percent = vals['mutation_propability'] ? 30
    @crossing_percent = vals['crossing_propability'] ? 30
    @crossing  = new Crossing  @crossing_percent
    @mutation  = new Mutation  @mutation_percent
    @selection = new Selection @population_count

  inject: (cities) =>
    @population = new Population [0 ... @population_count].map => new Individual cities.randomize()

  calculate: (callback, storage) =>
    callback @generation_count.times =>
      storage.store @population = @selection.evolve @mutation.evolve @crossing.evolve @population