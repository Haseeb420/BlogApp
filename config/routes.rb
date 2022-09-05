Rails.application.routes.draw do
  get 'comments/index'
  get 'comments/new'
  get 'comments/show'
  devise_for :users
  root 'home#index'
  get 'home/index' => 'home#index', as: 'welcome_page'
  get 'home/about' => 'home#about', as: 'about_page'
  get "moderators/dashboard" => 'moderators#index',as: 'moderator_dashboard'
  get  'post/likes/:id' => 'posts#likes', as: 'post_likes'
  get 'comment/likes/:comment_id'=> 'comment_likes#index', as: 'add_comment_like'
  post '/posts/:post_id/comments-reply'=> 'comments#reply', as: 'comment_reply'
  resources :posts do
    resources :comments
  end
  # resources :comments_likes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
