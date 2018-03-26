Rails.application.routes.draw do
  get 'static_pages/home'

  get 'static_pages/help'

  root to: 'articles#index'

  resources :articles do
    resources :comments
  end
  
  resources :tags
  resources :authors
  resources :impressions
  
  resources :author_sessions, only: [ :new, :create, :destroy ]
  get 'login'  => 'author_sessions#new'
  get 'logout' => 'author_sessions#destroy'
end
