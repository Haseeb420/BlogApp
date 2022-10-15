# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:post_category) }
  let(:post1) do
    create(:post, user_id: user.id, post_category_id: category.id, status: 'approved')
  end
  let(:post1_like) { create(:post_like, user_id: user.id, post_id: post1.id) }

  context 'Association Tests' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post_category) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:post_likes) }
    it { is_expected.to have_many(:suggestions).dependent(:destroy) }
    it { is_expected.to have_many(:reported_posts).dependent(:destroy) }
  end

  describe 'Validation test' do
    context 'Title validation tests' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_length_of(:title).is_at_least(3).is_at_most(200) }
    end

    context 'Body Testcases' do
      it { is_expected.to validate_presence_of(:body) }
      it { is_expected.to validate_length_of(:body).is_at_least(50) }
    end

    context 'Header Image Testcases' do
      it { expect(post1.header_img.attached?).to be(true) }
    end

    context 'Post Status test cases' do
      it { is_expected.to define_enum_for(:status).with_values(%i[not_approved approved]) }
      it { is_expected.to allow_value('not_approved', 'approved').for(:status) }
    end
  end

  describe 'Scopes tests' do
    context 'ordered' do
      it 'is expected to returns post in decending order published date' do
        expect(described_class.ordered).to eq(described_class.order(published_date: :desc))
      end
    end

    context 'recents_week_post' do
      it 'is expected to returns last week post' do
        expect(described_class.recents_week_post).to match_array(described_class.where('created_at > ?',
                                                                                       Time.zone.now - 7.days))
      end
    end

    context 'all_posts' do
      it 'is expected to return all approved post' do
        expect(described_class.all_posts).to match_array(described_class.all)
      end
    end
  end

  describe 'Post instance tests' do
    describe '.add_post_like' do
      it 'is expected to add user like on post' do
        post1.add_post_like(user.id)
        expect(post1.user_post_like_exists?(user.id)).to be(true)
      end
    end

    describe '.user_post_like_exists?' do
      it 'checks user like exists' do
        expect(post1.user_post_like_exists?(user.id)).to be(false)
      end
    end

    describe '.delete_user_post_like' do
      it 'is expected to delete user like on current post' do
        post1.add_post_like(user.id)
        post1.delete_user_post_like(user.id)
        expect(post1.user_post_like_exists?(user.id)).to be(false)
      end
    end
  end

  describe 'Db Tests' do
    context 'Db Columns Tests' do
      it { is_expected.to have_db_column(:title) }
      it { is_expected.to have_db_column(:body) }
      it { is_expected.to have_db_column(:published_date) }
      it { is_expected.to have_db_column(:user_id) }
      it { is_expected.to have_db_column(:post_category_id) }
    end

    context 'Index Columns Tests' do
      it { is_expected.to have_db_index(:title) }
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to have_db_index(:post_category_id) }
    end
  end
end
