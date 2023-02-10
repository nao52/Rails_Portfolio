class Club < ApplicationRecord
  has_many :users
  has_many :club_posts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
