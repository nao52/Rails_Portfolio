class BookFavoritesController < ApplicationController

  def create
    book = ReferenceBook.find(params[:reference_book_id])
    current_user.favorite_book(book)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    book = BookFavorite.find(params[:id]).reference_book
    current_user.unfavorite_book(book)
    redirect_back(fallback_location: root_url, status: :see_other)
  end

end