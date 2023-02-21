class KindsOfSchoolPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]

  def create
    @post = current_user.kinds_of_school_posts.build(kinds_of_school_post_params)
    if @post.save
      flash[:success] = "新規投稿を行いました！"
      redirect_back(fallback_location: root_url)
    else
      flash.now[:danger] = "新規投稿に失敗しました..."
      @group = KindsOfSchool.find(kinds_of_school_post_params[:kinds_of_school_id])
      @posts = KindsOfSchoolPost.where(kinds_of_school_post_params[:kinds_of_school_id]).page(params[:page]).per(30)
      render 'kinds_of_schools/show', status: :unprocessable_entity
    end
  end

  def destroy
    content = @kinds_of_school_post.content
    @kinds_of_school_post.destroy
    flash[:success] = "投稿(#{content})を削除しました"
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  private

    def kinds_of_school_post_params
      params.require(:kinds_of_school_post).permit(:kinds_of_school_id, :content)
    end

    def correct_user
      @kinds_of_school_post = current_user.kinds_of_school_posts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @kinds_of_school_post.nil?
    end
end
