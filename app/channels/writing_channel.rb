class WritingChannel < ApplicationCable::Channel
  # クライアントと接続されたとき
  def subscribed
    stream_from "writing:announce"
  end

  # クライアントと接続が解除されたとき
  def unsubscribed
  end

  def write(data)
    WritingChannel.broadcast_to('announce', announce: data['announce'], writting_id: current_user.id)
  end
end
