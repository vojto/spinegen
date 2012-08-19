{log, loge, assert} = require('../util')
fs = require('fs')

Generator = require('./generator')

class Haml extends Generator
  @haml: ->
    Generator.add_dependencies('hem-haml-coffee': '*')

    slug = "var argv = process.argv.slice(2)\nrequire('hem-haml-coffee').exec(argv[0])\n"
    Generator.create_file 'slug.js', slug

    Generator.install_npm()

module.exports = Haml.haml