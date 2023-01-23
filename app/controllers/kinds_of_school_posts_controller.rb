class KindsOfSchoolPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]

  def create
    @post = current_user.kinds_of_school_posts.build(kinds_of_school_post_params)
    if @post.save
      redirect_back(fallback_location: root_url)
    else
      @kinds_of_school = KindsOfSchool.find(params[:id])
      @posts = KindsOfSchoolPost.where(kinds_of_school_id: params[:id])
      render 'kinds_of_schools/show', status: :unprocessable_entity
    end
  end

  def destroy
    @kinds_of_school_post.destroy
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  private

    def kinds_of_school_post_params
      params.require(:kinds_of_school_post).permit(:content, :kinds_of_school_id)
    end

    def correct_user
      @kinds_of_school_post = current_user.kinds_of_school_posts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @kinds_of_school_post.nil?
    end
end
