require 'rails_helper'

RSpec.describe KindsOfSchool, type: :model do

  let(:kinds_of_school) { FactoryBot.build(:kinds_of_school) }

  it "is valid with name" do
    expect(kinds_of_school).to be_valid
  end

  it "is invalid without name" do
    kinds_of_school.name = ""
    expect(kinds_of_school).to_not be_valid
  end

  it "is valid when name is less than 50 characters" do
    kinds_of_school.name = "a" * 50
    expect(kinds_of_school).to be_valid
  end

  it "is invalid when name is more 51 characters" do
    kinds_of_school.name = "a" * 51
    expect(kinds_of_school).to_not be_valid
  end

end
