require 'rails_helper'

RSpec.feature "Clubs", type: :feature do

  scenario "show clubs_index" do
    visit root_path

    click_link "部活動一覧"

    Club.all.each do |club|
      expect(page).to have_link club.name, href: club_path(club)
    end
  end

  

end