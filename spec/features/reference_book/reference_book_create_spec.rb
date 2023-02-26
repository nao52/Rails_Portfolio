require 'rails_helper'

RSpec.feature "ReferenceBookCreates", type: :feature do

  before do
    @user = FactoryBot.create(:user)
    5.times do
      FactoryBot.create(:publisher, user_id: @user.id)
    end
    @publisher = Publisher.first
  end

  let(:michael) { FactoryBot.create(:user, name: "michael") }

  feature "creating new reference_book" do
    scenario "redirected login page" do
      visit root_path

      click_link "参考書一覧"

      expect {
        click_link "参考書の新規登録"
      }.to change { current_path }.to login_path

      expect(page).to have_text("『ログインしてください』")
    end

    scenario "creating reference_book is success" do
      login(michael)

      visit root_path
      click_link "参考書一覧"
      click_link "参考書の新規登録"

      expect {
        fill_in "reference_book[title]",   with: "新規書籍(1)"
        fill_in "reference_book[content]", with: "テスト用の書籍"
        select  @publisher.name, from: "出版社"
        click_button "参考書を追加"
      }.to change { ReferenceBook.count }.by(1) && change { current_path }.to(reference_books_path)

      expect(page).to have_text("『新規参考書を登録しました！』")
    end

    scenario "creating reference_book is failed" do
      login(michael)

      visit root_path
      click_link "参考書一覧"
      click_link "参考書の新規登録"

      expect {
        fill_in "reference_book[title]",   with: ""
        click_button "参考書を追加"
      }.to_not change { ReferenceBook.count }

      expect(page).to have_text("『出版社の登録に失敗しました...』")
      expect(page).to have_css('div#validation_messages')
    end
  end

end