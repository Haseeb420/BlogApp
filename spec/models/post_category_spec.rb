# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostCategory, type: :model do
  context 'Associations Tests' do
    it { should have_many(:posts) }
  end

  describe 'Validation Tests' do
    context 'should ensure category name presense' do
      it { should validate_presence_of(:category_name) }
    end

    context 'category name should be unique' do
      it { should validate_uniqueness_of(:category_name).ignoring_case_sensitivity }
    end
  end

  context 'Db Tests' do
    it { should have_db_column(:category_name) }
  end
end
