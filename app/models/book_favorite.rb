class BookFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :reference_book
end
