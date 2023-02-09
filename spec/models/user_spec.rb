require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    FactoryBot.create(:subject)
    FactoryBot.create(:club)
    FactoryBot.create(:kinds_of_school)
  end

  it "is valid with name, email, password, subject_id, club_id, kinds_of_school_id" do
    expect(FactoryBot.build(:user)).to be_valid
  end

end
