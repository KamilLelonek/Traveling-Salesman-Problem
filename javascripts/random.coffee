class @Random
  constructor: (@cities) ->

  bestRandomIndividual: (population_count) =>
    population = new Population [0 ... population_count].map =>
                                  new Individual @cities.randomize()
    population.stats().best.totalLength