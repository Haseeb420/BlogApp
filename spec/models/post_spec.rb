# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, type: :model do
  subject { build(:post) }

  let!(:user) { create(:user) }
  let!(:category) { create(:post_category) }
  let!(:post1) { create(:post, user_id: user.id, post_category_id: category.id, status: "approved") }
  let!(:post1_like) { create(:post_like, user_id: user.id, post_id: post1.id) }

  describe "Validation test" do
    subject { build(:post) }

    context "Title Testcases" do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_length_of(:title) }
    end

    context "Body Testcases" do
      it { is_expected.to validate_presence_of(:body) }
      it { is_expected.to validate_length_of(:body) }
    end

    context "Header Image Testcases" do
      it { expect(subject.header_img.attached?).to be(true) }
    end

    context "post category id" do
      it "ensure post category id presense" do
        @post = build(:post, post_category_id: nil).save
        expect(@post).to be(false)
      end
    end

    context "Post Status test cases" do
      it "Ensures In validation" do
        @post = build(:post, status: "not_approved").save
        expect(@post).to be(false)
      end
    end
  end

  context "Association Testing" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post_category) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:post_likes) }
    it { is_expected.to have_many(:suggestions) }
    it { is_expected.to have_many(:reported_posts) }
  end

  describe "Db Testing" do
    context "Db Columns Testing" do
      it { is_expected.to have_db_column(:title) }
      it { is_expected.to have_db_column(:body) }
      it { is_expected.to have_db_column(:published_date) }
      it { is_expected.to have_db_column(:user_id) }
      it { is_expected.to have_db_column(:post_category_id) }
    end

    context "Index Columns Testing" do
      it { is_expected.to have_db_index(:title) }
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to have_db_index(:post_category_id) }
    end
  end

  context "Scopes Test Cases" do
    it "returns post in decending order of published date" do
      expect(described_class.ordered).to eq(described_class.order(published_date: :desc))
    end

    it "returns last week post" do
      expect(described_class.recents_week_post).to match_array(described_class.where("created_at > ?",
                                                                                     Time.zone.now - 7.days))
    end

    it "returns all approved post" do
      expect(described_class.all_posts).to match_array(described_class.all)
    end
  end

  context "Post Method Test Cases" do
    it "add user like" do
      post1.add_post_like(user.id)
      expect(post1.user_post_like_exists?(user.id)).to be(true)
    end
    it "checks user like exists" do
      expect(subject.user_post_like_exists?(user.id)).to be(false)
    end

    it "Delete current user Post like" do
      post1.delete_user_post_like(user.id)
      expect(post1.user_post_like_exists?(user.id)).to be(false)
    end
  end
end
