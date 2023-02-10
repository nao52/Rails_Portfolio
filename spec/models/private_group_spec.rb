require 'rails_helper'

RSpec.describe PrivateGroup, type: :model do

  before do
    @subject         = FactoryBot.create(:subject)
    @club            = FactoryBot.create(:club)
    @kinds_of_school = FactoryBot.create(:kinds_of_school)
    @user            = FactoryBot.create(:user, subject_id: @subject.id,
                                                club_id:  @club.id,
                                                kinds_of_school_id: @kinds_of_school.id)
  end

  let(:group) { FactoryBot.build(:private_group, user_id: @user.id) }

  it "is valid with name, detail, user_id" do
    expect(group).to be_valid
  end

  it "is invalid without name" do
    group.name = ""
    expect(group).to_not be_valid
  end

  it "is invalid without user_id" do
    group.user_id = nil
    expect(group).to_not be_valid
  end

  it "is valid when name is less than 50 characters" do
    group.name = "a" * 50
    expect(group).to be_valid
  end

  it "is valid when name is more 51 characters" do
    group.name = "a" * 51
    expect(group).to_not be_valid
  end

  it "is valid when detail is less than 140 characters" do
    group.detail = "a" * 140
    expect(group).to be_valid
  end

  it "is valid when detail is more 141 characters" do
    group.detail = "a" * 141
    expect(group).to_not be_valid
  end

end
