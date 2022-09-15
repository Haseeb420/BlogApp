# frozen_string_literal: true

require "test_helper"

class ReportedPostControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reported_post_index_url
    assert_response :success
  end

  test "should get new" do
    get reported_post_new_url
    assert_response :success
  end
end
