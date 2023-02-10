require 'rails_helper'

RSpec.describe Carriculum, type: :model do
  
  let(:carriculum) { FactoryBot.build(:carriculum) }

  it "is valid with name" do
    expect(carriculum).to be_valid
  end

  it "is invalid without name" do
    carriculum.name = ""
    expect(carriculum).to_not be_valid
  end

  it "is valid when name is less than 50 characters" do
    carriculum.name = "a" * 50
    expect(carriculum).to be_valid
  end

  it "is invalid when name is more 51 characters" do
    carriculum.name = "a" * 51
    expect(carriculum).to_not be_valid
  end

end
