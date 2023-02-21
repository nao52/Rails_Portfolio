class PrivateGroupPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]

  def create
    @post = current_user.private_group_posts.build(private_group_post_params)
    if @post.save
      flash[:success] = "新規投稿を行いました！"
      redirect_back(fallback_location: root_url)
    else
      flash.now[:danger] = "新規投稿に失敗しました..."
      @group = PrivateGroup.find(private_group_post_params[:private_group_id])
      @posts = PrivateGroupPost.where(private_group_id: private_group_post_params[:private_group_id]).page(params[:page]).per(30)
      render 'private_groups/show', status: :unprocessable_entity
    end
  end

  def destroy
    content = @private_group_post.content
    @private_group_post.destroy
    flash[:success] = "投稿(#{content})を削除しました"
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  private

    def private_group_post_params
      params.require(:private_group_post).permit(:private_group_id, :content)
    end

    def correct_user
      @private_group_post = current_user.private_group_posts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @private_group_post.nil?
    end

end
