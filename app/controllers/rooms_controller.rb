class RoomsController < ApplicationController
  def show
    if current_user.chat_room != -1
      @room = Room.find(current_user.chat_room)
      @messages = @room.messages
      @target_id = User.where(chat_room: @room.id).where.not(id: current_user.id).first
      puts @target_id.id
    else
      redirect_to root_path
    end
  end

  # チャットを終了する
  def end_chat

  end

  # ユーザーを通報する
  def report_user
    Report.create!({user_id: current_user.id, target_id: params[:target_id]})
    redirect_to root_path
  end
end
