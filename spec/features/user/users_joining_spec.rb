require 'rails_helper'

RSpec.feature "UsersJoinings", type: :feature do
  
  before do
    @user    = FactoryBot.create(:user)
    @michael = FactoryBot.create(:user, name: "michael")
    50.times do
      @group = FactoryBot.create(:private_group, user_id: @user.id)
      @michael.join(@group)
    end
  end

  scenario "show users_joining with pagination" do
    login(@michael)

    visit user_path(@michael)
    click_link "所属グループ(50)"

    expect(page).to have_selector('ul.pagination')
    @michael.joining.page(1).per(30).each do |group|
      expect(page).to have_link group.name, href: private_group_path(group)
    end
  end

end
