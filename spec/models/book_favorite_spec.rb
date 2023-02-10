require 'rails_helper'

RSpec.describe BookFavorite, type: :model do

  before do
    FactoryBot.create(:subject)
    FactoryBot.create(:club)
    FactoryBot.create(:kinds_of_school)
    @user = FactoryBot.create(:user)
    FactoryBot.create(:publisher)
    @book = FactoryBot.create(:reference_book)
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
