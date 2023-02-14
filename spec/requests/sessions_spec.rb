require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  before do
    @subject         = FactoryBot.create(:subject)
    @club            = FactoryBot.create(:club)
    @kinds_of_school = FactoryBot.create(:kinds_of_school)
    @user            = FactoryBot.create(:user, subject_id: @subject.id,
                                                club_id:  @club.id,
                                                kinds_of_school_id: @kinds_of_school.id)
  end

  let(:unprocessable_entity) { 422 }
  let(:see_other) { 303 }

  describe "GET /login" do
    it "render new" do
      get login_path
      expect(response).to have_http_status(200)
      expect(response).to render_template("sessions/new")
      expect(response.body).to match(title("ログイン"))
    end
  end

  describe "POST /login" do
    it "login with valid information" do
      post login_path, params: { session: { email:    @user.email,
                                            password: 'password' } }
      expect(is_logged_in?).to be_truthy
      redirect_to users_url
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response).to render_template("users/index")
      expect(response.body).to match(message("ログインに成功しました！"))
    end

    it "login with invalid information" do
      post login_path, params: { session: { email: "", password: "" } }
      expect(response).to have_http_status(unprocessable_entity)
      expect(response).to render_template("sessions/new")
      expect(response.body).to match(message("ログインに失敗しました..."))
      get root_path
      expect(flash.empty?).to be_truthy
    end

    it "redirected forwarding_url" do
      get edit_user_path(@user)
      redirect_to login_url
      follow_redirect!
      expect(response.body).to match(message("ログインしてください"))
      login_as(@user)
      redirect_to edit_user_url(@user)
      follow_redirect!
      expect(response).to render_template("users/edit")
    end
  end

  describe "DELETE /logout" do
    it "redirected login" do
      login_as(@user)
      expect(is_logged_in?).to be_truthy
      delete logout_path
      expect(is_logged_in?).to be_falsey
      redirect_to login_url
      expect(response).to have_http_status(see_other)
      follow_redirect!
      expect(response.body).to match(message("ログアウトしました"))
    end
  end

end
