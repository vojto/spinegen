{log, logs, loge, assert} = require('./util')
optimist = require('optimist')

class Spinegen
  run: ->
    argv = optimist.argv
    commands = argv._

    if commands.length == 0
      loge 'usage: spinegen command [options]'
      process.exit()

    command = commands[0]
    commands.shift()

    if @[command]
      @[command].apply(@, commands)
    else
      loge "unknown command #{command}"
      process.exit()

  use: (module_name, params...) ->
    try
      module = require("./modules/#{module_name}")
    catch error
      loge "module '#{module_name}' not found", error
      process.exit()

    module()

spinegen = new Spinegen
spinegen.run()