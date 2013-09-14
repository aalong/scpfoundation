
resize_logs = ->
  if $('#messages_container').length > 0
    $('body').scrollTop($(document).height())
$(document).ready(resize_logs)
$(document).on('page:load', resize_logs)

toggle_sidebar = ->
  $('*[data-toggle="sidebar-collapse"]').click
$(document).on 'click', '*[data-toggle="sidebar-collapse"]', ->
  $('#sidebar-content').toggleClass 'hidden-xs'

$(document).on 'ajax:complete', '#new_message', (event,xhr,status) ->
  $('#message_content').val ''

$(document).on 'keypress', '#message_content', (e) ->
  if e.keyCode == 13 && !e.shiftKey
    $('#send_message_button').click()

load_editor = ->
  content_textarea = $('textarea.wmd-input')
  if content_textarea.length != 0
    content_textarea.before '<div id="wmd-button-bar"></div>'
    converter = -> makeHtml: (text) -> text
    help = -> (alert 'No help for you')
    options =
      helpButton: { handler: help }
      strings: { quoteexample: 'Hello, SCPF World!' }
    editor = new Markdown.Editor(converter, '', options)
    editor.run()

$(document).ready(load_editor)
$(document).on('page:load', load_editor)
