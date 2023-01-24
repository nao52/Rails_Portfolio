class PrivateGroupPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]

  def create
    @post = current_user.private_group_posts.build(private_group_post_params)
    if @post.save
      redirect_back(fallback_location: root_url)
    else
      @group = PrivateGroup.find(params[:id])
      @posts = PrivateGroupPost.where(private_group_id: params[:id])
      render 'private_groups/show', status: :unprocessable_entity
    end
  end

  def destroy
    @private_group_post.destroy
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  private

    def private_group_post_params
      params.require(:private_group_post).permit(:content, :private_group_id)
    end

    def correct_user
      @private_group_post = current_user.private_group_posts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @private_group_post.nil?
    end

end
