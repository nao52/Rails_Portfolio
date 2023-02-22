require 'rails_helper'

RSpec.feature "PrivateGroupUpdates", type: :feature do

  before do
    @michael = FactoryBot.create(:user, name: "michael")
    @private_group = FactoryBot.create(:private_group, user_id: @michael.id)
  end

  let(:other_user) { FactoryBot.create(:user) }

  feature "update private_group" do
    scenario "edit_btn not found with no login_user" do
      visit root_path

      click_link "グループ一覧"
      expect(page).to have_link @private_group.name, href: private_group_path(@private_group)
      expect(page).to_not have_link "グループ情報の編集", href: edit_private_group_path(@private_group)
    end

    scenario "edit_btn not found with other_user" do
      login(@michael)
      visit root_path

      click_link "グループ一覧"
      expect(page).to have_link @private_group.name, href: private_group_path(@private_group)
      expect(page).to have_link "グループ情報の編集", href: edit_private_group_path(@private_group)

      logout
      login(other_user)

      click_link "グループ一覧"
      expect(page).to have_link @private_group.name, href: private_group_path(@private_group)
      expect(page).to_not have_link "グループ情報の編集", href: edit_private_group_path(@private_group)
    end

    scenario "update private_group is success" do
      login(@michael)
      visit root_path
      click_link "グループ一覧"
      click_link "グループ情報の編集"

      expect {
        fill_in "private_group[name]",    with: "グループ(更新)"
        click_button "グループ情報の編集"
      }.to change { current_path }.to(private_groups_path)

      expect(page).to have_text("『グループ情報を更新しました！』")
      expect(page).to have_link "グループ(更新)", href: private_group_path(@private_group)
    end

    scenario "update private_group is failed" do
      login(@michael)
      visit root_path
      click_link "グループ一覧"
      click_link "グループ情報の編集"
      
      fill_in "private_group[name]",    with: ""
      click_button "グループ情報の編集"

      expect(page).to have_text("『グループ情報の編集に失敗しました...』")
      expect(page).to have_css('div#validation_messages')
    end
  end

end
