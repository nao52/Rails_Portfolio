require 'rails_helper'

RSpec.describe Relationship, type: :model do

  before do
    FactoryBot.create(:subject)
    FactoryBot.create(:club)
    FactoryBot.create(:kinds_of_school)
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  let(:relationship) { Relationship.new(  follower_id: @user1.id,
                                          followed_id: @user2.id  ) }

  it "is valid with follower_id, followed_id" do
    expect(relationship).to be_valid
  end

  it "is invalid without follower_id" do
    relationship.follower_id = nil
    expect(relationship).to_not be_valid
  end

  it "is invalid without followed_id" do
    relationship.followed_id = nil
    expect(relationship).to_not be_valid
  end

end
