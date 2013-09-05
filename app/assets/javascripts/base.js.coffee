
resize_logs = ->
  if $('#messages_container') != null
    $('body').scrollTop($(document).height())

toggle_sidebar = ->
  $('*[data-toggle="sidebar-collapse"]').click

$(document).on 'click', '*[data-toggle="sidebar-collapse"]', ->
  $('#sidebar-content').toggleClass 'hidden-xs'

$(document).on 'ajax:complete', '#new_message', (event,xhr,status) ->
  $('#message_content').val ''

$(document).on 'keypress', '#message_content', (e) ->
  if e.keyCode == 13 && !e.shiftKey
    $('#send_message_button').click()

$(document).ready(resize_logs)
$(document).on('page:load', resize_logs)
