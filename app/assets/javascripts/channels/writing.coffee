document.addEventListener 'turbolinks:load', ->
App.writing = App.cable.subscriptions.create { channel: "WritingChannel" },
  connected: ->

  disconnected: ->

  received: (data) ->
    show_user = $('#show_user').data('show_user')
    if show_user == data['writting_id']
      document.getElementById('on_input_status').innerHTML = ""
    else
      document.getElementById('on_input_status').innerHTML = data['announce']

  write: (announce) ->
    @perform 'write', announce: announce


$(document).on 'input', '[data-behavior~=room_speaker]', (event) ->
  App.writing.write "相手ユーザーが入力中です"