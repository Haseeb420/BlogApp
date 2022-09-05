Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'home/index' => 'home#index', as: 'welcome_page'
  get 'home/about' => 'home#about', as: 'about_page'
  get "moderators/dashboard" => 'moderators#index',as: 'moderator_dashboard'
  get  'post/likes/:id' => 'posts#likes', as: 'post_likes'
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
