# frozen_string_literal: true

require "rails_helper"

RSpec.describe PostCategory, type: :model do
  context "Validation Tests" do
    it "ensure category name presense" do
      @post_category = build(:post_category, category_name: nil).save
      expect(@post_category).to eq(false)
    end
    it "ensure category name uniqueness" do
      create(:post_category).save
      @post_category = build(:post_category).save
      expect(@post_category).to eq(false)
    end
  end
end
