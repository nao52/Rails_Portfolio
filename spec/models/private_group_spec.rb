require 'rails_helper'

RSpec.describe PrivateGroup, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  let(:private_group) { FactoryBot.build(:private_group, user_id: @user.id) }

  it "is valid with name, detail, user_id" do
    expect(private_group).to be_valid
  end

  it "is invalid without name" do
    private_group.name = ""
    expect(private_group).to_not be_valid
    expect(private_group.errors.full_messages).to include("グループ名は必須項目です")
  end

  it "is invalid without user_id" do
    private_group.user_id = nil
    expect(private_group).to_not be_valid
  end

  it "is valid when name is less than 50 characters" do
    private_group.name = "a" * 50
    expect(private_group).to be_valid
  end

  it "is valid when name is more 51 characters" do
    private_group.name = "a" * 51
    expect(private_group).to_not be_valid
    expect(private_group.errors.full_messages).to include("グループ名は50文字以内で入力してください")
  end

  it "is valid when detail is less than 140 characters" do
    private_group.detail = "a" * 140
    expect(private_group).to be_valid
  end

  it "is valid when detail is more 141 characters" do
    private_group.detail = "a" * 141
    expect(private_group).to_not be_valid
    expect(private_group.errors.full_messages).to include("グループ詳細は140文字以内で入力してください")
  end

end
