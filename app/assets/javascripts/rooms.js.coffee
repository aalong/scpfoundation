prepare_chosen = ->
  $('#room_user_ids').chosen()

$(document).ready(prepare_chosen)
$(document).on('page:load', prepare_chosen)
