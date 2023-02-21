require 'rails_helper'

RSpec.feature "PrivateGroups", type: :feature do

  let(:user)       { FactoryBot.create(:user) }
  let(:michael)    { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  scenario "show private_groups_index" do
    50.times do
      FactoryBot.create(:private_group, user_id: user.id)
    end

    visit root_path

    click_link "グループ一覧"

    PrivateGroup.all.page(1).per(30).each do |private_group|
      expect(page).to have_link private_group.name, href: private_group_path(private_group)
    end
  end

end