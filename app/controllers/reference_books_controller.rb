class ReferenceBooksController < ApplicationController
  before_action :logged_in_user,   only: [:new, :create, :edit, :update]
  before_action :correct_user,     only: [:edit, :update, :destroy]
  before_action -> {
    create_publisher(params[:name], params[:reference_book][:publisher_id])
  }, only: [:create, :update]
  
  def index
    @reference_books = ReferenceBook.all
  end

  def new
    @reference_book = current_user.reference_books.build(publisher_id: params[:publisher_id])
  end

  def create    
    @reference_book = current_user.reference_books.build(reference_book_params)
    if @reference_book.save
      redirect_to @reference_book.publisher
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @reference_book.update(reference_book_params)
      redirect_to @reference_book.publisher
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

    def reference_book_params
      params.require(:reference_book).permit(:title, :content, :publisher_id)
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
