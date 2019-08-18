class CreateHobies < ActiveRecord::Migration[5.1]
  def change
    create_table :hobies do |t|
      t.string :hoby_name

      t.timestamps
    end
  end
end
