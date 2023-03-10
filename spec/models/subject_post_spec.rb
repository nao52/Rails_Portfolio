require 'rails_helper'

RSpec.describe SubjectPost, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  let(:post) { FactoryBot.build(:subject_post, user_id: @user.id, subject_id: Subject.first.id) }
  let(:subject) { Subject.first }

  it "is valid with content, user_id, subject_id" do
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
    expect(post.errors.full_messages).to include("投稿内容は140文字以内で入力してください")
  end

  it "is first for most recent" do
    3.times do
      FactoryBot.create(:subject_post, user_id: @user.id, subject_id: subject.id, created_at: 3.years.ago)
    end
    most_recent_post = FactoryBot.create(:subject_post, user_id: @user.id, subject_id: subject.id, created_at: Time.zone.now)
    expect(most_recent_post).to eq(SubjectPost.first)
  end

end
