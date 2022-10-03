# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Posts", type: :request do
  let(:login_user) { FactoryBot.create(:user,  confirmed_at: Time.now.getutc) }
  let(:moderator) { FactoryBot.create(:user, email: "md@gmail.com", confirmed_at: Time.now.getutc, user_role: "moderator") }
  let(:category) { FactoryBot.create(:post_category,  category_name: "testing") }
  let(:header_img) { Rack::Test::UploadedFile.new Rails.root.join("public/assets/profile_img-9f7db6fe66a347566157a80fad374979fca61f81dfef6250c43f69fb87385aa6.jpg"), "image/jpg" }
  let(:param) { {
    post: {
      title: "This is new Post",
      body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
      post_category_id: category.id,
      header_img: header_img
     } }}

  let(:invalid_param) { {
      post: {
        body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
        post_category_id: category.id,
        header_img: header_img
       } }}
  let!(:post1) {  FactoryBot.create(:post, user_id: login_user.id, post_category_id: category.id) }

  describe "When User is signed In" do
    before(:each) do
      sign_in(login_user)
    end

    context "GET #index" do
      it "get all  post of user" do
        get posts_path
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    context "GET #new" do
      it "get create post form" do
        get new_post_path
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end

    context "POST #create" do
      it "create new valid post" do
        expect { post posts_path, params: param }.to change(Post, :count).by(1)
        expect(response.media_type).to eq "text/html"
        expect(flash["notice"]).to eq("Post Created Succesfully")
        expect(response).to redirect_to(post_path(assigns(:post)))
        expect(response).to have_http_status(:redirect)
      end

      it "don't create new on invalid post" do
        post posts_path, params: invalid_param
        expect(response.media_type).to eq "text/html"
        expect(flash["alert"]).to eq("Post not Created Succesfully")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "GET #show"  do
      it "should show post for id" do
        get post_path(post1)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
      end
    end

    context "GET #edit"  do
      it "should show post for id" do
        get edit_post_path(post1)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end

    context "Patch #update Post" do
      it "Should update post on valid attributes" do
        patch post_path(post1), params: { "post": { title: "I am updating this" } }
        expect(flash["notice"]).to eq("Post Updated Succesfully")
      end

      it "Should not update post on in-valid attributes" do
        patch post_path(post1), params: { "post": { body: "I am" } }
        expect(flash["alert"]).to eq("Post not Updated Succesfully")
      end
    end

    context "Delete #delete" do
      it "should delete post" do
        expect { delete post_path(post1) }.to change(Post, :count).by(-1)
      end
    end

    context "Testing Post not found exception" do
      it "should redirect to root with alert" do
        get post_path(0)
        expect(flash["alert"]).to eq("Post not found")
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context "Moderator user methods" do
      context "GET #approved Post"  do
        it "Approved Post by Moderator" do
          sign_in(moderator)
          get post_approval_post_path(post1), xhr: true
          expect(response).to have_http_status(:ok)
        end
        it "should redirect to root as a simple user" do
          get post_approval_post_path(post1), xhr: true
          expect(flash["alert"]).to eq("You are not authorized to perform this action.")
          expect(response).to redirect_to(root_path)
        end
      end
      context "Get Recent Post" do
        it "should redirect to root with alert" do
          sign_in(moderator)
          get recent_posts_path
          expect(response).to have_http_status(:ok)
        end
      end

      context "Get Recent Post" do
        it "should redirect to root with alert" do
          sign_in(moderator)
          get post_detail_post_path(post1)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  describe "When User is not signed In" do
    context "GET #index" do
      it "get all  post of user" do
        get posts_path
        expect(response).to have_http_status(302)
        expect(flash["alert"]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "GET #new" do
      it "get create post form" do
        get new_post_path
        expect(response).to have_http_status(302)
        expect(flash["alert"]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "POST #create" do
      it "create new post" do
        post posts_path, params: param
        expect(response).to have_http_status(302)
        expect(flash["alert"]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "GET #show"  do
      it "should show post for id" do
        get post_path(post1)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
      end
    end

    context "GET #edit"  do
      it "should show post for id" do
        get edit_post_path(post1)
        expect(response).to have_http_status(302)
        expect(flash["alert"]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
