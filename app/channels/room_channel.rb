class RoomChannel < ApplicationCable::Channel
  # クライアントと接続されたとき
  def subscribed
    stream_from "room_channel"
  end

  # クライアントと接続が解除されたとき
  def unsubscribed
  end

  def speak(data)
    Message.create!({context: data['message'], user_id: current_user.id, room_id: current_user.chat_room})
    #Question.create!({chat_context: data['message'], q_context: a, user_id: current_user.id,
    #                 target_id: aaa, room_id: current_user.chat_room})
  end
end
