require 'rails_helper'

RSpec.feature "ReferenceBookUpdates", type: :feature do

  before do
    @michael = FactoryBot.create(:user, name: "michael")
    @publisher = FactoryBot.create(:publisher, user_id: @michael.id)
    @reference_book = FactoryBot.create(:reference_book, user_id: @michael.id, publisher_id: @publisher.id)
  end

  let(:other_user) { FactoryBot.create(:user) }

  feature "update reference_book" do
    scenario "edit_btn not found with no login_user" do
      visit root_path

      click_link "参考書一覧"
      expect(page).to have_link @reference_book.title, href: reference_book_path(@reference_book)
      expect(page).to_not have_link "編集", href: edit_reference_book_path(@reference_book)
    end

    scenario "edit_btn not found with other_user" do
      login(@michael)
      visit root_path

      click_link "参考書一覧"
      expect(page).to have_link @reference_book.title, href: reference_book_path(@reference_book)
      expect(page).to have_link "編集", href: edit_reference_book_path(@reference_book)

      logout
      login(other_user)

      click_link "参考書一覧"
      expect(page).to have_link @reference_book.title, href: reference_book_path(@reference_book)
      expect(page).to_not have_link "編集", href: edit_reference_book_path(@reference_book)
    end

    scenario "update reference_book is success" do
      login(@michael)
      visit root_path
      click_link "参考書一覧"
      click_link "編集"

      expect {
        fill_in "reference_book[title]", with: "参考書(更新)"
        click_button "参考書情報を更新"
      }.to change { current_path }.to(reference_books_path)

      expect(page).to have_text("『参考書情報を更新しました！』")
      expect(page).to have_link "参考書(更新)", href: reference_book_path(@reference_book)
    end

    scenario "update reference_book is failed" do
      login(@michael)
      visit root_path
      click_link "参考書一覧"
      click_link "編集"

      fill_in "reference_book[title]", with: ""
      click_button "参考書情報を更新"

      expect(page).to have_text("『参考書情報の編集に失敗しました...』")
      expect(page).to have_css('div#validation_messages')
    end
  end

end