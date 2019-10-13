class RoomsController < ApplicationController
  def show
    if current_user.chat_room != -1
      @room = Room.find(current_user.chat_room)
      @messages = @room.messages
      @target_user = User.where(chat_room: @room.id).where.not(id: current_user.id).first
    else
      redirect_to root_path
    end
  end

  # チャットを終了する
  def end_chat
    end_change_user
    current_user.save!
    @target_user.save!
    redirect_to root_path
  end

  # ユーザーを通報する
  def report_user
    Report.create!({user_id: current_user.id, target_id: params[:target_id]})
    @reported_user_count = Report.where(target_id: params[:target_id]).count

    end_change_user
    if @reported_user_count >= 2
      User.find(params[:target_id]).destroy
    end
    redirect_to root_path
  end

  private

  # チャット終了とユーザー通報で共通した変更処理
  def end_change_user
    @target_user = User.where(chat_room: current_user.chat_room).where.not(id: current_user.id).first
    @target_user.chat_request = 0
    @target_user.chat_room = -1
    current_user.chat_request = 0
    current_user.chat_room = -1

    current_user.increment!(:chat_count, 1)
    @target_user.increment!(:chat_count, 1)
  end
end
