require 'rails_helper'

RSpec.describe Seat, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  let(:seat) { FactoryBot.build(:seat, user_id: @user.id) }

  it "is valid witn seat_no and student_name" do
    expect(seat).to be_valid
  end

  it "is invalid without seat_no" do
    seat.seat_no = ""
    expect(seat).to_not be_valid
    expect(seat.errors.full_messages).to include("座席番号は必須項目です")
  end

  it "is invalid without student_name" do
    seat.student_name = ""
    expect(seat).to_not be_valid
    expect(seat.errors.full_messages).to include("生徒名は必須項目です")
  end

  it "is invalid when seat_no is zero" do
    seat.seat_no = 0
    expect(seat).to_not be_valid
    expect(seat.errors.full_messages).to include("座席番号は0より大きい値にしてください")
  end

  it "is invalid when seat_no is less than 0" do
    seat.seat_no = -1
    expect(seat).to_not be_valid
    expect(seat.errors.full_messages).to include("座席番号は0より大きい値にしてください")
  end

  it "is invalid when seat_no is not integer" do
    seat.seat_no = 1.5
    expect(seat).to_not be_valid
    expect(seat.errors.full_messages).to include("座席番号は整数で入力してください")
  end

  it "is valid when student_name is less than 50 characters" do
    seat.student_name = "a" * 50
    expect(seat).to be_valid
  end

  it "is invalid when student_name is more 51 characters" do
    seat.student_name = "a" * 51
    expect(seat).to_not be_valid
    expect(seat.errors.full_messages).to include("生徒名は50文字以内で入力してください")
  end

end