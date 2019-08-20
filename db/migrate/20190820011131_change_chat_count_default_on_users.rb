class ChangeChatCountDefaultOnUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :chat_count, from: nil, to: 0
    change_column_default :users, :like_count, from: nil, to: 0
  end
end
