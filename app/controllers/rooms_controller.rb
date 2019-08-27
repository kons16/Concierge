class RoomsController < ApplicationController
  def show
    if current_user.chat_room != -1
      @room = Room.find(current_user.chat_room)
      @messages = @room.messages
    else
      redirect_to root_path
    end
  end
end
