# frozen_string_literal: true

Rails.application.routes.draw do
  resources :images
  root "home#index"
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for :users
  resources :posts do
    resource :post_like, only: :show
    resources :comments do
      collection do
        post :comment_reply
      end
      resources :comment_likes
    end
    resources :reported_posts
    resources :suggestions
  end
  resources :images, only: %i[show create]
  get "home/index" => "home#index", as: "welcome_page"
  get "home/about" => "home#about", as: "about_page"

  post "/posts/:post_id/comments-reply" => "comments#reply", as: "comment_reply"


  # moderators routes starts here
  scope "/moderator" do
    resources :posts do
      collection do
        get :recent
      end
      member do
        get :post_approval
        get :post_detail
      end
    end
    resources :suggestions
    resources :reported_posts
  end

  get "moderators/dashboard" => "moderators#index", as: "moderator_dashboard"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
