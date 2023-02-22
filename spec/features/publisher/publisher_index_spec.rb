require 'rails_helper'

RSpec.feature "PublisherIndices", type: :feature do

  before do
    @user = FactoryBot.create(:user)
    50.times do
      FactoryBot.create(:publisher, user_id: @user.id)
    end
  end

  feature "layout of publishers_index" do
    scenario "show publishers with pagination" do
      visit root_path
      click_link "出版社一覧"

      expect(page).to have_selector('ul.pagination')
      Publisher.all.page(1).per(30).each do |publisher|
        expect(page).to have_link publisher.name, href: publisher_path(publisher)
      end

    end
  end

  feature "search publishers" do
    scenario "publishers found" do
      search_name = "テスト1"

      visit root_path
      click_link "出版社一覧"

      fill_in "name", with: search_name
      click_button "検索"

      publishers = Publisher.where("name LIKE ?", "%#{search_name}%")

      expect(page).to have_text("『#{publishers.size}件の出版社が見つかりました！』")
      publishers.page(1).per(30).each do |publisher|
        expect(page).to have_link publisher.name, href: publisher_path(publisher)
      end
    end

    scenario "publishers not found" do
      visit root_path
      click_link "出版社一覧"

      fill_in "name", with: "kdjfgoierjg"
      click_button "検索"

      expect(page).to have_text("『該当する出版社が見つからなかったので、全ての出版社を表示します。』")
      Publisher.all.page(1).per(30).each do |publisher|
        expect(page).to have_link publisher.name, href: publisher_path(publisher)
      end
    end

    scenario "name is empty" do
      visit root_path
      click_link "出版社一覧"

      fill_in "name", with: ""
      click_button "検索"

      expect(page).to have_text("『出版社名を入力してください』")
      Publisher.all.page(1).per(30).each do |publisher|
        expect(page).to have_link publisher.name, href: publisher_path(publisher)
      end
    end
  end

end