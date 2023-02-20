class SubjectsController < ApplicationController
  before_action :set_subject,   only: [:show, :members]

  def index
    @subjects = Subject.all
  end

  def show
    @post  = current_user.subject_posts.build if logged_in?
    @posts = SubjectPost.where(subject_id: params[:id]).page(params[:page]).per(30)
  end

  def members
    @users = @group.users.page(params[:page]).per(30)
  end

  private

    def set_subject
      @group = Subject.find(params[:id])
    end

end
