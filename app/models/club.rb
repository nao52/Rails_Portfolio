class Club < ApplicationRecord
  has_many :users, dependent: :destroy
end
