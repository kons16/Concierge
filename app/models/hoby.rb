class Hoby < ApplicationRecord
  has_many :user_hoby
  has_many :user, through: :user_hoby
  accepts_nested_attributes_for :user_hoby
end
