require 'rails_helper'

RSpec.describe "Users", type: :request do

  before do
    @subject         = FactoryBot.create(:subject)
    @club            = FactoryBot.create(:club)
    @kinds_of_school = FactoryBot.create(:kinds_of_school)
    @user            = FactoryBot.create(:user, subject_id: @subject.id,
                                                club_id:  @club.id,
                                                kinds_of_school_id: @kinds_of_school.id)
  end

  describe "GET /users" do
    it "get users_index" do
      get users_path
      expect(response).to have_http_status(200)
      expect(response.body).to match(/<title>ユーザー一覧<\/title>/i)
    end
  end

  describe "Get /users/:id" do
    it "get users_show" do
      get user_path(@user)
      expect(response).to have_http_status(200)
      expect(response.body).to match(/<title>#{@user.name}<\/title>/i)
    end
  end

  describe "Get /users/new" do
    it "get users_new" do
      get new_user_path
      expect(response).to have_http_status(200)
      expect(response.body).to match(/<title>新規ユーザー登録<\/title>/i)
    end
  end

  # describe "Get /users/edit" do
  #   it "get users_edit" do
  #     login(@user)
  #     get edit_user_path(@user)
  #     expect(response).to have_http_status(200)
  #   end
  # end

end
