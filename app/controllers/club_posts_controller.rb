class ClubPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]

  def create
    @post = current_user.club_posts.build(club_post_params)
    if @post.save
      redirect_back(fallback_location: root_url)
    else
      @group = Club.find(params[:id])
      @posts = ClubPost.where(club_id: params[:id]).page(params[:page]).per(30)
      render 'clubs/show', status: :unprocessable_entity
    end
  end

  def destroy
    @club_post.destroy
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  private

    def club_post_params
      params.require(:club_post).permit(:content, :club_id)
    end

    def correct_user
      @club_post = current_user.club_posts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @club_post.nil?
    end
end
