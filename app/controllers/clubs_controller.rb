class ClubsController < ApplicationController
  before_action :set_club,   only: [:show, :members]

  def index
    @clubs = Club.all
  end

  def show
    @post = current_user.club_posts.build if logged_in?
    @posts = ClubPost.where(club_id: params[:id]).page(params[:page]).per(30)
  end

  def members
    @users = @group.users.page(params[:page]).per(30)
  end

  private

    def set_club
      @group = Club.find(params[:id])
    end

end
