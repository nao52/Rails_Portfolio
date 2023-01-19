class ClubsController < ApplicationController

  def index
    @clubs = Club.all
  end

  def show
    @club = Club.find(params[:id])
    @posts = ClubPost.where(club_id: params[:id])
  end

end
