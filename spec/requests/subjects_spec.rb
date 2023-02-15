require 'rails_helper'

RSpec.describe "Subjects", type: :request do

  before do
    @subject = FactoryBot.create(:subject)
  end

  describe "GET /subjects/index" do
    it "get subjects_index" do
      get subjects_path
      expect(response).to have_http_status(200)
      expect(response).to render_template("subjects/index")
      expect(response.body).to match(title("教科一覧"))
    end
  end

  describe "Get /subjects/show" do
    it "get subjects_show" do
      get subject_path(@subject)
      expect(response).to have_http_status(200)
      expect(response).to render_template("subjects/show")
      expect(response.body).to match(title(@subject.name))
    end
  end

  describe "Get /subjects/members" do
    it "get subjects_members" do
      get members_subject_path(@subject)
      expect(response).to have_http_status(200)
      expect(response).to render_template("subjects/members")
      expect(response.body).to match(title(@subject.name))
    end
  end
end
