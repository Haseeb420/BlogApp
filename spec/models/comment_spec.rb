# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  context "Validation Test Cases" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:post_id) }
    it { should validate_presence_of(:body) }
  end

  context "Association Test Cases" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
    it { should have_many(:comment_likes) }
    it { should have_many(:replies) }
  end

  context "Db Test Cases" do
    it { should have_db_column(:user_id) }
    it { should have_db_column(:post_id) }
    it { should have_db_column(:parent_id) }
    it { should have_db_column(:body) }
    it { should have_db_column(:commented_on) }
  end
end
