require 'rails_helper'

RSpec.describe Subject, type: :model do

  it "is valid with name" do
    expect(FactoryBot.build(:subject)).to be_valid
  end

  it "is invalid without name" do
    expect(FactoryBot.build(:subject, name: "")).to_not be_valid
  end

end
