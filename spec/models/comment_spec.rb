# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, type: :model do
  subject { build(:comment) }
  let(:user) { create(:user) }
  let(:category) { create(:post_category) }
  let(:post1) { create(:post, user_id: user.id, post_category_id: category.id, status: "approved") }
  let(:comment1) { FactoryBot.create(:comment, post_id: post1.id, user_id: user.id) }
  context "Validation Test Cases" do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:post_id) }
    it { is_expected.to validate_presence_of(:body) }
  end
  context "Association Test Cases" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
    it { is_expected.to have_many(:comment_likes) }
    it { is_expected.to have_many(:replies) }
  end

  context "Db Test Cases" do
    context "Db Table Column Testing" do
      it { is_expected.to have_db_column(:user_id) }
      it { is_expected.to have_db_column(:post_id) }
      it { is_expected.to have_db_column(:parent_id) }
      it { is_expected.to have_db_column(:body) }
      it { is_expected.to have_db_column(:commented_on) }
    end

    context "Db Index Testing" do
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to have_db_index(:post_id) }
    end
  end

  context "Testing Model Methods" do
    it "User comment like exists" do
      expect(subject.user_comment_like_exists?(user.id)).to be(false)
    end

    it "Add User comment like" do
      comment1.add_user_comment_like(user.id)
      expect(comment1.user_comment_like_exists?(user.id)).to be(true)
    end


    it "Add User comment like" do
      comment1.add_user_comment_like(user.id)
      comment1.delete_user_comment_like(user.id)
      expect(comment1.user_comment_like_exists?(user.id)).to be(false)
    end
  end
end
