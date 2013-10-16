
resize_logs = ->
  if $('#messages_container').length > 0
    $('html').scrollTop($(document).height())

toggle_sidebar = ->
  $('*[data-toggle="sidebar-collapse"]').click
$(document).on 'click', '*[data-toggle="sidebar-collapse"]', ->
  $('#sidebar-content').toggleClass 'hidden-xs'

$(document).on 'ajax:complete', '#new_message', (event,xhr,status) ->
  $('#message_content').val ''

$(document).on 'keypress', '#message_content', (e) ->
  if e.keyCode == 13 && !e.shiftKey
    $('#send_message_button').click()
    resize_logs()

$(document).on 'click', '.user_link', (e) ->
  e.preventDefault()
  textarea = $('#message_content')
  value = "#{textarea.val()} @#{this.innerHTML} "
  textarea.focus().val('').val(value)

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

load_atwho = ->
  participants = $('#participants_list')
  if participants.length > 0
    participants = JSON.parse participants.html()
    $('textarea.atwho').atwho({ at: '@', data: participants })

boot = ->
  load_editor()
  resize_logs()
  load_atwho()

$(document).ready(boot)
$(document).on('page:load', boot)
