require 'rails_helper'

RSpec.feature "ReferenceBookIndices", type: :feature do

  before do
    @user      = FactoryBot.create(:user)
    @publisher = FactoryBot.create(:publisher, user_id: @user.id)
    50.times do
      FactoryBot.create(:reference_book, user_id: @user.id, publisher_id: @publisher.id)
    end
  end

  feature "layout of reference_books_index" do
    scenario "show reference_books with pagination" do
      visit root_path
      click_link "参考書一覧"

      expect(page).to have_selector('ul.pagination')
      ReferenceBook.all.page(1).per(30).each do |reference_book|
        expect(page).to have_link "書籍名:【 #{reference_book.title} 】", href: reference_book_path(reference_book)
      end
    end
  end

  feature "search reference_books" do
    scenario "reference_books found" do
      search_title = "書籍"

      visit root_path
      click_link "参考書一覧"

      fill_in "title", with: search_title
      click_button "検索"

      reference_books = ReferenceBook.where("title LIKE ?", "%#{search_title}%")

      expect(page).to have_text("『#{reference_books.size}件の書籍が見つかりました！』")
      reference_books.page(1).per(30).each do |reference_book|
        expect(page).to have_link "書籍名:【 #{reference_book.title} 】", href: reference_book_path(reference_book)
      end
    end

    
  end
  
end
