# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      skip_before_action :authenticate_user!
      before_action :set_post, only: :show
      before_action :set_posts, only: :index
      def index
        render json: @posts, status: :ok
      end

      def show
        render json: @post, status: :ok 
      end

      private

      def set_post
        @post = Post.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Post not found' }, status: :not_found
      end

      def set_posts
        @posts = Post.all_posts.ordered
      end
    end
  end
end
