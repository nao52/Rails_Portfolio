class WorksheetFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :worksheet

  validates :user_id,       presence: true
  validates :worksheet_id,  presence: true
end
