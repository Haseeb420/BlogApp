require 'rails_helper'

RSpec.describe "Posts", type: :request do
  # describe "GET /index" do
  #   # it {  expect(respond_to).to render_template(:index) }

  # end
  it "Get /posts/index" do
    @posts = Post.all
    get posts_path
    expect(assigns(:@posts)).to match_array(@posts)
  end
end
