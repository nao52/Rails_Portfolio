require 'rails_helper'

RSpec.describe Subject, type: :model do

  let(:subject) { FactoryBot.build(:subject) }

  it "is valid with name" do
    expect(subject).to be_valid
  end

  it "is invalid without name" do
    subject.name = ""
    expect(subject).to_not be_valid
  end

  it "is valid when name is less than 50 characters" do
    subject.name = "a" * 50
    expect(subject).to be_valid
  end

  it "is invalid when name is more 51 characters" do
    subject.name = "a" * 51
    expect(subject).to_not be_valid
  end

end
