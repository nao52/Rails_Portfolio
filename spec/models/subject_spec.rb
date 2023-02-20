require 'rails_helper'

RSpec.describe Subject, type: :model do

  let(:subject) { FactoryBot.build(:subject) }

  it "is valid with name" do
    expect(subject).to be_valid
  end

  it "is invalid without name" do
    subject.name = ""
    expect(subject).to_not be_valid
    expect(subject.errors.full_messages).to include("教科名は必須項目です")
  end

  it "is valid when name is less than 50 characters" do
    subject.name = "a" * 50
    expect(subject).to be_valid
  end

  it "is invalid when name is more 51 characters" do
    subject.name = "a" * 51
    expect(subject).to_not be_valid
    expect(subject.errors.full_messages).to include("教科名は50文字以内で入力してください")
  end

end
