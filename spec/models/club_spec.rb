require 'rails_helper'

RSpec.describe Club, type: :model do

  it "is valid with name" do
    expect(FactoryBot.build(:club)).to be_valid
  end

  it "is invalid without name" do
    expect(FactoryBot.build(:club, name: "")).to_not be_valid
  end

end
