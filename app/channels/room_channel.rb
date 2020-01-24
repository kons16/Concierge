class RoomChannel < ApplicationCable::Channel
  include CarrierwaveBase64Uploader

  # クライアントと接続されたとき
  def subscribed
    stream_from "room_channel"
  end

  # クライアントと接続が解除されたとき
  def unsubscribed
  end

  def speak(data)
    if data['message'].length >= 300 then
      b64_encoder = base64_conversion(data['message'])
      Message.create!({context: "image_not_null", user_id: current_user.id,
                       room_id: current_user.chat_room,
                       image: b64_encoder})
    else
      Message.create!({context: data['message'], user_id: current_user.id, room_id: current_user.chat_room})
    end
  end
end
