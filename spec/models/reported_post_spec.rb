# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportedPost, type: :model do
  subject { build(:reported_post) }

  context 'Association Test Cases' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  context 'Validation Test Cases' do
    it { is_expected.to validate_presence_of(:reason) }
  end

  describe 'Db Test Cases' do
    context 'DB Column Tests' do
      it { is_expected.to have_db_column(:reason) }
      it { is_expected.to have_db_column(:user_id) }
      it { is_expected.to have_db_column(:post_id) }
    end

    context 'Index Column Tests' do
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to have_db_index(:post_id) }
    end
  end
end
