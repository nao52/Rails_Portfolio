class Subject < ApplicationRecord
  has_many :users
  has_many :subject_posts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
