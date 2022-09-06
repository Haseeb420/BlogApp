Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'reported_post/index'
  get 'reported_post/new'
  get 'comments/index'
  get 'comments/new'
  get 'comments/show'
  devise_for :users
  root 'home#index'
  get 'home/index' => 'home#index', as: 'welcome_page'
  get 'home/about' => 'home#about', as: 'about_page'
  get 'post/recent-post' => 'posts#recent', as: 'recent_post'

  get  'post/likes/:id' => 'posts#likes', as: 'post_likes'
  get 'comment/likes/:comment_id'=> 'comment_likes#index', as: 'add_comment_like'
  post '/posts/:post_id/comments-reply'=> 'comments#reply', as: 'comment_reply'
  resources :posts do
    resources :comments
    resources :reported_posts
  end
  # resources :comments_likes

  # moderators routes starts here

  get "moderators/dashboard" => 'moderators#index',as: 'moderator_dashboard'
  get "moderators/recent-post" => 'moderators#recent_post',as: 'moderator_recent_post'
  get "moderators/post-approval/(:post_id)" => 'moderators#approved_post',as: 'post_approval'
  get "moderators/reported-posts" => 'moderators#reported_post',as: 'reported_post'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
