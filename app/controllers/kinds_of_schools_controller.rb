class KindsOfSchoolsController < ApplicationController

  def index
    @kinds_of_schools = KindsOfSchool.all
  end

  def show
    @kinds_of_school = KindsOfSchool.find(params[:id])
    @posts = KindsOfSchoolPosts.where(kinds_of_school_id: params[:id])
  end

end
