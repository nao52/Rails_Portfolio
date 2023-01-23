class ClubsController < ApplicationController
  before_action :set_subject,   only: [:show, :members]

  def index
    @clubs = Club.all
  end

  def show
    @post = current_user.club_posts.build if logged_in?
    @posts = ClubPost.where(club_id: params[:id])
  end

  def members
    @users = @group.users
  end

  private

    def set_subject
      @group = Club.find(params[:id])
    end

end
