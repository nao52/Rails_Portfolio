require 'rails_helper'

RSpec.feature "KindsOfSchools", type: :feature do

  let(:michael)       { FactoryBot.create(:user) }
  let(:other_user)    { FactoryBot.create(:user) }
  let(:j_high_school) { KindsOfSchool.first }

  scenario "show kinds_of_shools_index" do
    visit root_path

    click_link "校種一覧"

    KindsOfSchool.all.each do |kinds_of_school|
      expect(page).to have_link kinds_of_school.name, href: kinds_of_school_path(kinds_of_school)
    end
  end

  scenario "layout of kinds_of_schools_show" do

    50.times do
      user = FactoryBot.create(:user, kinds_of_school_id: j_high_school.id)
      user.kinds_of_school_posts.create!(content: "テスト投稿", kinds_of_school_id: j_high_school.id)
    end

    visit root_path

    click_link "校種一覧"
    click_link j_high_school.name

    expect(page).to have_selector('ul.pagination')
    j_high_school.kinds_of_school_posts.page(1).per(30).each do |post|
      expect(page).to have_content(post.user.name)
      expect(page).to have_content(post.content)
    end

    click_link "ユーザー"

    j_high_school.users.page(1).per(30).each do |member|
      expect(page).to have_link member.name, href: user_path(member)
    end
  end

  feature "kinds_of_school_posts" do
    scenario "form not found with no login_user" do
      visit root_path

      click_link "校種一覧"
      click_link j_high_school.name

      expect(page).to_not have_css('form.post_form')

      login(michael)

      click_link "校種一覧"
      click_link j_high_school.name

      expect(page).to have_css('form.post_form')
    end

    scenario "create new posts and delete posts" do
      login(michael)
      visit root_path

      click_link "校種一覧"
      click_link j_high_school.name

      expect {
        fill_in "kinds_of_school_post[content]", with: "1番目の投稿です！"
        click_button "投稿"
        fill_in "kinds_of_school_post[content]", with: "2番目の投稿です！"
        click_button "投稿"
        fill_in "kinds_of_school_post[content]", with: "最新の投稿です！"
        click_button "投稿"
      }.to change { j_high_school.kinds_of_school_posts.count }.by(3)

      expect(page).to have_content("新規投稿を行いました！")
      expect(page).to have_content("1番目の投稿です！")
      expect(page).to have_content("2番目の投稿です！")
      expect(page).to have_content("最新の投稿です！")

      expect {
        first("#delete_btn#{j_high_school.kinds_of_school_posts.first.id}").click
      }.to change { j_high_school.kinds_of_school_posts.count }.by(-1)

      expect(page).to have_text("投稿(最新の投稿です！)を削除しました")
      expect(page).to have_content("1番目の投稿です！")
      expect(page).to have_content("2番目の投稿です！")

      logout

      login(other_user)
      visit kinds_of_school_path(j_high_school)

      expect(page).to_not have_content("投稿の削除")
    end

  end

end