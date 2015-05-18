###
 * Federated Wiki : Roster Plugin
 *
 * Licensed under the MIT license.
 * https://github.com/fedwiki/wiki-plugin-roster/blob/master/LICENSE.txt
###
#
# Sample Roster Accessing Code
#
# Any item that exploses a roster will be identifed with class "roster-source".
# These items offer the method getRoster() for retrieving the roster object.
# Convention has roster consumers looking left for the nearest (or all) such objects.
#
#     items = $(".item:lt(#{$('.item').index(div)})")
#     if (sources = items.filter ".roster-source").size()
#       choice = sources[sources.length-1]
#       roster = choice.getRoster()
#
# This simplified version might be useful from the browser's javascript inspector.
#
#     $('.roster-source').get(0).getRoster()

load_sites = (uri) ->
  tuples = uri.split ' '
  while tuples.length
    site = tuples.shift()
    wiki.neighborhoodObject.registerNeighbor site

emit = ($item, item) ->
  roster = {all: []}
  category = null
  lineup = []

  flag = (site) ->
    roster.all.push site
    lineup.push site
    br = if lineup.length >= 18
      newline()
    else
      ''
    if category?
      roster[category] ||= []
      roster[category].push site
    "<img class=\"remote\" src=\"//#{site}/favicon.png\" title=\"#{site}\" data-site=\"#{site}\" data-slug=\"welcome-visitors\">#{br}"

  newline = ->
    if lineup.length > 1
      sites = ("#{site}" for site in lineup)
      lineup = []
      """ <a class='loadsites' href= "/#" data-sites="#{sites.join ' '}">▶︎</a><br> """
    else
      "<br>"

  cat = (name) ->
    category = name

  expand = (text)->
    text
      .replace /&/g, '&amp;'
      .replace /</g, '&lt;'
      .replace />/g, '&gt;'
      .replace /\*(.+?)\*/g, '<i>$1</i>'
      .replace /^$/, newline
      .replace /^([a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+)(:\d+)?$/, flag
      .replace /^localhost(:\d+)?$/, flag
      .replace /^([^<].*)$/, cat

  $item.addClass 'roster-source'
  $item.get(0).getRoster = -> roster
  lines = (expand(line) for line in item.text.split /\r?\n/)
  lines.push newline()
  $item.append """
    <p style="background-color:#eee;padding:15px;">
      #{lines.join ' '}
    </p>
  """

bind = ($item, item) ->
  $item.dblclick -> wiki.textEditor $item, item
  $item.find('.loadsites').click (e) ->
    e.preventDefault()
    e.stopPropagation()
    console.log 'roster sites', $(e.target).data('sites').split(' ')
    load_sites $(e.target).data('sites')


window.plugins.roster = {emit, bind} if window?
module.exports = {} if module?
