Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'users/index'
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  resources :users, :only =>[:show]
  resources :posts do
    member do
      post :retweet
    end
    resources :likes
  end

  resources :users do
    resources :friends
    post 'friend/:user_id', to: 'friends#create', as: 'create_friend'
  end

  root 'posts#index'
  
  get 'user_posts/:user_id', to: 'posts#user', as: :user_posts
  
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',     to: 'users#show',       via: 'get'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
