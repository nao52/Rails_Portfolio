require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  describe "GET /login" do
    it "render new" do
      get '/login'
      expect(response).to have_http_status(200)
    end
  end

end
