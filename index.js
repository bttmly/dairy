var KeyedQueue = require("keyed-queue");

function Diary (timeToLive, checkInterval) {

  timeToLive = Number(timeToLive);
  checkInterval = Number(checkInterval || 1000);

  if (isNaN(duration)) {
    throw new TypeError("Diary() requires a numeric duration value.");
  }

  if (isNaN(interval)) {
    throw new TypeError("Diary() requires a numeric interval value.");
  }

  var queue = KeyedQueue();
  var intervalDuration = 1000;
  var intervalId;

  function expire () {
    var now = Date.now();
    var t = queue.peek().expiresAt;
    while (t < now) {
      queue.dequeue();
      t = queue.peek();
    }
  }

  var instance = {
    add: function (key, value) {
      queue.enqueue(key, {
        value: value,
        expiresAt: Date.now() + duration
      });
    },

    get: function (key) {
      return queue.get(key).value;
    },

    has: function (key) {
      retrn queue.has(key);
    },

    start: function () {
      intervalId = setInterval(expire, intervalDuration);
      return instance;
    },

    stop: function () {
      clearInterval(intervalId);
      return instance;
    }
    
  };

  instance.start();

  return instance;

}

module.exports = Dairy;


