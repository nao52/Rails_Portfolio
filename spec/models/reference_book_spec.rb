require 'rails_helper'

RSpec.describe ReferenceBook, type: :model do

  before do
    FactoryBot.create(:subject)
    FactoryBot.create(:club)
    FactoryBot.create(:kinds_of_school)
    FactoryBot.create(:user)
    FactoryBot.create(:publisher)
  end

  let(:book) { FactoryBot.build(:reference_book) }

  it "is valid with title, user_id, publisher_id, likes_count" do
    expect(book).to be_valid
  end

  it "is invalid without title" do
    book.title = ""
    expect(book).to_not be_valid
  end

  it "is invalid without user_id" do
    book.user_id = nil
    expect(book).to_not be_valid
  end

  it "is invalid without likes_count" do
    book.likes_count = nil
    expect(book).to_not be_valid
  end

  it "is valid when title is less than 50 characters" do
    book.title = "a" * 50
    expect(book).to be_valid
  end

  it "is invalid when title is more 51 characters" do
    book.title = "a" * 51
    expect(book).to_not be_valid
  end

  it "is valid when content is less than 140 characters" do
    book.content = "a" * 140
    expect(book).to be_valid
  end

  it "is invalid when content is more 141 characters" do
    book.content = "a" * 141
    expect(book).to_not be_valid
  end

end
