class UsersController < ApplicationController
  before_action :set_user,       only: [:show, :following, :followers]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  include UsersHelper

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image.attach(params[:user][:image])
    if @user.save
      redirect_to users_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def following
    @user  = User.find(params[:id])
    @title = "#{@user.name}のフォロー"
    @users = @user.following
    render 'show_follow', status: :unprocessable_entity
  end

  def followers
    @user  = User.find(params[:id])
    @title = "#{@user.name}のフォロワー"
    @users = @user.followers
    render 'show_follow', status: :unprocessable_entity
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :subject_id, :club_id, :kinds_of_school_id, :image)
    end

    # beforeフィルタ

    # idからユーザーを取得
    def set_user
      @user  = User.find(params[:id])
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

end