class ClubsController < ApplicationController

  def index
    @clubs = Club.all
  end

  def show
    @subject = Subject.find(params[:id])
    @posts = SubjectPost.where(subject_id: params[:id])
  end

end
