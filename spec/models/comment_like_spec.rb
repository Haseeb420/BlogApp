# frozen_string_literal: true

require "rails_helper"

RSpec.describe CommentLike, type: :model do
  context "Validation Test Cases" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:comment_id) }
  end

  context "Association Test Cases" do
    it { should belong_to(:user) }
    it { should belong_to(:comment) }
  end

  context "DB Test Cases" do
    it { should have_db_column(:user_id) }
    it { should have_db_column(:comment_id) }
  end
end
