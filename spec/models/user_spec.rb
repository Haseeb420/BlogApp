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
    it { is_expected.to have_many(:posts).dependent(:delete_all) }
    it { is_expected.to have_one(:post_like).dependent(:delete) }
    it { is_expected.to have_many(:comments).dependent(:delete_all) }
    it { is_expected.to have_one(:comment_like).dependent(:delete) }

    it {
      expect(subject).to have_many(:reported_posts).class_name('ReportedPost').dependent(:delete_all)
    }

    it { is_expected.to have_one_attached(:profile_img) }
  end

  describe 'Validation tests' do
    context 'tests for presense of All fields' do
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:last_name) }
      it { is_expected.to validate_presence_of(:password) }

      it 'expected true when profile image in attached' do
        expect(subject.profile_img.attached?).to be(true)
      end

      it 'expected content type of profile img to be png, jpg, Jpeg' do
        expect(['image/png', 'image/jpg', 'image/jpeg']).to include(subject.profile_img.blob.content_type)
      end
    end

    context 'email Validation tests' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end

    context 'enum tests' do
      it { is_expected.to define_enum_for(:user_role).with_values(%i[user admin moderator]) }
      it { is_expected.to allow_value('user', 'admin', 'moderator').for(:user_role) }
    end
  end

  context 'Scopes Tests' do
    it 'matcheses recently added users' do
      expect(described_class.recents_week_users).to contain_exactly(user1, user2, user3)
    end
  end

  describe 'Instance method tests' do
    context 'should return all posts of current user ' do
      it do
        expect(user1.user_all_post).to contain_exactly(post1, post2)
      end
    end
  end

  describe 'DB Tests' do
    context 'Tests Db Table Columns' do
      it { is_expected.to have_db_column(:first_name) }
      it { is_expected.to have_db_column(:last_name) }
      it { is_expected.to have_db_column(:email) }
    end

    context 'Index Column test' do
      it { is_expected.to have_db_index(:email) }
    end
  end
end
