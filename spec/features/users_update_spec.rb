require 'rails_helper'

RSpec.feature "UsersUpdates", type: :feature do

  let(:michael)    { FactoryBot.create(:user, name: "michael") }
  let(:other_user) { FactoryBot.create(:user) }

  feature "update a user" do
    scenario "valid information" do
      login(michael)

      visit root_path
      click_link "マイページ"

      expect(page).to have_content("#{michael.name}")
      click_link "ユーザー情報の編集"
      
      expect {
        fill_in "user[name]",  with: "#{michael.name}(アップデート)"
        fill_in "user[email]", with: michael.email
        select  michael.subject.name,         from: "担当教科"
        select  michael.club.name,            from: "担当部活動"
        select  michael.kinds_of_school.name, from: "校種"
        fill_in "user[profile]", with: "プロフィール情報を更新します！"
        click_button "ユーザー情報を更新"
      }.to change { current_path }.to user_path(michael)

      expect(page).to have_text("ユーザーの編集に成功しました！")
      expect(page).to have_content("#{michael.name}(アップデート)")
      expect(page).to have_content("プロフィール情報を更新します！")
    end

    scenario "invalid information" do
      login(michael)

      visit root_path
      click_link "マイページ"
      click_link "ユーザー情報の編集"

      fill_in "user[name]",  with: "#{michael.name}(アップデート)"
      fill_in "user[email]", with: nil
      select  michael.subject.name,         from: "担当教科"
      select  michael.club.name,            from: "担当部活動"
      select  michael.kinds_of_school.name, from: "校種"
      fill_in "user[profile]", with: "プロフィール情報を更新します！"
      click_button "ユーザー情報を更新"

      expect(page).to have_text("ユーザーの編集に失敗しました...")
      expect(page).to have_css('div#validation_messages')
    end

    scenario "user is not login" do

      expect {
        visit edit_user_path(michael)
      }.to change { current_path }.to login_path
      
      expect(page).to have_text("ログインしてください")

      expect {
        login(michael)
      }.to change { current_path }.to edit_user_path(michael)
    end

    scenario "user is invalid" do
      login(other_user)
      visit root_path
      
      expect {
        visit edit_user_path(michael)
      }.to_not change { current_path }
    end
  end
end
