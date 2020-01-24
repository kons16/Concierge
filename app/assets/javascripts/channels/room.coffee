document.addEventListener 'turbolinks:load', ->
App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id') },
  connected: ->

  disconnected: ->

  received: (data) ->
    show_user = $('#show_user').data('show_user')
    # console.log data['question']
    if show_user == data['chat_user']
      $('#messages').append data['message_right']
      document.getElementById('make_question_now').innerHTML = ""
    else
      $('#messages').append data['message_left']
      if data['question'] != ""
        document.getElementById('make_question_now').innerHTML = "提案Q. "+data['question']
      else
        document.getElementById('make_question_now').innerHTML = ""

    document.getElementById('load_mark').textContent = null

  speak: (message) ->
    # メッセージが10文字以上のときロードgifを表示させる
    if message.length >= 10 && message.length <= 100
      load_mark = document.getElementById('load_mark')
      date = new Date
      timestamp = date.getTime()
      img = document.createElement('img')
      img.src = '/load_image/gif-load.gif?' + timestamp
      load_mark.textContent = null
      load_mark.appendChild img

    @perform 'speak', message: message

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value
    event.target.value = ''
    event.preventDefault()

# 画像をドロップしたときの処理
document.addEventListener 'dragover', (e) ->
  e.preventDefault()
  e.stopPropagation()
  e.dataTransfer.dropEffect = 'copy'
  return

document.addEventListener 'drop', (e) ->
  file = e.dataTransfer.files[0]
  reader = new FileReader
  reader.addEventListener 'load', (->
    # document.getElementById('img_test').src = reader.result
    App.room.speak reader.result
    return
  ), false

  reader.readAsDataURL file

  e.preventDefault()

  # e.target.value = ''
  return