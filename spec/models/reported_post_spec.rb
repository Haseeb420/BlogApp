# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReportedPost, type: :model do
  subject { build(:reported_post) }

  context "Validation Test Cases" do
    it { should validate_presence_of(:reason) }
    it { should validate_presence_of(:post_id) }
    it { should validate_presence_of(:user_id) }
  end
  context "Association Test Cases" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
  context "Db Test Cases" do
    it { should have_db_column(:reason) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:post_id) }
    it { should have_db_index(:user_id) }
    it { should have_db_index(:post_id) }
  end
end
