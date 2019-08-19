class UsersController < ApplicationController
  before_action :logged_in_user, only:[:add_hoby, :delete_hoby, :chat_request]
  before_action :correct_user, only: :delete_hoby

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  # 趣味を新たに追加する
  def add_hoby
    @add_hoby = params[:hoby_name]
    # 同じ名前の趣味がまだ登録されていないときのみ登録
    my_hobies = current_user.hoby.pluck(:hoby_name)
    if my_hobies.exclude?(@add_hoby)
      current_user.user_hoby.build(hoby: Hoby.find_or_create_by(hoby_name: @add_hoby))
      if current_user.save
        redirect_to user_path(current_user.id)
      end
    else
      redirect_to user_path(current_user.id)
    end
  end

  # 登録している趣味を中間テーブルから削除する
  def delete_hoby
    @delete_hoby = params[:id]
    @my_hoby = current_user.user_hoby.find_by(hoby_id: @delete_hoby)
    if @my_hoby.delete
      redirect_to user_path(current_user.id)
    end
  end

  # チャット申請する
  def chat_request
    original = current_user.id.to_i
    dest_user = User.find(params[:dest_id])
    @dest_user_request = dest_user.chat_request

    if @dest_user_request == 0 and @dest_user_request != -2
      dest_user.chat_request = original
      User.find(current_user.id).chat_request = -2
    else

    end

    if dest_user.save
      redirect_to user_path(current_user.id)
    end
  end

  private
    def hoby_params
      params.require(:hoby).permit(:hoby_name)
    end

    def correct_user
      @hoby = current_user.hoby.find_by(id: params[:id])
      redirect_to root_url if @hoby.nil?
    end
end
