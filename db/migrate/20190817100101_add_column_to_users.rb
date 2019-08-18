class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :search_id, :string, unique: true
    add_column :users, :introduction, :text
    add_column :users, :chat_count, :integer
    add_column :users, :like_count, :integer
    add_column :users, :icon, :string
    add_column :users, :assist, :boolean
  end
end
