# frozen_string_literal: true

Rails.application.routes.draw do
  resources :images
  root "home#index"
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for :users
  resources :posts do
    resource :post_like, only: :show
    resources :comments do
      resources :comment_likes
    end
    resources :reported_posts
    resources :suggestions
  end
  resources :images, only: %i[show create]
  get "home/index" => "home#index", as: "welcome_page"
  get "home/about" => "home#about", as: "about_page"
  get "post/recent-post" => "posts#recent", as: "recent_post"

  get "comment/likes/:comment_id" => "comment_likes#index", as: "add_comment_like"
  # get "post/likes/:post_id" => "post_likes#index", as: "add_post_like"
  post "/posts/:post_id/comments-reply" => "comments#reply", as: "comment_reply"

  # moderators routes starts here
  scope "/moderator" do
    resources :posts, only: [:recent, :delete, :show, :destory]
    resources :suggestion
  end

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'
  get '/422', to: 'errors#unprocessable'
  # scope '/moderator', as: 'moderator', module: :moderator do
  #   resources :posts, :reported_posts, :suggestions
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
