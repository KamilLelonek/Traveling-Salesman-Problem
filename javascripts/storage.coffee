class @Storage
  constructor: -> @reset()

  reset: =>
    @bests       = []
    @worsts      = []
    @averages    = []
    @populations = []

  store: (population) =>
    stats = population.stats()
    @bests.push       stats.best
    @worsts.push      stats.worst
    @averages.push    stats.average
    @populations.push population

    console.clear()
    console.log '\n\n'
    console.log "Best    : #{stats.best.length()}"
    console.log "Worst   : #{stats.worst.length()}"
    console.log "Average : #{stats.average}"