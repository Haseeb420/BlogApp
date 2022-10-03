# frozen_string_literal: true

require "rails_helper"

RSpec.describe CommentLike, type: :model do
  context "Validation Test Cases" do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:comment_id) }
  end

  context "Association Test Cases" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:comment) }
  end

  context "DB Test Cases" do
    context "Db Table Column Testing" do
      it { is_expected.to have_db_column(:user_id) }
      it { is_expected.to have_db_column(:comment_id) }
    end

    context "Db Index Testing" do
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to have_db_index(:comment_id) }
    end
  end
end
