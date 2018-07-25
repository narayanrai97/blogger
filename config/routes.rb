Rails.application.routes.draw do

  mount ApplicationApi, at: "/"

  get 'events/index'
  
  # get "static_pages/home"
  root 'static_pages#home'

  # get 'static_pages/help'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  # get 'static_pages/contact'#, to: 'static_pages#contact'

  # root to: 'articles#index'

  resources :articles, :photos, :events do
    resources :comments
  end
  
  resources :tags
  resources :authors
  resources :impressions
  
  resources :author_sessions, only: [ :new, :create, :destroy ]
  get 'login'  => 'author_sessions#new'
  get 'logout' => 'author_sessions#destroy'
  
end
