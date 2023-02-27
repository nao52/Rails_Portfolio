require 'rails_helper'

RSpec.feature "WorksheetUpdates", type: :feature do

  before do
    @michael = FactoryBot.create(:user, name: "michael")
    @worksheet = FactoryBot.create(:worksheet, user_id: @michael.id)
  end

  let(:other_user) { FactoryBot.create(:user) }

  feature "update worksheet" do
    scenario "edit_btn not found with no login_user" do
      visit root_path

      click_link "ワークシート一覧"
      expect(page).to have_content("ワークシート名:【#{@worksheet.name}】")
      expect(page).to have_content("作成者:【#{@worksheet.user.name}】")
      expect(page).to_not have_link "編集", href: edit_worksheet_path(@worksheet)
    end

    scenario "edit_btn not found with other_user" do
      login(other_user)
      visit root_path

      click_link "ワークシート一覧"
      expect(page).to have_content("ワークシート名:【#{@worksheet.name}】")
      expect(page).to have_content("作成者:【#{@worksheet.user.name}】")
      expect(page).to_not have_link "編集", href: edit_worksheet_path(@worksheet)
    end

    scenario "update worksheet is success" do
      login(@michael)
      visit root_path

      click_link "ワークシート一覧"
      click_link "編集"

      expect {
        fill_in "worksheet[name]", with: "ワークシート(更新)"
        click_button "ワークシート情報を更新"
      }.to change { current_path }.to(worksheets_path)

      expect(page).to have_text("『ワークシート情報を更新しました！』")
      expect(page).to have_content("ワークシート名:【ワークシート(更新)】")
    end

    scenario "update worksheet is failed" do
      login(@michael)
      visit root_path

      click_link "ワークシート一覧"
      click_link "編集"

      fill_in "worksheet[name]", with: ""
      click_button "ワークシート情報を更新"

      expect(page).to have_text("『ワークシート情報の編集に失敗しました...』")
      expect(page).to have_css('div#validation_messages')
    end
  end

end