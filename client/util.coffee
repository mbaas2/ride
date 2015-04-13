# a kitchen sink of small functions and jQuery plugins

@onCodeMirrorDoubleClick = (cm, f) ->
  # CodeMirror supports 'dblclick' events but they are unreliable and seem to require rather a short time between the two clicks
  # So, let's track clicks manually:
  lct = lcx = lcy = 0 # last click's timestamp, x, and y
  cm.on 'mousedown', (cm, e) ->
    if e.timeStamp - lct < 400 && Math.abs(lcx - e.x) + Math.abs(lcy - e.y) < 10 then f e
    lct = e.timeStamp; lcx = e.x; lcy = e.y; return
  return

$.alert = (message, title, callback) ->
  $('<p>').text(message).dialog modal: 1, title: title, buttons: [
    text: 'OK', click: -> $(@).dialog 'close'; callback?(); return
  ]
  return

htmlChars = '<': '&lt;', '>': '&gt;', '&': '&amp;'
@esc = (s) -> s.replace /[<>&]/g, (x) -> htmlChars[x]

@join = (a) -> a.join ''

$.fn.insert = (s) -> # replace selection in an <input> or <textarea> with "s"
  @each ->
    if (x = @selectionStart)? && (y = @selectionEnd)?
      @value = @value[...x] + s + @value[y..]; @selectionStart = @selectionEnd = x + s.length
    return # TODO: IE support
