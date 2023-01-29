class BookFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :reference_book

  validates :user_id,            presence: true
  validates :reference_book_id,  presence: true
end
