class WorksheetFavoritesController < ApplicationController

  def create
    worksheet = Worksheet.find(params[:worksheet_id])
    current_user.favorite_worksheet(worksheet)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    worksheet = WorksheetFavorite.find(params[:id]).worksheet
    current_user.unfavorite_worksheet(worksheet)
    redirect_back(fallback_location: root_url, status: :see_other)
  end

end
