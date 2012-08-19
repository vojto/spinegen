path = require('path')
{log, loge, assert} = require('../util')
fs = require('fs')

Generator = require('./generator')

class Jade extends Generator
  @jade: ->
    Generator.add_dependencies
      'jade': '*'
      'hem-jade': '*'

    Generator.patch_json 'slug.json', (slug) ->
      slug.dependencies.push('jade/lib/runtime')

    slug = "var argv = process.argv.slice(2);\nrequire('hem-jade');\nrequire('hem').exec(argv[0]);\n"
    Generator.create_file 'slug.js', slug

    Generator.install_npm()

module.exports = Jade.jade