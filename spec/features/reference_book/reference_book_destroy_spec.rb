require 'rails_helper'

RSpec.feature "ReferenceBookDestroys", type: :feature do

  before do
    @michael = FactoryBot.create(:user, name: "michael")
    @publisher = FactoryBot.create(:publisher, user_id: @michael.id)
    @reference_book = FactoryBot.create(:reference_book, user_id: @michael.id, publisher_id: @publisher.id)
  end

  let(:other_user) { FactoryBot.create(:user) }

  feature "destroy reference_book" do
    scenario "delete_btn not found with no login_user" do
      visit root_path

      click_link "参考書一覧"
      expect(page).to have_link @reference_book.title, href: reference_book_path(@reference_book)
      expect(page).to_not have_link "削除", href: reference_book_path(@reference_book)
    end

    scenario "delete_btn not found with other_user" do
      login(@michael)
      visit root_path

      click_link "参考書一覧"
      expect(page).to have_link @reference_book.title, href: reference_book_path(@reference_book)
      expect(page).to have_link "削除", href: reference_book_path(@reference_book)

      logout
      login(other_user)

      click_link "参考書一覧"
      expect(page).to have_link @reference_book.title, href: reference_book_path(@reference_book)
      expect(page).to_not have_link "削除", href: reference_book_path(@reference_book)
    end

    scenario "destroy reference_book is success" do
      login(@michael)
      visit root_path
      click_link "参考書一覧"
      
      expect {
        click_link "削除"
      }.to change { ReferenceBook.count }.by(-1)

      expect(page).to have_text("『参考書(#{@reference_book.title})を削除しました』")
      expect(page).to_not have_link @reference_book.title, href: reference_book_path(@reference_book)
    end
  end

end