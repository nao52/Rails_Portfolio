require 'rails_helper'

RSpec.describe Worksheet, type: :model do
  
  before do
    @user = FactoryBot.create(:user)
  end

  let(:worksheet) { FactoryBot.build(:worksheet, user_id: @user.id) }

  it "is valid with name, file, user_id, likes_count" do
    expect(worksheet).to be_valid
  end

  it "is invalid without name" do
    worksheet.name = ""
    expect(worksheet).to_not be_valid
    expect(worksheet.errors.full_messages).to include("ワークシート名は必須項目です")
  end

  it "is invalid without file" do
    worksheet.file = nil
    expect(worksheet).to_not be_valid
    expect(worksheet.errors.full_messages).to include("ワークシートは必須項目です")
  end

  it "is invalid without user_id" do
    worksheet.user_id = nil
    expect(worksheet).to_not be_valid
  end

  it "is invalid without likes_count" do
    worksheet.likes_count = nil
    expect(worksheet).to_not be_valid
  end

  it "is valid when name is less than 50 characters" do
    worksheet.name = "a" * 50
    expect(worksheet).to be_valid
  end

  it "is invalid when name is more 51 characters" do
    worksheet.name = "a" * 51
    expect(worksheet).to_not be_valid
    expect(worksheet.errors.full_messages).to include("ワークシート名は50文字以内で入力してください")
  end

  it "is valid when detail is less than 140 characters" do
    worksheet.detail = "a" * 140
    expect(worksheet).to be_valid
  end

  it "is invalid when detail is more 141 characters" do
    worksheet.detail = "a" * 141
    expect(worksheet).to_not be_valid
    expect(worksheet.errors.full_messages).to include("ワークシートの詳細は140文字以内で入力してください")
  end

  it "is first for the most likes count" do
    5.times do
      FactoryBot.create(:worksheet, user_id: @user.id, likes_count: 3)
    end
    most_likes_count = FactoryBot.create(:worksheet, user_id: @user.id, likes_count: 10)
    expect(most_likes_count).to eq(Worksheet.first)
  end

end
