require 'rails_helper'

RSpec.feature "UsersIndices", type: :feature do

  before do
    # 画面表示用のユーザーを作成
    50.times do
      FactoryBot.create(:user)
    end
  end

  let(:subject1) { Subject.first }
  let(:subject2) { Subject.second }
  let(:club1) { Club.first }
  let(:club2) { Club.second }

  scenario "show users with pagination" do
    visit users_path
    
    expect(page).to have_selector('ul.pagination')
    User.all.page(1).per(30).each do |user|
      expect(page).to have_link user.name, href: user_path(user)
    end
  end

  feature "search users by name" do
    scenario "users found" do
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

  feature "search users by subject" do
    scenario "users found" do
      visit users_path
    
      choose "担当教科"
      select  "#{subject1.name}", from: "subject"
      click_button "検索"
    
      users = User.where("subject_id LIKE ?", "#{subject1.id}")
    
      expect(page).to have_text("#{users.count}件のユーザーが見つかりました！")
      users.page(1).per(30).each do |user|
        expect(page).to have_link user.name, href: user_path(user)
      end
    end

    scenario "users not found" do
      visit users_path
    
      choose "担当教科"
      select  "#{subject2.name}", from: "subject"
      click_button "検索"
        
      expect(page).to have_text("該当するユーザーが見つからなかったので、全てのユーザーを表示します。")
      User.all.page(1).per(30).each do |user|
        expect(page).to have_link user.name, href: user_path(user)
      end
    end
  end

  feature "search users by club" do
    scenario "users found" do
      visit users_path
    
      choose "担当部活動"
      select  "#{club1.name}", from: "club"
      click_button "検索"
    
      users = User.where("club_id LIKE ?", "#{club1.id}")
    
      expect(page).to have_text("#{users.count}件のユーザーが見つかりました！")
      users.page(1).per(30).each do |user|
        expect(page).to have_link user.name, href: user_path(user)
      end
    end

    scenario "users not found" do
      visit users_path
    
      choose "担当教科"
      select  "#{club2.name}", from: "club"
      click_button "検索"
        
      expect(page).to have_text("該当するユーザーが見つからなかったので、全てのユーザーを表示します。")
      User.all.page(1).per(30).each do |user|
        expect(page).to have_link user.name, href: user_path(user)
      end
    end
  end

end