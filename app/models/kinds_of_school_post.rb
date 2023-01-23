class KindsOfSchoolPost < ApplicationRecord
  belongs_to :user
  belongs_to :kinds_of_school

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :kinds_of_school_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
