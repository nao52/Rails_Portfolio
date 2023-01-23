class PrivateGroup < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true

  validates :name,   presence: true, length: { maximum: 50 }
  validates :detail, length: { maximum: 140 }

end
