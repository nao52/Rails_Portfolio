class SubjectsController < ApplicationController

  def index
    @subjects = Subject.all
  end

  def show
    @subject = Subject.find(params[:id])
    @posts = SubjectPost.where(subject_id: params[:id])
  end

end
