class Publisher < ApplicationRecord
  belongs_to :user

  validates :name,  presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
  validates :user_id, presence: true
end
