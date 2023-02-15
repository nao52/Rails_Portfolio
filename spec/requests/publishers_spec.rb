require 'rails_helper'

RSpec.describe "Publishers", type: :request do

  before do
    @subject         = FactoryBot.create(:subject)
    @club            = FactoryBot.create(:club)
    @kinds_of_school = FactoryBot.create(:kinds_of_school)
    @user            = FactoryBot.create(:user, subject_id: @subject.id,
                                                club_id:  @club.id,
                                                kinds_of_school_id: @kinds_of_school.id)
    @publisher       = FactoryBot.create(:publisher, user_id: @user.id)
    @other_user      = FactoryBot.create(:user, subject_id: @subject.id,
                                                club_id:  @club.id,
                                                kinds_of_school_id: @kinds_of_school.id)
  end

  let(:see_other) { 303 }
  let(:unprocessable_entity) { 422 }

  describe "GET /publishers/index" do
    it "get publishers_index" do
      get publishers_path
      expect(response).to have_http_status(200)
      expect(response).to render_template("publishers/index")
      expect(response.body).to match(title("出版社一覧"))
    end
  end

  describe "Get /publishers/show" do
    it "get publishers_show" do
      get publisher_path(@publisher)
      expect(response).to have_http_status(200)
      expect(response).to render_template("publishers/show")
      expect(response.body).to match(title("#{@publisher.name}"))
    end
  end

  describe "Get /publishers/new" do
    it "get publishers_new as login_user" do
      login_as(@user)
      get new_publisher_path
      expect(response).to have_http_status(200)
      expect(response).to render_template("publishers/new")
      expect(response.body).to match(title("出版社の追加"))
    end

    it "get publishers_new as non_login_user" do
      get new_publisher_path
      redirect_to login_url
      expect(response).to have_http_status(see_other)
    end
  end

  describe "POST /publishers/create" do
    it "is successful create" do
      login_as(@user)
      expect {
        post publishers_path, params: { publisher: { name: "New_Publisher" } }
      }.to change { Publisher.count }.by(1)
      follow_redirect!
      expect(response).to render_template("publishers/index")
      expect(response.body).to match(message("新しい出版社を登録しました！！"))
    end

    it "is unsuccessful create" do
      login_as(@user)
      expect {
        post publishers_path, params: { publisher: { name: "" } }
      }.to_not change { Publisher.count }
      expect(response).to have_http_status(unprocessable_entity)
      expect(response).to render_template("publishers/new")
      expect(response.body).to match(message("出版社の登録に失敗しました..."))
    end

    it "post publishers_create as non_login_user" do
      post publishers_path, params: { publisher: { name: "New_Publisher" } }
      redirect_to login_url
      expect(response).to have_http_status(see_other)
    end
  end

  describe "Get /publishers/edit" do
    it "get publishers_edit as login_user" do
      login_as(@user)
      get edit_publisher_path(@publisher)
      expect(response).to have_http_status(200)
      expect(response).to render_template("publishers/edit")
      expect(response.body).to match(title("出版社名の編集"))
    end

    it "get publishers_edit as non_login_user" do
      get edit_publisher_path(@publisher)
      redirect_to login_url
      expect(response).to have_http_status(see_other)
    end

    it "get publishers_edit as non_correct_user" do
      login_as(@other_user)
      get edit_publisher_path(@publisher)
      redirect_to root_url
      expect(response).to have_http_status(see_other)
    end
  end

  describe "Get /publishers/search" do
    it "shows all publishers when name is empty" do
      get search_publishers_path, params: { name: "" }
      expect(response).to have_http_status(unprocessable_entity)
      expect(response).to render_template("publishers/index")
      expect(response.body).to match(message("出版社名を入力してください"))
    end

    it "shows all publishers when name is invalid" do
      get search_publishers_path, params: { name: "invalid" }
      expect(response).to have_http_status(unprocessable_entity)
      expect(response).to render_template("publishers/index")
      expect(response.body).to match(message("該当する出版社が見つからなかったので、全ての出版社を表示します。"))
    end

    it "shows target publishers when name is valid" do
      FactoryBot.create(:publisher, user_id: @user.id)
      get search_publishers_path, params: { name: "テスト" }
      expect(response).to have_http_status(unprocessable_entity)
      expect(response).to render_template("publishers/index")
      expect(response.body).to match(message("2件の出版社が見つかりました！"))
    end
  end
end
