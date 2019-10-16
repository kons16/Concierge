document.addEventListener 'turbolinks:load', ->
App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id') },
  connected: ->

  disconnected: ->

  received: (data) ->
    show_user = $('#show_user').data('show_user')
    if data['chat_user'] == show_user
      $('#messages').append data['message_right']
      if data['message_right'].length >= 10
        $('#make_question_now').append "質問を生成中"
    else
      $('#messages').append data['message_left']
      if data['message_left'].length >= 10
        $('#make_question_now').append "質問を生成中"

  speak: (message) ->
    @perform 'speak', message: message

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value
    event.target.value = ''
    event.preventDefault()

