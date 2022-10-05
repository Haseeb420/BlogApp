# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportedPost, type: :model do
  subject { build(:reported_post) }

  context 'Association Test Cases' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
  end

  context 'Validation Test Cases' do
    it { should validate_presence_of(:reason) }
  end

  describe 'Db Test Cases' do
    context 'DB Column Testing' do
      it { should have_db_column(:reason) }
      it { should have_db_column(:user_id) }
      it { should have_db_column(:post_id) }
    end

    context 'Index Column Testing' do
      it { should have_db_index(:user_id) }
      it { should have_db_index(:post_id) }
    end
  end
end
