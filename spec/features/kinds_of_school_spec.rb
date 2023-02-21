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

  end

end