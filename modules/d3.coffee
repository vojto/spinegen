path = require('path')
{log, loge, assert} = require('../util')
fs = require('fs')

Generator = require('./generator')

class D3 extends Generator
  @binding: ->
    Generator.add_dependencies
      'd3': '*'

    Generator.patch_json 'slug.json', (slug) ->
      slug.dependencies.push('d3/d3.v2.js')

    Generator.install_npm()

module.exports = D3.binding