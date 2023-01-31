class BookReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @book_review = current_user.book_reviews.build(book_review_params)
    if @book_review.save
      redirect_back(fallback_location: root_url)
    else
      @reference_book = ReferenceBook.find(params[:id])
      @book_reviews = @reference_book.book_reviews.page(params[:page]).per(30)
      render 'reference_books/show', status: :unprocessable_entity
    end
  end

  private

    def book_review_params
      params.require(:book_review).permit(:content, :reference_book_id)
    end

end
