# frozen_string_literal: true

require "rails_helper"

RSpec.describe PostLike, type: :model do
  context "Validation Testing" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:post_id) }
  end

  context "Association Testing" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  context "DB Testing" do
    context "Column Testing" do
      it { should have_db_column(:user_id) }
      it { should have_db_column(:post_id) }
    end
    context "Index Testing" do
      it { should have_db_index(:user_id) }
      it { should have_db_index(:post_id) }
    end
  end
end
