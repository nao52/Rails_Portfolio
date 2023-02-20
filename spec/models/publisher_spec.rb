require 'rails_helper'

RSpec.describe Publisher, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  let(:publisher) { FactoryBot.create(:publisher, user_id: @user.id) }

  it "is valid with name, user_id" do
    expect(publisher).to be_valid
  end

  it "is invalid without name" do
    publisher.name = ""
    expect(publisher).to_not be_valid
    expect(publisher.errors.full_messages).to include("出版社名は必須項目です")
  end

  it "is invalid without user_id" do
    publisher.user_id = nil
    expect(publisher).to_not be_valid
  end

  it "is valid when name is less than 50 characters" do
    publisher.name = "a" * 50
    expect(publisher).to be_valid
  end

  it "is invalid when name is more 51 characters" do
    publisher.name = "a" * 51
    expect(publisher).to_not be_valid
    expect(publisher.errors.full_messages).to include("出版社名は50文字以内で入力してください")
  end

  it "is valid when name is unique" do
    publisher.save
    duplicate_publisher = publisher.dup
    expect(duplicate_publisher).to_not be_valid
    expect(duplicate_publisher.errors.full_messages).to include("出版社名はすでに存在します")
  end

end
