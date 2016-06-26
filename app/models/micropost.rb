class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  has_many :favorite, dependent:   :destroy
  has_many :favorite_users, through: :favorite, source: :user
end
