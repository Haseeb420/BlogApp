# frozen_string_literal: true

require "test_helper"

class PostCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "valid post category" do
    post_category = PostCategory.new(category_name: "category1")
    assert post_category.valid?
  end
end
