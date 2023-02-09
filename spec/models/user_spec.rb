require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    FactoryBot.create(:subject)
    FactoryBot.create(:club)
    FactoryBot.create(:kinds_of_school)
  end

  it "is valid with name, email, password, subject_id, club_id, kinds_of_school_id" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without name" do
    expect(FactoryBot.build(:user, name: "")).to_not be_valid
  end

  it "is invalid without email" do
    expect(FactoryBot.build(:user, email: "")).to_not be_valid
  end

  it "is invalid without password" do
    expect(FactoryBot.build(:user, password: "")).to_not be_valid
  end

  it "is invalid without subject_id" do
    expect(FactoryBot.build(:user, subject_id: nil)).to_not be_valid
  end

  it "is invalid without club_id" do
    expect(FactoryBot.build(:user, club_id: nil)).to_not be_valid
  end

  it "is invalid without kinds_of_school_id" do
    expect(FactoryBot.build(:user, kinds_of_school_id: nil)).to_not be_valid
  end

  it "is valid when name is less than 50 characters" do
    valid_name = "a" * 50
    expect(FactoryBot.build(:user, name: valid_name)).to be_valid
  end

  it "is invalid when name is more 51 characters" do
    invalid_name = "a" * 51
    expect(FactoryBot.build(:user, name: invalid_name)).to_not be_valid
  end

  it "is valid when email is less than 255 characters" do
    valid_email = ("a" * 243) + "@example.com"
    expect(FactoryBot.build(:user, email: valid_email)).to be_valid
  end

  it "is invalid when email is more 256 characters" do
    invalid_email = ("a" * 244) + "@example.com"
    expect(FactoryBot.build(:user, email: invalid_email)).to_not be_valid
  end

  it "is valid when profile is less than 140 characters" do
    valid_profile = "a" * 140
    expect(FactoryBot.build(:user, profile: valid_profile)).to be_valid
  end

  it "is invalid when profile is more 141 characters" do
    invalid_profile = "a" * 141
    expect(FactoryBot.build(:user, profile: invalid_profile)).to_not be_valid
  end

  it "is valid when password is more 8 characters" do
    valid_password = "a" * 8
    expect(FactoryBot.build(:user, password: valid_password)).to be_valid
  end

  it "is invalid when password is less than 7 characters" do
    invalid_password = "a" * 7
    expect(FactoryBot.build(:user, password: invalid_password)).to_not be_valid
  end

  it "is valid with valid email" do
    valid_emails = %w[ user@example.com USER@foo.COM A_US-ER@foo.bar.org
                       first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |valid_email|
      expect(FactoryBot.build(:user, email: valid_email)).to be_valid
    end
  end

  it "is invalid with invalid email" do
    invalid_addresses = %w[user@example,com user_at_foo.org
      user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_email|
      expect(FactoryBot.build(:user, email: invalid_email)).to_not be_valid
    end
  end

end
