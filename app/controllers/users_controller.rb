class UsersController < ApplicationController
  before_action :set_user,       only: [:show, :following, :followers, :joinings, :worksheets, :favorite_books, :favorite_worksheets]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

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
      @user.image.purge if params[:delete_image]
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def following
    @title = "#{@user.name}のフォロー"
    @users = @user.following
    render 'show_follow', status: :unprocessable_entity
  end

  def followers
    @title = "#{@user.name}のフォロワー"
    @users = @user.followers
    render 'show_follow', status: :unprocessable_entity
  end

  def joinings
    @groups = @user.joining
  end

  def worksheets
    @worksheets = @user.worksheets
  end

  def favorite_books
    @reference_books = @user.favorite_books
  end

  def favorite_worksheets
    @worksheets = @user.favorite_worksheets
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