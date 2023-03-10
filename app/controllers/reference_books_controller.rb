class ReferenceBooksController < ApplicationController
  before_action :logged_in_user,   only: [:new, :create, :edit, :update]
  before_action :correct_user,     only: [:edit, :update, :destroy]
  before_action -> {
    create_publisher(params[:name], params[:reference_book][:publisher_id])
  }, only: [:create, :update]
  
  def index
    @reference_books = ReferenceBook.all.page(params[:page]).per(30)
  end

  def show
    @reference_book = ReferenceBook.find(params[:id])
    @book_review  = current_user.book_reviews.build if logged_in?
    @book_reviews = @reference_book.book_reviews.page(params[:page]).per(30)
  end

  def new
    @reference_book = current_user.reference_books.build(publisher_id: params[:publisher_id])
  end

  def create
    @reference_book = current_user.reference_books.build(reference_book_params)
    @reference_book.image.attach(params[:reference_book][:image])
    if @reference_book.save
      flash[:success] = "新規参考書を登録しました！"
      redirect_to reference_books_url
    else
      flash.now[:danger] = "出版社の登録に失敗しました..."
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @reference_book.update(reference_book_params)
      @reference_book.image.purge if params[:delete_image]
      flash[:success] = "参考書情報を更新しました！"
      redirect_to reference_books_url
    else
      flash.now[:danger] = "参考書情報の編集に失敗しました..."
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    title = @reference_book.title
    @reference_book.destroy
    flash[:success] = "参考書(#{title})を削除しました"
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  def search
    @title  = params[:title]

    if @title.empty?
      @reference_books = ReferenceBook.all.page(params[:page]).per(30)
      flash.now[:danger] = "書籍名を入力してください"
      return render 'index'
    end

    reference_books = ReferenceBook.where("title LIKE ?", "%#{@title}%")

    if reference_books.size == 0
      @reference_books = ReferenceBook.all.page(params[:page]).per(30)
      flash.now[:danger] = "該当する書籍が見つからなかったので、全ての書籍を表示します。"
    else
      @messages = "#{reference_books.size}件の書籍が見つかりました！"
      @reference_books = reference_books.page(params[:page]).per(30)
    end

    render 'index'
  end

  private

    def reference_book_params
      params.require(:reference_book).permit(:title, :content, :publisher_id, :image)
    end

    # before フィルタ
    
    # 現在のユーザーが作成者であるか確認
    def correct_user
      @reference_book = current_user.reference_books.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @reference_book.nil?
    end

    def create_publisher(publisher_name, publisher_id)
      if publisher_id.blank? && publisher_name.present?
        new_publisher = current_user.publishers.create!(name: params[:name])
        params[:reference_book][:publisher_id] = new_publisher.id
      end
    end

end
