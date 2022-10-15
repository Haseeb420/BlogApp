# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostCategory, type: :model do
  context 'Associations Tests' do
    it { is_expected.to have_many(:posts) }
  end

  describe 'Validation Tests' do
    context 'should ensure category name presense' do
      it { is_expected.to validate_presence_of(:category_name) }
    end

    context 'category name should be unique' do
      it { is_expected.to validate_uniqueness_of(:category_name).ignoring_case_sensitivity }
    end
  end

  context 'Db Tests' do
    it { is_expected.to have_db_column(:category_name) }
  end
end
