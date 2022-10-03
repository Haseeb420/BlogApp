# frozen_string_literal: true

require "rails_helper"

RSpec.describe Suggestion, type: :model do
  subject { build(:suggestion) }

  context "Validation Test Cases" do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:post_id) }
  end

  context "Association Test Cases" do
    it { is_expected.to belong_to(:post) }
  end

  context "Db Test Cases" do
    context "DB Columns Testing" do
      it { is_expected.to have_db_column(:body) }
      it { is_expected.to have_db_column(:post_id) }
    end

    context "Index Column Testing" do
      it { is_expected.to have_db_index(:post_id) }
    end
  end
end
