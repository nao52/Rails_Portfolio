class WorksheetFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :worksheet
end
