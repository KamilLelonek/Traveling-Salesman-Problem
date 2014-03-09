class @TSP
  constructor: (
                  @population_count  = 10
                  @iteration_count   = 30
                  @mutation_percent  = 30
                  @crossing_percent  = 30
                ) ->
    @selection  = new Selection @population_count
    @crossing   = new Crossing  @crossing_percent
    @mutation   = new Mutation  @mutation_percent

  inject: (cities) =>
    individuals = [0...@population_count].map => new Individual cities.randomize()
    @population = new Population individuals

  calculate: (callback, storage) =>
    @iteration_count.times =>
      @population = @crossing.evolve  @population
      @population = @mutation.evolve  @population
      @population = @selection.evolve @population
      storage.store @population
    callback @population