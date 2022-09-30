# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

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
end
