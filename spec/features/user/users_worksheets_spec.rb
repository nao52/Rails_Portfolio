require 'rails_helper'

RSpec.feature "UsersWorksheets", type: :feature do

  before do
    @michael = FactoryBot.create(:user, name: "michael")
    50.times do
      FactoryBot.create(:worksheet, user_id: @michael.id)
    end
  end

  feature "layout of users_worksheets" do
    scenario "show worksheets with pagination" do
      login(@michael)
      visit root_path

      click_link "マイページ"
      click_link "ワークシート(50)"

      expect(page).to have_selector('ul.pagination')
      @michael.worksheets.page(1).per(30).each do |worksheet|
        expect(page).to have_content("ワークシート名:【#{worksheet.name}】")
        expect(page).to have_content("作成者:【#{worksheet.user.name}】")
      end
    end
  end

end