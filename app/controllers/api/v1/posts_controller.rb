# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      include PostsHelper
      skip_before_action :authenticate_user!
      def index
        @posts = Post.all_posts.ordered
        render json:  @posts.map { |post| post.as_json.merge({ header_img: post.header_img.service_url, user_name: authur_name_by_id(post.user_id).capitalize() }) }
      end

      def show
        @post = Post.find(params[:id])
        render json: @post.as_json().merge({ header_img: @post.header_img.service_url, user_name: authur_name_by_id(@post.user_id).capitalize() })
      end
    end
  end
end
