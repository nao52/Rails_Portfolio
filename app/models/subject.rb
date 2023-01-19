class Subject < ApplicationRecord
  has_many :users
  has_many :subject_posts, dependent: :destroy
end
