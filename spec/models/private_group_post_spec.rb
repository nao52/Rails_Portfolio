require 'rails_helper'

RSpec.describe PrivateGroupPost, type: :model do

  before do
    @user            = FactoryBot.create(:user)
    @private_group   = FactoryBot.create(:private_group, user_id: @user.id)
  end

  let(:post) { FactoryBot.build(:private_group_post, user_id: @user.id, private_group_id: @private_group.id) }

  it "is valid with content, user_id, private_group_id" do
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

  it "is invalid without private_group_id" do
    post.private_group_id = nil
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
      FactoryBot.create(:private_group_post, user_id: @user.id, private_group_id: @private_group.id, created_at: 3.years.ago)
    end
    most_recent_post = FactoryBot.create(:private_group_post, user_id: @user.id, private_group_id: @private_group.id, created_at: Time.zone.now)
    expect(most_recent_post).to eq(PrivateGroupPost.first)
  end

end
