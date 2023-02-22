class PublishersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @publishers = Publisher.all.page(params[:page]).per(30)
  end

  def show
    @publisher = Publisher.find(params[:id])
    @reference_books = @publisher.reference_books.page(params[:page]).per(30)
  end

  def new
    @publisher = current_user.publishers.build
  end

  def create
    @publisher = current_user.publishers.build(publisher_params)
    if @publisher.save
      flash[:success] = "新しい出版社を登録しました！！"
      redirect_to publishers_url
    else
      flash.now[:danger] = "出版社の登録に失敗しました..."
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @publisher.update(publisher_params)
      flash[:success] = "出版社情報の編集に成功しました！！"
      redirect_to @publisher
    else
      flash.now[:danger] = "出版社情報の編集に失敗しました..."
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    if @publisher.reference_books.present?
      flash[:danger] = "こちらの出版社は削除できません"
      return redirect_to publishers_url, status: :see_other
    end
    @publisher.destroy
    flash[:success] = "出版社を削除しました"
    redirect_to publishers_url, status: :see_other
  end

  def search
    @name  = params[:name]

    if @name.empty?
      @publishers = Publisher.all.page(params[:page]).per(30)
      flash.now[:danger] = "出版社名を入力してください"
      return render 'index', status: :unprocessable_entity
    end

    publishers = Publisher.where("name LIKE ?", "%#{@name}%").page(params[:page]).per(30)

    if publishers.size == 0
      @publishers = Publisher.all.page(params[:page]).per(30)
      flash.now[:danger] = "該当する出版社が見つからなかったので、全ての出版社を表示します。"
    else
      @messages = "#{publishers.size}件の出版社が見つかりました！"
      @publishers = publishers.page(params[:page]).per(30)
    end

    render 'index', status: :unprocessable_entity
  end

  private

    def publisher_params
      params.require(:publisher).permit(:name)
    end

    # before フィルタ
    
    # 現在のユーザーが作成者であるか確認
    def correct_user
      @publisher = current_user.publishers.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @publisher.nil?
    end

end