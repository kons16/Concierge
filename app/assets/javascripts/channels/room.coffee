document.addEventListener 'turbolinks:load', ->
App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id') },
  connected: ->

  disconnected: ->

  received: (data) ->
    show_user = $('#show_user').data('show_user')
    console.log data['question']
    if show_user == data['chat_user']
      $('#messages').append data['message_right']
      document.getElementById('make_question_now').innerHTML = ""
    else
      $('#messages').append data['message_left']
      document.getElementById('make_question_now').innerHTML = data['question']

  speak: (message) ->
    @perform 'speak', message: message

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value
    event.target.value = ''
    event.preventDefault()

