class Subject < ApplicationRecord
  has_many :users, dependent: :destroy
end
