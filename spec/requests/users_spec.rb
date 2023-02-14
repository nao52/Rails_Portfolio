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

  let(:see_other) { 303 }
  let(:unprocessable_entity) { 422 }

  describe "GET /users" do
    it "get users_index" do
      get users_path
      expect(response).to have_http_status(200)
      expect(response).to render_template("users/index")
      expect(response.body).to match(title("ユーザー一覧"))
    end
  end

  describe "Get /users/show" do
    it "get users_show" do
      get user_path(@user)
      expect(response).to have_http_status(200)
      expect(response).to render_template("users/show")
      expect(response.body).to match(title(@user.name))
    end
  end

  describe "Get /users/new" do
    it "get signup" do
      get signup_path
      expect(response).to have_http_status(200)
      expect(response).to render_template("users/new")
      expect(response.body).to match(title("新規ユーザー登録"))
    end
  end

  describe "Post /users/create" do
    it "is successful signup" do
      expect {
        post signup_path, params: { user: { name:   "Example User",
                                            email:  "user@example.com",
                                            password:               "password",
                                            password_confirmation:  "password",
                                            subject_id:           @subject.id,
                                            club_id:              @club.id,
                                            kinds_of_school_id:   @kinds_of_school.id } }
      }.to change { User.count }.by(1)
      expect(is_logged_in?).to be_truthy
      follow_redirect!
      expect(response.body).to match(title("ユーザー一覧"))
      expect(response.body).to match(message("ユーザーの新規登録を行いました！"))
    end

    it "is unsuccessful signup" do
      expect {
        post signup_path, params: { user: { name:   "",
                                            email:  "",
                                            password:               "",
                                            password_confirmation:  "",
                                            subject_id:           nil,
                                            club_id:              nil,
                                            kinds_of_school_id:   nil } }
        }.to_not change { User.count }
      expect(response).to have_http_status(unprocessable_entity)
      expect(response).to render_template("users/new")
      expect(response.body).to match(message("ユーザー登録に失敗しました..."))
    end
  end

  describe "Get /users/edit" do
    it "get users_edit as login_user" do
      login_as(@user)
      follow_redirect!
      get edit_user_path(@user)
      expect(response).to have_http_status(200)
      expect(response).to render_template("users/edit")
      expect(response.body).to match(title("ユーザー情報の編集"))
    end

    it "get users_edit as non_login_user" do
      get edit_user_path(@user)
      redirect_to login_url
      expect(response).to have_http_status(see_other)
    end
  end

  describe "PATCH /users/update" do
    it "is succcessful edit" do
      login_as(@user)
      patch user_path(@user), params: { user: { name:   "Update User",
                                                email:  "update@example.com",
                                                password:               "",
                                                password_confirmation:  "",
                                                subject_id:           @subject.id,
                                                club_id:              @club.id,
                                                kinds_of_school_id:   @kinds_of_school.id } }
      follow_redirect!
      expect(response.body).to match(title("Update User"))
      expect(response.body).to match(message("ユーザーの編集に成功しました！"))
    end

    it "is unsuccessful edit" do
      login_as(@user)
      patch user_path(@user), params: { user: { name:   "",
                                                email:  "invalid@aaa",
                                                password:               "pass",
                                                password_confirmation:  "word",
                                                subject_id:           nil,
                                                club_id:              nil,
                                                kinds_of_school_id:   nil } }
      expect(response).to have_http_status(unprocessable_entity)
      expect(response).to render_template("users/edit")
      expect(response.body).to match(message("ユーザーの編集に失敗しました..."))
    end

    it "can't edit as non_login_user" do
      patch user_path(@user), params: { user: { name:   "Update User",
                                                email:  "update@example.com",
                                                password:               "",
                                                password_confirmation:  "",
                                                subject_id:           @subject.id,
                                                club_id:              @club.id,
                                                kinds_of_school_id:   @kinds_of_school.id } }
      redirect_to login_url
      expect(response).to have_http_status(see_other)
    end
  end

  describe "Get /users/following" do
    it "get users_following" do
      get following_user_path(@user)
      expect(response).to have_http_status(unprocessable_entity)
      expect(response).to render_template("users/show_follow")
      expect(response.body).to match(title("#{@user.name}のフォロー"))
    end
  end

  describe "Get /users/followers" do
    it "get users_followers" do
      get followers_user_path(@user)
      expect(response).to have_http_status(unprocessable_entity)
      expect(response).to render_template("users/show_follow")
      expect(response.body).to match(title("#{@user.name}のフォロワー"))
    end
  end

  describe "Get /users/joinings" do
    it "get users_joinings" do
      get joinings_user_path(@user)
      expect(response).to have_http_status(200)
      expect(response).to render_template("users/joinings")
      expect(response.body).to match(title("#{@user.name}の所属グループ一覧"))
    end
  end

  describe "Get /users/worksheets" do
    it "get users_worksheets" do
      get worksheets_user_path(@user)
      expect(response).to have_http_status(200)
      expect(response).to render_template("users/worksheets")
      expect(response.body).to match(title("#{@user.name}のワークシート一覧"))
    end
  end

  describe "Get /users/favorite_books" do
    it "get users_favorite_books" do
      get favorite_books_user_path(@user)
      expect(response).to have_http_status(200)
      expect(response).to render_template("users/favorite_books")
      expect(response.body).to match(title("#{@user.name}のお気に入り書籍一覧"))
    end
  end

  describe "Get /users/favorite_worksheets" do
    it "get users_favorite_worksheets" do
      get favorite_worksheets_user_path(@user)
      expect(response).to have_http_status(200)
      expect(response).to render_template("users/favorite_worksheets")
      expect(response.body).to match(title("#{@user.name}のお気に入りワークシート一覧"))
    end
  end

end
