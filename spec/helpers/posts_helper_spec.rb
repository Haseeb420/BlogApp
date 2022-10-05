# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  let(:user) { create(:user) }
  let!(:post_count) { Post.count }
  let(:category) { create(:post_category) }
  let!(:post1) do
    create(:post, title: 'this is my titile', user_id: user.id, post_category_id: category.id,
                  status: 'approved')
  end
  let!(:post_count) { Post.count }

  it 'get Post Title by id' do
    expect(helper.get_post_title_id(post1.id)).to eq('this is my titile')
  end

  it 'returns date in dd-mm-yyyy format' do
    date = Time.zone.now
    expect(helper.date_formatter(date)).to eq(Time.zone.now.strftime('%d-%m-%Y'))
  end

  it 'returns authur full name' do
    expect(helper.authur_name_by_id(user.id)).to eq('Haseeb Malik')
  end

  it 'returns post count' do
    expect(helper.post_counter_all).to eq(post_count)
  end

  it 'returns post count of last week posts' do
    expect(helper.post_last_week_counter).to eq(Post.recents_week_post.count)
  end

  it 'returns user count of last week' do
    expect(helper.user_counter_last_week).to eq(User.recents_week_users.count)
  end

  it 'returns user count of last week reported posts' do
    expect(helper.counter_post_reported_last_week).to eq(ReportedPost.count)
  end

  it 'shows post status' do
    expect(helper.post_status_show('approved')).to eq('Approved')
  end
end
