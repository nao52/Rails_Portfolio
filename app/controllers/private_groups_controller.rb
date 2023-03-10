class PrivateGroupsController < ApplicationController
  before_action :set_private_group,   only: [:show, :members]
  before_action :logged_in_user,      only: [:new, :create, :update, :edit, :destroy]
  before_action :correct_user,        only: [:edit, :update, :destroy]

  def index
    @private_groups = PrivateGroup.all.page(params[:page]).per(30)
  end

  def show
    @post  = current_user.private_group_posts.build if logged_in?
    @posts = PrivateGroupPost.where(private_group_id: params[:id]).page(params[:page]).per(30)
  end

  def new
    @private_group = current_user.private_groups.build
  end

  def create
    @private_group = current_user.private_groups.build(private_group_params)
    if @private_group.save
      flash[:success] = "新規グループの作成を行いました！"
      current_user.join(@private_group)
      redirect_to private_groups_url
    else
      flash.now[:danger] = "新規グループの作成に失敗しました..."
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @private_group.update(private_group_params)
      flash[:success] = "グループ情報を更新しました！"
      redirect_to private_groups_url
    else
      flash.now[:danger] = "グループ情報の編集に失敗しました..."
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    group_name = @private_group.name
    @private_group.destroy
    flash[:success] = "グループ(#{group_name})を削除しました"
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  def members
    @users = @group.members.page(params[:page]).per(30)
  end

  private

    def set_private_group
      @group = PrivateGroup.find(params[:id])
    end

    def private_group_params
      params.require(:private_group).permit(:name, :detail)
    end

    def correct_user
      @private_group = current_user.private_groups.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @private_group.nil?
    end
end
