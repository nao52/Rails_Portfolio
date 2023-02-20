class SubjectPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]

  def create
    @post = current_user.subject_posts.build(subject_post_params)
    if @post.save
      flash[:success] = "新規投稿を行いました！"
      redirect_back(fallback_location: root_url)
    else
      flash.now[:danger] = "新規投稿に失敗しました..."
      @group = Subject.find(subject_post_params[:subject_id])
      @posts = SubjectPost.where(subject_id: subject_post_params[:subject_id]).page(params[:page]).per(30)
      render 'subjects/show', status: :unprocessable_entity
    end
  end

  def destroy
    content = @subject_post.content
    @subject_post.destroy
    flash[:success] = "投稿(#{content})を削除しました"
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  private

    def subject_post_params
      params.require(:subject_post).permit(:subject_id, :content)
    end

    # before フィルタ

    # 現在のユーザーが作成者であるか確認
    def correct_user
      @subject_post = current_user.subject_posts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @subject_post.nil?
    end

end
