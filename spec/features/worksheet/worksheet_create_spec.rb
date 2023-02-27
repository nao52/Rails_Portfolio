require 'rails_helper'

RSpec.feature "WorksheetCreates", type: :feature do

  before do

  end

  let(:michael) { FactoryBot.create(:user, name: "michael") }

  feature "creating new worksheet" do
    scenario "redirected login page" do
      visit root_path

      click_link "ワークシート一覧"

      expect {
        click_link "ワークシートの新規登録"
      }.to change { current_path }.to login_path

      expect(page).to have_text("『ログインしてください』")
    end
  end

  scenario "creating worksheet is success" do
    login(michael)

    visit root_path
    click_link "ワークシート一覧"
    click_link "ワークシートの新規登録"

    expect {
      fill_in "worksheet[name]", with: "テスト用ワークシート"
      attach_file "worksheet[file]", "#{Rails.root}/spec/fixtures/files/test1.pdf"
      click_button "ワークシートを追加"
    }.to change { Worksheet.count }.by(1) && change { current_path }.to(worksheets_path)

    expect(page).to have_text("『新規ワークシートを追加しました！』")
  end

  scenario "creating worksheet is failed" do
    login(michael)

    visit root_path
    click_link "ワークシート一覧"
    click_link "ワークシートの新規登録"

    expect {
      fill_in "worksheet[name]", with: ""
      click_button "ワークシートを追加"
    }.to_not change { Worksheet.count }

    expect(page).to have_text("『出版社の登録に失敗しました...』")
    expect(page).to have_css('div#validation_messages')
  end
end