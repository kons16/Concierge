class UsersController < ApplicationController
  before_action :logged_in_user, only:[:add_hoby, :delete_hoby]
  before_action :correct_user, only: :delete_hoby

  def index
  end

  def show
  end

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

  def delete_hoby
    @delete_hoby = params[:id]
    @my_hoby = current_user.user_hoby.find_by(hoby_id: @delete_hoby)
    if @my_hoby.delete
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
