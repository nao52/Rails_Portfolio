class Publisher < ApplicationRecord
  belongs_to :user

  has_many :reference_books

  validates :name,  presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
  validates :user_id, presence: true
end
