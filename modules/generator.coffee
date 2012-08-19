{log, loge, assert} = require('../util')
{exec} = require('child_process')
fs = require('fs')
sys = require('util')

class Generator
  @install_npm: ->
    log 'installing dependencies'
    exec 'npm install .', (err, stdout, stderr) ->
      assert !err, err
      sys.puts(stdout)

  @patch_json: (filename, patch_function) ->
    try
      data = fs.readFileSync(filename, 'utf8')
    catch error
      loge "cannot read #{filename} (#{error})"
      return

    json = JSON.parse(data)
    patch_function(json)
    patched_data = JSON.stringify(json, null, 2)

    fs.writeFileSync(filename, patched_data, 'utf8')

  @create_file: (filename, content) ->
    if fs.existsSync(filename)
      loge "can't create #{filename}"
      return
    fs.writeFileSync(filename, content, 'utf8')

module.exports = Generator