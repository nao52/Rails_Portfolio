class ReferenceBooksController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  
  def index
    @reference_books = ReferenceBook.all
  end

  def new
    @reference_book = current_user.reference_books.build(publisher_id: params[:publisher_id])
  end

  def create
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

  private

    def reference_book_params
      params.require(:reference_book).permit(:title, :content, :publisher_id)
    end
end
