class PrivateGroup < ApplicationRecord
  belongs_to :user
  
  has_many :private_group_posts, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :members, through: :participations, source: :user
  
  validates :name,    presence: true, length: { maximum: 50 }
  validates :detail,  length: { maximum: 140 }
end
