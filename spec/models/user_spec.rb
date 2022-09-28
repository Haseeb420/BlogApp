# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  # let!(:object) { FactoryBot.create(:user) }
  subject { build(:user) }
  context "Validation Test cases" do
    context "presense of All fields" do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
    end

    context "enum validation" do
      it { should define_enum_for(:user_role).with_values([:user, :admin, :moderator]) }
      it { should allow_value("user", "admin", "moderator").for(:user_role) }
    end
  end

  context "Association Test Cases" do
    it { should have_many(:posts) }
    it { should have_one(:post_like) }
    it { should have_many(:comments) }
    it { should have_one(:comment_like) }
    it { should have_many(:reported_posts) }
  end

  context "DB Test Cases" do
    it { should have_db_column(:first_name) }
    it { should have_db_column(:last_name) }
    it { should have_db_column(:email) }
    it { is_expected.to have_db_index(:email) }
  end
end
