class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_uniqueness_of :search_id
  has_many :user_hoby, foreign_key: :user_id, dependent: :destroy
  has_many :hoby, through: :user_hoby, dependent: :destroy
  has_many :report
  has_many :messages, foreign_key: :user_id, dependent: :destroy

  mount_uploader :icon, IconUploader

  def to_param
    search_id
  end
end
