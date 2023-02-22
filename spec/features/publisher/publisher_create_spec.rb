require 'rails_helper'

RSpec.feature "PublisherCreates", type: :feature do

  let(:michael)    { FactoryBot.create(:user, name: "michael") }

  feature "creating new publisher" do
    scenario "redirected login page" do
      visit root_path
      click_link "出版社一覧"

      expect {
        click_link "出版社の新規登録"
      }.to change { current_path }.to login_path

      expect(page).to have_text("『ログインしてください』")
    end

    scenario "creating publisher is success" do
      login(michael)

      visit root_path
      click_link "出版社一覧"
      click_link "出版社の新規登録"

      expect {
        fill_in "publisher[name]", with: "新規テスト出版社"
        click_button "出版社を追加"
      }.to change { Publisher.count }.by(1) && change { current_path }.to(publishers_path)

      new_publisher = Publisher.last

      expect(page).to have_text("『新しい出版社を登録しました！』")
      expect(page).to have_link "新規テスト出版社", href: publisher_path(new_publisher)
    end

    scenario "creating publisher is failed" do
      login(michael)

      visit root_path
      click_link "出版社一覧"
      click_link "出版社の新規登録"

      expect {
        fill_in "publisher[name]", with: ""
        click_button "出版社を追加"
      }.to_not change { Publisher.count }

      expect(page).to have_text("『出版社の登録に失敗しました...』")
      expect(page).to have_css('div#validation_messages')
    end
  end

end