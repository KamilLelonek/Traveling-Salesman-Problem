class @TSP
  constructor: (
                  @population_count  = 10
                  @iteration_count   = 10
                  @mutation_percent  = 30
                  @crossing_percent  = 30
                ) ->
    @crossing   = new Crossing  @crossing_percent
    @mutation   = new Mutation  @mutation_percent
    @selection  = new Selection @population_count

  inject: (cities) =>
    @population = new Population [0 ... @population_count].map => new Individual cities.randomize()

  calculate: (callback, storage) =>
    callback @iteration_count.times =>
      storage.store @population = @selection.evolve @mutation.evolve @crossing.evolve @population