# frozen_string_literal: true

require "rails_helper"

RSpec.describe PostCategory, type: :model do
  describe "Validation Tests" do
    context "ensure category name presense" do
      it { is_expected.to validate_presence_of(:category_name) }
    end

    context "Category name uniquessness Validation" do
      it { is_expected.to validate_uniqueness_of(:category_name).ignoring_case_sensitivity }
    end
  end

  context "Associations Testing" do
    it { is_expected.to have_many(:posts) }
  end

  context "Db Testing" do
    it { is_expected.to have_db_column(:category_name) }
  end
end
