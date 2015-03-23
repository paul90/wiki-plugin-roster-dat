###
 * Federated Wiki : Roster Plugin
 *
 * Licensed under the MIT license.
 * https://github.com/fedwiki/wiki-plugin-roster/blob/master/LICENSE.txt
###
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


emit = ($item, item) ->
  roster = {all: []}
  category = null

  flag = (site) ->
    roster.all.push site
    if category?
      roster[category] ||= []
      roster[category].push site
     "<img class=\"remote\" src=\"//#{site}/favicon.png\" title=\"#{site}\" data-site=\"#{site}\" data-slug=\"welcome-visitors\">"

  cat = (name) ->
    category = name

  expand = (text)->
    text
      .replace /&/g, '&amp;'
      .replace /</g, '&lt;'
      .replace />/g, '&gt;'
      .replace /\*(.+?)\*/g, '<i>$1</i>'
      .replace /^$/, '<br>'
      .replace /^([a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+)$/, flag
      .replace /^([^<].*)$/, cat


  $item.addClass 'roster-source'
  $item.get(0).getRoster = -> roster
  lines = (expand(line) for line in item.text.split /\r?\n/)
  $item.append """
    <p style="background-color:#eee;padding:15px;">
      #{lines.join ' '}
    </p>
  """

bind = ($item, item) ->
  $item.dblclick -> wiki.textEditor $item, item


window.plugins.roster = {emit, bind} if window?
module.exports = {} if module?

