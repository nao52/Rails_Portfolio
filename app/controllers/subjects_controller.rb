class SubjectsController < ApplicationController
  before_action :set_subject,   only: [:show, :members]

  def index
    @subjects = Subject.all
  end

  def show
    @title = @group.name
    @post  = current_user.subject_posts.build if logged_in?
    @posts = SubjectPost.where(subject_id: params[:id])
  end

  def members
    @users = @group.users
  end

  private

    def set_subject
      @group = Subject.find(params[:id])
    end

end
