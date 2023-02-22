require 'rails_helper'

RSpec.feature "PrivateGroupCreates", type: :feature do

  let(:michael)    { FactoryBot.create(:user, name: "michael") }
  let(:other_user) { FactoryBot.create(:user) }

  feature "creating new private_group" do
    scenario "redirected login page" do
      visit root_path
      click_link "グループ一覧"
  
      expect {
        click_link "グループの新規作成"
      }.to change { current_path }.to login_path

      expect(page).to have_text("『ログインしてください』")
    end

    scenario "create a private_group and delete a private_group" do
      login(michael)

      visit root_path
      click_link "グループ一覧"
      click_link "グループの新規作成"

      expect {
        fill_in "private_group[name]",    with: "新規テストグループ(1)"
        fill_in "private_group[detail]",  with: "テスト用のグループです！"
        click_button "新規グループの作成"

        click_link "グループの新規作成"
        fill_in "private_group[name]",    with: "新規テストグループ(2)"
        fill_in "private_group[detail]",  with: "テスト用のグループです！"
        click_button "新規グループの作成"
      }.to change { PrivateGroup.count }.by(2) && change { current_path }.to(private_groups_path)

      new_private_group1 = PrivateGroup.all[-2]
      new_private_group2 = PrivateGroup.all[-1]

      expect(page).to have_text("『新規グループの作成を行いました！』")
      expect(page).to have_link "新規テストグループ(1)", href: private_group_path(new_private_group1)
      expect(page).to have_link "新規テストグループ(2)", href: private_group_path(new_private_group2)
      expect(new_private_group2.members).to include michael

      expect {
        first("#delete_btn_private_group#{new_private_group2.id}").click
      }.to change { PrivateGroup.count }.by(-1)

      expect(page).to have_text("『グループ(新規テストグループ(2))を削除しました』")
      expect(page).to have_link "新規テストグループ(1)", href: private_group_path(new_private_group1)

      logout

      login(other_user)
      visit private_groups_path

      expect(page).to_not have_link "グループの削除"
    end

    scenario "creating private_group is failed" do
      login(michael)
      visit root_path

      click_link "グループ一覧"
      
      click_link "グループの新規作成"

      expect {
        fill_in "private_group[name]",    with: ""
        fill_in "private_group[detail]",  with: ""
        click_button "新規グループの作成"
      }.to_not change { PrivateGroup.count }

      expect(page).to have_text("『新規グループの作成に失敗しました...』")
      expect(page).to have_css('div#validation_messages')
    end
  end

end
