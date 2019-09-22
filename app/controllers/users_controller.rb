class UsersController < ApplicationController
  before_action :logged_in_user, only:[:add_hoby, :delete_hoby, :chat_request]
  before_action :correct_user, only: :delete_hoby

  # キーワードによるユーザー検索結果
  def index
    @users = []
    if Hoby.find_by(hoby_name: params[:keyword])
      hoby_id = Hoby.find_by!(hoby_name: params[:keyword]).id
      UserHoby.where(hoby_id: hoby_id).each do |get_user_hoby|
        @users.push(User.find(get_user_hoby["user_id"]))
      end
    end
  end

  # ユーザーのプロフィールページ
  def show
    @user = User.find_by!(search_id: params[:search_id])
  end

  # 趣味を新たに追加する
  def add_hoby
    @add_hoby = params[:hoby_name]
    if @add_hoby != ""
      # 同じ名前の趣味がまだ登録されていないときのみ登録
      my_hobies = current_user.hoby.pluck(:hoby_name)
      if my_hobies.exclude?(@add_hoby)
        current_user.user_hoby.build(hoby: Hoby.find_or_create_by(hoby_name: @add_hoby))
        if current_user.save
          redirect_to user_path(current_user.search_id)
        end
      else
        redirect_to user_path(current_user.search_id)
      end
    end
  end

  # 登録している趣味を中間テーブルから削除する
  def delete_hoby
    @delete_hoby = params[:id]
    @my_hoby = current_user.user_hoby.find_by(hoby_id: @delete_hoby)
    if @my_hoby.delete
      redirect_to user_path(current_user.search_id)
    end
  end

  # チャット申請する
  def chat_request
    original_user = User.find(current_user.id)
    dest_user = User.find_by!(search_id: params[:dest_search_id])
    original_user_id = current_user.id.to_i

    # チャット申請可能の場合
    if dest_user.chat_request == 0
      dest_user.chat_request = original_user_id
      original_user.chat_request = -2
    end

    if dest_user.save and original_user.save
      redirect_to user_path(current_user.search_id)
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
