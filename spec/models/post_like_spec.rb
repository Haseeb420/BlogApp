# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostLike, type: :model do
  context 'Association Tests' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
  end

  describe 'DB Tests' do
    context 'Column Tests' do
      it { should have_db_column(:user_id) }
      it { should have_db_column(:post_id) }
    end

    context 'Index Tests' do
      it { should have_db_index(:user_id) }
      it { should have_db_index(:post_id) }
    end
  end
end
