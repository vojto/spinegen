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

  @create_dir: (dir) ->
    filepath = path.join(process.cwd(), dir)
    exists = fs.existsSync(filepath)
    return if exists
    fs.mkdirSync(filepath)

  @create_file: (filename, content) ->
    filepath = path.join(process.cwd(), filename)
    return if fs.existsSync(filepath)
    fs.writeFileSync(filepath, content, 'utf8')
  
  @add_setup_require: (module) ->
    filepath = path.join(process.cwd(), 'app/lib/setup.coffee')
    # return unless fs.existsSync(filepath)
    data = fs.readFileSync(filepath, 'utf8')
    line = "require('#{module}')"
    if data.indexOf(line) == -1
      data += "\n#{line}"
      fs.writeFileSync(filepath, data, 'utf8')

module.exports = Generator