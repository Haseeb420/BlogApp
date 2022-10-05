# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  let(:user) { create(:user) }
  let(:category) { create(:post_category) }
  let(:post1) { create(:post, user_id: user.id, post_category_id: category.id, status: 'approved') }
  let(:comment1) { FactoryBot.create(:comment, post_id: post1.id, user_id: user.id) }

  context 'Association Test Cases' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
    it { should belong_to(:parent).class_name('Comment').optional(:true) }
    it { should have_many(:comment_likes).class_name('CommentLike').dependent(:delete_all) }
    it { should have_many(:replies).class_name('Comment').dependent(:destroy) }
  end

  context 'Validation Test Cases' do
    it { should validate_presence_of(:body) }
  end

  describe 'Testing instance Methods' do
    describe '.user_comment_like_exists?' do
      it 'returns false when comment like does not exit for user' do
        expect(subject.user_comment_like_exists?(user.id)).to be(false)
      end

      it 'Add User comment like' do
        comment1.add_user_comment_like(user.id)
        expect(comment1.user_comment_like_exists?(user.id)).to be(true)
      end
    end

    it 'Add User comment like' do
      comment1.add_user_comment_like(user.id)
      comment1.delete_user_comment_like(user.id)
      expect(comment1.user_comment_like_exists?(user.id)).to be(false)
    end
  end

  describe 'Db Test Cases' do
    context 'Db Table Column Testing' do
      it { should have_db_column(:user_id) }
      it { should have_db_column(:post_id) }
      it { should have_db_column(:parent_id) }
      it { should have_db_column(:body) }
      it { should have_db_column(:commented_on) }
    end

    context 'Db Index Testing' do
      it { should have_db_index(:user_id) }
      it { should have_db_index(:post_id) }
    end
  end
end
