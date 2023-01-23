class ClubsController < ApplicationController

  def index
    @clubs = Club.all
  end

  def show
    @club = Club.find(params[:id])
    @post = current_user.club_posts.build if logged_in?
    @posts = ClubPost.where(club_id: params[:id])
  end

end
