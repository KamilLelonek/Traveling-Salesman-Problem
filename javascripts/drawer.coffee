class @Drawer
  constructor: ->
    @bests       = []
    @worsts      = []
    @averages    = []
    @populations = []

  draw: (population) =>
    stats = population.stats()
    @bests.push       stats.best
    @worsts.push      stats.worst
    @averages.push    stats.average
    @populations.push population

    console.log "Best    : #{stats.best.length()}"
    console.log "Worst   : #{stats.worst.length()}"
    console.log "Average : #{stats.average}\n\n"