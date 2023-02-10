require 'rails_helper'

RSpec.describe Club, type: :model do

  let(:club) { FactoryBot.build(:club) }

  it "is valid with name" do
    expect(club).to be_valid
  end

  it "is invalid without name" do
    club.name = ""
    expect(club).to_not be_valid
  end

  it "is valid when name is less than 50 characters" do
    club.name = "a" * 50
    expect(club).to be_valid
  end

  it "is invalid when name is more 51 characters" do
    club.name = "a" * 51
    expect(club).to_not be_valid
  end

end
