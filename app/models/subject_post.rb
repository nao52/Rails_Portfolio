class SubjectPost < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  
  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 140 }
end
