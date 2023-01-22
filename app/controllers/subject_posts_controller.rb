class SubjectPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @post = current_user.subject_posts.build(subject_post_params)
    if @post.save
      redirect_back(fallback_location: root_url)
    else
      @subject = Subject.find(params[:id])
      @posts = SubjectPost.where(subject_id: params[:id])
      render 'subjects/show', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

    def subject_post_params
      params.require(:subject_post).permit(:content, :subject_id)
    end

end
