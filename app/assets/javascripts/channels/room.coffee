document.addEventListener 'turbolinks:load', ->
App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id') },
  connected: ->

  disconnected: ->

  speak: (message) ->
    @perform 'speak', message: message

  nowinput: () ->
    @perform 'now_input', message: message

  received: (data) ->
    show_user = $('#show_user').data('show_user')
    if data['chat_user'] == show_user
      $('#messages').append data['message_right']
    else
      $('#messages').append data['message_left']

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value
    event.target.value = ''
    event.preventDefault()

