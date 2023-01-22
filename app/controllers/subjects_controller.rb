class SubjectsController < ApplicationController

  def index
    @subjects = Subject.all
  end

  def show
    @subject = Subject.find(params[:id])
    @post = current_user.subject_posts.build if logged_in?
    @posts = SubjectPost.where(subject_id: params[:id])
  end

end
