require 'rails_helper'

RSpec.describe BookFavorite, type: :model do

  before do
    @user       = FactoryBot.create(:user)
    @publisher  = FactoryBot.create(:publisher, user_id: @user.id)
    @book       = FactoryBot.create(:reference_book, user_id: @user.id, publisher_id: @publisher.id)
  end

  let(:book_favorite) { @user.book_favorites.build(reference_book_id: @book.id) }

  it "is valid with user_id, reference_book_id" do
    expect(book_favorite).to be_valid
  end

  it "is invalid without user_id" do
    book_favorite.user_id = nil
    expect(book_favorite).to_not be_valid
  end

  it "is invalid without reference_book_id" do
    book_favorite.reference_book_id = nil
    expect(book_favorite).to_not be_valid
  end

end
