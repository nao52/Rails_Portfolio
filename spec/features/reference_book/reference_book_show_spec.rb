require 'rails_helper'

RSpec.feature "ReferenceBookShows", type: :feature do

  before do
    @user      = FactoryBot.create(:user)
    @publisher = FactoryBot.create(:publisher, user_id: @user.id)
    @reference_book = FactoryBot.create(:reference_book, user_id: @user.id, publisher_id: @publisher.id)
  end

  feature "layout of reference_books_show" do
    scenario "show book_reviews with pagination" do
      50.times do
        FactoryBot.create(:book_review, user_id: @user.id, reference_book_id: @reference_book.id)
      end

      visit root_path
      click_link "参考書一覧"
      click_link @reference_book.title

      expect(page).to have_content("【#{@reference_book.title}】のレビュー一覧")

      expect(page).to have_selector('ul.pagination')
      @reference_book.book_reviews.page(1).per(30).each do |review|
        expect(page).to have_content("投稿者:#{review.user.name}")
        expect(page).to have_content(review.content)
      end
    end
  end

end