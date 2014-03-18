class Evolution
  constructor: (@percentage) ->
  evolve     : (population)  ->

  _getIndividualsToEvolve: (individuals) =>
    @probability  = Math.round individuals.length * (@percentage / 100)
    selectRandom  = [true, false].sample()
    worst         = [true, false].sample()
    (selectRandom and @_pickRandom individuals) or @_pickOnly(worst, individuals)

  _pickOnly: (worst, individuals) =>
    individuals.sortBy('totalLength', worst).to @probability

  _pickRandom : (individuals) =>
    individuals.sample @probability

  _buildPopulation : (individuals, individualsEvolved) =>
    individualsEvolved.forEach (individual) =>
      TSP.evaluationCount++
      individual.calculateLength()

    new Population individuals.include individualsEvolved

class @Selection extends Evolution
  constructor: (@maxCount)  ->
  evolve     : (population) =>
    individuals = population.individuals[..]
    new Population individuals.sortBy('totalLength').to @maxCount

class @Crossing extends Evolution
  evolve: (population) =>
    individuals = population.individuals[..]
    individualsToCross  = @_getIndividualsToEvolve individuals
    individualsCrossed  = @_crossIndividuals individualsToCross[..]
    @_buildPopulation individuals, individualsCrossed

  _crossIndividuals: (individuals) =>
    return individuals if individuals.length < 3
    while individuals.length > 1
      father = individuals[0].cities
      individuals.removeAt(0)
      mather = individuals[0].cities
      individuals.removeAt(0)
      @_makeAChild mather, father

  _makeAChild: (mather, father) =>
    middle     = father.length / 2
    halfFather = father.to   middle
    halfMather = mather.from middle
    new Individual [].union(halfFather, halfMather, father)

class @Mutation extends Evolution
  evolve: (population) =>
    individuals = population.individuals[..]
    individualsToMutate = @_getIndividualsToEvolve individuals
    individualsMutated  = @_mutateIndividuals individualsToMutate[..]
    @_buildPopulation individuals, individualsMutated

  _mutateIndividuals: (individuals) =>
    individuals.map (individual) =>
      @_swapRandomElements individual

  _swapRandomElements: (individual) =>
    [firstIndex, secondIndex] = @_uniqueRandomIndexes individual.cities.length
    temporaryIndividual            = individual.cities[firstIndex]
    individual.cities[firstIndex]  = individual.cities[secondIndex]
    individual.cities[secondIndex] = temporaryIndividual
    individual

  _uniqueRandomIndexes: (count) =>
    firstIndex  = secondIndex = Math.floor(Math.random() * count)
    secondIndex = Math.floor(Math.random() * count) while firstIndex is secondIndex
    [firstIndex, secondIndex]