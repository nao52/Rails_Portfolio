require 'rails_helper'

RSpec.feature "UsersShows", type: :feature do
  
  let(:michael) { FactoryBot.create(:user, name: "michael") }
  let(:forger)  { FactoryBot.create(:user, name: "forger") }

  scenario "layout of users_show" do
    login(michael)
    click_link "マイページ"

    expect(page).to have_content("michael")

    expect(page).to have_link "ユーザー情報の編集",                                           href: edit_user_path(michael)
    expect(page).to have_link "#{michael.kinds_of_school.name}",                              href: kinds_of_school_path(michael.kinds_of_school)
    expect(page).to have_link "#{michael.subject.name}",                                      href: subject_path(michael.subject)
    expect(page).to have_link "#{michael.club.name}部",                                       href: club_path(michael.club)
    expect(page).to have_link "フォロー中(#{michael.following.count})",                       href: following_user_path(michael)
    expect(page).to have_link "フォロワー(#{michael.followers.count})",                       href: followers_user_path(michael)
    expect(page).to have_link "所属グループ(#{michael.joining.count})",                       href: user_path(michael)
    expect(page).to have_link "ワークシート(#{michael.worksheets.count})",                    href: worksheets_user_path(michael)
    expect(page).to have_link "お気に入り書籍(#{michael.favorite_books.count})",              href: favorite_books_user_path(michael)
    expect(page).to have_link "お気に入りワークシート(#{michael.favorite_worksheets.count})", href: favorite_worksheets_user_path(michael)

    visit user_path(forger)

    expect(page).to have_content("forger")

    expect(page).to_not have_link "ユーザー情報の編集",                                      href: edit_user_path(michael)
    
    expect(page).to have_link "#{forger.kinds_of_school.name}",                              href: kinds_of_school_path(forger.kinds_of_school)
    expect(page).to have_link "#{forger.subject.name}",                                      href: subject_path(forger.subject)
    expect(page).to have_link "#{forger.club.name}部",                                       href: club_path(forger.club)
    expect(page).to have_link "フォロー中(#{forger.following.count})",                       href: following_user_path(forger)
    expect(page).to have_link "フォロワー(#{forger.followers.count})",                       href: followers_user_path(forger)
    expect(page).to have_link "所属グループ(#{forger.joining.count})",                       href: user_path(forger)
    expect(page).to have_link "ワークシート(#{forger.worksheets.count})",                    href: worksheets_user_path(forger)
    expect(page).to have_link "お気に入り書籍(#{forger.favorite_books.count})",              href: favorite_books_user_path(forger)
    expect(page).to have_link "お気に入りワークシート(#{forger.favorite_worksheets.count})", href: favorite_worksheets_user_path(forger)
  end

end