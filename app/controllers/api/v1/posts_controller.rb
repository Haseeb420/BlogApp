# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, except: %i[new create index recent]
      def index
        @posts = Post.all.ordered
        authorize @posts
        render json: @posts
      end
      def show
      end

      private
        def set_post
          @post = Post.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          flash[:alert] = 'Post not found'
          redirect_to root_path
        end
    end
  end
end
