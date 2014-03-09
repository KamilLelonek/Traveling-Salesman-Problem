class @Storage
  constructor: -> @reset()

  reset: =>
    @bests          = []
    @worsts         = []
    @averages       = []
    @iterationCount = 0

  store: (population) =>
    stats = population.stats()
    @bests.unshift    stats.best
    @worsts.unshift   stats.worst
    @averages.unshift stats.average

    console.clear()
    console.log "\n\n#{(++@iterationCount).ordinalize()} iteration"
    console.log "Best    : #{stats.best.length()}"
    console.log "Worst   : #{stats.worst.length()}"
    console.log "Average : #{stats.average}"