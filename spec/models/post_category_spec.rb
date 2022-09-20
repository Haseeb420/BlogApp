# frozen_string_literal: true

require "rails_helper"

RSpec.describe PostCategory, type: :model do
  subject {
     described_class.new(category_name: "category1")
   }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
