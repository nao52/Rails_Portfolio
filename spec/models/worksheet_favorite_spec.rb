require 'rails_helper'

RSpec.describe WorksheetFavorite, type: :model do

  before do
    @user            = FactoryBot.create(:user)
    @worksheet       = FactoryBot.create(:worksheet, user_id: @user.id)
  end

  let(:worksheet_favorite) { @user.worksheet_favorites.build(worksheet_id: @worksheet.id) }

  it "is valid with user_id, worksheet_id" do
    expect(worksheet_favorite).to be_valid
  end

  it "is invalid without user_id" do
    worksheet_favorite.user_id = nil
    expect(worksheet_favorite).to_not be_valid
  end

  it "is invalid without worksheet_id" do
    worksheet_favorite.worksheet_id = nil
    expect(worksheet_favorite).to_not be_valid
  end

end
