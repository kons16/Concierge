class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :chat_context
      t.string :q_context
      t.integer :user_id
      t.integer :target_id
      t.integer :room_id

      t.timestamps
    end
  end
end
