# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, type: :model do
  subject { build(:post) }

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

    context "Header Image Testcases" do
      it { expect(subject.header_img).to be_attached }
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

  context "Association Testing" do
    it { should belong_to(:user) }
    it { should belong_to(:post_category) }
    it { should have_many(:comments) }
    it { should have_many(:post_likes) }
    it { should have_many(:suggestions) }
    it { should have_many(:reported_posts) }
  end

  context "Db Testing" do
    context "Db Columns Testing" do
      it { should have_db_column(:title) }
      it { should have_db_column(:body) }
      it { should have_db_column(:published_date) }
      it { should have_db_column(:user_id) }
      it { should have_db_column(:post_category_id) }
    end

    context "Index Columns Testing" do
      it { should have_db_index(:title) }
      it { should have_db_index(:user_id) }
      it { should have_db_index(:post_category_id) }
    end
  end
end
