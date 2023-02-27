require 'rails_helper'

RSpec.feature "ReferenceBookFavorites", type: :feature do

  before do
    @user = FactoryBot.create(:user)
    @publisher = FactoryBot.create(:publisher, user_id: @user.id)
    @reference_book = FactoryBot.create(:reference_book, user_id: @user.id, publisher_id: @publisher.id)
  end

  let(:michael) { FactoryBot.create(:user, name: "michael") }

  feature "favorite reference_book" do
    scenario "favorite_btn not found with no login_user" do
      visit root_path

      click_link "参考書一覧"
      expect(page).to have_link @reference_book.title, href: reference_book_path(@reference_book)
      expect(page).to_not have_css("div#favorite_form_#{@reference_book.id}")

      login(michael)

      visit root_path
      click_link "参考書一覧"
      expect(page).to have_link @reference_book.title, href: reference_book_path(@reference_book)
      expect(page).to have_css("div#favorite_form_#{@reference_book.id}")
    end

    scenario "favorite reference_book and unfavorite reference_book" do
      login(michael)
      visit root_path

      click_link "参考書一覧"
      expect {
        click_button "お気に入り(0)"
      }.to change { michael.favorite_books.count }.by(1)

      click_link "マイページ"
      expect(page).to have_link "お気に入り書籍(1)", href: favorite_books_user_path(michael)

      click_link "参考書一覧"
      expect {
        click_button "お気に入り解除(1)"
      }.to change { michael.favorite_books.count }.by(-1)

      click_link "マイページ"
      expect(page).to have_link "お気に入り書籍(0)", href: favorite_books_user_path(michael)
    end

    scenario "show favorite_books with pagination" do
      login(michael)

      50.times do
        reference_book = FactoryBot.create(:reference_book, user_id: @user.id, publisher_id: @publisher.id)
        michael.favorite_book(reference_book)
      end

      visit root_path

      click_link "マイページ"
      click_link "お気に入り書籍(#{michael.favorite_books.count})"

      expect(page).to have_selector('ul.pagination')
      michael.favorite_books.page(1).per(30).each do |reference_book|
        expect(page).to have_link reference_book.title, href: reference_book_path(reference_book)
      end
    end
  end

end