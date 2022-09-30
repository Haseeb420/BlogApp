# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Posts", type: :request do
  let!(:login_user) { FactoryBot.create(:user,  confirmed_at: Time.now.getutc) }
  let(:header_img) { Rack::Test::UploadedFile.new Rails.root.join("public/assets/profile_img-9f7db6fe66a347566157a80fad374979fca61f81dfef6250c43f69fb87385aa6.jpg"), "image/jpg" }
  let(:params) { {
    post: {
      title: "This is new Post",
      body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
      post_category_id: 1,
      header_img: header_img
     } }}
  before(:each) do
    sign_in(login_user)
  end

  describe "GET #index" do
    it "get all  post of user" do
      get posts_path
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it "get create post form" do
      get new_post_path
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe "GET #create" do
    it "create new post" do
      expect do
        post posts_path, params: params
      end.to change(Post, :count).by(1)
      response.should redirect_to Post.last
      # expect(response).to redirect_to("/posts")
    end
  end
end
