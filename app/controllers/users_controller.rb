class UsersController < ApplicationController
  before_action :set_user,       only: [:show, :following, :followers, :joinings, :worksheets, :favorite_books, :favorite_worksheets]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all.page(params[:page]).per(30)
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
      reset_session
      log_in @user
      flash[:success] = "ユーザーの新規登録を行いました！"
      redirect_to users_url
    else
      flash.now[:danger] = "ユーザー登録に失敗しました..."
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      @user.image.purge if params[:delete_image]
      flash[:success] = "ユーザーの編集に成功しました！"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザーの編集に失敗しました..."
      render 'edit', status: :unprocessable_entity
    end
  end

  def following
    @title = "#{@user.name}のフォロー"
    @users = @user.following.page(params[:page]).per(30)
    render 'show_follow', status: :unprocessable_entity
  end

  def followers
    @title = "#{@user.name}のフォロワー"
    @users = @user.followers.page(params[:page]).per(30)
    render 'show_follow', status: :unprocessable_entity
  end

  def joinings
    @groups = @user.joining
  end

  def worksheets
    @worksheets = @user.worksheets
  end

  def favorite_books
    @reference_books = @user.favorite_books.page(params[:page]).per(30)
  end

  def favorite_worksheets
    @worksheets = @user.favorite_worksheets
  end

  def search

    case params[:condition]

    when "name"
      @name  = params[:name]

      if @name.empty?
        @users = User.all.page(params[:page]).per(30)
        flash.now[:danger] = "ユーザー名を入力してください"
        return render 'index', status: :unprocessable_entity
      end

      @users = User.where("name LIKE ?", "%#{@name}%").page(params[:page]).per(30)

    when "subject"
      @subject = params[:subject]
      @users = User.where("subject_id LIKE ?", "%#{@subject}%").page(params[:page]).per(30)
      @checked_subject = true

    when "club"
      @club = params[:club]
      @users = User.where("club_id LIKE ?", "%#{@club}%").page(params[:page]).per(30)
      @checked_club = true
    end

    if @users.size == 0
      flash.now[:danger] = "該当するユーザーが見つからなかったので、全てのユーザーを表示します。"
      @users = User.all.page(params[:page]).per(30)
    else
      @messages = "#{@users.size}件のユーザーが見つかりました！"
    end

    render 'index', status: :unprocessable_entity
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