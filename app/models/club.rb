class Club < ApplicationRecord
  has_many :users
  has_many :club_posts, dependent: :destroy
end
