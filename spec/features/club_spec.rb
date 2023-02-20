require 'rails_helper'

RSpec.feature "Clubs", type: :feature do

  let(:baseball) { Club.first }

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

end