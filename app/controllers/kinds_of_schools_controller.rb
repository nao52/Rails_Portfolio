class KindsOfSchoolsController < ApplicationController

  def index
    @kinds_of_schools = KindsOfSchool.all
  end

  def show
    @kinds_of_school = KindsOfSchool.find(params[:id])
    @post = current_user.kinds_of_school_posts.build if logged_in?
    @posts = KindsOfSchoolPost.where(kinds_of_school_id: params[:id])
  end

end
