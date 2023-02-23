class BookReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]

  def create
    @book_review = current_user.book_reviews.build(book_review_params)
    if @book_review.save
      flash[:success] = "レビューを投稿しました！"
      redirect_back(fallback_location: root_url)
    else
      @reference_book = ReferenceBook.find(book_review_params[:reference_book_id])
      @book_reviews = @reference_book.book_reviews.page(params[:page]).per(30)
      flash.now[:danger] = "レビューの投稿に失敗しました..."
      render 'reference_books/show', status: :unprocessable_entity
    end
  end

  def destroy
    content = @book_review.content
    @book_review.destroy
    flash[:danger] = "レビュー(#{content})を削除しました"
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  private

    def book_review_params
      params.require(:book_review).permit(:content, :reference_book_id)
    end

    # before フィルタ

    # 現在のユーザーが作成者であるか確認
    def correct_user
      @book_review = current_user.book_reviews.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @book_review.nil?
    end

end
