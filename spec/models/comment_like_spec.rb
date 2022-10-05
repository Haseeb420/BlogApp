# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentLike, type: :model do
  context 'Association Test Cases' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:comment).class_name('Comment') }
  end

  describe 'DB Test Cases' do
    context 'Db Table Column Testing' do
      it { should have_db_column(:user_id) }
      it { should have_db_column(:comment_id) }
    end

    context 'Db Index Testing' do
      it { should have_db_index(:user_id) }
      it { should have_db_index(:comment_id) }
    end
  end
end
