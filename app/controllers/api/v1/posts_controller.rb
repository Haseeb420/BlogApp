# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      skip_before_action :authenticate_user!
      before_action :set_post, only: :show
      before_action :set_posts, only: :index
      def index
        render json:  @posts
      end

      def show
        render json: @post
      end

      private
        def set_post
          @post = Post.find(params[:id])
        end
        def set_posts
          @posts = Post.all_posts.ordered
        end
    end
  end
end
