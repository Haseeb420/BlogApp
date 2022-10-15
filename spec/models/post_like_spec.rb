# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostLike, type: :model do
  context 'Association Tests' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  describe 'DB Tests' do
    context 'Column Tests' do
      it { is_expected.to have_db_column(:user_id) }
      it { is_expected.to have_db_column(:post_id) }
    end

    context 'Index Tests' do
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to have_db_index(:post_id) }
    end
  end
end
