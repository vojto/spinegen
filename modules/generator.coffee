{log, loge, assert} = require('../util')
{exec} = require('child_process')
fs = require('fs')
sys = require('util')
path = require('path')

class Generator
  @install_npm: ->
    log 'installing dependencies'
    exec 'npm install .', (err, stdout, stderr) ->
      assert !err, err
      sys.puts(stdout)

  @add_dependencies: (dependencies) ->
    @patch_json 'package.json', (packages) ->
      assert packages.dependencies, 'package.json should contain dependencies'
      for key, value of dependencies
        packages.dependencies[key] = value

  @patch_json: (filename, patch_function) ->
    filepath = path.join(process.cwd(), filename)
    try
      data = fs.readFileSync(filepath, 'utf8')
    catch error
      loge "cannot read #{filepath} (#{error})"
      return

    json = JSON.parse(data)
    patch_function(json)
    patched_data = JSON.stringify(json, null, 2)

    fs.writeFileSync(filepath, patched_data, 'utf8')

  @create_file: (filename, content) ->
    filepath = path.join(process.cwd(), filename)
    if fs.existsSync(filepath)
      loge "can't create #{filepath}"
      return
    fs.writeFileSync(filepath, content, 'utf8')

module.exports = Generator