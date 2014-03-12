class @Storage
  constructor: -> @reset()

  reset: =>
    @bests          = []
    @worsts         = []
    @averages       = []
    @populations    = []
    @iterationCount = 0

  store: (population) =>
    stats = population.stats()
    @bests.push       stats.best
    @worsts.push      stats.worst
    @averages.push    stats.average
    @populations.push population

    console.clear()
    console.log "\n\n#{(++@iterationCount).ordinalize()} iteration"
    console.log "Best    : #{stats.best.totalLength}"
    console.log "Worst   : #{stats.worst.totalLength}"
    console.log "Average : #{stats.average}"

  worstsIndividuals : => @worsts.map 'totalLength'
  bestsIndividuals  : => @bests.map  'totalLength'