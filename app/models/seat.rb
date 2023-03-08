class Seat < ApplicationRecord
  belongs_to :user

  validates :seat_no, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :student_name, presence: true, length: { maximum: 50 }
end
