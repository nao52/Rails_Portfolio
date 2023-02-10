require 'rails_helper'

RSpec.describe SubjectPost, type: :model do

  before do
    FactoryBot.create(:subject)
    FactoryBot.create(:club)
    FactoryBot.create(:kinds_of_school)
    FactoryBot.create(:user)
  end

  let(:post) { FactoryBot.build(:subject_post) }

  it "is valid with content, user_id, subject_id" do
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

  it "is invalid without subject_id" do
    post.subject_id = nil
    expect(post).to_not be_valid
  end

  it "is valid when content is less than 140 characters" do
    post.content = "a" * 140
    expect(post).to be_valid
  end

  it "is invalid when content is more 141 characters" do
    post.content = "a" * 141
    expect(post).to_not be_valid
  end

  it "is first for most recent" do
    5.times do
      FactoryBot.create(:subject_post, created_at: 2.years.ago)
    end
    most_recent_post = FactoryBot.create(:subject_post)
    expect(most_recent_post).to eq(SubjectPost.first)
  end

  it "is last for most old" do
    5.times do
      FactoryBot.create(:subject_post)
    end
    most_old_post = FactoryBot.create(:subject_post, created_at: 2.years.ago)
    expect(most_old_post).to eq(SubjectPost.last)
  end

end