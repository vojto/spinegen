path = require('path')
{log, loge, assert} = require('../util')
fs = require('fs')

Generator = require('./generator')

class Haml extends Generator
  @haml: ->
    cwd = process.cwd()

    filename = path.join cwd, 'package.json'
    Generator.patch_json filename, (packages) ->
      assert packages.dependencies, 'package.json should contain dependencies'
      packages.dependencies['hem-haml-coffee'] = '*'

    slug = "var argv = process.argv.slice(2)\nrequire('hem-haml-coffee').exec(argv[0])\n"
    filename = path.join cwd, 'slug.js'
    Generator.create_file filename, slug

    Generator.install_npm()

module.exports = Haml.haml