# frozen_string_literal: true

require "rails_helper"

RSpec.describe PostCategory, type: :model do
  describe "validations" do
    describe "category name" do
      it "must be present" do
        @category = PostCategory.new(category_name: "category_name")
      end
    end
  end
  subject {
     described_class.new(category_name: "category1")
   }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
