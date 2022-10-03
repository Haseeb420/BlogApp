# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReportedPost, type: :model do
  subject { build(:reported_post) }

  context "Validation Test Cases" do
    it { is_expected.to validate_presence_of(:reason) }
    it { is_expected.to validate_presence_of(:post_id) }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  context "Association Test Cases" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  describe "Db Test Cases" do
    context "DB Column Testing" do
      it { is_expected.to have_db_column(:reason) }
      it { is_expected.to have_db_column(:user_id) }
      it { is_expected.to have_db_column(:post_id) }
    end

    context "Index Column Testing" do
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to have_db_index(:post_id) }
    end
  end
end
