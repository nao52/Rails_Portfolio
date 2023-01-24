class PrivateGroupsController < ApplicationController
  before_action :logged_in_user,      only: [:new, :create]
  before_action :set_private_group,   only: [:show, :members]

  def index
    @private_groups = PrivateGroup.all
  end

  def show
    # @post  = current_user.subject_posts.build if logged_in?
    # @posts = SubjectPost.where(subject_id: params[:id])
  end

  def new
    @private_group = current_user.private_groups.build
  end

  def create
    @private_group = current_user.private_groups.build(private_group_params)
    if @private_group.save
      redirect_to private_groups_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def members
    @users = @group.users
  end

  private

    def set_private_group
      @group = PrivateGroup.find(params[:id])
    end

    def  private_group_params
      params.require(:private_group).permit(:name, :detail)
    end
end
