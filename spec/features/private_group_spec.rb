require 'rails_helper'

RSpec.feature "PrivateGroups", type: :feature do

  before do
    @user          = FactoryBot.create(:user)
    @private_group = FactoryBot.create(:private_group, user_id: @user.id)
  end

  let(:michael)    { FactoryBot.create(:user, name: "michael") }
  let(:other_user) { FactoryBot.create(:user) }

  scenario "show private_groups_index" do
    50.times do
      FactoryBot.create(:private_group, user_id: @user.id)
    end

    visit root_path

    click_link "グループ一覧"

    PrivateGroup.all.page(1).per(30).each do |private_group|
      expect(page).to have_link private_group.name, href: private_group_path(private_group)
      expect(page).to have_content(private_group.detail) if private_group.detail.present?
    end
  end

  scenario "layout of private_groups_show" do
    50.times do
      user = FactoryBot.create(:user)
      user.join(@private_group)
      user.private_group_posts.create!(content: "テスト投稿", private_group_id: @private_group.id)
    end

    visit root_path

    click_link "グループ一覧"
    click_link @private_group.name

    expect(page).to have_content(@private_group.name)
    expect(page).to have_content(@private_group.detail) if @private_group.detail.present?

    expect(page).to have_selector('ul.pagination')
    @private_group.private_group_posts.page(1).per(30).each do |post|
      expect(page).to have_content(post.user.name)
      expect(page).to have_content(post.content)
    end

    click_link "メンバー"

    expect(page).to have_selector('ul.pagination')
    @private_group.members.page(1).per(30).each do |member|
      expect(page).to have_link member.name, href: user_path(member)
    end
  end

  feature "join a private_group" do
    scenario "joining button not found with no login_user" do
      visit root_path

      click_link "グループ一覧"
      click_link @private_group.name

      expect(page).to_not have_css('div#join_form')

      login(michael)

      click_link "グループ一覧"
      click_link @private_group.name

      expect(page).to have_css('div#join_form')
    end

    scenario "join a private_group and leave a private_group" do
      login(michael)

      click_link "グループ一覧"
      click_link @private_group.name

      expect {
        click_button "グループへ参加"
      }.to change { @private_group.members.count }.by(1)

      visit user_path(michael)

      expect(page).to have_link "所属グループ(1)", href: joinings_user_path(michael)

      visit private_group_path(@private_group)

      expect {
        click_button "グループの退出"
      }.to change { @private_group.members.count }.by(-1)

      visit user_path(michael)

      expect(page).to have_link "所属グループ(0)", href: joinings_user_path(michael)
    end
  end

  feature "private_group_posts" do
    scenario "form not found with no login_user" do
      visit root_path

      click_link "グループ一覧"
      click_link @private_group.name

      expect(page).to_not have_css('form.post_form')

      login(michael)

      click_link "グループ一覧"
      click_link @private_group.name

      expect(page).to have_css('form.post_form')
    end

    scenario "create new posts and delete posts" do
      login(michael)
      visit root_path

      click_link "グループ一覧"
      click_link @private_group.name

      expect {
        fill_in "private_group_post[content]", with: "1番目の投稿です！"
        click_button "投稿"
        fill_in "private_group_post[content]", with: "2番目の投稿です！"
        click_button "投稿"
        fill_in "private_group_post[content]", with: "最新の投稿です！"
        click_button "投稿"
      }.to change { @private_group.private_group_posts.count }.by(3)

      expect(page).to have_content("新規投稿を行いました！")
      expect(page).to have_content("1番目の投稿です！")
      expect(page).to have_content("2番目の投稿です！")
      expect(page).to have_content("最新の投稿です！")

      expect {
        first("#delete_btn#{@private_group.private_group_posts.first.id}").click
      }.to change {@private_group.private_group_posts.count}.by(-1)

      expect(page).to have_text("投稿(最新の投稿です！)を削除しました")
      expect(page).to have_content("1番目の投稿です！")
      expect(page).to have_content("2番目の投稿です！")

      logout

      login(other_user)
      visit private_group_path(@private_group)

      expect(page).to_not have_content("投稿の削除")
    end

    scenario "creating post is failed" do
      login(michael)
      visit root_path

      click_link "グループ一覧"
      click_link @private_group.name

      expect {
        fill_in "private_group_post[content]", with: ""
        click_button "投稿"
      }.to_not change { @private_group.private_group_posts.count }

      expect(page).to have_text("新規投稿に失敗しました")
      expect(page).to have_css('div#validation_messages')
    end
  end

end