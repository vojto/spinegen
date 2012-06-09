Color = require("ansi-color").set
node_assert = require("assert")

Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1

class Util
  @log: (message, extra...) ->
    Util.log_color(message, "white", extra...)

  @log2: (message, extra...) ->
    Util.log_color(message, "magenta", extra...)

  @logs: (message, extra...) ->
    Util.log_color(message, "white+green_bg", extra...)

  @loge: (message, extra...) ->
    Util.log_color(message, "white+red_bg", extra...)

  @log_color: (message, color, extra...) ->
    return if Util.muted?
    console.log Color(message, color), extra...

  @assert: (assertion, message) ->
    try
      node_assert.ok(assertion, message)
    catch err
      Util.handleException(err)
      process.exit()

  @handleException: (err) ->
    console.log Color(err.message, "red")
    console.log Color(err.stack, "black")

  @clone: (obj) ->
    JSON.parse(JSON.stringify(obj))

module.exports = Util