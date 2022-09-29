# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }
  context "Validation Test cases" do
    context "presense of All fields" do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
      it "profile img expected to be attached" do
        expect(subject.profile_img).to be_attached
      end
    end
    context "email uniquessness Validation" do
      it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end

    context "enum validation" do
      it { should define_enum_for(:user_role).with_values([:user, :admin, :moderator]) }
      it { should allow_value("user", "admin", "moderator").for(:user_role) }
    end
  end

  context "Scopes Test Cases" do
    it "Matches recently added users" do
      @user1 = create(:user, email: "user1@gmail.com")
      @user2 = create(:user, email: "user2@gmail.com")
      @user3 = create(:user, email: "user3@gmail.com")
      expect(User.recents_week_users).to contain_exactly(@user1, @user2, @user3)
    end
  end


  context "Association Test Cases" do
    it { should have_many(:posts) }
    it { should have_one(:post_like) }
    it { should have_many(:comments) }
    it { should have_one(:comment_like) }
    it { should have_many(:reported_posts) }
    it { should have_one_attached(:profile_img) }
  end

  context "DB Test Cases" do
    it { should have_db_column(:first_name) }
    it { should have_db_column(:last_name) }
    it { should have_db_column(:email) }
    it { is_expected.to have_db_index(:email) }
  end
end
