require 'rails_helper'

RSpec.feature "UsersSignups", type: :feature do

  before do
    Subject.create!( name: "国語" )
    Subject.create!( name: "数学" )
    Subject.create!( name: "英語" )
    Club.create!( name: "野球" )
    Club.create!( name: "サッカー" )
    Club.create!( name: "テニス" )
    KindsOfSchool.create!( name: "私立/中学" )
    KindsOfSchool.create!( name: "私立/高校" )
    KindsOfSchool.create!( name: "私立/中学高校" )
  end

  describe "create a new user" do
    context "valid information" do
      scenario "is successful" do
        visit root_path
    
        expect {
    
          click_link "新規登録"
      
          fill_in "user[name]",                  with: "テストユーザー"
          fill_in "user[email]",                 with: "test_example@example.com"
          fill_in "user[password]",              with: "password"
          fill_in "user[password_confirmation]", with: "password"
          select  "英語",          from: "担当教科"
          select  "野球",          from: "担当部活動"
          select  "私立/中学高校", from: "校種"
          click_button "新規ユーザー登録"
    
        }.to change{ User.count }.by(1) && change { current_path }.to(users_path)

        expect(page).to have_text("ユーザーの新規登録を行いました！")
        expect(page).to have_content("テストユーザーでログイン中")
      end
    end

    context "invalid information" do
      scenario "is failure" do
        visit root_path
    
        expect {
    
          click_link "新規登録"
      
          fill_in "user[name]",                  with: ""
          fill_in "user[email]",                 with: ""
          fill_in "user[password]",              with: ""
          fill_in "user[password_confirmation]", with: ""
          click_button "新規ユーザー登録"
    
        }.to_not change{ User.count }

        expect(page).to have_text("ユーザー登録に失敗しました...")
      end
    end
  end


end
