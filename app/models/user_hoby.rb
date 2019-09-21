class UserHoby < ApplicationRecord
  belongs_to :user
  belongs_to :hoby

  def self.search(search)
    if search
      where(['hoby_id LIKE ?', "%#{search}%"])
    else
      where(['hoby_id LIKE ?', ""])
    end
  end
end
