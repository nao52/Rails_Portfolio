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

    click_link "ユーザー"

    expect(page).to have_selector('ul.pagination')
    @private_group.members.page(1).per(30).each do |member|
      expect(page).to have_link member.name, href: user_path(member)
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
  end

end