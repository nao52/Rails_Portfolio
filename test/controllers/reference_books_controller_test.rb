require "test_helper"

class ReferenceBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reference_books_index_url
    assert_response :success
  end

  test "should get new" do
    get reference_books_new_url
    assert_response :success
  end

  test "should get edit" do
    get reference_books_edit_url
    assert_response :success
  end
end
