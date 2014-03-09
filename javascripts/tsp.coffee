class @TSP
  constructor: (
                  @population_count  = 30
                  @iteration_count   = 30
                  @mutation_percent  = 30
                  @crossing_percent  = 30
                ) ->
    @crossing   = new Crossing  @crossing_percent
    @mutation   = new Mutation  @mutation_percent
    @selection  = new Selection @population_count

  inject: (cities) =>
    @population = new Population [0 ... @population_count].map => new Individual cities.randomize()

  calculate: (callback, storage) =>
    @iteration_count.times =>
      storage.store @population = @selection.evolve @mutation.evolve @crossing.evolve @population
    callback @population