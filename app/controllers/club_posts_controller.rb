class ClubPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]

  def create
    @post = current_user.club_posts.build(club_post_params)
    if @post.save
      flash[:success] = "新規投稿を行いました！"
      redirect_back(fallback_location: root_url)
    else
      flash.now[:danger] = "新規投稿に失敗しました..."
      @group = Club.find(club_post_params[:club_id])
      @posts = ClubPost.where(club_post_params[:club_id]).page(params[:page]).per(30)
      render 'clubs/show', status: :unprocessable_entity
    end
  end

  def destroy
    content = @club_post.content
    @club_post.destroy
    flash[:success] = "投稿(#{content})を削除しました"
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  private

    def club_post_params
      params.require(:club_post).permit(:club_id, :content)
    end

    def correct_user
      @club_post = current_user.club_posts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @club_post.nil?
    end
end
