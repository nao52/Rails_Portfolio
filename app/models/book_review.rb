class BookReview < ApplicationRecord
  belongs_to :user
  belongs_to :reference_book

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :reference_book_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
