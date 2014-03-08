class @TSP
  constructor: (
                  @population_count  = 10
                  @iteration_count   = 10
                  @selection_percent = 30
                  @mutation_percent  = 30
                  @crossing_percent  = 30
                ) ->
    @selection  = new Selection()
    @crossing   = new Crossing()
    @mutation   = new Mutation()

  inject: (cities) =>
    individuals = [0...@population_count].map => cities.randomize()
    @population = new Population individuals

  calculate: (callback) =>