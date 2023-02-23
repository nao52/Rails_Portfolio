require 'rails_helper'

RSpec.feature "PublisherShows", type: :feature do

  before do
    @user = FactoryBot.create(:user)
    @publisher = FactoryBot.create(:publisher, user_id: @user.id)
    50.times do
      FactoryBot.create(:reference_book, user_id: @user.id, publisher_id: @publisher.id)
    end
  end
  
  scenario "layout of publishers_show" do
    visit root_path
    click_link "出版社一覧"
    click_link @publisher.name

    expect(page).to have_selector('ul.pagination')
    @publisher.reference_books.page(1).per(30).each do |reference_book|
      expect(page).to have_link "書籍名:【 #{reference_book.title} 】", href: reference_book_path(reference_book)
    end
  end

end
