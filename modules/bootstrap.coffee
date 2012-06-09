fs = require('fs')
path = require('path')
{log, logs, loge, assert} = require('../util')
{exec} = require('child_process')
fs = require('fs')
sys = require('util')


bootstrap = ->
  log 'downloading'
  exec path.join(__dirname, 'bootstrap.sh'), (err, stdout, stderr) ->
    assert !err, err
    sys.puts(stdout)

    patch()

    logs 'finished'

patch = ->
  log 'patching index.html'
  cwd = process.cwd()
  index_path = path.join(cwd, "public", "index.html")
  content = fs.readFileSync(index_path, 'utf8')
  lines = content.split('\n')

  patch_line = '<link rel="stylesheet" href="/bootstrap/css/bootstrap.min.css" type="text/css" charset="utf-8">'

  if content.indexOf(patch_line) != -1
    loge 'already patched'
    return

  success = false
  for line, i in lines
    offset = line.indexOf('<link rel="stylesheet"')
    if offset != -1
      patch_line = ' ' + patch_line for j in [1..offset]
      lines.splice(i, 0, patch_line)
      success = true
      break
  loge 'failed to patch index.html' unless success

  data = lines.join('\n')
  fs.writeFileSync(index_path, data, 'utf8')


module.exports = bootstrap