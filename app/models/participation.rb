class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :private_group
end
