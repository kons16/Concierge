class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.references :user, foreign_key: true
      t.integer :target_id

      t.timestamps
    end
  end
end
