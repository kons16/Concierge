class HomeController < ApplicationController
  def index
    if user_signed_in?
      # もしチャット申請がきている場合画面に表示させる
      @announce = ""
      chat_request = User.find(current_user.id).chat_request
      @origin_user = User.find(chat_request)
      if chat_request != 0 and chat_request != -2
        @announce = "チャット申請がきてます！"
      end
    end
  end

  def show
  end
end
