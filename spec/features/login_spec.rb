require 'rails_helper'

RSpec.feature "Logins", type: :feature do

  let(:user) { FactoryBot.create(:user) }

  scenario "login with valid information and logout" do
    visit root_path

    expect {

      click_link "ログイン"
  
      fill_in "session[email]",    with: user.email
      fill_in "session[password]", with: "password"
      click_button "ログイン"

    }.to change { current_path }.to user_path(user)

    expect(page).to have_text("ログインに成功しました！")
    expect(page).to have_content("michaelでログイン中")

    expect {

      click_link "ログアウト"

    }.to change { current_path }.to login_path

    expect(page).to have_text("ログアウトしました")
    expect(page).to_not have_content("michaelでログイン中")
  end

  scenario "login with invalid information" do
    visit root_path

    click_link "ログイン"

    fill_in "session[email]",    with: "invalid@example.com"
    fill_in "session[password]", with: "invalid"
    click_button "ログイン"

    expect(page).to have_text("ログインに失敗しました...")

    visit root_path

    expect(page).to_not have_text("ログインに失敗しました...")
  end

end
