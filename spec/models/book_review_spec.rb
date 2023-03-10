require 'rails_helper'

RSpec.describe BookReview, type: :model do

  before do
    @user            = FactoryBot.create(:user)
    @publisher       = FactoryBot.create(:publisher, user_id: @user.id)
    @reference_book  = FactoryBot.create(:reference_book, user_id: @user.id, publisher_id: @publisher.id)
  end

  let(:review) { FactoryBot.build(:book_review, user_id: @user.id, reference_book_id: @reference_book.id) }

  it "is valid with content, user_id, reference_book_id" do
    expect(review).to be_valid
  end

  it "is invalid without content" do
    review.content = ""
    expect(review).to_not be_valid
    expect(review.errors.full_messages).to include("レビュー内容は必須項目です")
  end

  it "is invalid without user_id" do
    review.user_id = nil
    expect(review).to_not be_valid
  end

  it "is invalid without reference_book_id" do
    review.reference_book_id = nil
    expect(review).to_not be_valid
  end

  it "is valid when content is less than 140 characters" do
    review.content = "a" * 140
    expect(review).to be_valid
  end

  it "is invalid when content is more 141 characters" do
    review.content = "a" * 141
    expect(review).to_not be_valid
    expect(review.errors.full_messages).to include("レビュー内容は140文字以内で入力してください")
  end

  it "is first for most recent" do
    5.times do
      FactoryBot.create(:book_review, user_id: @user.id, reference_book_id: @reference_book.id, created_at: 3.years.ago)
    end
    most_recent_review = FactoryBot.create(:book_review, user_id: @user.id, reference_book_id: @reference_book.id, created_at: Time.zone.now)
    expect(most_recent_review).to eq(BookReview.first)
  end

end
