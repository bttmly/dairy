KeyedQueue = require "keyed-queue"

SECOND = 1000
MINUTE = SECOND * 60

Dairy = (time_to_live, check_interval) ->
  time_to_live = Number time_to_live or MINUTE
  check_interval = Number check_interval or SECOND

  if isNaN time_to_live
    throw new TypeError "timeToLive must be numeric"

  if isNaN check_interval
    throw new TypeError "checkInterval must be numeric"

  queue = do KeyedQueue
  interval_id = undefined

  expire = ->
    now = do Date.now
    while queue.size() and queue.peek()?.expires_at < now
      do queue.dequeue

  instance =
    add: (key, value) ->
      queue.enqueue key,
        value: value
        expires_at: Date.now() + time_to_live
      return instance

    get: (key) ->
      return queue.get(key).value

    start: ->
      interval_id = setInterval expire, check_interval
      return instance

    stop: ->
      clearInterval interval_id
      return instance

  instance.has = queue.has
  instance.size = queue.size

  do instance.start

  instance

module.exports = Dairy
