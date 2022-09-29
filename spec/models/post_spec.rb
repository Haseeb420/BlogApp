# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, type: :model do
  subject { build(:post) }

  context "Validation test" do
    subject { build(:post) }
    context "Title Testcases" do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title) }
    end

    context "Body Testcases" do
      it { should validate_presence_of(:body) }
      it { should validate_length_of(:body) }
    end

    context "Header Image Testcases" do
      it { expect(subject.header_img).to be_attached }
    end



    context "post category id" do
      it "ensure post category id presense" do
        @post = build(:post, post_category_id: nil).save
        expect(@post).to eq(false)
      end
    end

    context "Post Status test cases" do
      it "Ensures In validation" do
        @post = build(:post, status: "not_approved").save
        expect(@post).to eq(false)
      end
    end
  end

  context "Association Testing" do
    it { should belong_to(:user) }
    it { should belong_to(:post_category) }
    it { should have_many(:comments) }
    it { should have_many(:post_likes) }
    it { should have_many(:suggestions) }
    it { should have_many(:reported_posts) }
  end

  context "Db Testing" do
    context "Db Columns Testing" do
      it { should have_db_column(:title) }
      it { should have_db_column(:body) }
      it { should have_db_column(:published_date) }
      it { should have_db_column(:user_id) }
      it { should have_db_column(:post_category_id) }
    end

    context "Index Columns Testing" do
      it { should have_db_index(:title) }
      it { should have_db_index(:user_id) }
      it { should have_db_index(:post_category_id) }
    end
  end

  context "Scopes Test Cases" do
    it "should return post in decending order of published date" do
      expect(Post.ordered).to eq(Post.order(published_date: :desc))
    end

    it "should return last week post" do
      @user = create(:user)
      @category = create(:post_category)
      @post1 = create(:post, user_id: @user.id, post_category_id: @category.id)
      @posts = Post.where("created_at > ?", Time.zone.now - 7.days)
      expect(Post.recents_week_post).to match_array(@posts)
    end

    it "should return all approved post" do
      expect(Post.all_posts).to match_array(Post.all)
    end
  end

  context "Post Method Test Cases" do
    it "should check user like exists" do
      expect(subject.user_post_like_exists?(1)).to eq(false)
    end
  end
end
