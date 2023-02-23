require 'rails_helper'

RSpec.feature "ReferenceBookShows", type: :feature do

  before do
    @user      = FactoryBot.create(:user)
    @publisher = FactoryBot.create(:publisher, user_id: @user.id)
    @reference_book = FactoryBot.create(:reference_book, user_id: @user.id, publisher_id: @publisher.id)
  end

  let(:michael) { FactoryBot.create(:user, name: "michael") }
  let(:other_user) { FactoryBot.create(:user) }

  feature "layout of reference_books_show" do
    scenario "show book_reviews with pagination" do
      50.times do
        FactoryBot.create(:book_review, user_id: @user.id, reference_book_id: @reference_book.id)
      end

      visit root_path
      click_link "参考書一覧"
      click_link @reference_book.title

      expect(page).to have_content("【#{@reference_book.title}】のレビュー一覧")

      expect(page).to have_selector('ul.pagination')
      @reference_book.book_reviews.page(1).per(30).each do |review|
        expect(page).to have_content("投稿者:#{review.user.name}")
        expect(page).to have_content(review.content)
      end
    end
  end

  feature "create new book_review" do
    scenario "form not found with no login_user" do
      visit root_path

      click_link "参考書一覧"
      click_link @reference_book.title

      expect(page).to_not have_css('form.review_form')

      login(michael)

      click_link "参考書一覧"
      click_link @reference_book.title

      expect(page).to have_css('form.review_form')
    end

    scenario "create new book_review and delete book_review" do
      login(michael)
      visit root_path

      click_link "参考書一覧"
      click_link @reference_book.title

      expect {
        fill_in "book_review[content]", with: "1番目の投稿です！"
        click_button "レビューを投稿"
        fill_in "book_review[content]", with: "2番目の投稿です！"
        click_button "レビューを投稿"
        fill_in "book_review[content]", with: "最新の投稿です！"
        click_button "レビューを投稿"
      }.to change { @reference_book.book_reviews.count }.by(3)

      expect(page).to have_text("『レビューを投稿しました！』")
      expect(page).to have_content("投稿者:#{michael.name}")
      expect(page).to have_content("1番目の投稿です！")
      expect(page).to have_content("2番目の投稿です！")
      expect(page).to have_content("最新の投稿です！")

      expect {
        first("#delete_btn#{@reference_book.book_reviews.first.id}").click
      }.to change { @reference_book.book_reviews.count }.by(-1)

      expect(page).to have_text("『レビュー(最新の投稿です！)を削除しました』")
      expect(page).to have_content("1番目の投稿です！")
      expect(page).to have_content("2番目の投稿です！")

      logout

      login(other_user)
      visit reference_book_path(@reference_book)

      expect(page).to_not have_content("レビューの削除")
    end

    scenario "creating review is failed" do
      login(michael)
      visit root_path

      click_link "参考書一覧"
      click_link @reference_book.title

      expect {
        fill_in "book_review[content]", with: ""
        click_button "レビューを投稿"
      }.to_not change { @reference_book.book_reviews.count }

      expect(page).to have_text("『レビューの投稿に失敗しました...』")
      expect(page).to have_css('div#validation_messages')
    end
  end

end