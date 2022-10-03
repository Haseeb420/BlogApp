# frozen_string_literal: true

require "rails_helper"

# Specs in this file have access to a helper object that includes
# the PostHelper. For example:
#
# describe PostHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PostsHelper, type: :helper do
  let(:user) { create(:user) }
  let(:category) { create(:post_category) }
  let!(:post1) { create(:post, title: "this is my titile", user_id: user.id, post_category_id: category.id, status: "approved") }
  it "get Post Title by id" do
    expect(helper.get_post_title_id(post1.id)).to eq("this is my titile")
  end
  let!(:post_count) { Post.count }

  it "should return date in dd-mm-yyyy format" do
    date = Time.now
    expect(helper.date_formatter(date)).to eq("03-10-2022")
  end

  it "should return authur full name" do
    expect(helper.authur_name_by_id(user.id)).to eq("Haseeb Malik")
  end

  it "should return post count" do
    expect(helper.post_counter_all).to eq(post_count)
  end

  it "should return post count of last week posts" do
    expect(helper.post_last_week_counter).to eq(Post.recents_week_post.count)
  end

  it "should return user count of last week" do
    expect(helper.user_counter_last_week).to eq(User.recents_week_users.count)
  end

  it "should return user count of last week reported posts" do
    expect(helper.counter_post_reported_last_week).to eq(ReportedPost.count)
  end

  it "should show post status" do
    expect(helper.post_status_show("approved")).to eq("Approved")
  end
end
