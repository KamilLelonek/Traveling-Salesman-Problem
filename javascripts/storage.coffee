class @Storage
  constructor: -> @reset()

  reset: =>
    @localBests     = []
    @globalBests    = []
    @worsts         = []
    @averages       = []
    @populations    = []
    @iterationCount = 0

  store: (population) =>
    stats = population.stats()

    @addGlobalBest    stats.best
    @localBests .push stats.best
    @worsts     .push stats.worst
    @averages   .push stats.average
    @populations.push population

    Printer.printStats(++@iterationCount, stats, @localBests, @globalBests)

  addGlobalBest : (best) =>
    currentGlobalBest = @globalBests.last()
    return @globalBests[0] = best unless currentGlobalBest
    @globalBests.push Math.min best, currentGlobalBest