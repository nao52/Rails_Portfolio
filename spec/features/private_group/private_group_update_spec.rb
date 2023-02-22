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
  end

end
