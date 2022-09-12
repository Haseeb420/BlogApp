# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :posts do
    resources :comments
    resources :reported_posts
    resources :suggestions
  end
  get 'home/index' => 'home#index', as: 'welcome_page'
  get 'home/about' => 'home#about', as: 'about_page'
  get 'post/recent-post' => 'posts#recent', as: 'recent_post'

  get 'comment/likes/:comment_id' => 'comment_likes#index', as: 'add_comment_like'
  get 'post/likes/:post_id' => 'post_likes#index', as: 'add_post_like'
  post '/posts/:post_id/comments-reply' => 'comments#reply', as: 'comment_reply'

  # moderators routes starts here

  get 'moderators/dashboard' => 'moderators#index', as: 'moderator_dashboard'
  get 'moderators/recent-post' => 'moderators#recent_post', as: 'moderator_recent_post'
  get 'moderators/post-approval/(:post_id)' => 'moderators#approved_post', as: 'post_approval'
  get 'moderators/reported-posts' => 'moderators#reported_post', as: 'reported_post'
  get 'moderators/post-details/(:post_id)' => 'moderators#post_details', as: 'post_details'
  get 'moderators/suugestions/' => 'moderators#suggestions', as: 'all_suggestions'
  get 'moderators/delete-suggestions/:id' => 'moderators#delete_suggestions', as: 'delete_suggestions'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
