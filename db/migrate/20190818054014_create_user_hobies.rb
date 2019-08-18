class CreateUserHobies < ActiveRecord::Migration[5.1]
  def change
    create_table :user_hobies do |t|
      t.references :user, foreign_key: true
      t.references :hoby, foreign_key: true

      t.timestamps
    end
  end
end
