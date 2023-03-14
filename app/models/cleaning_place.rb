class CleaningPlace < ApplicationRecord
  belongs_to :user

  validates :name,  presence: true, length: { maximum: 50 }
  validates :boys_num,  presence: true, numericality: { only_integer: true, in: 0..10 }
  validates :girls_num,  presence: true, numericality: { only_integer: true, in: 0..10 }
end
