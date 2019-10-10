document.addEventListener 'turbolinks:load', ->
App.writing = App.cable.subscriptions.create { channel: "WritingChannel" },
  connected: ->

  disconnected: ->

  received: (data) ->
    document.getElementById('on_input_status').innerHTML = data

  write: (announce) ->
    @perform 'write', announce: announce

$(document).on 'input', '[data-behavior~=room_speaker]', (event) ->
  App.writing.write "相手ユーザーが入力中です。"