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
  end

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
end
