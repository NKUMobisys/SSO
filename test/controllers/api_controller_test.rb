require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get query_user" do
    get api_query_user_url
    assert_response :success
  end

  test "should get query_all_user" do
    get api_query_all_user_url
    assert_response :success
  end

end
