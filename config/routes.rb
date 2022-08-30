Rails.application.routes.draw do
  get 'comments/index'
  get 'comments/new'
  get 'comments/show'
  devise_for :users
  root 'home#index'
  get 'home/index' => 'home#index', as: 'welcome_page'
  get 'home/about' => 'home#about', as: 'about_page'
  get  'post/likes/:id' => 'posts#likes', as: 'post_likes'
  resources :posts do
    resources :comments, shallow: true
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
