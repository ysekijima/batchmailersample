require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get post1" do
    get home_post1_url
    assert_response :success
  end

  test "should get post2" do
    get home_post2_url
    assert_response :success
  end

end
