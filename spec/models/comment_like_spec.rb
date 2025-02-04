# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentLike, type: :model do
  context 'Association Tests' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:comment) }
  end

  describe 'DB Tests' do
    context 'Db Table Column Tests' do
      it { is_expected.to have_db_column(:user_id) }
      it { is_expected.to have_db_column(:comment_id) }
    end

    context 'Db Index Tests' do
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to have_db_index(:comment_id) }
    end
  end
end
