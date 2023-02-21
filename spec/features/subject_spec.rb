require 'rails_helper'

RSpec.feature "Subjects", type: :feature do

  let(:michael)    { FactoryBot.create(:user, name: "michael") }
  let(:other_user) { FactoryBot.create(:user) }
  let(:japanese)   { Subject.first }

  scenario "show subjects_index" do
    visit root_path

    click_link "教科一覧"

    Subject.all.each do |subject|
      expect(page).to have_link subject.name, href: subject_path(subject)
    end
  end

  scenario "layout of subjects_show" do
    10.times do
      user = FactoryBot.create(:user, subject_id: Subject.second.id)
    end
    50.times do
      user = FactoryBot.create(:user, subject_id: japanese.id)
      user.subject_posts.create!(content: "テスト投稿", subject_id: japanese.id)
    end

    visit root_path

    click_link "教科一覧"
    click_link japanese.name

    expect(page).to have_selector('ul.pagination')
    japanese.subject_posts.page(1).per(30).each do |post|
      expect(page).to have_content(post.user.name)
      expect(page).to have_content(post.content)
    end

    click_link "メンバー"

    expect(page).to have_selector('ul.pagination')
    japanese.users.page(1).per(30).each do |member|
      expect(page).to have_link member.name, href: user_path(member)
    end
  end

  feature "subject_posts" do
    scenario "form not found with no login_user" do
      visit root_path

      click_link "教科一覧"
      click_link japanese.name

      expect(page).to_not have_css('form.post_form')

      login(michael)

      click_link "教科一覧"
      click_link japanese.name

      expect(page).to have_css('form.post_form')
    end

    scenario "create new posts and delete posts" do 
      login(michael)
      visit root_path

      click_link "教科一覧"
      click_link japanese.name

      expect {
        fill_in "subject_post[content]", with: "1番目の投稿です！"
        click_button "投稿"
        fill_in "subject_post[content]", with: "2番目の投稿です！"
        click_button "投稿"
        fill_in "subject_post[content]", with: "最新の投稿です！"
        click_button "投稿"
      }.to change { japanese.subject_posts.count }.by(3)

      expect(page).to have_content("新規投稿を行いました！")
      expect(page).to have_content("1番目の投稿です！")
      expect(page).to have_content("2番目の投稿です！")
      expect(page).to have_content("最新の投稿です！")

      expect {
        first("#delete_btn#{japanese.subject_posts.first.id}").click
      }.to change {japanese.subject_posts.count}.by(-1)

      expect(page).to have_text("投稿(最新の投稿です！)を削除しました")
      expect(page).to have_content("1番目の投稿です！")
      expect(page).to have_content("2番目の投稿です！")

      logout

      login(other_user)
      visit subject_path(japanese)

      expect(page).to_not have_content("投稿の削除")
    end

    scenario "creating post is failed" do
      login(michael)
      visit root_path

      click_link "教科一覧"
      click_link japanese.name

      expect {
        fill_in "subject_post[content]",    with: ""
        click_button "投稿"
      }.to_not change { japanese.subject_posts.count }

      expect(page).to have_text("新規投稿に失敗しました...")
      expect(page).to have_css('div#validation_messages')
    end
  end

end