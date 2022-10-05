# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  let(:user1) { create(:user, email: 'user1@gmail.com') }
  let(:user2) { create(:user, email: 'user2@gmail.com') }
  let(:user3) { create(:user, email: 'user3@gmail.com') }
  let(:category) { create(:post_category) }
  let(:post1) do
    create(:post, user_id: user1.id, post_category_id: category.id, status: 'approved')
  end
  let(:post2) do
    create(:post, user_id: user1.id, post_category_id: category.id, status: 'approved')
  end

  context 'Association Tests' do
    it { should have_many(:posts).class_name('Post').dependent(:delete_all) }
    it { should have_one(:post_like).class_name('PostLike').dependent(:delete) }
    it { should have_many(:comments).class_name('Comment').dependent(:delete_all) }
    it { should have_one(:comment_like).class_name('CommentLike').dependent(:delete) }

    it {
      expect(subject).to have_many(:reported_posts).class_name('ReportedPost').dependent(:delete_all)
    }

    it { should have_one_attached(:profile_img) }
  end

  describe 'Validation tests' do
    context 'tests for presense of All fields' do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:password) }

      it 'expected true when profile image in attached' do
        expect(subject.profile_img.attached?).to be(true)
      end
      it 'expected content type of profile img to be png, jpg, Jpeg' do
        expect(['image/png', 'image/jpg', 'image/jpeg']).to include(subject.profile_img.blob.content_type)
      end
    end

    context 'email Validation tests' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

    context 'enum tests' do
      it { should define_enum_for(:user_role).with_values(%i[user admin moderator]) }
      it { should allow_value('user', 'admin', 'moderator').for(:user_role) }
    end
  end

  context 'Scopes Tests' do
    it 'Matches recently added users' do
      expect(described_class.recents_week_users).to contain_exactly(user1, user2, user3)
    end
  end

  context 'Methods Tests' do
    it 'Users all post' do
      expect(user1.user_all_post).to contain_exactly(post1, post2)
    end
  end

  describe 'DB Tests' do
    context 'Tests Db Table Columns' do
      it { should have_db_column(:first_name) }
      it { should have_db_column(:last_name) }
      it { should have_db_column(:email) }
    end

    context 'Index Column test' do
      it { should have_db_index(:email) }
    end
  end
end
