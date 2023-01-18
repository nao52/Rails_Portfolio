class UsersController < ApplicationController

  include UsersHelper

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @subjects = make_array(Subject.all)
    @clubs    = make_array(Club.all)
    @kinds_of_schools = make_array(KindsOfSchool.all)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
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
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :profile)
    end

end
