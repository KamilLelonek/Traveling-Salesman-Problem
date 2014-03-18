class @Iterator
  constructor : ->
    @parameters =
      [
        {
          name   : 'population_size'
          values : [10, 20, 50, 100]
        },
        {
          name   : 'generation_count'
          values : [5, 15, 30, 50]
        },
        {
          name   : 'mutation_propability'
          values : [10, 20, 40, 70]
        },
        {
          name   : 'crossing_propability'
          values : [10, 20, 40, 70]
        }
      ]

  iterate : (@population) =>
    @parameters.each (parameter) =>
      log "Current parameter name: #{parameter.name}"
      parameter.values.each (value) =>
        log "Current parameter value: #{value}"
        10.times (iteration) =>
          log "Current repetition number: #{iteration + 1}"
          @calculate name

  calculate : (name) =>
    storage = new Storage()
    options = {}
    options[name] = name
    tsp = new TSP options
    tsp.inject @population
    tsp.calculate @showResults, storage

  showResults : =>