class RoomsController < ApplicationController
  def show
    if Room.find(current_user.chat_room)
      @room = Room.find(params[:id])
      @messages = @room.messages
    end
end
