require 'rails_helper'

RSpec.feature "UsersIndices", type: :feature do

  before do
    @subject         = FactoryBot.create(:subject)
    @club            = FactoryBot.create(:club)
    @kinds_of_school = FactoryBot.create(:kinds_of_school)
    @user            = FactoryBot.create(:user, subject_id: @subject.id,
                                                club_id:  @club.id,
                                                kinds_of_school_id: @kinds_of_school.id)

    # 画面表示用のユーザーを作成
    100.times do
      FactoryBot.create(:user, subject_id: @subject.id,
                               club_id:  @club.id,
                               kinds_of_school_id: @kinds_of_school.id)
    end

  end

  scenario "show users with pagination" do
    login(@user)
    visit users_path

    expect(page).to have_selector('ul.pagination')
    User.all.page(1).per(30).each do |user|
      expect(page).to have_link user.name, href: user_path(user)
    end
  end

  feature "search users by name" do
    scenario "users found" do
      login(@user)
      visit users_path
    
      choose "名前"
      fill_in "name", with: "michael"
      click_button "検索"
    
      users = User.where("name LIKE ?", "%michael%")
    
      expect(page).to have_text("#{users.count}件のユーザーが見つかりました！")
      users.page(1).per(30).each do |user|
        expect(page).to have_link user.name, href: user_path(user)
      end
    end

    scenario "users not found" do
      login(@user)
      visit users_path
    
      choose "名前"
      fill_in "name", with: "kdjfgoierjg"
      click_button "検索"
        
      expect(page).to have_text("該当するユーザーが見つからなかったので、全てのユーザーを表示します。")
      User.all.page(1).per(30).each do |user|
        expect(page).to have_link user.name, href: user_path(user)
      end
    end

    scenario "name is empty" do
      login(@user)
      visit users_path
    
      choose "名前"
      fill_in "name", with: ""
      click_button "検索"
        
      expect(page).to have_text("ユーザー名を入力してください")
      User.all.page(1).per(30).each do |user|
        expect(page).to have_link user.name, href: user_path(user)
      end
    end
  end

end