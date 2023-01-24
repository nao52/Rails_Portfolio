class PrivateGroupsController < ApplicationController
  before_action :set_private_group,   only: [:show, :members]

  def index
    @private_groups = PrivateGroup.all
  end

  def show
    # @post  = current_user.subject_posts.build if logged_in?
    # @posts = SubjectPost.where(subject_id: params[:id])
  end

  def new
    @private_group = current_user.private_groups.build if logged_in?
  end

  def create

  end

  def members
    @users = @group.users
  end

  private

    def set_private_group
      @group = PrivateGroup.find(params[:id])
    end
end
