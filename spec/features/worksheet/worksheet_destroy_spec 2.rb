require 'rails_helper'

RSpec.feature "WorksheetDestroys", type: :feature do

  before do
    @michael = FactoryBot.create(:user, name: "michael")
    @worksheet = FactoryBot.create(:worksheet, user_id: @michael.id)
  end

  let(:other_user) { FactoryBot.create(:user) }

  feature "destroy worksheet" do
    scenario "delete_btn not found with no login_user" do
      visit root_path

      click_link "ワークシート一覧"
      expect(page).to have_content("ワークシート名:【#{@worksheet.name}】")
      expect(page).to have_content("作成者:【#{@worksheet.user.name}】")
      expect(page).to_not have_link "削除", href: worksheet_path(@worksheet)
    end

    scenario "delete_btn not found with other_user" do
      login(@michael)
      visit root_path

      click_link "ワークシート一覧"
      expect(page).to have_content("ワークシート名:【#{@worksheet.name}】")
      expect(page).to have_content("作成者:【#{@worksheet.user.name}】")
      expect(page).to have_link "削除", href: worksheet_path(@worksheet)

      logout
      login(other_user)

      click_link "ワークシート一覧"
      expect(page).to have_content("ワークシート名:【#{@worksheet.name}】")
      expect(page).to have_content("作成者:【#{@worksheet.user.name}】")
      expect(page).to_not have_link "削除", href: worksheet_path(@worksheet)
    end

    scenario "destroy worksheet is success" do
      login(@michael)
      visit root_path
      click_link "ワークシート一覧"

      expect {
        click_link "削除"
      }.to change { Worksheet.count }.by(-1)

      expect(page).to have_text("『ワークシート(#{@worksheet.name})を削除しました』")
      expect(page).to_not have_content("ワークシート名:【#{@worksheet.name}】")
      expect(page).to_not have_content("作成者:【#{@worksheet.user.name}】")
    end
  end

end