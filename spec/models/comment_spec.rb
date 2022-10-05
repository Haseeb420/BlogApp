# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  let(:user) { create(:user) }
  let(:category) { create(:post_category) }
  let(:post1) { create(:post, user_id: user.id, post_category_id: category.id, status: 'approved') }
  let(:comment1) { create(:comment, post_id: post1.id, user_id: user.id) }

  context 'Association Tests' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
    it { should belong_to(:parent).class_name('Comment').optional(:true) }
    it { should have_many(:comment_likes).dependent(:delete_all) }
    it { should have_many(:replies).class_name('Comment').dependent(:destroy) }
  end

  context 'Validation Tests' do
    it { should validate_presence_of(:body) }
  end

  describe 'Tests instance Methods' do
    describe '.user_comment_like_exists?' do
      context 'should returns false when comment like does not exit for user' do
        it { expect(subject.user_comment_like_exists?(user.id)).to be(false) }
      end
    end
    describe '.add_user_comment_like' do
      context 'should Add User comment like' do
        it do
          comment1.add_user_comment_like(user.id)
          expect(comment1.user_comment_like_exists?(user.id)).to be(true)
        end
      end
    end

    describe '.delete_user_comment_like' do
      context 'should delete user like' do
        it do
          comment1.add_user_comment_like(user.id)
          comment1.delete_user_comment_like(user.id)
          expect(comment1.user_comment_like_exists?(user.id)).to be(false)
        end
      end
    end
  end

  describe 'Db Tests' do
    context 'Db Table Column Tests' do
      it { should have_db_column(:user_id) }
      it { should have_db_column(:post_id) }
      it { should have_db_column(:parent_id) }
      it { should have_db_column(:body) }
      it { should have_db_column(:commented_on) }
    end

    context 'Db Index Tests' do
      it { should have_db_index(:user_id) }
      it { should have_db_index(:post_id) }
    end
  end
end
