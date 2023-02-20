require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.build(:user) }
  let(:michael) { FactoryBot.create(:user, name: "michael") }
  let(:forger) { FactoryBot.create(:user, name: "forger") }

  it "is valid with name, email, password, subject_id, club_id, kinds_of_school_id" do
    expect(user).to be_valid
  end

  it "is invalid without name" do
    user.name = ""
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("名前は必須項目です")
  end

  it "is invalid without email" do
    user.email = ""
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("メールアドレスは必須項目です")
  end

  it "is invalid without subject_id" do
    user.subject_id = nil
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("教科を選択してください")
  end

  it "is invalid without club_id" do
    user.club_id = nil
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("部活動を選択してください")
  end

  it "is invalid without kinds_of_school_id" do
    user.kinds_of_school_id = nil
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("校種を選択してください")
  end

  it "is valid when name is less than 50 characters" do
    user.name = "a" * 50
    expect(user).to be_valid
  end

  it "is invalid when name is more 51 characters" do
    user.name = "a" * 51
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("名前は50文字以内で入力してください")
  end

  it "is valid when email is less than 255 characters" do
    user.email = ("a" * 243) + "@example.com"
    expect(user).to be_valid
  end

  it "is invalid when email is more 256 characters" do
    user.email = ("a" * 244) + "@example.com"
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("メールアドレスは255文字以内で入力してください")
  end

  it "is valid when profile is less than 140 characters" do
    user.profile = "a" * 140
    expect(user).to be_valid
  end

  it "is invalid when profile is more 141 characters" do
    user.profile = "a" * 141
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("プロフィールは140文字以内で入力してください")
  end

  it "is valid when password is more 8 characters" do
    user.password = user.password_confirmation = "a" * 8
    expect(user).to be_valid
  end

  it "is invalid when password is less than 7 characters" do
    user.password = user.password_confirmation = "a" * 7
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("パスワードは8文字以上で入力してください")
  end

  it "is valid when password is less than 16 characters" do
    user.password = user.password_confirmation = "a" * 16
    expect(user).to be_valid
  end

  it "is invalid when password is more 17 characters" do
    user.password = user.password_confirmation = "a" * 17
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("パスワードは16文字以内で入力してください")
  end

  it "is valid with valid email" do
    valid_emails = %w[ user@example.com USER@foo.COM A_US-ER@foo.bar.org
                       first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |valid_email|
      user.email = valid_email
      expect(user).to be_valid
    end
  end

  it "is invalid with invalid email" do
    invalid_emails = %w[user@example,com user_at_foo.org
      user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_emails.each do |invalid_email|
      user.email = invalid_email
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("メールアドレスの形式が不正です")
    end
  end

  it "is invalid when email is unique" do
    duplicate_user = michael.dup
    duplicate_user.email = michael.email.upcase
    expect(duplicate_user).to_not be_valid
    expect(duplicate_user.errors.full_messages).to include("メールアドレスはすでに存在します")
  end

  it "follow and unfollow a user" do
    expect(michael.following?(forger)).to be_falsey
    michael.follow(forger)
    expect(michael.following?(forger)).to be_truthy
    expect(forger.followers.include?(michael)).to be_truthy
    michael.unfollow(forger)
    expect(michael.following?(forger)).to be_falsey
  end

  it "can't follow oneself" do
    michael.follow(michael)
    expect(michael.following?(michael)).to be_falsey
  end

  it "join and leave a group" do
    group = FactoryBot.create(:private_group, user_id: michael.id)
    expect(forger.joining?(group)).to be_falsey
    forger.join(group)
    expect(forger.joining?(group)).to be_truthy
    expect(group.members.include?(forger)).to be_truthy
    forger.leave(group)
    expect(forger.joining?(group)).to be_falsey
  end

  it "can't leave my group" do
    group = michael.private_groups.create!( name: "テストグループ" )
    michael.join(group)
    expect(michael.joining?(group)).to be_truthy
    michael.leave(group)
    expect(michael.joining?(group)).to be_truthy
  end

  it "favorite and unfavorite a book" do
    publisher = FactoryBot.create(:publisher, user_id: michael.id)
    book      = FactoryBot.create(:reference_book, user_id: michael.id, publisher_id: publisher.id)
    likes_count = book.likes_count
    expect(michael.favorite_book?(book)).to be_falsey
    michael.favorite_book(book)
    expect(michael.favorite_book?(book)).to be_truthy
    expect(likes_count + 1).to eq(book.likes_count)
    likes_count = book.likes_count
    michael.unfavorite_book(book)
    expect(michael.favorite_book?(book)).to be_falsey
    expect(likes_count - 1).to eq(book.likes_count)
  end

  it "favorite and unfavorite a worksheet" do
    worksheet = FactoryBot.create(:worksheet, user_id: michael.id)
    likes_count = worksheet.likes_count
    expect(michael.favorite_worksheet?(worksheet)).to be_falsey
    michael.favorite_worksheet(worksheet)
    expect(michael.favorite_worksheet?(worksheet)).to be_truthy
    expect(likes_count + 1).to eq(worksheet.likes_count)
    likes_count = worksheet.likes_count
    michael.unfavorite_worksheet(worksheet)
    expect(michael.favorite_worksheet?(worksheet)).to be_falsey
    expect(likes_count - 1).to eq(worksheet.likes_count)
  end

end
