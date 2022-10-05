# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:login_user) { create(:user, confirmed_at: Time.zone.now.getutc) }
  let(:moderator) { create(:user, email: 'md@gmail.com', confirmed_at: Time.zone.now.getutc,
                             user_role: 'moderator') }
  let(:category) { create(:post_category, category_name: 'testing') }
  let(:header_img) do
    Rack::Test::UploadedFile.new Rails.root.join('public/assets/profile_img-9f7db6fe66a347566157a80fad374979fca61f81dfef6250c43f69fb87385aa6.jpg'),
                                 'image/jpg'
  end
  let(:param) do
    {
      post: {
        title: Faker::Lorem.characters(number: 20),
        body: Faker::Lorem.characters(number: 60),
        post_category_id: category.id,
        header_img: header_img
      }
    }
  end

  let(:invalid_param) do
    {
      post: {
        title: Faker::Lorem.characters(number: 20),
        post_category_id: category.id,
        header_img: header_img
      }
    }
  end
  let(:post1) { create(:post, user_id: login_user.id, post_category_id: category.id) }
  let!(:post2) { create(:post, user_id: login_user.id, post_category_id: category.id) }

  before do
    sign_in(login_user)
  end
  describe 'GET #index' do
    context 'should all post of user' do
      it  do
        get posts_path
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #new' do
    context 'should render new post form page' do
      it do
        get new_post_path
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #create' do
    context 'should create post with valid arguments' do
      it do
        expect { post posts_path, params: param }.to change(Post, :count).by(1)
        expect(flash['notice']).to eq('Post Created Succesfully')
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(post_path(assigns(:post)))
      end
    end

    context "shouldn't create post with in-valid arguments" do
      it do
        expect { post posts_path, params: invalid_param }.to change(Post, :count).by(0)
        expect(flash['alert']).to eq('Post not Created Succesfully')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    context 'should render post with given id' do
      it do
        get post_path(post1)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
      end
    end

    context 'should redirects to root path with alert when id not exists' do
      it do
        get post_path(0)
        expect(flash['alert']).to eq('Post not found')
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'should render post edit form for given id' do
      it do
        get edit_post_path(post1)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'Patch #update Post' do
    context 'should update post with valid arguments' do
      it  do
        patch post_path(post1), params: { post: { title: 'I am updating this' } }
        expect(flash['notice']).to eq('Post Updated Succesfully')
        post1.reload
        expect(post1.title).to eq('I am updating this')
      end
    end
    context 'should not update post with in-valid attributes' do
      it  do
        patch post_path(post1), params: { post: { body: 'I am' } }
        expect(flash['alert']).to eq('Post not Updated Succesfully')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'Delete #delete' do
    context 'should delete post' do
      it do
        expect { delete post_path(post2) }.to change(Post, :count).by(-1)
        expect(response).to have_http_status(:redirect)
      end
    end
    context "shouldn't delete post" do
      before(:each) do
        allow(post1).to receive(:destroy).and_return(false)
        allow(Post).to receive(:find).and_return(post1)
      end
      it do
        delete post_path(post1)
        expect(flash['alert']).to eq('Post not deleted')
        expect(response).to redirect_to(post_path(assigns(:post)))
      end
    end
  end

  describe 'Moderator user methods testing authorization' do
    before(:each) do
      sign_in(moderator)
    end
    describe 'GET #post_approval' do
      context 'should approved Post' do
        it 'post status should be equal to approved' do
          get post_approval_post_path(post1), xhr: true
          expect(response).to have_http_status(:ok)
          expect(assigns(:post).status).to eq('approved')
        end
      end

      context 'should expect to redirects to root with alert when a simple user' do
        it do
          sign_out(moderator)
          sign_in(login_user)
          get post_approval_post_path(post1), xhr: true
          expect(flash['alert']).to eq('You are not authorized to perform this action.')
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe 'Get #recent' do
      context 'should return recent post' do
        it do
          get recent_posts_path
          expect(response).to have_http_status(:ok)
        end
      end
      context 'should expect to redirects to root with alert when a simple user' do
        it do
          sign_out(moderator)
          sign_in(login_user)
          get recent_posts_path
          expect(flash['alert']).to eq('You are not authorized to perform this action.')
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe 'Get #post_detail' do
      context 'should render post detail view' do
        it do
          get post_detail_post_path(post1)
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'should expect to redirects to root with alert when a simple user' do
      it do
        sign_out(moderator)
        sign_in(login_user)
        get post_detail_post_path(post1)
        expect(flash['alert']).to eq('You are not authorized to perform this action.')
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
