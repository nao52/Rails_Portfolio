require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @subject         = FactoryBot.create(:subject)
    @club            = FactoryBot.create(:club)
    @kinds_of_school = FactoryBot.create(:kinds_of_school)
    @user1           = FactoryBot.create(:user, subject_id: @subject.id,
                                                club_id:  @club.id,
                                                kinds_of_school_id: @kinds_of_school.id)
    @user2           = FactoryBot.create(:user, subject_id: @subject.id,
                                                club_id:  @club.id,
                                                kinds_of_school_id: @kinds_of_school.id)
    @group           = FactoryBot.create(:private_group, user_id: @user1.id)
    @publisher       = FactoryBot.create(:publisher, user_id: @user1.id)
    @book            = FactoryBot.create(:reference_book, user_id: @user1.id, publisher_id: @publisher.id)
    @worksheet       = FactoryBot.create(:worksheet, user_id: @user1.id)
  end

  it "is valid with name, email, password, subject_id, club_id, kinds_of_school_id" do
    expect(@user1).to be_valid
  end

  it "is invalid without name" do
    @user1.name = ""
    expect(@user1).to_not be_valid
  end

  it "is invalid without email" do
    @user1.email = ""
    expect(@user1).to_not be_valid
  end

  it "is invalid without subject_id" do
    @user1.subject_id = nil
    expect(@user1).to_not be_valid
  end

  it "is invalid without club_id" do
    @user1.club_id = nil
    expect(@user1).to_not be_valid
  end

  it "is invalid without kinds_of_school_id" do
    @user1.kinds_of_school_id = nil
    expect(@user1).to_not be_valid
  end

  it "is valid when name is less than 50 characters" do
    @user1.name = "a" * 50
    expect(@user1).to be_valid
  end

  it "is invalid when name is more 51 characters" do
    @user1.name = "a" * 51
    expect(@user1).to_not be_valid
  end

  it "is valid when email is less than 255 characters" do
    @user1.email = ("a" * 243) + "@example.com"
    expect(@user1).to be_valid
  end

  it "is invalid when email is more 256 characters" do
    @user1.email = ("a" * 244) + "@example.com"
    expect(@user1).to_not be_valid
  end

  it "is valid when profile is less than 140 characters" do
    @user1.profile = "a" * 140
    expect(@user1).to be_valid
  end

  it "is invalid when profile is more 141 characters" do
    @user1.profile = "a" * 141
    expect(@user1).to_not be_valid
  end

  it "is valid when password is more 8 characters" do
    @user1.password = @user1.password_confirmation = "a" * 8
    expect(@user1).to be_valid
  end

  it "is invalid when password is less than 7 characters" do
    @user1.password = @user1.password_confirmation = "a" * 7
    expect(@user1).to_not be_valid
  end

  it "is valid with valid email" do
    valid_emails = %w[ user@example.com USER@foo.COM A_US-ER@foo.bar.org
                       first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |valid_email|
      @user1.email = valid_email
      expect(@user1).to be_valid
    end
  end

  it "is invalid with invalid email" do
    invalid_emails = %w[user@example,com user_at_foo.org
      user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_emails.each do |invalid_email|
      @user1.email = invalid_email
      expect(@user1).to_not be_valid
    end
  end

  it "is valid when email is unique" do
    duplicate_user = @user1.dup
    duplicate_user.email = @user1.email.upcase
    expect(duplicate_user).to_not be_valid
  end

  it "follow and unfollow a user" do
    expect(@user1.following?(@user2)).to be_falsey
    @user1.follow(@user2)
    expect(@user1.following?(@user2)).to be_truthy
    expect(@user2.followers.include?(@user1)).to be_truthy
    @user1.unfollow(@user2)
    expect(@user1.following?(@user2)).to be_falsey
  end

  it "can't follow oneself" do
    @user1.follow(@user1)
    expect(@user1.following?(@user1)).to be_falsey
  end

  it "join and leave a group" do
    expect(@user2.joining?(@group)).to be_falsey
    @user2.join(@group)
    expect(@user2.joining?(@group)).to be_truthy
    expect(@group.members.include?(@user2)).to be_truthy
    @user2.leave(@group)
    expect(@user2.joining?(@group)).to be_falsey
  end

  it "can't leave my group" do
    group = @user1.private_groups.create!( name: "テストグループ" )
    @user1.join(group)
    expect(@user1.joining?(group)).to be_truthy
    @user1.leave(group)
    expect(@user1.joining?(group)).to be_truthy
  end

  it "favorite and unfavorite a book" do
    likes_count = @book.likes_count
    expect(@user1.favorite_book?(@book)).to be_falsey
    @user1.favorite_book(@book)
    expect(@user1.favorite_book?(@book)).to be_truthy
    expect(likes_count + 1).to eq(@book.likes_count)
    likes_count = @book.likes_count
    @user1.unfavorite_book(@book)
    expect(@user1.favorite_book?(@book)).to be_falsey
    expect(likes_count - 1).to eq(@book.likes_count)
  end

  it "favorite and unfavorite a worksheet" do
    likes_count = @worksheet.likes_count
    expect(@user1.favorite_worksheet?(@worksheet)).to be_falsey
    @user1.favorite_worksheet(@worksheet)
    expect(@user1.favorite_worksheet?(@worksheet)).to be_truthy
    expect(likes_count + 1).to eq(@worksheet.likes_count)
    likes_count = @worksheet.likes_count
    @user1.unfavorite_worksheet(@worksheet)
    expect(@user1.favorite_worksheet?(@worksheet)).to be_falsey
    expect(likes_count - 1).to eq(@worksheet.likes_count)
  end

end
