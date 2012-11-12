path = require('path')
{log, loge, assert} = require('../util')
fs = require('fs')

Generator = require('./generator')

class SpineBinding extends Generator
  @binding: ->
    Generator.add_dependencies
      'spine-binding': '*'

    Generator.patch_json 'slug.json', (slug) ->
      slug.dependencies.push('spine-binding')

    Generator.install_npm()

module.exports = SpineBinding.binding