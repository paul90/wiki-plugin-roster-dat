# build time tests for roster plugin
# see http://mochajs.org/

{parse, includes} = require '../client/roster'
expect = require 'expect.js'

describe 'roster plugin', ->

  describe 'site markup', ->

    it 'makes image', ->
      result = parse null, {text: 'fed.wiki.org'}
      expect(result).to.match /<img class="remote" src="\/\/fed.wiki.org\/favicon.png"/
 
    it 'has title', ->
      result = parse null, {text: 'fed.wiki.org'}
      expect(result).to.match /title="fed.wiki.org"/
 
    it 'has site data', ->
      result = parse null, {text: 'fed.wiki.org'}
      expect(result).to.match /data-site="fed.wiki.org"/
 
    it 'has slug data', ->
      result = parse null, {text: 'fed.wiki.org'}
      expect(result).to.match /data-slug="welcome-visitors"/
 
  describe 'end of line markup', ->

    it 'has anchor', ->
      result = parse null, {text: 'fed.wiki.org'}
      expect(result).to.match /<a class='loadsites' href= "\/#"/
 
    it 'has title', ->
      result = parse null, {text: 'fed.wiki.org'}
      expect(result).to.match /title="add these 1 sites\nto neighborhood"/
 
    it 'has » at end of line', ->
      result = parse null, {text: 'fed.wiki.org'}
      expect(result).to.match />»<\/a><br>/
 
  describe 'category', ->

    it 'end of line', ->
      result = parse null, {text: 'students'}
      expect(result).to.match /students *<br>/

