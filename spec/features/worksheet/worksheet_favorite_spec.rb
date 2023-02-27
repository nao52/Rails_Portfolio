require 'rails_helper'

RSpec.feature "WorksheetFavorites", type: :feature do

  before do
    @user = FactoryBot.create(:user)
    @worksheet = FactoryBot.create(:worksheet, user_id: @user.id)
  end

  let(:michael) { FactoryBot.create(:user, name: "michael") }

  feature "favorite worksheet" do
    scenario "favorite_btn not found with no login_user" do
      visit root_path

      click_link "ワークシート一覧"
      expect(page).to have_content("ワークシート名:【#{@worksheet.name}】")
      expect(page).to have_content("作成者:【#{@worksheet.user.name}】")
      expect(page).to_not have_css("div#favorite_form_#{@worksheet.id}")

      login(michael)

      visit root_path
      click_link "ワークシート一覧"
      expect(page).to have_content("ワークシート名:【#{@worksheet.name}】")
      expect(page).to have_content("作成者:【#{@worksheet.user.name}】")
      expect(page).to have_css("div#favorite_form_#{@worksheet.id}")
    end

    scenario "favorite worksheet and unfavorite worksheet" do
      login(michael)
      visit root_path

      click_link "ワークシート一覧"
      expect {
        click_button "お気に入り(0)"
      }.to change { michael.favorite_worksheets.count }.by(1)

      click_link "マイページ"
      expect(page).to have_link "お気に入りワークシート(1)", href: favorite_worksheets_user_path(michael)

      click_link "ワークシート一覧"
      expect {
        click_button "お気に入り解除(1)"
      }.to change { michael.favorite_worksheets.count }.by(-1)

      click_link "マイページ"
      expect(page).to have_link "お気に入りワークシート(0)", href: favorite_worksheets_user_path(michael)
    end

    scenario "show favorite_worksheets with pagination" do
      login(michael)

      50.times do
        worksheet = FactoryBot.create(:worksheet, user_id: @user.id)
        michael.favorite_worksheet(worksheet)
      end

      visit root_path

      click_link "マイページ"
      click_link "お気に入りワークシート(#{michael.favorite_worksheets.count})"

      expect(page).to have_selector('ul.pagination')
      michael.favorite_worksheets.page(1).per(30).each do |worksheet|
        expect(page).to have_content("ワークシート名:【#{@worksheet.name}】")
      expect(page).to have_content("作成者:【#{@worksheet.user.name}】")
      end
    end
  end

end