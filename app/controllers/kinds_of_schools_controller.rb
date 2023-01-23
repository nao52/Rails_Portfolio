class KindsOfSchoolsController < ApplicationController
  before_action :set_kinds_of_school,   only: [:show, :members]

  def index
    @kinds_of_schools = KindsOfSchool.all
  end

  def show
    @post = current_user.kinds_of_school_posts.build if logged_in?
    @posts = KindsOfSchoolPost.where(kinds_of_school_id: params[:id])
  end

  def members
    @users = @group.users
  end

  private

    def set_kinds_of_school
      @group = KindsOfSchool.find(params[:id])
    end

end