require 'rails_helper'

RSpec.describe KindsOfSchoolPost, type: :model do

  before do
    @subject         = FactoryBot.create(:subject)
    @club            = FactoryBot.create(:club)
    @kinds_of_school = FactoryBot.create(:kinds_of_school)
    @user            = FactoryBot.create(:user, subject_id: @subject.id,
                                                club_id:  @club.id,
                                                kinds_of_school_id: @kinds_of_school.id)
  end

  let(:post) { FactoryBot.build(:kinds_of_school_post, user_id: @user.id, kinds_of_school_id: @kinds_of_school.id) }

  it "is valid with content, user_id, kinds_of_school_id" do
    expect(post).to be_valid
  end

  it "is invalid without content" do
    post.content = ""
    expect(post).to_not be_valid
  end

  it "is invalid without user_id" do
    post.user_id = nil
    expect(post).to_not be_valid
  end

  it "is invalid without kinds_of_school_id" do
    post.kinds_of_school_id = nil
    expect(post).to_not be_valid
  end

  it "is valid when content is less than 140 characters" do
    post.content = "a" * 140
    expect(post).to be_valid
  end

  it "is invalid when content is more 140 characters" do
    post.content = "a" * 141
    expect(post).to_not be_valid
  end

  it "is first for most recent" do
    3.times do
      FactoryBot.create(:kinds_of_school_post, user_id: @user.id, kinds_of_school_id: @kinds_of_school.id, created_at: 3.years.ago)
    end
    most_recent_post = FactoryBot.create(:kinds_of_school_post, user_id: @user.id, kinds_of_school_id: @kinds_of_school.id, created_at: Time.zone.now)
    expect(most_recent_post).to eq(KindsOfSchoolPost.first)
  end

end
