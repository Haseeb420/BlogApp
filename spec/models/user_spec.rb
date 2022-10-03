# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  let(:user1) { create(:user, email: "user1@gmail.com") }
  let(:user2) { create(:user, email: "user2@gmail.com") }
  let(:user3) { create(:user, email: "user3@gmail.com") }
  let(:category) { create(:post_category) }
  let(:post1) { create(:post, user_id: user1.id, post_category_id: category.id, status: "approved") }
  let(:post2) { create(:post, user_id: user1.id, post_category_id: category.id, status: "approved") }

  context "Validation Test cases" do
    context "presense of All fields" do
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:last_name) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }

      it "profile img expected to be attached" do
        expect(subject.profile_img.attached?).to be(true)
      end
    end

    context "email uniquessness Validation" do
      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end

    context "enum validation" do
      it { is_expected.to define_enum_for(:user_role).with_values(%i[user admin moderator]) }
      it { is_expected.to allow_value("user", "admin", "moderator").for(:user_role) }
    end
  end

  context "Association Test Cases" do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_one(:post_like) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_one(:comment_like) }
    it { is_expected.to have_many(:reported_posts) }
    it { is_expected.to have_one_attached(:profile_img) }
  end

  context "DB Test Cases" do
    context "Db Table Columns Testing" do
      it { is_expected.to have_db_column(:first_name) }
      it { is_expected.to have_db_column(:last_name) }
      it { is_expected.to have_db_column(:email) }
    end

    context "Index Column Testing" do
      it { is_expected.to have_db_index(:email) }
    end
  end


  context "Scopes Test Cases" do
    it "Matches recently added users" do
      expect(described_class.recents_week_users).to contain_exactly(user1, user2, user3)
    end
  end


  context "Methods Test Cases" do
    it "Users all post" do
      expect(user1.user_all_post).to contain_exactly(post1, post2)
    end
  end
end
