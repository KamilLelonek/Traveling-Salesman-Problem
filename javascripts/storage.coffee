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
    console.log "Best    : #{stats.best.length()}"
    console.log "Worst   : #{stats.worst.length()}"
    console.log "Average : #{stats.average}"


  worstsIndividuals : => @bests .map 'length'
  bestsIndividuals  : => @worsts.map 'length'