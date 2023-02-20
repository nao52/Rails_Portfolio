class Worksheet < ApplicationRecord
  belongs_to :user
  
  has_one_attached :file
  
  has_many :worksheet_favorites, dependent: :destroy
  
  default_scope -> { order(likes_count: :desc) }
  
  validates :name,   presence: true, length: { maximum: 50 }
  validates :detail, length: { maximum: 140 }
  validates :file, presence: true, content_type: { in: 'application/pdf', message: "フォーマットはPDFにしてください" }
  validates :likes_count, presence: true
end
