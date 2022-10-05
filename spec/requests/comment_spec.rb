# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:login_user) { create(:user, confirmed_at: Time.zone.now.getutc) }
  let(:category) { create(:post_category, category_name: 'testing') }
  let(:post1) {  create(:post, user_id: login_user.id, post_category_id: category.id) }
  let(:comment1) { create(:comment, user_id: login_user.id, post_id: post1.id) }
  let(:param) do
    {
      comment: {
        body: 'I am comment in testing.'
      }
    }
  end

  before do
    sign_in(login_user)
  end

  describe 'GET #new' do
    context 'should render new page' do
      it do
        get new_post_comment_path(post_id: post1.id)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    context 'should render show page' do
      it do
        get post_comment_path(post_id: post1.id, id: comment1.id)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'POST #create' do
    context 'should add new comment and redirect to comment show with valid arguments' do
      it do
        expect do
          post post_comments_path(post_id: post1.id), params: param
        end.to change(Comment, :count).by(1)
        expect(response).to redirect_to(post_path(assigns(:post)))
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'should not add new comment with in-valid arguments' do
      it do
        expect do
          post post_comments_path(post_id: post1.id), params: { comment: { body: '' } }
        end.to change(Comment, :count).by(0)
        expect(flash['alert']).to eq('Comment not added Succesfully')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST #reply' do
    context 'should add new reply as comment' do
      it do
        expect do
          post comment_reply_path(post_id: post1.id), params: param
        end.to change(Comment, :count).by(1)
        expect(response).to redirect_to(post_path(assigns(:post)))
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'DELETE #delete' do
    context 'should remove comment' do
      it do
        get post_comment_path(post_id: post1.id, id: comment1.id)
        expect do
          delete post_comment_path(post_id: post1.id, id: comment1.id)
        end.to change(Comment, :count).by(-1)
      end
    end
  end
end
