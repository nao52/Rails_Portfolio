class Worksheet < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  
  has_one_attached :file
  validates :file, presence: true, content_type: { in: 'application/pdf', message: "フォーマットはPDFにしてください" }
  
  validates :name,   presence: true, length: { maximum: 50 }
  validates :detail, length: { maximum: 140 }

  default_scope -> { order(created_at: :desc) }
end
