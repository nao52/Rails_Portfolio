require 'rails_helper'

RSpec.describe KindsOfSchoolPost, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  let(:post) { FactoryBot.build(:kinds_of_school_post, user_id: @user.id, kinds_of_school_id: KindsOfSchool.first.id) }
  let(:kinds_of_school) { KindsOfSchool.first }

  it "is valid with content, user_id, kinds_of_school_id" do
    expect(post).to be_valid
  end

  it "is invalid without content" do
    post.content = ""
    expect(post).to_not be_valid
    expect(post.errors.full_messages).to include("投稿内容は必須項目です")
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
    expect(post.errors.full_messages).to include("投稿内容は140文字以内で入力してください")
  end

  it "is first for most recent" do
    3.times do
      FactoryBot.create(:kinds_of_school_post, user_id: @user.id, kinds_of_school_id: kinds_of_school.id, created_at: 3.years.ago)
    end
    most_recent_post = FactoryBot.create(:kinds_of_school_post, user_id: @user.id, kinds_of_school_id: kinds_of_school.id, created_at: Time.zone.now)
    expect(most_recent_post).to eq(KindsOfSchoolPost.first)
  end

end
