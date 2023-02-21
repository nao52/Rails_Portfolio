require 'rails_helper'

RSpec.feature "UsersFollows", type: :feature do

  before do
    @other_user = FactoryBot.create(:user)
  end

  let(:michael)    { FactoryBot.create(:user, name: "michael") }

  scenario "follow other_user and unfollow other_user" do

    login(michael)
    visit root_path

    click_link "ユーザー一覧"
    
    expect {
      click_link @other_user.name

      expect(page).to have_link "フォロワー(0)", href: followers_user_path(@other_user)

      click_button "フォロー"
    }.to change { michael.following.count }.by(1) && change { @other_user.followers.count }.by(1)

    expect(page).to have_link "フォロワー(1)", href: followers_user_path(@other_user)

    click_link "マイページ"
    expect(page).to have_link "フォロー(1)", href: following_user_path(michael)

    expect {
      click_link "フォロー(1)"
      click_link @other_user.name

      expect(page).to have_link "フォロワー(1)", href: followers_user_path(@other_user)

      click_button "フォロー解除"
    }.to change{ michael.following.count }.by(-1) && change { @other_user.followers.count }.by(-1)

    expect(page).to have_link "フォロワー(0)", href: followers_user_path(@other_user)

    click_link "マイページ"
    expect(page).to have_link "フォロー(0)", href: following_user_path(michael)
  end

  scenario "show following and followers with pagination" do

    login(michael)

    50.times do
      user = FactoryBot.create(:user)
      michael.follow(user)
      user.follow(michael)
    end

    visit root_path

    click_link "フォロー(#{michael.following.count})"

    expect(page).to have_selector('ul.pagination')
    michael.following.page(1).per(30).each do |user|
      expect(page).to have_link user.name, href: user_path(user)
    end

    click_link "マイページ"

    click_link "フォロワー(#{michael.followers.count})"

    expect(page).to have_selector('ul.pagination')
    michael.followers.page(1).per(30).each do |user|
      expect(page).to have_link user.name, href: user_path(user)
    end
  end

end