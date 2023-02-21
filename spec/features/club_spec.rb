require 'rails_helper'

RSpec.feature "Clubs", type: :feature do

  let(:michael)    { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:baseball)   { Club.first }

  scenario "show clubs_index" do
    visit root_path

    click_link "部活動一覧"

    Club.all.each do |club|
      expect(page).to have_link club.name, href: club_path(club)
    end
  end

  scenario "layout of clubs_show" do

    50.times do
      user = FactoryBot.create(:user, club_id: baseball.id)
      user.club_posts.create!(content: "テスト投稿", club_id: baseball.id)
    end

    visit root_path

    click_link "部活動一覧"
    click_link baseball.name

    expect(page).to have_selector('ul.pagination')
    baseball.club_posts.page(1).per(30).each do |post|
      expect(page).to have_content(post.user.name)
      expect(page).to have_content(post.content)
    end

    click_link "ユーザー"

    baseball.users.page(1).per(30).each do |member|
      expect(page).to have_link member.name, href: user_path(member)
    end
  end

  feature "club_posts" do
    scenario "form not found with no login_user" do
      visit root_path

      click_link "部活動一覧"
      click_link baseball.name

      expect(page).to_not have_css('form.post_form')

      login(michael)

      click_link "部活動一覧"
      click_link baseball.name

      expect(page).to have_css('form.post_form')
    end

    scenario "create new posts and delete posts" do
      login(michael)
      visit root_path

      click_link "部活動一覧"
      click_link baseball.name

      expect {
        fill_in "club_post[content]", with: "1番目の投稿です！"
        click_button "投稿"
        fill_in "club_post[content]", with: "2番目の投稿です！"
        click_button "投稿"
        fill_in "club_post[content]", with: "最新の投稿です！"
        click_button "投稿"
      }.to change { baseball.club_posts.count }.by(3)

      expect(page).to have_content("新規投稿を行いました！")
      expect(page).to have_content("1番目の投稿です！")
      expect(page).to have_content("2番目の投稿です！")
      expect(page).to have_content("最新の投稿です！")

      expect {
        first("#delete_btn#{baseball.club_posts.first.id}").click
      }.to change { baseball.club_posts.count }.by(-1)

      expect(page).to have_text("投稿(最新の投稿です！)を削除しました")
      expect(page).to have_content("1番目の投稿です！")
      expect(page).to have_content("2番目の投稿です！")

      logout

      login(other_user)
      visit club_path(baseball)

      expect(page).to_not have_content("投稿の削除")
    end

    scenario "creating post is failed" do
      login(michael)
      visit root_path

      click_link "部活動一覧"
      click_link baseball.name

      expect {
        fill_in "club_post[content]", with: ""
        click_button "投稿"
      }.to_not change { baseball.club_posts.count }

      expect(page).to have_text("新規投稿に失敗しました")
      expect(page).to have_css('div#validation_messages')
    end
  end

end