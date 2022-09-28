# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, type: :model do
  context "Validation test" do
    subject { build(:post) }
    context "Title Testcases" do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title) }
    end

    context "Body Testcases" do
      it { should validate_presence_of(:body) }
      it { should validate_length_of(:body) }
    end

    context "header img" do
      it "ensure header img presense" do
        @post = build(:post, header_img: nil).save
        expect(@post).to eq(false)
      end
    end

    context "post category id" do
      it "ensure post category id presense" do
        @post = build(:post, post_category_id: nil).save
        expect(@post).to eq(false)
      end
    end

    context "Post Status test cases" do
      it "Ensures In validation" do
        @post = build(:post, status: "not_approved").save
        expect(@post).to eq(false)
      end
    end
  end

  context "association Testing" do
    it { should belong_to(:user) }
    it { should belong_to(:post_category) }
  end
end
