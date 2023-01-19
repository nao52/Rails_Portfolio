class KindsOfSchool < ApplicationRecord
  has_many :users
  has_many :kinds_of_school_posts, dependent: :destroy
end
