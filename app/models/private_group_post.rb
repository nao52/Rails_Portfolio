class PrivateGroupPost < ApplicationRecord
  belongs_to :user
  belongs_to :private_group

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :private_group_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end