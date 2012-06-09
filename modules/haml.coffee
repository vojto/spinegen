fs = require('fs')
path = require('path')
{log, logs, loge, assert} = require('../util')
{exec} = require('child_process')
fs = require('fs')
sys = require('util')

haml = ->
  log 'using haml'
  cwd = process.cwd()
  log cwd
  package_filename = path.join(cwd, 'package.json')
  try
    data = fs.readFileSync(package_filename, 'utf8')
  catch error
    loge 'cannot read ./package.json'
    return
  packages = JSON.parse(data)
  assert packages.dependencies, 'package.json should contain dependencies'
  packages.dependencies['hem-haml-coffee'] = '*'
  data = JSON.stringify(packages, null, 2)
  fs.writeFileSync(package_filename, data, 'utf8')

  log 'creating slug.js'
  slug_filename = path.join(cwd, 'slug.js')
  if path.existsSync(slug_filename)
    loge 'please remove you current slug.js before installing haml'
    return

  code = "var argv = process.argv.slice(2)\nrequire('hem-haml-coffee').exec(argv[0])\n"
  fs.writeFileSync(slug_filename, code, 'utf8')

  log 'installing dependencies'
  exec 'npm install .', (err, stdout, stderr) ->
    assert !err, err
    sys.puts(stdout)
    logs 'finished'

module.exports = haml