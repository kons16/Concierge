class RoomChannel < ApplicationCable::Channel
  # クライアントと接続されたとき
  def subscribed
    # クライアントが受信すべきストリーム
    stream_from "room_channel"
  end

  # クライアントと接続が解除されたとき
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # room.jsで実行されたspeakのmessageをroom_chanelのreceivedにブロードキャスト
    ActionCable.server.broadcast 'room_channel', message: data['message']
  end
end
