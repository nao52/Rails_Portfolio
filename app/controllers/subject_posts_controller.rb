class SubjectPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]

  def create
    @post = current_user.subject_posts.build(subject_post_params)
    if @post.save
      redirect_back(fallback_location: root_url)
    else
      @group = Subject.find(params[:id])
      @posts = SubjectPost.where(subject_id: params[:id])
      render 'subjects/show', status: :unprocessable_entity
    end
  end

  def destroy
    @subject_post.destroy
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  private

    def subject_post_params
      params.require(:subject_post).permit(:content, :subject_id)
    end

    # before フィルタ

    # 現在のユーザーが作成者であるか確認
    def correct_user
      @subject_post = current_user.subject_posts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @subject_post.nil?
    end

end
