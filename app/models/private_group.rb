class PrivateGroup < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true

  has_many :private_group_posts, dependent: :destroy
  has_many :participations, dependent: :destroy

  validates :name,   presence: true, length: { maximum: 50 }
  validates :detail, length: { maximum: 140 }

end
