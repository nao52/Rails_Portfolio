class ReferenceBooksController < ApplicationController
  
  def index
    @reference_books = ReferenceBook.all
  end

  def new
    @reference_book = current_user.reference_books.build(publisher_id: params[:publisher_id])
  end

  def edit
  end
end
