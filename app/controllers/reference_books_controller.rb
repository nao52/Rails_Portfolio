class ReferenceBooksController < ApplicationController
  
  def index
    @reference_books = ReferenceBook.all
  end

  def new
  end

  def edit
  end
end
