path = require('path')
{log, loge, assert} = require('../util')
fs = require('fs')
request = require('request')

Generator = require('./generator')

class NVD3 extends Generator
  @nvd3: ->
    Generator.create_dir 'app/vendor'
    request 'https://raw.github.com/novus/nvd3/master/nv.d3.js', (err, res) ->
      Generator.create_file 'app/vendor/nv.d3.js', res.body
      Generator.add_setup_require 'vendor/nv.d3'

module.exports = NVD3.nvd3