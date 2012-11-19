path = require('path')
{log, loge, assert} = require('../util')
fs = require('fs')

Generator = require('./generator')

class Atmos2 extends Generator
  @binding: ->
    Generator.add_dependencies
      'atmos2': 'git://github.com/vojto/atmos2.git#lite'

    Generator.patch_json 'slug.json', (slug) ->
      slug.dependencies.push('atmos2')

    Generator.install_npm()

module.exports = Atmos2.binding