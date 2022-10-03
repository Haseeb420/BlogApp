# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Comments", type: :request do
  let(:login_user) { FactoryBot.create(:user,  confirmed_at: Time.now.getutc) }
  let(:moderator) { FactoryBot.create(:user, email: "md@gmail.com", confirmed_at: Time.now.getutc, user_role: "moderator") }
  let(:category) { FactoryBot.create(:post_category,  category_name: "testing") }
  let!(:post1) {  FactoryBot.create(:post, user_id: login_user.id, post_category_id: category.id) }
  let!(:comment1) {  FactoryBot.create(:comment, user_id: login_user.id, post_id: post1.id) }
  let(:param) {
    {
      comment: {
        body: "I am comment in testing."
      }
    }
  }
  describe "When user is not siggned in" do
    context "GET #new" do
      it "It will redirect to signin Page" do
        get new_post_comment_path(post1)
        expect(response).to have_http_status(302)
        expect(flash["alert"]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "GET #show" do
      it "It will redirect to signin Page" do
        get post_comment_path(post_id: post1.id, id: comment1.id)
        expect(response).to have_http_status(302)
        expect(flash["alert"]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "POST #create" do
      it "It will redirect to signin Page" do
        post post_comments_path(post_id: post1.id)
        expect(response).to have_http_status(302)
        expect(flash["alert"]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "POST #reply" do
      it "It will redirect to signin Page" do
        post comment_reply_path(post_id: post1.id)
        expect(response).to have_http_status(302)
        expect(flash["alert"]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "When User is Logged In" do
    before do
      sign_in(login_user)
    end

    context "GET #new" do
      it "It will render new page" do
        get new_post_comment_path(post_id: post1.id)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end

    context "GET #show" do
      it "It will render show page" do
        get post_comment_path(post_id: post1.id, id: comment1.id)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
      end
    end

    context "POST #create" do
      it "It will add new comment and redirect to comment show" do
        expect { post post_comments_path(post_id: post1.id), params: param }.to change(Comment, :count).by(1)
        expect(response).to redirect_to(post_path(assigns(:post)))
        expect(response).to have_http_status(:redirect)
      end
    end

    context "POST #reply" do
      it "It will add new reply as comment" do
        expect { post comment_reply_path(post_id: post1.id), params: param }.to change(Comment, :count).by(1)
        expect(response).to redirect_to(post_path(assigns(:post)))
        expect(response).to have_http_status(:redirect)
      end
    end

    context "DELETE #delete" do
      it "It will remove comment of given post" do
        expect { delete post_comment_path(post_id: post1.id, id: comment1.id) }.to change(Comment, :count).by(-1)
      end
    end
  end
end
