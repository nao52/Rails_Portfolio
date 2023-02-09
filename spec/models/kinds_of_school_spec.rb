require 'rails_helper'

RSpec.describe KindsOfSchool, type: :model do

  it "is valid with name" do
    expect(FactoryBot.build(:kinds_of_school)).to be_valid
  end

  it "is invalid without name" do
    expect(FactoryBot.build(:kinds_of_school, name: "")).to_not be_valid
  end

end
