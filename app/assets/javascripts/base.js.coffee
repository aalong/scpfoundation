
resize_logs = ->
  if $('#messages_container').length > 0
    $('html').scrollTop($(document).height())

$(document).on 'click', '.fold_action', ->
  parent = $(this).parent()
  parent.find('.spoiler').toggle 'fast'
  if $(this).html() == parent.find('.show_action').html()
    $(this).html parent.find('.hide_action').html()
  else
    $(this).html parent.find('.show_action').html()

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


$(document).on 'click', "#pages_preview_button", ->
  action = $(this).attr("href")
  content = $.param { content: $("#wmd-input").val() }
  title = $("#page_title").val()
  $.ajax
    type: "POST"
    url: action
    data: content
    async: true
    success: (data) ->
      $("#page_preview_title").html title
      $("#page_preview_content").html data

    error: ->
      alert "Something went wrong."

    complete: ->
      false

  false


prepare_chosen = ->
  if $('#room_user_ids').length > 0
    $('#room_user_ids').chosen()
  if $('#page_user_ids').length > 0
    $('#page_user_ids').chosen()

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

$('a[rel=external]').attr('target','_blank')

flash_message = (content) ->
  $('div#flash').html("<div class='alert alert-success' id='new_flash'>#{content}</div>")
    .fadeOut().fadeIn().fadeOut().fadeIn()
    .click ->
      $('div#flash').html ''

boot = ->
  load_editor()
  resize_logs()
  load_atwho()
  prepare_chosen()

$(document).ready(boot)
$(document).on('page:load', boot)

$(window).resize ->
  resize_logs()
