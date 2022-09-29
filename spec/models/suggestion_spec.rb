# frozen_string_literal: true

require "rails_helper"

RSpec.describe Suggestion, type: :model do
  subject { build(:suggestion) }

  context "Validation Test Cases" do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:post_id) }
  end
  context "Association Test Cases" do
    it { should belong_to(:post) }
  end
  context "Db Test Cases" do
    it { should have_db_column(:body) }
    it { should have_db_column(:post_id) }
  end
end
