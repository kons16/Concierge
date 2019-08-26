class AddChatRoomToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :chat_room, :integer, default: -1
  end
end
