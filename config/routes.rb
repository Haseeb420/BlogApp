Rails.application.routes.draw do
  root 'home#index'
  get 'home/index' => 'home#index', as: 'welcome_page'
  get 'home/about' => 'home#about', as: 'about_page'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
