class ReferenceBooksController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  
  def index
    @reference_books = ReferenceBook.all
  end

  def new
    @reference_book = current_user.reference_books.build(publisher_id: params[:publisher_id])
  end

  def create
    if params[:name].present? && params[:reference_book][:publisher_id].blank?
      new_publisher = current_user.publishers.create!(name: params[:name])
      params[:reference_book][:publisher_id] = new_publisher.id
    end
    
    @reference_book = current_user.reference_books.build(reference_book_params)

    if @reference_book.save
      @publisher = Publisher.find(@reference_book.publisher_id)
      redirect_to @publisher
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
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

end
