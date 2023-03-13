require 'rails_helper'

RSpec.describe CleaningPlace, type: :model do
  
  before do
    @user = FactoryBot.create(:user)
  end

  let(:cleaning_place) { FactoryBot.build(:cleaning_place, user_id: @user.id) }

  it "is valid with name, boys_num, girls_num, user_id" do
    expect(cleaning_place).to be_valid
  end

  it "is invalid without name" do
    cleaning_place.name = ""
    expect(cleaning_place).to_not be_valid
    expect(cleaning_place.errors.full_messages).to include("掃除担当場所は必須項目です")
  end

  it "is invalid without boys_num" do
    cleaning_place.boys_num = nil
    expect(cleaning_place).to_not be_valid
    expect(cleaning_place.errors.full_messages).to include("男子生徒数は必須項目です")
  end

  it "is invalid without girls_num" do
    cleaning_place.girls_num = nil
    expect(cleaning_place).to_not be_valid
    expect(cleaning_place.errors.full_messages).to include("女子生徒数は必須項目です")
  end

  it "is invalid without user_id" do
    cleaning_place.user_id = nil
    expect(cleaning_place).to_not be_valid
  end

  it "is invalid when name is more 50 characters" do
    cleaning_place.name = "a" * 51
    expect(cleaning_place).to_not be_valid
    expect(cleaning_place.errors.full_messages).to include("掃除担当場所は50文字以内で入力してください")
  end

  it "is valid when boys_num is 0" do
    cleaning_place.boys_num = 0
    expect(cleaning_place).to be_valid
  end

  it "is valid when boys_num is 10" do
    cleaning_place.boys_num = 10
    expect(cleaning_place).to be_valid
  end

  it "is invalid when boys_num is more 10" do
    cleaning_place.boys_num = -1
    expect(cleaning_place).to_not be_valid
    expect(cleaning_place.errors.full_messages).to include("男子生徒数は0..10の範囲で入力してください")
  end

  it "is invalid when boys_num is more 10" do
    cleaning_place.boys_num = 11
    expect(cleaning_place).to_not be_valid
    expect(cleaning_place.errors.full_messages).to include("男子生徒数は0..10の範囲で入力してください")
  end

  it "is valid when girls_num is 0" do
    cleaning_place.girls_num = 0
    expect(cleaning_place).to be_valid
  end

  it "is valid when girls_num is 10" do
    cleaning_place.girls_num = 10
    expect(cleaning_place).to be_valid
  end

  it "is invalid when girls_num is more 10" do
    cleaning_place.girls_num = -1
    expect(cleaning_place).to_not be_valid
    expect(cleaning_place.errors.full_messages).to include("女子生徒数は0..10の範囲で入力してください")
  end

  it "is invalid when girls_num is more 10" do
    cleaning_place.girls_num = 11
    expect(cleaning_place).to_not be_valid
    expect(cleaning_place.errors.full_messages).to include("女子生徒数は0..10の範囲で入力してください")
  end

end
