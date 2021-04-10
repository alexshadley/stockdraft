require "test_helper"

class RoundControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get round_create_url
    assert_response :success
  end

  test "should get show" do
    get round_show_url
    assert_response :success
  end

  test "should get draft" do
    get round_draft_url
    assert_response :success
  end
end
