# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  subject { build(:suggestion) }

  context 'Association tests' do
    it { is_expected.to belong_to(:post) }
  end

  context 'Validation tests' do
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'sopes tests' do
    context 'should return all suggestion in desending order of created date' do
      it do
        expect(described_class.all_suggestions).to eq(described_class.all.order(created_at: :desc))
      end
    end
  end

  describe 'Db tests' do
    context 'DB Columns tests' do
      it { is_expected.to have_db_column(:body) }
      it { is_expected.to have_db_column(:post_id) }
    end

    context 'Index Column tests' do
      it { is_expected.to have_db_index(:post_id) }
    end
  end
end
