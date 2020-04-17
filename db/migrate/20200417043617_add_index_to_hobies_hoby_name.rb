class AddIndexToHobiesHobyName < ActiveRecord::Migration[6.0]
  def change
    add_index :hobies, :hoby_name, unique: true
  end
end
