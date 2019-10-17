class HomeController < ApplicationController
#  チャット申請・断るときの遷移 chat_requestの初期値は0
#  DestUser(申請先) : OriginUserのID　  → 0 (NG)
#                                     → -1 (OK)
#  OriginalUser(申請元) : -2           →　-4 (NG)  → 0
#                                     → -1  (OK)

  def index
    if user_signed_in?
      # もしチャット申請がきている場合画面に表示させる
      @announce = ""
      @chat_status = 0
      chat_request = User.find(current_user.id).chat_request

      if chat_request != 0

        if chat_request != -2 and chat_request != -4 and chat_request != -1 # チャット申請が送られてきた
          @announce = "チャット申請がきてます！"
          @chat_status = 1
          @origin_user = User.find(chat_request)

        elsif chat_request == -4 # チャット申請が断られた
          @announce = "チャット申請が断られました。"
          @chat_status = 2
          current_user.chat_request = 0
          current_user.save

        elsif chat_request == -1    # チャットルームへ移動
          chatroom_id = current_user.chat_room
          @announce = chatroom_id
          @chat_status = 3
          redirect_to rooms_path()
        end

      else
        @announce = ""
        @chat_status = 0
      end

    end
  end

  # チャット申請を断る
  def reject
    @origin_user = User.find(params[:origin_id])
    current_user.chat_request = 0
    @origin_user.chat_request = -4
    current_user.save!
    @origin_user.save!
  end

  # チャット申請を許諾する
  def create_room
    @room = Room.create!
    @origin_user = User.find(params[:origin_id])

    current_user.chat_room = @room.id
    @origin_user.chat_room = @room.id

    current_user.chat_request = -1
    @origin_user.chat_request = -1

    current_user.save!
    @origin_user.save!
    redirect_to root_path
  end
end
