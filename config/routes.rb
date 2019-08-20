Rails.application.routes.draw do
  mount ApplicationApi, at: "/"
  namespace :api do
    namespace :v1 do
      resources :messages, only: [:index]
    end
  end

  get 'events/index'
  root 'static_pages#home'

  # get 'static_pages/help'
  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/profile', to: 'static_pages#profile'

  resources :articles, :photos, :events do
    resources :comments
  end

  resources :tags
  resources :authors
  resources :impressions
  resources :messages do
    member do
      put 'post', 'unpost'
    end
  end

  resources :author_sessions, only: [ :new, :create, :destroy ]
  get 'login'  => 'author_sessions#new'
  get 'logout' => 'author_sessions#destroy'

end
