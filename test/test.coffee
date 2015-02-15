# build time tests for roster plugin
# see http://mochajs.org/

roster = require '../client/roster'
expect = require 'expect.js'

describe 'roster plugin', ->

  describe 'expand', ->

    it 'can make itallic', ->
      # result = roster.expand 'hello *world*'
      # expect(result).to.be 'hello <i>world</i>'
