require 'rails_helper'

RSpec.describe ReferenceBook, type: :model do

  before do
    @subject         = FactoryBot.create(:subject)
    @club            = FactoryBot.create(:club)
    @kinds_of_school = FactoryBot.create(:kinds_of_school)
    @user            = FactoryBot.create(:user, subject_id: @subject.id,
                                                club_id:  @club.id,
                                                kinds_of_school_id: @kinds_of_school.id)
    @publisher       = FactoryBot.create(:publisher, user_id: @user.id)
  end

  let(:book) { FactoryBot.build(:reference_book, user_id: @user.id, publisher_id: @publisher.id) }

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

  it "is first for the most likes count" do
    3.times do
      FactoryBot.create(:reference_book, user_id: @user.id, publisher_id: @publisher.id, likes_count: 3)
    end
    most_likes_count = FactoryBot.create(:reference_book, user_id: @user.id, publisher_id: @publisher.id, likes_count: 10)
    expect(most_likes_count).to eq(ReferenceBook.first)
  end

end
