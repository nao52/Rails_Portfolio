require 'rails_helper'

RSpec.feature "WorksheetIndices", type: :feature do

  before do
    @user = FactoryBot.create(:user)
    50.times do
      FactoryBot.create(:worksheet, user_id: @user.id)
    end
  end

  feature "layout of worksheets_index" do
    scenario "show worksheets with pagination" do
      visit root_path
      click_link "ワークシート一覧"

      expect(page).to have_selector('ul.pagination')
      Worksheet.all.page(1).per(30).each do |worksheet|
        expect(page).to have_content("ワークシート名:【#{worksheet.name}】")
        expect(page).to have_content("作成者:【#{worksheet.user.name}】")
      end
    end
  end

end