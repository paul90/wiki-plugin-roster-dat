
flag = (site) ->
  "<img class=\"remote\" src=\"//#{site}/favicon.png\" title=\"#{site}\" data-site=\"#{site}\" data-slug=\"welcome-visitors\">"

expand = (text)->
  text
    .replace /&/g, '&amp;'
    .replace /</g, '&lt;'
    .replace />/g, '&gt;'
    .replace /\*(.+?)\*/g, '<i>$1</i>'
    .replace /^$/, '<br>'
    .replace /^([a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+)$/, flag('$1')

emit = ($item, item) ->
  lines = (expand(line) for line in item.text.split /\r?\n/)
  $item.append """
    <p style="background-color:#eee;padding:15px;">
      #{lines.join ' '}
    </p>
  """

bind = ($item, item) ->
  $item.dblclick -> wiki.textEditor $item, item

window.plugins.roster = {emit, bind} if window?
module.exports = {expand} if module?

