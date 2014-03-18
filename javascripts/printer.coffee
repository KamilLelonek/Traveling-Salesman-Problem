class @Printer
  consoleLog = console.log
  @fileBuffer = []
  console.log = ->
    Printer.fileBuffer.add arguments
    consoleLog.apply(this, arguments)

  @printSection : (message) ->
    log '\n-------------------'
    log message
    console.log '-------------------\n'

  @printStats : (iterationCount, stats, localBests, globalBests) ->
    console.clear()
    console.log "\n\n#{(iterationCount).ordinalize()} iteration"
    console.log "Local  best        : #{round(stats.best, 2)}"
    console.log "Global best        : #{round(globalBests.last(), 2)}"
    console.log "Worst              : #{round(stats.worst, 2)}"
    console.log "Average            : #{round(stats.average, 2)}"
    console.log "Evaluation count   : #{TSP.evaluationCount}"
    console.log "Standard deviation : #{getStandardDeviation globalBests}"