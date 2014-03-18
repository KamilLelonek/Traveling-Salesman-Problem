class @Printer
  @fileBuffer = []
  @buffer = $('textarea')

  consoleLog = console.log
  console.log = (message) ->
    Printer.buffer.append("#{message}\n").trigger('autosize.resize')
    consoleLog.apply(this, arguments)

  @printSection : (message) ->
    log '\n-------------------'
    log message
    log '-------------------\n'

  @printStats : (iterationCount, stats, localBests, globalBests) ->
    log "\n\n#{(iterationCount).ordinalize()} iteration"
    log "  => Local  best        : #{round(stats.best, 2)}"
    log "  => Global best        : #{round(globalBests.last(), 2)}"
    log "  => Worst              : #{round(stats.worst, 2)}"
    log "  => Average            : #{round(stats.average, 2)}"
    log "  => Evaluation count   : #{TSP.evaluationCount}"
    log "  => Standard deviation : #{getStandardDeviation globalBests}"