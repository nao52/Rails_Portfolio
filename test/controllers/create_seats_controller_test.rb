require "test_helper"

class CreateSeatsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get create_seats_show_url
    assert_response :success
  end
end
