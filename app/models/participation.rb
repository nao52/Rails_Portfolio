class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :private_group

  validates :user_id,           presence: true
  validates :private_group_id,  presence: true
end
