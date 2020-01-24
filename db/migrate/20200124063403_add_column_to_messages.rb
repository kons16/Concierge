class AddColumnToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :image, :string
  end
end
