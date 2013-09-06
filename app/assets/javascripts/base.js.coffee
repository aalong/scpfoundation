
resize_logs = ->
  messagesDiv = document.getElementById 'messages_container'
  if messagesDiv != null
    messagesDiv.scrollTop = messagesDiv.scrollHeight

$(document).ready(resize_logs)
$(document).on('page:load', resize_logs)
