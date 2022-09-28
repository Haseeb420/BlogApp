# frozen_string_literal: true

require "rails_helper"

RSpec.describe PostCategory, type: :model do
  context "Validation Tests" do
    context "ensure category name presense" do
      it { should validate_presence_of(:category_name) }
    end
    it "ensure category name uniqueness" do
      create(:post_category).save
      @post_category = build(:post_category).save
      expect(@post_category).to eq(false)
    end
  end

  context "Associations Testing" do
    it { should have_many(:posts) }
  end

  context "Db Testing" do
    it { should have_db_column(:category_name) }
  end
end
