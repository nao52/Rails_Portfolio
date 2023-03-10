require 'rails_helper'

RSpec.describe Participation, type: :model do

  before do
    @user            = FactoryBot.create(:user)
    @private_group   = FactoryBot.create(:private_group, user_id: @user.id)
  end

  let(:participation) { @user.participations.build( private_group_id: @private_group.id ) }

  it "is valid with user_id, private_group_id" do
    expect(participation).to be_valid
  end

  it "is invalid witout user_id" do
    participation.user_id = nil
    expect(participation).to_not be_valid
  end

  it "is invalid without private_group_id" do
    participation.private_group_id = nil
    expect(participation).to_not be_valid
  end

end
