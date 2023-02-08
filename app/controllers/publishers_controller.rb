class PublishersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
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
      redirect_to publishers_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @publisher.update(publisher_params)
      redirect_to @publisher
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    unless @publisher.reference_books.empty?
      # エラーメッセージ
      redirect_back(fallback_location: root_url)
    end
    @publisher.destroy
    redirect_to publishers_url, status: :see_other
  end

  def search
    @name  = params[:name]

    if @name.empty?
      @publishers = Publisher.all.page(params[:page]).per(30)
      @error_messages = "出版社名を入力してください"
      return render 'index'
    end

    @publishers = Publisher.where("name LIKE ?", "%#{@name}%").page(params[:page]).per(30)

    if @publishers.size == 0
      @publishers = Publisher.all.page(params[:page]).per(30)
      @error_messages = "該当する出版社が見つからなかったので、全ての出版社を表示します。"
    else
      @messages = "#{@publishers.size}件の出版社が見つかりました！"
    end

    render 'index'
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