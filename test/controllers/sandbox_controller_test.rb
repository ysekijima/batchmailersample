require 'test_helper'

class SandboxControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sandbox_index_url
    assert_response :success
  end

  test "should get post1" do
    get sandbox_post1_url
    assert_response :success
  end

  test "should get post2" do
    get sandbox_post2_url
    assert_response :success
  end

end
